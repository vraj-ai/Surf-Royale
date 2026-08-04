# P0-002 — Authored Cove Seam and Provenance Pipeline

**What to build:** A demoable Tutorial Cove whose presentation is authored through scene/resources rather than constructed inside gameplay orchestration, plus a machine-checked asset provenance pipeline. The existing launch, deterministic scenario, benchmark, and gameplay behavior must continue through the new seam.

**Blocked by:** P0-001 — Forward+ Visual Benchmark Foundation.  
**Status:** ready-for-agent  
**Handoff target:** `coder` → `debugger` after this ticket's gate is green.

## Acceptance criteria

- [ ] Tutorial Cove still launches from the current application flow and all benchmark command modes.
- [ ] Gameplay/state orchestration is separated from authored geometry, materials, environment, particles, animation presentation, HUD layout, and audio presentation.
- [ ] A temporary authored cove replaces runtime-created presentation primitives without changing ocean/surf/projectile/network behavior.
- [ ] Fixed benchmark camera/checkpoint data can drive target, performance, and capture runs.
- [ ] Every third-party asset maps to a machine-readable provenance entry with source, creator, license, license URL, download date, checksum, derivative, transformations, attribution/restrictions, and approval.
- [ ] Missing required content, missing provenance, disallowed licenses, absent notices, or checksum mismatch fail with a named asset/path.
- [ ] CC0 and permissive dependency policies from Production Decision 003 are enforced.
- [ ] Texture-size, 4K-exception, LOD-or-exception, and platform import policies are validated.
- [ ] No paid/custom-license, ripped, uncertain AI-generated, trademark, or unapproved-likeness content is introduced.

## Relevant invariants

PERF-04, FAIL-01, DATA-01, PRIV-01, COMP-03, PERSIST-01.

## Verification-command

```bash
./scripts/verify.sh visual-assets && ./scripts/verify.sh all
```

The ticket handoff must list every acquired dependency/asset family, exact license, pinned version or source ID, and provenance evidence location.
