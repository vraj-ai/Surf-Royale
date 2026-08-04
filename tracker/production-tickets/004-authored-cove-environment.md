# P0-004 — Authored Reef, Shore, Materials, and Foliage

**What to build:** A compact near-photoreal cove environment around the deterministic scenario: authored shoreline and reef silhouettes, wet/dry transitions, physically based material families, environmental scale cues, instanced foliage/shore detail, target buoy, collision boundaries, and distance optimization.

**Blocked by:** P0-002 — Authored Cove Seam and Provenance Pipeline.  
**Status:** ready-for-agent  
**Handoff target:** `coder` → `debugger` after this ticket's gate is green.

## Acceptance criteria

- [ ] The intended gameplay frame contains authored reef/shoreline and no accidental box-reef, missing-material, or primitive surrogate.
- [ ] At least three distinct PBR material families are visible (for example rock/reef, sand/shore, vegetation or weathered prop) with plausible scale, roughness, normal, and wetness response.
- [ ] Environmental detail provides scale without hiding the wave, hazard, target, projectile, or player.
- [ ] All acquired content passes provenance and license validation.
- [ ] Common textures remain within the 2K policy; 4K hero exceptions are explicit and quality-tiered.
- [ ] Static meshes use generated/authored LOD or a reviewed exception; broken LOD on critical silhouettes is corrected or disabled with evidence.
- [ ] Repeated vegetation/shore detail uses instancing/MultiMesh where appropriate.
- [ ] Visibility/HLOD transitions show no obvious pop along the scripted camera path.
- [ ] Occlusion culling is added only if profiling demonstrates benefit for actual cove occluders; omission with evidence is valid.
- [ ] Collision and visual hazard boundaries remain consistent with the existing scenario and do not alter surf tuning.

## Relevant invariants

PERF-04, DATA-01, UX-01, UX-02, VIS-01, COMP-01.

## Verification-command

```bash
./scripts/verify.sh visual-cove && ./scripts/verify.sh all
```

The handoff must include provenance summary, texture/geometry/LOD exceptions, and camera-path performance comparison.
