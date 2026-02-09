local L = Gargul_L;

---@type GL
local _, GL = ...;

---@type Constants
local Constants = GL.Data.Constants;

---@type Events
local Events = GL.Events;

---@type SoftRes
local SoftRes = GL.SoftRes;

---@type TMB
local TMB = GL.TMB;

local LCG = LibStub("LibCustomGlowGargul-1.0");

---@class DroppedLoot
local DroppedLoot = {

    ---@type boolean
    _initialized = false,

    ---@type boolean
    allButtonsHooked = false,

    ---@type boolean
    lootWindowIsOpened = false,

    ---@type table
    Announced = {},

    ---@type table
    ButtonsHooked = {},

    ---@type table
    LootButtonItemLinkCache = {},
};

GL.DroppedLoot = DroppedLoot;

---@return boolean
function DroppedLoot:_init()
    -- No need to initialize this class twice
    if (self._initialized) then
        return false;
    end

    -- Fire DroppedLoot:lootReady every time a loot window is opened
    Events:register("DroppedLootLootOpenedListener", "LOOT_READY", function () self:lootReady(); end);

    -- Show a reminder window to use Gargul when trying to assign using native loot assignment
    Events:register("DroppedLootOpenMasterLooterListListener", "OPEN_MASTER_LOOT_LIST", function ()
        if (GL.User.isMasterLooter
            and GL.Settings:get("ExportingLoot.showLootAssignmentReminder")
            and TMB:available()
        ) then
            GL.Interface.ReminderToAssignLootUsingGargul:draw();
        end
    end);

    MasterLooterFrame:HookScript("OnHide", function ()
        GL.Interface.ReminderToAssignLootUsingGargul:close();
    end);

    -- Make sure to keep track of the loot window status
    Events:register("DroppedLootLootClosedListener", "LOOT_CLOSED", function ()
        self.lootWindowIsOpened = false;

        GL.Interface.ShortcutKeysLegend:close();
    end);

    -- Remove highlight on loot buttons when closing the loot window
    Events:register("DroppedLootLootClosedHighlighterListener", "LOOT_CLOSED",
        function ()
            self:removeHighlights();
            self.LootButtonItemLinkCache = {};
        end
    );

    -- Highlight items that are soft-reserved or have TMB details
    Events:register("DroppedLootLootSlotChangedHighlighterListener", "GL.LOOT_CHANGED", function () self:highlightItemsOfInterest() end);

    self._initialized = true;
    return true;
end

--- Fired when a loot window is opened
function DroppedLoot:lootReady()
    self.lootWindowIsOpened = true;

    self:lootChanged();
    Events:fire("GL.LOOT_CHANGED");

    -- Periodically check if the loot changed because the internal WoW events are not
    -- comprehensive enough to detect things like the player moving to the next page of items.
    GL:interval(.1, "DroppedLootLootChanged", function ()
        if (self:lootChanged()) then
            Events:fire("GL.LOOT_CHANGED");
        end

        if (not self.lootWindowIsOpened) then
            GL:cancelTimer("DroppedLootLootChanged");
        end
    end);

    -- Only announce loot in chat if the setting is enabled
    if (GL.User.isMasterLooter
        and GL.Settings:get("DroppedLoot.announceLootToChat")
    ) then
        self:announce();
    end

    if (GL.User.isMasterLooter
        and GL.Settings:get("ShortcutKeys.showLegend", true)
    ) then
        GL:after(1, "DroppedLootShowLegend", function ()
            if (self.lootWindowIsOpened) then
                GL.Interface.ShortcutKeysLegend:draw();
            end
        end);
    end

    -- Let the rest of the application know we're done announcing the items
    GL.Events:fire("GL.LOOT_ANNOUNCED");

    -- We need to delay the hooking of click events because some add-ons
    -- are slow when it comes to adding their custom buttons (looking at you XLoot)
    GL:after(.4, "DroppedLootHookEvents", function ()
        if (self.lootWindowIsOpened) then
            self:hookClickEvents();
        end
    end);
end

-- Check whether the loot in the loot window changed in any way e.g:
-- An item was taken from the window
-- The player navigated to a different page in the loot window
function DroppedLoot:lootChanged()
    local lootChanged = false;
    for buttonIndex = 1, LOOTFRAME_NUMBUTTONS do
        local buttonName = "LootButton" .. buttonIndex;
        local Button = getglobal("LootButton" .. buttonIndex);
        local itemLink = "";

        if (Button
            and Button:IsVisible()
            and Button.slot
        ) then
            itemLink = GetLootSlotLink(Button.slot);

            if (GL:empty(itemLink)) then
                itemLink = "";
            end
        end

        if (GL:tableGet(self.LootButtonItemLinkCache, buttonName, -1) ~= itemLink) then
            lootChanged = true;
        end

        self.LootButtonItemLinkCache[buttonName] = itemLink;
    end

    return lootChanged;
end

--- Remove the highlights on all loot buttons
function DroppedLoot:removeHighlights()
    GL:debug("DroppedLoot:removeHighlights");

    if (GL.isRetail) then
        return;
    end

    for buttonIndex = 1, LOOTFRAME_NUMBUTTONS do
        local Button = getglobal("LootButton" .. buttonIndex);

        if (Button) then
            GL:stopHighlight(getglobal("LootButton" .. buttonIndex));
        end
    end
end

-- Highlight items that are soft-reserved or otherwise need extra attention
function DroppedLoot:highlightItemsOfInterest()
    GL:debug("DroppedLoot:highlightItemsOfInterest");

    -- 4 is the max since buttons seem to be reused
    -- throughout loot pages... thanks Blizzard
    for buttonIndex = 1, LOOTFRAME_NUMBUTTONS do
        local Button = getglobal("LootButton" .. buttonIndex);

        if (Button and Button:IsVisible() and Button.slot) then
            local itemLink = GetLootSlotLink(Button.slot);

            if (itemLink) then
                GL:highlightItem(Button, itemLink);
            end
        end
    end
end

-- Hook click events to the item buttons in the
-- loot window (name LootButton1 through LootButton4)
-- Only 4 buttons will be used regardless of number of drops
-- Alt click opens the roll window, alt + shift opens the auctioneer window
function DroppedLoot:hookClickEvents()
    -- The first loot button should always exist,
    -- that way we can determine the button provider for all future buttons
    local buttonProvider = (function ()
        --- ElvUI support
        if (getglobal("ElvLootSlot1")) then
            return "ElvUI";
        end

        --- XLoot 1.0 support
        if (getglobal("XLootFrameButton1")) then
            return "XLoot1";
        end

        --- XLoot support
        if (getglobal("XLootButton1")) then
            return "XLoot";
        end

        --- default (vanilla) UI
        return "default";
    end)();

    --- Note: the default UI only supports 4 actionable buttons.
    --- Even though Add-ons like XLoot show more than 4 at a time, you can only interact with the first 4
    for buttonIndex = 1, LOOTFRAME_NUMBUTTONS do
        self.ButtonsHooked[buttonProvider] = self.ButtonsHooked[buttonProvider] or {};

        if (not self.ButtonsHooked[buttonProvider][buttonIndex]) then
            local Button;
            if (buttonProvider == "ElvUI") then
                --Button = getglobal("ElvLootSlot" .. buttonIndex);
                -- No need to support the ElvUI button since it's handled by the
                -- HandleModifiedItemClick handler in bootstrap.lua
            elseif (buttonProvider == "XLoot1") then
                Button = getglobal("XLootFrameButton" .. buttonIndex);
            elseif (buttonProvider == "XLoot") then
                Button = getglobal("XLootButton" .. buttonIndex);
            else
                --Button = getglobal("LootButton" .. buttonIndex);
                -- No need to support the vanilla button since it's handled by the
                -- HandleModifiedItemClick handler in bootstrap.lua

                return;
            end

            --- No button with this index was found, no need to look further
            if (not Button) then
                break;
            end

            Button:HookScript("OnClick", function ()
                local slot = tonumber(Button.slot) or buttonIndex;
                if (not slot) then
                    return;
                end

                HandleModifiedItemClick(GetLootSlotLink(slot));
            end);

            self.ButtonsHooked[buttonProvider][buttonIndex] = true;
        end
    end
end

--- Announce the loot that dropped in the party or raid chat
---@param Modifiers? table We can use this to override any of the global methods, only for testing purposes
function DroppedLoot:announce(Modifiers)
    Modifiers = Modifiers or {};
    local Functions = Modifiers.Functions or {
        GetNumLootItems = GetNumLootItems,
        GetLootSlotInfo = GetLootSlotInfo,
        GetLootSlotLink = GetLootSlotLink,
        GetLootSlotType = GetLootSlotType,
        GetLootSourceInfo = GetLootSourceInfo,
    };

    -- The sourceGUID is something we use to make sure
    -- we don't announce the same loot multiple times
    ---@type string|false
    local sourceGUID = false;

    -- Get the total number of items that dropped
    local itemCount = Functions.GetNumLootItems();

    -- Loop through every item in the loot window
    for lootIndex = 1, itemCount do
        local itemLink = Functions.GetLootSlotLink(lootIndex);

        (function ()
            -- We need an itemLink to work with. If an item doesn't have it that means:
            --     It's not a "real" item but gold/silver/copper
            --     The item no longer exists in the loot window
            --     The data is not (yet) available
            if (not itemLink) then
                return;
            end

            -- Make sure we don't override sourceGUID with false/nil if it was already set!
            sourceGUID = sourceGUID or Functions.GetLootSourceInfo(lootIndex);

            if (GL:empty(sourceGUID) -- Make sure we have a sourceGUID
                or self.Announced[sourceGUID] -- We already announced these items
            ) then
                return;
            end

            -- Double check itemID value just in case!
            local itemID = tonumber(GL:getItemIDFromLink(itemLink)) or 0;
            if (not GL:higherThanZero(itemID)) then
                return;
            end

            -- Make sure we're dealing with an actual item, not currency for example
            if (Functions.GetLootSlotType(lootIndex) ~= LOOT_SLOT_ITEM) then
                return;
            end

            local TMBInfo;
            local IDIsReserved = SoftRes:idIsReserved(itemID);
            local quality = select(5, Functions.GetLootSlotInfo(lootIndex)) or 0;
            if (quality < GL.Settings:get("DroppedLoot.minimumQualityOfAnnouncedLoot", 4) -- Quality is lower than our set minimum
                or GL:inTable(Constants.ItemsThatShouldntBeAnnounced, itemID) -- We don't want to announce this item
            ) then
                -- See if there's any TMB data worth sharing in chat
                if (GL.Settings:get("TMB.includePrioListInfoInLootAnnouncement")
                    or GL.Settings:get("TMB.includeWishListInfoInLootAnnouncement")
                ) then
                    TMBInfo = TMB:byItemID(itemID);
                end

                -- There's no softres or TMB data to share, return
                if (not IDIsReserved and GL:empty(TMBInfo)) then
                    return;
                end
            end

            -- Determine the correct channel for announcing the loot
            -- Both GROUP and RAID_WARNING will default to PARTY if not in a raid or if you don't have assist
            local channel = "GROUP";
            if (GL.Settings:get("DroppedLoot.announceDroppedLootInRW")) then
                channel = "RAID_WARNING";
            end

            --[[
                Announce the dropped item in chat
                * Either by itself or state that it's hard-reserved!
            ]]
            local itemIsHardReserved = SoftRes:IDIsHardReserved(itemID);
            if (itemIsHardReserved
                and GL.Settings:get("SoftRes.announceInfoInChat")
            ) then
                GL:sendChatMessage(
                    (L.CHAT["%s (This item is hard-reserved!)"]):format(itemLink),
                    channel
                );
            else
                -- Link the item in the chat for
                -- all group members to see
                GL:sendChatMessage(
                    itemLink,
                    channel
                );
            end

            --[[
                SHOW WHO RESERVED THIS ITEM (SOFTRES)
            ]]
            if (not itemIsHardReserved -- Only fetch the SoftRes data if the item isn't hard-reserved
                and IDIsReserved -- And there are any reserves
                and GL.Settings:get("SoftRes.announceInfoInChat") -- And the player wants to announce softres data in chat
            ) then
                local ActiveSoftResDetails = SoftRes:playerReserveAmountsByItemID(itemID);

                -- * This data is only available if the user has the announce SoftRes setting enabled
                if (not GL:empty(ActiveSoftResDetails)) then
                    GL:sendChatMessage(
                        (L.CHAT["Reserved by: %s"]):format(table.concat(ActiveSoftResDetails, ", ")),
                        "GROUP"
                    );
                end
            end

            TMB:announceDetailsOfItemInChat(itemID, TMBInfo);
        end)();
    end

    -- This ensures that we don't announce the same loot multiple times!
    -- Keep in mind that sourceGUID can be empty!
    if (sourceGUID) then
        self.Announced[sourceGUID] = true;
    end
end

--- This function allows me to test the loot announcement without actually having to kill bosses in raids
--- It also enables me to debug issues other players may have using their actual TMB/SoftRes data
function DroppedLoot:announceTest(...)
    local itemIDs = ...;

    if (type(itemIDs) ~= "table") then
        itemIDs = { itemIDs, };
    end

    -- Make sure all item links are translated to IDs
    for key, value in pairs(itemIDs) do
        value = string.trim(value);
        local concernsID = GL:higherThanZero(tonumber(value));

        if (not concernsID) then
            value = GL:getItemIDFromLink(value) or 0;
        end

        itemIDs[key] = value;
    end

    GL:onItemLoadDo(itemIDs, function (Details)
        self:announce{
            Functions = {
                GetNumLootItems = function () return GL:count(Details); end,
                GetLootSlotInfo = function (slot)
                    local SlotItem = Details[slot];

                    return SlotItem.icon, SlotItem.name, 1, nil, SlotItem.quality, false, false, nil, true;
                end,
                GetLootSlotLink = function (slot)
                    return Details[slot].link or nil;
                end,
                GetLootSlotType = function (slot)
                    local itemLink = Details[slot].link or "";

                    if (GL:strContains(itemLink, "Hcurrency:")) then
                        return LOOT_SLOT_CURRENCY;
                    end

                    return LOOT_SLOT_ITEM;
                end,
                GetLootSourceInfo = function () return GL:uuid() end,
            }
        };
    end);
end
