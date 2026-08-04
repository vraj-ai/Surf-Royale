# P0-008 — Cross-Platform Optimization, Integration, and Production Gate

**What to build:** Integrate and optimize the entire P0 slice, prove the native target profile on M4 and the RTX 3070 Mobile reference machine, preserve all technical gates and exports, complete legal/evidence review, and issue an evidence-backed proceed/adjust/stop decision for P1.

**Blocked by:** P0-007 — Readability, Audio/HUD Modes, and Visual Evidence Pack.  
**Status:** ready-for-agent; Windows performance acceptance remains machine-dependent.  
**Handoff target:** `coder` → `debugger` for independent final audit.

## Acceptance criteria

- [ ] `visual` aggregates every focused P0 suite; `all` includes `visual` and every pre-P0 suite without suppression.
- [ ] M4 target profile passes 300 s at 1600×900 with p95 ≤16.7 ms, 1% low ≤25 ms, no non-loading frame >50 ms, memory growth ≤64 MiB, and three clean reloads.
- [ ] RTX 3070 Mobile target profile passes the same gate at 1920×1080 on the physical reference machine before both-platform success is claimed.
- [ ] Performance evidence includes per-feature/profile costs and no threshold was relaxed to obtain green.
- [ ] Ocean visual/gameplay alignment, authority, malformed-state, network impairment, clean-log, and headless server gates remain green.
- [ ] macOS and Windows exports are generated according to the existing runbook; missing signing/notarization is reported, not hidden.
- [ ] Every dependency/asset passes provenance, notice, attribution, checksum, texture, LOD, and redistribution policy.
- [ ] Fixed visual evidence and the human checklist pass VIS-01 and UX-01 through UX-04, or the ticket remains blocked with exact failures.
- [ ] Diff review finds no secret, unrelated change, hard-coded test answer, disabled warning, or unreviewed binary/source artifact.
- [ ] Final report chooses one: proceed with Godot/Forward+ to the next production decision; adjust visual scope and rerun P0; or stop and reopen the permanent-engine decision.

## Relevant invariants

All P0 invariants, especially PERF-01 through PERF-04, OCEAN-01 through OCEAN-03, AUTH-01, DATA-01, VIS-01, and COMP-01 through COMP-03.

## Verification-command

```bash
./scripts/verify.sh all
```

On Windows reference hardware, run the documented equivalent visual benchmark/export commands and store their exact output. A missing physical Windows run is a declared blocker, not a planner/coder failure and not permission to claim success.
