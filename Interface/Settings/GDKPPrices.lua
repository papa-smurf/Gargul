---@type GL
local _, GL = ...;

---@type SettingsOverview
local Overview = GL.Interface.Settings.Overview;

---@type Settings
local Settings = GL.Settings;

---@class GDKPPricesSettings
GL.Interface.Settings.GDKPPrices = {
    ItemLevelElements = {},
};

---@type GDKPPricesSettings
local GDKPPrices = GL.Interface.Settings.GDKPPrices;

---@param Parent Frame
---
---@return nil
function GDKPPrices:draw(Parent)
    local Spacer;

    local ImportPerItemSettings = GL.AceGUI:Create("Button");
    ImportPerItemSettings:SetText("Import item prices and increments");
    ImportPerItemSettings:SetFullWidth(true);
    ImportPerItemSettings:SetCallback("OnClick", function ()
        GL.Interface.GDKP.ImportPrices:open();
    end);
    Parent:AddChild(ImportPerItemSettings);

    local SettingPrioExplanation = GL.AceGUI:Create("Label");
    SettingPrioExplanation:SetText([[

An item's price and increment are determined in the following order:
1: Item specific (if remember minimum bid/increment setting below is enabled)
2: Item level specific settings
3: Default minimum bid and increment

]]);
    SettingPrioExplanation:SetFullWidth(true);
    Parent:AddChild(SettingPrioExplanation);

    Overview:drawCheckboxes({
        {
            label = "Remember minimum bid and increment for each item",
            description = "If enabled, minimum and increment are remembered for each item. If not, the last minimum/increment you used will remain in place",
            setting = "GDKP.storeMinimumAndIncrementPerItem",
        },
    }, Parent);

    Spacer = GL.AceGUI:Create("SimpleGroup");
    Spacer:SetLayout("FILL");
    Spacer:SetFullWidth(true);
    Spacer:SetHeight(20);
    Parent:AddChild(Spacer);

    local DefaultMinimumBidLabel = GL.AceGUI:Create("Label");
    DefaultMinimumBidLabel:SetText("|c00FFF569Set a default minimum bid|r");
    DefaultMinimumBidLabel:SetFullWidth(true);
    Parent:AddChild(DefaultMinimumBidLabel);

    local DefaultMinimumBid = GL.AceGUI:Create("EditBox");
    DefaultMinimumBid:DisableButton(true);
    DefaultMinimumBid:SetHeight(20);
    DefaultMinimumBid:SetFullWidth(true);
    DefaultMinimumBid:SetText(GL.Settings:get("GDKP.defaultMinimumBid"));
    DefaultMinimumBid:SetCallback("OnTextChanged", function (self)
        local value = self:GetText();

        if (type(value) ~= "string"
            or GL:empty(value)
        ) then
            return;
        end

        value = tonumber(value);

        if (not value or value < 1) then
            return;
        end

        GL.Settings:set("GDKP.defaultMinimumBid", value);
    end);
    Parent:AddChild(DefaultMinimumBid);

    local DefaultIncrementLabel = GL.AceGUI:Create("Label");
    DefaultIncrementLabel:SetText("|c00FFF569Set a default increment|r");
    DefaultIncrementLabel:SetFullWidth(true);
    Parent:AddChild(DefaultIncrementLabel);

    local DefaultIncrement = GL.AceGUI:Create("EditBox");
    DefaultIncrement:DisableButton(true);
    DefaultIncrement:SetHeight(20);
    DefaultIncrement:SetFullWidth(true);
    DefaultIncrement:SetText(GL.Settings:get("GDKP.defaultIncrement"));
    DefaultIncrement:SetCallback("OnTextChanged", function (self)
        local value = self:GetText();

        if (type(value) ~= "string"
                or GL:empty(value)
        ) then
            return;
        end

        value = tonumber(value);

        if (not value or value < 1) then
            return;
        end

        GL.Settings:set("GDKP.defaultIncrement", value);
    end);
    Parent:AddChild(DefaultIncrement);

    Spacer = GL.AceGUI:Create("SimpleGroup");
    Spacer:SetLayout("FILL");
    Spacer:SetFullWidth(true);
    Spacer:SetHeight(20);
    Parent:AddChild(Spacer);

    local ItemLevelExplanation = GL.AceGUI:Create("Label");
    ItemLevelExplanation:SetText("Set a minimum price and increment per item level. Example: 252 -> 5000 -> 500");
    ItemLevelExplanation:SetFullWidth(true);
    Parent:AddChild(ItemLevelExplanation);

    local ItemLevelSettings = GL:tableValues(Settings:get("GDKP.ItemLevelDetails", {}));
    table.sort(ItemLevelSettings, function (a, b)
        return a.level < b.level;
    end);

    local numberOfItemLevelLines = 20;
    for i = 1, numberOfItemLevelLines do
        local Details = ItemLevelSettings[i] or {};

        local Level = GL.AceGUI:Create("EditBox");
        Level:DisableButton(true);
        Level:SetHeight(20);
        Level:SetWidth(100);
        Level:SetText(Details.level or "");
        Parent:AddChild(Level);

        local Minimum = GL.AceGUI:Create("EditBox");
        Minimum:DisableButton(true);
        Minimum:SetHeight(20);
        Minimum:SetWidth(100);
        Minimum:SetText(Details.minimum or "");
        Parent:AddChild(Minimum);

        local Increment = GL.AceGUI:Create("EditBox");
        Increment:DisableButton(true);
        Increment:SetHeight(20);
        Increment:SetWidth(100);
        Increment:SetText(Details.increment or "");
        Parent:AddChild(Increment);

        self.ItemLevelElements[i] = {
            Level = Level,
            Minimum = Minimum,
            Increment = Increment,
        };

        if (i == 1) then
            Level:SetLabel("|cffFFF569Level|r");
            Minimum:SetLabel("|cffFFF569Minimum|r");
            Increment:SetLabel("|cffFFF569Increment|r");
        end

        if (i < numberOfItemLevelLines) then
            Spacer = GL.AceGUI:Create("SimpleGroup");
            Spacer:SetLayout("FILL");
            Spacer:SetFullWidth(true);
            Spacer:SetHeight(10);
            Parent:AddChild(Spacer);
        end
    end
end

---@return nil
function GDKPPrices:onClose()
    GL.Settings:set("GDKP.ItemLevelDetails", {});

    for _, Details in pairs(self.ItemLevelElements or {}) do
        (function ()
            local level = tonumber(strtrim(Details.Level:GetText())) or 0;
            if (level < 1) then
                return;
            end

            local minimum = tonumber(strtrim(Details.Minimum:GetText())) or 0;
            if (minimum < 0) then
                return;
            end

            local increment = tonumber(strtrim(Details.Increment:GetText())) or 0;
            if (increment < 1) then
                return;
            end

            GL.Settings:set(("GDKP.ItemLevelDetails.%s"):format(level), {
                increment = increment,
                level = level,
                minimum = minimum,
            });
        end)();
    end
end
