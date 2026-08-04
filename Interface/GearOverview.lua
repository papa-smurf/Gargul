local L = Gargul_L;

---@type GL
local _, GL = ...;

---@type Interface
local Interface = GL.Interface;

---@class GearOverviewInterface
local GearOverview = {
    windowName = "Gargul.Interface.GearOverview",

    --- Bumped on every refresh so late item callbacks can't write into rows
    --- that have since been handed to a different player
    renderID = 0,
};

---@type GearOverviewInterface
GL.Interface.GearOverview = GearOverview;

--[[ CONSTANTS ]]
local WINDOW_WIDTH = 450;
local WINDOW_HEIGHT = 420;
local ROW_HEIGHT = 22;
local ICON_SIZE = 16;
local ICON_PITCH = 18;
local NAME_WIDTH = 108;
local AGE_WIDTH = 40;

--- Compact "how long ago did we learn this" label, kept short enough for its column.
---
---@param timestamp number|nil
---@return string
local function ageLabel(timestamp)
    if (not timestamp) then
        return "";
    end

    local seconds = math.max(GetServerTime() - timestamp, 0);

    if (seconds < 60) then
        return L["now"];
    end

    if (seconds < 3600) then
        return ("%dm"):format(math.floor(seconds / 60));
    end

    return ("%dh"):format(math.floor(seconds / 3600));
end

--- Open the window, or close it when it's already open.
---
---@return nil
function GearOverview:toggle()
    local Window = self:getWindow();

    if (Window and Window:IsShown()) then
        self:close();
        return;
    end

    self:open();
end

---@return Frame
function GearOverview:open()
    local Window = self:getWindow() or self:build();

    self:registerListeners();
    self:refresh();
    Window:Show();

    return Window;
end

---@return nil
function GearOverview:close()
    local Window = self:getWindow();

    if (Window) then
        Window:Hide();
    end
end

---@return Frame
function GearOverview:build()
    if (_G[self.windowName]) then
        return _G[self.windowName];
    end

    ---@type Frame
    local Window = Interface:createWindow({
        name = self.windowName,
        width = WINDOW_WIDTH,
        height = WINDOW_HEIGHT,
        minWidth = WINDOW_WIDTH,
        maxWidth = WINDOW_WIDTH,
        minHeight = 220,
        maxHeight = 800,
        hideMinimizeButton = true,
        OnClose = function ()
            self:onHide();
        end,
    });

    --[[ THE SETTINGS MENU IN THE TOP LEFT OF THE WINDOW ]]
    Interface:addWindowOptions(Window, {
        { text = L["Adjust Scale"], notCheckable = true, func = function ()
            Interface:openScaler(Window);
            CloseMenus();
        end }
    }, 100);

    --[[ COLUMN HEADERS ]]
    ---@type FontString
    local PlayerLabel = Interface:createFontString(Window, L["Player"]);
    PlayerLabel:SetPoint("TOPLEFT", Window, "TOPLEFT", 20, -20);

    --- The rows below show a relative age ("now", "4m", "2h") for the gear we know
    ---@type FontString
    local AgeLabel = Interface:createFontString(Window, L["Seen"]);
    AgeLabel:SetPoint("TOPLEFT", PlayerLabel, "TOPLEFT", NAME_WIDTH, 0);

    ---@type FontString
    local GearLabel = Interface:createFontString(Window, L["Gear"]);
    GearLabel:SetPoint("TOPLEFT", PlayerLabel, "TOPLEFT", NAME_WIDTH + AGE_WIDTH, 0);

    --[[ SCROLLFRAME BOILERPLATE ]]
    ---@type ScrollFrame
    local ScrollFrame = CreateFrame("ScrollFrame", nil, Window, "UIPanelScrollFrameTemplate");
    ScrollFrame:SetPoint("TOP", PlayerLabel, "BOTTOM", 0, -8);
    ScrollFrame:SetPoint("BOTTOM", Window, "BOTTOM", 0, 50);
    ScrollFrame:SetPoint("LEFT", Window, "LEFT", 16);
    ScrollFrame:SetPoint("RIGHT", Window, "RIGHT", -34, 0);

    ---@type Frame
    local PlayerHolder = CreateFrame("Frame", nil, ScrollFrame);
    PlayerHolder:SetSize(WINDOW_WIDTH - 50, 1);
    ScrollFrame:SetScrollChild(PlayerHolder);

    Window._ScrollFrame = ScrollFrame;
    Window._PlayerHolder = PlayerHolder;
    Window._Rows = {};

    --[[ FOOTER ]]
    ---@type FontString
    local Summary = Interface:createFontString(Window, "");
    Summary:SetPoint("BOTTOMLEFT", Window, "BOTTOMLEFT", 20, 30);
    Summary:SetColor("GRAY");
    Window._Summary = Summary;

    return Window;
end

--- Fetch (or lazily create) the row at the given index.
---
---@param Window Frame
---@param index number
---@return Frame
function GearOverview:getRow(Window, index)
    local Row = Window._Rows[index];

    if (Row) then
        return Row;
    end

    ---@type Button
    Row = CreateFrame("Button", nil, Window._PlayerHolder);
    Row:SetHeight(ROW_HEIGHT);
    Row:SetPoint("LEFT", Window._PlayerHolder, "LEFT", 0, 0);
    Row:SetPoint("RIGHT", Window._PlayerHolder, "RIGHT", 0, 0);

    Row.Highlight = Row:CreateTexture(nil, "BACKGROUND");
    Row.Highlight:SetAllPoints(Row);
    Row.Highlight:SetColorTexture(1, 1, 1, .05);
    Row.Highlight:Hide();

    Row.Name = Row:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall");
    Row.Name:SetPoint("LEFT", Row, "LEFT", 4, 0);
    Row.Name:SetWidth(NAME_WIDTH);
    Row.Name:SetJustifyH("LEFT");
    Row.Name:SetWordWrap(false);

    Row.Age = Row:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall");
    Row.Age:SetPoint("LEFT", Row, "LEFT", 4 + NAME_WIDTH, 0);
    Row.Age:SetWidth(AGE_WIDTH);
    Row.Age:SetJustifyH("LEFT");

    Row.Status = Row:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall");
    Row.Status:SetPoint("LEFT", Row, "LEFT", 4 + NAME_WIDTH + AGE_WIDTH, 0);
    Row.Status:SetJustifyH("LEFT");

    Row.Icons = {};

    Row:SetScript("OnEnter", function ()
        Row.Highlight:Show();
    end);
    Row:SetScript("OnLeave", function ()
        Row.Highlight:Hide();
    end);

    Window._Rows[index] = Row;

    return Row;
end

--- Fetch (or lazily create) the gear icon at the given index within a row.
---
---@param Row Frame
---@param index number
---@return Button
function GearOverview:getIcon(Row, index)
    local Icon = Row.Icons[index];

    if (Icon) then
        return Icon;
    end

    ---@type Button
    Icon = CreateFrame("Button", nil, Row, "BackdropTemplate");
    Icon:SetSize(ICON_SIZE, ICON_SIZE);
    Icon:SetPoint("LEFT", Row, "LEFT", 4 + NAME_WIDTH + AGE_WIDTH + ((index - 1) * ICON_PITCH), 0);
    Icon:SetBackdrop({ edgeFile = "Interface/Buttons/WHITE8X8", edgeSize = 1, });

    Icon.Texture = Icon:CreateTexture(nil, "ARTWORK");
    Icon.Texture:SetPoint("TOPLEFT", Icon, "TOPLEFT", 1, -1);
    Icon.Texture:SetPoint("BOTTOMRIGHT", Icon, "BOTTOMRIGHT", -1, 1);

    Icon:SetScript("OnLeave", function ()
        GameTooltip:Hide();
        Row.Highlight:Hide();
    end);

    Row.Icons[index] = Icon;

    return Icon;
end

--- Redraw every row from the gear we currently know about.
---
---@return nil
function GearOverview:refresh()
    local Window = self:getWindow();

    if (not Window) then
        return;
    end

    self.renderID = self.renderID + 1;
    local renderID = self.renderID;

    local Members = {};
    GL:forEachGroupMember(function (Member)
        tinsert(Members, Member);
    end);

    table.sort(Members, function (a, b)
        return strlower(a.name or "") < strlower(b.name or "");
    end);

    local knownFor = 0;

    for index, Member in ipairs(Members) do
        local Row = self:getRow(Window, index);
        Row:ClearAllPoints();
        Row:SetPoint("TOPLEFT", Window._PlayerHolder, "TOPLEFT", 20, (index - 1) * -ROW_HEIGHT);
        Row:SetPoint("RIGHT", Window._PlayerHolder, "RIGHT", 0, 0);

        local playerKey = GL.RollOff:gearPlayerKey(Member.fqn);
        local Gear = playerKey and GL.RollOff.EquippedGearByPlayer[playerKey] or nil;
        local wasInspected = playerKey and GL.RollOff.GearWasInspectedByPlayer[playerKey];
        local Color = GL:classRGBAColor(Member.class);

        Row.Name:SetText(GL:formatPlayerName(Member.name));
        Row.Name:SetTextColor(Color.r, Color.g, Color.b);
        Row.Age:SetText(playerKey and ageLabel(GL.RollOff.GearReceivedAt[playerKey]) or "");

        self:fillRow(Row, Member, Gear, wasInspected, renderID);

        if (Gear and next(Gear)) then
            knownFor = knownFor + 1;
        end

        Row:Show();
    end

    for index = #Members + 1, #Window._Rows do
        Window._Rows[index]:Hide();
    end

    Window._PlayerHolder:SetSize(
        math.max(Window._ScrollFrame:GetWidth(), 1),
        math.max(#Members * ROW_HEIGHT, 1)
    );

    if (knownFor < 1) then
        Window._Summary:SetText(L["Gear shows up here as soon as players roll on an item"]);
    else
        Window._Summary:SetText((L["Gear known for %s of %s players"]):format(knownFor, #Members));
    end

    Window._Summary:SetColor("GRAY");
end

--- Fill a single row's gear icons, tooltips and click behaviour.
---
---@param Row Frame
---@param Member table
---@param Gear table|nil
---@param wasInspected boolean|nil
---@param renderID number
---@return nil
function GearOverview:fillRow(Row, Member, Gear, wasInspected, renderID)
    local Equipped = Gear or {};
    local Slots = {};

    for slot in pairs(Equipped) do
        tinsert(Slots, slot);
    end
    table.sort(Slots);

    -- Nothing known yet: say so and make the row inert
    if (GL:empty(Slots)) then
        Row.Status:SetText(L["No gear seen yet"]);
        Row.Status:Show();
        Row:SetScript("OnClick", nil);

        for _, Icon in pairs(Row.Icons) do
            Icon:Hide();
        end

        return;
    end

    local openPanel = function ()
        -- Anchored to the window rather than the row so scrolling can't drag it off-screen
        GL.Interface.GearPanel:toggle(Member.fqn, self:getWindow(), {
            point = "TOPLEFT",
            relativePoint = "TOPRIGHT",
            x = 4,
            y = 0,
        });
    end;

    Row.Status:Hide();
    Row:SetScript("OnClick", openPanel);

    -- Inspected gear is a best guess rather than something the player told us
    local alpha = wasInspected and .6 or 1;
    local placeholderIcon = GL.Data.Constants.gearPlaceholderIcon;

    for position, slot in ipairs(Slots) do
        local Icon = self:getIcon(Row, position);
        local dehydratedLink = Equipped[slot];

        Icon.Texture:SetTexture(placeholderIcon);
        Icon.Texture:SetAlpha(alpha);
        Icon:SetBackdropBorderColor(.5, .5, .5, alpha);
        Icon:SetScript("OnEnter", nil);
        Icon:SetScript("OnClick", nil);
        Icon:Show();

        GL:hydrateItemLink(dehydratedLink, function (itemLink)
            if (not itemLink or self.renderID ~= renderID) then
                return;
            end

            Icon:SetScript("OnEnter", function ()
                Row.Highlight:Show();
                GameTooltip:SetOwner(Icon, "ANCHOR_RIGHT");
                GameTooltip:SetHyperlink(itemLink);
                GameTooltip:Show();
            end);

            Icon:SetScript("OnClick", openPanel);

            GL:onItemLoadDo(itemLink, function (Details)
                if (not Details or self.renderID ~= renderID) then
                    return;
                end

                Icon.Texture:SetTexture(Details.icon or placeholderIcon);

                local QColor = ITEM_QUALITY_COLORS and ITEM_QUALITY_COLORS[Details.quality] or { r = .5, g = .5, b = .5, };
                Icon:SetBackdropBorderColor(QColor.r, QColor.g, QColor.b, alpha);
            end);
        end);
    end

    for position = #Slots + 1, #Row.Icons do
        Row.Icons[position]:Hide();
    end
end

--- Keep the window in sync while it's open, and stop doing so once it isn't.
---
---@return nil
function GearOverview:registerListeners()
    GL.Events:register("GearOverviewGearReceivedListener", "GL.ROLLOFF_GEAR_RECEIVED", function ()
        GL:after(.5, "GearOverview.refresh", function ()
            self:refresh();
        end);
    end);

    GL.Events:register("GearOverviewRosterUpdatedListener", "GL.GROUP_ROSTER_UPDATE_THROTTLED", function ()
        self:refresh();
    end);
end

---@return nil
function GearOverview:onHide()
    GL.Events:unregister("GearOverviewGearReceivedListener");
    GL.Events:unregister("GearOverviewRosterUpdatedListener");

    GL.Interface.GearPanel:hide();
end

---@return Frame|nil
function GearOverview:getWindow()
    return _G[self.windowName];
end
