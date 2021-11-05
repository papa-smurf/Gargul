---@type GL
local _, GL = ...;

GL.AceGUI = GL.AceGUI or LibStub("AceGUI-3.0");

local AceGUI = GL.AceGUI;
local DB = GL.DB; ---@type DB

GL:tableSet(GL, "Interface.TMB.Overview", {
    isVisible = false,
});

---@class TMBOverview
local Overview = GL.Interface.TMB.Overview;

---@return void
function Overview:draw()
    GL:debug("Overview:draw");

    -- The overview is already visible
    if (self.isVisible) then
        return;
    end

    self.isVisible = true;

    -- Create a container/parent frame
    local Window = AceGUI:Create("Frame");
    Window:SetTitle("Gargul v" .. GL.version);
    Window:SetLayout("Flow");
    Window:SetWidth(600);
    Window:SetHeight(250);
    Window:EnableResize(false);
    Window.statustext:GetParent():Show(); -- Explicitely show the statustext bar
    Window:SetCallback("OnClose", function()
       self:close();
    end);
    GL.Interface:setItem(self, "Window", Window);

    Window:SetPoint(GL.Interface:getPosition("TMBOverview"));

    Window:SetStatusText(string.format(
        "Imported on |c00a79eff%s|r at |c00a79eff%s|r",
        date('%Y-%m-%d', DB:get("TMB.MetaData.importedAt", GetServerTime())),
        date('%H:%M', DB:get("TMB.MetaData.importedAt", GetServerTime()))
    ));

    -- Make sure the window can be closed by pressing the escape button
    _G["GARGUL_TMB_OVERVIEW_WINDOW"] = Window.frame;
    tinsert(UISpecialFrames, "GARGUL_TMB_OVERVIEW_WINDOW");

    local TimestampLabel = AceGUI:Create("Label");
    TimestampLabel:SetFullWidth(true);
    TimestampLabel:SetText(string.format(
        "\nThis TMB data was imported on |c00a79eff%s|r at |c00a79eff%s|r",
        date('%Y-%m-%d', DB:get("TMB.MetaData.importedAt", GetServerTime())),
        date('%H:%M', DB:get("TMB.MetaData.importedAt", GetServerTime()))

    ));
    TimestampLabel:SetFontObject(_G["GameFontNormal"]);
    Window:AddChild(TimestampLabel);

    local ItemNumberLabel = AceGUI:Create("Label");
    ItemNumberLabel:SetFullWidth(true);
    ItemNumberLabel:SetText(string.format(
            "\nNumber of items imported: |c00a79eff%s|r",
            GL:count(DB:get("TMB.Items")) or 0

    ));
    ItemNumberLabel:SetFontObject(_G["GameFontNormal"]);
    Window:AddChild(ItemNumberLabel);

    local notesAvailable = "No";

    if (not GL:empty(GL.DB.LootPriority)) then
        notesAvailable = "Yes";
    end

    local PriorityNotesLabel = AceGUI:Create("Label");
    PriorityNotesLabel:SetFullWidth(true);
    PriorityNotesLabel:SetText(string.format(
        "\nPriority notes available: |c00a79eff%s|r",
        notesAvailable
    ));
    PriorityNotesLabel:SetFontObject(_G["GameFontNormal"]);
    Window:AddChild(PriorityNotesLabel);

    local VerticalSpacer = AceGUI:Create("SimpleGroup");
    VerticalSpacer:SetLayout("FILL");
    VerticalSpacer:SetFullWidth(true);
    VerticalSpacer:SetHeight(40);
    Window:AddChild(VerticalSpacer);

    local ClearButton = AceGUI:Create("Button");
    ClearButton:SetText("Clear Data");
    ClearButton:SetCallback("OnClick", function()
        GL.Interface.Dialogs.PopupDialog:open("CLEAR_TMB_CONFIRMATION");
    end);
    Window:AddChild(ClearButton);

    local ShareButton = AceGUI:Create("Button");
    ShareButton:SetText("Share Data");
    ShareButton:SetCallback("OnClick", function()
        GL.Interface.Dialogs.PopupDialog:open("BROADCAST_TMB_CONFIRMATION");
    end);
    ShareButton:SetDisabled(true);
    Window:AddChild(ShareButton);
    GL.Interface:setItem(self, "Share", ShareButton);

    local SettingsButton = AceGUI:Create("Button");
    SettingsButton:SetText("Settings");
    SettingsButton:SetWidth(160);
    SettingsButton:SetCallback("OnClick", function()
        GL.Settings:draw("TMB");
    end);
    Window:AddChild(SettingsButton);

    VerticalSpacer = AceGUI:Create("SimpleGroup");
    VerticalSpacer:SetLayout("FILL");
    VerticalSpacer:SetFullWidth(true);
    VerticalSpacer:SetHeight(4);
    Window:AddChild(VerticalSpacer);

    local HorizontalSpacer = AceGUI:Create("SimpleGroup");
    HorizontalSpacer:SetLayout("FILL");
    HorizontalSpacer:SetWidth(4);
    HorizontalSpacer:SetHeight(10);
    Window:AddChild(HorizontalSpacer);

    local BroadcastProgressLabel = AceGUI:Create("Label");
    BroadcastProgressLabel:SetWidth(200);
    BroadcastProgressLabel:SetFontObject(_G["GameFontNormal"]);
    Window:AddChild(BroadcastProgressLabel);
    GL.Interface:setItem(GL.TMB, "BroadcastProgress", BroadcastProgressLabel);

    self:updateShareButton();

    GL.Events:register("TMBShareButtonRosterUpdatedListener", "GROUP_ROSTER_UPDATE", function () self:updateShareButton(); end);
    GL.Events:register("TMBBroadcastStartedListener", "GL.TMB_BROADCAST_STARTED", function () self:updateShareButton(); end);
    GL.Events:register("TMBBroadcastEndedListener", "GL.TMB_BROADCAST_ENDED", function () self:updateShareButton(); end);
end

--- Update the share button when the group setup changes
---
---@return void
function Overview:updateShareButton()
    local ShareButton = GL.Interface:getItem(self, "Button.Share")

    if (not ShareButton) then
        return;
    end

    -- The user doesn't have sufficient permissions to broadcast
    -- Or a broadcast is already in progress
    if (GL.TMB.broadcastInProgress
        or not GL.User.isInGroup
        or (not GL.User.isMasterLooter
            and not GL.User.hasAssist
        )
    ) then
        ShareButton:SetDisabled(true);
        return;
    end

    ShareButton:SetDisabled(false);
end

---@return void
function Overview:close()
    GL:debug("Overview:close");

    local Window = GL.Interface:getItem(self, "Window");

    if (not self.isVisible
        or not Window
    ) then
        return;
    end

    GL.Events:unregister("TMBShareButtonRosterUpdatedListener");

    -- Store the frame's last position for future play sessions
    GL.Interface:storePosition(Window, "TMBOverview");

    -- Clear the frame and its widgets
    Window:Hide();
    self.isVisible = false;

    local ShareButton = GL.Interface:getItem(self, "Frame.ShareButton");
    if (ShareButton) then
        ShareButton:Hide();
    end
end

GL:debug("Interfaces/TMB/Overview.lua");