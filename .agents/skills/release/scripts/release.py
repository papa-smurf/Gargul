#!/usr/bin/env python3
"""Bump Gargul's version, commit, push, tag and push the tag.

Usage:
    python3 release.py [patch|minor|major]                   # preview only
    python3 release.py [patch|minor|major] --confirm vX.Y.Z  # release

Bumps "## Version" in Gargul.toc and raises Comm.minimumAppVersion in Data/Constants.lua
to the newest vX.Y.Z tag that is at least one calendar month old (never lowers it).
Commits only those two files as "Version vX.Y.Z", pushes, then creates and pushes tag vX.Y.Z.
Without --confirm nothing is changed; --confirm must match the previewed tag.

Every git call runs as IDENTITY regardless of git config or environment, and nothing is pushed
unless all unpushed commits are authored and committed by IDENTITY.
"""

import argparse
import os
import re
import subprocess
import sys
from datetime import datetime, timezone
from pathlib import Path

ROOT = Path(__file__).resolve().parents[4]
TOC = ROOT / "Gargul.toc"
CONSTANTS = ROOT / "Data" / "Constants.lua"

TOC_VERSION_RE = re.compile(r"^(## Version: )(\d+\.\d+\.\d+)[ \t]*$", re.MULTILINE)
MIN_VERSION_RE = re.compile(r'^([ \t]*minimumAppVersion = ")(\d+\.\d+\.\d+)(",)', re.MULTILINE)
TAG_RE = re.compile(r"^v(\d+)\.(\d+)\.(\d+)$")

IDENTITY_NAME = "papa-smurf"
IDENTITY_EMAIL = "4224975+papa-smurf@users.noreply.github.com"
GIT_ENV = {
    **os.environ,
    "GIT_AUTHOR_NAME": IDENTITY_NAME,
    "GIT_AUTHOR_EMAIL": IDENTITY_EMAIL,
    "GIT_COMMITTER_NAME": IDENTITY_NAME,
    "GIT_COMMITTER_EMAIL": IDENTITY_EMAIL,
}


class ReleaseError(Exception):
    pass


def run(*cmd):
    result = subprocess.run(cmd, cwd=ROOT, capture_output=True, text=True, env=GIT_ENV)
    if result.returncode != 0:
        raise ReleaseError(f"`{' '.join(cmd)}` failed: {result.stderr.strip() or result.stdout.strip()}")
    return result.stdout.strip()


def parse(version):
    return tuple(int(part) for part in version.split("."))


def fmt(version):
    return ".".join(str(part) for part in version)


def bump(version, level):
    major, minor, patch = version
    if level == "major":
        return major + 1, 0, 0
    if level == "minor":
        return major, minor + 1, 0
    return major, minor, patch + 1


def one_month_ago(now):
    year, month = (now.year, now.month - 1) if now.month > 1 else (now.year - 1, 12)
    days_in_month = (datetime(year + month // 12, month % 12 + 1, 1) - datetime(year, month, 1)).days
    return now.replace(year=year, month=month, day=min(now.day, days_in_month))


def newest_tag_older_than(cutoff):
    output = run("git", "for-each-ref", "--format=%(refname:short) %(creatordate:unix)", "refs/tags")
    best = None
    for line in output.splitlines():
        name, timestamp = line.rsplit(" ", 1)
        match = TAG_RE.match(name)
        if not match or datetime.fromtimestamp(int(timestamp), timezone.utc) > cutoff:
            continue
        version = tuple(int(part) for part in match.groups())
        if best is None or version > best:
            best = version
    return best


def assert_unpushed_identity(upstream):
    expected = f"{IDENTITY_NAME} <{IDENTITY_EMAIL}>"
    log = run("git", "log", f"{upstream}..HEAD", "--format=%h%x00%an <%ae>%x00%cn <%ce>%x00%s")
    offenders = []
    for line in log.splitlines():
        sha, author, committer, subject = line.split("\x00", 3)
        if author != expected or committer != expected:
            offenders.append(f"    {sha} author: {author}, committer: {committer} ({subject})")
    if offenders:
        raise ReleaseError(
            f"Unpushed commits not made by {expected} would be pushed; nothing pushed:\n" + "\n".join(offenders)
        )


def single_match(regex, text, path):
    matches = regex.findall(text)
    if len(matches) != 1:
        raise ReleaseError(f"Expected exactly one version match in {path.name}, found {len(matches)}")
    return matches[0]


def main():
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("level", nargs="?", default="patch", choices=["patch", "minor", "major"])
    parser.add_argument("--confirm", metavar="TAG", help="release; must equal the previewed tag, e.g. v8.0.3")
    args = parser.parse_args()

    branch = run("git", "rev-parse", "--abbrev-ref", "HEAD")
    if branch == "HEAD":
        raise ReleaseError("Detached HEAD; check out a branch first")

    run("git", "fetch", "--tags", "origin")
    upstream = run("git", "rev-parse", "--abbrev-ref", "--symbolic-full-name", "@{u}")
    behind = int(run("git", "rev-list", "--count", f"HEAD..{upstream}"))
    if behind:
        raise ReleaseError(f"{branch} is {behind} commit(s) behind {upstream}; pull first")
    assert_unpushed_identity(upstream)

    for path in (TOC, CONSTANTS):
        relative = str(path.relative_to(ROOT))
        if run("git", "status", "--porcelain", "--", relative):
            raise ReleaseError(f"{relative} has uncommitted changes; commit or stash them first")

    toc_text = TOC.read_text(encoding="utf-8")
    constants_text = CONSTANTS.read_text(encoding="utf-8")

    current = parse(single_match(TOC_VERSION_RE, toc_text, TOC)[1])
    new = bump(current, args.level)
    tag = f"v{fmt(new)}"
    if run("git", "tag", "--list", tag) or run("git", "ls-remote", "--tags", "origin", f"refs/tags/{tag}"):
        raise ReleaseError(f"Tag {tag} already exists")

    current_minimum = parse(single_match(MIN_VERSION_RE, constants_text, CONSTANTS)[1])
    cutoff = one_month_ago(datetime.now(timezone.utc))
    candidate = newest_tag_older_than(cutoff)
    new_minimum = max(current_minimum, candidate) if candidate else current_minimum

    other_changes = run("git", "status", "--porcelain", "--untracked-files=all")
    if other_changes:
        print("WARNING: uncommitted changes that will NOT be part of this release:")
        for line in other_changes.splitlines():
            print(f"    {line}")
        print()

    print(f"Branch:            {branch} -> {upstream}")
    print(f"Version:           {fmt(current)} -> {fmt(new)} ({args.level})")
    print(f"Month-old cutoff:  {cutoff:%Y-%m-%d} (newest tag before it: {'v' + fmt(candidate) if candidate else 'none'})")
    print(f"minimumAppVersion: {fmt(current_minimum)} -> {fmt(new_minimum)}")
    print(f"Commit + tag:      Version {tag} / {tag}")
    print(f"Git identity:      {IDENTITY_NAME} <{IDENTITY_EMAIL}>")

    if args.confirm is None:
        print(f"Preview only: nothing changed. Release with --confirm {tag}")
        return
    if args.confirm != tag:
        raise ReleaseError(f"--confirm {args.confirm} does not match the computed tag {tag}; nothing changed")

    TOC.write_text(TOC_VERSION_RE.sub(lambda m: m.group(1) + fmt(new), toc_text), encoding="utf-8")
    CONSTANTS.write_text(
        MIN_VERSION_RE.sub(lambda m: m.group(1) + fmt(new_minimum) + m.group(3), constants_text), encoding="utf-8"
    )

    files = [str(TOC.relative_to(ROOT)), str(CONSTANTS.relative_to(ROOT))]
    run("git", "add", "--", *files)
    run("git", "-c", "commit.gpgsign=false", "commit", "--only", "-m", f"Version {tag}", "--", *files)
    assert_unpushed_identity(upstream)
    run("git", "push", "origin", branch)
    run("git", "tag", tag)
    run("git", "push", "origin", tag)
    print(f"Released {tag}: {run('git', 'rev-parse', '--short', 'HEAD')}")


if __name__ == "__main__":
    try:
        main()
    except ReleaseError as error:
        print(f"Error: {error}", file=sys.stderr)
        sys.exit(1)
