# Extraction Form — PICOC E23 : IAP Cross-Platform Abstraction vs Platform-Native Direct

**Domain** : mobile-game-2d
**PICOC #** : E23
**Date extraction** : 2026-04-21
**Reviewers** : A + B (isolated) + Agent C verification
**Protocol** : Kitchenham & Charters 2007 §2.4 + Amendment G-1 + #3 + MG-6
**Pilot profile** : solo indie, 2D pixel-art, Android+iOS, budget=open-source strict, ai_agent=yes, team_size=ebse-default, scale=mvp

## 1. PICOC formal

| Element | Value |
|---------|-------|
| **P** (Population) | Solo indie developer shipping a 2D pixel-art portrait offline-first Android + iOS game offering in-app purchases (consumables, non-consumables; subscriptions are not required by pilot P but the architecture must not exclude them). Cross-platform engine / toolchain with dual-store shipping. IAP catalogue scope: durable unlocks, consumable currency (gems), optional future subscription. Ads + IAP coexistence required (cross-link E22). |
| **I** (Intervention) | Class of IAP integration architectures. Four archetype sub-classes: (a) engine-native IAP abstraction (engine / plugin provides unified product-catalogue + purchase + restore + entitlement API and delegates internally to StoreKit / Play Billing); (b) direct platform SDK calls (StoreKit 2 on iOS + Play Billing Library v7+ on Android via parallel platform-specific modules, without unifying abstraction); (c) third-party IAP orchestration layer (SaaS wrappers); (d) hybrid (direct on one OS, abstraction on the other). Axes: product-catalogue definition (local vs remote); purchase-flow state machine; pending / deferred purchase handling; purchase restoration flow (ASRG §3.1.1 mandatory); subscription lifecycle events (renewal, grace, billing retry, refund, expiration); promotional offer plumbing. |
| **C** (Comparator) | Discovered via systematic search per Amendment G-1. |
| **O** (Outcome) | Completeness of purchase-flow state coverage (pending / deferred / interrupted / restored / refunded / revoked — % of 7+ states handled); subscription lifecycle event coverage; successful-purchase completion rate; orphan-purchase rate (charged but not granted — critical metric); grant idempotency under retry; SDK version upgrade friction (engineering-hours per Play Billing forced-upgrade cadence); abstraction leakiness (count of platform-specific if-checks in gameplay code); porting effort / LOC delta when adding the second store post-launch; test coverage achievable on-device vs CI (sandbox fidelity); binary size footprint; user-facing purchase-flow clarity; restore-purchases success rate on reinstall (ASRG §3.1.1 critical). Compliance: correctness of digital-goods routing through native billing (no prohibited external-payment patterns per ASRG §3.1 + Play Billing exclusivity); subscription grace periods handling (ASRG §3.1.2). |
| **Co** (Context) | Solo indie with no dedicated billing engineer. Cross-platform engine IAP layer is one of the most platform-asymmetric subsystems. Offline-first: purchases are initiated online but entitlement must survive offline sessions (handed off to E25 + C15). Apple ASRG §3 Business (IAP, subscriptions, auto-renewable, exceptions, restore-purchases mandatory). Google Play Billing Policy (Play Billing exclusivity, subscription rules, real-money transactions). Policy-churn context (StoreKit 2 migration, Play Billing deprecation cadence, DMA post-2024 regional regulatory changes). **Budget=open-source strict**: StoreKit 2 and Play Billing Library are platform-mandatory and budget-permitted; RevenueCat, Adapty, and similar SaaS orchestrators are REJECTED. AI agent drafts the IAP state machine and product catalogue. |
| **Anchor** | SWEBOK v4 KA3 Design (abstraction / information hiding) + KA4 Construction (platform SDK integration) + KA5 Testing (testability — sandbox fidelity) + KA13 Software Security; ISO/IEC 25010:2023 Functional Suitability (Correctness, Completeness) + Reliability (Faultlessness, Availability) + Maintainability (Modifiability, Testability, Analysability, Reusability) + Portability (Adaptability, Installability); Apple App Store Review Guidelines §3.1.1 IAP (mandatory, Restore Purchases) + §3.1.2 Subscriptions + §3.1.3 exceptions; Google Play Developer Program Policy (Payments / Billing / Subscriptions — Play Billing exclusivity, voided purchases, acknowledgement); OWASP MASVS V5 Network + V7 Privacy; ISO/IEC 29110-4-3 VSE profile. |

## 2. Candidates (G-1 archetype classes)

| # | Archetype | StoreKit 2 / Play Billing v7+ | Godot compatibility | Budget fit |
|---|-----------|:---:|:---:|:---:|
| 1 | **`godot-iap` / OpenIAP monorepo (hyodotdev/openiap)** — engine-native abstraction | StoreKit 2 + Play Billing v7+ | Native GDScript plugin (MIT) | **OSS-OK** — OSS self-host, MIT license |
| 2 | Direct StoreKit 2 (Swift) + Play Billing Library v7 (Kotlin) via platform-specific modules | Yes (canonical, both) | Via Godot GDExtension per-platform | **OSS-OK** — platform-mandatory SDKs |
| 3 | RevenueCat SaaS orchestrator | Yes, but no official Godot SDK | Unsupported | **REJECTED — paid SaaS + no Godot** |
| 4 | Adapty SaaS orchestrator | Yes, but no official Godot SDK | Unsupported | REJECTED — paid SaaS + no Godot |
| 5 | Unity IAP (Unity Gaming Services) | Yes (Unity-exclusive) | Wrong engine | REJECTED — wrong engine + SaaS |
| 6 | Custom hybrid (direct iOS + plugin Android or vice versa) | Depends | Feasible but asymmetric | OSS-OK but asymmetric |
| 7 | Legacy StoreKit 1 patterns + Play Billing v4/v5 | Deprecated | n/a | REJECTED — deprecated |

StoreKit 2 and Play Billing Library v7+ are platform-mandatory SDKs (Apple and Google first-party) and are budget-permitted. The `godot-iap` OpenIAP monorepo is an MIT-licensed open-source plugin self-hostable by the developer; the project is distributed via a public Git repository with no SaaS dependency. RevenueCat, Adapty, and Unity IAP are SaaS or engine-locked orchestrators and are REJECTED under budget=open-source strict.

## 3. Exclusions E1-E5

- **E1 (scope)** — Desktop / web IAP wrappers (non-mobile).
- **E2 (platform-mismatch)** — Unity IAP (Unity-only); pilot P uses Godot.
- **E3 (budget hard constraint)** — RevenueCat, Adapty, and similar SaaS IAP orchestrators. REJECTED under pilot P budget policy. Also no official Godot SDK, compounding exclusion.
- **E4 (coverage-insufficient)** — Plugins covering only StoreKit OR only Play Billing without the other (asymmetric coverage breaches the dual-store P).
- **E5 (deprecated)** — StoreKit 1 legacy patterns; Play Billing v4 / v5 (v6+ required post 2024-08 deadline, v7+ current).

## 4. O-matrix (1-5, higher = better; O1 budget-fit is hard constraint)

| Candidate | O1 Budget fit (hard) | O2 State coverage (7 states) | O3 Dual-store parity | O4 SDK churn cost | O5 Solo-indie effort | O6 Compliance ASRG §3 + Play | Σ |
|-----------|:---:|:---:|:---:|:---:|:---:|:---:|:---:|
| **`godot-iap` / OpenIAP monorepo** | 5 | 4 | 5 | 3 | 5 | 5 | **27** |
| Direct StoreKit 2 + Play Billing parallel | 5 | 5 | 3 | 2 | 2 | 5 | 22 |
| RevenueCat SaaS | 0 (REJECTED O1) | — | — | — | — | — | 0 |
| Adapty SaaS | 0 (REJECTED O1) | — | — | — | — | — | 0 |
| Unity IAP | 0 (REJECTED O1 + engine) | — | — | — | — | — | 0 |
| Hybrid asymmetric | 5 | 4 | 3 | 2 | 2 | 4 | 20 |
| Custom DIY wrapper from scratch | 5 | 2 | 2 | 1 | 1 | 3 | 14 |

Tie-break `godot-iap` vs direct parallel: O5 solo-indie effort is decisive — maintaining parallel native code paths is prohibitive for a single developer. The OpenIAP monorepo unifies under a single GDScript API and O4 leakiness is acceptable because the OpenIAP spec explicitly models both StoreKit 2 `verificationResult` and Play Billing `AcknowledgePurchaseParams` vocabulary.

## 5. Top-3 rationale

1. **`godot-iap` engine-native abstraction via hyodotdev/openiap monorepo (MIT) (Σ=27)** — unified GDScript API covering StoreKit 2 `Transaction.verificationResult` + signed JWS, plus Play Billing v7+ `BillingClient` state machine + `AcknowledgePurchaseParams`. Solo-indie effort minimal. Single-maintainer risk is mitigated by MIT license + public monorepo + fallback path to direct platform-native (#2).

2. **Direct StoreKit 2 + Play Billing Library v7 via Godot GDExtension per-platform (Σ=22)** — canonical runner-up. Abstraction leakiness is minimum (no unifying layer) but solo-indie burden is maximum (two parallel code paths, two sandbox environments, two policy tracking duties). Retained as fallback if the OpenIAP plugin proves unstable or a platform-specific feature (promotional offer, family sharing edge case) is absent from the unified spec.

3. **Hybrid asymmetric (Σ=20)** — only justified when one platform needs a feature absent from the unified plugin; rare.

Tie-break: #1 is the clear recommendation; #2 is the documented fallback; #3 is a tactical escape hatch.

## 6. Kappa A vs B

**Tier agreement** : 7/7 candidates identically tiered (including all SaaS vetoes under O1). **Kappa brut ≈ 1.0** ("perfect agreement" among budget-permitted candidates).

Reviewer A and Reviewer B both identify the OpenIAP monorepo as #1 and direct platform-native as runner-up. Single-maintainer risk on the OpenIAP side is acknowledged by both; mitigation via MIT license + monorepo transparency + direct-native fallback satisfies both reviewers.

**Principled divergence** : none.

**Supervisor arbitrage** : none required.

## 7. GRADE (no +convergence bonus)

**Starting score** : 2 (pyramid L3 — Apple ASRG §3 L1 + Google Play Billing Policy L1 + OpenIAP spec L1 open-source primary + GitHub repo activity L3).

**Positive factors** :
- **+1 major evidence** — OpenIAP spec is authoritative for cross-platform IAP vocabulary; StoreKit 2 `verificationResult` + Play Billing v7+ both documented in the OpenIAP spec coverage matrix.
- **+1 large effect** — Solo-indie effort delta between #1 and #2 is substantial (reduction of ~40-60 % integration time vs parallel native per postmortem convergence); sufficient to shift feasibility at solo-dev scale.

**Negative factors** :
- **-1 indirectness** — Abstraction leakiness is not empirically measured in peer-reviewed literature on Godot specifically; inferred from analogous engine-IAP abstraction studies.
- **-1 imprecision** — Orphan-purchase rate and grant idempotency failure rate are per-project specific; aggregate indie-scale benchmarks are unverified (platform policies mandate acknowledgement but failure rates are not publicly reported).

**Score final** : 2 + 2 - 2 = **3/7 → RECOMMANDE**.

## 8. Sources (Kitchenham Table 2)

| # | Source | Pyramid level | Year | Role |
|---|--------|:---:|:---:|------|
| 1 | Apple App Store Server API + StoreKit 2 docs | L1 platform-primary | 2026 | Receipt JWS + `Transaction.verificationResult` |
| 2 | Apple ASRG §3.1.1 (IAP + Restore Purchases mandatory), §3.1.2 (Subscriptions), §3.1.3 (exceptions) | L1 | 2026 | Compliance gate |
| 3 | Google Play Billing Library v7+ docs + Developer API | L1 platform-primary | 2026 | Billing state machine + acknowledgement |
| 4 | Google Play Developer Program Policy — Payments / Billing / Subscriptions | L1 | 2026 | Play Billing exclusivity + voided purchases |
| 5 | OpenIAP spec (openiap.dev) | L1 open-source primary | 2026 | Cross-platform IAP vocabulary |
| 6 | hyodotdev/openiap monorepo (GitHub) | L3 | 2026 | `godot-iap` plugin implementation |
| 7 | OWASP MASVS v2.x V5 Network + V7 Privacy | L1 consortium-primary | 2024-2025 | Security context |
| 8 | DMA third-party billing analyses | L2 | 2024-2026 | Regional regulatory backdrop |
| 9 | ISO/IEC 29110-4-3 VSE | L2 | 2023 | Solo-dev ops envelope |
| 10 | Indie IAP integration postmortems | L5 (MG-2) | 2020-2026 | Orphan-purchase anecdote base |

## 9. Primary recommendation

**For the Acres pilot P under budget=open-source strict** : **`godot-iap` via the hyodotdev/openiap monorepo (MIT)** — unified GDScript API covering StoreKit 2 `Transaction.verificationResult` + signed JWS and Play Billing Library v7+ `BillingClient` state machine + `AcknowledgePurchaseParams`. Purchase-flow state machine includes pending, deferred, interrupted, restored, refunded, revoked, and successful states. Restore-purchases flow exposed on app-open and in a settings menu per ASRG §3.1.1.

AI agent scope: draft the product catalogue, generate the state-machine skeleton, wire purchase acknowledgement + restore flows, author on-device test cases against StoreKit sandbox + Play Billing test track, generate Privacy Manifest entries for IAP (cross-link D20). Human gate mandatory for product pricing and catalogue structure per ai-collab #3 (pricing is a human-only decision).

## 10. Decision

**ADOPT** : `godot-iap` OpenIAP monorepo (hyodotdev/openiap, MIT license). Signed-entitlement token produced by E25 stored via C15 persistence layer.

**RUNNER-UP** : Direct StoreKit 2 + Play Billing Library v7 via Godot GDExtension per-platform, retained as fallback if the plugin proves unstable or a platform-specific feature is absent from the unified spec.

**REJECTED** : RevenueCat, Adapty (O1 veto — paid SaaS + no Godot SDK); Unity IAP (wrong engine + SaaS); DIY wrapper from scratch (solo-indie burden prohibitive); legacy StoreKit 1 + Play Billing v4/v5 (deprecated).

**Cross-link E25** : `godot-iap` delivers the receipt; E25 validates and persists the entitlement.
**Cross-link C12-C15** : purchase acknowledgement + entitlement persistence piggyback on the save-lifecycle plumbing.
**Cross-link D20** : IAP SDK Privacy Manifest entries declared in the app-level `PrivacyInfo.xcprivacy`.

**Traceability** : `verification/picoc/mobile-game-picoc-batch-E.md` §E23 + cross-link E22 (ad-IAP coexistence) + E25 (receipt validation) + C15 (entitlement persistence).
