# Extraction Form — PICOC H35 : Crash and Stability Telemetry Collection

**Domain** : mobile-game-2d
**PICOC #** : H35
**Year** : 2026
**Reviewers** : A + B (isolated) + Agent C verification
**Protocol** : Kitchenham & Charters 2007 §2.4 + Amendment G-1 + #3 + MG-2 + MG-6

## 1. PICOC formel

| Element | Value |
|---------|-------|
| **P** (Population) | Solo indie dev operating a shipped 2D mobile game on Android + iOS in the post-launch phase, needing to detect crashes, ANRs (Android), app hangs (iOS), out-of-memory terminations, and non-fatal errors across a heterogeneous installed base. Crash-free-session rate is a Play Console Vitals threshold gating Play Store visibility and a known Apple App Review signal. |
| **I** (Intervention) | Crash-reporting and stability-telemetry architecture class covering (a) platform-native dashboards (Google Play Console Android Vitals, Apple Xcode Organizer + MetricKit) ; (b) self-hosted OSS crash reporters (GlitchTip, Sentry self-host, self-hosted symbolication) ; (c) managed SaaS (Sentry cloud, Firebase Crashlytics, Bugsnag, Instabug, Embrace) ; (d) custom `/crashes` ingestion endpoint to a self-hosted backend ; (e) platform native APIs only (NSException, setUncaughtExceptionHandler, Breakpad / Crashpad minidump). Axes : delivery channel (platform dashboard vs custom ingestion) ; symbolication locus (device vs server) ; backend requirement (none vs self-host vs SaaS). |
| **C** (Comparator) | Discovered via Phase 2.1 systematic search (G-1) — no pre-identification. |
| **O** (Outcome) | Crash capture rate (% of real crashes surfaced in the dashboard) ; ANR / hang capture rate ; symbolication correctness (% frames with function names + line numbers) ; time-to-insight after a release (hours) ; Play Vitals threshold visibility ; iOS App Store review signal visibility (MetricKit outputs) ; PII / privacy footprint (data sent off-device) ; dev effort ; ingestion cost (USD/month). |
| **Context** | budget=open-source strict (Sentry cloud free tier rejected as SaaS ; Play Vitals + Xcode Organizer + MetricKit platform-mandatory accepted) ; ai_agent=yes ; scale=mvp ; no backend deployed at MVP (self-host crash ingestion deferred until a backend exists) ; privacy-manifest compliance required (D20). |
| **Anchor** | SWEBOK v4 KA6 SE Operations + KA12 Software Quality ; ISO/IEC 25010:2023 Reliability (Availability, Maturity, Fault tolerance) ; Apple MetricKit + Xcode Organizer docs ; Google Play Android Vitals + ANR docs ; Apple App Store Review Guidelines § Performance ; Google Play policy bad-behaviour thresholds. |

## 2. Candidates discovered (G-1 archetype classes)

| # | Candidate | Class | Backend required | Platform-mandatory |
|---|-----------|-------|:----------------:|:------------------:|
| 1 | Play Console Android Vitals (crashes + ANRs) | (a) platform dashboard | no | yes (accepted) |
| 2 | Xcode Organizer + MetricKit | (a) platform dashboard | no | yes (accepted) |
| 3 | GlitchTip self-host | (b) OSS self-host | yes (backend) | no |
| 4 | Sentry self-host (full server) | (b) OSS self-host | yes (heavy backend) | no |
| 5 | Sentry cloud free tier | (c) SaaS | no | no |
| 6 | Firebase Crashlytics | (c) SaaS | no | no |
| 7 | Custom `/crashes` ingestion endpoint | (d) custom | yes (backend) | no |

## 3. Exclusions E1-E5

| Candidate | Criterion | Reason |
|-----------|-----------|--------|
| Sentry cloud free tier | E5 budget | Strict-OSS rejects SaaS even free tier ; explicit in pilot P. |
| Firebase Crashlytics | E5 budget | SaaS even at free tier ; out. |
| Bugsnag / Instabug / Embrace | E5 budget | SaaS paid ; out. |
| Sentry self-host at MVP | E2 scope | Requires a heavy backend (Postgres + ClickHouse / Redis) not present at MVP. Retained as upgrade path alongside GlitchTip when a backend exists. |
| Custom `/crashes` endpoint at MVP | E2 scope | Same — no backend at MVP. |

## 4. O-matrix (ordinal 1-5, higher=better ; O1 gate)

| Candidate | O1 Budget gate | O2 Crash capture rate | O3 ANR / hang capture | O4 Symbolication | O5 Time-to-insight | O6 Play Vitals visibility | O7 iOS review-signal visibility | O8 Privacy footprint | Sigma |
|-----------|:--------------:|:---------------------:|:---------------------:|:----------------:|:------------------:|:-------------------------:|:-------------------------------:|:--------------------:|:-----:|
| Play Console Vitals | 5 PASS | 4 | 5 | 4 | 3 | 5 | n/a | 5 | 26 |
| Xcode Organizer + MetricKit | 5 PASS | 4 | 5 | 4 | 3 | n/a | 5 | 5 | 26 |
| Play Vitals + Xcode Organizer combined | 5 PASS | 5 | 5 | 4 | 3 | 5 | 5 | 5 | 32 |
| GlitchTip self-host (future) | 5 PASS (requires backend) | 5 | 4 | 5 | 5 | n/a | n/a | 3 | 22 |
| Sentry self-host (future) | 5 PASS (requires backend) | 5 | 4 | 5 | 5 | n/a | n/a | 3 | 22 |
| Sentry cloud free | excluded E5 | — | — | — | — | — | — | — | — |
| Firebase Crashlytics | excluded E5 | — | — | — | — | — | — | — | — |

## 5. Top-3 with rationale

1. **Play Console Android Vitals + Xcode Organizer + MetricKit combined** (sigma 32). Platform-mandatory and accepted under the budget rule. Covers crash + ANR + hang + OOM termination on both stores with zero SaaS dependency. MetricKit delivers structured daily diagnostic payloads including hang and disk-write metrics that directly align to App Review performance signals. Play Vitals exposes the crash-free-session threshold that gates discoverability.
2. **GlitchTip self-host added once a backend is deployed**. Lighter than full Sentry, GlitchTip speaks the Sentry SDK protocol, which leaves the door open to migrate later. Strong symbolication + event drill-down that platform dashboards lack. Deferred at MVP because it requires a Postgres + web server.
3. **Full Sentry self-host** as the scale-up alternative if event volume justifies it. Same protocol, heavier infrastructure (ClickHouse / Redis / Kafka). Recorded as scale-up path only.

## 6. Kappa A vs B

Effective set 3 post-exclusion (Play+Xcode combined, GlitchTip future, Sentry-self-host future). Both reviewers rank Play+Xcode > GlitchTip > Sentry-self-host. Top-1 agrees. Tier agreement 3/3 = 100%, kappa ~1.0 "almost perfect". Divergence : none substantive. Supervisor arbitrage : primary confirmed.

## 7. GRADE with factors

Starting score : 2 (pyramid L1 platform docs + L2 SWEBOK KA6 + L1 OSS project docs).

Factors :
- +1 large effect : combining both platform dashboards gives dual-store coverage at zero incremental cost.
- -1 indirectness : platform dashboards sample and aggregate ; event-level drill-down is limited compared to a dedicated reporter. Fine-grained stack traces are not always exposed at the event level.
- -1 imprecision : crash-capture-rate deltas between platform dashboards and self-host reporters are not benchmarked for solo-indie title scales.
- 0 inconsistency : top-1 stable.
- 0 monoculture : L1 vendor + L2 standard + L1 OSS convergence.

Score final : 2 + 1 - 2 = **1/7 → ACCEPTABLE**.

## 8. Sources Table 2

| # | Source | Pyramid level | Year | Role |
|---|--------|:-------------:|:----:|------|
| 1 | Google Play Console Android Vitals docs | L1 vendor | 2025 | Android dashboard anchor |
| 2 | Apple Xcode Organizer + MetricKit docs | L1 vendor | 2025 | iOS dashboard anchor |
| 3 | GlitchTip project docs | L1 OSS | 2025 | Self-host scale-up candidate |
| 4 | Sentry self-host docs | L1 OSS | 2025 | Self-host scale-up candidate |
| 5 | Google Play bad-behaviour thresholds policy | L1 policy | 2025 | Threshold / gating anchor |
| 6 | Apple App Store Review Guidelines § Performance | L1 policy | 2025 | Review-signal anchor |

## 9. Primary recommendation

At MVP, rely on **Google Play Console Android Vitals and Apple Xcode Organizer with MetricKit** as the primary crash and stability telemetry surface. Both are platform-mandatory, platform-collected, and require no SDK integration beyond enabling MetricKit delivery and ensuring symbol files are uploaded during the store submission pipeline (H33). AI agent can pull the weekly MetricKit payload and the Vitals export, diff against the previous window, and raise investigations on regressions of crash-free-session rate, ANR rate, hang rate, or OOM termination rate. When a backend is deployed (outside MVP scope), add **GlitchTip self-host** to capture non-fatal errors, enrich events with user-less metadata consistent with the privacy manifest (D20), and gain event-level drill-down. Avoid any SDK that phones home to a third-party endpoint under strict-OSS. Keep the symbolication artifacts (dSYM, mapping.txt) archived by H33 so Organizer and Vitals always have the bits they need.

## 10. Decision + traceability

**Decision** : Play Console Vitals + Xcode Organizer + MetricKit at MVP. GlitchTip self-host recorded as post-backend upgrade. GRADE ACCEPTABLE (1/7).

**Traceability** : PICOC source `verification/picoc/mobile-game-picoc-batch-H.md` §H35. Amendments G-1 + #3. Cross-refs : H33 (pipeline uploads dSYM + mapping.txt ; delivers to platform dashboards via store upload) ; D17 (store submission attaches symbols) ; D20 (privacy manifest excludes third-party crash reporters at MVP) ; H34 (beta channels feed early crash signal). Anti-double-counting : crash telemetry credited to H35 ; symbol upload to H33 ; privacy disclosure to D20.
