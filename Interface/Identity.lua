local L = Gargul_L;

---@type GL
local _, GL = ...;
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
        url = L["https://discord.gg/D3mDhYPVzf"],
        urlInfo = L["Visit the URL below to learn more about personalizing Gargul GDKPs"],
        tooltip = L["Your logo here? Click for more info!"],
        cutMailSubject = L["Gargul GDKP: %sg"],

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
                if (button == "LeftButton") then
                    GL.Interface.Dialogs.HyperlinkDialog:open{
                        description = Identity.urlInfo,
                        hyperlink = Identity.url,
                    };
                end
            end);

            GL:stopHighlight(Window);
            LCG.PixelGlow_Start(Window, { .59, .5, .82, 1, }, 26, .02, 5, 2);

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
                if (button == "LeftButton") then
                    GL.Interface.Dialogs.HyperlinkDialog:open{
                        description = Identity.urlInfo,
                        hyperlink = Identity.url,
                    };
                end
            end);

            return Window;
        end,

        ---@return Frame, function
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
                    if (button == "LeftButton") then
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

        ---@return Frame, function
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
                    if (button == "LeftButton") then
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

    --[[ ================== GARGUL  ================== ]]
    ["54402906-2451533554"] = {
        id = "gargul",
        url = "https://discord.com/invite/5Nvcrt4u",
        urlInfo = "Join our Discord server to learn more about our guild and joining our ranks!",
        tooltip = "Gargul is recruiting, click for more info!",
        cutMailSubject = L["Gargul GDKP: %sg"],
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
                if (button == "LeftButton") then
                    GL.Interface.Dialogs.HyperlinkDialog:open{
                        description = Identity.urlInfo,
                        hyperlink = Identity.url,
                    };
                end
            end);

            GL:stopHighlight(Window);
            LCG.PixelGlow_Start(Window, { .59, .5, .82, 1, }, 26, .02, 5, 2);

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
                if (button == "LeftButton") then
                    GL.Interface.Dialogs.HyperlinkDialog:open{
                        description = Identity.urlInfo,
                        hyperlink = Identity.url,
                    };
                end
            end);

            return Window;
        end,

        ---@return Frame, function
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
                if (button == "LeftButton") then
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

        ---@return Frame, function
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
                if (button == "LeftButton") then
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

    --[[ ================== GG GDKP ================== ]]
    ["2118133100-1868759167"] = {
        id = "gggdkp",
        url = "https://discord.gg/gg-gdkp",
        urlInfo = "Join our Discord server to learn more about GG GDKP!",
        tooltip = "GG GDKP discord",
        cutMailSubject = L["Gargul GDKP: %sg"],
        cutMailBody = "Hey Bigbuyer,\n\nThanks for pumping so hard in the GDKP last night.\n\nHere is your ${cut} cut from the run!\n\nPlease sign-up for the next run at https://discord.gg/gg-gdkp\n\nLot's of Love,\nYour Friends at <GG>",

        ---@return Frame
        ledger = function()
            local Identity = GL.Interface.Identity["2118133100-1868759167"];

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
                if (button == "LeftButton") then
                    GL.Interface.Dialogs.HyperlinkDialog:open{
                        description = Identity.urlInfo,
                        hyperlink = Identity.url,
                    };
                end
            end);

            GL:stopHighlight(Window);
            LCG.PixelGlow_Start(Window, { .59, .5, .82, 1, }, 26, .02, 5, 2);

            return Window;
        end,

        ---@return Frame
        multiAuctionClient = function ()
            local Identity = GL.Interface.Identity["2118133100-1868759167"];

            ---@type Frame
            local Window = CreateFrame("Frame", nil, UIParent, "BackdropTemplate");
            Window:SetSize(110, 110);
            Window:SetBackdrop(_G.BACKDROP_DARK_DIALOG_32_32);
            Interface:addTooltip(Window, Identity.tooltip);

            ---@type Texture
            local Logo = Window:CreateTexture();
            Logo:SetPoint("CENTER", Window, "CENTER");
            Logo:SetSize(75, 75);
            Logo:SetTexture("Interface/AddOns/Gargul/Assets/Identities/" .. Identity.id);

            Window:SetScript("OnMouseUp", function(_, button)
                if (button == "LeftButton") then
                    GL.Interface.Dialogs.HyperlinkDialog:open{
                        description = Identity.urlInfo,
                        hyperlink = Identity.url,
                    };
                end
            end);

            return Window;
        end,

        ---@return Frame, function
        bidder = function ()
            local Identity = GL.Interface.Identity["2118133100-1868759167"];

            ---@type Frame
            local Window = CreateFrame("Frame", nil, UIParent);
            Window:SetSize(96, 96);

            ---@type Texture
            local Logo = Window:CreateTexture();
            Logo:SetAllPoints(Window);
            Logo:SetTexture("Interface/AddOns/Gargul/Assets/Identities/" .. Identity.id);

            Interface:addTooltip(Window, Identity.tooltip);
            Window:SetScript("OnMouseUp", function(_, button)
                if (button == "LeftButton") then
                    GL.Interface.Dialogs.HyperlinkDialog:open{
                        description = Identity.urlInfo,
                        hyperlink = Identity.url,
                    };
                end
            end);

            return Window, function (Element, Anchor)
                Element:SetPoint("TOPRIGHT", Anchor, "TOPLEFT", -6, 0);
            end;
        end,

        ---@return Frame, function
        roller = function ()
            local Identity = GL.Interface.Identity["2118133100-1868759167"];

            ---@type Frame
            local Window = CreateFrame("Frame", nil, UIParent);
            Window:SetSize(48, 48);

            ---@type Texture
            local Logo = Window:CreateTexture();
            Logo:SetAllPoints(Window);
            Logo:SetTexture("Interface/AddOns/Gargul/Assets/Identities/" .. Identity.id);

            Interface:addTooltip(Window, Identity.tooltip);

            Window:SetScript("OnMouseUp", function(_, button)
                if (button == "LeftButton") then
                    GL.Interface.Dialogs.HyperlinkDialog:open{
                        description = Identity.urlInfo,
                        hyperlink = Identity.url,
                    };
                end
            end);

            return Window, function (Element, Anchor)
                Element:SetPoint("TOPRIGHT", Anchor, "TOPLEFT", -8, 0);
            end;
        end,
    },

    --[[ ================== UNHINGED  ================== ]]
    ["4120152845-1402702386"] = {
        id = "unhinged",
        url = "https://unhinged.gg/",
        urlInfo = "Visit us to learn more about Unhinged!",
        tooltip = nil,
        cutMailSubject = L["Gargul GDKP: %sg"],

        ---@return Frame
        ledger = function()
            local Identity = GL.Interface.Identity["4120152845-1402702386"];

            ---@type Frame
            local Window = CreateFrame("Frame", nil, UIParent);
            Window:SetSize(80, 80);
            Interface:addTooltip(Window, Identity.tooltip);

            ---@type Texture
            local Logo = Window:CreateTexture();
            Logo:SetTexture("Interface/AddOns/Gargul/Assets/Identities/" .. Identity.id);
            Logo:SetAllPoints();

            Window:SetScript("OnMouseUp", function(_, button)
                if (button == "LeftButton") then
                    GL.Interface.Dialogs.HyperlinkDialog:open{
                        description = Identity.urlInfo,
                        hyperlink = Identity.url,
                    };
                end
            end);

            GL:stopHighlight(Window);
            LCG.PixelGlow_Start(Window, { .59, .5, .82, 1, }, 26, .02, 5, 2);

            return Window;
        end,

        ---@return Frame
        multiAuctionClient = function ()
            local Identity = GL.Interface.Identity["4120152845-1402702386"];

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
            local Text = Interface:createFontString(Window, "Unhinged");
            Text:SetPoint("CENTER", Window, "CENTER");
            Text:SetPoint("BOTTOM", Window, "BOTTOM", 0, 11);
            Text:SetFont(1.4, "OUTLINE");

            Window:SetScript("OnMouseUp", function(_, button)
                if (button == "LeftButton") then
                    GL.Interface.Dialogs.HyperlinkDialog:open{
                        description = Identity.urlInfo,
                        hyperlink = Identity.url,
                    };
                end
            end);

            return Window;
        end,

        ---@return Frame, function
        bidder = function ()
            local Identity = GL.Interface.Identity["4120152845-1402702386"];

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
            local Text = Interface:createFontString(Window, "Unhinged");
            Text:SetPoint("CENTER", Window, "CENTER");
            Text:SetPoint("BOTTOM", Window, "BOTTOM", 0, 2);
            Text:SetFont(1.4, "OUTLINE");

            Interface:addTooltip(Window, Identity.tooltip);
            Window:SetScript("OnMouseUp", function(_, button)
                if (button == "LeftButton") then
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

        ---@return Frame, function
        roller = function ()
            local Identity = GL.Interface.Identity["4120152845-1402702386"];

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
            local Text = Interface:createFontString(Window, "Unhinged");
            Text:SetPoint("CENTER", Window, "CENTER");
            Text:SetPoint("BOTTOM", Window, "BOTTOM", 1, -4);
            Text:SetFont(1.2, "OUTLINE");

            Interface:addTooltip(Window, Identity.tooltip);
            Window:SetScript("OnMouseUp", function(_, button)
                if (button == "LeftButton") then
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
};
local Identity = GL.Interface.Identity;

--[[ GARGUL ALIASES ]]
Identity["126782309-4184359051"] = Identity["54402906-2451533554"];
Identity["4091637282-1561179"] = Identity["54402906-2451533554"];
Identity["3046712350-2962835883"] = Identity["54402906-2451533554"];
Identity["2644832658-2651387317"] = Identity["54402906-2451533554"];

--[[ GG GDKP ]]
Identity["1890643919-4143577729"] = Identity["2118133100-1868759167"];
Identity["3628029066-969996875"] = Identity["2118133100-1868759167"];

--[[ UNHINGED ]]
Identity["524810767-3114103717"] = Identity["4120152845-1402702386"];
Identity["2261728042-2605682897"] = Identity["4120152845-1402702386"];
Identity["106568130-2547934016"] = Identity["4120152845-1402702386"];
Identity["2738699027-911884178"] = Identity["4120152845-1402702386"];
Identity["329719560-4149689853"] = Identity["4120152845-1402702386"];

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