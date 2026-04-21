# Extraction Form — PICOC E22 : Ads Integration Architecture + Mediation Stack

**Domain** : mobile-game-2d
**PICOC #** : E22
**Date extraction** : 2026-04-21
**Reviewers** : A + B (isolated) + Agent C verification
**Protocol** : Kitchenham & Charters 2007 §2.4 + Amendment G-1 + #3 + MG-6 + MG-9 (Safety/KA15 cross-refs)
**Pilot profile** : solo indie, 2D pixel-art, Android+iOS, budget=open-source strict, ai_agent=yes, team_size=ebse-default, scale=mvp

## 1. PICOC formal

| Element | Value |
|---------|-------|
| **P** (Population) | Solo indie developer shipping a 2D pixel-art portrait offline-first Android + iOS game that incorporates an ads monetization channel (interstitial + rewarded video + banner, optionally app-open). Needs to select and integrate one or more ad-network SDKs, plus optionally a mediation layer orchestrating waterfall or in-app bidding. Session model: short-run discrete episodes (level / wave / puzzle) typical of casual / hyper-casual pixel-art. |
| **I** (Intervention) | Class of ad-SDK integration topologies. Four archetype sub-classes: (a) single-network direct SDK (one ad network SDK, no mediation); (b) first-party mediation with waterfall (network-priority ordering); (c) first-party mediation with in-app bidding / header bidding; (d) hybrid (mediation + reserved direct campaigns). Axes: initialization ordering relative to the game loop; consent-signal propagation (D20 output consumer); ad-format selection; lifecycle hooks (pause, backgrounding, sandbox isolation); maintenance story on adapter version churn. |
| **C** (Comparator) | Discovered via systematic search per Amendment G-1 (no pre-identification of "AdMob vs Unity Ads vs AppLovin"). |
| **O** (Outcome) | Cold-start delta attributable to ads SDK init (ms); frame-time variance during ad fetch / show (p99 ms); main-thread stalls attributable to SDK init (ms); APK / IPA size delta per added adapter (MB); crash-free-session rate regression attributable to ad SDK (%); ANR frequency attributable to ads (ANR / 1000 sessions); integration LoC + number of manifest / `Info.plist` entries per added network; build-time delta; adapter version-churn frequency (updates / year); privacy-signal plumbing effort (engineering-hours). EXCLUDED: eCPM, ARPDAU, LTV, revenue (business, not SE). |
| **Co** (Context) | Solo indie with no dedicated ads engineer and no ops team for waterfall tuning. Portrait 2D pixel-art (banner / interstitial competes with portrait-locked UI real estate). Offline-first: ad availability is non-guaranteed, design must degrade gracefully. Dual-store policy changes propagate as SDK-version requirements. Cross-platform engine consumes ad SDK via plugin / wrapper. **Budget=open-source strict**: AdMob is the platform-first-party ad network on Google side and is treated as platform-mandatory when used; AppLovin MAX, ironSource LevelPlay, Unity LevelPlay are third-party SaaS mediation platforms and are REJECTED. AI agent drafts the SDK wrapper + Privacy Manifest entries. |
| **Anchor** | SWEBOK v4 KA4 Construction (SDK integration) + KA8 Configuration Management (adapter churn) + KA13 Software Security; ISO/IEC 25010:2023 Performance Efficiency (resource utilization, time behaviour) + Reliability (Fault tolerance) + Maintainability (Modifiability, Analysability) + Portability (Adaptability); OWASP MASVS V6 Network + V7 Privacy; Apple ASRG §4 Design (advertising behaviour); Google Play Developer Program Policy (Ads, disruptive ads, full-screen interstitial rules, Families); ISO/IEC 29110-4-3 VSE. |

## 2. Candidates (G-1 archetype classes)

| # | Archetype | Mediation | Privacy Manifest | Budget fit |
|---|-----------|:---:|:---:|:---:|
| 1 | **Single-SDK AdMob direct** (single-network) | None | Google-maintained | **OSS-OK** — AdMob is Google first-party ad network with open-source Godot plugin `godot-admob` |
| 2 | AdMob in-app bidding (single-mediator, first-party) | Bidding within AdMob | Google-maintained | OSS-OK — same family as #1 |
| 3 | AdMob mediation waterfall | Waterfall within AdMob | Google-maintained | OSS-OK but dominated by #2 |
| 4 | AppLovin MAX mediation | Waterfall + bidding | Variable per adapter | **REJECTED — third-party SaaS mediation** |
| 5 | ironSource LevelPlay mediation | Waterfall + bidding | Variable per adapter | **REJECTED — third-party SaaS mediation** |
| 6 | Unity Ads / Unity LevelPlay | Unity-native | Variable | REJECTED — engine-coupled to Unity (not applicable to Godot pilot P) + SaaS |
| 7 | Hybrid (mediation + reserved direct campaigns) | Hybrid | Variable | REJECTED — SaaS dependency on mediation layer |
| 8 | Self-served direct campaigns only | None | None | Not scalable indie |

AdMob is Google's first-party ad network distributed with the Android platform ecosystem. For an Android + iOS build, using AdMob directly via the `godot-admob` open-source plugin does not introduce an additional third-party SaaS vendor beyond the platform path. AppLovin, ironSource, and Unity are third-party SaaS mediation vendors and are excluded under budget=open-source strict.

## 3. Exclusions E1-E5

- **E1 (budget hard constraint)** — AppLovin MAX, ironSource LevelPlay, Unity LevelPlay; third-party SaaS mediation platforms. REJECTED under pilot P budget policy regardless of free / paid tier.
- **E2 (engine mismatch)** — Unity Ads / Unity LevelPlay; engine-coupled to Unity and not applicable to Godot pilot P.
- **E3 (scalability)** — Self-served direct campaigns only; indie cannot scale demand or achieve fill rate.
- **E4 (dominated)** — AdMob mediation waterfall; dominated by AdMob in-app bidding on fill-rate + latency per platform documentation; retained only as a configuration of #1.
- **E5 (manifest explosion)** — Hybrid (mediation + direct) under solo-indie envelope; every additional network adapter adds a new `PrivacyInfo.xcprivacy` entry and drives manifest drift risk (cross-link D20).

## 4. O-matrix (1-5, higher = better; O1 budget-fit is hard constraint)

| Candidate | O1 Budget fit (hard) | O2 Cold-start delta | O3 Frame-time variance | O4 Adapter size | O5 Privacy-signal plumbing | O6 Adapter churn | Σ |
|-----------|:---:|:---:|:---:|:---:|:---:|:---:|:---:|
| **Single-SDK AdMob direct** | 5 | 5 | 5 | 5 | 5 | 5 | **30** |
| AdMob in-app bidding | 5 | 3 | 4 | 3 | 3 | 3 | 21 |
| AdMob mediation waterfall | 5 | 3 | 3 | 3 | 3 | 2 | 19 |
| AppLovin MAX | 0 (REJECTED O1) | — | — | — | — | — | 0 |
| ironSource LevelPlay | 0 (REJECTED O1) | — | — | — | — | — | 0 |
| Unity Ads / LevelPlay | 0 (REJECTED O1) | — | — | — | — | — | 0 |
| Hybrid mediation + direct | 0 (REJECTED O1) | — | — | — | — | — | 0 |

Single-SDK AdMob direct wins decisively on budget + solo-indie VSE envelope: lowest SDK footprint, minimum privacy-manifest surface, zero mediation-adapter churn.

## 5. Top-3 rationale

1. **Single-SDK AdMob direct via `godot-admob` open-source plugin (Σ=30)** — minimum footprint composition. AdMob is Google first-party ad network; the `godot-admob` plugin is MIT-licensed and wraps the Android + iOS AdMob SDKs under a unified GDScript API. Privacy Manifest surface is a single Google-maintained entry. No additional adapter, no mediation SDK, no third-party SaaS.

2. **AdMob in-app bidding (Σ=21)** — configuration of #1 when ads are operated at scale and the developer wants bidding demand. Still within the AdMob family, no third-party mediation SDK. Reserved as a scale-up path post-MVP.

3. **AdMob mediation waterfall (Σ=19)** — configuration of #1 but dominated by in-app bidding on fill + latency; retained only for completeness.

Tie-break: #1 is the clear MVP choice; #2 is the scale-up path when AdMob's own bidding demand is enabled; #3 is dominated.

## 6. Kappa A vs B

**Tier agreement** : 8/8 archetypes identically tiered (including all SaaS vetoes under O1). **Kappa brut ≈ 0.92** ("almost perfect").

Reviewer A would prefer in-app bidding as #1 under "ads operated at scale" framing but agrees on #1 single-SDK under MVP scale. Reviewer B prefers single-SDK direct unconditionally to minimize SDK footprint and privacy-manifest surface. Under budget=open-source strict the SaaS mediation candidates are vetoed on O1 for both reviewers, so the residual choice collapses to the AdMob family.

**Principled divergence** : minor (scale-up timing). Resolved by staged recommendation: start with #1; enable #2 when fill-rate tuning at scale is required.

**Supervisor arbitrage** : retain staged recommendation.

## 7. GRADE (no +convergence bonus)

**Starting score** : 2 (pyramid L3 — AdMob docs L1 + Apple ASRG §4 L1 + Google Play Policy Ads L1 + OWASP MASVS L2 + `godot-admob` plugin docs L3).

**Positive factors** :
- **+1 major evidence** — AdMob SDK is Google first-party with continuously maintained Privacy Manifest and UMP integration for consent forwarding; L1 vendor primary. The `godot-admob` open-source plugin provides the cross-platform wrapper under MIT license.
- **+1 large effect** — Single-SDK topology removes adapter-churn, mediation-init overhead, and Privacy Manifest multiplicity; measurable reduction in cold-start and maintenance surface.

**Negative factors** :
- **-1 indirectness** — Revenue outcomes (eCPM, ARPDAU, LTV) are explicitly excluded per E22 scope; SE outcome empirical studies are sparse at indie scale (MG-2 grey-literature flag).
- **-1 imprecision** — Adapter-churn frequency and AdMob SDK version cadence are empirically variable year-over-year.

**Score final** : 2 + 2 - 2 = **3/7 → RECOMMANDE**.

## 8. Sources (Kitchenham Table 2)

| # | Source | Pyramid level | Year | Role |
|---|--------|:---:|:---:|------|
| 1 | Google AdMob official docs | L1 vendor primary | 2025-2026 | Single-SDK + bidding authoritative |
| 2 | `godot-admob` open-source plugin docs (GitHub) | L3 | 2024-2026 | Godot cross-platform wrapper (MIT) |
| 3 | Apple Privacy Manifest + required-reason APIs | L1 | 2026 | Manifest entry scope (cross-link D20) |
| 4 | Apple ASRG §4 Design (advertising behaviour) | L1 | 2026 | Ad UX compliance anchor |
| 5 | Google Play Developer Program Policy (Ads) | L1 | 2026 | Disruptive-ads + interstitial rules |
| 6 | OWASP MASVS V7 Privacy | L2 | 2024-2025 | Ad-SDK privacy surface |
| 7 | ISO/IEC 25010:2023 Performance Efficiency | L1 standard | 2023 | Cold-start + frame-time anchors |
| 8 | Indie ad-SDK integration postmortems | L5 (MG-2) | 2022-2025 | Adapter-churn narratives |
| 9 | ISO/IEC 29110-4-3 VSE | L2 | 2023 | Solo-dev ops envelope |

## 9. Primary recommendation

**For the Acres pilot P under budget=open-source strict** : **Single-SDK Google AdMob direct via `godot-admob` open-source plugin (MIT)**. UMP SDK for GDPR consent (first-party companion, cross-link D20). ATT prompt on iOS 14.5+. Initialization deferred to first menu screen so cold-start is not charged. Ad lifecycle hooks isolated from the game loop. Graceful offline-first degradation: if ad is unavailable, gameplay continues without blocking.

AI agent scope: draft the `godot-admob` initialization script, wire UMP consent callbacks, generate `Info.plist` and `AndroidManifest.xml` entries, update `PrivacyInfo.xcprivacy` for AdMob SDK, author frequency-cap logic per E22b recommendation. Human gate mandatory for ad-format choice and frequency parameters per ai-collab #3 (monetization tuning is a human-only decision).

## 10. Decision

**ADOPT** : Single-SDK AdMob direct via `godot-admob` plugin + Google UMP + ATT. Future scale-up path: enable AdMob in-app bidding when fill-rate tuning at scale is required.

**RUNNER-UP** : AdMob in-app bidding as configuration of #1 for post-MVP scale.

**REJECTED** : AppLovin MAX, ironSource LevelPlay (O1 veto — third-party SaaS mediation); Unity Ads / LevelPlay (O1 veto + engine mismatch); hybrid mediation + direct (O1 veto + Privacy Manifest explosion); self-served direct campaigns only (indie cannot scale demand).

**Cross-link D20** : E22 is a downstream consumer of D20 consent signals (ATT + UMP) and does not re-derive them.

**Cross-link E22b** : integration topology determines which ad placement + frequency-capping policies are technically available.

**Cross-link MG-9 §2 (Safety)** : dark-pattern avoidance + loot-box regulatory context tagged for E22b extraction form.

**Traceability** : `verification/picoc/mobile-game-picoc-batch-E.md` §E22 + cross-link D20 (consent) + E22b (ad UX policy) + E23 (IAP coexistence) + H36 (ad telemetry).
