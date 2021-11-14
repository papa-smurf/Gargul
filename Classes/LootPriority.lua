---@type GL
local _, GL = ...;

GL.AceGUI = GL.AceGUI or LibStub("AceGUI-3.0");

---@class LootPriority
GL.LootPriority = {
    _initialized = false,
};

local AceGUI = GL.AceGUI;
local CommActions = GL.Data.Constants.Comm.Actions;
local LootPriority = GL.LootPriority; ---@type LootPriority

---@return void
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

--- Append the loot prio as defined in GL.DB.LootPriority to an item's tooltip
---
---@param tooltip table
---@return void
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

---@return void
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
    LootPriorityBox:SetText(self:toCSV());

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

--- Translate the lootpriority table to CSV
---
---@return string
function LootPriority:toCSV()
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

    return LootPriorityCSV;
end

--- Save a given loot priority string
---
---@param data string
---@return void
function LootPriority:save(data)
    GL:debug("LootPriority:save");

    if (type(data) ~= "string") then
        return GL:warning("Invalid data provided");
    end

    -- The user wishes to clear the loot priorities
    if (GL:empty(data)) then
        GL:success("Loot priorities cleared successfully");
        GL.DB.LootPriority = {};
        return;
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

--- Broadcast the loot priorities to the RAID / PARTY
---@return boolean
function LootPriority:broadcast()
    GL:debug("LootPriority:broadcast");

    if (self.broadcastInProgress) then
        GL:error("Broadcast still in progress");
        return false;
    end

    if (not GL.User.isInGroup) then
        GL:warning("No one to broadcast to, you're not in a group!");
        return false;
    end

    if (not GL.User.hasAssist
        and not GL.User.isMasterLooter
    ) then
        GL:warning("Insufficient permissions to broadcast, need ML, assist or lead!");
        return false;
    end

    local LootPriorityCSV = self:toCSV();
    -- Check if there's anything to share
    if (GL:empty(LootPriorityCSV)) then
        GL:warning("Nothing to broadcast, set up loot priorities first!");
        return false;
    end

    self.broadcastInProgress = true;
    GL.Events:fire("GL.LOOT_PRIORITY_BROADCAST_STARTED");

    local Broadcast = function ()
        GL:message("Broadcasting loot priorities...");

        local Label = GL.Interface:getItem(GL.LootPriority, "Label.BroadcastProgress");

        if (Label) then
            Label:SetText("Broadcasting...");
        end

        GL.CommMessage.new(
            CommActions.broadcastLootPriorities,
            LootPriorityCSV,
            "GROUP"
        ):send(function ()
            GL:success("Loot priority broadcast finished");
            self.broadcastInProgress = false;
            GL.Events:fire("GL.LOOT_PRIORITY_BROADCAST_ENDED");

            Label = GL.Interface:getItem(GL.LootPriority, "Label.BroadcastProgress");
            if (Label) then
                Label:SetText("Broadcast finished!");
            end
        end, function (sent, total)
            Label = GL.Interface:getItem(GL.LootPriority, "Label.BroadcastProgress");
            if (Label) then
                Label:SetText(string.format("Sent %s of %s bytes", sent, total));
            end
        end);
    end

    -- We're about to send a lot of data which will put strain on CTL
    -- Make sure we're out of combat before doing so!
    if (UnitAffectingCombat("player")) then
        GL:message("You are currently in combat, delaying loot priority broadcast");

        GL.Events:register("LootPriorityOutOfCombatListener", "PLAYER_REGEN_ENABLED", function ()
            GL.Events:unregister("LootPriorityOutOfCombatListener");
            Broadcast();
        end);
    else
        Broadcast();
    end

    return true;
end

--- Process an incoming loot priority broadcast
---
---@param CommMessage CommMessage
function LootPriority:receiveBroadcast(CommMessage)
    GL:debug("LootPriority:receiveBroadcast");

    -- No need to update our priorities if we broadcasted them ourselves
    if (CommMessage.Sender.id == GL.User.id) then
        GL:debug("LootPriority:receiveBroadcast received by self, skip");
        return true;
    end

    local priorities = CommMessage.content;
    if (type(priorities) == "string"
        and not GL:empty(priorities)
    ) then
        GL:warning("Attempting to process incoming loot priorities from " .. CommMessage.Sender.name);

        self:save(priorities);
    end
end

GL:debug("LootPriority.lua");