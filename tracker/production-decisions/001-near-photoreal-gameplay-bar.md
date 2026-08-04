# Production Decision 001 — Define the Near-Photoreal Gameplay Bar

**Type:** Wayfinder grilling decision (resolved under the user's autonomous-planning authorization)  
**Status:** closed  
**Blocks:** P0 specification

## Question

What does “almost photo realistic” mean for a solo-developed competitive surf game, and what observable bar prevents it from becoming either an untestable taste claim or an impossible film-render target?

## Resolution

Target near-photoreal **gameplay presentation** at normal third-person camera distances:

- physically plausible PBR materials, sunlight, sky/IBL, atmosphere, water absorption/reflection, foam, spray, wetness, and environmental scale;
- production-shaped surfer, board, reef, shoreline, foliage, and prop silhouettes;
- no visible graybox primitive in fixed gameplay hero shots;
- no film-quality face requirement, ray tracing, offline rendering, 4K-native requirement, or cinematic post-process that degrades play;
- readability has priority over strict realism: swell silhouettes, break state, reef/kelp danger, player/target/projectile separation, and reserved zone hue must survive every weather checkpoint;
- visual acceptance uses fixed shots, a scripted camera path, performance evidence, and human sign-off—not “looks good” alone.

## Evidence

The checked-in screenshot is compositionally readable but visibly consists of flat water/sky, rectangular wave cues, box reefs/board, a capsule player, and a sphere target. The GDD already requires stylized-realistic water, 300 m swell readability, a distinct hazard palette, and gameplay-legible water in all weather. The newest user request raises material/lighting fidelity while preserving those rules.

## Consequence

P0 can now be specified as a visual benchmark rather than an undefined whole-game art pass.
