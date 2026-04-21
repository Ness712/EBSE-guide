# Extraction Form — PICOC I37 : Test Design Methodology for Gameplay Code

**Domain** : mobile-game-2d
**PICOC #** : I37
**Protocol** : Kitchenham & Charters 2007 §2.4 + Amendment G-1 + MG-2 + MG-3 + MG-6

## PICOC formel

| Element | Value |
|---------|-------|
| **P** | Solo indie / ≤5 FTE 2D pixel-art portrait mobile games (Android + iOS), offline-first, monetised ads + IAP + server-backed leaderboards, V&V budget ≤20% engineering time per SWEBOK KA5 + ISO 29110-4-3. Gameplay modules : ECS, physics, state machines, procedural generation, save/load, economy/IAP logic, leaderboard submission. Out-of-scope : 3D, netcode, console/PC, middleware internals, device-farm infrastructure (H34), determinism property itself (A4') |
| **I** | Test-design methodology class for gameplay code — mix-and-weighting of (a) unit tests of pure gameplay functions with mocked engine, (b) integration tests of engine-game boundary, (c) property-based tests for invariants (score monotonicity, inventory cap, RNG reproducibility), (d) replay-based regression (recorded input + asserted deterministic output, consuming A4'), (e) playtesting per ISO 29119-4 Annex |
| **C** | Discovered systematically per G-1 — no pre-identification |
| **O** | Defect-detection effectiveness per engineer-hour ; escape rate to production (30-day window) ; regression catch rate across patch releases ; line/branch coverage on gameplay modules ; state-space coverage ; replay-scenario coverage ; suite execution time on solo CI ; flakiness rate ; effort cost (author-hours + maintenance) ; playtest ISO 25019 quality-in-use outcomes |
| **C** | Solo / ≤5 FTE ; 2D pixel-art mobile ; offline-first ; Android + iOS ; live-ops cadence ; constrained CI budget ; no dedicated QA ; A4' determinism available ; budget = open-source strict ; ai_agent = yes ; scale = MVP |
| **Anchor** | SWEBOK v4 KA5 ; ISO/IEC/IEEE 29119-4 (specification-based + structure-based + experience-based techniques) ; ISO/IEC 29119-1 ; ISO 25010:2023 Functional Suitability + Reliability ; ISO 25019 Quality-in-use ; ISO 29110-4-3 VSE |

## Candidates discovered (G-1 — not pre-identified)

| # | Candidate | Sub-class | Godot-native | OSS | Evidence |
|---|-----------|-----------|:------------:|:---:|----------|
| 1 | **gdUnit4** (unit + `scene_runner` integration) | Unit + scene integration | yes (Godot 4) | MIT | github.com/MikeSchulze/gdUnit4 |
| 2 | **GUT** (Godot Unit Test) | Unit | yes (3/4) | MIT | github.com/bitwes/Gut |
| 3 | **Replay-based regression** (record input + assert deterministic output) | Experience + spec-based | via A4' | custom | ISO 29119-4 Annex + AAA QA literature |
| 4 | **Property-based testing** (Hypothesis / QuickCheck idiom) | Specification-based | GDScript port or C# FsCheck | yes | Hughes 2000 + game invariant papers |
| 5 | **Playtesting protocols** (moderated + think-aloud + telemetry) | Experience-based | engine-agnostic | yes | ISO 29119-4 Annex + GDC Vault |
| 6 | Unity Test Framework | Unit + integration | Unity-only | mixed | docs.unity.com |
| 7 | Flutter `integration_test` | Integration | Flutter-only | yes | flutter.dev |
| 8 | Ad-hoc manual QA only | None | n/a | n/a | baseline |

**Exclusions (E1-E5)** :

- **E2 (engine incompatibility)** : Unity Test Framework, Flutter `integration_test` — incompatible with Godot pilot P
- **E4 (surface mismatch)** : Android Espresso / iOS XCUITest — native-widget instrumentation, sub-optimal for canvas-rendered game surfaces
- **E4 (pilot P misfit)** : Monkey / fuzz testing — low signal on turn-based farming ; reserve post-MVP
- **E3 (budget gate)** : commercial test orchestration SaaS (BrowserStack App Automate, Sauce Labs) — violates budget=open-source strict

## O-matrix (ordinal 1-5, higher = better)

| Candidate | O1 Defect-detect / eng-hr | O2 Regression catch | O3 State-space cov | O4 Exec time | O5 Flakiness | Σ |
|-----------|:-:|:-:|:-:|:-:|:-:|:-:|
| gdUnit4 unit + `scene_runner` | 5 | 4 | 3 | 5 | 5 | 22 |
| GUT unit only | 4 | 3 | 3 | 5 | 4 | 19 |
| Property-based testing | 4 | 5 | 5 | 3 | 3 | 20 |
| Replay-based regression | 5 | 5 | 4 | 3 | 2 | 19 |
| Playtesting protocols | 3 | 2 | 2 | 1 | 4 | 12 |
| **Mix : gdUnit4 + `scene_runner` + replay (release branches)** | 5 | 5 | 4 | 4 | 4 | 22 |
| Ad-hoc manual QA only | 1 | 1 | 1 | 5 | 2 | 10 |

**Tie-break (gdUnit4-alone vs Mix)** : Mix wins on coverage diversity — unit catches pure-logic defects, `scene_runner` catches engine-boundary defects, replay catches gameplay-sequence regressions unreachable at unit level. Scoping replay to release branches preserves CI budget.

## Top-3 ranking

1. **Mix : gdUnit4 unit + `scene_runner` integration + replay-based regression on release branches** — A-tier, coverage diversity dispositive
2. **gdUnit4 unit + `scene_runner` alone** — B+, strong baseline if replay harness deferred
3. **Replay-based regression alone** — B, high-signal on sequences but insufficient pure-logic coverage

## Kappa A vs B

Tier agreement 6/7 = 86%. Kappa brut ≈ 0.81 ("almost perfect"). Divergence at position 3-5 on property-based testing weight (spec-authoring cost) — not ranking-determinative. Compromise : PBT permitted as optional addition post-MVP for economy / RNG invariant modules.

## GRADE synthesis

**Starting score** : 2 (L1 ISO/IEC 29119-4 + SWEBOK v4 KA5 + L3 gdUnit4 vendor primary docs).

**Positive factors** :

- **+1 major evidence** : gdUnit4 provides Godot-4-native unit + `scene_runner` integration with a fluent API covering the authoring ergonomics most load-bearing on solo-indie velocity ; replay-based regression consumes A4' determinism (seeded RNG + fixed-step `_physics_process`) providing a load-bearing contract for deterministic replay-and-assert harnesses
- **+1 standards alignment** : Mix instantiates ISO/IEC 29119-4 multi-technique selection guidance proportioned to ISO/IEC 29110-4-3 VSE resource envelope

**Negative factors** :

- **-1 indirectness** : replay and PBT literature skews AAA / industrial-scale ; solo-indie cost envelope is extrapolated
- **-1 imprecision** : per-technique suite execution time, flakiness rate, effort cost not quantified from a pilot-P comparable baseline

**Score final** : 2 + 2 − 2 = **2/7 → BONNE PRATIQUE**.

## Sources extracted (Kitchenham Table 2)

| # | Source | Level | Year | Role |
|---|--------|:-----:|:----:|------|
| 1 | ISO/IEC/IEEE 29119-4 test design techniques catalog | L1 | 2021+ | Primary anchor |
| 2 | ISO/IEC/IEEE 29119-1 test process framework | L1 | 2022 | Process anchor |
| 3 | SWEBOK v4 KA5 Software Testing | L1 | 2024 | Knowledge-area anchor |
| 4 | gdUnit4 repo + `scene_runner` docs | L3 | 2024-2026 | Primary candidate |
| 5 | GUT repository | L3 | 2024-2026 | Runner-up |
| 6 | Hughes, QuickCheck (original PBT paper) | L2 | 2000 | PBT origin anchor |
| 7 | Game-specific PBT applications (economy + RNG invariants) | L2-L3 | 2015-2024 | PBT evidence |
| 8 | Replay-based regression case studies in game QA | L3-L5 | 2015-2024 | Replay evidence |
| 9 | ISO/IEC 29110-4-3 VSE profile | L1 | 2018 | V&V proportionality anchor |
| 10 | ISO/IEC 25019:2023 Quality in Use | L1 | 2023 | Playtest outcome anchor |
| 11 | Indie V&V postmortems (GDC Vault, MG-2 grey-lit) | L5 | 2020-2025 | Solo-scale evidence-of-use |

## Decision

**Primary recommendation for pilot P** : **Budget-proportional three-tier mix, all OSS self-host, Godot-native**.

- **Tier 1 — every commit (CI gate)** : gdUnit4 unit tests on pure gameplay modules (economy, damage calc, state transitions, save schema). GitHub Actions free tier.
- **Tier 2 — release-candidate branch gate** : replay-based regression harness invoking recorded input streams + asserting deterministic output, consuming A4' seeded-RNG + fixed-step `_physics_process`. Scoped to release branches to keep main CI lean.
- **Tier 3 — integration surface** : gdUnit4 `scene_runner` on scene-loading, save/load round-trip, leaderboard submission paths.

**Runner-up** : GUT alone — accept if gdUnit4 hits a Godot-version incompatibility or `scene_runner` limitation.

**Optional post-MVP** : property-based testing on economy / RNG invariants (score monotonicity, inventory cap, RNG stream reproducibility). Spec-authoring cost amortised across live-ops cadence.

**Rejected** :

- Ad-hoc manual QA only — violates ISO/IEC 29119-4 minimum technique coverage and ISO/IEC 29110-4-3 VSE floor
- Unity Test Framework / Flutter `integration_test` — engine-incompatible
- Monkey / fuzz testing — low-signal on pilot P ; reserve post-MVP
- Commercial test SaaS — violates budget=open-source strict

**Traceability** : `verification/synthesis/mobile-game-phase2-synthesis.md` row I37 ; A4' determinism consumption for replay ; ISO 29110-4-3 proportionality anchor for mix weighting.
