local _, App = ...;

App.RollerUI = App.RollerUI or {};

local Settings = App.Settings;
local RollerUI = App.RollerUI;
local UI = App.UI;

RollerUI.Widgets = {};

-- Hide the roll window
function RollerUI:hide(...)
    if (not self.Widgets.RollerFrame) then
        return;
    end

    self.Widgets.RollerFrame:Hide();
end

-- Show the roll window (unless it's already active)
function RollerUI:show(...)
    if (self.Widgets.RollerFrame
        and self.Widgets.RollerFrame:IsShown()
    ) then
        return;
    end

    self:draw(...);
end

-- Reopen the roll window (after closing it by right clicking)
function RollerUI:reopen()
    if (not App.RollOff.inProgress) then
        return App:warning("There is no roll in progress");
    end

    -- Should not be possible, but you never know
    if (not App:tableGet(self.Widgets, "RollerFrame")) then
        return;
    end

    self.Widgets.RollerFrame:Show();
end

-- Note: we're not using Ace Gui here since we don't want any fancy frames
function RollerUI:draw(time, itemId, itemName, itemLink, itemIcon)
    App:debug("RollerUI:draw");

    local itemIsReserved = App.SoftReserves:getSoftReservesByItemId(itemId);
    local itemIsReservedByUser = itemIsReserved and App.SoftReserves:itemIdIsReservedByPlayer(itemId, App.User.name);

    if (itemIsReserved) then
        itemIsReserved = "YES";
    else
        itemIsReserved = "NO";
    end

    if (itemIsReservedByUser) then
        itemIsReservedByUser = "YES";
    else
        itemIsReservedByUser = "NO";
    end

    self.Widgets.RollerFrame = self.Widgets.RollerFrame or UI:createFrame("Frame", "RollerFrame", UIParent);
    local RollerFrame = self.Widgets.RollerFrame;
    RollerFrame:Show();
    RollerFrame:SetSize(350, 48);
    RollerFrame:SetPoint(
        Settings:get("UI.Roller.Position.point"),
        UIParent,
        Settings:get("UI.Roller.Position.relativePoint"),
        Settings:get("UI.Roller.Position.offsetX"),
        Settings:get("UI.Roller.Position.offsetY")
    );

    RollerFrame:SetMovable(true);
    RollerFrame:EnableMouse(true);
    RollerFrame:SetClampedToScreen(true);
    RollerFrame:SetFrameStrata("HIGH");
    RollerFrame:RegisterForDrag("LeftButton");
    RollerFrame:SetScript("OnDragStart", RollerFrame.StartMoving);
    RollerFrame:SetScript("OnDragStop", function()
        RollerFrame:StopMovingOrSizing();
        local point, _, relativePoint, offsetX, offsetY = RollerFrame:GetPoint();

        -- Store the frame's last position for future play sessions
        Settings:set("UI.Roller.Position.point", point);
        Settings:set("UI.Roller.Position.relativePoint", relativePoint);
        Settings:set("UI.Roller.Position.offsetX", offsetX);
        Settings:set("UI.Roller.Position.offsetY", offsetY);
    end);

    self.Widgets.RollerFrameTexture = self.Widgets.RollerFrameTexture or RollerFrame:CreateTexture(nil,"BACKGROUND");
    local Texture = self.Widgets.RollerFrameTexture;
    Texture:SetColorTexture(0, 0, 0, .6);
    Texture:SetAllPoints(RollerFrame)
    RollerFrame.texture = Texture;
    self.Widgets.RollerFrameTexture = Texture;

    -- Roll info label
    self.Widgets.RollLabel = self.Widgets.RollLabel or UI:createFrame("Frame", "GialUI_Label_MinimumBid", RollerFrame);
    local RollLabel = self.Widgets.RollLabel;
    RollLabel:SetSize(1, 1);
    RollLabel:SetPoint("TOPLEFT", RollerFrame, "TOPLEFT", 5, -2);
    RollLabel:SetPoint("BOTTOMRIGHT", RollerFrame, "BOTTOMRIGHT", -7);

    self.Widgets.RollLabelText = self.Widgets.RollLabelText or RollLabel:CreateFontString(nil, "ARTWORK");
    RollLabel.text = self.Widgets.RollLabelText;
    RollLabel.text:SetFont("Fonts\\ARIALN.ttf", 11, "OUTLINE");
    RollLabel.text:SetPoint("TOPLEFT", RollLabel, "TOPLEFT", 0, -4);
    RollLabel.text:SetText(
        string.format("SOFT RESERVED: |c00efb8cd%s|r     BY YOU: |c00efb8cd%s|r", itemIsReserved, itemIsReservedByUser)
    );

    -- Bid/Roll/Cancel button
    self.Widgets.RollButton = self.Widgets.RollButton or UI:createFrame("Button", "GialUI_Buttons_StartBidding", RollerFrame, "GameMenuButtonTemplate");
    local RollButton = self.Widgets.RollButton;

    RollButton:SetPoint("TOPRIGHT", RollerFrame, "TOPRIGHT", -4, -2);
    RollButton:SetSize(60, 20);
    RollButton:SetText("Roll");
    RollButton:SetNormalFontObject("GameFontNormal");
    RollButton:SetHighlightFontObject("GameFontNormal");
    RollButton:SetScript("OnClick", function ()
        local buttonText = RollButton:GetText();
        local bid = self.Widgets.BidEditBox:GetText();
        self.Widgets.BidEditBox:ClearFocus();
        self.Widgets.BidEditBox:SetText("");

        if (buttonText == "Roll") then
            RandomRoll(1, 100);
            return RollButton:SetText("Pass");
        elseif (buttonText == "Bid"
                and App.Bidder:bid(bid)
        ) then
            self.Widgets.BidEditBox:Hide();
            return RollButton:SetText("Pass");
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
        RollButton:SetText(ButtonText);
    end);

    -- Only add the DKP input field if the user actually has enough DKP to bid
    self.Widgets.BidEditBox = self.Widgets.BidEditBox or UI:createFrame("EditBox", "GialUI_Input_MinimumBid", RollerFrame, "InputBoxTemplate");
    local BidEditBox = self.Widgets.BidEditBox;
    BidEditBox:SetPoint("TOPRIGHT", RollerFrame, "TOPRIGHT", -70, -2);
    BidEditBox:SetSize(40, 20);
    BidEditBox:SetMaxLetters(7);
    BidEditBox:SetAutoFocus(false);
    BidEditBox:Hide();
    BidEditBox:SetScript("OnEscapePressed", function()
        BidEditBox:ClearFocus();
    end)
    BidEditBox:SetScript("OnEnterPressed", function()
        RollButton:Click();
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

    bar:SetParent(RollerFrame);
    bar:SetPoint("BOTTOM", RollerFrame, "BOTTOM");
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
            App:message("You can reopen the roll window by typing /gl bid");
        end
    end)

    -- Show a gametooltip for the item up for roll
    -- when hovering over the progress bar
    bar:SetScript("OnEnter", function()
        GameTooltip:SetOwner(RollerFrame, "ANCHOR_TOP");
        GameTooltip:SetHyperlink(itemLink);
        GameTooltip:Show();
    end);
    bar:SetScript("OnLeave", function()
        GameTooltip:Hide();
    end);
end

App:debug("RollerUI.lua");