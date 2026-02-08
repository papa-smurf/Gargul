# Gargul Test Suite

This directory contains automated tests for Gargul.

## Quick Start

### Standalone Unit Tests
```lua
/run GargulTests:runAll()      -- Run all unit tests
/run Gargul:xda()               -- View test results
```

### MultiAuction E2E Test (Fully Automated)
```lua
/run GargulMultiAuctionE2E:start()   -- Start E2E test
/run GargulMultiAuctionE2E:stop()    -- Stop and cleanup
```

## Prerequisites

**For MultiAuction E2E**: Be in a group (2+ players), have tradeable items in bags

## Test Files

### 1. `GDKPTests_Standalone.lua` - Fast Unit Tests

Quick, synchronous unit tests with visual feedback:

**Run all tests:**
```lua
/run GargulTests:runAll()
/run Gargul:xda()
```

**Run specific category:**
```lua
/run GargulTests:run("Session Creation")
/run Gargul:xda()
```

**Tests include:**
- Opening GDKP Overview
- Creating Multi-Auction sessions via UI
- Session activation/deletion
- MultiAuction window operations
- Settings configuration

**Features:**
- Self-contained, no external dependencies
- Windows visible for 1s during UI tests
- Per-test cleanup
- Custom assertion library
- Output via `Gargul:xd()` for easy copy/paste

### 2. `GDKPMultiAuctionE2E.lua` - MultiAuction End-to-End Test

Complete GDKP MultiAuction workflow with 1-second delays between steps for visual feedback.

**Run the test:**
```lua
/run GargulMultiAuctionE2E:start()
```

**Stop/cleanup:**
```lua
/run GargulMultiAuctionE2E:stop()
```

**Test Flow (Fully Automated):**
1. Open GDKP Overview (wait 1s)
2. Open Create Session (wait 1s)
3. Fill session details (wait 1s)
4. Create session (wait 1s)
5. Close GDKP windows
6. Open MultiAuction window (wait 1s)
7. Fill items from inventory
8. Select all items (wait 1s)
9. Click Next → Version Check opens
9b. Auto-click "Start" in Version Check
10. Wait for MultiAuction client (wait 3s)
11. Auto-click "Terminate" button
11b. Auto-click "Yes" on confirmation (wait 3s)
12. Close windows (wait 1s)
13. Delete session (soft delete + permanent after 2s)

**No Manual Steps Required** - Fully automated!

## Test Structure Example

### Standalone Test (GDKPTests_Standalone.lua)

```lua
function Tests:testSomething()
    self:log("Testing something...");
    
    -- Arrange
    local value = 42;
    
    -- Act
    local result = value * 2;
    
    -- Assert
    self:assertEquals(84, result, "Value should be doubled");
    
    self:success("Test passed");
end
```

### Orchestrated E2E Test

```lua
function E2E:step1_DoSomething()
    self:log("Step 1: Doing something...");
    
    -- Do the thing
    
    self:success("Thing done");
    self:scheduleNext(0.5, function() self:step2_DoNextThing() end);
end
```

## Custom Assertions (GDKPTests_Standalone.lua)

Available assertions:
- `self:assert(value, message)` - Value is truthy
- `self:assertEquals(expected, actual, message)` - Values are equal
- `self:assertNotEquals(val1, val2, message)` - Values are not equal
- `self:assertNil(value, message)` - Value is nil
- `self:assertNotNil(value, message)` - Value is not nil
- `self:assertType(expectedType, value, message)` - Value is of expected type

## Adding New Tests

### Add a Standalone Test

Edit `GDKPTests_Standalone.lua`:

```lua
function Tests:testYourFeature()
    self:log("Testing your feature...");
    
    -- Arrange
    local something = GL.Something;
    
    -- Act
    local result = something:doThing();
    
    -- Assert
    self:assert(result, "Thing was done");
    
    self:success("Test passed");
end
```

### Add an E2E Step

Edit `GDKPMultiAuctionE2E.lua`:

```lua
function E2E:stepN_YourStep()
    if (not self.isRunning) then return; end
    
    self.currentStep = N;
    self:log("Step N: Doing your thing...");
    
    -- Do your thing
    
    self:success("Your thing done");
    self:scheduleNext(0.5, function() self:stepN+1_NextStep() end);
end
```

Then call it from the previous step's `scheduleNext()`.

## Troubleshooting

### Tests failing
- Check prerequisites (group, items in bags, active session)
- Run `/reload` between test runs to reset state
- Check for lua errors: `/console scriptErrors 1`

### E2E test stuck
- Use `/run GargulMultiAuctionE2E:stop()` to cleanup
- Check which step it's on: `/run print(GargulMultiAuctionE2E.currentStep)`
- Check if running: `/run print(GargulMultiAuctionE2E.isRunning)`

### Widget access errors
- Some widgets may not be accessible via Interface:get()
- Try accessing frames directly: `_G["WindowName"]`
- Check frame hierarchy: `/fstack` (enable in Interface options)

## Best Practices

1. **Always cleanup** - Tests should clean up sessions, windows, etc.
2. **Use helpers** - Reuse helper functions for common operations
3. **Test isolation** - Each test should be independent
4. **Clear assertions** - Use descriptive messages in assertions
5. **Handle async** - Use proper delays for UI operations
6. **Prerequisites** - Check and document what tests need (groups, items, etc.)

## Future Improvements

- [ ] Add tests for single-auction mode
- [ ] Add tests for GDKP pot distribution
- [ ] Add tests for GDKP ledger operations
- [ ] Mock version check to avoid manual intervention
- [ ] Add performance benchmarks
- [ ] Add integration with CI/CD (if possible)
