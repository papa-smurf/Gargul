---@type GL
local _, GL = ...;
local L = Gargul_L;

--- RollOff E2E: close the Master Looter UI mid-roll, use the reopen button to stop the roll and reopen the UI.
--- Run with: /run Gargul.Tests.E2E.RollOffReopen:start()
--- Stop with: /run Gargul.Tests.E2E.RollOffReopen:stop()

assert(GL.Tests.E2E and GL.Tests.E2E.RollOffBase, "GL.Tests.E2E.RollOffBase missing (TOC: Tests/E2E/RollOffBase.lua before this file)");

---@class RollOffReopen : RollOffBase
local E2E = {
    scenarioName = "RollOffReopen",
    timer = 30,
    STEPS = {
        { title = "Check prerequisites", fn = "stepSetup", },
        { title = "Open Master Looter UI", fn = "stepOpenMasterLooter", },
        { title = "Insert item", fn = "stepInsertItem", },
        { title = "Assert item accepted", fn = "stepAssertItemAccepted", },
        { title = "Set timer", fn = "stepSetTimer", },
        { title = "Click Start", fn = "stepClickStart", },
        { title = "Assert roll started", fn = "stepAssertStarted", },
        { title = "Assert RollerUI shown", fn = "stepAssertRollerShown", },
        { title = "Click MS", fn = "stepClickRoll", },
        { title = "Assert roll rows", fn = "stepAssertRollRows", },
        { title = "Close Master Looter UI", fn = "stepCloseWindow", },
        { title = "Assert reopen button", fn = "stepAssertReopenButton", },
        { title = "Click Stop on reopen button", fn = "stepClickReopenStop", },
        { title = "Assert roll stopped", fn = "stepAssertReopenStopped", },
        { title = "Click reopen button", fn = "stepClickReopen", },
        { title = "Assert Master Looter UI is back", fn = "stepAssertReopened", },
        { title = "Clean up", fn = "stepCleanup", },
    },
};

setmetatable(E2E, { __index = GL.Tests.E2E.RollOffBase });
GL.Tests.E2E.RollOffReopen = E2E; ---@type RollOffReopen

---@param id string
---@return any
local function ml(id)
    return GL.Interface:get(GL.MasterLooterUI, id);
end

---@return Button|nil
local function reopenButton()
    return GL.Interface:get(GL.MasterLooterUI, "Frame.OpenMasterLooterButton");
end

--- Press the window's own Close button
---@return nil
function E2E:stepCloseWindow()
    if (not self.isRunning) then return; end

    local Window = ml("Window");
    local CloseButton;
    for i = 1, Window.frame:GetNumChildren() do
        local child = select(i, Window.frame:GetChildren());
        if (child and child.GetText and child:GetText() == _G.CLOSE) then
            CloseButton = child;
            break;
        end
    end

    if (not CloseButton) then
        self:error("Close button not found on the Master Looter UI");
        return;
    end

    CloseButton:Click();

    if (Window.frame:IsShown()) then
        self:error("Master Looter UI is still shown");
        return;
    end

    self:success("Master Looter UI closed");
    self:next();
end

---@return nil
function E2E:stepAssertReopenButton()
    self:poll(10, .3, function ()
        local Button = reopenButton();
        return Button and Button:IsShown()
            and Button.RollCountText:GetText() == (L["rolls: %s"]):format(1);
    end, "Reopen button shown with 1 roll", "Reopen button missing or wrong roll count");
end

---@return nil
function E2E:stepClickReopenStop()
    if (not self.isRunning) then return; end

    local Button = reopenButton() and reopenButton().PlayStopButton;
    if (not Button) then
        self:error("Play/Stop button not found");
        return;
    end

    Button:Click();

    self:success("Play/Stop clicked");
    self:next();
end

---@return nil
function E2E:stepAssertReopenStopped()
    self:poll(15, .5, function ()
        return not GL.RollOff.inProgress and reopenButton():IsShown();
    end, "Roll stopped via the reopen button", "Roll did not stop");
end

--- The button reacts to OnMouseUp, so run that script like a click would
---@return nil
function E2E:stepClickReopen()
    if (not self.isRunning) then return; end

    local Button = reopenButton();
    local onMouseUp = Button and Button:GetScript("OnMouseUp");
    if (not onMouseUp) then
        self:error("Reopen button has no OnMouseUp");
        return;
    end

    onMouseUp(Button, "LeftButton");

    self:success("Reopen button clicked");
    self:next();
end

---@return nil
function E2E:stepAssertReopened()
    self:poll(10, .3, function ()
        local Window = ml("Window");
        return Window and Window.frame:IsShown()
            and #(ml("Table.Players").data or {}) == 1
            and not reopenButton():IsShown();
    end, "Master Looter UI reopened with its roll", "Master Looter UI did not reopen cleanly");
end

return E2E;
