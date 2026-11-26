---@type GL
local _, GL = ...;
local L = Gargul_L;

--- RollOff E2E: pass a new item without awarding the last one (reminder dialog), then use Clear.
--- Run with: /run Gargul.Tests.E2E.RollOffReminder:start()
--- Stop with: /run Gargul.Tests.E2E.RollOffReminder:stop()

assert(GL.Tests.E2E and GL.Tests.E2E.RollOffBase, "GL.Tests.E2E.RollOffBase missing (TOC: Tests/E2E/RollOffBase.lua before this file)");

local REMINDER_DIALOG = "GARGUL_NEW_ROLL_WITHOUT_AWARDING_PREVIOUS_DIALOG";

---@class RollOffReminder : RollOffBase
local E2E = {
    scenarioName = "RollOffReminder",
    itemsNeeded = 2,
    timer = 30,
    STEPS = {
        { title = "Check prerequisites", fn = "stepSetup", },
        { title = "Open Master Looter UI", fn = "stepOpenMasterLooter", },
        { title = "Pass item A", fn = "stepPassItemA", },
        { title = "Assert item accepted", fn = "stepAssertItemAccepted", },
        { title = "Set timer", fn = "stepSetTimer", },
        { title = "Click Start", fn = "stepClickStart", },
        { title = "Assert roll started", fn = "stepAssertStarted", },
        { title = "Assert RollerUI shown", fn = "stepAssertRollerShown", },
        { title = "Click MS", fn = "stepClickRoll", },
        { title = "Assert roll rows", fn = "stepAssertRollRows", },
        { title = "Click Stop", fn = "stepClickStop", },
        { title = "Assert roll stopped", fn = "stepAssertStopped", },
        { title = "Pass item B without awarding", fn = "stepPassItemB", },
        { title = "Assert reminder dialog", fn = "stepAssertReminder", },
        { title = "Click New roll", fn = "stepClickNewRoll", },
        { title = "Assert rolls cleared for item B", fn = "stepAssertNewRoll", },
        { title = "Click Clear", fn = "stepClickClear", },
        { title = "Assert UI reset and nothing awarded", fn = "stepAssertCleared", },
        { title = "Clean up", fn = "stepCleanup", },
    },
};

setmetatable(E2E, { __index = GL.Tests.E2E.RollOffBase });
GL.Tests.E2E.RollOffReminder = E2E; ---@type RollOffReminder

---@param id string
---@return any
local function ml(id)
    return GL.Interface:get(GL.MasterLooterUI, id);
end

--- Alt-clicking an item ends up in MasterLooterUI:draw(itemLink)
---@return nil
function E2E:stepPassItemA()
    if (not self.isRunning) then return; end

    self:passItem(1);
    self:success("Item A passed");
    self:next();
end

---@return nil
function E2E:stepPassItemB()
    if (not self.isRunning) then return; end

    self:passItem(2);
    self:success("Item B passed");
    self:next();
end

---@return nil
function E2E:stepAssertReminder()
    self:poll(10, .3, function ()
        return self:staticPopup(REMINDER_DIALOG, 1) ~= nil and ml("Button.Start").disabled == true;
    end, "Reminder dialog shown, Start locked", "Reminder dialog did not appear");
end

---@return nil
function E2E:stepClickNewRoll()
    if (not self.isRunning) then return; end

    local Popup, Button = self:staticPopup(REMINDER_DIALOG, 1);
    if (not Button) then
        self:error("'New roll' button not found on the reminder dialog");
        return;
    end

    if (Button:GetText() ~= L["New roll"]) then
        self:error(("First dialog button is '%s'"):format(tostring(Button:GetText())));
        return;
    end

    Button:Click();

    self:success("New roll clicked");
    self:next();
end

---@return nil
function E2E:stepAssertNewRoll()
    self:poll(10, .3, function ()
        local Table = ml("Table.Players");
        return ml("EditBox.Item"):GetText() == self.itemLinks[2]
            and #(Table.data or {}) == 0
            and #GL.RollOff.CurrentRollOff.Rolls == 0
            and ml("Button.Start").disabled == false;
    end, "Item B loaded, rolls cleared, Start enabled", "Item B was not loaded cleanly");
end

---@return nil
function E2E:stepClickClear()
    if (not self.isRunning) then return; end

    if (not self:clickWidget(ml("Button.Clear"), "Clear button")) then return; end

    self:success("Clear clicked");
    self:next();
end

---@return nil
function E2E:stepAssertCleared()
    self:poll(10, .3, function ()
        return ml("EditBox.Item"):GetText() == ""
            and not GL.MasterLooterUI.ItemBoxHoldsValidItem
            and ml("Button.Start").disabled == true
            and ml("Button.Award").disabled == true
            and #self.Awards == 0;
    end, "UI reset, nothing awarded", "UI was not reset by Clear");
end

return E2E;
