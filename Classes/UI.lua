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

function UI:createShareButton(ParentFrame, onClick, tooltipText, disabledTooltipText)
    local ShareButton = GL.UI:createFrame("Button", "ShareButton" .. GL:uuid(), ParentFrame, "UIPanelButtonTemplate");
    ShareButton:Show();
    ShareButton:SetSize(24, 24);
    ShareButton:SetPoint("TOPRIGHT", ParentFrame, "TOPRIGHT", -20, -20);
    ShareButton:SetMotionScriptsWhileDisabled(true); -- Make sure tooltip still shows even when button is disabled

    local HighlightTexture = ShareButton:CreateTexture();
    HighlightTexture:SetTexture("Interface\\AddOns\\Gargul\\Assets\\Buttons\\share-button-highlighted");
    HighlightTexture:SetPoint("CENTER", ShareButton, "CENTER", 0, 0);
    HighlightTexture:SetSize(24, 24);

    ShareButton:SetNormalTexture("Interface\\AddOns\\Gargul\\Assets\\Buttons\\share-button");
    ShareButton:SetHighlightTexture(HighlightTexture);
    ShareButton:SetDisabledTexture("Interface\\AddOns\\Gargul\\Assets\\Buttons\\share-button-disabled");

    ShareButton:SetScript("OnEnter", function()
        local textToShow = tooltipText;

        if (not ShareButton:IsEnabled()) then
            textToShow = disabledTooltipText;
        end

        if (not GL:empty(textToShow)) then
            GameTooltip:SetOwner(ShareButton, "ANCHOR_TOP");
            GameTooltip:AddLine(textToShow);
            GameTooltip:Show();
        end
    end);

    ShareButton:SetScript("OnLeave", function()
        GameTooltip:Hide();
    end);

    if (type(onClick) == "function") then
        if (ShareButton:IsEnabled()) then
            ShareButton:SetScript("OnClick", function(_, button)
                if (button == 'LeftButton') then
                    onClick();
                end
            end);
        end
    end

    return ShareButton;
end

-- Generate a checkbox used in the Interface Options -> Settings menu
function UI:createSettingCheckbox(ParentFrame, label, description, onClick)
    local CheckBox = CreateFrame("CheckButton", "GargulSetting" .. label, ParentFrame, "InterfaceOptionsCheckButtonTemplate");

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