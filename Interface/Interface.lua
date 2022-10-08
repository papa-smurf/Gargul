---@type GL
local _, GL = ...;

---@class Interface
GL.Interface = GL.Interface or {
    typeDictionary = {
        InteractiveLabel = "Label",
        SimpleGroup = "Frame",
        InlineGroup = "Frame",
    }
};

local Settings = GL.Settings; ---@type Settings
local Interface = GL.Interface; ---@type Interface

-- Set an interface item on a given scope (either an object or string reference to an interface class)
function Interface:setItem(scope, identifier, Item)
    local widgetType = self:determineItemType(Item);
    local path = "";

    if (type(scope) == "table") then
        path = string.format("InterfaceItems.%s.%s", widgetType, identifier);
        return GL:tableSet(scope, path, Item);
    end

    path = string.format("GL.Interface.%s.InterfaceItems.%s.%s", scope, widgetType, identifier);
    return GL:tableSet(path, identifier);
end

-- Fetch an interface item from a given scope (either an object or string reference to an interface class)
function Interface:getItem(Scope, identifier)
    if (identifier == "Window") then
        identifier = "Frame.Window";
    end

    if (type(Scope) == "table") then
        return GL:tableGet(Scope, "InterfaceItems." .. identifier), identifier;
    end

    return GL:tableGet(GL.Interface, Scope .. ".InterfaceItems." .. identifier), identifier;
end

--- Release an item and remove it from our interface entirely
---
---@param Scope table
---@param identifier string
---@return boolean
function Interface:release(Scope, identifier)
    if (type(Scope) ~= "table"
        or type(identifier) ~= "string"
        or GL:empty(identifier)
    ) then
        return false
    end

    local Item, fullIdentifier = self:getItem(Scope, identifier);

    if (not Item
        or type(Item) ~= "table"
    ) then
        return false;
    end

    if (type(Item.type) == "string") then
        GL.AceGUI:Release(Item);
    end

    local path = string.format("InterfaceItems.%s", fullIdentifier);
    return GL:tableSet(Scope, path, nil);
end

-- Determine the given Item's type
function Interface:determineItemType(Item)
    if (type(Item.GetCell) == "function") then
        return "Table";
    end

    if (type(Item.type) == "string") then
        local itemType = Item.type;

        return self.typeDictionary[itemType] or itemType;
    end

    return "Frame";
end

--- Get an element's stored position (defaults to center of screen)
---
---@param identifier string
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
---@param Item table
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

GL:debug("Interface/Interface.lua");