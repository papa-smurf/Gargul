local _, App = ...;

App.Ace.GUI = App.Ace.GUI or LibStub("AceGUI-3.0");
App.SoftReserves = {};

local SoftReserves = App.SoftReserves;
local AceGUI = App.Ace.GUI;

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

    reserves = App:strConcat(reserves, ", ");

    -- Add the header
    tooltip:AddLine(string.format("\n|c00efb8cd%s", "Soft Reserves"));

    -- Add the actual soft reserves
    tooltip:AddLine(string.format("|c008aecff %s", reserves));
end

function SoftReserves:draw()
    App:debug("SoftReserves:draw");

    -- Create a container/parent frame
    local SoftReservesFrame = AceGUI:Create("Frame");
    SoftReservesFrame:SetCallback("OnClose", function(widget) AceGUI:Release(widget) end);
    SoftReservesFrame:SetTitle("Gargul v" .. App.version);
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
    SoftReservesBox:SetLabel([[Paste the softres.it CSV here, then click the 'Import' button. Use 'Broadcast' to share with your group]]);
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
        if (self:import(softReservesBoxContent)) then

        end
    end);
    FooterFrame:AddChild(BroadCastButton);

    local ClearButton = AceGUI:Create("Button");
    ClearButton:SetText("Clear");
    ClearButton:SetWidth(140);
    ClearButton:SetCallback("OnClick", function()
        SoftReservesBox:SetText("");
    end);
    FooterFrame:AddChild(ClearButton);
end

function SoftReserves:import(data, sender)
    App:debug("SoftReserves:import");

    -- Try to decode data, pcall makes sure this won't throw an error

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

App:debug("SoftReserves.lua");