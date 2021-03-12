local _, App = ...;

App.Ace.GUI = App.Ace.GUI or LibStub("AceGUI-3.0");
App.Ace.ScrollingTable = App.Ace.ScrollingTable or LibStub("ScrollingTable");

App.BagInspector = {
    InspectionReport = {
        Items = {},
        Reports = {},
        NumberOfItemsInspected = 0,
    },
    inspectionInProgress = false,
};

local BagInspector = App.BagInspector;
local CommActions = App.Data.Constants.Comm.Actions;
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

-- Inspect the raid group's bag contents for the
-- availability of specific items (max 8)
function BagInspector:inspect(items)
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

    -- This ensures that the item exists and that
    -- all of its info is available
    items = App:strSplit(items, ",");
    items = App:tableSlice(items, 8); -- inspect supports up to 8 items
    BagInspector.inspectionInProgress = true;

    -- Send the inspection request to the correct channel
    local CommMessage = {};
    App:success("Starting inspection...");
    if (App.User.isInRaid) then
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
    end, 5);
end

-- Someone requested an item count, report back!
function BagInspector:report(CommMessage)
    App:debug("BagInspector:report");

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
                App:tableSet(BagInspector.InspectionReport.Reports, senderName .. "." .. itemId, amount);
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

        BagInspector:displayInspectionResults(ItemIds, ItemLinksById);
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
            tinsert(BagInspector.InspectionReport.Items, {
                id = itemId,
                name = item:GetItemName(),
                link = item:GetItemLink(),
                icon = item:GetItemIcon(),
            });

            if (itemsLoaded >= numberOfItems) then
                BagInspector.InspectionReport.NumberOfItemsInspected = itemsLoaded;
                displayInspectionReport();
            end
        end)
    end
end

-- Display the report results from a group-wide bag inspection
function BagInspector:displayInspectionResults()
    -- Create a container/parent frame
    local ResultFrame = AceGUI:Create("Frame");
    ResultFrame:SetCallback("OnClose", function(widget)
        App:clearScrollTable(BagInspector.Widgets.Tables.InspectionReport);

        App.BagInspector.InspectionReport = {
            Items = {},
            Reports = {},
            NumberOfItemsInspected = 0,
        };
        App.BagInspector.inspectionInProgress = false;

        AceGUI:Release(widget);
    end);
    ResultFrame:SetTitle(App.name .. " v" .. App.version);
    ResultFrame:SetStatusText("Addon v" .. App.version);
    ResultFrame:SetLayout("Flow");
    ResultFrame:SetWidth(600);
    ResultFrame:SetHeight(450);
    ResultFrame.statustext:GetParent():Hide(); -- Hide the statustext bar

    local FirstRow = AceGUI:Create("SimpleGroup");
    FirstRow:SetLayout("Flow");
    FirstRow:SetFullWidth(true);
    FirstRow:SetHeight(30);
    ResultFrame:AddChild(FirstRow);

    local ItemIcons = {};
    local ItemSpacers = {};
    for index = 1, 8 do
        ItemSpacers[index] = AceGUI:Create("SimpleGroup");
        local ItemSpacer = ItemSpacers[index];
        ItemSpacer:SetHeight(30);
        ItemSpacer:SetLayout("Fill");

        if (index == 1) then
            ItemSpacer:SetWidth(130);
        else
            ItemSpacer:SetWidth(20);
        end

        FirstRow:AddChild(ItemSpacer);

        local Item = BagInspector.InspectionReport.Items[index];

        local ItemIconHolder = AceGUI:Create("SimpleGroup");
        ItemIconHolder:SetHeight(30);
        ItemIconHolder:SetWidth(30);
        FirstRow:AddChild(ItemIconHolder);

        ItemIcons[index] = AceGUI:Create("Icon");
        local ItemIcon = ItemIcons[index];
        ItemIcon:SetWidth(30);
        ItemIcon:SetHeight(30);

        if (Item and Item.id > 0) then
            ItemIcon:SetImage(Item.icon);
            ItemIcon:SetImageSize(30, 30);

            -- Show a gametooltip if the icon shown belongs to an item
            ItemIcon:SetCallback("OnEnter", function()
                GameTooltip:SetOwner(ItemIcon.frame, "ANCHOR_TOP");
                GameTooltip:SetHyperlink(Item.link);
                GameTooltip:Show();
            end)

            ItemIcon:SetCallback("OnLeave", function()
                GameTooltip:Hide();
            end)
        end

        ItemIconHolder:AddChild(ItemIcon);
    end

    local Columns = {
        {
            name = "Player",
            width = 100,
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
    };

    for index = 1, 8 do
        local name = "Amount";

        if (index > BagInspector.InspectionReport.NumberOfItemsInspected) then
            name = "";
        end

        tinsert(Columns, {
            name = name,
            width = 50,
            align = "CENTER",
            color = {
                r = 0.5,
                g = 0.5,
                b = 1.0,
                a = 1.0
            },
            colorargs = nil,
        });
    end

    -- Loop through all members of the group (party or raid)
    local PlayerData = {};
    local ClassColors = App.Data.Constants.ClassRgbColors;
    for index = 1, MAX_RAID_MEMBERS do
        local name, _, _, _, class = GetRaidRosterInfo(index);
        local Row = {};

        if (name
            and BagInspector.InspectionReport.Reports[name]
        ) then
            Row = {
                cols = {
                    {
                        value = name,
                        color = ClassColors[string.lower(class)],
                    },
                },
            };

            for index = 1, 8 do
                local Item = BagInspector.InspectionReport.Items[index];

                if (Item and Item.id) then
                    local itemIdString = tostring(Item.id);
                    local amount = BagInspector.InspectionReport.Reports[name][itemIdString];

                    tinsert(Row.cols, {
                        value = amount,
                        color = ClassColors[string.lower(class)],
                    });
                end
            end

            tinsert(PlayerData, Row);
        end
    end

    local table = ScrollingTable:CreateST(Columns, 20, 15, nil, ResultFrame.frame);
    table:EnableSelection(true);
    table:SetData(PlayerData);

    table.frame:SetPoint("BOTTOM", ResultFrame.frame, "BOTTOM", 0, 50);

    BagInspector.Widgets.Tables.InspectionReport = table;
end

App:debug("BagInspector.lua");