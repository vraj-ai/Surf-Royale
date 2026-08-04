# Specification — Near-Photoreal Tutorial Cove Visual Foundation

**Status:** Ready for `coder` implementation  
**Date:** 2026-07-19  
**Milestone:** P0 in `tracker/production-map.md`  
**Source decisions:** `tracker/production-decisions/001`–`003`  
**Research:** `docs/research/near-photoreal-godot-production.md`

## Problem Statement

Surf Royale's current Godot risk slice proves deterministic ocean truth, six-state surfing, two-client authority, basic combat, exports, and an M4 performance gate. It does not prove the newly requested visual target or a maintainable production content workflow.

The visible Tutorial Cove is constructed almost entirely from runtime primitives: a flat cyan plane, rectangular wave strips, box reefs and board, capsule surfer, sphere buoy, flat colors, and a debug panel. The scene is useful technical evidence but cannot establish whether Godot 4.7.1 can deliver a near-photoreal surf game on the M4 MacBook Air and RTX 3070 Mobile while preserving competitive readability and deterministic gameplay.

The visual request must be resolved before the full map, backend, or content program. Otherwise the project risks building production systems on an engine/rendering/content stack that has not passed the most presentation-sensitive part of the game's core promise: readable, convincing water.

## Solution

Build one authored, near-photoreal **Tutorial Cove visual foundation** around the existing deterministic risk slice.

The slice will:

- move rendered clients from Compatibility to Forward+;
- preserve a rendering-independent headless server and every current gameplay/network invariant;
- split authored presentation from runtime gameplay orchestration;
- introduce a CPU-truth-to-visual-ocean boundary;
- ingest only provenance-recorded, legally compatible content;
- deliver authored reef/shore/foliage, physically plausible water, lighting/atmosphere, surfer/board presentation, effects, audio, and capture-ready HUD behavior;
- provide target/performance/capture quality profiles;
- produce fixed visual evidence plus five-minute M4 and Windows reference benchmarks;
- leave a reversible gate for Godot, the visual-water implementation, and later terrain technology.

This is not the whole game. It is the first coherent production slice that makes the whole-game route evidence-based.

## Goals

1. Make the Tutorial Cove look near-photoreal at its normal third-person gameplay camera distance.
2. Preserve the GDD's readability rules under sun, overcast, and storm checkpoints.
3. Preserve deterministic CPU ocean/gameplay truth and server authority.
4. Establish a repeatable authored-content and asset-provenance pipeline.
5. Prove Forward+ performance at the existing M4 and RTX 3070 Mobile targets.
6. Leave all expensive visual systems independently scalable and replaceable.
7. Keep the existing clean-checkout gate green.

## Non-goals

- Full 3×3 km archipelago.
- Production terrain/streaming selection.
- 50–60-player validation, matchmaking, backend, identity, persistence, voice, moderation, store, or progression.
- Production netcode replacement.
- Final character creator, cosmetics catalog, facial animation, or film-quality cinematics.
- Ray tracing, native 4K acceptance, console/mobile/web support, or offline-render quality.
- Final permanent-engine commitment.
- Replacing authoritative gameplay queries with GPU or visual ocean data.
- Purchasing paid/custom-license assets.
- Changing surf tuning without a separately recorded playtest decision.

## User Stories

1. As a player, I want the ocean to look deep, reflective, translucent, and alive, so that the game's central surface feels convincing.
2. As a player, I want large wave forms and breaking sections to match the wave I can actually ride, so that visual skill reads remain honest.
3. As a player, I want foam, spray, shore interaction, and wakes to react at the places I expect, so that movement feels connected to the scene.
4. As a player, I want reefs, kelp, shore, surfer, board, buoy, and projectiles to remain distinct in every weather checkpoint, so that realism does not create unfair ambiguity.
5. As a player, I want the same cove to transition from sun-bleached to storm-grey without clipping, ghosting, or losing hazards, so that weather remains a readable match clock.
6. As a player on the M4 target, I want the visual target profile to hold 60 FPS at 1600×900, so that the game feels responsive on the primary development machine.
7. As a player on the RTX 3070 Mobile reference, I want the visual target profile to hold 60 FPS at 1920×1080, so that the Windows client meets its stated baseline.
8. As a player on constrained hardware, I want a performance profile that scales fog, reflection, particles, vegetation, and resolution coherently, so that the image remains readable rather than randomly degraded.
9. As a player, I want the surfer and board to have recognizable anatomy, proportions, materials, and state-readable poses, so that movement no longer looks like a debug capsule on a box.
10. As a player, I want capture mode to hide debug UI without removing gameplay-critical presentation, so that screenshots show the intended game rather than a benchmark panel.
11. As a developer, I want authored presentation scenes separated from gameplay orchestration, so that artists/content changes do not rewrite deterministic mechanics.
12. As a developer, I want every imported asset to record source, license, checksum, and transformations, so that the project remains legally auditable.
13. As a developer, I want visual-water features independently toggleable, so that performance regressions can be attributed instead of guessed.
14. As a network engineer, I want the headless server to remain rendering-independent, so that visual work cannot alter authority or server deployment.
15. As a tester, I want one high-level visual verification command, fixed evidence shots, and machine-readable metrics, so that every ticket has an objective completion gate.
16. As a future maintainer, I want third-party addons pinned behind adapters with notices and replacement seams, so that an abandoned dependency cannot own core gameplay.
17. As a competitive player, I want the existing reserved zone hue and dual-channel swell cues preserved, so that visual polish never changes learned information rules.
18. As the project owner, I want failed visual/performance evidence to stop the production route, so that the project can reconsider Godot or effect scope before full-map investment.

## Implementation Decisions

### Rendering foundation

- Rendered desktop clients use Godot 4.7.1 Forward+.
- macOS uses the supported Metal RenderingDevice path; Windows uses supported Vulkan/Direct3D 12 behavior.
- Unexpected Compatibility fallback is surfaced in evidence and cannot pass the target visual profile.
- The dedicated/headless server remains rendering-independent and does not load client-only visual content.
- The existing project-wide gate remains authoritative; P0 adds a `visual` suite without weakening any existing suite.

### Authored-scene boundary

- Replace the monolithic programmatic presentation with authored scene/resource composition while leaving gameplay models/controllers intact.
- Gameplay orchestration owns state and deterministic updates. Authored scenes own geometry, materials, lights, environment, particles, animation presentation, HUD layout, and audio presentation.
- The Tutorial Cove remains launchable through the existing application flow and benchmark modes.
- The fixed benchmark scenario and camera path are data-driven and reusable by target/performance/capture profiles.

### Ocean presentation boundary

- CPU `OceanTruth` remains the only authority for height, normal, surface velocity, current, break phase, underwater state, surf state, movement, and projectile-water checks.
- The visual layer consumes a bounded snapshot/interface derived from gameplay truth.
- Cosmetic high-frequency waves, normals, foam, spray, wake, and shading may be GPU-driven but never feed gameplay.
- No gameplay tick waits for GPU readback.
- Large visible wave phase, crest path, and break zone must remain aligned with deterministic truth along the scripted benchmark path.
- `godot4-oceanfft` may be evaluated only behind the visual interface at a pinned commit. It is accepted only if it is cleaner, faster, deterministic enough visually, lifecycle-safe, and cross-platform. Otherwise the owned visual layer remains.

### Cove content

- P0 uses an authored Blender→glTF compact cove, not the later full-map terrain solution.
- The intended gameplay frame contains no accidental graybox primitive or missing-material surrogate.
- The authored set includes recognizable shoreline/reef shape, wet/dry transitions, environmental scale cues, repeated vegetation/shore detail, the target buoy, and collision/readability boundaries needed by the existing scenario.
- Imported static meshes use automatic or authored LOD. Repeated content uses instancing/MultiMesh where appropriate. HLOD/visibility ranges are used where they reduce cost without visible popping.
- Occlusion culling is used only when the authored cove contains meaningful large occluders and profiling shows a benefit.

### Material, lighting, and environment

- Use PBR material inputs with physically plausible roughness/metalness, correct color-space handling, and platform compression.
- Use directional sun and sky/IBL as the foundation; reflection probes prefer non-continuous updates.
- Use baked/static indirect lighting for land only where compatible with dynamic weather and evidence shows value.
- Add SSAO/SSIL/SSR only after individual profiling; none is mandatory if a cheaper technique meets the visual bar.
- Use restrained volumetric mist/fog plus non-volumetric distance fog. Bound range and temporal settings to prevent ghosting and preserve the horizon.
- Exposure, tone mapping, and review may create sun/overcast/storm moods but may not clip the water foreground, crush hazards, or reuse reserved zone hues.

### Character and board presentation

- Replace the capsule/box presentation with a legally usable humanoid surrogate and production-shaped surfboard suitable for the P0 camera distance.
- Map all six surf states to distinct, readable poses or animation states. Animation polish may be provisional; state identity may not be ambiguous.
- Add contact/wake/splash/wipeout cues without changing authoritative motion or state timing.
- Temporary Mixamo use is allowed only with provenance and archived source. Final character ownership is not decided by P0.

### Asset provenance and licensing

- Every third-party asset has a machine-readable manifest entry with stable source URL/ID, creator, license, license URL, download date, original checksum, local derivative, transformations, attribution, restrictions, and approval.
- CC0 from Poly Haven/ambientCG and compatible permissive software are default.
- MIT/BSD/Apache/Zlib notices are preserved.
- Freesound defaults to CC0. CC-BY requires complete attribution. NC/incompatible SA assets are rejected.
- Paid/custom-license assets, ripped assets, uncertain AI-generated assets, trademarks/logos, and unapproved likenesses fail the gate.

### Quality profiles

- **Performance:** lower fog/reflection/particle/foliage cost; may use FSR 2.2 Quality/Balanced if evidence justifies it.
- **Target:** visually complete acceptance profile at native target resolution; this profile owns the 60 FPS gate.
- **Capture:** screenshot-only quality, excluded from performance acceptance.
- Expensive categories—water detail, reflection, fog, foliage, and particles—are independently toggleable for attribution.
- Quality profiles never modify gameplay, authority, or visibility rules.

### HUD and evidence presentation

- Preserve state/speed/stamina/wave data in debug/evidence mode.
- Add a clean capture mode that hides benchmark/debug chrome.
- Preserve dual-channel critical wave information and the existing UI contrast/reserved-hue rules.
- Fixed hero shots cover forward travel, wave approach/break, reef hazard, surfer/board, and storm readability. Evidence uses stable names and machine-readable metadata.

## Executable Invariants

| ID | Category | Owner | Observable condition | Verification approach |
|---|---|---|---|---|
| PERF-01 | Performance | Visual benchmark | Target profile p95 frame time ≤16.7 ms over 300 s at 1600×900 M4 and 1920×1080 RTX 3070 Mobile | Machine-readable benchmark JSON validated by the visual gate |
| PERF-02 | Frame stability | Visual benchmark | After warm-up, 1% low frame time ≤25 ms and no non-loading frame >50 ms | Frame-sample aggregation in the visual benchmark |
| PERF-03 | Resource stability | Presentation lifecycle | Process memory growth ≤64 MiB over 300 s and no monotonically growing rendering resource count across three cove reloads | Benchmark and reload-soak evidence |
| PERF-04 | Asset budgets | Asset pipeline | Common texture sets ≤2K per channel; every 4K hero exception is manifest-recorded; static meshes have LOD or exception | Import/provenance validator |
| OCEAN-01 | Gameplay truth | Ocean boundary | Gameplay ocean queries and network seed remain bit-for-bit owned by CPU truth; visuals cannot write them | Existing ocean/network tests plus adapter contract test |
| OCEAN-02 | No GPU dependency | Ocean boundary | No gameplay query waits on GPU readback | Static boundary check and headless tests |
| OCEAN-03 | Visual alignment | Ocean presentation | Fixed truth markers and visible large-wave crest/break stay within 0.5 m horizontally and 0.25 m vertically at sampled benchmark checkpoints | Deterministic rendered marker/capture comparison |
| AUTH-01 | Authority | Network/gameplay | Existing server ownership, malformed-state rejection, sequence bounds, correction, damage, HP, board, and seed gates remain unchanged and green | `./scripts/verify.sh network` and `all` |
| FAIL-01 | Missing required content | Asset pipeline | Missing required mesh/material/shader/manifest entry fails import or visual verification with a named path/asset ID | Negative fixture or validator test |
| FAIL-02 | Optional effect failure | Presentation | Optional audio/particle/reflection feature degrades to an explicit disabled state without crash or gameplay change | Feature-toggle smoke tests |
| FAIL-03 | Renderer mismatch | Rendering foundation | Target/capture profile cannot pass if the client runs Compatibility or a required Forward+ feature is unavailable | Renderer recorded and asserted in evidence JSON |
| DATA-01 | License integrity | Asset pipeline | Every third-party file maps to an approved manifest entry and required notice/attribution | Provenance validator |
| PRIV-01 | Privacy | P0 scope | No personal data, remote analytics, account token, or production telemetry is introduced | Dependency/config scan; N/A service test because P0 is local-only |
| UX-01 | Swell readability | Art/readability | Large swell silhouette and break direction remain visible in fixed 300 m-equivalent sun/overcast/storm shots | Fixed camera review + human sign-off |
| UX-02 | Hazard readability | Art/readability | Reef/kelp/player/target/projectile remain distinguishable; H 300–320 remains zone-only | Color-token scan and fixed-shot review |
| UX-03 | Dual-channel cues | Presentation | Critical wave approach retains both visual and audio channels | Scripted cue test |
| UX-04 | State readability | Character presentation | All six surf states are visually distinguishable at normal camera distance | State contact sheet + human sign-off |
| VIS-01 | Near-photoreal bar | Art integration | Intended hero frames contain no accidental graybox primitives, missing materials, clipped foreground, obvious horizon seam, detached foam, severe temporal smear, or visible LOD pop | Fixed-shot checklist and scripted camera-path capture |
| COMP-01 | macOS | Rendering/export | M4 arm64 editor/run/export works on pinned Godot version and target profile | macOS visual gate and export |
| COMP-02 | Windows | Rendering/export | x86_64 Windows export launches on RTX 3070 Mobile and target profile passes 1080p gate | Reference-machine evidence |
| COMP-03 | Headless | Server | Headless server imports/runs without rendering dependency | Existing bootstrap/server smoke |
| PERSIST-01 | Persistence | P0 scope | N/A: P0 introduces no save/account schema; quality profile selection may remain command/config driven | Scope review |

No invariant may be “fixed” by weakening its threshold or excluding a representative visual feature without updating this spec and recording a new planning decision.

## Acceptance Criteria

- [ ] Godot 4.7.1 rendered clients run Forward+ and evidence records the actual renderer/driver/profile.
- [ ] The headless server and all pre-P0 verification suites remain green.
- [ ] Tutorial Cove presentation is authored outside the gameplay controller/orchestrator seam.
- [ ] CPU `OceanTruth` remains authoritative and no visual feature feeds gameplay or requires GPU readback.
- [ ] The target profile shows aligned large-wave form, fine water detail, absorption/depth variation, reflection, and localized foam/spray/wake behavior.
- [ ] The cove contains authored reef/shoreline, at least three distinct PBR material families, environmental scale cues, and instanced detail.
- [ ] Intended gameplay hero shots show no accidental graybox primitives or missing materials.
- [ ] Surfer and board use production-shaped silhouettes and all six states have distinct presentation.
- [ ] Sun, overcast, and storm checkpoints preserve swell, hazard, player, target, projectile, and reserved-zone-hue readability.
- [ ] Capture mode hides debug chrome; evidence mode retains state/speed/stamina/wave/renderer/profile metrics.
- [ ] Every third-party asset/dependency passes provenance, checksum, license, notice, and texture/LOD validation.
- [ ] Performance, target, and capture profiles exist; expensive effect categories are independently toggleable.
- [ ] M4 target-profile evidence passes PERF-01 through PERF-03 at 1600×900.
- [ ] Windows target-profile evidence passes PERF-01 through PERF-03 at 1920×1080 on the RTX 3070 Mobile reference machine before P1 visual lock.
- [ ] Fixed screenshots, state contact sheet, camera-path capture/frame sequence, performance JSON, and visual checklist are stored under the evidence convention.
- [ ] A human visual review records pass/fail against VIS-01 and UX-01 through UX-04; automated checks do not pretend to replace perception.
- [ ] `./scripts/verify.sh visual` and `./scripts/verify.sh all` exit zero on the M4 environment after P0 integration.

## Testing Decisions

### Highest seam

Use the existing repository verification entry point. P0 adds:

```text
./scripts/verify.sh visual
```

The suite owns import validation, provenance validation, deterministic visual/ocean contract tests, feature-toggle smoke, authored-scene smoke, fixed evidence capture, benchmark JSON validation, reload soak, and macOS export checks. The existing `all` suite must include `visual` once P0 is complete.

### Test externally observable behavior

Good tests assert:

- actual renderer/driver/profile in evidence;
- successful scene launch/reload/export;
- unchanged deterministic ocean/network outputs;
- bounded performance/resource results;
- manifest completeness and legal-policy rules;
- fixed output artifacts and readable state distinctions.

Avoid tests that assert internal node counts, exact private class names, shader source text, or hard-coded screenshot hashes. Rendering varies across drivers; use bounded metrics, semantic markers, stable camera metadata, and human visual review for appearance.

### Existing prior art

- `./scripts/verify.sh all` as the global gate;
- Godot headless test runner;
- slice benchmark JSON and screenshot capture;
- network impaired two-client soak;
- clean-log assertions and macOS export generation;
- human-reviewed checked-in screenshot evidence.

### Manual evidence that remains manual

- near-photoreal quality judgment;
- temporal artifacts in the scripted camera path;
- state readability and weather readability;
- Windows reference-machine thermal/driver behavior;
- surf-control feel, which remains user-owned and outside P0 tuning.

## Ticket Order

1. P0-001 — Forward+ visual benchmark foundation.
2. P0-002 — Authored cove seam and provenance pipeline.
3. P0-003 — Deterministic near-photoreal ocean presentation.
4. P0-004 — Authored reef, shore, materials, and foliage.
5. P0-005 — Lighting, sky, weather, fog, and quality profiles.
6. P0-006 — Surfer, board, six-state presentation, and interaction effects.
7. P0-007 — Readability, audio/HUD modes, and visual evidence pack.
8. P0-008 — Cross-platform optimization, integration, and production gate.

Dependency edges live in the individual ticket files.

## Out of Scope

Everything in the Non-goals section, plus external tracker publication, commit, push, paid acquisition, and permanent closure of Production Decisions 004–005.

## Further Notes

- The current M4 benchmark is exactly at 16.667 ms p95 in a graybox scene. P0 is expected to expose a genuine feasibility risk; failure is valid evidence and must not be hidden by lowering the frame target.
- Windows visual lock remains blocked until the physical RTX 3070 Mobile reference run exists. The coder may complete all portable work on M4, but P0 cannot claim both-platform performance without that evidence.
- The user authorized autonomous recommended defaults for planning. These are recorded explicitly in the decision files rather than silently assumed.
- No external issue, commit, or push is part of this spec.
