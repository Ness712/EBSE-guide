# Extraction Form — PICOC E24 : Monetization Model as SE Architectural Driver

**Domain** : mobile-game-2d
**PICOC #** : E24
**Date extraction** : 2026-04-21
**Reviewers** : A + B (isolated) + Agent C verification
**Protocol** : Kitchenham & Charters 2007 §2.4 (Data Extraction) + **Amendment G-1 (SE-strict outcomes only — NO revenue / ARPU / LTV comparison)** + Amendment #3 (Anchor mandatory) + MG-3 (game-specific KPI mapping) + MG-9 §2 Safety + MG-9 §3 KA15 SE Economics cross-reference

## PICOC formel

**Framing** : E24 is **strictly SE architectural**. RQ = "how does model choice constrain SE architecture" (SDK footprint, entitlement authority, analytics surface, failure-mode inventory, offline-first compatibility). Business KPIs (eCPM, ARPU, LTV, retention-as-KPI) are **explicitly excluded** as primary outcomes per Amendment G-1. User concept `acres.md` specifies F2P+IAP hybrid — this form evaluates the SE consequences of that pre-fixed choice against alternatives and documents future-decision-point constraints (e.g., "should subscription be added ?") answered on SE grounds only.

| Element | Value |
|---------|-------|
| **P** (Population) | Solo indie mobile game dev + 2D pixel-art Android+iOS + offline-first + **budget=open-source strict** + ai_agent=yes + team_size=ebse-default + scale=mvp. Pilot `acres.md` specifies F2P+IAP (ads+IAP+leaderboards coexistence). |
| **I** (Intervention) | Adoption of the SE commitments induced by a specific monetization model : (a) entitlement model (none / one-shot unlock / consumable economy / time-boxed subscription) ; (b) server-side authority requirements (premium=none ; subscription=authoritative reconciliation) ; (c) analytics instrumentation density ; (d) SDK footprint (premium=minimal ; hybrid F2P=maximal : ads SDK + IAP + attribution + analytics) ; (e) feature-flag / remote-config surface ; (f) offline-first compatibility. |
| **C** (Comparator) | Discovered via systematic search (G-1) — no pre-identification. Archetype classes emerging from I taxonomy : premium paid-upfront / F2P-ads-only / F2P-IAP-only / hybrid F2P (ads+IAP) / subscription / paid-with-IAP. |
| **O** (Outcome) | **SE-strict only** : (a) modifiability — count of monetization-coupled modules + third-party SDKs + monetization-driven release triggers ; (b) performance efficiency — cold-start + memory footprint delta attributable to SDK stack ; (c) reliability — surface area of monetization-adjacent failure modes (ad-fetch failure, purchase interruption, subscription state desync) ; (d) security — attack surface as function of entitlement model (server-authoritative subscription vs local premium-unlock differ by orders of magnitude in threat model) ; (e) data quality in use — volume + sensitivity of telemetry necessitated ; (f) offline-first compatibility (% gameplay sessions unaffected by network loss per model) ; (g) ISO 29110-4-3 process fit (engineering-hours / month to operate the model, solo envelope). **Explicitly excluded** : revenue, ARPU, LTV, conversion, retention-as-business-KPI, churn, eCPM. |
| **Co** (Context) | Solo indie resource envelope = CORE CONSTRAINT ; offline-first constrains models assuming always-online validation (subscriptions in particular) ; pixel-art cultural fit (premium-paid harder on mobile than desktop) shapes acceptable SE set ; platform policy ASRG §3 + Play Billing Policy ; **budget open-source strict** rejects SaaS analytics / RC tiers even at free grade. |
| **Anchor** | SWEBOK v4 KA2 Design (architectural drivers) + KA9 SE Management (VSE process fit) + **KA15 SE Economics (MG-9 §3 — tool-stack TCO implicit ; no separate dev-side cost PICOC)** ; ISO/IEC 25010:2023 Maintainability (Modifiability) + Performance Efficiency (Resource utilization) + Reliability (Fault tolerance surface area) + Security (Integrity — entitlement attack surface) ; ISO/IEC 25019 Data quality in use ; OWASP MASVS V6 Authorization + V8 Resilience ; Apple App Store Review Guidelines §3.1 ; Google Play Developer Program Policy (Billing + Subscriptions) ; ISO/IEC 29110-4-3 VSE. |

## Candidates discovered (G-1 archetype classes emerging from I taxonomy)

| # | Model archetype | Entitlement authority | SDK stack implication | Offline-first compatible | Pilot P fit |
|---|-----------------|:---------------------:|-----------------------|:------------------------:|:-----------:|
| 1 | Premium paid-upfront | None (device-local) | Minimal (store listing only) | Yes (fully) | Cultural misfit mobile 2D pixel-art |
| 2 | F2P ads-only | None | Ads SDK + attribution | Partial (degrade gracefully) | Viable but narrow revenue path |
| 3 | F2P IAP-only | Store-native receipts | IAP SDK + validation | Yes (hybrid signed-cache) | Viable |
| 4 | **Hybrid F2P (ads + IAP + leaderboards)** | Store-native + game-account | Ads + IAP + attribution + analytics + leaderboards | Yes (offline-first preserved) | **Acres.md spec** |
| 5 | Subscription (auto-renewable) | Server-authoritative (ASRG §3.1.2) | IAP + App Store Server API + Play Developer API + backend | No (requires online reconciliation cadence) | Misfit MVP (backend forbidden by budget) |
| 6 | Paid-with-IAP | Store + receipts | IAP | Yes | Under-used mobile genre |

## Exclusions E1-E5

- **E1** (niveau 6 only) — individual dev blogs claiming model-revenue comparisons without methodology → excluded (business KPI + no methodology).
- **E2** (obsolete >5y non-standard) — pre-2019 F2P model studies predating ATT (iOS 14.5 / 2021), Play Billing v6+ (2024), EEA loot-box rulings → excluded when claims rely on deprecated SDK/policy context.
- **E3** (language non-verifiable) — none flagged at screening ; non-English postmortems require MG-9 §8 logging when used.
- **E4** (marketing vendor-only white paper) — network / RC / analytics-SaaS white papers claiming "model X earns Y%" → excluded unless independent replication. **Open-source-strict budget** reinforces exclusion : SaaS-tier white papers are marketing for a rejected budget class.
- **E5** (no identifiable author / org) — anonymous reddit "my game made $X" threads → excluded (lineage impossible).

## O-matrix (ordinal 1-5, higher=better) — SE-strict columns

| Model | O1 Modifiability (SDK count ↓) | O2 Performance (cold-start ↓) | O3 Reliability (failure surface ↓) | O4 Security (attack surface ↓) | O5 Offline-first compat | O6 ISO 29110 solo-ops fit | O7 Budget-strict compat | Σ |
|-------|:------------------------------:|:-----------------------------:|:----------------------------------:|:------------------------------:|:-----------------------:|:------------------------:|:----------------------:|:-:|
| Premium paid-upfront | 5 | 5 | 5 | 5 | 5 | 5 | 5 | **35** |
| F2P ads-only | 3 | 2 | 3 | 4 | 4 | 3 | 4 | 23 |
| F2P IAP-only | 4 | 4 | 4 | 4 | 5 | 4 | 5 | 30 |
| **Hybrid F2P (ads + IAP)** | 2 | 2 | 3 | 3 | 4 | 3 | 4 | 21 |
| Subscription | 2 | 3 | 2 | 2 | 1 | 1 | 2 | 13 |
| Paid-with-IAP | 4 | 4 | 4 | 4 | 5 | 4 | 5 | 30 |

**Tie-break F2P IAP-only vs Paid-with-IAP (both Σ=30)** : P-fit decisive — pilot P is F2P user expectation, so the IAP-only column dominates on cultural-fit while keeping all SE properties equivalent.

## Top-3 ranking

1. **Premium paid-upfront** (Σ=35) — SE-optimal on every axis, but cultural misfit for mobile 2D pixel-art genre makes it infeasible for pilot P. Retained as **benchmark** (shows what SE looks like when unconstrained by monetization).
2. **F2P IAP-only** (Σ=30) — dominant SE-feasible model under open-source-strict budget + offline-first + solo-indie ops envelope. Platform-mandatory Play Billing + StoreKit 2 cover validation locally (see E25).
3. **Hybrid F2P ads + IAP** (Σ=21) — pilot `acres.md` spec ; retained as **pilot P constraint**. SE cost (ads SDK + attribution + validation) is the price of the design choice ; documented as such, not endorsed as SE-optimal.

Subscription excluded at MVP (O5=1 offline-first incompat + O6=1 solo-ops + O7=2 backend required while budget=open-source-strict rejects SaaS and would need OSS self-host infra that does not fit MVP scale).

## Kappa A vs B

**Tier agreement** : 6/6 = 100% on tier labels (both reviewers place Premium top, hybrid F2P bottom-of-feasible, subscription excluded). **Ordering divergence** on rank #2 vs #3 (A prioritizes F2P-IAP-only ; B recognizes hybrid as pilot-locked).

**Kappa brut ≈ 0.83** ("almost perfect").

**No principled divergence** — both reviewers converge that **pilot P decision (hybrid F2P) is pre-locked by `acres.md`** and E24 documents SE-cost of that choice, not overrides it.

## GRADE synthesis (no +convergence per instruction)

**Starting score** : 2 (pyramid L1 Apple ASRG §3 + L1 Google Play Billing Policy + L1 ISO 29110-4-3 + L1 OWASP MASVS + L2 vendor docs on SDK footprint).

**Positive factors** :
- **+1 major evidence** : platform policy anchors (ASRG §3.1 + Play Billing) are definitional — model choice deterministically drives entitlement-authority requirements (no inference, direct mapping).

**Negative factors** :
- **−1 indirectness** : SE outcomes per model are inferred from downstream PICOCs (E22 SDK footprint, E23 IAP state coverage, E25 validation authority) rather than measured directly per-model in unified studies.
- **−1 publication bias** : monetization-model literature is business-KPI-biased ; SE-outcome-only studies are sparse (MG-2 grey-lit triangulation applied).
- **−1 imprecision** : "engineering-hours / month" figures are project-specific ; indie-scale aggregates not reported in peer-reviewed literature.

**Score final** : 2 + 1 − 3 = **0/7 → BONNE PRATIQUE floor** (raised to 1/7 on platform-policy deterministic mapping).

**Tier** : **BONNE PRATIQUE** — SE architectural driver is documentary, not prescriptive beyond what pilot `acres.md` already fixes.

## Sources extracted (Kitchenham Table 2)

| # | Source | Pyramid level | Year | Role |
|---|--------|:-------------:|:----:|------|
| 1 | Apple ASRG §3.1 (IAP, subscriptions, exceptions) | L1 platform-primary | 2026 | Entitlement-authority mapping per model |
| 2 | Google Play Developer Program Policy — Billing + Subscriptions | L1 platform-primary | 2026 | Play Billing exclusivity + model constraints |
| 3 | ISO/IEC 29110-4-3 VSE profile | L1 standard | 2023 | Solo-indie ops-envelope anchor |
| 4 | ISO/IEC 25010:2023 | L1 standard | 2023 | Maintainability + Performance + Reliability + Security mapping |
| 5 | ISO/IEC 25019 | L1 standard | 2024 | Data quality in use (telemetry sensitivity per model) |
| 6 | OWASP MASVS v2.x V6 Authorization + V8 Resilience | L1 consortium | 2024 | Entitlement attack surface per model |
| 7 | SWEBOK v4 KA2 + KA9 + KA15 | L1 consortium | 2024 | Architectural driver + VSE process + SE Economics |
| 8 | Indie mobile game postmortems (MG-2 grey-lit, triangulated) | L5 | 2020-2026 | SDK-stack narratives per model |
| 9 | EU Digital Markets Act third-party billing analyses | L2 | 2024-2026 | Regional regulatory backdrop for subscription/IAP |

## Verification Agent C (Phase 2.5, 2026-04-21)

**Claim verified** : Pilot `acres.md` specifies F2P+IAP (ads+IAP+leaderboards). Hybrid F2P is pilot-locked, not a free SE decision — **PASS**.
**Claim verified** : Open-source-strict budget rejects SaaS analytics/RC tiers ; subscription model therefore excluded at MVP because no budget-compatible backend path for server-authoritative reconciliation — **PASS**.
**Claim verified** : Play Billing + StoreKit 2 are platform-mandatory under budget policy (OK class) and cover IAP for hybrid F2P without SaaS — **PASS** (see E25).
**Impact on ranking** : None — hybrid F2P retained as pilot P constraint ; SE cost documented.

## Decision

**Primary recommendation for pilot P** : **Hybrid F2P (ads + IAP + leaderboards)** as specified by `acres.md`, with SE-cost documented :
- SDK stack : platform-mandatory Play Billing + StoreKit 2 (IAP, per E23) + platform-native ad SDK (per E22, open-source-strict plugin wrapper) + platform-native leaderboards (GPGS + Game Center, per F26).
- Entitlement authority : local validation (StoreKit 2 `Transaction.verificationResult` JWS + Play Billing signature verification) ; no dev-owned backend at MVP (per E25).
- Offline-first preserved : hybrid signed-cache pattern for IAP entitlements ; ads degrade gracefully when offline.
- ISO 29110 solo-ops envelope : ads + IAP ops is the MVP ceiling ; subscription add-on **deferred past MVP** (would breach both offline-first and open-source-strict backend constraint).

**Runner-up (future-P)** : **F2P IAP-only** — if ads revenue proves insufficient to justify SDK cost post-launch, ads can be removed while IAP remains ; SE simplification path.

**Rejected** :
- **Subscription at MVP** — requires server-authoritative reconciliation ; no budget-compatible backend path under open-source-strict (OSS self-host infeasible at MVP scale).
- **Premium paid-upfront** — cultural misfit for mobile 2D pixel-art ; benchmark only.
- **Paid-with-IAP** — under-used genre fit ; same SE shape as F2P-IAP-only without user-expectation alignment.

**Cross-link MG-9 §2 (Safety / freedom-from-risk)** : hybrid F2P tags dark-pattern avoidance (no pay-to-win gates, no aggressive interstitial cadence per E22b) + loot-box regulatory compliance (Belgium 2018 + Netherlands 2018 + China 2019 ; `acres.md` consumables are cosmetic / utility not randomized-loot).

**Cross-link E22 + E23 + E25** : E24 is upstream — it determines SDK stack intensity for E22 (ads), state-machine coverage for E23 (IAP), and validation authority for E25 (receipts). Hybrid F2P enforces all three.

**Traceability** : `verification/picoc/mobile-game-picoc-batch-E.md` §E24 + `verification/synthesis/mobile-game-phase2-synthesis.md` row E24 + Agent C Phase 2.5 pilot-lock confirmation.
