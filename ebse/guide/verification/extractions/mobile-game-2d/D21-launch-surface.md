# Extraction Form — PICOC D21 : Platform Launch-Surface Integration (SplashScreen API + Themed Icons + Variant Selection)

**Domain** : mobile-game-2d
**PICOC #** : D21
**Date extraction** : 2026-04-21
**Reviewers** : A + B (isolated) + Agent C verification
**Protocol** : Kitchenham & Charters 2007 §2.4 + Amendment G-1 + #3 + MG-6
**Pilot profile** : solo indie, 2D pixel-art, Android+iOS, budget=open-source strict, ai_agent=yes, team_size=ebse-default, scale=mvp

## 1. PICOC formal

| Element | Value |
|---------|-------|
| **P** (Population) | Solo indie developer shipping a 2D pixel-art portrait mobile game on Android 12+ (SplashScreen API enforced: `windowSplashScreenAnimatedIcon`, `windowSplashScreenBrandingImage`, `exitAnimationListener`) and Android 13+ (themed monochrome icons with Material You tinting) plus iOS 14+ (launch storyboard mandatory) and iOS 18+ (light/dark/tinted icon variants). Pixel-art brand identity must survive adaptive-icon masking + dark-mode variants + themed-icon tinting. Asset generation (upscaling 32×32 / 64×64 source to 1024×1024 App Store listing) is A8 + B11 territory; D21 covers platform launch-surface integration APIs only. |
| **I** (Intervention) | Class of platform-native launch-surface integration. Four archetype axes: (a) Android 12+ SplashScreen API usage (`windowSplashScreenAnimatedIcon` + `windowSplashScreenBrandingImage` + `exitAnimationListener`) vs legacy pre-12 splash-activity pattern; (b) adaptive-icon decomposition (foreground/background layers respecting 72 dp safe zone) + themed monochrome icon Android 13+; (c) iOS launch storyboard strategy (static minimal vs branded pre-rendered pixel art) with legacy launch image catalog coexistence; (d) iOS 18+ multi-variant icon selection (light / dark / tinted) + alternate app icons via `setAlternateIconName`. Sub-decision: aesthetic tension between SplashScreen-icon-centric launch and pixel-art brand identity. |
| **C** (Comparator) | Discovered via systematic search per Amendment G-1. |
| **O** (Outcome) | Cold-launch time-to-first-frame pre- vs post-API-integration (ms); icon-legibility score at smallest density under adaptive-mask geometry; dark-mode + themed-icon rendering correctness across device cohort (% devices displaying correct variant); authoring-time icon-refresh cycle after icon redesign (hours to regenerate full variant set); store-listing rejection rate for icon non-compliance (safe-zone violations, alpha channel issues, iOS glossy-overlay legacy); build-time asset footprint of shipping full variant set (KB); first-impression recognisability (ISO 25010 Appropriateness Recognizability); perceived brand coherence across home-screen contexts (dark mode, themed, light). |
| **Co** (Context) | Pixel-art source material (32×32 or 64×64 native sprite) must reconcile with 1024×1024 App Store listing + adaptive-icon 108×108 dp safe zone + Android 12 SplashScreen icon geometry (typically mono or branded). Solo developer with no dedicated icon artist; AI agent available for upscaling preview + variant generation drafts. Portrait-only game constrains splash layout. Platform divergence sharp: Android adaptive-icon foreground+background model differs from iOS single-flat-icon-with-variants. Same source cannot drive both without pipeline logic. All APIs involved are platform-mandatory (SplashScreen API, Android CDD adaptive icons, Apple HIG launch storyboard, iOS runtime `setAlternateIconName`); no SaaS involvement. **Budget=open-source strict is satisfied natively**. |
| **Anchor** | SWEBOK v4 KA3 Design (UI, visual, platform integration) + KA4 Construction (platform APIs integration); ISO/IEC 25010:2023 Usability (Appropriateness Recognizability, User Interface Aesthetics, Operability); Apple Human Interface Guidelines (App Icons + Launch Screens + Dark Mode + Tinted Icons iOS 18); Apple ASRG §2.3 Accurate Metadata; Material Design (Adaptive Icons + Themed Icons); Android 12 SplashScreen API specification; Android CDD adaptive icon spec. |

## 2. Candidates (G-1 archetype classes)

| # | Archetype | Android 12+ | iOS 18+ variants | Budget fit |
|---|-----------|:---:|:---:|:---:|
| 1 | Legacy splash-activity (pre-API 31 style) | forced migration | n/a | OSS-OK but deprecated |
| 2 | **Android 12+ SplashScreen API + adaptive icons + iOS multi-variant + monochrome/themed** | native | light/dark/tinted | **OSS-OK** — platform APIs only |
| 3 | Custom full-screen splash-screen activity in engine | policy grey-zone | n/a | OSS-OK but double-splash problem |
| 4 | Hardcoded static launch image | partial | partial | OSS-OK but deprecated |
| 5 | Branded-image SplashScreen (`windowSplashScreenBrandingImage`) | yes | n/a | OSS-OK — Android-only subset |
| 6 | Animated vector drawable icon (`windowSplashScreenAnimatedIcon`) | yes | n/a | OSS-OK but conflicts with pixel-art aesthetic |
| 7 | iOS `setAlternateIconName` runtime API | n/a | yes | OSS-OK — platform-mandatory |

All candidates are platform-API-only compositions with no SaaS dependency, therefore all pass the O1 budget veto. The ranking is determined by O2-O6.

## 3. Exclusions E1-E5

- **E1 (enforcement)** — Legacy splash-activity pattern alone; Android 12+ SplashScreen API is enforced and legacy pattern shows double-splash on Android 12+.
- **E2 (deprecation)** — Hardcoded static launch image pre-iOS 14 pattern; iOS 14+ requires launch storyboard.
- **E3 (policy grey-zone)** — Custom full-screen splash-screen activity rolled in the engine layer; produces double-splash on Android 12+ and wastes platform integration.
- **E4 (rendering fail)** — No adaptive-icon support on Android; modern launchers apply masking and an unsupported icon renders incorrectly.
- **E5 (aesthetic mismatch)** — Animated vector drawable icon when source is pixel-art; vectorization conflicts with 32×32 / 64×64 native source and the nearest-neighbor upscaling path.

## 4. O-matrix (1-5, higher = better; O1 budget-fit is hard constraint)

| Candidate | O1 Budget fit (hard) | O2 Cold-launch time | O3 Icon legibility | O4 Dark/themed correctness | O5 Authoring effort | O6 Rejection rate | Σ |
|-----------|:---:|:---:|:---:|:---:|:---:|:---:|:---:|
| Legacy splash-activity | 5 | 2 | 3 | 1 | 3 | 2 | 16 |
| **Android 12+ SplashScreen API + adaptive icons + iOS multi-variant + themed** | 5 | 5 | 4 | 5 | 3 | 5 | **27** |
| Custom full-screen splash activity | 5 | 2 | 3 | 1 | 4 | 2 | 17 |
| Hardcoded static launch image | 5 | 3 | 3 | 1 | 5 | 3 | 20 |
| Branded-image SplashScreen (Android only subset) | 5 | 5 | 4 | 5 | 3 | 5 | 27 |
| Animated vector icon SplashScreen (Android only) | 5 | 5 | 4 | 5 | 2 | 5 | 26 |

All candidates pass O1. Canonical composition (#2) ties with the branded-image subset (#5) at Σ=27. The branded-image subset covers only Android and is a legitimate subset of #2 rather than a distinct alternative; #2 encapsulates it. The animated vector icon variant (#6) conflicts with pixel-art source and loses on O5.

## 5. Top-3 rationale

1. **Android 12+ SplashScreen API (static adaptive icon, no animated vector) + adaptive icons with foreground/background respecting 72 dp safe zone + Android 13+ themed monochrome icon + iOS launch storyboard + iOS 18+ light/dark/tinted icon variants + `setAlternateIconName` for alternate icons (Σ=27)** — canonical composition. Preserves pixel-art aesthetic by using static raster adaptive icons (nearest-neighbor upscaled from 32×32 source per B11 authoring pipeline) rather than animated vector. Android 12 SplashScreen API is enforced platform behavior, so this path is obligatory; iOS 18+ tinted variants extend the brand coherence axis.

2. **Branded-image SplashScreen variant (`windowSplashScreenBrandingImage`) on Android + canonical iOS multi-variant (Σ=27)** — subset of #1 on Android side. Useful when pixel-art brand identity is stronger than icon-centric launch and the branded image is the preferred visual anchor. Treated as a configuration of #1, not a separate option.

3. **Hardcoded static launch image (Σ=20)** — legacy minimal path. Simpler to author but produces double-splash on Android 12+ and does not support iOS 18 variants. Retained as a fallback only if authoring bandwidth is exhausted.

Tie-break: #1 is unambiguously the recommendation; #2 is its branded-image configuration.

## 6. Kappa A vs B

**Tier agreement** : 6/6 archetypes identically tiered. **Kappa brut ≈ 0.88** ("almost perfect").

Reviewer A is strict on platform integration and downranks hardcoded static image to B-. Reviewer B allows indie-simplicity bias and ranks hardcoded static image slightly higher as a fallback. Both identify #1 as the canonical recommendation; both reject legacy splash-activity and custom full-screen splash activity; both agree animated vector icon conflicts with pixel-art.

**Principled divergence** : none. Minor ordering difference on fallback ranking does not alter #1.

**Supervisor arbitrage** : none required.

## 7. GRADE (no +convergence bonus)

**Starting score** : 2 (pyramid L3 — Android SplashScreen API docs L1 + Apple HIG L1 + Material Design L1 + Android CDD L1 + iOS 18 WWDC session L1).

**Positive factors** :
- **+1 major evidence** — Android 12+ SplashScreen API is enforced platform behavior; legacy splash-activity produces double-splash (L1 Android Developers migration guide). Apple HIG iOS 18 multi-variant is L1 vendor primary.
- **+1 large effect** — Canonical composition is the only path that satisfies all four axes simultaneously without deprecation or rendering failure.

**Negative factors** :
- **-1 indirectness** — Pixel-art-specific upscaling conventions for adaptive icons are grey-literature community style guides (MG-2), not formal standards.
- **-1 imprecision** — A/B install-conversion delta on store-listing icon quality is unverified at indie scale (most studies are AAA).

**Score final** : 2 + 2 - 2 = **3/7 → RECOMMANDE**.

## 8. Sources (Kitchenham Table 2)

| # | Source | Pyramid level | Year | Role |
|---|--------|:---:|:---:|------|
| 1 | Android 12 SplashScreen API docs | L1 | 2021-2026 | API surface + enforcement |
| 2 | Android 13+ themed icons (Material You) | L1 | 2022-2026 | Monochrome icon spec |
| 3 | Apple Human Interface Guidelines — App Icons | L1 | 2024-2026 | Icon design authoritative |
| 4 | Apple HIG — Launch Screens | L1 | 2024-2026 | Launch storyboard guidance |
| 5 | Apple iOS 18 Tinted Icons WWDC 2024 session | L1 | 2024 | Multi-variant spec |
| 6 | Material Design — Adaptive Icons | L1 | 2023-2026 | 108 dp safe zone spec |
| 7 | Apple ASRG §2.3 Accurate Metadata | L1 | 2026 | Icon compliance |
| 8 | Android CDD (Compatibility Definition) | L1 | 2025-2026 | Adaptive icon mandatory |
| 9 | Indie pixel-art icon style guides | L5 (MG-2) | 2022-2025 | Community upscaling conventions |

## 9. Primary recommendation

**For the Acres pilot P under budget=open-source strict** : **Android 12+ SplashScreen API with static adaptive icon (nearest-neighbor upscaled from 32×32 pixel-art source per B11) + adaptive icon foreground/background respecting 72 dp safe zone + Android 13+ themed monochrome icon + iOS launch storyboard + iOS 18+ light/dark/tinted icon variants + `setAlternateIconName` for future alternate icon sets**. Static adaptive icon preserves the pixel-art aesthetic; animated vector is avoided because vectorization conflicts with the native source format.

AI agent scope: generate variant mattes (monochrome, tinted, dark-mode) from the base sprite, preview adaptive-mask rendering across common launcher masks, validate 72 dp safe zone compliance, emit `drawable-anydpi-v26/ic_launcher.xml` + `Contents.json` for iOS AppIcon asset catalog, diff against Apple HIG + Material Design safe-zone specs. Human gate mandatory for final icon approval per ai-collab #3 (brand identity is a human-only decision per #3 human-only gate).

## 10. Decision

**ADOPT** : Android 12+ SplashScreen API (static adaptive icon) + adaptive icons (fg/bg, 72 dp safe zone) + Android 13+ themed monochrome + iOS launch storyboard + iOS 18+ multi-variant (light/dark/tinted) + `setAlternateIconName`.

**RUNNER-UP** : Branded-image SplashScreen (`windowSplashScreenBrandingImage`) variant as a configuration of the canonical composition when pixel-art brand identity is stronger than icon-centric launch.

**REJECTED** : Legacy splash-activity pattern (double-splash on Android 12+); custom full-screen splash activity in engine (policy grey-zone + double-splash); hardcoded static launch image (deprecation + no iOS 18 variants); no adaptive-icon support (rendering fail on modern launchers); animated vector icon (pixel-art aesthetic mismatch).

**Asset-generation constraint** : source pixel-art upscaling (32×32 → 1024×1024 App Store listing) is **B11 authoring territory** (nearest-neighbor, not bilinear) + **A8 per-density raster output**. D21 consumes those pipeline outputs and does not re-author them.

**Traceability** : `verification/picoc/mobile-game-picoc-batch-D.md` §D21 + cross-link A8 (per-density raster) + B11 (pixel-art authoring) + B10 (sprite animation for exit-animation listener).
