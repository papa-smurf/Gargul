---@type GL
local _, GL = ...;
local LCG = LibStub("LibCustomGlowGargul-1.0");

---@type Constants
local Constants = GL.Data.Constants;

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
            Logo:SetPoint("CENTER", Window, "CENTER", 0, 5);
            Logo:SetSize(80, 80);
            Logo:SetTexture("Interface/AddOns/Gargul/Assets/Identities/" .. Identity.id);

            ---@type FontString
            local Text = Interface:createFontString(Window, "Gargul GDKP");
            Text:SetPoint("CENTER", Window, "CENTER");
            Text:SetPoint("BOTTOM", Window, "BOTTOM", 0, 14);
            Text:SetFont(1.1, "OUTLINE");

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
            local Window = CreateFrame("Frame", nil, UIParent, "BackdropTemplate");
            Window:SetSize(100, 100);
            Window:SetBackdrop(_G.BACKDROP_DARK_DIALOG_32_32);

            ---@type Texture
            local Logo = Window:CreateTexture();
            Logo:SetPoint("CENTER", Window, "CENTER", 0, 5);
            Logo:SetSize(70, 70);
            Logo:SetTexture("Interface/AddOns/Gargul/Assets/Identities/" .. Identity.id);

            ---@type FontString
            local Text = Interface:createFontString(Window, "Gargul GDKP");
            Text:SetPoint("CENTER", Window, "CENTER");
            Text:SetPoint("BOTTOM", Window, "BOTTOM", 0, 14);
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

            return Window;
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
            Logo:SetPoint("CENTER", Window, "CENTER");
            Logo:SetSize(48, 48);
            Logo:SetTexture("Interface/AddOns/Gargul/Assets/Identities/" .. Identity.id);

            ---@type FontString
            local Text = Interface:createFontString(Window, "Gargul");
            Text:SetPoint("CENTER", Window, "CENTER");
            Text:SetPoint("BOTTOM", Window, "BOTTOM", 0, 1);
            Text:SetFont(.9, "OUTLINE");

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

            return Window;
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