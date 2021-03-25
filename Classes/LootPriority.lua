local _, App = ...;

App.Ace.GUI = App.Ace.GUI or LibStub("AceGUI-3.0");

App.LootPriority = {
    initialized = false,
};

local Utils = App.Utils;
local AceGUI = App.Ace.GUI;
local LootPriority = App.LootPriority;

function LootPriority:_init()
    Utils:debug("LootPriority:_init");

    if (self._initialized) then
        return;
    end

    -- Bind the appendLootPrioToTooltip method to the OnTooltipSetItem event
    GameTooltip:HookScript("OnTooltipSetItem", function(tooltip)
        self:appendLootPrioToTooltip(tooltip);
    end);

    self._initialized = true;
end

-- Fetch an item's prio
function LootPriority:getPriority(itemIdOrLink, itemName)
    Utils:debug("LootPriority:getPriority");

    local itemId = itemIdOrLink;
    if (Utils:strIsItemLink(itemIdOrLink)) then
        itemId = Utils:getItemIdFromLink(itemIdOrLink);
        itemName = Utils:getItemNameFromLink(itemIdOrLink);
    end

    return App.DB.LootPriority[itemId]
        or App.DB.LootPriority[itemName];
end

-- Append the loot prio as defined in App.DB.LootPriority to an item's tooltip
function LootPriority:appendLootPrioToTooltip(tooltip)
    Utils:debug("LootPriority:appendLootPrioToTooltip");

    -- No tooltip was provided
    if (not tooltip) then
        return;
    end

    local _, itemLink = tooltip:GetItem();

    -- We couldn't find an itemLink (this can actually happen!)
    if (not itemLink) then
        return;
    end

    local itemPriority = self:getPriority(itemLink);

    -- No prio defined for this item
    if (not itemPriority) then
        return;
    end

    -- Add the header
    tooltip:AddLine(string.format("\n|c00efb8cd%s", "Loot Prio"));

    -- Add the actual item prio
    for priorityLevel, value in pairs(itemPriority) do
        tooltip:AddLine(string.format("|c008aecff %s: %s", priorityLevel, value))
    end
end

function LootPriority:drawImporter()
    Utils:debug("LootPriority:drawImporter");

    -- Create a container/parent frame
    local LootPriorityFrame = AceGUI:Create("Frame");
    LootPriorityFrame:SetTitle(App.name .. " v" .. App.version);
    LootPriorityFrame:SetStatusText("Addon v" .. App.version);
    LootPriorityFrame:SetLayout("Flow");
    LootPriorityFrame:SetWidth(600);
    LootPriorityFrame:SetHeight(450);
    LootPriorityFrame.statustext:GetParent():Hide(); -- Hide the statustext bar

    -- Large edit box
    local LootPriorityBoxContent = "";
    local LootPriorityBox = AceGUI:Create("MultiLineEditBox");
    LootPriorityBox:SetFullWidth(true);
    LootPriorityBox:DisableButton(true);
    LootPriorityBox:SetFocus();
    LootPriorityBox:SetLabel("Provide a prio CSV in the following format (1 line per item): id or name > prio1, equalprio > prio2 > etc");
    LootPriorityBox:SetNumLines(22);
    LootPriorityBox:SetMaxLetters(999999999);
    LootPriorityFrame:AddChild(LootPriorityBox);

    local LootPriorityCSV = "";

    if (App.DB.LootPriority and type(App.DB.LootPriority) == "table") then
        for item, priority in pairs(App.DB.LootPriority) do
            local prioritycount = #priority;
            local priorityString = "";

            for index = 1, prioritycount do
                priorityString = string.format("%s > %s", priorityString, priority[index]);
            end

            LootPriorityCSV = string.format("%s%s %s\n", LootPriorityCSV, item, priorityString);
        end
    end

    LootPriorityBox:SetText(LootPriorityCSV);

    LootPriorityBox:SetCallback("OnTextChanged", function(_, _, text)
        LootPriorityBoxContent = text;
    end)

    --[[
        FOOTER BUTTON PARENT FRAME
    ]]
    local FooterFrame = AceGUI:Create("SimpleGroup");
    FooterFrame:SetLayout("Flow");
    FooterFrame:SetFullWidth(true);
    FooterFrame:SetHeight(50);
    LootPriorityFrame:AddChild(FooterFrame);

    local SaveButton = AceGUI:Create("Button");
    SaveButton:SetText("Save");
    SaveButton:SetWidth(140);
    SaveButton:SetCallback("OnClick", function()
        self:save(LootPriorityBoxContent);
    end);
    FooterFrame:AddChild(SaveButton);

    local ClearButton = AceGUI:Create("Button");
    ClearButton:SetText("Clear");
    ClearButton:SetWidth(140);
    ClearButton:SetCallback("OnClick", function()
        LootPriorityBox:SetText("");
    end);
    FooterFrame:AddChild(ClearButton);
end

function LootPriority:save(data, sender)
    Utils:debug("LootPriority:save");

    if (not data or type(data) ~= "string") then
        return Utils:warning("Invalid data provided");
    end

    local LootPriorityData = {};
    for line in data:gmatch("[^\n]+") do
        local segments = Utils:strSplit(line, ">");
        local segmentCount = #segments;

        if (segmentCount < 2) then
            return Utils:warning(string.format("Invalid data provided in line: '%s': missing item id or priority", line));
        end

        local key = strtrim(segments[1]);
        local keyIsNumeric = tonumber(key) ~= nil;

        if (tonumber(key) ~= nil) then
            key = tonumber(key);
        end

        LootPriorityData[key] = {};

        for segment = 2, segmentCount do
            local priority = strtrim(segments[segment]);

            tinsert(LootPriorityData[key], priority);
        end
    end

    App.DB.LootPriority = LootPriorityData;

    Utils:success("Save successful");
end

Utils:debug("LootPriority.lua");