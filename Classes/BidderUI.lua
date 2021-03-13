local _, App = ...;

App.BidderUI = App.BidderUI or {};

local Settings = App.Settings;
local BidderUI = App.BidderUI;
local UI = App.UI;

BidderUI.Widgets = {};

-- Hide the bidding window
function BidderUI:hide(...)
    App:debug("BidderUI:hide");

    if (not self.Widgets.BidderFrame) then
        return;
    end

    self.Widgets.BidderFrame:Hide();
end

-- Show the bidding window (unless it's already active)
function BidderUI:show(...)
    App:debug("BidderUI:show");

    if (self.Widgets.BidderFrame
        and self.Widgets.BidderFrame:IsShown()
    ) then
        return;
    end

    self:draw(...);
end

-- Reopen the bidding window (after closing it by right clicking)
function BidderUI:reopen()
    App:debug("BidderUI:reopen");

    if (not App.Auction.inProgress) then
        return App:warning("There is no auction in progress");
    end

    -- Should not be possible, but you never know
    if (not App:tableGet(self.Widgets, "BidderFrame")) then
        return;
    end

    self.Widgets.BidderFrame:Show();
end

-- Note: we're not using Ace Gui here since we don't want any fancy frames
function BidderUI:draw(time, minimumBid, itemId, itemName, itemLink, itemIcon)
    App:debug("BidderUI:draw");

    self.Widgets.BidderFrame = self.Widgets.BidderFrame or UI:createFrame("Frame", "BidderFrame", UIParent);
    local BidderFrame = self.Widgets.BidderFrame;
    BidderFrame:Show();
    BidderFrame:SetSize(350, 48);
    BidderFrame:SetPoint(
        Settings:get("UI.Bidder.Position.point"),
        UIParent,
        Settings:get("UI.Bidder.Position.relativePoint"),
        Settings:get("UI.Bidder.Position.offsetX"),
        Settings:get("UI.Bidder.Position.offsetY")
    );

    BidderFrame:SetMovable(true);
    BidderFrame:EnableMouse(true);
    BidderFrame:SetClampedToScreen(true);
    BidderFrame:SetFrameStrata("HIGH");
    BidderFrame:RegisterForDrag("LeftButton");
    BidderFrame:SetScript("OnDragStart", BidderFrame.StartMoving);
    BidderFrame:SetScript("OnDragStop", function()
        BidderFrame:StopMovingOrSizing();
        local point, _, relativePoint, offsetX, offsetY = BidderFrame:GetPoint();

        -- Store the frame's last position for future play sessions
        Settings:set("UI.Bidder.Position.point", point);
        Settings:set("UI.Bidder.Position.relativePoint", relativePoint);
        Settings:set("UI.Bidder.Position.offsetX", offsetX);
        Settings:set("UI.Bidder.Position.offsetY", offsetY);
    end);

    -- Allow the player to close the bid window by
    -- right-clicking the window (they can reopen using /gl bid)
    BidderFrame:SetScript("OnMouseDown", function(_, button)
        if (button == "RightButton") then
            self:hide();
            App:message("You can reopen the bidding window by typing /gl bid");
        end
    end)

    self.Widgets.BidderFrameTexture = self.Widgets.BidderFrameTexture or BidderFrame:CreateTexture(nil,"BACKGROUND");
    local Texture = self.Widgets.BidderFrameTexture;
    Texture:SetColorTexture(0, 0, 0, .6);
    Texture:SetAllPoints(BidderFrame)
    BidderFrame.texture = Texture;
    self.Widgets.BidderFrameTexture = Texture;

    -- Dkp info label
    self.Widgets.DkpInfoLabel = self.Widgets.DkpInfoLabel or UI:createFrame("Frame", "GialUI_Label_MinimumBid", BidderFrame);
    local DkpInfoLabel = self.Widgets.DkpInfoLabel;
    DkpInfoLabel:SetSize(1, 1);
    DkpInfoLabel:SetPoint("TOPLEFT", BidderFrame, "TOPLEFT", 5, -2);
    DkpInfoLabel:SetPoint("BOTTOMRIGHT", BidderFrame, "BOTTOMRIGHT", -7);

    self.Widgets.DkpInfoLabelText = self.Widgets.DkpInfoLabelText or DkpInfoLabel:CreateFontString(nil, "ARTWORK");
    DkpInfoLabel.text = self.Widgets.DkpInfoLabelText;
    DkpInfoLabel.text:SetFont("Fonts\\ARIALN.ttf", 11, "OUTLINE");
    DkpInfoLabel.text:SetPoint("TOPLEFT", DkpInfoLabel, "TOPLEFT", 0, -4);
    DkpInfoLabel.text:SetText(
        string.format("MIN DKP: |c00efb8cd%s|r     YOUR DKP: |c00efb8cd%s|r     DKP:", minimumBid, App.User.Dkp.amount)
    );

    -- Bid/Roll/Cancel button
    self.Widgets.BidRollCancelButton = self.Widgets.BidRollCancelButton or UI:createFrame("Button", "GialUI_Buttons_StartBidding", BidderFrame, "GameMenuButtonTemplate");
    local BidRollCancel = self.Widgets.BidRollCancelButton;
    local ButtonText = "Bid";

    if (not App.Bidder.hasEnoughDkpToBid) then
        ButtonText = "Roll";
    end

    BidRollCancel:SetPoint("TOPRIGHT", BidderFrame, "TOPRIGHT", -4, -2);
    BidRollCancel:SetSize(60, 20);
    BidRollCancel:SetText(ButtonText);
    BidRollCancel:SetNormalFontObject("GameFontNormal");
    BidRollCancel:SetHighlightFontObject("GameFontNormal");
    BidRollCancel:SetScript("OnClick", function ()
        local buttonText = BidRollCancel:GetText();
        local bid = self.Widgets.BidEditBox:GetText();
        self.Widgets.BidEditBox:ClearFocus();
        self.Widgets.BidEditBox:SetText("");

        if (buttonText == "Roll") then
            RandomRoll(1, 100);
            return BidRollCancel:SetText("Pass");
        elseif (buttonText == "Bid"
                and App.Bidder:bid(bid)
        ) then
            self.Widgets.BidEditBox:Hide();
            return BidRollCancel:SetText("Pass");
        elseif (buttonText == "Pass") then
            if (App.Bidder.hasEnoughDkpToBid) then
                App.Bidder:retractBid();
                self.Widgets.BidEditBox:Show();
            else
                -- Retract roll shit
            end
        end

        ButtonText = "Bid";
        if (not App.Bidder.hasEnoughDkpToBid) then
            ButtonText = "Roll";
        end
        BidRollCancel:SetText(ButtonText);
    end);

    -- Only add the DKP input field if the user actually has enough DKP to bid
    self.Widgets.BidEditBox = self.Widgets.BidEditBox or UI:createFrame("EditBox", "GialUI_Input_MinimumBid", BidderFrame, "InputBoxTemplate");
    local BidEditBox = self.Widgets.BidEditBox;
    BidEditBox:SetPoint("TOPRIGHT", BidderFrame, "TOPRIGHT", -70, -2);
    BidEditBox:SetSize(40, 20);
    BidEditBox:SetMaxLetters(7);
    BidEditBox:SetAutoFocus(false);
    BidEditBox:Hide();
    BidEditBox:SetScript("OnEscapePressed", function()
        BidEditBox:ClearFocus();
    end)
    BidEditBox:SetScript("OnEnterPressed", function()
        BidRollCancel:Click();
    end);

    if (App.Bidder.hasEnoughDkpToBid) then
        BidEditBox:Show();
    end

    self.Widgets.TimerBarTexture = self.Widgets.TimerBarTexture or "Interface\\AddOns\\Gargul\\Assets\\Textures\\timer-bar";
    local texture = self.Widgets.TimerBarTexture;
    self.Widgets.TimerBar = self.Widgets.TimerBar or LibStub("LibCandyBar-3.0"):New(texture, 350, 24);
    local bar = self.Widgets.TimerBar;
    local itemPriority = App.LootPriority:getPriorityByItemId(itemId);

    if (itemPriority) then
        itemPriority = table.concat(App.LootPriority:getPriorityByItemId(itemId), " > ");
    else
        itemPriority = "Off spec";
    end

    local priorityStringLengthAllowed = 53 - string.len(itemName);

    -- Make sure the item priority does not go out of bounds
    if (priorityStringLengthAllowed < 0) then
        priorityStringLengthAllowed = 0;
    end

    bar:SetParent(BidderFrame);
    bar:SetPoint("BOTTOM", BidderFrame, "BOTTOM");
    bar:SetDuration(time);

    bar:SetLabel("  " .. itemLink .. " " .. string.sub(itemPriority, 0, priorityStringLengthAllowed));
    bar.candyBarLabel:SetFont("Fonts\\ARIALN.ttf", 13, "OUTLINE");

    bar:SetIcon(itemIcon);
    bar:SetColor(0, 1, 0, .5);
    bar:Start();

    -- Make the bar turn green/yellow/red based on time left
    bar:AddUpdateFunction(function ()
        local percentageLeft = 100 / (time / bar.remaining);

        if (percentageLeft >= 60) then
            bar:SetColor(0, 1, 0, .3);
        elseif (percentageLeft >= 30) then
            bar:SetColor(1, 1, 0, .3);
        else
            bar:SetColor(1, 0, 0, .3);
        end
    end);

    -- Call the bid window close function on rightclick
    bar:SetScript("OnMouseDown", function(widget, button)
        if (button == "RightButton") then
            self:hide();
            App:message("You can reopen the bidding window by typing /gl bid");
        end
    end)

    -- Show a gametooltip for the item up for auction
    -- when hovering over the progress bar
    bar:SetScript("OnEnter", function()
        GameTooltip:SetOwner(BidderFrame, "ANCHOR_TOP");
        GameTooltip:SetHyperlink(itemLink);
        GameTooltip:Show();
    end);
    bar:SetScript("OnLeave", function()
        GameTooltip:Hide();
    end);
end

App:debug("BidderUI.lua");