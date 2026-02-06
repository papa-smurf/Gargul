#!/usr/bin/env python3
"""
Decode a Gargul /gl bug report (base64 -> zlib -> JSON).

Usage:
  python decode_bug_report.py <path-to-bug-report.txt>
  python decode_bug_report.py   # reads from stdin

Output: Full JSON payload. Use --key to extract specific settings, e.g.:
  python decode_bug_report.py file.txt --key Settings.AutoRoll
  python decode_bug_report.py file.txt --key Settings.AutoRoll.enabled
"""

import argparse
import base64
import json
import re
import sys
import zlib


def decode_bug_report(data: str) -> dict:
    """Decode Gargul bug report: strip non-base64, fix length, base64 -> zlib -> JSON."""
    data = re.sub(r"[^A-Za-z0-9+/=]", "", data)
    if len(data) % 4 == 1:
        data = data[:-1]  # Invalid length; remove trailing char
    decoded = base64.b64decode(data)
    decompressed = zlib.decompress(decoded)
    return json.loads(decompressed.decode("utf-8"))


def get_nested(obj: dict, key_path: str):
    """Get nested key, e.g. 'Settings.AutoRoll.enabled'."""
    for part in key_path.split("."):
        obj = obj.get(part)
        if obj is None:
            return None
    return obj


def main():
    parser = argparse.ArgumentParser(description="Decode Gargul /gl bug report")
    parser.add_argument("file", nargs="?", help="Path to bug report file (or stdin)")
    parser.add_argument("--key", "-k", help="Extract key path, e.g. Settings.AutoRoll")
    parser.add_argument("--compact", "-c", action="store_true", help="Compact JSON output")
    args = parser.parse_args()

    if args.file:
        with open(args.file, "r", encoding="utf-8") as f:
            data = f.read()
    else:
        data = sys.stdin.read()

    try:
        payload = decode_bug_report(data)
    except Exception as e:
        sys.stderr.write(f"Decode failed: {e}\n")
        sys.exit(1)

    if args.key:
        result = get_nested(payload, args.key)
        if result is None:
            sys.stderr.write(f"Key not found: {args.key}\n")
            sys.exit(1)
        output = json.dumps(result, indent=None if args.compact else 2)
    else:
        output = json.dumps(payload, indent=None if args.compact else 2)

    print(output)


if __name__ == "__main__":
    main()
