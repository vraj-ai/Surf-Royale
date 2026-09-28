# Surf Royale

**A battle royale where the ocean is the map, the vehicle, and the enemy.**

50–60 players drop into a 3×3 km stretch of simulated ocean. You paddle at
about 1 m/s but ride a wave at 6–11 m/s, so waves *are* the vehicles — and
because swell, currents, and weather are forecastable systems rather than
scenery, **reading the ocean is the intended skill gap.** Combat is fast,
audio is directional, and depth is cover, so positioning and information beat
raw aim.

Design pillars:

1. **The ocean is the author.** Waves are the vehicles, the cover, the clock,
   and the comms channel.
2. **Positioning beats tracking.** Fast time-to-kill, hard audio rings,
   depth-as-cover.
3. **Buildable by one developer.** 50–60 players instead of 100, no bot AI, one
   handcrafted tutorial cove, no ongoing SBMM.
4. **No pay-to-win, provably** — cosmetics-only, enforced as testable
   acceptance checks rather than as a promise.

> **Status: archived / paused** (last worked on August 2026). What exists is a
> complete game design document plus a **Godot 4 vertical slice** built to
> de-risk the hard parts — ocean simulation, surf control, and networked
> correction. The engine choice was explicitly a reversible evaluation, not a
> production commitment. There is no playable game here.

## What's actually built

A risk-slice prototype in Godot 4.7 with typed GDScript:

```
src/ocean/       deterministic ocean truth + sampling (the server's source of truth)
src/surf/        surf controller, input, and tuning
src/gameplay/    sidearm projectile
src/network/     session, connection, input validation, client-correction tracking
src/telemetry/   frame metrics for the performance budget
src/visual/      near-photoreal rendering experiments
src/world/       tutorial cove
```

The slice targets a performance ceiling of an RTX 3070 Mobile (the original
reference machine), with an M4 MacBook Air as the primary dev machine.

### Run it

Requires **Godot 4.7.1 exactly** — see `docs/runbooks/godot-setup.md`.

```bash
./scripts/verify.sh          # run the test suites
GODOT_BIN=/path/to/godot ./scripts/verify.sh
```

Open `project.godot` in the Godot editor to play the slice.

## Documentation

The design work is the substantial artifact here. In rough reading order:

| Doc | What it covers |
|-----|----------------|
| [`docs/GDD.md`](docs/GDD.md) | **The game design document** — every system as unambiguous rules with tunable numbers. Start here. |
| [`IDEA.md`](IDEA.md) | The original pitch |
| [`tracker/technical-map.md`](tracker/technical-map.md) | Current (non-UE5) technical direction |
| [`docs/specs/godot-vertical-slice.md`](docs/specs/godot-vertical-slice.md) | Spec for the risk slice that exists in `src/` |
| [`docs/evidence/README.md`](docs/evidence/README.md) | Benchmark evidence backing the technical calls |
| [`docs/research/near-photoreal-godot-production.md`](docs/research/near-photoreal-godot-production.md) | Can Godot hit the visual target? |
| [`docs/specs/near-photoreal-tutorial-cove.md`](docs/specs/near-photoreal-tutorial-cove.md) | Spec for the visual-target cove |
| [`tracker/production-map.md`](tracker/production-map.md) | What full production would require |
| [`handoffs/`](handoffs/) | Session-by-session history — latest: [audit](handoffs/2026-07-18-debugger-godot-risk-slice-audit.md), [plan](handoffs/2026-07-19-near-photoreal-tutorial-cove-plan.md) |

## If you're picking this up again

The open question is the one the slice was built to answer: **can a solo
developer hit semi-photorealistic ocean rendering, at 50–60 players, inside the
hardware budget?** Read `docs/evidence/README.md` for where that stood, then
`tracker/technical-map.md` for what to do next.
