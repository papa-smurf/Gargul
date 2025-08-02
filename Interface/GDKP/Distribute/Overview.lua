local L = Gargul_L;

---@type GL
local _, GL = ...;

local AceGUI = LibStub("AceGUI-3.0");

---@type Interface
local Interface = GL.Interface;

---@type Settings
local Settings = GL.Settings;

---@type Data
local Constants = GL.Data.Constants;

---@type Player
local Player = GL.Player;

---@type Events
local Events = GL.Events;

---@type GDKPSession
local GDKPSession = GL.GDKP.Session;

---@type GDKPPot
local GDKPPot = GL.GDKP.Pot;

Interface.GDKP.Distribute = Interface.GDKP.Distribute or {};

---@class GDKPDistribute
Interface.GDKP.Distribute.Overview = {
    isVisible = false,
    refreshing = false,
    openedViaOverview = false,
    sessionID = nil,

    MutatorActionButtons = {},
    RaiderActionButtons = {},
    CutHolders = {}, -- The labels that hold the actula cut values
    MutationFrame = nil,
    PotDistributionDetails = {},
};

---@type GDKPDistribute
local Overview = Interface.GDKP.Distribute.Overview;

---@return void
function Overview:open(sessionID, openedViaOverview)
    local Session = GDKPSession:byID(sessionID);
    if (not Session) then
        return;
    end

    self.openedViaOverview = openedViaOverview;

    local Window = Interface:get(self, "GDKPDistribute");
    if (not Window) then
        Window = self:build();
    end

    if (self.isVisible) then
        return;
    end

    self.sessionID = sessionID;
    self:refresh();
    self.isVisible = true;
    Window:Show();
end

---@return void
function Overview:build()
    ---@type AceGUIFrame
    local Window = Interface:get(self, "GDKPDistribute");

    -- Looks like we already created the overview before
    if (Window) then
        return;
    end

    Events:register({
        "GL.GDKP_MUTATOR_CREATED",
        "GL.GDKP_MUTATOR_CHANGED",
        "GL.GDKP_CUTS_IMPORTED",
        "GL.GDKP_SESSION_LOCKED",
        "GL.GDKP_SESSION_UNLOCKED",
        "GL.GDKP_GOLD_TRADED",
        "GL.GDKP_GOLD_TRADE_CREATED",
        "GL.GDKP_GOLD_TRADE_DELETED",
        "GL.GDKP_GOLD_TRADE_RESTORED",
        "GL.GDKP_CUT_MAILED",
    }, function ()
        self:throttledRefresh();
    end);

    ---@type AceGUIFrame
    Window = AceGUI:Create("Frame");
    Interface:AceGUIDefaults(self, Window, "GDKPDistribute", 700, 550);
    Interface:resizeBounds(Window, 700, 550);

    ---@type AceGUIInlineGroup
    local MutatorsHeader = AceGUI:Create("InlineGroup");
    MutatorsHeader:SetFullWidth(true);
    Window:AddChild(MutatorsHeader);

    ---@type AceGUILabel
    local MutatorsLabel = AceGUI:Create("Label");
    MutatorsLabel:SetText("    " .. L["Mutators"]);
    MutatorsLabel:SetWidth(150);
    MutatorsHeader:AddChild(MutatorsLabel);

    local MutatorHelpIcon = AceGUI:Create("Icon");
    MutatorHelpIcon:SetWidth(12);
    MutatorHelpIcon:SetHeight(12);
    MutatorHelpIcon:SetImageSize(12, 12);
    MutatorHelpIcon:SetImage("interface/friendsframe/informationicon");
    MutatorHelpIcon.frame:SetParent(MutatorsLabel.frame);
    MutatorHelpIcon.frame:SetPoint("BOTTOMLEFT", MutatorsHeader.frame, "BOTTOMLEFT", 7, 8);
    MutatorHelpIcon.frame:Show();

    GL.Interface:addTooltip(MutatorHelpIcon, L["\n\nWith mutators you can give more or less gold to players\nExample: giving 2% extra to tanks is what mutators are for!\n\nNote: Editing or deleting mutators here only changes them for this session\n\n"], "RIGHT");

    ---@type AceGUISimpleGroup
    local Mutators = AceGUI:Create("SimpleGroup");
    Mutators:SetFullWidth(true);
    Mutators:SetLayout("List");
    Mutators:SetHeight(150);
    Window:AddChild(Mutators);
    Interface:set(self, "Mutators", Mutators);

    ---@type AceGUIInlineGroup
    local RaidersHeader = AceGUI:Create("InlineGroup");
    RaidersHeader:SetFullWidth(true);
    RaidersHeader:SetHeight(50);
    Window:AddChild(RaidersHeader);

    ---@type AceGUILabel
    local RaidersLabel = AceGUI:Create("Label");
    RaidersLabel:SetText(L["Raiders"]);
    RaidersLabel:SetWidth(400);
    RaidersHeader:AddChild(RaidersLabel);
    Interface:set(self, "RaidersHeaderLabel", RaidersLabel);

    local PotHelpIcon = AceGUI:Create("Icon");
    PotHelpIcon:SetWidth(12);
    PotHelpIcon:SetHeight(12);
    PotHelpIcon:SetImageSize(12, 12);
    PotHelpIcon:SetImage("interface/friendsframe/informationicon");
    PotHelpIcon.frame:SetParent(RaidersLabel.frame);
    PotHelpIcon.frame:SetPoint("BOTTOMLEFT", RaidersHeader.frame, "BOTTOMLEFT", 7, 8);
    PotHelpIcon.frame:Show();

    GL.Interface:addTooltip(PotHelpIcon, L["\n\nThe total payout can differ slightly from the pot due to rounding differences!\nPlayers currently in the raid can not be edited or removed!\n\nColor explanation:\n|c00F7922E(2000g) Means you owe this person 2000g\n|c00BE3333(3000g) Means this person owes you 3000g\n|c0092FF00(0) Means that you're square\n\nAdjuster explanation:\nWith adjust [g] you can add/deduct gold to a player (use -50 to deduct 50 gold from a player's cut)\nWith adjust [%] you can add/deduct a percentage to a player (use -50 to give players a half cut)\n"], "RIGHT");

    ---@type AceGUISimpleGroup
    local RaidersTableHeader = AceGUI:Create("SimpleGroup");
    RaidersTableHeader:SetLayout("FLOW");
    RaidersTableHeader:SetFullWidth(true);
    Window:AddChild(RaidersTableHeader);
    Interface:set(self, "RaidersTableHeader", RaidersTableHeader);

    ---@type AceGUISimpleGroup
    local ScrollFrameHolder = AceGUI:Create("SimpleGroup");
    ScrollFrameHolder:SetLayout("FILL")
    ScrollFrameHolder:SetFullWidth(true);
    Window:AddChild(ScrollFrameHolder);
    Interface:set(self, "ScrollFrameHolder", ScrollFrameHolder);
    ScrollFrameHolder.frame:SetPoint("BOTTOMRIGHT", Window.frame, "BOTTOMRIGHT", -20, 20);

    ---@type AceGUIScrollFrame
    local ScrollFrame = AceGUI:Create("ScrollFrame");
    ScrollFrame:SetLayout("Flow");
    ScrollFrameHolder:AddChild(ScrollFrame);
    Interface:set(self, "Raiders", ScrollFrame);

    ---@type AceGUISimpleGroup
    local RaidersHolder = AceGUI:Create("SimpleGroup");
    RaidersHolder:SetFullWidth(true);
    RaidersHolder:SetLayout("Flow");
    ScrollFrame:AddChild(RaidersHolder);
    Interface:set(self, "Raiders", RaidersHolder);

    ---@type AceGUISimpleGroup
    local Footer = AceGUI:Create("SimpleGroup");
    Footer:SetFullWidth(true);
    Footer:SetLayout("FLOW");
    Footer:SetFullWidth(true);
    Window:AddChild(Footer);

    local AddRaider = AceGUI:Create("Button");
    AddRaider:SetText(L["Add Raider"]);
    AddRaider:SetWidth(110); ---@TODO: TOO SHORT IN FR
    AddRaider:SetHeight(20);
    AddRaider:SetCallback("OnClick", function()
        self:closeSubWindows();
        Interface.GDKP.Distribute.AddRaider:open(self.sessionID);
    end);
    Interface:set(self, "AddRaider", AddRaider);

    local Import = AceGUI:Create("Button");
    Import:SetText(L["Import"]);
    Import:SetWidth(90);
    Import:SetHeight(20);
    Import:SetCallback("OnClick", function()
        self:closeSubWindows();
        Interface.GDKP.Distribute.Import:open(self.sessionID);
    end);
    Interface:set(self, "Import", Import);

    local Clear = AceGUI:Create("Button");
    Clear:SetText(L["Clear"]);
    Clear:SetWidth(90);
    Clear:SetHeight(20);
    Clear:SetCallback("OnClick", function()
        Interface.Dialogs.PopupDialog:open{
            question = L["Are you sure you want to reset all players and calculations? Note: all players no longer in the raid will be removed from the list!"],
            OnYes = function ()
                GDKPPot:resetCuts(self.sessionID);
                self:throttledRefresh();
            end,
        };
    end);
    Interface:set(self, "Clear", Clear);

    local LockToggler = AceGUI:Create("Button");
    LockToggler:SetText(L["Lock and Pay"]);
    LockToggler:SetWidth(120);
    LockToggler:SetHeight(20);
    Interface:set(self, "LockToggler", LockToggler);

    local Announce = AceGUI:Create("Button");
    Announce:SetText(L["Announce"]);
    Announce:SetWidth(100);
    Announce:SetHeight(20);
    Announce:SetCallback("OnClick", function()
        GDKPPot:announce(self.sessionID);
    end);

    GL.Interface:addTooltip(Announce, L["Announce the base cut in group chat"], "TOP");

    local Export = AceGUI:Create("Button");
    Export:SetText(L["Export"]);
    Export:SetWidth(100);
    Export:SetHeight(20);
    Export:SetCallback("OnClick", function()
        Interface.GDKP.Distribute.Export:open(self.sessionID);
    end);

    Footer:AddChildren(AddRaider, Import, Clear, LockToggler, Announce, Export);

    Window.OnHeightSet = function (...)
        self:resizeFrames();
    end

    return Window;
end

---@return void
function Overview:close()
    self.isVisible = false;

    self:closeSubWindows();
    if (self.openedViaOverview) then
        GL.Interface.GDKP.Overview:open();
    end
end

---@return void
function Overview:closeSubWindows()
    Interface.GDKP.Distribute.CreateMutator:close();
    Interface.GDKP.Distribute.EditMutator:close();
    Interface.GDKP.Distribute.AddRaider:close();
    Interface.GDKP.Distribute.EditRaider:close();
    Interface.GDKP.Distribute.Import:close();
end

---@return void
function Overview:throttledRefresh()
    GL.Ace:CancelTimer(self.RefreshTimer);

    self.RefreshTimer = GL.Ace:ScheduleTimer(function ()
        self:refresh();
    end, .2);
end

---@return void
function Overview:refresh()
    -- Make sure we try to prevent race-conditions as much as possible
    if (self.refreshing) then
        return self:throttledRefresh();
    end

    self.refreshing = true;

    local MutatorsFrame = Interface:get(self, "Frame.Mutators");
    local RaidersFrame = Interface:get(self, "Frame.Raiders");
    local RaidersTableHeader = Interface:get(self, "Frame.RaidersTableHeader");
    local Window = Interface:get(self, "GDKPDistribute");
    local AddRaiderButton = Interface:get(self, "Button.AddRaider");
    local ImportButton = Interface:get(self, "Button.Import");
    local ClearButton = Interface:get(self, "Button.Clear");

    if (not Window
        or not MutatorsFrame
        or not RaidersFrame
    ) then
        self.refreshing = false;
        return;
    end

    self:calculateCuts();

    local Session = GDKPSession:byID(self.sessionID);
    if (type(Session) ~= "table") then
        self.refreshing = false;
        return;
    end

    if (AddRaiderButton and AddRaiderButton.SetDisabled) then
        AddRaiderButton:SetDisabled(Session.lockedAt);
    end

    if (ImportButton and ImportButton.SetDisabled) then
        ImportButton:SetDisabled(Session.lockedAt);
    end

    if (ClearButton and ClearButton.SetDisabled) then
        ClearButton:SetDisabled(Session.lockedAt);
    end

    self.CutHolders = {};
    self:releaseActionButtons();
    Interface:releaseChildren(MutatorsFrame);
    Interface:releaseChildren(RaidersFrame);
    Interface:releaseChildren(RaidersTableHeader);

    local question;
    local LockToggler = Interface:get(self, "Button.LockToggler");
    if (Session.lockedAt) then
        LockToggler:SetText(L["Unlock"]);
        question = L["Unlocking and changing the pot or cuts can get really messy, especially if you've already done payouts. Are you sure?"];
    else
        LockToggler:SetText(L["Lock and Pay"]);
        question = L["Locking a session means you can't auction items or otherwise change anything until you unlock it, are you sure?"];
    end
    LockToggler:SetCallback("OnClick", function()
        Interface.Dialogs.PopupDialog:open{
            question = question,
            OnYes = function ()
                GDKPSession:toggleLock(self.sessionID);
            end,
        };
    end);

    local Mutators = GL:tableValues(GL:tableGet(Session, "Pot.Mutators", {}));

    local totalPot = GDKPPot:total(self.sessionID);
    local managementCutPercentage = tonumber(Session.managementCut) or 0;
    local managementCut = GL:floor(totalPot * (0 + managementCutPercentage / 100), Settings:get("GDKP.precision"))
    Window:SetStatusText((L["Total pot: %sg | Management cut: %sg (%s%%) | To distribute: %sg"]):format(
        totalPot,
        managementCut,
        managementCutPercentage,
        GL:floor(totalPot - managementCut, Settings:get("GDKP.precision"))
    ));

    -- [[ SHOW MUTATORS ]]

    local mutatorHeight = 210;

    -- Sort mutators by name alphabetically
    table.sort(Mutators, function (a, b)
        if (a.name and b.name) then
            return a.name < b.name;
        end

        return false;
    end);

    for _, Mutator in pairs(Mutators or {}) do
        ---@type AceGUISimpleGroup
        local MutatorHolder = AceGUI:Create("SimpleGroup");
        MutatorHolder:SetLayout("FLOW");
        MutatorHolder:SetFullWidth(true);
        MutatorsFrame:AddChild(MutatorHolder);

        ---@type AceGUILabel
        local mutatorName = GL:capitalize(strsub(Mutator.name, 1,20));
        local MutatorTitleLabel = AceGUI:Create("Label");
        MutatorTitleLabel:SetText("    |c00967FD2" .. mutatorName .. "|r");
        MutatorTitleLabel:SetWidth(100);
        MutatorHolder:AddChild(MutatorTitleLabel);

        local MutatorPercentageLabel = AceGUI:Create("Label");
        MutatorPercentageLabel:SetText(L["%"]);
        MutatorPercentageLabel:SetWidth(20);
        MutatorHolder:AddChild(MutatorPercentageLabel);

        ---@type AceGUIEditBox
        local MutatorPercentageBox = AceGUI:Create("EditBox");
        MutatorPercentageBox:SetText(Mutator.percentage);
        MutatorPercentageBox:SetDisabled(true);
        MutatorPercentageBox:SetWidth(50);
        MutatorHolder:AddChild(MutatorPercentageBox);

        ---@type AceGUILabel
        local MutatorFlatLabel = AceGUI:Create("Label");
        MutatorFlatLabel:SetText("             " .. L["g"]);
        MutatorFlatLabel:SetWidth(60);
        MutatorHolder:AddChild(MutatorFlatLabel);

        ---@type AceGUIEditBox
        local MutatorFlatBox = AceGUI:Create("EditBox");
        MutatorFlatBox:SetText(Mutator.flat);
        MutatorFlatBox:SetDisabled(true);
        MutatorFlatBox:DisableButton(true);
        MutatorFlatBox:SetWidth(80);
        MutatorHolder:AddChild(MutatorFlatBox);

        if (not Session.lockedAt) then
            --[[ EDIT BUTTON ]]
            local Edit = Interface:createButton(MutatorHolder, {
                onClick = function()
                    self:closeSubWindows();
                    Interface.GDKP.Distribute.EditMutator:open(self.sessionID, Mutator.name);
                end,
                tooltip = L["Edit mutator"],
                normalTexture = "Interface/AddOns/Gargul/Assets/Buttons/edit",
            });
            Edit:SetPoint("TOPLEFT", MutatorFlatBox.frame, "TOPRIGHT", 20, 0);
            tinsert(self.MutatorActionButtons, Edit);

            --[[ DELETE BUTTON ]]
            local Delete = Interface:createButton(MutatorHolder, {
                onClick = function()
                    local deleteMutator = function ()
                        if (GDKPPot:removeMutator(Mutator.name, self.sessionID)) then
                            self:refresh();
                        else
                            GL:error(L["Something went wrong!"]);
                        end
                    end

                    -- Shift button was held, skip reason
                    if (IsShiftKeyDown()) then
                        deleteMutator();
                        return;
                    end

                    Interface.Dialogs.PopupDialog:open{
                        question = L["Are you sure?"],
                        OnYes = function () deleteMutator(); end,
                    };
                end,
                tooltip = L["Delete. Hold shift to bypass confirmation"],
                normalTexture = "Interface/AddOns/Gargul/Assets/Buttons/delete",
            });
            Delete:SetPoint("TOPLEFT", Edit, "TOPRIGHT", 2);
            tinsert(self.MutatorActionButtons, Delete);
        end

        mutatorHeight = mutatorHeight + MutatorHolder.frame:GetHeight();
    end

    ---@type AceGUILabel
    local Filler = AceGUI:Create("Label");
    Filler:SetText(" ");
    Filler:SetFullWidth(true);
    MutatorsFrame:AddChild(Filler);

    local AddMutator = AceGUI:Create("Button");
    AddMutator:SetText(L["Add Mutator"]);
    AddMutator:SetWidth(110); ---@TODO: TOO SHORT FOR FR
    AddMutator:SetHeight(20);
    AddMutator:SetCallback("OnClick", function()
        self:closeSubWindows();
        Interface.GDKP.Distribute.CreateMutator:open(self.sessionID);
    end);
    AddMutator:SetDisabled(Session.lockedAt);
    MutatorsFrame:AddChild(AddMutator);

    --[[ SHOW RAIDERS ]]

    -- [[ HEADER ]]

    ---@type AceGUILabel
    local HeaderLabel = AceGUI:Create("Label");
    HeaderLabel:SetText("");
    HeaderLabel:SetWidth(150);
    HeaderLabel:SetJustifyH("CENTER");
    RaidersTableHeader:AddChild(HeaderLabel);

    ---@type AceGUILabel
    HeaderLabel = AceGUI:Create("Label");
    HeaderLabel:SetText(L["Base"]);
    HeaderLabel:SetWidth(50);
    RaidersTableHeader:AddChild(HeaderLabel);

    for _, Mutator in pairs(Mutators or {}) do
        ---@type AceGUILabel
        HeaderLabel = AceGUI:Create("Label");
        HeaderLabel:SetText(Mutator.name);
        HeaderLabel:SetWidth(50);
        RaidersTableHeader:AddChild(HeaderLabel);
    end

    ---@type AceGUILabel
    HeaderLabel = AceGUI:Create("Label");
    HeaderLabel:SetText(L["adjust [g]"]);
    HeaderLabel:SetWidth(60);
    RaidersTableHeader:AddChild(HeaderLabel);

    ---@type AceGUILabel
    HeaderLabel = AceGUI:Create("Label");
    HeaderLabel:SetText(L["adjust [%]"]);
    HeaderLabel:SetWidth(70);
    RaidersTableHeader:AddChild(HeaderLabel);

    ---@type AceGUILabel
    HeaderLabel = AceGUI:Create("Label");
    HeaderLabel:SetText(L["Balance"]);
    HeaderLabel:SetWidth(50);
    RaidersTableHeader:AddChild(HeaderLabel);

    local PlayersInRaid = {};
    local PlayersNotInRaid = {};

    -- Split players into in raid and not in raid
    for player in pairs(Session.Pot.DistributionDetails or {}) do
        if (GL.User:unitInGroup(player)) then
            tinsert(PlayersInRaid, player);
        else
            tinsert(PlayersNotInRaid, player);
        end
    end

    -- Sort names (asc)
    table.sort(PlayersInRaid, function(a, b)
        if (a and b) then
            return a < b;
        end

        return false;
    end);

    table.sort(PlayersNotInRaid, function(a, b)
        if (a and b) then
            return a < b;
        end

        return false;
    end);

    ---@type AceGUISimpleGroup
    local RaiderHolder;

    ---@type AceGUILabel
    local FillerLabel = AceGUI:Create("Label");

    local function addPlayer(player, playerIsInMyGroup)
        local PlayerPotDetails = Session.Pot.DistributionDetails[player];
        local classColor = Constants.disabledTextColor;

        if (playerIsInMyGroup) then
            classColor = Constants.ClassHexColors[Player:classByName(player)];
        end

        RaiderHolder = AceGUI:Create("SimpleGroup");
        RaiderHolder:SetLayout("FLOW");
        RaiderHolder:SetFullWidth(true);
        RaidersFrame:AddChild(RaiderHolder);

        --[[ GOLD TRADE ADJUSTMENT ]]
        local AdjustGoldTradesButton = Interface:createButton(RaiderHolder, {
            width = 18,
            height = 18,
            onClick = function()
                GL.Interface.GDKP.GoldTrades.Overview:open(Session.ID, player);
            end,
            tooltip = L["Manage gold trades"],
            normalTexture = "Interface/AddOns/Gargul/Assets/Buttons/bag",
        });
        AdjustGoldTradesButton:SetPoint("CENTER", RaiderHolder.frame, "CENTER");
        AdjustGoldTradesButton:SetPoint("LEFT", RaiderHolder.frame, "LEFT", -2, -1);

        local nameText;
        local nameFormatted = GL:disambiguateName(player);
        if (not Session.lockedAt) then
            nameText = string.format("    |c00%s%s|r", classColor, nameFormatted);
        else
            local copperToGive = GDKPSession:copperOwedToPlayer(player, Session.ID);

            if (copperToGive > 0) then
                nameText = ("    |c00F7922E(%s%s)|r |c00%s%s|r"):format(copperToGive / 10000, L["g"], classColor, nameFormatted);
            elseif (copperToGive < 0) then
                nameText = ("    |c00BE3333(%s%s)|r |c00%s%s|r"):format((copperToGive * -1) / 10000, L["g"], classColor, nameFormatted);
            else
                nameText = ("    |c0092FF00(%s)|r |c00%s%s|r"):format(L["0"], classColor, nameFormatted);
            end
        end

        ---@type AceGUILabel
        local RaiderNameLabel = AceGUI:Create("Label");
        RaiderNameLabel:SetText("   " .. nameText);
        RaiderNameLabel:SetWidth(150);
        RaiderHolder:AddChild(RaiderNameLabel);

        local Checkbox = AceGUI:Create("CheckBox");
        Checkbox:SetValue(PlayerPotDetails[Constants.GDKP.baseMutatorIdentifier]);
        Checkbox:SetWidth(43);
        Checkbox:SetLabel("");
        Checkbox:SetDescription("");
        Checkbox:SetDisabled(Session.lockedAt);
        Checkbox:SetCallback("OnValueChanged", function(El)
            GDKPPot:setPlayerMutatorValue(
                self.sessionID,
                player,
                Constants.GDKP.baseMutatorIdentifier,
                GL:toboolean(El:GetValue())
            );
            self:calculateCuts();
        end);
        RaiderHolder:AddChild(Checkbox);

        for _, Mutator in pairs(Mutators or {}) do
            if (PlayerPotDetails[Mutator.name] == nil) then
                PlayerPotDetails[Mutator.name] = false;
            end

            Checkbox = AceGUI:Create("CheckBox");
            Checkbox:SetValue(PlayerPotDetails[Mutator.name]);
            Checkbox:SetWidth(50);
            Checkbox:SetLabel("");
            Checkbox:SetDescription("");
            Checkbox:SetDisabled(Session.lockedAt);
            Checkbox:SetCallback("OnValueChanged", function(El)
                GDKPPot:setPlayerMutatorValue(
                    self.sessionID,
                    player,
                    Mutator.name,
                    GL:toboolean(El:GetValue())
                );
                self:calculateCuts();
            end);
            RaiderHolder:AddChild(Checkbox);
        end

        ---@type AceGUIEditBox
        local AdjustGoldBox = AceGUI:Create("EditBox");
        AdjustGoldBox:SetText();
        AdjustGoldBox:DisableButton(true);
        AdjustGoldBox:SetWidth(62);
        AdjustGoldBox:SetHeight(18);
        AdjustGoldBox:SetText(PlayerPotDetails[Constants.GDKP.adjustMutatorIdentifier]);
        AdjustGoldBox:SetDisabled(Session.lockedAt);
        AdjustGoldBox:SetCallback("OnTextChanged", function(El)
            GDKPPot:setPlayerMutatorValue(
                self.sessionID,
                player,
                Constants.GDKP.adjustMutatorIdentifier,
                El:GetText()
            );
            self:calculateCuts();
        end);
        RaiderHolder:AddChild(AdjustGoldBox);

        ---@type AceGUIEditBox
        local AdjustPercentageBox = AceGUI:Create("EditBox");
        AdjustPercentageBox:SetText();
        AdjustPercentageBox:DisableButton(true);
        AdjustPercentageBox:SetWidth(64);
        AdjustPercentageBox:SetHeight(18);
        AdjustPercentageBox:SetText(PlayerPotDetails[Constants.GDKP.adjustPercentageMutatorIdentifier]);
        AdjustPercentageBox:SetDisabled(Session.lockedAt);
        AdjustPercentageBox:SetCallback("OnTextChanged", function(El)
            GDKPPot:setPlayerMutatorValue(
                self.sessionID,
                player,
                Constants.GDKP.adjustPercentageMutatorIdentifier,
                El:GetText()
            );
            self:calculateCuts();
        end);
        RaiderHolder:AddChild(AdjustPercentageBox);

        ---@type AceGUILabel
        FillerLabel = AceGUI:Create("Label");
        FillerLabel:SetText(" ");
        FillerLabel:SetWidth(10);
        RaiderHolder:AddChild(FillerLabel);

        local CutLabel = AceGUI:Create("Label");
        CutLabel:SetText(" ");
        CutLabel:SetWidth(180);
        RaiderHolder:AddChild(CutLabel);
        self.CutHolders[player] = CutLabel;

        -- Show a edit and delete button when
        --   The current user is not in a group or the raider is not in our group
        --   And the session is not currently locked
        if ((not GL.User.isInGroup or not playerIsInMyGroup) and not Session.lockedAt) then
            --[[ EDIT BUTTON ]]
            local Edit = Interface:createButton(RaiderHolder, {
                onClick = function()
                    self:closeSubWindows();
                    Interface.GDKP.Distribute.EditRaider:open(self.sessionID, player);
                end,
                tooltip = L["Edit Raider"],
                normalTexture = "Interface/AddOns/Gargul/Assets/Buttons/edit",
            });
            Edit:SetPoint("TOPLEFT", CutLabel.frame, "TOPRIGHT", 20, 10);
            tinsert(self.RaiderActionButtons, Edit);

            --[[ DELETE BUTTON ]]
            local Delete = Interface:createButton(RaiderHolder, {
                onClick = function()
                    GDKPPot:deletePlayer(self.sessionID, player);
                    self:throttledRefresh();
                end,
                tooltip = L["Delete Raider"],
                normalTexture = "Interface/AddOns/Gargul/Assets/Buttons/delete",
            });
            Delete:SetPoint("TOPLEFT", Edit, "TOPRIGHT", 2);
            tinsert(self.RaiderActionButtons, Delete);
        end
    end;

    -- [[ RAIDERS ]]

    --- In raid
    for _, player in pairs(PlayersInRaid) do
        addPlayer(player, true);
    end

    if (not GL:empty(PlayersNotInRaid)) then
        FillerLabel = AceGUI:Create("Label");
        FillerLabel:SetText(" ");
        FillerLabel:SetFullWidth(true);
        RaidersFrame:AddChild(FillerLabel);

        local Heading = GL.AceGUI:Create("Heading");
        Heading:SetFullWidth(true);
        Heading:SetText(("|c00FFFFFF%s|r"):format(L["Not in the raid"]));
        RaidersFrame:AddChild(Heading);

        --- Not in raid
        for _, player in pairs(PlayersNotInRaid) do
            addPlayer(player, false);
        end
    end

    self.mutatorHeight = mutatorHeight;
    self:resizeFrames();
    self:calculateCuts();

    self.refreshing = false;
end

--- Do some resizing magic when the user resizes the distribution window
---
---@return void
function Overview:resizeFrames()
    local MutatorsFrame = Interface:get(self, "Frame.Mutators");
    local RaidersFrame = Interface:get(self, "Frame.Raiders");
    local RaidersScrollFrame = Interface:get(self, "ScrollFrame.Raiders");
    local Window = Interface:get(self, "GDKPDistribute");

    local height = Window.frame:GetHeight() - (self.mutatorHeight or 0) - 56;

    Interface:get(self, "Frame.ScrollFrameHolder"):SetHeight(height);
    MutatorsFrame:DoLayout();
    RaidersFrame:DoLayout();
    RaidersScrollFrame:DoLayout();
    Window:DoLayout();
end

---@return void
function Overview:calculateCuts()
    local Session, totalToDistribute, totalDistributed = GDKPPot:calculateCuts(self.sessionID);

    if (type(Session) ~= "table") then
        return;
    end

    local Cuts = GL:tableGet(Session, "Pot.Cuts", {});

    local numberOfRaiders = 0;
    local numberOfRaidersWithCut = 0;
    for player, cut in pairs(Cuts or {}) do
        local CutHolder = self.CutHolders[player];

        if (CutHolder and CutHolder.SetText) then
            numberOfRaiders = numberOfRaiders + 1;
            local cutAsPartOfTotalToDistribute = ( cut > 0 and totalToDistribute > 0 ) and totalToDistribute / cut or 0;
            local cutPercentage = cutAsPartOfTotalToDistribute > 0 and 100 / cutAsPartOfTotalToDistribute or 0;

            if (cutPercentage < 1) then
                cutPercentage = 0;
            end

            if (cut > 0) then
                numberOfRaidersWithCut = numberOfRaidersWithCut + 1;
            end

            CutHolder:SetText(("|c00FFF569%s|r (%s%%)"):format(GL:goldToMoneyTexture(cut), GL:round(cutPercentage, 2)));
        end
    end

    if (totalDistributed < 1) then
        totalDistributed = 0;
    end

    Interface:get(self, "Label.RaidersHeaderLabel"):SetText(
        ("    " .. L["%s Raiders | %s With cut | Total payout: %s"]):format(numberOfRaiders, numberOfRaidersWithCut, GL:goldToMoneyTexture(totalDistributed))
    );
end

---@return void
function Overview:releaseActionButtons()
    -- Release all of the action buttons into our pool so that we can reuse them later
    for _, Button in pairs(self.MutatorActionButtons or {}) do
        Interface:releaseButton(Button);
    end

    for _, Button in pairs(self.RaiderActionButtons or {}) do
        Interface:releaseButton(Button);
    end

    self.MutatorActionButtons = {};
    self.RaiderActionButtons = {};
end
