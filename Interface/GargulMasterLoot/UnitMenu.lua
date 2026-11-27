local L = Gargul_L;

--[[
    Adds "Gargul Master Loot" to the right click menu of your own portrait / unit frame
    (the same menu that holds Blizzard's loot method options).

    Retail (and anything else that has it) uses the modern Menu API, which is taint safe by design.
    Older clients use Blizzard's dropdown. Adding a real dropdown button from add-on code taints the
    shared dropdown state and breaks protected entries like Set Focus, so instead we attach our own
    button below the list (the same trick LibDropDownExtension uses).

    There's always /gl gml as a fallback.
]]
---@type GL
local _, GL = ...;

GL.Interface.GargulMasterLoot = GL.Interface.GargulMasterLoot or {};

---@return GargulMasterLootMode
local function Mode() return GL.GargulMasterLoot.Mode; end

---@class GargulMasterLootUnitMenu
local UnitMenu = {
    _initialized = false,
};

GL.Interface.GargulMasterLoot.UnitMenu = UnitMenu; ---@type GargulMasterLootUnitMenu

--- What should the menu offer right now?
---
---@return string|nil label
---@return function|nil action
function UnitMenu:entry()
    GL.User:refresh();

    if (Mode():isActive() or Mode().Check) then
        if (GL.User.isPseudoMasterLooter or GL.User.isLead or Mode().Check) then
            return L["Stop Gargul Master Loot"], function () Mode():stop(); end;
        end

        return nil;
    end

    if (GL.User.isInGroup and (GL.User.isLead or GL.User.hasAssist)) then
        return L["Start Gargul Master Loot"], function () Mode():start(); end;
    end

    return nil;
end

---@return nil
function UnitMenu:_init()
    if (self._initialized) then
        return;
    end

    self._initialized = true;

    if (type(Menu) == "table" and type(Menu.ModifyMenu) == "function") then
        Menu.ModifyMenu("MENU_UNIT_SELF", function (_, rootDescription)
            local label, action = self:entry();
            if (not label) then
                return;
            end

            rootDescription:CreateDivider();
            rootDescription:CreateButton(label, action);
        end);

        return;
    end

    self:legacy();
end

--- Older clients: our own button glued to the bottom of Blizzard's dropdown
---
---@return nil
function UnitMenu:legacy()
    local List = _G.DropDownList1;
    if (type(List) ~= "table" or type(List.HookScript) ~= "function") then
        return;
    end

    local buttonHeight = _G.UIDROPDOWNMENU_BUTTON_HEIGHT or 16;
    local action;

    local Button = CreateFrame("Button", nil, List);
    Button:SetHeight(buttonHeight);
    Button:SetFrameLevel(List:GetFrameLevel() + 2);
    Button:Hide();

    local Highlight = Button:CreateTexture(nil, "BACKGROUND");
    Highlight:SetTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight");
    Highlight:SetBlendMode("ADD");
    Highlight:SetAllPoints(Button);
    Highlight:Hide();

    local Label = Button:CreateFontString(nil, "ARTWORK", "GameFontHighlightSmallLeft");
    Label:SetPoint("LEFT", Button, "LEFT", 0, 0);
    Label:SetPoint("RIGHT", Button, "RIGHT", 0, 0);

    Button:SetScript("OnEnter", function () Highlight:Show(); end);
    Button:SetScript("OnLeave", function () Highlight:Hide(); end);
    Button:SetScript("OnClick", function ()
        local callback = action;
        CloseDropDownMenus();

        if (callback) then
            callback();
        end
    end);

    List:HookScript("OnShow", function ()
        Button:Hide();

        local Dropdown = _G.UIDROPDOWNMENU_OPEN_MENU;
        if (not Dropdown
            or Dropdown.which ~= "SELF"
            or _G.UIDROPDOWNMENU_MENU_LEVEL ~= 1
        ) then
            return;
        end

        local label, callback = self:entry();
        local Last = _G["DropDownList1Button" .. (List.numButtons or 0)];
        if (not label or not Last) then
            return;
        end

        action = callback;
        Label:SetText(label);

        Button:ClearAllPoints();
        Button:SetPoint("TOPLEFT", Last, "BOTTOMLEFT", 0, 0);
        Button:SetWidth(math.max(Last:GetWidth(), Label:GetStringWidth()));
        Button:Show();

        List:SetHeight(List:GetHeight() + buttonHeight);
        if (Label:GetStringWidth() > Last:GetWidth()) then
            List:SetWidth(List:GetWidth() + Label:GetStringWidth() - Last:GetWidth());
        end
    end);

    List:HookScript("OnHide", function ()
        Button:Hide();
        action = nil;
    end);
end

GL:registerForInit(UnitMenu);
