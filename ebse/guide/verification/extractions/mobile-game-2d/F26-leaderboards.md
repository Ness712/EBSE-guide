# Extraction Form — PICOC F26 : Social Gaming Services Backend (Leaderboards + Achievements Unified)

**Domain** : mobile-game-2d
**PICOC #** : F26
**Date extraction** : 2026-04-21
**Reviewers** : A + B (isolated) + Agent C verification
**Protocol** : Kitchenham & Charters 2007 §2.4 (Data Extraction) + Amendment G-1 + Amendment #3 + MG-6 (cross-PICOC tagging with C15 defence-in-depth + F28 authentication upstream)

## PICOC formel

**Merge note** : F27 (achievements) absorbed into F26 — same SDK, same backend, same authentication surface, same policy envelope (Apple ASRG §5.3 + Google Play Games Services Policy). Literature treats the pair as a single "social gaming services" bundle.

| Element | Value |
|---------|-------|
| **P** (Population) | Solo indie mobile 2D pixel-art portrait offline-first Android+iOS, distributed on Google Play + Apple App Store, monetised via ads + IAP, featuring score-ranked gameplay (leaderboards) and/or progression milestones (achievements) visible across the player base, cross-platform codebase. Solo-indie context (no dedicated backend engineer, no SRE). **Budget = open-source strict** ; **scale = MVP** ; ai_agent = yes. |
| **I** (Intervention) | Class of backend architectures for leaderboards + achievements. Archetype classes : (a) **platform-native** (Google Play Games Services v2 on Android + Apple Game Center on iOS — per-store isolated boards) ; (b) cross-platform BaaS (Firebase leaderboards, Nakama, LootLocker, GameAnalytics leaderboards — unified boards across stores) ; (c) self-hosted minimal (OSS on a dev-owned VPS) ; (d) hybrid (platform-native + custom aggregator). Axes : score-submission lifecycle (offline queue, idempotent submission keys, retry with exponential backoff, server dedup), server-side anti-cheat heuristics (plausibility bounds, rate throttling, outlier flagging), achievement unlock semantics (incremental progress, hidden achievements, idempotency across offline replay), cross-platform unification strategy, client-SDK integration pattern. |
| **C** (Comparator) | Discovered via systematic search (G-1) — no pre-identification. |
| **O** (Outcome) | (a) integration effort (person-days solo indie) ; (b) score submission success rate under intermittent connectivity (% within 24h) ; (c) duplicate-suppression correctness ; (d) cheater-induced leaderboard pollution rate (% top-N flagged) ; (e) SDK size / app-bundle impact (MB delta) ; (f) time-to-first-submission latency (ms) ; (g) SDK upgrade burden over 3-5 year indie lifespan ; (h) ongoing operational cost ($/month + maintenance hours) ; (i) cross-platform parity effort (LOC diff Android/iOS adapters) ; (j) achievement unlock idempotency under replay. **User-facing** : (k) leaderboard freshness perception ; (l) achievement unlock UI timing correctness. **Compliance** : (m) Apple ASRG §5.3 + Google Play Games Services Policy. |
| **Co** (Context) | Solo indie no dedicated backend expertise ; Android + iOS parity ; offline-first primary game loop + sporadic connectivity for score sync ; ads + IAP already integrated (networking + identity surface exists) ; leaderboards/achievements **optional engagement feature** (not core mechanic under `acres.md`) ; 2D portrait pixel-art = low ARPU + high price sensitivity on operational budget ; GDPR Art. 6 + Art. 17 apply to display names + account deletion ; **budget=open-source strict → Firebase free tier / Nakama Heroic Labs cloud REJECTED ; Nakama self-host only if OSS commitment made ; GPGS + Game Center OK as platform-mandatory**. |
| **Anchor** | SWEBOK v4 KA3 Design (component integration, architectural styles) + KA9 SE Management (third-party service selection) + KA13 Software Security ; ISO/IEC 25010:2023 Functional Suitability (Completeness) + Reliability (Availability, Fault tolerance) + Security (Integrity — anti-cheat) + Maintainability + Portability ; ISO/IEC 25019 Data quality in use (leaderboard entry accuracy) ; Apple ASRG §5.3 (Gaming Services rules, Game Center usage) ; Google Play Games Services Policy ; Google Play Developer Program Policy (account deletion) ; OWASP MASVS V5 Network + V8 Resilience (server-side, defence-in-depth with C15 client-side) ; ISO/IEC 29110-4-3 VSE ; GDPR Art. 6 + Art. 17. |

## Candidates discovered (G-1 archetype classes)

| # | Candidate | Class | Budget-strict status | Cross-store parity | Offline-queue support |
|---|-----------|-------|:--------------------:|:------------------:|:---------------------:|
| 1 | **Google Play Games Services v2 (Android) + Apple Game Center (iOS)** | (a) platform-native | **OK — platform-mandatory** | Per-store isolated (by design) | Partial (platform SDK handles retry) |
| 2 | Firebase Realtime Database / Firestore leaderboards | (b) BaaS SaaS | **REJECTED — free tier is SaaS** | Unified | Yes |
| 3 | Nakama (Heroic Labs cloud) | (b) BaaS SaaS | **REJECTED — SaaS** | Unified | Yes |
| 4 | **Nakama self-host OSS** | (c) OSS self-host | OK only if self-host already committed | Unified | Yes |
| 5 | LootLocker | (b) BaaS SaaS | **REJECTED — SaaS** | Unified | Yes |
| 6 | GameAnalytics leaderboards | (b) BaaS SaaS | **REJECTED — SaaS** | Unified | Yes |
| 7 | Hybrid (GPGS + GC for native UI + custom aggregator) | (d) hybrid | OK only if self-host aggregator | Unified | Yes |
| 8 | Custom minimal OSS on VPS | (c) self-host | OK only if self-host committed + scale permits | Unified | Yes (custom) |

## Exclusions E1-E5

- **E1** (niveau 6) — individual dev blogs with anecdotal "I wrote my own leaderboard in 2 hours" without schema / threat model → excluded.
- **E2** (obsolete >5y) — Google Play Games Services v1 tutorials (v2 supersedes since 2022), Game Center pre-iOS 14 patterns → excluded.
- **E3** (language non-verifiable) — none at screening.
- **E4** (vendor marketing) — Firebase / Nakama cloud / LootLocker white papers claiming "%X cheater reduction" without independent methodology → excluded ; also budget-rejected class.
- **E5** (no identifiable author) — anonymous forum claims on cheat rates → excluded.

Additional budget-policy exclusion : all SaaS BaaS candidates (Firebase free tier, Nakama cloud, LootLocker, GameAnalytics leaderboards) are **excluded at scope level** by budget=open-source-strict. Retained in candidate table for reference only ; not evaluated in O-matrix.

## O-matrix (ordinal 1-5, higher=better)

| Candidate | O1 Integration effort ↓ | O2 Submission success under intermittent | O3 Anti-cheat efficacy (server) | O4 SDK size ↓ | O5 Ops cost $/month ↓ | O6 ASRG §5.3 + Play GS policy compliance | O7 Budget-strict compat | Σ |
|-----------|:-----------------------:|:----------------------------------------:|:-------------------------------:|:-------------:|:---------------------:|:----------------------------------------:|:-----------------------:|:-:|
| **GPGS v2 + Game Center (platform-native)** | 5 | 4 | 3 (platform-level only) | 4 | 5 (free) | 5 | 5 | **31** |
| Nakama self-host OSS | 2 | 5 | 5 (custom heuristics) | 3 | 2 (VPS $) | 4 | 3 | 24 |
| Hybrid (GPGS+GC + OSS aggregator) | 1 | 5 | 5 | 3 | 2 | 4 | 3 | 23 |
| Custom minimal OSS | 1 | 4 | 3 | 4 | 2 | 4 | 3 | 21 |
| Firebase / Nakama cloud / LootLocker | 5 | 5 | 5 | 3 | 5 (free tier) | 5 | **0 (excluded)** | — |

**Tie-break notes** :
- GPGS+GC O3=3 because anti-cheat is platform-level only (no custom heuristics possible — must accept what Apple+Google provide).
- Nakama self-host O1=2 reflects the OSS infra commitment (docker-compose + postgres + monitoring) — real engineering-days cost.
- "Hybrid" loses integration effort (O1=1) without decisive gains elsewhere at MVP.

## Top-3 ranking

1. **Platform-native GPGS v2 (Android) + Apple Game Center (iOS)** (Σ=31) — **MVP fit** : platform-mandatory and OK under budget policy ; zero ongoing cost ; native UI handles signed-in player scoreboards ; per-store isolated leaderboards are an accepted design constraint at MVP (most indie titles ship this way).
2. **Nakama self-host OSS** (Σ=24) — **only if unified cross-platform leaderboards are required and OSS self-host commitment made**. Scale ≥ post-MVP ; adds docker-compose + postgres + monitoring to solo-indie ops envelope.
3. **Custom minimal OSS aggregator** (Σ=21) — deferred ; only considered if Nakama footprint proves excessive and a minimal score-submission HTTP endpoint with SQLite suffices. Not recommended at MVP.

SaaS BaaS candidates (Firebase, Nakama cloud, LootLocker, GameAnalytics) excluded at scope level by budget=open-source-strict.

## Kappa A vs B

**Tier agreement** : 4/4 valid classes = 100%. **Kappa brut ≈ 1.0** ("almost perfect").

**No principled divergence** — both reviewers converge that platform-native GPGS + Game Center is the MVP answer under the budget constraint. Unified cross-platform leaderboard is a "nice to have" that does not justify OSS self-host infra at MVP. Divergence was considered only on "when to add Nakama self-host" — A says "only if a tournament / seasonal event feature is added" ; B says "only if cross-platform leaderboard parity becomes a user-demanded feature". Both triggers are compatible.

## GRADE synthesis (no +convergence per instruction)

**Starting score** : 2 (pyramid L1 Google Play Games Services v2 docs + L1 Apple Game Center + GameKit docs + L1 Apple ASRG §5.3 + L1 Google Play Games Services Policy).

**Positive factors** :
- **+1 major evidence** : platform-native GPGS + Game Center is deterministically compliant with ASRG §5.3 and Play Games Services Policy (no inference — direct spec).

**Negative factors** :
- **−1 indirectness** : "cheater-induced pollution rate" is not reported at indie scale in peer-reviewed literature ; inferred from GDC postmortems (MG-2 grey-lit).
- **−1 publication bias** : leaderboard postmortems overrepresent successful titles ; games that got overwhelmed by cheaters and silently abandoned leaderboards are under-reported.
- **−1 imprecision** : aggregate "time-to-first-submission latency" metrics for GPGS + Game Center are not published ; per-region variance is substantial.

**Score final** : 2 + 1 − 3 = **0/7 → BONNE PRATIQUE floor** (raised to 1/7 on platform-spec deterministic mapping).

**Tier** : **BONNE PRATIQUE** — MVP recommendation is platform-native ; scale-up triggers documented.

## Sources extracted (Kitchenham Table 2)

| # | Source | Pyramid level | Year | Role |
|---|--------|:-------------:|:----:|------|
| 1 | Google Play Games Services v2 official docs | L1 platform-primary | 2026 | Android leaderboards + achievements API |
| 2 | Apple GameKit + Game Center Connect docs | L1 platform-primary | 2026 | iOS leaderboards + achievements API |
| 3 | Apple ASRG §5.3 (Gaming Services) | L1 platform-primary | 2026 | Compliance gate |
| 4 | Google Play Games Services Policy | L1 platform-primary | 2026 | Score integrity + attribution |
| 5 | Google Play Developer Program Policy — account deletion | L1 platform-primary | 2026 | GDPR Art. 17 cascade |
| 6 | OWASP MASVS v2.x V5 Network + V8 Resilience (server-side) | L1 consortium | 2024 | Anti-cheat threat model |
| 7 | ISO/IEC 25010:2023 + ISO/IEC 25019 | L1 standard | 2023-2024 | Outcome mapping |
| 8 | ISO/IEC 29110-4-3 VSE | L1 standard | 2023 | Solo-indie deployment anchor |
| 9 | GDPR Art. 6 + Art. 17 | L1 regulatory | 2016 (in force) | Lawful basis + erasure |
| 10 | Nakama OSS self-host docs (Heroic Labs GitHub) | L2 | 2024-2026 | Reference for OSS self-host path |
| 11 | Indie leaderboard postmortems (MG-2 grey-lit, triangulated) | L5 | 2020-2026 | Indie-scale cheater narrative |

## Verification Agent C (Phase 2.5, 2026-04-21)

**Claim verified** : GPGS v2 + Game Center are **platform-mandatory classification** under budget=open-source-strict (leaderboard platforms treated as platform-mandatory alongside Play Billing + StoreKit) — **PASS**.
**Claim verified** : Firebase leaderboards free tier is SaaS → rejected by budget policy — **PASS**.
**Claim verified** : Nakama cloud (Heroic Labs) is SaaS → rejected ; Nakama self-host OSS is OK but only if self-host committed — **PASS**.
**Claim verified** : Per-store isolated boards (one on GPGS + one on Game Center) are an accepted MVP design under `acres.md` — cross-platform unification is not a user requirement at MVP — **PASS**.
**Impact on ranking** : None — platform-native retained at top.

## Decision

**Primary recommendation for pilot P (MVP)** : **Platform-native GPGS v2 (Android) + Apple Game Center (iOS)** :
- Android : Google Play Games Services v2 via Godot plugin (OSS, e.g., `godot-play-game-services` or equivalent platform-mandatory wrapper) — leaderboards + achievements + sign-in UI.
- iOS : Apple GameKit via GDExtension wrapper — `GKLeaderboard` + `GKAchievement` + `GKLocalPlayer` authentication.
- Per-store isolated boards accepted as MVP design constraint (documented).
- Offline queue implemented at client level : score-submission payloads held in a local pending-queue, flushed on connectivity return with idempotent submission keys (client-generated UUID + server-side dedup on platform side).
- Anti-cheat relies on platform-level plausibility (GPGS has score submission throttling ; Game Center validates via Apple ID) + C15 client-side save integrity HMAC as defence-in-depth.

**Runner-up / scale-up path (post-MVP)** : **Nakama self-host OSS** — triggered only if (a) cross-platform unified leaderboard becomes a user-demanded feature, or (b) seasonal/tournament event mechanics require server-authoritative state, or (c) observed cheater pollution on platform-native boards exceeds acceptable threshold. Requires docker-compose + postgres + monitoring commitment.

**Rejected** :
- **Firebase leaderboards (free tier)** — SaaS, excluded by budget=open-source-strict.
- **Nakama cloud (Heroic Labs)** — SaaS, excluded.
- **LootLocker, GameAnalytics leaderboards** — SaaS, excluded.
- **Custom minimal OSS at MVP** — premature infra ; does not outperform GPGS + GC.

**Cross-link C15** (defence-in-depth) : F26 server-side anti-cheat (platform-level at MVP) + C15 client-side save integrity HMAC form a defence-in-depth pair. Phase 2.5 synthesis treats F26+C15 jointly.

**Cross-link F28** (authentication upstream) : score submission requires platform gaming identity (Game Center player ID on iOS, GPGS player ID on Android). F28 decision on identity strategy feeds into F26 binding. Critical distinction : game account (F28) ≠ store account (Apple ID / Google account used for E23/E25 IAP restore).

**Cross-link D20** : leaderboard display names = personal data ; Privacy Manifest declaration required. GPGS + GC are platform-native so declaration is simplified vs adding a third-party BaaS SDK.

**Traceability** : `verification/picoc/mobile-game-picoc-batch-F.md` §F26 + `verification/synthesis/mobile-game-phase2-synthesis.md` row F26 + Agent C Phase 2.5 budget-policy classification.
