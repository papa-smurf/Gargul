local L = Gargul_L;

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

---@return nil
function Overview:draw()
    GL:debug("Overview:draw");

    -- The overview is already visible
    if (self.isVisible) then
        return;
    end

    self.isVisible = true;

    -- Create a container/parent frame
    local Window = AceGUI:Create("Frame");
    Window:SetTitle((L["Gargul v%s"]):format(GL.version));
    Window:SetLayout("Flow");
    Window:SetWidth(500);
    Window:SetHeight(300);
    Window:EnableResize(false);
    Window.statustext:GetParent():Show(); -- Explicitly show the statustext bar
    Window:SetCallback("OnClose", function()
       self:close();
    end);
    GL.Interface:set(self, "Window", Window);

    Window:SetPoint(GL.Interface:getPosition("TMBOverview"));

    Window:SetStatusText(GL:printfn(L["Imported on ${date} at ${time}"], {
        date = GL:colorize(date(L["%Y-%m-%d"], DB:get("TMB.MetaData.importedAt", GetServerTime())), GL.Interface.Colors.WARLOCK),
        time = GL:colorize(date(L["%H:%M"], DB:get("TMB.MetaData.importedAt", GetServerTime())), GL.Interface.Colors.WARLOCK),
    }));

    -- Make sure the window can be closed by pressing the escape button
    _G["GARGUL_TMB_OVERVIEW_WINDOW"] = Window.frame;
    tinsert(UISpecialFrames, "GARGUL_TMB_OVERVIEW_WINDOW");

    local VerticalSpacer = GL.AceGUI:Create("SimpleGroup");
    VerticalSpacer:SetLayout("FILL");
    VerticalSpacer:SetFullWidth(true);
    VerticalSpacer:SetHeight(6);
    Window:AddChild(VerticalSpacer);

    local MoreInfoLabel = GL.AceGUI:Create("Label");
    MoreInfoLabel:SetText(GL:printfn(L["How to use Gargul with ${source}"], { source = GL.TMB:source(), }));
    MoreInfoLabel:SetFontObject(_G["GameFontGreenLarge"]);
    MoreInfoLabel:SetFullWidth(true);
    MoreInfoLabel:SetJustifyH("CENTER");
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
    TimestampLabel:SetText(GL:printfn("\n" .. L["Imported on ${date} at ${time}"], {
        date = GL:colorize(date(L["%Y-%m-%d"], DB:get("TMB.MetaData.importedAt", GetServerTime())), GL.Interface.Colors.WARLOCK),
        time = GL:colorize(date(L["%H:%M"], DB:get("TMB.MetaData.importedAt", GetServerTime())), GL.Interface.Colors.WARLOCK),
    }));
    TimestampLabel:SetJustifyH("CENTER");
    TimestampLabel:SetFontObject(_G["GameFontNormal"]);
    Window:AddChild(TimestampLabel);

    local ItemNumberLabel = AceGUI:Create("Label");
    ItemNumberLabel:SetFullWidth(true);
    ItemNumberLabel:SetText(("\n" .. L["Number of items imported: %s"]):format(
        GL:colorize(GL:count(DB:get("TMB.Items")) or 0, GL.Interface.Colors.WARLOCK)
    ));
    ItemNumberLabel:SetJustifyH("CENTER");
    ItemNumberLabel:SetFontObject(_G["GameFontNormal"]);
    Window:AddChild(ItemNumberLabel);

    local notesAvailable = "No";

    if (not GL:empty(GL.DB.LootPriority)) then
        notesAvailable = "Yes";
    end

    local PriorityNotesLabel = AceGUI:Create("Label");
    PriorityNotesLabel:SetFullWidth(true);
    PriorityNotesLabel:SetText(("\n" .. L["Priority notes available: %s"]):format(
        GL:colorize(notesAvailable, GL.Interface.Colors.WARLOCK)
    ));
    PriorityNotesLabel:SetJustifyH("CENTER");
    PriorityNotesLabel:SetFontObject(_G["GameFontNormal"]);
    Window:AddChild(PriorityNotesLabel);

    local autoSharingEnabled = "No";

    if (GL.Settings:get("TMB.automaticallyShareData", false)) then
        autoSharingEnabled = "Yes";
    end

    local AutoSharingStatusLabel = AceGUI:Create("Label");
    AutoSharingStatusLabel:SetFullWidth(true);
    AutoSharingStatusLabel:SetText(("\n" .. L["Auto-sharing enabled: %s"]):format(
        GL:colorize(autoSharingEnabled, GL.Interface.Colors.WARLOCK)
    ));
    AutoSharingStatusLabel:SetJustifyH("CENTER");
    AutoSharingStatusLabel:SetFontObject(_G["GameFontNormal"]);
    Window:AddChild(AutoSharingStatusLabel);

    VerticalSpacer = AceGUI:Create("SimpleGroup");
    VerticalSpacer:SetLayout("FILL");
    VerticalSpacer:SetFullWidth(true);
    VerticalSpacer:SetHeight(15);
    Window:AddChild(VerticalSpacer);

    local ClearButton = AceGUI:Create("Button");
    ClearButton:SetWidth(110);
    ClearButton:SetText(L["Clear"]);
    ClearButton:SetCallback("OnClick", function()
        -- Show a confirmation dialog before clearing entries
        GL.Interface.Dialogs.PopupDialog:open{
            question = L["Are you sure?"],
            OnYes = function ()
                local source = GL.TMB:source();
                GL.Interface.TMB.Overview:close();
                GL.TMB:clear();

                GL.TMB:draw(strlower(source));
            end,
        };
    end);
    GL.Interface:addTooltip(ClearButton, L["Clear TMB / DFT data. This doesn't affect any data on your raider's machines"]);
    Window:AddChild(ClearButton);

    local ShareButton = AceGUI:Create("Button");
    ShareButton:SetWidth(108);
    ShareButton:SetText(L["Broadcast"]);
    ShareButton:SetCallback("OnClick", function()
        if (not GL:empty(GL.Settings:get("TMB.shareWhitelist", ""))) then
            GL.TMB:broadcast();
        else
            GL.Interface.Dialogs.PopupDialog:open({
                question = L["Are you sure you want to broadcast your TMB data to everyone in your party/raid? NB: EVERYONE can see your TMB data regardless of their permissions on the TMB website!"],
                OnYes = function ()
                    GL.TMB:broadcast();
                end,
            });
        end
    end);
    ShareButton:SetDisabled(true);
    Window:AddChild(ShareButton);
    GL.Interface:set(self, "Share", ShareButton);

    local SettingsButton = AceGUI:Create("Button");
    SettingsButton:SetText(L["Settings"]);
    SettingsButton:SetWidth(90);
    SettingsButton:SetCallback("OnClick", function()
        GL.Settings:draw("TMB");
    end);
    Window:AddChild(SettingsButton);

    local ClearRaiderDataButton = AceGUI:Create("Button");
    ClearRaiderDataButton:SetText(L["Clear Raider Data"]);
    ClearRaiderDataButton:SetWidth(146); ---@TODO: TOO SHORT FOR FRENCH
    ClearRaiderDataButton:SetCallback("OnClick", function()
        -- Show a confirmation dialog before clearing entries
        GL.Interface.Dialogs.PopupDialog:open{
            question = L["Clear TMB data for all raiders?"],
            OnYes = function ()
                GL.TMB:broadcast(true);
            end,
        };
    end);
    GL.Interface:addTooltip(ClearRaiderDataButton, L["Remove TMB / DFT data on your raider's machines, useful if you broadcasted data accidentally"]);
    Window:AddChild(ClearRaiderDataButton);


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
---@return nil
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

---@return nil
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