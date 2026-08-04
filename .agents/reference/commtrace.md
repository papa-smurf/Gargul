# Reading a Gargul comm trace

Produced by `/gl commtrace` (`CommRecorder:formatSession`). Everything below is verified against
`Classes/CommRecorder.lua`, `Classes/Comm.lua`, `Libs/AceComm-3.0/AceComm-3.0.lua` and
`Libs/AceComm-3.0/ChatThrottleLib.lua`. Trust it; don't re-read those files unless you need to
check one specific claim.

## Triage order

1. **`Sent past ChatThrottleLib:` line.** If the rate is at or above `MAX_CPS`, CTL is starved and
   that is the whole diagnosis — stop. Added after v7.7.36; for older traces derive it from `byp=`
   (see below).
2. **A `SEND` with no matching `DONE` for the same `id=`.** That message never reached the wire.
   Strongest single signal in the format.
3. **`DROP` rows.** Reason is spelled out; see the table below.
4. **`ROLL ... event=failed`.** The 5s roll-start watchdog fired (`RollOff:armStartWatchdog`), so
   the master looter saw "Couldn't start the roll".
5. **Latency.** `DONE ... lat=` and `ROLL ... event=echo lat=`. Under ~1s is healthy. High `lat` on
   the very first send is usually just CTL's 5s post-login hard throttle.

## Header

```
Gargul comm trace | v7.7.36 | started <wall clock> | duration 18m59s | group 24
Traffic: Gargul N msg / N B | Other addons N msg / N B
Sent past ChatThrottleLib: N B in Ns = N B/s vs MAX_CPS 800 | CTL STARVED: ...
Outgoing addon traffic by prefix (top offenders):
  PmV5: 4931 msg / 740696 B / 650 B/s
```

- Traffic counters are **outgoing from the reporter's own client only** (a `hooksecurefunc` on
  `C_ChatInfo.SendAddonMessage` / `SendAddonMessageLogged`). A spammy prefix here is an addon
  **they** have installed, not someone else in the raid.
- Those counters include CTL-mediated sends. The prefix table tells you volume, not method.
- Prefix bytes are payload only. The bypass line is higher because CTL also charges 40 B overhead
  per message plus the prefix, and counts `SendChatMessage` traffic the recorder never sees.
- `duration` and the B/s columns are absent on traces captured on v7.7.36 and older.

## Entry rows

`t(ms) | kind | action | detail`, `t` is ms since session start.

| Kind | Meaning |
|------|---------|
| `SEND` | handed to AceComm. Does **not** mean it was transmitted. |
| `DONE` | CTL's send callback fired — it actually went out. |
| `RECV` | dispatched to a handler. |
| `DROP` | rejected on receipt, or a confirm timed out. |
| `ROLL` | roll-off echo/failure marker, initiator only. |
| `CONF` | we sent a receipt confirmation. |

`response` is an **action**, not a kind — it shows up as `RECV | response`.

## Fields

- **`id=`** — outgoing counter, travels in the payload. A `RECV` whose `id=` matches one of our
  `SEND`s is **our own echo**, so that row's `from=` names the reporter.
- **Gaps in the id sequence** — aggregated actions (the GDKP multi-auction ones) consume IDs but
  are rolled into the "High-frequency actions" block instead of getting a row. An id gap plus a
  line in that block is the explanation, not a lost message.
- **`B=`** — payload bytes. On an `xN` coalesced row this is the **sum** of N messages and `t` is
  the **last** one's timestamp. Divide to get the per-message size.
- **`xN`** — consecutive same-action same-channel BULK sends/receives collapsed into one row.
- **`chunks=`** — AceComm splits payloads over 255 B into 254 B chunks and queues them all into CTL
  at once. Expect N `DONE` rows, the first N-1 carrying `PARTIAL sent/total`.
- **`prio=`** — from `PriorityByAction` in `Comm.lua`: only `startRollOff` and `stopRollOff` are
  NORMAL, everything else is BULK. Receives are logged as BULK unconditionally so they coalesce;
  that is a recorder detail, not a real priority.
- **`ctl[...]`** — snapshot taken **before** the send:
  - `av=` — `CTL.avail`, stale, before `UpdateAvail()` tops it up. **Negative `av` with `lat=0ms`
    is normal.** Its magnitude is roughly the bypass bytes accrued since the last refresh.
  - `Qa/Qn/Qb` — queue depth per priority, **global across every CTL addon**, not just Gargul.
  - `byp=` — `CTL.nBypass`, cumulative since login. The delta between two rows over their `t`
    interval is an exact byte rate. Most useful number in the format.
  - `burst/cps` — `CTL.BURST` / `CTL.MAX_CPS`.

## Drop reasons

`decompress-fail`, `not-for-me`, `tamper` (sender name doesn't prefix the claimed FQN),
`sender-outdated`, `not-backwards-compatible`, `missing-action`, `missing-id`,
`confirm-timeout` (3s, only for messages with an `onConfirm`), `unknown-action`.

## ChatThrottleLib rules that drive most diagnoses

One global instance shared by every addon. `MAX_CPS` 800, `BURST` 4000, `MSG_OVERHEAD` 40,
`OnUpdate` every .08s, 5s hard throttle after login and zoning.

- The hook charges `#text + #prefix + #destination + 40` to both `avail` and `nBypass`, and skips
  CTL's own sends via a `bMyTraffic` flag. **Anything counted in `byp` definitively did not use
  the library.**
- `OnUpdate` returns early while `avail < 0`, before `Despool` — so **priority is irrelevant when
  starved**; raising a message to ALERT changes nothing.
- `avail` floors at `-(MAX_CPS*2)` = -1600. A snapshot below that means it is pinned there.
- Once `bQueueing` is set, the direct-send fast path is unavailable until the queues drain.

Net effect: if another addon sustains more than `MAX_CPS` bytes/sec outside CTL, nothing Gargul
queues will **ever** send, and CTL gives no feedback about it.

## Attributing bypass traffic

Charged bytes for prefix P = `bytes(P) + count(P) * (len(P) + 40)`. Compare against the `byp`
delta; the remainder is `SendChatMessage` traffic, which the recorder does not count.

## Known offenders

**ProfessionMaster (`PmV5`)** and **TradeBoard (`TbV1`)**, both by Kurki. They reimplement CTL
privately — same 800 `MAX_CPS`, 4000 `BURST`, 40 overhead, .08s tick — and send through raw
`C_ChatInfo.SendAddonMessage`, so each grants itself a second full-bandwidth budget. Fix for the
user is to disable ProfessionMaster; fix for the author is
`ChatThrottleLib:SendAddonMessage("BULK", prefix, text, channel, target)`.

## Worked example (report of 2026-07-26)

`SEND awardItem id=6 chunks=2` at t=78865 with no `DONE`; `Qb=2` still queued 17.6 minutes later;
`byp` climbing 42094 → 1000700 over that span = 906 B/s against `MAX_CPS` 800; final `av=-1645`
below the -1600 floor. `PmV5` was 4931 of the 4958 non-Gargul messages. Conclusion: ProfessionMaster
starved CTL, the award never broadcast, and a later roll-off was about to fail its watchdog.

## What the trace cannot tell you

- Incoming traffic from other prefixes (outgoing only).
- Which addon owns the messages in `Qa/Qn/Qb`.
- Bursts, if you only use the header rates — those are session averages. Use `byp` deltas between
  two rows to pin down when something started.
