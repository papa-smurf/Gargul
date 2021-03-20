local _, App = ...;

App.UI = {};

local UI = App.UI;
local Utils = App.Utils;

UI.components = {};

function UI:createFrame(...)
    local type, identifier, parent, inheritsFrom = ...;
    local frame = CreateFrame(type, identifier, parent, inheritsFrom);

    UI.components[identifier] = frame;

    return frame;
end

-- Generate a checkbox used in the Interface Options -> Settings menu
function UI:createSettingCheckbox(ParentFrame, label, description, onClick)
    local CheckBox = CreateFrame("CheckButton", App.name .. "Setting" .. label, ParentFrame, "InterfaceOptionsCheckButtonTemplate");

    CheckBox:SetScript("OnClick", function(self)
        local checked = self:GetChecked()

        onClick(self, checked and true or false)

        if checked then
            PlaySound(856) -- SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON
        else
            PlaySound(857) -- SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_OFF
        end
    end)

    CheckBox.label = _G[CheckBox:GetName() .. "Text"];
    CheckBox.label:SetText(label);
    CheckBox.tooltipText = label;
    CheckBox.tooltipRequirement = description;

    return CheckBox
end

function UI:show(identifier)
    if (not UI.components[identifier]) then
        Utils:debug(identifier .. " has not been created yet");
        return;
    elseif (UI.components[identifier]:IsVisible()) then
        Utils:debug(identifier .. " is already visible");
        return;
    end

    UI.components[identifier]:Show();
end

function UI:hide(identifier)
    if (not UI.components[identifier]) then
        Utils:debug(identifier .. " has not been created yet");
        return;
    elseif (not UI.components[identifier]:IsVisible()) then
        Utils:debug(identifier .. " is not visible");
        return;
    end

    UI.components[identifier]:Hide();
end

function UI:hideAll()
    if (not #UI.components) then
        Utils:debug("No components have been created yet");
        return;
    end
end

Utils:debug("UI.lua");