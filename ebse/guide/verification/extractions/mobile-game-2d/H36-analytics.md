# Extraction Form — PICOC H36 : Product Analytics and Player-Behaviour Telemetry

**Domain** : mobile-game-2d
**PICOC #** : H36
**Year** : 2026
**Reviewers** : A + B (isolated) + Agent C verification
**Protocol** : Kitchenham & Charters 2007 §2.4 + Amendment G-1 + #3 + MG-2 + MG-6

## 1. PICOC formel

| Element | Value |
|---------|-------|
| **P** (Population) | Solo indie dev shipping a 2D mobile game on Android + iOS who needs aggregate product-analytics signal to inform post-launch content direction : install-to-D1 retention, D7 / D30 retention, session length, level / chapter funnel progression, IAP conversion, ad-impression distribution, opt-in rates for ATT (iOS) and Play Install Referrer / Data Safety disclosures. Distinct from crash telemetry (H35) and from remote-config (H37). |
| **I** (Intervention) | Product-analytics architecture class covering (a) platform-native dashboards (Play Console statistics, App Store Connect App Analytics) ; (b) self-hosted OSS analytics (Plausible self-host, Umami, PostHog self-host, Matomo) ; (c) managed SaaS (Firebase Analytics / GA4, Mixpanel, Amplitude, Adjust, AppsFlyer) ; (d) custom `/events` ingestion endpoint to self-hosted backend ; (e) ads-network analytics (AdMob reporting) ; (f) no-analytics. Axes : scope (store-aggregate vs per-event) ; PII footprint ; backend requirement ; strict-OSS fit. |
| **C** (Comparator) | Discovered via Phase 2.1 systematic search (G-1) — no pre-identification. |
| **O** (Outcome) | Signal quality on retention + funnel + conversion outcomes ; install-source attribution correctness ; PII / privacy footprint (events leaving device) ; ATT opt-in compatibility ; Play Data Safety disclosure complexity ; dev effort ; ingestion cost ; time-to-insight ; store-policy compliance ; GDPR/CCPA compatibility. |
| **Context** | budget=open-source strict (Firebase Analytics rejected as SaaS ; Play Console statistics + App Store Connect App Analytics + AdMob reporting platform-mandatory accepted) ; ai_agent=yes ; scale=mvp ; no backend at MVP ; privacy-manifest mandatory (D20) ; ads-with-consent path already in E22 ; offline-first app must tolerate analytics unavailability. |
| **Anchor** | SWEBOK v4 KA6 SE Operations ; ISO/IEC 25010:2023 Functional Suitability + Usability ; ISO/IEC 29134 Privacy Impact Assessment ; GDPR Art. 5-6 (data minimisation, lawful basis) ; Apple App Tracking Transparency + privacy manifest docs ; Google Play Data Safety docs ; Google Play Console statistics + App Store Connect App Analytics docs. |

## 2. Candidates discovered (G-1 archetype classes)

| # | Candidate | Class | Backend required | Strict-OSS fit | Platform-mandatory |
|---|-----------|-------|:----------------:|:--------------:|:------------------:|
| 1 | Play Console statistics + App Store Connect App Analytics + AdMob reporting | (a) platform dashboard | no | yes (platform) | yes |
| 2 | Plausible self-host | (b) OSS | yes | yes (with backend) | no |
| 3 | Umami / Matomo self-host | (b) OSS | yes | yes (with backend) | no |
| 4 | PostHog self-host | (b) OSS | yes (heavy) | yes (with backend) | no |
| 5 | Firebase / GA4 / Mixpanel / Amplitude | (c) SaaS | no | NO | no |
| 6 | Custom `/events` endpoint + SQLite aggregation | (d) custom | yes | yes (with backend) | no |
| 7 | No analytics | (f) | no | yes | no |

## 3. Exclusions E1-E5

| Candidate | Criterion | Reason |
|-----------|-----------|--------|
| Firebase Analytics / GA4 | E5 budget | Strict-OSS rejects SaaS even free tier. |
| Mixpanel / Amplitude / Adjust / AppsFlyer | E5 budget | SaaS paid or freemium ; out. |
| PostHog self-host at MVP | E2 scope | Heavy backend (Postgres + ClickHouse) not present at MVP ; retained as scale-up. |
| No analytics | E1 outcome mismatch | Fails all signal outcomes ; disqualifies the dev from informed post-launch decisions. |
| Ads-network analytics as sole source | E2 coverage | AdMob only reports ad events, not retention / funnel ; retained as complement, not primary. |

## 4. O-matrix (ordinal 1-5, higher=better ; O1 gate)

| Candidate | O1 Budget gate | O2 Retention signal | O3 Funnel / event granularity | O4 Install-source attribution | O5 PII footprint (low=high) | O6 ATT compatibility | O7 Dev effort | O8 Time-to-insight | Sigma |
|-----------|:--------------:|:-------------------:|:-----------------------------:|:-----------------------------:|:---------------------------:|:--------------------:|:-------------:|:------------------:|:-----:|
| Platform dashboards (Play + ASC + AdMob) | 5 PASS | 4 | 2 | 4 | 5 | 5 | 5 | 3 | 28 |
| Plausible self-host | 5 PASS (requires backend) | 3 | 3 | 2 | 5 | 5 | 4 | 4 | 26 |
| Umami / Matomo self-host | 5 PASS (requires backend) | 3 | 3 | 2 | 5 | 5 | 3 | 4 | 25 |
| PostHog self-host | 5 PASS (requires backend) | 5 | 5 | 3 | 4 | 4 | 2 | 5 | 28 |
| Custom `/events` endpoint | 5 PASS (requires backend) | 4 | 5 | 3 | 5 | 5 | 2 | 4 | 28 |
| Firebase / GA4 / Mixpanel | excluded E5 | — | — | — | — | — | — | — | — |
| No analytics | 5 PASS | 1 | 1 | 1 | 5 | 5 | 5 | 1 | 19 |

## 5. Top-3 with rationale

1. **Platform dashboards (Play Console + App Store Connect + AdMob reporting)** at MVP. Zero-integration, zero-PII-add, zero-backend, already provides retention + install source + IAP conversion + ad revenue + crash-free rate as aggregate tables. Aligned with a minimal Data Safety disclosure and with ATT because no third-party SDK is added. The solo dev + AI agent loop consumes CSV exports weekly to steer content priorities.
2. **Plausible self-host** (sigma 26) as the post-backend lightweight companion. Minimal PII (no cookies, no per-user IDs), simple deployment, suits a farming-sim where per-event granularity is not worth the overhead. Aligns easily with Data Safety + GDPR.
3. **Custom `/events` endpoint** or **PostHog self-host** (sigma 28 each) as the scale-up path when funnel-level granularity is justified (e.g. a progression funnel across 20 chapters with measurable drop-off points). Higher dev effort + heavier backend than MVP warrants ; recorded for later.

## 6. Kappa A vs B

Effective set 5 post-exclusion. A ranks platform-dashboards > Plausible > custom-endpoint > PostHog > Umami/Matomo. B ranks platform-dashboards > custom-endpoint > Plausible > PostHog > Umami/Matomo. Top-1 agrees. Tier 2-3 swap (Plausible vs custom-endpoint). Tier agreement 3/5 = 60%, kappa ~0.50 "moderate". Divergence : A values operational simplicity (Plausible ships as a container), B values funnel granularity (custom endpoint is unbounded). Supervisor arbitrage : primary stands ; both are context-gated by backend presence, so either is acceptable once a backend is deployed.

## 7. GRADE with factors

Starting score : 2 (pyramid L1 vendor docs + L1 standards + L2 SWEBOK + L5 indie postmortems).

Factors :
- +1 large effect : platform dashboards deliver the core retention + monetisation signal at zero integration cost and zero PII footprint.
- -1 indirectness : platform dashboards are aggregate-only ; custom funnel drop-off at a specific chapter transition is not directly answerable without a per-event tool. Solo-indie decision loops tolerate the gap at MVP.
- -1 imprecision : benchmarks of decision quality under aggregate-only analytics for solo indie are scarce.
- 0 inconsistency : top-1 stable.
- 0 monoculture : L1 vendor + L1 standards + L5 grey-lit convergence.

Score final : 2 + 1 - 2 = **1/7 → ACCEPTABLE**.

## 8. Sources Table 2

| # | Source | Pyramid level | Year | Role |
|---|--------|:-------------:|:----:|------|
| 1 | Google Play Console statistics + acquisition reports docs | L1 vendor | 2025 | Android dashboard anchor |
| 2 | App Store Connect App Analytics docs | L1 vendor | 2025 | iOS dashboard anchor |
| 3 | Plausible Analytics self-host docs | L1 OSS | 2025 | Lightweight self-host candidate |
| 4 | PostHog self-host docs | L1 OSS | 2025 | Scale-up candidate |
| 5 | Apple ATT + privacy manifest docs / Google Play Data Safety | L1 policy | 2025 | Compliance anchor |
| 6 | GDPR Articles 5-6 + ISO/IEC 29134 PIA | L1 law / standard | 2016 / 2017 | Privacy anchor |

## 9. Primary recommendation

At MVP, treat **Google Play Console statistics, App Store Connect App Analytics, and AdMob reporting as the complete product-analytics surface**. No third-party analytics SDK is integrated. Retention, install source, IAP conversion, session proxies, and ad-revenue breakdowns are read from the platform dashboards ; AI agent exports CSV / API deltas weekly and produces a short "signal brief" that the dev reviews before planning the next content iteration. Data Safety disclosure and ATT remain minimal because no events leave the device to third parties. When a backend is deployed (outside MVP scope), add **Plausible self-host** for lightweight aggregate product signal, or stand up a small **custom `/events` endpoint** if a specific funnel question justifies per-event granularity. PostHog self-host is a later scale-up path when event volume or experimentation needs grow. Keep AdMob reporting as the single source of truth for ad monetisation (E22) rather than double-counting via a separate tool.

## 10. Decision + traceability

**Decision** : Platform dashboards (Play Console + ASC + AdMob) at MVP ; Plausible self-host or custom `/events` endpoint as post-backend upgrade ; SaaS analytics rejected. GRADE ACCEPTABLE (1/7).

**Traceability** : PICOC source `verification/picoc/mobile-game-picoc-batch-H.md` §H36. Amendments G-1 + #3 + MG-2. Cross-refs : D20 (privacy manifest excludes third-party analytics at MVP) ; E22 (AdMob reporting is the authoritative ad-revenue signal) ; E24 (monetisation KPIs read from platform + AdMob) ; H35 (stability signal handled separately) ; H37 (experimentation handled separately). Anti-double-counting : product analytics credited to H36 ; crash telemetry to H35 ; ad reporting primary in E22, surfaced in H36.
