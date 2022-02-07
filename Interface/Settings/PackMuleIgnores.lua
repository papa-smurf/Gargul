---@type GL
local _, GL = ...;

local Overview = GL.Interface.Settings.Overview; ---@type SettingsOverview

---@class PackMuleIgnoresSettings
GL.Interface.Settings.PackMuleIgnores = {
    description = "PackMule ignores quest items, recipes, legendaries and many \"special\" items that are not tradeable. These items will always be ignored unless you make a rule for it in the |c00f7922eSpecific item rules|r section of the PackMule Item Rules. Use the field below if you want to double check whether an item is ignored by PackMule!\n\nReport any missing items that should be ignored by default on our Discord server.",
};
local PackMuleIgnores = GL.Interface.Settings.PackMuleIgnores; ---@type PackMuleIgnoresSettings

---@return void
function PackMuleIgnores:draw(Parent)
    GL:debug("PackMuleIgnoresSettings:draw");

    local Heading = GL.AceGUI:Create("Heading");
    Heading:SetFullWidth(true);
    Heading:SetText("Is this item ignored by PackMule?");
    Parent:AddChild(Heading);

    Overview:drawSpacer(Parent, nil, 10);

    local ItemSearchBox = GL.AceGUI:Create("EditBox");
    ItemSearchBox:DisableButton(false);
    ItemSearchBox:SetHeight(20);
    ItemSearchBox:SetFullWidth(true);
    ItemSearchBox:SetText("");
    ItemSearchBox:SetLabel(string.format(
        "Search using an item ID or item link (shift click or drag/drop)",
        GL:classHexColor("rogue")
    ));
    ItemSearchBox:SetCallback("OnEnterPressed", function (EditBox)
        self:isItemIgnored(EditBox:GetText());
    end);
    Parent:AddChild(ItemSearchBox);

    Overview:drawSpacer(Parent, nil, 10);

    local ItemIsIgnoredResult = GL.AceGUI:Create("Label");
    ItemIsIgnoredResult:SetText("");
    ItemIsIgnoredResult:SetFontObject(_G["GameFontNormal"]);
    ItemIsIgnoredResult:SetFullWidth(true);
    Parent:AddChild(ItemIsIgnoredResult);

    GL.Interface:setItem(self, "ItemIsIgnored", ItemIsIgnoredResult);
end

--- Check whether a given item ID or link is ignored
---
---@return void
function PackMuleIgnores:isItemIgnored(input)
    GL:debug("PackMuleIgnoresSettings:isItemIgnored");

    local Label = GL.Interface:getItem(self, "Label.ItemIsIgnored");

    -- Better safe than LUA error
    if (not Label) then
        return;
    end

    local itemID = GL:getItemIdFromLink(input) or input;
    GL.PackMule:isItemIDIgnored(itemID, function (Loot, itemIsIgnored)
        -- The given item ID doesn't exist
        if (not Loot) then
            Label:SetText(string.format("|c00f7922eItem with ID \"%s\" doesn't exist!|r", itemID));
            return;
        end

        local textColor = "92FF00";
        local flagText = "ignored";

        if (not itemIsIgnored) then
            textColor = "f7922e";
            flagText = "not ignored";
        end

        Label:SetText(string.format("Item with ID %s ( %s ) is |c00%s%s|r", itemID, Loot.link, textColor, flagText));
    end);
end

GL:debug("Interface/Settings/PackMuleIgnores.lua");