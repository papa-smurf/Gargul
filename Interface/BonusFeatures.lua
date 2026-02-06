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

---@return nil
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
        height = 420,
        minWidth = 220,
        minHeight = 420,
        maxWidth = 475,
        maxHeight = 500,
        hideMinimizeButton = true,
    };

    --[[ ADD THE SETTINGS MENU IN THE TOP LEFT OF THE WINDOW ]]
    Interface:addWindowOptions(Window, {
        {text = L["Window"], isTitle = true, notCheckable = true },
        {text = L["Adjust Scale"], notCheckable = true, func = function ()
            Interface:openScaler(Window);
            CloseMenus();
        end},
    });

    ---@type FontString
    local Intro = Interface:createFontString(Window, L["Gargul has a few tricks up its sleeve that you might not be aware of. Have a looksy!"]);
    Intro:SetPoint("TOPLEFT", Window, "TOPLEFT", 20, -30);
    Intro:SetPoint("TOPRIGHT", Window, "TOPRIGHT", -20, 0);
    Intro:SetJustifyH("CENTER");

    --[[ GROUP MANAGER ]]
    ---@type FontString
    local GroupManagerLabel = Interface:createFontString(Window, L["1. Auto invite/sort groups from raid signup! Click below or use |c00A79EFF/gl gr"]);
    GroupManagerLabel:SetPoint("TOPLEFT", Intro, "BOTTOMLEFT", 0, -18);
    GroupManagerLabel:SetPoint("TOPRIGHT", Intro, "BOTTOMRIGHT");

    ---@type Button
    local GroupManager = Interface:dynamicPanelButton(Window, L["Group Manager"]);
    GroupManager:SetPoint("TOPLEFT", GroupManagerLabel, "BOTTOMLEFT", 0, -10);
    GroupManager:SetPoint("TOPRIGHT", GroupManagerLabel, "BOTTOMRIGHT", 0, 0);
    GroupManager:SetScript("OnClick", function ()
        GL.Commands:call("groups");
    end);

    --[[ BOOSTED ROLLS ]]
    ---@type FontString
    local BoostedRollsLabel = Interface:createFontString(Window, L["2. Reward players for being regulars or going the extra mile! Click below or use |c00A79EFF/gl br"]);
    BoostedRollsLabel:SetPoint("TOPLEFT", GroupManager, "BOTTOMLEFT", 0, -18);
    BoostedRollsLabel:SetPoint("TOPRIGHT", GroupManager, "BOTTOMRIGHT");

    ---@type Button
    local BoostedRolls = Interface:dynamicPanelButton(Window, L["Boosted Rolls"]);
    BoostedRolls:SetPoint("TOPLEFT", BoostedRollsLabel, "BOTTOMLEFT", 0, -10);
    BoostedRolls:SetPoint("TOPRIGHT", BoostedRollsLabel, "BOTTOMRIGHT", 0, 0);
    BoostedRolls:SetScript("OnClick", function ()
        GL.Settings:draw("BoostedRolls");
    end);

    --[[ PLUS ONES ]]
    ---@type FontString
    local PlusOnesLabel = Interface:createFontString(Window, L["3. Gargul includes a plus one tracking system! Click below or use |c00A79EFF/gl po"]);
    PlusOnesLabel:SetPoint("TOPLEFT", BoostedRolls, "BOTTOMLEFT", 0, -18);
    PlusOnesLabel:SetPoint("TOPRIGHT", BoostedRolls, "BOTTOMRIGHT");

    ---@type Button
    local PlusOnes = Interface:dynamicPanelButton(Window, L["Plus Ones"]);
    PlusOnes:SetPoint("TOPLEFT", PlusOnesLabel, "BOTTOMLEFT", 0, -10);
    PlusOnes:SetPoint("TOPRIGHT", PlusOnesLabel, "BOTTOMRIGHT", 0, 0);
    PlusOnes:SetScript("OnClick", function ()
        GL.Commands:call("plusones");
    end);

    --[[ AUTO ROLL ]]
    ---@type FontString
    local AutoRollLabel = Interface:createFontString(Window, L["4. Automatically roll need, greed or pass based on saved rules! Click below or use |c00A79EFF/gl ar"]);
    AutoRollLabel:SetPoint("TOPLEFT", PlusOnes, "BOTTOMLEFT", 0, -18);
    AutoRollLabel:SetPoint("TOPRIGHT", PlusOnes, "BOTTOMRIGHT");

    ---@type Button
    local AutoRoll = Interface:dynamicPanelButton(Window, L["Auto Roll"]);
    AutoRoll:SetPoint("TOPLEFT", AutoRollLabel, "BOTTOMLEFT", 0, -10);
    AutoRoll:SetPoint("TOPRIGHT", AutoRollLabel, "BOTTOMRIGHT", 0, 0);
    AutoRoll:SetScript("OnClick", function ()
        GL.Settings:draw("AutoRollRules");
    end);

    _G[self.windowName] = Window;
    return Window;
end
