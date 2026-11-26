---@type GL
local _, GL = ...;

--- RollOff E2E: re-roll the same item (rolls are kept), roll twice, let the timer end the roll, award.
--- Run with: /run Gargul.Tests.E2E.RollOffTimer:start()
--- Stop with: /run Gargul.Tests.E2E.RollOffTimer:stop()

assert(GL.Tests.E2E and GL.Tests.E2E.RollOffBase, "GL.Tests.E2E.RollOffBase missing (TOC: Tests/E2E/RollOffBase.lua before this file)");

---@class RollOffTimer : RollOffBase
local E2E = {
    scenarioName = "RollOffTimer",
    timer = 5,
    STEPS = {
        { title = "Check prerequisites", fn = "stepSetup", },
        { title = "Open Master Looter UI", fn = "stepOpenMasterLooter", },
        { title = "Insert item", fn = "stepInsertItem", },
        { title = "Assert item accepted", fn = "stepAssertItemAccepted", },
        { title = "Set timer (5s)", fn = "stepSetTimer", },
        { title = "Click Start", fn = "stepClickStart", },
        { title = "Assert roll started", fn = "stepAssertStarted", },
        { title = "Assert RollerUI shown", fn = "stepAssertRollerShown", },
        { title = "Click MS", fn = "stepClickRoll", },
        { title = "Assert roll rows", fn = "stepAssertRollRows", },
        { title = "Click Stop", fn = "stepClickStop", },
        { title = "Assert roll stopped", fn = "stepAssertStopped", },
        { title = "Start the same item again", fn = "stepClickStart", },
        { title = "Assert second roll started", fn = "stepAssertStarted", },
        { title = "Assert RollerUI shown again", fn = "stepAssertRollerShown", },
        { title = "Click MS again", fn = "stepClickRoll", },
        { title = "Assert 'Name [2]' row", fn = "stepAssertRollRows", },
        { title = "Wait for the timer to stop the roll", fn = "stepAssertStopped", },
        { title = "Select row", fn = "stepSelectRow", },
        { title = "Click Award", fn = "stepClickAward", },
        { title = "Click Yes in award dialog", fn = "stepConfirmAward", },
        { title = "Assert item awarded with 2 rolls", fn = "stepAssertAwarded", },
        { title = "Clean up", fn = "stepCleanup", },
    },
};

setmetatable(E2E, { __index = GL.Tests.E2E.RollOffBase });
GL.Tests.E2E.RollOffTimer = E2E; ---@type RollOffTimer

return E2E;
