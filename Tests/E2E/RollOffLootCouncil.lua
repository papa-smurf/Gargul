---@type GL
local _, GL = ...;

--- RollOff E2E: vote on a roll (also after the timer ended) and award with loot council on.
--- Run with: /run Gargul.Tests.E2E.RollOffLootCouncil:start()
--- Stop with: /run Gargul.Tests.E2E.RollOffLootCouncil:stop()

assert(GL.Tests.E2E and GL.Tests.E2E.RollOffBase, "GL.Tests.E2E.RollOffBase missing (TOC: Tests/E2E/RollOffBase.lua before this file)");

---@class RollOffLootCouncil : RollOffBase
local E2E = {
    scenarioName = "RollOffLootCouncil",
    timer = 30,
    STEPS = {
        { title = "Check prerequisites", fn = "stepSetup", },
        { title = "Enable loot council", fn = "stepEnableCouncil", },
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
        { title = "Vote after the timer", fn = "stepVote", },
        { title = "Retract and vote again", fn = "stepRevote", },
        { title = "Select row", fn = "stepSelectRow", },
        { title = "Click Award", fn = "stepClickAward", },
        { title = "Click Yes in award dialog", fn = "stepConfirmAward", },
        { title = "Assert item awarded with votes", fn = "stepAssertCouncilAward", },
        { title = "Clean up", fn = "stepCleanup", },
    },
};

setmetatable(E2E, { __index = GL.Tests.E2E.RollOffBase });
GL.Tests.E2E.RollOffLootCouncil = E2E; ---@type RollOffLootCouncil

---@return nil
function E2E:stepEnableCouncil()
    if (not self.isRunning) then return; end

    GL.Settings:set("LootCouncil.enabled", true, true);

    self:success("Loot council enabled");
    self:next();
end

--- Vote for (or retract from) the first roller and wait for the tally
---
---@param cast boolean
---@param expectedVotes number
---@return nil
function E2E:castVote(cast, expectedVotes)
    local Roll = GL.RollOff.CurrentRollOff.Rolls[1];
    if (not Roll) then
        self:error("No roll to vote on");
        return;
    end

    if (not GL.LootCouncil:userIsMember()) then
        self:error("You are not a loot council member");
        return;
    end

    GL.LootCouncil:toggleVote(Roll.player, cast);

    self:poll(20, .25, function ()
        return GL.LootCouncil:votesFor(Roll.player) == expectedVotes;
    end, ("Votes are now %d"):format(expectedVotes), ("Votes did not become %d"):format(expectedVotes));
end

---@return nil
function E2E:stepVote()
    if (not self.isRunning) then return; end

    self:castVote(true, 1);
end

---@return nil
function E2E:stepRevote()
    if (not self.isRunning) then return; end

    local Roll = GL.RollOff.CurrentRollOff.Rolls[1];
    if (not Roll) then
        self:error("No roll to vote on");
        return;
    end

    GL.LootCouncil:toggleVote(Roll.player, false);

    if (GL.LootCouncil:votesFor(Roll.player) ~= 0) then
        self:error("Retracting the vote did not work");
        return;
    end

    self:castVote(true, 1);
end

---@return nil
function E2E:stepAssertCouncilAward()
    self:poll(10, .5, function ()
        local Entry = self.Awards[1];
        if (not Entry) then
            return false;
        end

        if (not Entry.LC or Entry.LCVotes ~= 1) then
            error(("Expected a council award with 1 vote, got LC=%s votes=%s"):format(tostring(Entry.LC), tostring(Entry.LCVotes)));
        end

        return true;
    end, "Award holds the council votes", "Award was not recorded");
end

return E2E;
