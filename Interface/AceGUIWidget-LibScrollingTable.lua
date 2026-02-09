--[[
Courtesy of https://github.com/ClassicLootManager

MIT License

Copyright (c) 2021 Lantis

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
]]

--[[-----------------------------------------------------------------------------
LibScrollingTable Widget
Wraps ScrollingTable provided by LibScrollingTable in AceGUI widget
-------------------------------------------------------------------------------]]
local Type, Version ="CLMLibScrollingTable", 1
local AceGUI = LibStub and LibStub("AceGUI-3.0", true)
if not AceGUI or (AceGUI:GetWidgetVersion(Type) or 0) >= Version then return end
local ScrollingTable = LibStub("ScrollingTable")
if not ScrollingTable then return end

-- Lua APIs
local pairs = pairs

-- WoW APIs
local CreateFrame, UIParent = CreateFrame, UIParent

--[[-----------------------------------------------------------------------------
Support functions
-------------------------------------------------------------------------------]]

local STMethodsToExposeDirectly = {
    "SetData",
    "SortData",
    "CompareSort",
    "RegisterEvents",
    "FireUserEvent",
    "SetDefaultHighlightBlank",
    "SetDefaultHighlight",
    "GetDefaultHighlightBlank",
    "GetDefaultHighlight",
    "EnableSelection",
    "SetHighLightColor",
    "ClearSelection",
    "SetSelection",
    "GetSelection",
    "GetCell",
    "GetRow",
    "IsRowVisible",
    "SetFilter",
    "DoFilter",
}

local STMethodsToExposeWithResize = {
    "SetDisplayRows",
    "SetRowHeight",
    "SetDisplayCols",
}

local function Resize(self)
    self:SetWidth(self.st.frame:GetWidth())
    -- self.st.rowHeight + 8 comes from the lib implementation of header frame
    self:SetHeight(self.st.frame:GetHeight() + self.st.rowHeight + 8)
end

--[[-----------------------------------------------------------------------------
Methods
-------------------------------------------------------------------------------]]

local methods = {
    ["OnAcquire"] = function (self)
        Resize(self)
    end,

    ["Show"] = function (self)
        self.st:Show()
    end,

    ["Hide"] = function (self)
        self.st:Hide()
    end,

    -- ["OnRelease"] = nil,

    ["GetScrollingTable"] = function (self)
        return self.st
    end,

    ["GetDefaultEvent"] = function (self, event)
        return self.st.DefaultEvents[event]
    end,

    ["GetWidth"] = function (self)
        return self.frame.width
    end,

    ["SetBackdropColor"] = function (self, ...)
        self.st.frame:SetBackdropColor(...)
    end,

    -- AFAIK needed for input type of AceConfigDialog
    ["SetDisabled"] = function (self)
    end,
    ["SetLabel"] = function (self)
    end,
    ["SetText"] = function (self)
    end,
}

--[[-----------------------------------------------------------------------------
Constructor
-------------------------------------------------------------------------------]]
local function Constructor()
    local frame = CreateFrame("Frame", nil, UIParent)
    local st = ScrollingTable:CreateST({{name ="A", width = 1}}, 25, 18, nil, frame, true)
    st:EnableSelection(true)
    frame:Hide()
    -- create widget
    local widget = {
        st = st,
        frame = frame,
        type  = Type
    }
    for method, func in pairs(methods) do
        ---@diagnostic disable-next-line: assign-type-mismatch
        widget[method] = func
    end

    for _, methodName in ipairs(STMethodsToExposeDirectly) do
        ---@diagnostic disable-next-line: assign-type-mismatch
        widget[methodName] = function (self, ...) return self.st[methodName](self.st, ...) end
    end

    -- Methods that we do not want to be touched directly as they require resize
    for _, methodName in ipairs(STMethodsToExposeWithResize) do
        ---@diagnostic disable-next-line: assign-type-mismatch
        widget[methodName] = function (self, ...)
            -- local newMethodName = "ace3_" .. methodName
            -- self.st[newMethodName] = self.st[methodName]
            -- self.st[newMethodName](self.st, ...)
            -- self.st[methodName] = (function ()
            --     error("Do not call " .. methodName .. " directly when using Ace3 wrapper.")
            -- end)
            self.st[methodName](self.st, ...)
            Resize(self)
        end
    end

    return AceGUI:RegisterAsWidget(widget)
end

AceGUI:RegisterWidgetType(Type, Constructor, Version)