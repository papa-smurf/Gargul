local L = Gargul_L;

---@type GL
local _, GL = ...;

GL.AceGUI = GL.AceGUI or LibStub("AceGUI-3.0");

---@type Interface
local Interface = GL.Interface;

---@class ImporterInterface
GL.Interface.Importer = {
    isVisible = false,
    windowName = "Gargul.Interface.Importer.Window",
};

---@type ImporterInterface
local Importer = GL.Interface.Importer;

--[[ CONSTANTS ]]
local FONT;

---@return table
function Importer:open()
    GL:debug("Importer:open");

    self.isVisible = true;
    FONT = GL.FONT;

    local Window = _G[self.windowName] or self:build();

    Window:Show();
    return Window;
end

---@return void
function Importer:close()
    GL:debug("Importer:close");

    self.isVisible = false;
    return _G[self.windowName] and _G[self.windowName]:Hide();
end

--- Build the auctioneer UI. We only do this once per runtime
---
---@return table
function Importer:build()
    GL:debug("Importer:build");

    if (_G[self.windowName]) then
        return _G[self.windowName];
    end

    --[[ THE MAIN AUCTIONEER WINDOW ]]
    ---@type Frame
    local Window = Interface:createWindow(self.windowName, {
        width = 300,
        height = 200,
        minWidth = 220,
        minHeight = 190,
        maxWidth = 500,
        maxHeight = 200,
        hideMinimizeButton = true,
    });

    --[[ ADD THE SETTINGS MENU IN THE TOP LEFT OF THE WINDOW ]]
    Interface:addWindowOptions(Window, {
        {text = L.WINDOW, isTitle = true, notCheckable = true },
        {text = L.CHANGE_SCALE, notCheckable = true, func = function ()
            Interface:openScaler(Window);
            CloseMenus();
        end},
    });

    ---@type FontString
    local Intro = Interface:createFontString(Window, L.IMPORT_EXPLANATION);
    Intro:SetPoint("TOPLEFT", Window, "TOPLEFT", 20, -30);
    Intro:SetPoint("TOPRIGHT", Window, "TOPRIGHT", -20, 0);
    Intro:SetJustifyH("MIDDLE")

    ---@type Button
    local ImportSoftRes = Interface:dynamicPanelButton(Window, L.SOFTRES);
    ImportSoftRes:SetPoint("TOPLEFT", Window, "TOPLEFT", 20, -60);
    ImportSoftRes:SetPoint("TOPRIGHT", Window, "TOPRIGHT", -20, 0);
    ImportSoftRes:SetScript("OnClick", function ()
        GL.Commands:call("softreserves");
    end);

    ---@type Button
    local ImportTMB = Interface:dynamicPanelButton(Window, L.TMBETC);
    ImportTMB:SetPoint("TOPLEFT", ImportSoftRes, "TOPLEFT", 0, -26);
    ImportTMB:SetPoint("TOPRIGHT", ImportSoftRes, "TOPRIGHT", 0, 0);
    ImportTMB:SetScript("OnClick", function ()
        GL.Commands:call("tmb");
    end);

    ---@type Button
    local ImportBoostedRolls = Interface:dynamicPanelButton(Window, L.BOOSTED_ROLLS);
    ImportBoostedRolls:SetPoint("TOPLEFT", ImportTMB, "TOPLEFT", 0, -26);
    ImportBoostedRolls:SetPoint("TOPRIGHT", ImportTMB, "TOPRIGHT", 0, 0);
    ImportBoostedRolls:SetScript("OnClick", function ()
        GL.Commands:call("boostedrolls");
    end);

    ---@type Button
    local ImportPlusOnes = Interface:dynamicPanelButton(Window, L.PLUSONES);
    ImportPlusOnes:SetPoint("TOPLEFT", ImportBoostedRolls, "TOPLEFT", 0, -26);
    ImportPlusOnes:SetPoint("TOPRIGHT", ImportBoostedRolls, "TOPRIGHT", 0, 0);
    ImportPlusOnes:SetScript("OnClick", function ()
        GL.Commands:call("plusones");
    end);

    _G[self.windowName] = Window;
    return Window;
end

GL:debug("Importer.lua");