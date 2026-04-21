# Extraction Form — PICOC H34 : Device and Emulator Test Matrix Strategy

**Domain** : mobile-game-2d
**PICOC #** : H34
**Year** : 2026
**Reviewers** : A + B (isolated) + Agent C verification
**Protocol** : Kitchenham & Charters 2007 §2.4 + Amendment G-1 + #3 + MG-2 + MG-6

## 1. PICOC formel

| Element | Value |
|---------|-------|
| **P** (Population) | Solo indie dev validating builds of a 2D pixel-art portrait offline-first Android + iOS game against a heterogeneous device population spanning OS versions, screen aspect ratios (including notched + hole-punch + foldable), RAM tiers (2 GB low-end through flagship), GPU families (Adreno, Mali, PowerVR, Apple GPU), and thermal envelopes. Dual-store submission requires both platform toolchains. |
| **I** (Intervention) | Device-testing architecture class covering (a) local emulators / simulators (Android Studio AVD, Xcode Simulator) ; (b) Linux container runtimes (Waydroid) ; (c) physical devices owned by the dev ; (d) beta-channel distribution to testers (TestFlight, Play Internal Testing, Play Closed Testing) ; (e) managed device-farm services (Firebase Test Lab, AWS Device Farm, BrowserStack) ; (f) continuous device-cloud execution integrated into CI. Axes : fidelity (simulator vs real hardware) ; coverage breadth (matrix size) ; budget fit (strict-OSS or platform-mandatory vs SaaS rejected). |
| **C** (Comparator) | Discovered via Phase 2.1 systematic search (G-1) — no pre-identification. |
| **O** (Outcome) | Bug-detection rate pre-release (% of post-release bugs reproducible on the test matrix) ; crash-free-session rate at launch ; frame-time regression detection on low-end devices ; GPU shader-compile failure detection ; store rejection avoidance (pre-review failure caught pre-submission) ; test-matrix latency (hours from build to matrix completion) ; test-matrix cost (USD/month amortized) ; dev effort per matrix run ; reproducibility of found defects. |
| **Context** | budget=open-source strict (Firebase Test Lab free tier rejected as SaaS ; TestFlight + Play Internal Testing platform-mandatory accepted) ; ai_agent=yes ; scale=mvp ; solo dev with a small owned-device pool (typically 2-4 phones spanning low-end Android + mid-tier Android + one iPhone) ; Linux dev workstation with Waydroid optional. |
| **Anchor** | SWEBOK v4 KA5 Software Testing + KA6 SE Operations ; ISO/IEC 25010:2023 Reliability (Availability, Fault tolerance) + Portability (Adaptability, Installability) + Performance Efficiency ; ISO/IEC 29119 software testing ; Android developer testing docs ; Apple TestFlight + XCTest docs ; Google Play pre-launch report docs. |

## 2. Candidates discovered (G-1 archetype classes)

| # | Candidate | Class | Strict-OSS fit | Platform-mandatory path |
|---|-----------|-------|:--------------:|:-----------------------:|
| 1 | Android Studio AVD emulator | (a) local emulator | yes | no |
| 2 | Xcode Simulator | (a) local simulator | yes (tooling free, macOS required) | no |
| 3 | Waydroid container on Linux | (b) container runtime | yes | no |
| 4 | Own physical devices (Android + iPhone) | (c) real hardware | yes | no |
| 5 | TestFlight beta | (d) platform beta channel | yes (platform-mandatory) | yes |
| 6 | Play Internal Testing + Closed Testing | (d) platform beta channel | yes (platform-mandatory) | yes |
| 7 | Firebase Test Lab / AWS Device Farm / BrowserStack | (e) managed device-farm SaaS | NO (strict-OSS rejects SaaS) | no |

## 3. Exclusions E1-E5

| Candidate | Criterion | Reason |
|-----------|-----------|--------|
| Firebase Test Lab (Spark / free tier) | E5 budget | Strict-OSS rejects SaaS even free tier ; explicitly out per pilot P. |
| AWS Device Farm / BrowserStack | E5 budget | SaaS paid ; out. |
| Play Pre-launch Report | E5 budget partial | Uses Firebase Test Lab backend ; treat as informational only when free via Play Console, not as the primary matrix. |
| Xcode Cloud device testing | E5 budget | SaaS metered ; out. |
| Crowd-sourced tester marketplaces | E3 quality variance | Coverage unpredictable ; out of MVP. |

## 4. O-matrix (ordinal 1-5, higher=better ; O1 gate)

| Candidate | O1 Budget gate | O2 Fidelity to real hardware | O3 OS-version coverage | O4 Device-matrix breadth | O5 Pre-store rejection catch | O6 Latency build→matrix | O7 Dev effort | Sigma |
|-----------|:--------------:|:----------------------------:|:----------------------:|:------------------------:|:----------------------------:|:-----------------------:|:-------------:|:-----:|
| Android Studio AVD | 5 PASS | 3 | 5 | 4 | 3 | 5 | 5 | 30 |
| Xcode Simulator | 5 PASS | 3 | 5 | 3 | 3 | 5 | 5 | 29 |
| Waydroid | 5 PASS | 3 | 3 | 2 | 2 | 5 | 3 | 23 |
| Own physical devices | 5 PASS | 5 | 2 | 2 | 4 | 4 | 4 | 26 |
| TestFlight | 5 PASS (platform) | 5 | 4 | 4 | 5 | 3 | 4 | 30 |
| Play Internal Testing | 5 PASS (platform) | 5 | 4 | 4 | 5 | 3 | 4 | 30 |
| Firebase Test Lab | excluded E5 | 5 | 5 | 5 | 5 | 4 | 4 | — |

## 5. Top-3 with rationale

1. **Layered matrix : AVD + Simulator + own devices + TestFlight + Play Internal Testing** (best composite coverage). Each stratum covers a different failure mode : AVD/Simulator for rapid iteration on a wide OS-version set, own physical devices for real GPU + thermal + input latency, TestFlight + Play Internal Testing for real-user real-device feedback before public release. Platform betas also surface store-review-style rejections (privacy manifest, required reasons API) before public submission.
2. **AVD + Xcode Simulator + own devices only** (cheaper, faster). Acceptable when beta-channel logistics are heavy ; loses pre-store rejection catches and real-user feedback.
3. **Waydroid + own devices** (Linux-native workflow). Appealing on a Linux workstation where AVD is heavy ; lower fidelity than AVD on graphics subsystems and weaker OS-version coverage.

## 6. Kappa A vs B

Effective set 5 post-exclusion. A ranks layered-matrix > AVD+Sim+devices > TestFlight-only > Play-Internal-only > Waydroid+devices. B ranks layered-matrix > AVD+Sim+devices > Play-Internal-only > TestFlight-only > Waydroid+devices. Top-1 agrees. Tier 3-4 swap (TestFlight vs Play Internal). Tier agreement 3/5 = 60%, kappa ~0.50 "moderate". Divergence : stylistic ordering of the two platform-beta channels. Supervisor arbitrage : primary stands ; both platform channels are mandatory because the title is dual-store.

## 7. GRADE with factors

Starting score : 2 (pyramid L1 platform docs + L2 SWEBOK KA5 + L1 ISO 29119 + L5 indie postmortems).

Factors :
- +1 large effect : layered matrix stacks fidelity gains that no single stratum achieves alone.
- -1 indirectness : bug-detection-rate-by-stratum empirical data is scarce for solo-indie archetypes.
- -1 imprecision : TestFlight + Play Internal latency distributions and tester-response-rate benchmarks are not normalized for MVP indie titles.
- 0 inconsistency : top-1 stable.
- 0 monoculture : L1 vendor + L1 standard + L5 grey-lit convergence.

Score final : 2 + 1 - 2 = **1/7 → ACCEPTABLE**.

## 8. Sources Table 2

| # | Source | Pyramid level | Year | Role |
|---|--------|:-------------:|:----:|------|
| 1 | Android Studio AVD / emulator docs | L1 vendor | 2025 | Emulator anchor |
| 2 | Xcode Simulator + TestFlight docs | L1 vendor | 2025 | iOS toolchain anchor |
| 3 | Play Internal Testing + Closed Testing docs | L1 vendor | 2025 | Android beta-channel anchor |
| 4 | Waydroid project docs | L1 OSS | 2025 | Linux container runtime |
| 5 | ISO/IEC 29119 software testing | L1 standard | 2022 | Testing methodology anchor |
| 6 | Indie mobile device-test postmortems | L5 MG-2 grey-lit | varied | Matrix-strategy evidence |

## 9. Primary recommendation

Adopt a **layered test matrix** : (1) Android Studio AVD profiles covering the Android API-level floor + one mid + one current + one foldable geometry, run on every push from the local dev loop ; (2) Xcode Simulator profiles covering iPhone SE (smallest screen), a recent Pro (notch + ProMotion), and an iPad if iPad support is declared ; (3) at least one physical low-end Android (the actual RAM + GPU floor of the declared `minSdk`) and one iPhone owned by the dev for real-input + thermal runs ; (4) TestFlight external beta for iOS and Play Internal Testing (escalating to Closed Testing) for Android before each store submission, with a small stable tester cohort. Waydroid is an optional Linux-only accelerator for sanity-checks, not a substitute for AVD. Firebase Test Lab and equivalent SaaS farms are rejected under strict-OSS ; the dev-owned device pool plus platform beta channels is the strict-OSS coverage path. AI agent can drive emulator launches + XCTest / espresso smoke runs ; human is required for TestFlight tester-facing release notes.

## 10. Decision + traceability

**Decision** : Layered matrix AVD + Simulator + own devices + TestFlight + Play Internal Testing. GRADE ACCEPTABLE (1/7). Managed device-farm SaaS excluded by E5.

**Traceability** : PICOC source `verification/picoc/mobile-game-picoc-batch-H.md` §H34. Amendments G-1 + #3 + MG-2. Cross-refs : H33 (pipeline dispatches AVD + Simulator stages to self-hosted runners) ; H35 (crash reporting consumes test-matrix outputs) ; D17 (TestFlight + Play Internal Testing are the beta rail into store submission). Anti-double-counting : device strategy credited to H34 ; pipeline wiring to H33 ; store upload to D17.
