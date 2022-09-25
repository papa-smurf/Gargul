---@type GL
local _, GL = ...;

---@class GDKPBidderInterface
GL:tableSet(GL, "Interface.GDKP.Bidder", {
    Window = nil,
});
local Bidder = GL.Interface.GDKP.Bidder; ---@type GDKPBidderInterface

---@return boolean
function Bidder:show(...)
    GL:debug("Bidder:show");

    if (self.Window and self.Window:IsShown()) then
        return false;
    end

    self:draw(...);
end

--- Note: we're not using AceGUI here since getting a SimpleGroup to move properly is a friggin nightmare
---
---@param time number The duration of the RollOff
---@param itemLink string
---@param itemIcon string
---@return boolean
function Bidder:draw(time, itemLink, itemIcon)
    GL:debug("Bidder:draw");

    local Window = CreateFrame("Frame", "GARGUL_GDKP_BIDDER_WINDOW", UIParent, Frame);
    Window:Hide();
    Window:SetSize(300, 96);
    Window:SetPoint(GL.Interface:getPosition("Roller"));

    Window:SetMovable(true);
    Window:EnableMouse(true);
    Window:SetClampedToScreen(true);
    Window:SetFrameStrata("HIGH");
    Window:RegisterForDrag("LeftButton");
    Window:SetScript("OnDragStart", Window.StartMoving);
    Window:SetScript("OnDragStop", function()
        Window:StopMovingOrSizing();
        GL.Interface:storePosition(Window, "Roller");
    end);
    Window:SetScript("OnMouseDown", function (_, button)
        -- Close the roll window on right-click
        if (button == "RightButton") then
            self:hide();
        end
    end);
    self.Window = Window;

    local Texture = Window:CreateTexture(nil,"BACKGROUND");
    Texture:SetColorTexture(0, 0, 0, .6);
    Texture:SetAllPoints(Window)
    Window.texture = Texture;

    self:drawCountdownBar(time, itemLink, itemIcon);

    local TopBidder = Window:CreateFontString(nil, "ARTWORK", "GameFontWhite");
    TopBidder:SetPoint("CENTER", Window, "CENTER", 0, 12);
    GL.Interface:setItem(self, "TopBidder", TopBidder);

    local NewBid = Window:CreateFontString(nil, "ARTWORK", "GameFontWhite");
    NewBid:SetPoint("TOPLEFT", Window, "TOPLEFT", 44, -51);
    NewBid:SetText("New bid");

    local BidButton, BidButtonClick;
    local BidInput = CreateFrame("EditBox", "GARGUL_GDKP_BIDDER_BID_INPUT", Window, "InputBoxTemplate");
    BidInput:SetSize(70, 20);
    BidInput:SetPoint("TOPLEFT", NewBid, "TOPRIGHT", 12, 4);
    BidInput:SetAutoFocus(false);
    BidInput:SetCursorPosition(0);
    BidInput:SetScript("OnEnterPressed", function()
        BidButtonClick();
    end);

    local MinimumButton = CreateFrame("Button", "GARGUL_GDKP_BIDDER_MINIMUM_BUTTON", Window, "GameMenuButtonTemplate");
    MinimumButton:SetPoint("TOPLEFT", BidInput, "TOPRIGHT", 4, 0);
    MinimumButton:SetSize(78, 21); -- Minimum width is
    MinimumButton:SetText("Minimum");
    MinimumButton:SetNormalFontObject("GameFontNormal");
    MinimumButton:SetHighlightFontObject("GameFontNormal");
    MinimumButton:SetScript("OnClick", function ()
        BidInput:SetText(GL.GDKP:lowestValidBid());
    end);

    BidButtonClick = function ()
        GL.GDKP:bid(BidInput:GetText());
        BidInput:SetText("");
        BidInput:ClearFocus();
    end;

    --[[ ENABLE THIS INSTEAD ONCE AUTOBID IS ADDED
    BidButton = CreateFrame("Button", "GARGUL_GDKP_BIDDER_BID_BUTTON", Window, "GameMenuButtonTemplate");
    BidButton:SetPoint("TOPLEFT", NewBid, "BOTTOMLEFT", -20, -10);
    BidButton:SetSize(60, 20); -- Minimum width is
    BidButton:SetText("Bid");
    BidButton:SetNormalFontObject("GameFontNormal");
    BidButton:SetHighlightFontObject("GameFontNormal");
    BidButton:SetScript("OnClick", function ()
        BidButtonClick();
    end);

    local AutoBidButton = CreateFrame("Button", "GARGUL_GDKP_BIDDER_AUTO_BID_BUTTON", Window, "GameMenuButtonTemplate");
    AutoBidButton:SetPoint("TOPLEFT", BidButton, "TOPRIGHT", 8, 0);
    AutoBidButton:SetSize(110, 20); -- Minimum width is
    AutoBidButton:SetText("Stop Auto Bid");
    AutoBidButton:SetText("Auto Bid");
    AutoBidButton:SetNormalFontObject("GameFontNormal");
    AutoBidButton:SetHighlightFontObject("GameFontNormal");
    AutoBidButton:SetScript("OnClick", function ()
        GL:dump("AUTO BID!");
    end);

    local PassButton = CreateFrame("Button", "GARGUL_GDKP_BIDDER_PASS_BUTTON", Window, "GameMenuButtonTemplate");
    PassButton:SetPoint("TOPLEFT", AutoBidButton, "TOPRIGHT", 8, 0);
    PassButton:SetSize(64, 20); -- Minimum width is
    PassButton:SetText("Pass");
    PassButton:SetNormalFontObject("GameFontNormal");
    PassButton:SetHighlightFontObject("GameFontNormal");
    PassButton:SetScript("OnClick", function ()
        GL:dump("PASS!");
    end);
    --]]

    BidButton = CreateFrame("Button", "GARGUL_GDKP_BIDDER_BID_BUTTON", Window, "GameMenuButtonTemplate");
    BidButton:SetPoint("TOPLEFT", NewBid, "BOTTOMLEFT", 36, -10);
    BidButton:SetSize(60, 20); -- Minimum width is
    BidButton:SetText("Bid");
    BidButton:SetNormalFontObject("GameFontNormal");
    BidButton:SetHighlightFontObject("GameFontNormal");
    BidButton:SetScript("OnClick", function ()
        BidButtonClick();
    end);

    local PassButton = CreateFrame("Button", "GARGUL_GDKP_BIDDER_PASS_BUTTON", Window, "GameMenuButtonTemplate");
    PassButton:SetPoint("TOPLEFT", BidButton, "TOPRIGHT", 8, 0);
    PassButton:SetSize(64, 20); -- Minimum width is
    PassButton:SetText("Pass");
    PassButton:SetNormalFontObject("GameFontNormal");
    PassButton:SetHighlightFontObject("GameFontNormal");
    PassButton:SetScript("OnClick", function ()
        GL:dump("PASS!");
    end);

    self:refresh();

    Window:Show();

    -- YOU should be GREEN, other player should be RED!

    --[[
    ---------- Countdown Bar ----------
         TOP BIDDER: YOU WITH 5000g
            NEW BID [________]
        <BID>   <AUTO BID>   <PASS>
    ]]

    --[[
    ---------- Countdown Bar ----------
      TOP BIDDER: PLAYER X WITH 5000g
        NEW BID [MINIMUM INCREMENT]
        <BID>   <AUTO BID>   <PASS>
    ]]

    --[[
    ---------- Countdown Bar ----------
         TOP BIDDER: YOU WITH 5000g
            NEW BID [________]
      <BID>   <STOP AUTO BID>   <PASS>
    ]]
end

function Bidder:refresh()
    local TopBidderLabel = GL.Interface:getItem(self, "Frame.TopBidder");

    if (not TopBidderLabel) then
        return;
    end

    local TopBid = GL:tableGet(GL.GDKP, "CurrentAuction.TopBid", {});
    if (TopBid and TopBid.bid) then
        -- We're the highest bidder, NICE!
        if (string.lower(TopBid.Bidder.name) == string.lower(GL.User.name)) then
            TopBidderLabel:SetText(string.format("Top bidder: |c001Eff00%s|r with %s|c00FFF569g|r",
                "You",
                TopBid.bid
            ));
        else
            TopBidderLabel:SetText(string.format("Top bidder: |c00%s%s|r with %s|c00BE3333g|r",
                GL:classHexColor(TopBid.Bidder.class),
                TopBid.Bidder.name,
                TopBid.bid
            ));
        end
    end
end

--- Draw the countdown bar
---
---@param time number
---@param itemLink string
---@param itemIcon string
---@return void
function Bidder:drawCountdownBar(time, itemLink, itemIcon)
    GL:debug("Bidder:drawCountdownBar");

    -- This shouldn't be possible but you never know!
    if (not self.Window) then
        return false;
    end

    local TimerBar = LibStub("LibCandyBarGargul-3.0"):New(
        "Interface\\AddOns\\Gargul\\Assets\\Textures\\timer-bar",
        300,
        24
    );

    TimerBar:SetParent(self.Window);
    TimerBar:SetPoint("TOP", self.Window, "TOP");
    TimerBar.candyBarLabel:SetFont("Fonts\\ARIALN.ttf", 13, "OUTLINE");

    -- Make the bar turn green/yellow/red based on time left
    TimerBar:AddUpdateFunction(function (Bar)
        local percentageLeft = 100 / (time / Bar.remaining);

        if (percentageLeft >= 60) then
            Bar:SetColor(0, 1, 0, .3);
        elseif (percentageLeft >= 30) then
            Bar:SetColor(1, 1, 0, .3);
        else
            Bar:SetColor(1, 0, 0, .3);
        end
    end);

    -- Close the roll window on rightclick
    TimerBar:SetScript("OnMouseDown", function(_, button)
        if (button == "RightButton") then
            self:hide();
        end
    end)

    TimerBar:SetScript("OnLeave", function()
        GameTooltip:Hide();
    end);

    TimerBar:SetDuration(time);
    TimerBar:SetColor(0, 1, 0, .3); -- Reset color to green
    TimerBar:SetLabel("  " .. itemLink .. " ");

    TimerBar:SetIcon(itemIcon);
    TimerBar:Set("type", "ROLLER_UI_COUNTDOWN");
    TimerBar:Start();

    -- Show a gametooltip for the item up for roll
    -- when hovering over the progress bar
    TimerBar:SetScript("OnEnter", function()
        GameTooltip:SetOwner(self.Window, "ANCHOR_TOP");
        GameTooltip:SetHyperlink(itemLink);
        GameTooltip:Show();
    end);
end

---@return void
function Bidder:hide()
    GL:debug("Bidder:hide");

    if (not self.Window) then
        return;
    end

    self.Window:Hide();
    self.Window = nil;
end

GL:debug("Bidder.lua");