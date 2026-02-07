local L = Gargul_L;

---@type GL
local _, GL = ...;

--[[-----------------------------------------------------------------------------
PopupDialog AceGUI Widget
Simple container widget that creates a popup dialog similar to Blizzard's dialogs
But with added checkboxes for OS and +1 markers
-------------------------------------------------------------------------------]]
local Type, Version = "GargulIncomingPlusOneDataDialog", 1
local AceGUI = LibStub and LibStub("AceGUI-3.0", true)
if not AceGUI or (AceGUI:GetWidgetVersion(Type) or 0) >= Version then return end

-- Lua APIs
local pairs = pairs;

-- WoW APIs
local CreateFrame, UIParent = CreateFrame, UIParent;

local sender = "";

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
    OnYes = function(self, yesCallback)
        self.yesCallback = function ()
            yesCallback();
            self.frame:Hide();
        end
    end,

    OnNo = function(self, noCallback)
        self.noCallback = function ()
            noCallback();
            self.frame:Hide();
        end
    end,

    SetQuestion = function(self, question)
        self.DialogLabel:SetText(question);
    end,

    SetSender = function(self, playerName)
        sender = playerName;

        self.TrustSenderLabel:SetText((L["Automatically accept incoming broadcasts from %s"]):format(GL:formatPlayerName(playerName, { colorize = true, })));
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
    local Frame = GL.Interface:get(GL.Interface.Dialogs.IncomingPlusOneDataDialog, "Window");
    if (Frame) then
        Frame:Hide();
    end

    local frameName = "GargulIncomingPlusOneDataDialog";
    Frame = CreateFrame("Frame", frameName, UIParent, BackdropTemplateMixin and "BackdropTemplate" or nil);
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
    GL.Interface:set(GL.Interface.Dialogs.IncomingPlusOneDataDialog, "Window", Frame);

    -- Container Support
    local content = CreateFrame("Frame", nil, Frame)
    content:SetPoint("TOPLEFT", 17, -27)
    content:SetPoint("BOTTOMRIGHT", -17, 40)

    local Widget = {
        localstatus = {},
        frame     = Frame,
        content   = content,
        type      = Type,
        DialogLabel = {},
        yesCallback = function () end,
        noCallback = function () end,
    }
    for method, func in pairs(Events) do
        Widget[method] = func;
    end

    local PopupDialogInstance = AceGUI:RegisterAsContainer(Widget);

    local VerticalSpacer;
    local HorizontalSpacer;

    -- Dialog
    local Dialog = AceGUI:Create("Label");
    Dialog:SetFontObject(_G["GameFontNormal"]);
    Dialog:SetWidth(272);
    Dialog.label:SetJustifyH("CENTER");
    PopupDialogInstance:AddChild(Dialog);
    Widget.DialogLabel = Dialog;

    HorizontalSpacer = AceGUI:Create("SimpleGroup");
    HorizontalSpacer:SetLayout("FILL");
    HorizontalSpacer:SetFullWidth(true);
    HorizontalSpacer:SetHeight(8);
    PopupDialogInstance:AddChild(HorizontalSpacer);

    local OptionsFrame = AceGUI:Create("SimpleGroup");
    OptionsFrame:SetFullWidth(true);
    OptionsFrame:SetLayout("FLOW");
    PopupDialogInstance:AddChild(OptionsFrame);

    VerticalSpacer = AceGUI:Create("SimpleGroup");
    VerticalSpacer:SetLayout("FILL");
    VerticalSpacer:SetWidth(40);
    VerticalSpacer:SetHeight(10);
    OptionsFrame:AddChild(VerticalSpacer);

    if (sender) then
        -- Trust sender checkbox
        local TrustSenderCheckBox = AceGUI:Create("CheckBox");
        TrustSenderCheckBox:SetLabel("");
        TrustSenderCheckBox:SetDescription("");
        TrustSenderCheckBox:SetHeight(20);
        TrustSenderCheckBox:SetWidth(24);
        OptionsFrame:AddChild(TrustSenderCheckBox);
        GL.Interface:set(GL.Interface.Dialogs.IncomingPlusOneDataDialog, "TrustSender", TrustSenderCheckBox);
        Widget.TrustSenderCheckBox = TrustSenderCheckBox;

        TrustSenderCheckBox:SetCallback("OnValueChanged", function (widget)
            if (widget:GetValue()) then
                GL.PlusOnes:markPlayerAsTrusted(sender);
            else
                GL.PlusOnes:removePlayerFromTrusted(sender);
            end
        end);

        -- Trust sender label
        local TrustSenderLabel = AceGUI:Create("InteractiveLabel");
        TrustSenderLabel:SetFontObject(_G["GameFontNormal"]);
        TrustSenderLabel:SetWidth(200);
        TrustSenderLabel:SetText("");
        Widget.TrustSenderLabel = TrustSenderLabel;

        TrustSenderLabel:SetCallback("OnClick", function()
            TrustSenderCheckBox:ToggleChecked();
            TrustSenderCheckBox:Fire("OnValueChanged", TrustSenderCheckBox:GetValue());
        end);

        OptionsFrame:AddChild(TrustSenderLabel);
    end

    HorizontalSpacer = AceGUI:Create("SimpleGroup");
    HorizontalSpacer:SetLayout("FILL");
    HorizontalSpacer:SetFullWidth(true);
    HorizontalSpacer:SetHeight(8);
    OptionsFrame:AddChild(HorizontalSpacer);

    VerticalSpacer = AceGUI:Create("SimpleGroup");
    VerticalSpacer:SetLayout("FILL");
    VerticalSpacer:SetWidth(40);
    VerticalSpacer:SetHeight(10);
    OptionsFrame:AddChild(VerticalSpacer);
 
    -- Block shared data checkbox
    local BlockSharedDataCheckBox = AceGUI:Create("CheckBox");
    BlockSharedDataCheckBox:SetLabel("");
    BlockSharedDataCheckBox:SetDescription("");
    BlockSharedDataCheckBox:SetHeight(20);
    BlockSharedDataCheckBox:SetWidth(24);
    OptionsFrame:AddChild(BlockSharedDataCheckBox);
    GL.Interface:set(GL.Interface.Dialogs.IncomingPlusOneDataDialog, "BlockSharedData", BlockSharedDataCheckBox);
    Widget.BlockSharedDataCheckBox = BlockSharedDataCheckBox;

    BlockSharedDataCheckBox:SetCallback("OnValueChanged", function (widget)
        if (widget:GetValue()) then
            GL.Settings:set("PlusOnes.blockShareData", true);
        else
            GL.Settings:set("PlusOnes.blockShareData", false);
        end
    end);

    -- Block shared data label
    local BlockSharedDataLabel = AceGUI:Create("InteractiveLabel");
    BlockSharedDataLabel:SetFontObject(_G["GameFontNormal"]);
    BlockSharedDataLabel:SetWidth(200);
    BlockSharedDataLabel:SetText(L["Block all incoming +1 shared data"]);
    Widget.BlockSharedDataLabel = BlockSharedDataLabel;

    BlockSharedDataLabel:SetCallback("OnClick", function()
        BlockSharedDataCheckBox:ToggleChecked();
        BlockSharedDataCheckBox:Fire("OnValueChanged", BlockSharedDataCheckBox:GetValue());
    end);

    OptionsFrame:AddChild(BlockSharedDataLabel);   

    HorizontalSpacer = AceGUI:Create("SimpleGroup");
    HorizontalSpacer:SetLayout("FILL");
    HorizontalSpacer:SetFullWidth(true);
    HorizontalSpacer:SetHeight(8);
    PopupDialogInstance:AddChild(HorizontalSpacer);

    VerticalSpacer = AceGUI:Create("SimpleGroup");
    VerticalSpacer:SetLayout("FILL");
    VerticalSpacer:SetWidth(16);
    VerticalSpacer:SetHeight(10);
    PopupDialogInstance:AddChild(VerticalSpacer);

    -- Yes
    local YesButton = AceGUI:Create("Button");
    YesButton:SetText(L["Yes"]);
    YesButton:SetHeight(20);
    YesButton:SetWidth(120);
    YesButton:SetCallback("OnClick", function()
        if (type(Widget.yesCallback) == "function") then
            Widget.yesCallback();
        end
    end);
    PopupDialogInstance:AddChild(YesButton);

    VerticalSpacer = AceGUI:Create("SimpleGroup");
    VerticalSpacer:SetLayout("FILL");
    VerticalSpacer:SetWidth(12);
    VerticalSpacer:SetHeight(10);
    PopupDialogInstance:AddChild(VerticalSpacer);

    -- No
    local NoButton = AceGUI:Create("Button");
    NoButton:SetText(L["No"]);
    NoButton:SetHeight(20);
    NoButton:SetWidth(120);
    NoButton:SetCallback("OnClick", function()
        if (type(Widget.noCallback) == "function") then
            Widget.noCallback();
        end
    end);
    PopupDialogInstance:AddChild(NoButton);

    HorizontalSpacer = AceGUI:Create("SimpleGroup");
    HorizontalSpacer:SetLayout("FILL");
    HorizontalSpacer:SetFullWidth(true);
    HorizontalSpacer:SetHeight(1);
    PopupDialogInstance:AddChild(HorizontalSpacer);

    return PopupDialogInstance;
end

AceGUI:RegisterWidgetType(Type, constructor, Version)
