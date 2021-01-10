local _, App = ...;

App.Dashboard = App.Dashboard or {};
App.Ace.GUI = App.Ace.GUI or LibStub("AceGUI-3.0");
App.Ace.ScrollingTable = App.Ace.ScrollingTable or LibStub("ScrollingTable");

local Settings = App.Settings;
local Dashboard = App.Dashboard;
local AceGUI = App.Ace.GUI;
local ScrollingTable = App.Ace.ScrollingTable;

Dashboard.visible = false;
Dashboard.CharactersDataTable = {
    Frame = {},
    Tables = {},
};

Dashboard.Widgets = {
    Frame = {},
    Tables = {},
};

-- Add a resut table confirmation dialog to Blizzard's global StaticPopupDialogs object
StaticPopupDialogs["RESET_TABLES_CONFIRMATION"] = {
    text = "Are you sure you want to reset your tables? This cannot be undone!",
    button1 = "Yes",
    button2 = "No",
    OnAccept = function()
        App.DB:resetCharactersAndLoot();
        App.Dashboard:refresh();
    end,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3,
}

-- Add a resut table confirmation dialog to Blizzard's global StaticPopupDialogs object
StaticPopupDialogs["BROADCAST_TABLES_CONFIRMATION"] = {
    text = "Are you sure you want to broadcast your tables to the entire guild?",
    button1 = "Yes",
    button2 = "No",
    OnAccept = function()
        App.Sync:broadcast();
    end,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3,
}

function Dashboard:draw()
    if (self.visible) then
        App:warning("The dashboard is already visible");
        return;
    end

    App.User:refresh();
    self.visible = true;

    -- Create a container/parent frame
    local DashboardFrame = AceGUI:Create("Frame");
    DashboardFrame:SetTitle("Gargul v" .. App.version);
    DashboardFrame:SetStatusText("You have |c00a79eff" .. App.User.Dkp.amount .. "|r DKP");
    DashboardFrame.statustext:GetParent():Show(); -- We want to explicitely show the status bar here
    DashboardFrame:SetLayout("Flow");
    DashboardFrame:SetWidth(600);
    DashboardFrame:SetHeight(470);
    DashboardFrame:EnableResize(false);
    DashboardFrame.frame:SetFrameStrata("HIGH");
    DashboardFrame:SetCallback("OnClose", function(widget)
        self:close();
    end);
    DashboardFrame:SetPoint(
        Settings:get("UI.Dashboard.Position.point"),
        UIParent,
        Settings:get("UI.Dashboard.Position.relativePoint"),
        Settings:get("UI.Dashboard.Position.offsetX"),
        Settings:get("UI.Dashboard.Position.offsetY")
    );
    self.Widgets.Frame.Dashboard = DashboardFrame;

    local TreeData = Dashboard:lootHistoryToTreeData();

    --[[
        PARENT FRAME FOR DKP AND LOOT
    ]]
    local CharactersAndLootFrame = AceGUI:Create("SimpleGroup");
    CharactersAndLootFrame:SetLayout("Flow")
    CharactersAndLootFrame:SetFullWidth(true);
    CharactersAndLootFrame:SetHeight(350);
    DashboardFrame:AddChild(CharactersAndLootFrame);

    --[[
        CHARACTERS FRAME
    ]]
    local CharactersFrame = AceGUI:Create("SimpleGroup");
    CharactersFrame:SetLayout("FILL")
    CharactersFrame:SetWidth(305);
    CharactersFrame:SetHeight(350);
    CharactersAndLootFrame:AddChild(CharactersFrame);

    -- Generate the characters table and add it to CharactersFrame.frame
    Dashboard:drawCharactersTable(CharactersFrame.frame);

    --[[
        LOOT FRAME
    ]]
    local LootFrame = AceGUI:Create("SimpleGroup");
    LootFrame:SetLayout("Fill");
    LootFrame:SetWidth(260);
    LootFrame:SetHeight(350);

    CharactersAndLootFrame:AddChild(LootFrame);

    local lootHistoryTree = AceGUI:Create("TreeGroup");
    LootFrame:AddChild(lootHistoryTree);
    lootHistoryTree:SetTree(TreeData);

    -- For some unknown idiotic reason you can't disable the right hand side directly
    local treeLeftSide, treeRightSide = lootHistoryTree.frame:GetChildren();
    treeLeftSide:SetPoint("TOPRIGHT", CharactersAndLootFrame.frame, "TOPRIGHT", -15, 0);
    treeRightSide:Hide();
    treeRightSide = nil;

    --[[
        FOOTER BUTTON PARENT FRAME
    ]]
    local FooterFrame = AceGUI:Create("SimpleGroup");
    FooterFrame:SetLayout("Flow");
    FooterFrame:SetFullWidth(true);
    FooterFrame:SetHeight(50);
    DashboardFrame:AddChild(FooterFrame);

    -- Button padder
    local ButtonPadder = AceGUI:Create("SimpleGroup");
    ButtonPadder:SetLayout("Flow");
    ButtonPadder:SetFullWidth(false);
    ButtonPadder:SetHeight(1);
    ButtonPadder:SetWidth(16);
    FooterFrame:AddChild(ButtonPadder);

    -- In raid checkbox
    local InRaidCheckbox = AceGUI:Create("CheckBox");
    InRaidCheckbox:SetType("checkbox");
    InRaidCheckbox:SetLabel("In raid only");
    InRaidCheckbox:SetValue(Settings:get("UI.Dashboard.showInRaidOnly", false));
    InRaidCheckbox:SetCallback("OnValueChanged", function (widget)
        local checked = widget:GetValue();
        Settings:set("UI.Dashboard.showInRaidOnly", checked);
        Dashboard:refresh();
    end);
    FooterFrame:AddChild(InRaidCheckbox);

    self.Widgets.Tables.Characters:SortData();
end

function Dashboard:drawCharactersTable(parent)
    if (not App.DB:isValid()) then
        App:error("This feature is unavailable because your SavedVariables are corrupt");
        return;
    end

    local columns = {
        {
            name = "Player",
            width = 110,
            align = "LEFT",
            color = {
                r = 0.5,
                g = 0.5,
                b = 1.0,
                a = 1.0
            },
            colorargs = nil,
        },
        {
            name = "Class",
            width = 70,
            align = "LEFT",
            color = {
                r = 0.5,
                g = 0.5,
                b = 1.0,
                a = 1.0
            },
            colorargs = nil,
            sort = 1, -- 1 = ascending, 2 = descending
        },
        {
            name = "DKP",
            width = 60,
            align = "LEFT",
            color = {
                r = 0.5,
                g = 0.5,
                b = 1.0,
                a = 1.0
            },
            colorargs = nil,
        },
    };

    local table = ScrollingTable:CreateST(columns, 21, 15, nil, parent);
    table:EnableSelection(true);
    table:SetWidth(250);
    table.frame:SetPoint("BOTTOM", 2);

    local CharacterData = {};
    local ClassColors = App.Data.Constants.ClassRgbColors;

    local GroupMembers = {};
    if (App.User.isInGroup and Settings:get("UI.Dashboard.showInRaidOnly")) then
        -- Loop through all members of the group (party or raid)
        for index = 1, MAX_RAID_MEMBERS do
            local name, _, _, _, class, _,
            _, online = GetRaidRosterInfo(index);

            if (name) then
                GroupMembers[name] = true;
            end
        end
    end

    local hasData = false;
    for name, character in pairs(App.DB.Characters) do
        local row = {
            cols = {
                {
                    value = name,
                    color = ClassColors[character.class],
                },
                {
                    value = App:capitalize(character.class),
                    color = ClassColors[character.class],
                },
                {
                    value = tonumber(string.format("%." .. 2 .. "f", character.dkp)),
                    color = ClassColors[character.class],
                },
            },

        };

        -- Check if in raid only is disabled or if not make sure
        -- the player is in the raid, if not don't show it
        if (not Settings:get("UI.Dashboard.showInRaidOnly")
            or App:tableGet(GroupMembers, name, false)
        ) then
            tinsert(CharacterData, row);
            hasData = true;
        end
    end

    if (not hasData) then
        CharacterData[1] = {
            cols = {
                {
                    value = "No data!",
                },
                {
                    value = "",
                },
                {
                    value = "",
                },
            },
        };
    end

    -- The second argument refers to "isMinimalDataformat"
    -- For the full format see https://www.wowace.com/projects/lib-st/pages/set-data
    table:SetData(CharacterData);

    self.Widgets.Tables.Characters = table;
end

--[[
    Transform the loot history data in our saved variables
    to something AceGUI's TreeGroup can work with

    Our treegroup basically looks like this:
    - Date (d-m-Y)
        - Item
            - Winning bid
            - Other bid #1
            - Other bid #2
            - etc
    - Date (d-m-Y)
    - etc
]]
function Dashboard:lootHistoryToTreeData()
    local lootHistory = App.DB.LootHistory or {};
    local TreeData = {};

    if (not lootHistory or not #lootHistory) then
        return {};
    end

    for timestamp, item in pairs(lootHistory) do
        local date = date('%d-%m-%Y', timestamp);

        -- This item doesn't have an item link yet for some reason, fix it!
        if (not item.link) then
            local _, _, itemLink = pcall(function () return GetItemInfo(item.id); end);
            item.link = itemLink;
        end

        -- Initialize the first level (date)
        TreeData[date] = TreeData[date] or {
            value = 1,
            text = date,
            children = {},
        };

        -- Build the item level (item details plus winning bid details)
        local itemTree = {
            value = item.id .. timestamp,
            text = item.link,
            icon = GetItemIcon(item.id),
            children = {
                {
                    value = 1,
                    text = string.format("%s: %s DKP (Winner)", item.player, item.dkp),
                }
            },
        };

        -- Add all valid bids to the item level (if any)
        if (item.bids and #item.bids) then
            for bidKey, bid in pairs(item.bids) do
                if (bid.player and bid.dkp) then
                    itemTree.children[#itemTree.children + 1] = {
                        value = bidKey + 1,
                        text = string.format("%s: %s DKP", bid.player, bid.dkp);
                    };
                end
            end
        end

        tinsert(TreeData[date].children, itemTree);
    end

    local treeDataKeys = {};
    for key in pairs(TreeData) do
        tinsert(treeDataKeys, key);
    end

    -- Sort the keys in descending order (so newest items end up on top)
    sort(treeDataKeys, function (left, right)
        local leftDateParts = App:strSplit(left, "-");
        local rightDateParts = App:strSplit(right, "-");
        local leftTimestamp = time{year=leftDateParts[3], month=leftDateParts[2], day=leftDateParts[1]};
        local rightTimestamp = time{year=rightDateParts[3], month=rightDateParts[2], day=rightDateParts[1]};

        return leftTimestamp > rightTimestamp;
    end)

    -- Our date keys are not something TreeGroup can work with since it expects numeric keys
    local unassociativeTreeData = {};
    local numberOfEntries = 0;
    for _, key in pairs(treeDataKeys) do
        numberOfEntries = numberOfEntries + 1;
        TreeData[key].value = numberOfEntries;
        tinsert(unassociativeTreeData, TreeData[key]);
    end

    return unassociativeTreeData;
end

-- Close the dashboard
function Dashboard:close()
    if (not self.visible) then
        return;
    end

    local point, _, relativePoint, offsetX, offsetY = self.Widgets.Frame.Dashboard:GetPoint();

    -- Store the frame's last position for future play sessions
    Settings:set("UI.Dashboard.Position.point", point);
    Settings:set("UI.Dashboard.Position.relativePoint", relativePoint);
    Settings:set("UI.Dashboard.Position.offsetX", offsetX);
    Settings:set("UI.Dashboard.Position.offsetY", offsetY);

    -- Clear the frame and its widgets
    AceGUI:Release(self.Widgets.Frame.Dashboard);
    self.visible = false;

    -- Clean up the characters table seperately
    self.Widgets.Tables.Characters:SetData({}, true);
    self.Widgets.Tables.Characters:Hide();
end

-- Refresh the dashboard
function Dashboard:refresh()
    if (not self.visible) then
        return;
    end

    self:close();
    self:draw();
end

App:debug("Dashboard.lua");