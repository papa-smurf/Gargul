local _, App = ...;

App.Ace.GUI = App.Ace.GUI or LibStub("AceGUI-3.0");
App.SoftReserves = {
    broadcastInProgress = false,
};

local SoftReserves = App.SoftReserves;
local AceGUI = App.Ace.GUI;
local CommActions = App.Data.Constants.Comm.Actions;

-- Add a award confirmation dialog to Blizzard's global StaticPopupDialogs object
StaticPopupDialogs["CLEAR_SOFTRESERVES_CONFIRMATION"] = {
    text = "Are you sure you want to clear everything?",
    button1 = "Yes",
    button2 = "No",
    OnAccept = {},
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3,
}

function SoftReserves:_init()
    if (self._initialized) then
        return;
    end

    -- Bind the appendSoftReserveInfoToTooltip method to the OnTooltipSetItem event
    GameTooltip:HookScript("OnTooltipSetItem", function(tooltip)
        self:appendSoftReserveInfoToTooltip(tooltip);
    end);

    self._initialized = true;
end

-- Fetch an item's soft reserves based on its ID
function SoftReserves:getSoftReservesByItemId(itemId)
    -- We couldn't find an item ID
    if (not itemId) then
        return;
    end

    return App.DB.SoftReserves[itemId];
end

-- Fetch an item's soft reserves based on its item link
function SoftReserves:getSoftReservesByItemLink(itemLink)
    if (not itemLink) then
        return;
    end

    return self:getSoftReservesByItemId(App:getItemIdFromLink(itemLink));
end

-- Fetch an item's soft reserves based on its item link
function SoftReserves:itemIdIsReservedByPlayer(itemId, player)
    local reserves = self:getSoftReservesByItemId(itemId);

    if (not reserves) then
        return false;
    end

    return App:inArray(reserves, player);
end

-- Append the soft reserves as defined in App.DB.SoftReserves to an item's tooltip
function SoftReserves:appendSoftReserveInfoToTooltip(tooltip)
    -- No tooltip was provided
    if (not tooltip) then
        return;
    end

    -- If we're not in a group there's no
    -- point in showing softreserves!
    if (not App.User.isInGroup) then
        return;
    end

    local itemName, itemLink = tooltip:GetItem();

    -- We couldn't find an itemName or link (this can actually happen!)
    if (not itemName or not itemLink) then
        return;
    end

    local reserves = self:getSoftReservesByItemLink(itemLink);

    -- No reserves defined for this item
    if (not reserves) then
        return;
    end

    local activeReserves = {};
    local playersInRaids = {};
    -- Fetch the name of everyone currently in the raid/party
    for _, player in pairs(App.User:groupMembers()) do
        tinsert(playersInRaids, player.name);
    end

    -- Make sure we only show shoft reserves of people
    -- Who are actually in the raid
    for _, player in pairs(reserves) do
        if (App:inArray(playersInRaids, player)) then
            tinsert(activeReserves, player);
        end
    end

    reserves = table.concat(activeReserves, ", ");

    -- Add the header
    tooltip:AddLine(string.format("\n|c00efb8cd%s", "Soft Reserves"));

    -- Add the actual soft reserves
    tooltip:AddLine(string.format("|c008aecff %s", reserves));
end

function SoftReserves:drawImporter()
    App:debug("SoftReserves:drawImporter");

    -- Create a container/parent frame
    local SoftReservesFrame = AceGUI:Create("Frame");
    SoftReservesFrame:SetTitle(App.name .. " v" .. App.version);
    SoftReservesFrame:SetStatusText("Addon v" .. App.version);
    SoftReservesFrame:SetLayout("Flow");
    SoftReservesFrame:SetWidth(600);
    SoftReservesFrame:SetHeight(450);
    SoftReservesFrame.statustext:GetParent():Hide(); -- Hide the statustext bar

    -- Large edit box
    local softReservesBoxContent = "";
    local SoftReservesBox = AceGUI:Create("MultiLineEditBox");
    SoftReservesBox:SetFullWidth(true);
    SoftReservesBox:DisableButton(true);
    SoftReservesBox:SetFocus();
    SoftReservesBox:SetLabel("Paste the softres.it CSV here, then click the 'Import' button. Use 'Broadcast' to share with your group");
    SoftReservesBox:SetNumLines(22);
    SoftReservesBox:SetMaxLetters(999999999);
    SoftReservesFrame:AddChild(SoftReservesBox);

    SoftReservesBox:SetCallback("OnTextChanged", function(_, _, text)
        softReservesBoxContent = text;
    end)

    --[[
        FOOTER BUTTON PARENT FRAME
    ]]
    local FooterFrame = AceGUI:Create("SimpleGroup");
    FooterFrame:SetLayout("Flow");
    FooterFrame:SetFullWidth(true);
    FooterFrame:SetHeight(50);
    SoftReservesFrame:AddChild(FooterFrame);

    local ImportButton = AceGUI:Create("Button");
    ImportButton:SetText("Import");
    ImportButton:SetWidth(140);
    ImportButton:SetCallback("OnClick", function()
        self:import(softReservesBoxContent);
    end);
    FooterFrame:AddChild(ImportButton);

    local BroadCastButton = AceGUI:Create("Button");
    BroadCastButton:SetText("Broadcast");
    BroadCastButton:SetWidth(140);
    BroadCastButton:SetCallback("OnClick", function()
        SoftReserves:broadcast();
    end);
    FooterFrame:AddChild(BroadCastButton);

    local ClearButton = AceGUI:Create("Button");
    ClearButton:SetText("Clear");
    ClearButton:SetWidth(140);
    ClearButton:SetCallback("OnClick", function()
        StaticPopupDialogs["CLEAR_SOFTRESERVES_CONFIRMATION"].OnAccept = function ()
            SoftReservesBox:SetText("");
        end

        StaticPopup_Show("CLEAR_SOFTRESERVES_CONFIRMATION");
    end);
    FooterFrame:AddChild(ClearButton);

    SoftReserves:updateBroadCastButton(BroadCastButton);
end

function SoftReserves:import(data, sender)
    App:debug("SoftReserves:import");

    -- Make sure all the required properties are available and of the correct type
    if (not data or type(data) ~= "string") then
        App:warning("Invalid data provided");
        return false;
    end

    local first = true;
    local SoftReserveData = {};
    for line in data:gmatch("[^\n]+") do
        if (not first) then

            local segments = App:strSplit(line, ",");
            if (#segments == 5) then

                local itemId = tonumber(segments[1]);
                local player = segments[2];

                if (itemId > 0
                    and player
                    and type(player) == "string"
                ) then
                    itemId = tostring(itemId);
                    local entry = App:tableGet(SoftReserveData, itemId, {});

                    tinsert(entry, player);
                    SoftReserveData[itemId] = entry;
                end
            end
        else
            first = false;
        end
    end

    App.DB.SoftReserves = SoftReserveData;

    App:success("Import successful");
    return true;
end

-- Check if the broadcast button should be available
function SoftReserves:updateBroadCastButton(BroadCastButton)
    if (not App.User.isMasterLooter) then
        return BroadCastButton:SetDisabled(true);
    end

    return BroadCastButton:SetDisabled(false);
end

-- Broadcast our soft reserves table to the raid or group
function SoftReserves:broadcast()
    App:debug("SoftReserves:broadcast");

    if (SoftReserves.broadcastInProgress) then
        App:error("Broadcast still in progress");
        return;
    end

    self.broadcastInProgress = true;

    if (App.User.isInRaid) then
        App.CommMessage.new(
            CommActions.broadcastSoftReserves,
            App.DB.SoftReserves,
            "RAID"
        ):send();
    elseif (App.User.isInParty) then
        App.CommMessage.new(
            CommActions.broadcastSoftReserves,
            App.DB.SoftReserves,
            "PARTY"
        ):send();
    end

    App.Ace:ScheduleTimer(function ()
        App:success("Broadcast finished");
        self.broadcastInProgress = false;
    end, 10);
end

-- Process an incoming soft reserve broadcast
function SoftReserves:receiveSoftReserves(CommMessage)
    App:debug("SoftReserves:receiveSoftReserves");

    -- No need to update our tables if we broadcasted them ourselves
    if (CommMessage.Sender.name == App.User.name) then
        App:debug("Sync:receiveSoftReserves received by self, skip");
        return;
    end

    App.DB.SoftReserves = CommMessage.content;

    App:success("Your Soft Reserves just got updated by " .. CommMessage.Sender.name);
end

App:debug("SoftReserves.lua");