local L = Gargul_L;

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
---@return nil
function RaidGroups:toCSV()
    local csv = "";
    for _, Player in pairs(GL.User:groupMembers()) do
        csv = csv .. Player.name .. ",";
    end

    GL:frameMessage(strsub(csv, 1, -2));
end

--- Draw the ui that allows us to import/write a raid roster
function RaidGroups:drawImporter()
    -- Check to make sure the raid groups window isn't active already
    if (self.isVisible) then
        return;
    end

    self.isVisible = true;
    local Spacer;

    -- Create a container/parent frame
    local Window = AceGUI:Create("Frame");
    Window:SetTitle((L["Gargul v%s"]):format(GL.version));
    Window:SetStatusText(L["v"] ..GL.version);
    Window:SetLayout("Flow");
    Window:EnableResize(false);
    Window:SetWidth(600);
    Window:SetHeight(500);
    Window.statustext:GetParent():Hide(); -- Hide the statustext bar
    Window:SetCallback("OnClose", function()
        self:close();
    end);
    GL.Interface:set(self, "Window", Window);

    -- Make sure the window can be closed by pressing the escape button
    _G["GARGUL_RAID_GROUP_WINDOW"] = Window.frame;
    tinsert(UISpecialFrames, "GARGUL_RAID_GROUP_WINDOW");

    -- First part of explanation
    local Explanation = AceGUI:Create("Label");
    Explanation:SetFullWidth(true);
    Explanation:SetText(L["\nIn the large edit box below you can provide a roster and: invite everyone, check who's missing, apply groups and assign the tanks.\n\nYou can provide a |c00FFF569Wowhead raid composition link:"]);
    Window:AddChild(Explanation);

    Spacer = AceGUI:Create("SimpleGroup");
    Spacer:SetLayout("Flow");
    Spacer:SetFullWidth(true);
    Spacer:SetHeight(8);
    Window:AddChild(Spacer);

    local wowheadSection = "";
    if (GL.isEra) then
        wowheadSection = "classic/";
    elseif (GL.isClassic) then
        wowheadSection = "wotlk/";
    end
    local wowheadURL = ("https://wowhead.com/%sraid-composition"):format(wowheadSection);

    -- Go to Wowhead
    local RaidGroupsBox;
    local WowheadButton = AceGUI:Create("Button");
    WowheadButton:SetText(L["Wowhead Comp Tool"]);
    WowheadButton:SetWidth(180);
    WowheadButton:SetCallback("OnClick", function()
        GL.Interface.Dialogs.HyperlinkDialog:open{
            description = L["You can visit the wowhead comp tool using the URL down below. After creating your comp you can paste it here or in the large edit field of the Gargul group window"],
            hyperlink = wowheadURL,
            OnConfirm = function (value)
                RaidGroupsBox:SetText(value);
                self:normalizeInput(RaidGroupsBox, RaidGroupsBox:GetText());

                return true;
            end,
            closeOnConfirm = true,
        };
    end);
    Window:AddChild(WowheadButton);

    Spacer = AceGUI:Create("SimpleGroup");
    Spacer:SetLayout("Flow");
    Spacer:SetFullWidth(true);
    Spacer:SetHeight(8);
    Window:AddChild(Spacer);

    -- Second part of explanation
    Explanation = AceGUI:Create("Label");
    Explanation:SetFullWidth(true);
    Explanation:SetText(L["a |c00FFF569Raid-Helper export (Use the 'Groups sorted vertically' variant) or a |c00FFF569Gargul group composition CSV:"]);
    Window:AddChild(Explanation);

    Spacer = AceGUI:Create("SimpleGroup");
    Spacer:SetLayout("Flow");
    Spacer:SetFullWidth(true);
    Spacer:SetHeight(8);
    Window:AddChild(Spacer);

    -- Go to Wiki
    local WikiButton = AceGUI:Create("Button");
    WikiButton:SetText(L["Gargul Group Wiki"]);
    WikiButton:SetWidth(180);
    WikiButton:SetCallback("OnClick", function()
        GL.Interface.Dialogs.HyperlinkDialog:open{
            description = L["Visit the Gargul group wiki for more info on the raid group format"],
            hyperlink = "https://github.com/papa-smurf/Gargul/wiki/Sort-Groups-&-Tanks",
        };
    end);
    Window:AddChild(WikiButton);

    self.rosterString = not GL:empty(self.rosterString) and self.rosterString or GL.DB:get("Utility.RaidGroupsString", "");

    -- Edit box
    RaidGroupsBox = AceGUI:Create("MultiLineEditBox");
    RaidGroupsBox:SetFullWidth(true);
    RaidGroupsBox:DisableButton(true);
    RaidGroupsBox:SetFocus();
    RaidGroupsBox:SetLabel("");
    RaidGroupsBox:SetText(self.rosterString);
    RaidGroupsBox:SetNumLines(10);
    RaidGroupsBox:SetMaxLetters(999999999);
    Window:AddChild(RaidGroupsBox);

    RaidGroupsBox:SetCallback("OnTextChanged", function(EditBox, _, text)
        local rosterString = self:normalizeInput(EditBox, text);
        GL.DB:set("Utility.RaidGroupsString", rosterString);
        self.rosterString = rosterString;
    end);

    local OutputFrame = AceGUI:Create("SimpleGroup");
    OutputFrame:SetLayout("FILL");
    OutputFrame:SetFullWidth(true);
    OutputFrame:SetHeight(78);
    Window:AddChild(OutputFrame);

    local CheckAttendanceOutput = AceGUI:Create("Label");
    CheckAttendanceOutput:SetFullWidth(true);
    CheckAttendanceOutput:SetText("\n\n\n\n\n\n\n ");
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
    InviteButton:SetText(L["Invite"]);
    InviteButton:SetWidth(76);
    InviteButton:SetCallback("OnClick", function()
        self:invitePlayers(RaidGroups.rosterString);
    end);
    FooterFrame:AddChild(InviteButton);
    GL.Interface:addTooltip(InviteButton, L["Send invites to players on roster"]);

    local AttendanceCheckButton = AceGUI:Create("Button");
    AttendanceCheckButton:SetText(L["Who's Missing"]);
    AttendanceCheckButton:SetWidth(128);
    AttendanceCheckButton:SetCallback("OnClick", function()
        self:checkAttendance(RaidGroups.rosterString, CheckAttendanceOutput);
    end);
    FooterFrame:AddChild(AttendanceCheckButton);
    GL.Interface:addTooltip(AttendanceCheckButton, L["Show missing player names"]);

    local SaveButton = AceGUI:Create("Button");
    SaveButton:SetText(L["Apply Groups"]);
    SaveButton:SetWidth(126);
    SaveButton:SetCallback("OnClick", function()
        self:applyRaidGroups(RaidGroups.rosterString);
    end);
    FooterFrame:AddChild(SaveButton);
    GL.Interface:addTooltip(SaveButton, L["Sort groups based on roster"]);

    local SetTanksButton = CreateFrame("Button", nil, Window.frame, "SecureActionButtonTemplate, GameMenuButtonTemplate");
    SetTanksButton:SetAttribute("type", "macro");
    SetTanksButton:SetSize(112, 24);
    SetTanksButton:SetText(L["Assign Tanks"]);
    SetTanksButton:SetNormalFontObject("GameFontNormal");
    SetTanksButton:SetHighlightFontObject("GameFontNormal");
    SetTanksButton:SetPoint("TOPLEFT", SaveButton.frame, "TOPRIGHT", 10);
    SetTanksButton:SetScript("PreClick", function ()
        self:updateTankAssignmentButton();
    end);

    local KickUnwantedButton = AceGUI:Create("Button");
    KickUnwantedButton:SetText(L["Kick unwanted players"]);
    KickUnwantedButton:SetWidth(170);
    KickUnwantedButton:SetCallback("OnClick", function()
        self:kickUnwanted(RaidGroups.rosterString);
    end);
    FooterFrame:AddChild(KickUnwantedButton);
    GL.Interface:addTooltip(KickUnwantedButton, L["Kick players that aren't on the roster"]);

    local DisbandButton = AceGUI:Create("Button");
    DisbandButton:SetText(L["Disband raid"]);
    DisbandButton:SetWidth(126);
    DisbandButton:SetCallback("OnClick", function()
        -- Show a confirmation dialog before disbanding the raid
        GL.Interface.Dialogs.PopupDialog:open{
            question = L["Are you sure?"],
            OnYes = function ()
                GL:forEachGroupMember(function (Member)
                    if (GL:iEquals(strlower(Member.name), GL.User.name)) then
                        return;
                    end

                    -- Kick the player!
                    UninviteUnit(GL:iEquals(Member.realm, GL.User.realm) and Member.name or Member.fqn);
                end);
            end
        };
    end);
    FooterFrame:AddChild(DisbandButton);
    GL.Interface:addTooltip(DisbandButton, L["Disband your raid"]);

    self.UIComponents.TankAssignmentButton = SetTanksButton;
end

---@return nil
function RaidGroups:close()
    self.isVisible = false;

    local Window = GL.Interface:get(self, "Window");
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
    if (GL:empty(input)) then
        return;
    end

    --- The user provided a wowhead URL
    if (GL:strContains(input, "/raid%-composition")) then -- Escape of - is required!
        input = self:normalizeWowheadInput(input);

    --- The user provided a non-Gargul format, most likely a raid helper export
    elseif (not GL:strContains(input, ":")) then
        input = self:normalizeRaidHelperInput(input);
    end

    -- Update the editbox with the new format
    EditBox:SetText(input);

    return input;
end

--- Transform the raid helper comp tool format to something Gargul can use
---
---@param input string
---@return string
function RaidGroups:normalizeRaidHelperInput(input)
    local playerDelimiter = " ";

    -- Determine the correct delimiter
    if (GL:strContains(input, ", ")) then
        playerDelimiter = ", ";
    elseif (GL:strContains(input, "; ")) then
        playerDelimiter = "; ";
    end

    local group = 1;
    local output = "";
    for line in input:gmatch("[^\n]+") do
        if (group > 8) then
            break;
        elseif (group > 1) then
            output = output .. "\n";
        end

        output = output .. group .. ":";

        local Players = GL:explode(line, playerDelimiter);

        local PlayerNames = {};
        for _, playerName in pairs(Players) do
            playerName = strtrim(playerName);

            if (playerName ~= "-") then
                tinsert(PlayerNames, playerName);
            end
        end

        output = output .. table.concat(PlayerNames, ",");
        group = group + 1;
    end

    return output;
end

--- Transform the wowhead raid comp format to something Gargul can use
---
---@param input string
---@return string
function RaidGroups:normalizeWowheadInput(input)
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
        local wowheadSpecIndexes = { 0, 41, 61, 81, 161, 163, 164, 181, 182, 183, 201, 202, 203, 261, 262, 263, 281, 282, 283, 301, 302, 303, 361, 362, 363, 381, 382, 383, };
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
    local Specs = GL:explode(specString);
    local Members = GL:explode(raiderString, ";");
    local Groups = {{}, {}, {}, {}, {}, {}, {}, {}, {}}; -- 9 groups, 9th is reserved for tank assignments
    local membersProcessed = 0;
    local currentGroupNumber = 1;

    for _, member in pairs(Members) do
        -- Everything past group 8 is considered "benched" in the comp tool
        if (currentGroupNumber >= 8) then
            break;
        end

        membersProcessed = membersProcessed + 1;

        if (type(member) == "string"
            and not GL:empty(member)
        ) then
            -- Add the member to its group
            tinsert(Groups[currentGroupNumber], member);

            -- If the member's spec is concerned "tank" we add it to the tank group as well
            local spec = specHashToSpec(Specs[membersProcessed] or 0);
            if (GL:inTable(TankSpecs, spec)) then
                tinsert(Groups[9], member); -- 9 is reserved for tanking assignments, see wiki for more info
            end
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

    return input;
end

---@param raidGroupCsv string
function RaidGroups:listPlayerNames(raidGroupCsv)
    local PlayerNames = {};
    for line in raidGroupCsv:gmatch("[^\n]+") do
        local Segments = GL:explode(line, ":");
        local group = tonumber(Segments[1]);

        if (not group
            or type(group) ~= "number"
            or group < 1
            or group > 9
        ) then
            return GL:warning(L["Invalid group data provided, check your format!"]);
        end

        local Players = GL:explode(Segments[2], ",");

        for _, playerName in pairs(Players) do
            if (group < 9 -- group 9 is a group we reserve for specifying the tanks
                and not GL:empty(playerName) -- Make sure we skip empty names
                and strlower(playerName) ~= strlower(GL.User.name) -- No need to invite ourselves
            ) then
                tinsert(PlayerNames, playerName);
            end
        end
    end

    return PlayerNames;
end

--- Attempt to invite everyone who's on the roster
---
---@return nil
function RaidGroups:invitePlayers(raidGroupCsv)
    for _, playerName in pairs(self:listPlayerNames(raidGroupCsv)) do
        GL.InviteUnit(playerName); -- Attempt to invite the player
    end
end

-- Check if everyone's in the raid or if the raid contains players who shouldn't be there
function RaidGroups:checkAttendance(raidGroupCsv, OutPutLabel)
    if (GL:empty(raidGroupCsv)) then
        return GL:warning(L["Invalid group data provided, check your format!"]);
    end

    local PlayersOnRoster = self:listPlayerNames(raidGroupCsv);
    local MissingPlayers = {};
    local UnknownPlayers = {};

    -- Check who's in the raid who doesn't belong
    local PlayersInRaid = {};
    for _, Player in pairs(GL.User:groupMembers()) do
        Player.name = strlower(Player.name);
        PlayersInRaid[Player.name] = true;

        if (not GL:iEquals(GL.User.name, Player.name)
            and not GL:inTable(PlayersOnRoster, Player.name)
        ) then
            tinsert(UnknownPlayers, Player.name);
        end
    end

    -- Check who's missing
    for _, playerName in pairs(PlayersOnRoster) do
        playerName = strlower(playerName);
        if (not PlayersInRaid[playerName]) then
            tinsert(MissingPlayers, GL:capitalize(playerName));
        end
    end

    OutPutLabel:SetText(([[
The following people are missing in the raid:
|c00be3333%s|r

The following people are in the raid but shouldn't be:
|c00f7922e%s|r
]]):format(
    table.concat(MissingPlayers, ", "),
    table.concat(UnknownPlayers, ", ")
    ));
    OutPutLabel:SetFullWidth(false);
    OutPutLabel:SetWidth(500);
end

--- Kick unwanted players from the raid
---
---@param raidGroupCsv string
function RaidGroups:kickUnwanted(raidGroupCsv)
    local WantedPlayers = self:listPlayerNames(raidGroupCsv);
    for key, name in pairs(WantedPlayers) do
        WantedPlayers[key] = strlower(name);
    end
    WantedPlayers = GL:tableFlip(WantedPlayers);

    GL:forEachGroupMember(function (Member)
        if (not GL:iEquals(strlower(Member.name), GL.User.name)
            and not WantedPlayers[strlower(Member.name)]
        ) then
            -- Kick the player!
            UninviteUnit(GL:iEquals(Member.realm, GL.User.realm) and Member.name or Member.fqn);
        end
    end);
end

--- Build a list of migrations based on the csv provided by the user
---
---@param raidGroupCsv string
---@return nil
function RaidGroups:applyRaidGroups(raidGroupCsv)
    if (not GL.User.isInRaid) then
        return GL:warning(L["You need to be in a raid!"]);
    end

    if (not GL.User.hasAssist) then
        return GL:warning(L["You need to be the master looter or have an assist / lead role!"]);
    end

    if (self.migrationInProgress) then
        return GL:warning(L["Sorting is still in progress, wait a bit!"]);
    end

    local DesiredGroupByPlayerName = {};
    local PlayersOnTheRoster = {};

    for line in raidGroupCsv:gmatch("[^\n]+") do
        local Segments = GL:explode(line, ":");
        local group = tonumber(Segments[1]);

        if (not group
            or type(group) ~= "number"
            or group < 1
            or group > 9
        ) then
            return GL:warning(L["Invalid group data provided, check your format!"]);
        end

        local Players = GL:explode(Segments[2], ",");

        for _, playerName in pairs(Players) do
            playerName = strlower(playerName);

            if (group < 9 -- group 9 is a group we reserve for specifying the tanks
                and not GL:empty(playerName) -- Make sure we skip empty names
            ) then
                -- We can't process the same name twice!
                if (PlayersOnTheRoster[playerName]) then
                    return GL:warning((L["%s is listed twice on the roster!"]):format(playerName));
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
        Raider.name = strlower(Raider.name);

        if (UnitAffectingCombat("raid" .. Raider.index)) then
            return GL:warning((L["Can't sort groups while %s is in combat!"]):format(GL:formatPlayerName(Raider.name, { colorize = true, })));
        end

        -- Check if there's people in the raid who are not on the roster
        if (not DesiredGroupByPlayerName[Raider.name]) then
            tinsert(UnwantedPlayers, Raider.name);
        end

        RaidMembers[Raider.name] = Raider;
        RaidersPerGroup[Raider.subgroup][Raider.name] = true;
        NumRaidersInGroup[Raider.subgroup] = NumRaidersInGroup[Raider.subgroup] + 1;
    end

    -- There are people in the raid who are not on the roster!
    if (UnwantedPlayers[1]) then
        -- We can't sort the groups if there's anyone in the raid who doesn't belong!
        return GL:warning((L["The following players are not part of the roster: %s"]):format(table.concat(UnwantedPlayers, " ")));
    end

    local Migrations = {};
    for key in pairs(RaidMembers) do
        local Raider = RaidMembers[key];
        local raidersCurrentGroup = Raider.subgroup;
        local raidersDesiredGroup = DesiredGroupByPlayerName[Raider.name];

        -- Make sure the player is stripped of his maintank/mainassist role
        if (GL:inTable({ "MAINTANK", "MAINASSIST" }, Raider.role or "")) then
            tinsert(Migrations, { "stripRole", Raider.role, Raider.name });
        end

        if (raidersDesiredGroup
            and type(raidersDesiredGroup) == "number"
            and raidersCurrentGroup ~= raidersDesiredGroup
        ) then
            -- The raider's desired group is not full yet so we can just move him
            if (NumRaidersInGroup[raidersDesiredGroup] < _G.MEMBERS_PER_RAID_GROUP) then
                GL:debug(("%s wants to be in group %s which is not full yet, so move him"):format(
                    Raider.name,
                    raidersDesiredGroup
                ));

                tinsert(Migrations, { "set", Raider.name, raidersDesiredGroup });

                NumRaidersInGroup[raidersCurrentGroup] = NumRaidersInGroup[raidersCurrentGroup] - 1;
                NumRaidersInGroup[raidersDesiredGroup] = NumRaidersInGroup[raidersDesiredGroup] + 1;
            else -- The group is full which means someone doesn't belong... SWAP!
                local MisplacedTeammate = false;
                for TeamMateName in pairs(RaidersPerGroup[raidersDesiredGroup]) do
                    local TeamMate = RaidMembers[TeamMateName];
                    local teamMatesDesiredGroup = DesiredGroupByPlayerName[TeamMate.name];

                    if (teamMatesDesiredGroup ~= TeamMate.subgroup) then
                        GL:debug(("%s is currently in group %s but wants to be in group %s so we can switch"):format(
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

                -- If there's no one in the group who doesn't belong then the user is
                -- most likely trying to cram more than 5 people into 1 group
                if (not MisplacedTeammate) then
                    return GL:warning((L["Can't find a place for %s, are you trying to put more than 5 people in 1 group?"]):format(Raider.name));
                end

                tinsert(Migrations, { "swap", Raider.name, MisplacedTeammate.name });

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
        GL:message(L["Sorting groups"]);
        self.migrationInProgress = true;
        self:processMigrations(Migrations, migrationCount, 1);
    end
end

-- Assigning tanks programmatically requires the use of a "SecureActionButton" which
-- allows you to assign the main tank role to a maximum of 2 to 3 people depending
-- on certain circumstances that I'm not fully aware of, requiring multiple clicks by the player
function RaidGroups:updateTankAssignmentButton()
    if (not self.rosterString
        or type(self.rosterString) ~= "string"
        or self.rosterString == ""
    ) then
        return GL:warning(L["Invalid group data provided, check your format!"]);
    end

    local Tanks = {};
    for line in self.rosterString:gmatch("[^\n]+") do
        local Segments = GL:explode(line, ":");
        local group = tonumber(Segments[1]);

        if (group
            and type(group) == "number"
            and group == 9
        ) then
            local Players = GL:explode(Segments[2], ",");

            for _, playerName in pairs(Players) do
                tinsert(Tanks, playerName);
            end

            break;
        end
    end

    local Button = self.UIComponents.TankAssignmentButton;

    -- No point in doing anything if there are no tanks
    if (not Tanks) then
        return GL:message(L["No tanks defined"]);
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
            macros = ("%s/mt %s\n"):format(macros, tankName);
        end
    end

    if (macros and macros ~= "") then
        Button:SetAttribute("macrotext", macros);
    else
        GL:success(L["All tanks are assigned"]);
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

        for index = 1, _G.MAX_RAID_MEMBERS do
            local nameOnIndex = GetRaidRosterInfo(index);

            if (GL:iEquals(name, nameOnIndex)
                or GL:iEquals(name, GL:disambiguateName(nameOnIndex))
            ) then
                leftIndex = index;
                break;
            end
        end

        if (not leftIndex) then
            return GL:warning((L["Something went wrong while moving %s"]):format(GL:formatPlayerName(name, { colorize = true, })));
        end

        -- Move the player to his desired group
        SetRaidSubgroup(leftIndex, desiredGroup);
    elseif (action == "swap") then
        local leftName = Migration[2];
        local rightName = Migration[3];
        local leftIndex = 0;
        local rightIndex = 0;

        for index = 1, _G.MAX_RAID_MEMBERS do
            local nameOnIndex = strlower(GetRaidRosterInfo(index));

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
            GL:success(L["Finished applying raid roster"]);
        end, 2);
    end
end
