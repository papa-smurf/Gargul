local _, App = ...;

App.Ace.GUI = App.Ace.GUI or LibStub("AceGUI-3.0");
App.Ace.ScrollingTable = App.Ace.ScrollingTable or LibStub("ScrollingTable");

App.BagInspector = {
    InspectionReport = {},
    inspectionInProgress = false,
};

local BagInspector = App.BagInspector;
local CommActions = App.Data.Constants.CommActions;
local ScrollingTable = App.Ace.ScrollingTable;
local AceGUI = App.Ace.GUI;

BagInspector.Widgets = {
    Frame = {},
    Buttons = {},
    EditBoxes = {},
    Labels = {},
    Tables = {},
    Icons = {},
};

-- Inspect either the entire group or a single player
function BagInspector:inspect(items, player)
    App:debug("BagInspector:inspect");

    if (not App.User.isInGroup) then
        return App:error("You're not in a group");
    end

    -- Only raid leader/assists or master
    -- looters can use this functionality
    if (not UnitIsGroupAssistant("player")
        and not UnitIsGroupLeader("player")
        and not App.User.isMasterLooter
    ) then
        return App:error("You need lead, assist or master looter privileges to use this functionality");
    end

    -- If a player name is provided we need to make
    -- sure that the player is in our group, otherwise
    -- we can't interact with them
    if (player
        and not App:playerIsInSameGroup(player)
    ) then
        return App:error("Due to certain API limitations you can only inspect people who are in your group");
    end

    -- This ensures that the item exists and that
    -- all of its info is available
    items = App:strSplit(items, ",");
    BagInspector.inspectionInProgress = true;

    -- Send the inspection request to the correct channel
    local CommMessage = {};
    if (player) then
        CommMessage = App.CommMessage.new(
            CommActions.inspectBags,
            items,
            "WHISPER",
            player
        ):send();
    elseif (App.User.isInRaid) then
        CommMessage = App.CommMessage.new(
            CommActions.inspectBags,
            items,
            "RAID"
        ):send();
    else
        CommMessage = App.CommMessage.new(
            CommActions.inspectBags,
            items,
            "PARTY"
        ):send();
    end

    -- After a period of X seconds inspect the results
    App.Ace:ScheduleTimer(function ()
        App:success("Inspection finished");
        BagInspector.inspectionInProgress = false;

        BagInspector:processInspectionResults(CommMessage);
    end, 8);
end

-- Someone requested an item count, report back!
function BagInspector:report(CommMessage)
    App:debug("BagInspector:report");

    -- No need to report back to ourselves
    if (CommMessage.Sender.name == App.User.name) then
        return;
    end

    local Items = CommMessage.content;
    local Report = {};

    -- Collect the item count for the requested item ids
    for _, itemId in pairs(Items) do
        Report[itemId] = GetItemCount(itemId);
    end

    CommMessage:respond(Report);
end

-- Loop through all the inspection
-- responses and process them
function BagInspector:processInspectionResults(CommMessage)
    App:debug("BagInspector:processInspectionResults");

    local ItemIds = {};
    local ItemLinksById = {};

    local numberOfResponses = 0;
    local senderName = "";
    for _, response in pairs(CommMessage.Responses) do
        senderName = response.Sender.name;
        local responseWasValid = false;
        local Report = response.content;

        for itemId, amount in pairs(Report) do
            itemId = tonumber(itemId);

            if (type(itemId) == "number"
                and type(amount) == "number"
                and itemId > 0
            ) then
                responseWasValid = true;
                ItemIds[itemId] = true;
                App:tableSet(BagInspector.InspectionReport, senderName .. "." .. itemId, amount);
            end
        end

        if (responseWasValid) then
            numberOfResponses = numberOfResponses + 1;
        end
    end

    -- We wrapped the inspection report logic in a method so
    -- that we can fire it seperately when all items including
    -- their item links have been successfully loaded by the API
    local displayInspectionReport = function ()
        if (numberOfResponses < 1) then
            return App:error("Bag inspection failed: no reports received");
        end

        if (numberOfResponses == 1) then
            BagInspector:displayPlayerInspectionResults(senderName, ItemLinksById);
        else
            BagInspector:displayGroupInspectionResults(ItemIds, ItemLinksById);
        end
    end

    local numberOfItems = 0;
    for _ in pairs(ItemIds) do
        numberOfItems = numberOfItems + 1;
    end

    local itemsLoaded = 0;
    for itemId in pairs(ItemIds) do
        local item = Item:CreateFromItemID(itemId)

        item:ContinueOnItemLoad(function()
            itemsLoaded = itemsLoaded + 1;
            ItemLinksById[itemId] = item:GetItemLink();

            if (itemsLoaded >= numberOfItems) then
                displayInspectionReport();
            end
        end)
    end
end

-- Display the report results from a personal bag inspection
function BagInspector:displayPlayerInspectionResults(playerName, ItemLinksById)
    for itemId, amount in pairs(BagInspector.InspectionReport[playerName]) do
        itemId = tonumber(itemId);

        local message = string.format("%s has %sx %s",
            playerName,
            amount,
            ItemLinksById[itemId]
        );

        App:message(message);
    end
end

-- Display the report results from a group-wide bag inspection
function BagInspector:displayGroupInspectionResults(ItemIds, ItemLinksById)
    local Report = {};

    for player, report in pairs(BagInspector.InspectionReport) do
        local amountString = "";
        local firstItem = true;

        for itemId in pairs(ItemIds) do
            itemId = tostring(itemId);
            local amount = report[itemId];

            if (not amount
                    or amount < 0
            ) then
                amount = "0";
            end

            amount = tostring(amount);

            if (firstItem) then
                firstItem = false;
                amountString = amount;
            else
                amountString = amountString .. ", " .. amount;
            end
        end

        tinsert(Report, {player, amountString});
    end

    -- Create a container/parent frame
    local ResultFrame = AceGUI:Create("Frame");
    ResultFrame:SetCallback("OnClose", function(widget)
        self.Widgets.Tables.InspectionReport:SetData({}, true);
        self.Widgets.Tables.InspectionReport = nil;
        AceGUI:Release(widget);
    end);
    ResultFrame:SetTitle("Gargul v" .. App.version);
    ResultFrame:SetStatusText("Addon v" .. App.version);
    ResultFrame:SetLayout("Flow");
    ResultFrame:SetWidth(600);
    ResultFrame:SetHeight(450);
    ResultFrame.statustext:GetParent():Hide(); -- Hide the statustext bar

    local firstItemLink = true;
    local itemLinkString = "      ";
    for _, itemLink in pairs(ItemLinksById) do
        if (firstItemLink) then
            itemLinkString = itemLinkString .. itemLink;
            firstItemLink = false;
        else
            itemLinkString = itemLinkString .. ", " .. itemLink;
        end
    end

    local ItemsLabel = AceGUI:Create("Label");
    ItemsLabel:SetText(itemLinkString);
    ItemsLabel:SetColor(.94, .72, .8);
    ItemsLabel:SetHeight(20);
    ItemsLabel:SetWidth(600);
    ResultFrame:AddChild(ItemsLabel);
    self.Widgets.Labels.Items = ItemsLabel;

    local columns = {
        {
            name = "Player",
            width = 170,
            align = "LEFT",
            color = {
                r = 0.5,
                g = 0.5,
                b = 1.0,
                a = 1.0
            },
            colorargs = nil,
            sort = App.Data.Constants.ScrollingTable.ascending,
        },
        {
            name = "Item count",
            width = 330,
            align = "LEFT",
            color = {
                r = 0.5,
                g = 0.5,
                b = 1.0,
                a = 1.0
            },
            colorargs = nil,
        },
    };

    local table = ScrollingTable:CreateST(columns, 20, 15, nil, ResultFrame.frame);
    table:EnableSelection(true);
    table:SetData(Report, true);
    table.frame:SetPoint("BOTTOM", ResultFrame.frame, "BOTTOM", 0, 50);

    self.Widgets.Tables.InspectionReport = table;
end

App:debug("BagInspector.lua");