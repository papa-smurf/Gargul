---@type GL
local _, GL = ...;
local L = Gargul_L;
local LCG = LibStub("LibCustomGlowGargul-1.0");

---@type Interface
local Interface = GL.Interface;

--[[ CONSTANTS ]]
local DEFAULT = "default";

---@class IdentityInterface
GL.Interface.Identity = {

    --[[ ================== DEFAULT ================== ]]
    [DEFAULT] = {
        id = DEFAULT,
        url = "https://discord.gg/gX3QUWE5cq",
        urlInfo = "Visit the URL below to learn more about personalizing Gargul GDKPs",
        tooltip = "Your logo here? Click for more info!",
        cutMailSubject = L.CUT_MAIL_SUBJECT,

        ---@return Frame
        ledger = function()
            local Identity = GL.Interface.Identity.default;

            ---@type Frame
            local Window = CreateFrame("Frame", nil, UIParent);
            Window:SetSize(80, 80);
            Interface:addTooltip(Window, Identity.tooltip);

            ---@type Texture
            local Logo = Window:CreateTexture();
            Logo:SetTexture("Interface/AddOns/Gargul/Assets/Identities/" .. Identity.id);
            Logo:SetAllPoints();

            Window:SetScript("OnMouseUp", function(_, button)
                if (button == 'LeftButton') then
                    GL.Interface.Dialogs.HyperlinkDialog:open{
                        description = Identity.urlInfo,
                        hyperlink = Identity.url,
                    };
                end
            end);

            LCG.PixelGlow_Stop(Window);
            LCG.PixelGlow_Start(Window, {.59, .5, .82, 1}, 26, .02, 5, 2);

            return Window;
        end,

        ---@return Frame
        multiAuctionClient = function ()
            local Identity = GL.Interface.Identity.default;

            ---@type Frame
            local Window = CreateFrame("Frame", nil, UIParent, "BackdropTemplate");
            Window:SetSize(110, 110);
            Window:SetBackdrop(_G.BACKDROP_DARK_DIALOG_32_32);
            Interface:addTooltip(Window, Identity.tooltip);

            ---@type Texture
            local Logo = Window:CreateTexture();
            Logo:SetPoint("CENTER", Window, "CENTER", 0, -1);
            Logo:SetSize(74, 74);
            Logo:SetTexture("Interface/AddOns/Gargul/Assets/Identities/" .. Identity.id);

            ---@type FontString
            local TextTop = Interface:createFontString(Window, "Gargul");
            TextTop:SetPoint("CENTER", Window, "CENTER");
            TextTop:SetPoint("TOP", Window, "TOP", 0, -13);
            TextTop:SetFont(1.1, "OUTLINE");

            ---@type FontString
            local TextBottom = Interface:createFontString(Window, "GDKP");
            TextBottom:SetPoint("CENTER", Window, "CENTER");
            TextBottom:SetPoint("BOTTOM", Window, "BOTTOM", 0, 11);
            TextBottom:SetFont(1.1, "OUTLINE");

            Window:SetScript("OnMouseUp", function(_, button)
                if (button == 'LeftButton') then
                    GL.Interface.Dialogs.HyperlinkDialog:open{
                        description = Identity.urlInfo,
                        hyperlink = Identity.url,
                    };
                end
            end);

            return Window;
        end,

        ---@return Frame
        bidder = function ()
            local Identity = GL.Interface.Identity.default;

            ---@type Frame
            local Window = CreateFrame("Frame", nil, UIParent);
            Window:SetSize(92, 98);

            local Texture = Window:CreateTexture(nil, "BACKGROUND");
            Texture:SetColorTexture(0, 0, 0, .6);
            Texture:SetPoint("TOPLEFT", Window, "TOPLEFT", 0, -2);
            Texture:SetPoint("TOPRIGHT", Window, "TOPRIGHT", 0, -2);
            Texture:SetPoint("BOTTOMLEFT", Window, "BOTTOMLEFT");
            Texture:SetPoint("BOTTOMRIGHT", Window, "BOTTOMRIGHT");

            ---@type Texture
            local Logo = Window:CreateTexture();
            Logo:SetPoint("CENTER", Window, "CENTER");
            Logo:SetSize(72, 72);
            Logo:SetTexture("Interface/AddOns/Gargul/Assets/Identities/" .. Identity.id);

            ---@type FontString
            local TextTop = Interface:createFontString(Window, "Gargul");
            TextTop:SetPoint("CENTER", Window, "CENTER");
            TextTop:SetPoint("TOP", Window, "TOP", 0, -5);
            TextTop:SetFont(1.2, "OUTLINE");

            ---@type FontString
            local TextBottom = Interface:createFontString(Window, "GDKP");
            TextBottom:SetPoint("CENTER", Window, "CENTER");
            TextBottom:SetPoint("BOTTOM", Window, "BOTTOM", 0, 2);
            TextBottom:SetFont(1.2, "OUTLINE");

            -- Let raid leaders know that they can personalize Gargul
            if (not GL.User.isInGroup or (GL.User.isMasterLooter or GL.User.isLead)) then
                Interface:addTooltip(Window, Identity.tooltip);

                Window:SetScript("OnMouseUp", function(_, button)
                    if (button == 'LeftButton') then
                        GL.Interface.Dialogs.HyperlinkDialog:open{
                            description = Identity.urlInfo,
                            hyperlink = Identity.url,
                        };
                    end
                end);
            end

            return Window, function (Element, Anchor)
                Element:SetPoint("TOPRIGHT", Anchor, "TOPLEFT", -6, 2);
            end;
        end,

        ---@return Frame
        roller = function ()
            local Identity = GL.Interface.Identity.default;

            ---@type Frame
            local Window = CreateFrame("Frame", nil, UIParent);
            Window:SetSize(48, 48);

            local Texture = Window:CreateTexture(nil, "BACKGROUND");
            Texture:SetColorTexture(0, 0, 0, .6);
            Texture:SetAllPoints(Window);

            ---@type Texture
            local Logo = Window:CreateTexture();
            Logo:SetPoint("CENTER", Window, "CENTER", 0, 1);
            Logo:SetSize(54, 54);
            Logo:SetTexture("Interface/AddOns/Gargul/Assets/Identities/" .. Identity.id);

            ---@type FontString
            local Text = Interface:createFontString(Window, "Gargul");
            Text:SetPoint("CENTER", Window, "CENTER");
            Text:SetPoint("BOTTOM", Window, "BOTTOM", 1, -5);
            Text:SetFont(1.1, "OUTLINE");

            -- Let raid leaders know that they can personalize Gargul
            if (not GL.User.isInGroup or (GL.User.isMasterLooter or GL.User.isLead)) then
                Interface:addTooltip(Window, Identity.tooltip);

                Window:SetScript("OnMouseUp", function(_, button)
                    if (button == 'LeftButton') then
                        GL.Interface.Dialogs.HyperlinkDialog:open{
                            description = Identity.urlInfo,
                            hyperlink = Identity.url,
                        };
                    end
                end);
            end

            return Window, function (Element, Anchor)
                Element:SetPoint("TOPRIGHT", Anchor, "TOPLEFT", -4, 0);
            end;
        end,
    },

    --[[ ================== EVERLOOK ================== ]]
    ["4095158674-3607791837"] = {
        id = "everlook",
        url = "https://discord.gg/gdkpeverlook",
        urlInfo = "Küsschen auf dein ...",
        tooltip = "GDKP Everlook Discord",
        cutMailSubject = "GDKP Everlook Cut: %sg",
        Realms = { "everlook" },

        ---@return Frame
        ledger = function()
            local Identity = GL.Interface.Identity["4095158674-3607791837"];

            ---@type Frame
            local Window = CreateFrame("Frame", nil, UIParent);
            Window:SetSize(80, 80);
            Interface:addTooltip(Window, Identity.tooltip);

            ---@type Texture
            local Logo = Window:CreateTexture();
            Logo:SetTexture("Interface/AddOns/Gargul/Assets/Identities/" .. Identity.id);
            Logo:SetPoint("CENTER", Window, "CENTER");
            Logo:SetSize(74, 74);

            Window:SetScript("OnMouseUp", function(_, button)
                if (button == 'LeftButton') then
                    GL.Interface.Dialogs.HyperlinkDialog:open{
                        description = Identity.urlInfo,
                        hyperlink = Identity.url,
                    };
                end
            end);

            LCG.PixelGlow_Stop(Window);
            LCG.PixelGlow_Start(Window, {.59, .5, .82, 1}, 26, .02, 5, 2);

            return Window;
        end,

        ---@return Frame
        multiAuctionClient = function ()
            local Identity = GL.Interface.Identity["4095158674-3607791837"];

            ---@type Frame
            local Window = CreateFrame("Frame", nil, UIParent, "BackdropTemplate");
            Window:SetSize(110, 110);
            Window:SetBackdrop(_G.BACKDROP_DARK_DIALOG_32_32);
            Interface:addTooltip(Window, Identity.tooltip);

            ---@type Texture
            local Logo = Window:CreateTexture();
            Logo:SetPoint("CENTER", Window, "CENTER", 0, 5);
            Logo:SetSize(75, 75);
            Logo:SetTexture("Interface/AddOns/Gargul/Assets/Identities/" .. Identity.id);

            ---@type FontString
            local Text = Interface:createFontString(Window, "GDKP Everlook");
            Text:SetPoint("CENTER", Window, "CENTER");
            Text:SetPoint("BOTTOM", Window, "BOTTOM", 0, 11);
            Text:SetFont(1, "OUTLINE");
            Text:SetColor("bc9968");

            LCG.PixelGlow_Stop(Window);
            LCG.PixelGlow_Start(Window, {.59, .5, .82, 1}, 26, .02, 5, 2);

            Window:SetScript("OnMouseUp", function(_, button)
                if (button == 'LeftButton') then
                    GL.Interface.Dialogs.HyperlinkDialog:open{
                        description = Identity.urlInfo,
                        hyperlink = Identity.url,
                    };
                end
            end);

            return Window;
        end,

        ---@return Frame
        bidder = function ()
            local Identity = GL.Interface.Identity["4095158674-3607791837"];

            ---@type Frame
            local Window = CreateFrame("Frame", nil, UIParent);
            Window:SetSize(92, 98);

            local Texture = Window:CreateTexture(nil, "BACKGROUND");
            Texture:SetColorTexture(0, 0, 0, .6);
            Texture:SetPoint("TOPLEFT", Window, "TOPLEFT", 0, -2);
            Texture:SetPoint("TOPRIGHT", Window, "TOPRIGHT", 0, -2);
            Texture:SetPoint("BOTTOMLEFT", Window, "BOTTOMLEFT");
            Texture:SetPoint("BOTTOMRIGHT", Window, "BOTTOMRIGHT");

            ---@type Texture
            local Logo = Window:CreateTexture();
            Logo:SetPoint("CENTER", Window, "CENTER");
            Logo:SetSize(88, 88);
            Logo:SetTexture("Interface/AddOns/Gargul/Assets/Identities/" .. Identity.id);

            ---@type FontString
            local Text = Interface:createFontString(Window, "GDKP Everlook");
            Text:SetPoint("CENTER", Window, "CENTER");
            Text:SetPoint("BOTTOM", Window, "BOTTOM", 0, 3);
            Text:SetFont(1.1, "OUTLINE");
            Text:SetColor("bc9968");

            Interface:addTooltip(Window, Identity.tooltip);
            Window:SetScript("OnMouseUp", function(_, button)
                if (button == 'LeftButton') then
                    GL.Interface.Dialogs.HyperlinkDialog:open{
                        description = Identity.urlInfo,
                        hyperlink = Identity.url,
                    };
                end
            end);

            return Window;
        end,

        ---@return Frame
        roller = function ()
            local Identity = GL.Interface.Identity["4095158674-3607791837"];

            ---@type Frame
            local Window = CreateFrame("Frame", nil, UIParent);
            Window:SetSize(48, 48);

            local Texture = Window:CreateTexture(nil, "BACKGROUND");
            Texture:SetColorTexture(0, 0, 0, .6);
            Texture:SetAllPoints(Window);

            ---@type Texture
            local Logo = Window:CreateTexture();
            Logo:SetPoint("CENTER", Window, "CENTER");
            Logo:SetSize(44, 44);
            Logo:SetTexture("Interface/AddOns/Gargul/Assets/Identities/" .. Identity.id);

            Interface:addTooltip(Window, Identity.tooltip);

            Window:SetScript("OnMouseUp", function(_, button)
                if (button == 'LeftButton') then
                    GL.Interface.Dialogs.HyperlinkDialog:open{
                        description = Identity.urlInfo,
                        hyperlink = Identity.url,
                    };
                end
            end);

            return Window, function (Element, Anchor)
                Element:SetPoint("TOPRIGHT", Anchor, "TOPLEFT", -4, 0);
            end;
        end,
    },

    --[[ ================== GARGUL  ================== ]]
    ["54402906-2451533554"] = {
        id = "gargul",
        url = "https://discord.com/invite/5Nvcrt4u",
        urlInfo = "Join our Discord server to learn more about our guild and joining our ranks!",
        tooltip = "Gargul is recruiting, click for more info!",
        cutMailSubject = L.CUT_MAIL_SUBJECT,
        Realms = { "firemaw", },

        ---@return Frame
        ledger = function()
            local Identity = GL.Interface.Identity["54402906-2451533554"];

            ---@type Frame
            local Window = CreateFrame("Frame", nil, UIParent);
            Window:SetSize(80, 80);
            Interface:addTooltip(Window, Identity.tooltip);

            ---@type Texture
            local Logo = Window:CreateTexture();
            Logo:SetTexture("Interface/AddOns/Gargul/Assets/Identities/" .. Identity.id);
            Logo:SetAllPoints();

            Window:SetScript("OnMouseUp", function(_, button)
                if (button == 'LeftButton') then
                    GL.Interface.Dialogs.HyperlinkDialog:open{
                        description = Identity.urlInfo,
                        hyperlink = Identity.url,
                    };
                end
            end);

            LCG.PixelGlow_Stop(Window);
            LCG.PixelGlow_Start(Window, {.59, .5, .82, 1}, 26, .02, 5, 2);

            return Window;
        end,

        ---@return Frame
        multiAuctionClient = function ()
            local Identity = GL.Interface.Identity["54402906-2451533554"];

            ---@type Frame
            local Window = CreateFrame("Frame", nil, UIParent, "BackdropTemplate");
            Window:SetSize(110, 110);
            Window:SetBackdrop(_G.BACKDROP_DARK_DIALOG_32_32);
            Interface:addTooltip(Window, Identity.tooltip);

            ---@type Texture
            local Logo = Window:CreateTexture();
            Logo:SetPoint("CENTER", Window, "CENTER");
            Logo:SetSize(74, 74);
            Logo:SetTexture("Interface/AddOns/Gargul/Assets/Identities/" .. Identity.id);

            ---@type FontString
            local Text = Interface:createFontString(Window, "Gargul");
            Text:SetPoint("CENTER", Window, "CENTER");
            Text:SetPoint("BOTTOM", Window, "BOTTOM", 0, 11);
            Text:SetFont(1.4, "OUTLINE");

            Window:SetScript("OnMouseUp", function(_, button)
                if (button == 'LeftButton') then
                    GL.Interface.Dialogs.HyperlinkDialog:open{
                        description = Identity.urlInfo,
                        hyperlink = Identity.url,
                    };
                end
            end);

            return Window;
        end,

        ---@return Frame
        bidder = function ()
            local Identity = GL.Interface.Identity["54402906-2451533554"];

            ---@type Frame
            local Window = CreateFrame("Frame", nil, UIParent);
            Window:SetSize(92, 98);

            local Texture = Window:CreateTexture(nil, "BACKGROUND");
            Texture:SetColorTexture(0, 0, 0, .6);
            Texture:SetPoint("TOPLEFT", Window, "TOPLEFT", 0, -2);
            Texture:SetPoint("TOPRIGHT", Window, "TOPRIGHT", 0, -2);
            Texture:SetPoint("BOTTOMLEFT", Window, "BOTTOMLEFT");
            Texture:SetPoint("BOTTOMRIGHT", Window, "BOTTOMRIGHT");

            ---@type Texture
            local Logo = Window:CreateTexture();
            Logo:SetPoint("CENTER", Window, "CENTER", 0, 2);
            Logo:SetSize(76, 76);
            Logo:SetTexture("Interface/AddOns/Gargul/Assets/Identities/" .. Identity.id);

            ---@type FontString
            local Text = Interface:createFontString(Window, "Gargul");
            Text:SetPoint("CENTER", Window, "CENTER");
            Text:SetPoint("BOTTOM", Window, "BOTTOM", 0, 2);
            Text:SetFont(1.4, "OUTLINE");

            Interface:addTooltip(Window, Identity.tooltip);
            Window:SetScript("OnMouseUp", function(_, button)
                if (button == 'LeftButton') then
                    GL.Interface.Dialogs.HyperlinkDialog:open{
                        description = Identity.urlInfo,
                        hyperlink = Identity.url,
                    };
                end
            end);

            return Window, function (Element, Anchor)
                Element:SetPoint("TOPRIGHT", Anchor, "TOPLEFT", -6, 2);
            end;
        end,

        ---@return Frame
        roller = function ()
            local Identity = GL.Interface.Identity["54402906-2451533554"];

            ---@type Frame
            local Window = CreateFrame("Frame", nil, UIParent);
            Window:SetSize(48, 48);

            local Texture = Window:CreateTexture(nil, "BACKGROUND");
            Texture:SetColorTexture(0, 0, 0, .6);
            Texture:SetAllPoints(Window);

            ---@type Texture
            local Logo = Window:CreateTexture();
            Logo:SetPoint("CENTER", Window, "CENTER");
            Logo:SetSize(44, 44);
            Logo:SetTexture("Interface/AddOns/Gargul/Assets/Identities/" .. Identity.id);

            ---@type FontString
            local Text = Interface:createFontString(Window, "Gargul");
            Text:SetPoint("CENTER", Window, "CENTER");
            Text:SetPoint("BOTTOM", Window, "BOTTOM", 1, -4);
            Text:SetFont(1.2, "OUTLINE");

            Interface:addTooltip(Window, Identity.tooltip);
            Window:SetScript("OnMouseUp", function(_, button)
                if (button == 'LeftButton') then
                    GL.Interface.Dialogs.HyperlinkDialog:open{
                        description = Identity.urlInfo,
                        hyperlink = Identity.url,
                    };
                end
            end);

            return Window, function (Element, Anchor)
                Element:SetPoint("TOPRIGHT", Anchor, "TOPLEFT", -4, 0);
            end;
        end,
    },

    --[[ ================== STEEL ================== ]]
    ["2728411460-1372754882"] = {
        id = "steel",
        url = "https://discord.gg/928Dc9Pb",
        urlInfo = "Follow Steel, Whitemane's most popular GDKP host!",
        tooltip = "Follow Steel on Discord",
        cutMailSubject = "STEEL GDKP: %sg",
        Realms = { "whitemane", },

        ---@return Frame
        ledger = function()
            local Identity = GL.Interface.Identity["2728411460-1372754882"];

            ---@type Frame
            local Window = CreateFrame("Frame", nil, UIParent);
            Window:SetSize(80, 80);
            Interface:addTooltip(Window, Identity.tooltip);

            ---@type Texture
            local Logo = Window:CreateTexture();
            Logo:SetTexture("Interface/AddOns/Gargul/Assets/Identities/" .. Identity.id);
            Logo:SetAllPoints();

            Window:SetScript("OnMouseUp", function(_, button)
                if (button == 'LeftButton') then
                    GL.Interface.Dialogs.HyperlinkDialog:open{
                        description = Identity.urlInfo,
                        hyperlink = Identity.url,
                    };
                end
            end);

            LCG.PixelGlow_Stop(Window);
            LCG.PixelGlow_Start(Window, {.59, .5, .82, 1}, 26, .02, 5, 2);

            return Window;
        end,

        ---@return Frame
        multiAuctionClient = function ()
            local Identity = GL.Interface.Identity["2728411460-1372754882"];

            ---@type Frame
            local Window = CreateFrame("Frame", nil, UIParent, "BackdropTemplate");
            Window:SetSize(110, 110);
            Window:SetBackdrop(_G.BACKDROP_DARK_DIALOG_32_32);
            Interface:addTooltip(Window, Identity.tooltip);

            ---@type Texture
            local Logo = Window:CreateTexture();
            Logo:SetPoint("CENTER", Window, "CENTER", 0, -1);
            Logo:SetSize(74, 74);
            Logo:SetTexture("Interface/AddOns/Gargul/Assets/Identities/" .. Identity.id);

            ---@type FontString
            local TextTop = Interface:createFontString(Window, "FOLLOW");
            TextTop:SetPoint("CENTER", Window, "CENTER");
            TextTop:SetPoint("TOP", Window, "TOP", 0, -13);
            TextTop:SetFont(1.1, "OUTLINE");

            ---@type FontString
            local TextBottom = Interface:createFontString(Window, "STEEL");
            TextBottom:SetPoint("CENTER", Window, "CENTER");
            TextBottom:SetPoint("BOTTOM", Window, "BOTTOM", 0, 11);
            TextBottom:SetFont(1.1, "OUTLINE");

            Window:SetScript("OnMouseUp", function(_, button)
                if (button == 'LeftButton') then
                    GL.Interface.Dialogs.HyperlinkDialog:open{
                        description = Identity.urlInfo,
                        hyperlink = Identity.url,
                    };
                end
            end);

            return Window;
        end,

        ---@return Frame
        bidder = function ()
            local Identity = GL.Interface.Identity["2728411460-1372754882"];

            ---@type Frame
            local Window = CreateFrame("Frame", nil, UIParent);
            Window:SetSize(92, 98);

            local Texture = Window:CreateTexture(nil, "BACKGROUND");
            Texture:SetColorTexture(0, 0, 0, .6);
            Texture:SetPoint("TOPLEFT", Window, "TOPLEFT", 0, -2);
            Texture:SetPoint("TOPRIGHT", Window, "TOPRIGHT", 0, -2);
            Texture:SetPoint("BOTTOMLEFT", Window, "BOTTOMLEFT");
            Texture:SetPoint("BOTTOMRIGHT", Window, "BOTTOMRIGHT");

            ---@type Texture
            local Logo = Window:CreateTexture();
            Logo:SetPoint("CENTER", Window, "CENTER");
            Logo:SetSize(72, 72);
            Logo:SetTexture("Interface/AddOns/Gargul/Assets/Identities/" .. Identity.id);

            ---@type FontString
            local TextTop = Interface:createFontString(Window, "FOLLOW");
            TextTop:SetPoint("CENTER", Window, "CENTER");
            TextTop:SetPoint("TOP", Window, "TOP", 0, -5);
            TextTop:SetFont(1.2, "OUTLINE");

            ---@type FontString
            local TextBottom = Interface:createFontString(Window, "STEEL");
            TextBottom:SetPoint("CENTER", Window, "CENTER");
            TextBottom:SetPoint("BOTTOM", Window, "BOTTOM", 0, 2);
            TextBottom:SetFont(1.2, "OUTLINE");

            Interface:addTooltip(Window, Identity.tooltip);
            Window:SetScript("OnMouseUp", function(_, button)
                if (button == 'LeftButton') then
                    GL.Interface.Dialogs.HyperlinkDialog:open{
                        description = Identity.urlInfo,
                        hyperlink = Identity.url,
                    };
                end
            end);

            return Window;
        end,

        ---@return Frame
        roller = function ()
            local Identity = GL.Interface.Identity["2728411460-1372754882"];

            ---@type Frame
            local Window = CreateFrame("Frame", nil, UIParent);
            Window:SetSize(48, 48);

            local Texture = Window:CreateTexture(nil, "BACKGROUND");
            Texture:SetColorTexture(0, 0, 0, .6);
            Texture:SetAllPoints(Window);

            ---@type Texture
            local Logo = Window:CreateTexture();
            Logo:SetPoint("CENTER", Window, "CENTER");
            Logo:SetSize(48, 48);
            Logo:SetTexture("Interface/AddOns/Gargul/Assets/Identities/" .. Identity.id);

            ---@type FontString
            local Text = Interface:createFontString(Window, "STEEL");
            Text:SetPoint("CENTER", Window, "CENTER");
            Text:SetPoint("BOTTOM", Window, "BOTTOM", 0, -5);
            Text:SetFont(1.1, "OUTLINE");

            Interface:addTooltip(Window, Identity.tooltip);
            Window:SetScript("OnMouseUp", function(_, button)
                if (button == 'LeftButton') then
                    GL.Interface.Dialogs.HyperlinkDialog:open{
                        description = Identity.urlInfo,
                        hyperlink = Identity.url,
                    };
                end
            end);

            return Window, function (Element, Anchor)
                Element:SetPoint("TOPRIGHT", Anchor, "TOPLEFT", -4, 0);
            end;
        end,
    },

    --[[ ================== GOLD BOYS ================== ]]
    ["3666447951-3772521060"] = {
        id = "goldboys",
        url = "https://discord.gg/agZUUaypWq",
        urlInfo = "Join our Discord server to learn more about Gold Boys!",
        tooltip = "Gold Boys discord",
        cutMailSubject = L.CUT_MAIL_SUBJECT,
        Realms = { "pyrewoodvillage" },

        ---@return Frame
        ledger = function()
            local Identity = GL.Interface.Identity["3666447951-3772521060"];

            ---@type Frame
            local Window = CreateFrame("Frame", nil, UIParent);
            Window:SetSize(80, 80);
            Interface:addTooltip(Window, Identity.tooltip);

            ---@type Texture
            local Logo = Window:CreateTexture();
            Logo:SetTexture("Interface/AddOns/Gargul/Assets/Identities/" .. Identity.id);
            Logo:SetPoint("CENTER", Window, "CENTER");
            Logo:SetSize(74, 74);

            Window:SetScript("OnMouseUp", function(_, button)
                if (button == 'LeftButton') then
                    GL.Interface.Dialogs.HyperlinkDialog:open{
                        description = Identity.urlInfo,
                        hyperlink = Identity.url,
                    };
                end
            end);

            LCG.PixelGlow_Stop(Window);
            LCG.PixelGlow_Start(Window, {.59, .5, .82, 1}, 26, .02, 5, 2);

            return Window;
        end,

        ---@return Frame
        multiAuctionClient = function ()
            local Identity = GL.Interface.Identity["3666447951-3772521060"];

            ---@type Frame
            local Window = CreateFrame("Frame", nil, UIParent, "BackdropTemplate");
            Window:SetSize(110, 110);
            Window:SetBackdrop(_G.BACKDROP_DARK_DIALOG_32_32);
            Interface:addTooltip(Window, Identity.tooltip);

            ---@type Texture
            local Logo = Window:CreateTexture();
            Logo:SetPoint("CENTER", Window, "CENTER", 0, 5);
            Logo:SetSize(75, 75);
            Logo:SetTexture("Interface/AddOns/Gargul/Assets/Identities/" .. Identity.id);

            ---@type FontString
            local Text = Interface:createFontString(Window, "Gold Boys");
            Text:SetPoint("CENTER", Window, "CENTER");
            Text:SetPoint("BOTTOM", Window, "BOTTOM", 0, 11);
            Text:SetFont(1, "OUTLINE");
            Text:SetColor("bc9968");

            Window:SetScript("OnMouseUp", function(_, button)
                if (button == 'LeftButton') then
                    GL.Interface.Dialogs.HyperlinkDialog:open{
                        description = Identity.urlInfo,
                        hyperlink = Identity.url,
                    };
                end
            end);

            return Window;
        end,

        ---@return Frame
        bidder = function ()
            local Identity = GL.Interface.Identity["3666447951-3772521060"];

            ---@type Frame
            local Window = CreateFrame("Frame", nil, UIParent);
            Window:SetSize(80, 90);

            ---@type Texture
            local Logo = Window:CreateTexture();
            Logo:SetPoint("CENTER", Window, "CENTER");
            Logo:SetSize(80, 80);
            Logo:SetTexture("Interface/AddOns/Gargul/Assets/Identities/" .. Identity.id);

            ---@type FontString
            local Text = Interface:createFontString(Window, "Gold Boys");
            Text:SetPoint("CENTER", Window, "CENTER");
            Text:SetPoint("BOTTOM", Window, "BOTTOM", 0, 2);
            Text:SetFont(1.1, "OUTLINE");
            Text:SetColor("bc9968");

            Interface:addTooltip(Window, Identity.tooltip);

            Window:SetScript("OnMouseUp", function(_, button)
                if (button == 'LeftButton') then
                    GL.Interface.Dialogs.HyperlinkDialog:open{
                        description = Identity.urlInfo,
                        hyperlink = Identity.url,
                    };
                end
            end);

            return Window, function (Element, Anchor)
                Element:SetPoint("TOPRIGHT", Anchor, "TOPLEFT", -6, -2);
            end;
        end,

        ---@return Frame
        roller = function ()
            local Identity = GL.Interface.Identity["3666447951-3772521060"];

            ---@type Frame
            local Window = CreateFrame("Frame", nil, UIParent);
            Window:SetSize(48, 48);

            ---@type Texture
            local Logo = Window:CreateTexture();
            Logo:SetPoint("CENTER", Window, "CENTER");
            Logo:SetSize(44, 44);
            Logo:SetTexture("Interface/AddOns/Gargul/Assets/Identities/" .. Identity.id);

            Interface:addTooltip(Window, Identity.tooltip);

            Window:SetScript("OnMouseUp", function(_, button)
                if (button == 'LeftButton') then
                    GL.Interface.Dialogs.HyperlinkDialog:open{
                        description = Identity.urlInfo,
                        hyperlink = Identity.url,
                    };
                end
            end);

            return Window, function (Element, Anchor)
                Element:SetPoint("TOPRIGHT", Anchor, "TOPLEFT", -4, 0);
            end;
        end,
    },

    --[[ ================== XIPPO  ================== ]]
    ["86558097-712084183"] = {
        id = "xippo",
        cutMailSubject = L.CUT_MAIL_SUBJECT,
        Realms = { "faerlina", },

        ---@return Frame
        ledger = function()
            local Identity = GL.Interface.Identity["86558097-712084183"];

            ---@type Frame
            local Window = CreateFrame("Frame", nil, UIParent);
            Window:SetSize(80, 80);
            Interface:addTooltip(Window, Identity.tooltip);

            ---@type Texture
            local Logo = Window:CreateTexture();
            Logo:SetTexture("Interface/AddOns/Gargul/Assets/Identities/" .. Identity.id);
            Logo:SetAllPoints();

            LCG.PixelGlow_Stop(Window);
            LCG.PixelGlow_Start(Window, {.59, .5, .82, 1}, 26, .02, 5, 2);

            return Window;
        end,

        ---@return Frame
        multiAuctionClient = function ()
            local Identity = GL.Interface.Identity["86558097-712084183"];

            ---@type Frame
            local Window = CreateFrame("Frame", nil, UIParent, "BackdropTemplate");
            Window:SetSize(110, 110);
            Window:SetBackdrop(_G.BACKDROP_DARK_DIALOG_32_32);
            Interface:addTooltip(Window, Identity.tooltip);

            ---@type Texture
            local Logo = Window:CreateTexture();
            Logo:SetPoint("CENTER", Window, "CENTER");
            Logo:SetSize(74, 74);
            Logo:SetTexture("Interface/AddOns/Gargul/Assets/Identities/" .. Identity.id);

            return Window;
        end,

        ---@return Frame
        bidder = function ()
            local Identity = GL.Interface.Identity["86558097-712084183"];

            ---@type Frame
            local Window = CreateFrame("Frame", nil, UIParent);
            Window:SetSize(95, 95);

            ---@type Texture
            local Logo = Window:CreateTexture();
            Logo:SetAllPoints(Window);
            Logo:SetTexture("Interface/AddOns/Gargul/Assets/Identities/" .. Identity.id);

            return Window, function (Element, Anchor)
                Element:SetPoint("TOPRIGHT", Anchor, "TOPLEFT", -6, 0);
            end;
        end,

        ---@return Frame
        roller = function ()
            local Identity = GL.Interface.Identity["86558097-712084183"];

            ---@type Frame
            local Window = CreateFrame("Frame", nil, UIParent);
            Window:SetSize(48, 48);

            ---@type Texture
            local Logo = Window:CreateTexture();
            Logo:SetAllPoints(Window);
            Logo:SetTexture("Interface/AddOns/Gargul/Assets/Identities/" .. Identity.id);

            return Window, function (Element, Anchor)
                Element:SetPoint("TOPRIGHT", Anchor, "TOPLEFT", -4, 0);
            end;
        end,
    },
};
local Identity = GL.Interface.Identity;

--[[ EVERLOOK ALIASES ]]
Identity["1693251292-4038511571"] = Identity["4095158674-3607791837"];
Identity["899545035-811854049"] = Identity["4095158674-3607791837"];
Identity["4246247173-217891525"] = Identity["4095158674-3607791837"];
Identity["60536489-2522607623"] = Identity["4095158674-3607791837"];
Identity["3825630290-2352514161"] = Identity["4095158674-3607791837"];
Identity["991876154-338457788"] = Identity["4095158674-3607791837"];
Identity["2721348070-2296142268"] = Identity["4095158674-3607791837"];
Identity["2288484345-3562407233"] = Identity["4095158674-3607791837"];
Identity["301466391-3279526899"] = Identity["4095158674-3607791837"];
Identity["2895629043-3084611412"] = Identity["4095158674-3607791837"];
Identity["3188539266-4063358498"] = Identity["4095158674-3607791837"];
Identity["1784466978-533458395"] = Identity["4095158674-3607791837"];
Identity["3110547987-1844148009"] = Identity["4095158674-3607791837"];
Identity["2425115384-2043966142"] = Identity["4095158674-3607791837"];

--[[ GARGUL ALIASES ]]
Identity["126782309-4184359051"] = Identity["54402906-2451533554"];
Identity["4091637282-1561179"] = Identity["54402906-2451533554"];
Identity["3046712350-2962835883"] = Identity["54402906-2451533554"];
Identity["2644832658-2651387317"] = Identity["54402906-2451533554"];

--[[ XIPPO ALIASES ]]
Identity["4209972553-3499284415"] = Identity["86558097-712084183"];
Identity["2208482902-2275005731"] = Identity["86558097-712084183"];
Identity["2724529675-176490976"] = Identity["86558097-712084183"];

---@param identifier string
---
---@return string
function Identity:build(identifier)
    identifier = identifier or DEFAULT;

    local Instance = self[identifier] and self[identifier] or self[DEFAULT];
    if (Instance.Realms
        and not GL:inTable(Instance.Realms, GL.User.realm)
    ) then
        Instance = self[DEFAULT];
    end

    return Instance;
end

---@param identifier string
---@return Frame
function Identity:buildForLedger(identifier)
    local Instance = self:build(identifier);
    identifier = identifier or DEFAULT;

    if (Instance.ledger) then
        return Instance:ledger();
    end

    return self[DEFAULT]:ledger();
end

---@param identifier string
---@return Frame
function Identity:buildForMultiAuctionClient(identifier)
    local Instance = self:build(identifier);
    identifier = identifier or DEFAULT;

    if (Instance.multiAuctionClient) then
        return Instance:multiAuctionClient();
    end

    return self[DEFAULT]:multiAuctionClient();
end

---@param identifier string
---@return Frame
function Identity:buildForBidder(identifier)
    local Instance = self:build(identifier);
    identifier = identifier or DEFAULT;

    if (Instance.bidder) then
        return Instance:bidder();
    end

    return self[DEFAULT]:bidder();
end

---@param identifier string
---@return Frame
function Identity:buildForRoller(identifier)
    local Instance = self:build(identifier);
    identifier = identifier or DEFAULT;

    if (Instance.roller) then
        return Instance.roller();
    end

    return self[DEFAULT]:roller();
end

---@param identifier string
---@param method string
---
---@return string
function Identity:getForMethod(identifier, method)
    identifier = identifier or DEFAULT;

    return GL:tableGet(self, ("%s.%s"):format(identifier, method)) and identifier or DEFAULT;
end