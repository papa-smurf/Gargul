local _, GL = ...;

GL.AceGUI = GL.AceGUI or LibStub("AceGUI-3.0");

GL.LootPriority = {
    initialized = false,
};

local AceGUI = GL.AceGUI;
local LootPriority = GL.LootPriority;

function LootPriority:_init()
    GL:debug("LootPriority:_init");

    if (self._initialized) then
        return;
    end

    -- Bind the appendLootPrioToTooltip method to the OnTooltipSetItem event
    GameTooltip:HookScript("OnTooltipSetItem", function(tooltip)
        self:appendLootPrioToTooltip(tooltip);
    end);

    self._initialized = true;
end

--- Fetch an item's prio
---
---@param itemLink string
---@param itemName string|nil
---@return string|nil
function LootPriority:getPriority(itemLink, itemName)
    GL:debug("LootPriority:byItemLink");

    local itemId = GL:getItemIdFromLink(itemLink);
    itemName = itemName or GL:getItemNameFromLink(itemLink);

    return GL.DB.LootPriority[itemId]
        or GL.DB.LootPriority[itemName];
end

-- Append the loot prio as defined in GL.DB.LootPriority to an item's tooltip
function LootPriority:appendLootPrioToTooltip(tooltip)
    GL:debug("LootPriority:appendLootPrioToTooltip");

    -- No tooltip was provided
    if (not tooltip) then
        return;
    end

    local itemName, itemLink = tooltip:GetItem();

    -- We couldn't find an itemLink (this can actually happen!)
    if (not itemLink) then
        return;
    end

    local itemPriority = self:getPriority(itemLink, itemName);

    -- No prio defined for this item
    if (not itemPriority) then
        return;
    end

    -- Add the header
    tooltip:AddLine(string.format("\n|c00efb8cd%s", "Loot Prio"));

    -- Add the actual item prio
    for priorityLevel, value in pairs(itemPriority) do
        tooltip:AddLine(string.format("|c008aecff    %s: %s", priorityLevel, value))
    end
end

function LootPriority:drawImporter()
    GL:debug("LootPriority:drawImporter");

    -- Create a container/parent frame
    local LootPriorityFrame = AceGUI:Create("Frame");
    LootPriorityFrame:SetTitle("Gargul v" .. GL.version);
    LootPriorityFrame:SetStatusText("Addon v" .. GL.version);
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

    if (GL.DB.LootPriority and type(GL.DB.LootPriority) == "table") then
        for item, priority in pairs(GL.DB.LootPriority) do
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

function LootPriority:save(data)
    GL:debug("LootPriority:save");

    if (not data or type(data) ~= "string") then
        return GL:warning("Invalid data provided");
    end

    local LootPriorityData = {};
    for line in data:gmatch("[^\n]+") do
        local segments = GL:strSplit(line, ">");
        local segmentCount = #segments;

        if (segmentCount < 2) then
            return GL:warning(string.format("Invalid data provided in line: '%s': missing item id or priority", line));
        end

        local key = strtrim(segments[1]);

        if (tonumber(key) ~= nil) then
            key = tonumber(key);
        end

        LootPriorityData[key] = {};

        for segment = 2, segmentCount do
            local priority = strtrim(segments[segment]);

            tinsert(LootPriorityData[key], priority);
        end
    end

    GL.DB.LootPriority = LootPriorityData;

    GL:success("Loot priorities imported successfully");
end

GL:debug("LootPriority.lua");