---@type GL
local _, GL = ...;

--- RollOff E2E: roll an item, stop it, award it through the award dialog.
--- Run with: /run Gargul.Tests.E2E.RollOffAward:start()
--- Stop with: /run Gargul.Tests.E2E.RollOffAward:stop()

assert(GL.Tests.E2E and GL.Tests.E2E.RollOffBase, "GL.Tests.E2E.RollOffBase missing (TOC: Tests/E2E/RollOffBase.lua before this file)");

---@class RollOffAward : RollOffBase
local E2E = {
    scenarioName = "RollOffAward",
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
        { title = "Click Stop", fn = "stepClickStop", },
        { title = "Assert roll stopped", fn = "stepAssertStopped", },
        { title = "Select row", fn = "stepSelectRow", },
        { title = "Click Award", fn = "stepClickAward", },
        { title = "Click Yes in award dialog", fn = "stepConfirmAward", },
        { title = "Assert item awarded", fn = "stepAssertAwarded", },
        { title = "Clean up", fn = "stepCleanup", },
    },
};

setmetatable(E2E, { __index = GL.Tests.E2E.RollOffBase });
GL.Tests.E2E.RollOffAward = E2E; ---@type RollOffAward

return E2E;
