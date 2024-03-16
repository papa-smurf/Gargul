
---@TODO: TRANSLATE SETTINGS!

local L = Gargul_L;

---@type GL
local _, GL = ...;

GL.ScrollingTable = GL.ScrollingTable or LibStub("ScrollingTable");
local ScrollingTable = GL.ScrollingTable;

GL.Interface.Settings = GL.Interface.Settings or {};
---@class SettingsOverview
GL.Interface.Settings.Overview = {
    isVisible = false,
    activeSection = nil,
    previousSection = nil,
    defaultSection = "Welcome",
    Sections = {
        {"|c00A79EFFWELCOME|r", "Welcome"},
        {"General", "General"},
        {"Minimap Icon", "MinimapButton"},
        {"SoftRes", "SoftRes"},
        {"TMB and DFT", "TMB"},
        GL.GDKPIsAllowed and {"GDKP", "GDKP"} or nil,
        GL.GDKPIsAllowed and {"    Communication", "GDKPCommunication"} or nil,
        GL.GDKPIsAllowed and {"    Prices", "GDKPPrices"} or nil,
        GL.GDKPIsAllowed and {"    Mutators", "GDKPMutators"} or nil,
        GL.GDKPIsAllowed and {"    Queues", "GDKPQueues"} or nil,
        {"Dropped Loot", "DroppedLoot"},
        {"Exporting Loot", "ExportingLoot"},
        {"Loot trade timers", "LootTradeTimers"},
        {"Autoloot with PackMule", "PackMule"},
        {"    Item Rules", "PackMuleRules"},
        {"    Ignored Items", "PackMuleIgnores"},
        {"", ""},
        {"|c00A79EFFADVANCED|r", "Advanced"},
        {"Master Looting", "MasterLooting"},
        {"    Roll Tracking", "RollTracking"},
        {"    Awarding Loot", "AwardingLoot"},
        {"Shortcut Keys", "ShortcutKeys"},
        {"Trade Announcements", "TradeAnnouncements"},
        {"Rolling", "Rolling"},
        {"Loot Highlighting", "LootHighlighting"},
        {"Boosted Rolls", "BoostedRolls"},
        {"Plus Ones", "PlusOnes"},
        {"", ""},
        {"Slash Commands", "SlashCommands"},
    },
    SectionIndexes = false,
};
local Overview = GL.Interface.Settings.Overview; ---@type SettingsOverview

GL.Interface.Settings.Overview.Sections = GL:tableValues(GL.Interface.Settings.Overview.Sections);

--- Draw a setting section
---
---@param section string|nil
---@param param function|nil What to do after closing the settings again
---@return void
function Overview:draw(section, onCloseCallback)
    local AceGUI = GL.AceGUI;

    if (self.isVisible) then
        return self:showSection(section);
    end

    self.isVisible = true;

    -- Fill the SectionIndexes table (only once per play session)
    if (not self.SectionIndexes) then
        self.SectionIndexes = {};

        for index, Entry in pairs(self.Sections) do
            if (not GL:empty(Entry[2])) then
                self.SectionIndexes[Entry[2]] = index;
            end
        end
    end

    -- Open a specific section based on the section identifier
    -- If no identifier is given we open the most recent one or open the homescreen
    if (type (section) ~= "string"
        or GL:empty(section)
        or not self.SectionIndexes[section]
    ) then
        section = self.previousSection or self.defaultSection;
    end

    -- Create a container/parent frame
    local Window = AceGUI:Create("Frame");
    Window:SetTitle((L.WINDOW_HEADER):format(GL.version) .. " - Settings");
    Window:SetLayout("Flow");
    Window:SetWidth(800);
    Window:SetHeight(600);
    Window:EnableResize(false);
    Window.statustext:GetParent():Hide(); -- Hide the statustext bar
    GL.Interface:set(self, "Window", Window);
    Window:SetPoint(GL.Interface:getPosition("Settings"));

    Window:SetCallback("OnClose", function()
        self:close(onCloseCallback);
    end);

    -- Override the default close button behavior
    local CloseButton = GL:fetchCloseButtonFromAceGUIWidget(Window);
    if (CloseButton) then
        CloseButton:SetScript("OnClick", function ()
            self:close(onCloseCallback);
        end);
    end

    -- Make sure the window can be closed by pressing the escape button
    _G["GARGUL_SETTING_WINDOW"] = Window.frame;
    tinsert(UISpecialFrames, "GARGUL_SETTING_WINDOW");

    --[[
        COLUMN SPACER
    ]]
    local ColumnSpacerOne = AceGUI:Create("SimpleGroup");
    ColumnSpacerOne:SetLayout("FILL")
    ColumnSpacerOne:SetWidth(6);
    ColumnSpacerOne:SetHeight(400);
    Window:AddChild(ColumnSpacerOne);

    --[[
        FIRST COLUMN
    ]]
    local FirstColumn = AceGUI:Create("SimpleGroup");
    FirstColumn:SetLayout("FILL")
    FirstColumn:SetWidth(180);
    FirstColumn:SetHeight(1);
    Window:AddChild(FirstColumn);

    self:drawSectionsTable(Window.frame, section);

    --[[
        COLUMN SPACER TWO
    ]]
    local ColumnSpacerTwo = AceGUI:Create("SimpleGroup");
    ColumnSpacerTwo:SetLayout("FILL")
    ColumnSpacerTwo:SetWidth(20);
    ColumnSpacerTwo:SetHeight(400);
    Window:AddChild(ColumnSpacerTwo);

    local SecondColumn = AceGUI:Create("SimpleGroup");
    SecondColumn:SetLayout("FLOW")
    SecondColumn:SetWidth(550);
    GL.Interface:set(self, "SecondColumn", SecondColumn);
    Window:AddChild(SecondColumn);

    local SectionTitle = AceGUI:Create("Label");
    SectionTitle:SetFontObject(_G["GameFontNormalLarge"]);
    SectionTitle:SetFullWidth(true);
    SectionTitle:SetText(" ");
    SecondColumn:AddChild(SectionTitle);

    local ScrollFrameHolder = AceGUI:Create("InlineGroup");
    ScrollFrameHolder:SetLayout("FILL")
    ScrollFrameHolder:SetWidth(556);
    ScrollFrameHolder:SetHeight(480);
    SecondColumn:AddChild(ScrollFrameHolder);

    GL.Interface:set(self, "Window", Window);
    GL.Interface:set(self, "Title", SectionTitle);
    GL.Interface:set(self, "SectionWrapper", ScrollFrameHolder);

    local HorizontalSpacer = GL.AceGUI:Create("SimpleGroup");
    HorizontalSpacer:SetLayout("FILL");
    HorizontalSpacer:SetFullWidth(true);
    HorizontalSpacer:SetHeight(20);
    SecondColumn:AddChild(HorizontalSpacer);

    local ChangelogButton = GL.AceGUI:Create("Button");
    ChangelogButton:SetText("Changelog");
    ChangelogButton:SetCallback("OnClick", function()
        GL.Interface.Changelog:draw();
        self:close(function ()
            self:draw(self.activeSection);
        end);
    end);
    ChangelogButton:SetWidth(120);
    SecondColumn:AddChild(ChangelogButton);

    local ResetUIButton = GL.AceGUI:Create("Button");
    ResetUIButton:SetText(L.RESET_UI);
    ResetUIButton:SetCallback("OnClick", function()
        GL.Interface.Dialogs.PopupDialog:open{
            question = L.RESET_UI_CONFIRMATION,
            OnYes = function ()
                GL.Commands:call("resetui");
            end,
        };
    end);
    ResetUIButton:SetWidth(136);
    SecondColumn:AddChild(ResetUIButton);

    local ResetSettingsButton = GL.AceGUI:Create("Button");
    ResetSettingsButton:SetText(L.RESET_SETTINGS);
    ResetSettingsButton:SetCallback("OnClick", function()
        GL.Interface.Dialogs.PopupDialog:open{
            question = L.RESET_SETTINGS_CONFIRMATION,
            OnYes = function ()
                GL.Commands:call("resetsettings");
            end,
        };
    end);
    ResetSettingsButton:SetWidth(136);
    SecondColumn:AddChild(ResetSettingsButton);

    self:showSection(section);
end

---@return void
function Overview:close(onCloseCallback)
    local Window = GL.Interface:get(self, "Window");

    -- Some sections require additional cleanup, check if that's the case here
    if (self.activeSection
        and type(GL.Interface.Settings[self.activeSection].onClose) == "function"
    ) then
        local result = GL.Interface.Settings[self.activeSection]:onClose();

        if (result == false) then
            return;
        end
    end

    -- The user can pass along a close handler if his own
    -- this allows us to open up a previous window after closing the settings for example
    if (type(onCloseCallback) == "function") then
        onCloseCallback();
    end

    self.isVisible = false;
    self.previousSection = self.activeSection;
    self.activeSection = nil;

    if (Window) then
        GL.Interface:storePosition(Window, "Settings");
        Window:Hide();
        PlaySound(799) -- SOUNDKIT.GS_TITLE_OPTION_EXIT
    end
end

--- Draw the sections table (the left portion of the settings screen)
---
---@param Parent table
---@param section string
---@return void
function Overview:drawSectionsTable(Parent, section)
    GL:debug("Overview:drawSectionsTable");

    local sectionIndex = self.SectionIndexes[section];

    -- The given section wasn't found
    if (not GL:higherThanZero(sectionIndex)) then
        return;
    end

    local columns = {
        {
            name = "",
            width = 145,
            colorargs = nil,
        },
    };

    local Table = ScrollingTable:CreateST(columns, 27, 18, nil, Parent);
    Table:EnableSelection(true);
    Table:SetSelection(sectionIndex);
    Table:SetWidth(145);
    Table.frame:SetPoint("TOPLEFT", Parent, "TOPLEFT", 23, -40);

    Table:RegisterEvents{
        OnClick = function (_, _, _, _, _, realrow)
            -- Make sure something is actually selected, better safe than lua error
            if (not GL:higherThanZero(realrow)) then
                return;
            end

            self:showSection(self.Sections[realrow][2]);
        end
    };

    local TableData = {};
    for _, Entry in pairs(self.Sections) do
        tinsert(TableData, { Entry[1] });
    end

    -- The second argument refers to "isMinimalDataformat"
    -- For the full format see https://www.wowace.com/projects/lib-st/pages/set-data
    Table:SetData(TableData, true);
    GL.Interface:set(self, "Sections", Table);
end

--- Show a specific setting section
---
---@param section string
---@return boolean
function Overview:showSection(section)
    section = string.trim(section or "");
    local sectionIndex = self.SectionIndexes[section];

    if (not GL:higherThanZero(sectionIndex)) then
        return false;
    end

    -- Determine which setting object we should render based on the user's selection
    local SectionEntry = self.Sections[sectionIndex] or {};
    local sectionClassIdentifier = SectionEntry[2];

    -- Make sure the requested section actually exists
    if (not sectionClassIdentifier
        or sectionClassIdentifier == self.activeSection
    ) then
        return false;
    end

    local SectionClass = GL.Interface.Settings[sectionClassIdentifier] or {};

    -- Make sure the provided section has the required "draw" method
    if (type(SectionClass.draw) ~= "function") then
        return false;
    end

    -- Some sections require additional cleanup, check if that's the case here
    if (self.activeSection
        and type(GL.Interface.Settings[self.activeSection].onClose) == "function"
    ) then
        GL.Interface.Settings[self.activeSection]:onClose();
    end

    self.activeSection = sectionClassIdentifier;

    -- Set the Title of the section (shown top-right)
    GL.Interface:get(self, "Label.Title"):SetText(" " .. strtrim(SectionEntry[1]));

    -- Prepare a new ScrollFrame for the section we're about to draw
    local ScrollFrame = GL.Interface:get(self, "ScrollFrame.ScrollFrame") or GL.AceGUI:Create("ScrollFrame");
    local Parent = GL.Interface:get(self, "Frame.SectionWrapper");
    ScrollFrame:SetLayout("Flow");

    -- Clean the ScrollFrame in case it still holds old data
    GL.Interface:releaseChildren(ScrollFrame);

    Parent:AddChild(ScrollFrame);

    -- Store the ScrollFrame so that we can clean/release it later
    GL.Interface:set(self, "ScrollFrame", ScrollFrame);

    -- Add a description to the section if available
    if (not GL:empty(SectionClass.description)) then
        local SectionDescription = GL.AceGUI:Create("Label");
        SectionDescription:SetText(SectionClass.description .. "\n\n");
        SectionDescription:SetFontObject(_G["GameFontNormal"]);
        SectionDescription:SetFullWidth(true);
        ScrollFrame:AddChild(SectionDescription);
    end

    -- Add a link to our wiki when available
    if (not GL:empty(SectionClass.wikiUrl)) then
        local MoreInfoLabel = GL.AceGUI:Create("Label");
        MoreInfoLabel:SetText("\nVisit our Wiki for more info:\n");
        MoreInfoLabel:SetFontObject(_G["GameFontNormal"]);
        MoreInfoLabel:SetFullWidth(true);
        ScrollFrame:AddChild(MoreInfoLabel);

        local WikiUrlBox = GL.AceGUI:Create("EditBox");
        WikiUrlBox:DisableButton(true);
        WikiUrlBox:SetHeight(20);
        WikiUrlBox:SetFullWidth(true);
        WikiUrlBox:SetText(SectionClass.wikiUrl);
        ScrollFrame:AddChild(WikiUrlBox);

        local HorizontalSpacer = GL.AceGUI:Create("SimpleGroup");
        HorizontalSpacer:SetLayout("FILL");
        HorizontalSpacer:SetFullWidth(true);
        HorizontalSpacer:SetHeight(20);
        ScrollFrame:AddChild(HorizontalSpacer);
    end

    SectionClass:draw(ScrollFrame, GL.Interface:get(self, "Window"));

    -- Highlight the correct section in the table on the left
    -- This delay is necessary because of how lib-st handles click and selection events
    GL.Ace:ScheduleTimer(function ()
        local Table = GL.Interface:get(self, "Table.Sections");
        if (Table and Table:GetSelection() ~= sectionIndex) then
            Table:SetSelection(sectionIndex);
        end
    end, .1);

    return true;
end

--- This is a helper method that transforms a table of Checkbox data
--- To one or more checkboxes all directly linked to the correct setting
---
---@param Checkboxes table
---@param Parent table
---@return void
function Overview:drawCheckboxes(Checkboxes, Parent)
    GL:debug("Overview:drawCheckboxes");

    local AceGUI = GL.AceGUI;

    for _, Entry in pairs(Checkboxes) do
        local Checkbox = AceGUI:Create("CheckBox");
        Checkbox:SetValue(GL.Settings:get(Entry.setting));
        Checkbox:SetLabel(Entry.label);
        Checkbox:SetDescription(Entry.description);
        Checkbox:SetFullWidth(true);
        Checkbox.text:SetTextColor(1, .95686, .40784);
        Checkbox:SetCallback("OnValueChanged", function()
            GL.Settings:set(Entry.setting, Checkbox:GetValue());

            if (type(Entry.callback) == "function") then
                Entry.callback(Checkbox);
            end
        end);
        GL.Interface:set(GL.Settings, Entry.setting, Checkbox);
        Parent:AddChild(Checkbox);
    end
end

---@param text string
---@param Parent table
---@return void
function Overview:drawHeader(text, Parent)
    local Header = GL.AceGUI:Create("InlineGroup");
    Header:SetFullWidth(true);
    Header:SetHeight(20);
    Parent:AddChild(Header);

    local HeaderText = GL.AceGUI:Create("Label");
    HeaderText:SetFullWidth(true);
    HeaderText:SetHeight(20);
    HeaderText:SetText(text);
    Header:AddChild(HeaderText);
    Header.Label = HeaderText;

    return Header;
end

--- This is a helper method that draws a spacer
---
---@param Parent table
---@param width number|nil
---@param height number
---@return void
function Overview:drawSpacer(Parent, width, height)
    GL:debug("Overview:drawSpacer");

    local Spacer = GL.AceGUI:Create("SimpleGroup");
    Spacer:SetLayout("Flow");

    if (width) then
        Spacer:SetWidth(width);
    else
        Spacer:SetFullWidth(true);
    end

    Spacer:SetHeight(height);
    Parent:AddChild(Spacer);
end

GL:debug("Interface/Settings/Overview.lua");