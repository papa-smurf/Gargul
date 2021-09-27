local _, GL = ...;

GL.AceGUI = GL.AceGUI or LibStub("AceGUI-3.0");
GL.ScrollingTable = GL.ScrollingTable or LibStub("ScrollingTable");

GL.BagInspector = {
    InspectionReport = {
        Items = {},
        Reports = {},
        NumberOfItemsInspected = 0,
    },
    inspectionInProgress = false,
};

local AceGUI = GL.AceGUI;
local BagInspector = GL.BagInspector;
local ScrollingTable = GL.ScrollingTable;
local CommActions = GL.Data.Constants.Comm.Actions;

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
    GL:debug("BagInspector:inspect");

    if (not GL.User.isInGroup) then
        return GL:error("You're not in a group");
    end

    -- Only raid leader/assists or master
    -- looters can use this functionality
    if (not UnitIsGroupAssistant("player")
        and not UnitIsGroupLeader("player")
        and not GL.User.isMasterLooter
    ) then
        return GL:error("You need lead, assist or master looter privileges to use this functionality");
    end

    -- This ensures that the item exists and that
    -- all of its info is available
    items = GL:strSplit(items, ",");
    items = GL:tableSlice(items, 8); -- inspect supports up to 8 items
    BagInspector.inspectionInProgress = true;

    -- Send the inspection request to the correct channel
    local CommMessage = {};
    GL:success("Starting inspection...");
    CommMessage = GL.CommMessage.new(
        CommActions.inspectBags,
        items,
        "GROUP"
    ):send();

    -- After a period of X seconds inspect the results
    GL.Ace:ScheduleTimer(function ()
        GL:success("Inspection finished");
        BagInspector.inspectionInProgress = false;

        BagInspector:processInspectionResults(CommMessage);
    end, 5);
end

-- Someone requested an item count, report back!
function BagInspector:report(CommMessage)
    GL:debug("BagInspector:report");

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
    GL:debug("BagInspector:processInspectionResults");

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
                GL:tableSet(BagInspector.InspectionReport.Reports, senderName .. "." .. itemId, amount);
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
            return GL:error("Bag inspection failed: no reports received");
        end

        BagInspector:displayInspectionResults(ItemIds, ItemLinksById);
    end

    local numberOfItems = 0;
    for _ in pairs(ItemIds) do
        numberOfItems = numberOfItems + 1;
    end

    local itemsLoaded = 0;
    for itemId in pairs(ItemIds) do
        local item = Item:CreateFromItemID(itemId);

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
    GL:debug("BagInspector:displayInspectionResults");

    -- Create a container/parent frame
    local ResultFrame = AceGUI:Create("Frame");
    ResultFrame:SetCallback("OnClose", function(widget)
        GL:clearScrollTable(BagInspector.Widgets.Tables.InspectionReport);

        GL.BagInspector.InspectionReport = {
            Items = {},
            Reports = {},
            NumberOfItemsInspected = 0,
        };
        GL.BagInspector.inspectionInProgress = false;

        AceGUI:Release(widget);
    end);
    ResultFrame:SetTitle("Gargul v" .. GL.version);
    ResultFrame:SetStatusText("Addon v" .. GL.version);
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
            sort = GL.Data.Constants.ScrollingTable.ascending,
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

    -- Loop through all members of the group
    local PlayerData = {};
    for index = 1, _G.MAX_RAID_MEMBERS do
        local name, _, _, _, class = GetRaidRosterInfo(index);
        local Row = {};

        if (GL.isEra and not strfind(name, "-")) then
            name = string.format("%s-%s", name, GL.User.realm);
        end

        if (name
            and BagInspector.InspectionReport.Reports[name]
        ) then
            Row = {
                cols = {
                    {
                        value = name,
                        color = GL:classRGBAColor(class),
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
                        color = GL:classRGBAColor(class),
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

GL:debug("BagInspector.lua");