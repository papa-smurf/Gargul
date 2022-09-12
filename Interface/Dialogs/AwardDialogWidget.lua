---@type GL
local _, GL = ...;

--[[-----------------------------------------------------------------------------
PopupDialog AceGUI Widget
Simple container widget that creates a popup dialog similar to Blizzard's dialogs
But with added checkboxes for OS and +1 markers
-------------------------------------------------------------------------------]]
local Type, Version = "GargulAwardDialog", 1
local AceGUI = LibStub and LibStub("AceGUI-3.0", true)
if not AceGUI or (AceGUI:GetWidgetVersion(Type) or 0) >= Version then return end

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
    bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
    edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
    tile = true, tileSize = 32, edgeSize = 32,
    insets = { left = 8, right = 8, top = 8, bottom = 8 }
}

local function constructor()
    local frameName = "GargulAwardDialog" .. GL:uuid();
    local Frame = CreateFrame("Frame", frameName, UIParent, BackdropTemplateMixin and "BackdropTemplate" or nil);
    Frame:Hide();

    Frame:EnableMouse(true);
    Frame:SetMovable(true);
    Frame:SetResizable(false);
    Frame:SetFrameStrata("FULLSCREEN_DIALOG");
    Frame:SetBackdrop(FrameBackdrop);
    Frame:SetBackdropColor(0, 0, 0, 1);
    Frame:SetMinResize(320, 10);
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
    local YesButton;

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
    VerticalSpacer:SetWidth(57);
    VerticalSpacer:SetHeight(10);
    OptionsFrame:AddChild(VerticalSpacer);

    -- Plus one checkbox
    local PlusOneCheckBox = AceGUI:Create("CheckBox");
    PlusOneCheckBox:SetLabel("");
    PlusOneCheckBox:SetDescription("");
    PlusOneCheckBox:SetHeight(20);
    PlusOneCheckBox:SetWidth(24);
    OptionsFrame:AddChild(PlusOneCheckBox);
    GL.Interface:setItem(GL.Interface.Dialogs.AwardDialog, "PlusOne", PlusOneCheckBox);

    -- Plus one label
    local PlusOneLabel = AceGUI:Create("InteractiveLabel");
    PlusOneLabel:SetFontObject(_G["GameFontNormal"]);
    PlusOneLabel:SetWidth(100);
    PlusOneLabel:SetText("Add a +1");

    PlusOneLabel:SetCallback("OnClick", function()
        PlusOneCheckBox:ToggleChecked();
    end);

    OptionsFrame:AddChild(PlusOneLabel);

    -- Plus one checkbox
    local OffSpecCheckBox = AceGUI:Create("CheckBox");
    OffSpecCheckBox:SetLabel("");
    OffSpecCheckBox:SetDescription("");
    OffSpecCheckBox:SetHeight(20);
    OffSpecCheckBox:SetWidth(24);
    OptionsFrame:AddChild(OffSpecCheckBox);
    GL.Interface:setItem(GL.Interface.Dialogs.AwardDialog, "OffSpec", OffSpecCheckBox);

    -- Plus one label
    local OffSpecLabel = AceGUI:Create("InteractiveLabel");
    OffSpecLabel:SetFontObject(_G["GameFontNormal"]);
    OffSpecLabel:SetWidth(30);
    OffSpecLabel:SetText("OS");

    OffSpecLabel:SetCallback("OnClick", function()
        OffSpecCheckBox:ToggleChecked();
    end);

    OptionsFrame:AddChild(OffSpecLabel);

    if (GL.BoostedRolls:enabled()) then
        HorizontalSpacer = AceGUI:Create("SimpleGroup");
        HorizontalSpacer:SetLayout("FILL");
        HorizontalSpacer:SetFullWidth(true);
        HorizontalSpacer:SetHeight(8);
        OptionsFrame:AddChild(HorizontalSpacer);

        VerticalSpacer = AceGUI:Create("SimpleGroup");
        VerticalSpacer:SetLayout("FILL");
        VerticalSpacer:SetWidth(52);
        VerticalSpacer:SetHeight(10);
        OptionsFrame:AddChild(VerticalSpacer);

        -- Boosted Roll cost label
        local CostLabel = AceGUI:Create("Label");
        CostLabel:SetFontObject(_G["GameFontNormal"]);
        CostLabel:SetWidth(120);
        CostLabel:SetText("Boosted Roll Cost:");
        OptionsFrame:AddChild(CostLabel);

        -- Boosted Roll cost
        local BoostedRollsCostEditBox = GL.AceGUI:Create("EditBox");
        BoostedRollsCostEditBox:DisableButton(true);
        BoostedRollsCostEditBox:SetHeight(20);
        BoostedRollsCostEditBox:SetWidth(60);
        BoostedRollsCostEditBox:SetText(GL.Settings:get("BoostedRolls.defaultCost", 0));
        BoostedRollsCostEditBox:SetLabel("");
        OptionsFrame:AddChild(BoostedRollsCostEditBox);
        BoostedRollsCostEditBox:SetFocus();
        GL.Interface:setItem(GL.Interface.Dialogs.AwardDialog, "Cost", BoostedRollsCostEditBox);
    end

    if (GL.GDKP:hasActiveSession()) then
        HorizontalSpacer = AceGUI:Create("SimpleGroup");
        HorizontalSpacer:SetLayout("FILL");
        HorizontalSpacer:SetFullWidth(true);
        HorizontalSpacer:SetHeight(8);
        OptionsFrame:AddChild(HorizontalSpacer);

        VerticalSpacer = AceGUI:Create("SimpleGroup");
        VerticalSpacer:SetLayout("FILL");
        VerticalSpacer:SetWidth(52);
        VerticalSpacer:SetHeight(10);
        OptionsFrame:AddChild(VerticalSpacer);

        -- Boosted Roll cost label
        local PriceLabel = AceGUI:Create("Label");
        PriceLabel:SetFontObject(_G["GameFontNormal"]);
        PriceLabel:SetWidth(120);
        PriceLabel:SetText("GDKP Price:");
        OptionsFrame:AddChild(PriceLabel);

        -- Boosted Roll cost
        local GDKPPriceEditBox = GL.AceGUI:Create("EditBox");
        GDKPPriceEditBox:DisableButton(true);
        GDKPPriceEditBox:SetHeight(20);
        GDKPPriceEditBox:SetWidth(60);
        GDKPPriceEditBox:SetText("");
        GDKPPriceEditBox:SetLabel("");
        GDKPPriceEditBox:SetFocus();
        OptionsFrame:AddChild(GDKPPriceEditBox);
        GDKPPriceEditBox:SetCallback("OnEnterPressed", function ()
            YesButton:Fire("OnClick");
        end); -- Update item info when input value changes
        GL.Interface:setItem(GL.Interface.Dialogs.AwardDialog, "GDKPPrice", GDKPPriceEditBox);
    end

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
    YesButton = AceGUI:Create("Button");
    YesButton:SetText("Yes");
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
    NoButton:SetText("No");
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

GL:debug("Interface/AwardDialogWidget.lua");