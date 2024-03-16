local L = Gargul_L;

---@type GL
local _, GL = ...;

---@type Settings
local Settings = GL.Settings;

---@type Interface
local Interface = GL.Interface;

---@type GDKP
local GDKP = GL.GDKP;

---@class GDKPMultiAuctionAddItemInterface
GL:tableSet(GL, "Interface.GDKP.MultiAuction.AddItem", {
    windowName = "Gargul.Interface.GDKP.MultiAuction.AddItem.Window",

    ItemRows = {},
});

---@type GDKPMultiAuctionAddItemInterface
local AddItem = GL.Interface.GDKP.MultiAuction.AddItem;

--[[ CONSTANTS ]]
local FONT;

---@return Frame|nil
function AddItem:open(link)
    if (self:isShown()) then
        return;
    end

    local itemID = GL:getItemIDFromLink(link);
    if (not itemID) then
        return;
    end

    FONT = GL.FONT;
    local Window = self:getWindow() or self:build();

    -- Update the window with the correct data
    do
        local PerItemSettings;
        PerItemSettings = GDKP:settingsForItemID(itemID);

        Window.ItemLink:SetText(link);
        Window.Minimum:SetText(PerItemSettings.minimum);
        Window.Increment:SetText(PerItemSettings.increment);

        local AuctionDetails = GL:tableGet(GDKP, "MultiAuction.Client.AuctionDetails.Auctions", {});
        local highestEndsAt = 0;
        local serverTime = GetServerTime();
        for _, Details in pairs(AuctionDetails or {}) do
            if (Details.endsAt > highestEndsAt
                and Details.endsAt > (serverTime + 20)
            ) then
                highestEndsAt = Details.endsAt;
            end
        end

        Window.Duration:SetText(highestEndsAt > 0 and highestEndsAt - serverTime or Settings:get("GDKP.time"));
    end

    return Window:Show() and Window;
end

---@return void
function AddItem:close()
    local Window = self:getWindow() or self:build();

    Window:Hide();
end

---@return boolean
function AddItem:isShown()
    local Window = self:getWindow();

    return Window and Window:IsShown();
end

---@return Frame
function AddItem:build()
    if (_G[self.windowName]) then
        return _G[self.windowName];
    end

    ---@type Frame
    local Window = Interface:createWindow{
        name = self.windowName,
        width = 315,
        minWidth = 315,
        height = 128,
        minHeight = 128,
        hideMinimizeButton = true,
    };

    --[[ THE SETTINGS MENU IN THE TOP LEFT OF THE WINDOW ]]
    Interface:addWindowOptions(Window, {
        { text = L.CHANGE_SCALE, notCheckable = true, func = function ()
            Interface:openScaler(Window);
            CloseMenus();
        end }
    }, 100);

    --[[ ITEM LINK ]]
    ---@type FontString
    local ItemLink = Interface:createFontString(Window);
    ItemLink:SetPoint("CENTER", Window, "CENTER");
    ItemLink:SetPoint("TOP", Window, "TOP", 0, -20);
    Window.ItemLink = ItemLink;

    --[[ MINIMUM ]]
    ---@type FontString
    local MinimumLabel = Interface:createFontString(Window, L.MIN);
    MinimumLabel:SetPoint("TOP", ItemLink, "BOTTOM", 0, -18);
    MinimumLabel:SetPoint("LEFT", Window, "LEFT", 30, 0);

    ---@type EditBox
    local Minimum = Interface:numericInputBox(Window, nil, nil, Settings:get("GDKP.precision"));
    Minimum:SetWidth(42);
    Minimum:SetPoint("TOPLEFT", MinimumLabel, "TOPRIGHT", 6, 6);
    Window.Minimum = Minimum;

    --[[ INCREMENT ]]
    ---@type FontString
    local IncrementLabel = Interface:createFontString(Window, L.INCREMENT);
    IncrementLabel:SetPoint("TOPLEFT", Minimum, "TOPRIGHT", 10, -6);

    ---@type EditBox
    local Increment = Interface:numericInputBox(Window, nil, nil, Settings:get("GDKP.precision"));
    Increment:SetWidth(36);
    Increment:SetPoint("TOPLEFT", IncrementLabel, "TOPRIGHT", 6, 6);
    Window.Increment = Increment;

    --[[ DURATION ]]
    ---@type FontString
    local DurationLabel = Interface:createFontString(Window, L.TIME);
    DurationLabel:SetPoint("TOPLEFT", Increment, "TOPRIGHT", 10, -6);

    ---@type EditBox
    local Duration = Interface:inputBox(Window);
    Duration:SetNumeric(true);
    Duration:SetWidth(42);
    Duration:SetPoint("TOPLEFT", DurationLabel, "TOPRIGHT", 6, 6);
    Window.Duration = Duration;

    local OKButton = Interface:dynamicPanelButton(Window, L.OK);
    OKButton:SetPoint("BOTTOMLEFT", Window, "BOTTOMLEFT", 20, 30);
    OKButton:SetScript("OnClick", function ()
        local link = Window.ItemLink:GetText();
        local minimum = Window.Minimum:GetText() or 0;
        local increment = Window.Increment:GetText() or 0;
        local duration = Window.Duration:GetText() or 5;

        -- Shenanigans?!
        if (not link or not GL:getItemIDFromLink(link)) then
            return;
        end

        if (not duration or duration < 5) then
            duration = 5;
        end

        GL.GDKP.MultiAuction.Client:addToCurrentSession{
            link = link,
            duration = duration,
            minimum = minimum,
            increment = increment,
        };

        self:close();
    end);

    local CancelButton = Interface:dynamicPanelButton(Window, L.CANCEL);
    CancelButton:SetPoint("BOTTOMRIGHT", Window, "BOTTOMRIGHT", -20, 30);
    CancelButton:SetScript("OnClick", function ()
        self:close();
    end);

    return Window;
end

---@return Frame
function AddItem:getWindow()
    return _G[self.windowName];
end