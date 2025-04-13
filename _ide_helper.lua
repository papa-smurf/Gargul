
GL = {} ---@type GL
GL.Interface = GL.Interface or {}; ---@type Interface

---@class AceGUIFrame
AceGUIFrame = {};

---@class AceGUISimpleGroup
AceGUISimpleGroup = {};

---@class AceGUIScrollFrame
AceGUIScrollFrame = {};

---@class AceGUIInlineGroup
AceGUIInlineGroup = {};

---@class AceGUILabel
AceGUILabel = {};

---@class AceGUIEditBox
AceGUIEditBox = {};

---@class AceGUICheckBox
AceGUICheckBox = {};

---@class AceGUIMultiLineEditBox
AceGUIMultiLineEditBox = {};

---@class AceGUIDropdown
AceGUIDropdown = {};

---@class AceGUIIcon
AceGUIIcon = {};

---@class AceGUIButton
AceGUIButton = {};

-- [[ GLOBAL ]]
---@param mixed any
function DevTools_Dump(mixed) end

-- [[ AceGUIFrame ]]
---@param value string
function AceGUIFrame:SetStatusText(value) end

---@param Child table
function AceGUIFrame:AddChild(Child) end

function AceGUIFrame:Hide() end
function AceGUIFrame:Show() end
function AceGUIFrame:PauseLayout() end
function AceGUIFrame:DoLayout() end

---@type Frame
AceGUIFrame.frame = Frame;

---@type AceGUISimpleGroup
AceGUIFrame.statustext = {};

---@type table
StaticPopupDialogs = {};

---@type function
StaticPopup_Show = function() end;

---@type function
StaticPopup_Hide = function() end;

---@type function
MoneyFrame_Update = function() end;

-- [[ AceGUISimpleGroup ]]
---@param Child table
function AceGUISimpleGroup:AddChild(Child) end

function AceGUISimpleGroup:Hide() end
function AceGUISimpleGroup:Show() end

function AceGUIFrame:PauseLayout() end
function AceGUIFrame:DoLayout() end

-- [[ AceGUIScrollFrame ]]
---@param Child table
function AceGUIScrollFrame:AddChild(Child) end

function AceGUIScrollFrame:Hide() end
function AceGUIScrollFrame:Show() end

function AceGUIFrame:PauseLayout() end
function AceGUIFrame:DoLayout() end

---@return AceGUIFrame
function AceGUIScrollFrame:GetParent() end

-- [[ AceGUIInlineGroup ]]
---@param Child table
function AceGUIInlineGroup:AddChild(Child) end

function AceGUIInlineGroup:Hide() end
function AceGUIInlineGroup:Show() end

function AceGUIInlineGroup:PauseLayout() end
function AceGUIInlineGroup:DoLayout() end

---@param width number
function AceGUIInlineGroup:SetWidth(width); end

---@param height number
function AceGUIInlineGroup:SetHeight(height); end

---@param trueOrFalse boolean
function AceGUIInlineGroup:SetFullWidth(trueOrFalse); end

---@param trueOrFalse boolean
function AceGUIInlineGroup:SetFullHeight(trueOrFalse); end

---@return AceGUIFrame
function AceGUIInlineGroup:GetParent() end

-- [[ AceGUILabel ]]

---@param value string
function AceGUILabel:SetText(value) end

---@param FontObject table GameFontNormal GameFontNormalSmall GameFontNormalLarge GameFontHighlight GameFontHighlightSmall GameFontHighlightSmallOutline GameFontHighlightLarge GameFontDisable GameFontDisableSmall GameFontDisableLarge GameFontGreen GameFontGreenSmall GameFontGreenLarge GameFontRed GameFontRedSmall GameFontRedLarge GameFontWhite GameFontDarkGraySmall NumberFontNormalYellow NumberFontNormalSmallGray QuestFontNormalSmall DialogButtonHighlightText ErrorFont TextStatusBarText CombatLogFont function
function AceGUILabel:SetFontObject(FontObject) end

---@param trueOrFalse boolean
function AceGUILabel:SetFullWidth(trueOrFalse) end

---@return AceGUIFrame
function AceGUILabel:GetParent() end

function AceGUILabel:Hide() end
function AceGUILabel:Show() end

function AceGUILabel:ClearAllPoints(); end

---@type Frame
AceGUILabel.frame = Frame;

-- [[ AceGUIDropdown ]]
---@param trueOrFalse boolean
function AceGUIDropdown:SetDisabled(trueOrFalse); end

---@param option number
function AceGUIDropdown:SetValue(selectedOption) end;

---@param DropDownItems table
function AceGUIDropdown:SetList(DropDownItems); end

---@param selectedText string
function AceGUIDropdown:SetText(selectedText); end

---@param width number
function AceGUIDropdown:SetWidth(width); end

---@param trueOrFalse boolean
function AceGUIDropdown:SetFullWidth(trueOrFalse); end

---@param onselectDo function
function AceGUIDropdown:SetCallBack(onselectDo); end

function AceGUIDropdown:ClearAllPoints(); end

---@type Frame
AceGUIDropdown.frame = Frame;

--[[ AceGUIEditBox ]]
---@param trueOrFalse boolean
function AceGUIEditBox:SetFullWidth(trueOrFalse); end

---@param trueOrFalse boolean
function AceGUIEditBox:DisableButton(trueOrFalse); end

---@param trueOrFalse boolean
function AceGUIEditBox:SetDisabled(trueOrFalse); end

---@param width number
function AceGUIEditBox:SetWidth(width); end

---@param height number
function AceGUIEditBox:SetHeight(height); end

---@param selectedText string
function AceGUIEditBox:SetText(selectedText); end

---@return string
function AceGUIEditBox:GetText(); end

---@param onChangeDo function
function AceGUIEditBox:SetCallBack(onChangeDo); end

---@param label string
function AceGUIEditBox:SetLabel(label); end

---@param max number 0 = Limitless
function AceGUIEditBox:SetMaxLetters(max); end

function AceGUIEditBox:ClearAllPoints(); end

---@type Frame
AceGUIEditBox.frame = Frame;

--[[ AceGUICheckBox ]]
---@param trueOrFalse boolean
function AceGUICheckBox:SetDisabled(trueOrFalse); end

---@param value boolean
function AceGUICheckBox:SetValue(value); end

---@param onChangeDo function
function AceGUICheckBox:SetCallBack(onChangeDo); end

---@param label string
function AceGUICheckBox:SetLabel(label); end

---@type Frame
AceGUICheckBox.frame = Frame;

--[[ AceGUIMultiLineEditBox ]]
---@param trueOrFalse boolean
function AceGUIMultiLineEditBox:SetFullWidth(trueOrFalse); end

---@param trueOrFalse boolean
function AceGUIMultiLineEditBox:DisableButton(trueOrFalse); end

---@param width number
function AceGUIMultiLineEditBox:SetWidth(width); end

---@param height number
function AceGUIMultiLineEditBox:SetHeight(height); end

---@param selectedText string
function AceGUIMultiLineEditBox:SetText(selectedText); end

---@return string
function AceGUIMultiLineEditBox:GetText(); end

---@param onChangeDo function
function AceGUIMultiLineEditBox:SetCallBack(onChangeDo); end

---@param label string
function AceGUIMultiLineEditBox:SetLabel(label); end

---@param lines number
function AceGUIMultiLineEditBox:SetNumLines(lines); end

---@param max number 0 = Limitless
function AceGUIMultiLineEditBox:SetMaxLetters(max); end

function AceGUIMultiLineEditBox:ClearAllPoints(); end

---@type Frame
AceGUIMultiLineEditBox.frame = Frame;

--[[ AceGUIIcon ]]

---@param width number
function AceGUIIcon:SetWidth(width); end

---@param height number
function AceGUIIcon:SetHeight(height); end

---@param width number
---@param height number
function AceGUIIcon:SetImageSize(width, height); end

---@param location string
function AceGUIIcon:SetImage(location); end

function AceGUIIcon:ClearAllPoints(); end

---@type Frame
AceGUIIcon.frame = Frame;

---@type Frame
AceGUILabel.frame = {};

---@param min number
---@param max number|nil
function RandomRoll(min, max) end

---@param message string The message you'd like to send
---@param chatType string The type of message (SAY|EMOTE|YELL|PARTY|GUILD|OFFICER|RAID|RAID_WARNING|INSTANCE_CHAT|BATTLEGROUND|WHISPER|CHANNEL|AFK|DND)
---@param language string|nil The language of the message (COMMON|ORCISH|etc), if nil it's COMMON for Alliance and ORCISH for Horde
---@param channel string|nil The channel (numeric) or player (name string) receiving the message
function SendChatMessage(message, chatType, language, channel)  end

---@param Table table
---@param value any
function tinsert(Table, value) end

---@param str string
---@param chars string|nil The chars to trim (defaults to \t\r\n)
---@return string
function strtrim(str, chars) end

---@param Table table
---@param key string|number
function tremove(Table, key) end

---@param delimiter string
---@param string string
---@param string2 string
---@param string3 string
---@return string
function strjoin(delimiter, string, string2, string3, ...) end

--- Returns the elements from the given table
---@param list table
---@return any
function unpack(list) end

---@param major string Name of the library
---@param silent boolean
---@return table
function LibStub(major, silent) end

--- Play one of a set of built-in sounds. Other players will not hear the sound.
---@param soundName string
---@param channel string
function PlaySound(soundName, channel)  end

--[[
    Item
]]

---@class Item
Item = {};

---@param id number
---@return Item
function Item:CreateFromItemID(id) end

---@param link string
---@return Item
function Item:CreateFromItemLink(link) end

---@return boolean
function Item:IsItemEmpty() end

---@param callback function
function Item:ContinueOnItemLoad(callback) end

--[[
    TradeFrame
]]

---@class TradeFrame
TradeFrame = {};

---@return boolean
function TradeFrame:IsShown() end

--[[
    GameTooltip
]]

---@class GameTooltip
GameTooltip = {};

--- Return the item name and item link connected to the tooltip
---@return string, string
function GameTooltip:GetItem() end

---@param event string
---@param callback function
function GameTooltip:HookScript(event, callback) end

---@param frame table
---@param point string
function GameTooltip:SetOwner(frame, point) end

---@param itemLink string
function GameTooltip:SetHyperlink(itemLink) end

function GameTooltip:Show() end

function GameTooltip:Hide() end

---@param text string
function GameTooltip:SetText(text) end

---@param line string
function GameTooltip:AddLine(line) end