local L = Gargul_L;

---@type GL
local _, GL = ...;

---@type Interface
local Interface = GL.Interface;

---@type Settings
local Settings = GL.Settings;

---@class LocaleInterface
GL.Interface.Locale = {
    forwardToSettings = false,
    isVisible = false,
    windowName = "Gargul.Interface.Locale.Window",
};

---@type LocaleInterface
local Locale = GL.Interface.Locale;

---@return table
function Locale:open(forwardToSettings)
    self.forwardToSettings = forwardToSettings ~= nil;
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
        {text = L["Window"], isTitle = true, notCheckable = true },
        {text = L["Adjust Scale"], notCheckable = true, func = function ()
            Interface:openScaler(Window);
            CloseMenus();
        end},
    });

    ---@type FontString
    local Title = Interface:createFontString(Window, ("|c00%s%s|r"):format(GL.Data.Constants.addonHexColor, L["Choose a chat language for Gargul"]));
    Title:SetPoint("TOPLEFT", Window, "TOPLEFT", 20, -30);
    Title:SetPoint("TOPRIGHT", Window, "TOPRIGHT", -20, 0);
    Title:SetJustifyH("CENTER");

    ---@type FontString
    local Intro = Interface:createFontString(Window, (L["\nGargul posts chat messages in English (default)\nYou can select a different language in the dropdown below\n\nYour current chat language is '%s', enabling a different language will cause a /reload!\n"]):format(("|c00%s%s|r"):format(GL.Data.Constants.addonHexColor, GL.Settings:get("chatLocale", "enUS"))));
    Intro:SetPoint("TOP", Title, "BOTTOM", 0, -6);
    Intro:SetPoint("LEFT", Window, "LEFT", 20, -30);
    Intro:SetPoint("RIGHT", Window, "RIGHT", -20, 0);
    Intro:SetJustifyH("CENTER");

    ---@type Frame
    local Locales = Interface:createDropdown{
        Parent = Window,
        Options = {
            enUS = L["enUS"], -- English (United States)
            koKR = L["koKR"], -- Korean (Korea)
            frFR = L["frFR"], -- French (France)
            deDE = L["deDE"], -- German (Germany)
            zhCN = L["zhCN"], -- Chinese (Simplified, PRC)
            esES = L["esES"], -- Spanish (Spain)
            zhTW = L["zhTW"], -- Chinese (Traditional, Taiwan)
            esMX = L["esMX"], -- Spanish (Mexico)
            ruRU = L["ruRU"], -- Russian (Russia)
            ptBR = L["ptBR"], -- Portuguese (Brazil)
            itIT = L["itIT"], -- Italian (Italy)
        },
        value = Settings:get("chatLocale", "enUS"),
    };
    Locales:SetPoint("TOP", Intro, "BOTTOM", 0, -16);
    Locales:SetPoint("CENTER", Window, "CENTER");

    ---@type FontString
    local Note = Interface:createFontString(Window, (L["Note: you can change the locale at any time in the settings or via |c00%s/gl locale"]):format(GL.Data.Constants.addonHexColor));
    Note:SetPoint("TOP", Locales, "BOTTOM", 0, -6);
    Note:SetPoint("LEFT", Window, "LEFT", 20, -30);
    Note:SetPoint("RIGHT", Window, "RIGHT", -20, 0);
    Note:SetJustifyH("CENTER");

    local OkButton = Interface:dynamicPanelButton(Window, L["Ok"]);
    OkButton:SetPoint("BOTTOMLEFT", Window, "BOTTOMLEFT", 20, 30);
    OkButton:SetScript("OnClick", function ()
        Settings:set("chatLocale", Locales:GetValue() or "enUS");
        self:close();

        if (self.forwardToSettings) then
            self.forwardToSettings = false;
            GL.Settings:draw();
        end
    end);

    local CancelButton = Interface:dynamicPanelButton(Window, L["Cancel"]);
    CancelButton:SetPoint("TOPLEFT", OkButton, "TOPRIGHT", 2, 0);
    CancelButton:SetScript("OnClick", function ()
        self:close();
    end);

    _G[self.windowName] = Window;
    return Window;
end
