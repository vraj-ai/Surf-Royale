# Wayfinder Map — Surf Royale Production Road to v1

**Status:** Charted locally; first implementation slice is decision-complete. Remaining production milestones stay behind explicit gates.  
**Tracker:** Local planning artifacts only. No GitHub issues were created or modified.  
**Planning rule:** This map names decisions and milestone gates; implementation belongs to the `coder` profile and independent audit belongs to `debugger`.

## Destination

A finishable Windows-and-macOS v1 of **Surf Royale** that preserves the GDD's core bet—reading the ocean is the skill gap—and delivers Solos and Duos for 50–60 players with near-photoreal, gameplay-readable ocean and island presentation at the existing hardware targets.

“Near-photoreal” means physically plausible materials, lighting, atmosphere, water response, animation, and authored composition at normal gameplay camera distances. It does **not** mean offline-render fidelity, film-quality faces, ray tracing, 4K-native output, or a unique scan-quality asset for every object.

## Fixed constraints

- Solo developer; automation may assist but cannot erase content, networking, moderation, and live-operations workload.
- Godot 4.7.1 + typed GDScript remains the next reversible candidate stack, not a permanent commitment until the visual and scale gates pass.
- Primary development machine: M4 MacBook Air.
- Reference clients: macOS at 1600×900 and RTX 3070 Mobile Windows at 1920×1080, both targeting 60 FPS.
- Server owns gameplay truth; ocean gameplay queries remain deterministic and independent of GPU readback.
- Existing `./scripts/verify.sh all` behavior remains green throughout production work.
- Default dependency policy: Godot/MIT/BSD/Apache/Zlib/CC0 assets and tools with recorded provenance. Paid or custom-license content requires a separate user approval before acquisition.
- Visual fidelity may never hide swell silhouettes, break state, reef/kelp hazards, zone state, projectiles, players, or interactable loot.
- The planner edits documentation only. The coder implements ready tickets. The debugger independently audits the result.

## Decisions so far

1. [Define the Near-Photoreal Gameplay Bar](production-decisions/001-near-photoreal-gameplay-bar.md) — target physically plausible gameplay presentation, preserve competitive reads, and verify with fixed evidence rather than an undefined taste claim.
2. [Choose the P0 Renderer and Ocean Boundary](production-decisions/002-renderer-and-ocean-boundary.md) — use Forward+ for clients while CPU `OceanTruth` remains the only gameplay authority; visual-ocean experiments stay behind an adapter.
3. [Choose the P0 Asset and Scene Pipeline](production-decisions/003-asset-and-scene-pipeline.md) — use Blender→glTF and CC0-first provenance for the compact cove; defer Terrain3D to the full-map gate.
4. Treat “finish the game” as a production program, not one implementation ticket; the current green risk slice cannot safely collapse rendering, content, gameplay, backend, scale, social, and release work into one change.
5. Select the Near-Photoreal Tutorial Cove as the first production slice because it proves the visual target and production content seam without prematurely committing to full-map or service architecture.
6. Keep native target resolutions as the acceptance baseline; FSR 2.2 is an optional quality-tier tool, not permission to blur gameplay reads or miss the frame target.
7. Keep specs and tickets local until the user separately authorizes external tracker publication, commit, or push.

## Milestone route

### P0 — Near-Photoreal Tutorial Cove Visual Foundation (ready)

Prove Forward+, authored presentation seams, legal asset ingestion, near-photoreal water/land/lighting/character presentation, visual readability, and the existing 60 FPS gates in the compact Tutorial Cove. Detailed spec: `docs/specs/near-photoreal-tutorial-cove.md`.

**Exit:** Every P0 ticket is green; M4 evidence is captured; Windows evidence is either green on the reference machine or explicitly blocks P1 visual lock.

### P1 — Production Surf Tutorial (blocked by P0)

Turn the five-minute cove into the complete onboarding loop: paddle, read a set, catch, ride, wipe out, recover, fire, and finish, using final-feeling controls, accessibility fallbacks, saveable settings, and first-user telemetry that is local/private by default.

**Exit concept:** a clean-checkout user can complete the tutorial with keyboard/mouse and controller; scripted state coverage and a recorded human playtest both pass.

### P2 — Networked Surf-Combat Arena (blocked by P1)

Replace the deterministic two-client harness with a small production-shaped match session that proves join/leave/reconnect, prediction/reconciliation, server-authoritative combat/stamina/board state, elimination/spectate, and abusive-input handling in an 8–12-client cove arena.

**Exit concept:** an impaired-network soak and repeated join/leave test remain within correction, tick, memory, and trust-boundary budgets.

### P3 — Complete Match Loop at Reduced Scale (blocked by P2)

Deliver a 12–16-player end-to-end match: insertion, loot, one moving zone, ocean rotation, combat, elimination/waterlogged flow, win, recap, and requeue. Use the cove/limited archipelago content set; do not build the final 3×3 km map yet.

**Exit concept:** unattended matches reach exactly one winner without manual repair, invalid state, or server authority violations.

### P4 — 50–60 Player and Service Architecture Gate (blocked by P3)

Decide and prove the production backend, matchmaking, identity, moderation/reports, persistence boundaries, hosting budget, regional topology, observability, and 60-client server scale. Synthetic clients may prove load; real-player testing remains a separate release gate.

**Exit concept:** a documented monthly-cost envelope is approved, a 60-client soak meets tick/network budgets, data handling is threat-modeled, and failure/recovery drills pass.

### P5 — Archipelago Content Pipeline and Full Map (blocked by P4)

Productionize streaming/chunking, Terrain3D-or-authored-terrain selection, biome kits, two island clusters, four reefs, three wrecks, kelp, loot surfaces, collision, HLOD, navigation/readability, and deterministic break authoring for the 3×3 km map.

**Exit concept:** all map chunks stream and remain within draw-call, geometry, texture-memory, collision, and traversal budgets on both reference clients.

### P6 — Solos, Duos, Social, Progression, and Content Complete (blocked by P5)

Finish waterlogged/stabilize, parties/fill, pings, opt-in party voice or an approved substitute, cosmetics-only account progression, battle-pass structure, locker/store surfaces, onboarding pool, accessibility, and content production required by the GDD.

**Exit concept:** every GDD user journey is playable end-to-end with no pay-to-win visibility, hitbox, or audio delta.

### P7 — Alpha/Beta Hardening (blocked by P6)

Security review, anti-cheat evidence, abuse/report operations, crash recovery, save migration, reconnects, packet abuse, performance tiers, accessibility validation, localization readiness, privacy disclosures, and external playtests.

**Exit concept:** release-blocker matrix is empty; soak, fuzz, recovery, compatibility, and playtest gates pass.

### P8 — Release Candidate (blocked by P7)

Signing/notarization, installers, patch/update path, support/runbooks, legal notices, credits/provenance, privacy and moderation operations, store assets, release rollback, and final Windows/macOS certification matrix.

**Exit concept:** reproducible signed artifacts, clean-install/upgrade/uninstall evidence, monitored release rehearsal, and rollback drill.

## Decision frontier after P0

These decisions are intentionally deferred because P0 evidence is their prerequisite:

- Does Forward+ on both reference machines retain enough headroom for production gameplay and networking?
- Does Godot remain the permanent engine after visual quality, asset workflow, and 60-client scale evidence?
- What monthly service/hosting/moderation budget is acceptable for a 50–60-player live game?
- Which identity, matchmaking, persistence, voice, crash, analytics, and anti-cheat providers are acceptable?
- Is the full launch scope still Solos + Duos, or must v1 narrow to one mode to remain solo-maintainable?
- Which final character/animation source and art-production budget replace temporary evaluation assets?
- What real-player alpha population and regions are required before launch?
- How is the production ocean contract split between public visual-wave parameters and hidden future authoritative timing? The current risk harness shares the exact seed, while the GDD calls it server-secret.
- What is the exact per-weapon TTK contract? The GDD's global “two shots” statement conflicts with a 30-damage pistol against the current 100-HP scale.
- Can an isolated level-1–10 beginner pool coexist with 50-player minimum lobbies, two launch modes, no bots, and a small initial population, or must onboarding use assists without queue fragmentation?
- Does a board at zero integrity become recoverable, repairable, replaceable, or permanently unusable for the match?
- Which baseline accessibility requirements—remapping, captions, non-color-only cues, reduced motion, readable HUD modes—are mandatory before any public alpha?
- Does “v1” mean a commercial launch, Early Access release, or closed alpha? The staffing, service, legal, and evidence gates differ materially.

## Not yet specified

- Exact production service providers and schemas.
- Full-map terrain technology and streaming cell sizes.
- Final character customization and animation-production pipeline.
- Store economics, pricing, currency, and platform commerce.
- Regional launch topology and service-level objectives.
- Final content quantity, seasonal production cadence, and localization set.

## Out of scope for P0

Production backend, 50–60-player validation, accounts, persistence, matchmaking, monetization, final map, production voice, final anti-cheat, console/mobile/web, ray tracing, native 4K, film-quality cinematics, and replacing deterministic gameplay truth with a visual simulation.

## P0 planning artifacts

- Research: `docs/research/near-photoreal-godot-production.md`
- Spec: `docs/specs/near-photoreal-tutorial-cove.md`
- Tickets: `tracker/production-tickets/001` through `008`
- Handoff: `handoffs/2026-07-19-near-photoreal-tutorial-cove-plan.md`
