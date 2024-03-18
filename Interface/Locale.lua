local L = Gargul_L;

---@type GL
local _, GL = ...;

---@type Interface
local Interface = GL.Interface;

---@type Settings
local Settings = GL.Settings;

---@class LocaleInterface
GL.Interface.Locale = {
    isVisible = false,
    windowName = "Gargul.Interface.Locale.Window",
};

---@type LocaleInterface
local Locale = GL.Interface.Locale;

---@return table
function Locale:open()
    self.isVisible = true;

    local Window = _G[self.windowName] or self:build();

    Window:Show();
    return Window;
end

---@return void
function Locale:close()
    self.isVisible = false;
    return _G[self.windowName] and _G[self.windowName]:Hide();
end

---@return table
function Locale:build()
    if (_G[self.windowName]) then
        return _G[self.windowName];
    end

    --[[ THE MAIN AUCTIONEER WINDOW ]]
    ---@type Frame
    local Window = Interface:createWindow{
        name = self.windowName,
        width = 375,
        height = 240,
        hideMinimizeButton = true,
        hideResizeButton = true,
    };

    Window:ClearAllPoints();
    Window:SetPoint("CENTER", UIParent, "CENTER");

    --[[ ADD THE SETTINGS MENU IN THE TOP LEFT OF THE WINDOW ]]
    Interface:addWindowOptions(Window, {
        {text = L.WINDOW, isTitle = true, notCheckable = true },
        {text = L.CHANGE_SCALE, notCheckable = true, func = function ()
            Interface:openScaler(Window);
            CloseMenus();
        end},
    });

    ---@type FontString
    local Title = Interface:createFontString(Window, ("|c00%s%s|r"):format(GL.Data.Constants.addonHexColor, L.LOCALE_NONE_TITLE));
    Title:SetPoint("TOPLEFT", Window, "TOPLEFT", 20, -30);
    Title:SetPoint("TOPRIGHT", Window, "TOPRIGHT", -20, 0);
    Title:SetJustifyH("MIDDLE");

    ---@type FontString
    local Intro = Interface:createFontString(Window, (L.LOCALE_NONE_EXPLANATION):format(("|c00%s%s|r"):format(GL.Data.Constants.addonHexColor, GL.Settings:get("chatLocale", "enUS"))));
    Intro:SetPoint("TOP", Title, "BOTTOM", 0, -6);
    Intro:SetPoint("LEFT", Window, "LEFT", 20, -30);
    Intro:SetPoint("RIGHT", Window, "RIGHT", -20, 0);
    Intro:SetJustifyH("MIDDLE");

    ---@type Frame
    local Locales = Interface:createDropdown{
        Parent = Window,
        Options = {
            enUS = L.LOCALE_ENUS, -- English (United States)
            koKR = L.LOCALE_KOKR, -- Korean (Korea)
            frFR = L.LOCALE_FRFR, -- French (France)
            deDE = L.LOCALE_DEDE, -- German (Germany)
            zhCN = L.LOCALE_ZHCN, -- Chinese (Simplified, PRC)
            esES = L.LOCALE_ESES, -- Spanish (Spain)
            zhTW = L.LOCALE_ZHTW, -- Chinese (Traditional, Taiwan)
            esMX = L.LOCALE_ESMX, -- Spanish (Mexico)
            ruRU = L.LOCALE_RURU, -- Russian (Russia)
            ptBR = L.LOCALE_PTBR, -- Portuguese (Brazil)
            itIT = L.LOCALE_ITIT, -- Italian (Italy)
        },
        value = Settings:get("chatLocale", "enUS"),
    };
    Locales:SetPoint("TOP", Intro, "BOTTOM", 0, -16);
    Locales:SetPoint("CENTER", Window, "CENTER");

    ---@type FontString
    local Note = Interface:createFontString(Window, (L.LOCALE_CHANGE_NOTE):format(GL.Data.Constants.addonHexColor));
    Note:SetPoint("TOP", Locales, "BOTTOM", 0, -6);
    Note:SetPoint("LEFT", Window, "LEFT", 20, -30);
    Note:SetPoint("RIGHT", Window, "RIGHT", -20, 0);
    Note:SetJustifyH("MIDDLE");

    local OkButton = Interface:dynamicPanelButton(Window, L.OK);
    OkButton:SetPoint("BOTTOMLEFT", Window, "BOTTOMLEFT", 20, 30);
    OkButton:SetScript("OnClick", function ()
        Settings:set("chatLocale", Locales:GetValue() or "enUS");
        self:close();
    end);

    local CancelButton = Interface:dynamicPanelButton(Window, L.CANCEL);
    CancelButton:SetPoint("TOPLEFT", OkButton, "TOPRIGHT", 2, 0);
    CancelButton:SetScript("OnClick", function ()
        self:close();
    end);

    _G[self.windowName] = Window;
    return Window;
end
