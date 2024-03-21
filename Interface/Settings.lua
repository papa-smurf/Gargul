local L = Gargul_L;

---@type GL
local _, GL = ...;

---@type Interface
local Interface = GL.Interface;

--[[ CONSTANTS ]]
local DEFAULT_SECTION = L.SETTINGS_SECTION_GENERAL;
local MENU_ROW_HEIGHT = 22;
local MENU_FONT_SIZE = 1.1;
local SUBJECT_FONT_SIZE = 1.5;
local HEADER_MARGIN_LEFT = 30;
local HEADER_MARGIN_TOP = -40;
local HEADER_PADDING_BOTTOM = 20;
local SUB_SECTION_MARGIN_LEFT = -10;
local SUB_SECTION_MARGIN_TOP = -20;
local SETTING_COLOR = "EDC507";
local SETTING_MARGIN_LEFT = 20;
local SETTING_MARGIN_TOP = -10;

--- Section types
local SUB_SECTION = 0;
local CHECKBOX = 1;
local BUTTON = 2;
local DROPDOWN = 3;
local MINIMAP_HOTKEY_DROPDOWN = 4;
local CUSTOM = 5;
local LABEL = 6;
local INPUT = 7;

local MINIMAP_HOTKEY_ACTIONS = {
    "DISABLED",
    "GARGUL",
    "SOFTRES",
    "GDKP",
    "GDKP_LEDGER",
    "GDKP_CUTS",
    "MULTIAUCTION",
    "IMPORT",
    "EXPORT",
    "AWARDHISTORY",
    "PLUS_ONE",
    "BOOSTED_ROLLS",
};

local SECTION_ORDER = {
    [1] = L.SETTINGS_SECTION_GETTING_STARTED,
    [2] = L.SETTINGS_SECTION_GENERAL,
    [3] = L.SETTINGS_SECTION_SOFTRES,
    [4] = L.SETTINGS_SECTION_TMB,
};
local SECTION_INDEXES = GL:tableFlip(SECTION_ORDER);

GL.Interface.Settings = GL.Interface.Settings or {
    FramePool = {},
    MenuFrames = {},

    windowName = "GL.Interface.Settings",
};
local Settings = GL.Interface.Settings;

---@class SettingsInterface
local SettingEntries = {
    [L.SETTINGS_SECTION_GETTING_STARTED] = {
        {
            ID = "gettingStartedView",
            type = CUSTOM,
            build = function (Parent)
                local SettingFrame = CreateFrame("Frame", nil, Parent);
                SettingFrame:SetWidth(1);
                SettingFrame:SetHeight(1);

                local Intro = Interface:createFontString(SettingFrame, (L.SETTINGS_SECTION_GETTING_STARTED_INTRO):format(
                    GL.Settings:get("ShortcutKeys.rollOffOrAuction"),
                    GL.Settings:get("ShortcutKeys.award")
                ));
                Intro:SetColor(SETTING_COLOR);
                Intro:SetPoint("TOPLEFT", SettingFrame, "TOPLEFT");

                ---@type Frame
                local OpenBonusFeatures = Interface:dynamicPanelButton(SettingFrame, L.SETTINGS_SECTION_GETTING_STARTED_INTRO_BONUS_FEATURES);
                OpenBonusFeatures:SetScript("OnClick", function ()
                    GL.Interface.BonusFeatures:open();
                end);
                OpenBonusFeatures:SetPoint("TOPLEFT", Intro, "BOTTOMLEFT", 0, 5);

                ---[[ PATRONS ]]
                local Colors = {
                    contributors = "FFFFFF",
                    common = Interface.Colors.COMMON,
                    uncommon = Interface.Colors.UNCOMMON,
                    rare = Interface.Colors.RARE,
                    epic = Interface.Colors.EPIC,
                    legendary = Interface.Colors.LEGENDARY,
                };

                local PatronNames = {};
                for _, name in pairs(GL.Data.Constants.Vips.Legendary or {}) do
                    tinsert(PatronNames, ("|c00%s%s|r"):format(Colors.legendary, name));
                end

                for _, name in pairs(GL.Data.Constants.Vips.Epic or {}) do
                    tinsert(PatronNames, ("|c00%s%s|r"):format(Colors.epic, name));
                end

                for _, name in pairs(GL.Data.Constants.Vips.Rare or {}) do
                    tinsert(PatronNames, ("|c00%s%s|r"):format(Colors.rare, name));
                end

                for _, name in pairs(GL.Data.Constants.Vips.Uncommon or {}) do
                    tinsert(PatronNames, ("|c00%s%s|r"):format(Colors.uncommon, name));
                end

                local patronString = "";
                local lastColor = "";
                local first = true;
                for _, patron in pairs (PatronNames) do
                    local color = string.sub(patron, 1, 10);

                    if (not first and color ~= lastColor) then
                        patronString = ("%s%s%s"):format(
                            patronString,
                            "\n\n",
                            patron
                        );
                    elseif (not first) then
                        patronString = ("%s, %s"):format(
                            patronString,
                            patron
                        );
                    else
                        patronString = patron;
                    end

                    first = false;
                    lastColor = color;
                end

                local PatronsTitle = Interface:createFontString(SettingFrame, L.SETTINGS_SECTION_GETTING_STARTED_PATRONS);
                PatronsTitle:SetFont(SUBJECT_FONT_SIZE);
                PatronsTitle:SetPoint("TOPLEFT", OpenBonusFeatures, "BOTTOMLEFT", SUB_SECTION_MARGIN_LEFT, SUB_SECTION_MARGIN_TOP);

                local Patrons = Interface:createFontString(SettingFrame, patronString);
                Patrons:SetPoint("TOPLEFT", PatronsTitle, "BOTTOMLEFT", 10, SETTING_MARGIN_TOP);

                ---@type Frame
                local MoreInfo = Interface:dynamicPanelButton(SettingFrame, L.SETTINGS_SECTION_GETTING_STARTED_MORE_INFO);
                MoreInfo:SetScript("OnClick", function ()
                    GL.Interface.Dialogs.HyperlinkDialog:open{
                        description = L.SETTINGS_SECTION_GETTING_STARTED_MORE_INFO_DIALOG,
                        hyperlink = L.DISCORD_URL,
                    };
                end);
                MoreInfo:SetPoint("TOPLEFT", Patrons, "BOTTOMLEFT", 0, SETTING_MARGIN_TOP * 2);

                return SettingFrame;
            end,
        },
    },
    [L.SETTINGS_SECTION_GENERAL] =
        (function ()
            local Entries = {
                {
                    ID = "openChatLocale",
                    type = BUTTON,
                    action = function () GL.Commands:call("locale"); end,
                },
                {
                    ID = "welcomeMessage",
                    type = CHECKBOX,
                },
                --- WotLK only
                GL.isClassic and {
                    ID = "MasterLooting.linkNormalAndHardModeItems",
                    type = CHECKBOX,
                } or nil,
                {
                    ID = "changeLog",
                    type = CHECKBOX,
                },
                {
                    ID = "showUpdateAlert",
                    type = CHECKBOX,
                },
                {
                    ID = "noSounds",
                    type = CHECKBOX,
                },
                {
                    ID = "soundChannel",
                    type = DROPDOWN,
                    Options = {
                        Master = "Master",
                        Music = "Music",
                        SFX = "SFX",
                        Ambience = "Ambience",
                        Dialog = "Dialog",
                    }
                },
                {
                    ID = L.SETTINGS_SUBSECTION_MINIMAP,
                    type = SUB_SECTION,
                },{
                    ID = "MinimapButton.enabled",
                    type = CHECKBOX,
                    callback = function()
                        GL.MinimapButton:drawOrHide();
                    end,
                },
            };

            local Hotkeys = {
                "CLICK", "RIGHTCLICK", "MIDDLECLICK", "SHIFT_CLICK", "SHIFT_RIGHTCLICK", "SHIFT_MIDDLECLICK",
                "ALT_CLICK", "ALT_RIGHTCLICK", "ALT_MIDDLECLICK", "CTRL_CLICK", "CTRL_RIGHTCLICK", "CTRL_MIDDLECLICK",
                "ALT_SHIFT_CLICK", "ALT_SHIFT_RIGHTCLICK", "ALT_SHIFT_MIDDLECLICK", "CTRL_SHIFT_CLICK",
                "CTRL_SHIFT_RIGHTCLICK", "CTRL_SHIFT_MIDDLECLICK",
            };

            for _, action in pairs(Hotkeys) do
                tinsert(Entries, {
                    ID = "MinimapButton.Actions." .. action,
                    type = MINIMAP_HOTKEY_DROPDOWN,
                });
            end

            return Entries;
        end)()
    ,
    [L.SETTINGS_SECTION_SOFTRES] = {
        {
            ID = "settingsSectionSoftresExplanation",
            type = LABEL,
        },
        {
            ID = "SoftRes.enableTooltips",
            type = CHECKBOX,
        },
        {
            ID = "SoftRes.hideInfoOfPeopleNotInGroup",
            type = CHECKBOX,
        },
        {
            ID = "SoftRes.announceInfoInChat",
            type = CHECKBOX,
        },
        {
            ID = "SoftRes.announceInfoWhenRolling",
            type = CHECKBOX,
        },
        {
            ID = "SoftRes.enableWhisperCommand",
            type = CHECKBOX,
        },
        {
            ID = "SoftRes.fixPlayerNames",
            type = CHECKBOX,
        },
        {
            ID = L.SETTINGS_SUBSECTION_SOFTRES_SUPPORTED_SERVICES,
            type = SUB_SECTION,
        },
        {
            ID = "softResOpen",
            type = BUTTON,
            action = function ()
                GL.Interface.Dialogs.HyperlinkDialog:open{
                    description = L.SETTINGS_OPEN_SOFT_RES_DESCRIPTION,
                    hyperlink = "https://softres.it/",
                };
            end,
        },
        {
            ID = "softResOpenCPR",
            label = L.CLASSICPRIO_ABBR,
            type = BUTTON,
            action = function ()
                GL.Interface.Dialogs.HyperlinkDialog:open{
                    description = L.SETTINGS_OPEN_CPR_DESCRIPTION,
                    hyperlink = "https://classicpr.io/",
                };
            end,
        },
    },
    [L.SETTINGS_SECTION_TMB] = {
        {
            ID = "settingsSectionTMbExplanation",
            type = LABEL,
        },
        {
            ID = "TMB.automaticallyShareData",
            type = CHECKBOX,
        },
        {
            ID = "TMB.shareWhitelist",
            type = INPUT,
            placeholder = ("%s, %s"):format(GL.User.name, L.GARGUL),
        },
    },
};

---@return table|nil
function Settings:open(section)
    FONT = GL.FONT;

    local Window = _G[self.windowName] or self:build();

    self:showSection(section or DEFAULT_SECTION);

    Window:Show();
    return Window;
end

---@return Frame
function Settings:build()
    if (_G[self.windowName]) then
        return _G[self.windowName];
    end

    ---@type Frame
    local Window = Interface:createWindow({
        name = self.windowName,
        width = 700,
        height = 500,
        hideResizeButton = true,
        hideMinimizeButton = true,
    });
    Window:Hide();

    --[[ ADD THE SETTINGS MENU IN THE TOP LEFT OF THE WINDOW ]]
    Interface:addWindowOptions(Window, {
        {text = L.WINDOW, isTitle = true, notCheckable = true },
        {text = L.CHANGE_SCALE, notCheckable = true, func = function ()
            Interface:openScaler(Window);
            CloseMenus();
        end},
    });

    Window.Search = Interface:inputBox(Window, nil, SEARCH);
    Window.Search:SetWidth(250);
    Window.Search:SetPoint("TOPLEFT", Window, "TOPLEFT", 70, -26);

    Window.Logo = Window:CreateTexture(nil, "ARTWORK")
    Window.Logo:SetTexture("Interface/AddOns/Gargul/Assets/Icons/Gargul");
    Window.Logo:SetPoint("TOPLEFT", Window, "TOPLEFT", 20, -20);
    Window.Logo:SetSize(32, 32);

    self:injectSectionsMenu(Window);

    --[[ SCROLLFRAME BOILERPLATE ]]
    ---@type ScrollFrame
    local ScrollFrame = CreateFrame("ScrollFrame", nil, Window, "UIPanelScrollFrameTemplate");
    ScrollFrame:SetPoint("TOPLEFT", Window, "TOPLEFT", 166, -30);
    ScrollFrame:SetPoint("BOTTOMRIGHT", Window, "BOTTOMRIGHT", -40, 30);
    Window.ScrollFrame = ScrollFrame;

    ---@type Frame
    Window.SettingsFrame = CreateFrame("Frame");
    ScrollFrame:SetScrollChild(Window.SettingsFrame);
    Window.SettingsFrame:SetSize(ScrollFrame:GetWidth(), ( ScrollFrame:GetHeight() * 2 ));
    Window.SettingsFrame:SetPoint("TOPLEFT", ScrollFrame, "TOPLEFT");
    Window.SettingsFrame:SetPoint("BOTTOMRIGHT", ScrollFrame, "BOTTOMRIGHT");

    _G[self.windowName] = Window;
    return Window;
end

---@param Parent Frame
---
---@return Frame
function Settings:injectSectionsMenu(Parent)
    for position, section in pairs(SECTION_ORDER) do
        local Item = CreateFrame("Frame", nil, Parent);
        Item:EnableMouse(true);
        Item:SetSize(128, MENU_ROW_HEIGHT);
        Item:SetPoint("TOPLEFT", Parent.Logo, "BOTTOMLEFT", 0, (position * MENU_ROW_HEIGHT) * -1 + 10);

        Item.Highlight = Item:CreateTexture(nil, "BACKGROUND");
        Item.Highlight:SetTexture("interface/buttons/ui-listbox-highlight.blp");
        Item.Highlight:SetAllPoints(Item);
        Item.Highlight:Hide();

        Item.Hover = Item:CreateTexture(nil, "BACKGROUND");
        Item.Hover:SetTexture("interface/buttons/ui-listbox-highlight2.blp");
        Item.Hover:SetAllPoints(Item);
        Item.Hover:Hide();

        Item.text = Interface:createFontString(Item, "  " .. section);
        Item.text:SetFont(MENU_FONT_SIZE, "OUTLINE");
        Item.text:SetPoint("CENTER", Item);
        Item.text:SetPoint("LEFT", Item);

        Item:SetScript("OnMouseUp", function ()
            self:showSection(section);
        end);

        Item:SetScript("OnEnter", function ()
            if (Item.Highlight:IsShown()) then
                return;
            end

            Item.Hover:Show();
        end);

        Item:SetScript("OnLeave", function ()
            if (Item.Highlight:IsShown()) then
                return;
            end

            Item.Hover:Hide();
        end);

        self.MenuFrames[position] = Item;
    end

    return Parent;
end

---@param section string
---@return void
function Settings:showSection(section)
    if (not SettingEntries[section]) then
        return;
    end

    for _, SettingFrame in pairs(self.FramePool or {}) do
        if (SettingFrame:IsVisible()) then
            SettingFrame:Hide();
        end
    end

    local Window = self:build();
    self:disableMenuHighlights();

    local MenuEntry = self.MenuFrames[SECTION_INDEXES[section]];
    MenuEntry.Hover:Hide();
    MenuEntry.Highlight:Show();

    self:injectSettingsForSection(Window.SettingsFrame, section);

    self:resetScroll();
end

---@return void
function Settings:disableMenuHighlights()
    for _, Frame in pairs(self.MenuFrames or {}) do
        Frame.Highlight:Hide();
    end
end

---@param Parent Frame
---
---@return Frame
function Settings:injectSettingsForSection(Parent, section)
    local Entries = SettingEntries[section];

    if (not Entries) then
        return Parent;
    end

    ---[[ Add the header + horizontal ruler ]]

    local SectionFrame = self.FramePool[section];
    if (not SectionFrame) then
        ---@type Frame
        SectionFrame = CreateFrame("Frame", nil, Parent);
        SectionFrame:SetWidth(300);
        SectionFrame:SetHeight(20);

        ---@type FontString
        local SectionHeader = Interface:createFontString(SectionFrame, section);
        SectionHeader:SetFont(1.8, "OUTLINE");
        SectionHeader:SetPoint("TOPLEFT", SectionFrame, "TOPLEFT");

        ---@type Line
        local Line = SectionFrame:CreateLine();
        Line:SetThickness(1);
        Line:SetColorTexture(.9, .9, .9, .5);
        Line:SetStartPoint("TOPLEFT", SectionFrame, 0, -30);
        Line:SetEndPoint("TOPRIGHT", SectionFrame, 20, -30);

        self.FramePool[section] = SectionFrame;
    else
        self.FramePool[section]:Show();
        self.FramePool[section]:ClearAllPoints();
    end

    SectionFrame:SetPoint("TOPLEFT", Parent, "TOPLEFT", HEADER_MARGIN_LEFT, HEADER_MARGIN_TOP);

    ---[[ Add the setting entries ]]

    local Anchor = SectionFrame;
    local first = true
    local xOffset = 0;
    for _, Details in pairs(Entries or {}) do
        if (not self.FramePool[Details.ID]) then
            self.FramePool[Details.ID] = self:buildFrameForSetting(Parent, Details);
        else
            self.FramePool[Details.ID]:Show();
            self.FramePool[Details.ID]:ClearAllPoints();
        end

        if (first) then
            self.FramePool[Details.ID]:SetPoint("TOPLEFT", Anchor, "BOTTOMLEFT", SETTING_MARGIN_LEFT, SETTING_MARGIN_TOP - HEADER_PADDING_BOTTOM);
        elseif (self.FramePool[Details.ID].type == SUB_SECTION) then
            self.FramePool[Details.ID]:SetPoint("TOPLEFT", Anchor, "BOTTOMLEFT", SUB_SECTION_MARGIN_LEFT, SUB_SECTION_MARGIN_TOP);
            xOffset = SUB_SECTION_MARGIN_LEFT * -1;
        else
            self.FramePool[Details.ID]:SetPoint("TOPLEFT", Anchor, "BOTTOMLEFT", xOffset, SETTING_MARGIN_TOP);
            xOffset = 0;
        end

        Anchor = self.FramePool[Details.ID];
        first = false;
    end
end

---@param Parent Frame
---
---@return Frame
function Settings:injectSettingsForSearch(Parent, search)
    local Entries = (function()
        ---@todo: SEARCH FOR SETTINGS
        if (true) then return ; end
    end);

    if (not Entries) then
        return Parent;
    end

    local Anchor = Parent;
    local first = true;
    for _, Details in pairs(Entries or {}) do
        if (not self.FramePool[Details.ID]) then
            self.FramePool[Details.ID] = self:buildFrameForSetting(Parent, Details);
        else
            self.FramePool[Details.ID]:Show();
            self.FramePool[Details.ID]:ClearAllPoints();
        end

        if (first) then
            self.FramePool[Details.ID]:SetPoint("TOPLEFT", Anchor, "TOPLEFT", SETTING_MARGIN_LEFT, SETTING_MARGIN_TOP);
        elseif (self.FramePool[Details.ID].type == SUB_SECTION) then
            self.FramePool[Details.ID]:SetPoint("TOPLEFT", Anchor, "BOTTOMLEFT", 0, SETTING_MARGIN_TOP);
        else
            self.FramePool[Details.ID]:SetPoint("TOPLEFT", Anchor, "BOTTOMLEFT", 0, SETTING_MARGIN_TOP);
        end

        Anchor = self.FramePool[Details.ID];
        first = false;
    end
end

---@param Parent Frame
---@param Details table
---
---@return string
function Settings:buildFrameForSetting(Parent, Details)
    local settingID = Details.ID;

    ---@type Frame
    local SettingFrame;

    if (Details.type == CUSTOM) then
        SettingFrame = Details.build(Parent);

    elseif (Details.type == SUB_SECTION) then
        ---@type FontString
        SettingFrame = Interface:createFontString(Parent, Details.ID);
        SettingFrame:SetFont(SUBJECT_FONT_SIZE, "OUTLINE");
        SettingFrame.type = SUB_SECTION;

    elseif (Details.type == LABEL) then
        ---@type FontString
        SettingFrame = Interface:createFontString(Parent, L[GL:camelToSnake(Details.ID)]);
        SettingFrame:SetColor(SETTING_COLOR);

    elseif (Details.type == INPUT) then
        local label = self:getLabel(settingID);
        local tooltip = self:getDescription(settingID);

        ---@type Frame
        SettingFrame = CreateFrame("Frame", nil, Parent);
        SettingFrame:SetWidth(300);
        SettingFrame:SetHeight(40);

        ---@type FontString
        local InputLabel = Interface:createFontString(SettingFrame, label);
        InputLabel:SetColor(SETTING_COLOR);
        InputLabel:SetPoint("TOPLEFT", SettingFrame, "TOPLEFT");

        local Input = Interface:inputBox(SettingFrame, nil, Details.placeholder);
        Input:SetPoint("TOPLEFT", InputLabel, "BOTTOMLEFT", 2, -2);
        Input:SetWidth(200);

        if (tooltip) then
            Interface:addTooltip(SettingFrame, ("|c00FFFFFF%s|r\n%s"):format(label, tooltip));
            Interface:addTooltip(Input, ("|c00FFFFFF%s|r\n%s"):format(label, tooltip));
        end

    elseif (Details.type == CHECKBOX) then
        local label = self:getLabel(settingID);
        local tooltip = self:getDescription(settingID);

        ---@type Frame
        SettingFrame = Interface:createCheckbox{
            Parent = Parent,
            name = ("GL.Interface.Settings.Wrappers.%s"):format(settingID),
            checked = GL.Settings:get(settingID),
            label = label,
            tooltip = tooltip and ("|c00FFFFFF%s|r\n%s"):format(label, tooltip) or nil,
            callback = function (_, value)
                GL.Settings:set(settingID, value);

                if (Details.callback) then
                    Details.callback();
                end
            end,
        };

        SettingFrame.Label:SetColor(SETTING_COLOR);

        GL.Settings:onChange(settingID, function ()
            SettingFrame:SetChecked(GL.Settings:get(settingID));
        end);

    elseif (Details.type == BUTTON) then
        local label = self:getLabel(settingID);
        local tooltip = self:getDescription(settingID);

        ---@type Frame
        SettingFrame = Interface:dynamicPanelButton(Parent, label);
        SettingFrame:SetWidth(200);
        SettingFrame:SetScript("OnClick", Details.action);

        if (tooltip) then
            Interface:addTooltip(SettingFrame, ("|c00FFFFFF%s|r\n%s"):format(label, tooltip));
        end

    elseif (Details.type == DROPDOWN) then
        local label = self:getLabel(settingID);
        local tooltip = self:getDescription(settingID);

        ---@type Frame
        SettingFrame = CreateFrame("Frame", nil, Parent);
        SettingFrame:SetWidth(300);
        SettingFrame:SetHeight(40);

        ---@type FontString
        local ChannelLabel = Interface:createFontString(SettingFrame, label);
        ChannelLabel:SetColor(SETTING_COLOR);
        ChannelLabel:SetPoint("TOPLEFT", SettingFrame, "TOPLEFT");

        ---@type Frame
        local DropDown = Interface:createDropdown{
            Parent = SettingFrame,
            Options = Details.Options,
            value = GL.Settings:get(settingID),
            callback = function (_, value)
                GL.Settings:set(settingID, value);
            end
        };
        DropDown:SetPoint("TOPLEFT", ChannelLabel, "BOTTOMLEFT", -20, -2);

        if (tooltip) then
            Interface:addTooltip(DropDown, ("|c00FFFFFF%s|r\n%s"):format(label, tooltip));
        end

    elseif (Details.type == MINIMAP_HOTKEY_DROPDOWN) then
        local hotkey = GL:explode(Details.ID, ".")[3];
        local label = L["HOTKEYS_" .. hotkey];

        ---@type Frame
        SettingFrame = CreateFrame("Frame", nil, Parent);
        SettingFrame:SetWidth(300);
        SettingFrame:SetHeight(40);

        ---@type FontString
        local ChannelLabel = Interface:createFontString(SettingFrame, label);
        ChannelLabel:SetColor(SETTING_COLOR);
        ChannelLabel:SetPoint("TOPLEFT", SettingFrame, "TOPLEFT");

        ---@type Frame
        local DropDown = Interface:createDropdown{
            Parent = SettingFrame,
            Options = MINIMAP_HOTKEY_ACTIONS,
            value = GL.Settings:get("MinimapButton.Actions." .. hotkey),
            callback = function (_, value)
                GL.Settings:set("MinimapButton.Actions." .. hotkey, value);
            end
        };
        DropDown:SetPoint("TOPLEFT", ChannelLabel, "BOTTOMLEFT", -20, -2);

        if (tooltip) then
            Interface:addTooltip(DropDown, ("|c00FFFFFF%s|r\n%s"):format(label, tooltip));
        end
    end

    return SettingFrame;
end

---@param settingID string
---
---@return string|nil
function Settings:getLabel(settingID)
    return L["SETTINGS_" .. GL:camelToSnake(settingID) .. "_LABEL"];
end

---@param settingID string
---
---@return string|nil
function Settings:getDescription(settingID)
    return L["SETTINGS_" .. GL:camelToSnake(settingID) .. "_DESCRIPTION"];
end

--- Reset the vertical scroll of the settings frame
---
---@return void
function Settings:resetScroll()
    local Window = _G[self.windowName];
    if (not Window) then
        return;
    end

    return Window.ScrollFrame and Window.ScrollFrame:SetVerticalScroll(0) or nil;
end
