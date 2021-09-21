--[[
    This class allows us to quickly change
    raid group compositions via a predefined csv format
]]

local _, GL = ...;

GL.RaidGroups = GL.RaidGroups or {
    isVisible = false,
    rosterString = "",
    migrationInProgress = false,
    raidGroupsWindowIsActive = false,
    UIComponents = {
        Frame = nil,
        TankAssignmentButton = nil,
    },
};

GL.AceGUI = GL.AceGUI or LibStub("AceGUI-3.0");

local AceGUI = GL.AceGUI;
local RaidGroups = GL.RaidGroups;

--- Output everyone currently in the group in a CSV format
---
---@return void
function RaidGroups:toCSV()
    GL:debug("RaidGroups:toCSV");

    if (not GL.User.isInGroup) then
        return GL:warning("You're not currently in a raid");
    end

    local csv = "";
    for _, Player in pairs(GL.User:groupMembers()) do
        csv = csv .. Player.name .. ",";
    end

    GL:frameMessage(string.sub(csv, 1, -2));
end

--- Draw the ui that allows us to import/write a raid roster
function RaidGroups:drawImporter()
    GL:debug("RaidGroups:drawImporter");

    -- Check to make sure the raid groups window isn't active already
    if (self.isVisible) then
        return;
    end

    self.isVisible = true;
    local Spacer;

    -- Create a container/parent frame
    local Window = AceGUI:Create("Frame");
    Window:SetTitle("Gargul v" .. GL.version);
    Window:SetStatusText("Addon v" .. GL.version);
    Window:SetLayout("Flow");
    Window:EnableResize(false);
    Window:SetWidth(600);
    Window:SetHeight(450);
    Window.statustext:GetParent():Hide(); -- Hide the statustext bar
    Window:SetCallback("OnClose", function()
        self:close();
    end);
    GL.Interface:setItem(self, "Window", Window);

    -- First part of explanation
    local Explanation = AceGUI:Create("Label");
    Explanation:SetFullWidth(true);
    Explanation:SetText("In the large edit box below you can provide a roster and: invite everyone, check who's missing, apply groups and assign the tanks.\n\nDown below you can provide a Wowhead raid composition link:");
    Window:AddChild(Explanation);

    Spacer = AceGUI:Create("SimpleGroup");
    Spacer:SetLayout("Flow");
    Spacer:SetFullWidth(true);
    Spacer:SetHeight(8);
    Window:AddChild(Spacer);

    -- Wowhead URL
    local WowheadURL = AceGUI:Create("EditBox");
    WowheadURL:SetFullWidth(true);
    WowheadURL:DisableButton(true);
    WowheadURL:SetText("https://tbc.wowhead.com/raid-composition");
    Window:AddChild(WowheadURL);

    Spacer = AceGUI:Create("SimpleGroup");
    Spacer:SetLayout("Flow");
    Spacer:SetFullWidth(true);
    Spacer:SetHeight(8);
    Window:AddChild(Spacer);

    -- Second part of explanation
    Explanation = AceGUI:Create("Label");
    Explanation:SetFullWidth(true);
    Explanation:SetText("Or a Gargul group composition CSV:");
    Window:AddChild(Explanation);

    Spacer = AceGUI:Create("SimpleGroup");
    Spacer:SetLayout("Flow");
    Spacer:SetFullWidth(true);
    Spacer:SetHeight(8);
    Window:AddChild(Spacer);

    -- Wiki URL
    local WikiURL = AceGUI:Create("EditBox");
    WikiURL:SetFullWidth(true);
    WikiURL:DisableButton(true);
    WikiURL:SetText("https://github.com/papa-smurf/Gargul/wiki/Sort-Groups-&-Tanks");
    Window:AddChild(WikiURL);

    -- Edit box
    local RaidGroupsBox = AceGUI:Create("MultiLineEditBox");
    RaidGroupsBox:SetFullWidth(true);
    RaidGroupsBox:DisableButton(true);
    RaidGroupsBox:SetFocus();
    RaidGroupsBox:SetLabel("");
    RaidGroupsBox:SetText(RaidGroups.rosterString);
    RaidGroupsBox:SetNumLines(10);
    RaidGroupsBox:SetMaxLetters(999999999);
    Window:AddChild(RaidGroupsBox);

    RaidGroupsBox:SetCallback("OnTextChanged", function(EditBox, _, text)
        RaidGroups.rosterString = self:normalizeInput(EditBox, text);
    end)

    local OutputFrame = AceGUI:Create("SimpleGroup");
    OutputFrame:SetLayout("FILL");
    OutputFrame:SetFullWidth(true);
    OutputFrame:SetHeight(78);
    Window:AddChild(OutputFrame);

    local CheckAttendanceOutput = AceGUI:Create("Label");
    CheckAttendanceOutput:SetFullWidth(true);
    CheckAttendanceOutput:SetText("");
    OutputFrame:AddChild(CheckAttendanceOutput);

    --[[
        FOOTER BUTTON PARENT FRAME
    ]]
    local FooterFrame = AceGUI:Create("SimpleGroup");
    FooterFrame:SetLayout("Flow");
    FooterFrame:SetWidth(340);
    FooterFrame:SetHeight(30);
    Window:AddChild(FooterFrame);

    local InviteButton = AceGUI:Create("Button");
    InviteButton:SetText("Invite");
    InviteButton:SetWidth(76);
    InviteButton:SetCallback("OnClick", function()
        self:invitePlayers(RaidGroups.rosterString);
    end);
    FooterFrame:AddChild(InviteButton);

    local AttendanceCheckButton = AceGUI:Create("Button");
    AttendanceCheckButton:SetText("Who's Missing");
    AttendanceCheckButton:SetWidth(128);
    AttendanceCheckButton:SetCallback("OnClick", function()
        self:checkAttendance(RaidGroups.rosterString, CheckAttendanceOutput);
    end);
    FooterFrame:AddChild(AttendanceCheckButton);

    local SaveButton = AceGUI:Create("Button");
    SaveButton:SetText("Apply Groups");
    SaveButton:SetWidth(126);
    SaveButton:SetCallback("OnClick", function()
        self:applyRaidGroups(RaidGroups.rosterString);
    end);
    FooterFrame:AddChild(SaveButton);

    local SetTanksButton = CreateFrame("Button", nil, Window.frame, "SecureActionButtonTemplate, GameMenuButtonTemplate");
    SetTanksButton:SetAttribute("type", "macro");
    SetTanksButton:SetSize(112, 24);
    SetTanksButton:SetText("Assign Tanks");
    SetTanksButton:SetNormalFontObject("GameFontNormal");
    SetTanksButton:SetHighlightFontObject("GameFontNormal");
    SetTanksButton:SetPoint("TOPLEFT", SaveButton.frame, "TOPRIGHT", 10);
    SetTanksButton:SetScript("PreClick", function ()
        self:updateTankAssignmentButton();
    end);

    self.UIComponents.TankAssignmentButton = SetTanksButton;
end

---@return void
function RaidGroups:close()
    GL:debug("RaidGroups:close");

    self.isVisible = false;

    local Window = GL.Interface:getItem(self, "Window");
    if (Window) then
        -- Store the frame's last position for future play sessions
        GL.Interface:storePosition(Window, "RollOff");
        Window:Hide();
    end
end

--- A user can provide either a Gargul group CSV or a wowhead URL, but need to be normalized to the same CSV format
--- Example wowhead link: https://tbc.wowhead.com/raid-composition#0xr000g;Zhorax;Gargul;;;;SomeWarrior
---
---@param EditBox table
---@param input string
---@return string
function RaidGroups:normalizeInput(EditBox, input)
    -- A CSV was provided, or at least something that's not a wowhead url
    if (not GL:strContains(input, "wowhead.com/raid%-composition")) then -- Escape of - is required!
        return input;
    end

    --[[ A WOWHEAD LINK WAS PROVIDED, TRANSFORM IT TO OUR FORMAT ]]
    local firstSemicolonPosition = strfind(input, ";");
    local firstHashtagPosition = strfind(input, "#");

    if (not firstSemicolonPosition
        or not firstHashtagPosition
    ) then
        return "";
    end

    -- A helper function to transform a wowhead spec hash into a spec index (see https://wow.tools/dbc/?dbc=talenttab&build=2.5.2.40260#page=1)
    local function specHashToSpec(specHash)
        local wowheadSpecIndexes = {0,41,61,81,161,163,164,181,182,183,201,202,203,261,262,263,281,282,283,301,302,303,361,362,363,381,382,383};
        local wowheadSpecHashes = "0bcdfghjkmnpqrstvwxyzBCDFGHJKLMNPQRSTVWXYZ123456789";
        local hashPosition = strfind(wowheadSpecHashes, specHash);

        if (not hashPosition) then
            return 0;
        end

        return wowheadSpecIndexes[hashPosition] or 0;
    end

    -- IDs of specs we consider to be tanks
    local TankSpecs = {
        163, -- Prot Warrior
        281, -- Feral
        383, -- Prot Pally
    }

    local urlLength = GL:count(input);
    local raiderString = GL:urlDecode(strsub(input, firstSemicolonPosition + 1));
    local specString = strsub(
        input,
        firstHashtagPosition + 2, -- 2 because we want to skip the leading zero
        urlLength - firstHashtagPosition - (urlLength - firstSemicolonPosition - firstHashtagPosition) - 1 -- Quick math
    );
    local Specs = GL:strSplit(specString);
    local Members = GL:strSplit(raiderString, ";");
    local Groups = {{}, {}, {}, {}, {}, {}, {}, {}, {}}; -- 9 groups, 9th is reserved for tank assignments
    local membersProcessed = 0;
    local currentGroupNumber = 1;

    -- How can there be more than 40? Trick question: there can't be. YEET
    if (GL:count(Members) > MAX_RAID_MEMBERS) then
        return "";
    end

    for _, member in pairs(Members) do
        membersProcessed = membersProcessed + 1;

        -- Add the member to its group
        tinsert(Groups[currentGroupNumber], member);

        -- If the member's spec is concerned "tank" we add it to the tank group as well
        local spec = specHashToSpec(Specs[membersProcessed] or 0);
        if (GL:inTable(TankSpecs, spec)) then
            tinsert(Groups[9], member); -- 9 is reserved for tanking assignments, see wiki for more info
        end

        -- Our current group has 5 members in it, switch to the next group
        if (math.fmod(membersProcessed, 5) == 0) then
            currentGroupNumber = currentGroupNumber + 1;
        end
    end

    -- Transform the Groups table to the default Gargul group CSV format
    input = "";
    for group, GroupMembers in pairs(Groups) do
        if (group > 1) then
            input = input .. "\n";
        end

        input = input .. group .. ":";
        input = input .. table.concat(GroupMembers, ",");
    end

    -- Update the editbox with the new format
    EditBox:SetText(input);

    return input;
end

--- Attempt to invite everyone who's on the roster
---
---@return void
function RaidGroups:invitePlayers(raidGroupCsv)
    for line in raidGroupCsv:gmatch("[^\n]+") do
        local Segments = GL:strSplit(line, ":");
        local group = tonumber(Segments[1]);

        if (not group
            or type(group) ~= "number"
            or group < 1
            or group > 9
        ) then
            return GL:warning("Invalid raid groups provided!");
        end

        local Players = GL:strSplit(Segments[2], ",");

        for _, playerName in pairs(Players) do
            if (group < 9 -- group 9 is a group we reserve for specifiying the tanks
                and not GL:empty(playerName) -- Make sure we skip empty names
                and playerName ~= GL.User.name -- No need to invite ourselves
            ) then
                InviteUnit(playerName); -- Attempt to invite the player
            end
        end
    end
end

-- Check if everyone's in the raid or if the raid contains players who shouldn't be there
function RaidGroups:checkAttendance(raidGroupCsv, OutPutLabel)
    GL:debug("RaidGroups:checkAttendance");

    if (not GL.User.isInRaid) then
        return GL:warning("You need to be in a raid!");
    end

    if (GL:empty(raidGroupCsv)) then
        return GL:warning("Invalid group format provided!");
    end

    local PlayersOnRoster = {};
    local MissingPlayers = {};
    local UnknownPlayers = {};

    for line in raidGroupCsv:gmatch("[^\n]+") do
        local Segments = GL:strSplit(line, ":");
        local group = tonumber(Segments[1]);

        if (not group
            or type(group) ~= "number"
            or group < 1
            or group > 9
        ) then
            return GL:warning("Invalid raid groups provided!");
        end

        local Players = GL:strSplit(Segments[2], ",");

        for _, playerName in pairs(Players) do
            if (group < 9 -- group 9 is a group we reserve for specifiying the tanks
                and not GL:empty(playerName) -- Make sure we skip empty names
            ) then
                PlayersOnRoster[playerName] = true;
            end
        end
    end

    -- Check who's in the raid who doesn't belong
    local PlayersInRaid = {};
    for _, Player in pairs(GL.User:groupMembers()) do
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
The following people are missing in the raid:
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
    GL:debug("RaidGroups:applyRaidGroups");

    if (not GL.User.isInRaid) then
        return GL:warning("You need to be in a raid!");
    end

    if (not GL.User.hasAssist) then
        return GL:warning("You need to have a lead or assist role!");
    end

    if (self.migrationInProgress) then
        return GL:warning("There's a migration still in progress, wait a bit!");
    end

    local DesiredGroupByPlayerName = {};
    local PlayersOnTheRoster = {};

    for line in raidGroupCsv:gmatch("[^\n]+") do
        local Segments = GL:strSplit(line, ":");
        local group = tonumber(Segments[1]);

        if (not group
            or type(group) ~= "number"
            or group < 1
            or group > 9
        ) then
            return GL:warning("Invalid raid groups provided!");
        end

        local Players = GL:strSplit(Segments[2], ",");

        for _, playerName in pairs(Players) do
            if (group < 9 -- group 9 is a group we reserve for specifiying the tanks
                and not GL:empty(playerName) -- Make sure we skip empty names
            ) then
                -- We can't process the same name twice!
                if (PlayersOnTheRoster[playerName]) then
                    return GL:warning(string.format("%s is listed twice on the roster!", playerName));
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
    for _, Raider in pairs(GL.User:groupMembers()) do
        if (UnitAffectingCombat("raid" .. Raider.index)) then
            return GL:warning(string.format("Can't sort groups while %s is in combat!", Raider.name));
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
        return GL:warning(string.format(
            "The following players are not part of the roster: %s",
            table.concat(UnwantedPlayers, ", ")
        ));
    end

    local Migrations = {};
    for key in pairs(RaidMembers) do
        local Raider = RaidMembers[key];
        local raidersCurrentGroup = Raider.subgroup;
        local raidersDesiredGroup = DesiredGroupByPlayerName[Raider.name];

        -- Make sure the player is stripped of his maintank/mainassist role
        if (GL:inTable({"MAINTANK", "MAINASSIST"}, Raider.role or "")) then
            tinsert(Migrations, {"stripRole", Raider.role, Raider.name});
        end

        if (raidersDesiredGroup
            and type(raidersDesiredGroup) == "number"
            and raidersCurrentGroup ~= raidersDesiredGroup
        ) then
            -- The raider's desired group is not full yet so we can just move him
            if (NumRaidersInGroup[raidersDesiredGroup] < _G.MEMBERS_PER_RAID_GROUP) then
                GL:debug(string.format(
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
                        GL:debug(string.format(
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
                    return GL:warning(string.format(
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
        GL:message("Applying raid roster");
        self.migrationInProgress = true;
        self:processMigrations(Migrations, migrationCount, 1);
    end
end

-- Assigning tanks programmatically requires the use of a "SecureActionButton" which
-- allows you to assign the main tank role to a maximum of 2 to 3 people depending
-- on certain circumstances that I'm not fully aware of, requiring multiple clicks by the player
function RaidGroups:updateTankAssignmentButton()
    GL:debug("RaidGroups:updateTankAssignmentButton");

    if (not self.rosterString
        or type(self.rosterString) ~= "string"
        or self.rosterString == ""
    ) then
        return GL:warning("No roster defined");
    end

    local Tanks = {};
    for line in self.rosterString:gmatch("[^\n]+") do
        local Segments = GL:strSplit(line, ":");
        local group = tonumber(Segments[1]);

        if (group
            and type(group) == "number"
            and group == 9
        ) then
            local Players = GL:strSplit(Segments[2], ",");

            for _, playerName in pairs(Players) do
                tinsert(Tanks, playerName);
            end

            break;
        end
    end

    local Button = self.UIComponents.TankAssignmentButton;

    -- No point in doing anything if there are no tanks
    if (not Tanks) then
        return GL:message("No tanks defined");
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
        GL:success("All tanks are assigned");
    end
end

-- Move people recursively based on a list of migrations. The reason
-- we do this is because it turns out that the client (or server?) starts
-- throttling SetRaidSubgroup/GetRaidRosterInfo when there's too many
-- in rapid succession. The raider index also changes after moving a player
-- which is why we have to keep fetching the current index all the time
function RaidGroups:processMigrations(Migrations, numberOfMigrations, index)
    GL:debug("RaidGroups:processMigrations");

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

        for index = 1, _G.MAX_RAID_MEMBERS do
            local nameOnIndex = GetRaidRosterInfo(index);

            if (name == nameOnIndex) then
                leftIndex = index;
                break;
            end
        end

        if (not leftIndex) then
            return GL:warning(string.format("Something went wrong while moving %s", playerName));
        end

        -- Move the player to his desired group
        SetRaidSubgroup(leftIndex, desiredGroup);
    elseif (action == "swap") then
        local leftName = Migration[2];
        local rightName = Migration[3];
        local leftIndex = 0;
        local rightIndex = 0;

        for index = 1, _G.MAX_RAID_MEMBERS do
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

        GL.Ace:ScheduleTimer(function ()
            RaidGroups:processMigrations(Migrations, numberOfMigrations, nextIndex);
        end, .5);
    else
        GL.Ace:ScheduleTimer(function ()
            self.migrationInProgress = false;
            GL:success("Finished applying raid roster");
        end, 2);
    end
end

GL:debug("RaidGroups.lua");