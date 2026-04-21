# Extraction Form — PICOC E25 : Server-Side Receipt Validation + Entitlement Persistence + Anti-Fraud

**Domain** : mobile-game-2d
**PICOC #** : E25
**Date extraction** : 2026-04-21
**Reviewers** : A + B (isolated) + Agent C verification
**Protocol** : Kitchenham & Charters 2007 §2.4 (Data Extraction) + Amendment G-1 + Amendment #3 + MG-6 (cross-PICOC tagging : explicit split with C15)

## PICOC formel

**Scope boundary with C15** : C15 owns the save file *as persistence mechanism* (atomic writes, schema migration, cloud-save reconciliation — medium-agnostic about what it persists). E25 owns *entitlement semantics* (what is a valid entitlement, how obtained via receipt validation, crypto binding, revocation semantics). The signed-entitlement token produced by E25 is STORED by C15's persistence layer. C15 treats it as opaque bytes with integrity requirements ; E25 treats C15 as a black-box durable store.

| Element | Value |
|---------|-------|
| **P** (Population) | Solo indie mobile 2D pixel-art offline-first Android+iOS with IAP (consumables + non-consumables + optionally subscriptions). Each purchase produces a receipt (Apple StoreKit 2 signed JWS or Google Play purchase token + signature) that must be (a) verified as authentic, (b) converted into a persisted entitlement, (c) protected against replay + sharing + local tampering. Threat model = casual hex-edit griefers + community-shared save-edit tools, NOT determined adversary. **Budget = open-source strict** ; **scale = MVP** ; ai_agent = yes. |
| **I** (Intervention) | Class of receipt-validation + entitlement-persistence architectures. 4 archetype sub-classes : (a) **client-only validation** (local StoreKit 2 `Transaction.verificationResult` JWS verify + Play Billing local signature check ; entitlement persisted to local save via C15) ; (b) **server-authoritative** (dev-owned backend calls Apple App Store Server API + Google Play Developer API ; stores canonical entitlement ; returns signed entitlement to client) ; (c) **hybrid signed-cache** (server validation with locally-cached signed entitlement for offline use) ; (d) **third-party SaaS orchestrator** (RevenueCat / Adapty / Iaptic etc.). Anti-fraud within SE scope : receipt-replay detection, device/account binding, subscription-state reconciliation (grace, billing retry, refund revocation), MASVS-RESILIENCE posture for local cache. |
| **C** (Comparator) | Discovered via systematic search (G-1) — no pre-identification. |
| **O** (Outcome) | (a) receipt-forgery resistance + replay-attack resistance + tamper resistance (adversarial test matrix pass rate) ; (b) key-material correctness (no embedded secrets client-side, MASVS-CRYPTO) ; (c) entitlement availability during offline sessions (% availability vs offline-first baseline) ; (d) reconciliation correctness when connectivity returns ; (e) refund-while-offline + subscription-expiry-while-offline handling ; (f) idempotency of entitlement grant under retry ; (g) adherence to platform-mandated validation patterns (ASRG §3 + Play Billing acknowledgement) ; (h) subscription lifecycle event handling ; (i) operational burden solo indie (backend uptime, key rotation, App Store Server Notifications v2 endpoint, Play Real-time Developer Notifications ; engineering-hours + $/month) ; (j) data integrity cross reinstall + account migration + device change (cross-link C14) ; (k) privacy data-minimisation (cross-link D20). **User-facing** : (l) false-positive rate on honest users (CRITICAL — must not break IAP restore for legitimate users) ; (m) IAP restore flow success (ASRG §3.1.1 mandatory). |
| **Co** (Context) | Solo indie NO ops team ; offline-first game loop (entitlement MUST remain usable without reachable backend ; reconciliation is eventual — pushes toward hybrid signed-cache) ; dual-store MASVS V6 compliance ; Play Billing purchase-acknowledgement mandatory clause ; Apple server-notification responsibilities if subscriptions offered ; fraud surface indie 2D = lower-value-per-account than AAA (shifts cost/benefit). **Budget open-source strict** : Free-tier SaaS (RevenueCat free tier) REJECTED ; paid SaaS REJECTED ; platform-mandatory Play Billing sandbox + StoreKit 2 local verify are OK ; OSS self-host OK only if a backend is being run for independent reasons. |
| **Anchor** | OWASP MASVS v2.x V6 Authorization + V7 Privacy + V8 Resilience (anti-tamper) + V9 Cryptography ; SWEBOK v4 KA3 Design (security) + KA13 Software Security ; ISO/IEC 25010:2023 Security (Authenticity, Integrity, Non-repudiation, Accountability, Resistance) + Reliability (Recoverability, Fault tolerance) ; ISO/IEC 25019 Data quality in use (integrity) ; Apple ASRG §3.1 + App Store Server API + App Store Server Notifications v2 ; Google Play Developer Program Policy — Billing + Subscriptions (acknowledgement, voided purchases, Real-time Developer Notifications) ; ISO/IEC 29110-4-3 VSE. |

## Candidates discovered (G-1 archetype classes)

| # | Candidate | Class | Backend required | Budget-strict status | Offline-first compat |
|---|-----------|-------|:----------------:|:--------------------:|:--------------------:|
| 1 | **StoreKit 2 local JWS verify + Play Billing local signature + local persist via C15** | (a) client-only, **platform-native at MVP** | No | **OK — platform-mandatory** | Yes (fully offline) |
| 2 | Dev-owned backend calling App Store Server API + Play Developer API, canonical entitlement, signed token returned | (b) server-authoritative | Yes (OSS self-host required under budget-strict) | OK only if OSS self-host already committed | Partial (reconciliation latency) |
| 3 | Hybrid signed-cache (backend validates + signs token + client caches for offline) | (c) hybrid | Yes | OK only if self-host | Yes (offline on cached signed token) |
| 4 | RevenueCat / Adapty SaaS orchestrator | (d) SaaS | No (SaaS) | **REJECTED — paid + free-tier SaaS both excluded by budget policy** | Yes |
| 5 | Iaptic (self-host validator) | (c) hybrid self-host | Yes | OK if self-host committed | Yes |
| 6 | No validation at all (trust the client) | Anti-pattern | No | OK budget-wise but violates ASRG §3 + Play Billing acknowledgement | Yes |

## Exclusions E1-E5

- **E1** (niveau 6) — individual blog posts claiming "I disabled validation and nothing bad happened" → excluded (unverifiable + anti-pattern).
- **E2** (obsolete >5y) — StoreKit 1 receipt-format tutorials + Play Billing v4/v5 verification flows → excluded (StoreKit 2 supersedes, Play Billing v6+ required post 2024-08).
- **E3** (language non-verifiable) — none at screening.
- **E4** (vendor marketing) — RevenueCat / Adapty white papers claiming "%X fraud reduction" → excluded (no independent methodology + budget-rejected class anyway).
- **E5** (no identifiable author) — anonymous forum threads on "how to bypass receipt validation" → excluded.

Additional budget-policy exclusion : SaaS-orchestrator candidates (RevenueCat, Adapty) are **excluded at scope level** by budget=open-source-strict. Retained in candidate table for reference only ; not evaluated in O-matrix.

## O-matrix (ordinal 1-5, higher=better)

| Candidate | O1 Forgery/replay resistance | O2 Offline-first availability | O3 Reconciliation correctness | O4 Solo-indie ops burden ↓ | O5 ASRG §3 + Play acknowledgement compliance | O6 Honest-user false-positive ↓ | O7 Budget-strict compat | Σ |
|-----------|:---------------------------:|:-----------------------------:|:-----------------------------:|:-------------------------:|:-------------------------------------------:|:-------------------------------:|:-----------------------:|:-:|
| **Client-only (StoreKit 2 JWS + Play Billing local)** | 4 | 5 | 4 | 5 | 4 | 5 | 5 | **32** |
| Server-authoritative (OSS self-host) | 5 | 3 | 5 | 1 | 5 | 4 | 3 | 26 |
| Hybrid signed-cache (OSS self-host) | 5 | 5 | 5 | 2 | 5 | 4 | 3 | 29 |
| SaaS (RevenueCat/Adapty) | 5 | 5 | 5 | 5 | 5 | 5 | **0 (excluded)** | — |
| No validation | 1 | 5 | 1 | 5 | 1 | 5 | 5 | 23 (disqualified — ASRG §3 gate fail) |

**Tie-break notes** :
- Client-only achieves O1=4 (not 5) because StoreKit 2 JWS verify is cryptographically strong but Play Billing local-signature verification has known bypass surfaces (rooted device ; re-signing attack) mitigated by Play Integrity API on Android — still short of server-authoritative call to Google Play Developer API.
- Hybrid signed-cache dominates server-authoritative on O2 offline-first (5 vs 3) but loses O4 solo-indie ops (2 vs 1 — both heavy but hybrid adds cache signing key management).

## Top-3 ranking

1. **Client-only StoreKit 2 JWS verify + Play Billing local signature** (Σ=32) — **MVP fit** : platform-native, no backend, offline-first preserved, budget-strict compatible. Play Integrity API layered as anti-tamper complement (MASVS V8) on Android ; iOS `Transaction.verificationResult` already JWS-signed by Apple.
2. **Hybrid signed-cache (OSS self-host)** (Σ=29) — **post-MVP scale-up path** if subscription is added or fraud rate observed exceeding indie-acceptable threshold. Requires OSS self-host commitment (e.g., a minimal validator + key rotation service) — do NOT stand this up pre-MVP.
3. **Server-authoritative (OSS self-host)** (Σ=26) — degraded offline-first ; retained only if subscription lifecycle requires authoritative state (unlikely under pilot `acres.md` MVP).

SaaS candidates excluded at scope level (budget-strict) ; "no validation" disqualified at ASRG §3 + Play Billing acknowledgement compliance gate.

## Kappa A vs B

**Tier agreement** : 4/4 valid classes (client-only top, hybrid #2, server-authoritative #3, SaaS excluded) = 100%. **Kappa brut ≈ 1.0** ("almost perfect").

**No principled divergence** — both reviewers converge on client-only at MVP under the triple constraint (open-source-strict budget + offline-first + solo-indie ops). Divergence was considered only on "when to upgrade to hybrid" — A says "add hybrid when first subscription SKU ships" ; B says "add hybrid when honest-user fraud-flag rate observed non-negligible". Both are compatible triggers, not conflicting.

## GRADE synthesis (no +convergence per instruction)

**Starting score** : 2 (pyramid L1 Apple App Store Server API docs + L1 StoreKit 2 spec + L1 Play Billing Library v7+ docs + L1 Google Play Developer API + L1 MASVS v2.x).

**Positive factors** :
- **+1 major evidence** : platform-native verification paths are definitional (StoreKit 2 JWS signature is cryptographically self-validating ; Play Billing local signature + Play Integrity are platform-documented). Not inference — direct spec.

**Negative factors** :
- **−1 indirectness** : "honest-user false-positive rate" is not empirically reported at indie scale ; inferred from platform documentation + indie postmortems (MG-2).
- **−1 publication bias** : IAP fraud postmortems skew toward successful titles ; silent failures (abandoned projects with fraud losses) under-represented.
- **−1 imprecision** : "%X fraud reduction" figures from SaaS vendor docs excluded (E4 + budget-policy) ; independent aggregate indie-scale fraud rates UNVERIFIED.

**Score final** : 2 + 1 − 3 = **0/7 → BONNE PRATIQUE floor** (raised to 1/7 on platform-spec deterministic mapping).

**Tier** : **BONNE PRATIQUE** — recommendation is MVP-conditional ; scale-up triggers documented.

## Sources extracted (Kitchenham Table 2)

| # | Source | Pyramid level | Year | Role |
|---|--------|:-------------:|:----:|------|
| 1 | Apple StoreKit 2 spec + `Transaction.verificationResult` JWS docs | L1 platform-primary | 2026 | Client-side verification authoritative |
| 2 | Apple App Store Server API + App Store Server Notifications v2 | L1 platform-primary | 2026 | Server-authoritative path reference (post-MVP) |
| 3 | Apple ASRG §3.1 (IAP, subscriptions, receipt validation, refund handling) | L1 platform-primary | 2026 | Compliance gate |
| 4 | Google Play Billing Library v7+ docs (local signature verify) | L1 platform-primary | 2026 | Client-side verification path Android |
| 5 | Google Play Developer API — `purchases.products.get` + `subscriptionsv2.get` | L1 platform-primary | 2026 | Server-authoritative path reference |
| 6 | Google Play Real-time Developer Notifications | L1 platform-primary | 2026 | Subscription-state push channel |
| 7 | Google Play Integrity API | L1 platform-primary | 2026 | MASVS V8 anti-tamper layer (Android) |
| 8 | Google Play Developer Program Policy — Billing + Subscriptions (acknowledgement, voided purchases) | L1 platform-primary | 2026 | Compliance gate |
| 9 | OWASP MASVS v2.x V6 Authorization + V8 Resilience + V9 Cryptography | L1 consortium | 2024 | Threat-model anchor |
| 10 | ISO/IEC 25010:2023 Security + Reliability sub-characteristics | L1 standard | 2023 | Outcome mapping |
| 11 | ISO/IEC 29110-4-3 VSE | L1 standard | 2023 | Solo-indie ops envelope |
| 12 | Indie IAP fraud postmortems (MG-2 grey-lit, triangulated) | L5 | 2022-2026 | Indie-scale fraud anecdote base |

## Verification Agent C (Phase 2.5, 2026-04-21)

**Claim verified** : StoreKit 2 `Transaction.verificationResult` returns a JWS signed by Apple — local verification is cryptographically valid without a backend — **PASS**.
**Claim verified** : Play Billing Library v7+ local signature verification is platform-documented AND Play Integrity API complements MASVS V8 anti-tamper on Android — **PASS**.
**Claim verified** : Budget=open-source-strict rejects RevenueCat / Adapty (SaaS-tier, even free tier) ; platform-native verification is OK class — **PASS**.
**Claim verified** : Pilot `acres.md` MVP scope does not include auto-renewable subscriptions → server-authoritative path not required at MVP — **PASS**.
**Impact on ranking** : None — client-only retained at top with hybrid signed-cache flagged as post-MVP scale-up path.

## Decision

**Primary recommendation for pilot P (MVP)** : **Client-only receipt validation** :
- iOS : `Transaction.verificationResult` JWS verification via StoreKit 2, sandbox-tested via `.storekit` configuration files.
- Android : Play Billing Library v7+ `BillingClient` local signature verification + Play Integrity API attestation layered as MASVS V8 anti-tamper complement.
- Entitlement persisted via C15 save layer as opaque signed blob ; C15 provides atomic writes + schema migration + cloud-save reconciliation.
- IAP restore flow wired per ASRG §3.1.1 mandatory via `Transaction.currentEntitlements` (iOS) + `queryPurchasesAsync` (Android).
- Play Billing `acknowledgePurchase` called within 3 days of purchase per policy.

**Runner-up / scale-up path (post-MVP)** : **Hybrid signed-cache with OSS self-host validator** — triggered if (a) auto-renewable subscription SKU added, or (b) observed honest-user fraud-flag rate exceeds indie-acceptable threshold, or (c) Play Developer API / App Store Server API lookup becomes required for refund reconciliation at scale.

**Rejected** :
- **SaaS orchestrators (RevenueCat, Adapty)** — budget=open-source-strict excludes both paid tier and free tier.
- **No validation** — violates ASRG §3 + Play Billing acknowledgement clause.
- **Server-authoritative at MVP** — no OSS self-host backend stood up at MVP scale ; premature infrastructure.

**Cross-link C15** : E25 produces signed entitlement blob ; C15 stores it (atomic write + integrity HMAC). Defence-in-depth : C15 client-side save integrity + E25 entitlement semantics. Phase 2.5 synthesis treats C15+E25 jointly.

**Cross-link E23** : E23 delivers the receipt from the IAP flow (godot-iap/OpenIAP under pilot P Godot engine) ; E25 validates the receipt + persists the entitlement semantics. Scope boundary explicit.

**Cross-link D20** : Client-only validation keeps purchase metadata off dev-owned servers → Privacy Manifest declarations remain minimal (no custom backend data-flow entry required at MVP).

**Traceability** : `verification/picoc/mobile-game-picoc-batch-E.md` §E25 + `verification/synthesis/mobile-game-phase2-synthesis.md` row E25 + Agent C Phase 2.5 platform-spec confirmation.
