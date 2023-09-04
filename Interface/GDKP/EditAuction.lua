---@type GL
local _, GL = ...;

---@type Interface
local Interface = GL.Interface;

GL.AceGUI = GL.AceGUI or LibStub("AceGUI-3.0");
local AceGUI = GL.AceGUI;

---@type GDKPAuction
local GDKPAuction = GL.GDKP.Auction;

---@class GDKPEditAuction
GL.Interface.GDKP.EditAuction = {}

---@type GDKPEditAuction
local EditAuction = GL.Interface.GDKP.EditAuction;

---@return void
function EditAuction:draw(session, checksum)
    GL:debug("GDKP.Edit:draw");

    local VerticalSpacer;

    -- Release any existing edit auction window
    self:close();

    session = tostring(session);
    checksum = tostring(checksum);
    local Auction = GL.DB:get(string.format("GDKP.Ledger.%s.Auctions.%s", session, checksum));

    -- The given auction does not exist
    if (not Auction) then
        return;
    end

    ---@type GDKPOverview
    local Overview = GL.Interface.GDKP.Overview;

    -- It seems our GDKP overview window is not opened
    if (not Overview.isVisible) then
        return;
    end

    -- Create a container/parent frame
    local Window = AceGUI:Create("InlineGroup");
    Window:SetLayout("Flow");
    Window:SetWidth(200);
    Window:SetHeight(280);
    Window:SetPoint("TOPLEFT", Interface:get(Overview, "GDKPOverview").frame, "TOPRIGHT", 2, 16);
    Interface:set(self, "Window", Window);
    Window.frame:SetFrameStrata("HIGH");
    Window.frame:Show();

    local ItemLink = AceGUI:Create("Label");
    ItemLink:SetFontObject(_G["GameFontNormal"]);
    ItemLink:SetFullWidth(true);
    ItemLink:SetText(string.format(
        "|cFF%s%s|r paid |cFF%s%sg|r for\n%s",
        GL:classHexColor(Auction.Winner.class),
        Auction.Winner.name or "",
        GL:classHexColor("rogue"),
        Auction.price or "0",
        GL:getCachedItem(Auction.itemID).link
    ));
    Window:AddChild(ItemLink);

    VerticalSpacer = AceGUI:Create("SimpleGroup");
    VerticalSpacer:SetLayout("FILL");
    VerticalSpacer:SetFullWidth(true);
    VerticalSpacer:SetHeight(4);
    Window:AddChild(VerticalSpacer);

    local DropDownItems = {};
    local ItemOrder = {};

    local Sessions = GL.DB:get("GDKP.Ledger");
    table.sort(Sessions, function (a, b)
        if (a.createdAt and b.createdAt) then
            return a.createdAt < b.createdAt;
        end

        return false;
    end);
    for _, Session in pairs(Sessions) do
        DropDownItems[Session.ID] = Session.title;
        tinsert(ItemOrder, Session.ID);
    end

    local SessionDropdown = AceGUI:Create("Dropdown");
    SessionDropdown:SetValue(session);
    SessionDropdown:SetList(DropDownItems, ItemOrder);
    SessionDropdown:SetText(DropDownItems[session]);
    SessionDropdown:SetLabel("Session");
    SessionDropdown:SetWidth(250);
    Window:AddChild(SessionDropdown);

    local PlayernameInput = GL.AceGUI:Create("EditBox");
    PlayernameInput:DisableButton(true);
    PlayernameInput:SetHeight(20);
    PlayernameInput:SetWidth(250);
    PlayernameInput:SetText(GL:nameFormat(Auction.Winner.guid));
    PlayernameInput:SetLabel("Player");
    Window:AddChild(PlayernameInput);

    local NoteInput = GL.AceGUI:Create("EditBox");
    NoteInput:DisableButton(true);
    NoteInput:SetHeight(20);
    NoteInput:SetWidth(250);
    NoteInput:SetText(Auction.note);
    NoteInput:SetLabel("Note");
    Window:AddChild(NoteInput);

    local AdjustPaidInput = GL.AceGUI:Create("EditBox");
    AdjustPaidInput:DisableButton(true);
    AdjustPaidInput:SetHeight(20);
    AdjustPaidInput:SetWidth(250);
    AdjustPaidInput:SetText(Auction.paid);
    AdjustPaidInput:SetLabel("     Set paid amount (read left)");
    Window:AddChild(AdjustPaidInput);

    local HelpIcon = AceGUI:Create("Icon");
    HelpIcon:SetWidth(12);
    HelpIcon:SetHeight(12);
    HelpIcon:SetImageSize(12, 12);
    HelpIcon:SetImage("interface/friendsframe/informationicon");
    HelpIcon.frame:SetParent(AdjustPaidInput.frame);
    HelpIcon.frame:SetPoint("BOTTOMLEFT", AdjustPaidInput.frame, "BOTTOMLEFT", 2, 22);
    HelpIcon.frame:Show();

    HelpIcon:SetCallback("OnEnter", function()
        GameTooltip:SetOwner(HelpIcon.frame, "ANCHOR_RIGHT");
        GameTooltip:AddLine(" ");
        GameTooltip:AddLine("Gargul automatically keeps track of gold traded. As long as players pay");
        GameTooltip:AddLine("for what they bought then you shouldn't ever need this field");
        GameTooltip:AddLine(" ");
        GameTooltip:AddLine("\"Paid amount\" refers to the amount of gold the buyer already traded you.");
        GameTooltip:AddLine("This does not change the actual price of the item!");
        GameTooltip:AddLine(" ");
        GameTooltip:AddLine("Warning: only set a value here if the player promises to pay");
        GameTooltip:AddLine("outside of the raid or trades the gold from an alt / mail etc!");
        GameTooltip:AddLine(" ");

        GameTooltip:AddLine(" ");
        GameTooltip:Show();
    end);

    HelpIcon:SetCallback("OnLeave", function()
        GameTooltip:Hide();
    end);

    local SaveButton = AceGUI:Create("Button");
    SaveButton:SetText("Save");
    SaveButton:SetFullWidth(true);
    SaveButton:SetCallback("OnClick", function()
        local newName = strtrim(PlayernameInput:GetText());
        local note = strtrim(NoteInput:GetText());
        local paid = strtrim(AdjustPaidInput:GetText());

        -- The winner was changed
        if (not GL:empty(newName)
            and Auction.Winner.name ~= newName
        ) then
            GDKPAuction:reassignAuction(session, checksum, newName);
        end

        -- The note was changed
        if (Auction.note ~= note) then
            GDKPAuction:setNote(session, checksum, note);
        end

        -- The note was changed
        if (not GL:empty(paid)
            and Auction.paid ~= paid
            and tonumber(paid)
        ) then
            GDKPAuction:setPaid(session, checksum, paid);
        end

        -- The session was changed (make sure we do this last!)
        if (session ~= SessionDropdown:GetValue()) then
            GDKPAuction:move(checksum, session, SessionDropdown:GetValue());
        end

        self:close();
    end);
    Window:AddChild(SaveButton);

    local CancelButton = AceGUI:Create("Button");
    CancelButton:SetText("Cancel");
    CancelButton:SetFullWidth(true);
    CancelButton:SetCallback("OnClick", function()
        self:close();
    end);
    Window:AddChild(CancelButton);
end

function EditAuction:close()
    Interface:release(self, "Window");
end

GL:debug("Interfaces/GDKP/EditAuction.lua");