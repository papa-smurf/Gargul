local L = Gargul_L;
local LibDD = LibStub:GetLibrary("LibUIDropDownMenu-4.0");

---@type GL
local _, GL = ...;

---@class Interface
GL.Interface = GL.Interface or {
    _resizeBoundsMethod = nil,
    scalerName = "Gargul.Interface.Scaler",

    Colors = {
        AQUA = "00FFFF",
        BLACK = 000000,
        COPPER = "B87333",
        GOLD = "FFD700",
        GRAY = 808080,
        LIGHT_GRAY = "D3D3D3",
        DIM_GRAY = 696969,
        PURPLE = "A335EE",
        SILVER = "C0C0C0",
        WHITE = "FFFFFF",
        WHITE_SMOKE = "F5F5F5",
        YELLOW = "FFF569",

        -- Statuses
        ERROR = "BE3333",
        NOTICE = "FFF569",
        SUCCESS = "92FF00",
        WARNING = "F7922E",

        -- Classes
        DRUID = "FF7D0A",
        HUNTER = "ABD473",
        MAGE = "69CCF0",
        PALADIN = "F58CBA",
        PRIEST = "FFFFFF",
        ROGUE = "FFF569",
        SHAMAN = "0070DE",
        WARLOCK = "9482C9",
        WARRIOR = "C79C6E",
        DEATHKNIGHT = "C41E3A",
        DEATH_KNIGHT = "C41E3A",
        ["DEATH KNIGHT"] = "C41E3A",
        DEMONHUNTER = "A330C9",
        DEMON_HUNTER = "A330C9",
        ["DEMON HUNTER"] = "A330C9",
        EVOKER = "33937F",
        MONK = "00FF98",

        -- Qualities
        POOR = "9D9D9D",
        COMMON = "FFFFFF",
        UNCOMMON = "1EFF00",
        RARE = "0070DD",
        EPIC = "A335EE",
        LEGENDARY = "FF8000",
        ARTIFACT = "E6CC80",
        HEIRLOOM = "00CCFF",
        ["WOW TOKEN"] = "00CCFF",
    },
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

--[[ CONSTANTS ]]
local MENU_DIVIDER = {
    text              = "",
    hasArrow          = false,
    dist              = 0,
    isTitle           = true,
    isUninteractable  = true,
    notCheckable      = true,
    iconOnly          = true,
    icon              = "Interface/Common/UI-TooltipDivider-Transparent",
    tCoordLeft        = 0,
    tCoordRight       = 1,
    tCoordTop         = 0,
    tCoordBottom      = 1,
    tSizeX            = 0,
    tSizeY            = 8,
    tFitDropDownSizeX = true,
    iconInfo =
    {
        tCoordLeft        = 0,
        tCoordRight       = 1,
        tCoordTop         = 0,
        tCoordBottom      = 1,
        tSizeX            = 0,
        tSizeY            = 8,
        tFitDropDownSizeX = true
    },
};

--- Create a UIPanelButtonTemplate that changes it's width dynamically based on its contents
---
---@param Parent Frame
---@param text string|nil
---@param template string|nil
---@return Button
function Interface:dynamicPanelButton(Parent, text, template)
    template = template or "UIPanelButtonTemplate";
    local minOffset = 33;

    ---@type Button
    local Button = CreateFrame("Button", nil, Parent, template);

    ---@type FontString
    local Text = Button:GetFontString()
    Text:ClearAllPoints();
    Text:SetPoint("TOPLEFT", 15, -1)
    Text:SetPoint("BOTTOMRIGHT", -15, 1)
    Text:SetJustifyV("MIDDLE")

    Text._SetFont = Text.SetFont;
    Text.SetFont = function (_, rem, flags)
        Text:_SetFont(GL.FONT, GL:rem(rem), flags or "");
    end

    Text:SetFont();

    -- Make sure the button changes in size whenever we change its contents
    Button.SetText = function (_, ...)
        local scale = Button:GetScale();

        if (scale < 1) then
            scale = math.min(scale * 1.2, 1);
        end

        Text:SetText(...);
        local textWidth = Text:GetUnboundedStringWidth();
        Button:SetSize((Text:GetUnboundedStringWidth() + math.max(minOffset, textWidth * .44)) * scale, 21 * scale);
    end

    Button:SetText(text or "");

    return Button;
end

--- Create a InputBoxTemplate which only permits numeric values
---
---@param Parent Frame
---@param name string|nil
---@param placeholder string|nil
---@param decimals number|nil
---@return EditBox
function Interface:numericInputBox(Parent, name, placeholder, decimals)
    local Input = self:inputBox(Parent, name, placeholder);

    -- Prevent anything but numbers and the allowed number of decimals
    Input:HookScript("OnTextChanged", function (_, setByUser)
        if (not Input:HasFocus() or not setByUser) then
            return;
        end

        local text = Input:GetText();
        local output  = "";

        if (not decimals or decimals == 0) then
            string.gsub(text,"%d[%d]*",function (e)
                output = output .. e;
            end);
        else
            string.gsub(text,"%d[%d.]*",function (e)
                output = output .. e;
            end);

            local firstPointPosition = strfind(output, "%.");

            if (firstPointPosition) then
                local outputLength = strlen(output);
                output = output:gsub("%.", "");
                output = GL:strInsert(output, ".", firstPointPosition - 1);

                -- Make sure we don't allow too many decimals
                if (outputLength - firstPointPosition > decimals) then
                    output = strsub(output, 1, firstPointPosition + decimals);
                end
            end
        end

        if (output ~= text) then
            Input:SetText(output);
        end
    end);

    return Input;
end

--- Create a InputBoxTemplate
---
---@param Parent Frame
---@param name string|nil
---@param placeholder string|nil
---@return EditBox
function Interface:inputBox(Parent, name, placeholder)
    ---@type EditBox
    local Input = CreateFrame("EditBox", name, Parent, "InputBoxTemplate");
    Input:SetHeight(20);
    Input:SetAutoFocus(false);

    Input._SetFont = Input.SetFont;
    Input.SetFont = function (_, rem, flags)
        Input:_SetFont(GL.FONT, GL:rem(rem), flags or "");
    end
    Input:SetFont();

    -- Simulate HTML's "placeholder" behavior
    if (placeholder) then
        Input._placeholder = ("|c00%s%s|r"):format(self.Colors["GRAY"], placeholder);
        Input:SetText(Input._placeholder);

        -- Make sure an empty value is returned when the placeholder value is still active
        Input._GetText = Input.GetText;
        Input.GetText = function ()
            local text = Input:IsNumeric() and Input:GetNumber() or Input:_GetText();

            return text ~= Input._placeholder and text or "";
        end

        Input.updatePlaceholder = function (placeholder)
            -- This ensures that the old placeholder is removed before setting a new one
            if (GL:empty(Input:GetText())) then
                Input:SetText("");
            end

            Input._placeholder = ("|c00%s%s|r"):format(self.Colors["GRAY"], placeholder);

            if (not Input:HasFocus()) then
                Input:GetScript("OnEditFocusLost")();
            end
        end

        Input:SetScript("OnEditFocusGained", function ()
            if (not GL:empty(Input:GetText())) then
                return;
            end

            Input:SetText("");
        end);

        Input:SetScript("OnEditFocusLost", function ()
            local text = Input:GetText();
            if (not GL:empty(text) and text ~= 0) then
                return;
            end

            -- Placeholders (including their color string
            if (Input:IsNumeric()) then
                Input:SetNumeric(false);
                Input:SetText(Input._placeholder);
                Input:SetNumeric(true);
            else
                Input:SetText(Input._placeholder);
            end
        end);
    else
        Input._GetText = Input.GetText;
        Input.GetText = function ()
            return Input:IsNumeric() and Input:GetNumber() or Input:_GetText();
        end
    end

    Input.Clear = function ()
        Input:SetText(Input._placeholder or "");
        Input:ClearFocus();
    end

    -- Make sure spells, macros and items can be dragged into the field
    Input:SetScript("OnReceiveDrag", function ()
        local type, id, info = GetCursorInfo();
        local value

        if (type) == "item" then
            value = info;
        elseif (type) == "spell" then
            value = GetSpellInfo(id, info);
        elseif (type) == "macro" then
            value = GetMacroInfo(id);
        end

        if (value) then
            Input:SetText(value)
            ClearCursor()
        end
    end);

    Input:SetScript("OnEscapePressed", function ()
        Input:ClearFocus();
    end);

    return Input;
end

---@param Parent Frame
---@param name? string
---@param width? number
---@param height? number
---
---@return ScrollFrame
function Interface:textArea(Parent, name, width, height)
    if (name ~= nil or type(Parent) ~= "table") then
        GL:error("Pass a table instead of multiple arguments");
        return false;
    end

    name = Parent.name;
    width = Parent.width;
    height = Parent.height;
    Parent = Parent.Parent;

    local ScrollFrame = CreateFrame("ScrollFrame", nil, Parent, "UIPanelScrollFrameTemplate")
    ScrollFrame:SetPoint("LEFT", Parent, "LEFT", 30, 0);
    ScrollFrame:SetPoint("RIGHT", Parent, "RIGHT", -60, 0);

    ScrollFrame:SetHeight(height or 200);

    if (width) then
        ScrollFrame:SetWidth(height or 200);
    end

    local Background = CreateFrame("Frame", nil, Parent, "BackdropTemplate");
    Background:SetBackdrop({
        bgFile = "Interface/Tooltips/UI-Tooltip-Background",
        edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
        edgeSize = 16,
        insets = { left = 4, right = 3, top = 4, bottom = 3 },
    });
    Background:SetBackdropColor(0, 0, 0);
    Background:SetBackdropBorderColor(0.4, 0.4, 0.4);
    Background:SetPoint("TOPLEFT", ScrollFrame, "TOPLEFT", -10, 10);
    Background:SetPoint("BOTTOMRIGHT", ScrollFrame, "BOTTOMRIGHT", 2, -10);

    local TextArea = CreateFrame("EditBox", nil, ScrollFrame);
    TextArea:SetAutoFocus(false);
    TextArea:SetFontObject(ChatFontNormal);
    TextArea:SetMultiLine(true);
    TextArea:SetWidth(ScrollFrame:GetWidth());
    TextArea:SetPoint("LEFT", ScrollFrame, "LEFT", 50, 0);

    TextArea:SetScript("OnEscapePressed", function (self)
        self:ClearFocus();
    end)

    ScrollFrame:SetScript("OnMouseUp", function ()
        TextArea:SetFocus()
    end);

    ScrollFrame:SetScrollChild(TextArea)

    ScrollFrame:SetScript("OnSizeChanged", function ()
        TextArea:SetWidth(ScrollFrame:GetWidth())
    end);

    ScrollFrame.GetText = TextArea.GetText;

    return ScrollFrame;
end

--- Besides static string value we also support closures with an optional "updateOn" value
--- You can use this to automatically update a string whenever an event is fired for example
---
---@example
---
-- local CurrentPotLabel = Interface:createFontString(Window, {
--     text = function (self)
--         self:SetText(Pot:total());
--     end,
--     updateOn = "GL.GDKP_AUCTION_CHANGED",
-- });
---
---@param Parent Frame
---@param text string|table|nil
---@param template string|nil
---@param name string|nil
---@param layer string|nil
---@return FontString
function Interface:createFontString(Parent, text, template, name, layer)
    ---@type FontString
    local FontString = Parent:CreateFontString(name, layer or "ARTWORK", template or "GameFontWhite");
    FontString:SetJustifyH("LEFT");

    FontString._SetFont = FontString.SetFont;
    FontString.SetFont = function (_, rem, flags)
        FontString:_SetFont(GL.FONT, GL:rem(rem), flags or "");
    end

    FontString.SetColor = function (_, color)
        color = self.Colors[color] or color;
        FontString:SetText(("|c00%s%s|r"):format(color, FontString:GetText() or ""));

        FontString._lastColor = color;
    end

    FontString:SetFont(1, "OUTLINE");

    if (type(text) == "table") then
        FontString.update = text.text;

        if (text.updateOn) then
            if (type(text.updateOn) ~= "table") then
                text.updateOn = { text.updateOn };
            end

            for _, event in pairs(text.updateOn) do
                GL.Events:register(nil, event, function () FontString:update(FontString); end);
            end
        end

        FontString:update(FontString);
    else
        FontString:SetText(text or "");
    end

    return FontString;
end

---@param Element Frame
---@return nil
function Interface:addMoveButton(Element)
    ---@type Button
    local Move = CreateFrame("Button", Element:GetName() .. ".Move", Element);
    Move:SetSize(15, 15);

    Move.normalTexture = Move:CreateTexture(nil, "BACKGROUND");
    Move.normalTexture:SetTexture("Interface/AddOns/Gargul/Assets/Buttons/panel-move-up");
    Move.normalTexture:SetTexCoord(0.21875, 0.75, 0.234375, 0.765625);
    Move.normalTexture:SetPoint("TOPRIGHT", Move, "TOPRIGHT", 0, -3);
    Move.normalTexture:SetSize(15, 15);
    Move:SetNormalTexture(Move.normalTexture);

    Move.pushedTexture = Move:CreateTexture(nil, "BACKGROUND");
    Move.pushedTexture:SetTexture("Interface/AddOns/Gargul/Assets/Buttons/panel-move-down");
    Move.pushedTexture:SetTexCoord(0.21875, 0.75, 0.234375, 0.765625);
    Move.pushedTexture:SetPoint("TOPRIGHT", Move, "TOPRIGHT", 0, -3);
    Move.pushedTexture:SetSize(15, 15);
    Move:SetPushedTexture(Move.pushedTexture);

    Move.highlightTexture = Move:CreateTexture(nil, "BACKGROUND");
    Move.highlightTexture:SetTexture("Interface/BUTTONS/UI-Panel-MinimizeButton-Highlight");
    Move.highlightTexture:SetTexCoord(0.21875, 0.75, 0.234375, 0.765625);
    Move.highlightTexture:SetPoint("TOPRIGHT", Move, "TOPRIGHT", 0, -3);
    Move.highlightTexture:SetSize(15, 15);
    Move:SetHighlightTexture(Move.highlightTexture, "ADD");

    Move:SetPoint("TOPRIGHT", Element, "TOPRIGHT", -40, 0);
    Move:SetPoint("TOPLEFT", Element, "TOPLEFT", 0, 0);

    do
        self:addTooltip(Move, L["Move"], "CURSOR");
        Move:EnableMouse(true);
        Move:RegisterForDrag("LeftButton");
        Move:SetScript("OnDragStart", function ()
            Element:StartMoving();
            Move:SetButtonState("PUSHED");
        end);
        Move:SetScript("OnDragStop", function ()
            Element:StopMovingOrSizing();
            self:storePosition(Element);
            Move:SetButtonState("NORMAL");
        end);
    end

    Element.MoveButton = Move;
end

---@param Element Frame
---@return nil
function Interface:addOptionsButton(Element)
    ---@type Button
    local Options = CreateFrame("Button", nil, Element);
    Options:SetPoint("TOPLEFT", Element, "TOPLEFT", 2, -2);
    Options:SetSize(16, 16);
    self:addTooltip(Options, L["Settings"]);
    Element.OptionsButton = Options;

    Options.normalTexture = Options:CreateTexture(nil, "BACKGROUND");
    Options.normalTexture:SetTexture("Interface/AddOns/Gargul/Assets/Buttons/panel-cogwheel-up");
    Options.normalTexture:SetTexCoord(0.21875, 0.75, 0.234375, 0.765625);
    Options.normalTexture:SetAllPoints(Options);
    Options:SetNormalTexture(Options.normalTexture);

    Options.pushedTexture = Options:CreateTexture(nil, "BACKGROUND");
    Options.pushedTexture:SetTexture("Interface/AddOns/Gargul/Assets/Buttons/panel-cogwheel-down");
    Options.pushedTexture:SetTexCoord(0.21875, 0.75, 0.234375, 0.765625);
    Options.pushedTexture:SetAllPoints(Options);
    Options:SetPushedTexture(Options.pushedTexture);

    Options:SetHighlightTexture("Interface/BUTTONS/UI-Panel-MinimizeButton-Highlight", "ADD");

    Element.OptionsButton = Options;

    -- Make sure the movebutton doesn't overlap the options button
    if (Element.MoveButton) then
        Element.MoveButton:SetPoint("TOPLEFT", Element, "TOPLEFT", 20, 0);
    end
end

---@param Element Frame
---@return nil
function Interface:addCloseButton(Element)
    ---@type Button
    local Close = CreateFrame("Button", Element:GetName() .. ".Close", Element, "UIPanelCloseButton");
    Close:SetPoint("TOPRIGHT", Element, "TOPRIGHT", 8, 5);
    Close:SetSize(30, 30);
    self:addTooltip(Close, L["Close"]);

    -- Override the default onclick since it taints in combat
    Close:SetScript("OnClick", function ()
        Element:Hide();
    end);

    Element.CloseButton = Close;
end

---@param Element Frame
---@param title string|nil
---@return nil
function Interface:addMinimizeButton(Element, title)
    local minimizedName = Element:GetName() .. ".Minimized";

    ---@type Frame
    local MinimizedWindow = CreateFrame("Frame", minimizedName, UIParent, "BackdropTemplate");
    MinimizedWindow:SetMovable(true);
    MinimizedWindow:SetClampedToScreen(true);
    MinimizedWindow:SetSize(200, 50);
    MinimizedWindow:SetBackdrop(_G.BACKDROP_DARK_DIALOG_32_32);
    MinimizedWindow:SetFrameStrata("FULLSCREEN_DIALOG");
    MinimizedWindow:SetFrameLevel(100);
    MinimizedWindow:EnableMouse(true);
    MinimizedWindow:SetToplevel(true);
    MinimizedWindow:Hide();
    MinimizedWindow:SetUserPlaced(false);

    self:resizeBounds(MinimizedWindow, 80, 60);

    --[[ THE SETTINGS MENU IN THE TOP LEFT OF THE WINDOW ]]
    self:addWindowOptions(MinimizedWindow, {
        { text = L["Adjust Scale"], notCheckable = true, func = function ()
            self:openScaler(MinimizedWindow);
            CloseMenus();
        end }
    }, 100);

    if (title) then
        ---@type FontString
        local Title = self:createFontString(MinimizedWindow, title);
        Title:SetFont(1.5, "OUTLINE");
        Title:SetPoint("CENTER", MinimizedWindow, "CENTER");
        Title:SetPoint("TOPLEFT", MinimizedWindow, "TOPLEFT", 20, -16);
        MinimizedWindow.Title = Title;
    end

    self:addMoveButton(MinimizedWindow);
    self:addMaximizeButton(MinimizedWindow, Element);
    self:addResizer(MinimizedWindow);

    ---@type Button
    local Minimize = CreateFrame("Button", Element:GetName() .. ".Minimize", Element, "MaximizeMinimizeButtonFrameTemplate");
    Minimize:SetPoint("TOPRIGHT", Element, "TOPRIGHT", -13, 4);
    Minimize:SetSize(29, 29);
    self:addTooltip(Minimize.MinimizeButton, L["Minimize"]);

    Minimize.MinimizeButton:Show();
    Minimize.MaximizeButton:Hide();

    Minimize.MinimizeButton:SetScript("OnClick", function ()
        MinimizedWindow:ClearAllPoints();
        if (self:getPosition(minimizedName, false)) then
            self:restorePosition(MinimizedWindow);
        else
            MinimizedWindow:SetPoint("TOPRIGHT", Element, "TOPRIGHT");
        end

        MinimizedWindow:Show();
        Element:Hide();
    end);

    MinimizedWindow:SetScript("OnSizeChanged", function ()
        self:storeDimensions(MinimizedWindow);
        self:storePosition(MinimizedWindow);
    end);

    Element:HookScript("OnShow", function ()
        MinimizedWindow:Hide();
    end);

    Element.Minimize = Minimize;
    Element.Minimized = MinimizedWindow;

    --[[ POSITION ACTION BUTTONS ]]
    MinimizedWindow.MoveButton:SetPoint("TOPRIGHT", MinimizedWindow, "TOPRIGHT", -18, 0);
    MinimizedWindow.Maximize:SetPoint("TOPRIGHT", MinimizedWindow, "TOPRIGHT", 8, 4);

    self:restorePosition(MinimizedWindow);
    self:restoreDimensions(MinimizedWindow);

    _G[minimizedName] = MinimizedWindow;
end

---@param Element Frame
---@param Opens Frame
---@return nil
function Interface:addMaximizeButton(Element, Opens)
    ---@type Frame
    local Maximize = CreateFrame("Button", Element:GetName() .. ".Maximize", Element, "MaximizeMinimizeButtonFrameTemplate");
    Maximize:SetPoint("TOPRIGHT", Element, "TOPRIGHT", -13, 4);
    Maximize:SetSize(29, 29);
    self:addTooltip(Maximize.MaximizeButton, L["Maximize"]);

    Maximize.MinimizeButton:Hide();
    Maximize.MaximizeButton:Show();

    Maximize.MaximizeButton:SetScript("OnClick", function ()
        Opens:Show();
        Element:Hide();
    end);

    Element.Maximize = Maximize;
end

---@param Element Frame
---@return nil
function Interface:addResizer(Element)
    Element:SetResizable(true);

    ---@type Button
    local Resize = CreateFrame("Button", Element:GetName() .. ".Resize", Element);
    Resize:SetPoint("BOTTOMRIGHT", Element, "BOTTOMRIGHT", -11, 10);
    Resize:SetSize(16,16);

    local NormalTexture = Resize:CreateTexture();
    NormalTexture:SetTexture("Interface/ChatFrame/UI-ChatIM-SizeGrabber-Down");
    NormalTexture:ClearAllPoints();
    NormalTexture:SetPoint("CENTER", Resize, "CENTER", 0, 0);
    NormalTexture:SetSize(16, 16);
    Resize.NormalTexture = NormalTexture;
    Resize:SetNormalTexture(NormalTexture);

    local HighlightTexture = Resize:CreateTexture();
    HighlightTexture:SetTexture("Interface/ChatFrame/UI-ChatIM-SizeGrabber-Highlight");
    HighlightTexture:ClearAllPoints();
    HighlightTexture:SetPoint("CENTER", Resize, "CENTER", 0, 0);
    HighlightTexture:SetSize(16, 16);
    Resize.HighlightTexture = HighlightTexture;
    Resize:SetHighlightTexture(HighlightTexture);

    local PushedTexture = Resize:CreateTexture();
    PushedTexture:SetTexture("Interface/ChatFrame/UI-ChatIM-SizeGrabber-Pushed");
    PushedTexture:ClearAllPoints();
    PushedTexture:SetPoint("CENTER", Resize, "CENTER", 0, 0);
    PushedTexture:SetSize(16, 16);
    Resize.PushedTexture = PushedTexture;
    Resize:SetPushedTexture(PushedTexture);

    Resize:SetScript("OnMouseDown", function ()
        Element:StartSizing("BOTTOMRIGHT");
    end);
    Resize:SetScript("OnMouseUp", function ()
        Element:StopMovingOrSizing("BOTTOMRIGHT");
    end);

    -- Make the clickable are larger
    Resize:SetHitRectInsets(-6, -6, -6, -6);

    Element.Resize = Resize;
end

---@param name string|table
---@param width number
---@param height number
---@param minWidth number
---@param minHeight number
---@param maxWidth number
---@param maxHeight number
---@param closeWithEscape boolean
---@param OnClose function
---@param hideMinimizeButton boolean
---@param hideCloseButton boolean
---@param hideResizeButton boolean
---@param hideMoveButton boolean
---@param hideAllButtons boolean
---@param hideWatermark boolean
---@param template string
---@param Parent Frame
---@return Frame
function Interface:createWindow(
    name, width, height, minWidth, minHeight, maxWidth, maxHeight, closeWithEscape, OnClose,
    hideMinimizeButton, hideCloseButton, hideResizeButton, hideMoveButton, hideAllButtons, hideWatermark, template,
    Parent
)
    if (width ~= nil or type(name) ~= "table") then
        GL:error("Pass a table instead of multiple arguments");
        return false;
    end

    local predefinedParent = name.Parent ~= nil;

    width = name.width;
    height = name.height;
    minWidth = name.minWidth;
    minHeight = name.minHeight;
    maxWidth = name.maxWidth;
    maxHeight = name.maxHeight;
    closeWithEscape = name.closeWithEscape;
    OnClose = name.OnClose;
    hideMinimizeButton = name.hideMinimizeButton;
    hideCloseButton = name.hideCloseButton;
    hideResizeButton = name.hideResizeButton;
    hideMoveButton = name.hideMoveButton;
    hideAllButtons = name.hideAllButtons;
    template = name.template;
    hideWatermark = name.hideWatermark;

    Parent = name.Parent or UIParent;
    if (name.Parent and closeWithEscape == nil) then
        closeWithEscape = false;
    end

    name = name.name;

    if (not name) then
        return GL:error("Gargul windows require a unique and descriptive name!");
    end

    closeWithEscape = closeWithEscape ~= false;

    ---@type Frame
    local Window = CreateFrame("Frame", name, Parent, template == false and Frame or "BackdropTemplate");
    Window:SetSize(width or 200, height or 200);

    if (not predefinedParent) then
        Window:SetPoint("CENTER", UIParent, "CENTER");
    end

    if (template ~= false) then
        Window:SetBackdrop(_G.BACKDROP_DARK_DIALOG_32_32);
    end

    Window:SetClampedToScreen(true);
    Window:SetFrameStrata("FULLSCREEN_DIALOG");
    Window:SetFrameLevel(100);
    Window:EnableMouse(true);
    Window:SetToplevel(true);

    if (type(OnClose) == "function") then
        Window:SetScript("OnHide", OnClose);
    end

    --[[ MINIMIZE BUTTON ]]
    if (not hideAllButtons and not hideMinimizeButton) then
        self:addMinimizeButton(Window);
    end

    --[[ CLOSE BUTTON ]]
    if (not hideAllButtons and not hideCloseButton) then
        self:addCloseButton(Window);
    end

    --[[ MOVE / RESIZE BUTTONS ]]
    if (not hideAllButtons and
        (
            not hideResizeButton
            or not hideMoveButton
        )
    ) then
        self:restorePosition(Window);
        self:restoreDimensions(Window);

        Interface:resizeBounds(Window, minWidth or 0, minHeight or 0);

        if (not hideResizeButton) then
            self:addResizer(Window);
        else
            -- This is to make sure we can update dimensions between patches
            -- without the restoreDimensions method overriding them with old SavedVariables data
            Window:SetSize(width or 200, height or 200);
        end

        if (not hideMoveButton) then
            Window:SetMovable(true);
            self:addMoveButton(Window);
            Window:SetUserPlaced(false);

            -- This sequence forces the window to be on top
            Window._Show = Window.Show;
            Window.Show = function ()
                Window:_Show();
                Window:StartMoving();
                Window:StopMovingOrSizing();
            end;
        end

        Window:SetScript("OnSizeChanged", function ()
            if (maxWidth) then
                local windowWidth = Window:GetWidth();
                Window:SetWidth(math.min(windowWidth, maxWidth));
            end

            if (maxHeight) then
                local windowHeight = Window:GetHeight();
                Window:SetHeight(math.min(windowHeight, maxHeight));
            end

            self:storeDimensions(Window);
            self:storePosition(Window);
        end);
    end

    --[[ WATERMARK ]]
    if (not hideWatermark) then
        ---@type FontString
        local Watermark = Interface:createFontString(Window, GL.name .. " v" .. GL.version);
        Watermark:SetFont(.8, "OUTLINE");
        Watermark:SetColor("GRAY");
        Watermark:SetPoint("BOTTOMLEFT", Window, "BOTTOMLEFT", 14, 13);
        Window.Watermark = Watermark;
    end

    --[[ POSITION ACTION BUTTONS ]]
    if (Window.MoveButton and (
        hideMinimizeButton
        or hideCloseButton
    )) then
        if (hideCloseButton and hideMinimizeButton) then
            Window.MoveButton:SetPoint("TOPRIGHT", Window, "TOPRIGHT", 0, 0);
        else
            Window.MoveButton:SetPoint("TOPRIGHT", Window, "TOPRIGHT", -18, 0);
        end
    end

    if (Window.Minimize and hideCloseButton) then
        Window.Minimize:SetPoint("TOPRIGHT", Window, "TOPRIGHT", 8, 4);
    end

    _G[name] = Window;

    if (closeWithEscape) then
        tinsert(UISpecialFrames, name);
    end

    return Window;
end

---@param Parent Frame|table
---@param name string
---@param checked boolean
---@param label string
---@param tooltip string
---@param callback function
---@return CheckButton
function Interface:createCheckbox(Parent, name, checked, label, tooltip, callback)
    if (name ~= nil or type(Parent) ~= "table") then
        GL:error("Pass a table instead of multiple arguments");
        return false;
    end

    name = Parent.name;
    checked = Parent.checked;
    label = Parent.label;
    tooltip = Parent.tooltip;
    callback = Parent.callback or function () end;

    Parent = Parent.Parent;

    ---@type CheckButton
    local Checkbox = CreateFrame("CheckButton", nil, Parent, "UICheckButtonTemplate");
    Checkbox:SetChecked(checked);
    Checkbox:SetSize(22, 22);

    Checkbox.toggle = function ()
        checked = not Checkbox:GetChecked();
        Checkbox:SetChecked(checked);
        callback(Checkbox, checked);
    end

    -- Add a label to the checkbox and make it clickable
    if (label) then
        local Label = self:createFontString(Parent, label);
        Label:SetPoint("CENTER", Checkbox, "CENTER");
        Label:SetPoint("LEFT", Checkbox, "RIGHT", 4, 0);

        -- Not available in Era at time of writing
        if (Label.EnableMouse) then
            Label:EnableMouse(true);
            Label:HookScript("OnMouseDown", Checkbox.toggle);
        end
        Checkbox.Label = Label;

        if (tooltip) then
            self:addTooltip(Label, tooltip);
        end
    end

    Checkbox:HookScript("OnClick", function ()
        callback(Checkbox, Checkbox:GetChecked());
    end);
    return Checkbox;
end

---@param Parent table
---@param name string
---@param min number
---@param max number
---@param step number
---@param value string|number
---@param callback function
---@param width number
---@param height number
---@return Frame
function Interface:createSlider(Parent, name, min, max, step, value, callback, width, height)
    if (name ~= nil or type(Parent) ~= "table") then
        GL:error("Pass a table instead of multiple arguments");
        return false;
    end

    min = Parent.min;
    max = Parent.max;
    step = Parent.step;
    value = Parent.value;
    width = Parent.width or 200;
    height = Parent.height or 15;
    callback = Parent.callback or function () end;

    Parent = Parent.Parent;

    local SliderBackdrop  = {
        bgFile = "Interface/Buttons/UI-SliderBar-Background",
        edgeFile = "Interface/Buttons/UI-SliderBar-Border",
        tile = true, tileSize = 8, edgeSize = 8,
        insets = { left = 3, right = 3, top = 6, bottom = 6 }
    };

    local InputBackdrop = {
        bgFile = "Interface/ChatFrame/ChatFrameBackground",
        edgeFile = "Interface/ChatFrame/ChatFrameBackground",
        tile = true, edgeSize = 1, tileSize = 5,
    };

    ---@type Slider
    local Slider = CreateFrame("Slider", name, Parent, "BackdropTemplate");
    Slider:SetSize(width, height);
    Slider:SetHitRectInsets(0, 0, -10, 0);
    Slider:SetOrientation("HORIZONTAL");
    Slider:SetMinMaxValues(min, max);
    Slider:SetObeyStepOnDrag(true);
    Slider:SetValue(1);
    Slider:SetValueStep(step);
    Slider:SetBackdrop(SliderBackdrop)
    Slider:SetThumbTexture("Interface/Buttons/UI-SliderBar-Button-Horizontal");

    ---@type FontString
    local LowText = Interface:createFontString(Slider, tostring(min));
    LowText:SetPoint("TOPLEFT", Slider, "BOTTOMLEFT", 2, 3);

    ---@type FontString
    local HighText = Interface:createFontString(Slider, tostring(max));
    HighText:SetPoint("TOPRIGHT", Slider, "BOTTOMRIGHT", -2, 3);

    ---@type EditBox
    local Input = CreateFrame("EditBox", nil, Slider, "BackdropTemplate")
    Input:SetAutoFocus(false);
    Input:SetPoint("TOP", Slider, "BOTTOM");
    Input:SetHeight(14);
    Input:SetWidth(70);
    Input:SetJustifyH("CENTER");
    Input:EnableMouse(true);
    Input:SetBackdrop(InputBackdrop);
    Input:SetBackdropColor(0, 0, 0, 0.5);
    Input:SetBackdropBorderColor(0.3, 0.3, 0.30, 0.80);

    Input._SetFont = Input.SetFont;
    Input.SetFont = function (_, rem, flags)
        Input:_SetFont(GL.FONT, GL:rem(rem), flags or "");
    end

    Input:SetFont();

    Input:SetScript("OnEscapePressed", function ()
        Input:ClearFocus();
    end);
    Input:SetScript("OnEnterPressed", function ()
        local value = Input:GetText();
        if (GL:empty(value)) then
            return;
        end

        PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON);
        Slider:SetValue(value);
    end);
    Slider.Input = Input;

    Slider:SetScript("OnValueChanged", function (_, value)
        local currentValue = Input:GetText();
        Slider.Input:SetText(value);

        if (currentValue ~= value) then
            callback(Slider, value);
        end
    end);

    Slider.GetValue = function ()
        return Input:GetText();
    end

    Slider:SetValue(value);
    Slider.Input:SetText(value);

    return Slider;
end

function Interface:multiSelect(Parent, title, Menu, width)
    local levels = 1;
    local Sanitized = {};
    do --[[ SANITIZE MENU ]]
        for _, Entry in pairs(Menu) do
            --[[ DIVIDER ]]
            if (Entry == "divider") then
                tinsert(Sanitized, MENU_DIVIDER);

            --[[ REGULAR ]]
            elseif (not Entry.SubMenu) then
                tinsert(Sanitized, Entry);

            --[[ MULTI-LEVEL ]]
            else
                levels = levels + 1;
                local SubMenu = Entry.SubMenu;
                Entry.SubMenu = nil;
                Entry.menuList = levels;
                Entry.hasArrow = true;
                Entry.notCheckable = true;
                tinsert(Sanitized, Entry);

                for _, SubEntry in pairs(SubMenu) do
                    SubEntry.level = levels;
                    tinsert(Sanitized, SubEntry);
                end
            end
        end
    end

    local DropDown = LibDD:Create_UIDropDownMenu(Parent:GetName() .. ".OptionsDropdown", Parent);

    LibDD:UIDropDownMenu_SetWidth(DropDown, width or 200) -- Use in place of dropDown:SetWidth
    LibDD:UIDropDownMenu_JustifyText(DropDown, "LEFT");
    LibDD:UIDropDownMenu_Initialize(DropDown, function (_, level, menuList)
        local addEntry = function (Entry)
            menuList = menuList or 1;
            Entry.level = Entry.level or 1;
            Entry.isNotRadio = not Entry.isRadio;
            local isSubMenu = menuList > 1;

            if (not isSubMenu and Entry.level > 1) then
                return;
            end

            if (isSubMenu and menuList ~= Entry.level) then
                return;
            end

            if (type(Entry.text) == "function") then
                Entry.textFunc = Entry.text;
                Entry.text = Entry.text();
            elseif(Entry.textFunc) then
                Entry.text = Entry.textFunc();
            end

            if (type(Entry.checked) == "function") then
                Entry.checkFunc = Entry.checked;
                Entry.checked = Entry.checked();
            elseif(Entry.checkFunc) then
                Entry.checked = Entry.checkFunc();
            end

            -- Move text to the right if ElvUI is loaded
            if (not Entry.notCheckable
                and not Entry.isTitle
                and GL.elvUILoaded
            ) then
                Entry.text = " " .. Entry.text;
            end

            if (Entry.setting) then
                Entry.checked = Settings:get(Entry.setting);

                if (not Entry.func) then
                    Entry.func = function (_, _, _, checked)
                        Settings:set(Entry.setting, checked);
                        Entry.checked = checked;
                    end;
                end
            end

            Entry.minWidth = DropDown:GetWidth() - 40;

            Entry.keepShownOnClick = true;
            if (Entry.hideOnClick) then
                Entry.keepShownOnClick = not Entry.hideOnClick;
            end

            LibDD:UIDropDownMenu_AddButton(Entry, level);
        end

        for _, Entry in pairs(Sanitized) do
            addEntry(Entry);
        end
    end);

    DropDown.Text:SetText(title);
    return DropDown;
end

---@param Parent table
---@param name string
---@param value string|number
---@param Options table
---@param sorter function
---@param callback function
---@return Frame
function Interface:createDropdown(Parent, name, value, Options, sorter, callback)
    if (name ~= nil or type(Parent) ~= "table") then
        GL:error("Pass a table instead of multiple arguments");
        return false;
    end

    name = Parent.name;
    value = Parent.value;
    Options = Parent.Options or {};
    sorter = Parent.sorter ~= nil and Parent.sorter or false;
    callback = Parent.callback or function () end;

    Parent = Parent.Parent;

    local Dropdown = CreateFrame("Frame", name, Parent, "UIDropDownMenuTemplate");
    Dropdown.value = value;
    Dropdown.Options = Options;

    UIDropDownMenu_SetWidth(Dropdown, Parent:GetWidth() - 70); -- Use in place of dropDown:SetWidth
    UIDropDownMenu_SetText(Dropdown, " ");

    UIDropDownMenu_Initialize(Dropdown, function ()
        local Option = UIDropDownMenu_CreateInfo()
        Option.func = function (self)
            Dropdown:SetValue(self.value);
        end

        -- Sort our options the way we want them
        local FauxOptions = {};
        if (not sorter) then
            for value, text in pairs(Dropdown.Options) do
                tinsert(FauxOptions, { v = value, t = text });
            end
            table.sort(FauxOptions, function (a, b)
                if (a.v and b.v) then
                    return a.v < b.v;
                end

                return false;
            end);
        else
            FauxOptions = sorter(FauxOptions);
        end

        for _, Details in pairs(FauxOptions) do
            Option.text = Details.t;
            Option.value = Details.v;
            Option.checked = Dropdown.value == Details.v;
            UIDropDownMenu_AddButton(Option);
        end
    end);

    Dropdown.SetOptions = function (_, Options)
        Dropdown.Options = Options;
    end

    Dropdown.SetWidth = function (_, width)
        UIDropDownMenu_SetWidth(Dropdown, width);
    end

    Dropdown.SetText = function (_, text)
        UIDropDownMenu_SetText(Dropdown, text);
    end

    Dropdown.SetValue = function (_, value)
        Dropdown:SetText(Options[value] or "");

        -- Something changed
        if (value ~= Dropdown.value) then
            callback(Dropdown, value);
        end

        Dropdown.value = value;
    end

    Dropdown.GetValue = function ()
        return Dropdown.value;
    end

    Dropdown:SetValue(value);

    return Dropdown;
end

--- Open a scale slider for the given frame
---
---@param Parent Frame
---@return Frame
function Interface:openScaler(Parent)
    local Scaler = _G[self.scalerName];
    local sliderName = self.scalerName .. ".Slider";

    local min, max, step = .5, 2, .05;
    local valueToStep = function (value)
        return floor((value - min) / step + 0.5) * step + min;
    end

    if (not Scaler) then
        ---@type Frame
        Scaler = self:createWindow({
            name = self.scalerName,
            hideMinimizeButton = true,
            hideResizeButton = true,
            width = 240,
            height = 90,
        });
        Scaler:Hide();

        local Slider = self:createSlider({
            name = sliderName,
            Parent = Scaler,
            min = min,
            max = max,
            step = step,
            value = 1,
            callback = function (_, value)
                local currentStep = valueToStep(value);
                Scaler.Slider.Input:SetText(currentStep);
                Parent:SetScale(value);
            end,
        });
        Slider:SetPoint("CENTER", Scaler, "CENTER");
        Slider:SetPoint("TOP", Scaler, "TOP", 0, -30);
        Scaler.Slider = Slider;

        ---@type FontString
        local TitleText = self:createFontString(Slider, L["Window Scale"]);
        TitleText:SetPoint("CENTER", Slider, "CENTER");
        TitleText:SetPoint("BOTTOM", Slider, "TOP", 0, 2);
    end

    -- If the scaler does not have a valid position (anymore) then center it
    if (not self:getPosition(Scaler:GetName(), false)) then
        Scaler:ClearAllPoints();
        Scaler:SetPoint("CENTER", UIParent, "CENTER");
    end

    local currentStep = valueToStep(Parent:GetScale());
    Scaler.Slider:SetValue(currentStep);
    Scaler.Slider.Input:SetText(currentStep);

    -- Guarantee that the scaler window is on the foreground
    GL.Ace:ScheduleTimer(function ()
        Scaler:SetFrameLevel(Parent:GetFrameLevel() + 100);
        Scaler:Show();
    end, .1);

    _G[self.scalerName] = Scaler;

    return Scaler;
end

---@param Window Frame
---@param Menu table
---@param width number|nil
---@return nil
function Interface:addWindowOptions(Window, Menu, width)
    self:addOptionsButton(Window);

    local levels = 1;
    local Sanitized = {};
    do --[[ SANITIZE MENU ]]
        for _, Entry in pairs(Menu) do
            --[[ DIVIDER ]]
            if (Entry == "divider") then
                tinsert(Sanitized, MENU_DIVIDER);

            --[[ REGULAR ]]
            elseif (not Entry.SubMenu) then
                tinsert(Sanitized, Entry);

            --[[ MULTI-LEVEL ]]
            else
                levels = levels + 1;
                local SubMenu = Entry.SubMenu;
                Entry.SubMenu = nil;
                Entry.menuList = levels;
                Entry.hasArrow = true;
                Entry.notCheckable = true;
                tinsert(Sanitized, Entry);

                for _, SubEntry in pairs(SubMenu) do
                    SubEntry.level = levels;
                    tinsert(Sanitized, SubEntry);
                end
            end
        end
    end

    local DropDown = LibDD:Create_UIDropDownMenu(Window:GetName() .. ".OptionsDropdown", Window);
    DropDown:SetPoint("TOPLEFT", Window.OptionsButton, "BOTTOMLEFT", 0, 24);

    LibDD:UIDropDownMenu_SetWidth(DropDown, width or 200) -- Use in place of dropDown:SetWidth
    LibDD:UIDropDownMenu_JustifyText(DropDown, "LEFT");
    LibDD:UIDropDownMenu_Initialize(DropDown, function (_, level, menuList)
        local addEntry = function (Entry)
            menuList = menuList or 1;
            Entry.level = Entry.level or 1;
            Entry.isNotRadio = not Entry.isRadio;
            local isSubMenu = menuList > 1;

            if (not isSubMenu and Entry.level > 1) then
                return;
            end

            if (isSubMenu and menuList ~= Entry.level) then
                return;
            end

            if (type(Entry.text) == "function") then
                Entry.textFunc = Entry.text;
                Entry.text = Entry.text();
            elseif(Entry.textFunc) then
                Entry.text = Entry.textFunc();
            end

            if (type(Entry.checked) == "function") then
                Entry.checkFunc = Entry.checked;
                Entry.checked = Entry.checked();
            elseif(Entry.checkFunc) then
                Entry.checked = Entry.checkFunc();
            end

            -- Move text to the right if ElvUI is loaded
            if (not Entry.notCheckable
                and not Entry.isTitle
                and GL.elvUILoaded
            ) then
                Entry.text = " " .. Entry.text;
            end

            if (Entry.setting) then
                Entry.checked = Settings:get(Entry.setting);

                if (not Entry.func) then
                    Entry.func = function (_, _, _, checked)
                        Settings:set(Entry.setting, checked);
                        Entry.checked = checked;
                    end;
                end
            end

            Entry.minWidth = DropDown:GetWidth() - 40;

            Entry.keepShownOnClick = true;
            if (Entry.hideOnClick) then
                Entry.keepShownOnClick = not Entry.hideOnClick;
            end

            LibDD:UIDropDownMenu_AddButton(Entry, level);
        end

        for _, Entry in pairs(Sanitized) do
            addEntry(Entry);
        end
    end, "MENU");

    Window.OptionsButton:SetScript("OnClick", function ()
        LibDD:ToggleDropDownMenu(nil, nil, DropDown);
    end);

    -- We don't need these elements since we use
    -- our own frame to toggle the settings dropdown
    DropDown.Text:Hide();
    DropDown.Button:Hide();
end

--- Add item tooltip that follows the cursor.
---@param Owner Frame|table AceGUI widget or frame
---@param itemLink string
---@return nil
function Interface:addItemTooltipToCursor(Owner, itemLink)
    if (GL:empty(itemLink) or not GL:getItemIDFromLink(itemLink)) then
        return;
    end

    local Target = Owner.frame and Owner.frame or Owner;
    if (Target.EnableMouse) then
        Target:EnableMouse(true);
    end

    Target:HookScript("OnEnter", function ()
        if (Target.GetEffectiveAlpha and Target:GetEffectiveAlpha() == 0) then
            return;
        end

        GameTooltip:SetOwner(Target, "ANCHOR_CURSOR");
        GameTooltip:SetHyperlink(itemLink);
        GameTooltip:Show();
    end);

    Target:HookScript("OnLeave", function ()
        GameTooltip:Hide();
    end);
end

---@param Owner Frame
---@param Lines table|string
---@param anchor string|nil
function Interface:addTooltip(Owner, Lines, anchor)
    local isItemLink = false;
    local isFunction = type(Lines) == "function";

    if (GL:empty(Lines)) then
        return;
    end

    if (type(Owner) ~= "table") then
        return;
    end

    if (not anchor) then
        anchor = "TOP";
    end

    if (type(Lines) == "string") then
        if (GL:getItemIDFromLink(Lines)) then
            isItemLink = true;
        else
            Lines = { Lines };
        end
    end

    local Target = Owner.frame and Owner.frame or Owner;

    -- Make sure mouse events are enabled
    if (Target.EnableMouse) then
        Target:EnableMouse(true);
    end

    Target:HookScript("OnEnter", function ()
        if (Target.GetEffectiveAlpha
            and Target:GetEffectiveAlpha() == 0
        ) then
            return;
        end

        GameTooltip:SetOwner(Target, "ANCHOR_" .. anchor);

        if (isItemLink) then
            GameTooltip:SetHyperlink(Lines);
        elseif (isFunction) then
            local LineResult = Lines();
            if (not LineResult) then
                return;
            end

            if (type(LineResult) == "string") then
                LineResult = { LineResult };
            end

            for _, line in pairs(LineResult) do
                if (GL:getItemIDFromLink(line)) then
                    GameTooltip:SetHyperlink(line);
                else
                    GameTooltip:AddLine(line);
                end
            end
        else
            for _, line in pairs(Lines) do
                GameTooltip:AddLine(line);
            end
        end

        GameTooltip:Show();
    end);

    Target:HookScript("OnLeave", function ()
        GameTooltip:Hide();
    end);
end

--- Set resize bounds of given element
---
---@param Element Frame
---@return any
function Interface:resizeBounds(Element, ...)
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
---@return nil
function Interface:AceGUIDefaults(Scope, Item, identifier, width, height)
    local itemType = self:determineItemType(Item);

    if (itemType == "Frame") then
        Item:SetTitle(GL.Data.Constants.defaultFrameTitle);
        Item:SetLayout("Flow");
        self:restorePosition(Item, identifier);
        self:restoreDimensions(Item, identifier, width, height);
        self:makeCloseableWithEscape(Item, identifier);

        if (Scope.close and type(Scope.close) == "function") then
            Item:SetCallback("OnClose", function ()
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
---@return nil
function Interface:makeCloseableWithEscape(Item, identifier)
    identifier = identifier or Item:GetName();

    if not (identifier) then
        return false;
    end

    -- Frame needs to exist in global scope
    if (not _G[identifier]) then
        -- Make sure we prefix everything
        if (not GL:strStartsWith(identifier, "GARGUL_")) then
            identifier = "GARGUL_" .. identifier;
            _G[identifier] = Item;
        end
    end

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
    prefixWithType = prefixWithType ~= false;

    local widgetType = "";
    if (prefixWithType) then
        widgetType = "." .. self:determineItemType(Item);
    end

    local path = "";
    if (type(scope) == "table") then
        path = ("InterfaceItems%s.%s"):format(widgetType, identifier);
        return GL:tableSet(scope, path, Item);
    end

    path = ("GL.Interface.%s.InterfaceItems%s.%s"):format(scope, widgetType, identifier);
    return GL:tableSet(path, identifier);
end

--- Release an item and remove it from our interface entirely
---
---@param Scope table
---@param identifier string
---@return nil
function Interface:release(Scope, identifier)
    if (type(Scope) ~= "table") then
        return;
    end

    local fullIdentifier, path, Element;

    -- We're not given an element, but instead need to fetch it from our interface cache
    if (not Scope.type and identifier) then
        Element, fullIdentifier = self:get(Scope, identifier);
        path = ("InterfaceItems.%s"):format(fullIdentifier);

        if (not Element
            or type(Element) ~= "table"
        ) then
            return;
        end
    elseif (Scope.type) then
        Element = Scope;
    elseif (Scope.GetChildren) then
        Scope:Hide();
        self:releaseChildren(Scope);
        Scope = nil;
        return;
    else
        return;
    end

    if (type(Element.type) == "string") then
        self:releaseChildren(Element);

        if (type(Element.Hide) == "function") then
            Element:Hide();
        end

        if (Element.frame and type(Element.frame.Hide) == "function") then
            Element.frame:Hide();
        end

        Element = nil;
    end

    if (path and Scope) then
        GL:tableSet(Scope, path, nil);
    end
end

--- Release the children of an element (and their children recursively)
---
---@param Element table
---@return nil
function Interface:releaseChildren(Element)
    if (type(Element) ~= "table") then
        return;
    end

    -- This is an AceGUI element
    if (Element.frame) then
        local Children = Element.children or {};
        for i = 1, #Children do
            self:releaseChildren(Children[i]);
            Children[i].frame:Hide();

            Children[i] = nil;
        end

        return;
    end

    local Children = { Element:GetChildren() };
    for i = 1, #Children do
        self:releaseChildren(Children[i]);
        Children[i]:SetFrameLevel(1);
        Children[i]:SetSize(1, 1);
        Children[i]:Hide();
        Children[i] = nil;
    end
end

--- Determine the given Item's type (e.g: Frame, Table, Button etc)
---
---@param Item Frame
---@return string
function Interface:determineItemType(Item)
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
---@param identifier string|nil
---@param default table
---@return table
function Interface:getPosition(identifier, default)
    identifier = ("UI.%s.Position"):format(identifier);

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
---@param identifier string|nil The name under which the settings should be stored
---@return boolean
function Interface:storePosition(Item, identifier)
    identifier = identifier or Item:GetName();

    if not (identifier) then
        return false;
    end

    identifier = ("UI.%s.Position"):format(identifier);

    local point, _, relativePoint, offsetX, offsetY = Item:GetPoint();

    Settings:set(identifier .. ".point", point);
    Settings:set(identifier .. ".relativePoint", relativePoint);
    Settings:set(identifier .. ".offsetX", offsetX);
    Settings:set(identifier .. ".offsetY", offsetY);

    return true;
end

--- Restore an element's position from the settings table
---
---@param Item Frame
---@param identifier string|nil The name under which the settings should be stored
---@return boolean
function Interface:restorePosition(Item, identifier)
    identifier = identifier or Item:GetName();

    if (not identifier) then
        return false;
    end

    Item:ClearAllPoints();
    Item:SetPoint(self:getPosition(identifier));

    return true;
end

--- Get an element's stored dimensions
---
---@param identifier string|nil
---@return number|nil, number|nil
function Interface:getDimensions(identifier)
    if (type(identifier) == "table" and identifier.GetName) then
        identifier = identifier:GetName();
    end

    if not (identifier) then
        return false;
    end

    identifier = ("UI.%s.Dimensions"):format(identifier);

    local Dimensions = Settings:get(identifier, {});
    return Dimensions.width, Dimensions.height, Dimensions.scale;
end

--- Store an element's position in the settings table
---
---@param Item table
---@param identifier string|nil The name under which the settings should be stored
---@return nil
function Interface:storeDimensions(Item, identifier)
    identifier = identifier or Item:GetName();

    if (not identifier) then
        return false;
    end

    identifier = ("UI.%s.Dimensions"):format(identifier);

    if (Item.frame) then
        Settings:set(identifier .. ".width", Item.frame:GetWidth());
        Settings:set(identifier .. ".height", Item.frame:GetHeight());
        Settings:set(identifier .. ".scale", Item.frame:GetScale());
        return;
    end

    Settings:set(identifier .. ".width", Item:GetWidth());
    Settings:set(identifier .. ".height", Item:GetHeight());
    Settings:set(identifier .. ".scale", Item:GetScale());
end

--- Restore an element's position from the settings table
---
---@param Item Frame
---@param identifier string|nil The name under which the settings should be stored
---@param defaultWidth number The default width if no width is stored yet
---@param defaultHeight number The default height if no height is stored yet
---@param defaultScale number The default scale if no scale is stored yet
---@return nil
function Interface:restoreDimensions(Item, identifier, defaultWidth, defaultHeight, defaultScale)
    identifier = identifier or Item:GetName();

    if (not identifier) then
        return false;
    end

    local width, height, scale = self:getDimensions(identifier);
    width = width or defaultWidth;
    height = height or defaultHeight;
    scale = scale or defaultScale;

    if (GL:higherThanZero(width)) then
        Item:SetWidth(width or defaultWidth);
    end

    if (GL:higherThanZero(height)) then
        Item:SetHeight(height or defaultHeight);
    end

    if (GL:higherThanZero(scale)) then
        if (Item.frame) then
            Item.frame:SetScale(scale);
        else
            Item:SetScale(scale);
        end
    end
end

--- Check if the user's mouse cursor is over the given frame
---
---@param Element table
---@return boolean
function Interface:mouseIsOnFrame(Element)
    local x, y = GetCursorPosition();
    local scale = Element:GetEffectiveScale();
    x, y = x / scale,  y / scale;

    local left, right, bottom, top = Element:GetLeft(), Element:GetRight(), Element:GetBottom(), Element:GetTop();

    if (not left or not right or not bottom or not top) then
        return false;
    end

    return ((x >= left) and (x <= right)
        and (y >= bottom) and (y <= top));
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
    local onClick = Details.onClick or function () end;
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
    local imageWidth = Details.imageWidth or width;
    local imageHeight = Details.imageHeight or height;

    fireUpdateOnCreation = fireUpdateOnCreation ~= false;

    if (type(updateOn) ~= "table") then
        updateOn = { updateOn };
    end

    -- If the parent element is an AceGUI element then refer to its frame instead
    if (Parent.frame) then
        Parent = Parent.frame;
    end

    local name;

    ---@type Frame
    local Button = tremove(self.FramePool.Buttons);

    if (not Button) then
        name = "GargulButton" .. GL:uuid() .. GL:uuid();
        Button = CreateFrame("Button", name, Parent, "UIPanelButtonTemplate");
    else
        name = Button:GetName();
    end

    Button:SetParent(Parent);
    Button:SetEnabled(true);
    Button:ClearAllPoints();
    Button:SetSize(width, height);
    Button.updateOn = updateOn;

    -- Make sure the tooltip still shows even when the button is disabled
    if (disabledTooltip) then
        Button:SetMotionScriptsWhileDisabled(true);
    end

    if (normalTexture) then
        local NormalTexture = Button.normalTexture or Button:CreateTexture();
        NormalTexture:SetTexture(normalTexture);
        NormalTexture:ClearAllPoints();
        NormalTexture:SetPoint("CENTER", Button, "CENTER", 0, 0);
        NormalTexture:SetSize(imageWidth, imageHeight);
        Button:SetNormalTexture(NormalTexture);

        Button.normalTexture = NormalTexture;
    end

    if (highlightTexture) then
        local HighlightTexture = Button.highlightTexture or Button:CreateTexture();
        HighlightTexture:SetTexture(highlightTexture);
        HighlightTexture:ClearAllPoints();
        HighlightTexture:SetPoint("CENTER", Button, "CENTER", 0, 0);
        HighlightTexture:SetSize(width, height);
        Button:SetHighlightTexture(HighlightTexture);

        Button.highlightTexture = HighlightTexture;
    end

    if (disabledTexture) then
        local DisabledTexture = Button.disabledTexture or Button:CreateTexture();
        DisabledTexture:SetTexture(disabledTexture);
        DisabledTexture:ClearAllPoints();
        DisabledTexture:SetPoint("CENTER", Button, "CENTER", 0, 0);
        DisabledTexture:SetSize(width, height);
        Button:SetDisabledTexture(DisabledTexture);

        Button.disabledTexture = DisabledTexture;
    elseif (normalTexture) then
        local DisabledTexture = Button.disabledTexture or Button:CreateTexture();
        DisabledTexture:SetTexture(normalTexture);
        DisabledTexture:SetDesaturated(true);
        DisabledTexture:ClearAllPoints();
        DisabledTexture:SetPoint("CENTER", Button, "CENTER", 0, 0);
        DisabledTexture:SetSize(width, height);
        Button:SetDisabledTexture(DisabledTexture);

        Button.disabledTexture = DisabledTexture;
    end

    -- Show the tooltip on hover
    Button:SetScript("OnEnter", function ()
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

    Button:SetScript("OnLeave", function ()
        GameTooltip:Hide();
    end);

    if (type(onClick) == "function") then
        Button:SetScript("OnClick", function (_, button)
            if (not Button:IsEnabled() and not alwaysFireOnClick) then
                return;
            end

            if (button == "LeftButton") then
                onClick();
            end
        end);
    end

    -- Make sure the button's update method is called whenever any of the given events are fired
    if (type(update) == "function") then
        Button.update = update;

        for _, event in pairs(updateOn) do
            GL.Events:register(nil, event, function () Button:update(); end);
        end

        if (fireUpdateOnCreation) then
            Button:update();
        end
    end

    Button:Show();
    return Button;
end

--- Release a button generated by Gargul
---
---@param Button table
---@return nil
function Interface:releaseButton(Button)
    local name = Button:GetName();

    -- Make sure we can release the button unto our pool for recycling purposes
    Button:SetMotionScriptsWhileDisabled(false);
    Button:SetParent(UIParent);
    Button.normalTexture = nil;
    Button.highlightTexture = nil;
    Button.disabledTexture = nil;
    Button.update = nil;
    Button.OnEnter = nil;
    Button.OnLeave = nil;
    Button.OnClick = nil;
    Button:ClearAllPoints();

    -- Get rid of the button's event listeners
    for _, event in pairs(Button.updateOn or {}) do
        GL.Events:unregister(name .. event .. "Listener");
    end

    Button:Hide();
    Button = nil;

    ---@todo: figure out why reusing doesn't work
    --tinsert(self.FramePool.Buttons, Button);
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
    Details = Details or {};
    Details.normalTexture = "Interface/AddOns/Gargul/Assets/Buttons/share";
    Details.highlightTexture = "Interface/AddOns/Gargul/Assets/Buttons/share-highlighted";

    local Button = self:createButton(Parent, Details);
    local position = Details.position;
    local x = Details.x;
    local y = Details.y;

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

    return Button;
end
