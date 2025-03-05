--[[
Documentation:
https://warcraft.wiki.gg/wiki/Creating_simple_pop-up_dialog_boxes
https://wowpedia.fandom.com/wiki/Creating_simple_pop-up_dialog_boxes
https://www.townlong-yak.com/framexml/era/Blizzard_StaticPopup/StaticPopup.lua

Missing information:
Dialogs support up to 4 buttons
selectCallbackByIndex needs to be enabled in order to use OnButton3 etc
]]

---@type GL
local _, GL = ...;

---@class Dialog
local Dialog = {};

---@type Dialog
GL.Dialog = Dialog;

local MoneyFrame_Update = _G.MoneyFrame_Update;
local StaticPopupDialogs = _G.StaticPopupDialogs;
local StaticPopup_Hide = _G.StaticPopup_Hide;
local StaticPopup_Show = _G.StaticPopup_Show;

---@param identifier string
---@return string
function Dialog:normalizeIdentifier(identifier)
    if (not GL:strStartsWith(identifier, "gargul")) then
        identifier = "GARGUL_" .. identifier .. "_DIALOG";
    end

    return strupper(identifier);
end

---@param identifier string
---@return boolean
function Dialog:exists(identifier)
    identifier = self:normalizeIdentifier(identifier);
    return StaticPopupDialogs[identifier] ~= nil;
end

---@param identifier string
---@param Details { message: string, paddingTop?: number, paddingBottom?: number, hideOnEscape?: boolean, whileDead?: boolean, Buttons?: [{ label: string, onclick?: function, display?: fun(Data?: any): boolean }], onShow?:function, AppendFrame?: Frame }
function Dialog:register(identifier, Details)
    identifier = self:normalizeIdentifier(identifier);
    Details = self:normalizeRegistrationDetails(Details);

    StaticPopupDialogs[identifier] = Details;
end

---@param Details table
---@return table
function Dialog:normalizeRegistrationDetails(Details)
    if (not Details or GL:empty(Details)) then
        return {};
    end

    local Normalized = {
        AppendFrame = Details.AppendFrame,
        OnShow = Details.onShow,

        hideOnEscape = Details.hideOnEscape == true,
        originalOnShow = Details.onShow,
        selectCallbackByIndex = true,
        text = Details.message,
        useLinkForItemInfo = Details.itemLink,
        whileDead = Details.showWhileDead ~= false,
    };

    -- Add top padding to the dialog label
    local paddingTop = Details.paddingTop == nil and 1 or Details.paddingTop;
    if (paddingTop > 0) then
        Normalized.text = string.rep("\n", paddingTop) .. Normalized.text;
    end

    -- Add bottom padding to the dialog label
    local paddingBottom = Details.paddingBottom == nil and 1 or Details.paddingBottom;
    if (paddingBottom > 0) then
        Normalized.text = Normalized.text .. string.rep("\n", paddingBottom);
    end

    local i = 1;
    for _, Button in pairs(Details.Buttons or {}) do
        Normalized["button" .. i] = Button.label;
        Normalized["OnButton" .. i] = Button.onClick;
        Normalized["DisplayButton" .. i] = Button.display;
        i = i + 1;
    end

    Normalized.originalText = Normalized.text;
    return Normalized;
end

---@param identifier string
function Dialog:unregister(identifier)
    identifier = self:normalizeIdentifier(identifier);
    StaticPopupDialogs[identifier] = nil;
end

---@param identifier string
function Dialog:hide(identifier)
    identifier = self:normalizeIdentifier(identifier);
    if (not StaticPopupDialogs[identifier]) then
        return;
    end

    StaticPopup_Hide(identifier);
end

---@param identifier string
---@param Details { copper?: number, itemLink?: string, Replace?: table<string, string> }
---
--- Reserved:
--- useLinkForItemInfo - When using hasItemFrame = true in register
--- Replace - Replaces dialog message placholders using printfn
--- 
--- Note:
--- Will return nil when dialog doesn't exist or when itemLink is provided
---
---@return boolean?
function Dialog:show(identifier, Details)
    Details = Details or {};
    identifier = self:normalizeIdentifier(identifier);
    local Dialog = StaticPopupDialogs[identifier];
    if (not Dialog) then
        return;
    end

    local AppendFrame = Details.AppendFrame or Dialog.AppendFrame;
    Details.AppendedFrame = AppendFrame;

    -- Make sure the correct amount of gold is shown
    if (Details.copper) then
        Dialog.hasMoneyFrame = true;
        Dialog.OnShow = function (self)
            MoneyFrame_Update(self.moneyFrame, Details.copper);
            return Dialog.originalOnShow and Dialog.originalOnShow(self, Details) or nil;
        end;
    end

    if (Details.Replace) then
        Dialog.text = GL:printfn(Dialog.originalText, Details.Replace);
    end

    -- Make sure the correct item is shown
    if (Details.itemLink) then
        Dialog.hasItemFrame = true;
        Details.useLinkForItemInfo = Details.itemLink;
        Details.link = Details.itemLink;

        GL:onItemLoadDo(Details.itemLink, function ()
            StaticPopup_Show(identifier, "", "", Details, AppendFrame);
        end);

        return;
    end

    return StaticPopup_Show(identifier, "", "", Details, AppendFrame);
end