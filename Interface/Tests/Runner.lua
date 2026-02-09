---@type GL
local _, GL = ...;

local L = Gargul_L;
local Interface = GL.Interface;

--- Scenario/Test Runner UI: shows steps with green/red/gray, click step to view log
--- Use via GL.Interface.Tests.Runner
---@class Runner
local Runner = {
    isVisible = false,
    Window = nil,
    LogFrame = nil,
    steps = {},
    stepButtons = {},
    ItemHolder = nil,
    ROW_HEIGHT = 22,
};

GL.Interface.Tests = GL.Interface.Tests or {};
GL.Interface.Tests.Runner = Runner; ---@type Runner

local STATUS = {
    pending = "pending",
    success = "success",
    fail = "fail",
};

---@param title string
---@param stepNames table Array of step display names
---@return nil
function Runner:open(title, stepNames)
    if (self.Window) then
        self.Window:Hide();
        self.Window = nil;
    end

    if (self.LogFrame) then
        self.LogFrame:Hide();
    end

    self.steps = {};
    self.stepButtons = {};
    for i, name in ipairs(stepNames) do
        self.steps[i] = {
            name = name,
            status = STATUS.pending,
            log = {},
        };
    end

    local numSteps = #stepNames;
    local contentHeight = numSteps * self.ROW_HEIGHT;
    local windowHeight = math.min(420, contentHeight + 80);

    local Window = Interface:createWindow({
        name = "GargulTestsRunner",
        width = 320,
        height = windowHeight,
        hideMinimizeButton = true,
        hideResizeButton = true,
        hideWatermark = true,
        OnClose = function ()
            self.Window = nil;
            self.isVisible = false;
        end,
    });

    self.Window = Window;
    self.isVisible = true;

    -- Title
    local Title = Interface:createFontString(Window, title or L["Test Runner"]);
    Title:SetFont(1.25, "OUTLINE");
    Title:SetPoint("TOP", Window, "TOP", 0, -18);

    -- ScrollFrame
    local ScrollFrame = CreateFrame("ScrollFrame", nil, Window, "UIPanelScrollFrameTemplate");
    ScrollFrame:SetPoint("TOP", Title, "BOTTOM", 0, -10);
    ScrollFrame:SetPoint("LEFT", Window, "LEFT", 16, 0);
    ScrollFrame:SetPoint("RIGHT", Window, "RIGHT", -36, 0);
    ScrollFrame:SetPoint("BOTTOM", Window, "BOTTOM", 0, 20);

    local ItemHolder = CreateFrame("Frame");
    ScrollFrame:SetScrollChild(ItemHolder);
    ItemHolder:SetWidth(ScrollFrame:GetWidth() - 24);
    ItemHolder:SetHeight(math.max(contentHeight, ScrollFrame:GetHeight()));
    ItemHolder:SetPoint("TOPLEFT", ScrollFrame, "TOPLEFT");
    self.ItemHolder = ItemHolder;

    for i, step in ipairs(self.steps) do
        local btn = CreateFrame("Button", nil, ItemHolder);
        btn:SetHeight(self.ROW_HEIGHT);
        btn:SetPoint("TOPLEFT", ItemHolder, "TOPLEFT", 0, -(i - 1) * self.ROW_HEIGHT);
        btn:SetPoint("RIGHT", ItemHolder, "RIGHT", 0, 0);
        btn.stepIndex = i;

        local label = Interface:createFontString(btn, self:formatStepLine(i, step));
        label:SetPoint("LEFT", btn, "LEFT", 4, 0);
        label:SetPoint("RIGHT", btn, "RIGHT", -4, 0);
        label:SetJustifyH("LEFT");
        btn.Label = label;

        btn:SetScript("OnClick", function ()
            self:showStepLog(i);
        end);

        self.stepButtons[i] = btn;
    end

    Interface:makeCloseableWithEscape(Window, Window:GetName());
    Window:Show();
end

---@param stepIndex number
---@param step table
---@return string
function Runner:formatStepLine(stepIndex, step)
    local icon, color;
    if (step.status == STATUS.success) then
        icon = "|TInterface/RAIDFRAME/ReadyCheck-Ready:14:14|t";
        color = "92FF00"; -- green
    elseif (step.status == STATUS.fail) then
        icon = "|TInterface/RAIDFRAME/ReadyCheck-NotReady:14:14|t";
        color = "BE3333"; -- red
    else
        icon = "|TInterface/MINIMAP/TRACKING/None:14:14|t";
        color = "808080"; -- gray
    end
    return ("|c00%s%s %d. %s|r"):format(color, icon, stepIndex, step.name);
end

---@return nil
function Runner:refresh()
    if (not self.Window or not self.isVisible) then
        return;
    end

    for i, btn in ipairs(self.stepButtons) do
        local step = self.steps[i];
        if (step and btn.Label) then
            btn.Label:SetText(self:formatStepLine(i, step));
        end
    end
end

---@param stepIndex number
---@param status string "pending"|"success"|"fail"
---@param logLine? string Optional line to append to log
---@return nil
function Runner:setStepStatus(stepIndex, status, logLine)
    local step = self.steps[stepIndex];
    if (not step) then
        return;
    end

    step.status = status;
    if (logLine and type(logLine) == "string") then
        tinsert(step.log, logLine);
    end

    self:refresh();
end

---@param stepIndex number
---@param line string
---@return nil
function Runner:appendStepLog(stepIndex, line)
    local step = self.steps[stepIndex];
    if (not step) then
        return;
    end

    tinsert(step.log, line);
end

---@param stepIndex number
---@return nil
function Runner:showStepLog(stepIndex)
    local step = self.steps[stepIndex];
    if (not step) then
        return;
    end

    local logText;
    if (#step.log > 0) then
        logText = table.concat(step.log, "\n");
    else
        logText = L["No log entries for this step"];
    end

    local title = ("%d. %s"):format(stepIndex, step.name);
    local fullText = ("[%s]\n\n%s"):format(title, logText);

    if (not self.LogFrame) then
        self:buildLogFrame();
    end

    self.LogFrame.EditBox:SetText(fullText);
    self.LogFrame.Title:SetText(title);

    local scrollFrame = self.LogFrame.EditBox:GetParent();
    if (scrollFrame.SetVerticalScroll) then
        scrollFrame:SetVerticalScroll(0);
    end

    self.LogFrame:Show();
end

---@return nil
function Runner:buildLogFrame()
    local LogFrame = Interface:createWindow({
        name = "GargulTestsRunnerLog",
        width = 500,
        height = 350,
        hideMinimizeButton = true,
        hideResizeButton = true,
        hideWatermark = true,
    });

    local Title = Interface:createFontString(LogFrame, "");
    Title:SetFont(1.25, "OUTLINE");
    Title:SetPoint("TOP", LogFrame, "TOP", 0, -18);

    local ScrollFrame = CreateFrame("ScrollFrame", nil, LogFrame, "UIPanelScrollFrameTemplate");
    ScrollFrame:SetPoint("TOP", Title, "BOTTOM", 0, -10);
    ScrollFrame:SetPoint("LEFT", LogFrame, "LEFT", 16, 0);
    ScrollFrame:SetPoint("RIGHT", LogFrame, "RIGHT", -36, 0);
    ScrollFrame:SetPoint("BOTTOM", LogFrame, "BOTTOM", 0, 20);

    local EditBox = CreateFrame("EditBox", nil, ScrollFrame);
    EditBox:SetAutoFocus(false);
    EditBox:SetFontObject(_G.ChatFontNormal);
    EditBox:SetMultiLine(true);
    EditBox:SetMaxLetters(0);
    EditBox:ClearFocus();
    EditBox:SetWidth(ScrollFrame:GetWidth() - 24);
    EditBox:SetHeight(2000);
    EditBox:SetPoint("TOPLEFT", ScrollFrame, "TOPLEFT", 4, 0);

    ScrollFrame:SetScrollChild(EditBox);

    LogFrame.EditBox = EditBox;
    LogFrame.Title = Title;
    self.LogFrame = LogFrame;

    Interface:makeCloseableWithEscape(LogFrame, LogFrame:GetName());
end

---@return nil
function Runner:close()
    if (self.Window) then
        self.Window:Hide();
    end

    if (self.LogFrame) then
        self.LogFrame:Hide();
    end

    self.Window = nil;
    self.isVisible = false;
end

return Runner;
