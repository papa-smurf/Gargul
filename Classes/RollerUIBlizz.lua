---@type GL
local _, GL = ...;

---@class RollerUIBlizz
GL.RollerUIBlizz = GL.RollerUIBlizz or {
    Window = nil,
};
local RollerUIBlizz = GL.RollerUIBlizz; ---@type RollerUIBlizz

---@return boolean
function RollerUIBlizz:show(time, itemLink, itemIcon, note, SupportedRolls)
    GL:debug("RollerUIBlizz:show");

    if (self.Window and self.Window:IsShown()) then
        return false;
    end

    -- Make sure we can adjust the roller UI accordingly when a player can't use the item
    GL:canUserUseItem(itemLink, function (userCanUseItem)
        if (not userCanUseItem
            and GL.Settings:get("Rolling.dontShowOnUnusableItems", false)
        ) then
            return false;
        end

        self:draw(time, itemLink, itemIcon, note, SupportedRolls, userCanUseItem);
    end);

    return true;
end

--- Note: we're not using AceGUI here since getting a SimpleGroup to move properly is a friggin nightmare
---
---@param time number The duration of the RollOff
---@param itemLink string
---@param itemIcon string
---@param note string
---@return boolean
function RollerUIBlizz:draw(time, itemLink, itemIcon, note, SupportedRolls, userCanUseItem)
    GL:debug("RollerUIBlizz:draw");

	local itemName = GL:getItemNameFromLink(itemLink);
	
	-- FrameXML\LootFrame.xml GroupLootFrameTemplate as base
	
    local Window = CreateFrame("Frame", "GargulUI_RollerUIBlizz_Window", UIParent, "BackdropTemplate");
    Window:Hide();
    Window:SetPoint(GL.Interface:getPosition("Roller"));
    Window:SetMovable(true);
    Window:EnableMouse(true);
    Window:SetClampedToScreen(true);
    Window:SetFrameStrata("DIALOG");

	-- toplevel="true"
    Window:SetSize(275, 84);
	Window:SetBackdrop({
		bgFile = "Interface\\DialogFrame\\UI-DialogBox-Gold-Background", 
		edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Gold-Border", 
		tile = true, 
		tileSize = 32, 
		edgeSize = 32, 
		insets = { left = 11, right = 12, top = 12, bottom = 11 } 
	});
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
    Window:SetScale(GL.Settings:get("Rolling.scale", 1));
    self.Window = Window;

	local SlotTexture = Window:CreateTexture(nil, "ARTWORK");
	SlotTexture:SetSize(64, 64);
	SlotTexture:SetPoint("TOPLEFT", 3, -3);
	SlotTexture:SetTexture("Interface\\Buttons\\UI-EmptySlot");
	Window.SlotTexture = SlotTexture;

	local IconFrame = CreateFrame("Button", nil, Window);
    IconFrame:EnableMouse(true);
	IconFrame:SetSize(34, 34);
	IconFrame:SetPoint("TOPLEFT", SlotTexture, "TOPLEFT", 15, -15);
	IconFrame:SetScript("OnEnter", 
		function(self)
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
			GameTooltip:SetHyperlink(itemLink);
			GameTooltip:Show();
			CursorUpdate(self);
		end);
	IconFrame:SetScript("OnLeave", 
		function(self)
			GameTooltip:Hide();
			ResetCursor();
		end);
	IconFrame:SetScript("OnUpdate", 
		function(self)
			if ( GameTooltip:IsOwned(self) ) then
				GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
				GameTooltip:SetHyperlink(itemLink);
			end
			CursorOnUpdate(self);
		end);
	IconFrame:SetScript("OnClick", 
		function(self)
			HandleModifiedItemClick(itemLink);
		end);
	Window.IconFrame = IconFrame;
	

	local Icon = IconFrame:CreateTexture(nil, "ARTWORK");
	Icon:SetSize(34, 34);
	Icon:SetPoint("TOPLEFT");
	Icon:SetTexture(itemIcon);
	Window.IconFrame.Icon = Icon;

	local NameFrame = Window:CreateTexture(nil, "ARTWORK");
	NameFrame:SetSize(128, 64);
	NameFrame:SetPoint("LEFT", SlotTexture, "RIGHT", -9, -10);
	NameFrame:SetTexture("Interface\\MerchantFrame\\UI-Merchant-LabelSlots");
	Window.NameFrame = NameFrame;

	local Name = Window:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall");
	Name:SetText(itemName);
	Name:SetJustifyH("LEFT");
	Name:SetSize(90, 30);
	Name:SetPoint("LEFT", SlotTexture, "RIGHT", -5, 5);
	GL:onItemLoadDo(itemLink, 
		function(data) 
			local quality = data[1].quality;
			local color = ITEM_QUALITY_COLORS[quality];
			Name:SetVertexColor(color.r, color.g, color.b);
		end);
	Window.Name = Name;
	
	local Decoration = Window:CreateTexture(nil, "OVERLAY");
	Decoration:SetSize(120, 120);
	Decoration:SetPoint("TOPLEFT", -30, 15);
	Decoration:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Gold-Dragon");
	Window.Decoration = Decoration;

	local Corner = Window:CreateTexture(nil, "OVERLAY");
	Corner:SetSize(32, 32);
	Corner:SetPoint("TOPRIGHT", -9, -7);
	Corner:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Gold-Corner");
	Window.Corner = Corner;

    local RollButtons = {};
    local numberOfButtons = #SupportedRolls;

	if numberOfButtons > 3
	then
		local h = Window:GetHeight();
		h = h + (numberOfButtons - 3) * 21;
		Window:SetHeight(h);
	end

    for i = 1, numberOfButtons do
        local RollDetails = SupportedRolls[i] or {}

        local identifier = string.sub(RollDetails[1] or "", 1, 3);
        local min = math.floor(tonumber(RollDetails[2]) or 0);
        local max = math.floor(tonumber(RollDetails[3]) or 0)

        -- There are no more buttons to display
        if (GL:empty(identifier)) then
            break;
        end

        -- Roll button
        local Button = CreateFrame("Button", nil, Window, "GameMenuButtonTemplate");
        Button:SetSize(66, 20);
        Button:SetText(identifier);
        Button:SetNormalFontObject("GameFontNormal");
        Button:SetHighlightFontObject("GameFontNormal")

        if (not userCanUseItem) then
            Button:Disable();
            Button:SetMotionScriptsWhileDisabled(true);
			
            -- Make sure rolling is still possible in case something was amiss!
            Button:SetScript("OnEnter", function()
                Button:Enable();
            end);

            Button:SetScript("OnLeave", function()
                Button:Disable();
            end);
        end

        Button:SetScript("OnClick", function ()
            RandomRoll(min, max);

            if (GL.Settings:get("Rolling.closeAfterRoll")) then
                self:hide();
            else
                local RollAcceptedNotification = GL.AceGUI:Create("InlineGroup");
                RollAcceptedNotification:SetLayout("Fill");
                RollAcceptedNotification:SetWidth(150);
                RollAcceptedNotification:SetHeight(50);
                RollAcceptedNotification.frame:SetParent(Window);
                RollAcceptedNotification.frame:SetPoint("BOTTOMLEFT", Window, "TOPLEFT", 14, 4)

                local Text = GL.AceGUI:Create("Label");
                Text:SetText("Roll accepted!");
                RollAcceptedNotification:AddChild(Text);
                Text:SetJustifyH("MIDDLE");
                self.RollAcceptedTimer = GL.Ace:ScheduleTimer(function ()
                    RollAcceptedNotification.frame:Hide();
                end, 2);
            end
        end);

        if (i == 1) then
            Button:SetPoint("TOPRIGHT", Window, "TOPRIGHT", -36, -10);
        else
            Button:SetPoint("TOPRIGHT", RollButtons[i - 1], "BOTTOMRIGHT", 0, -1);
        end

        tinsert(RollButtons, Button);
    end
	
	Window.RollButtons = RollButtons;

    local PassButton = CreateFrame("Button", "GargulUI_RollerUIBlizz_Pass", Window, "UIPanelCloseButton");
    PassButton:SetPoint("TOPRIGHT", Window, "TOPRIGHT", -5, -3);
    PassButton:SetScript("OnClick", function ()
        self:hide();
    end);
	Window.PassButton = PassButton;

    self:drawCountdownBar(time, itemLink, itemIcon, note, userCanUseItem);

    Window:Show();
end

--- Draw the countdown bar
---
---@param time number
---@param itemLink string
---@param itemIcon string
---@param note string
---@return void
function RollerUIBlizz:drawCountdownBar(time, itemLink, itemIcon, note, userCanUseItem, width)
    GL:debug("RollerUIBlizz:drawCountdownBar");

    -- This shouldn't be possible but you never know!
    if (not self.Window) then
        return false;
    end
	
	local Window = self.Window;
	
	local Timer = CreateFrame("StatusBar", nil, Window);
	Timer:SetSize(152, 10);
	Timer:SetPoint("TOPLEFT", Window.SlotTexture, "BOTTOMLEFT", 13, 10);
	Timer:SetMinMaxValues(0, 60000);
	Timer:SetValue(0);
	Timer:SetStatusBarTexture("Interface\\PaperDollInfoFrame\\UI-Character-Skills-Bar");
	Timer:SetStatusBarColor(1, 1, 0);
	Window.Timer = Timer;

	Window.Timer.Bar = Window.Timer:GetStatusBarTexture();
	Window.Timer.Bar:SetDrawLayer("ARTWORK");
	
	local Background = Timer:CreateTexture(nil, "BACKGROUND");
	Background:SetAllPoints(Timer);
	Background:SetColorTexture(0, 0, 0);
	Timer.Background = Background;
	
	local Border = Timer:CreateTexture(nil, "BORDER");
	Border:SetSize(156, 20);
	Border:SetPoint("TOP", 0, 5);
	Border:SetTexture("Interface\\PaperDollInfoFrame\\UI-Character-Skills-BarBorder");
	Timer.Border = Border;

	Timer.start = GetTime();
	Timer:SetMinMaxValues(0, time);

	Timer:SetScript("OnUpdate", 
		function(self)
			local left = self.start and (GetTime()-self.start) or 0;
			local min, max = self:GetMinMaxValues();
			if ( (left < min) or (left > max) ) then
				left = min;
			end
			self:SetValue(max-left);
		end);
end

---@return void
function RollerUIBlizz:hide()
    GL:debug("RollerUIBlizz:hide");

    if (not self.Window) then
        return;
    end

    self.Window:Hide();
    self.Window = nil;
end

GL:debug("RollerUIBlizz.lua");