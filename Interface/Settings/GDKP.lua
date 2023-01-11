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
            label = "Show GDKP data on item tooltips",
            setting = "GDKP.showHistoryOnTooltip",
        },
    }, Parent);

    Spacer = GL.AceGUI:Create("SimpleGroup");
    Spacer:SetLayout("FILL");
    Spacer:SetFullWidth(true);
    Spacer:SetHeight(20);
    Parent:AddChild(Spacer);

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
    OutbidSoundDropdown:SetFullWidth(true);
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
            label = "Announce auction start",
            setting = "GDKP.announceAuctionStart",
        },
        {
            label = "Announce pot after awarding item",
            setting = "GDKP.announcePotAfterAuction",
        },
        {
            label = "Whisper bidder if their bid is too low",
            setting = "GDKP.notifyIfBidTooLow",
        },
        {
            label = "Announce countdown in raid warning",
            description = "Announce countdown in /rw instead of /ra",
            setting = "GDKP.announceCountdownInRW",
        },
        {
            label = "Announce incoming bids",
            description = "Announce all accepted bids in group chat",
            setting = "GDKP.announceNewBid",
        },
        {
            label = "Announce incoming bids in raid warning",
            description = "Announce bids in /rw instead of /ra. Requires |c00967FD2Announce incoming bids|r to be enabled!|r",
            setting = "GDKP.announceNewBidInRW",

        },
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

    local NumberOfSecondsToCountdown = GL.AceGUI:Create("Slider");
    NumberOfSecondsToCountdown:SetLabel("Countdown every second starting from (0 to disable)");
    NumberOfSecondsToCountdown.label:SetTextColor(1, .95686, .40784);
    NumberOfSecondsToCountdown:SetFullWidth(true);
    NumberOfSecondsToCountdown:SetValue(GL.Settings:get("GDKP.numberOfSecondsToCountdown", 5));
    NumberOfSecondsToCountdown:SetSliderValues(0, 25, 1);
    NumberOfSecondsToCountdown:SetCallback("OnValueChanged", function(Slider)
        local value = math.floor(tonumber(Slider:GetValue()));

        if (value >= 0) then
            GL.Settings:set("GDKP.numberOfSecondsToCountdown", value);
        end
    end);
    Parent:AddChild(NumberOfSecondsToCountdown);

    Spacer = GL.AceGUI:Create("SimpleGroup");
    Spacer:SetLayout("FILL");
    Spacer:SetFullWidth(true);
    Spacer:SetHeight(20);
    Parent:AddChild(Spacer);

    local NumberOfFiveSecondsToCountdown = GL.AceGUI:Create("Slider");
    NumberOfFiveSecondsToCountdown:SetLabel("Countdown every 5 seconds starting from (0 to disable)");
    NumberOfFiveSecondsToCountdown.label:SetTextColor(1, .95686, .40784);
    NumberOfFiveSecondsToCountdown:SetFullWidth(true);
    NumberOfFiveSecondsToCountdown:SetValue(GL.Settings:get("GDKP.numberOfFiveSecondsToCountdown", 15));
    NumberOfFiveSecondsToCountdown:SetSliderValues(0, 30, 5);
    NumberOfFiveSecondsToCountdown:SetCallback("OnValueChanged", function(Slider)
        local value = math.floor(tonumber(Slider:GetValue()));

        if (value >= 0) then
            GL.Settings:set("GDKP.numberOfFiveSecondsToCountdown", value);
        end
    end);
    Parent:AddChild(NumberOfFiveSecondsToCountdown);

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

    Overview:drawHeader("Queues", Parent);

    Overview:drawCheckboxes({
        {
            label = "Enable GDKP queues by default",
            setting = "GDKP.enableGDKPQueuesByDefault",
        },
        {
            label = "Show the GDKP bid queue that allows you to prebid on queued items",
            setting = "GDKP.enableGDKPBidderQueue",
            callback = function()
                local BidderQueue = GL.Interface.GDKP.BidderQueue;

                if (not GL.Settings:get("GDKP.enableGDKPBidderQueue")) then
                    BidderQueue:close();
                else
                    BidderQueue:open();
                    BidderQueue:refreshTable();
                end
            end,
        },
    }, Parent);

    Spacer = GL.AceGUI:Create("SimpleGroup");
    Spacer:SetLayout("FILL");
    Spacer:SetFullWidth(true);
    Spacer:SetHeight(20);
    Parent:AddChild(Spacer);

    local DelayInSecondsBetweenQueuedAuctions = GL.AceGUI:Create("Slider");
    DelayInSecondsBetweenQueuedAuctions:SetLabel("Add a delay in seconds between queued auctions");
    DelayInSecondsBetweenQueuedAuctions.label:SetTextColor(1, .95686, .40784);
    DelayInSecondsBetweenQueuedAuctions:SetFullWidth(true);
    DelayInSecondsBetweenQueuedAuctions:SetValue(GL.Settings:get("GDKP.delayBetweenQueuedAuctions", 1));
    DelayInSecondsBetweenQueuedAuctions:SetSliderValues(1, 30, 1);
    DelayInSecondsBetweenQueuedAuctions:SetCallback("OnValueChanged", function(Slider)
        local value = math.floor(tonumber(Slider:GetValue()));

        if (value >= 0) then
            GL.Settings:set("GDKP.delayBetweenQueuedAuctions", value);
        end
    end);
    Parent:AddChild(DelayInSecondsBetweenQueuedAuctions);

    Spacer = GL.AceGUI:Create("SimpleGroup");
    Spacer:SetLayout("FILL");
    Spacer:SetFullWidth(true);
    Spacer:SetHeight(20);
    Parent:AddChild(Spacer);

    local BidderQueueScale = GL.AceGUI:Create("Slider");
    BidderQueueScale:SetLabel("Magnification scale of the queue bidding window");
    BidderQueueScale.label:SetTextColor(1, .95686, .40784);
    BidderQueueScale:SetFullWidth(true);
    BidderQueueScale:SetValue(GL.Settings:get("GDKP.bidderQueueScale"));
    BidderQueueScale:SetSliderValues(.8, 1.8, .1);
    BidderQueueScale:SetCallback("OnValueChanged", function(Slider)
        local value = tonumber(Slider:GetValue());

        if (not value) then
            return;
        end

        GL.Settings:set("GDKP.bidderQueueScale", value);

        -- Change the existing bidder queue window if it's active!
        local Window = GL.Interface:get(GL.Interface.GDKP.BidderQueue, "Frame.GDKPBidderQueue");
        if (Window and Window.frame and Window.frame.SetScale) then
            Window.frame:SetScale(value);
        end
    end);
    Parent:AddChild(BidderQueueScale);

    Spacer = GL.AceGUI:Create("SimpleGroup");
    Spacer:SetLayout("FILL");
    Spacer:SetFullWidth(true);
    Spacer:SetHeight(20);
    Parent:AddChild(Spacer);

    local QueuedAuctionNoBidsActionLabel = GL.AceGUI:Create("Label");
    QueuedAuctionNoBidsActionLabel:SetText("|c00FFF569Default action when no one bids on a queued auction|r");
    QueuedAuctionNoBidsActionLabel:SetFullWidth(true);
    Parent:AddChild(QueuedAuctionNoBidsActionLabel);

    local Actions = GL.Data.Constants.GDKP.QueuedAuctionNoBidsActions;

    local QueuedAuctionNoBidsActionDropdown = GL.AceGUI:Create("Dropdown");
    QueuedAuctionNoBidsActionDropdown:SetValue(GL.Settings:get("GDKP.queuedAuctionNoBidsAction"));
    QueuedAuctionNoBidsActionDropdown:SetList(Actions);
    QueuedAuctionNoBidsActionDropdown:SetText(GL.Settings:get("GDKP.queuedAuctionNoBidsAction"));
    QueuedAuctionNoBidsActionDropdown:SetFullWidth(true);
    QueuedAuctionNoBidsActionDropdown:SetCallback("OnValueChanged", function()
        local value = QueuedAuctionNoBidsActionDropdown:GetValue();

        if (GL.Data.Constants.GDKP.QueuedAuctionNoBidsActions[value]) then
            GL.Settings:set("GDKP.queuedAuctionNoBidsAction", value);
        end
    end);
    Parent:AddChild(QueuedAuctionNoBidsActionDropdown);

    Overview:drawHeader("Item Prices", Parent);

    local ImportPerItemSettings = GL.AceGUI:Create("Button");
    ImportPerItemSettings:SetText("Import item prices and increments");
    ImportPerItemSettings:SetFullWidth(true);
    ImportPerItemSettings:SetCallback("OnClick", function()
        GL.Interface.GDKP.ImportPrices:open();
    end);
    Parent:AddChild(ImportPerItemSettings);

    Spacer = GL.AceGUI:Create("SimpleGroup");
    Spacer:SetLayout("FILL");
    Spacer:SetFullWidth(true);
    Spacer:SetHeight(20);
    Parent:AddChild(Spacer);

    Overview:drawCheckboxes({
        {
            label = "Remember minimum bid and increment for each item",
            description = "If enabled, minimum and increment are remembered for each item. If not, the last minimum/increment you used will remain in place",
            setting = "GDKP.storeMinimumAndIncrementPerItem",
        },
    }, Parent);

    Spacer = GL.AceGUI:Create("SimpleGroup");
    Spacer:SetLayout("FILL");
    Spacer:SetFullWidth(true);
    Spacer:SetHeight(20);
    Parent:AddChild(Spacer);

    local DefaultMinimumBidLabel = GL.AceGUI:Create("Label");
    DefaultMinimumBidLabel:SetText("|c00FFF569Set a default minimum bid|r");
    DefaultMinimumBidLabel:SetFullWidth(true);
    Parent:AddChild(DefaultMinimumBidLabel);

    local DefaultMinimumBid = GL.AceGUI:Create("EditBox");
    DefaultMinimumBid:DisableButton(true);
    DefaultMinimumBid:SetHeight(20);
    DefaultMinimumBid:SetFullWidth(true);
    DefaultMinimumBid:SetText(GL.Settings:get("GDKP.defaultMinimumBid"));
    DefaultMinimumBid:SetCallback("OnTextChanged", function (self)
        local value = self:GetText();

        if (type(value) ~= "string"
            or GL:empty(value)
        ) then
            return;
        end

        value = tonumber(value);

        if (not value or value < 1) then
            return;
        end

        GL.Settings:set("GDKP.defaultMinimumBid", value);
    end);
    Parent:AddChild(DefaultMinimumBid);

    local DefaultIncrementLabel = GL.AceGUI:Create("Label");
    DefaultIncrementLabel:SetText("|c00FFF569Set a default increment|r");
    DefaultIncrementLabel:SetFullWidth(true);
    Parent:AddChild(DefaultIncrementLabel);

    local DefaultIncrement = GL.AceGUI:Create("EditBox");
    DefaultIncrement:DisableButton(true);
    DefaultIncrement:SetHeight(20);
    DefaultIncrement:SetFullWidth(true);
    DefaultIncrement:SetText(GL.Settings:get("GDKP.defaultIncrement"));
    DefaultIncrement:SetCallback("OnTextChanged", function (self)
        local value = self:GetText();

        if (type(value) ~= "string"
                or GL:empty(value)
        ) then
            return;
        end

        value = tonumber(value);

        if (not value or value < 1) then
            return;
        end

        GL.Settings:set("GDKP.defaultIncrement", value);
    end);
    Parent:AddChild(DefaultIncrement);



    Spacer = GL.AceGUI:Create("SimpleGroup");
    Spacer:SetLayout("FILL");
    Spacer:SetFullWidth(true);
    Spacer:SetHeight(20);
    Parent:AddChild(Spacer);

    Overview:drawHeader("UI Style", Parent);

    local HorizontalSpacer = GL.AceGUI:Create("SimpleGroup");
    HorizontalSpacer:SetLayout("FILL");
    HorizontalSpacer:SetFullWidth(true);
    HorizontalSpacer:SetHeight(20);
    Parent:AddChild(HorizontalSpacer);

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
        GL.Interface.Dialogs.PopupDialog:open({
            question = "Are you sure you want to reset all individual item settings?",
            OnYes = function ()
                GL.GDKP:resetPerItemSettings();
            end,
        });
    end);
    Parent:AddChild(ResetPerItemSettings);

    local ResetGDKPSettings = GL.AceGUI:Create("Button");
    ResetGDKPSettings:SetText("Reset GDKP settings to default");
    ResetGDKPSettings:SetFullWidth(true);
    ResetGDKPSettings:SetCallback("OnClick", function()
        GL.Interface.Dialogs.PopupDialog:open({
            question = "Are you sure you want to reset all GDKP settings?",
            OnYes = function ()
                local PerItemSettings = Settings:get("GDKP.SettingsPerItem", {});
                Settings:set("GDKP", {});
                Settings:set("GDKP.SettingsPerItem", PerItemSettings);
                C_UI.Reload();
            end,
        });
    end);
    Parent:AddChild(ResetGDKPSettings);

    local ResetGDKPSessionData = GL.AceGUI:Create("Button");
    ResetGDKPSessionData:SetText("Reset GDKP session data");
    ResetGDKPSessionData:SetFullWidth(true);
    ResetGDKPSessionData:SetCallback("OnClick", function()
        GL.Interface.Dialogs.PopupDialog:open({
            question = "Are you sure you want to delete all session data? You will lose ALL auction data. Use with extreme caution!",
            OnYes = function ()
                GL.DB:set("GDKP", {});
                C_UI.Reload();
            end,
        });
    end);
    Parent:AddChild(ResetGDKPSessionData);

    Overview:drawHeader("Mutators", Parent);

    local MutatorExplanation = GL.AceGUI:Create("Label");
    MutatorExplanation:SetText("The mutators shown below will automatically be added to all new GDKP sessions");
    MutatorExplanation:SetFullWidth(true);
    Parent:AddChild(MutatorExplanation);

    Spacer = GL.AceGUI:Create("SimpleGroup");
    Spacer:SetLayout("FILL");
    Spacer:SetFullWidth(true);
    Spacer:SetHeight(10);
    Parent:AddChild(Spacer);

    local MutatorNames = {};
    local Mutators = Settings:get("GDKP.Mutators", {});

    for name in pairs(Mutators) do
        tinsert(MutatorNames, name);
    end

    table.sort(MutatorNames);

    for i = 1, 20 do
        local mutatorName = MutatorNames[i] or nil;
        local MutatorDetails = {};

        if (mutatorName) then
            MutatorDetails = Settings:get("GDKP.Mutators." .. mutatorName, {});
        end

        local Name = GL.AceGUI:Create("EditBox");
        Name:DisableButton(true);
        Name:SetHeight(20);
        Name:SetWidth(80);
        Name:SetText(MutatorDetails.name);
        Parent:AddChild(Name);

        local Percentage = GL.AceGUI:Create("EditBox");
        Percentage:DisableButton(true);
        Percentage:SetHeight(20);
        Percentage:SetWidth(100);
        Percentage:SetText(MutatorDetails.percentage);
        Parent:AddChild(Percentage);

        local Flat = GL.AceGUI:Create("EditBox");
        Flat:DisableButton(true);
        Flat:SetHeight(20);
        Flat:SetWidth(100);
        Flat:SetText(MutatorDetails.flat);
        Parent:AddChild(Flat);

        local AutoApplyTo = GL.AceGUI:Create("EditBox");
        AutoApplyTo:DisableButton(true);
        AutoApplyTo:SetHeight(20);
        AutoApplyTo:SetWidth(220);
        AutoApplyTo:SetText(MutatorDetails.autoApplyTo);
        AutoApplyTo:SetMaxLetters(2);
        Parent:AddChild(AutoApplyTo);

        self.InputElements[i] = {
            Name = Name,
            Percentage = Percentage,
            Flat = Flat,
            AutoApplyTo = AutoApplyTo,
        };

        if (i == 1) then
            Name:SetLabel("|cffFFF569Name|r");
            Percentage:SetLabel("|cffFFF569Percentage|r");
            Flat:SetLabel("|cffFFF569Flat g|r");
            AutoApplyTo:SetLabel("|cffFFF569Apply to|r");
        end

        if (i < 20) then
            Spacer = GL.AceGUI:Create("SimpleGroup");
            Spacer:SetLayout("FILL");
            Spacer:SetFullWidth(true);
            Spacer:SetHeight(10);
            Parent:AddChild(Spacer);
        end
    end
end

--- Store the button details (will be overwritten by the draw method)
function GDKP:onClose()
    GL.Settings:set("GDKP.Mutators", {});

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