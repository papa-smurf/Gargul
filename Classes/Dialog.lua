--[[
Documentation:
https://warcraft.wiki.gg/wiki/Creating_simple_pop-up_dialog_boxes
https://wowpedia.fandom.com/wiki/Creating_simple_pop-up_dialog_boxes
https://www.townlong-yak.com/framexml/era/Blizzard_StaticPopup/StaticPopup.lua
https://www.townlong-yak.com/framexml/live/Blizzard_StaticPopup_Game/GameDialog.lua

Additional information:
Dialogs support up to 4 buttons
selectCallbackByIndex needs to be enabled in order to use OnButton3 etc
]]

---@type GL
local _, GL = ...;

local Item = _G.Item;
local MoneyFrame_Update = _G.MoneyFrame_Update;
local StaticPopupDialogs = _G.StaticPopupDialogs;
local StaticPopup_Hide = _G.StaticPopup_Hide;
local StaticPopup_Show = _G.StaticPopup_Show;

local Defaults = {
    Details = {},

    hideOnEscape = false,
    selectCallbackByIndex = true,
    whileDead = true,
};

---@class Dialog
---@field AppendFrame Frame
---@field AppendedFrame Frame
---@field OnHide? function
---@field OnShow? function
---@field Replace? table
---
---@field copper? number
---@field dialogType string
---@field hasItemFrame? boolean
---@field hasMoneyFrame? boolean
---@field hideOnEscape boolean
---@field itemLink? string
---@field link? string
---@field normalizedType string
---@field onHide? function
---@field onShow? function
---@field originalText? string
---@field paddingBottom? number
---@field paddingTop? number
---@field text? string
---@field useLinkForItemInfo? string
---@field whileDead boolean
---@field originalOnShow? function
---
---@field button1? boolean
---@field OnButton1? function
---@field DisplayButton1? function
---@field button2? boolean
---@field OnButton2? function
---@field DisplayButton2? function
---@field button3? boolean
---@field OnButton3? function
---@field DisplayButton3? function
---@field button4? boolean
---@field OnButton4? function
---@field DisplayButton4? function
local Dialog = {};
Dialog.__index = Dialog;

---@type Dialog
GL.Dialog = Dialog;

setmetatable(Dialog, {
    __call = function (self, ...)
        return self.new(...);
    end,
});

--- Local helper function to streamline dialog identifiers
---
---@param identifier string
---@return string
local function normalizeType(identifier)
    if (not GL:strStartsWith(identifier, "gargul")) then
        identifier = "GARGUL_" .. identifier .. "_DIALOG";
    end

    return strupper(identifier);
end

---@param dialogType string
---@return Dialog
function Dialog.new(dialogType)
    local self = setmetatable(Defaults, Dialog);
    self.dialogType = dialogType;
    self.normalizedType = normalizeType(dialogType);

    StaticPopupDialogs[self.normalizedType] = self;

    return self;
end

---@param message string
---@return Dialog
function Dialog:setMessage(message)
    self.originalText = message;
    self.text = message;

    return self;
end

---@param padding integer
---@return Dialog
function Dialog:setPaddingTop(padding)
    self.paddingTop = padding;
    return self;
end

---@param padding integer
---@return Dialog
function Dialog:setPaddingBottom(padding)
    self.paddingBottom = padding;
    return self;
end

---@param closeOnEscape boolean
---@return Dialog
function Dialog:setCloseOnEscape(closeOnEscape)
    self.hideOnEscape = closeOnEscape;
    return self;
end

---@param showWhileDead boolean
---@return Dialog
function Dialog:setShowWhileDead(showWhileDead)
    self.whileDead = showWhileDead;
    return self;
end

---@param isAlert? boolean
---@return Dialog
function Dialog:setIsAlert(isAlert)
    self.showAlert = isAlert ~= false;
    return self;
end

--- Accepts 4 buttons
---@param Buttons [{ label: string, onclick?: function, display?: fun(Data?: any): boolean }]
---@return Dialog
function Dialog:setButtons(Buttons)
    for i = 1, 4 do
        local Button = Buttons[i] or {
            label = nil,
            onClick = nil,
            display = nil,
        };

        self["button" .. i] = Button.label;
        self["OnButton" .. i] = Button.onClick and function ()
            Button.onClick(self, self.Details);
        end or nil;
        self["DisplayButton" .. i] = Button.display;
    end

    return self;
end

---@param AppendFrame Frame
---@return Dialog
function Dialog:appendFrame(AppendFrame)
    self.AppendFrame = AppendFrame;
    self.AppendedFrame = AppendFrame;

    return self;
end

---@param itemLink? string
---@return Dialog
function Dialog:setItemLink(itemLink)
    if (not GL:isValidItemLink(itemLink)) then
        self.hasItemFrame = false;
        self.useLinkForItemInfo = nil;
        self.itemLink = nil;
        self.link = nil;

        return self;
    end

    self.hasItemFrame = true;
    self.useLinkForItemInfo = itemLink;
    self.itemLink = itemLink;
    self.link = itemLink;

    return self;
end

---@param copper? number
---@return Dialog
function Dialog:setCopper(copper)
    if (not copper) then
        self.hasMoneyFrame  = false;
        self.copper = nil;

        return self;
    end

    self.hasMoneyFrame = true;
    self.copper = copper;

    return self;
end

---@param Replacements table
---@return Dialog
function Dialog:replace(Replacements)
    self.Replace = Replacements;
    return self;
end

---@param onShow? function
---@return Dialog
function Dialog:setOnShow(onShow)
    self.OnShow = onShow;
    self.originalOnShow = onShow;

    return self;
end

---@param onHide? function
---@return Dialog
function Dialog:setOnHide(onHide)
    self.onHide = onHide;
    self.OnHide = onHide;

    return self;
end

--- Enable a single-line edit box in the dialog.
---
---@param width? number Edit box width (default 260)
---@param defaultText? string Pre-filled text
---@return Dialog
function Dialog:setEditBox(width, defaultText)
    self.hasEditBox = true;
    self.EditBoxWidth = width or 260;
    self.editBoxDefault = defaultText;
    return self;
end

--- Get the current edit box text from the shown dialog. Call from within a button handler.
---
---@return string
function Dialog:getEditBoxText()
    local frame = self._lastShownFrame;
    if (not frame) then
        return "";
    end

    local editBox = frame.editBox or frame.EditBox or (frame.GetName and _G[frame:GetName() .. "EditBox"]);
    if (not editBox or not editBox.GetText) then
        for i = 1, frame:GetNumChildren() or 0 do
            local child = select(i, frame:GetChildren());
            if (child and child.GetObjectType and child:GetObjectType() == "EditBox") then
                editBox = child;
                break;
            end
        end
    end

    return editBox and editBox:GetText() or "";
end

---@param Details? any
---@param callback? function
---@return Dialog
function Dialog:show(Details, callback)
    ---@type Frame
    local ResultFrame;
    callback = callback or function () end;

    -- Reset the text, removing any previous padding
    self.text = self.originalText;

    --- Reset details
    self.Details = Details;

    -- Replace text placeholders
    if (self.Replace) then
        self.text = GL:printfn(self.text, self.Replace);
    end

    local paddingTop = self.paddingTop == nil and 1 or self.paddingTop;
    if (paddingTop > 0) then
        self.text = strrep("\n", paddingTop) .. self.text;
    end

    if (self.paddingBottom and self.paddingBottom > 0) then
        self.text = self.text .. strrep("\n", self.paddingBottom);
    end

    -- Wire OnShow: store frame, handle copper/editBox, then call original
    local originalOnShow = self.originalOnShow;
    self.OnShow = function (DialogFrame)
        self._lastShownFrame = DialogFrame;

        if (self.copper) then
            MoneyFrame_Update(DialogFrame.moneyFrame, self.copper);
        end

        if (self.hasEditBox and self.editBoxDefault) then
            local editBox = DialogFrame.editBox or DialogFrame.EditBox or (DialogFrame.GetName and _G[DialogFrame:GetName() .. "EditBox"]);
            if (editBox and editBox.SetText) then
                editBox:SetText(self.editBoxDefault);
                editBox:SetFocus();
            end
        end

        return originalOnShow and originalOnShow(self, DialogFrame) or nil;
    end;

    -- Make sure the correct item is shown
    if (self.itemLink) then
        -- Check if we can immediately show the dialog or whether
        -- we have to fetch the item details first
        local ItemResult = Item:CreateFromItemLink(self.itemLink);
        if (not ItemResult:IsItemDataCached()) then
            GL:onItemLoadDo(self.itemLink, function ()
                ResultFrame = StaticPopup_Show(self.normalizedType, "", "", self, self.AppendFrame);
                callback(ResultFrame);
            end);

            return self;
        end
    end

    ResultFrame = StaticPopup_Show(self.normalizedType, "", "", self, self.AppendFrame);
    callback(ResultFrame);

    return self;
end

---@return Dialog
function Dialog:unregister()
    StaticPopupDialogs[self.normalizedType] = nil;
    return self;
end

---@param identifier string
function Dialog:hide(identifier)
    identifier = identifier and normalizeType(identifier) or self.normalizedType;
    if (not StaticPopupDialogs[identifier]) then
        return;
    end

    StaticPopup_Hide(identifier);
end
