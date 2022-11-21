---@type GL
local _, GL = ...;

---@class Interface
GL.Interface = GL.Interface or {
    _resizeBoundsMethod = nil,
    FramePool = {
        Buttons = {};
    },
    TypeDictionary = {
        InteractiveLabel = "Label",
        SimpleGroup = "Frame",
        InlineGroup = "Frame",
    }
};

local Settings = GL.Settings; ---@type Settings
local Interface = GL.Interface; ---@type Interface

--- Set resize bounds of given element
---
---@param Element Frame
---@return any
function Interface:resizeBounds(Element, ...)
    GL:debug("Interface:resizeBounds");

    if (not self._resizeBoundsMethod) then
        if (GL.EventFrame.SetResizeBounds) then
            self._resizeBoundsMethod = "SetResizeBounds";
        else
            self._resizeBoundsMethod = "SetMinResize";
        end
    end

    if (Element.frame) then
        return Element.frame[self._resizeBoundsMethod](Element.frame, ...);
    end

    return Element[self._resizeBoundsMethod](Element, ...);
end

--- Provide AceGUI Frame with default settings
---
---@param Scope table
---@param Item Frame
---@param identifier string
---@param width number|nil
---@param height number|nil
---@return void
function Interface:AceGUIDefaults(Scope, Item, identifier, width, height)
    GL:debug("Interface:AceGUIDefaults");

    local itemType = self:determineItemType(Item);

    if (itemType == "Frame") then
        Item:SetTitle(GL.Data.Constants.defaultFrameTitle);
        Item:SetLayout("Flow");
        self:restorePosition(Item, identifier);
        self:restoreDimensions(Item, identifier, width, height);
        self:makeCloseableWithEscape(Item, identifier);

        if (Scope.close and type(Scope.close) == "function") then
            Item:SetCallback("OnClose", function()
                self:storePosition(Item, identifier);
                self:storeDimensions(Item, identifier);

                Scope:close(Item);
            end);
        end
    end

    self:set(Scope, identifier, Item, false);
end

--- Make an element closeable using escape
---
---@param Item Frame
---@param identifier string
---@return void
function Interface:makeCloseableWithEscape(Item, identifier)
    GL:debug("Interface:makeCloseableWithEscape");

    -- Make sure we prefix everything
    if (not GL:strStartsWith(identifier, "GARGUL_")) then
        identifier = "GARGUL_" .. identifier;
    end

    _G[identifier] = Item;
    tinsert(UISpecialFrames, identifier);
end

--- Fetch an interface item from a given scope (either an object or string reference to an interface class)
---
---@param scope table|string
---@param identifier string
---@return any
function Interface:get(scope, identifier)
    if (identifier == "Window") then
        identifier = "Frame.Window";
    end

    if (type(scope) == "table") then
        return GL:tableGet(scope, "InterfaceItems." .. identifier), identifier;
    end

    return GL:tableGet(GL.Interface, scope .. ".InterfaceItems." .. identifier), identifier;
end

--- Set an interface item on a given scope (either an object or string reference to an interface class)
---
---@param scope table|string
---@param identifier string
---@param Item Frame
---@param prefixWithType boolean Defaults to true
---@return boolean
function Interface:set(scope, identifier, Item, prefixWithType)
    GL:debug("Interface:set");

    if (prefixWithType == nil) then
        prefixWithType = true;
    end

    local widgetType = "";
    if (prefixWithType) then
        widgetType = "." .. self:determineItemType(Item);
    end

    local path = "";
    if (type(scope) == "table") then
        path = string.format("InterfaceItems%s.%s", widgetType, identifier);
        return GL:tableSet(scope, path, Item);
    end

    path = string.format("GL.Interface.%s.InterfaceItems%s.%s", scope, widgetType, identifier);
    return GL:tableSet(path, identifier);
end

--- Release an item and remove it from our interface entirely
---
---@param scope table
---@param identifier string
---@return boolean
function Interface:release(scope, identifier)
    if (type(scope) ~= "table"
        or type(identifier) ~= "string"
        or GL:empty(identifier)
    ) then
        return false
    end

    local Item, fullIdentifier = self:get(scope, identifier);

    if (not Item
        or type(Item) ~= "table"
    ) then
        return false;
    end

    if (type(Item.type) == "string") then
        GL.AceGUI:Release(Item);
    end

    local path = string.format("InterfaceItems.%s", fullIdentifier);
    return GL:tableSet(scope, path, nil);
end

--- Determine the given Item's type (e.g: Frame, Table, Button etc)
---
---@param Item Frame
---@return string
function Interface:determineItemType(Item)
    GL:debug("Interface:determineItemType");

    if (type(Item.GetCell) == "function") then
        return "Table";
    end

    if (type(Item.type) == "string") then
        local itemType = Item.type;

        return self.TypeDictionary[itemType] or itemType;
    end

    return "Frame";
end

--- Get an element's stored position (defaults to center of screen)
---
---@param identifier string
---@param default table
---@return table
function Interface:getPosition(identifier, default)
    identifier = string.format("UI.%s.Position", identifier);

    -- There's a default, return it if no position points are available
    if (default ~= nil
        and not Settings:get(identifier .. ".point")
    ) then
        return default;
    end

    return unpack({
        Settings:get(identifier .. ".point", "CENTER"),
        UIParent,
        Settings:get(identifier .. ".relativePoint", "CENTER"),
        Settings:get(identifier .. ".offsetX", 0),
        Settings:get(identifier .. ".offsetY", 0),
    });
end

--- Store an element's position in the settings table
---
---@param Item Frame
---@param identifier string The name under which the settings should be stored
---@return void
function Interface:storePosition(Item, identifier)
    identifier = string.format("UI.%s.Position", identifier);

    local point, _, relativePoint, offsetX, offsetY = Item:GetPoint();

    Settings:set(identifier .. ".point", point);
    Settings:set(identifier .. ".relativePoint", relativePoint);
    Settings:set(identifier .. ".offsetX", offsetX);
    Settings:set(identifier .. ".offsetY", offsetY);
end

--- Restore an element's position from the settings table
---
---@param Item Frame
---@param identifier string The name under which the settings should be stored
---@return void
function Interface:restorePosition(Item, identifier)
    Item:ClearAllPoints();
    Item:SetPoint(self:getPosition(identifier));
end

--- Get an element's stored dimensions
---
---@param identifier string
---@return number|nil, number|nil
function Interface:getDimensions(identifier)
    identifier = string.format("UI.%s.Dimensions", identifier);

    local Dimensions = Settings:get(identifier, {});
    return Dimensions.width, Dimensions.height;
end

--- Store an element's position in the settings table
---
---@param Item table
---@param identifier string The name under which the settings should be stored
---@return void
function Interface:storeDimensions(Item, identifier)
    identifier = string.format("UI.%s.Dimensions", identifier);

    if (Item.frame) then
        Settings:set(identifier .. ".width", Item.frame:GetWidth());
        Settings:set(identifier .. ".height", Item.frame:GetHeight());
        return;
    end

    Settings:set(identifier .. ".width", Item:GetWidth());
    Settings:set(identifier .. ".height", Item:GetHeight());
end

--- Restore an element's position from the settings table
---
---@param Item Frame
---@param identifier string The name under which the settings should be stored
---@param defaultWidth number The default width of no width is stored yet
---@param defaultHeight number The default height of no height is stored yet
---@return void
function Interface:restoreDimensions(Item, identifier, defaultWidth, defaultHeight)
    local width, height = self:getDimensions(identifier);
    width = width or defaultWidth;
    height = height or defaultHeight;

    if (GL:higherThanZero(width)) then
        Item:SetWidth(width or defaultWidth);
    end

    if (GL:higherThanZero(height)) then
        Item:SetHeight(height or defaultHeight);
    end
end

--- Create a button
---
---@param Parent Frame
---@param Details table<string,any>
--- Supported Details keys:
---     onClick: function that fires on click
---     alwaysFireOnClick: onClick also fires when button is disabled
---     tooltipText: tooltip text on hover
---     disabledTooltipText: tooltip text on hover when button is disabled
---     position: TOPRIGHT|TOPCENTER
---     update: method that runs when the button is updated
---     updateOn: events on which the update method is run
---     fireUpdateOnCreation: run the update method immediately after creating the button
---     normalTexture: the texture to use when the button has the normal state
---     highlightTexture: the texture to use when the button has the highlight state
---     disabledTexture: the texture to use when the button has the disabled state
---     width, height
---@return Frame
function Interface:createButton(Parent, Details)
    GL:debug("Interface:createButton");

    -- Invalid Parent provided
    if (not Parent
        or type(Parent) ~= "table"
        or (not Parent.Hide
        and not Parent.frame)
    ) then
        GL:error("Invalid Parent provided in Interface:createShareButton");
        return;
    end

    Details = Details or {};
    local onClick = Details.onClick or function() end;
    local alwaysFireOnClick = Details.alwaysFireOnClick or false;
    local tooltip = Details.tooltip or "";
    local disabledTooltip = Details.disabledTooltip or "";
    local width = Details.width or 24;
    local height = Details.height or 24;
    local update = Details.update or nil;
    local updateOn = Details.updateOn or {};
    local fireUpdateOnCreation = Details.updateOnCreate;
    local normalTexture = Details.normalTexture;
    local highlightTexture = Details.highlightTexture;
    local disabledTexture = Details.disabledTexture;

    if (fireUpdateOnCreation == nil) then
        fireUpdateOnCreation = true;
    end

    if (type(updateOn) ~= "table") then
        updateOn = { updateOn };
    end

    -- If the parent element is an AceGUI element then refer to its frame instead
    if (Parent.frame) then
        Parent = Parent.frame;
    end

    local name;

    ---@type Frame
    local Button = table.remove(self.FramePool.Buttons, 1);

    if (not Button) then
        name = "GargulButton" .. GL:uuid();
        Button = CreateFrame("Button", name, Parent, "UIPanelButtonTemplate");
    else
        name = Button:GetName();
    end

    Button:SetParent(Parent);
    Button:ClearAllPoints();
    Button:SetSize(width, height);

    -- Make sure the tooltip still shows even when the button is disabled
    if (disabledTooltip) then
        Button:SetMotionScriptsWhileDisabled(true);
    end

    if (highlightTexture) then
        local HighlightTexture = Button:CreateTexture();
        HighlightTexture:SetTexture(highlightTexture);
        HighlightTexture:SetPoint("CENTER", Button, "CENTER", 0, 0);
        HighlightTexture:SetSize(width, height);
        Button:SetHighlightTexture(HighlightTexture);
    end

    if (normalTexture) then
        Button:SetNormalTexture(normalTexture);
    end

    if (disabledTexture) then
        Button:SetDisabledTexture(disabledTexture);
    end

    -- Show the tooltip on hover
    Button:SetScript("OnEnter", function()
        local textToShow = tooltip;

        if (not Button:IsEnabled()) then
            textToShow = disabledTooltip;
        end

        if (not GL:empty(textToShow)) then
            GameTooltip:SetOwner(Button, "ANCHOR_TOP");
            GameTooltip:AddLine(textToShow);
            GameTooltip:Show();
        end
    end);

    Button:SetScript("OnLeave", function()
        GameTooltip:Hide();
    end);

    if (type(onClick) == "function") then
        Button:SetScript("OnClick", function(_, button)
            if (not Button:IsEnabled() and not alwaysFireOnClick) then
                return;
            end

            if (button == 'LeftButton') then
                onClick();
            end
        end);
    end

    -- Make sure the button's update method is called whenever any of the given events are fired
    if (type(update) == "function") then
        Button.update = update;

        for _, event in pairs(updateOn) do
            GL.Events:register(name .. event .. "Listener", event, function () Button:update(); end);
        end

        if (fireUpdateOnCreation) then
            Button:update();
        end
    end

    -- Make sure we can release the button unto our pool for recycling purposes
    Button.Release = function ()
        Button:SetMotionScriptsWhileDisabled(false);
        Button:SetNormalTexture(nil,"ARTWORK");
        Button:SetHighlightTexture(nil,"ARTWORK");
        Button:SetDisabledTexture(nil,"ARTWORK");
        Button.update = nil;
        Button.OnEnter = nil;
        Button.OnLeave = nil;
        Button.OnClick = nil;
        Button:ClearAllPoints();
        Button:Hide();

        -- Get rid of the button's event listeners
        for _, event in pairs(updateOn) do
            GL.Events:unregister(name .. event .. "Listener");
        end

        tinsert(self.FramePool.Buttons, Button);
    end

    Button:Show();

    return Button;
end

--- Create a settings (cogwheel) button
---
---@param Parent Frame
---@param Details table<string,any>
--- Supported Details keys:
---     onClick: function that fires on click
---     alwaysFireOnClick: onClick also fires when button is disabled
---     tooltipText: tooltip text on hover
---     disabledTooltipText: tooltip text on hover when button is disabled
---     position: TOPRIGHT|TOPCENTER
---     update: method that runs when the button is updated
---     updateOn: events on which the update method is run
---     fireUpdateOnCreation: run the update method immediately after creating the button
---     x, y, width, height
---@return Frame
function Interface:createShareButton(Parent, Details)
    GL:debug("Interface:createShareButton");

    Details = Details or {};
    local position = Details.position;
    local x = Details.x;
    local y = Details.y;
    local width = Details.width or 24;
    local height = Details.height or 24;

    local Button = self:createButton(Parent, Details);

    -- If the parent element is an AceGUI element and no position was given we assume that the user wants
    -- to add the button as-is to the parent frame
    if (Parent.frame and position) then
        Parent = Parent.frame;
    end

    if (position == "TOPRIGHT") then
        Button:SetPoint("TOPRIGHT", Parent, "TOPRIGHT", x or -20, y or -20);
    elseif (position == "TOPCENTER") then
        Button:SetPoint("TOP", Parent, "TOP", x or 0, y or -7);
        Button:SetPoint("CENTER", Parent, "CENTER");
    end

    local HighlightTexture = Button:CreateTexture();
    HighlightTexture:SetTexture("Interface\\AddOns\\Gargul\\Assets\\Buttons\\share-highlighted");
    HighlightTexture:SetPoint("CENTER", Button, "CENTER", 0, 0);
    HighlightTexture:SetSize(width, height);

    Button:SetNormalTexture("Interface\\AddOns\\Gargul\\Assets\\Buttons\\share");
    Button:SetHighlightTexture(HighlightTexture);
    Button:SetDisabledTexture("Interface\\AddOns\\Gargul\\Assets\\Buttons\\share-disabled");

    return Button;
end

GL:debug("Interface/Interface.lua");