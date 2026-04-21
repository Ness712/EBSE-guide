# Extraction Form — PICOC H37 : Remote Configuration and Feature-Flag Strategy

**Domain** : mobile-game-2d
**PICOC #** : H37
**Year** : 2026
**Reviewers** : A + B (isolated) + Agent C verification
**Protocol** : Kitchenham & Charters 2007 §2.4 + Amendment G-1 + #3 + MG-2 + MG-6

## 1. PICOC formel

| Element | Value |
|---------|-------|
| **P** (Population) | Solo indie dev shipping a 2D mobile game on Android + iOS who may need to adjust tunable parameters (economy values, drop rates, event toggles, ad frequency caps, difficulty curves), roll out features gradually, or kill a feature without a store resubmission. App-review cycles on iOS are measured in hours-to-days so a short time-to-mitigate for a broken tuning decision is valuable. |
| **I** (Intervention) | Remote-configuration / feature-flag architecture class covering (a) hardcoded values + app-store redeploy ; (b) static JSON hosted on a CDN / object store with ETag + cache-control ; (c) self-hosted OSS flag managers (Unleash, Flagsmith self-host, FeatureBase) ; (d) managed SaaS (Firebase Remote Config, LaunchDarkly, ConfigCat, Split.io) ; (e) custom `/config` endpoint to a self-hosted backend ; (f) git-driven config with scheduled client fetch. Axes : rollout granularity (global vs segmented vs percentage) ; change-propagation latency ; backend requirement ; strict-OSS fit. |
| **C** (Comparator) | Discovered via Phase 2.1 systematic search (G-1) — no pre-identification. |
| **O** (Outcome) | Time-to-mitigate a broken tuning change ; rollout granularity (boolean / percentage / segment) ; offline-first behaviour (default when config fetch fails) ; PII / privacy footprint ; dev effort ; backend operational cost ; config-drift risk (client and server disagree) ; store-policy compatibility (Apple forbids changing app behaviour to circumvent review but allows server-driven content / tuning) ; experimentation support (A/B). |
| **Context** | budget=open-source strict (Firebase Remote Config + LaunchDarkly + ConfigCat rejected as SaaS) ; ai_agent=yes ; scale=mvp ; no backend at MVP (any non-trivial remote config requires infrastructure that MVP has not deployed) ; offline-first client must behave deterministically when config is unreachable ; iOS App Review Guideline 4.1 against bait-and-switch behaviour applies. |
| **Anchor** | SWEBOK v4 KA6 SE Operations (release management) + KA9 SE Management (change control) ; ISO/IEC 25010:2023 Maintainability (Modifiability) + Reliability (Availability) ; Apple App Store Review Guidelines § 4.1 ; Google Play Developer Policies § Deceptive Behavior ; Unleash project docs ; Flagsmith self-host docs. |

## 2. Candidates discovered (G-1 archetype classes)

| # | Candidate | Class | Backend required | Strict-OSS fit |
|---|-----------|-------|:----------------:|:--------------:|
| 1 | Hardcode + app-store redeploy | (a) | no | yes |
| 2 | Static JSON on CDN + ETag (self-host CDN, e.g. MinIO + Caddy) | (b) | light static host | yes |
| 3 | Unleash self-host | (c) OSS | yes | yes (with backend) |
| 4 | Flagsmith self-host | (c) OSS | yes | yes (with backend) |
| 5 | Firebase Remote Config / LaunchDarkly / ConfigCat / Split.io | (d) SaaS | no | NO |
| 6 | Custom `/config` endpoint + SQLite-backed admin | (e) custom | yes | yes (with backend) |
| 7 | Git-driven config + scheduled fetch | (f) | git raw URL | yes |

## 3. Exclusions E1-E5

| Candidate | Criterion | Reason |
|-----------|-----------|--------|
| Firebase Remote Config | E5 budget | SaaS ; strict-OSS rejects even free tier. |
| LaunchDarkly / ConfigCat / Split.io | E5 budget | SaaS paid ; out. |
| Unleash / Flagsmith self-host at MVP | E2 scope | Requires a backend not present at MVP. Retained as post-backend upgrade. |
| Custom `/config` endpoint at MVP | E2 scope | Same — no backend at MVP. |
| Arbitrary behaviour switch post-review | E3 policy | Apple 4.1 forbids changing app behaviour to circumvent review ; tuning must stay within reviewed functionality. Scope limit, not an archetype exclusion. |

## 4. O-matrix (ordinal 1-5, higher=better ; O1 gate)

| Candidate | O1 Budget gate | O2 Time-to-mitigate | O3 Rollout granularity | O4 Offline-first safety | O5 PII footprint (low=high) | O6 Dev effort | O7 Operational cost | O8 Experimentation support | Sigma |
|-----------|:--------------:|:-------------------:|:----------------------:|:-----------------------:|:---------------------------:|:-------------:|:-------------------:|:--------------------------:|:-----:|
| Hardcode + redeploy | 5 PASS | 1 (days) | 1 | 5 | 5 | 5 | 5 | 1 | 23 |
| Static JSON + ETag (CDN) | 5 PASS (requires static host) | 4 | 2 | 5 | 5 | 4 | 4 | 2 | 26 |
| Unleash self-host (future) | 5 PASS (requires backend) | 5 | 5 | 4 | 4 | 2 | 3 | 5 | 28 |
| Flagsmith self-host (future) | 5 PASS (requires backend) | 5 | 5 | 4 | 4 | 2 | 3 | 5 | 28 |
| Custom `/config` (future) | 5 PASS (requires backend) | 4 | 4 | 4 | 5 | 2 | 3 | 3 | 25 |
| Git-driven config + fetch | 5 PASS | 3 | 2 | 4 | 4 | 4 | 5 | 2 | 24 |
| Firebase RC / LD / ConfigCat | excluded E5 | — | — | — | — | — | — | — | — |

## 5. Top-3 with rationale

1. **Hardcode + redeploy at MVP** (sigma 23 — low on speed but highest on simplicity). The honest answer at MVP : with no backend, no SaaS allowed, and a small installed base, the cost of a hotfix redeploy (iOS expedited review + Play staged rollout) is a bounded number of hours and is rarely exercised. Paying for remote-config infrastructure before it is needed is negative ROI.
2. **Static JSON on a CDN (self-hosted object store + Caddy) with ETag + cache-control** (sigma 26). The first step once even minimal static hosting exists. Client fetches `config.json`, caches, falls back to the bundled defaults on failure. No secrets, no PII, no backend logic ; review-safe. Supports global parameter tuning (drop rates, ad frequency) without store resubmission. No percentage rollouts and no segmentation, but those are not MVP requirements.
3. **Unleash or Flagsmith self-host** (sigma 28 each) once a backend is deployed. Proper percentage rollouts, kill-switches, user / device segmentation, A/B experiments. Dev effort and operational cost make them unjustified at MVP ; they become the target architecture when the install base or ops tempo justifies them.

## 6. Kappa A vs B

Effective set 4 post-exclusion (hardcode, static-JSON, Unleash-future, Flagsmith-future). A ranks static-JSON > Unleash > Flagsmith > hardcode. B ranks hardcode > static-JSON > Unleash > Flagsmith. Top-1 disagrees : A on speed-once-infra-exists, B on YAGNI at MVP. Tier agreement 2/4 = 50%, kappa ~0.33 "fair". Divergence : time horizon. Supervisor arbitrage : adopt B at MVP (no infra deployed, hardcode is honest), and adopt A's static-JSON as the first upgrade step when any static host exists. Unleash / Flagsmith remain the post-backend target.

## 7. GRADE with factors

Starting score : 2 (pyramid L1 vendor docs + L1 OSS project docs + L1 store policy + L2 SWEBOK KA9).

Factors :
- +1 large effect : YAGNI-at-MVP removes an entire class of infra cost without materially harming the outcome, because expedited store review bounds the mitigation time.
- -1 indirectness : expedited-review latency distributions are reported anecdotally ; the upper bound on time-to-mitigate under hardcode is not rigorously benchmarked.
- -1 imprecision : remote-config usage rates and hotfix frequencies for solo-indie titles are not published.
- 0 inconsistency : the top-1 split between A and B is resolved by context rather than by evidence quality.
- 0 monoculture : L1 vendor + L1 OSS + L1 policy convergence.

Score final : 2 + 1 - 2 = **1/7 → ACCEPTABLE**.

## 8. Sources Table 2

| # | Source | Pyramid level | Year | Role |
|---|--------|:-------------:|:----:|------|
| 1 | Apple App Store Review Guidelines § 4.1 | L1 policy | 2025 | Behaviour-switch compliance anchor |
| 2 | Google Play Developer Policies § Deceptive Behavior | L1 policy | 2025 | Behaviour-switch compliance anchor |
| 3 | Unleash project docs (self-host deployment) | L1 OSS | 2025 | Scale-up feature-flag candidate |
| 4 | Flagsmith self-host docs | L1 OSS | 2025 | Scale-up feature-flag candidate |
| 5 | HTTP caching RFC 9111 + ETag semantics | L1 standard | 2022 | Static-JSON integrity anchor |
| 6 | ISO/IEC 25010:2023 Maintainability + Reliability | L1 standard | 2023 | Outcome anchor |

## 9. Primary recommendation

At MVP, use **hardcoded configuration values compiled into the app, updated via normal store releases**, with a clear mitigation SOP : if a tuning mistake is shipped (an economy parameter out of band, an ad-frequency cap too aggressive), prepare a hotfix, submit to Apple as an expedited review with a rationale and publish to Play with a staged rollout. AI agent can pre-stage the hotfix branch and prepare the store listing notes. Keep all tunables in a single `config.gd` (or equivalent) file so a change is one-line and auditable. As soon as any static hosting is deployed (self-hosted object store + Caddy / nginx as part of H33 artifact infra), migrate tunables to a **static JSON with ETag + cache-control**, with bundled defaults as offline-safe fallback. Defer Unleash or Flagsmith self-host to the moment a backend is deployed and the team needs percentage rollouts, segmentation, or A/B experiments. Reject Firebase Remote Config and equivalent SaaS under strict-OSS. Stay within Apple 4.1 and Google Play deceptive-behaviour bounds : tuning must not change advertised functionality, unlock unreviewed content, or circumvent the rating.

## 10. Decision + traceability

**Decision** : Hardcode + redeploy at MVP ; static-JSON on self-hosted object store as first upgrade ; Unleash / Flagsmith self-host as post-backend target. GRADE ACCEPTABLE (1/7). SaaS flag managers rejected under strict-OSS.

**Traceability** : PICOC source `verification/picoc/mobile-game-picoc-batch-H.md` §H37. Amendments G-1 + #3 + MG-2. Cross-refs : D17 (expedited store review is the MVP mitigation channel) ; H33 (static object store provisioned alongside artifact store when available) ; H36 (any experimentation signal reads from product analytics) ; E22b (ad-frequency caps are a candidate tunable) ; A1 (engine config loader is the consumer). Anti-double-counting : config-propagation mechanism credited to H37 ; store redeploy channel to D17 ; analytics consumption to H36.
