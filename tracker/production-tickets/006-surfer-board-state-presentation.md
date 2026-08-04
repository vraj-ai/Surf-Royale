# P0-006 — Surfer, Board, Six-State Presentation, and Interaction Effects

**What to build:** Replace the capsule-and-box presentation with a legally usable production-shaped surfer and surfboard, map all six authoritative surf states to distinct poses/animation states, and add visual contact, wake, splash, wipeout, and projectile feedback without changing mechanics.

**Blocked by:** P0-002 — Authored Cove Seam and Provenance Pipeline.  
**Status:** ready-for-agent  
**Handoff target:** `coder` → `debugger` after this ticket's gate is green.

## Acceptance criteria

- [ ] Normal gameplay and hero-shot frames show recognizable humanoid and surfboard silhouettes rather than capsule/box surrogates.
- [ ] Character, rig, animations, board, textures, and audio/VFX source assets all pass provenance and license validation.
- [ ] Paddling, duck-dive, pop-up, riding, wipeout, and treading each have a distinct normal-camera presentation captured in a state contact sheet.
- [ ] Presentation reads authoritative state but never changes state timing, controller forces, stamina, hitboxes, projectile truth, board truth, or network ownership.
- [ ] Board/surfer alignment stays visually plausible through the scripted scenario without obvious floating, foot sliding at the camera distance, or persistent clipping.
- [ ] Wake, contact, splash, wipeout, and projectile feedback are bounded, independently toggleable, and cleanly reset on scene reload.
- [ ] Temporary Mixamo use, if any, records Adobe terms, source archive, transformation, and replacement status; it does not silently become the final character decision.
- [ ] State readability is reviewed under sun, overcast, and storm checkpoints.
- [ ] No animation root motion or visual offset causes OCEAN-03 alignment or target-readability failure.
- [ ] Existing surf/projectile/network tests remain green with unchanged expected mechanics.

## Relevant invariants

PERF-03, OCEAN-01, AUTH-01, FAIL-02, DATA-01, UX-04, VIS-01.

## Verification-command

```bash
./scripts/verify.sh visual-character && ./scripts/verify.sh all
```

The handoff must link the six-state contact sheet, provenance entries, reload-soak result, and explicit confirmation that gameplay values were not retuned.
