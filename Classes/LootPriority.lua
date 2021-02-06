local _, App = ...;

App.LootPriority = {
    initialized = false,
};

local LootPriority = App.LootPriority;

-- Fetch an items prio based on its ID
function LootPriority:getPriorityByItemId(itemId)
    -- We couldn't find an item ID
    if (not itemId) then
        return;
    end

    itemId = tonumber(itemId);

    return App.DB.LootPriority[itemId];
end

function LootPriority:_init()
    if (self._initialized) then
        return;
    end

    App:debug("LootPriority:_init");

    -- Bind the appendLootPrioToTooltip method to the OnTooltipSetItem event
    GameTooltip:HookScript("OnTooltipSetItem", function(tooltip)
        self:appendLootPrioToTooltip(tooltip);
    end);

    self._initialized = true;
end

-- Fetch an item's prio based on its item link
function LootPriority:getPriorityByItemLink(itemLink)
    App:debug("LootPriority:getPriorityByItemLink");

    return self:getPriorityByItemId(App:getItemIdFromLink(itemLink));
end

-- Append the loot prio as defined in App.DB.LootPriority to an item's tooltip
function LootPriority:appendLootPrioToTooltip(tooltip)
    App:debug("LootPriority:appendLootPrioToTooltip");

    -- No tooltip was provided
    if (not tooltip) then
        return;
    end

    local itemName, itemLink = tooltip:GetItem();

    -- We couldn't find an itemName or link (this can actually happen!)
    if (not itemName or not itemLink) then
        return;
    end

    local itemPriority = self:getPriorityByItemLink(itemLink);

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

App:debug("LootPriority.lua");