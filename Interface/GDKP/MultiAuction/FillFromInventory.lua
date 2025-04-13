local L = Gargul_L;

---@type GL
local _, GL = ...;

---@type Settings
local Settings = GL.Settings;

---@type Interface
local Interface = GL.Interface;

---@type GDKPMultiAuctionAuctioneerInterface
local Auctioneer = GL.GDKP.MultiAuction.Auctioneer;

---@class GDKPMultiAuctionFillFromInventoryInterface
GL:tableSet(GL, "Interface.GDKP.MultiAuction.FillFromInventory", {
    windowName = "Gargul.Interface.GDKP.MultiAuction.FillFromInventory.Window",

    ItemRows = {},
});

---@type GDKPMultiAuctionFillFromInventoryInterface
local FillFromInventory = GL.Interface.GDKP.MultiAuction.FillFromInventory;

--[[ CONSTANTS ]]
local FONT;

---@return Frame|nil
function FillFromInventory:open()
    if (self:isShown()) then
        return;
    end

    FONT = GL.FONT;

    local Window = self:getWindow() or self:build();

    return Window:Show() and Window;
end

---@return void
function FillFromInventory:close()
    local Window = self:getWindow() or self:build();

    Window:Hide();
end

---@return boolean
function FillFromInventory:isShown()
    local Window = self:getWindow();

    return Window and Window:IsShown();
end

---@return Frame
function FillFromInventory:build()
    if (_G[self.windowName]) then
        return _G[self.windowName];
    end

    ---@type Frame
    local Window = Interface:createWindow{
        name = self.windowName,
        width = 260,
        minWidth = 260,
        height = 275,
        minHeight = 275,
        hideMinimizeButton = true,
    };

    --[[ THE SETTINGS MENU IN THE TOP LEFT OF THE WINDOW ]]
    Interface:addWindowOptions(Window, {
        { text = L["Adjust Scale"], notCheckable = true, func = function ()
            Interface:openScaler(Window);
            CloseMenus();
        end }
    }, 100);

    --[[ CHANNEL ]]
    ---@type FontString
    local MinimumQualityLabel = Interface:createFontString(Window, L["Minimum Quality"]);
    MinimumQualityLabel:SetPoint("TOP", Window, "TOP", 20, -30);
    MinimumQualityLabel:SetPoint("LEFT", Window, "LEFT", 20, 0);

    ---@type Frame
    local MinimumQuality = Interface:createDropdown{
        Parent = Window,
        Options = {
            [0] = ("|c00%s%s|r"):format(Interface.Colors.POOR, L["Poor"]),
            [1] = ("|c00%s%s|r"):format(Interface.Colors.COMMON, L["Common"]),
            [2] = ("|c00%s%s|r"):format(Interface.Colors.UNCOMMON, L["Uncommon"]),
            [3] = ("|c00%s%s|r"):format(Interface.Colors.RARE, L["Rare"]),
            [4] = ("|c00%s%s|r"):format(Interface.Colors.EPIC, L["Epic"]),
        },
        value = Settings:get("GDKP.MultiAuction.minimumFillQuality"),
        callback = function (_, value)
            Settings:set("GDKP.MultiAuction.minimumFillQuality", value);
        end
    };
    MinimumQuality:SetPoint("TOP", MinimumQualityLabel, "BOTTOM", 0, -6);
    MinimumQuality:SetPoint("LEFT", Window, "LEFT");

    --[[ ITEM LEVEL ]]
    ---@type FontString
    local ItemLevelLabel = Interface:createFontString(Window, L["Minimum item level"]);
    ItemLevelLabel:SetHeight(20);
    ItemLevelLabel:SetPoint("TOPLEFT", MinimumQuality, "BOTTOMLEFT", 22, 0);

    ---@type EditBox
    local ItemLevel = Interface:numericInputBox(Window, nil, nil, 0);
    ItemLevel:SetPoint("TOPLEFT", ItemLevelLabel, "BOTTOMLEFT", 2, 0);
    ItemLevel:SetPoint("RIGHT", Window, "RIGHT", -24, 0);
    ItemLevel:SetText(Settings:get("GDKP.MultiAuction.minimumFillItemLevel", ""));

    --[[ INCLUDE BOES ]]
    ---@type CheckButton
    local IncludeBOE = Interface:createCheckbox{
        Parent = Window,
        checked = Settings:get("GDKP.MultiAuction.includeBOEs"),
        label = L["Include BOEs"],
        callback = function (_, value)
            Settings:set("GDKP.MultiAuction.includeBOEs", value);
        end,
    };
    IncludeBOE:SetPoint("TOPLEFT", ItemLevel, "BOTTOMLEFT", 0, -10);

    --[[ INCLUDE ALREADY AWARDED ]]
    ---@type CheckButton
    local IncludeAwarded = Interface:createCheckbox{
        Parent = Window,
        checked = Settings:get("GDKP.MultiAuction.includeAwarded"),
        label = L["Include previously awarded items"],
        callback = function (_, value)
            Settings:set("GDKP.MultiAuction.includeAwarded", value);
        end,
    };
    IncludeAwarded:SetPoint("TOPLEFT", IncludeBOE, "BOTTOMLEFT", 0, -6);

    --[[ INCLUDE REAGENTS ]]
    ---@type CheckButton
    local IncludeMaterials = Interface:createCheckbox{
        Parent = Window,
        checked = Settings:get("GDKP.MultiAuction.includeMaterials"),
        label = L["Include materials (like Abyss Crystals)"],
        callback = function (_, value)
            Settings:set("GDKP.MultiAuction.includeMaterials", value);
        end,
    };
    IncludeMaterials:SetPoint("TOPLEFT", IncludeAwarded, "BOTTOMLEFT", 0, -6);

    local FillButton = Interface:dynamicPanelButton(Window, L["Fill"]);
    FillButton:SetPoint("BOTTOMLEFT", Window, "BOTTOMLEFT", 20, 30);
    FillButton:SetScript("OnClick", function ()
        local itemLevel = ItemLevel:GetText();
        Auctioneer:fillFromInventory(MinimumQuality:GetValue(), itemLevel, IncludeBOE:GetChecked(), IncludeAwarded:GetChecked(), IncludeMaterials:GetChecked());
        Settings:set("GDKP.MultiAuction.minimumFillItemLevel", itemLevel);
        self:close();
    end);

    local CancelButton = Interface:dynamicPanelButton(Window, L["Cancel"]);
    CancelButton:SetPoint("TOPLEFT", FillButton, "TOPRIGHT", 2, 0);
    CancelButton:SetScript("OnClick", function ()
        self:close();
    end);

    return Window;
end

---@return Frame
function FillFromInventory:getWindow()
    return _G[self.windowName];
end
