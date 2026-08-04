# Research — Near-Photoreal Godot Production for Surf Royale

**Date:** 2026-07-19  
**Scope:** Evidence for the first production slice only; no application code or external assets were changed.  
**Decision target:** A near-photoreal, gameplay-readable Tutorial Cove on M4 macOS and RTX 3070 Mobile Windows while deterministic gameplay truth remains intact.

## Executive recommendation

Proceed with a **Forward+ authored Tutorial Cove visual benchmark** before committing Godot as the permanent engine or building the full map.

Use:

- Godot 4.7.1 Forward+;
- Metal on macOS and Vulkan/Direct3D 12 on Windows through RenderingDevice;
- deterministic CPU `OceanTruth` for gameplay and a separate visual-water layer for render-only detail;
- Blender→glTF for the compact cove;
- CC0 materials/HDRIs/models from Poly Haven and ambientCG, with provenance recorded even when attribution is not legally required;
- directional sun + sky/IBL + reflection probes + baked/static lighting where it helps land assets;
- automatic mesh LOD, explicit visibility/HLOD for repeated or grouped content, and MultiMesh for foliage;
- native-resolution evidence first, with FSR 2.2 as an optional quality-tier fallback;
- fixed hero shots plus a five-minute representative benchmark and deterministic gameplay gates.

Do **not** adopt an off-the-shelf ocean addon as authoritative gameplay simulation. Do not start with the full 3×3 km map. Do not treat “near-photoreal” as permission to remove gameplay color separation or exceed the existing 60 FPS targets.

## Current baseline

### Repository shape

- The tracked GDScript footprint is 1,655 lines across application and test files.
- `TutorialCove` is a six-line scene whose world, lighting, water plane, reefs, wave cues, board, surrogate surfer, buoy, camera, HUD, and audio cue are constructed programmatically in one 370-line script.
- The project uses the Compatibility renderer.
- There is no production asset manifest, authored environmental scene hierarchy, imported terrain, character rig, animation set, material library, foliage system, or visual quality-tier matrix.

### Evidence baseline

The checked-in M4 benchmark records:

- Godot 4.7.1 stable;
- Compatibility renderer;
- 1600×900;
- 300 seconds;
- 17,876 measured frames;
- p95 frame time 16.667 ms;
- 2,043,306 bytes memory growth;
- passed.

The result is exactly at the 16.7 ms frame budget, so it does **not** demonstrate spare headroom for Forward+, high-fidelity water, vegetation, fog, reflections, animation, particles, networking, or full-match gameplay. The first visual ticket must therefore preserve a measurable baseline and expose GPU/CPU cost rather than assuming the new renderer is affordable.

### Visible graybox assessment

The checked-in render capture is a useful gameplay diagram, not a presentation target:

- flat cyan water and sky with no physically based depth, reflection, refraction, foam, spray, shore interaction, or atmospheric horizon;
- cyan rectangular wave strips rather than formed waves;
- box reefs, a box board, a capsule player, and a sphere buoy;
- no authored shoreline, geology, vegetation, debris, character anatomy, clothing, animation, or environmental scale cues;
- simple hard-edged direct lighting and a large clipped bright area in the foreground;
- a readable but oversized debug HUD.

Strengths to preserve:

- the player, board, target, and approaching swell are compositionally legible;
- the forward camera now faces the travel/target direction;
- wave timing has both visual and audio channels;
- the ocean palette separates hazards and interactables;
- deterministic state/speed/stamina information is available for evidence capture.

## Renderer decision

Godot 4.7 documentation identifies Forward+ as the most advanced desktop renderer and the choice for newer desktop hardware, 3D games, and advanced rendering features. It uses RenderingDevice with Vulkan, Direct3D 12, or Metal. Compatibility uses OpenGL and the least advanced feature set.

Forward+ is required for the requested visual direction because it enables the desktop path for:

- compute-shader experiments;
- volumetric fog;
- FSR 1/2 resolution scaling;
- the broadest environment/post-processing feature set;
- clustered real-time lighting and higher-end reflection/GI options.

The move is a **risk gate**, not a foregone success. Godot notes that switching from Compatibility to Forward+ can require manual scene, lighting, and environment changes. The coder must keep a clean headless server path and fail visibly if a client falls back to Compatibility and no longer matches the intended visual profile.

## Water architecture

### Required separation

The project already has deterministic, server-owned ocean truth. Preserve this contract:

1. CPU gameplay truth owns wave schedule, height/normal/surface velocity/current/break phase, underwater checks, and networking.
2. The visual layer samples that truth at bounded points and adds cosmetic high-frequency detail.
3. GPU visual displacement never becomes collision, hit, stamina, or movement authority.
4. No GPU readback may enter the gameplay tick.
5. A visual/gameplay phase mismatch must fail the visual integration gate rather than silently drift.

### Visual feature ladder

Implement and profile in this order:

1. sky/IBL-driven color and specular response;
2. multi-scale normal detail and distance-aware roughness;
3. deterministic large-wave silhouette deformation tied to `OceanTruth`;
4. depth/absorption color and underwater transition;
5. break/shore/reef foam masks;
6. wake, splash, spray, and wipeout particles;
7. carefully budgeted reflections/refraction;
8. optional compute FFT detail only if it is deterministic enough visually, isolated from gameplay, and cheaper than the owned alternative.

Every rung must be independently disableable in a quality profile so the M4 and Windows gates identify the actual cost.

### `godot4-oceanfft` evaluation

Useful facts:

- MIT license;
- requires Godot 4.3+;
- compute-shader displacement, CDLOD surface, buoyancy, underwater effect, whitecaps, reflection/refraction, and subsurface scattering;
- latest repository activity found: November 2025;
- no tagged releases;
- calls itself early work in progress;
- shore interaction, splash effects, lower-detail shader optimization, and multiplayer synchronization remain on its TODO list.

Decision: treat it as a **spike/reference candidate behind a visual adapter**, not a production dependency or source of gameplay truth. Pin an exact commit if evaluated. Acceptance requires macOS Metal and Windows RenderingDevice evidence, deterministic screenshot behavior, clean shutdown, and no change to gameplay queries.

## Land, materials, and content pipeline

### Compact cove

Use authored Blender→glTF assets for the compact cove. This keeps the first slice reviewable, minimizes a new native-extension dependency, and lets the team control silhouette, collision, UVs, materials, LOD, and lightmap UVs directly.

Recommended asset structure:

- hero reef/shore meshes with authored collision and wet/dry material regions;
- modular rock, sand, coral/reef, driftwood, platform, and foliage kits;
- PBR texture sets packed for Godot conventions;
- repeated vegetation through MultiMesh/instancing;
- automatic mesh LOD on glTF imports, with manual LOD for broken skinned or silhouette-critical meshes;
- HLOD/visibility ranges for distant reef/foliage groups;
- occlusion only where large island/rock masses create real hiding opportunities—open ocean offers little benefit and occlusion culling has CPU/setup cost.

### Full map candidate

Terrain3D is a credible later candidate:

- MIT license;
- active repository with a stable v1.0.2 release in May 2026 and current July 2026 activity at research time;
- high-performance editable Godot 4 terrain implemented as a C++ GDExtension.

Do not add it in P0. Evaluate it at the P5 full-map gate against authored terrain/chunking, version compatibility, export binaries, macOS/Windows support, collision, waterline editing, source-build burden, and repository longevity.

## Lighting, atmosphere, and post-processing

Recommended default:

- physically plausible directional sun;
- sky material or CC0 HDRI for IBL and horizon color;
- reflection probes with `Once` update where possible;
- static/baked indirect lighting for authored land assets where it improves contact and remains compatible with dynamic weather;
- SSAO/SSIL/SSR only after profiling, because Godot documents significant cost for SSAO and still higher cost for SSR;
- restrained volumetric fog for mist/spray shafts, paired with non-volumetric distance fog for the horizon;
- physical or practical camera attributes with controlled exposure;
- ACES-style tone mapping and restrained review;
- no cinematic depth of field, chromatic aberration, or motion blur that harms target/swell readability.

Volumetric fog is Forward+-only. Godot warns its temporal reprojection can ghost moving fog volumes/lights and that it has finite range. Use low global density, local volumes, bounded range, and zero volumetric contribution for short-lived combat lights.

## Resolution and quality tiers

Benchmark native target resolutions first:

- M4 MacBook Air: 1600×900, 60 FPS;
- RTX 3070 Mobile: 1920×1080, 60 FPS.

Godot 4.7 provides FSR 1.0 and FSR 2.2 only in Forward+. FSR 2.2 includes temporal antialiasing. It is a valid quality-tier option, but the docs explicitly state resolution scaling is not a replacement for lower graphics settings.

Plan three user-facing tiers:

- **Performance:** reduced fog/reflection/particle/foliage distance and FSR 2.2 Quality/Balanced only if required.
- **Target:** native target resolution, visually complete, all readability checks, 60 FPS gate.
- **Capture:** higher quality for screenshots only; never the acceptance or gameplay default.

## Asset and license policy

### Approved defaults

- **Poly Haven:** all downloadable HDRIs, textures, and 3D models are CC0; commercial use, modification, and redistribution are allowed without required attribution.
- **ambientCG:** downloadable assets are CC0; commercial use, modification, distribution, and inclusion of raw files in a game project are allowed.
- **Blender:** GPL software; artwork created with Blender belongs to the creator and may be used commercially.
- **Terrain3D / `godot4-oceanfft`:** MIT software; preserve license/copyright notices in distributed source or substantial copies.

### Conditional source

- **Mixamo:** Adobe says characters and animations may be used royalty-free in commercial video games and the service is free with an Adobe ID. Treat it as temporary evaluation content unless the final asset strategy explicitly accepts the account/service dependency and archived source files.
- **Freesound:** licenses vary per sound. Default ingestion must filter to CC0; CC-BY requires attribution; non-commercial or incompatible share-alike content is rejected unless separately approved.

### Provenance record required per asset

- stable source URL and source asset ID;
- creator/publisher;
- license identifier and license URL;
- download date;
- original archive checksum;
- local derivative path;
- transformations/optimization performed;
- attribution text if required;
- redistribution restrictions;
- reviewer and approval status.

No “found online,” ripped-game, AI-generated-with-unclear-training-rights, logo/trademark, or personal-likeness asset enters the repository.

## Visual acceptance bar

The P0 result passes only when all fixed hero shots meet all of these conditions:

- no primitive cube/capsule/sphere surrogate remains visible in the intended gameplay frame except an intentionally designed buoy or debug-only overlay;
- the water shows coherent large-wave form, fine normal detail, depth/absorption variation, horizon reflection, and localized foam at a break/reef interaction;
- the cove has authored shoreline/reef geometry, at least three distinct physically based material families, and scaled environmental detail;
- the surfer and board have recognizable production-shaped silhouettes and state-readable animation/poses;
- sun, sky, exposure, fog, and review produce a plausible outdoor ocean scene without clipped highlights or crushed hazards;
- wave, reef/kelp, player, target, projectile, and zone-reserved colors remain readable under sun, overcast, and storm checkpoints;
- no temporal ghosting, reflection smear, foam detachment, obvious LOD pop, or horizon seam is visible in the scripted camera path;
- debug HUD can be hidden for capture while evidence metrics remain available in a separate debug mode.

“Looks good” alone is not a gate. Store fixed screenshots, a short camera-path capture or frame sequence, performance JSON, import/provenance validation, and human visual sign-off.

## Performance and resource budgets

P0 locks the following initial budgets; the coder may make them stricter but may not silently relax them:

- M4 and RTX targets: p95 frame time ≤16.7 ms over a five-minute representative rendered run;
- 1% low frame time ≤25 ms and no single non-loading frame >50 ms after warm-up;
- process memory growth ≤64 MiB over the run;
- no unbounded GPU resource growth across three scene reloads;
- no gameplay query waits on GPU readback;
- all imported static meshes use generated or authored LOD unless an explicit exception is recorded;
- common environment materials use ≤2K source textures per channel; 4K is reserved for documented hero assets and should be downsampled by lower quality tiers;
- texture compression/import settings are platform-appropriate and checked into the project;
- quality-tier toggles must isolate expensive water, fog, reflection, vegetation, and particle features for profiling.

The current M4 baseline has no measured headroom—it already reports 16.667 ms p95—so the renderer-foundation ticket may discover that the target requires reducing effect cost, not lowering the acceptance frame rate.

## Risks and mitigations

| Risk | Consequence | Mitigation/gate |
|---|---|---|
| Forward+ cost on fanless M4 | Visual slice misses 60 FPS or thermally degrades | Five-minute warm benchmark, native target first, quality toggles, profile each feature rung |
| GPU visual ocean diverges from gameplay | Player sees a surface that does not match movement/projectile truth | CPU authority, no readback, fixed phase markers, mismatch test |
| Transparent water/reflections dominate frame | RTX target passes but M4 fails | ReflectionProbe/IBL first, SSR conditional, bounded refraction, feature cost evidence |
| Photogrammetry bloats memory/repo | Slow imports, oversized builds, stutter | Blender decimation/UV cleanup, 2K default, LOD/HLOD, checksum/provenance, import budget checks |
| Addon abandonment/version break | Godot upgrades or exports fail | Adapter seam, pinned commit, license notice, replacement test, no gameplay ownership |
| Visual realism harms battle readability | Core skill loop becomes unfair | Fixed visibility shots at distance/weather states, reserved zone hue, dual-channel cues |
| Full BR scope exceeds solo operations | Game never reaches releasable state | Milestone gates, reduced-scale complete match before full map, explicit hosting/moderation budget gate |

## Sources

Primary/repository evidence:

- `project.godot`
- `src/world/tutorial_cove.gd`
- `docs/evidence/m4-2026-07-18-benchmark.json`
- `docs/evidence/m4-2026-07-18-tutorial-cove.png`
- `docs/GDD.md`
- `docs/specs/godot-vertical-slice.md`

External primary sources:

- Godot 4.7 renderers: https://docs.godotengine.org/en/4.7/tutorials/rendering/renderers.html
- Godot environment/post-processing: https://docs.godotengine.org/en/4.7/tutorials/3d/environment_and_post_processing.html
- Godot global illumination: https://docs.godotengine.org/en/4.7/tutorials/3d/global_illumination/introduction_to_global_illumination.html
- Godot volumetric fog: https://docs.godotengine.org/en/4.7/tutorials/3d/volumetric_fog.html
- Godot resolution scaling: https://docs.godotengine.org/en/4.7/tutorials/3d/resolution_scaling.html
- Godot mesh LOD: https://docs.godotengine.org/en/4.7/tutorials/3d/mesh_lod.html
- Godot visibility ranges/HLOD: https://docs.godotengine.org/en/4.7/tutorials/3d/visibility_ranges.html
- Godot occlusion culling: https://docs.godotengine.org/en/4.7/tutorials/3d/occlusion_culling.html
- Terrain3D: https://github.com/TokisanGames/Terrain3D
- Terrain3D license: https://github.com/TokisanGames/Terrain3D/blob/main/LICENSE.txt
- Godot 4 OceanFFT: https://github.com/tessarakkt/godot4-oceanfft
- OceanFFT license: https://github.com/tessarakkt/godot4-oceanfft/blob/devel/LICENSE.txt
- Poly Haven license: https://polyhaven.com/license
- ambientCG license: https://docs.ambientcg.com/license/
- Blender license/artwork ownership: https://www.blender.org/about/license/
- Adobe Mixamo FAQ: https://helpx.adobe.com/creative-cloud/faq/mixamo-faq.html
- Freesound licensing FAQ: https://freesound.org/help/faq/#licenses
