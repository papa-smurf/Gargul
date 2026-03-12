local L = Gargul_L;

---@type GL
local _, GL = ...;

---@type Interface
local Interface = GL.Interface;

---@class OnboardingInterface
GL.Interface.Onboarding = {
    isVisible = false,
    windowName = "Gargul.Interface.Onboarding.Window",
};

---@type OnboardingInterface
local Onboarding = GL.Interface.Onboarding;

--[[ CONSTANTS ]]
local WINDOW_WIDTH = 620;
local WINDOW_HEIGHT = 520;
local SIDE_PADDING = 30;
local STEP_ICON_SIZE = 26;
local STEP_ROW_HEIGHT = 30;
local COLORS = {
    EPIC = "A335EE",
    RARE = "0070DD",
    UNCOMMON = "1EFF00",
    GOLD = "FFD700",
    YELLOW = "FFF569",
    PURPLE = "A79EFF",
    GREEN = "92FF00",
    WARRIOR = "C79C6E",
    HUNTER = "ABD473",
    PALADIN = "F58CBA",
};

---@return table
function Onboarding:open()
    self.isVisible = true;

    local Window = _G[self.windowName] or self:build();

    Window:Show();
    self:showSlide(Window.currentSlide or 1);
    return Window;
end

---@return nil
function Onboarding:close()
    self.isVisible = false;
    return _G[self.windowName] and _G[self.windowName]:Hide();
end

--- Show a slide by index (1-based).
---
---@param index number
---@return nil
function Onboarding:showSlide(index)
    local Window = _G[self.windowName];
    if (not Window or not Window.Slides) then
        return;
    end

    local total = #Window.Slides;
    index = math.max(1, math.min(index, total));
    Window.currentSlide = index;

    for i, frame in ipairs(Window.Slides) do
        frame:SetShown(i == index);
    end

    if (Window.BackButton) then
        if (index > 1) then
            Window.BackButton:Enable();
        else
            Window.BackButton:Disable();
        end
    end

    if (Window.NextButton) then
        Window.NextButton:SetText(index == total and L["Done"] or L["Next"]);
    end

    if (Window.SlideLabel) then
        Window.SlideLabel:SetText(("%s %d/%d"):format(L["Quick start"], index, total));
    end
end

--- Create a dark backdrop frame used for mockups.
---
---@param Parent Frame
---@param height number
---@return Frame
local function createMockupFrame(Parent, height)
    local Frame = CreateFrame("Frame", nil, Parent, "BackdropTemplate");
    Frame:SetHeight(height);
    Frame:SetBackdrop({
        bgFile = "Interface/Tooltips/UI-Tooltip-Background",
        edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
        tile = true,
        tileSize = 16,
        edgeSize = 12,
        insets = { left = 3, right = 3, top = 3, bottom = 3, },
    });
    Frame:SetBackdropColor(0, 0, 0, .7);
    Frame:SetBackdropBorderColor(.3, .3, .3, .6);

    return Frame;
end

--- Create a quality-colored swatch (small square).
---
---@param Parent Frame
---@param hexColor string
---@param size number|nil
---@return Texture
local function createColorSwatch(Parent, hexColor, size)
    size = size or 10;
    local r = tonumber(strsub(hexColor, 1, 2), 16) / 255;
    local g = tonumber(strsub(hexColor, 3, 4), 16) / 255;
    local b = tonumber(strsub(hexColor, 5, 6), 16) / 255;

    local Swatch = Parent:CreateTexture(nil, "ARTWORK");
    Swatch:SetSize(size, size);
    Swatch:SetColorTexture(r, g, b, 1);

    return Swatch;
end

--- Create a numbered step row (icon + text).
---
---@param Parent Frame
---@param stepNumber number
---@param text string
---@param anchor Frame
---@param offsetY number
---@return Frame
local function createStepRow(Parent, stepNumber, text, anchor, offsetY)
    local Row = CreateFrame("Frame", nil, Parent);
    Row:SetHeight(STEP_ROW_HEIGHT);
    Row:SetPoint("TOPLEFT", anchor, "BOTTOMLEFT", 0, offsetY);
    Row:SetPoint("TOPRIGHT", anchor, "BOTTOMRIGHT", 0, offsetY);

    local Icon = Row:CreateTexture(nil, "ARTWORK");
    Icon:SetSize(STEP_ICON_SIZE, STEP_ICON_SIZE);
    Icon:SetPoint("LEFT", Row, "LEFT", 0, 0);
    Icon:SetTexture(("Interface/AddOns/Gargul/Assets/Icons/%d"):format(stepNumber));

    local Text = Interface:createFontString(Row, text);
    Text:SetPoint("LEFT", Icon, "RIGHT", 6, 0);
    Text:SetPoint("RIGHT", Row, "RIGHT", 0, 0);
    Text:SetWordWrap(true);
    Text:SetFont(1.2, "");

    return Row;
end

--- Build a single slide frame with header, mockup area, steps, and action button.
---
---@param Window Frame
---@param cfg table
---@return Frame
local function buildSlide(Window, cfg)
    local Slide = CreateFrame("Frame", nil, Window);
    Slide:SetPoint("TOPLEFT", Window, "TOPLEFT", SIDE_PADDING, -42);
    Slide:SetPoint("TOPRIGHT", Window, "TOPRIGHT", -SIDE_PADDING, -42);
    Slide:SetPoint("BOTTOM", Window, "BOTTOM", 0, 56);
    Slide:Hide();

    --[[ HEADER: icon + title + subtitle ]]
    local HeaderIcon = Slide:CreateTexture(nil, "ARTWORK");
    HeaderIcon:SetSize(36, 36);
    HeaderIcon:SetPoint("TOPLEFT", Slide, "TOPLEFT", 0, 0);
    HeaderIcon:SetTexture(cfg.icon);

    local Title = Interface:createFontString(Slide, ("|c00%s%s|r"):format(COLORS.PURPLE, cfg.title));
    Title:SetPoint("TOPLEFT", HeaderIcon, "TOPRIGHT", 10, -2);
    Title:SetFont(2, "OUTLINE");

    local Subtitle = Interface:createFontString(Slide, cfg.subtitle);
    Subtitle:SetPoint("TOPLEFT", Title, "BOTTOMLEFT", 0, -2);
    Subtitle:SetPoint("RIGHT", Slide, "RIGHT");
    Subtitle:SetFont(1.2, "");

    --[[ MOCKUP ]]
    local MockupContainer = createMockupFrame(Slide, cfg.mockupHeight or 100);
    MockupContainer:SetPoint("TOPLEFT", Slide, "TOPLEFT", 0, -52);
    MockupContainer:SetPoint("TOPRIGHT", Slide, "TOPRIGHT", 0, -52);

    if (cfg.buildMockup) then
        cfg.buildMockup(MockupContainer);
    end

    --[[ STEP BULLETS ]]
    local lastAnchor = MockupContainer;
    for stepIdx, stepText in ipairs(cfg.steps) do
        local yOffset = stepIdx == 1 and -10 or -4;
        lastAnchor = createStepRow(Slide, stepIdx, stepText, lastAnchor, yOffset);
    end

    --[[ ACTION BUTTON ]]
    local ActionBtn = Interface:dynamicPanelButton(Slide, cfg.buttonText);
    ActionBtn:GetFontString():SetFont(1.2, "");
    ActionBtn:SetText(cfg.buttonText);
    ActionBtn:SetPoint("BOTTOM", Slide, "BOTTOM", 0, 0);
    local btnWidth = ActionBtn:GetWidth();
    if (btnWidth < 180) then
        ActionBtn:SetWidth(180);
    end
    ActionBtn:SetScript("OnClick", function ()
        if (cfg.action) then
            cfg.action();
            GL:message(("|c00%s%s|r"):format(GL.Data.Constants.addonHexColor, (L["Type |c00%s/gl start|r to get back to the quick start guide"]):format(GL.Data.Constants.commandHexColor)));
        end
    end);

    return Slide;
end

--[[ ============================
     MOCKUP BUILDERS
     ============================ ]]

--- GDKP pot mockup: gold icon, pot total, 3 auction result rows.
---
---@param Parent Frame
---@return nil
local function buildGDKPMockup(Parent)
    local PotIcon = Parent:CreateTexture(nil, "ARTWORK");
    PotIcon:SetSize(24, 24);
    PotIcon:SetPoint("TOPLEFT", Parent, "TOPLEFT", 10, -8);
    PotIcon:SetTexture("Interface/AddOns/Gargul/Assets/Icons/achievement_guildperk_cashflow");

    local PotLabel = Interface:createFontString(Parent, ("|c00%s%s|r"):format(COLORS.YELLOW, L["Total Pot"]));
    PotLabel:SetPoint("LEFT", PotIcon, "RIGHT", 6, 0);
    PotLabel:SetFont(1.4, "");

    local PotAmount = Interface:createFontString(Parent, ("|c00%s247g 50s|r"):format(COLORS.GOLD));
    PotAmount:SetPoint("TOPRIGHT", Parent, "TOPRIGHT", -14, -12);
    PotAmount:SetFont(1.7, "OUTLINE");

    local items = {
        { color = COLORS.EPIC, name = "Betrayer of Humanity", price = "125g", },
        { color = COLORS.RARE, name = "Wraith Spear", price = "62g", },
        { color = COLORS.EPIC, name = "Drape of the Deadly Foe", price = "60g", },
    };

    local prevAnchor = PotIcon;
    for i, item in ipairs(items) do
        local y = i == 1 and -12 or -4;

        local Swatch = createColorSwatch(Parent, item.color, 8);
        Swatch:SetPoint("TOPLEFT", prevAnchor, "BOTTOMLEFT", i == 1 and 0 or 0, y);

        local Name = Interface:createFontString(Parent, ("|c00%s%s|r"):format(item.color, item.name));
        Name:SetPoint("LEFT", Swatch, "RIGHT", 6, 0);
        Name:SetFont(1.3, "");

        local Price = Interface:createFontString(Parent, ("|c00%s%s|r"):format(COLORS.GOLD, item.price));
        Price:SetPoint("RIGHT", Parent, "RIGHT", -14, 0);
        Price:SetPoint("TOP", Swatch, "TOP", 0, 1);
        Price:SetFont(1.3, "");

        prevAnchor = Swatch;
    end
end

--- Multi-auction mockup: 3 auction rows with icon, name, bid controls.
---
---@param Parent Frame
---@return nil
local function buildMultiAuctionMockup(Parent)
    local items = {
        { icon = "Interface/Icons/INV_Sword_39", color = COLORS.EPIC, name = "Betrayer of Humanity", bid = "100g", },
        { icon = "Interface/Icons/INV_Spear_07", color = COLORS.RARE, name = "Wraith Spear", bid = "50g", },
        { icon = "Interface/Icons/INV_Misc_Cape_18", color = COLORS.EPIC, name = "Drape of the Deadly Foe", bid = "75g", },
    };

    for i, item in ipairs(items) do
        local rowY = -8 + (i - 1) * -34;

        local Icon = Parent:CreateTexture(nil, "ARTWORK");
        Icon:SetSize(28, 28);
        Icon:SetPoint("TOPLEFT", Parent, "TOPLEFT", 10, rowY);
        Icon:SetTexture(item.icon);

        local Name = Interface:createFontString(Parent, ("|c00%s%s|r"):format(item.color, item.name));
        Name:SetPoint("LEFT", Icon, "RIGHT", 6, 0);
        Name:SetFont(1.3, "");

        local Controls = Interface:createFontString(Parent,
            ("|c00%s[Min]|r  |c00FFFFFF%s|r  |c00%s[Bid]|r  |c00%s[Auto]|r"):format(
                COLORS.YELLOW, item.bid, COLORS.YELLOW, COLORS.YELLOW
            )
        );
        Controls:SetPoint("RIGHT", Parent, "RIGHT", -10, 0);
        Controls:SetPoint("TOP", Icon, "TOP", 0, 0);
        Controls:SetFont(1.25, "");
    end
end

--- SoftRes mockup: fake tooltip showing reserved-by info.
---
---@param Parent Frame
---@return nil
local function buildSoftResMockup(Parent)
    local ItemName = Interface:createFontString(Parent, ("|c00%s[Betrayer of Humanity]|r"):format(COLORS.EPIC));
    ItemName:SetPoint("TOPLEFT", Parent, "TOPLEFT", 12, -10);
    ItemName:SetFont(1.5, "");

    local ReservedLabel = Interface:createFontString(Parent, ("|c00%s%s|r"):format(COLORS.PURPLE, L["Soft reserved by:"]));
    ReservedLabel:SetPoint("TOPLEFT", ItemName, "BOTTOMLEFT", 0, -6);
    ReservedLabel:SetFont(1.4, "");

    local players = ("|c00%sWarriorGuy|r, |c00%sHunterBob|r, |c00%sPaladinJane|r"):format(
        COLORS.WARRIOR, COLORS.HUNTER, COLORS.PALADIN
    );
    local PlayerNames = Interface:createFontString(Parent, players);
    PlayerNames:SetPoint("TOPLEFT", ReservedLabel, "BOTTOMLEFT", 8, -4);
    PlayerNames:SetPoint("RIGHT", Parent, "RIGHT", -12, 0);
    PlayerNames:SetFont(1.4, "");
    PlayerNames:SetWordWrap(true);
end

--- PackMule mockup: 3 quality-based loot rules.
---
---@param Parent Frame
---@return nil
local function buildPackMuleMockup(Parent)
    local rules = {
        { color = COLORS.UNCOMMON, quality = L["Uncommon"], target = L["Disenchanter"], },
        { color = COLORS.RARE, quality = L["Rare"], target = "SELF", },
        { color = COLORS.EPIC, quality = L["Epic"], target = L["Master Looter"], },
    };

    for i, rule in ipairs(rules) do
        local rowY = -10 + (i - 1) * -26;

        local Swatch = createColorSwatch(Parent, rule.color, 12);
        Swatch:SetPoint("TOPLEFT", Parent, "TOPLEFT", 14, rowY);

        local Text = Interface:createFontString(Parent,
            ("|c00%s%s|r  |c00808080-->|r  |c00FFFFFF%s|r"):format(rule.color, rule.quality, rule.target)
        );
        Text:SetPoint("LEFT", Swatch, "RIGHT", 8, 0);
        Text:SetFont(1.4, "");
    end
end

--- AutoRoll mockup: item-specific rules (search + add item + assign action).
---
---@param Parent Frame
---@return nil
local function buildAutoRollMockup(Parent)
    local items = {
        { icon = "Interface/Icons/INV_Sword_39", color = COLORS.EPIC, name = "Betrayer of Humanity", roll = L["Need"], },
        { icon = "Interface/Icons/INV_Spear_07", color = COLORS.RARE, name = "Wraith Spear", roll = L["Greed"], },
        { icon = "Interface/Icons/INV_Misc_Cape_18", color = COLORS.EPIC, name = "Drape of the Deadly Foe", roll = L["Pass"], },
    };

    for i, item in ipairs(items) do
        local rowY = -8 + (i - 1) * -26;

        local Icon = Parent:CreateTexture(nil, "ARTWORK");
        Icon:SetSize(22, 22);
        Icon:SetPoint("TOPLEFT", Parent, "TOPLEFT", 12, rowY);
        Icon:SetTexture(item.icon);

        local Name = Interface:createFontString(Parent, ("|c00%s%s|r"):format(item.color, item.name));
        Name:SetPoint("LEFT", Icon, "RIGHT", 6, 0);
        Name:SetFont(1.3, "");

        local Action = Interface:createFontString(Parent, ("|c00%s%s|r"):format(COLORS.YELLOW, item.roll));
        Action:SetPoint("RIGHT", Parent, "RIGHT", -14, 0);
        Action:SetPoint("TOP", Icon, "TOP", 0, 0);
        Action:SetFont(1.3, "");
    end
end

--- Hotkeys mockup: shows the 3 main hotkey actions visually.
---
---@param Parent Frame
---@return nil
local function buildHotkeysMockup(Parent)
    local rollKey = GL.Settings:get("ShortcutKeys.rollOffOrAuction") or "ALT_CLICK";
    local awardKey = GL.Settings:get("ShortcutKeys.award") or "ALT_SHIFT_CLICK";
    local deKey = GL.Settings:get("ShortcutKeys.disenchant") or "CTRL_SHIFT_CLICK";

    local hotkeys = {
        { key = rollKey, label = L["Roll / Auction"], icon = "Interface/Buttons/UI-GroupLoot-Dice-Up", },
        { key = awardKey, label = L["Award loot"], icon = "Interface/AddOns/Gargul/Assets/Buttons/award", },
        { key = deKey, label = L["Disenchant"], icon = "Interface/AddOns/Gargul/Assets/Buttons/disenchant", },
    };

    for i, entry in ipairs(hotkeys) do
        local rowY = -8 + (i - 1) * -30;

        local Icon = Parent:CreateTexture(nil, "ARTWORK");
        Icon:SetSize(22, 22);
        Icon:SetPoint("TOPLEFT", Parent, "TOPLEFT", 14, rowY);
        Icon:SetTexture(entry.icon);

        local Key = Interface:createFontString(Parent, ("|c00%s%s|r"):format(COLORS.YELLOW, entry.key));
        Key:SetPoint("LEFT", Icon, "RIGHT", 8, 0);
        Key:SetFont(1.3, "OUTLINE");

        local Label = Interface:createFontString(Parent, ("|c00808080-->|r  |c00FFFFFF%s|r"):format(entry.label));
        Label:SetPoint("LEFT", Key, "RIGHT", 10, 0);
        Label:SetFont(1.3, "");
    end
end

--[[ ============================
     BUILD
     ============================ ]]

--- Build the onboarding window (carousel of slides with mockups).
---
---@return table
function Onboarding:build()
    if (_G[self.windowName]) then
        return _G[self.windowName];
    end

    local SlidesConfig = {};

    table.insert(SlidesConfig, {
        title = L["Hotkeys"],
        subtitle = L["Use these on items in your bags or item links in chat"],
        icon = "Interface/AddOns/Gargul/Assets/Icons/gargul",
        mockupHeight = 104,
        buildMockup = buildHotkeysMockup,
        steps = {
            L["Works on items in your bags, loot windows, and chat links"],
            L["You can change these hotkeys in |c00FFF569/gl|r -> Shortcut Keys"],
            L["Try it right now -- no need to be in a raid!"],
        },
        buttonText = L["Shortcut Keys"],
        action = function ()
            Onboarding:close();
            GL.Settings:draw("ShortcutKeys");
        end,
    });

    if (GL.GDKPIsAllowed) then
        table.insert(SlidesConfig, {
            title = L["GDKP"],
            subtitle = L["Auction loot, split the gold"],
            icon = "Interface/AddOns/Gargul/Assets/Icons/achievement_guildperk_cashflow",
            mockupHeight = 120,
            buildMockup = buildGDKPMockup,
            steps = {
                L["Create a session with |c00FFF569/gdkp|r"],
                L["Loot drops, you auction it -- gold goes into the pot"],
                L["At the end the pot is split among all raiders"],
            },
            buttonText = L["Open GDKP"],
            action = function ()
                Onboarding:close();
                GL.Commands:call("gdkp");
            end,
        });

        table.insert(SlidesConfig, {
            title = L["Multi-Auction"],
            subtitle = L["Auction many items at once -- the fastest way to run GDKP"],
            icon = "Interface/AddOns/Gargul/Assets/Icons/achievement_guildperk_cashflow",
            mockupHeight = 120,
            buildMockup = buildMultiAuctionMockup,
            steps = {
                L["Type |c00FFF569/gl ma|r or use the multi-auction icon in the GDKP window"],
                L["All items are auctioned off at once -- raiders bid in real time"],
                L["Recommended: auction your entire loot table in one go"],
            },
            buttonText = L["Open GDKP"],
            action = function ()
                Onboarding:close();
                GL.Commands:call("gdkp");
            end,
        });
    end

    table.insert(SlidesConfig, {
        title = L["Soft Reserves"],
        subtitle = L["Players reserve items before the raid"],
        icon = "Interface/AddOns/Gargul/Assets/Icons/softres",
        mockupHeight = 100,
        buildMockup = buildSoftResMockup,
        steps = {
            L["Create a raid on |c00FFF569softres.it|r"],
            L["Import with |c00FFF569/gl sr|r -- data shows on all item tooltips"],
            L["Reserved items are highlighted when they drop"],
            L["Reservation details are displayed when you hover over an item"],
        },
        buttonText = L["Open SoftRes"],
        action = function ()
            Onboarding:close();
            GL.Commands:call("softreserves");
        end,
    });

    table.insert(SlidesConfig, {
        title = L["Autolooting"],
        subtitle = L["Funnel loot to the right player without clicking"],
        icon = "Interface/Icons/INV_Misc_Bag_10",
        mockupHeight = 96,
        buildMockup = buildPackMuleMockup,
        steps = {
            L["Set rules by quality, name or type (e.g. greens to disenchanter)"],
            L["Hold |c00FFF569Shift|r while looting to temporarily skip rules"],
            L["Works with master loot and group loot"],
        },
        buttonText = L["Set up PackMule"],
        action = function ()
            Onboarding:close();
            GL.Settings:draw("PackMule");
        end,
    });

    table.insert(SlidesConfig, {
        title = L["Auto Roll"],
        subtitle = L["Need, greed or pass without lifting a finger"],
        icon = "Interface/Icons/INV_Misc_Dice_02",
        mockupHeight = 96,
        buildMockup = buildAutoRollMockup,
        steps = {
            L["Search for items and assign need, greed or pass per item"],
            L["When a Gargul roll is announced, your roll happens automatically"],
            L["Only works with Gargul rolls, not group loot"],
        },
        buttonText = L["Set up Auto Roll"],
        action = function ()
            Onboarding:close();
            GL.Settings:draw("AutoRollRules");
        end,
    });

    ---@type Frame
    local Window = Interface:createWindow({
        name = self.windowName,
        width = WINDOW_WIDTH,
        height = WINDOW_HEIGHT,
        minWidth = 580,
        minHeight = 480,
        maxWidth = 740,
        maxHeight = 620,
        hideMinimizeButton = true,
        hideWatermark = true,
    });

    Window.currentSlide = 1;
    Window.Slides = {};

    local SlideLabel = Interface:createFontString(Window, ("%s %d/%d"):format(L["Quick start"], 1, #SlidesConfig));
    SlideLabel:SetPoint("TOP", Window, "TOP", 0, -16);
    SlideLabel:SetFont(1.5, "OUTLINE");
    Window.SlideLabel = SlideLabel;

    for _, cfg in ipairs(SlidesConfig) do
        local Slide = buildSlide(Window, cfg);
        table.insert(Window.Slides, Slide);
    end

    local BackBtn = Interface:dynamicPanelButton(Window, L["Back"]);
    BackBtn:GetFontString():SetFont(1.2, "");
    BackBtn:SetText(L["Back"]);
    BackBtn:SetPoint("BOTTOMLEFT", Window, "BOTTOMLEFT", 24, 20);
    BackBtn:SetScript("OnClick", function ()
        Onboarding:showSlide((Window.currentSlide or 1) - 1);
    end);
    Window.BackButton = BackBtn;

    local NextBtn = Interface:dynamicPanelButton(Window, L["Next"]);
    NextBtn:GetFontString():SetFont(1.2, "");
    NextBtn:SetText(L["Next"]);
    NextBtn:SetPoint("BOTTOMRIGHT", Window, "BOTTOMRIGHT", -24, 20);
    NextBtn:SetScript("OnClick", function ()
        local total = #Window.Slides;
        local cur = Window.currentSlide or 1;
        if (cur >= total) then
            Onboarding:close();
        else
            Onboarding:showSlide(cur + 1);
        end
    end);
    Window.NextButton = NextBtn;

    _G[self.windowName] = Window;
    return Window;
end

GL:debug("Interface/Onboarding.lua");
