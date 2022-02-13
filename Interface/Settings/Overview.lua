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
    defaultSection = "General",
    Sections = {
        {"General", "General"},
        {"Master Looting", "MasterLooting"},
        {"    Shortcut Keys", "ShortcutKeys"},
        {"    Dropped Loot", "DroppedLoot"},
        {"    Roll Tracking", "RollTracking"},
        {"    Stacked Roll", "StackedRoll"},
        {"    Awarding Loot", "AwardingLoot"},
        {"PackMule Autoloot", "PackMule"},
        {"    Item Rules", "PackMuleRules"},
        {"    Ignored Items", "PackMuleIgnores"},
        {"Rolling", "Rolling"},
        {"Loot Highlighting", "LootHighlighting"},
        {"SoftRes", "SoftRes"},
        {"TMB", "TMB"},
        {"Exporting Loot", "ExportingLoot"},
        {"Loot trade timers", "LootTradeTimers"},
        {"", ""},
        {"Slash Commands", "SlashCommands"},
    },
    SectionIndexes = false,
};
local Overview = GL.Interface.Settings.Overview; ---@type SettingsOverview

--- Draw a setting section
---
---@param section string|nil
---@return void
function Overview:draw(section)
    GL:debug("Overview:draw");

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
    Window:SetTitle("Gargul v" .. GL.version .. " - Settings");
    Window:SetLayout("Flow");
    Window:SetWidth(800);
    Window:SetHeight(600);
    Window:EnableResize(false);
    Window.statustext:GetParent():Hide(); -- Hide the statustext bar
    Window:SetCallback("OnClose", function()
        self:close();
    end);
    GL.Interface:setItem(self, "Window", Window);
    Window:SetPoint(GL.Interface:getPosition("Settings"));

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
    FirstColumn:SetHeight(505);
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
    GL.Interface:setItem(self, "SecondColumn", SecondColumn);
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

    GL.Interface:setItem(self, "Window", Window);
    GL.Interface:setItem(self, "Title", SectionTitle);
    GL.Interface:setItem(self, "SectionWrapper", ScrollFrameHolder);

    local PatreonButton = GL.UI:createFrame("Button", "PatreonButton" .. GL:uuid(), Window.frame, "UIPanelButtonTemplate");
    PatreonButton:Show();
    PatreonButton:SetSize(170, 43);
    PatreonButton:SetPoint("BOTTOMLEFT", Window.frame, "BOTTOMLEFT", 25, 16);

    local HighlightTexture = PatreonButton:CreateTexture();
    HighlightTexture:SetTexture("Interface\\AddOns\\Gargul\\Assets\\Buttons\\patreon");
    HighlightTexture:SetPoint("CENTER", PatreonButton, "CENTER", 0, 0);
    HighlightTexture:SetSize(170, 43);

    PatreonButton:SetNormalTexture("Interface\\AddOns\\Gargul\\Assets\\Buttons\\patreon");
    PatreonButton:SetHighlightTexture(HighlightTexture);

    PatreonButton:SetScript("OnClick", function(_, button)
        if (button == 'LeftButton') then
            GL.Interface.Dialogs.HyperlinkDialog:open({
                description = "Thanks for considering becoming a Patron of Gargul, your support helps tremendously!",
                hyperlink = "patreon.com/gargul",
            });
        end
    end);

    self:showSection(section);
end

---@return void
function Overview:close()
    local Window = GL.Interface:getItem(self, "Window");

    -- Some sections require additional cleanup, check if that's the case here
    if (self.activeSection
        and type(GL.Interface.Settings[self.activeSection].onClose) == "function"
    ) then
        GL.Interface.Settings[self.activeSection]:onClose();
    end

    self.isVisible = false;
    self.previousSection = self.activeSection;
    self.activeSection = nil;

    if (Window) then
        GL.Interface:storePosition(Window, "Settings");
        Window:Hide();
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

    Table:RegisterEvents({
        OnClick = function (_, _, _, _, _, realrow)
            -- Make sure something is actually selected, better safe than lua error
            if (not GL:higherThanZero(realrow)) then
                return;
            end

            self:showSection(self.Sections[realrow][2]);
        end
    });

    local TableData = {};
    for _, Entry in pairs(self.Sections) do
        tinsert(TableData, { Entry[1] });
    end

    -- The second argument refers to "isMinimalDataformat"
    -- For the full format see https://www.wowace.com/projects/lib-st/pages/set-data
    Table:SetData(TableData, true);
    GL.Interface:setItem(self, "Sections", Table);
end

--- Show a specific setting section
---
---@param section string
---@return boolean
function Overview:showSection(section)
    section = string.trim(section);
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

    GL.Interface:release(self, "ScrollFrame.ScrollFrame");

    self.activeSection = sectionClassIdentifier;

    -- Set the Title of the section (shown top-right)
    GL.Interface:getItem(self, "Label.Title"):SetText(" " .. strtrim(SectionEntry[1]));

    -- Prepare a new ScrollFrame for the section we're about to draw
    local ScrollFrame = GL.AceGUI:Create("ScrollFrame");
    local Parent = GL.Interface:getItem(self, "Frame.SectionWrapper");
    ScrollFrame:SetLayout("Flow");
    Parent:AddChild(ScrollFrame);

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

    SectionClass:draw(ScrollFrame);

    -- Store the ScrollFrame so that we can clean/release it later
    GL.Interface:setItem(self, "ScrollFrame", ScrollFrame);

    -- Highlight the correct section in the table on the left
    -- This delay is necessary because of how lib-st handles click and selection events
    GL.Ace:ScheduleTimer(function ()
        local Table = GL.Interface:getItem(self, "Table.Sections");
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
        GL.Interface:setItem(GL.Settings, Entry.setting, Checkbox);
        Parent:AddChild(Checkbox);
    end
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