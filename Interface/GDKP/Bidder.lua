local L = Gargul_L;

---@type GL
local _, GL = ...;

---@type GDKP
local GDKP = GL.GDKP;

---@type GDKPAuction
local GDKPAuction = GDKP.Auction;

---@type Interface
local Interface = GL.Interface;

---@class GDKPBidderInterface
GL:tableSet(GL, "Interface.GDKP.Bidder", {
    AutoBidButton = nil,
    StopAutoBidButton = nil,
    Window = nil,
    TimerBar = nil,
});
local Bidder = GL.Interface.GDKP.Bidder; ---@type GDKPBidderInterface

--- Adjust the duration shown on the timer bar
---@param time number
---@return boolean
function Bidder:changeDuration(time)
    if (not self.Window
        or not self.Window:IsShown()
        or not self.TimerBar
        or not self.TimerBar.SetDuration
    ) then
        return false;
    end

    self.TimerBar:Stop();
    self.TimerBar:Hide();

    self:drawCountdownBar(time, GDKPAuction.Current.itemLink, GDKPAuction.Current.itemIcon, GDKPAuction.Current.duration);

    return true;
end

---@return boolean
function Bidder:show(...)
    if (self.Window and self.Window:IsShown()) then
        return false;
    end

    self:draw(...);
end

---@return nil
function Bidder:autoBidStopped()
    if (self.AutoBidButton
        and self.AutoBidButton.Show
    ) then
        self.AutoBidButton:Show();
    end

    if (self.StopAutoBidButton
        and self.StopAutoBidButton.Hide
    ) then
        self.StopAutoBidButton:Hide();
    end
end

--- Note: we're not using AceGUI here since getting a SimpleGroup to move properly is a friggin nightmare
---
---@param time number The duration of the RollOff
---@param itemLink string
---@param itemIcon string
---@param bth string
---@return boolean
function Bidder:draw(time, itemLink, itemIcon, bth)
    local Window = CreateFrame("Frame", "GARGUL_GDKP_BIDDER_WINDOW", UIParent);
    Window:Hide();
    Window:SetSize(300, 96);
    Window:SetPoint(GL.Interface:getPosition("Bidder"));

    Window:SetMovable(true);
    Window:EnableMouse(true);
    Window:SetClampedToScreen(true);
    Window:SetFrameStrata("FULLSCREEN_DIALOG");
    Window:RegisterForDrag("LeftButton");
    Window:SetScript("OnDragStart", Window.StartMoving);
    Window:SetScript("OnDragStop", function()
        Window:StopMovingOrSizing();
        GL.Interface:storePosition(Window, "Bidder");
    end);
    Window:SetScript("OnMouseDown", function (_, mouseButtonPressed)
        -- Close the roll window on right-click
        if (mouseButtonPressed == "RightButton") then
            self:hide();
            return;
        end

        HandleModifiedItemClick(itemLink, mouseButtonPressed);
    end);
    Window:SetScale(GL.Settings:get("GDKP.bidderScale", 1));
    self.Window = Window;

    local Texture = Window:CreateTexture(nil,"BACKGROUND");
    Texture:SetColorTexture(0, 0, 0, .6);
    Texture:SetAllPoints(Window)
    Window.texture = Texture;

    local CountDownBarDragger = CreateFrame("Frame", nil, Window);
    CountDownBarDragger:SetPoint("TOPLEFT", Window, "TOPLEFT", 0, 0);
    CountDownBarDragger:SetPoint("TOPRIGHT", Window, "TOPRIGHT", 0, 0);
    CountDownBarDragger:SetHeight(30);
    CountDownBarDragger.ownedByGargul = true;

    CountDownBarDragger:EnableMouse(true);
    CountDownBarDragger:RegisterForDrag("LeftButton");
    CountDownBarDragger:SetScript("OnDragStart", function()
        Window:StartMoving();
    end);
    CountDownBarDragger:SetScript("OnDragStop", function()
        Window:StopMovingOrSizing();
        GL.Interface:storePosition(Window, "Bidder");
    end);

    -- Close the roll window on rightclick
    CountDownBarDragger:SetScript("OnMouseDown", function(_, button)
        if (button == "RightButton") then
            self:hide();
        end
    end)

    local lastShiftStatus;
    local itemTooltipIsShowing = false;
    local refreshTooltip = function ()
        GameTooltip:Hide();

        GameTooltip:SetOwner(CountDownBarDragger, "ANCHOR_TOP");
        GameTooltip:SetHyperlink(itemLink);
        GameTooltip:Show();
        itemTooltipIsShowing = true;
    end;

    CountDownBarDragger:SetScript("OnEnter", function()
        lastShiftStatus = IsShiftKeyDown();

        GameTooltip:SetOwner(CountDownBarDragger, "ANCHOR_TOP");
        GameTooltip:SetHyperlink(itemLink);
        GameTooltip:Show();
        itemTooltipIsShowing = true;
    end);

    CountDownBarDragger:SetScript("OnLeave", function()
        GameTooltip:Hide();
        itemTooltipIsShowing = false;
    end);

    GL.Events:register("BidderModifierStateChanged", "MODIFIER_STATE_CHANGED", function (_, key, pressed)
        if (not itemTooltipIsShowing
            or (key ~= "LSHIFT" and key ~= "RSHIFT")
        ) then
            return;
        end

        if (lastShiftStatus ~= pressed) then
            refreshTooltip();
            lastShiftStatus = pressed;
        end
    end);

    Window.CountDownBarDragger = CountDownBarDragger;

    self:drawCountdownBar(time, itemLink, itemIcon);

    local TopBidder = Window:CreateFontString(nil, "ARTWORK", "GameFontWhite");
    TopBidder:SetPoint("CENTER", Window, "CENTER", 0, 12);
    GL.Interface:set(self, "TopBidder", TopBidder);

    -- Show the minimum bid and increment if no one bid yet
    if (GDKPAuction.Current.minimumBid > 0) then
        local message = (L["Min bid: %sg   Increment: %sg"]):format(GDKPAuction.Current.minimumBid, GDKPAuction.Current.minimumIncrement);
        TopBidder:SetText(message);
    end

    local NewBid = Window:CreateFontString(nil, "ARTWORK", "GameFontWhite");
    NewBid:SetPoint("TOPLEFT", Window, "TOPLEFT", 44, -51);
    NewBid:SetText(L["New bid"]);

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
    MinimumButton:SetPoint("TOPLEFT", NewBid, "BOTTOMLEFT", -28, -10);
    MinimumButton:SetSize(78, 21); -- Minimum width is
    MinimumButton:SetText(L["Minimum"]);
    MinimumButton:SetNormalFontObject("GameFontNormal");
    MinimumButton:SetHighlightFontObject("GameFontNormal");
    MinimumButton:SetScript("OnClick", function ()
        GDKPAuction:minimumBid();
    end);

    BidButtonClick = function ()
        GDKPAuction:bid(BidInput:GetText());

        BidInput:SetText("");
        BidInput:ClearFocus();
    end;

    --[[ ENABLE THIS INSTEAD ONCE AUTOBID IS ADDED ]]
    BidButton = CreateFrame("Button", "GARGUL_GDKP_BIDDER_BID_BUTTON", Window, "GameMenuButtonTemplate");
    BidButton:SetPoint("TOPLEFT", BidInput, "TOPRIGHT", 4, 0);
    BidButton:SetSize(60, 20); -- Minimum width is
    BidButton:SetText(L["Bid"]);
    BidButton:SetNormalFontObject("GameFontNormal");
    BidButton:SetHighlightFontObject("GameFontNormal");
    BidButton:SetScript("OnClick", function ()
        BidButtonClick();
    end);

    local AutoBidButton, StopAutoBidButton;
    AutoBidButton = CreateFrame("Button", "GARGUL_GDKP_BIDDER_AUTO_BID_BUTTON", Window, "GameMenuButtonTemplate");
    AutoBidButton:SetPoint("TOPLEFT", MinimumButton, "TOPRIGHT", 8, 0);
    AutoBidButton:SetSize(110, 20); -- Minimum width is
    AutoBidButton:SetText(L["Auto Bid"]);
    AutoBidButton:SetNormalFontObject("GameFontNormal");
    AutoBidButton:SetHighlightFontObject("GameFontNormal");
    AutoBidButton:SetScript("OnClick", function ()
        GL.Interface.Dialogs.ConfirmWithSingleInputDialog:open{
            question = (L["What's your maximum bid? (Minimum %s|c00FFF569g)"]):format(GDKPAuction:lowestValidBid()),
            inputValue = BidInput:GetText(),
            OnYes = function (max)
                if (not GDKPAuction:setAutoBid(max)) then
                    self:showBidDeniedNotification(Window);
                else
                    BidInput:SetText("");
                    BidInput:ClearFocus();
                    AutoBidButton:Hide();
                    StopAutoBidButton:Show();
                end
            end,
            focus = true,
        };
    end);
    self.AutoBidButton = AutoBidButton;

    StopAutoBidButton = CreateFrame("Button", "GARGUL_GDKP_BIDDER_AUTO_BID_BUTTON", Window, "GameMenuButtonTemplate");
    StopAutoBidButton:SetPoint("TOPLEFT", MinimumButton, "TOPRIGHT", 8, 0);
    StopAutoBidButton:SetSize(110, 20); -- Minimum width is
    StopAutoBidButton:SetText(L["Stop Auto Bid"]);
    StopAutoBidButton:SetNormalFontObject("GameFontNormal");
    StopAutoBidButton:SetHighlightFontObject("GameFontNormal");
    StopAutoBidButton:SetScript("OnClick", function ()
        GDKPAuction:stopAutoBid();
        StopAutoBidButton:Hide();
        AutoBidButton:Show();
    end);
    self.StopAutoBidButton = StopAutoBidButton;

    if (GDKPAuction.autoBiddingIsActive) then
        AutoBidButton:Hide();
        StopAutoBidButton:Show();
    else
        AutoBidButton:Show();
        StopAutoBidButton:Hide();
    end

    local PassButton = CreateFrame("Button", "GARGUL_GDKP_BIDDER_PASS_BUTTON", Window, "GameMenuButtonTemplate");
    PassButton:SetPoint("TOPLEFT", StopAutoBidButton, "TOPRIGHT", 8, 0);
    PassButton:SetSize(64, 20); -- Minimum width is
    PassButton:SetText(L["Pass"]);
    PassButton:SetNormalFontObject("GameFontNormal");
    PassButton:SetHighlightFontObject("GameFontNormal");
    PassButton:SetScript("OnClick", function ()
        if (GDKPAuction.Current.iBid
            and not GDKPAuction:userIsTopBidder()
        ) then
            GL:sendChatMessage(L.CHAT["Pass"], "GROUP", nil, nil, false);
        end

        GDKPAuction:stopAutoBid();
        self:hide();
    end);

    ---@type Frame
    local IdentityWindow, position = Interface.Identity:buildForBidder(bth);
    IdentityWindow:SetParent(Window);

    if (type(position) ~= "function") then
        IdentityWindow:SetPoint("TOPRIGHT", Window, "TOPLEFT", -6, 2);
    else
        position(IdentityWindow, Window);
    end

    self:refresh();

    Window:Show();
end

function Bidder:showBidDeniedNotification(Window)
    local BidDeniedNotification = GL.AceGUI:Create("InlineGroup");
    BidDeniedNotification:SetLayout("Fill");
    BidDeniedNotification:SetWidth(150);
    BidDeniedNotification:SetHeight(50);
    BidDeniedNotification.frame:SetParent(Window);
    BidDeniedNotification.frame:SetPoint("BOTTOMLEFT", Window, "TOPLEFT", 0, 4);

    local Text = GL.AceGUI:Create("Label");
    Text:SetText(("|c00BE3333%s|r"):format(L["Bid denied!"]));
    BidDeniedNotification:AddChild(Text);
    Text:SetJustifyH("CENTER");

    GL.Ace:ScheduleTimer(function ()
        BidDeniedNotification.frame:Hide();
    end, 2);
end

function Bidder:refresh()
    local TopBidderLabel = Interface:get(self, "Frame.TopBidder");

    if (not TopBidderLabel) then
        return;
    end

    local TopBid = GL:tableGet(GDKPAuction, "Current.TopBid", {});

    -- The given bids seems to be invalid somehow? Better safe than LUA error!
    if (not TopBid or not TopBid.bid) then
        return;
    end

    -- We're the highest bidder, NICE!
    --if (strlower(TopBid.Bidder.name) == strlower(GL.User.name)) then
    if (GL:iEquals(TopBid.bidder, GDKP:myGUID())) then
        local maxBidString = "";

        if (GDKPAuction.autoBiddingIsActive and GDKPAuction.maxBid) then
            maxBidString = (" " .. L["(max %sg)"]):format(GDKPAuction.maxBid);
        end

        TopBidderLabel:SetText(("|c001EFF00" .. L["Top bid: %s by you"] .. "%s|r"):format(GL:goldToMoney(TopBid.bid), maxBidString));
    else
        TopBidderLabel:SetText(("|c00BE3333" .. L["Top bid: %s by %s"] .. "|r"):format(
            GL:goldToMoney(TopBid.bid),
            GL:formatPlayerName(TopBid.Bidder.name, { colorize = true, })
        ));
    end
end

--- Draw the countdown bar
---
---@param time number
---@param itemLink string
---@param itemIcon string
---@return Frame
function Bidder:drawCountdownBar(time, itemLink, itemIcon, maxValue)
    -- This shouldn't be possible but you never know!
    if (not self.Window) then
        return false;
    end

    local TimerBar = LibStub("LibCandyBarGargul-3.0"):New(
        "Interface/AddOns/Gargul/Assets/Textures/timer-bar",
        300,
        24
    );
    TimerBar:SetParent(self.Window);
    TimerBar:SetPoint("TOP", self.Window);
    TimerBar.candyBarLabel:SetFont("Fonts/ARIALN.ttf", 13, "OUTLINE");

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

    TimerBar:SetDuration(time);
    TimerBar:SetColor(0, 1, 0, .3); -- Reset color to green
    TimerBar:SetLabel("  " .. itemLink .. " ");

    TimerBar:SetIcon(itemIcon);
    TimerBar:Set("type", "ROLLER_UI_COUNTDOWN");
    TimerBar:Start(maxValue);

    TimerBar:SetDuration(5);
    self.TimerBar = TimerBar;

    return TimerBar;
end

---@return nil
function Bidder:hide()
    GL.Events:unregister("BidderModifierStateChanged");

    if (not self.Window) then
        return;
    end

    -- We can't release the timer bar because it will be reused later
    if (self.TimerBar and self.TimerBar.SetParent) then
        self.TimerBar:SetParent(UIParent);
        self.TimerBar:Stop();
        self.TimerBar = nil;
    end

    Interface:release(self.Window);
    self.Window = nil;
end
