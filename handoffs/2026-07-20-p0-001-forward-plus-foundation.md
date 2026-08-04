# Handoff — P0-001 Forward+ Visual Benchmark Foundation

## Completed

- Locked gate: `./scripts/verify.sh visual-foundation && ./scripts/verify.sh all`.
- Kept Forward+ client configuration and render-independent headless/network paths.
- Added machine-readable renderer/profile/frame-stability/reload evidence.
- Reproduced the original capture-contaminated metric defect with a failing test, then moved fixed screenshot capture to 0.5 s and preserved a 2.0 s warm-up.
- After independent review found warm-up-boundary contamination, added interval-start sampling so an interval that starts before warm-up cannot enter non-loading metrics; post-warm-up hitches remain measured.
- The visual gate now removes any prior capture before execution and requires the new capture to be non-empty. It also records three post-cleanup reload samples, rejects monotonic object-count growth, and keeps client launch/cove scenes out of headless server startup through lazy scene loading.

## Verification

Final locked gate exited 0:

- `VISUAL_FOUNDATION_EVIDENCE_OK`
- `VISUAL_RELOAD_SOAK_OK`
- `TESTS_OK`, `SERVER_SMOKE_OK`, `SLICE_GATE_OK`, `NETWORK_GATE_OK`, `EVIDENCE_GATE_OK`, `MACOS_EXPORT_GATE_OK`

M4 target evidence: `docs/evidence/m4-2026-07-20-forward-plus-foundation.json`

- Forward+ / Metal 4.0 / Apple M4
- 1600×900, 300 s, target profile
- p95 16.667 ms; 1% low 16.667 ms; worst non-loading 16.667 ms
- memory growth 4,030,437 bytes; 17,881 samples
- three reloads: post-cleanup scene nodes `2,2,2`, object counts `1513,1513,1513`, memory drift 7,176 bytes, and bounded cumulative memory growth

## Independent review

Fresh-context review found a warm-up-boundary sampling issue, stale-screenshot acceptance risk, missing cumulative reload evidence, and client launch-scene preloading on headless routes. The implementation added interval-start sampling, fresh-capture enforcement, machine-checked three-reload cleanup evidence, and lazy client scene loading; the final locked gate above was rerun afterward.

A final independent read-only review returned **no blocking findings**. It noted that Godot's baseline object count (`1499`) is lower than the post-cleanup plateau (`1513`) because first-use engine/resource initialization persists, so the gate enforces the ticket's no-monotonic-growth condition across all three measured cleanup samples and records both values rather than claiming baseline restoration.

## Follow-ups

- Windows RTX 3070 Mobile evidence and human visual review remain unavailable machine-dependent gates for P0-008; no success is claimed.
- No commit, stage, push, PR, deployment, or external tracker action was performed.
