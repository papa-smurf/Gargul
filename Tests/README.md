# Gargul Test Suite

This directory contains automated tests for Gargul.

## Directory structure

```
Tests/
  Base.lua              -- Shared base for all tests: Assert helpers, generic log (GL.Tests.Assert, GL.Tests.log)
  Fakes/
    Loot.lua            -- Native-first loot harness for E2E scenarios
  E2E/
    Base.lua            -- E2E-specific base: Runner integration, startWith, next, retry, runStep, success, error
    PackMule.lua        -- PackMule master-loot E2E (GL.Tests.E2E.PackMule)
    GDKPAuction.lua     -- Single-item GDKP auction E2E (GL.Tests.E2E.GDKPAuction)
    GDKPMultiAuction.lua -- MultiAuction E2E (GL.Tests.E2E.GDKPMultiAuction)
```

- **Tests/Base.lua** – Loaded first (TOC). Provides `GL.Tests.Assert` (assert, assertEquals, isNil) and `GL.Tests.log(message)` for any test type.
- **Tests/Fakes/Loot.lua** – Scoped loot harness that drives native loot frames/events where possible and temporarily shims master-loot server responses for E2E tests.
- **Tests/E2E/Base.lua** – Base for E2E scenarios: step runner, Runner UI integration, `startWith`, `next`, `retry`, `success`, `error`. Scenarios set metatable to `GL.Tests.E2E.Base`.
- **Tests/E2E/PackMule.lua** – PackMule master-loot E2E (fake master-loot group, six-item loot window, handout success, failure reporting, close cleanup).
- **Tests/E2E/GDKPAuction.lua** – GDKP single-item auction E2E (create session, open Auctioneer via item, start auction, bid minimum, assert award, cleanup).
- **Tests/E2E/GDKPMultiAuction.lua** – GDKP MultiAuction E2E (create session, open MultiAuction, fill items, version check, terminate, cleanup).

## Quick start

### E2E tests (Launcher)

Open the E2E launcher (via the addon’s test entry point), select scenarios, and click **Start**. The Runner window shows step progress; when running multiple scenarios, the active one is expanded and the previous one collapses when the next starts. PackMule is unchecked by default because it temporarily shims loot/group globals.

### E2E tests (manual)

```lua
-- Single-item GDKP auction E2E
/run Gargul.Tests.E2E.GDKPAuction:start()
/run Gargul.Tests.E2E.GDKPAuction:stop()

-- MultiAuction E2E
/run Gargul.Tests.E2E.GDKPMultiAuction:start()
/run Gargul.Tests.E2E.GDKPMultiAuction:stop()

-- PackMule E2E
/run Gargul.Tests.E2E.PackMule:start()
/run Gargul.Tests.E2E.PackMule:stop()
```

## Prerequisites

- **GDKP Auction E2E:** Tradeable item in bags, active GDKP session (test creates one).
- **GDKP MultiAuction E2E:** Be in a group (2+ players), tradeable items in bags.
- **PackMule E2E:** No real group or loot required; run it by itself because it temporarily replaces loot and group APIs until cleanup.

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
5. Terminate → confirm → verify termination → close windows → delete session  

### PackMule

1. Install fake master-loot group and scoped loot harness
2. Open a six-item loot window and assert all matching items are handed out
3. Simulate a bags-full handout failure and assert PackMule records it
4. Simulate a silent handout failure and assert the still-in-window fallback reports it
5. Close the loot window while a handout is pending and assert pending handouts are cleared without a late fallback report

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
- **PackMule E2E interrupted:** `/run Gargul.Tests.E2E.PackMule:stop()` should restore the shimmed APIs. If a script error interrupts teardown, `/reload` restores the native client state.
- **PackMule E2E queueing:** Run PackMule separately from GDKP E2Es; it temporarily shims loot/group globals and should not share a launcher queue with scenarios that expect real state.
- **Runner not updating:** Ensure TOC order is Base.lua → E2E/Base.lua → E2E scenario files.
- **Check state:** `/run print(Gargul.Tests.E2E.GDKPAuction.isRunning)` (or the scenario you ran).
- **Script errors:** `/console scriptErrors 1` and run again.
- **Clean run:** `/reload` between runs to reset UI/state.

## Best practices

1. **Cleanup** – Scenarios should close windows, soft-delete sessions, and schedule permanent ledger cleanup where needed.
2. **Step isolation** – Each step checks `if (not self.isRunning) then return; end` and uses `self:success()` / `self:error()` so the Runner shows status.
3. **Retries** – Use `self:retry(delay)` for async or flaky UI; define `MAX_RETRIES` per step where appropriate.
4. **Prerequisites** – Document and assert what each scenario needs (group, items, etc.).
