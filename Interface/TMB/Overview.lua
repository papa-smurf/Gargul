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
    Window:SetWidth(500);
    Window:SetHeight(300);
    Window:EnableResize(false);
    Window.statustext:GetParent():Show(); -- Explicitely show the statustext bar
    Window:SetCallback("OnClose", function()
       self:close();
    end);
    GL.Interface:set(self, "Window", Window);

    Window:SetPoint(GL.Interface:getPosition("TMBOverview"));

    Window:SetStatusText(string.format(
        "Imported on |c00a79eff%s|r at |c00a79eff%s|r",
        date('%Y-%m-%d', DB:get("TMB.MetaData.importedAt", GetServerTime())),
        date('%H:%M', DB:get("TMB.MetaData.importedAt", GetServerTime()))
    ));

    -- Make sure the window can be closed by pressing the escape button
    _G["GARGUL_TMB_OVERVIEW_WINDOW"] = Window.frame;
    tinsert(UISpecialFrames, "GARGUL_TMB_OVERVIEW_WINDOW");

    local source = GL.TMB:source();

    local VerticalSpacer = GL.AceGUI:Create("SimpleGroup");
    VerticalSpacer:SetLayout("FILL");
    VerticalSpacer:SetFullWidth(true);
    VerticalSpacer:SetHeight(6);
    Window:AddChild(VerticalSpacer);

    local MoreInfoLabel = GL.AceGUI:Create("Label");
    MoreInfoLabel:SetText(string.format("|c00FFF569How to use Gargul with %s|r", source));
    MoreInfoLabel:SetFontObject(_G["GameFontGreenLarge"]);
    MoreInfoLabel:SetFullWidth(true);
    MoreInfoLabel:SetJustifyH("MIDDLE");
    Window:AddChild(MoreInfoLabel);

    local DiscordURL = GL.AceGUI:Create("EditBox");
    DiscordURL:DisableButton(true);
    DiscordURL:SetHeight(20);
    DiscordURL:SetFullWidth(true);
    DiscordURL:SetText("https://github.com/papa-smurf/Gargul/wiki/Gargul-and-ThatsMyBIS");
    Window:AddChild(DiscordURL);

    VerticalSpacer = GL.AceGUI:Create("SimpleGroup");
    VerticalSpacer:SetLayout("FILL");
    VerticalSpacer:SetFullWidth(true);
    VerticalSpacer:SetHeight(10);
    Window:AddChild(VerticalSpacer);

    local TimestampLabel = AceGUI:Create("Label");
    TimestampLabel:SetFullWidth(true);
    TimestampLabel:SetText(string.format(
        "\nThis %s data was imported on |c00a79eff%s|r at |c00a79eff%s|r",
        source,
        date('%Y-%m-%d', DB:get("TMB.MetaData.importedAt", GetServerTime())),
        date('%H:%M', DB:get("TMB.MetaData.importedAt", GetServerTime()))
    ));
    TimestampLabel:SetJustifyH("MIDDLE");
    TimestampLabel:SetFontObject(_G["GameFontNormal"]);
    Window:AddChild(TimestampLabel);

    local ItemNumberLabel = AceGUI:Create("Label");
    ItemNumberLabel:SetFullWidth(true);
    ItemNumberLabel:SetText(string.format(
        "\nNumber of items imported: |c00a79eff%s|r",
        GL:count(DB:get("TMB.Items")) or 0

    ));
    ItemNumberLabel:SetJustifyH("MIDDLE");
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
    PriorityNotesLabel:SetJustifyH("MIDDLE");
    PriorityNotesLabel:SetFontObject(_G["GameFontNormal"]);
    Window:AddChild(PriorityNotesLabel);

    local autoSharingEnabled = "no";

    if (GL.Settings:get("TMB.automaticallyShareData", false)) then
        autoSharingEnabled = "yes";
    end

    local AutoSharingStatusLabel = AceGUI:Create("Label");
    AutoSharingStatusLabel:SetFullWidth(true);
    AutoSharingStatusLabel:SetText(string.format(
        "\nAuto-sharing enabled: |c00a79eff%s|r",
        autoSharingEnabled
    ));
    AutoSharingStatusLabel:SetJustifyH("MIDDLE");
    AutoSharingStatusLabel:SetFontObject(_G["GameFontNormal"]);
    Window:AddChild(AutoSharingStatusLabel);

    VerticalSpacer = AceGUI:Create("SimpleGroup");
    VerticalSpacer:SetLayout("FILL");
    VerticalSpacer:SetFullWidth(true);
    VerticalSpacer:SetHeight(15);
    Window:AddChild(VerticalSpacer);

    local ClearButton = AceGUI:Create("Button");
    ClearButton:SetWidth(152);
    ClearButton:SetText("Clear Data");
    ClearButton:SetCallback("OnClick", function()
        -- Show a confirmation dialog before clearing entries
        GL.Interface.Dialogs.PopupDialog:open{
            question = ("Are you sure you want to clear your %s tables?"):format(source),
            OnYes = function ()
                GL.Interface.TMB.Overview:close();
                GL.TMB:clear();

                GL.TMB:draw(string.lower(source));
            end,
        };
    end);
    Window:AddChild(ClearButton);

    local ShareButton = AceGUI:Create("Button");
    ShareButton:SetWidth(152);
    ShareButton:SetText("Share Data");
    ShareButton:SetCallback("OnClick", function()
        if (not GL:empty(GL.Settings:get("TMB.shareWhitelist", ""))) then
            GL.TMB:broadcast();
        else
            GL.Interface.Dialogs.PopupDialog:open("BROADCAST_TMB_CONFIRMATION");
        end
    end);
    ShareButton:SetDisabled(true);
    Window:AddChild(ShareButton);
    GL.Interface:set(self, "Share", ShareButton);

    local SettingsButton = AceGUI:Create("Button");
    SettingsButton:SetText("Settings");
    SettingsButton:SetWidth(152);
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
    GL.Interface:set(GL.TMB, "BroadcastProgress", BroadcastProgressLabel);

    self:updateShareButton();

    GL.Events:register("TMBShareButtonRosterUpdatedListener", "GROUP_ROSTER_UPDATE", function () self:updateShareButton(); end);
    GL.Events:register("TMBBroadcastStartedListener", "GL.TMB_BROADCAST_STARTED", function () self:updateShareButton(); end);
    GL.Events:register("TMBBroadcastEndedListener", "GL.TMB_BROADCAST_ENDED", function () self:updateShareButton(); end);
end

--- Update the share button when the group setup changes
---
---@return void
function Overview:updateShareButton()
    local ShareButton = GL.Interface:get(self, "Button.Share")

    if (not ShareButton) then
        return;
    end

    -- The user doesn't have sufficient permissions to broadcast
    -- Or a broadcast is already in progress
    if (GL.TMB.broadcastInProgress
        or not GL.TMB:userIsAllowedToBroadcast()
    ) then
        ShareButton:SetDisabled(true);
        return;
    end

    ShareButton:SetDisabled(false);
end

---@return void
function Overview:close()
    GL:debug("Overview:close");

    local Window = GL.Interface:get(self, "Window");

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

    local ShareButton = GL.Interface:get(self, "Frame.ShareButton");
    if (ShareButton) then
        ShareButton:Hide();
    end
end

GL:debug("Interfaces/TMB/Overview.lua");