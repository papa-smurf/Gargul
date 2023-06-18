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

---@param Parent Frame
---@param Details table<string,any>
function UI:createShareButton(Parent, Details)
    GL:debug("UI:createShareButton");

    -- Invalid Parent provided
    if (not Parent
        or type(Parent) ~= "table"
        or (not Parent.Hide
            and not Parent.frame)
    ) then
        return;
    end

    Details = Details or {};
    local onClick = Details.onClick or function() end;
    local alwaysFireOnClick = Details.alwaysFireOnClick or false;
    local tooltipText = Details.tooltipText or "";
    local disabledTooltipText = Details.disabledTooltipText or "";
    local position = Details.position or "TOPRIGHT";
    local x = Details.x;
    local y = Details.y;
    local width = Details.width or 24;
    local height = Details.height or 24;
    local update = Details.update or nil;
    local updateOn = Details.updateOn or {};
    local fireUpdateOnCreation = Details.updateOnCreate;

    fireUpdateOnCreation = fireUpdateOnCreation ~= false;

    if (type(updateOn) ~= "table") then
        updateOn = { updateOn };
    end

    -- Check if Parent is a AceGUI element
    if (Parent.frame) then
        Parent = Parent.frame;
    end

    local name = "ShareButton" .. GL:uuid();
    local ShareButton = self:createFrame("Button", name, Parent, "UIPanelButtonTemplate");
    ShareButton:SetSize(width, height);

    if (position == "TOPRIGHT") then
        ShareButton:SetPoint("TOPRIGHT", Parent, "TOPRIGHT", x or -20, y or -20);
    elseif (position == "TOPCENTER") then
        ShareButton:SetPoint("TOP", Parent, "TOP", x or 0, y or -7);
        ShareButton:SetPoint("CENTER", Parent, "CENTER");
    else
        ShareButton:SetPoint("TOPRIGHT", Parent, "TOPRIGHT", x or -20, y or -20);
    end

    -- Make sure the tooltip still shows even when the button is disabled
    if (disabledTooltipText) then
        ShareButton:SetMotionScriptsWhileDisabled(true);
    end

    local HighlightTexture = ShareButton:CreateTexture();
    HighlightTexture:SetTexture("Interface\\AddOns\\Gargul\\Assets\\Buttons\\share-highlighted");
    HighlightTexture:SetPoint("CENTER", ShareButton, "CENTER", 0, 0);
    HighlightTexture:SetSize(width, height);

    ShareButton:SetNormalTexture("Interface\\AddOns\\Gargul\\Assets\\Buttons\\share");
    ShareButton:SetHighlightTexture(HighlightTexture);
    ShareButton:SetDisabledTexture("Interface\\AddOns\\Gargul\\Assets\\Buttons\\share-disabled");

    -- Show the tooltip on hover
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
        ShareButton:SetScript("OnClick", function(_, button)
            if (ShareButton:IsEnabled() or alwaysFireOnClick) then
                return;
            end

            if (button == 'LeftButton') then
                onClick();
            end
        end);
    end

    if (type(update) == "function") then
        ShareButton.update = update;

        for _, event in pairs(updateOn) do
            GL.Events:register(name .. event .. "Listener", event, function () ShareButton:update(); end);
        end

        if (fireUpdateOnCreation) then
            ShareButton:update();
        end
    end

    ShareButton:Show();

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