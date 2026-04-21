# Phase 1.3 Batch D — PICOCs : Store Publishing (domaine `mobile-game-2d`)

**Protocole** : methodology.md v3.0 §1.3 + Amendement G-1 + Amendement #3
**Date** : 2026-04-21
**Methode** : double extraction + reconciliation
**Tracability** :
- Reviewer A : agent `ad0b9dc4b0325857a`
- Reviewer B : agent `a2f574fe51b246aa7`

## Cadre upstream

14 PICOCs deja consolides : A1, A4', A6, A7, A8 (Batch A) ; B7-B11 (Batch B) ; C12-C15 (Batch C).

**Ligne Batch D** : publishing + release + store-mandated compliance. A8 s'arrete a l'artifact `.aab` / `.ipa` sur disk ; Batch D demarre "comment l'artifact atteint un device user, legalement et avec succes".

## Decisions candidates (commissioning §1.2 Categorie D)

- D17. Publishing workflow Android + iOS
- D18. Bundle format / install size optimization
- D19. Dynamic delivery / asset packs
- D20. Privacy manifest / data safety declaration
- D21. App icon / splash screen pipeline

## Reconciliation A vs B

| # initial | Decision | Verdict A | Verdict B | Accord |
|-----------|----------|-----------|-----------|:------:|
| D17 | Publishing workflow | RETAIN | RETAIN | V |
| D18 | Bundle optimization | ABSORB A8 | ABSORB A8 | V |
| D19 | Dynamic delivery | RETAIN | RETAIN | V |
| D20 | Privacy compliance | RETAIN | RETAIN | V |
| D21 | Icon + splash | RETAIN (unified) | SPLIT retain only platform integration | PARTIAL V |

**Kappa brut : 5/5 = 100% sur retain/absorb decision**, divergence uniquement sur **granularite D21** (B split ; A unified).

**Arbitrage DIV-D21** :
- Position A : unified pipeline icon+splash multi-variant authoring-to-packaging
- Position B : split en (a) asset generation [absorbed A8 per-density output + B11 pixel-art authoring] + (b) platform launch-surface integration (Android 12+ SplashScreen API + themed icons + iOS variant selection)

**B wins**. Rationale :
1. Asset generation (nearest-neighbor upscaling 32×32 → 1024×1024 pour App Store listing) est deja coverage A8 (per-density raster output) + B11 (pixel-art authoring tool choices). Redondance si D21 l'inclut.
2. Platform launch-surface integration (SplashScreen API behavior, themed icons Android 13+, iOS light/dark/tinted variants) est une decision distincte et store-gated — meme anchor base (SWEBOK KA3 Design + Apple HIG + Material Design) mais evidence base distinct (platform integration APIs vs asset rendering).
3. Split evite l'incoherent mega-PICOC.

## PICOCs retenus — Batch D final

### PICOC #D17 — Cross-store publishing workflow + release-track orchestration

| Element | Valeur |
|---------|--------|
| **P** | Dev indie solo mobile 2D pixel-art portrait offline-first ciblant Google Play + Apple App Store, monetise ads+IAP+leaderboards, shippant updates incrementaux (bug fixes, content drops) sur multi-year release cadence, avec **single developer responsable pour build + sign + upload + review-submission + rollout decisions** cross-store simultaneously. First-submission cohort (no prior app on either store). |
| **I** | Classe des **workflow automation + release-orchestration** pour cross-store publishing. 5 axes : (a) build-and-sign automation degree (manual IDE upload ↔ script-driven ↔ hosted CI avec remote signing ↔ managed platforms) ; (b) release-track utilization pattern (internal→closed→open→production Play ; TestFlight internal→external→App Store Apple vs direct-to-production) ; (c) credential + signing-key management (local keystore + manual provisioning ↔ encrypted CI secrets ↔ Play App Signing + Xcode Cloud managed signing) ; (d) submission-metadata synchronization (store-console UI ↔ declarative metadata-as-code) ; (e) staged rollout + halt/resume automation (percentage rollout avec crash-rate/ANR-rate-based halt triggers ↔ direct-to-100% ↔ manual halt monitoring). |
| **C** | À découvrir systématiquement en Phase 2.1 (recherche : fastlane/Codemagic/GitHub Actions/Xcode Cloud docs, indie dev postmortems release automation, Apple WWDC + Google I/O release-engineering sessions, mobile CI/CD benchmark repos). **Pre-identification prohibée per Amendement G-1.** |
| **O** | **Mesurables** : (a) time-to-first-release from code-freeze to production both stores (hours/days, median + tail p95) ; (b) review-rejection rate per submission + root-cause distribution (metadata / policy / technical) ; (c) rollback latency apres regression detected post-release (time from detection to halted rollout + hotfix availability) ; (d) signing-key loss or compromise incidents (frequency + recovery cost solo dev) ; (e) developer-hours per release cycle (setup amortized vs per-release marginal) ; (f) release-cadence sustainability (releases/quarter maintainable solo over 3+ years). **User-facing** : (g) user-facing regression escape rate (crashes/ANR/1-star reviews attributable to insufficient pre-production testing) ; (h) staged-rollout halted rollout prevented customer-facing incident count. |
| **Co** | Solo dev finite ops capacity, no dedicated release engineer ; Windows or macOS development host (macOS required iOS signing) ; constrained budget (no enterprise CI seats) ; two stores avec asymmetric review SLAs (Apple typically 24-48h human review ; Google mostly automated + occasional human review) ; portrait-only 2D pixel-art modest binary size ; ads+IAP+leaderboards requiring periodic SDK updates → republication. |
| **Question** | "Pour un dev indie solo shippant un jeu mobile 2D pixel-art cross-store multi-year sur Google Play + Apple App Store avec ads+IAP+leaderboards, **quelle classe de workflow automation + release-track orchestration** (manual console ↔ script-driven ↔ CI-hosted ↔ managed platforms, cross all 5 axes) minimise time-to-production + user-facing regression escape rate + signing-key loss risk, tout en gardant ops overhead sustainable ?" |
| **Anchor** | **SWEBOK v4** : KA8 Software Configuration Management (release management, build-release process), KA9 SE Management (release planning). **ISO/IEC 29110-4-3** : VSE delivery/release process solo dev. **Apple App Store Review Guidelines** : §2 (Performance, TestFlight Beta), §3 (IAP submission). **Google Play Developer Program Policy** : release tracks, staged rollouts, App Signing by Google Play. **ISO/IEC 25010** : Reliability (Availability). |
| **Dependances** | **Cross-link D19** (in-app updates API vs release-track rollout — cross-store asymmetry : Google AppUpdateManager Play-mediated ; iOS relies on store-update notification only). **Cross-link D20** (privacy-manifest update cycle triggers republication). **Weak dep Batch H** (general CI/CD separate from store submission). |

---

### PICOC #D19 — Post-install dynamic content delivery under offline-first constraint

| Element | Valeur |
|---------|--------|
| **P** | Dev indie solo mobile 2D pixel-art portrait **offline-first** (A7 hard constraint) Android+iOS, ou total initial install budget est contraint par store limits (**Google Play 200 MB base APK** avant PAD requise ; **iOS 200 MB cellular-download cap** triggerant Wi-Fi-required prompt), et ou additional content (optional biomes, cosmetic packs, language packs, sprite atlases late-game content, background music variants, seasonal events) may be deferrable to post-install delivery — **avec overarching constraint que core gameplay doit rester playable offline-first immediately after install**. Pixel-art asset footprint typiquement modeste vs 3D AAA mais audio + content drops peuvent pousser au-dela store-friction thresholds. |
| **I** | Classe des **post-install additional-content delivery architectures**. 5 sous-classes : (a) ship-everything-in-bundle (no dynamic delivery ; rely on A8 splits + App Thinning only) ; (b) platform-native on-demand asset delivery (Google Play Asset Delivery install-time / fast-follow / on-demand modes ; iOS On-Demand Resources tag-based fetching) ; (c) self-hosted CDN asset delivery (developer-operated HTTPS endpoint + custom version manifest + incremental patching) ; (d) hybrid (platform-native pour initial gate-clearing, self-hosted pour in-game content drops post-release) ; (e) in-app update prompts (Play In-App Updates API flexible vs immediate ; iOS sans equivalent — store update notification only). Sub-decision : cache-invalidation / integrity-verification (manifest hashes, signed payloads). |
| **C** | À découvrir systématiquement en Phase 2.1 (recherche : Google Play Asset Delivery + iOS On-Demand Resources docs, mobile game dev content-delivery postmortems, in-app-update adoption rate studies, offline-first mobile game architecture papers, self-hosted CDN cost analyses indie scale). **Pre-identification prohibée per Amendement G-1.** |
| **O** | **Mesurables** : (a) initial install size delivered to user (MB) + conversion-rate delta vs monolithic (%) ; (b) time-to-first-playable after install completion (seconds, including post-install fetches if any) ; (c) **offline-first contract preservation** : % core-gameplay sessions uninterrupted par required fetch (cross-link A7) ; (d) fetch-failure user-facing impact (content unavailable, error dialog, graceful degradation to lower-fidelity asset) — % sessions encountering fetch failure ; (e) update-propagation latency content drops (hours/days from developer publish to 50% / 90% installed-base coverage) ; (f) bandwidth cost (self-hosted: $ per GB served ; platform-native: effectively zero to developer) ; (g) implementation complexity solo dev (LOC, testing surface, duplicated iOS+Android logic). **User-facing** : (h) initial install conversion rate store listing → install ; (i) post-install update adoption latency (% users on latest version at T+7 days). |
| **Co** | Pixel-art assets compress extremely well (small footprint per sprite) — dynamic-delivery decision less forced than 3D AAA ; MAIS audio tracks + optional content packs can still push bundle past store-friction thresholds. **Offline-first = HARD CONSTRAINT** : any design ou core gameplay depends on post-install fetch VIOLATES le pilot. Solo dev → custom CDN ops significant burden. iOS ODR complex deprecation/coexistence with App Thinning. Cross-store asymmetry : Google In-App Updates API mature ; iOS no equivalent. |
| **Question** | "Pour un jeu mobile 2D pixel-art offline-first indie solo Android+iOS avec modest asset footprint mais content-drop cadence periodique, **quelle classe de post-install dynamic content delivery strategy** (monolithic / platform-native PAD+ODR / self-hosted CDN / hybrid / in-app updates) optimise le compromis initial install size + offline-first contract preservation + update adoption latency + solo-dev ops overhead, dans les contraintes store limits et cross-store asymmetry ?" |
| **Anchor** | **SWEBOK v4** : KA8 Software Configuration Management (release distribution, delta packaging), KA2 Software Design (deployment architecture). **ISO/IEC 25010** : Portability (Adaptability, Installability), Reliability (Availability). **Apple App Store Review Guidelines** : §2.5.2 (executable code delivery restriction — asset delivery MUST NOT include executable game logic). **Google Play Developer Program Policy** : Play Asset Delivery usage policy, prohibited runtime code download. |
| **Dependances** | **Strong cross-link A7** (offline-first invariants) et **A8** (picks delivery channel for artifacts A8 produced). **Cross-link D17** (in-app updates API integrates with release orchestration). |

---

### PICOC #D20 — Privacy manifest + data-safety compliance architecture

| Element | Valeur |
|---------|--------|
| **P** | Dev indie solo mobile 2D pixel-art offline-first Android+iOS integrating **third-party SDKs** : ads (mediation network + one or more ad networks), IAP (StoreKit / Google Play Billing), leaderboards (Game Center / Google Play Games Services or cross-platform BaaS), analytics/crash-reporting, publishing to Apple App Store (**Privacy Manifest mandatory since Fall 2024** for apps using required-reason APIs or embedding listed SDKs + App Tracking Transparency) ET Google Play Store (**Data Safety form mandatory since 2022** + Families policy if targeting children + Advertising ID user choice since Android 12+). **Apple Fall 2024 deadline has already passed as of 2026-04-21** — non-compliance actively blocking submissions. |
| **I** | Classe des **privacy-compliance architectures + SDK-governance strategies**. 6 axes : (a) SDK selection policy keyed on privacy-manifest availability (refuse SDKs sans `PrivacyInfo.xcprivacy` + required-reason API declarations ↔ accept and manually paper over) ; (b) manifest aggregation approach (Xcode auto-aggregation at build time ↔ hand-curated app-level `PrivacyInfo.xcprivacy` ↔ CI-time validation step) ; (c) tracking-consent mechanics (ATT prompt timing + copy ; Google UMP / IAB TCF for GDPR ; ads SDK consent-forwarding configuration) ; (d) data-safety declaration generation (manual console entry ↔ declarative source-of-truth in repo ↔ SDK-manifest-driven auto-population) ; (e) kid-safety / age-gating decision (COPPA, Designed-for-Families, Apple Kids Category trade-offs pour non-child-targeted but family-friendly pixel-art) ; (f) required-reason API audit process (identifying app-code + SDK-code usage of file-timestamp, user-defaults, disk-space, system-boot-time, active-keyboard APIs). |
| **C** | À découvrir systématiquement en Phase 2.1 (recherche : Apple Privacy Manifest docs + required-reason API list, Google Play Data Safety documentation, IAB TCF + Google UMP + OneTrust CMP docs, GDPR + CCPA + COPPA guidance, indie mobile dev compliance postmortems, Apple WWDC sessions on Privacy Manifest 2023+). **Pre-identification prohibée per Amendement G-1.** |
| **O** | **Mesurables** : (a) first-submission privacy-review pass rate (App Store + Play Store) ; (b) SDK-manifest coverage ratio (SDKs with published manifest ÷ total SDKs in build) ; (c) declaration-reality drift (discrepancies between declared categories + runtime SDK behaviour — detected by network-call audit) ; (d) time-to-remediate on store-issued privacy compliance notice (hours/days) ; (e) time-to-remediate when embedded SDK updates changes manifest (hours per SDK update) ; (f) user-visible consent-prompt funnel conversion (ATT opt-in rate, GDPR consent rate) + downstream eCPM impact ; (g) regulatory-complaint + store-enforcement incidents product lifetime (count) ; (h) auditability — time to answer data-subject request / regulator inquiry ("what data does your app collect, from which SDK, for which purpose"). **User-facing** : (i) consent prompt user experience (fatigue, abandonment) ; (j) actual privacy outcome (no user PII exfiltration beyond declared). |
| **Co** | Solo dev LEGALLY responsible as data controller, NO privacy officer. **Ads monetization = primary driver of manifest/consent complexity** (ad network collects IDFA/GAID, device fingerprints, user-agent). IAP relatively clean (first-party platform payment). Leaderboards Game Center/Play Games first-party. **Offline-first pixel-art single-player core does NOT itself collect user data beyond local saves** — almost all privacy surface is SDK-imported. Apple Fall 2024 deadline PASSED (2026-04-21 current) — actively enforced. Family-friendly pixel-art not child-targeted MUST still answer the question. |
| **Question** | "Pour un dev indie solo mobile 2D monetizing via ads+IAP+leaderboards Android+iOS, **quelle classe d'architecture privacy-manifest + data-safety compliance** (SDK selection criteria / manifest aggregation / consent mechanics / data-safety declaration sync, across 6 axes) minimise submission rejections + remediation time + audit exposure + false-positive user-experience disruption, tout en respectant legal hard constraint (Apple Privacy Manifest, GDPR, COPPA si applicable) ?" |
| **Anchor** | **SWEBOK v4** : KA14 Professional Practice (legal/regulatory), KA12 Software Quality (compliance attributes), KA13 Software Security. **ISO/IEC 25010** : Security (Confidentiality, Accountability, Authenticity). **ISO/IEC 25019** : Data quality in use (privacy). **Apple App Store Review Guidelines** : §5 Legal (§5.1.1 Data Collection + §5.1.2 Data Use + §5.1.5 Location). **Apple Privacy Manifest specification** : required-reason APIs + tracking domains + commonly-used SDKs list + Fall 2024 enforcement. **Google Play Developer Program Policy** : User Data + Data Safety + Families + Advertising ID + UMP/GDPR consent requirement. |
| **Dependances** | **Cross-link C15** (save integrity privacy-adjacent local scope vs D20 disclosure scope). **Strong cross-link Batch E** (IAP/ads runtime consent prompts — ATT + UMP/CMP). **Cross-link D17** (SDK manifest update = trigger republication). **Weak cross-link A7** (cloud-save privacy classification declared in D20). |

---

### PICOC #D21 — Platform launch-surface integration (SplashScreen API + themed icons + variant selection)

| Element | Valeur |
|---------|--------|
| **P** | Dev indie solo mobile 2D pixel-art portrait Android 12+ (SplashScreen API enforced : windowSplashScreenAnimatedIcon + brandedImage + exitAnimation hooks) + Android 13+ (themed monochrome icons Material You tinting) + iOS 14+ (launch storyboard mandatory) + iOS 18+ (light/dark/tinted icon variants), avec **pixel-art brand identity qui doit survivre adaptive-icon masking + dark-mode variants + themed-icon tinting**. Note : asset generation (upscaling 32×32 source to 1024×1024 App Store listing) = A8/B11 territory ; D21 couvre **platform launch-surface integration APIs**. |
| **I** | Classe d'**integration platform-native launch-surface**. 4 axes : (a) Android 12+ SplashScreen API usage (windowSplashScreenAnimatedIcon + windowSplashScreenBrandingImage + exitAnimation listener) vs legacy pre-12 splash activity pattern ; (b) Adaptive icon decomposition (foreground/background layers respecting 72dp safe zone) + themed monochrome icon Android 13+ ; (c) iOS launch storyboard strategy (static minimal ↔ branded with pre-rendered pixel art) + legacy launch image catalog coexistence ; (d) iOS 18+ multi-variant icon selection (light/dark/tinted) + alternate app icons via `setAlternateIconName`. Sub-decision : aesthetic tension SplashScreen API icon-centric launch vs pixel-art brand identity (branded image vs pure icon). |
| **C** | À découvrir systématiquement en Phase 2.1 (recherche : Android 12 SplashScreen API Codelabs + docs, Material Design themed icons guidelines, Apple HIG launch screens + App Icons + dark-mode variants, iOS 18 WWDC tinted-icons session, indie mobile dev launch-surface postmortems, A/B install-conversion studies on icon quality). **Pre-identification prohibée per Amendement G-1.** |
| **O** | **Mesurables** : (a) cold-launch time-to-first-frame pre- vs post-API-integration (ms) ; (b) icon-legibility score at smallest density under adaptive-mask geometry (expert rubric) ; (c) dark-mode + themed-icon rendering correctness cross device cohort (% devices displaying correct variant) ; (d) A/B install-conversion delta sur store listing icon (store-analytics %) ; (e) authoring-time icon-refresh cycle after icon redesign (hours to regenerate full variant set) ; (f) store-listing rejection rate for icon non-compliance (safe-zone violations, alpha channel issues, iOS glossy overlay legacy) ; (g) build-time asset footprint cost of shipping full variant set (KB added to bundle). **User-facing** : (h) first-impression recognisability (ISO 25010 Appropriateness Recognizability — playtest/heuristic rating) ; (i) perceived brand coherence cross home-screen contexts (dark mode, themed, light). |
| **Co** | **Pixel-art source material = defining authoring constraint** : 32×32 ou 64×64 native sprite doit etre reconcilie avec 1024×1024 App Store listing + adaptive-icon 108×108 dp safe zone + Android 12 SplashScreen icon geometry (typically mono or branded). Solo dev no dedicated icon artist. Portrait-only game constrains splash layout. **Platform divergence sharp** : Android adaptive-icon foreground+background model != iOS single-flat-icon-with-variants — same source CAN'T drive both without pipeline logic. |
| **Question** | "Pour un jeu mobile 2D pixel-art indie solo Android 12+/13+ et iOS 14+/18+, **quelle classe d'integration platform-native launch-surface** (Android SplashScreen API strategy + adaptive/themed icons + iOS launch storyboard + iOS multi-variant selection) maximise cold-launch time-to-first-frame + brand recognisability cross home-screen contexts + store-listing compliance, tout en gardant authoring overhead sustainable pour solo dev cross icon-refresh cycles ?" |
| **Anchor** | **SWEBOK v4** : KA3 Design (user-interface design, visual design, platform integration), KA4 Construction (platform APIs integration). **ISO/IEC 25010** : Usability (Appropriateness Recognizability, User Interface Aesthetics, Operability). **Apple Human Interface Guidelines** : App Icons + Launch Screens + Dark Mode + Tinted Icons (iOS 18). **Apple App Store Review Guidelines** : §2.3 Accurate Metadata (icons must match in-app icon). **Material Design** : Adaptive Icons + Themed Icons. **Android 12 SplashScreen API specification**. **Android CDD** (adaptive icon spec). |
| **Dependances** | **Strong dep A8** (per-density raster output feeds D21 inputs). **Strong dep B11** (pixel-art authoring conventions determine upscaling approach). **Weak cross-link B10** (SplashScreen API exit-animation could involve animated icon — sprite animation). |

---

## Decisions dropped / absorbed

| Decision | Action | Justification | Redirection |
|----------|--------|---------------|-------------|
| D18 Bundle format / install size | ABSORBED A8 | A8 explicitly covers AAB splits + App Thinning + compression formats + per-density output. Beyond architecture : dead-code elimination / R8 / Swift optimization flags = toolchain-config question, not architectural | — |
| D21 part (a) asset generation | ABSORBED A8 + B11 | Upscaling source pixel-art to adaptive-icon safe zones + 1024×1024 listing = A8 (per-density raster output) + B11 (pixel-art authoring tool conventions nearest-neighbor vs mask anti-aliasing) | A8 + B11 |
| Store marketing / ASO / screenshot strategy | OUT OF SCOPE | Marketing-ops, not SE engineering EBSE | — |
| Platform-mandated signing mechanics (v2/v3/v4 schemes) | OUT OF SCOPE | Prescribed by platform, non-empirical | Automation class around signing inside D17 |
| Legal drafting EULA / privacy policy text | OUT OF SCOPE | Legal-writing domain | Architectural compliance inside D20 |
| App Store / Play featuring / editorial submission | OUT OF SCOPE | Marketing-relations | — |
| Review-rejection appeals process | OUT OF SCOPE | Editorial/legal activity, not repeatable engineering | — |
| Runtime consent UI for ads/IAP (ATT prompt, UMP/CMP) | DEFERRED Batch E | Runtime behaviour, distinct from publishing flow | Batch E |
| Enterprise MDM distribution, TestFlight-only internal tooling | OUT OF SCOPE | Incompatible with pilot P (public store release) | — |

## Open questions pour Phase 1.5 + cross-batch

### Cross-batch coordination

1. **D17 vs Batch H CI/CD** : confirmer que Batch H (dev tooling / CI/CD) couvre **generic build/test CI** ; D17 couvre specifiquement **store-submission + release-track orchestration**. Boundary : Batch H stops at "tested artifact ready" ; D17 starts at "submit to store". OK pour superviseur ? Yes.
2. **In-app updates API** : retenu dans D19 (post-install delivery) ; cross-link D17 (release orchestration). iOS no equivalent → cross-store asymmetry sharp. Extraction Phase 2 doit tagger studies par plateform specifically.
3. **D20 ATT/UMP scope** : D20 couvre les **mechanics** (when to prompt, how to integrate UMP, how to forward consent to ad SDKs). **Prompt copy optimization for opt-in rate** = Batch E domain (monetization UX optimisation).
4. **Leaderboards SDK influence sur D20** : si pilot utilise Game Center + Google Play Games Services (first-party) → minimal privacy surface. Si BaaS cross-platform → lands squarely in D20 SDK-governance. Default = first-party, flag en Phase 2.1 si stack discovery surface BaaS preferable.
5. **Kids/Families policy** : D20 include Designed-for-Families + Apple Kids Category sub-axis. Pour Acres (family-friendly pixel-art farming-sim NOT child-targeted), la decision est "declare mixed audience, avoid kids-category pitfalls". Si pilot pivot vers explicitly child-targeted → separate PICOC (not current scope).

### Agent C verifications Phase 1.5

6. Verifier **Apple Privacy Manifest Fall 2024 deadline** enforcement status as of 2026-04 (still active ? updated ?).
7. Verifier **Google Play 200 MB base APK limit** toujours en vigueur 2026 (may have changed with App Bundle mandate).
8. Verifier **iOS 200 MB cellular-download cap** current value.
9. Verifier **Android 12 SplashScreen API** mandatory status (is legacy splash activity still accepted post-2026 ?).
10. Verifier **iOS 18 tinted icon variants** scope + requirements.

### Phase 2.1 extraction guidance

11. Phase 2.1 pour D17 : chercher **cross-store CI/CD indie postmortems** (fastlane vs Codemagic vs Xcode Cloud real-world cost).
12. Phase 2.1 pour D19 : chercher **offline-first games with content updates** (empirical data on dynamic-delivery necessity at indie scale).
13. Phase 2.1 pour D20 : chercher **Privacy Manifest SDK coverage 2025+ surveys** (which ad networks ship compliant manifests).
14. Phase 2.1 pour D21 : chercher **pixel-art icon authoring conventions for adaptive icons** (community pixel-art style guides for mobile).

## Statut Batch D

- **4 PICOCs retenues** : D17, D19, D20, D21
- **Kappa brut** : 5/5 = 100% sur retain/absorb decisions (near-perfect)
- **Divergence granularite** : D21 split par B, arbitre en faveur de B (split plus propre)
- **Cross-batch dependencies** : A7 (D19), A8 (D17, D21), B11 (D21), C15 (D20), Batch E (D20, D19 updates), Batch H (D17)

**APPROVED pour Phase 1.3 Batch E (monetization).**
