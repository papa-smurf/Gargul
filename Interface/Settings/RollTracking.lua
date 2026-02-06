---@type GL
local _, GL = ...;

local Overview = GL.Interface.Settings.Overview; ---@type SettingsOverview

---@class RollTrackingSettings
GL.Interface.Settings.RollTracking = {
    description = "Gargul can keep track of incoming rolls. By default, Gargul will only track MS and OS rolls (|c00A79EFF/rnd|r or |c00A79EFF/rnd 99|r). The fields below allow you to customize this to your liking. The 'Identifier' is the text shown on the buttons, the 'Priority' field determines how rolls will be sorted in the roll tracking window (priority 1 is the top priority)"
};
local RollTracking = GL.Interface.Settings.RollTracking; ---@type RollTrackingSettings

---@return nil
function RollTracking:draw(Parent, Window)
    GL:debug("RollTrackingSettings:draw");

    local InputElements = {};
    local Checkboxes = {
        {
            label = "Track all rolls",
            description = "By default Gargul only tracks rolls that follow the rules defined below. If you want to track all rolls then enable this option. The range in which a player rolled will be displayed in the roll tracker window",
            setting = "RollTracking.trackAll",
        },
        {
            label = "Sort rolls by SoftRes status",
            setting = "RollTracking.sortBySoftRes",
        },
        {
            label = "Sort rolls by TMB wishlist status",
            setting = "RollTracking.sortByTMBWishlist",
        },
        {
            label = "Sort rolls by TMB/DFT prio status",
            setting = "RollTracking.sortByTMBPrio",
        },
    };

    Overview:drawCheckboxes(Checkboxes, Parent);

    local HorizontalSpacer = GL.AceGUI:Create("SimpleGroup");
    HorizontalSpacer:SetLayout("FILL");
    HorizontalSpacer:SetFullWidth(true);
    HorizontalSpacer:SetHeight(10);
    Parent:AddChild(HorizontalSpacer);

    local SortByPlusOneLabel = GL.AceGUI:Create("Label");
    SortByPlusOneLabel:SetText("Sort by +1");
    SortByPlusOneLabel:SetColor(1, .95686, .40784);
    SortByPlusOneLabel:SetHeight(20);
    SortByPlusOneLabel:SetFullWidth(true);
    Parent:AddChild(SortByPlusOneLabel);

    local DropdownItems = {
        [0] = "No",
        ASC = "Ascending",
        DESC = "Descending",
    };

    local SortByPlusOne = GL.AceGUI:Create("Dropdown");
    SortByPlusOne:SetValue(GL.Settings:get("RollTracking.sortByPlusOne", 2));
    SortByPlusOne:SetList(DropdownItems);
    SortByPlusOne:SetText(DropdownItems[GL.Settings:get("RollTracking.sortByPlusOne", 2)]);
    SortByPlusOne:SetWidth(150);
    SortByPlusOne:SetCallback("OnValueChanged", function()
        GL.Settings:set("RollTracking.sortByPlusOne", SortByPlusOne:GetValue());
    end);
    Parent:AddChild(SortByPlusOne);

    HorizontalSpacer = GL.AceGUI:Create("SimpleGroup");
    HorizontalSpacer:SetLayout("FILL");
    HorizontalSpacer:SetFullWidth(true);
    HorizontalSpacer:SetHeight(20);
    Parent:AddChild(HorizontalSpacer);

    local NumberOfSecondsToCountdown = GL.AceGUI:Create("Slider");
    NumberOfSecondsToCountdown:SetLabel("Accept rolls till how long after a rolloff ends?");
    NumberOfSecondsToCountdown.label:SetTextColor(1, .95686, .40784);
    NumberOfSecondsToCountdown:SetFullWidth(true);
    NumberOfSecondsToCountdown:SetValue(GL.Settings:get("RollTracking.rollOffEndLeeway", 1));
    NumberOfSecondsToCountdown:SetSliderValues(1, 20, 1);
    NumberOfSecondsToCountdown:SetCallback("OnValueChanged", function(Slider)
        local value = math.floor(tonumber(Slider:GetValue()));

        if (value >= 1) then
            GL.Settings:set("RollTracking.rollOffEndLeeway", value);
        end
    end);
    Parent:AddChild(NumberOfSecondsToCountdown);

    local StatusMessageLabel;
    self.onClose = function()
        local TempNewRollSettings = GL.Settings:get("RollTracking.Brackets");

        for i = 1, 10 do
            local identifier = strtrim(InputElements[i].Identifier:GetText());
            local min = tonumber(strtrim(InputElements[i].Min:GetText()));
            local max = tonumber(strtrim(InputElements[i].Max:GetText()));
            local priority = tonumber(strtrim(InputElements[i].SortingPriority:GetText()));
            local concernsOS = InputElements[i].ConcernsOS:GetValue();
            local givesPlusOne = InputElements[i].GivesPlusOne:GetValue();

            if (not GL:empty(identifier)) then
                --- Not all the necessary data is provided
                if (not min
                    or not max
                    or not priority
                ) then
                    local error = string.format("Missing data for identifier '%s'", identifier);
                    StatusMessageLabel:SetText(error);
                    GL:error(error);
                    return false;
                end

                min = math.floor(min);
                max = math.floor(max);
                priority = math.floor(priority);

                --- The user provided invalid data (letters instead of numbers or invalid numerical values)
                if (min < 1
                    or max < min
                    or priority < 1
                ) then
                    local error = string.format("Invalid data for identifier '%s'. Min must be greater than 0, max must be higher than min and priority must be greater than 0", identifier);
                    StatusMessageLabel:SetText(error);
                    GL:error(error);
                    return false;
                end

                TempNewRollSettings[i] = { identifier, min, max, priority, concernsOS, givesPlusOne};
            else
                TempNewRollSettings[i] = nil;
            end
        end

        -- We rebuild the table to make sure it's unassociative again
        local NewRollSettings = {};
        for _, NewSettings in pairs(TempNewRollSettings) do
            tinsert(NewRollSettings, NewSettings);
        end

        -- Store the roll range settings
        GL.Settings:set("RollTracking.Brackets", NewRollSettings);

        -- Remove error messages (if any), since all data is valid
        StatusMessageLabel:SetText("");

        return true;
    end;

    -- Status message frame
    local StatusMessageFrame = GL.AceGUI:Create("SimpleGroup");
    StatusMessageFrame:SetLayout("FILL");
    StatusMessageFrame:SetWidth(500);
    StatusMessageFrame:SetHeight(10);
    Parent:AddChild(StatusMessageFrame);

    local HorizontalSpacer = GL.AceGUI:Create("SimpleGroup");
    HorizontalSpacer:SetLayout("FILL");
    HorizontalSpacer:SetFullWidth(true);
    HorizontalSpacer:SetHeight(12);
    Parent:AddChild(HorizontalSpacer);

    StatusMessageLabel = GL.AceGUI:Create("Label");
    StatusMessageLabel:SetFontObject(_G["GameFontNormal"]);
    StatusMessageLabel:SetFullWidth(true);
    StatusMessageLabel:SetColor(1, 0, 0);
    StatusMessageFrame:AddChild(StatusMessageLabel);

    for i = 1, 10 do
        local RollTrackingSettings = GL.Settings:get("RollTracking.Brackets", {})[i] or {};

        local identifier = RollTrackingSettings[1] or "";
        local min = RollTrackingSettings[2] or "";
        local max = RollTrackingSettings[3] or "";
        local priority = RollTrackingSettings[4] or "";
        local concernsOS = GL:toboolean(RollTrackingSettings[5]);
        local givesPlusOne = GL:toboolean(RollTrackingSettings[6]);

        local Identifier = GL.AceGUI:Create("EditBox");
        Identifier:DisableButton(true);
        Identifier:SetHeight(20);
        Identifier:SetWidth(80);
        Identifier:SetText(identifier);
        Parent:AddChild(Identifier);

        local Min = GL.AceGUI:Create("EditBox");
        Min:DisableButton(true);
        Min:SetHeight(20);
        Min:SetWidth(100);
        Min:SetText(min);
        Parent:AddChild(Min);

        local Max = GL.AceGUI:Create("EditBox");
        Max:DisableButton(true);
        Max:SetHeight(20);
        Max:SetWidth(100);
        Max:SetText(max);
        Parent:AddChild(Max);

        local SortingPriority = GL.AceGUI:Create("EditBox");
        SortingPriority:DisableButton(true);
        SortingPriority:SetHeight(20);
        SortingPriority:SetWidth(100);
        SortingPriority:SetText(priority);
        SortingPriority:SetMaxLetters(2);
        Parent:AddChild(SortingPriority);

        local ConcernsOS = GL.AceGUI:Create("CheckBox");
        ConcernsOS:SetValue(concernsOS);
        ConcernsOS:SetLabel("OS?");
        ConcernsOS:SetWidth(60);
        ConcernsOS:SetHeight(26);
        ConcernsOS.text:SetTextColor(1, .95686, .40784);
        Parent:AddChild(ConcernsOS);

        local GivesPlusOne = GL.AceGUI:Create("CheckBox");
        GivesPlusOne:SetValue(givesPlusOne);
        GivesPlusOne:SetLabel("+1?");
        GivesPlusOne:SetWidth(60);
        GivesPlusOne:SetHeight(26);
        GivesPlusOne.text:SetTextColor(1, .95686, .40784);
        Parent:AddChild(GivesPlusOne);

        InputElements[i] = {
            Identifier = Identifier,
            Min = Min,
            Max = Max,
            SortingPriority = SortingPriority,
            ConcernsOS = ConcernsOS,
            GivesPlusOne = GivesPlusOne,
        };

        if (i == 1) then
            Identifier:SetLabel(string.format(
                "|cff%sIdentifier|r",
                GL:classHexColor("rogue")
            ));

            Min:SetLabel(string.format(
                "|cff%sMinimum roll|r",
                GL:classHexColor("rogue")
            ));

            Max:SetLabel(string.format(
                "|cff%sMaximum roll|r",
                GL:classHexColor("rogue")
            ));

            SortingPriority:SetLabel(string.format(
                "|cff%sPriority (sorting)|r",
                GL:classHexColor("rogue")
            ));
        end

        if (i < 10) then
            HorizontalSpacer = GL.AceGUI:Create("SimpleGroup");
            HorizontalSpacer:SetLayout("FILL");
            HorizontalSpacer:SetFullWidth(true);
            HorizontalSpacer:SetHeight(10);
            Parent:AddChild(HorizontalSpacer);
        end
    end

    HorizontalSpacer = GL.AceGUI:Create("SimpleGroup");
    HorizontalSpacer:SetLayout("FILL");
    HorizontalSpacer:SetFullWidth(true);
    HorizontalSpacer:SetHeight(10);
    Parent:AddChild(HorizontalSpacer);

    local ResetButton = GL.AceGUI:Create("Button");
    ResetButton:SetText("Undo");
    ResetButton:SetCallback("OnClick", function()
        self.onClose = nil;
        GL.Interface.Settings.Overview:close();
        GL.Settings:draw("RollTracking");
        GL.Commands:call("settings");
    end);
    Parent:AddChild(ResetButton);
end

--- Store the button details (will be overwritten by the draw method)
function RollTracking:onClose() end

GL:debug("Interface/Settings/RollTracking.lua");