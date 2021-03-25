--[[
    This class allows us to quickly change
    raid group compositions via a predefined csv format
]]

local _, App = ...;

App.RaidGroups = App.RaidGroups or {
    UIComponents = {},
    rosterString = "",
    migrationInProgress = false,
    raidGroupsWindowIsActive = false,
    UIComponents = {
        Frame = nil,
        TankAssignmentButton = nil,
    },
};

App.Ace.GUI = App.Ace.GUI or LibStub("AceGUI-3.0");

local Utils = App.Utils;
local AceGUI = App.Ace.GUI;
local RaidGroups = App.RaidGroups;

-- Output everyone currently in the group in a CSV format
function RaidGroups:toCSV()
    Utils:debug("RaidGroups:toCSV");

    local raidMembers = {};

    if (not App.User.isInGroup) then
        return Utils:warning("You're not currently in a raid");
    end

    local csv = "";
    for _, Player in pairs(App.User:groupMembers()) do
        csv = csv .. Player.name .. ",";
    end

    Utils:frameMessage(string.sub("csv", 1, -2));
end

-- Draw the ui that allows us to import/write a raid roster
function RaidGroups:drawImporter()
    Utils:debug("RaidGroups:drawImporter");

    -- Check to make sure the raid groups window isn't active already
    if (self.UIComponents.MainFrame
        and self.UIComponents.MainFrame:IsShown()
    ) then
        return;
    elseif (self.UIComponents.MainFrame) then
        return self.UIComponents.MainFrame:Show();
    end

    -- Create a container/parent frame
    local RaidGroupsFrame = AceGUI:Create("Frame");
    RaidGroupsFrame:SetTitle(App.name .. " v" .. App.version);
    RaidGroupsFrame:SetStatusText("Addon v" .. App.version);
    RaidGroupsFrame:SetLayout("Flow");
    RaidGroupsFrame:SetWidth(600);
    RaidGroupsFrame:SetHeight(450);
    RaidGroupsFrame.statustext:GetParent():Hide(); -- Hide the statustext bar
    RaidGroupsFrame:SetCallback("OnClose", function(widget)
        self.raidGroupsWindowIsActive = false;
    end);
    self.UIComponents.MainFrame = RaidGroupsFrame;

    -- LABEL: Explanation of the RaidGroups window
    local Explanation = AceGUI:Create("Label");
    Explanation:SetFullWidth(true);
    Explanation:SetText([[

Here you can quickly sort your groups based on premade rosters and can easily check whether someone is missing or shouldn't be in the current raid. The format in which you can provide groups is fairly straightforward: you put each group on seperate line, prefixed with the group number. Example:

|cff8aecff1:player1,player2,player3,player4,player5
2:player6,player7,player8,player9,player10|r

You can use group 9 ('9:') to define main tanks. Assigning main tanks automatically is not possible due to technical limitations, meaning you'll have to click the "Assign Tanks" button multiple times.

]]);
    RaidGroupsFrame:AddChild(Explanation);

    -- Edit box
    local RaidGroupsBoxContent = "";
    local RaidGroupsBox = AceGUI:Create("MultiLineEditBox");
    RaidGroupsBox:SetFullWidth(true);
    RaidGroupsBox:DisableButton(true);
    RaidGroupsBox:SetFocus();
    RaidGroupsBox:SetLabel("");
    RaidGroupsBox:SetText(RaidGroups.rosterString);
    RaidGroupsBox:SetNumLines(9);
    RaidGroupsBox:SetMaxLetters(999999999);
    RaidGroupsFrame:AddChild(RaidGroupsBox);

    RaidGroupsBox:SetCallback("OnTextChanged", function(_, _, text)
        RaidGroups.rosterString = text;
    end)

    local CheckAttendanceOutput = AceGUI:Create("Label");
    CheckAttendanceOutput:SetFullWidth(true);
    CheckAttendanceOutput:SetHeight(300);
    CheckAttendanceOutput:SetText("");
    RaidGroupsFrame:AddChild(CheckAttendanceOutput);

    local Spacer = AceGUI:Create("SimpleGroup");
    Spacer:SetLayout("Flow");
    Spacer:SetWidth(1);
    Spacer:SetHeight(95);
    RaidGroupsFrame:AddChild(Spacer);

    --[[
        FOOTER BUTTON PARENT FRAME
    ]]
    local FooterFrame = AceGUI:Create("SimpleGroup");
    FooterFrame:SetLayout("Flow");
    FooterFrame:SetFullWidth(true);
    FooterFrame:SetHeight(50);
    RaidGroupsFrame:AddChild(FooterFrame);

    local AttendanceCheckButton = AceGUI:Create("Button");
    AttendanceCheckButton:SetText("Check Attendance");
    AttendanceCheckButton:SetWidth(140);
    AttendanceCheckButton:SetCallback("OnClick", function()
        self:checkAttendance(RaidGroups.rosterString, CheckAttendanceOutput);
    end);
    FooterFrame:AddChild(AttendanceCheckButton);

    local SaveButton = AceGUI:Create("Button");
    SaveButton:SetText("Apply");
    SaveButton:SetWidth(80);
    SaveButton:SetCallback("OnClick", function()
        self:applyRaidGroups(RaidGroups.rosterString);
    end);
    FooterFrame:AddChild(SaveButton);

    Spacer = AceGUI:Create("SimpleGroup");
    Spacer:SetLayout("Flow");
    Spacer:SetWidth(120);
    Spacer:SetHeight(1);
    FooterFrame:AddChild(Spacer);

    local SetTanksButton = CreateFrame("Button", nil, RaidGroupsFrame.frame, "SecureActionButtonTemplate, GameMenuButtonTemplate");
    SetTanksButton:SetAttribute("type", "macro");
    SetTanksButton:SetSize(120, 24);
    SetTanksButton:SetText("Assign Tanks");
    SetTanksButton:SetNormalFontObject("GameFontNormal");
    SetTanksButton:SetHighlightFontObject("GameFontNormal");
    SetTanksButton:SetPoint("TOPLEFT", SaveButton.frame, "TOPRIGHT", 10);
    SetTanksButton:SetScript("PreClick", function ()
        self:updateTankAssignmentButton();
    end);

    self.UIComponents.TankAssignmentButton = SetTanksButton;
end

-- Check if everyone's in the raid or if the raid contains players who shouldn't be there
function RaidGroups:checkAttendance(raidGroupCsv, OutPutLabel)
    Utils:debug("RaidGroups:checkAttendance");

    if (not App.User.isInRaid) then
        return Utils:warning("You need to be in a raid!");
    end

    local PlayersOnRoster = {};
    local MissingPlayers = {};
    local UnknownPlayers = {};

    for line in raidGroupCsv:gmatch("[^\n]+") do
        local Segments = Utils:strSplit(line, ":");
        local group = tonumber(Segments[1]);

        if (not group
            or type(group) ~= "number"
            or group < 1
            or group > 9
        ) then
            return Utils:warning("Invalid raid groups provided!");
        end

        local Players = Utils:strSplit(Segments[2], ",");

        for _, playerName in pairs(Players) do
            if (group < 9) then
                PlayersOnRoster[playerName] = true;
            end
        end
    end

    -- Check who's in the raid who doesn't belong
    local PlayersInRaid = {};
    for _, Player in pairs(App.User:groupMembers()) do
        PlayersInRaid[Player.name] = true;

        if (not PlayersOnRoster[Player.name]) then
            tinsert(UnknownPlayers, Player.name);
        end
    end

    -- Check who's missing
    for playerName in pairs(PlayersOnRoster) do
        if (not PlayersInRaid[playerName]) then
            tinsert(MissingPlayers, playerName);
        end
    end

    OutPutLabel:SetText(string.format([[
The following people are missing from the raid:
|c00be3333%s|r

The following people are in the raid but shouldn't be:
|c00f7922e%s|r
]],
    table.concat(MissingPlayers, ", "),
    table.concat(UnknownPlayers, ", ")
    ));
    OutPutLabel:SetFullWidth(false);
    OutPutLabel:SetWidth(500);
end

-- Build a list of migrations based on the csv provided by the user
function RaidGroups:applyRaidGroups(raidGroupCsv)
    Utils:debug("RaidGroups:applyRaidGroups");

    if (not App.User.isInRaid) then
        return Utils:warning("You need to be in a raid!");
    end

    if (not App.User.hasAssist) then
        return Utils:warning("You need to have a lead or assist role!");
    end

    if (self.migrationInProgress) then
        return Utils:warning("There's a migration still in progress, wait a bit!");
    end

    local Tanks = {};
    local DesiredGroupByPlayerName = {};
    local PlayersOnTheRoster = {};

    for line in raidGroupCsv:gmatch("[^\n]+") do
        local Segments = Utils:strSplit(line, ":");
        local group = tonumber(Segments[1]);

        if (not group
            or type(group) ~= "number"
            or group < 1
            or group > 9
        ) then
            return Utils:warning("Invalid raid groups provided!");
        end

        local Players = Utils:strSplit(Segments[2], ",");

        for _, playerName in pairs(Players) do
            -- group 9 is a group we reserve for specifiying the tanks
            if (group < 9) then
                -- We can't process the same name twice!
                if (PlayersOnTheRoster[playerName]) then
                    return Utils:warning(string.format("%s is listed twice on the roster!", playerName));
                end

                DesiredGroupByPlayerName[playerName] = group;
                PlayersOnTheRoster[playerName] = true;
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
            return Utils:warning(string.format("Can't sort groups while %s is in combat!", Raider.name));
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
        return Utils:warning(string.format(
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
        if (Utils:inArray({"MAINTANK", "MAINASSIST"}, Raider.role or "")) then
            tinsert(Migrations, {"stripRole", Raider.role, Raider.name});
        end

        if (raidersDesiredGroup
            and type(raidersDesiredGroup) == "number"
            and raidersCurrentGroup ~= raidersDesiredGroup
        ) then
            -- The raider's desired group is not full yet so we can just move him
            if (NumRaidersInGroup[raidersDesiredGroup] < MEMBERS_PER_RAID_GROUP) then
                Utils:debug(string.format(
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
                        Utils:debug(string.format(
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
                    return Utils:warning(string.format(
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
        Utils:message("Applying raid roster");
        self.migrationInProgress = true;
        self:processMigrations(Migrations, migrationCount, 1);
    end
end

-- Assigning tanks programmatically requires the use of a "SecureActionButton" which
-- allows you to assign the main tank role to a maximum of 2 to 3 people depending
-- on certain circumstances that I'm not fully aware of, requiring multiple clicks by the player
function RaidGroups:updateTankAssignmentButton()
    Utils:debug("RaidGroups:updateTankAssignmentButton");

    if (not self.rosterString
        or type(self.rosterString) ~= "string"
        or self.rosterString == ""
    ) then
        return Utils:warning("No roster defined");
    end

    local Tanks = {};
    for line in self.rosterString:gmatch("[^\n]+") do
        local Segments = Utils:strSplit(line, ":");
        local group = tonumber(Segments[1]);

        if (group
            and type(group) == "number"
            and group == 9
        ) then
            local Players = Utils:strSplit(Segments[2], ",");

            for _, playerName in pairs(Players) do
                tinsert(Tanks, playerName);
            end

            break;
        end
    end

    local Button = self.UIComponents.TankAssignmentButton;

    -- No point in doing anything if there are no tanks
    if (not Tanks) then
        return Utils:message("No tanks defined");
    end

    -- Players who are currently assigned as main tank
    local MainTankIndexes = { GetPartyAssignment("MAINTANK") };
    local MainTanksByName = {};

    for _, index in pairs(MainTankIndexes) do
        local name = GetRaidRosterInfo(index);

        if (name) then
            MainTanksByName[name] = true;
        end
    end

    local macros = "";
    for _, tankName in pairs(Tanks) do
        if (not MainTanksByName[tankName]) then
            macros = string.format("%s/mt %s\n", macros, tankName);
        end
    end

    if (macros and macros ~= "") then
        Button:SetAttribute("macrotext", macros);
    else
        Utils:success("All tanks are assigned");
    end
end

-- Move people recursively based on a list of migrations. The reason
-- we do this is because it turns out that the client (or server?) starts
-- throttling SetRaidSubgroup/GetRaidRosterInfo when there's too many
-- in rapid succession. The raider index also changes after moving a player
-- which is why we have to keep fetching the current index all the time
function RaidGroups:processMigrations(Migrations, numberOfMigrations, index)
    Utils:debug("RaidGroups:processMigrations");

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
            return Utils:warning(string.format("Something went wrong while moving %s", playerName));
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

        App.Ace:ScheduleTimer(function ()
            RaidGroups:processMigrations(Migrations, numberOfMigrations, nextIndex);
        end, .5);
    else
        App.Ace:ScheduleTimer(function ()
            self.migrationInProgress = false;
            Utils:success("Finished applying raid roster");
        end, 2);
    end
end

Utils:debug("RaidGroups.lua");