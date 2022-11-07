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

function UI:createSettingsButton(ParentFrame, settingsSection, width, height, omitPosition)
    omitPosition = GL:toboolean(omitPosition);
    width = width or 16;
    height = height or 16;

    -- Create the cogwheel that links to the announcement settings
    local Cogwheel = CreateFrame("Button", "SettingsButton" .. GL:uuid(), ParentFrame, Frame);
    Cogwheel:Show();
    Cogwheel:SetClipsChildren(true);
    Cogwheel:SetSize(width, height);

    if (not omitPosition) then
        Cogwheel:SetPoint("TOPLEFT", ParentFrame, "TOPLEFT", 18, -18);
    end

    local CogwheelTexture = Cogwheel:CreateTexture();
    CogwheelTexture:SetPoint("BOTTOMRIGHT", math.ceil(width / 6.5) * -1, math.ceil(height / 6.5));
    CogwheelTexture:SetSize(width,height);
    CogwheelTexture:SetTexture("interface\\cursor\\interact");
    CogwheelTexture:SetTexture("interface\\cursor\\unableinteract");
    Cogwheel.texture = CogwheelTexture;

    Cogwheel:SetScript('OnEnter', function()
        CogwheelTexture:SetTexture("interface\\cursor\\interact");
    end);
    Cogwheel:SetScript('OnLeave', function()
        CogwheelTexture:SetTexture("interface\\cursor\\unableinteract");
    end);

    Cogwheel:SetScript("OnClick", function(_, button)
        if (button == 'LeftButton') then
            GL.Settings:draw(settingsSection);
        end
    end);

    return Cogwheel;
end

function UI:createShareButton(ParentFrame, onClick, tooltipText, disabledTooltipText, omitPosition)
    omitPosition = GL:toboolean(omitPosition);
    local ShareButton = GL.UI:createFrame("Button", "ShareButton" .. GL:uuid(), ParentFrame, "UIPanelButtonTemplate");
    ShareButton:Show();
    ShareButton:SetSize(24, 24);

    if (not omitPosition) then
        ShareButton:SetPoint("TOPRIGHT", ParentFrame, "TOPRIGHT", -20, -20);
    end

    ShareButton:SetMotionScriptsWhileDisabled(true); -- Make sure tooltip still shows even when button is disabled

    local HighlightTexture = ShareButton:CreateTexture();
    HighlightTexture:SetTexture("Interface\\AddOns\\Gargul\\Assets\\Buttons\\share-highlighted");
    HighlightTexture:SetPoint("CENTER", ShareButton, "CENTER", 0, 0);
    HighlightTexture:SetSize(24, 24);

    ShareButton:SetNormalTexture("Interface\\AddOns\\Gargul\\Assets\\Buttons\\share");
    ShareButton:SetHighlightTexture(HighlightTexture);
    ShareButton:SetDisabledTexture("Interface\\AddOns\\Gargul\\Assets\\Buttons\\share-disabled");

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

GL:debug("UI.lua");