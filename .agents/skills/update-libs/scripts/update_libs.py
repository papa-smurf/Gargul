#!/usr/bin/env python3
"""Check or update the vendored libraries in Libs/ against their upstream sources.

Usage:
    python3 update_libs.py check [Name ...]
    python3 update_libs.py update [Name ...] [--force]

Each lib in ../libs.json records the upstream revision the local copy is based on
("vendored"). Updates are 3-way merges against that base, so Gargul's own changes survive.
Needs git and network access to github.com and repos.wowace.com.
"""

import argparse
import difflib
import json
import re
import subprocess
import sys
import tempfile
import time
import urllib.error
import urllib.parse
import urllib.request
from html import unescape
from pathlib import Path
from xml.etree import ElementTree

SKILL_DIR = Path(__file__).resolve().parent.parent
MANIFEST = SKILL_DIR / "libs.json"
ROOT = SKILL_DIR.parents[2]
CACHE = Path(tempfile.gettempdir()) / "gargul-lib-cache"

KEYWORD_RE = re.compile(
    r"\$(Id|Rev|Revision|LastChangedRevision|Date|LastChangedDate|Author|LastChangedBy|HeadURL|URL)(?::[^$\n]*)?\$"
)
REV_KEYWORD_RE = re.compile(r"\$(Rev|Revision|LastChangedRevision)\$")
TOKEN_RE = re.compile(r"@(?:project|file)-[a-z-]+@")
MAX_LOG_LINES = 40


class LibError(Exception):
    pass


def run(cmd, cwd=None, check=True):
    result = subprocess.run(cmd, cwd=cwd, capture_output=True, text=True, encoding="utf-8", errors="replace")
    if check and result.returncode != 0:
        raise LibError(f"`{' '.join(cmd)}` failed: {result.stderr.strip() or result.stdout.strip()}")
    return result


def http(url, method="GET", body=None):
    request = urllib.request.Request(url, data=body, method=method, headers={"User-Agent": "gargul-update-libs"})
    if body is not None:
        request.add_header("Content-Type", "text/xml")
    for attempt in range(3):
        try:
            with urllib.request.urlopen(request, timeout=60) as response:
                return response.read()
        except urllib.error.HTTPError as error:
            raise LibError(f"HTTP {error.code} for {url}")
        except (urllib.error.URLError, TimeoutError) as error:
            if attempt == 2:
                raise LibError(f"Can't reach {url} ({error}). Does this shell have network access?")
            time.sleep(2)


def decode(data):
    return data.decode("utf-8", "surrogateescape")


def normalize(text):
    """LF line endings, collapsed VCS keywords, exactly one trailing newline."""
    text = text.replace("\r\n", "\n").replace("\r", "\n")
    text = KEYWORD_RE.sub(lambda m: f"${m.group(1)}$", text)
    return text.rstrip("\n") + "\n"


def comparable(text):
    lines = [line.rstrip() for line in text.split("\n")]
    while lines and not lines[-1]:
        lines.pop()
    return lines


def same(a, b):
    return comparable(a) == comparable(b)


def substitute_tokens(text, tokens):
    return TOKEN_RE.sub(lambda m: tokens.get(m.group(0)[1:-1], m.group(0)), text)


def token_pattern(raw_line):
    parts, last = [], 0
    for match in TOKEN_RE.finditer(raw_line):
        parts.append(re.escape(raw_line[last:match.start()]))
        parts.append(".*?")
        last = match.end()
    parts.append(re.escape(raw_line[last:].rstrip()))
    return "".join(parts)


def canonicalize_local(local, base_raw, base_sub):
    """Swap local lines that differ from base only by a filled-in packager token for the base's version."""
    local_lines, raw_lines, sub_lines = local.split("\n"), base_raw.split("\n"), base_sub.split("\n")
    if len(raw_lines) != len(sub_lines):
        return local
    matcher = difflib.SequenceMatcher(None, local_lines, raw_lines, autojunk=False)
    for tag, i1, i2, j1, j2 in matcher.get_opcodes():
        if tag != "replace" or i2 - i1 != j2 - j1:
            continue
        for offset in range(i2 - i1):
            raw = raw_lines[j1 + offset]
            if TOKEN_RE.search(raw) and re.fullmatch(token_pattern(raw), local_lines[i1 + offset].rstrip()):
                local_lines[i1 + offset] = sub_lines[j1 + offset]
    return "\n".join(local_lines)


def merge(local, base, new, base_label, new_label):
    with tempfile.TemporaryDirectory() as tmp:
        paths = []
        for name, text in (("local", local), ("base", base), ("new", new)):
            path = Path(tmp) / name
            path.write_bytes(text.encode("utf-8", "surrogateescape"))
            paths.append(str(path))
        result = run(
            ["git", "merge-file", "-p", "-L", "gargul", "-L", f"base {base_label}", "-L", f"upstream {new_label}", *paths],
            check=False,
        )
        if result.returncode < 0:
            raise LibError(f"git merge-file failed: {result.stderr.strip()}")
        return result.stdout, result.returncode


class GitSource:
    def __init__(self, lib):
        self.lib = lib
        self.source = lib["source"]
        self.repo = CACHE / re.sub(r"[^A-Za-z0-9_.-]", "_", lib["name"])

    def describe(self):
        return f"git {self.source['url']}"

    def git(self, *args, check=True):
        return run(["git", "-C", str(self.repo), *args], check=check).stdout.strip()

    def prepare(self):
        if (self.repo / "HEAD").exists():
            self.git("fetch", "--quiet", "--force", "--tags", "--prune", "origin", "+refs/heads/*:refs/heads/*")
        else:
            CACHE.mkdir(parents=True, exist_ok=True)
            run(["git", "clone", "--quiet", "--bare", "--filter=blob:none", self.source["url"], str(self.repo)])

    def latest(self):
        if self.source.get("track") == "tag":
            tags = self.git("tag", "--sort=-creatordate").splitlines()
            if not tags:
                raise LibError("upstream has no tags")
            return self.git("rev-parse", f"{tags[0]}^{{commit}}")
        return self.git("rev-parse", self.source.get("branch", "HEAD") + "^{commit}")

    def label(self, ref):
        return self.git("describe", "--tags", "--always", ref, check=False) or ref[:7]

    def list_files(self, ref, path):
        if not path.endswith("/"):
            return [path]
        out = self.git("ls-tree", "-r", "--name-only", ref, "--", path)
        return [line for line in out.splitlines() if line]

    def read(self, ref, path):
        result = subprocess.run(["git", "-C", str(self.repo), "show", f"{ref}:{path}"], capture_output=True)
        if result.returncode != 0:
            return None
        return decode(result.stdout)

    def tokens(self, ref):
        stamp = int(self.git("log", "-1", "--format=%ct", ref))
        version = self.label(ref)
        return {
            "project-timestamp": str(stamp),
            "file-timestamp": str(stamp),
            "project-version": version,
            "project-hash": ref,
            "file-hash": ref,
            "project-abbreviated-hash": ref[:7],
            "file-abbreviated-hash": ref[:7],
            "project-date-iso": time.strftime("%Y-%m-%dT%H:%M:%SZ", time.gmtime(stamp)),
            "project-date-integer": time.strftime("%Y%m%d%H%M%S", time.gmtime(stamp)),
        }

    def expand(self, text, ref):
        return text

    def log(self, base, new, paths):
        if not base:
            return []
        out = self.git("log", "--format=%h %as %s", f"{base}..{new}", "--", *[p.rstrip("/") for p in paths], check=False)
        return out.splitlines()


class SvnSource:
    def __init__(self, lib):
        self.lib = lib
        self.source = lib["source"]
        self.url = self.source["url"].rstrip("/")
        self.path = self.source.get("path", "trunk").strip("/")

    def describe(self):
        return f"svn {self.url}/{self.path}"

    def prepare(self):
        pass

    def latest(self):
        html = decode(http(f"{self.url}/{self.path}/"))
        match = re.search(r"Revision (\d+)", html)
        if not match:
            raise LibError(f"Can't read the revision from {self.url}/{self.path}/")
        return match.group(1)

    def label(self, ref):
        return f"r{ref}"

    def _url(self, ref, path):
        return f"{self.url}/!svn/bc/{ref}/{self.path}/{urllib.parse.quote(path)}"

    def list_files(self, ref, path):
        if not path.endswith("/"):
            return [path]
        try:
            html = decode(http(self._url(ref, path)))
        except LibError:
            return []
        files = []
        for href in re.findall(r'<li><a href="([^"]+)">', html):
            name = urllib.parse.unquote(unescape(href))
            if name == "../":
                continue
            files.extend(self.list_files(ref, path + name) if name.endswith("/") else [path + name])
        return files

    def read(self, ref, path):
        try:
            return decode(http(self._url(ref, path)))
        except LibError as error:
            if "HTTP 404" in str(error):
                return None
            raise

    def tokens(self, ref):
        return {"project-revision": ref, "file-revision": ref, "project-version": f"r{ref}"}

    def expand(self, text, ref):
        # Uses the repo revision, not the file's last-changed one; only matters for LibStub minor versions.
        return REV_KEYWORD_RE.sub(lambda m: f"${m.group(1)}: {ref} $", text)

    def log(self, base, new, paths):
        if not base or int(base) >= int(new):
            return []
        body = (
            '<?xml version="1.0"?><S:log-report xmlns:S="svn:">'
            f"<S:start-revision>{new}</S:start-revision><S:end-revision>{int(base) + 1}</S:end-revision>"
            "<S:path></S:path></S:log-report>"
        ).encode()
        entries = {}
        for path in paths:
            try:
                root = ElementTree.fromstring(http(self._url(new, path.rstrip("/")), method="REPORT", body=body))
            except (LibError, ElementTree.ParseError):
                continue
            for item in root.findall("{svn:}log-item"):
                rev = item.findtext("{DAV:}version-name")
                date = (item.findtext("{svn:}date") or "")[:10]
                comment = (item.findtext("{DAV:}comment") or "").strip().splitlines()
                entries[int(rev)] = f"r{rev} {date} {comment[0] if comment else ''}"
        return [entries[rev] for rev in sorted(entries, reverse=True)]


def make_source(lib):
    kind = lib["source"]["type"]
    if kind == "git":
        return GitSource(lib)
    if kind == "svn":
        return SvnSource(lib)
    raise LibError(f"unknown source type {kind}")


def collect(source, lib, ref):
    """Upstream files at ref, keyed by local path: (raw, substituted)."""
    tokens = source.tokens(ref)
    files = {}
    for mapping in lib["files"]:
        src, dest = mapping["from"], mapping["to"]
        for path in source.list_files(ref, src):
            text = source.read(ref, path)
            if text is None:
                continue
            for old, new in lib.get("transforms", []):
                text = text.replace(old, new)
            raw = normalize(text)
            local_path = dest + path[len(src):] if src.endswith("/") else dest
            files[local_path] = (raw, substitute_tokens(raw, tokens))
    return files


def local_files(lib):
    paths = set()
    for mapping in lib["files"]:
        dest = ROOT / mapping["to"]
        if mapping["to"].endswith("/"):
            if dest.is_dir():
                paths.update(
                    p.relative_to(ROOT).as_posix() for p in dest.rglob("*") if p.is_file() and p.name != ".DS_Store"
                )
        elif dest.is_file():
            paths.add(mapping["to"])
    return paths


def process(lib, apply, force):
    source = make_source(lib)
    source.prepare()
    base_ref = lib.get("vendored")
    new_ref = source.latest()
    new_label = source.label(new_ref)
    base_label = lib.get("vendoredLabel") or (source.label(base_ref) if base_ref else "unknown")

    print(f"\n== {lib['name']} ({source.describe()})")
    print(f"   base {base_label} -> upstream {new_label}")
    if base_ref == new_ref and not force:
        print("   up to date")
        return 0

    new_files = collect(source, lib, new_ref)
    if not new_files:
        raise LibError("upstream returned no files; check the 'files' mapping")
    base_files = collect(source, lib, base_ref) if base_ref else {}
    actions, conflicts = [], 0
    dir_mapped = any(m["to"].endswith("/") for m in lib["files"])

    for path in sorted(set(new_files) | set(base_files) | local_files(lib)):
        target = ROOT / path
        local = normalize(decode(target.read_bytes())) if target.is_file() else None
        new = new_files.get(path)
        base = base_files.get(path)
        if local is not None and base:
            local = canonicalize_local(local, base[0], base[1])

        if new:
            if local is None:
                actions.append(("added", path, new[1]))
            elif same(local, new[1]):
                continue
            elif not base_ref:
                actions.append(("overwritten", path, new[1]))
            elif base and same(local, base[1]):
                actions.append(("updated", path, new[1]))
            elif base and same(new[1], base[1]):
                actions.append(("kept local changes", path, None))
            else:
                merged, count = merge(local, base[1] if base else "", new[1], base_label, new_label)
                conflicts += count
                actions.append((f"CONFLICT x{count}" if count else "merged", path, merged))
        elif local is not None:
            if base:
                if same(local, base[1]):
                    actions.append(("removed upstream", path, ""))
                else:
                    conflicts += 1
                    actions.append(("CONFLICT: removed upstream, changed locally (kept)", path, None))
            elif not base_ref and dir_mapped:
                actions.append(("removed (not upstream)", path, ""))

    changed = [a for a in actions if a[2] is not None]
    if not actions:
        print("   local files already match upstream")
    for status, path, _ in actions:
        print(f"   {'' if apply else 'would be '}{status}: {path}")
    if changed and lib.get("notes"):
        print(f"   note: {lib['notes']}")

    log = source.log(base_ref, new_ref, [m["from"] for m in lib["files"]])
    if log:
        print("   upstream changes:")
        for line in log[:MAX_LOG_LINES]:
            print(f"     {line}")
        if len(log) > MAX_LOG_LINES:
            print(f"     ... and {len(log) - MAX_LOG_LINES} more")

    if apply:
        for status, path, text in changed:
            target = ROOT / path
            if text == "" and status.startswith("removed"):
                target.unlink()
                continue
            target.parent.mkdir(parents=True, exist_ok=True)
            target.write_bytes(source.expand(text, new_ref).encode("utf-8", "surrogateescape"))
        lib["vendored"] = new_ref
        lib["vendoredLabel"] = new_label
    return conflicts


def main():
    parser = argparse.ArgumentParser(description="Check or update vendored libraries in Libs/.")
    parser.add_argument("mode", choices=["check", "update"])
    parser.add_argument("names", nargs="*", help="lib names from libs.json (default: all)")
    parser.add_argument("--force", action="store_true", help="re-sync even when the recorded base is the latest")
    args = parser.parse_args()

    if not (ROOT / "libraries.xml").is_file():
        sys.exit(f"Can't find the addon root (expected libraries.xml in {ROOT})")

    manifest = json.loads(MANIFEST.read_text(encoding="utf-8"))
    wanted = {n.lower() for n in args.names}
    known = {lib["name"].lower() for lib in manifest["libs"]}
    if wanted - known:
        sys.exit(f"Unknown lib(s): {', '.join(sorted(wanted - known))}. Known: {', '.join(l['name'] for l in manifest['libs'])}")

    conflicts, errors = 0, 0
    for lib in manifest["libs"]:
        if wanted and lib["name"].lower() not in wanted:
            continue
        if lib.get("pinned"):
            print(f"\n== {lib['name']}\n   pinned: {lib.get('notes', '')}")
            continue
        try:
            conflicts += process(lib, args.mode == "update", args.force)
        except LibError as error:
            errors += 1
            print(f"   ERROR: {error}")

    if args.mode == "update":
        MANIFEST.write_text(json.dumps(manifest, indent=2) + "\n", encoding="utf-8")

    print()
    if errors:
        print(f"{errors} lib(s) failed.")
    if conflicts:
        print(f"{conflicts} conflict(s). Search Libs/ for '<<<<<<< gargul' and resolve them.")
    sys.exit(2 if errors else 1 if conflicts else 0)


if __name__ == "__main__":
    main()
