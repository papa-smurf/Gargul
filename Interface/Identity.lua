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
        url = "https://discord.gg/D3mDhYPVzf",
        urlInfo = "Visit the URL below to learn more about personalizing Gargul GDKPs",
        tooltip = "Your logo here? Click for more info!",
        cutMailSubject = L.CUT_MAIL_SUBJECT,

        ---@return Frame
        ledger = function()
            local Identity = GL.Interface.Identity.default;

            ---@type Frame
            local Window = CreateFrame("Frame", nil, UIParent);
            Window:SetSize(80, 80);
            Interface:addTooltip(Window, Identity.tooltip, "TOP");

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
            Interface:addTooltip(Window, Identity.tooltip, "TOP");

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
                Interface:addTooltip(Window, Identity.tooltip, "TOP");

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
            Texture:SetAllPoints(Window)

            ---@type Texture
            local Logo = Window:CreateTexture();
            Logo:SetPoint("CENTER", Window, "CENTER", 0, 1);
            Logo:SetSize(40, 40);
            Logo:SetTexture("Interface/AddOns/Gargul/Assets/Identities/" .. Identity.id);

            ---@type FontString
            local Text = Interface:createFontString(Window, "Gargul");
            Text:SetPoint("CENTER", Window, "CENTER");
            Text:SetPoint("BOTTOM", Window, "BOTTOM", 1, -5);
            Text:SetFont(1.1, "OUTLINE");

            -- Let raid leaders know that they can personalize Gargul
            if (not GL.User.isInGroup or (GL.User.isMasterLooter or GL.User.isLead)) then
                Interface:addTooltip(Window, Identity.tooltip, "TOP");

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
};
local Identity = GL.Interface.Identity;

---@param identifier string
---@return Frame
function Identity:buildForLedger(identifier)
    identifier = identifier or DEFAULT;

    if (not self[identifier]
        or not self[identifier].ledger
    ) then
        identifier = "default";
    end

    return self[identifier]:ledger();
end

---@param identifier string
---@return Frame
function Identity:buildForMultiAuctionClient(identifier)
    identifier = identifier or DEFAULT;

    if (not self[identifier]
        or not self[identifier].multiAuctionClient
    ) then
        identifier = "default";
    end

    return self[identifier]:multiAuctionClient();
end

---@param identifier string
---@return Frame
function Identity:buildForBidder(identifier)
    identifier = identifier or DEFAULT;

    if (not self[identifier]
        or not self[identifier].bidder
    ) then
        identifier = "default";
    end

    return self[identifier]:bidder();
end

---@param identifier string
---
---@return string
function Identity:build(identifier)
    identifier = identifier or DEFAULT;

    return self[identifier] and self[identifier] or self[DEFAULT];
end

---@param identifier string
---@return Frame
function Identity:buildForRoller(identifier)
    identifier = identifier or DEFAULT;

    if (not self[identifier]
        or not self[identifier].roller
    ) then
        identifier = "default";
    end

    return self[identifier]:roller();
end

---@param identifier string
---@param method string
---
---@return string
function Identity:getForMethod(identifier, method)
    identifier = identifier or DEFAULT;

    return GL:tableGet(self, ("%s.%s"):format(identifier, method)) and identifier or DEFAULT;
end