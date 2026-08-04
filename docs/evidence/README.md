# Integrated Slice Evidence

## M4 MacBook Air

- Benchmark: [`m4-2026-07-18-benchmark.json`](m4-2026-07-18-benchmark.json)
- Render capture: [`m4-2026-07-18-tutorial-cove.png`](m4-2026-07-18-tutorial-cove.png)
- Workload: rendered Godot 4.7.1 compatibility renderer, 1600×900 internal resolution, 300 seconds
- Result: 17,876 measured frames, 16.667 ms p95, 2,043,306 bytes memory growth, passed

## P0-001 Forward+ foundation — M4 MacBook Air

- Benchmark: [`m4-2026-07-20-forward-plus-foundation.json`](m4-2026-07-20-forward-plus-foundation.json)
- Render capture: [`m4-2026-07-20-forward-plus-foundation.png`](m4-2026-07-20-forward-plus-foundation.png)
- Reload soak: [`m4-2026-07-20-forward-plus-reload-soak.json`](m4-2026-07-20-forward-plus-reload-soak.json)
- Workload: Godot 4.7.1 Forward+ through Metal 4.0 on Apple M4, target profile, 1600×900, 300 seconds.
- Result: 17,881 measured non-loading frames; the fixed screenshot captured at 0.5 seconds during the 2.0-second warm-up; 16.667 ms p95, 1% low, and worst non-loading frame; 4,030,437 bytes memory growth. The three-reload cleanup soak held two post-cleanup scene nodes and a stable 1,513-object count; its 7,176-byte post-cleanup memory drift is recorded in the reload evidence.

## macOS artifact

`./scripts/verify.sh all` produced the unsigned local-review artifact at:

```text
build/macos/SurfRoyale.zip
```

Evidence from the final T006 gate:

```text
size:   59,623,833 bytes
sha256: c7dc3f3168767561a90638df4ed3296713158fbf0cf9645494bfa83bf59ddb88
```

The artifact is generated under the ignored `build/` directory and is not committed. Recreate it with the pinned templates through the global verification command or the export command in `docs/runbooks/godot-setup.md`.

## Windows reference run

The x86_64 export preset and cross-export instructions are checked in. The 1920×1080 at 60 FPS RTX 3070 Mobile evidence remains machine-dependent and must be recorded when the Alienware m15 R6 is available; no Windows performance result is claimed from the M4 run.
