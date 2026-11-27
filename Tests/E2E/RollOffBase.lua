---@type GL
local _, GL = ...;
local L = Gargul_L;

--- Shared steps for the RollOff E2Es. Drives the real Master Looter UI, RollerUI and dialogs with clicks.
--- Scenarios set `STEPS` (array of { title, fn }) and optionally `itemsNeeded`, `timer`.

assert(GL.Tests.E2E and GL.Tests.E2E.Base, "GL.Tests.E2E.Base missing (TOC: Tests/E2E/Base.lua before this file)");

local Base = GL.Tests.E2E.Base;

---@class RollOffBase : E2EBase
local RollOffBase = {
    isRunning = false,
    runnerStep = 0,
    retryCount = 0,
    itemsNeeded = 1,
    timer = 30,
    expectedRolls = 0,
    itemLinks = {},
    Awards = {},
};

setmetatable(RollOffBase, { __index = Base });
GL.Tests.E2E.RollOffBase = RollOffBase; ---@type RollOffBase

local LISTENER_ID = "E2E.RollOff.Awarded";

--- Settings pinned for the run, restored in stop()
local PINNED_SETTINGS = {
    ["UI.RollOff.closeOnStart"] = false,
    ["UI.RollOff.closeOnAward"] = true,
    ["UI.RollOff.warnWhenNotAwarded"] = true,
    ["UI.RollOff.timer"] = 30,
    ["Rolling.showRollOffWindow"] = true,
    ["Rolling.closeAfterRoll"] = false,
    ["Rolling.dontShowOnUnusableItems"] = false,
    ["Rolling.showRollTracker"] = true,
    ["AutoRoll.enabled"] = false,
    ["LootCouncil.enabled"] = false,
    ["LootCouncil.minimumQuality"] = 0,
    ["LootCouncil.guildRunsOnly"] = false,
    ["LootCouncil.votesPerMember"] = 1,
    ["AwardingLoot.skipAwardConfirmationDialog"] = false,
    ["RollTracking.Brackets"] = function ()
        return {
            { L["MS"], 1, 100, 2, false, false, },
            { L["OS"], 1, 99, 3, true, false, },
        };
    end,
};

---@param id string
---@return any
local function ml(id)
    return GL.Interface:get(GL.MasterLooterUI, id);
end

---@param widget any
---@return boolean
local function isShown(widget)
    if (not widget) then
        return false;
    end

    if (widget.frame) then
        return widget.frame:IsShown() and true or false;
    end

    return widget.IsShown and widget:IsShown() and true or false;
end

---@param widget any AceGUI widget
---@return boolean
local function isDisabled(widget)
    return widget == nil or widget.disabled == true;
end

--- Scenarios are queued by the Launcher, steps run quickly so short roll timers survive
---@param delay? number
---@return nil
function RollOffBase:next(delay)
    Base.next(self, delay == nil and .3 or delay);
end

---@return table
function RollOffBase:getStepTitles()
    local titles = {};
    for _, step in ipairs(self.STEPS or {}) do
        table.insert(titles, step.title);
    end

    return titles;
end

--- Repeat the current step until cond() is true, then run onOk and move on.
---@param max number
---@param delay number
---@param cond fun(): boolean
---@param okMessage string
---@param failMessage string
---@param onOk? function
---@return nil
function RollOffBase:poll(max, delay, cond, okMessage, failMessage, onOk)
    if (not self.isRunning) then return; end

    self.retryCount = (self.retryCount or 0) + 1;

    local ok, result = pcall(cond);
    if (ok and result) then
        self.retryCount = 0;

        if (onOk) then
            onOk();
        end

        self:success(okMessage);
        self:next();
    elseif (self.retryCount >= max) then
        self:error(ok and failMessage or ("%s (%s)"):format(failMessage, tostring(result)));
    else
        self:retry(delay);
    end
end

---@param widget any AceGUI widget
---@param name string
---@return boolean
function RollOffBase:clickWidget(widget, name)
    if (not widget or not widget.frame) then
        self:error(("%s not found"):format(name));
        return false;
    end

    if (isDisabled(widget)) then
        self:error(("%s is disabled"):format(name));
        return false;
    end

    widget.frame:Click();

    return true;
end

---@return table
function RollOffBase:collectBagItems()
    local Links, Seen = {}, {};

    for bag = 0, 4 do
        local numSlots = GL.GetContainerNumSlots and GL.GetContainerNumSlots(bag) or 0;
        for slot = 1, numSlots do
            local _, _, _, _, _, _, hyperlink = GL:getContainerItemInfo(bag, slot);
            local itemID = hyperlink and GL:getItemIDFromLink(hyperlink);

            if (itemID and not Seen[itemID] and GL:isValidItemLink(hyperlink)) then
                Seen[itemID] = true;
                table.insert(Links, hyperlink);
            end
        end
    end

    return Links;
end

---@param frame Frame
---@param predicate fun(child: Frame): boolean
---@return Frame|nil
local function findChild(frame, predicate)
    for i = 1, frame:GetNumChildren() do
        local child = select(i, frame:GetChildren());
        if (child and predicate(child)) then
            return child;
        end
    end
end

--- Find a visible StaticPopup by its dialog type and return it with one of its buttons.
---@param which string
---@param index number
---@return Frame|nil popup
---@return Button|nil button
function RollOffBase:staticPopup(which, index)
    for i = 1, 4 do
        local Popup = _G["StaticPopup" .. i];
        if (Popup and Popup:IsShown()
            and (Popup.which == which or Popup.dialog == _G.StaticPopupDialogs[which])
        ) then
            local Button = Popup["button" .. index]
                or (Popup.GetButton and Popup:GetButton(index))
                or _G[Popup:GetName() .. "Button" .. index]
                or (Popup.ButtonContainer and Popup.ButtonContainer.Buttons and Popup.ButtonContainer.Buttons[index]);

            return Popup, Button;
        end
    end
end

---@return nil
function RollOffBase:start(skipRunnerOpen)
    self.retryCount = 0;
    self.expectedRolls = 0;
    self.Awards = {};
    self.steps = self.STEPS;

    if (skipRunnerOpen) then
        if (self.isRunning) then
            self:log(("Test already running. Use /run Gargul.Tests.E2E.%s:stop() to stop it first."):format(self.scenarioName));
            return;
        end

        self.isRunning = true;
        self.runnerStep = 0;
        GL.Interface.Tests.Runner:setActiveScenario(self.scenarioName);
        self:log("========== Starting Visual E2E Test ==========");
        self:runStep(1);
        return;
    end

    self:startWith("E2E Tests", { { name = self.scenarioName, steps = self:getStepTitles(), }, });
    if (self.isRunning) then
        self:runStep(1);
    end
end

---@return nil
function RollOffBase:stop()
    self:resetRunnerState();

    -- Dialogs first so nothing is left waiting on an answer
    local No = GL.Interface:get(GL.Interface.Dialogs.AwardDialog, "Button.No");
    if (isShown(No)) then
        No.frame:Click();
    end

    local PopupDialog = GL.Interface.Dialogs.PopupDialog;
    if (PopupDialog.Current and isShown(PopupDialog.Current)) then
        PopupDialog.Current.frame:Hide();
    end
    PopupDialog.Current = nil;

    GL.Dialog:hide("NEW_ROLL_WITHOUT_AWARDING_PREVIOUS");
    GL.Interface.PlayerSelector:close();

    if (GL.RollOff.inProgress) then
        GL.RollOff:stop();
    end

    -- Forget the item so the next roll starts from a clean slate
    GL.RollOff:reset();
    GL.RollOff.CurrentRollOff.Rolls = {};
    GL.LootCouncil:endSession();

    GL.RollerUI:hide();
    GL.MasterLooterUI:closeReopenMasterLooterUIButton();
    if (ml("Window")) then
        GL.MasterLooterUI:reset();
        GL.MasterLooterUI:close();
        GL.MasterLooterUI:closeReopenMasterLooterUIButton();
    end

    GL.Events:unregister(LISTENER_ID);

    for _, Entry in pairs(self.Awards or {}) do
        GL.AwardedLoot:deleteWinner(Entry.checksum, false, false);
    end
    self.Awards = {};

    if (self.SavedSettings) then
        for key, value in pairs(self.SavedSettings) do
            GL.Settings:set(key, value, true);
        end
        self.SavedSettings = nil;
    end

    if (self.SavedActiveSessionID) then
        GL.DB:set("GDKP.activeSession", self.SavedActiveSessionID);
        self.SavedActiveSessionID = nil;
    end

    self:log("Stopped and cleaned up");
end

--- Check prerequisites, collect bag items and pin settings
---@return nil
function RollOffBase:stepSetup()
    if (not self.isRunning) then return; end

    self:log("Checking prerequisites and pinning settings...");

    if (GL.User.isInGroup) then
        self:error("Leave your group first: the test would post in real group chat");
        return;
    end

    if (GL.RollOff.inProgress) then
        self:error("A roll off is already in progress");
        return;
    end

    self.itemLinks = self:collectBagItems();
    if (#self.itemLinks < self.itemsNeeded) then
        self:error(("Need %d different items in your bags, found %d"):format(self.itemsNeeded, #self.itemLinks));
        return;
    end

    -- Assigned only once complete so a failed save is never restored over the user's settings
    local Saved = {};
    for key in pairs(PINNED_SETTINGS) do
        local value = GL.Settings:get(key);
        Saved[key] = type(value) == "table" and GL:cloneTable(value) or value;
    end
    self.SavedSettings = Saved;

    for key, value in pairs(PINNED_SETTINGS) do
        GL.Settings:set(key, type(value) == "function" and value() or value, true);
    end

    -- An active GDKP session makes the award dialog ask for a price, set it aside until stop()
    local activeSessionID = GL.GDKP.Session:activeSessionID();
    if (activeSessionID) then
        self.SavedActiveSessionID = activeSessionID;
        GL.DB:set("GDKP.activeSession", nil);
    end

    GL.Events:register(LISTENER_ID, "GL.ITEM_AWARDED", function (_, AwardEntry)
        table.insert(self.Awards, AwardEntry);
    end);

    self:success(("Ready, %d items found"):format(#self.itemLinks));
    self:next();
end

--- Open the Master Looter UI via its slash command and press Clear
---@return nil
function RollOffBase:stepOpenMasterLooter()
    if (not self.isRunning) then return; end

    self:log("Opening the Master Looter UI...");
    GL.Commands:call("rolloff");

    if (not isShown(ml("Window"))) then
        self:error("Master Looter UI did not open");
        return;
    end

    if (not self:clickWidget(ml("Button.Clear"), "Clear button")) then return; end

    if (ml("EditBox.Item"):GetText() ~= "") then
        self:error("Item box not empty after Clear");
        return;
    end

    self:success("Master Looter UI opened and cleared");
    self:next();
end

--- Focus the item box and insert a link, as shift-clicking an item does
---@return nil
function RollOffBase:stepInsertItem()
    if (not self.isRunning) then return; end

    self:log("Passing item to the Master Looter UI: " .. self.itemLinks[1]);

    -- Typing a link into the box never reaches MasterLooterUI:update, alt-click uses draw(link)
    self:passItem(1);

    self:success("Item passed");
    self:next();
end

--- Pass an item through the same entry point alt-click uses
---@param index number
---@return nil
function RollOffBase:passItem(index)
    GL.MasterLooterUI:draw(self.itemLinks[index]);
end

---@return nil
function RollOffBase:stepAssertItemAccepted()
    self:poll(10, .3, function ()
        return GL.MasterLooterUI.ItemBoxHoldsValidItem
            and not isDisabled(ml("Button.Start"));
    end, "Item accepted, Start enabled", "Master Looter UI did not accept the item");
end

---@return nil
function RollOffBase:stepSetTimer()
    if (not self.isRunning) then return; end

    ml("EditBox.Duration"):SetText(tostring(self.timer));

    self:success(("Timer set to %s"):format(self.timer));
    self:next();
end

---@return nil
function RollOffBase:stepClickStart()
    if (not self.isRunning) then return; end

    self:log("Clicking Start...");
    if (not self:clickWidget(ml("Button.Start"), "Start button")) then return; end

    self:success("Start clicked");
    self:next();
end

---@return nil
function RollOffBase:stepAssertStarted()
    self:poll(15, .3, function ()
        return GL.RollOff.inProgress
            and not isDisabled(ml("Button.Stop"))
            and isDisabled(ml("Button.Start"))
            and isDisabled(ml("EditBox.Item"));
    end, "Roll started: Stop enabled, Start and item box locked", "Roll did not start");
end

---@return nil
function RollOffBase:stepAssertRollerShown()
    self:poll(20, .3, function ()
        local RollerUI = GL.RollerUI;
        return RollerUI.Window and RollerUI.Window:IsShown()
            and RollerUI.RollButtons and #RollerUI.RollButtons >= 2;
    end, "RollerUI shows the roll buttons", "RollerUI did not appear");
end

--- Click the first roll button (MS), hovering first when it's disabled for unusable items
---@return nil
function RollOffBase:stepClickRoll()
    if (not self.isRunning) then return; end

    local RollerUI = GL.RollerUI;
    local Button = RollerUI.RollButtons and RollerUI.RollButtons[1];
    if (not Button) then
        self:error("Roll button not found");
        return;
    end

    if (Button:GetText() ~= L["MS"]) then
        self:error(("First roll button is '%s', expected '%s'"):format(tostring(Button:GetText()), L["MS"]));
        return;
    end

    if (not Button:IsEnabled()) then
        local onEnter = Button:GetScript("OnEnter");
        if (onEnter) then
            onEnter(Button);
        end
    end

    self:log("Clicking MS...");
    Button:Click();
    self.expectedRolls = self.expectedRolls + 1;

    if (not RollerUI.RollAcceptedNotification) then
        self:error("No 'Roll accepted!' notification after rolling");
        return;
    end

    self:success("MS clicked, roll accepted");
    self:next();
end

--- Rolls arrive via the game's chat message, wait for them in the table and the roller tracker
---@return nil
function RollOffBase:stepAssertRollRows()
    self:poll(15, .5, function ()
        local Table = ml("Table.Players");
        local Data = Table and Table.data or {};
        if (#Data ~= self.expectedRolls or #GL.RollOff.CurrentRollOff.Rolls ~= self.expectedRolls) then
            return false;
        end

        local foundSecondRoll = false;
        for _, Row in ipairs(Data) do
            local name, amount, rollType = Row.cols[1].value, tonumber(Row.cols[2].value), Row.cols[4].value;
            if (not strfind(strlower(name), strlower(GL.User.name), 1, true)
                or not amount or amount < 1 or amount > 100
                or rollType ~= L["MS"]
            ) then
                error(("Unexpected row: %s / %s / %s"):format(tostring(name), tostring(amount), tostring(rollType)));
            end

            if (strfind(name, " %[2%]")) then
                foundSecondRoll = true;
            end
        end

        if (self.expectedRolls > 1 and not foundSecondRoll) then
            error("No 'Name [2]' row for the second roll");
        end

        local TopRow = GL.RollerUI.RollTrackerTopRow;
        return TopRow and not GL:empty(TopRow.NameText:GetText());
    end, "Roll rows shown in Master Looter UI and RollerUI", "Roll did not show up");
end

---@return nil
function RollOffBase:stepClickStop()
    if (not self.isRunning) then return; end

    self:log("Clicking Stop...");
    if (not self:clickWidget(ml("Button.Stop"), "Stop button")) then return; end

    self:success("Stop clicked");
    self:next();
end

---@return nil
function RollOffBase:stepAssertStopped()
    self:poll(20, .5, function ()
        return not GL.RollOff.inProgress
            and not isDisabled(ml("Button.Award"))
            and not isDisabled(ml("Button.Start"));
    end, "Roll stopped, Award enabled", "Roll did not stop");
end

--- Select the first row by clicking its cell
---@return nil
function RollOffBase:stepSelectRow()
    if (not self.isRunning) then return; end

    local Table = ml("Table.Players");
    local Cell = Table and Table.rows[1] and Table.rows[1].cols[1];
    if (not Cell) then
        self:error("Roll table row not found");
        return;
    end

    Cell:Click("LeftButton");

    if (not Table:GetSelection()) then
        self:error("Clicking the row did not select it");
        return;
    end

    self:success("Row selected");
    self:next();
end

---@return nil
function RollOffBase:stepClickAward()
    if (not self.isRunning) then return; end

    self:log("Clicking Award...");
    if (not self:clickWidget(ml("Button.Award"), "Award button")) then return; end

    self:success("Award clicked");
    self:next();
end

--- Wait for the award dialog, then click Yes
---@return nil
function RollOffBase:stepConfirmAward()
    local Dialogs = GL.Interface.Dialogs.AwardDialog;
    self:poll(10, .3, function ()
        return isShown(GL.Interface:get(Dialogs, "Button.Yes"));
    end, "Award confirmed", "Award dialog did not appear", function ()
        GL.Interface:get(Dialogs, "Button.Yes").frame:Click();
    end);
end

---@return nil
function RollOffBase:stepAssertAwarded()
    self:poll(10, .5, function ()
        local Entry = self.Awards[1];
        if (not Entry) then
            return false;
        end

        if (#self.Awards ~= 1) then
            error("More than one award was recorded");
        end

        if (not GL:playerNamesMatch(Entry.awardedTo, GL.User.name)
            and not GL:playerNamesMatch(Entry.awardedTo, GL.User.fqn)
            and not GL:playerNamesMatch(GL:stripRealm(Entry.awardedTo), GL:stripRealm(GL.User.name))
        ) then
            error(("Awarded to %s, expected you"):format(tostring(Entry.awardedTo)));
        end

        if (Entry.winningRollType ~= L["MS"]) then
            error(("Winning roll type is %s"):format(tostring(Entry.winningRollType)));
        end

        if (#Entry.Rolls ~= self.expectedRolls) then
            error(("Award holds %d rolls, expected %d"):format(#Entry.Rolls, self.expectedRolls));
        end

        return not isShown(ml("Window"));
    end, "Item awarded to you, Master Looter UI closed", "Award was not recorded");
end

---@return nil
function RollOffBase:stepCleanup()
    if (not self.isRunning) then return; end

    self:success("Cleaning up");
    self:log("========== E2E Test Complete ==========");
    self:next(0);
end

return RollOffBase;
