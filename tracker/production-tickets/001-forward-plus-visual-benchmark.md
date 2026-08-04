# P0-001 — Forward+ Visual Benchmark Foundation

**What to build:** A reversible Forward+ client-rendering baseline and visual verification harness that records the actual renderer/driver/quality profile, preserves the rendering-independent server, and measures enough frame/resource data to make every later visual ticket evidence-based.

**Blocked by:** None — can start immediately.  
**Status:** ready-for-agent  
**Handoff target:** `coder` → `debugger` after this ticket's gate is green.

## Acceptance criteria

- [ ] Rendered desktop clients use Godot 4.7.1 Forward+ on supported RenderingDevice drivers.
- [ ] Headless/bootstrap/ocean/surf/network/slice behavior remains green and does not load client-only visual content.
- [ ] A `visual-foundation` verification suite records Godot version, renderer, driver, quality profile, resolution, frame samples, p95, 1% low, worst non-loading frame, memory growth, and pass/fail in machine-readable evidence.
- [ ] The suite refuses to pass the target profile on Compatibility fallback.
- [ ] Target, performance, and capture profile identifiers exist; profile selection cannot change gameplay or authority.
- [ ] A three-reload smoke detects crashes, stale scene state, and monotonically growing resources/memory.
- [ ] The pre-P0 global gate remains unchanged and green.
- [ ] Baseline evidence is captured before any expensive water/content effect is introduced.

## Relevant invariants

PERF-01, PERF-02, PERF-03, FAIL-03, AUTH-01, COMP-01, COMP-03.

## Verification-command

```bash
./scripts/verify.sh visual-foundation && ./scripts/verify.sh all
```

The command must exit zero and the ticket handoff must quote the evidence artifact locations and measured values. Do not relax frame thresholds to obtain green.
