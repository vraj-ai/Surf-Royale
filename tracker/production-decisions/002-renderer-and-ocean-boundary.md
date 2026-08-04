# Production Decision 002 — Choose the P0 Renderer and Ocean Boundary

**Type:** Wayfinder research decision  
**Status:** closed  
**Blocked by:** Production Decision 001  
**Blocks:** P0 rendering and ocean tickets

## Question

Which Godot renderer and water architecture can pursue near-photoreal presentation without invalidating the deterministic server-owned ocean contract?

## Resolution

- Use Godot 4.7.1 **Forward+** for rendered clients. Godot documents it as the advanced desktop renderer using Metal, Vulkan, or Direct3D 12 through RenderingDevice.
- Keep the headless server rendering-independent.
- Preserve CPU `OceanTruth` as the only gameplay authority for height, normal, surface velocity, current, break phase, underwater state, movement, and projectile-water checks.
- Build a visual-water adapter that consumes deterministic truth and adds render-only high-frequency detail. No GPU readback enters gameplay.
- Evaluate `godot4-oceanfft` only as a pinned MIT spike/reference. Do not adopt it as gameplay truth or a permanent dependency until it proves Godot 4.7.1 compatibility, Metal/Windows behavior, deterministic visual phase, clean lifecycle, and budget compliance.
- Benchmark native target resolutions first; FSR 2.2 is an optional quality-tier fallback, not an acceptance substitute.

## Evidence

Godot 4.7 renderer documentation reserves the broadest advanced feature set, volumetric fog, compute path, and FSR 1/2 for Forward+. The ocean addon is MIT and feature-rich but calls itself early work in progress, has no tagged release, and lists shore interaction and multiplayer synchronization as unfinished.

## Consequence

P0 is a reversible renderer and presentation gate. A failed M4/Windows benchmark can still trigger a renderer/effect or engine reconsideration without rewriting authoritative gameplay.
