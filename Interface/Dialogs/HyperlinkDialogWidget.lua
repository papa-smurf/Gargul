local L = Gargul_L;

---@type GL
local _, GL = ...;

--[[-----------------------------------------------------------------------------
PopupDialog AceGUI Widget
Simple container widget that creates a popup dialog similar to Blizzard's dialogs
But with added checkboxes for OS and +1 markers
-------------------------------------------------------------------------------]]
local Type, Version = "GargulHyperlinkDialog", 1;
local AceGUI = LibStub and LibStub("AceGUI-3.0", true);
if not AceGUI or (AceGUI:GetWidgetVersion(Type) or 0) >= Version then return; end

-- Lua APIs
local pairs = pairs;

-- WoW APIs
local CreateFrame, UIParent = CreateFrame, UIParent;

local function OnClose(Frame)
    PlaySound(799) -- SOUNDKIT.GS_TITLE_OPTION_EXIT

    GL.Interface:storePosition(Frame, "PopupDialog");

    Frame:Hide()
    Frame.obj:Fire("OnClose");
end

local function OnMouseDown(Frame)
    Frame:StartMoving();
    AceGUI:ClearFocus();
end

local function OnMouseUp(Frame)
    Frame:StopMovingOrSizing()
    local self = Frame.obj;
    local status = self.status or self.localstatus;
    status.width = Frame:GetWidth();
    status.height = Frame:GetHeight();
    status.top = Frame:GetTop();
    status.left = Frame:GetLeft();
end

-- Widget Events
local Events = {
    Close = function (self)
        self.CloseButton:Fire("OnClick");
    end,

    EnableHyperLinkButton = function(self)
        self.HyperlinkEditbox:DisableButton(false);
    end,

    SetHyperlink = function(self, hyperlink)
        self.HyperlinkEditbox:SetText(hyperlink);
        self.HyperlinkEditbox:HighlightText();
        self.HyperlinkEditbox:SetFocus();
    end,

    SetOnConfirm = function(self, callback)
        self.HyperlinkEditbox:SetCallback("OnEnterPressed", callback);
    end,

    SetDescription = function(self, description)
        self.DialogLabel:SetText(description);
    end,

    OnAcquire = function(self)
        self:ApplyStatus();
        self.frame:SetParent(UIParent);
        self.frame:SetFrameStrata("FULLSCREEN_DIALOG");

        -- Make sure the dialog can be closed using the escape key
        GL.Ace:ScheduleTimer(function ()
            table.insert(UISpecialFrames, self.frame:GetName());
        end, .1);

        self:SetPoint(GL.Interface:getPosition("PopupDialog"));
        self:Show();
    end,

    OnRelease = function(self)
        GL.Interface:storePosition(self, "PopupDialog");

        self.status = nil;
        wipe(self.localstatus);
    end,

    LayoutFinished = function(self, _, height)
        if (self.noAutoHeight) then
            return;
        end

        self:SetHeight((height or 0) + 40);
    end,

    Show = function(self)
        self.frame:Show();
    end,

    -- called to set an external table to store status in
    SetStatusTable = function(self, status)
        assert(type(status) == "table");
        self.status = status;
        self:ApplyStatus();
    end,

    ApplyStatus = function(self)
        local status = self.status or self.localstatus;
        local frame = self.frame;
        self:SetWidth(status.width or 700);
        self:SetHeight(status.height or 500);
        frame:ClearAllPoints();

        if status.top and status.left then
            frame:SetPoint("TOP", UIParent, "BOTTOM", 0, status.top);
            frame:SetPoint("LEFT", UIParent, "LEFT", status.left, 0);
        else
            frame:SetPoint("CENTER");
        end
    end,

    OnWidthSet = function(self, width)
        local content = self.content;
        local contentwidth = width - 20;

        if (contentwidth < 0) then
            contentwidth = 0;
        end

        content:SetWidth(contentwidth);
        content.width = contentwidth;
    end,

    OnHeightSet = function(self, height)
        local content = self.content;
        local contentheight = height - 20;

        if contentheight < 0 then
            contentheight = 0;
        end

        content:SetHeight(contentheight);
        content.height = contentheight;
    end
}

local FrameBackdrop = {
    bgFile = "Interface/DialogFrame/UI-DialogBox-Background",
    edgeFile = "Interface/DialogFrame/UI-DialogBox-Border",
    tile = true, tileSize = 32, edgeSize = 32,
    insets = { left = 8, right = 8, top = 8, bottom = 8 }
}

local function constructor()
    local frameName = "HyperlinkDialog" .. GL:uuid();
    local Frame = CreateFrame("Frame", frameName, UIParent, BackdropTemplateMixin and "BackdropTemplate" or nil);
    Frame:Hide();

    Frame:EnableMouse(true);
    Frame:SetMovable(true);
    Frame:SetResizable(false);
    Frame:SetFrameStrata("FULLSCREEN_DIALOG");
    Frame:SetBackdrop(FrameBackdrop);
    Frame:SetBackdropColor(0, 0, 0, 1);
    Frame:SetWidth(320);
    Frame:SetToplevel(true);
    Frame:SetScript("OnHide", OnClose);
    Frame:SetScript("OnMouseDown", OnMouseDown);
    Frame:SetScript("OnMouseUp", OnMouseUp);

    -- Container Support
    local content = CreateFrame("Frame", nil, Frame)
    content:SetPoint("TOPLEFT", 17, -27)
    content:SetPoint("BOTTOMRIGHT", -17, 40)

    local Widget = {
        localstatus = {},
        frame     = Frame,
        content   = content,
        type      = Type,
        HyperlinkEditbox = {},
    }
    for method, func in pairs(Events) do
        Widget[method] = func;
    end

    local HyperlinkDialogInstance = AceGUI:RegisterAsContainer(Widget);

    local VerticalSpacer;
    local HorizontalSpacer;

    -- Dialog
    local Dialog = AceGUI:Create("Label");
    Dialog:SetFontObject(_G["GameFontNormal"]);
    Dialog:SetWidth(272);
    Dialog.label:SetJustifyH("CENTER");
    HyperlinkDialogInstance:AddChild(Dialog);
    Widget.DialogLabel = Dialog;

    VerticalSpacer = AceGUI:Create("SimpleGroup");
    VerticalSpacer:SetLayout("FILL");
    VerticalSpacer:SetWidth(16);
    VerticalSpacer:SetHeight(10);
    HyperlinkDialogInstance:AddChild(VerticalSpacer);

    local HyperlinkEditbox = GL.AceGUI:Create("EditBox");
    HyperlinkEditbox:DisableButton(true);
    HyperlinkEditbox:SetHeight(20);
    HyperlinkEditbox:SetFullWidth(true);
    HyperlinkEditbox:SetText("");
    HyperlinkDialogInstance:AddChild(HyperlinkEditbox);
    Widget.HyperlinkEditbox = HyperlinkEditbox;

    HorizontalSpacer = AceGUI:Create("SimpleGroup");
    HorizontalSpacer:SetLayout("FILL");
    HorizontalSpacer:SetFullWidth(true);
    HorizontalSpacer:SetHeight(8);
    HyperlinkDialogInstance:AddChild(HorizontalSpacer);

    VerticalSpacer = AceGUI:Create("SimpleGroup");
    VerticalSpacer:SetLayout("FILL");
    VerticalSpacer:SetWidth(165);
    VerticalSpacer:SetHeight(10);
    HyperlinkDialogInstance:AddChild(VerticalSpacer);

    -- Close
    local CloseButton = AceGUI:Create("Button");
    CloseButton:SetText(L.CLOSE);
    CloseButton:SetHeight(20);
    CloseButton:SetWidth(120);
    CloseButton:SetCallback("OnClick", function()
        Frame:Hide();
    end);
    HyperlinkDialogInstance:AddChild(CloseButton);
    Widget.CloseButton = CloseButton;

    HorizontalSpacer = AceGUI:Create("SimpleGroup");
    HorizontalSpacer:SetLayout("FILL");
    HorizontalSpacer:SetFullWidth(true);
    HorizontalSpacer:SetHeight(1);
    HyperlinkDialogInstance:AddChild(HorizontalSpacer);

    return HyperlinkDialogInstance;
end

AceGUI:RegisterWidgetType(Type, constructor, Version)
