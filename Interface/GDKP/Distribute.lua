---@type GL
local _, GL = ...;

local AceGUI = LibStub("AceGUI-3.0");

---@type Interface
local Interface = GL.Interface;

---@type Events
local Events = GL.Events;

---@type GDKP
local GDKP = GL.GDKP;

---@class GDKPDistribute
GL.Interface.GDKP.Distribute = {
    isVisible = false,
    session = nil,

    CutHolders = {}, -- The labels that hold the actula cut values
    MutationFrame = nil,
    Mutators = {},
    PotDistributionDetails = {},
};

---@type GDKPDistribute
local Distribute = GL.Interface.GDKP.Distribute;

---@return void
function Distribute:open(sessionID)
    GL:debug("Interface.GDKP.Distribute:open");

    local Session = GDKP:getSessionByID(sessionID);
    if (not Session) then
        return;
    end

    local Window = Interface:get(self, "GDKPDistribute");
    if (not Window) then
        Window = self:build();
    end

    self.Mutators = GL:tableGet(Session, "Pot.Mutators", nil) or {
        --mgmt = {title="mgmt", percentage=20, flat=0, AutoGiveOnRolls={"LEAD"}},
        --mgmt = {title="mgmt", percentage=20, flat=0,},
        tank = {title="tank", percentage=2, flat=0, AutoGiveOnRolls={"TANK"}},
        healer = {title="healer", percentage=1, flat=0, AutoGiveOnRolls={"HEALER"}},
        --dps1 = {title="dps1", percentage=2, flat=0},
        --dps2 = {title="dps2", percentage=1, flat=0},
        --dps3 = {title="dps3", percentage=.5, flat=0},
        utility = {title="utility", percentage=.5, flat=0, AutoGiveOnRolls={"MASTERLOOTER", "ROGUE"}},
    };

    self.session = sessionID;
    self:refresh();

    if (self.isVisible) then
        return;
    end

    self.isVisible = true;
    Window:Show();
end

---@return void
function Distribute:build()
    GL:debug("Distribute:build");

    ---@type AceGUIFrame
    local Window = Interface:get(self, "GDKPDistribute");

    -- Looks like we already created the overview before
    if (Window) then
        return;
    end

    ---@type AceGUIFrame
    Window = AceGUI:Create("Frame");
    Interface:AceGUIDefaults(self, Window, "GDKPDistribute", 700, 550);
    Interface:resizeBounds(Window, 700, 550);

    ---@type AceGUIInlineGroup
    local MutationsHeader = AceGUI:Create("InlineGroup");
    MutationsHeader:SetFullWidth(true);
    Window:AddChild(MutationsHeader);

    ---@type AceGUILabel
    local MutationsLabel = AceGUI:Create("Label");
    MutationsLabel:SetText("Mutations");
    MutationsLabel:SetWidth(150);
    MutationsHeader:AddChild(MutationsLabel);

    ---@type AceGUISimpleGroup
    local Mutations = AceGUI:Create("SimpleGroup");
    Mutations:SetFullWidth(true);
    Mutations:SetLayout("List");
    Mutations:SetHeight(150);
    Window:AddChild(Mutations);
    Interface:set(self, "Mutations", Mutations);

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
        GL.Interface.GDKP.Announce:open(self.selectedSession);
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

    Footer:AddChildren(Announce, Export, LockAndPay);

    Window.OnHeightSet = function (...)
        self:resizeFrames();
    end

    return Window;
end

---@return void
function Distribute:close()
    GL:debug("Distribute:close");

    self.isVisible = false;
end

function Distribute:refresh()
    GL:debug("Distribute:refresh");

    local Session = GDKP:getSessionByID(self.session);

    if (type(Session) ~= "table") then
        return;
    end

    local MutationsFrame = Interface:get(self, "Frame.Mutations");
    local RaidersFrame = Interface:get(self, "Frame.Raiders");
    local RaidersTableHeader = Interface:get(self, "Frame.RaidersTableHeader");
    local Window = Interface:get(self, "GDKPDistribute");

    if (not Window
        or not MutationsFrame
        or not RaidersFrame
    ) then
        return;
    end

    self.CutHolders = {};
    MutationsFrame:ReleaseChildren();
    RaidersFrame:ReleaseChildren();
    RaidersTableHeader:ReleaseChildren();

    local totalPot = GDKP:pot(self.session);
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
    for _, Mutator in pairs(self.Mutators) do
        ---@type AceGUISimpleGroup
        local MutatorHolder = AceGUI:Create("SimpleGroup");
        MutatorHolder:SetLayout("FLOW");
        MutatorHolder:SetFullWidth(true);
        MutationsFrame:AddChild(MutatorHolder);

        ---@type AceGUILabel
        local MutatorPercentageLabel = AceGUI:Create("Label");
        MutatorPercentageLabel:SetText("    " .. GL:capitalize(Mutator.title) .. " [%]");
        MutatorPercentageLabel:SetWidth(80);
        MutatorHolder:AddChild(MutatorPercentageLabel);

        ---@type AceGUIEditBox
        local MutatorPercentageBox = AceGUI:Create("EditBox");
        MutatorPercentageBox:SetText(Mutator.percentage);
        MutatorPercentageBox:SetWidth(50);
        MutatorHolder:AddChild(MutatorPercentageBox);

        ---@type AceGUILabel
        local MutatorFlatLabel = AceGUI:Create("Label");
        MutatorFlatLabel:SetText("      " .. GL:capitalize(Mutator.title));
        MutatorFlatLabel:SetWidth(80);
        MutatorHolder:AddChild(MutatorFlatLabel);

        ---@type AceGUIEditBox
        local MutatorFlatBox = AceGUI:Create("EditBox");
        MutatorFlatBox:SetText(Mutator.flat);
        MutatorFlatBox:SetWidth(80);
        MutatorHolder:AddChild(MutatorFlatBox);

        mutatorHeight = mutatorHeight + MutatorHolder.frame:GetHeight();
    end

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

    for _, Mutator in pairs(self.Mutators) do
        ---@type AceGUILabel
        HeaderLabel = AceGUI:Create("Label");
        HeaderLabel:SetText(strlower(Mutator.title));
        HeaderLabel:SetWidth(50);
        RaidersTableHeader:AddChild(HeaderLabel);
    end

    HeaderLabel = AceGUI:Create("Label");
    HeaderLabel:SetText("Share");
    HeaderLabel:SetWidth(50);
    RaidersTableHeader:AddChild(HeaderLabel);

    self.PotDistributionDetails = {};
    local PotDistributionDetails = self.PotDistributionDetails;

    -- [[ RAIDERS ]]
    for _, Player in pairs(GL.User:groupMembers() or {}) do
        if (not PotDistributionDetails[Player.name]) then
            PotDistributionDetails[Player.name] = self:determineDistributionDefaults(Player);
        end

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

        local Checkbox = AceGUI:Create("CheckBox");
        Checkbox:SetValue(true);
        Checkbox:SetWidth(50);
        Checkbox:SetLabel("");
        Checkbox:SetDescription("");
        Checkbox:SetCallback("OnValueChanged", function()
            self:calculateCuts(true);
        end);
        RaiderHolder:AddChild(Checkbox);

        for _, Mutator in pairs(self.Mutators) do
            if (PlayerPotDetails[Mutator.title] == nil) then
                PlayerPotDetails[Mutator.title] = false;
            end

            Checkbox = AceGUI:Create("CheckBox");
            Checkbox:SetValue(PlayerPotDetails[Mutator.title]);
            Checkbox:SetWidth(50);
            Checkbox:SetLabel("");
            Checkbox:SetDescription("");
            Checkbox:SetCallback("OnValueChanged", function(El)
                PlayerPotDetails[Mutator.title] = GL:toboolean(El:GetValue());
                self:calculateCuts(true);
            end);
            RaiderHolder:AddChild(Checkbox);
        end

        local CutLabel = AceGUI:Create("Label");
        CutLabel:SetText("2157g");
        CutLabel:SetWidth(80);
        RaiderHolder:AddChild(CutLabel);
        self.CutHolders[Player.name] = CutLabel;
    end

    self.mutatorHeight = mutatorHeight;
    self:resizeFrames();
    self:calculateCuts();
end

--- Do some resizing magic when the user resizes the distribution window
---
---@return void
function Distribute:resizeFrames()
    GL:debug("Distribute:resizeFrames");

    local MutationsFrame = Interface:get(self, "Frame.Mutations");
    local RaidersFrame = Interface:get(self, "Frame.Raiders");
    local RaidersScrollFrame = Interface:get(self, "ScrollFrame.Raiders");
    local Window = Interface:get(self, "GDKPDistribute");

    local height = Window.frame:GetHeight() - (self.mutatorHeight or 0) - 20;

    Interface:get(self, "Frame.ScrollFrameHolder"):SetHeight(height);
    MutationsFrame:DoLayout();
    RaidersFrame:DoLayout();
    RaidersScrollFrame:DoLayout();
    Window:DoLayout();
end

function Distribute:determineDistributionDefaults(Player)
    GL:debug("Distribute:determineDistributionDefaults");

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

        DistributionDetails[Mutator.title] = active;
    end

    return DistributionDetails;
end

function Distribute:calculateCuts(forceRecalculate)
    GL:debug("Distribute:calculateCuts");

    local Session = GDKP:getSessionByID(self.session);
    if (not Session) then
        return;
    end

    Session.Pot = Session.Pot or {};

    if (not GL:empty(Session.Pot) and not forceRecalculate) then
        return;
    end

    -- If there's a management cut then we remove it from the pot first
    local totalPot = GDKP:pot(self.session);
    local managementCut = tonumber(Session.managementCut) or 0;
    managementCut = math.floor(totalPot * (0 + managementCut / 100));
    totalPot = math.floor(totalPot - managementCut);

    local percentages = 0;
    local flat = 0;
    local leftToDistribute = totalPot;
    local base;

    for _, Mutators in pairs(self.PotDistributionDetails or {}) do
        for title, active in pairs(Mutators or {}) do
            if (self.Mutators[title] and active) then
                percentages = percentages + (self.Mutators[title].percentage or 0);
                flat = flat + (self.Mutators[title].flat or 0);
            end
        end
    end

    leftToDistribute = totalPot - flat;
    leftToDistribute = leftToDistribute - (totalPot * (0 + (percentages / 100)));
    base = GL:round(leftToDistribute / GL:count(self.PotDistributionDetails), 2);

    local totalToDistribute = 0;
    for player, Mutators in pairs(self.PotDistributionDetails or {}) do
        local playerPot = base;
        for title, active in pairs(Mutators or {}) do
            if (self.Mutators[title] and active) then
                local percentage = tonumber(self.Mutators[title].percentage);
                flat = self.Mutators[title].flat;

                if (percentage) then
                    playerPot = playerPot + (totalPot * (0 + percentage / 100));
                end

                if (flat) then
                    playerPot = playerPot + flat;
                end
            end
        end

        Session.Pot[player] = playerPot;
        totalToDistribute = totalToDistribute + playerPot;
    end

    GL:debug("Distribute:calculateCuts total to distribute = " .. totalToDistribute);

    for player, cut in pairs(Session.Pot or {}) do
        local CutHolder = self.CutHolders[player];

        if (CutHolder and CutHolder.SetText) then
            local cutPercentage = 100 / (totalPot / cut);
            CutHolder:SetText(string.format("%sg\n(%s%%)", GL:round(cut, 2), GL:round(cutPercentage, 2)));
        end
    end
end

GL:debug("Interfaces/GDKP/Export.lua");