local L = Gargul_L;

---@type GL
local _, GL = ...;

local Overview = GL.Interface.Settings.Overview; ---@type SettingsOverview
local LibDD = LibStub:GetLibrary("LibUIDropDownMenu-4.0");

---@class AutoRollRules
---@field description string
---@field _linkTargetEditBox table|nil
---@field _profileDropdown table|nil
---@field _profileBarFrame table|nil
---@field _profileDeleteBtn table|nil
---@field _rulesListRef table|nil
---@field onClose fun(): nil
local AutoRollRules = {
    description = L["Add item rules to automatically roll need, greed or pass when a Gargul roll is announced (does not work with group loot rolls). Rules are stored per item ID. When you win an item, its rule is automatically set to pass. Shift-click items or drag them into the box below."],
    _linkTargetEditBox = nil,
    _profileDropdown = nil,
    _profileBarFrame = nil,
    _profileDeleteBtn = nil,
    _rulesListRef = nil,

    ---@return nil
    onClose = function ()
        GL.Interface.Settings.AutoRollRules._linkTargetEditBox = nil;
        GL.Interface.Settings.AutoRollRules._profileDropdown = nil;
        GL.Interface.Settings.AutoRollRules._profileBarFrame = nil;
        GL.Interface.Settings.AutoRollRules._profileDeleteBtn = nil;
        GL.Interface.Settings.AutoRollRules._rulesListRef = nil;
    end,
};
GL.Interface.Settings.AutoRollRules = AutoRollRules;

local PROFILE_ICON_PATH = "Interface/AddOns/Gargul/Assets/Buttons/";

-- Hook HandleModifiedItemClick so shift-click works when Auto Roll Rules item box is the target.
-- ChatEdit_InsertLink is only called when chat is "active"; HandleModifiedItemClick is called for all bag shift-clicks.
do
    local orig = HandleModifiedItemClick;
    function HandleModifiedItemClick(link, ...)
        if (IsModifiedClick("CHATLINK") and link and type(link) == "string" and #link > 0) then
            local editbox = AutoRollRules._linkTargetEditBox;
            if (editbox) then
                editbox:SetText((editbox:GetText() or "") .. link);
                return true;
            end
        end
        return orig(link, ...);
    end
end

---@param RulesList table|nil
---@return nil
function AutoRollRules:refreshProfileUI(RulesList)
    self._rulesListRef = RulesList;
    local dropdown = self._profileDropdown;
    if (not dropdown) then
        return;
    end

    local activeID = GL.Profiles:getActiveProfileID(GL.Profiles.NAMESPACE_AUTOROLL);
    local profiles = GL.Profiles:getProfiles(GL.Profiles.NAMESPACE_AUTOROLL);
    local activeProfile = activeID and profiles[activeID];
    local displayName = activeProfile and activeProfile.name or L["No profile"];

    LibDD:UIDropDownMenu_SetSelectedValue(dropdown, activeID);
    LibDD:UIDropDownMenu_SetText(dropdown, displayName);

    local deleteBtn = self._profileDeleteBtn;
    if (deleteBtn) then
        local isDefault = activeProfile and GL:iEquals(activeProfile.name, L["Default"]);
        deleteBtn:SetEnabled(not isDefault);
    end
end

---@param Parent table AceGUI ScrollFrame
---@return Frame
function AutoRollRules:drawProfileBar(Parent)
    local Profiles = GL.Profiles;
    local barHeight = 32;
    local btnSize = 22;
    local btnSpacing = 2;

    -- Ensure at least one profile exists
    local profiles = Profiles:getProfiles(GL.Profiles.NAMESPACE_AUTOROLL);
    if (GL:empty(profiles)) then
        Profiles:createProfile(GL.Profiles.NAMESPACE_AUTOROLL, L["Default"], {});
        profiles = Profiles:getProfiles(GL.Profiles.NAMESPACE_AUTOROLL);
    end

    local ProfileBar = GL.AceGUI:Create("SimpleGroup");
    ProfileBar:SetLayout("Flow");
    ProfileBar:SetFullWidth(true);
    ProfileBar:SetHeight(barHeight);
    Parent:AddChild(ProfileBar);

    local barFrame = ProfileBar.frame;
    if (not barFrame) then
        return barFrame;
    end

    -- Profile label
    local profileLabel = barFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal");
    profileLabel:SetText(L["Profile: "]);
    profileLabel:SetTextColor(1, .95686, .40784);
    profileLabel:SetPoint("LEFT", barFrame, "LEFT", 0, 0);

    -- Profile dropdown
    local dropdownName = "GargulAutoRollProfileDropdown" .. GL:uuid();
    local DropDown = LibDD:Create_UIDropDownMenu(dropdownName, barFrame);
    DropDown:SetPoint("LEFT", profileLabel, "RIGHT", 4, 0);
    LibDD:UIDropDownMenu_SetWidth(DropDown, 180);
    LibDD:UIDropDownMenu_JustifyText(DropDown, "LEFT");
    LibDD:UIDropDownMenu_Initialize(DropDown, function (_, level)
        if (level ~= 1) then
            return;
        end

        local profiles = Profiles:getProfiles(GL.Profiles.NAMESPACE_AUTOROLL);
        local sorted = {};
        for profileID, profile in pairs(profiles) do
            tinsert(sorted, { id = profileID, name = profile.name });
        end
        table.sort(sorted, function (a, b) return strlower(a.name) < strlower(b.name); end);

        for _, entry in ipairs(sorted) do
            local profileID = entry.id;
            local profile = profiles[profileID];
            local info = LibDD:UIDropDownMenu_CreateInfo();
            info.text = profile.name;
            info.value = profileID;
            info.func = function (button)
                local value = button.value;
                Profiles:setActiveProfile(GL.Profiles.NAMESPACE_AUTOROLL, value);
                LibDD:UIDropDownMenu_SetSelectedValue(DropDown, value);
                local p = Profiles:getProfile(GL.Profiles.NAMESPACE_AUTOROLL, value);
                LibDD:UIDropDownMenu_SetText(DropDown, p and p.name or L["No profile"]);
                self:refreshProfileUI(self._rulesListRef);
                self:refreshRulesList(self._rulesListRef);
            end;
            LibDD:UIDropDownMenu_AddButton(info, level);
        end
    end);

    local activeID = Profiles:getActiveProfileID(GL.Profiles.NAMESPACE_AUTOROLL);
    LibDD:UIDropDownMenu_SetSelectedValue(DropDown, activeID);
    local activeProfile = activeID and profiles[activeID];
    LibDD:UIDropDownMenu_SetText(DropDown, activeProfile and activeProfile.name or L["No profile"]);

    self._profileDropdown = DropDown;
    self._profileBarFrame = barFrame;

    -- Icon buttons container (right of dropdown)
    local buttonsFrame = CreateFrame("Frame", nil, barFrame);
    buttonsFrame:SetSize(btnSize * 4 + btnSpacing * 3, btnSize);
    buttonsFrame:SetPoint("LEFT", DropDown, "RIGHT", 8, 2);

    local function createIconButton(name, icon, tooltip, onClick)
        local btn = CreateFrame("Button", name .. GL:uuid(), buttonsFrame, "UIPanelButtonTemplate");
        btn:SetSize(btnSize, btnSize);
        btn:SetNormalTexture(PROFILE_ICON_PATH .. icon);
        local disabled = PROFILE_ICON_PATH .. icon:gsub("%.tga", "-disabled.tga");
        btn:SetDisabledTexture(disabled);
        btn:SetScript("OnClick", onClick);
        btn:SetScript("OnEnter", function ()
            GameTooltip:SetOwner(btn, "ANCHOR_RIGHT");
            GameTooltip:SetText(tooltip);
            GameTooltip:Show();
        end);
        btn:SetScript("OnLeave", function ()
            GameTooltip:Hide();
        end);
        return btn;
    end

    local xOffset = 0;
    local createBtn = createIconButton("CreateProfile", "create.tga", L["Create profile"], function ()
        GL.Interface.Dialogs.ConfirmWithSingleInputDialog:open({
            question = L["Profile name"],
            inputValue = "",
            OnYes = function (name)
                if (GL:empty(strtrim(name or ""))) then
                    return;
                end
                local newID = Profiles:createProfile(GL.Profiles.NAMESPACE_AUTOROLL, strtrim(name), {});
                if (not newID) then
                    GL:warning(L["A profile with that name already exists."]);
                    return;
                end
                LibDD:UIDropDownMenu_SetSelectedValue(DropDown, newID);
                self:refreshProfileUI(self._rulesListRef);
                self:refreshRulesList(self._rulesListRef);
                LibDD:UIDropDownMenu_Refresh(DropDown);
                LibDD:UIDropDownMenu_SetText(DropDown, strtrim(name));
            end,
        });
    end);
    createBtn:SetPoint("LEFT", buttonsFrame, "LEFT", xOffset, 0);
    xOffset = xOffset + btnSize + btnSpacing;

    local copyBtn = createIconButton("CopyProfile", "share.tga", L["Copy profile"], function ()
        local active = Profiles:getActiveProfile(GL.Profiles.NAMESPACE_AUTOROLL);
        if (not active) then
            return;
        end
        GL.Interface.Dialogs.ConfirmWithSingleInputDialog:open({
            question = L["Copy profile"],
            inputValue = active.name .. " " .. L["(copy)"],
            OnYes = function (name)
                if (GL:empty(strtrim(name or ""))) then
                    return;
                end
                local newID = Profiles:copyProfile(GL.Profiles.NAMESPACE_AUTOROLL, Profiles:getActiveProfileID(GL.Profiles.NAMESPACE_AUTOROLL), strtrim(name));
                if (not newID) then
                    GL:warning(L["A profile with that name already exists."]);
                    return;
                end
                LibDD:UIDropDownMenu_SetSelectedValue(DropDown, newID);
                self:refreshProfileUI(self._rulesListRef);
                self:refreshRulesList(self._rulesListRef);
                LibDD:UIDropDownMenu_Refresh(DropDown);
                LibDD:UIDropDownMenu_SetText(DropDown, strtrim(name));
            end,
        });
    end);
    copyBtn:SetPoint("LEFT", buttonsFrame, "LEFT", xOffset, 0);
    xOffset = xOffset + btnSize + btnSpacing;

    local renameBtn = createIconButton("RenameProfile", "edit.tga", L["Rename profile"], function ()
        local activeID = Profiles:getActiveProfileID(GL.Profiles.NAMESPACE_AUTOROLL);
        local active = Profiles:getActiveProfile(GL.Profiles.NAMESPACE_AUTOROLL);
        if (not activeID or not active) then
            return;
        end
        GL.Interface.Dialogs.ConfirmWithSingleInputDialog:open({
            question = L["Rename profile"],
            inputValue = active.name,
            OnYes = function (name)
                if (GL:empty(strtrim(name or ""))) then
                    return;
                end
                local newName = strtrim(name);
                if (not Profiles:renameProfile(GL.Profiles.NAMESPACE_AUTOROLL, activeID, newName)) then
                    GL:warning(L["A profile with that name already exists."]);
                    return;
                end
                self:refreshProfileUI(self._rulesListRef);
                LibDD:UIDropDownMenu_Refresh(DropDown);
                LibDD:UIDropDownMenu_SetText(DropDown, newName);
            end,
        });
    end);
    renameBtn:SetPoint("LEFT", buttonsFrame, "LEFT", xOffset, 0);
    xOffset = xOffset + btnSize + btnSpacing;

    local deleteBtn = createIconButton("DeleteProfile", "delete.tga", L["Delete profile"], function ()
        local activeID = Profiles:getActiveProfileID(GL.Profiles.NAMESPACE_AUTOROLL);
        local active = Profiles:getActiveProfile(GL.Profiles.NAMESPACE_AUTOROLL);
        if (not activeID or not active or GL:iEquals(active.name, L["Default"])) then
            return;
        end
        GL.Interface.Dialogs.PopupDialog:open({
            question = (L["Delete profile \"%s\"?"]):format(active.name),
            OnYes = function ()
                Profiles:deleteProfile(GL.Profiles.NAMESPACE_AUTOROLL, activeID);
                self:refreshProfileUI(self._rulesListRef);
                self:refreshRulesList(self._rulesListRef);
                LibDD:UIDropDownMenu_Refresh(DropDown);
            end,
        });
    end);
    deleteBtn:SetPoint("LEFT", buttonsFrame, "LEFT", xOffset, 0);
    self._profileDeleteBtn = deleteBtn;
    self:refreshProfileUI(self._rulesListRef);

    return barFrame;
end

local function addVerticalSpacer(Parent, height)
    local Spacer = GL.AceGUI:Create("SimpleGroup");
    Spacer:SetLayout("FILL");
    Spacer:SetFullWidth(true);
    Spacer:SetHeight(height);
    Parent:AddChild(Spacer);
end

--- Draw content that appears above the section description (e.g. enable checkbox, profile bar)
---
---@param Parent table AceGUI ScrollFrame
---@return nil
function AutoRollRules:drawPreContent(Parent)
    addVerticalSpacer(Parent, 8);
    local Checkboxes = {
        {
            label = L["Enable Auto Roll"],
            setting = "AutoRoll.enabled",
        },
    };
    Overview:drawCheckboxes(Checkboxes, Parent);
    addVerticalSpacer(Parent, 12);
    self:drawProfileBar(Parent);
    addVerticalSpacer(Parent, 26);
end

---@return nil
function AutoRollRules:draw(Parent)
    -- Margin between description (window information text) and add-rule row
    addVerticalSpacer(Parent, 12);

    local RulesList; -- Declare before Add button so its callback captures it

    local AddRuleRow = GL.AceGUI:Create("SimpleGroup");
    AddRuleRow:SetLayout("Flow");
    AddRuleRow:SetFullWidth(true);
    AddRuleRow.noAutoHeight = true;
    AddRuleRow:SetHeight(44);
    Parent:AddChild(AddRuleRow);

    local ItemBox = GL.AceGUI:Create("EditBox");
    ItemBox:DisableButton(true);
    ItemBox:SetWidth(200);
    ItemBox:SetLabel(L["Item link or ID"]);
    ItemBox.alignoffset = 26; -- Match Dropdown for vertical alignment
    ItemBox.label:SetTextColor(1, .95686, .40784);
    -- Force height when frame is shown (SetLabel/SetHeight get overwritten by AceGUI internals)
    ItemBox.frame:SetScript("OnShow", function ()
        ItemBox.frame:SetHeight(40);
        ItemBox.frame.height = 40;
        ItemBox.editbox:SetHeight(24);
    end);
    -- AceGUI EditBox has no OnFocusGained callback; set link target when section is drawn (cleared on onClose)
    self._linkTargetEditBox = ItemBox.editbox;
    AddRuleRow:AddChild(ItemBox);

    local ActionDropdown = GL.AceGUI:Create("Dropdown");
    ActionDropdown:SetLabel(L["Action"]);
    ActionDropdown.label:SetTextColor(1, .95686, .40784);
    ActionDropdown:SetWidth(120);
    ActionDropdown:SetList({
        need = L["Need"],
        greed = L["Greed"],
        pass = L["Pass"],
    });
    ActionDropdown:SetValue("need");
    ActionDropdown:SetText(L["Need"]);
    AddRuleRow:AddChild(ActionDropdown);

    local DropdownButtonSpacer = GL.AceGUI:Create("Label");
    DropdownButtonSpacer:SetText("");
    DropdownButtonSpacer:SetWidth(4);
    DropdownButtonSpacer.alignoffset = 26; -- Match dropdown so AddButton offset is relative to it
    AddRuleRow:AddChild(DropdownButtonSpacer);

    local AddButton = GL.AceGUI:Create("Button");
    AddButton:SetText(L["Add"]);
    AddButton:SetHeight(27);
    AddButton.alignoffset = 12; -- Required for vertical alignment with dropdown (AceGUI Button has no alignoffset by default)
    AddButton:SetWidth(80);
    AddButton:SetCallback("OnClick", function ()
        local input = strtrim(ItemBox:GetText());
        if (GL:empty(input)) then
            return;
        end

        local itemID = tonumber(input) or GL:getItemIDFromLink(input);
        if (not itemID or itemID < 1) then
            GL:warning(L["Invalid item link or ID"]);
            return;
        end

        if (not GL.GetItemInfoInstant(itemID)) then
            GL:warning(L["Invalid item link or ID"]);
            return;
        end

        local action = ActionDropdown:GetValue();
        GL.AutoRoll:setRule(itemID, action);
        ItemBox:SetText("");
        self:refreshRulesList(RulesList);
    end);
    AddRuleRow:AddChild(AddButton);

    Overview:drawSpacer(Parent, 20, 1);

    RulesList = GL.AceGUI:Create("ScrollFrame");
    RulesList:SetLayout("List");
    RulesList:SetFullWidth(true);
    RulesList:SetHeight(250);

    local RulesHeaderRow = GL.AceGUI:Create("SimpleGroup");
    RulesHeaderRow:SetLayout("Table");
    RulesHeaderRow:SetUserData("table", { columns = { 250, 80, 90 }, alignV = "middle" });
    RulesHeaderRow:SetFullWidth(true);
    RulesHeaderRow:SetHeight(28);
    Parent:AddChild(RulesHeaderRow);

    local RulesLabel = GL.AceGUI:Create("Label");
    RulesLabel:SetText(L["Your rules"]);
    RulesLabel:SetColor(1, .95686, .40784);
    RulesLabel:SetHeight(20);
    RulesLabel:SetWidth(250);
    RulesHeaderRow:AddChild(RulesLabel);

    local headerSpacer = GL.AceGUI:Create("Label");
    headerSpacer:SetText("");
    headerSpacer:SetWidth(80);
    headerSpacer:SetHeight(20);
    RulesHeaderRow:AddChild(headerSpacer);

    local clearAllBtn = GL.AceGUI:Create("Button");
    clearAllBtn:SetText(L["Clear all"]);
    clearAllBtn:SetWidth(90);
    clearAllBtn:SetCallback("OnClick", function ()
        GL.Interface.Dialogs.PopupDialog:open({
            question = L["Remove all rules from this profile?"],
            OnYes = function ()
                GL.Profiles:setProfileData(GL.Profiles.NAMESPACE_AUTOROLL, {});
                self:refreshRulesList(self._rulesListRef);
            end,
        });
    end);
    RulesHeaderRow:AddChild(clearAllBtn);
    GL.Interface:addTooltip(clearAllBtn, L["Remove all rules from this profile"]);

    addVerticalSpacer(Parent, 9);

    Parent:AddChild(RulesList);

    self:refreshRulesList(RulesList);
    self:refreshProfileUI(RulesList);
end

---@param RulesList table
---@return nil
function AutoRollRules:refreshRulesList(RulesList)
    if (not RulesList) then
        return;
    end
    RulesList:ReleaseChildren();

    local rules = GL.AutoRoll:getAllRules();
    if (GL:empty(rules)) then
        local EmptyLabel = GL.AceGUI:Create("Label");
        EmptyLabel:SetText(L["No rules yet. Add an item link and choose need, greed or pass."]);
        EmptyLabel:SetFullWidth(true);
        RulesList:AddChild(EmptyLabel);
        self:refreshProfileUI(RulesList);
        return;
    end

    local itemIDs = {};
    for itemID in pairs(rules) do
        tinsert(itemIDs, tonumber(itemID) or itemID);
    end

    GL:onItemLoadDo(itemIDs, function (Details)
        if (not RulesList) then
            return;
        end
        RulesList:ReleaseChildren();

        local detailsByID = {};
        if (type(Details) == "table") then
            if (Details.id) then
                detailsByID[Details.id] = Details;
            else
                for _, d in pairs(Details) do
                    if (d and d.id) then
                        detailsByID[d.id] = d;
                    end
                end
            end
        end

        local shownIDs = {};
        for itemID, action in pairs(rules) do
            local ruleItemID = tonumber(itemID) or itemID;
            -- SavedVariables can store numeric keys as strings; show one row per item ID
            if (shownIDs[ruleItemID]) then
                -- skip duplicate
            else
                shownIDs[ruleItemID] = true;
                local idForRemove = ruleItemID;
                local itemDetails = detailsByID[ruleItemID] or detailsByID[itemID];
                local itemLink = itemDetails and itemDetails.link or select(2, GL.GetItemInfo(ruleItemID)) or ("[%d]"):format(ruleItemID);
                if (type(itemLink) ~= "string" or GL:empty(itemLink)) then
                    itemLink = ("[%d]"):format(ruleItemID);
                end

                local tooltipLink = itemDetails and itemDetails.link or select(2, GL.GetItemInfo(ruleItemID)) or ("|Hitem:%d:0:0:0:0:0:0:0:0|h[%d]|h"):format(ruleItemID, ruleItemID);

                -- Explicit capture per row to avoid closure capturing wrong item when switching profiles
                local linkForTooltip = tooltipLink;

                local Row = GL.AceGUI:Create("SimpleGroup");
                Row:SetLayout("Table");
                Row:SetUserData("table", { columns = { 250, 80, 90 }, alignV = "middle" });
                Row:SetFullWidth(true);
                Row:SetHeight(28);
                RulesList:AddChild(Row);

                local ItemLabel = GL.AceGUI:Create("Label");
                ItemLabel:SetText(itemLink);
                ItemLabel:SetWidth(250);
                ItemLabel:SetHeight(20);
                GL.Interface:addItemTooltipToCursor(ItemLabel, linkForTooltip);
                Row:AddChild(ItemLabel);

                local ActionLabel = GL.AceGUI:Create("Label");
                ActionLabel:SetText(action == "need" and L["Need"] or action == "greed" and L["Greed"] or L["Pass"]);
                ActionLabel:SetWidth(80);
                ActionLabel:SetHeight(20);
                -- Prevent stray item tooltips when hovering over action (e.g. from text overflow or frame overlap)
                if (ActionLabel.frame) then
                    ActionLabel.frame:SetScript("OnEnter", function ()
                        GameTooltip:Hide();
                    end);
                end
                Row:AddChild(ActionLabel);

                local RemoveButton = GL.AceGUI:Create("Button");
                RemoveButton:SetText(L["Remove"]);
                RemoveButton:SetWidth(90);
                RemoveButton:SetCallback("OnClick", function ()
                    GL.AutoRoll:removeRule(idForRemove);
                    self:refreshRulesList(RulesList);
                end);
                Row:AddChild(RemoveButton);
            end
        end

        if (RulesList.DoLayout) then
            RulesList:DoLayout();
        end
        self:refreshProfileUI(RulesList);
    end);
end
