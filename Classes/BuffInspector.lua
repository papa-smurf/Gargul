local _, App = ...;

App.Ace.GUI = App.Ace.GUI or LibStub("AceGUI-3.0");
App.Ace.ScrollingTable = App.Ace.ScrollingTable or LibStub("ScrollingTable");

App.BuffInspector = {
    InspectionReport = {
        Buffs = {},
        Reports = {},
        NumberOfBuffsInspected = 0,
    },
};

local BuffInspector = App.BuffInspector;
local ScrollingTable = App.Ace.ScrollingTable;
local AceGUI = App.Ace.GUI;

BuffInspector.Widgets = {
    Frame = {},
    Buttons = {},
    EditBoxes = {},
    Labels = {},
    Tables = {},
    Icons = {},
};

-- Inspect the raid group's bag contents for the
-- availability of specific items (max 8)
function BuffInspector:inspect(SpellIds)
    App:debug("BuffInspector:inspect");

    if (not App.User.isInGroup) then
        return App:error("You're not in a group");
    end

    SpellIds = App:strSplit(SpellIds, ",");
    SpellIds = App:tableSlice(SpellIds, 8); -- inspect supports up to 8 spell ids

    if (#SpellIds < 1) then
        return App:error("No spell ids provided in BuffInspector.inspect");
    end

    local Buffs = {}
    local buffsDetected = false;
    local groupType = "party";

    if (App.User.isInRaid) then
        groupType = "raid";
    end

    for index = 1, #SpellIds do
        local spellId = tonumber(SpellIds[index]);

        if (not spellId) then
            return App:error("Unknown spell id provided in BuffInspector.inspect");
        end

        -- Trim the buff name
        local name, _, icon = GetSpellInfo(spellId);

        if (not name) then
            return App:error(string.format("Unknown spell id '%s' provided in BuffInspector.inspect", spellId));
        end

        Buffs[tostring(spellId)] = {
            name = name,
            icon = icon,
            spellId = spellId,
            players = {},
        }
    end

    local Players = App.User:listGroupMembers();

    for _, player in pairs(Players) do
        -- Prefill the Buffs object for this player
        for _, Buff in pairs(Buffs) do
            Buff.players[player.name] = "no";
        end

        for buffSlot = 1, 32 do
            local _, _, _, _, _, _, _, _, _, spellId = UnitBuff(player.name, buffSlot);

            if (spellId) then
                spellId = tostring(spellId);

                if (Buffs[spellId]) then
                    Buffs[spellId].players[player.name] = "yes";

                    buffsDetected = true;
                end
            elseif (not buffName) then
                break;
            end
        end
    end

    if (buffsDetected) then
        return self:displayInspectionResults(Buffs, Players);
    end

    App:message("Could not find anyone in your group with any of the specified buffs");
end

-- Display the report results from a group-wide bag inspection
function BuffInspector:displayInspectionResults(Buffs, Players)
    --[[ Buffs format:
        {
            "Devotion Aura":{
                "icon":135893,
                "index":1,
                "name":"Devotion Aura",
                "players": {
                    "Bushboss":"no",
                    "Receptionist":"yes"
                },
                "spellId":465
            },
            etc..
        }
    ]]

    local PlayerData = {};
    local SortedBuffs = {};
    local firstPassThrough = true;
    local ClassColors = App.Data.Constants.ClassRgbColors;
    for _, Player in pairs(Players) do
        local Row = {
            cols = {
                {
                    value = Player.name,
                    color = ClassColors[string.lower(Player.class)],
                },
            },
        };

        for _, Buff in pairs(Buffs) do
            tinsert(Row.cols, {
                value = App:tableGet(Buffs, string.format("%s.players.%s", Buff.spellId, Player.name)),
                color = ClassColors[string.lower(Player.class)],
            });

            if (firstPassThrough) then
                tinsert(SortedBuffs, Buff);
            end
        end

        firstPassThrough = false;
        tinsert(PlayerData, Row);
    end

    --[[ lib-st table data format:
        [
            {
                "cols":[
                    {
                        "color":{
                            "a":1,
                            "b":0.93725,
                            "g":0.8,
                            "r":0.4078
                        },
                        "value":"Abudabi"
                    },
                    {
                        "color":{
                            "a":1,
                            "b":0.93725,
                            "g":0.8,
                            "r":0.4078
                        },
                        "value":"yes"
                    },
                    {
                        etc..
                    }
                ]
            },
            {
                "cols": etc..
            }
        ]
    ]]

    -- Create a container/parent frame
    local ResultFrame = AceGUI:Create("Frame");
    ResultFrame:SetCallback("OnClose", function(widget)
        App:clearScrollTable(self.Widgets.Tables.InspectionReport);

        self.InspectionReport = {
            Buffs = {},
            Reports = {},
        };

        AceGUI:Release(widget);
    end);
    ResultFrame:SetTitle("Gargul v" .. App.version);
    ResultFrame:SetStatusText("Addon v" .. App.version);
    ResultFrame:SetLayout("Flow");
    ResultFrame:SetWidth(600);
    ResultFrame:SetHeight(450);
    ResultFrame.statustext:GetParent():Hide(); -- Hide the statustext bar

    local FirstRow = AceGUI:Create("SimpleGroup");
    FirstRow:SetLayout("Flow");
    FirstRow:SetFullWidth(true);
    FirstRow:SetHeight(30);
    ResultFrame:AddChild(FirstRow);

    local BuffIcons = {};
    local ItemSpacers = {};
    for index = 1, 8 do
        ItemSpacers[index] = AceGUI:Create("SimpleGroup");
        local ItemSpacer = ItemSpacers[index];
        ItemSpacer:SetHeight(30);
        ItemSpacer:SetLayout("Fill");

        if (index == 1) then
            ItemSpacer:SetWidth(130);
        else
            ItemSpacer:SetWidth(20);
        end

        FirstRow:AddChild(ItemSpacer);

        local Buff = SortedBuffs[index];

        local BuffIconHolder = AceGUI:Create("SimpleGroup");
        BuffIconHolder:SetHeight(30);
        BuffIconHolder:SetWidth(30);
        FirstRow:AddChild(BuffIconHolder);

        BuffIcons[index] = AceGUI:Create("Icon");
        local BuffIcon = BuffIcons[index];
        BuffIcon:SetWidth(30);
        BuffIcon:SetHeight(30);

        if (Buff) then
            BuffIcon:SetImage(Buff.icon);
            BuffIcon:SetImageSize(30, 30);

            -- Show a gametooltip if the icon shown belongs to an item
            BuffIcon:SetCallback("OnEnter", function()
                GameTooltip:SetOwner(BuffIcon.frame, "ANCHOR_TOP");
                GameTooltip:SetHyperlink("spell:" .. Buff.spellId);
                GameTooltip:Show();
            end)

            BuffIcon:SetCallback("OnLeave", function()
                GameTooltip:Hide();
            end)
        end

        BuffIconHolder:AddChild(BuffIcon);
    end

    local Columns = {
        {
            name = "Player",
            width = 100,
            align = "LEFT",
            color = {
                r = 0.5,
                g = 0.5,
                b = 1.0,
                a = 1.0
            },
            colorargs = nil,
            sort = App.Data.Constants.ScrollingTable.ascending,
        },
    };

    for index = 1, 8 do
        local name = "Buff";

        if (index > #SortedBuffs) then
            name = "";
        end

        tinsert(Columns, {
            name = name,
            width = 50,
            align = "CENTER",
            color = {
                r = 0.5,
                g = 0.5,
                b = 1.0,
                a = 1.0
            },
            colorargs = nil,
        });
    end

    local table = ScrollingTable:CreateST(Columns, 20, 15, nil, ResultFrame.frame);
    table:EnableSelection(true);
    table:SetData(PlayerData);

    table.frame:SetPoint("BOTTOM", ResultFrame.frame, "BOTTOM", 0, 50);

    BuffInspector.Widgets.Tables.InspectionReport = table;
end

App:debug("BuffInspector.lua");