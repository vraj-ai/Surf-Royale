# P0-007 — Readability, Audio/HUD Modes, and Visual Evidence Pack

**What to build:** Integrate the completed cove presentation into an auditable evidence pack: dual-channel swell cues, clean capture mode, debug/evidence mode, fixed hero shots, six-state contact sheet, weather checkpoints, and a scripted camera-path capture or frame sequence with a human review checklist.

**Blocked by:** P0-003 — Deterministic Near-Photoreal Ocean Presentation; P0-004 — Authored Reef, Shore, Materials, and Foliage; P0-005 — Lighting, Sky, Weather, Fog, and Quality Profiles; P0-006 — Surfer, Board, Six-State Presentation, and Interaction Effects.  
**Status:** ready-for-agent  
**Handoff target:** `coder` → `debugger` after this ticket's gate is green.

## Acceptance criteria

- [ ] Critical wave approach retains both visual and audio channels, and each channel can be tested independently.
- [ ] Evidence/debug mode displays state, speed, stamina, wave, renderer, driver, profile, and benchmark status.
- [ ] Capture mode hides debug chrome without hiding gameplay-critical world presentation.
- [ ] Fixed evidence includes forward travel, wave approach/break, reef hazard, surfer/board, six-state contact sheet, and sun/overcast/storm checkpoints.
- [ ] Fixed evidence also includes the underwater transition and preserves interactable separation at normal camera distance.
- [ ] Evidence metadata records Godot version, platform, architecture, renderer, driver, profile, resolution, seed, camera/checkpoint ID, and timestamp.
- [ ] The scripted camera path/frame sequence shows no severe temporal ghosting, reflection smear, detached foam, horizon seam, missing material, or obvious LOD pop.
- [ ] Reserved zone hue is absent from non-zone UI/VFX and HUD contrast remains within the existing visual-system rules.
- [ ] HUD text and controls preserve the existing tabular-numeral, focus, target-size, and reduced-motion rules where applicable.
- [ ] A human review checklist covers VIS-01 and UX-01 through UX-04 and records reviewer/pass/fail/notes; automation does not falsely claim subjective visual approval.
- [ ] Evidence filenames and locations are stable and the validator rejects missing/stale required artifacts.

## Relevant invariants

UX-01, UX-02, UX-03, UX-04, VIS-01, DATA-01.

## Verification-command

```bash
./scripts/verify.sh visual-evidence && ./scripts/verify.sh all
```

The handoff must list every evidence artifact and clearly separate automated pass results from the required human visual sign-off.
