
GL = {} ---@type GL
GL.Interface = GL.Interface or {}; ---@type Interface

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
---@return void
function tinsert(Table, value) end

---@param str string
---@param chars string|nil The chars to trim (defaults to \t\r\n)
---@return string
function strtrim(str, chars) end

---@param Table table
---@param key string|number
---@return void
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
---@return void
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
---@return void
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
---@return void
function GameTooltip:HookScript(event, callback) end

---@param frame table
---@param point string
---@return void
function GameTooltip:SetOwner(frame, point) end

---@param itemLink string
---@return void
function GameTooltip:SetHyperlink(itemLink) end

---@return void
function GameTooltip:Show() end

---@return void
function GameTooltip:Hide() end

---@param text string
---@return void
function GameTooltip:SetText(text) end

---@param line string
---@return void
function GameTooltip:AddLine(line) end