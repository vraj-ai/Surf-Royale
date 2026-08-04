# Handoff — Near-Photoreal Tutorial Cove Production Plan

**Date:** 2026-07-19  
**From:** `planner`  
**Next profile:** `coder`  
**Independent closure:** `debugger`  
**Git authorization:** implementation is authorized; commit, push, PR, deployment, paid acquisition, and external tracker publication are not authorized.

## Outcome

The broad “finish Surf Royale and make it almost photorealistic” request was wayfound into a gated production program. The first decision-complete implementation effort is **P0 — Near-Photoreal Tutorial Cove Visual Foundation**.

P0 is intentionally smaller than the full game. It proves the renderer, visual ocean boundary, content/licensing pipeline, authored presentation seams, gameplay readability, and target-hardware performance before the project invests in full-map, backend, or 50–60-player work.

## Artifact pointer map

- Production Wayfinder: `tracker/production-map.md`
- Research: `docs/research/near-photoreal-godot-production.md`
- P0 spec: `docs/specs/near-photoreal-tutorial-cove.md`
- Resolved decisions:
  - `tracker/production-decisions/001-near-photoreal-gameplay-bar.md`
  - `tracker/production-decisions/002-renderer-and-ocean-boundary.md`
  - `tracker/production-decisions/003-asset-and-scene-pipeline.md`
- Deferred production decisions:
  - `tracker/production-decisions/004-live-service-budget-and-mode-scope.md`
  - `tracker/production-decisions/005-permanent-engine-and-scale-architecture.md`
- Ready implementation tickets: `tracker/production-tickets/001` through `008`

No GitHub issue or other external tracker item was created or modified.

## Decisions locked for P0

- Near-photoreal means physically plausible gameplay presentation at normal camera distances, not film rendering, ray tracing, native 4K, or cinematic effects that harm play.
- Use Godot 4.7.1 Forward+ for desktop clients.
- Keep the headless server rendering-independent.
- CPU `OceanTruth` remains the only gameplay authority. Visual ocean detail cannot feed gameplay or require GPU readback.
- Evaluate OceanFFT only as a pinned MIT spike behind a replaceable visual adapter; rejection is a valid outcome.
- Use authored Blender→glTF content for the compact cove.
- Use CC0-first assets and machine-checked provenance. Paid/custom-license content requires separate approval.
- Defer Terrain3D to the later full-map gate.
- Benchmark native target resolutions first. FSR 2.2 is optional and does not relax readability or frame budgets.
- Preserve every existing ocean, surf, network authority, clean-log, headless, export, and evidence gate.

## Invariants that must survive every ticket

The complete executable table is in the P0 spec. Highest-risk constraints:

- M4 target profile: 1600×900, p95 ≤16.7 ms for 300 s.
- RTX 3070 Mobile target profile: 1920×1080, p95 ≤16.7 ms for 300 s.
- 1% low ≤25 ms; no non-loading frame >50 ms after warm-up.
- Memory growth ≤64 MiB; three scene reloads do not leak resources.
- No GPU readback in gameplay queries.
- Visible large-wave crest/break aligns with CPU truth within 0.5 m horizontal and 0.25 m vertical at sampled checkpoints.
- Existing server authority/network correction and malformed-input gates stay green.
- Every third-party asset has approved provenance/license/checksum/derivative metadata.
- Common texture sets are ≤2K; 4K hero exceptions are explicit and quality-tiered.
- Sun/overcast/storm frames preserve wave, hazard, player, target, projectile, and reserved-zone-hue readability.
- Human visual review is required; automated checks may not fabricate perceptual sign-off.

## Ticket frontier and order

1. **P0-001 — Forward+ Visual Benchmark Foundation**  
   Blocked by: none. **Next ready ticket.**  
   Gate: `./scripts/verify.sh visual-foundation && ./scripts/verify.sh all`

2. **P0-002 — Authored Cove Seam and Provenance Pipeline**  
   Blocked by: P0-001.  
   Gate: `./scripts/verify.sh visual-assets && ./scripts/verify.sh all`

3. **P0-003 — Deterministic Near-Photoreal Ocean Presentation**  
   Blocked by: P0-002.  
   Gate: `./scripts/verify.sh visual-ocean && ./scripts/verify.sh all`

4. **P0-004 — Authored Reef, Shore, Materials, and Foliage**  
   Blocked by: P0-002.  
   Gate: `./scripts/verify.sh visual-cove && ./scripts/verify.sh all`

5. **P0-005 — Lighting, Sky, Weather, Fog, and Quality Profiles**  
   Blocked by: P0-003 and P0-004.  
   Gate: `./scripts/verify.sh visual-environment && ./scripts/verify.sh all`

6. **P0-006 — Surfer, Board, Six-State Presentation, and Interaction Effects**  
   Blocked by: P0-002.  
   Gate: `./scripts/verify.sh visual-character && ./scripts/verify.sh all`

7. **P0-007 — Readability, Audio/HUD Modes, and Visual Evidence Pack**  
   Blocked by: P0-003 through P0-006.  
   Gate: `./scripts/verify.sh visual-evidence && ./scripts/verify.sh all`

8. **P0-008 — Cross-Platform Optimization, Integration, and Production Gate**  
   Blocked by: P0-007.  
   Gate: `./scripts/verify.sh all`

P0-003, P0-004, and P0-006 become independently ready after P0-002, but one coder should still complete and hand off one ticket at a time to protect the shared scene contract.

## Coder operating instructions

- Load and follow `coder` before implementation.
- Read the spec, this handoff, the selected ticket, current git status, existing tests, and affected consumers before editing.
- Implement the lowest-numbered ready ticket first; after a green independent review and ticket handoff, continue to the next ready ticket because the user explicitly requested autonomous completion of the ticket set.
- Lock each ticket's exact `Verification-command` before editing and run a red→green loop at the highest meaningful seam.
- Use a fresh-context auditor for each ticket where available.
- Do not change thresholds, suppress warnings, substitute screenshot confidence for evidence, or mutate authoritative gameplay to simplify rendering.
- Preserve the user's pre-existing untracked `IDEA.md`.
- Do not commit or push.
- Stop only on a true blocker such as unavailable required physical hardware, failed legal source verification, unavailable dependency, or exhausted bounded repair budget. Record exact evidence.

## Debugger operating instructions

After the coder's final handoff, load and follow `debugger`.

Audit with four nets:

1. failing focused/global gates;
2. parser/static/import/export errors and dirty logs;
3. violations of performance, ocean truth, authority, provenance, failure, readability, and compatibility invariants;
4. weak, tautological, driver-fragile, or missing tests/evidence.

Reproduce every confirmed defect before fixing it, repair one at a time test-first, rerun the focused and global gates, then obtain a fresh-context review. Do not commit or push.

## Profile and model routing verified

No re-login or model reconfiguration is needed:

- `coder`: provider `openai-codex`, model `gpt-5.6-terra`, reasoning `high`.
- `debugger`: provider `openai-codex`, model `gpt-5.6-sol`, reasoning `max`.

Both profiles already point at the Codex OAuth responses backend requested by the user.

## Open decisions outside P0

P0 implementation must not guess these:

- live-service budget and whether v1 remains Solos + Duos at 50–60 players;
- permanent engine and production scale architecture;
- public visual-wave data versus hidden future authoritative timing;
- exact weapon TTK contract;
- beginner-pool population fragmentation;
- board-at-zero-integrity semantics;
- release accessibility baseline;
- final character/animation source;
- whether v1 means closed alpha, Early Access, or commercial launch.

## Known evidence limitations

- The current graybox M4 benchmark has effectively no p95 headroom: 16.667 ms against a 16.7 ms threshold.
- Windows performance is not yet recorded and requires the physical RTX 3070 Mobile reference machine. Portable implementation can proceed, but P0-008 cannot claim both-platform success without that run.
- Two delegated web researchers timed out; the planner independently gathered the needed primary-source evidence through official Godot, license, and project sources. The roadmap reviewer completed and its confirmed contradictions were added to the Wayfinder frontier.

## Concurrent P0-001 candidate detected at handoff

During final planning verification, P0-001-shaped application changes appeared in the shared worktree from another Hermes session. The planner did not create or modify those application files, and no tracked background coder process remained active when checked.

Treat the candidate as untrusted, incomplete work—not as a completed ticket:

- `./scripts/verify.sh all` exits `0` on the candidate worktree.
- `./scripts/verify.sh visual-foundation` exits `1` after its unit checks.
- The 300-second evidence records p95 `16.6667 ms`, 1% low `16.6667 ms`, and memory growth `4,977,865` bytes, but fails because `worst_non_loading_frame_ms` is `284.3113 ms`, above the `50 ms` invariant.
- The three-reload evidence passes with stable node count and bounded memory growth.
- There is no P0-001 implementation handoff or independent review.

The coder must begin with P0-001, inspect and attribute the current diff, reproduce the focused failure, determine whether the 284 ms sample is a real runtime hitch or an incorrectly included capture/loading frame, repair test-first without weakening the invariant, rerun both ticket gates, and obtain fresh-eyes review before marking P0-001 complete.

## Current worktree reconciliation

The final planner verification found pre-existing or concurrently authored candidate P0-001 implementation edits in the shared worktree (`project.godot`, verification tooling, benchmark telemetry, Tutorial Cove integration, tests, visual-profile resources, runbook/evidence files). The planner did not author, revert, stage, or claim those changes.

The current global baseline gate exited zero with `TESTS_OK`, `SERVER_SMOKE_OK`, `SLICE_GATE_OK`, `NETWORK_GATE_OK`, `EVIDENCE_GATE_OK`, and `MACOS_EXPORT_GATE_OK`. A later exact rerun of the candidate's focused gate exited `1`: the 300-second file reports 16.667 ms p95, 16.667 ms one-percent-low frame time, 284.311 ms worst non-loading frame time, and 4,977,865 bytes memory growth. The three-reload soak still passes. The later focused result is authoritative; an earlier 46.153 ms file was superseded by the failed rerun.

P0-001 remains the next ticket until the `coder` verifies its exact gate, inspects the diff, obtains the required fresh-eyes review, repairs any findings, and writes a ticket handoff. Do not redo or discard the candidate work merely because it lacks a handoff.

## Commit/push status

No commit, push, PR, deployment, paid acquisition, or external tracker mutation was attempted or authorized.
