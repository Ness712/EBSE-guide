# Extraction Form — PICOC A4' : Simulation Update Strategy (Timing & Determinism)

**Domain** : mobile-game-2d
**PICOC #** : A4'
**Date** : 2026
**Reviewers** : A + B (isolated contexts) + Agent C verification
**Protocol** : Kitchenham & Charters 2007 §2.4 + Amendment G-1 + Amendment #3 + methodology.md v2026.04.7

## 1. PICOC formal

| Element | Value |
|---------|-------|
| **P** | Solo indie mobile game developer implementing the simulation loop of a 2D pixel-art farming-sim where gameplay depends on deterministic or near-deterministic update behaviour: pixel-perfect movement, replayable runs, platform-leaderboard-submittable verifiable scores ; runs on heterogeneous Android + iOS hardware (60/90/120 Hz panels, battery-throttled CPU, OS-driven vsync) |
| **I** | Class of timestep + update-decoupling patterns: fixed-step simulation with interpolated/extrapolated render ; variable-step simulation ; semi-fixed (accumulator) with clamped max dt ; deterministic vs non-deterministic integration — within the sub-space permitted by the threading model imposed by the engine chosen in A1 |
| **C** | Discovered systematically in Phase 2.1 — no pre-identification per Amendment G-1 |
| **O** | Input-to-visual latency median + p95 (target ≤ 2 frames @ 60 Hz ≈ 33 ms) ; simulation jitter σ² of effective dt ; determinism rate (% identical runs over 100 replays of same input sequence on same device, target ≥ 99%) ; frame-drop % on 60/90/120 Hz panels ; CPU ms per simulation step ; thermal throttling onset (s before first throttle event) ; leaderboard-score reject rate |
| **Co** | Pixel-art = elevated tolerance to visual stutter (discrete motion) but determinism critical for leaderboard integrity ; portrait lock ; offline-first (no server reconciliation to mask non-determinism) ; OS background/foreground interrupts the loop ; thermal throttling changes frame budget mid-session ; transverses = budget=open-source strict, ai_agent=yes, team_size=ebse-default, scale=mvp |
| **Anchor** | SWEBOK v4 KA2 Architecture (control-flow styles) + KA3 Design (real-time/reactive patterns) + KA16 Computing Foundations (concurrency, timing) ; ISO/IEC 25010:2023 Performance Efficiency (Time behaviour) + Reliability (Maturity via deterministic replay, Fault tolerance under frame drops) ; ISO/IEC 25019 Freedom from risk (leaderboard integrity) ; Apple ASRG §2.3.1 + §2.5.1 ; Google Play Vitals ANR + jank thresholds |

## 2. Candidates discovered (archetype classes)

| # | Archetype class | Description |
|---|-----------------|-------------|
| 1 | Fixed-step simulation + interpolated render | Simulation advances at canonical rate (e.g. 60 Hz), rendering interpolates between last two states for display refresh ; classic Fiedler / Gregory Ch. 8 pattern |
| 2 | Fixed-step simulation + extrapolated render | Simulation at canonical rate, render extrapolates forward by accumulator leftover ; lower latency but prediction error on direction changes |
| 3 | Semi-fixed (accumulator with dt clamp) | Accumulator pattern running 0..N fixed steps per frame, max-dt clamp to prevent spiral-of-death ; pragmatic default |
| 4 | Pure variable-step (delta-time) | One simulation step per render frame, dt = frame delta ; simplest, non-deterministic, numeric instability under large dt |
| 5 | Decoupled render thread + fixed sim thread | Simulation on its own thread at canonical rate, render thread pulls latest snapshot ; engine-permitting only |
| 6 | Deterministic fixed-point integration | Fixed-point (or rational) arithmetic inside fixed-step simulation for bit-level reproducibility across CPUs |

## 3. Exclusions at screening

| Candidate pattern | Exclusion code | Reason |
|-------------------|:--------------:|--------|
| Client-rewinding netcode | E2 | Offline-first P — no network rollback required |
| Server-authoritative tick | E2 | No server component in pilot P ; budget=open-source strict excludes cloud tick services |
| Fully async GPU-driven simulation | E3 | Maturity + portability on Android/iOS insufficient for solo indie horizon |
| Lockstep multi-client | E2 | Single-player farming-sim ; no peer client |

## 4. O-matrix (ordinal 1–5, higher = better)

| Archetype | O1 Input latency | O2 Jitter control | O3 Determinism | O4 Frame-drop resilience | O5 CPU budget headroom | O6 Implementation effort (solo) | O7 Engine-threading compat | Σ |
|-----------|:---------------:|:-----------------:|:--------------:|:------------------------:|:----------------------:|:-------------------------------:|:--------------------------:|:-:|
| 1. Fixed + interpolated | 3 | 5 | 5 | 5 | 4 | 4 | 5 | 31 |
| 2. Fixed + extrapolated | 5 | 4 | 5 | 4 | 4 | 3 | 5 | 30 |
| 3. Semi-fixed accumulator | 4 | 4 | 4 | 4 | 4 | 5 | 5 | 30 |
| 4. Pure variable | 5 | 2 | 1 | 3 | 5 | 5 | 5 | 26 |
| 5. Decoupled threads | 4 | 5 | 4 | 5 | 3 | 2 | 2 | 25 |
| 6. Fixed-point deterministic | 3 | 5 | 5 | 5 | 3 | 1 | 4 | 26 |

## 5. Top-3 ranking with rationale

1. **Fixed-step with interpolated render (archetype 1)** — Highest determinism + jitter control ; leaderboard integrity preserved since identical input sequences yield identical simulation state. Interpolation introduces one-frame presentation lag but for a turn-paced farming-sim this is imperceptible.
2. **Semi-fixed accumulator (archetype 3)** — Best implementation-effort-to-outcome ratio for a solo developer. Clamped max dt prevents spiral-of-death under thermal throttling ; determinism slightly weaker than pure fixed-step because accumulator boundary effects can cause a variable count of steps per frame.
3. **Fixed-step with extrapolated render (archetype 2)** — Lowest perceived input latency, useful if touch-action responsiveness is prioritized ; extrapolation artefacts visible on abrupt direction changes, acceptable for farming-sim but not for twitchy action genres.

## 6. Kappa A vs B

Agreement on ranking across 6 archetypes: 5/6 → **κ ≈ 0.80 ("substantial")**. Divergence concerns archetype 2 vs 3 placement: Reviewer A ranks accumulator first for solo-indie pragmatism ; Reviewer B ranks extrapolated first for perceived responsiveness. Supervisor arbitrage: fixed-interpolated retained as primary because determinism rate weighs more heavily than −1 frame of presentation lag under the farming-sim P ; the two runners-up are essentially tied and ordered by secondary criterion (implementation effort).

## 7. GRADE synthesis

Starting score : **3** (highest source = L2 Gregory "Game Engine Architecture" Ch. 8 + L1 ISO 25010 Time behaviour).

Positive factors:
- **+1 large_effect** — Fixed-step patterns reduce determinism error from O(frame_jitter × dt²) to effectively zero for same-device replay ; the qualitative leap from non-deterministic to deterministic is binary for leaderboard integrity.
- **+1 major_evidence** — Pattern literature is cross-engine and cross-decade (Fiedler 2004–2022 ; Gregory 3rd ed. 2018), reducing engine-coupling confound.

Convergence factor **OMITTED** (monoculture discount — real-time simulation pattern canon is socially reinforced ; multiple grey-literature sources restate the same Fiedler/Gregory framing rather than providing independent evidence).

Negative factors:
- **−1 indirectness** — Target device class (mid-range 2026 Android + iOS) is not the hardware most of the cited literature benchmarked (desktop PC or console). Thermal throttling behaviour on mobile differs from desktop.
- **−1 imprecision** — Determinism rate ≥ 99% threshold unverified empirically ; replay-test harnesses in the cited literature are qualitative.

No −1 inconsistency (converging recommendation across sources) ; no −1 bias.

Final score : 3 + 2 − 2 = **3/7 → RECOMMANDE**.

## 8. Sources extracted (Kitchenham Table 2)

| # | Source | Pyramid level | Year | Role |
|---|--------|:-------------:|:----:|------|
| 1 | Gregory J. "Game Engine Architecture" 3rd ed. Ch. 8 | L2 | 2018 | Pattern taxonomy canonical |
| 2 | Fiedler G. "Fix Your Timestep!" gafferongames | L5 grey-lit MG-2 | 2004–2022 | Accumulator pattern reference |
| 3 | ISO/IEC 25010:2023 §4.2 Performance Efficiency | L1 | 2023 | Time-behaviour anchor |
| 4 | ISO/IEC 25010:2023 §4.4 Reliability (Maturity) | L1 | 2023 | Determinism anchor |
| 5 | Google Play Vitals ANR + jank thresholds | L1 platform | 2026 | Mobile-specific constraints |
| 6 | Apple ASRG §2.3.1 + §2.5.1 | L1 platform | 2026 | Performance + battery compliance |
| 7 | ACM DL game-pattern papers (real-time loops) | L3 | 2018–2024 | Academic cross-reference |
| 8 | Engine-official timing documentation (per A1 exemplar) | L1 vendor | 2026 | Threading-model constraint |

## 9. Primary recommendation for pilot P

**Fixed-step simulation at 60 Hz with interpolated render**, max-dt clamp of 0.25 s inside a semi-fixed accumulator fallback for engines that do not natively expose a pure fixed-step callback. Input sampled at the top of each simulation step ; render reads the interpolated state. All gameplay logic contributing to leaderboard scores executes only inside the fixed step. This configuration is compatible with archetype 1 from A1 and requires no SaaS, no paid tooling, no cloud tick services — budget=open-source strict compliant.

## 10. Decision with traceability

**Decision** : Adopt archetype 1 (fixed-step + interpolated render) as canonical simulation pattern. Fallback to archetype 3 (semi-fixed accumulator) where the engine threading model does not expose a pure fixed callback.

**Traceability** : PICOC definition in `verification/picoc/mobile-game-picoc-batch-A.md` §A4' ; dependency on A1 (engine threading model = constraint, not intervention) documented in the cross-batch dependency graph ; consumers: I37 (replay-based test methodology), F26 (leaderboard score validity). J43 defers to A4' per amendment MG-9 clarification.
