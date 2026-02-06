---@type GL
local _, GL = ...;

---@type Settings
local Settings = GL.Settings;

---@class GDKPMutatorsSettings
GL.Interface.Settings.GDKPMutators = {
    InputElements = {},
    ItemLevelElements = {},
};

---@type GDKPMutatorsSettings
local GDKPMutators = GL.Interface.Settings.GDKPMutators;

---@param Parent Frame
---
---@return nil
function GDKPMutators:draw(Parent)
    local Spacer;

    local MutatorExplanation = GL.AceGUI:Create("Label");
    MutatorExplanation:SetText("Mutators can be used to give raiders a bonus or penalty based on performance or role for example.\nMutators defined here will automatically be added to all new GDKP sessions\n\n");
    MutatorExplanation:SetFullWidth(true);
    Parent:AddChild(MutatorExplanation);

    Spacer = GL.AceGUI:Create("SimpleGroup");
    Spacer:SetLayout("FILL");
    Spacer:SetFullWidth(true);
    Spacer:SetHeight(10);
    Parent:AddChild(Spacer);

    local MutatorNames = {};
    local Mutators = Settings:get("GDKP.Mutators", {});

    for name in pairs(Mutators) do
        tinsert(MutatorNames, name);
    end

    table.sort(MutatorNames);

    for i = 1, 20 do
        local mutatorName = MutatorNames[i] or nil;
        local MutatorDetails = {};

        if (mutatorName) then
            MutatorDetails = Settings:get("GDKP.Mutators." .. mutatorName, {});
        end

        local Name = GL.AceGUI:Create("EditBox");
        Name:DisableButton(true);
        Name:SetHeight(20);
        Name:SetWidth(80);
        Name:SetText(MutatorDetails.name);
        Parent:AddChild(Name);

        Name:SetCallback("OnTextChanged", function ()
            local name = Name:GetText() or "";

            if (name:match("%.")) then
                GL:warning(L["Mutator names can not contains dots (.)"]);
                Name:SetText("");
                return;
            end
        end);

        local Percentage = GL.AceGUI:Create("EditBox");
        Percentage:DisableButton(true);
        Percentage:SetHeight(20);
        Percentage:SetWidth(100);
        Percentage:SetText(MutatorDetails.percentage);
        Parent:AddChild(Percentage);

        local Flat = GL.AceGUI:Create("EditBox");
        Flat:DisableButton(true);
        Flat:SetHeight(20);
        Flat:SetWidth(100);
        Flat:SetText(MutatorDetails.flat);
        Parent:AddChild(Flat);

        local AutoApplyTo = GL.AceGUI:Create("EditBox");
        AutoApplyTo:DisableButton(true);
        AutoApplyTo:SetHeight(20);
        AutoApplyTo:SetWidth(220);
        AutoApplyTo:SetText(MutatorDetails.autoApplyTo);
        Parent:AddChild(AutoApplyTo);

        self.InputElements[i] = {
            Name = Name,
            Percentage = Percentage,
            Flat = Flat,
            AutoApplyTo = AutoApplyTo,
        };

        if (i == 1) then
            Name:SetLabel("|cffFFF569Name|r");
            Percentage:SetLabel("|cffFFF569Percentage|r");
            Flat:SetLabel("|cffFFF569Flat g|r");
            AutoApplyTo:SetLabel("|cffFFF569     Apply to|r");

            local HelpIcon = GL.AceGUI:Create("Icon");
            HelpIcon:SetWidth(12);
            HelpIcon:SetHeight(12);
            HelpIcon:SetImageSize(12, 12);
            HelpIcon:SetImage("interface/friendsframe/informationicon");
            HelpIcon.frame:SetParent(AutoApplyTo.frame);
            HelpIcon.frame:SetPoint("TOPLEFT", AutoApplyTo.frame, "TOPLEFT", 0, 0);
            HelpIcon.frame:Show();

            HelpIcon:SetCallback("OnEnter", function()
                GameTooltip:SetOwner(HelpIcon.frame, "ANCHOR_RIGHT");
                GameTooltip:AddLine(" ");
                GameTooltip:AddLine("You can automatically apply this mutator to raiders using\none or multiple (comma-separated) keywords in the 'Apply to' fields below:");
                GameTooltip:AddLine(" ");

                for _, placeholder in pairs (GL.GDKP.Pot.ValidAutoApplyPlaceholders) do
                    GameTooltip:AddLine(("|c00967FD2%s|r"):format(placeholder));
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
        end

        if (i < 20) then
            Spacer = GL.AceGUI:Create("SimpleGroup");
            Spacer:SetLayout("FILL");
            Spacer:SetFullWidth(true);
            Spacer:SetHeight(10);
            Parent:AddChild(Spacer);
        end
    end
end

---@return nil
function GDKPMutators:onClose()
    GL.Settings:set("GDKP.Mutators", {});

    for _, Mutator in pairs(self.InputElements or {}) do
        (function ()
            local name = strtrim(Mutator.Name:GetText());
            if (GL:empty(name)) then
                return;
            end

            local percentage = strtrim(Mutator.Percentage:GetText());
            if (not GL:empty(percentage)
                    and GL:empty(tonumber(percentage))
            ) then
                return;
            end

            local flat = strtrim(Mutator.Flat:GetText());
            if (not GL:empty(flat)
                    and GL:empty(tonumber(flat))
            ) then
                return;
            end

            local autoApplyTo = strtrim(Mutator.AutoApplyTo:GetText());

            local MutatorObj = {
                autoApplyTo = autoApplyTo,
                flat = flat,
                name = name,
                percentage = percentage,
            };

            GL.Settings:set("GDKP.Mutators." .. name, MutatorObj);
        end)();
    end
end
