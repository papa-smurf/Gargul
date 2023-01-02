---@type GL
local _, GL = ...;

local AceGUI = LibStub("AceGUI-3.0");

---@type Interface
local Interface = GL.Interface;

---@type Data
local Constants = GL.Data.Constants;

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
    GL:debug("Interface.GDKP.Overview:open");

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
    GL:debug("Overview:build");

    ---@type AceGUIFrame
    local Window = Interface:get(self, "GDKPDistribute");

    -- Looks like we already created the overview before
    if (Window) then
        return;
    end

    Events:register({
        {"DistributionOverviewGDKPMutatorCreatedListener", "GL.GDKP_MUTATOR_CREATED"},
        {"DistributionOverviewGDKPMutatorCreatedListener", "GL.GDKP_MUTATOR_CHANGED"},
        {"DistributionOverviewGDKPCutsImportedListener", "GL.GDKP_CUTS_IMPORTED"},
        {"DistributionOverviewGDKPSessionLockedListener", "GL.GDKP_SESSION_LOCKED"},
        {"DistributionOverviewGDKPSessionUnlockedListener", "GL.GDKP_SESSION_UNLOCKED"},
        {"DistributionOverviewGoldTradedListener", "GL.GDKP_GOLD_TRADED"},
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
    MutatorsLabel:SetText("    Mutators");
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

    MutatorHelpIcon:SetCallback("OnEnter", function()
        GameTooltip:SetOwner(MutatorHelpIcon.frame, "ANCHOR_RIGHT");
        GameTooltip:AddLine(" ");
        GameTooltip:AddLine("With mutators you can give more or less gold to players");
        GameTooltip:AddLine("Example: giving 2% extra to tanks is what mutators are for!");
        GameTooltip:AddLine(" ");
        GameTooltip:AddLine("Notes:");
        GameTooltip:AddLine("- Negative percentages are not allowed");
        GameTooltip:AddLine("- Editing or deleting mutators here only changes them for this session");
        GameTooltip:AddLine(" ");
        GameTooltip:Show();
    end);

    MutatorHelpIcon:SetCallback("OnLeave", function()
        GameTooltip:Hide();
    end);

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
    RaidersLabel:SetText("Raiders");
    RaidersLabel:SetWidth(300);
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

    PotHelpIcon:SetCallback("OnEnter", function()
        GameTooltip:SetOwner(PotHelpIcon.frame, "ANCHOR_RIGHT");
        GameTooltip:AddLine(" ");
        GameTooltip:AddLine("The total payout can differ slightly from the pot due to rounding differences!");
        GameTooltip:AddLine("Players currently in the raid can not be edited or removed!");
        GameTooltip:AddLine(" ");
        GameTooltip:AddLine("Color explanation:");
        GameTooltip:AddLine("|c00F7922E(2000g)|r Means you owe this person 2000g");
        GameTooltip:AddLine("|c00BE3333(3000g)|r Means this person owes you 3000g");
        GameTooltip:AddLine("|c0092FF00(0)|r Means that you're square");
        GameTooltip:Show();
    end);

    PotHelpIcon:SetCallback("OnLeave", function()
        GameTooltip:Hide();
    end);

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
    AddRaider:SetText("Add Raider");
    AddRaider:SetWidth(110);
    AddRaider:SetHeight(20);
    AddRaider:SetCallback("OnClick", function()
        self:closeSubWindows();
        Interface.GDKP.Distribute.AddRaider:open(self.sessionID);
    end);
    Interface:set(self, "AddRaider", AddRaider);

    local Import = AceGUI:Create("Button");
    Import:SetText("Import");
    Import:SetWidth(90);
    Import:SetHeight(20);
    Import:SetCallback("OnClick", function()
        self:closeSubWindows();
        Interface.GDKP.Distribute.Import:open(self.sessionID);
    end);
    Interface:set(self, "Import", Import);

    local Clear = AceGUI:Create("Button");
    Clear:SetText("Clear");
    Clear:SetWidth(90);
    Clear:SetHeight(20);
    Clear:SetCallback("OnClick", function()
        Interface.Dialogs.PopupDialog:open({
            question = "Are you sure you want to reset all players and calculations? Note: all players no longer in the raid will be removed from the list!",
            OnYes = function ()
                GDKPPot:resetCuts(self.sessionID);
                self:throttledRefresh();
            end,
        });
    end);
    Interface:set(self, "Clear", Clear);

    local LockToggler = AceGUI:Create("Button");
    LockToggler:SetText("Lock and Pay");
    LockToggler:SetWidth(120);
    LockToggler:SetHeight(20);
    Interface:set(self, "LockToggler", LockToggler);

    local Announce = AceGUI:Create("Button");
    Announce:SetText("Announce");
    Announce:SetWidth(100);
    Announce:SetHeight(20);
    Announce:SetCallback("OnClick", function()
        GDKPPot:announce(self.sessionID);

        ---@todo: polish up the announcement at some point
        if (true) then
            return;
        end

        Announce:SetDisabled(true);
        GDKPPot:announce(self.sessionID, function ()
            Announce:SetDisabled(false);
        end);
    end);
    Announce:SetCallback("OnEnter", function()
        GameTooltip:SetOwner(Announce.frame, "ANCHOR_TOP");
        GameTooltip:AddLine("Announce the base cut in group chat");
        GameTooltip:Show();
    end);

    Announce:SetCallback("OnLeave", function()
        GameTooltip:Hide();
    end);

    local Export = AceGUI:Create("Button");
    Export:SetText("Export");
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
    GL:debug("Overview:close");

    self.isVisible = false;

    self:closeSubWindows();
    if (self.openedViaOverview) then
        GL.Interface.GDKP.Overview:open();
    end
end

---@return void
function Overview:closeSubWindows()
    GL:debug("Overview:closeSubWindows");

    Interface.GDKP.Distribute.CreateMutator:close();
    Interface.GDKP.Distribute.EditMutator:close();
    Interface.GDKP.Distribute.AddRaider:close();
    Interface.GDKP.Distribute.EditRaider:close();
    Interface.GDKP.Distribute.Import:close();
end

---@return void
function Overview:throttledRefresh()
    GL:debug("Overview:throttledRefresh");

    GL.Ace:CancelTimer(self.RefreshTimer);

    self.RefreshTimer = GL.Ace:ScheduleTimer(function ()
        self:refresh();
    end, .2);
end

---@return void
function Overview:refresh()
    GL:debug("Overview:refresh");

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
        LockToggler:SetText("Unlock");
        question = "Unlocking and changing the pot or cuts can get really messy, especially if you've already done payouts. Are you sure?";
    else
        LockToggler:SetText("Lock and Pay");
        question = "Locking a session means you can't auction items or otherwise change anything until you unlock it, are you sure?";
    end
    LockToggler:SetCallback("OnClick", function()
        Interface.Dialogs.PopupDialog:open({
            question = question,
            OnYes = function ()
                GDKPSession:toggleLock(self.sessionID);
            end,
        });
    end);

    local Mutators = GL:tableGet(Session, "Pot.Mutators", {});

    local totalPot = GDKPPot:total(self.sessionID);
    local managementCutPercentage = tonumber(Session.managementCut) or 0;
    local managementCut = math.floor(totalPot * (0 + managementCutPercentage / 100));
    Window:SetStatusText(string.format(
        "Total pot: %sg | Management cut: %sg (%s%%) | To distribute: %sg",
        totalPot,
        managementCut,
        managementCutPercentage,
        math.floor(totalPot - managementCut)
    ));

    -- [[ SHOW MUTATORS ]]

    local mutatorHeight = 210;

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
        MutatorPercentageLabel:SetText("%");
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
        MutatorFlatLabel:SetText("             g");
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
                tooltip = "Edit mutator",
                normalTexture = "Interface/AddOns/Gargul/Assets/Buttons/edit",
            });
            Edit:SetPoint("TOPLEFT", MutatorFlatBox.frame, "TOPRIGHT", 20, 0);
            tinsert(self.MutatorActionButtons, Edit);

            --[[ DELETE BUTTON ]]
            local Delete = Interface:createButton(MutatorHolder, {
                onClick = function()
                    Interface.Dialogs.PopupDialog:open({
                        question = string.format("Are you sure you want to delete the %s mutator?", Mutator.name),
                        OnYes = function ()
                            if (GDKPPot:removeMutator(Mutator.name, self.sessionID)) then
                                self:throttledRefresh();
                            else
                                GL:error("Unable to delete mutator " .. Mutator.name);
                            end
                        end,
                    });
                end,
                tooltip = "Delete mutator",
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
    AddMutator:SetText("Add Mutator");
    AddMutator:SetWidth(110);
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
    HeaderLabel:SetJustifyH("MIDDLE");
    RaidersTableHeader:AddChild(HeaderLabel);

    ---@type AceGUILabel
    HeaderLabel = AceGUI:Create("Label");
    HeaderLabel:SetText("Base");
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
    HeaderLabel:SetText("adjust [g]");
    HeaderLabel:SetWidth(70);
    RaidersTableHeader:AddChild(HeaderLabel);

    ---@type AceGUILabel
    HeaderLabel = AceGUI:Create("Label");
    HeaderLabel:SetText("Share");
    HeaderLabel:SetWidth(50);
    RaidersTableHeader:AddChild(HeaderLabel);

    -- Make sure we sort by name (asc), otherwise names keep jumping around
    local Players = {};
    for player in pairs(Session.Pot.DistributionDetails or {}) do
        tinsert(Players, player);
    end

    table.sort(Players, function(a, b)
        return a < b;
    end);

    -- [[ RAIDERS ]]
    for _, player in pairs(Players) do
        local PlayerPotDetails = Session.Pot.DistributionDetails[player];
        local playerIsInMyGroup = GL:iEquals(player, GL.User.name) or (GL.User.isInGroup and GL.User:unitIsInYourGroup(player));

        ---@type AceGUISimpleGroup
        local RaiderHolder = AceGUI:Create("SimpleGroup");
        RaiderHolder:SetLayout("FLOW");
        RaiderHolder:SetFullWidth(true);
        RaidersFrame:AddChild(RaiderHolder);

        local nameText;
        if (not Session.lockedAt) then
            nameText = "    " .. player;
        else
            if (player ~= GL.User.name) then
                do
                    local copperToGive = GDKPSession:copperOwedToPlayer(player, Session.ID);

                    if (copperToGive > 0) then
                        nameText = string.format("    |c00F7922E(%sg)|r %s", copperToGive / 10000, player);
                    elseif (copperToGive < 0) then
                        nameText = string.format("    |c00BE3333(%sg)|r %s", (copperToGive * -1) / 10000, player);
                    else
                        nameText = "    |c0092FF00(0)|r " .. player;
                    end
                end
            else
                nameText = "    |c0092FF00(0)|r " .. player;
            end
        end

        ---@type AceGUILabel
        local RaiderNameLabel = AceGUI:Create("Label");
        RaiderNameLabel:SetText(nameText);
        RaiderNameLabel:SetWidth(150);
        RaiderHolder:AddChild(RaiderNameLabel);

        local Checkbox = AceGUI:Create("CheckBox");
        Checkbox:SetValue(PlayerPotDetails[Constants.GDKP.baseMutatorIdentifier]);
        Checkbox:SetWidth(50);
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
        local AdjustBox = AceGUI:Create("EditBox");
        AdjustBox:SetText();
        AdjustBox:DisableButton(true);
        AdjustBox:SetWidth(60);
        AdjustBox:SetHeight(18);
        AdjustBox:SetText(PlayerPotDetails[Constants.GDKP.adjustMutatorIdentifier]);
        AdjustBox:SetDisabled(Session.lockedAt);
        AdjustBox:SetCallback("OnTextChanged", function(El)
            GDKPPot:setPlayerMutatorValue(
                self.sessionID,
                player,
                Constants.GDKP.adjustMutatorIdentifier,
                El:GetText()
            );
            self:calculateCuts();
        end);
        RaiderHolder:AddChild(AdjustBox);

        ---@type AceGUILabel
        local FillerLabel = AceGUI:Create("Label");
        FillerLabel:SetText(" ");
        FillerLabel:SetWidth(10);
        RaiderHolder:AddChild(FillerLabel);

        local CutLabel = AceGUI:Create("Label");
        CutLabel:SetText("2157g");
        CutLabel:SetWidth(120);
        RaiderHolder:AddChild(CutLabel);
        self.CutHolders[player] = CutLabel;

        if (not playerIsInMyGroup and not Session.lockedAt) then
            --[[ EDIT BUTTON ]]
            local Edit = Interface:createButton(RaiderHolder, {
                onClick = function()
                    self:closeSubWindows();
                    Interface.GDKP.Distribute.EditRaider:open(self.sessionID, player);
                end,
                tooltip = "Edit raider",
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
                tooltip = "Delete raider",
                normalTexture = "Interface/AddOns/Gargul/Assets/Buttons/delete",
            });
            Delete:SetPoint("TOPLEFT", Edit, "TOPRIGHT", 2);
            tinsert(self.RaiderActionButtons, Delete);
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
    GL:debug("Overview:resizeFrames");

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
    GL:debug("Overview:calculateCuts");

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
            local cutPercentage = 100 / (totalToDistribute / cut);

            if (cutPercentage < 1) then
                cutPercentage = 0;
            end

            if (cut > 0) then
                numberOfRaidersWithCut = numberOfRaidersWithCut + 1;
            end

            CutHolder:SetText(string.format("|c00967FD2%s|r|c00FFF569g|r  (%s%%)", GL:round(cut, 2), GL:round(cutPercentage, 2)));
        end
    end

    if (totalDistributed < 1) then
        totalDistributed = 0;
    end

    Interface:get(self, "Label.RaidersHeaderLabel"):SetText(
        string.format("    %s Raiders | %s With cut | Total payout: %sg", numberOfRaiders, numberOfRaidersWithCut, GL:round(totalDistributed, 2))
    );
end

---@return void
function Overview:releaseActionButtons()
    GL:debug("Overview:releaseActionButtons");

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

GL:debug("Interfaces/GDKP/Distribute.lua");