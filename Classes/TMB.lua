local _, App = ...;

App.Ace.GUI = App.Ace.GUI or LibStub("AceGUI-3.0");
App.TMB = {
    _initialized = false,
    broadcastInProgress = false,
};

local Utils = App.Utils;
local AceGUI = App.Ace.GUI;
local TMB = App.TMB;
local CommActions = App.Data.Constants.Comm.Actions;
local Constants = App.Data.Constants;

-- Add a award confirmation dialog to Blizzard's global StaticPopupDialogs object
StaticPopupDialogs[App.name .. "_CLEAR_TMB_CONFIRMATION"] = {
    text = "Are you sure you want to clear the TMB tables?",
    button1 = "Yes",
    button2 = "No",
    OnAccept = {},
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3,
}

function TMB:_init()
    Utils:debug("TMB:_init");

    if (self._initialized) then
        return;
    end

    -- Bind the appendTMBItemInfoToTooltip method to the OnTooltipSetItem event
    GameTooltip:HookScript("OnTooltipSetItem", function(tooltip)
        self:appendTMBItemInfoToTooltip(tooltip);
    end);

    self._initialized = true;
end

-- Fetch an item's TMB info based on its ID
function TMB:getTMBInfoByItemId(itemId)
    Utils:debug("TMB:getTMBInfoByItemId");

    if (type(itemId) ~= "string") then
        itemId = tostring(itemId);
    end

    -- We couldn't find an item ID
    if (not itemId or itemId == "") then
        return;
    end

    if (not App.Data.Constants.LinkedItems[itemId]) then
        return App.DB.TMB[itemId];
    end

    -- The item linked to this id can have multiple IDs (head of Onyxia for example)
    local Wishes = Utils:tableGet(App.DB.TMB, tostring(itemId), {});
    for _, linkedItemId in pairs(App.Data.Constants.LinkedItems[itemId]) do
        Wishes = Utils:tableMerge(Wishes, Utils:tableGet(App.DB.TMB, tostring(linkedItemId), {}));
    end

    return Wishes;
end

-- Fetch an item's TMB info based on its item link
function TMB:getTMBInfoByItemLink(itemLink)
    Utils:debug("TMB:getTMBInfoByItemLink");

    if (not itemLink) then
        return;
    end

    return self:getTMBInfoByItemId(Utils:getItemIdFromLink(string.lower(itemLink)));
end

-- Fetch an item's TMB info based on its item link
function TMB:itemIdIsReservedByPlayer(itemId, player)
    Utils:debug("TMB:itemIdIsReservedByPlayer");

    local reserves = self:getTMBInfoByItemId(itemId);

    if (not reserves) then
        return false;
    end

    return Utils:inArray(reserves, player);
end

-- Append the TMB info as defined in App.DB.TMB to an item's tooltip
function TMB:appendTMBItemInfoToTooltip(tooltip)
    Utils:debug("TMB:appendTMBItemInfoToTooltip");

    -- No tooltip was provided
    if (not tooltip) then
        return;
    end

    -- If we're not in a group there's no point in showing anything! (unless the non-raider setting is active)
    if (not App.User.isInGroup
        and App.Settings:get("TMB.hideInfoOfPeopleNotInraid")
    ) then
        return;
    end

    -- Make sure the user actually wants to see any tooltip data
    if (not App.Settings:get("TMB.showWishListInfoOnTooltips")
        and not App.Settings:get("TMB.showPrioListInfoOnTooltips")
    ) then
        return;
    end

    local _, itemLink = tooltip:GetItem();

    -- We couldn't find an itemLink (this can actually happen!)
    if (not itemLink) then
        return;
    end

    local TMBInfo = self:getTMBInfoByItemLink(itemLink);

    -- No wishes defined for this item
    if (not TMBInfo) then
        return;
    end

    local PlayersInRaid = {};
    -- Fetch the name/class of everyone currently in the raid/party
    for _, Player in pairs(App.User:groupMembers()) do
        PlayersInRaid[string.lower(Player.name)] = string.lower(Player.class);
    end

    local WishListEntries = {};
    local PrioListEntries = {};
    local itemIsOnSomeonesWishlist = false;
    local itemIsOnSomeonesPriolist = false;
    for _, Entry in pairs(TMBInfo) do
        local playerName = Entry.character;

        if (not App.Settings:get("TMB.hideInfoOfPeopleNotInraid")
            or PlayersInRaid[string.gsub(playerName, "(OS)", "")]
        ) then
            local prio = Entry.prio;
            local entryType = Entry.type or Constants.tmbTypeWish;
            local Target = WishListEntries;
            local isOffSpec = string.find(playerName, "(OS)");
            local prioOffset = 0;
            local sortingOrder = prio;

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

            if (entryType == Constants.tmbTypePrio) then
                tinsert(PrioListEntries, {sortingOrder, string.format("%s[%s]", playerName, prio)});
                itemIsOnSomeonesPriolist = true;
            else
                tinsert(WishListEntries, {sortingOrder, string.format("%s[%s]", playerName, prio)});
                itemIsOnSomeonesWishlist = true;
            end
        end
    end

    if (not itemIsOnSomeonesWishlist and not itemIsOnSomeonesPriolist) then
        return;
    end

    -- Only add the 'Prio List' header if the item is actually on someone's wishlist
    if (itemIsOnSomeonesPriolist and App.Settings:get("TMB.showPrioListInfoOnTooltips")) then
        -- Add the header
        tooltip:AddLine(string.format("\n|c00efb8cd%s", "TMB Prio List"));

        -- Sort the PrioListEntries based on prio (lowest to highest)
        table.sort(PrioListEntries, function (a, b)
            return a[1] < b[1];
        end);

        -- Add the entries to the tooltip
        for _, Entry in pairs(PrioListEntries) do
            local color = Utils:tableGet(Constants.ClassHexColors, PlayersInRaid[Entry[2]], "FFFFFF");

            tooltip:AddLine(string.format(
                "|cFF%s%s|r",
                color,
                Utils:capitalize(Entry[2])
            ));
        end
    end

    -- The item is on someone's prio list and the user is not interested in wishlist entries
    if (App.Settings:get("TMB.hideWishListInfoIfPriorityIsPresent") and itemIsOnSomeonesPriolist) then
        return;
    end

    -- Only add the 'Wish List' header if the item is actually on someone's wishlist
    if (itemIsOnSomeonesWishlist and App.Settings:get("TMB.showWishListInfoOnTooltips")) then
        -- Add the header
        tooltip:AddLine(string.format("\n|c00efb8cd%s", "TMB Wish List"));

        -- Sort the WishListEntries based on prio (lowest to highest)
        table.sort(WishListEntries, function (a, b)
            return a[1] < b[1];
        end);

        -- Add the entries to the tooltip
        for _, Entry in pairs(WishListEntries) do
            local color = Utils:tableGet(Constants.ClassHexColors, PlayersInRaid[Entry[2]], "FFFFFF");

            tooltip:AddLine(string.format(
                "|cFF%s%s|r",
                color,
                Utils:capitalize(Entry[2])
            ));
        end
    end
end

function TMB:drawImporter()
    Utils:debug("TMB:drawImporter");

    -- Create a container/parent frame
    local TMBFrame = AceGUI:Create("Frame");
    TMBFrame:SetTitle(App.name .. " v" .. App.version);
    TMBFrame:SetStatusText("Addon v" .. App.version);
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
        StaticPopupDialogs[App.name .. "_CLEAR_TMB_CONFIRMATION"].OnAccept = function ()
            TMBBox:SetText("");
            App.DB.TMB = {};
        end

        StaticPopup_Show(App.name .. "_CLEAR_TMB_CONFIRMATION");
    end);
    FooterFrame:AddChild(ClearButton);

--     TMB:updateBroadCastButton(BroadCastButton);
end

function TMB:import(data, sender)
    Utils:debug("TMB:import");

    -- Make sure all the required properties are available and of the correct type
    if (not data or type(data) ~= "string") then
        Utils:error("Invalid data provided");
        return false;
    end

    local WebsiteData = App.JSON:decode(data);

    -- Make sure the given string could actually be decoded
    if (not WebsiteData or type(WebsiteData) ~= "table") then
        Utils:error("Invalid data provided");
        return false;
    end

    -- Import the actual TMB data
    local insufficientPermissions = false;
    if (WebsiteData.wishlists and type(WebsiteData.wishlists) == "table") then
        local processedEntryCheckums = {};
        local TMBData = {};
        for itemId, WishListEntries in pairs(WebsiteData.wishlists) do
            TMBData[itemId] = {};
            for _, characterString in pairs (WishListEntries) do
                local stringParts = Utils:strSplit(characterString, "|");
                local characterName = "";
                local order = .0;
                local type = Constants.tmbTypeWish;

                if (stringParts[1] and stringParts[3]) then
                    characterName = stringParts[1];
                    order = tonumber(stringParts[3]);
                end

                if (stringParts[5]) then
                    local providedType = tonumber(stringParts[5]);

                    if (providedType == Constants.tmbTypePrio) then
                        type = Constants.tmbTypePrio;
                    end
                end

                if (characterName and order) then
                    local checkSum = string.format('%s|%s|%s|%s', itemId, characterName, order, type);

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

        App.DB.TMB = TMBData;
    end

    -- There is also loot priority data available, pass it to on!
    if (WebsiteData.loot and type(WebsiteData.loot) == "string") then
        App.LootPriority:save(WebsiteData.loot);
    end

    if (insufficientPermissions) then
        Utils:success("TMB Import successful with notice:");
        Utils:warning("It seems like you don't have sufficient permissions on TMB to view all priority data. Do you have the correct role in TMB?");
    else
        Utils:success("TMB Import successful");
    end

    return true;
end

-- Check if the broadcast button should be available
function TMB:updateBroadCastButton(BroadCastButton)
    Utils:debug("TMB:updateBroadCastButton");

    if (not App.User.isMasterLooter) then
        return BroadCastButton:SetDisabled(true);
    end

    return BroadCastButton:SetDisabled(false);
end

-- Broadcast our TMB info table to the raid or group
function TMB:broadcast()
    Utils:debug("TMB:broadcast");

    if (WishLists.broadcastInProgress) then
        Utils:error("Broadcast still in progress");
        return;
    end

    self.broadcastInProgress = true;

    if (App.User.isInRaid) then
        App.CommMessage.new(
            CommActions.broadcastTMBData,
            "App.DB.TMB",
            "RAID"
        ):send();
    elseif (App.User.isInParty) then
        App.CommMessage.new(
            CommActions.broadcastTMBData,
            "App.DB.TMB",
            "PARTY"
        ):send();
    end

    App.Ace:ScheduleTimer(function ()
        Utils:success("Wishlist Broadcast finished");
        self.broadcastInProgress = false;
    end, 10);
end

-- Process an incoming wishlist broadcast
function TMB:receiveWishLists(CommMessage)
    Utils:debug("TMB:receiveWishLists");

    -- No need to update our tables if we broadcasted them ourselves
    if (CommMessage.Sender.name == App.User.name) then
        Utils:debug("Sync:receiveWishLists received by self, skip");
        return;
    end

    App.DB.TMB = CommMessage.content;

    Utils:success("Your Wishlists just got updated by " .. CommMessage.Sender.name);
end

Utils:debug("WishLists.lua");