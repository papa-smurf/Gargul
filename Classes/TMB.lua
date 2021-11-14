---@type GL
local _, GL = ...;

GL.AceGUI = GL.AceGUI or LibStub("AceGUI-3.0");

---@class TMB
GL.TMB = {
    _initialized = false,
    broadcastInProgress = false,
};
local TMB = GL.TMB; ---@type TMB

local Constants = GL.Data.Constants; ---@type Data
local CommActions = Constants.Comm.Actions;
local Settings = GL.Settings; ---@type Settings

---@return boolean
function TMB:_init()
    GL:debug("TMB:_init");

    if (self._initialized) then
        return false;
    end

    -- Bind the appendTMBItemInfoToTooltip method to the OnTooltipSetItem event
    GameTooltip:HookScript("OnTooltipSetItem", function(tooltip)
        self:appendTMBItemInfoToTooltip(tooltip);
    end);

    self._initialized = true;
    return true;
end

--- Check whether there is TMB data available
---
---@return boolean
function TMB:available()
    return GL:higherThanZero(GL.DB:get("TMB.MetaData.importedAt", 0));
end

--- Fetch an item's TMB info based on its ID
---
---@param itemId number
---@param inRaidOnly boolean|nil
---@return table
function TMB:byItemId(itemId, inRaidOnly)
    GL:debug("TMB:byItemId");

    -- An invalid item id was provided
    itemId = tonumber(itemId);
    if (not GL:higherThanZero(itemId)) then
        return {};
    end

    if (type(inRaidOnly) ~= "boolean") then
        inRaidOnly = Settings:get("TMB.hideInfoOfPeopleNotInGroup");

        -- User is not in group and showEntriesWhenSolo is true
        if (inRaidOnly
            and not GL.User.isInGroup
            and GL.Settings:get("TMB.showEntriesWhenSolo")
        ) then
            inRaidOnly = false;
        end
    end

    -- The item linked to this id can have multiple IDs (head of Onyxia for example)
    local AllLinkedItemIds = GL:getLinkedItemsForId(itemId);

    local GroupMemberNames = {};
    if (inRaidOnly) then
        GroupMemberNames = GL.User:groupMemberNames();
    end

    local Processed = {};
    local Wishes = {};
    for _, id in pairs(AllLinkedItemIds) do
        id = tostring(id);
        for _, Entry in pairs(GL.DB:get("TMB.Items." .. tostring(id), {})) do
            local playerName = string.lower(GL:stripRealm(Entry.character));

            -- If inRaidOnly is true we need to make sure we only return details of people who are actually in the raid
            --- NOTE TO SELF: it's (os) because of the string.lower, if you remove the lower then change below accordingly!
            if (not inRaidOnly or GL:inTable(GroupMemberNames, string.gsub(playerName, "%(os%)", ""))) then
                local checkSum = string.format('%s||%s||%s', Entry.character, tostring(Entry.prio), tostring(Entry.type));

                -- Make sure we don't add the same player/prio combo more than once
                if (not Processed[checkSum]) then
                    Processed[checkSum] = true;
                    tinsert(Wishes, Entry);
                end
            end
        end
    end

    return Wishes;
end

--- Fetch an item's TMB info based on its item link
---
---@param itemLink string
---@param inRaidOnly boolean|nil
---@return table
function TMB:byItemLink(itemLink, inRaidOnly)
    GL:debug("TMB:byItemLink");

    if (GL:empty(itemLink)) then
        return {};
    end

    return self:byItemId(GL:getItemIdFromLink(itemLink), inRaidOnly);
end

--- Fetch an item's TMB tier based on its item link
---
---@param itemLink string
---@return string
function TMB:tierByItemLink(itemLink)
    GL:debug("TMB:tierByItemLink");

    if (GL:empty(itemLink)) then
        return "";
    end

    return self:tierByItemID(GL:getItemIdFromLink(itemLink));
end

--- Fetch an item's TMB tier based on its item ID
---
---@param itemID string
---@return string
function TMB:tierByItemID(itemID)
    GL:debug("TMB:tierByItemID");

    if (GL:empty(itemID)) then
        return "";
    end

    return GL.DB:get("TMB.Tiers." .. itemID, "");
end

--- Fetch an item's TMB note based on its item link
---
---@param itemLink string
---@return string
function TMB:noteByItemLink(itemLink)
    GL:debug("TMB:noteByItemLink");

    if (GL:empty(itemLink)) then
        return "";
    end

    return self:noteByItemID(GL:getItemIdFromLink(itemLink));
end

--- Fetch an item's TMB note based on its item ID
---
---@param itemID string
---@return string
function TMB:noteByItemID(itemID)
    GL:debug("TMB:noteByItemID");

    if (GL:empty(itemID)) then
        return "";
    end

    return GL.DB:get("TMB.Notes." .. itemID, "");
end

--- Append the TMB info as defined in GL.DB.TMB.Items to an item's tooltip
---
---@param tooltip GameTooltip
---@return void
function TMB:appendTMBItemInfoToTooltip(tooltip)
    GL:debug("TMB:appendTMBItemInfoToTooltip");

    -- No tooltip was provided
    if (not tooltip) then
        return;
    end

    -- If we're not in a group there's no point in showing anything! (unless the non-raider setting is active)
    if ((not GL.User.isInGroup and GL.Settings:get("TMB.hideInfoOfPeopleNotInGroup"))
        and (not GL.User.isInGroup and not GL.Settings:get("TMB.showEntriesWhenSolo"))
    ) then
        return;
    end

    local _, itemLink = tooltip:GetItem();

    -- We couldn't find an itemLink (this can actually happen!)
    if (GL:empty(itemLink)) then
        return;
    end

    local TMBTier = self:tierByItemLink(itemLink);
    local TMBNote = self:noteByItemLink(itemLink);
    local TMBInfo = self:byItemLink(itemLink);

    local TMBHeaderAdded = false;

    if (GL.Settings:get("TMB.showItemInfoOnTooltips")) then
        -- This item has a tier, show it!
        if (not GL:empty(TMBTier)
            and GL.Data.Constants.TMBTierHexColors[TMBTier]
        ) then
            local tierString = string.format("|cFF%s%s|r",
                GL.Data.Constants.TMBTierHexColors[TMBTier],
                TMBTier
            );

            -- Add the header
            tooltip:AddLine(string.format(
                "\n|cFF%sTMB:|r",
                GL.Data.Constants.addonHexColor,
                "TMB"
            ));
            TMBHeaderAdded = true;

            -- Add the tier string
            tooltip:AddLine(string.format(
                "|cFFFFFFFF    Tier:|r %s",
                tierString
            ));
        end

        -- This item has a note, show it!
        if (not GL:empty(TMBNote)) then
            if (not TMBHeaderAdded) then
                -- Add the header
                tooltip:AddLine(string.format(
                    "\n|cFF%sTMB:|r",
                    GL.Data.Constants.addonHexColor,
                    "TMB"
                ));
            end

            -- Add the note
            tooltip:AddLine(string.format(
                "|cFFFFFFFF    Note:|r |cFFFFF569%s|r",
                TMBNote
            ));
        end
    end

    -- No wishes defined for this item
    if (GL:empty(TMBInfo)) then
        return;
    end

    local WishListEntries = {};
    local PrioListEntries = {};
    local itemIsOnSomeonesWishlist = false;
    local itemIsOnSomeonesPriolist = false;
    local entriesAdded = 0;
    for _, Entry in pairs(TMBInfo) do
        local playerName = string.lower(Entry.character);
        local prio = Entry.prio;
        local entryType = Entry.type or Constants.tmbTypeWish;
        local isOffSpec = string.find(Entry.character, "%(OS%)");
        local prioOffset = 0;
        local sortingOrder = prio;
        local color = GL:classHexColor(GL.Player:classByName(playerName));

        -- We add 100 to the prio (first key) of the object
        -- This object is used for sorting later and is not visible to the player
        if (isOffSpec) then
            prioOffset = 100;
        end

        if (type(sortingOrder) == "number") then
            sortingOrder = prio + prioOffset;
        else
            -- If for whatever reason we can't determine the
            -- item prio then we add it to the end of the list by default
            sortingOrder = 1000;
        end

        -- TMB is not case-sensitive so people get creative with capital letters sometimes
        playerName = GL:capitalize(playerName);
        if (entryType == Constants.tmbTypePrio) then
            tinsert(PrioListEntries, {sortingOrder, string.format("|cFF%s    %s[%s]|r", color, playerName, prio)});
            itemIsOnSomeonesPriolist = true;
        else
            tinsert(WishListEntries, {sortingOrder, string.format("|cFF%s    %s[%s]|r", color, playerName, prio)});
            itemIsOnSomeonesWishlist = true;
        end
    end

    -- Only add the 'Prio List' header if the item is actually on someone's character prio list
    if (itemIsOnSomeonesPriolist
        and (GL.Settings:get("TMB.showPrioListInfoOnTooltips")
            or (not GL.User.isInGroup and GL.Settings:get("TMB.showEntriesWhenSolo"))
        )
    ) then
        -- Add the header
        tooltip:AddLine(string.format("\n|cFFff7a0a%s|r", "TMB Prio List"));

        -- Sort the PrioListEntries based on prio (lowest to highest)
        table.sort(PrioListEntries, function (a, b)
            return a[1] < b[1];
        end);

        -- Add the entries to the tooltip
        entriesAdded = 0;
        for _, Entry in pairs(PrioListEntries) do
            entriesAdded = entriesAdded + 1;

            tooltip:AddLine(string.format(
                "|cFF%s%s|r",
                GL:classHexColor(GL.Player:classByName(Entry[2])),
                GL:capitalize(Entry[2]):gsub("%(os%)", " (OS)")
            ));

            -- Make sure we don't add more names to the tooltip than the user allowed
            if (entriesAdded >= GL.Settings:get("TMB.maximumNumberOfTooltipEntries")) then
                break;
            end
        end
    end

    -- The item is on someone's prio list and the user is not interested in wishlist entries
    if (GL.Settings:get("TMB.hideWishListInfoIfPriorityIsPresent") and itemIsOnSomeonesPriolist)
        and (GL.User.isInGroup or not GL.Settings:get("TMB.showEntriesWhenSolo"))
    then
        return;
    end

    -- Only add the 'Wish List' header if the item is actually on someone's wishlist
    if (itemIsOnSomeonesWishlist
        and (GL.Settings:get("TMB.showWishListInfoOnTooltips")
            or (not GL.User.isInGroup and GL.Settings:get("TMB.showEntriesWhenSolo"))
        )
    ) then
        -- Add the header
        tooltip:AddLine(string.format("\n|cFFffffff%s|r", "TMB Wish List"));

        -- Sort the WishListEntries based on prio (lowest to highest)
        table.sort(WishListEntries, function (a, b)
            return a[1] < b[1];
        end);

        -- Add the entries to the tooltip
        entriesAdded = 0;
        for _, Entry in pairs(WishListEntries) do
            entriesAdded = entriesAdded + 1;

            tooltip:AddLine(string.format(
                "|cFF%s%s|r",
                GL:classHexColor(GL.Player:classByName(Entry[2])),
                GL:capitalize(Entry[2]):gsub("%(os%)", " (OS)")
            ));

            -- Make sure we don't add more names to the tooltip than the user allowed
            if (entriesAdded >= GL.Settings:get("TMB.maximumNumberOfTooltipEntries")) then
                break;
            end
        end
    end
end

--- Draw either the importer or overview
--- based on the current soft-reserve data
---
---@return void
function TMB:draw()
    GL:debug("TMB:draw");

    -- No data available, show importer
    if (not self:available()) then
        GL.Interface.TMB.Importer:draw();
        return;
    end

    GL.Interface.TMB.Overview:draw();
end

--- Clear all TMB data
---
---@return void
function TMB:clear()
    GL.DB.TMB = {};

    GL.Events:fire("GL.TMB_CLEARED");
end

--- Import a given tmb string
---
---@param data string
---@param triedToDecompress boolean
---@return boolean
function TMB:import(data, triedToDecompress)
    GL:debug("TMB:import");

    local function displayGenericException()
        GL.Interface:getItem("TMB.Importer", "Label.StatusMessage"):SetText("Invalid TMB data provided, make sure to click the 'Download' button in the Gargul section and paste the contents here as-is!");
    end

    if (type(data) ~= "string"
        or GL:empty(data)
    ) then
        displayGenericException();
        return false;
    end

    -- Make sure to get rid of any leadin/trailing whitespaces
    data = strtrim(data);

    -- This is the new zlib format, attempt to decompress it!
    if (not triedToDecompress
        and not GL:strStartsWith(data, "{\"wishlists\":")
    ) then
        data = TMB:decompress(data);
        return TMB:import(data, true);
    end

    local jsonDecodeSucceeded, WebsiteData = pcall(function () return GL.JSON:decode(data); end);

    -- Make sure the given string could actually be decoded
    if (not jsonDecodeSucceeded
        or not WebsiteData
        or type(WebsiteData) ~= "table"
    ) then
        displayGenericException();
        return false;
    end

    -- Import the actual TMB data
    local wishlistItemsWereImported = false;
    if (type(WebsiteData.wishlists) == "table"
        and not GL:empty(WebsiteData.wishlists)
    ) then
        local processedEntryCheckums = {};
        local formatDecided = false;
        local TMBData = {};
        local Keys = {
            name = 1,
            order = 2,
            type = 3,
            groupID = 4,
        };

        for itemId, WishListEntries in pairs(WebsiteData.wishlists) do
            TMBData[itemId] = {};
            for _, characterString in pairs(WishListEntries) do
                local stringParts = GL:strSplit(characterString, "|");

                -- Check whether the format provided is the old (deprecated) format
                if (not formatDecided) then
                    local isOldFormat = GL:count(stringParts) > 4; -- The old TMB format has more than 4 parts

                    if (isOldFormat) then
                        Keys = {
                            name = 1,
                            order = 3,
                            type = 5,
                            groupID = nil, -- The old format doesn't support the groupID
                        };
                    end

                    formatDecided = true;
                end

                local characterName = "";
                local order = "?";
                local raidGroupID = nil;
                local type = Constants.tmbTypeWish;

                if (stringParts[Keys.name] and stringParts[Keys.order]) then
                    characterName = stringParts[Keys.name];
                    order = tonumber(stringParts[Keys.order]) or order;
                end

                if (stringParts[Keys.type]) then
                    local providedType = tonumber(stringParts[Keys.type]);

                    if (providedType == Constants.tmbTypePrio) then
                        type = Constants.tmbTypePrio;
                    end
                end

                if (Keys.groupID and stringParts[Keys.groupID]) then
                    raidGroupID = tonumber(stringParts[Keys.groupID]);
                end

                if (characterName and order) then
                    local checkSum = string.format('%s||%s||%s||%s||%s', itemId, characterName, order, type, raidGroupID or 0);

                    -- Make sure to ignore duplicates
                    if (not processedEntryCheckums[checkSum]) then
                        tinsert(TMBData[itemId], {
                            ["character"] = characterName,
                            ["prio"] = order,
                            ["type"] = type,
                            ['group'] = raidGroupID,
                        });

                        wishlistItemsWereImported = true;
                        processedEntryCheckums[checkSum] = true;
                    end
                end
            end
        end

        GL.DB.TMB.Items = TMBData;
    end

    -- There are item notes available, store them
    if (WebsiteData.notes and type(WebsiteData.notes) == "table") then
        for itemID, note in pairs(WebsiteData.notes) do
            GL.DB:set("TMB.Notes." .. itemID, note);
        end
    end

    -- There are item tiers available, store them
    if (WebsiteData.tiers and type(WebsiteData.tiers) == "table") then
        for itemID, tier in pairs(WebsiteData.tiers) do
            GL.DB:set("TMB.Tiers." .. itemID, tier);
        end
    end

    -- There is also loot priority data available, pass it to on!
    if (type(WebsiteData.loot) == "string"
        and not GL:empty(WebsiteData.loot)
    ) then
        GL.LootPriority:save(WebsiteData.loot);
    end

    -- This can happen if the user only imported item notes
    if (GL:empty(wishlistItemsWereImported)) then
        return true;
    end

    GL.DB.TMB.MetaData = {
        importedAt = GetServerTime(),
    };

    GL.Events:fire("GL.TMB_IMPORTED");
    GL.Interface.TMB.Importer:close();
    self:draw();

    return true;
end

---@param data string
---@return string
function TMB:decompress(data)
    local base64DecodeSucceeded;
    base64DecodeSucceeded, data = pcall(function () return GL.Base64.decode(data); end);

    -- Something went wrong while base64 decoding the payload
    if (not base64DecodeSucceeded) then
        local errorMessage = "Unable to base64 decode the data. Make sure you copy/paste it as-is from thatsmybis.com without changing anything!";
        GL.Interface:getItem("TMB.Importer", "Label.StatusMessage"):SetText(errorMessage);

        return "";
    end

    local LibDeflate = LibStub:GetLibrary("LibDeflate");
    local zlibDecodeSucceeded;
    zlibDecodeSucceeded, data = pcall(function () return LibDeflate:DecompressZlib(data); end);

    -- Something went wrong while zlib decoding the payload
    if (not zlibDecodeSucceeded) then
        local errorMessage = "Unable to zlib decode the data. Make sure you copy/paste it as-is from thatsmybis.com without changing anything!";
        GL.Interface:getItem("TMB.Importer", "Label.StatusMessage"):SetText(errorMessage);
        return "";
    end

    return data;
end

--- Broadcast the TMB to the RAID / PARTY
---@return boolean
function TMB:broadcast()
    GL:debug("TMB:broadcast");

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

    -- Check if there's anything to share
    if (not self:available()) then
        GL:warning("Nothing to broadcast, import TMB data first!");
        return false;
    end

    self.broadcastInProgress = true;
    GL.Events:fire("GL.TMB_BROADCAST_STARTED");

    local Broadcast = function ()
        GL:message("Broadcasting TMB data...");

        local Label = GL.Interface:getItem(GL.TMB, "Label.BroadcastProgress");

        if (Label) then
            Label:SetText("Broadcasting...");
        end

        GL.CommMessage.new(
            CommActions.broadcastTMBData,
            GL.DB.TMB,
            "GROUP"
        ):send(function ()
            GL:success("TMB broadcast finished");
            self.broadcastInProgress = false;
            GL.Events:fire("GL.TMB_BROADCAST_ENDED");

            Label = GL.Interface:getItem(GL.TMB, "Label.BroadcastProgress");
            if (Label) then
                Label:SetText("Broadcast finished!");
            end

            -- Make sure to broadcast the loot priorities as well
            GL.LootPriority:broadcast();
        end, function (sent, total)
            Label = GL.Interface:getItem(GL.TMB, "Label.BroadcastProgress");
            if (Label) then
                Label:SetText(string.format("Sent %s of %s bytes", sent, total));
            end
        end);
    end

    -- We're about to send a lot of data which will put strain on CTL
    -- Make sure we're out of combat before doing so!
    if (UnitAffectingCombat("player")) then
        GL:message("You are currently in combat, delaying TMB broadcast");

        GL.Events:register("TMBOutOfCombatListener", "PLAYER_REGEN_ENABLED", function ()
            GL.Events:unregister("TMBOutOfCombatListener");
            Broadcast();
        end);
    else
        Broadcast();
    end

    return true;
end

--- Process an incoming TMB broadcast
---
---@param CommMessage CommMessage
function TMB:receiveBroadcast(CommMessage)
    GL:debug("TMB:receiveBroadcast");

    -- No need to update our tables if we broadcasted them ourselves
    if (CommMessage.Sender.id == GL.User.id) then
        GL:debug("TMB:receiveBroadcast received by self, skip");
        return true;
    end

    local Data = CommMessage.content;
    if (not GL:empty(Data)) then
        GL:warning("Attempting to process incoming TMB data from " .. CommMessage.Sender.name);

        if (type(Data) ~= "table" or GL:empty(Data)
            or type(Data.Items) ~= "table" or GL:empty(Data.Items)
            or GL:empty(GL:tableGet(Data, "MetaData.importedAt"))
        ) then
            GL:error("Invalid TMB data received from " .. CommMessage.Sender.name);
            return;
        end

        -- Validate dataset
        for itemId, Entries in pairs(Data.Items) do
            itemId = tonumber(itemId);

            if (GL:empty(itemId)) then
                GL:error("Invalid TMB data received from " .. CommMessage.Sender.name);
                return;
            end

            for _, Entry in pairs(Entries) do
                if (GL:empty(Entry.character)
                    or GL:empty(Entry.prio)
                    or GL:empty(Entry.type)
                ) then
                    GL:error("Invalid TMB data received from " .. CommMessage.Sender.name);
                    return;
                end
            end
        end

        GL:success("TMB data synced");
        GL.DB.TMB = Data;
    end
end

GL:debug("WishLists.lua");