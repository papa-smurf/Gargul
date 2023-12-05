---@type GL
local _, GL = ...;

---@type SettingsOverview
local Overview = GL.Interface.Settings.Overview;

---@type Settings
local Settings = GL.Settings;

---@class GDKPSettings
GL.Interface.Settings.GDKP = {
    description = "Type |c00a79eff/gl gdkp|r or simply |c00a79eff/gdkp|r or click the button below to get started!",
    InputElements = {},
    ItemLevelElements = {},
};
local GDKP = GL.Interface.Settings.GDKP; ---@type GDKPSettings

---@return void
function GDKP:draw(Parent)
    GL:debug("GDKPSettings:draw");
    local Spacer;

    local OpenGDKP = GL.AceGUI:Create("Button");
    OpenGDKP:SetText("Open GDKP");
    OpenGDKP:SetWidth(130);
    OpenGDKP:SetCallback("OnClick", function()
        GL.Settings:close();
        GL.Commands:call("gdkp");
    end);
    Parent:AddChild(OpenGDKP);

    local HotkeyLabel = GL.AceGUI:Create("Label");
    HotkeyLabel:SetText("  You can find the GDKP hotkeys here");
    HotkeyLabel:SetWidth(202);
    Parent:AddChild(HotkeyLabel);

    local GoToHotkeys = GL.AceGUI:Create("Button");
    GoToHotkeys:SetText("Hotkeys");
    GoToHotkeys:SetWidth(90);
    GoToHotkeys:SetCallback("OnClick", function()
        GL.Settings:draw("ShortcutKeys");
    end);
    Parent:AddChild(GoToHotkeys);

    Overview:drawHeader("General", Parent);

    Overview:drawCheckboxes({
        {
            label = "Bid window",
            description = "Show the bid window whenever the master looter starts an auction. This only works if the master looter uses Gargul!",
            setting = "GDKP.showBidWindow",
        },
        {
            label = "Show the GDKP bid queue that allows you to prebid on queued items",
            setting = "GDKP.enableBidderQueue",
            callback = function()
                local BidderQueue = GL.Interface.GDKP.BidderQueue;

                if (not GL.Settings:get("GDKP.enableBidderQueue")) then
                    BidderQueue:close();
                else
                    BidderQueue:open();
                    BidderQueue:refreshTable();
                end
            end,
        },
        {
            label = "Show GDKP data on item tooltips",
            setting = "GDKP.showHistoryOnTooltip",
        },
    }, Parent);

    Spacer = GL.AceGUI:Create("SimpleGroup");
    Spacer:SetLayout("FILL");
    Spacer:SetFullWidth(true);
    Spacer:SetHeight(20);
    Parent:AddChild(Spacer);

    local BidderScale = GL.AceGUI:Create("Slider");
    BidderScale:SetLabel("Magnification scale of the bidder window");
    BidderScale.label:SetTextColor(1, .95686, .40784);
    BidderScale:SetFullWidth(true);
    BidderScale:SetValue(GL.Settings:get("GDKP.bidderScale"));
    BidderScale:SetSliderValues(.8, 1.8, .1);
    BidderScale:SetCallback("OnValueChanged", function(Slider)
        local value = tonumber(Slider:GetValue());

        if (not value) then
            return;
        end

        GL.Settings:set("GDKP.bidderScale", value);

        -- Change the existing bidder window if it's active!
        if (GL.Interface.GDKP.Bidder.Window
                and type(GL.Interface.GDKP.Bidder.Window.SetScale == "function")
        ) then
            GL.Interface.GDKP.Bidder.Window:SetScale(value);
        end
    end);
    Parent:AddChild(BidderScale);

    local HorizontalSpacer = GL.AceGUI:Create("SimpleGroup");
    HorizontalSpacer:SetLayout("FILL");
    HorizontalSpacer:SetFullWidth(true);
    HorizontalSpacer:SetHeight(20);
    Parent:AddChild(HorizontalSpacer);

    local PlaySoundWhenOutbidLabel = GL.AceGUI:Create("Label");
    PlaySoundWhenOutbidLabel:SetText("|c00FFF569Choose a sound that plays when you're outbid|r");
    PlaySoundWhenOutbidLabel:SetFullWidth(true);
    Parent:AddChild(PlaySoundWhenOutbidLabel);

    local Sounds = LibStub("LibSharedMedia-3.0"):List("sound");
    local SoundsByName = GL:tableFlip(Sounds);

    local OutbidSoundDropdown = GL.AceGUI:Create("Dropdown");
    OutbidSoundDropdown:SetValue(SoundsByName[GL.Settings:get("GDKP.outbidSound")]);
    OutbidSoundDropdown:SetList(Sounds);
    OutbidSoundDropdown:SetText(GL.Settings:get("GDKP.outbidSound"));
    OutbidSoundDropdown:SetWidth(250);
    OutbidSoundDropdown:SetCallback("OnValueChanged", function()
        local value = OutbidSoundDropdown:GetValue();
        local sound = LibStub("LibSharedMedia-3.0"):Fetch("sound", Sounds[value]);

        if (type(sound) == "string" and not GL:empty(sound)) then
            GL:playSound(sound);

            GL.Settings:set("GDKP.outbidSound", Sounds[value]);
        end
    end);
    Parent:AddChild(OutbidSoundDropdown);

    Overview:drawHeader("Auctions", Parent);

    Overview:drawCheckboxes({
        {
            label = "Accept bids lower than minimum",
            description = "Accept bids that don't meet the minimum, useful for identifying off spec bids",
            setting = "GDKP.acceptBidsLowerThanMinimum",
        },
        {
            label = "Allow invalid bids to trigger anti-snipe",
            description = "Bids that are too low will still trigger the anti-snipe timer",
            setting = "GDKP.invalidBidsTriggerAntiSnipe",
        },
        {
            label = "Auto award items",
            description = "Auto award an item to the highest bidder when the timer runs out (clicking \"Stop\" during an auction will not trigger this)",
            setting = "GDKP.autoAwardViaAuctioneer",
        },
    }, Parent);

    Spacer = GL.AceGUI:Create("SimpleGroup");
    Spacer:SetLayout("FILL");
    Spacer:SetFullWidth(true);
    Spacer:SetHeight(20);
    Parent:AddChild(Spacer);

    local AuctionBidLeeway = GL.AceGUI:Create("Slider");
    AuctionBidLeeway:SetLabel("Accept bids till how long after auction an auction ends?");
    AuctionBidLeeway.label:SetTextColor(1, .95686, .40784);
    AuctionBidLeeway:SetFullWidth(true);
    AuctionBidLeeway:SetValue(GL.Settings:get("GDKP.auctionEndLeeway", 2));
    AuctionBidLeeway:SetSliderValues(1, 5, .5);
    AuctionBidLeeway:SetCallback("OnValueChanged", function(Slider)
        local value = tonumber(Slider:GetValue()) or 0;

        if (value >= 1) then
            GL.Settings:set("GDKP.auctionEndLeeway", value);
        end
    end);
    Parent:AddChild(AuctionBidLeeway);

    Spacer = GL.AceGUI:Create("SimpleGroup");
    Spacer:SetLayout("FILL");
    Spacer:SetFullWidth(true);
    Spacer:SetHeight(20);
    Parent:AddChild(Spacer);

    Overview:drawHeader("UI Style", Parent);

    Spacer = GL.AceGUI:Create("SimpleGroup");
    Spacer:SetLayout("FILL");
    Spacer:SetFullWidth(true);
    Spacer:SetHeight(20);
    Parent:AddChild(Spacer);

    local LedgerAuctionSizeExplanation = GL.AceGUI:Create("Label");
    LedgerAuctionSizeExplanation:SetText("The slider below affects how tightly auctions are packed together in the |c00967FD2/gdkp|r overview");
    LedgerAuctionSizeExplanation:SetFullWidth(true);
    Parent:AddChild(LedgerAuctionSizeExplanation);

    local LedgerAuctionSize = GL.AceGUI:Create("Slider");
    LedgerAuctionSize:SetLabel("Auction scale");
    LedgerAuctionSize.label:SetTextColor(1, .95686, .40784);
    LedgerAuctionSize:SetFullWidth(true);
    LedgerAuctionSize:SetValue(GL.Settings:get("GDKP.ledgerAuctionScale"));
    LedgerAuctionSize:SetSliderValues(11, 50, 1);
    LedgerAuctionSize:SetCallback("OnValueChanged", function(Slider)
        local value = math.floor(tonumber(Slider:GetValue()));
        local currentValue = GL.Settings:get("GDKP.ledgerAuctionScale");

        if (currentValue ~= value) then
            GL.Settings:set("GDKP.ledgerAuctionScale", value);

            if (GL.Interface.GDKP.Overview.isVisible) then
                GL.Interface.GDKP.Overview:refreshLedger();
            end
        end
    end);
    Parent:AddChild(LedgerAuctionSize);

    Spacer = GL.AceGUI:Create("SimpleGroup");
    Spacer:SetLayout("FILL");
    Spacer:SetFullWidth(true);
    Spacer:SetHeight(20);
    Parent:AddChild(Spacer);

    Overview:drawHeader("Trading", Parent);

    Overview:drawCheckboxes({
        {
            label = "Whisper a gold to give or receive message",
            setting = "GDKP.whisperGoldDetails",
        },
        {
            label = "Automatically add gold you owe",
            setting = "GDKP.addGoldToTradeWindow",
        },
    }, Parent);

    Overview:drawHeader("|c00FF0000DANGER ZONE|r", Parent);

    local ResetPerItemSettings = GL.AceGUI:Create("Button");
    ResetPerItemSettings:SetText("Reset all minimum prices and increments");
    ResetPerItemSettings:SetFullWidth(true);
    ResetPerItemSettings:SetCallback("OnClick", function()
        GL.Interface.Dialogs.PopupDialog:open{
            question = "Are you sure you want to reset all individual item settings?",
            OnYes = function ()
                GL.GDKP:resetPerItemSettings();
            end,
        };
    end);
    Parent:AddChild(ResetPerItemSettings);

    local ResetGDKPSettings = GL.AceGUI:Create("Button");
    ResetGDKPSettings:SetText("Reset GDKP settings to default");
    ResetGDKPSettings:SetFullWidth(true);
    ResetGDKPSettings:SetCallback("OnClick", function()
        GL.Interface.Dialogs.PopupDialog:open{
            question = "Are you sure you want to reset all GDKP settings?",
            OnYes = function ()
                local PerItemSettings = Settings:get("GDKP.SettingsPerItem", {});
                Settings:set("GDKP", {});
                Settings:set("GDKP.SettingsPerItem", PerItemSettings);
                C_UI.Reload();
            end,
        };
    end);
    Parent:AddChild(ResetGDKPSettings);

    local ResetGDKPSessionData = GL.AceGUI:Create("Button");
    ResetGDKPSessionData:SetText("Reset GDKP session data");
    ResetGDKPSessionData:SetFullWidth(true);
    ResetGDKPSessionData:SetCallback("OnClick", function()
        GL.Interface.Dialogs.PopupDialog:open{
            question = "Are you sure you want to delete all session data? You will lose ALL auction data. Use with extreme caution!",
            OnYes = function ()
                GL.DB:set("GDKP", {});
                C_UI.Reload();
            end,
        };
    end);
    Parent:AddChild(ResetGDKPSessionData);


end

--- Store the button details (will be overwritten by the draw method)
function GDKP:onClose()
    GL.Settings:set("GDKP.Mutators", {});
    GL.Settings:set("GDKP.ItemLevelDetails", {});

    for _, Details in pairs(self.ItemLevelElements or {}) do
        (function ()
            local level = tonumber(strtrim(Details.Level:GetText())) or 0;
            if (level < 1) then
                return;
            end

            local minimum = tonumber(strtrim(Details.Minimum:GetText())) or 0;
            if (minimum < 0) then
                return;
            end

            local increment = tonumber(strtrim(Details.Increment:GetText())) or 0;
            if (increment < 1) then
                return;
            end

            GL.Settings:set(("GDKP.ItemLevelDetails.%s"):format(level), {
                increment = increment,
                level = level,
                minimum = minimum,
            });
        end)();
    end

    for _, Mutator in pairs(self.InputElements or {}) do
        (function ()
            local name = strtrim(Mutator.Name:GetText());
            if (GL:empty(name)) then
                return;
            end

            local percentage = strtrim(Mutator.Percentage:GetText());
            if (not GL:empty(percentage)
                and GL:empty(tonumber(percentage))
            ) then
                return;
            end

            local flat = strtrim(Mutator.Flat:GetText());
            if (not GL:empty(flat)
                and GL:empty(tonumber(flat))
            ) then
                return;
            end

            local autoApplyTo = strtrim(Mutator.AutoApplyTo:GetText());

            local MutatorObj = {
                autoApplyTo = autoApplyTo,
                flat = flat,
                name = name,
                percentage = percentage,
            };

            GL.Settings:set("GDKP.Mutators." .. name, MutatorObj);
        end)();
    end
end

GL:debug("Interface/Settings/GDKP.lua");