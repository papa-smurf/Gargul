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

GL.Interface.GDKP.Distribute = GL.Interface.GDKP.Distribute or {};

---@class GDKPDistribute
GL.Interface.GDKP.Distribute.Overview = {
    isVisible = false,
    sessionID = nil,

    CutHolders = {}, -- The labels that hold the actula cut values
    MutationFrame = nil,
    PotDistributionDetails = {},
};

---@type GDKPDistribute
local Overview = GL.Interface.GDKP.Distribute.Overview;

---@return void
function Overview:open(sessionID)
    GL:debug("Interface.GDKP.Overview:open");

    local Session = GDKPSession:byID(sessionID);
    if (not Session) then
        return;
    end

    local Window = Interface:get(self, "GDKPDistribute");
    if (not Window) then
        Window = self:build();
    end

    self.sessionID = sessionID;
    self:refresh();

    if (self.isVisible) then
        return;
    end

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

    Events:register("GDKPMutatorCreatedListener", "GL.GDKP_MUTATOR_CREATED", function ()
        self:refresh();
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

    local HelpIcon = AceGUI:Create("Icon");
    HelpIcon:SetWidth(12);
    HelpIcon:SetHeight(12);
    HelpIcon:SetImageSize(12, 12);
    HelpIcon:SetImage("interface/friendsframe/informationicon");
    HelpIcon.frame:SetParent(MutatorsLabel.frame);
    HelpIcon.frame:SetPoint("BOTTOMLEFT", MutatorsHeader.frame, "BOTTOMLEFT", 7, 8);
    HelpIcon.frame:Show();

    HelpIcon:SetCallback("OnEnter", function()
        GameTooltip:SetOwner(HelpIcon.frame, "ANCHOR_RIGHT");
        GameTooltip:AddLine(" ");
        GameTooltip:AddLine("With mutators you can give more or less to players");
        GameTooltip:AddLine("Example: giving 2% extra to tanks is what mutators are for!");
        GameTooltip:AddLine(" ");
        GameTooltip:Show();
    end);

    HelpIcon:SetCallback("OnLeave", function()
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
    RaidersLabel:SetWidth(150);
    RaidersHeader:AddChild(RaidersLabel);

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

    local Announce = AceGUI:Create("Button");
    Announce:SetText("Announce");
    Announce:SetWidth(150);
    Announce:SetHeight(20);
    Announce:SetCallback("OnClick", function()
        GL:xd("ANNOUNCE!");
    end);

    local Import = AceGUI:Create("Button");
    Import:SetText("Import");
    Import:SetWidth(150);
    Import:SetHeight(20);
    Import:SetCallback("OnClick", function()
        GL.Interface.GDKP.Distribute.Import:open(self.sessionID);
    end);

    local Export = AceGUI:Create("Button");
    Export:SetText("Export");
    Export:SetWidth(150);
    Export:SetHeight(20);
    Export:SetCallback("OnClick", function()
        GL.Interface.GDKP.Export:open(self.selectedSession);
    end);

    local LockAndPay = AceGUI:Create("Button");
    LockAndPay:SetText("Lock and Pay");
    LockAndPay:SetWidth(150);
    LockAndPay:SetHeight(20);
    LockAndPay:SetCallback("OnClick", function()
        GL.Interface.GDKP.Export:open(self.selectedSession);
    end);

    Footer:AddChildren(Announce, Import, Export, LockAndPay);

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
end

---@return void
function Overview:closeSubWindows()
    GL:debug("Overview:closeSubWindows");

    Interface.GDKP.Distribute.Import:close();
end

function Overview:refresh()
    GL:debug("Overview:refresh");

    local Session = GDKPSession:byID(self.sessionID);

    if (type(Session) ~= "table") then
        return;
    end

    local MutatorsFrame = Interface:get(self, "Frame.Mutators");
    local RaidersFrame = Interface:get(self, "Frame.Raiders");
    local RaidersTableHeader = Interface:get(self, "Frame.RaidersTableHeader");
    local Window = Interface:get(self, "GDKPDistribute");

    if (not Window
        or not MutatorsFrame
        or not RaidersFrame
    ) then
        return;
    end

    self:calculateCuts();
    local PotDistributionDetails = Session.Pot.DistributionDetails or {};

    self.CutHolders = {};
    MutatorsFrame:ReleaseChildren();
    RaidersFrame:ReleaseChildren();
    RaidersTableHeader:ReleaseChildren();

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
        MutatorPercentageBox:DisableButton(true);
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
        MutatorFlatBox:DisableButton(true);
        MutatorFlatBox:SetWidth(80);
        MutatorHolder:AddChild(MutatorFlatBox);

        mutatorHeight = mutatorHeight + MutatorHolder.frame:GetHeight();
    end

    ---@type AceGUILabel
    local Filler = AceGUI:Create("Label");
    Filler:SetText(" ");
    Filler:SetFullWidth(true);
    MutatorsFrame:AddChild(Filler);

    local AddMutator = AceGUI:Create("Button");
    AddMutator:SetText("New Mutator");
    AddMutator:SetWidth(150);
    AddMutator:SetHeight(20);
    AddMutator:SetCallback("OnClick", function()
        GL.Interface.GDKP.Distribute.CreateMutator:open(self.sessionID);
    end);
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
    HeaderLabel:SetText("base");
    HeaderLabel:SetWidth(50);
    RaidersTableHeader:AddChild(HeaderLabel);

    for _, Mutator in pairs(Mutators or {}) do
        ---@type AceGUILabel
        HeaderLabel = AceGUI:Create("Label");
        HeaderLabel:SetText(strlower(Mutator.name));
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

    -- [[ RAIDERS ]]
    for _, Player in pairs(GL.User:groupMembers() or {}) do
        local PlayerPotDetails = PotDistributionDetails[Player.name];
        ---@type AceGUISimpleGroup
        local RaiderHolder = AceGUI:Create("SimpleGroup");
        RaiderHolder:SetLayout("FLOW");
        RaiderHolder:SetFullWidth(true);
        RaidersFrame:AddChild(RaiderHolder);

        ---@type AceGUILabel
        local RaiderNameLabel = AceGUI:Create("Label");
        RaiderNameLabel:SetText("    " .. Player.name);
        RaiderNameLabel:SetWidth(150);
        RaiderHolder:AddChild(RaiderNameLabel);

        ---@type AceGUICheckBox
        if (PlayerPotDetails[Constants.GDKP.baseMutatorIdentifier] == nil) then
            PlayerPotDetails[Constants.GDKP.baseMutatorIdentifier] = true;
        end

        local Checkbox = AceGUI:Create("CheckBox");
        Checkbox:SetValue(PlayerPotDetails[Constants.GDKP.baseMutatorIdentifier]);
        Checkbox:SetWidth(50);
        Checkbox:SetLabel("");
        Checkbox:SetDescription("");
        Checkbox:SetCallback("OnValueChanged", function(El)
            PlayerPotDetails[Constants.GDKP.baseMutatorIdentifier] = GL:toboolean(El:GetValue());
            self:calculateCuts(true);
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
            Checkbox:SetCallback("OnValueChanged", function(El)
                PlayerPotDetails[Mutator.name] = GL:toboolean(El:GetValue());
                self:calculateCuts(true);
            end);
            RaiderHolder:AddChild(Checkbox);
        end

        ---@type AceGUIEditBox
        local AdjustBox = AceGUI:Create("EditBox");
        AdjustBox:SetText();
        AdjustBox:DisableButton(true);
        AdjustBox:SetWidth(60);
        AdjustBox:SetHeight(18);
        AdjustBox:SetCallback("OnTextChanged", function(El)
            PlayerPotDetails[Constants.GDKP.adjustMutatorIdentifier] = El:GetText();
            self:calculateCuts(true);
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
        self.CutHolders[Player.name] = CutLabel;
    end

    self.mutatorHeight = mutatorHeight;
    self:resizeFrames();
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

    local height = Window.frame:GetHeight() - (self.mutatorHeight or 0) - 44;

    Interface:get(self, "Frame.ScrollFrameHolder"):SetHeight(height);
    MutatorsFrame:DoLayout();
    RaidersFrame:DoLayout();
    RaidersScrollFrame:DoLayout();
    Window:DoLayout();
end

function Overview:determineDistributionDefaults(Player)
    GL:debug("Overview:determineDistributionDefaults");

    local PlayerRoles = {};
    local DistributionDetails = {};
    local ClassRoleDictionary = {
        TANK = "TANK",
        DAMAGER = "DPS",
        HEALER = "HEAL",
    };

    if (Player.class) then
        tinsert(PlayerRoles, strupper(Player.class));
    end

    local classRole = UnitGroupRolesAssigned(Player.name);
    if (classRole and ClassRoleDictionary[classRole]) then
        tinsert(PlayerRoles, classRole);
    end

    if (Player.isLeader) then
        tinsert(PlayerRoles, "LEAD");
    end

    if (Player.isML) then
        tinsert(PlayerRoles, "ML");
    end

    for _, Mutator in pairs(self.Mutators or {}) do
        local active = false;

        if (type(Mutator.AutoGiveOnRolls) == "table") then
            for _, role in pairs(PlayerRoles or {}) do
                if (GL:inTable(Mutator.AutoGiveOnRolls, role)) then
                    active = true;
                    break;
                end
            end
        end

        DistributionDetails[Mutator.name] = active;
    end

    return DistributionDetails;
end

function Overview:calculateCuts()
    GL:debug("Overview:calculateCuts");

    local Session, totalToDistribute = GDKPPot:calculateCuts(self.sessionID);

    if (type(Session) ~= "table") then
        return;
    end

    local Cuts = GL:tableGet(Session, "Pot.Cuts", {});

    for player, cut in pairs(Cuts or {}) do
        local CutHolder = self.CutHolders[player];

        if (CutHolder and CutHolder.SetText) then
            local cutPercentage = 100 / (totalToDistribute / cut);
            CutHolder:SetText(string.format("|c00967FD2%s|r|c00FFF569g|r  (%s%%)", GL:round(cut, 2), GL:round(cutPercentage, 2)));
        end
    end
end

GL:debug("Interfaces/GDKP/Distribute.lua");