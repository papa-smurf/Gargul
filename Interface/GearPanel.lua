local L = Gargul_L;

---@type GL
local _, GL = ...;

---@class GearPanel
GL.Interface.GearPanel = GL.Interface.GearPanel or {
    panelPlayer = nil,
    Panel = nil,

    --- Bumped on every render so late item callbacks from a previous player
    --- can't write into rows that now belong to someone else
    renderID = 0,
};

---@type GearPanel
local GearPanel = GL.Interface.GearPanel;

--- Hide the panel.
---@return nil
function GearPanel:hide()
    if (self.Panel) then
        self.Panel:Hide();
    end

    self.panelPlayer = nil;
end

--- Toggle the panel for a player; hide when already showing that player.
---
---@param playerFQN string
---@param AnchorFrame Frame
---@param AnchorArgs table { point, relativePoint, x, y }
---@return nil
function GearPanel:toggle(playerFQN, AnchorFrame, AnchorArgs)
    local playerKey = GL.RollOff:gearPlayerKey(playerFQN);
    if (not playerKey) then
        return;
    end

    if (self.panelPlayer == playerKey) then
        self:hide();
        return;
    end

    self:show(playerKey, AnchorFrame, AnchorArgs);
end

--- Show all worn gear for a player beside an anchor frame.
---
---@param playerKey string
---@param AnchorFrame Frame
---@param AnchorArgs table { point, relativePoint, x, y }
---@return nil
function GearPanel:show(playerKey, AnchorFrame, AnchorArgs)
    local gear = GL.RollOff.EquippedGearByPlayer[playerKey];
    if (not gear or not next(gear)) then
        self:hide();
        return;
    end

    local Panel = self.Panel;
    if (not Panel) then
        Panel = CreateFrame("Frame", "GARGUL_GEAR_PANEL", UIParent, "BackdropTemplate");
        Panel:SetBackdrop({
            bgFile = "Interface/DialogFrame/UI-DialogBox-Background",
            edgeFile = "Interface/DialogFrame/UI-DialogBox-Border",
            tile = true,
            tileSize = 32,
            edgeSize = 16,
            insets = { left = 4, right = 4, top = 4, bottom = 4, },
        });
        Panel.Rows = {};
        Panel.NameLabel = Panel:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall");
        Panel.NameLabel:SetPoint("TOPLEFT", Panel, "TOPLEFT", 8, -14);
        Panel.NameLabel:SetWidth(148);
        Panel.InspectWarning = CreateFrame("Frame", nil, Panel);
        Panel.InspectWarning:SetSize(14, 14);
        Panel.InspectWarning:SetPoint("TOPLEFT", Panel, "TOPLEFT", 10, -12);
        Panel.InspectWarning.Icon = Panel.InspectWarning:CreateTexture(nil, "ARTWORK");
        Panel.InspectWarning.Icon:SetAllPoints(Panel.InspectWarning);
        Panel.InspectWarning.Icon:SetTexture("Interface/DialogFrame/UI-Dialog-Icon-AlertNew");
        Panel.InspectWarning:SetScript("OnEnter", function ()
            GameTooltip:SetOwner(Panel.InspectWarning, "ANCHOR_RIGHT");
            GameTooltip:SetText(L["Inspected gear: less reliable because this player doesn't have Gargul"]);
            GameTooltip:Show();
        end);
        Panel.InspectWarning:SetScript("OnLeave", function ()
            GameTooltip:Hide();
        end);
        Panel.InspectWarning:Hide();
        GL.Interface:addCloseButton(Panel);
        Panel.CloseButton:SetScript("OnClick", function ()
            GearPanel:hide();
        end);
        self.Panel = Panel;
    end

    -- Ride along with whichever window opened us so we're never buried behind it
    Panel:SetFrameStrata(AnchorFrame and AnchorFrame:GetFrameStrata() or "DIALOG");
    Panel:SetFrameLevel((AnchorFrame and AnchorFrame:GetFrameLevel() or 0) + 10);
    Panel.CloseButton:SetFrameLevel(Panel:GetFrameLevel() + 10);

    self.renderID = self.renderID + 1;
    local renderID = self.renderID;

    local slots = {};
    for slot in pairs(gear) do
        table.insert(slots, slot);
    end
    table.sort(slots);

    local baseName = (strsplit("-", playerKey));
    local playerClass;
    for _, Roll in pairs(GL.RollOff.CurrentRollOff.Rolls or {}) do
        if (GL.RollOff:gearPlayerKey(Roll.player) == playerKey) then
            playerClass = Roll.class;
            break;
        end
    end
    if (not playerClass) then
        for _, Player in pairs(GL.User:groupMembers()) do
            if (GL.RollOff:gearPlayerKey(Player.fqn) == playerKey) then
                playerClass = Player.class;
                break;
            end
        end
    end
    local C = GL:classRGBAColor(playerClass);
    local colorizedName = ("|cFF%02X%02X%02X%s|r"):format(C.r * 255, C.g * 255, C.b * 255, baseName);

    Panel.NameLabel:SetText(colorizedName);

    -- The warning icon sits where the name starts, so make room for it when shown
    Panel.NameLabel:ClearAllPoints();
    if (GL.RollOff.GearWasInspectedByPlayer[playerKey]) then
        Panel.InspectWarning:Show();
        Panel.NameLabel:SetPoint("TOPLEFT", Panel, "TOPLEFT", 28, -14);
    else
        Panel.InspectWarning:Hide();
        Panel.NameLabel:SetPoint("TOPLEFT", Panel, "TOPLEFT", 8, -14);
    end

    local rowHeight = 20;
    local yOffset = -30;

    for i, slot in ipairs(slots) do
        local dehydratedLink = gear[slot];

        local Row = Panel.Rows[i];
        if (not Row) then
            Row = CreateFrame("Frame", nil, Panel);
            Row:SetSize(180, rowHeight);
            Row:EnableMouse(true);

            Row.IconBorder = CreateFrame("Frame", nil, Row, "BackdropTemplate");
            Row.IconBorder:SetSize(18, 18);
            Row.IconBorder:SetPoint("LEFT", Row, "LEFT", 0, 0);
            Row.IconBorder:SetBackdrop({ edgeFile = "Interface/Buttons/WHITE8X8", edgeSize = 1, });
            Row.IconBorder:SetBackdropBorderColor(.5, .5, .5);
            Row.IconBorder:EnableMouse(false);

            Row.Icon = Row.IconBorder:CreateTexture(nil, "ARTWORK");
            Row.Icon:SetPoint("TOPLEFT", Row.IconBorder, "TOPLEFT", 1, -1);
            Row.Icon:SetPoint("BOTTOMRIGHT", Row.IconBorder, "BOTTOMRIGHT", -1, 1);

            Row.Text = Row:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall");
            Row.Text:SetPoint("LEFT", Row, "LEFT", 22, 0);
            Row.Text:SetJustifyH("LEFT");
            Row.Text:SetWordWrap(false);
            Row.Text:SetNonSpaceWrap(false);
            Row.Text:SetWidth(154);
            Panel.Rows[i] = Row;
        end

        Row:ClearAllPoints();
        Row:SetPoint("TOPLEFT", Panel, "TOPLEFT", 8, yOffset);
        Row.Icon:SetTexture("Interface/Icons/INV_Misc_QuestionMark");
        Row.IconBorder:SetBackdropBorderColor(.5, .5, .5);
        Row.Text:SetText("...");
        Row:SetScript("OnEnter", nil);

        GL:hydrateItemLink(dehydratedLink, function (itemLink)
            if (not itemLink or self.renderID ~= renderID) then
                return;
            end

            Row.Text:SetText(itemLink);

            Row:SetScript("OnEnter", function ()
                GameTooltip:SetOwner(Row, "ANCHOR_RIGHT");
                GameTooltip:SetHyperlink(itemLink);
                GameTooltip:Show();
            end);

            GL:onItemLoadDo(itemLink, function (Details)
                if (not Details or self.renderID ~= renderID) then
                    return;
                end
                Row.Icon:SetTexture(Details.icon or "Interface/Icons/INV_Misc_QuestionMark");
                local QColor = ITEM_QUALITY_COLORS and ITEM_QUALITY_COLORS[Details.quality] or { r = .5, g = .5, b = .5, };
                Row.IconBorder:SetBackdropBorderColor(QColor.r, QColor.g, QColor.b);
            end);
        end);

        Row:SetScript("OnLeave", function ()
            GameTooltip:Hide();
        end);

        Row:Show();
        yOffset = yOffset - rowHeight;
    end

    for i = #slots + 1, #Panel.Rows do
        Panel.Rows[i]:Hide();
    end

    Panel:SetSize(200, math.abs(yOffset) + 8);
    Panel:ClearAllPoints();

    -- A frame without any points never renders, so always fall back to the screen
    if (AnchorFrame and AnchorArgs) then
        Panel:SetPoint(AnchorArgs.point, AnchorFrame, AnchorArgs.relativePoint, AnchorArgs.x, AnchorArgs.y);
    else
        Panel:SetPoint("CENTER", UIParent, "CENTER", 0, 0);
    end

    Panel:Show();

    self.panelPlayer = playerKey;
end
