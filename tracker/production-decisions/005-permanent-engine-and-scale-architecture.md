# Production Decision 005 — Lock the Permanent Engine and 60-Player Architecture

**Type:** Wayfinder research/prototype decision  
**Status:** open; intentionally blocked  
**Blocked by:** P0 visual evidence and P3 production-shaped match evidence

## Question

Does Godot 4.7 remain the permanent engine, and which authoritative replication/service architecture can sustain a 50–60-player match on the target hardware and budget?

## Why it is not answered now

The existing slice proves a deterministic two-client harness, not presentation-quality Forward+ rendering or 60-player production replication. The correct decision requires actual P0 frame/headroom evidence and P3 network/state-volume evidence.

## Required evidence before resolution

- M4 and RTX 3070 Mobile Forward+ benchmark results;
- visual-quality review against the P0 acceptance bar;
- server CPU, memory, bandwidth, correction, snapshot, and failure data from a production-shaped reduced-scale match;
- 60 synthetic-client soak and provider cost model;
- migration cost if Godot fails either gate.
