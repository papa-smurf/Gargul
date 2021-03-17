--[[
    This class allows us to quickly change
    raid group compositions via a predefined csv format
]]

local _, App = ...;

App.RaidGroups = App.RaidGroups or {
    UIComponents = {},
    MainTanksByPlayerName = {},
    migrationInProgress = false,
};

App.Ace.GUI = App.Ace.GUI or LibStub("AceGUI-3.0");

local RaidGroups = App.RaidGroups;
local AceGUI = App.Ace.GUI;

-- Output everyone currently in the raid in a CSV format
function RaidGroups:toCSV()
    local raidMembers = {};

    if (not App.User.isInRaid) then
        return App:warning("You're not currently in a raid");
    end

    local csv = "";
    for _, Player in pairs(App.User:groupMembers()) do
        csv = csv .. Player.name .. ",";
    end

    App:frameMessage(csv);
end

-- Draw the ui that allows us to import/write a raid roster
function RaidGroups:drawImporter()
    App:debug("RaidGroups:draw");

    -- Create a container/parent frame
    local RaidGroupsFrame = AceGUI:Create("Frame");
    RaidGroupsFrame:SetTitle(App.name .. " v" .. App.version);
    RaidGroupsFrame:SetStatusText("Addon v" .. App.version);
    RaidGroupsFrame:SetLayout("Flow");
    RaidGroupsFrame:SetWidth(600);
    RaidGroupsFrame:SetHeight(450);
    RaidGroupsFrame.statustext:GetParent():Hide(); -- Hide the statustext bar

    -- Large edit box
    local RaidGroupsBoxContent = "";
    local RaidGroupsBox = AceGUI:Create("MultiLineEditBox");
    RaidGroupsBox:SetFullWidth(true);
    RaidGroupsBox:DisableButton(true);
    RaidGroupsBox:SetFocus();
    RaidGroupsBox:SetLabel("Put groups on seperate lines prefixed with group number: '1:player1,player2'. Group 9 are the tanks");
    RaidGroupsBox:SetNumLines(22);
    RaidGroupsBox:SetMaxLetters(999999999);
    RaidGroupsFrame:AddChild(RaidGroupsBox);

    RaidGroupsBox:SetCallback("OnTextChanged", function(_, _, text)
        RaidGroupsBoxContent = text;
    end)

    --[[
        FOOTER BUTTON PARENT FRAME
    ]]
    local FooterFrame = AceGUI:Create("SimpleGroup");
    FooterFrame:SetLayout("Flow");
    FooterFrame:SetFullWidth(true);
    FooterFrame:SetHeight(50);
    RaidGroupsFrame:AddChild(FooterFrame);

    local SaveButton = AceGUI:Create("Button");
    SaveButton:SetText("Apply");
    SaveButton:SetWidth(140);
    SaveButton:SetCallback("OnClick", function()
        self:applyRaidGroups(RaidGroupsBoxContent);
    end);
    FooterFrame:AddChild(SaveButton);

    local ClearButton = AceGUI:Create("Button");
    ClearButton:SetText("Clear");
    ClearButton:SetWidth(140);
    ClearButton:SetCallback("OnClick", function()
        RaidGroupsBox:SetText("");
    end);
    FooterFrame:AddChild(ClearButton);
end

-- Build a list of migrations based on the csv provided by the user
function RaidGroups:applyRaidGroups(raidGroupCsv)
    App:debug("RaidGroups:applyRaidGroups");

    if (not App.User.isInRaid) then
        return App:warning("You need to be in a raid!");
    end

    if (not App.User.hasAssist) then
        return App:warning("You need to have an assist or lead role!");
    end

    if (self.migrationInProgress) then
        return App:warning("There's a migration still in progress, wait a bit!");
    end

    local MainTanksByPlayerName = {};
    local DesiredGroupByPlayerName = {};
    local PlayersOnTheRoster = {};

    for line in raidGroupCsv:gmatch("[^\n]+") do
        local Segments = App:strSplit(line, ":");
        local group = tonumber(Segments[1]);

        if (not group or type(group) ~= "number" or group < 1 or group > 9) then
            return App:warning("Invalid raid groups provided!");
        end

        local Players = App:strSplit(Segments[2], ",");

        for _, playerName in pairs(Players) do
            -- We can't process the same name twice!
            if (PlayersOnTheRoster[playerName]) then
                return App:warning(string.format("%s is listed twice on the roster!", playerName));
            end

            PlayersOnTheRoster[playerName] = true;

            -- group 9 is a group we reserve for specifiying the tanks
            if (group < 9) then
                DesiredGroupByPlayerName[playerName] = group;
            else
                tinsert(MainTanksByPlayerName, playerName);
            end
        end
    end

    local RaidMembers = {};
    local RaidersPerGroup = {};
    local UnwantedPlayers = {};
    local NumRaidersInGroup = {};
    for i = 1, 8 do RaidersPerGroup[i] = {}; end
    for i = 1, 8 do NumRaidersInGroup[i] = 0; end
    for _, Raider in pairs(App.User:groupMembers()) do
        if (UnitAffectingCombat("raid" .. Raider.index)) then
            return App:warning(string.format("Can't sort groups while %s is in combat!", Raider.name));
        end

        -- Check if there's people in the raid who are not on the roster
        if (not DesiredGroupByPlayerName[Raider.name]) then
            tinsert(UnwantedPlayers, Raider.name);
        end

        RaidMembers[Raider.name] = Raider;
        RaidersPerGroup[Raider.subgroup][Raider.name] = true;
        NumRaidersInGroup[Raider.subgroup] = NumRaidersInGroup[Raider.subgroup] + 1;
    end

    -- We can't sort the groups if there's anyone in the raid who doesn't belong!
    if (UnwantedPlayers[1]) then
        return App:warning(string.format(
            "The following players are not part of the group roster: %s",
            table.concat(UnwantedPlayers, ", ")
        ));
    end

    local Migrations = {};
    for key in pairs(RaidMembers) do
        local Raider = RaidMembers[key];
        local raidersCurrentGroup = Raider.subgroup;
        local raidersDesiredGroup = DesiredGroupByPlayerName[Raider.name];

        -- Make sure the player is stripped of his maintank/mainassist role
        if (App:inArray({"MAINTANK", "MAINASSIST"}, Raider.role or "")) then
            tinsert(Migrations, {"stripRole", Raider.role, Raider.name});
        end

        if (raidersDesiredGroup
            and type(raidersDesiredGroup) == "number"
            and raidersCurrentGroup ~= raidersDesiredGroup
        ) then
            -- The raider's desired group is not full yet so we can just move him
            if (NumRaidersInGroup[raidersDesiredGroup] < MEMBERS_PER_RAID_GROUP) then
                App:debug(string.format(
                    "%s is currently wants to be in group %s which is not full yet, so move him",
                    Raider.name,
                    raidersDesiredGroup
                ));

                tinsert(Migrations, {"set", Raider.name, raidersDesiredGroup});

                NumRaidersInGroup[raidersCurrentGroup] = NumRaidersInGroup[raidersCurrentGroup] - 1;
                NumRaidersInGroup[raidersDesiredGroup] = NumRaidersInGroup[raidersDesiredGroup] + 1;
            else -- The group is full which means someone doesn't belong... SWAP!
                local MisplacedTeammate = false;
                for TeamMateName in pairs(RaidersPerGroup[raidersDesiredGroup]) do
                    local TeamMate = RaidMembers[TeamMateName];
                    local teamMatesDesiredGroup = DesiredGroupByPlayerName[TeamMate.name];

                    if (teamMatesDesiredGroup ~= TeamMate.subgroup) then
                        App:debug(string.format(
                            "%s is currently in group %s but wants to be in group %s so we can switch",
                            TeamMate.name,
                            TeamMate.subgroup,
                            DesiredGroupByPlayerName[TeamMate.name]
                        ));

                        MisplacedTeammate = TeamMate;

                        -- This is a match made in heaven: the teammate wants to be in my group and I in his
                        if (teamMatesDesiredGroup == raidersDesiredGroup) then
                            break;
                        end
                    end
                end

                -- If there's noone in the group who doesn't belong then the user is
                -- most likely tring to cram more than 5 people into 1 group
                if (not MisplacedTeammate) then
                    return App:warning(string.format(
                        "Can't find a place for %s, are you trying to put more than 5 people in 1 group?",
                        Raider.name
                    ));
                end

                tinsert(Migrations, {"swap", Raider.name, MisplacedTeammate.name});

                MisplacedTeammate.subgroup = raidersCurrentGroup;

                RaidersPerGroup[raidersDesiredGroup][MisplacedTeammate.name] = nil;
                RaidersPerGroup[raidersCurrentGroup][MisplacedTeammate.name] = MisplacedTeammate;
            end

            Raider.subgroup = raidersDesiredGroup;
            RaidersPerGroup[raidersDesiredGroup][Raider.name] = Raider;
            RaidersPerGroup[raidersCurrentGroup][Raider.name] = nil;
        end
    end

    local migrationCount = #Migrations;

    -- Move players
    if (migrationCount > 0) then
        self.migrationInProgress = true;
        self:processMigrations(Migrations, migrationCount, 1);
        self.MainTanksByPlayerName = MainTanksByPlayerName;
    end
end

-- Move people recursively based on a list of migrations. The reason
-- we do this is because it turns out that the client (or server?) starts
-- throttling SetRaidSubgroup/GetRaidRosterInfo when there's too many
-- in rapid succession. The raider index also changes after moving a player
-- which is why we have to keep fetching the current index all the time
function RaidGroups:processMigrations(Migrations, numberOfMigrations, index)

    local Migration = Migrations[index];
    local action = Migration[1];

    if (action == "stripRole") then
        local role = Migration[2];
        local playerName = Migration[3];

        ClearPartyAssignment(role, playerName);
    elseif (action == "set") then
        local name = Migration[2];
        local desiredGroup = Migration[3];
        local leftIndex = 0;

        for index = 1, MAX_RAID_MEMBERS do
            local nameOnIndex = GetRaidRosterInfo(index);

            if (name == nameOnIndex) then
                leftIndex = index;
                break;
            end
        end

        if (not leftIndex) then
            return App:warning(string.format("Something went wrong while moving %s", playerName));
        end

        -- Move the player to his desired group
        SetRaidSubgroup(leftIndex, desiredGroup);
    elseif (action == "swap") then
        local leftName = Migration[2];
        local rightName = Migration[3];
        local leftIndex = 0;
        local rightIndex = 0;

        for index = 1, MAX_RAID_MEMBERS do
            local nameOnIndex = GetRaidRosterInfo(index);

            if (leftName == nameOnIndex) then
                leftIndex = index;
            elseif (rightName == nameOnIndex) then
                rightIndex = index;
            end

            if (leftIndex > 0 and rightIndex > 0) then
                break;
            end
        end

        -- Swap the two given players
        SwapRaidSubgroup(leftIndex, rightIndex);
    end

    if (index < numberOfMigrations) then
        local nextIndex = index + 1;

        C_Timer.After(.5, function()
            RaidGroups:processMigrations(Migrations, numberOfMigrations, nextIndex);
        end);
    else
        C_Timer.After(2, function()
            self.migrationInProgress = false;
        end);
    end
end

App:debug("RaidGroups.lua");