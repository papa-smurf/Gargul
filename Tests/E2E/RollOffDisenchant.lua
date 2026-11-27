---@type GL
local _, GL = ...;

--- RollOff E2E: stop a roll, press Disenchant, pick yourself as disenchanter, assert the disenchant award.
--- Run with: /run Gargul.Tests.E2E.RollOffDisenchant:start()
--- Stop with: /run Gargul.Tests.E2E.RollOffDisenchant:stop()

assert(GL.Tests.E2E and GL.Tests.E2E.RollOffBase, "GL.Tests.E2E.RollOffBase missing (TOC: Tests/E2E/RollOffBase.lua before this file)");

---@class RollOffDisenchant : RollOffBase
local E2E = {
    scenarioName = "RollOffDisenchant",
    timer = 30,
    STEPS = {
        { title = "Check prerequisites", fn = "stepSetup", },
        { title = "Forget the disenchanter", fn = "stepForgetDisenchanter", },
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
        { title = "Click Disenchant", fn = "stepClickDisenchant", },
        { title = "Assert player selector", fn = "stepAssertPlayerSelector", },
        { title = "Select yourself and click Ok", fn = "stepSelectDisenchanter", },
        { title = "Click Yes to set the disenchanter", fn = "stepConfirmDisenchanter", },
        { title = "Assert disenchant award", fn = "stepAssertDisenchantAward", },
        { title = "Clean up", fn = "stepCleanup", },
    },
};

setmetatable(E2E, { __index = GL.Tests.E2E.RollOffBase });
GL.Tests.E2E.RollOffDisenchant = E2E; ---@type RollOffDisenchant

---@param id string
---@return any
local function ml(id)
    return GL.Interface:get(GL.MasterLooterUI, id);
end

---@return nil
function E2E:stop()
    GL.Tests.E2E.RollOffBase.stop(self);

    -- Put the real disenchanter back without announcing anything
    if (self.hadDisenchanter) then
        GL.PackMule.disenchanter = self.savedDisenchanter;
        self.hadDisenchanter = false;
    end
end

---@return nil
function E2E:stepForgetDisenchanter()
    if (not self.isRunning) then return; end

    self.savedDisenchanter = GL.PackMule.disenchanter;
    self.hadDisenchanter = true;
    GL.PackMule:clearDisenchanter();

    self:success("Disenchanter forgotten for the run");
    self:next();
end

---@return nil
function E2E:stepClickDisenchant()
    if (not self.isRunning) then return; end

    if (not self:clickWidget(ml("Button.Disenchant"), "Disenchant button")) then return; end

    self:success("Disenchant clicked");
    self:next();
end

---@return nil
function E2E:stepAssertPlayerSelector()
    self:poll(10, .3, function ()
        local Window = GL.Interface:get(GL.Interface.PlayerSelector, "Window");
        local Table = GL.Interface:get(GL.Interface.PlayerSelector, "Table.Players");

        return Window and Window.frame:IsShown()
            and Table and #(Table.data or {}) >= 1
            and not ml("Window").frame:IsShown();
    end, "Player selector shown, Master Looter UI closed", "Player selector did not appear");
end

---@return nil
function E2E:stepSelectDisenchanter()
    if (not self.isRunning) then return; end

    local Table = GL.Interface:get(GL.Interface.PlayerSelector, "Table.Players");
    local Cell = Table and Table.rows[1] and Table.rows[1].cols[1];
    if (not Cell) then
        self:error("Player selector row not found");
        return;
    end

    Cell:Click("LeftButton");

    GL.Interface.Dialogs.PopupDialog.Current = nil;
    if (not self:clickWidget(GL.Interface:get(GL.Interface.PlayerSelector, "Button.Ok"), "Ok button")) then return; end

    self:success("Player selected and confirmed");
    self:next();
end

---@return nil
function E2E:stepConfirmDisenchanter()
    self:poll(10, .3, function ()
        local Dialog = GL.Interface.Dialogs.PopupDialog.Current;
        return Dialog and Dialog.Yes and Dialog.frame:IsShown();
    end, "Disenchanter confirmed", "Disenchanter popup did not appear", function ()
        GL.Interface.Dialogs.PopupDialog.Current.Yes.frame:Click();
    end);
end

---@return nil
function E2E:stepAssertDisenchantAward()
    self:poll(10, .5, function ()
        local Entry = self.Awards[1];
        if (not Entry) then
            return false;
        end

        if (#self.Awards ~= 1 or Entry.awardedTo ~= GL.Exporter.disenchantedItemIdentifier) then
            error("Expected exactly one disenchant award");
        end

        if (not GL:playerNamesMatch(GL.PackMule.disenchanter, GL.User.name)
            and not GL:playerNamesMatch(GL.PackMule.disenchanter, GL.User.fqn)
            and not GL:playerNamesMatch(GL:stripRealm(GL.PackMule.disenchanter), GL:stripRealm(GL.User.name))
        ) then
            error("You were not set as disenchanter");
        end

        return true;
    end, "Item disenchanted and you are the disenchanter", "Disenchant award was not recorded");
end

return E2E;
