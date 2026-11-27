# Gargul Test Suite

This directory contains automated tests for Gargul.

## Directory structure

```
Tests/
  Base.lua              -- Shared base for all tests: Assert helpers, generic log (GL.Tests.Assert, GL.Tests.log)
  Fakes/
    Env.lua             -- Private global environment for Gargul code, so fakes never write to _G
    Loot.lua            -- Loot harness for E2E scenarios
    GroupLoot.lua       -- Group-loot roll harness (START_LOOT_ROLL, RollOnLoot, ConfirmLootRoll)
  E2E/
    Base.lua            -- E2E-specific base: Runner integration, startWith, next, retry, runStep, success, error
    PackMuleBase.lua    -- Table-driven case runner shared by the PackMule scenarios
    PackMule.lua        -- PackMule handout & error reporting (GL.Tests.E2E.PackMule)
    PackMuleRules.lua   -- PackMule rule matching, targets and guards (GL.Tests.E2E.PackMuleRules)
    PackMuleForever.lua -- PackMule Forever name handling (GL.Tests.E2E.PackMuleForever)
    PackMuleAward.lua   -- Award-driven assignLootToPlayer and disenchant (GL.Tests.E2E.PackMuleAward)
    PackMuleGroupLoot.lua -- Group-loot auto rolls and auto confirm (GL.Tests.E2E.PackMuleGroupLoot)
    RollOffBase.lua     -- Shared steps for the RollOff scenarios (real Master Looter UI, RollerUI and dialog clicks)
    RollOffAward.lua    -- Roll, stop, award via the award dialog (GL.Tests.E2E.RollOffAward)
    RollOffLootCouncil.lua -- Vote after the timer, retract, award with votes (GL.Tests.E2E.RollOffLootCouncil)
    RollOffTimer.lua    -- Re-roll the same item, timer expiry, "Name [2]" row (GL.Tests.E2E.RollOffTimer)
    RollOffReminder.lua -- "New roll without awarding" reminder and Clear (GL.Tests.E2E.RollOffReminder)
    RollOffReopen.lua   -- Reopen master looter button mid-roll (GL.Tests.E2E.RollOffReopen)
    RollOffDisenchant.lua -- Disenchant button, player selector, disenchanter popup (GL.Tests.E2E.RollOffDisenchant)
    GDKPAuction.lua     -- Single-item GDKP auction E2E (GL.Tests.E2E.GDKPAuction)
    GDKPMultiAuction.lua -- MultiAuction E2E (GL.Tests.E2E.GDKPMultiAuction)
```

- **Tests/Base.lua** – Loaded first (TOC). Provides `GL.Tests.Assert` (assert, assertEquals, isNil) and `GL.Tests.log(message)` for any test type.
- **Tests/Fakes/Env.lua** – While a fake is installed, Gargul's functions (root, PackMule, DroppedLoot, AwardedLoot, User, Events and all event listeners) run with a proxy environment via `setfenv`. Fakes register API overrides there with `Env:set(name, value)`. Never assign fakes to `_G`: an addon write to a Blizzard global taints it for the whole session, even after restoring it, and tainted Blizzard UI errors on secret values on Forever.
- **Tests/Fakes/Loot.lua** – Scoped loot harness that fakes master-loot server responses, group membership, error/warning output and (opt-in) `UnitName` for E2E tests. It shows its own `GargulTestsLootFrame` instead of Blizzard's loot frame. Fires `LOOT_READY`/`LOOT_OPENED` so PackMule runs through its real `GL.LOOT_ANNOUNCED` timer. Set `Loot.verbose = true` to dump every harness call.
- **Tests/Fakes/GroupLoot.lua** – Requires the Loot fake. Starts fake group-loot rolls and records `RollOnLoot`, `ConfirmLootRoll` and the confirm popup hide.
- **Tests/E2E/Base.lua** – Base for E2E scenarios: step runner, Runner UI integration, `startWith`, `next`, `retry`, `success`, `error`. Scenarios set metatable to `GL.Tests.E2E.Base`.
- **Tests/E2E/PackMuleBase.lua** – Builds Setup, one Runner step per case, and Cleanup from a `CASES` table. Saves and restores every touched setting, resets PackMule and harness state between cases, and asserts both what should happen and what shouldn't (no extra handouts, errors, messages or rolls).
- **Tests/E2E/PackMule*.lua** – The PackMule scenarios, see [PackMule scenarios](#packmule-scenarios).
- **Tests/E2E/GDKPAuction.lua** – GDKP single-item auction E2E (create session, open Auctioneer via item, start auction, bid minimum, assert award, cleanup).
- **Tests/E2E/GDKPMultiAuction.lua** – GDKP MultiAuction E2E (create session, open MultiAuction, fill items, version check, expired countdown bar, terminate, cleanup).

## Quick start

### E2E tests (Launcher)

Open the E2E launcher (via the addon’s test entry point), select scenarios, and click **Start**. The Runner window shows step progress; when running multiple scenarios, the active one is expanded and the previous one collapses when the next starts. All scenarios are checked by default. The Forever names scenario is only listed on the Forever client.

### E2E tests (manual)

```lua
-- Single-item GDKP auction E2E
/run Gargul.Tests.E2E.GDKPAuction:start()
/run Gargul.Tests.E2E.GDKPAuction:stop()

-- RollOff E2Es (swap RollOffAward for RollOffLootCouncil, RollOffTimer, RollOffReminder, RollOffReopen or RollOffDisenchant)
/run Gargul.Tests.E2E.RollOffAward:start()
/run Gargul.Tests.E2E.RollOffAward:stop()

-- MultiAuction E2E
/run Gargul.Tests.E2E.GDKPMultiAuction:start()
/run Gargul.Tests.E2E.GDKPMultiAuction:stop()

-- PackMule E2Es (swap PackMule for PackMuleRules, PackMuleForever, PackMuleAward or PackMuleGroupLoot)
/run Gargul.Tests.E2E.PackMule:start()
/run Gargul.Tests.E2E.PackMule:stop()

-- Dump every loot harness call while a PackMule E2E runs
/run Gargul.Tests.Fakes.Loot.verbose = true
```

## Prerequisites

- **RollOff E2Es:** Be solo (not in a group), have no unlocked GDKP session, and carry at least one item in your bags (two different items for Reminder). They pin and restore the roll settings, delete the awards they create, and use real clicks. Alt-click can't be faked, so Reminder passes items through `MasterLooterUI:draw(link)` and the others insert the link into the focused item box.
- **GDKP Auction E2E:** Tradeable item in bags, active GDKP session (test creates one).
- **GDKP MultiAuction E2E:** Be in a group (2+ players), tradeable items in bags.
- **PackMule E2Es:** No real group or loot required. They temporarily replace loot and group APIs until cleanup, so don't queue them with scenarios that need real state. Item data is warmed in the Setup step; the Award scenario adds and removes its own award history entries.

## E2E scenario flow (examples)

### GDKPAuction

1. Open GDKP Overview → Create Session → fill details → Create session  
2. Close GDKP windows  
3. Open single Auctioneer via item (addItemLink)  
4. Set Min 500, Inc 100, Time 10, Anti Snipe 5  
5. Click Start → assert auction started  
6. Assert Bidder visible, click Minimum → assert bid 500  
7. Wait for auction end → assert item awarded to self at 500  
8. Remove from award history, force-delete session, close windows  

### GDKPMultiAuction

1. Open GDKP Overview → Create Session → fill details → Create session  
2. Close GDKP windows  
3. Open MultiAuction → fill from inventory → select items → Next  
4. Version check → click Start → wait for client  
5. Expire a countdown bar and hand it to another owner → stop, recolor and refresh its old row without errors → assert the row gets a new bar  
6. Terminate → confirm → verify termination → close windows → delete session  

## PackMule scenarios

Every PackMule scenario runs Setup (install harness, save settings, warm item cache), one step per case, then Cleanup (restore settings and shimmed APIs).

- **PackMule Handout & Errors** – multi-page windows, slow successes, every error category, batching, retries reported once, delayed errors matched in order, silent failures, unrelated UI errors, closing with pending handouts or errors.
- **PackMule Rules** – item ID, name and wildcard rules, every quality operator, priorities, `IGNORE`, any-of and `!` targets, `SELF`/`DE`/`RR`/`RANDOM`, ineligible and absent players, BoP, legendary, (un)tradable lists, recipes, disabled/Shift/not master looter, locked slots, gold, timer lifecycle and window changes.
- **PackMule Forever Names** (Forever only) – multi-word names, comma separation, placeholders, hyphenated and first-name-only candidates, ambiguous first names.
- **PackMule Award** – `addWinner` auto-assign (and marking the award received), auto-assign off, items outside the window, non-candidate winners, disenchant, failed handouts.
- **PackMule Group Loot** – NEED/GREED/PASS, disabled and master-loot guards, BoP assist rules, pet/recipe/quest filters, item-ID bypass, roll confirmation, solo and group container auto loot, auto-disable after leaving the group.

### Adding a PackMule case

Add a table to the scenario's `CASES`. The field reference lives at the top of `Tests/E2E/PackMuleBase.lua`.

```lua
{
    title = "Quality rule hands uncommon items to the target",
    rules = { { operator = ">=", quality = 2, target = "PackMuleTarget", }, },
    items = { { id = 25, quality = 2, }, { id = 35, quality = 1, }, },
    expect = {
        handouts = { [25] = "PackMuleTarget", }, -- itemID = player or { players }, "SELF" for the master looter
        untouched = { 35, },                     -- never attempted, still in the window
    },
},
```

Anything not listed in `expect` fails the case: unexpected handouts, loot errors, error/warning messages and group-loot rolls. Use `arrange` to shape the harness (fail a handout, lock a slot, mark a player ineligible) and `check` for custom assertions.

## Adding a new E2E scenario

1. Add **Tests/E2E/YourScenario.lua**.
2. Set `GL.Tests.E2E.YourScenario` and metatable `__index = GL.Tests.E2E.Base`.
3. Define `scenarioName = "YourScenario"`, `E2E_STEPS`, and implement `stop()`, `start(skipRunnerOpen)`, and step functions (`step1_...`, etc.).
4. Implement `getStepTitles()` for the Launcher (return step title strings from your steps table).
5. Register in **Interface/Tests/Launcher.lua**: add `{ key = "YourScenario", label = "Your Label" }` to `E2E_SCENARIOS`.

## Shared assertions (Tests/Base.lua)

For any test that uses `GL.Tests`:

- `GL.Tests.Assert:assert(condition, message)` – condition is truthy  
- `GL.Tests.Assert:assertEquals(expected, actual, message)`  
- `GL.Tests.Assert:isNil(value, message)`  
- `GL.Tests.Assert:reset()` – clear failures  
- `GL.Tests.log(message)` – generic log (Gargul:xd). E2E steps use the E2E Base `self:log()` which also appends to the Runner.

## Troubleshooting

- **E2E test stuck:** `/run Gargul.Tests.E2E.GDKPAuction:stop()` or `GDKPMultiAuction:stop()` to cleanup.
- **PackMule E2E interrupted:** `/run Gargul.Tests.E2E.PackMule:stop()` (or the scenario you ran) restores settings and shimmed APIs. If a script error interrupts teardown, `/reload` restores the native client state.
- **PackMule E2E queueing:** The queue runs one scenario at a time and PackMule restores its shimmed loot/group globals in Cleanup, so the GDKP E2Es after it see real state. If a PackMule scenario errors before Cleanup, `/reload` before running the GDKP ones.
- **PackMule case failed:** The failure dumps the harness log, captured messages and PackMule state via `Gargul:xd`. Rerun with `Gargul.Tests.Fakes.Loot.verbose = true` for a call-by-call trace.
- **Item not cached:** Setup retries item info for a while; if it still fails, mouse over the item once or rerun.
- **Runner not updating:** Ensure TOC order is Base.lua → E2E/Base.lua → E2E scenario files.
- **Check state:** `/run print(Gargul.Tests.E2E.GDKPAuction.isRunning)` (or the scenario you ran).
- **Script errors:** `/console scriptErrors 1` and run again.
- **Clean run:** `/reload` between runs to reset UI/state.

## Best practices

1. **Cleanup** – Scenarios should close windows, soft-delete sessions, and schedule permanent ledger cleanup where needed.
2. **Step isolation** – Each step checks `if (not self.isRunning) then return; end` and uses `self:success()` / `self:error()` so the Runner shows status.
3. **Retries** – Use `self:retry(delay)` for async or flaky UI; define `MAX_RETRIES` per step where appropriate.
4. **Prerequisites** – Document and assert what each scenario needs (group, items, etc.).
