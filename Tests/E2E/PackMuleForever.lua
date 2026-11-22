---@type GL
local _, GL = ...;
---@diagnostic disable: undefined-field, need-check-nil

local L = Gargul_L;

assert(GL.Tests.E2E and GL.Tests.E2E.PackMuleBase, "GL.Tests.E2E.PackMuleBase missing (TOC: Tests/E2E/PackMuleBase.lua before this file)");

local PackMuleBase = GL.Tests.E2E.PackMuleBase;

local CLINE = "Cline Gloomhaunt";
local ADA = "Ada Brightwater";

---@param target string
---@vararg number
---@return table
local function itemRules(target, ...)
    local Rules = {};
    for _, itemID in ipairs({ ... }) do
        table.insert(Rules, { item = tostring(itemID), target = target, });
    end

    return Rules;
end

local THREE_ITEMS = { { id = 25, }, { id = 35, }, { id = 36, }, };

local CASES = {
    {
        title = "Comma-less rule with a space name is one name",
        rules = itemRules(CLINE, 25),
        items = { { id = 25, }, },
        expect = { handouts = { [25] = CLINE, }, },
    },
    {
        title = "Space names without commas are not split",
        rules = itemRules(("%s %s"):format(CLINE, ADA), 25),
        items = { { id = 25, }, },
        expect = { untouched = { 25, }, },
    },
    {
        title = "Comma-separated space names hand out to any of them",
        rules = itemRules(("%s, %s"):format(CLINE, ADA), 25, 35, 36),
        items = THREE_ITEMS,
        expect = { handouts = { [25] = { CLINE, ADA, }, [35] = { CLINE, ADA, }, [36] = { CLINE, ADA, }, }, },
    },
    {
        title = "Priority target (!) works with space names",
        rules = itemRules(("%s, %s!"):format(CLINE, ADA), 25, 35, 36),
        items = THREE_ITEMS,
        expect = { handouts = { [25] = ADA, [35] = ADA, [36] = ADA, }, },
    },
    {
        title = "Placeholder-only rules still split on spaces",
        arrange = function (E2E)
            GL.PackMule.disenchanter = E2E:playerFQN(ADA);
        end,
        rules = itemRules(("%s %s"):format(L["SELF"], L["DE"]), 25, 35, 36),
        items = THREE_ITEMS,
        expect = { handouts = { [25] = { "SELF", ADA, }, [35] = { "SELF", ADA, }, [36] = { "SELF", ADA, }, }, },
    },
    {
        title = "Hyphenated loot candidate spelling matches",
        players = { { name = CLINE, candidateName = "Cline-Gloomhaunt", }, ADA, },
        rules = itemRules(CLINE, 25),
        items = { { id = 25, }, },
        expect = { handouts = { [25] = CLINE, }, },
    },
    {
        title = "First-name-only loot candidate is resolved via the group",
        players = { { name = CLINE, candidateName = "Cline", }, ADA, },
        rules = itemRules(CLINE, 25),
        items = { { id = 25, }, },
        expect = { handouts = { [25] = CLINE, }, },
    },
    {
        title = "Ambiguous first name is not handed out",
        players = {
            { name = CLINE, candidateName = "Cline", },
            { name = "Cline Brightwater", candidateName = "Cline", },
        },
        rules = itemRules(CLINE, 25),
        items = { { id = 25, }, },
        expect = { untouched = { 25, }, },
    },
};

for _, Case in ipairs(CASES) do
    Case.requires = function () return GL.isForever; end;
    Case.skipReason = "Forever only";
end

---@class PackMuleForeverE2E : PackMuleE2EBase
local E2E = PackMuleBase:extend({
    scenarioName = "PackMuleForever",
    label = "PackMule Forever Names E2E",
    PLAYERS = { CLINE, ADA, },
    CASES = CASES,
});
GL.Tests.E2E.PackMuleForever = E2E; ---@type PackMuleForeverE2E

---@return nil
function E2E:onSetup()
    if (GL.isForever) then
        GL.Tests.Fakes.Loot:installUnitShims();
    end
end

return E2E;
