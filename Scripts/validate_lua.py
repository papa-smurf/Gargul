#!/usr/bin/env python3
"""
Validate Lua syntax for Gargul addon files.

Uses luac -p (Lua 5.1 compiler) when available. WoW uses Lua 5.1, so luac
provides authoritative syntax validation.

Usage:
  python Scripts/validate_lua.py                    # validate all .lua files
  python Scripts/validate_lua.py path/to/file.lua  # validate specific file(s)
  python Scripts/validate_lua.py Classes/          # validate directory
  python Scripts/validate_lua.py --luac "C:\\path\\to\\luac5.1.exe"  # if not in PATH

Install Lua 5.1 (for luac). WoW uses Lua 5.1; winget's Lua is 5.4.
  - Windows: LuaBinaries 5.1.5 from https://sourceforge.net/projects/luabinaries/files/5.1.5/Tools%20Executables/
  - Or: https://www.lua.org/download.html
  - Add folder to PATH (LuaBinaries provides luac5.1.exe)
"""

import argparse
import subprocess
import sys
import tempfile
from pathlib import Path
from typing import List, Optional, Tuple

UTF8_BOM = b"\xef\xbb\xbf"


# Directories to skip (Libs are third-party; Data may have non-standard Lua)
SKIP_DIRS = {".git", "Libs", "automations", "Data", "Scripts"}


def find_lua_files(root: Path, paths: Optional[List[Path]]) -> List[Path]:
    """Collect .lua files to validate."""
    if paths:
        files = []
        for p in paths:
            p = Path(p)
            if p.is_file() and p.suffix == ".lua":
                files.append(p)
            elif p.is_dir():
                files.extend(f for f in p.rglob("*.lua") if not any(s in f.parts for s in SKIP_DIRS))
        return sorted(set(files))

    # Default: all .lua in project, excluding skip dirs
    root = Path(root)
    return [
        f
        for f in root.rglob("*.lua")
        if not any(s in f.parts for s in SKIP_DIRS)
    ]


def validate_with_luac(file_path: Path, luac_cmd: Optional[str] = None) -> Tuple[bool, str]:
    """Validate using luac -p. Returns (ok, error_message)."""
    # Lua 5.1 chokes on UTF-8 BOM; strip it to a temp file for validation
    raw = file_path.read_bytes()
    if raw.startswith(UTF8_BOM):
        raw = raw[len(UTF8_BOM) :]
    with tempfile.NamedTemporaryFile(suffix=".lua", delete=False) as tmp:
        tmp.write(raw)
        tmp_path = tmp.name
    try:
        cmds = [luac_cmd] if luac_cmd else ["luac5.1", "luac"]
        for cmd in cmds:
            if not cmd:
                continue
            try:
                result = subprocess.run(
                    [cmd, "-p", tmp_path],
                    capture_output=True,
                    text=True,
                    timeout=5,
                )
                if result.returncode == 0:
                    return True, ""
                return False, (result.stderr or result.stdout or "unknown error").strip()
            except FileNotFoundError:
                continue
            except subprocess.TimeoutExpired:
                return False, "timeout"
        return False, "luac not found (try --luac path or add luac5.1 to PATH)"
    finally:
        try:
            Path(tmp_path).unlink()
        except OSError:
            pass


def main():
    parser = argparse.ArgumentParser(description="Validate Lua syntax for Gargul addon files")
    parser.add_argument(
        "paths",
        nargs="*",
        help="Files or directories to validate (default: all .lua in project)",
    )
    parser.add_argument(
        "--root",
        default=Path(__file__).resolve().parent.parent,
        type=Path,
        help="Project root (default: parent of Scripts/)",
    )
    parser.add_argument(
        "--luac",
        metavar="PATH",
        help="Path to luac5.1.exe (if not in PATH)",
    )
    args = parser.parse_args()

    paths = [Path(p) for p in args.paths] if args.paths else None
    files = find_lua_files(args.root, paths)
    if not files:
        print("No .lua files found to validate.")
        sys.exit(0)

    errors = []
    for f in files:
        ok, msg = validate_with_luac(f, args.luac)
        try:
            rel = f.relative_to(args.root)
        except ValueError:
            rel = f
        if ok:
            print(f"OK   {rel}")
        else:
            print(f"FAIL {rel}")
            if msg:
                for line in msg.splitlines():
                    print(f"     {line}")
            errors.append((rel, msg))

    if errors:
        print(f"\n{len(errors)} file(s) failed validation.")
        if errors and "luac not found" in errors[0][1]:
            print("\nInstall Lua 5.1 to enable validation (WoW uses 5.1; winget's Lua is 5.4):")
            print("  LuaBinaries: https://sourceforge.net/projects/luabinaries/files/5.1.5/Tools%20Executables/")
            print("  Or: https://www.lua.org/download.html")
            print("  Use --luac path/to/luac5.1.exe or add luac5.1 to PATH.")
        sys.exit(1)

    print(f"\nAll {len(files)} file(s) passed.")
    sys.exit(0)


if __name__ == "__main__":
    main()
