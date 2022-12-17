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

    Overview:drawHeader("Auctions", Parent);

    Overview:drawCheckboxes({
        {
            label = "Announce start of auction",
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
            label = "Countdown on auctions",
            description = "A countdown will be shown in chat when an auction is coming to an end (e.g: 5 seconds to bid)",
            setting = "GDKP.doCountdown",
        },
        {
            label = "Countdown ONCE",
            description = "Announce auction countdown only once instead of every second when countdown timer is reached",
            setting = "GDKP.announceCountdownOnce",
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
    }, Parent);

    Spacer = GL.AceGUI:Create("SimpleGroup");
    Spacer:SetLayout("FILL");
    Spacer:SetFullWidth(true);
    Spacer:SetHeight(20);
    Parent:AddChild(Spacer);

    local NumberOfSecondsToCountdown = GL.AceGUI:Create("Slider");
    NumberOfSecondsToCountdown:SetLabel("At how many seconds left do you want to start the countdown?");
    NumberOfSecondsToCountdown.label:SetTextColor(1, .95686, .40784);
    NumberOfSecondsToCountdown:SetFullWidth(true);
    NumberOfSecondsToCountdown:SetValue(GL.Settings:get("GDKP.numberOfSecondsToCountdown", 5));
    NumberOfSecondsToCountdown:SetSliderValues(3, 25, 1);
    NumberOfSecondsToCountdown:SetCallback("OnValueChanged", function(Slider)
        local value = math.floor(tonumber(Slider:GetValue()));

        if (value >= 3) then
            GL.Settings:set("GDKP.numberOfSecondsToCountdown", value);
        end
    end);
    Parent:AddChild(NumberOfSecondsToCountdown);

    Spacer = GL.AceGUI:Create("SimpleGroup");
    Spacer:SetLayout("FILL");
    Spacer:SetFullWidth(true);
    Spacer:SetHeight(20);
    Parent:AddChild(Spacer);

    Overview:drawHeader("UI Style", Parent);

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
            label = "Show GDKP gold details window",
            setting = "GDKP.showGoldDetailsWindow",
        },
        {
            label = "Whisper a gold to give or receive message",
            setting = "GDKP.whisperGoldDetails",
        },
        {
            label = "Automatically add gold you owe",
            setting = "GDKP.addGoldToTradeWindow",
        },
    }, Parent);

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