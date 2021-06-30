local _, App = ...;

App.Ace.GUI = App.Ace.GUI or LibStub("AceGUI-3.0");
App.WishLists = {
    _initialized = false,
    broadcastInProgress = false,
};

local Utils = App.Utils;
local AceGUI = App.Ace.GUI;
local WishLists = App.WishLists;
local CommActions = App.Data.Constants.Comm.Actions;
local Constants = App.Data.Constants;

-- Add a award confirmation dialog to Blizzard's global StaticPopupDialogs object
StaticPopupDialogs[App.name .. "_CLEAR_WISHLISTS_CONFIRMATION"] = {
    text = "Are you sure you want to clear the wishlists?",
    button1 = "Yes",
    button2 = "No",
    OnAccept = {},
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3,
}

function WishLists:_init()
    Utils:debug("WishLists:_init");

    if (self._initialized) then
        return;
    end

    -- Bind the appendWishListInfoToTooltip method to the OnTooltipSetItem event
    GameTooltip:HookScript("OnTooltipSetItem", function(tooltip)
        self:appendWishListInfoToTooltip(tooltip);
    end);

    self._initialized = true;
end

-- Fetch an item's wish lists based on its ID
function WishLists:getWishListsByItemName(itemId)
    Utils:debug("WishLists:getWishListsByItemName");

    if (type(itemId) == "number") then
        itemId = tostring(itemId);
    end

    -- We couldn't find an item ID
    if (not itemId or itemId == "") then
        return;
    end

    return App.DB.WishLists[itemId];
end

-- Fetch an item's wish lists based on its item link
function WishLists:getWishListsByItemLink(itemLink)
    Utils:debug("WishLists:getWishListsByItemLink");

    if (not itemLink) then
        return;
    end

    return self:getWishListsByItemName(Utils:getItemNameFromLink(string.lower(itemLink)));
end

-- Fetch an item's wish lists based on its item link
function WishLists:itemIdIsReservedByPlayer(itemId, player)
    Utils:debug("WishLists:itemIdIsReservedByPlayer");

    local reserves = self:getWishListsByItemName(itemId);

    if (not reserves) then
        return false;
    end

    return Utils:inArray(reserves, player);
end

-- Append the wish lists as defined in App.DB.WishLists to an item's tooltip
function WishLists:appendWishListInfoToTooltip(tooltip)
    Utils:debug("WishLists:appendWishListInfoToTooltip");

    -- No tooltip was provided
    if (not tooltip) then
        return;
    end

    -- If we're not in a group there's no
    -- point in showing wishlists!
    if (not App.User.isInGroup) then
        return;
    end

    local itemName, itemLink = tooltip:GetItem();

    -- We couldn't find an itemName or link (this can actually happen!)
    if (not itemName or not itemLink) then
        return;
    end

    local Wishes = self:getWishListsByItemLink(itemLink);

    -- No wishes defined for this item
    if (not Wishes) then
        return;
    end

    local PlayersInRaid = {};
    -- Fetch the name/class of everyone currently in the raid/party
    for _, Player in pairs(App.User:groupMembers()) do
        PlayersInRaid[string.lower(Player.name)] = string.lower(Player.class);
    end

    -- Add the header
    tooltip:AddLine(string.format("\n|c00efb8cd%s", "Wish List"));

    local TooltipEntries = {};
    for playerName, prio in pairs(Wishes) do
        if (PlayersInRaid[playerName]) then
            tinsert(TooltipEntries, {prio, playerName});
        end
    end

    -- Sort the TooltipEntries based on prio (lowest to highest)
    table.sort(TooltipEntries, function (a, b)
        return a[1] < b[1];
    end);

    -- Add the entries to the tooltip
    for _, Entry in pairs(TooltipEntries) do
        local color = Utils:tableGet(Constants.ClassHexColors, PlayersInRaid[Entry[2]], "FFFFFF");

        tooltip:AddLine(string.format(
            "|cFF%s%s[%s]|r",
            color,
            Entry[2],
            Entry[1]
        ));
    end
end

function WishLists:drawImporter()
    Utils:debug("WishLists:drawImporter");

    -- Create a container/parent frame
    local WishListsFrame = AceGUI:Create("Frame");
    WishListsFrame:SetTitle(App.name .. " v" .. App.version);
    WishListsFrame:SetStatusText("Addon v" .. App.version);
    WishListsFrame:SetLayout("Flow");
    WishListsFrame:SetWidth(600);
    WishListsFrame:SetHeight(450);
    WishListsFrame.statustext:GetParent():Hide(); -- Hide the statustext bar

    -- Large edit box
    local wishListsBoxContent = "";
    local WishListsBox = AceGUI:Create("MultiLineEditBox");
    WishListsBox:SetFullWidth(true);
    WishListsBox:DisableButton(true);
    WishListsBox:SetFocus();
    WishListsBox:SetLabel("Paste the thatsmybis JSON here, then click the 'Import' button. Use 'Broadcast' to share with your group");
    WishListsBox:SetNumLines(22);
    WishListsBox:SetMaxLetters(999999999);
    WishListsFrame:AddChild(WishListsBox);

    WishListsBox:SetCallback("OnTextChanged", function(_, _, text)
        wishListsBoxContent = text;
    end)

    --[[
        FOOTER BUTTON PARENT FRAME
    ]]
    local FooterFrame = AceGUI:Create("SimpleGroup");
    FooterFrame:SetLayout("Flow");
    FooterFrame:SetFullWidth(true);
    FooterFrame:SetHeight(50);
    WishListsFrame:AddChild(FooterFrame);

    local ImportButton = AceGUI:Create("Button");
    ImportButton:SetText("Import");
    ImportButton:SetWidth(140);
    ImportButton:SetCallback("OnClick", function()
        self:import(wishListsBoxContent);
    end);
    FooterFrame:AddChild(ImportButton);

--     local BroadCastButton = AceGUI:Create("Button");
--     BroadCastButton:SetText("Broadcast");
--     BroadCastButton:SetWidth(140);
--     BroadCastButton:SetCallback("OnClick", function()
--         WishLists:broadcast();
--     end);
--     FooterFrame:AddChild(BroadCastButton);

    local ClearButton = AceGUI:Create("Button");
    ClearButton:SetText("Clear");
    ClearButton:SetWidth(140);
    ClearButton:SetCallback("OnClick", function()
        StaticPopupDialogs[App.name .. "_CLEAR_WISHLISTS_CONFIRMATION"].OnAccept = function ()
            WishListsBox:SetText("");
            App.DB.WishLists = {};
        end

        StaticPopup_Show(App.name .. "_CLEAR_WISHLISTS_CONFIRMATION");
    end);
    FooterFrame:AddChild(ClearButton);

--     WishLists:updateBroadCastButton(BroadCastButton);
end

function WishLists:import(data, sender)
    Utils:debug("WishLists:import");

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

    local WishListData = {};
    for _, WishListEntry in pairs(WebsiteData) do
        local itemName = Utils:tableGet(WishListEntry, "name", false);

        if (not itemName or type(itemName) ~= "string") then
            Utils:error("Invalid data provided");
            return false;
        end

        WishListData[itemName] = {};
        for _, characterString in pairs (Utils:tableGet(WishListEntry, "characters", {})) do
            local stringParts = Utils:strSplit(characterString, "|");
            local characterName = "";
            local order = .0;

            if (stringParts[1] and stringParts[3]) then
                characterName = stringParts[1];
                order = tonumber(stringParts[3]);
            end

            if (not characterName or not order) then
                Utils:error("Invalid data provided");
                return false;
            end

            WishListData[itemName][characterName] = order;
        end
    end

    App.DB.WishLists = WishListData;

    Utils:success("Import successful");
    return true;
end

-- Check if the broadcast button should be available
function WishLists:updateBroadCastButton(BroadCastButton)
    Utils:debug("WishLists:updateBroadCastButton");

    if (not App.User.isMasterLooter) then
        return BroadCastButton:SetDisabled(true);
    end

    return BroadCastButton:SetDisabled(false);
end

-- Broadcast our wish lists table to the raid or group
function WishLists:broadcast()
    Utils:debug("WishLists:broadcast");

    if (WishLists.broadcastInProgress) then
        Utils:error("Broadcast still in progress");
        return;
    end

    self.broadcastInProgress = true;

    if (App.User.isInRaid) then
        App.CommMessage.new(
            CommActions.broadcastWishLists,
            "App.DB.WishLists",
            "RAID"
        ):send();
    elseif (App.User.isInParty) then
        App.CommMessage.new(
            CommActions.broadcastWishLists,
            "App.DB.WishLists",
            "PARTY"
        ):send();
    end

    App.Ace:ScheduleTimer(function ()
        Utils:success("Broadcast finished");
        self.broadcastInProgress = false;
    end, 10);
end

-- Process an incoming wishlist broadcast
function WishLists:receiveWishLists(CommMessage)
    Utils:debug("WishLists:receiveWishLists");

    -- No need to update our tables if we broadcasted them ourselves
    if (CommMessage.Sender.name == App.User.name) then
        Utils:debug("Sync:receiveWishLists received by self, skip");
        return;
    end

    App.DB.WishLists = CommMessage.content;

    Utils:success("Your Wish Lists just got updated by " .. CommMessage.Sender.name);
end

Utils:debug("WishLists.lua");