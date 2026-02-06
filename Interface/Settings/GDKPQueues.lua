---@type GL
local _, GL = ...;

---@type SettingsOverview
local Overview = GL.Interface.Settings.Overview;

---@class GDKPQueuesSettings
GL.Interface.Settings.GDKPQueues = {
    InputElements = {},
    ItemLevelElements = {},
};

---@type GDKPQueuesSettings
local GDKPQueues = GL.Interface.Settings.GDKPQueues;

---@return nil
function GDKPQueues:draw(Parent)
    local Spacer;

    Overview:drawCheckboxes({
        {
            label = "Completely disable queues",
            setting = "GDKP.disableQueues",
        },
        {
            label = "Automatically add drops to queue",
            setting = "GDKP.addDropsToQueue",
        },
        {
            label = "Include BOEs",
            setting = "GDKP.addBOEDropsToQueue",
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
    }, Parent);

    Spacer = GL.AceGUI:Create("SimpleGroup");
    Spacer:SetLayout("FILL");
    Spacer:SetFullWidth(true);
    Spacer:SetHeight(20);
    Parent:AddChild(Spacer);

    local MinimumDropQualityLabel = GL.AceGUI:Create("Label");
    MinimumDropQualityLabel:SetText("|c00FFF569Minimum quality of items to automatically add to queue|r");
    MinimumDropQualityLabel:SetFullWidth(true);
    Parent:AddChild(MinimumDropQualityLabel);

    local QualityList = {};
    local ItemQualityColors = GL.Data.Constants.ItemQualityColors;
    for i = 0, #ItemQualityColors do
        QualityList[i] = ("|c00%s%s|r"):format(ItemQualityColors[i].hex, ItemQualityColors[i].description);
    end

    local MinimumDropQuality = GL.AceGUI:Create("Dropdown");
    MinimumDropQuality:SetHeight(20);
    MinimumDropQuality:SetWidth(250);
    MinimumDropQuality:SetList(QualityList);
    MinimumDropQuality:SetValue(GL.Settings:get("GDKP.minimumDropQuality"));
    MinimumDropQuality:SetCallback("OnValueChanged", function()
        GL.Settings:set("GDKP.minimumDropQuality", MinimumDropQuality:GetValue());
    end);
    Parent:AddChild(MinimumDropQuality);

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
    QueuedAuctionNoBidsActionDropdown:SetWidth(250);
    QueuedAuctionNoBidsActionDropdown:SetCallback("OnValueChanged", function()
        local value = QueuedAuctionNoBidsActionDropdown:GetValue();

        if (GL.Data.Constants.GDKP.QueuedAuctionNoBidsActions[value]) then
            GL.Settings:set("GDKP.queuedAuctionNoBidsAction", value);
        end
    end);
    Parent:AddChild(QueuedAuctionNoBidsActionDropdown);

    Spacer = GL.AceGUI:Create("SimpleGroup");
    Spacer:SetLayout("FILL");
    Spacer:SetFullWidth(true);
    Spacer:SetHeight(20);
    Parent:AddChild(Spacer);

    local DelayInSecondsBetweenQueuedAuctions = GL.AceGUI:Create("Slider");
    DelayInSecondsBetweenQueuedAuctions:SetLabel("Delay in seconds between queued auctions");
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
end

GL:debug("Interface/Settings/GDKP.lua");