# P0-003 — Deterministic Near-Photoreal Ocean Presentation

**What to build:** A near-photoreal ocean visual layer for the authored cove—large wave form, multi-scale detail, depth/absorption, reflection, refraction where affordable, break/reef foam, wakes, spray, and underwater transition—whose visible large-wave behavior remains aligned with deterministic CPU gameplay truth.

**Blocked by:** P0-002 — Authored Cove Seam and Provenance Pipeline.  
**Status:** ready-for-agent  
**Handoff target:** `coder` → `debugger` after this ticket's gate is green.

## Acceptance criteria

- [ ] CPU `OceanTruth` remains the only owner of gameplay height, normal, velocity, current, break, underwater, movement, and projectile-water checks.
- [ ] The visual layer consumes a bounded deterministic snapshot/interface and cannot write gameplay truth.
- [ ] No gameplay tick performs or waits for GPU readback.
- [ ] Large visible wave crest/break markers stay within OCEAN-03 tolerances at fixed benchmark checkpoints.
- [ ] Target profile demonstrates coherent large-wave silhouette, fine normal detail, depth/absorption variation, horizon/sky reflection, and localized foam at break/reef interaction.
- [ ] Wake, splash, spray, and underwater effects are visual-only, bounded, lifecycle-safe, and individually toggleable.
- [ ] Reflection/refraction choices are backed by feature-off/on cost evidence; unsupported expensive effects may be omitted if the visual bar still passes.
- [ ] Any OceanFFT evaluation is pinned, isolated behind the adapter, licensed, and removable; adopting it requires cross-platform and lifecycle evidence. Rejecting it is an acceptable result.
- [ ] Existing ocean, surf, projectile, network seed, and malformed-state gates remain green.

## Relevant invariants

OCEAN-01, OCEAN-02, OCEAN-03, AUTH-01, FAIL-02, UX-01, VIS-01.

## Verification-command

```bash
./scripts/verify.sh visual-ocean && ./scripts/verify.sh all
```

The handoff must include alignment evidence and per-feature frame-cost deltas; screenshots alone are insufficient.
