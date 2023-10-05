---@type GL
local _, GL = ...;

GL.AceGUI = GL.AceGUI or LibStub("AceGUI-3.0");
local AceGUI = GL.AceGUI;

---@type Events
local Events = GL.Events;

---@type GDKPSession
local GDKPSession = GL.GDKP.Session;

---@type GDKPPot
local GDKPPot = GL.GDKP.Pot;

---@type GDKPOverview
local Overview = GL.Interface.GDKP.Distribute.Overview;

---@type Interface
local Interface = GL.Interface;

---@class EditMutator
GL.Interface.GDKP.Distribute.EditMutator = {
    isVisible = false,
    originalMutatorName = nil,
    sessionID = nil,
};

---@type EditMutator
local EditMutator = GL.Interface.GDKP.Distribute.EditMutator;

---@return Frame
function EditMutator:build()
    GL:debug("Interface.GDKP.EditMutator:build");

    local Window = AceGUI:Create("InlineGroup");
    Window:SetLayout("Flow");
    Window:SetWidth(200);
    Window:SetHeight(280);
    Window.frame:SetFrameStrata("HIGH");
    Window.frame:Show();
    Interface:set(self, "Window", Window);

    local Name = GL.AceGUI:Create("EditBox");
    Name:DisableButton(true);
    Name:SetHeight(20);
    Name:SetFullWidth(true);
    Name:SetLabel("Name [example: Tanks]");
    Interface:set(self, "Name", Name);
    Window:AddChild(Name);

    local Percentage = GL.AceGUI:Create("EditBox");
    Percentage:DisableButton(true);
    Percentage:SetHeight(20);
    Percentage:SetFullWidth(true);
    Percentage:SetLabel("Percentage [example: 10]");
    Interface:set(self, "Percentage", Percentage);
    Window:AddChild(Percentage);

    local Flat = GL.AceGUI:Create("EditBox");
    Flat:DisableButton(true);
    Flat:SetHeight(20);
    Flat:SetFullWidth(true);
    Flat:SetLabel("Flat gold rate [example: 250]");
    Interface:set(self, "Flat", Flat);
    Window:AddChild(Flat);

    local AutoApplyTo = GL.AceGUI:Create("EditBox");
    AutoApplyTo:DisableButton(true);
    AutoApplyTo:SetHeight(20);
    AutoApplyTo:SetFullWidth(true);
    AutoApplyTo:SetLabel("     Auto apply to");
    Interface:set(self, "AutoApplyTo", AutoApplyTo);
    Window:AddChild(AutoApplyTo);

    local HelpIcon = AceGUI:Create("Icon");
    HelpIcon:SetWidth(12);
    HelpIcon:SetHeight(12);
    HelpIcon:SetImageSize(12, 12);
    HelpIcon:SetImage("interface/friendsframe/informationicon");
    HelpIcon.frame:SetParent(AutoApplyTo.frame);
    HelpIcon.frame:SetPoint("BOTTOMLEFT", AutoApplyTo.frame, "BOTTOMLEFT", 2, 22);
    HelpIcon.frame:Show();

    HelpIcon:SetCallback("OnEnter", function()
        GameTooltip:SetOwner(HelpIcon.frame, "ANCHOR_RIGHT");
        GameTooltip:AddLine(" ");
        GameTooltip:AddLine("You can automatically apply this mutator to raiders using keywords:");
        GameTooltip:AddLine(" ");

        for _, placeholder in pairs (GDKPPot.ValidAutoApplyPlaceholders) do
            GameTooltip:AddLine(string.format("|c00967FD2%s|r", placeholder));
        end

        GameTooltip:AddLine(" ");
        GameTooltip:AddLine("Example:");
        GameTooltip:AddLine("|c00967FD2SELF,RL,HEALER|r");
        GameTooltip:AddLine(" ");
        GameTooltip:Show();
    end);

    HelpIcon:SetCallback("OnLeave", function()
        GameTooltip:Hide();
    end);

    local Save = AceGUI:Create("Button");
    Save:SetText("Save");
    Save:SetFullWidth(true);
    Save:SetCallback("OnClick", function()
        local name = strtrim(Name:GetText());
        if (GL:empty(name)) then
            GL:warning("Add a mutator name");
            return;
        end

        if (name:match("%.")) then
            GL:warning("Mutator names can not contains dots (.)");
            return;
        end

        local percentage = strtrim(Percentage:GetText());
        if (not GL:empty(percentage)
                and GL:empty(tonumber(percentage))
        ) then
            GL:warning("The percentage needs to be a number");
            return;
        end

        local flat = strtrim(Flat:GetText());
        if (not GL:empty(flat)
                and GL:empty(tonumber(flat))
        ) then
            GL:warning("The flat rate needs to be a number");
            return;
        end

        local autoApplyTo = strtrim(AutoApplyTo:GetText());
        local Session = GDKPSession:byID(self.sessionID);

        if (not Session) then
            GL:warning("Something went wrong while creating the session!");
            return;
        end

        local MutatorObj = {
            autoApplyTo = autoApplyTo,
            flat = flat,
            name = name, -- We want name to be unique
            percentage = percentage,
        };

        if (not GDKPPot:editMutator(self.originalMutatorName, MutatorObj, self.sessionID)) then
            GL:error("Something went wrong adding your mutator, fill the form out correctly!")
            return;
        end

        Events:fire("GL.GDKP_MUTATOR_CHANGED", MutatorObj);

        self:close();
    end);
    Window:AddChild(Save);

    local Cancel = AceGUI:Create("Button");
    Cancel:SetText("Cancel");
    Cancel:SetFullWidth(true);
    Cancel:SetCallback("OnClick", function()
        self:close();
    end);
    Window:AddChild(Cancel);

    return Window;
end

---@return Frame
function EditMutator:window()
    GL:debug("Interface.GDKP.EditMutator:window");

    local Window = Interface:get(self, "Window");

    if (not Window) then
        Window = self:build();
    end

    return Window;
end

--- Toggle the create session window that's anchored to the right side of the GDKP overview window
---
---@return void
function EditMutator:toggle()
    GL:debug("Interface.GDKP.EditMutator:toggle");

    if (self.isVisible) then
        return self:close();
    end

    self:open();
end

---@return void
function EditMutator:open(sessionID, mutator)
    GL:debug("Interface.GDKP.EditMutator:open");

    -- It seems our GDKP overview window is not opened
    if (not Overview.isVisible) then
        return;
    end

    local Session = GDKPSession:byID(sessionID);
    if (not Session) then
        return;
    end

    self.sessionID = sessionID;
    self.originalMutatorName = mutator;
    local Window = self:window();

    local Mutator = GL:tableGet(Session, "Pot.Mutators." .. mutator);
    if (not Mutator) then
        GL:error("Unknown mutator " .. mutator);

        return;
    end

    Interface:get(self, "EditBox.Name"):SetText(Mutator.name);
    Interface:get(self, "EditBox.Percentage"):SetText(Mutator.percentage);
    Interface:get(self, "EditBox.Flat"):SetText(Mutator.flat);
    Interface:get(self, "EditBox.AutoApplyTo"):SetText(Mutator.autoApplyTo);

    self.isVisible = true;
    Window.frame:SetPoint("TOPLEFT", Interface:get(Overview, "GDKPDistribute").frame, "TOPRIGHT", 2, 16);
    Window.frame:Show();
end

---@return void
function EditMutator:close()
    GL:debug("Interface.GDKP.EditMutator:close");

    local Window = self:window();

    if (self.isVisible) then
        Window.frame:Hide();
        self.isVisible = false;
    end
end

GL:debug("Interface.GDKP.EditMutator.lua");