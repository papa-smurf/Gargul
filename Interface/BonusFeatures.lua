local L = Gargul_L;

---@type GL
local _, GL = ...;

GL.AceGUI = GL.AceGUI or LibStub("AceGUI-3.0");

---@type Interface
local Interface = GL.Interface;

---@class BonusFeaturesInterface
GL.Interface.BonusFeatures = {
    isVisible = false,
    windowName = "Gargul.Interface.BonusFeatures.Window",
};

---@type BonusFeaturesInterface
local BonusFeatures = GL.Interface.BonusFeatures;

--[[ CONSTANTS ]]
local FONT;

---@return table
function BonusFeatures:open()
    self.isVisible = true;
    FONT = GL.FONT;

    local Window = _G[self.windowName] or self:build();

    Window:Show();
    return Window;
end

---@return void
function BonusFeatures:close()
    self.isVisible = false;
    return _G[self.windowName] and _G[self.windowName]:Hide();
end

--- Build the auctioneer UI. We only do this once per runtime
---
---@return table
function BonusFeatures:build()
    if (_G[self.windowName]) then
        return _G[self.windowName];
    end

    --[[ THE MAIN AUCTIONEER WINDOW ]]
    ---@type Frame
    local Window = Interface:createWindow{
        name = self.windowName,
        width = 220,
        height = 325,
        minWidth = 220,
        minHeight = 325,
        maxWidth = 475,
        maxHeight = 400,
        hideMinimizeButton = true,
    };

    --[[ ADD THE SETTINGS MENU IN THE TOP LEFT OF THE WINDOW ]]
    Interface:addWindowOptions(Window, {
        {text = L.WINDOW, isTitle = true, notCheckable = true },
        {text = L.CHANGE_SCALE, notCheckable = true, func = function ()
            Interface:openScaler(Window);
            CloseMenus();
        end},
    });

    ---@type FontString
    local Intro = Interface:createFontString(Window, L.BONUS_FEATURE_EXPLANATION);
    Intro:SetPoint("TOPLEFT", Window, "TOPLEFT", 20, -30);
    Intro:SetPoint("TOPRIGHT", Window, "TOPRIGHT", -20, 0);
    Intro:SetJustifyH("CENTER");

    --[[ GROUP MANAGER ]]
    ---@type FontString
    local GroupManagerLabel = Interface:createFontString(Window, L.BONUS_AUTO_INVITE);
    GroupManagerLabel:SetPoint("TOPLEFT", Intro, "BOTTOMLEFT", 0, -18);
    GroupManagerLabel:SetPoint("TOPRIGHT", Intro, "BOTTOMRIGHT");

    ---@type Button
    local GroupManager = Interface:dynamicPanelButton(Window, L.GROUP_MANAGER);
    GroupManager:SetPoint("TOPLEFT", GroupManagerLabel, "BOTTOMLEFT", 0, -10);
    GroupManager:SetPoint("TOPRIGHT", GroupManagerLabel, "BOTTOMRIGHT", 0, 0);
    GroupManager:SetScript("OnClick", function ()
        GL.Commands:call("groups");
    end);

    --[[ BOOSTED ROLLS ]]
    ---@type FontString
    local BoostedRollsLabel = Interface:createFontString(Window, L.BONUS_BOOSTED_ROLLS);
    BoostedRollsLabel:SetPoint("TOPLEFT", GroupManager, "BOTTOMLEFT", 0, -18);
    BoostedRollsLabel:SetPoint("TOPRIGHT", GroupManager, "BOTTOMRIGHT");

    ---@type Button
    local BoostedRolls = Interface:dynamicPanelButton(Window, L.BOOSTED_ROLLS);
    BoostedRolls:SetPoint("TOPLEFT", BoostedRollsLabel, "BOTTOMLEFT", 0, -10);
    BoostedRolls:SetPoint("TOPRIGHT", BoostedRollsLabel, "BOTTOMRIGHT", 0, 0);
    BoostedRolls:SetScript("OnClick", function ()
        GL.Settings:draw("BoostedRolls");
    end);

    --[[ PLUS ONES ]]
    ---@type FontString
    local PlusOnesLabel = Interface:createFontString(Window, L.BONUS_PLUSONES);
    PlusOnesLabel:SetPoint("TOPLEFT", BoostedRolls, "BOTTOMLEFT", 0, -18);
    PlusOnesLabel:SetPoint("TOPRIGHT", BoostedRolls, "BOTTOMRIGHT");

    ---@type Button
    local PlusOnes = Interface:dynamicPanelButton(Window, L.PLUSONES);
    PlusOnes:SetPoint("TOPLEFT", PlusOnesLabel, "BOTTOMLEFT", 0, -10);
    PlusOnes:SetPoint("TOPRIGHT", PlusOnesLabel, "BOTTOMRIGHT", 0, 0);
    PlusOnes:SetScript("OnClick", function ()
        GL.Commands:call("plusones");
    end);

    _G[self.windowName] = Window;
    return Window;
end
