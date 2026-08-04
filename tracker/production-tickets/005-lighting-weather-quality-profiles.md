# P0-005 — Lighting, Sky, Weather, Fog, and Quality Profiles

**What to build:** A physically plausible and performant environment treatment that carries Tutorial Cove from sun-bleached through overcast to storm-grey while preserving competitive reads. Complete the target/performance/capture quality profiles and isolate each expensive category for profiling.

**Blocked by:** P0-003 — Deterministic Near-Photoreal Ocean Presentation; P0-004 — Authored Reef, Shore, Materials, and Foliage.  
**Status:** ready-for-agent  
**Handoff target:** `coder` → `debugger` after this ticket's gate is green.

## Acceptance criteria

- [ ] Directional sun, sky/IBL, exposure, tone mapping, and review create plausible outdoor ocean lighting without clipped water foreground or crushed hazards.
- [ ] Fixed sun, overcast, and storm checkpoints are deterministic and reusable by evidence capture.
- [ ] Reflection probes or cheaper alternatives are configured with bounded update cost; continuous updates require measured justification.
- [ ] Baked/static indirect lighting is used only where it improves land contact and remains compatible with weather transitions.
- [ ] SSAO/SSIL/SSR are individually profiled; omission is acceptable when cheaper treatment meets the visual bar.
- [ ] Volumetric mist/fog is range-bounded and paired with distant fog as needed; no severe temporal ghosting appears on the scripted camera path.
- [ ] Short-lived combat/interaction lights do not create fog ghost trails.
- [ ] Sun, overcast, and storm checkpoints preserve swell, reef/kelp, player, target, projectile, and reserved-zone-hue readability.
- [ ] Performance, target, and capture profiles visibly select intended settings without touching gameplay.
- [ ] Water detail, reflection, fog, foliage, and particles are independently toggleable and their cost appears in evidence.
- [ ] FSR 2.2 is optional; if enabled, target remains native-resolution acceptance and FSR does not blur critical reads.

## Relevant invariants

PERF-01, PERF-02, FAIL-02, FAIL-03, UX-01, UX-02, VIS-01, COMP-01, COMP-02.

## Verification-command

```bash
./scripts/verify.sh visual-environment && ./scripts/verify.sh all
```

The handoff must include weather checkpoint artifacts and feature-cost measurements, including explicit reasons for every expensive effect retained.
