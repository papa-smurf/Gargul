---
name: update-libs
description: Checks and updates the third-party WoW libraries vendored in Libs/ (Ace3, LibCandyBar, LibCustomGlow, LibDBIcon, LibDeflate, LibSerialize, LibSharedMedia, LibUIDropDownMenu, lib-st) from their upstream GitHub and WowAce SVN sources, keeping Gargul's local forks via 3-way merge. Use when the user asks to update, upgrade, or check versions of the libs, libraries, Ace, or embeds in Libs/.
---

# Update Libs

`libs.json` lists each lib's upstream, the files Gargul ships, and `vendored`: the upstream revision the local copy is based on. `scripts/update_libs.py` 3-way merges local, base, and latest upstream, so Gargul's changes survive. It also re-applies the `transforms` renames, fills in packager tokens (`@project-timestamp@`, ...), and expands SVN `$Rev$` keywords.

Run it with `required_permissions: ["all"]`. It needs repos.wowace.com, which isn't on the sandbox allowlist, and it caches clones in the system temp dir. A full run takes about two minutes because WowAce SVN is slow.

## Workflow

1. **Check** (read-only):
   ```bash
   python3 .agents/skills/update-libs/scripts/update_libs.py check
   ```
2. **Report** to the user which libs have updates, with the upstream commit messages the script prints. Call out anything in "Risky libs" below.
3. **Update** all libs, or only the named ones. This writes files and bumps `vendored` in `libs.json`:
   ```bash
   python3 .agents/skills/update-libs/scripts/update_libs.py update [Name ...]
   ```
4. **Resolve conflicts.** Search `Libs/` for `<<<<<<< gargul`. Keep what Gargul's side was for (see "Forks"), port upstream's fixes into it, and remove every marker.
5. **Verify**:
   - `git diff --stat -- Libs .agents/skills/update-libs/libs.json`
   - Syntax-check every changed `.lua` file with a Lua 5.1 `luac -p`. On Windows that's `Scripts\bin\luac5.1.exe -p <file>`. `Scripts/validate_lua.lua` skips `Libs/`.
   - Upstreams now target Retail 12.x (`issecretvalue`, `C_*`, `TextureUtil`, ...). Check new globals in the diff against `.agents/rules/wow-api-diffs.mdc`. Every client Gargul supports must load the lib, or the lib must guard the call.
   - If a lib's API changed (methods removed or renamed), check Gargul's call sites, e.g. `rg 'LibCandyBarGargul-3.0|LibCustomGlowGargul-1.0|LibDBIcon|LibSharedMedia'`.
6. Don't commit. Tell the user what to test in-game: trade timer bars, glow highlights, the minimap icon, dropdowns, and comms with an older Gargul version.

## Forks

The renames are applied automatically by `transforms`. Never undo them: other addons' copies of these libs would then hook Gargul's.

Gargul's own edits inside lib files are marked `-- Gargul:`. Keep them when resolving conflicts.

- **LibCandyBar-3.0**: renamed to `LibCandyBarGargul-3.0`. Its update loop only reformats the time text when the shown value changes (trade timer performance). `ClearText`/`ClearScripts` are guarded with fallbacks, and scripts are cleared after `Hide()` so `OnLeave` still hides tooltips. Conflicts are expected. Usually the cleanest fix is to take upstream's file and re-apply the `-- Gargul:` blocks.
- **LibCustomGlow-1.0**: renamed to `LibCustomGlowGargul-1.0`, because ElvUI strips the shared glow. There are no other patches.
- **LibSharedMedia-3.0**: `C_UIFileAsset.IsKnownFile` is guarded.

## Client support

Gargul's TOC targets Era, Forever, TBC, Wrath, Titan, Cata, Mists and Retail. Upstreams increasingly use 2026-era APIs without guards, such as `FontString:ClearText` and `C_UIFileAsset`, and some drop clients from their TOC. Compare each upstream `.toc` `## Interface` line with `Gargul.toc`. For new unguarded calls, check warcraft.wiki.gg's "Game Types". If a call is missing on a client Gargul supports, add a `-- Gargul:` guard, or ask the user if upstream dropped that client.

## Risky libs

- **LibSerialize, LibDeflate, AceComm-3.0 (with ChatThrottleLib)**: these carry data between players who may run different Gargul versions. Read upstream's changes for wire-format changes. Older clients must still decode the new output, so LibSerialize's `SERIALIZATION_VERSION` must stay `1`. If it doesn't, stop and ask the user.
- **LibUIDropDownMenu**: exists to avoid taint. Big jumps need in-game testing on Era/Forever and Retail. Since r140, upstream supports only Era, Forever, TBC, Mists and Retail.

## Manifest fields

| Field | Meaning |
|---|---|
| `source.type` | `git` (`url`, `track`: `branch` = default branch, or `tag` = newest tag) or `svn` (`url` = repo root, `path` = `trunk`) |
| `files` | `from` (upstream path) → `to` (local path). A trailing `/` mirrors a whole directory, including deletions. |
| `transforms` | `[old, new]` string replacements applied to upstream text before merging |
| `vendored` | Base git SHA or SVN revision. `null` means none recorded: the next update overwrites local files. |
| `pinned` | Never touched (LibDeformat-3.0: upstream is gone) |

To add a lib, add an entry, set `vendored` to the upstream revision the local copy matches (find it by diffing), then run `check`.

Only the files Gargul loads (see `libraries.xml`) are managed. Nested LibStub/CallbackHandler copies inside lib folders, stale `.toc`/`CHANGES.txt` files, and `Libs/!LibUIDropDownMenu/` aren't loaded, so they're ignored.
