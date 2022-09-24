---@type GL
local _, GL = ...;

local Overview = GL.Interface.Settings.Overview; ---@type SettingsOverview

---@class DroppedLootSettings
GL.Interface.Settings.DroppedLoot = {
    description = "Gargul allows you to automatically announce dropped loot into your group chat.\n\nNB: In order for loot to be announced you need to be in a group and need to have the master looter role!",
    wikiUrl = "https://github.com/papa-smurf/Gargul/wiki/Announcing-Loot-in-Chat",
};
local DroppedLoot = GL.Interface.Settings.DroppedLoot; ---@type DroppedLootSettings

---@return void
function DroppedLoot:draw(Parent)
    GL:debug("DroppedLoot:draw");

    local HorizontalSpacer;
    local AceGUI = GL.AceGUI;

    local MinimumQualityLabel = AceGUI:Create("Label");
    MinimumQualityLabel:SetColor(1, .95686, .40784);
    MinimumQualityLabel:SetText("The minimum quality an item should have in order to be announced in chat");
    MinimumQualityLabel:SetHeight(20);
    MinimumQualityLabel:SetFullWidth(true);
    Parent:AddChild(MinimumQualityLabel);

    local DropDownItems = {
        [0] = "0 - Poor",
        [1] = "1 - Common",
        [2] = "2 - Uncommon",
        [3] = "3 - Rare",
        [4] = "4 - Epic",
        [5] = "5 - Legendary",
    };

    local MinimumQuality = AceGUI:Create("Dropdown");
    MinimumQuality:SetValue(GL.Settings:get("DroppedLoot.minimumQualityOfAnnouncedLoot", 4));
    MinimumQuality:SetList(DropDownItems);
    MinimumQuality:SetText(DropDownItems[GL.Settings:get("DroppedLoot.minimumQualityOfAnnouncedLoot", 4)]);
    MinimumQuality:SetWidth(150);
    MinimumQuality:SetCallback("OnValueChanged", function()
        GL.Settings:set("DroppedLoot.minimumQualityOfAnnouncedLoot", MinimumQuality:GetValue());
    end);
    Parent:AddChild(MinimumQuality);

    HorizontalSpacer = AceGUI:Create("SimpleGroup");
    HorizontalSpacer:SetLayout("FILL");
    HorizontalSpacer:SetFullWidth(true);
    HorizontalSpacer:SetHeight(10);
    Parent:AddChild(HorizontalSpacer);

    local Checkboxes = {
        {
            label = "Announce loot to chat",
            setting = "DroppedLoot.announceLootToChat",
        },
        {
            label = "Use raid warning",
            description = "Use /rw instead of /ra when announcing dropped loot",
            setting = "DroppedLoot.announceDroppedLootInRW",
        },
    };

    Overview:drawCheckboxes(Checkboxes, Parent);

    HorizontalSpacer = GL.AceGUI:Create("SimpleGroup");
    HorizontalSpacer:SetLayout("FILL");
    HorizontalSpacer:SetFullWidth(true);
    HorizontalSpacer:SetHeight(15);
    Parent:AddChild(HorizontalSpacer);

    local defaultTestItems = (function ()
        local normalizedPlayerName = string.lower(GL.User.name);
        local Reserved = GL.SoftRes:getDetailsForPlayer(normalizedPlayerName);
        local ItemIDs = {};

        -- Check to see if the current player reserved anything
        if (Reserved.Items) then
            for itemID in pairs(Reserved.Items) do
                tinsert(ItemIDs, itemID);
                break;
            end
        end

        if (GL.TMB:available()) then
            -- Check to see if the current player TMBed anything
            local TMBItemFound = false;
            for itemID, ItemEntry in pairs(GL.DB:get("TMB.Items", {})) do
                for _, Entry in pairs(ItemEntry) do
                    local playerName = string.lower(GL:stripRealm(Entry.character));

                    --- NOTE TO SELF: it's (os) because of the string.lower, if you remove the lower then change below accordingly!
                    if (normalizedPlayerName == string.gsub(playerName, "%(os%)", "")) then
                        tinsert(ItemIDs, itemID);
                        TMBItemFound = true;
                        break;
                    end
                end

                if (TMBItemFound) then
                    break;
                end
            end
        end

        return table.concat(ItemIDs, ";");
    end)();

    local TestItems = GL.AceGUI:Create("EditBox");
    TestItems:DisableButton(true);
    TestItems:SetHeight(20);
    TestItems:SetFullWidth(true);
    TestItems:SetText(defaultTestItems);
    TestItems:SetLabel(string.format(
        "|cff%sAdd item links or IDs here separated by ; (semicolon) and 'Simulate drop' to preview the announce:|r",
        GL:classHexColor("rogue")
    ));
    Parent:AddChild(TestItems);

    local OpenDataButton = GL.AceGUI:Create("Button");
    OpenDataButton:SetText("Simulate drop");
    OpenDataButton:SetCallback("OnClick", function()
        GL.DroppedLoot:announceTest(GL:strSplit(TestItems:GetText(), ";"));
    end);
    Parent:AddChild(OpenDataButton);
end

GL:debug("Interface/Settings/DroppedLoot.lua");