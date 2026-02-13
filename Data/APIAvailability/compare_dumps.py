#!/usr/bin/env python3
"""Compare WoW API dump files and output differences for cursor rule generation."""

import json
import re
from pathlib import Path

DUMP_DIR = Path(__file__).parent / "dumps"

# Client groups: Wrath, Titan, Cata, Mists share the same API (per user)
CLIENTS = {
    "Classic": "Classic_11508.json",   # Era
    "TBC": "TBC_20505.json",            # BCC
    "Wrath+": "Mists_50503.json",      # Wrath, Titan, Cata, Mists
    "Retail": "Retail_120000.json",
}

# Filter: only include globals relevant to addon API development
def is_api_relevant(name):
    if not name or len(name) < 2:
        return False
    # Skip: UI frames, localization strings, numbers, weird chars
    if name[0] in "$0123456789" or " " in name:
        return False
    # LE_* constants (item class, quality, etc.)
    if name.startswith("LE_"):
        return True
    # C_* namespace (C_Container, C_Item, etc.)
    if name.startswith("C_"):
        return True
    # Enum
    if name == "Enum":
        return True
    # Key WoW globals addons use
    if name in ("SOUNDKIT", "tinsert", "tsort", "MAX_TRADABLE_ITEMS", "MEMBERS_PER_RAID_GROUP",
                "MAX_RAID_MEMBERS", "LOOT_SLOT_MONEY", "ItemLocation", "TooltipDataProcessor"):
        return True
    if name.startswith(("MAX_TRADABLE", "MEMBERS_PER", "LOOT_SLOT", "MAX_RAID")):
        return True
    return False


# Filter enum paths to those Gargul or typical addons use
def is_enum_relevant(path):
    prefixes = ("Enum.ItemClass", "Enum.ItemBind", "Enum.BagIndex", "Enum.ItemMiscellaneousSubclass",
                "Enum.UICursorType", "Enum.TooltipDataType", "Enum.SeasonID", "Enum.LootSlotType",
                "Enum.ItemArmorSubclass", "Enum.ItemQuality")
    return any(path.startswith(p) for p in prefixes)


def load_dump(filename):
    path = DUMP_DIR / filename
    if not path.exists():
        return None
    with open(path, encoding="utf-8") as f:
        return json.load(f)


def main():
    data = {}
    for name, filename in CLIENTS.items():
        dump = load_dump(filename)
        if dump:
            data[name] = {
                "globals": set(dump.get("globals", [])),
                "enumPaths": set(dump.get("enumPaths", [])),
            }
        else:
            print(f"Warning: {filename} not found")

    if len(data) < 2:
        print("Need at least 2 dumps to compare")
        return

    all_globals = set()
    all_enum_paths = set()
    for d in data.values():
        all_globals |= d["globals"]
        all_enum_paths |= d["enumPaths"]

    # Find globals that differ across clients (filtered to API-relevant)
    global_diffs = {}
    for g in sorted(all_globals):
        if not is_api_relevant(g):
            continue
        present_in = [c for c in data if g in data[c]["globals"]]
        absent_from = [c for c in data if g not in data[c]["globals"]]
        if present_in and absent_from:
            global_diffs[g] = {"present": present_in, "absent": absent_from}

    # Find enum paths that differ across clients (filtered to addon-relevant)
    enum_diffs = {}
    for p in sorted(all_enum_paths):
        if not is_enum_relevant(p):
            continue
        present_in = [c for c in data if p in data[c]["enumPaths"]]
        absent_from = [c for c in data if p not in data[c]["enumPaths"]]
        if present_in and absent_from:
            enum_diffs[p] = {"present": present_in, "absent": absent_from}

    # Output markdown for cursor rule
    output = []
    output.append("# WoW API Differences Across Clients\n")
    output.append("Generated from dump files. Client groups: Classic (Era), TBC (BCC), Wrath+ (Wrath/Titan/Cata/Mists), Retail.\n")
    output.append("**Legend**: ✓ = present, ✗ = absent\n")

    # Globals that differ
    output.append("\n## Globals with Version Differences\n")
    output.append("| Global | Classic | TBC | Wrath+ | Retail |\n")
    output.append("|--------|---------|-----|--------|--------|\n")

    for g in sorted(global_diffs.keys()):
        d = global_diffs[g]
        row = [g]
        for c in ["Classic", "TBC", "Wrath+", "Retail"]:
            row.append("✓" if c in d["present"] else "✗")
        output.append("| " + " | ".join(row) + " |\n")

    # Enum paths - group by prefix to reduce noise (e.g. Enum.ItemClass.*)
    output.append("\n## Enum Paths with Version Differences\n")
    output.append("*(Only paths that exist in some clients but not others)*\n")

    # Group enum diffs by top-level Enum.X
    enum_by_prefix = {}
    for p, d in enum_diffs.items():
        parts = p.split(".")
        prefix = parts[0] + "." + parts[1] if len(parts) >= 2 else p
        if prefix not in enum_by_prefix:
            enum_by_prefix[prefix] = []
        enum_by_prefix[prefix].append((p, d))

    for prefix in sorted(enum_by_prefix.keys()):
        items = enum_by_prefix[prefix]
        output.append(f"\n### {prefix}.*\n")
        output.append("| Path | Classic | TBC | Wrath+ | Retail |\n")
        output.append("|------|---------|-----|--------|--------|\n")
        for p, d in sorted(items, key=lambda x: x[0]):
            row = [p]
            for c in ["Classic", "TBC", "Wrath+", "Retail"]:
                row.append("✓" if c in d["present"] else "✗")
            output.append("| " + " | ".join(row) + " |\n")

    # Summary stats
    output.insert(2, f"\n**Summary**: {len(global_diffs)} globals differ, {len(enum_diffs)} enum paths differ.\n")

    result = "".join(output)

    # Write to file
    out_path = Path(__file__).parent.parent.parent / ".cursor" / "rules" / "wow-api-diffs.mdc"
    out_path.parent.mkdir(parents=True, exist_ok=True)
    with open(out_path, "w", encoding="utf-8") as f:
        f.write("---\n")
        f.write("description: WoW API differences across clients (Classic, TBC, Wrath+, Retail)\n")
        f.write("globs: \"**/*.lua\"\n")
        f.write("alwaysApply: false\n")
        f.write("---\n\n")
        f.write(result)
    print(f"Wrote {out_path} ({len(global_diffs)} global diffs, {len(enum_diffs)} enum diffs)")


if __name__ == "__main__":
    main()
