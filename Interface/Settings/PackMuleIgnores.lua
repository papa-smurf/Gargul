---@type GL
local _, GL = ...;

local Overview = GL.Interface.Settings.Overview; ---@type SettingsOverview

---@class PackMuleIgnoresSettings
GL.Interface.Settings.PackMuleIgnores = {
    description = "PackMule ignores quest items, recipes, legendaries and many \"special\" items that are not tradeable. These items will always be ignored unless you make a rule for it in the |c00F7922ESpecific item rules|r section of the PackMule Item Rules. Use the field below if you want to double check whether an item is ignored by PackMule!\n\nReport any missing items that should be ignored by default on our Discord server.",
};
local PackMuleIgnores = GL.Interface.Settings.PackMuleIgnores; ---@type PackMuleIgnoresSettings

---@return nil
function PackMuleIgnores:draw(Parent)
    GL:debug("PackMuleIgnoresSettings:draw");

    local DiscordURL = GL.AceGUI:Create("EditBox");
    DiscordURL:DisableButton(true);
    DiscordURL:SetHeight(20);
    DiscordURL:SetFullWidth(true);
    DiscordURL:SetText("https://discord.gg/D3mDhYPVzf");
    Parent:AddChild(DiscordURL);

    Overview:drawSpacer(Parent, nil, 10);

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
    ItemSearchBox:SetFocus();
    ItemSearchBox:SetLabel(("Search using an item ID or item link (shift click or drag/drop)"):format(
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

    GL.Interface:set(self, "ItemIsIgnored", ItemIsIgnoredResult);
end

--- Check whether a given item ID or link is ignored
---
---@return nil
function PackMuleIgnores:isItemIgnored(input)
    GL:debug("PackMuleIgnoresSettings:isItemIgnored");

    local itemID = GL:getItemIDFromLink(input) or input;

    local Label = GL.Interface:get(self, "Label.ItemIsIgnored");
    if (not Label) then
        return;
    end

    GL.PackMule:isItemIDIgnored(itemID, function (Loot, itemIDisIgnoredForMaster, itemIDisIgnoredForGroup)
        -- The given item ID doesn't exist
        if (not Loot) then
            Label:SetText(("|c00F7922EItem with ID \"%s\" doesn't exist!|r"):format(itemID));
            return;
        end

        local labelText = "";
        local textColor = "92FF00";
        local flagText = "ignored";

        if (not itemIDisIgnoredForMaster) then
            textColor = "F7922E";
            flagText = "not ignored";
        end

        local masterLootText = ("In master loot, item with ID %s ( %s ) is |c00%s%s|r"):format(itemID, Loot.link, textColor, flagText);

        textColor = "92FF00";
        flagText = "ignored";

        if (not itemIDisIgnoredForGroup) then
            textColor = "F7922E";
            flagText = "not ignored";
        end

        local groupLootText = ("In group loot, item with ID %s ( %s ) is |c00%s%s|r"):format(itemID, Loot.link, textColor, flagText);

        labelText = ("|c00967FD2By default|r:\n%s\n%s"):format(masterLootText, groupLootText);
        Label:SetText(labelText);

        GL.PackMule:currentTargetForItemForGroupOrMaster(itemID, function (Loot, masterTarget, groupTarget)
            -- The given item ID doesn't exist
            if (not Loot) then
                return;
            end

            masterTarget = masterTarget or "-";
            groupTarget = groupTarget or "-";

            Label:SetText(("%s\n\n|c00967FD2Based on your rules and current group|r:\n%s\n%s"):format(
                labelText,
                ("In master loot, item ( %s ) goes to: %s"):format(Loot.link, GL:nameFormat{ name = masterTarget, colorize = true, }),
                ("In group loot, item ( %s ) goes to: %s"):format(Loot.link, GL:nameFormat{ name = groupTarget, colorize = true, })
            ));
        end);
    end);
end
