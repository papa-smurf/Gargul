local L = Gargul_L;

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
---@return nil
function AuctionDetails:toggle(sessionID, auctionID)
    if (self.sessionID == sessionID
        and self.auctionID == auctionID
    ) then
        return self:close();
    end

    self:draw(sessionID, auctionID);
end

---@param sessionID string
---@param auctionID string
---@return nil
function AuctionDetails:draw(sessionID, auctionID)
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
    local ItemEntry = GL:getCachedItem(Auction.itemLink);

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
            itemLabel = (L["\n|c00%s%s added to pot by %s\nNote: %s"]):format(
                Constants.ClassHexColors.rogue,
                Auction.price and GL:goldToMoneyTexture(Auction.price) or L["0"],
                GL:nameFormat{ name = Auction.Winner.name, colorize = true, },
                Auction.note or ""
            );
        else
            itemLabel = (L["\n%s paid |c00%s%s for\n%s"]):format(
                GL:nameFormat{ name = Auction.Winner.name, colorize = true, },
                Constants.ClassHexColors.rogue,
                Auction.price and GL:goldToMoneyTexture(Auction.price) or L["0"],
                ItemEntry.link
            );
        end

        -- Item was deleted
    else
        local reason = Auction.reason;

        if (GL:empty(reason)) then
            reason = "-";
        end

        itemLabel = (L["\n|c00be3333Deleted by %s\nReason: %s"]):format(
            GL:nameFormat{ name = Auction.CreatedBy.name, colorize = true, },
            reason
        );
    end

    local ItemLink = AceGUI:Create("Label");
    ItemLink:SetFontObject(_G["GameFontNormal"]);
    ItemLink:SetFullWidth(true);
    ItemLink:SetText(itemLabel);
    ScrollFrame:AddChild(ItemLink);

    local AuctionEntry = AceGUI:Create("Label");
    AuctionEntry:SetText(("\n|c00967FD2%s|r"):format(L["About"]));
    AuctionEntry:SetFullWidth(true);
    ScrollFrame:AddChild(AuctionEntry);
    for key, val in pairs(Auction or {}) do
        if (val and type(val) ~= "table") then
            AuctionEntry = AceGUI:Create("Label");
            AuctionEntry:SetText(string.format("%s: %s", key, val));
            AuctionEntry:SetFullWidth(true);
            ScrollFrame:AddChild(AuctionEntry);
        end
    end

    local WinnerEntry = AceGUI:Create("Label");
    WinnerEntry:SetText("\n|c00967FD2" .. L["Won by"] .. "|r");
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
    CreatedByEntry:SetText("\n|c00967FD2" .. L["Created by"] .. "|r");
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
        local SortedBids = GL:tableValues(Auction.Bids or {});
        table.sort(SortedBids, function (a, b)
            if (not a or not b or not a.bid or not b.bid) then
                return false;
            end

            return a.bid > b.bid;
        end);

        local BidEntry = AceGUI:Create("Label");
        BidEntry:SetText("\n|c00967FD2" .. L["Bids"] .. "|r");
        BidEntry:SetFullWidth(true);
        ScrollFrame:AddChild(BidEntry);

        local firstBid = true;
        local linebreak = "";
        for _, Bid in pairs(SortedBids) do
            if (not firstBid) then
                linebreak = "\n";
            end

            BidEntry = AceGUI:Create("Label");
            BidEntry:SetText(string.format("%s%s: %s", linebreak, L["by"], GL:nameFormat(Bid.bidder)));
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
    CloseButton:SetText(L["Close"]);
    CloseButton:SetFullWidth(true);
    CloseButton:SetCallback("OnClick", function()
        self:close();
    end);
    ScrollFrame:AddChild(CloseButton);
end

--- Close the details
---
---@return nil
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
