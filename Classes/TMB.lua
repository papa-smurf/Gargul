---@type GL
local _, GL = ...;

GL.AceGUI = GL.AceGUI or LibStub("AceGUI-3.0");

---@class TMB
GL.TMB = {
    _initialized = false,
    broadcastInProgress = false,
};
local TMB = GL.TMB; ---@type TMB

local AceGUI = GL.AceGUI;
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
    end

    -- The item linked to this id can have multiple IDs (head of Onyxia for example)
    local AllLinkedItemIds = self:getLinkedItemsForId(itemId);

    local GroupMemberNames = {};
    if (inRaidOnly) then
        GroupMemberNames = GL.User:groupMemberNames();
    end

    local Processed = {};
    local Wishes = {};
    for _, id in pairs(AllLinkedItemIds) do
        id = tostring(id);
        for _, Entry in pairs(GL:tableGet(GL.DB.TMB, tostring(id), {})) do
            local playerName = string.lower(Entry.character);

            -- If inRaidOnly is true we need to make sure we only return details of people who are actually in the raid
            if (not inRaidOnly or GL:inTable(GroupMemberNames, string.gsub(playerName, "%(OS%)", ""))) then
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

--- Some items have items linked to them. Example: t4 tokens have their quest reward counterpart linked to them.
---
---@param itemId number
---@return table
function TMB:getLinkedItemsForId(itemId)
    -- An invalid item id was provided
    itemId = tonumber(itemId);
    if (not GL:higherThanZero(itemId)) then
        return {};
    end

    -- Gather all the item IDs that are linked to our item
    itemId = tostring(itemId);
    local AllLinkedItemIds = {itemId};
    for _, id in pairs(GL.Data.Constants.LinkedItems[itemId] or {}) do
        tinsert(AllLinkedItemIds, id);
    end

    return AllLinkedItemIds;
end

--- Append the TMB info as defined in GL.DB.TMB to an item's tooltip
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
    if (not GL.User.isInGroup
        and GL.Settings:get("TMB.hideInfoOfPeopleNotInGroup")
    ) then
        return;
    end

    -- Make sure the user actually wants to see any tooltip data
    if (not GL.Settings:get("TMB.showWishListInfoOnTooltips")
        and not GL.Settings:get("TMB.showPrioListInfoOnTooltips")
    ) then
        return;
    end

    local _, itemLink = tooltip:GetItem();

    -- We couldn't find an itemLink (this can actually happen!)
    if (GL:empty(itemLink)) then
        return;
    end

    local TMBInfo = self:byItemLink(itemLink);

    -- No wishes defined for this item
    if (GL:empty(TMBInfo)) then
        return;
    end

    local GroupMemberClasses = {};
    -- Fetch the name/class of everyone currently in the raid/party
    for _, Player in pairs(GL.User:groupMembers()) do
        GroupMemberClasses[string.lower(Player.name)] = string.lower(Player.class);
    end

    local WishListEntries = {};
    local PrioListEntries = {};
    local itemIsOnSomeonesWishlist = false;
    local itemIsOnSomeonesPriolist = false;
    local entriesAdded = 0;
    for _, Entry in pairs(TMBInfo) do
        local playerName = string.lower(Entry.character)
        local prio = Entry.prio;
        local entryType = Entry.type or Constants.tmbTypeWish;
        local isOffSpec = string.find(Entry.character, "(OS)");
        local prioOffset = 0;
        local sortingOrder = prio;
        local color = GL:classHexColor(GroupMemberClasses[playerName]);

        -- Make sure we don't add more names to the tooltip than the user allowed
        if (entriesAdded >= GL.Settings:get("TMB.maximumNumberOfTooltipEntries")) then
            break;
        end

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
            entriesAdded = entriesAdded + 1;
        else
            tinsert(WishListEntries, {sortingOrder, string.format("|cFF%s    %s[%s]|r", color, playerName, prio)});
            itemIsOnSomeonesWishlist = true;
            entriesAdded = entriesAdded + 1;
        end
    end

    -- Only add the 'Prio List' header if the item is actually on someone's character prio list
    if (itemIsOnSomeonesPriolist and GL.Settings:get("TMB.showPrioListInfoOnTooltips")) then
        -- Add the header
        tooltip:AddLine(string.format("\n|cFFff7a0a%s|r", "TMB Prio List"));

        -- Sort the PrioListEntries based on prio (lowest to highest)
        table.sort(PrioListEntries, function (a, b)
            return a[1] < b[1];
        end);

        -- Add the entries to the tooltip
        for _, Entry in pairs(PrioListEntries) do
            tooltip:AddLine(string.format(
                "|cFF%s%s|r",
                GL:classHexColor(GroupMemberClasses[Entry[2]]),
                GL:capitalize(Entry[2])
            ));
        end
    end

    -- The item is on someone's prio list and the user is not interested in wishlist entries
    if (GL.Settings:get("TMB.hideWishListInfoIfPriorityIsPresent") and itemIsOnSomeonesPriolist) then
        return;
    end

    -- Only add the 'Wish List' header if the item is actually on someone's wishlist
    if (itemIsOnSomeonesWishlist and GL.Settings:get("TMB.showWishListInfoOnTooltips")) then
        -- Add the header
        tooltip:AddLine(string.format("\n|cFFffffff%s|r", "TMB Wish List"));

        -- Sort the WishListEntries based on prio (lowest to highest)
        table.sort(WishListEntries, function (a, b)
            return a[1] < b[1];
        end);

        -- Add the entries to the tooltip
        for _, Entry in pairs(WishListEntries) do
            tooltip:AddLine(string.format(
                "|cFF%s%s|r",
                GL:classHexColor(GroupMemberClasses[Entry[2]]),
                GL:capitalize(Entry[2])
            ));
        end
    end
end

--- Draw the TMB importer interface
---@todo Refactor to Interface
---@todo Fix broadcast functionality (payload needs to be smaller)
---
---@return void
function TMB:drawImporter()
    GL:debug("TMB:drawImporter");

    -- Create a container/parent frame
    local TMBFrame = AceGUI:Create("Frame");
    TMBFrame:SetTitle(GL.name .. " v" .. GL.version);
    TMBFrame:SetStatusText("Addon v" .. GL.version);
    TMBFrame:SetLayout("Flow");
    TMBFrame:SetWidth(600);
    TMBFrame:SetHeight(450);
    TMBFrame.statustext:GetParent():Hide(); -- Hide the statustext bar

    -- Large edit box
    local TMBBoxContent = "";
    local TMBBox = AceGUI:Create("MultiLineEditBox");
    TMBBox:SetFullWidth(true);
    TMBBox:DisableButton(true);
    TMBBox:SetFocus();
    TMBBox:SetLabel("Paste the thatsmybis JSON here, then click the 'Import' button. Use 'Broadcast' to share with your group");
    TMBBox:SetNumLines(22);
    TMBBox:SetMaxLetters(999999999);
    TMBFrame:AddChild(TMBBox);

    TMBBox:SetCallback("OnTextChanged", function(_, _, text)
        TMBBoxContent = text;
    end)

    --[[
        FOOTER BUTTON PARENT FRAME
    ]]
    local FooterFrame = AceGUI:Create("SimpleGroup");
    FooterFrame:SetLayout("Flow");
    FooterFrame:SetFullWidth(true);
    FooterFrame:SetHeight(50);
    TMBFrame:AddChild(FooterFrame);

    local ImportButton = AceGUI:Create("Button");
    ImportButton:SetText("Import");
    ImportButton:SetWidth(140);
    ImportButton:SetCallback("OnClick", function()
        self:import(TMBBoxContent);
    end);
    FooterFrame:AddChild(ImportButton);

--     local BroadCastButton = AceGUI:Create("Button");
--     BroadCastButton:SetText("Broadcast");
--     BroadCastButton:SetWidth(140);
--     BroadCastButton:SetCallback("OnClick", function()
--         TMB:broadcast();
--     end);
--     FooterFrame:AddChild(BroadCastButton);

    local ClearButton = AceGUI:Create("Button");
    ClearButton:SetText("Clear");
    ClearButton:SetWidth(140);
    ClearButton:SetCallback("OnClick", function()
        StaticPopupDialogs[GL.name .. "_CLEAR_TMB_CONFIRMATION"].OnAccept = function ()
            TMBBox:SetText("");
            GL.DB.TMB = {};
        end

        StaticPopup_Show(GL.name .. "_CLEAR_TMB_CONFIRMATION");
    end);
    FooterFrame:AddChild(ClearButton);

--     TMB:updateBroadCastButton(BroadCastButton);
end

--- Import a given tmb string
---
---@param data string
---@return boolean
function TMB:import(data)
    GL:debug("TMB:import");

    -- Make sure all the required properties are available and of the correct type
    if (not data or type(data) ~= "string") then
        GL:error("Invalid data provided");
        return false;
    end

    local jsonDecodeSucceeded, WebsiteData = pcall(function () return GL.JSON:decode(data); end);

    -- Make sure the given string could actually be decoded
    if (not jsonDecodeSucceeded
        or not WebsiteData
        or type(WebsiteData) ~= "table"
    ) then
        GL:warning("Invalid TMB data provided");
        return false;
    end

    -- Import the actual TMB data
    local insufficientPermissions = false;
    if (WebsiteData.wishlists and type(WebsiteData.wishlists) == "table") then
        local processedEntryCheckums = {};
        local TMBData = {};
        for itemId, WishListEntries in pairs(WebsiteData.wishlists) do
            TMBData[itemId] = {};
            for _, characterString in pairs(WishListEntries) do
                local stringParts = GL:strSplit(characterString, "|");
                local characterName = "";
                local order = "?";
                local type = Constants.tmbTypeWish;

                if (stringParts[1] and stringParts[3]) then
                    characterName = stringParts[1];
                    order = tonumber(stringParts[3]) or order;
                end

                if (stringParts[5]) then
                    local providedType = tonumber(stringParts[5]);

                    if (providedType == Constants.tmbTypePrio) then
                        type = Constants.tmbTypePrio;
                    end
                end

                if (characterName and order) then
                    local checkSum = string.format('%s||%s||%s||%s', itemId, characterName, order, type);

                    if (not processedEntryCheckums[checkSum]) then
                        tinsert(TMBData[itemId], {
                            ["character"] = characterName,
                            ["prio"] = order,
                            ["type"] = type
                        });

                        processedEntryCheckums[checkSum] = true;
                    end
                end

                if (not order) then
                    insufficientPermissions = true;
                end
            end
        end

        GL.DB.TMB = TMBData;
    end

    -- There is also loot priority data available, pass it to on!
    if (WebsiteData.loot and type(WebsiteData.loot) == "string") then
        GL.LootPriority:save(WebsiteData.loot);
    end

    if (insufficientPermissions) then
        GL:success("TMB Import successful with notice:");
        GL:warning("It seems like you don't have sufficient permissions on TMB to view all priority data. Do you have the correct role in TMB?");
    else
        GL:success("TMB Import successful");
    end

    return true;
end

--- Check if the broadcast button should be available
---
---@param BroadCastButton table
---@return void
function TMB:updateBroadCastButton(BroadCastButton)
    GL:debug("TMB:updateBroadCastButton");

    if (not GL.User.isMasterLooter) then
        return BroadCastButton:SetDisabled(true);
    end

    return BroadCastButton:SetDisabled(false);
end

--- Broadcast our TMB info table to the raid or group
---@todo this doesn't work at the moment
---
---@return void
function TMB:broadcast()
    GL:debug("TMB:broadcast");

    if (WishLists.broadcastInProgress) then
        GL:error("Broadcast still in progress");
        return;
    end

    self.broadcastInProgress = true;

    if (GL.User.isInRaid) then
        GL.CommMessage.new(
            CommActions.broadcastTMBData,
            "GL.DB.TMB",
            "RAID"
        ):send();
    elseif (GL.User.isInParty) then
        GL.CommMessage.new(
            CommActions.broadcastTMBData,
            "GL.DB.TMB",
            "PARTY"
        ):send();
    end

    GL.Ace:ScheduleTimer(function ()
        GL:success("Wishlist Broadcast finished");
        self.broadcastInProgress = false;
    end, 10);
end

--- Process an incoming wishlist broadcast
function TMB:receiveWishLists(CommMessage)
    GL:debug("TMB:receiveWishLists");

    -- No need to update our tables if we broadcasted them ourselves
    if (CommMessage.Sender.name == GL.User.name) then
        GL:debug("Sync:receiveWishLists received by self, skip");
        return;
    end

    GL.DB.TMB = CommMessage.content;

    GL:success("Your Wishlists just got updated by " .. CommMessage.Sender.name);
end

GL:debug("WishLists.lua");