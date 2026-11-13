---
name: release
description: Releases a new Gargul version by bumping the version in Gargul.toc, raising Comm.minimumAppVersion, committing "Version vX.Y.Z", pushing, and creating and pushing tag vX.Y.Z. Use when the user says "release", "release new version", "release minor", or "release major".
---

# Release

Map the request to a level:

| User says | Level | 8.0.2 becomes |
|-----------|-------|---------------|
| "release" / "release new version" | `patch` | 8.0.3 |
| "release minor" | `minor` | 8.1.0 |
| "release major" | `major` | 9.0.0 |

Git network access is required (`git fetch`/`push` to origin). Run everything from the repo root.

Every commit and push must be made as `papa-smurf <4224975+papa-smurf@users.noreply.github.com>`, never a real name or email. The script forces that identity and refuses to push unpushed commits made by anyone else. Never commit, tag, or push for a release outside the script, and never bypass its identity check (e.g. by amending or rebasing other commits) without the user explicitly asking.

## 1. Preview

```bash
python3 .agents/skills/release/scripts/release.py <level>
```

This changes nothing. It aborts if HEAD is detached, the branch is behind its upstream, an unpushed commit has a different author or committer, `Gargul.toc` or `Data/Constants.lua` has uncommitted changes, or the tag already exists. On error, report the message and stop; don't work around it.

## 2. Confirm

Always ask with the AskQuestion tool before releasing, even if the user already said "release". Options: "Yes, release vX.Y.Z" and "No, cancel".

If the preview printed a `WARNING: uncommitted changes` block, the prompt MUST start with it, in capitals, listing every file, e.g.:

```
⚠️ YOU HAVE UNCOMMITTED CHANGES THAT WILL NOT BE PART OF THIS RELEASE:
- Interface/Settings/PackMuleRules.lua (modified)
- .agents/skills/ (untracked)

About to release v8.0.3, you sure?
- Version: 8.0.2 → 8.0.3
- minimumAppVersion: 8.0.0 → 8.0.1
- Commit "Version v8.0.3" pushed to origin/master, tag v8.0.3 pushed
- As papa-smurf <4224975+papa-smurf@users.noreply.github.com>
```

Without changed files, start with "About to release vX.Y.Z, you sure?".

## 3. Release

Only after the user picks yes:

```bash
python3 .agents/skills/release/scripts/release.py <level> --confirm vX.Y.Z
```

`--confirm` must equal the previewed tag, otherwise the script refuses. It bumps `## Version:` in `Gargul.toc`, sets `minimumAppVersion` in `Data/Constants.lua` to the newest `vX.Y.Z` tag created at least one calendar month ago (only if higher), commits only those two files as `Version vX.Y.Z`, pushes the branch, then creates lightweight tag `vX.Y.Z` and pushes it.

Reply with the old and new version, the `minimumAppVersion` change, and the commit hash.
