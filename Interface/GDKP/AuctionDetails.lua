---@type GL
local _, GL = ...;

GL.AceGUI = GL.AceGUI or LibStub("AceGUI-3.0");
local AceGUI = GL.AceGUI;

---@type Interface
local Interface = GL.Interface;

---@type Data
local Constants = GL.Data.Constants;

---@class AuctionDetails
GL.Interface.GDKP.AuctionDetails = {
    auctionID = nil,
    sessionID = nil,
};

---@type AuctionDetails
local AuctionDetails = GL.Interface.GDKP.AuctionDetails;

---@param sessionID string
---@param auctionID string
---@return void
function AuctionDetails:toggle(sessionID, auctionID)
    GL:debug("GDKP.AuctionDetails:toggle");

    if (self.sessionID == sessionID
        and self.auctionID == auctionID
    ) then
        return self:close();
    end

    self:draw(sessionID, auctionID);
end

---@param sessionID string
---@param auctionID string
---@return void
function AuctionDetails:draw(sessionID, auctionID)
    GL:debug("GDKP.AuctionDetails:draw");

    local Spacer;

    ---@type GDKPOverview
    local Overview = GL.Interface.GDKP.Overview;

    -- It seems our GDKP overview window is not opened
    if (not Overview.isVisible) then
        return;
    end

    -- Release any existing edit auction window
    Overview:closeSubWindows();

    sessionID = tostring(sessionID);
    auctionID = tostring(auctionID);
    local Auction = GL.DB:get(string.format("GDKP.Ledger.%s.Auctions.%s", sessionID, auctionID));

    -- The given auction does not exist
    if (not Auction) then
        return;
    end

    self.sessionID = sessionID;
    self.auctionID = auctionID;

    local GDKPOverviewFrame = Interface:get(Overview, "GDKPOverview").frame;

    -- This entry should always exist, if it doesn't something went wrong (badly)
    local ItemEntry = GL.DB.Cache.ItemsByID[tostring(Auction.itemID)];

    if (GL:empty(ItemEntry)) then
        return;
    end

    -- Create a container/parent frame
    local Window = AceGUI:Create("InlineGroup");
    Window:SetLayout("Flow");
    Window:SetWidth(260);
    Window:SetHeight(300);
    Window:SetPoint("TOPLEFT", GDKPOverviewFrame, "TOPRIGHT", 2, 16);
    Window:SetPoint("BOTTOMLEFT", GDKPOverviewFrame, "BOTTOMLEFT", 2);
    Interface:set(self, "Window", Window);
    Window.frame:SetFrameStrata("HIGH");
    Window.frame:Show();

    local ScrollFrameHolder = GL.AceGUI:Create("SimpleGroup");
    ScrollFrameHolder:SetLayout("FILL")
    ScrollFrameHolder:SetFullWidth(true);
    ScrollFrameHolder:SetFullHeight(true);
    Window:AddChild(ScrollFrameHolder);

    local ScrollFrame = GL.AceGUI:Create("ScrollFrame");
    ScrollFrame:SetLayout("Flow");
    ScrollFrameHolder:AddChild(ScrollFrame);

    local auctionWasDeleted = not Auction.price;
    local concernsManualAdjustment = Auction.itemID == Constants.GDKP.potIncreaseItemID;
    local itemLabel;

    if (not auctionWasDeleted) then
        if (concernsManualAdjustment) then
            itemLabel = string.format("|cFF%s%sg|r added to pot by |c00%s%s|r\nNote: %s",
                Constants.ClassHexColors.rogue,
                Auction.price or "0",
                GL:classHexColor(GL.Player:classByName(Auction.Winner.name, 0), GL.Data.Constants.disabledTextColor),
                Auction.Winner.name,
                Auction.note or ""
            );
        else
            itemLabel = string.format(
    "|cFF%s%s|r paid |cFF%s%sg|r for\n%s",
                GL:classHexColor(Auction.Winner.class),
                Auction.Winner.name or "",
                Constants.ClassHexColors.rogue,
                Auction.price or "0",
                ItemEntry.link
            );
        end

        -- Item was deleted
    else
        local reason = Auction.reason;

        if (GL:empty(reason)) then
            reason = "-";
        end

        itemLabel = string.format(
            "|cFFbe3333Deleted by|r |cFF%s%s|r\nReason: %s",
            GL:classHexColor(Auction.CreatedBy.class),
            Auction.CreatedBy.name,
            reason
        );
    end

    local ItemLink = AceGUI:Create("Label");
    ItemLink:SetFontObject(_G["GameFontNormal"]);
    ItemLink:SetFullWidth(true);
    ItemLink:SetText(itemLabel);
    ScrollFrame:AddChild(ItemLink);

    local AuctionEntry = AceGUI:Create("Label");
    AuctionEntry:SetText("\n|c00967FD2About|r");
    AuctionEntry:SetFullWidth(true);
    ScrollFrame:AddChild(AuctionEntry);
    for key, val in pairs(Auction or {}) do
        if (type(val) ~= "table") then
            AuctionEntry = AceGUI:Create("Label");
            AuctionEntry:SetText(string.format("%s: %s", key, val));
            AuctionEntry:SetFullWidth(true);
            ScrollFrame:AddChild(AuctionEntry);
        end
    end

    local WinnerEntry = AceGUI:Create("Label");
    WinnerEntry:SetText("\n|c00967FD2Won by|r");
    WinnerEntry:SetFullWidth(true);
    ScrollFrame:AddChild(WinnerEntry);

    for key, val in pairs(Auction.Winner or {}) do
        if (type(val) == "string" and val ~= "nil") then
            WinnerEntry = AceGUI:Create("Label");
            WinnerEntry:SetText(string.format("%s: %s", key, val));
            WinnerEntry:SetFullWidth(true);
            ScrollFrame:AddChild(WinnerEntry);
        end
    end

    local CreatedByEntry = AceGUI:Create("Label");
    CreatedByEntry:SetText("\n|c00967FD2Created by|r");
    CreatedByEntry:SetFullWidth(true);
    ScrollFrame:AddChild(CreatedByEntry);

    for key, val in pairs(Auction.CreatedBy or {}) do
        if (type(val) == "string" and val ~= "nil") then
            CreatedByEntry = AceGUI:Create("Label");
            CreatedByEntry:SetText(string.format("%s: %s", key, val));
            CreatedByEntry:SetFullWidth(true);
            ScrollFrame:AddChild(CreatedByEntry);
        end
    end

    if (type(Auction.Bids) == "table") then
        local BidEntry = AceGUI:Create("Label");
        BidEntry:SetText("\n|c00967FD2Bids|r");
        BidEntry:SetFullWidth(true);
        ScrollFrame:AddChild(BidEntry);

        local firstBid = true;
        local linebreak = "";
        for player, Bid in pairs(Auction.Bids or {}) do
            if (not firstBid) then
                linebreak = "\n";
            end

            BidEntry = AceGUI:Create("Label");
            BidEntry:SetText(string.format("%sBy: %s", linebreak, player));
            BidEntry:SetFullWidth(true);
            ScrollFrame:AddChild(BidEntry);

            for key, val in pairs(Bid or {}) do
                if (type(val) ~= "table") then
                    BidEntry = AceGUI:Create("Label");
                    BidEntry:SetText(string.format("%s: %s", key, val));
                    BidEntry:SetFullWidth(true);
                    ScrollFrame:AddChild(BidEntry);
                else
                    for bidderKey, bidderVal in pairs(val or {}) do
                        BidEntry = AceGUI:Create("Label");
                        BidEntry:SetText(string.format("%s: %s", bidderKey, bidderVal));
                        BidEntry:SetFullWidth(true);
                        ScrollFrame:AddChild(BidEntry);
                    end
                end
            end

            firstBid = false;
        end
    end

    Spacer = AceGUI:Create("SimpleGroup");
    Spacer:SetLayout("FILL")
    Spacer:SetFullWidth(true);
    Spacer:SetHeight(30);
    ScrollFrame:AddChild(Spacer);

    local CloseButton = AceGUI:Create("Button");
    CloseButton:SetText("Close");
    CloseButton:SetFullWidth(true);
    CloseButton:SetCallback("OnClick", function()
        self:close();
    end);
    ScrollFrame:AddChild(CloseButton);
end

--- Close the details
---
---@return void
---
---@todo use build/draw to reuse frames. Can't simply :Release() because of ScrollBar
function AuctionDetails:close()
    local Window = Interface:get(self, "Window");

    if (Window and Window.frame) then
        Window.frame:Hide();
    end

    self.sessionID = nil;
    self.auctionID = nil;
end

GL:debug("Interfaces/GDKP/AuctionDetails.lua");