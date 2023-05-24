---@type GL
local _, GL = ...;

local AceGUI = GL.AceGUI;
local Constants = GL.Data.Constants; ---@type Data
local DB = GL.DB; ---@type DB
local PlusOnes = GL.PlusOnes; ---@type PlusOnes

---@class PlusOnesOverview
GL:tableSet(GL, "Interface.PlusOnes.Overview", {
    isVisible = false,
    plusOnes = 0,
    ShareButton = {},
    SettingsButton = {},
    Window = nil,
});

local Overview = GL.Interface.PlusOnes.Overview; ---@type PlusOnesOverview

function Overview:draw()
    GL:debug("Overview:draw");

    if (self.isVisible) then
        return;
    end

    self.isVisible = true;

    -- Create a container/parent frame
    local Window = AceGUI:Create("Frame");
    self.Window = Window
    Window:SetTitle("Gargul v" .. GL.version);
    Window:SetLayout("Flow");
    Window:SetWidth(485);
    Window:SetHeight(465);
    Window.statustext:GetParent():Show(); -- Show the statustext bar
    Window:EnableResize(false);
    Window:SetCallback("OnClose", function()
        self:close();
    end);
    GL.Interface:set(self, "Window", Window);
    Window:SetPoint(GL.Interface:getPosition("PlusOnesOverview"));
    local importedAt = GL:tableGet(DB.PlusOnes, "MetaData.importedAt", GetServerTime());
    local updatedAt = GL:tableGet(DB.PlusOnes, "MetaData.updatedAt", GetServerTime());
        Window:SetStatusText(string.format(
            "Imported on |c00a79eff%s|r at |c00a79eff%s|r, Updated on |c00a79eff%s|r at |c00a79eff%s|r",
            date('%Y-%m-%d', importedAt),
            date('%H:%M', importedAt),
            date('%Y-%m-%d', updatedAt),
            date('%H:%M', updatedAt)
        ));

    -- Make sure the window can be closed by pressing the escape button
    _G["GARGUL_PLUSONES_OVERVIEW_WINDOW"] = Window.frame;
    tinsert(UISpecialFrames, "GARGUL_PLUSONES_OVERVIEW_WINDOW");

    --[[
        SHARE BUTTON
    ]]
    local ShareButton = GL.Interface:createShareButton(Window, {
        onClick = function() GL.Interface.Dialogs.PopupDialog:open("BROADCAST_PLUSONES_CONFIRMATION"); end,
        tooltip = "Broadcast Data",
        disabledTooltip = "To broadcast you need to be in a group and need master loot, assist or lead!",
        position = "TOPRIGHT",
    });
    self.ShareButton = ShareButton;
    ShareButton:Show();

    --[[
        SETTINGS BUTTON
    ]]
    local SettingsButton = GL.UI:createSettingsButton(
        Window.frame,
        "PlusOnes"
    );
    self.SettingsButton = SettingsButton;

    local HorizontalSpacer = AceGUI:Create("SimpleGroup");
    HorizontalSpacer:SetLayout("FILL")
    HorizontalSpacer:SetWidth(420);
    HorizontalSpacer:SetHeight(16);
    Window:AddChild(HorizontalSpacer);

    local ScrollFrameParent = AceGUI:Create("SimpleGroup");
    ScrollFrameParent:SetLayout("Fill");
    ScrollFrameParent:SetFullWidth(true);
    ScrollFrameParent:SetHeight(318);
    Window:AddChild(ScrollFrameParent);

    local ScrollFrame = AceGUI:Create("ScrollFrame");
    ScrollFrame:SetLayout("Flow");
    ScrollFrameParent:AddChild(ScrollFrame);

    HorizontalSpacer = AceGUI:Create("SimpleGroup");
    HorizontalSpacer:SetLayout("FILL");
    HorizontalSpacer:SetFullWidth(true);
    HorizontalSpacer:SetHeight(6);
    Window:AddChild(HorizontalSpacer);

    local ButtonFrame = AceGUI:Create("SimpleGroup");
    ButtonFrame:SetLayout("FLOW")
    ButtonFrame:SetFullWidth(true);
    Window:AddChild(ButtonFrame);

    local ClearButton = AceGUI:Create("Button");
    ClearButton:SetText("Clear Data");
    ClearButton:SetWidth(80);
    ClearButton:SetCallback("OnClick", function()
        GL.Interface.Dialogs.PopupDialog:open("CLEAR_PLUSONES_CONFIRMATION");
    end);
    ButtonFrame:AddChild(ClearButton);

    VerticalSpacer = AceGUI:Create("SimpleGroup");
    VerticalSpacer:SetLayout("FILL");
    VerticalSpacer:SetWidth(99);
    VerticalSpacer:SetHeight(24);
    ButtonFrame:AddChild(VerticalSpacer);

    local ImportButton = AceGUI:Create("Button");
    ImportButton:SetText("Import");
    ImportButton:SetWidth(80);
    ImportButton:SetCallback("OnClick", function()
        self:close();
        GL.Interface.PlusOnes.Importer:draw();
    end);
    ButtonFrame:AddChild(ImportButton);

    VerticalSpacer = AceGUI:Create("SimpleGroup");
    VerticalSpacer:SetLayout("FILL");
    VerticalSpacer:SetWidth(99);
    VerticalSpacer:SetHeight(24);
    ButtonFrame:AddChild(VerticalSpacer);

    local ExportButton = AceGUI:Create("Button");
    ExportButton:SetText("Export");
    ExportButton:SetWidth(80);
    ExportButton:SetCallback("OnClick", function()
        PlusOnes:export(true);
    end);
    ButtonFrame:AddChild(ExportButton);

    HorizontalSpacer = AceGUI:Create("SimpleGroup");
    HorizontalSpacer:SetLayout("FILL");
    HorizontalSpacer:SetFullWidth(true);
    HorizontalSpacer:SetHeight(6);
    Window:AddChild(HorizontalSpacer);

    self:addPlayerPlusOneEntries(ScrollFrame);

    self:updateShareButton();

    GL.Events:register("PlusOnesOverViewChangeListener", "GL.PLUSONES_CHANGED", function () self:update(); end);
    GL.Events:register("PlusOnesOverViewRosterUpdatedListener","GL.GROUP_ROSTER_UPDATE_THROTTLED", function () self:close(); self:draw(); end);
    GL.Events:register("PlusOnesOverViewUserJoinedGroupListener", "GL.USER_JOINED_GROUP", function () self:update(); end);
    GL.Events:register("PlusOnesShareButtonRosterUpdatedListener", "GROUP_ROSTER_UPDATE", function () self:updateShareButton(); end);
    GL.Events:register("PlusOnesBroadcastStartedListener", "GL.PLUSONES_BROADCAST_STARTED", function () self:updateShareButton(); end);
    GL.Events:register("PlusOnesBroadcastEndedListener", "GL.PLUSONES_BROADCAST_ENDED", function () self:updateShareButton(); end);

end

--- Update the share button when the group setup changes
---
---@return void
function Overview:updateShareButton()
    local ShareButton = self.ShareButton;

    if (not ShareButton) then
        return;
    end

    GL.Ace:ScheduleTimer(function ()
        -- The user doesn't have sufficient permissions to broadcast the data
        -- Or a broadcast is already in process
        if (GL.PlusOnes.broadcastInProgress
                or not GL.PlusOnes:userIsAllowedToBroadcast()
        ) then
            ShareButton:Disable();
            return;
        end

        ShareButton:Enable();
    end, 1.5);
end

--- Add all player entries to the PlusOnes ScrollFrame
---
---@param Parent table
---@return void
function Overview:addPlayerPlusOneEntries(Parent)
    local HorizontalSpacer;
    local PlusOneEntries = {};

    for _, Player in pairs(GL.User:groupMembers()) do
        tinsert(PlusOneEntries, {
            name = Player.fqn,
            class = Player.class,
            total = GL.PlusOnes:getPlusOnes(Player.fqn),
        });
    end

    -- Sort the PlusOne entries alphabetically
    table.sort(PlusOneEntries, function (a, b)
        if (a.name and b.name) then
            return a.name < b.name;
        end

        return false;
    end);

    for _, Entry in pairs(PlusOneEntries) do
        local Row = AceGUI:Create("SimpleGroup");
        Row:SetLayout("Flow");
        Row:SetFullWidth(true);
        Row:SetHeight(30);

        local PlayerName = AceGUI:Create("Label");
        PlayerName:SetFontObject(_G["GameFontNormal"]);
        PlayerName:SetText(GL:nameFormat(Entry.name));
        PlayerName:SetColor(unpack(GL:classRGBColor(Entry.class)))
        PlayerName:SetHeight(28);
        PlayerName:SetWidth(320);
        Row:AddChild(PlayerName);

        local DeductButton = AceGUI:Create("Button");
        DeductButton:SetText("<");
        DeductButton:SetWidth(38);
        DeductButton:SetCallback("OnClick", function()
            Entry.total = max(Entry.total -1, 0);
            GL.PlusOnes:queueUpdate(Entry.name, Entry.total);
            self:update();
        end);
        Row:AddChild(DeductButton);

        local PlusOneStatus = AceGUI:Create("Label");
        PlusOneStatus:SetFontObject(_G["GameFontNormal"]);
        PlusOneStatus:SetText(Entry.total);
        PlusOneStatus:SetHeight(28);
        PlusOneStatus:SetWidth(30);
        PlusOneStatus:SetJustifyH("CENTER");
        Row:AddChild(PlusOneStatus);
        GL.Interface:set(self, "PlusOnesOf_" .. Entry.name, PlusOneStatus);

        local AddButton = AceGUI:Create("Button");
        AddButton:SetText(">");
        AddButton:SetWidth(38);
        AddButton:SetCallback("OnClick", function()
            Entry.total = Entry.total + 1;
            GL.PlusOnes:queueUpdate(Entry.name, Entry.total);
            self:update();
        end);
        Row:AddChild(AddButton);

        Parent:AddChild(Row);

        HorizontalSpacer = AceGUI:Create("SimpleGroup");
        HorizontalSpacer:SetLayout("FILL");
        HorizontalSpacer:SetFullWidth(true);
        HorizontalSpacer:SetHeight(8);
        Parent:AddChild(HorizontalSpacer);
    end
end

--- Close the window and stop listening for plusone changes
---
---@return void
function Overview:close()
    GL:debug("Overview:close");

    if (not self.isVisible) then
        return;
    end

    local Window = GL.Interface:get(self, "Window");

    if (Window) then
        Window:Hide();
    end

    self.isVisible = false;
    GL.Interface:storePosition(Window, "PlusOnesOverview");

    GL.Events:unregister("PlusOnesOverViewChangeListener");
    GL.Events:unregister("PlusOnesOverViewRosterUpdatedListener");
    GL.Events:unregister("PlusOnesOverViewUserJoinedGroupListener");
    GL.Events:unregister("PlusOnesShareButtonRosterUpdatedListener");
    GL.Events:unregister("PlusOnesBroadcastStartedListener");
    GL.Events:unregister("PlusOnesBroadcastEndedListener");
end

--- Update all PlusOne values in the plusone overview
---
---@return void
function Overview:update()
    local importedAt = GL:tableGet(DB.PlusOnes, "MetaData.importedAt", GetServerTime());
    local updatedAt = GL:tableGet(DB.PlusOnes, "MetaData.updatedAt", GetServerTime());
        self.Window:SetStatusText(string.format(
            "Imported on |c00a79eff%s|r at |c00a79eff%s|r, Updated on |c00a79eff%s|r at |c00a79eff%s|r",
            date('%Y-%m-%d', importedAt),
            date('%H:%M', importedAt),
            date('%Y-%m-%d', updatedAt),
            date('%H:%M', updatedAt)
        ));

    if (not IsInGroup()) then
        self:close();
        return self:draw();
    end

    for _, Player in pairs(GL.User:groupMembers()) do
        local PlusOneLabel = GL.Interface:get(self, "Label.PlusOnesOf_" .. Player.fqn);

        if (PlusOneLabel) then
            PlusOneLabel:SetText(GL.PlusOnes:getPlusOnes(Player.fqn));
        else
            self:close();
            return self:draw();
        end
    end
end

GL:debug("Interfaces/PlusOnes/Overview.lua");