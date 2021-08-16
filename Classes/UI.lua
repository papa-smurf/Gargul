---@type GL
local _, GL = ...;

---@class UI
GL.UI = {};

local UI = GL.UI; ---@type UI

UI.components = {};

function UI:createFrame(...)
    local type, identifier, parent, inheritsFrom = ...;
    local frame = CreateFrame(type, identifier, parent, inheritsFrom);

    UI.components[identifier] = frame;

    return frame;
end

function UI:createShareButton(ParentFrame, onClick, tooltipText)
    local ShareButton = GL.UI:createFrame("Frame", "ShareButton" .. GL:uuid(), ParentFrame);
    ShareButton:Show();
    ShareButton:SetSize(24, 24);
    ShareButton:SetPoint("TOPRIGHT", ParentFrame, "TOPRIGHT", -20, -20);

    ShareButton.texture = ShareButton:CreateTexture();
    ShareButton.texture:SetTexture("Interface\\AddOns\\Gargul\\Assets\\Buttons\\share-button-highlighted");
    ShareButton.texture:SetTexture("Interface\\AddOns\\Gargul\\Assets\\Buttons\\share-button");
    ShareButton.texture:SetPoint("CENTER", ShareButton, "CENTER", 0, 0);
    ShareButton.texture:SetSize(24, 24);

    ShareButton:SetScript("OnEnter", function()
        ShareButton.texture:SetTexture("Interface\\AddOns\\Gargul\\Assets\\Buttons\\share-button-highlighted");

        if (not GL:empty(tooltipText)) then
            GameTooltip:SetOwner(ShareButton, "ANCHOR_TOP");
            GameTooltip:AddLine(tooltipText);
            GameTooltip:Show();
        end
    end);

    ShareButton:SetScript("OnLeave", function()
        ShareButton.texture:SetTexture("Interface\\AddOns\\Gargul\\Assets\\Buttons\\share-button");

        if (not GL:empty(tooltipText)) then
            GameTooltip:Hide();
        end
    end);

    if (type(onClick) == "function") then
        ShareButton:SetScript("OnMouseDown", function(_, button)
            if (button == 'LeftButton') then
                onClick();
            end
        end);
    end

    return ShareButton;
end

-- Generate a checkbox used in the Interface Options -> Settings menu
function UI:createSettingCheckbox(ParentFrame, label, description, onClick)
    local CheckBox = CreateFrame("CheckButton", GL.name .. "Setting" .. label, ParentFrame, "InterfaceOptionsCheckButtonTemplate");

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
        GL:debug(identifier .. " has not been created yet");
        return;
    elseif (UI.components[identifier]:IsVisible()) then
        GL:debug(identifier .. " is already visible");
        return;
    end

    UI.components[identifier]:Show();
end

function UI:hide(identifier)
    if (not UI.components[identifier]) then
        GL:debug(identifier .. " has not been created yet");
        return;
    elseif (not UI.components[identifier]:IsVisible()) then
        GL:debug(identifier .. " is not visible");
        return;
    end

    UI.components[identifier]:Hide();
end

function UI:hideAll()
    if (not #UI.components) then
        GL:debug("No components have been created yet");
        return;
    end
end

GL:debug("UI.lua");