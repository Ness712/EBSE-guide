# Phase 1.3 Batch H — PICOCs : Dev Tooling + Ops (domaine `mobile-game-2d`)

**Protocole** : methodology.md v3.0 §1.3 + Amendement G-1 + Amendement #3
**Date** : 2026-04-21
**Methode** : double extraction + reconciliation
**Tracability** :
- Reviewer A : agent `a5f280373b5092e36`
- Reviewer B : agent `a19f2c0aef2d5d825`

## Cadre upstream

29 PICOCs formulees. Batch H boundary avec D17 (D17 = "signed artifact → store submission → review → staged rollout" ; H33 = "commit → build → test → signed artifact").

## Reconciliation A vs B

| Decision | Verdict A | Verdict B | Accord | Reconciliation |
|----------|-----------|-----------|:------:|----------------|
| H33 CI/CD | RETAIN | RETAIN | V | RETAIN |
| H34 Device testing | RETAIN | RETAIN | V | RETAIN |
| H35+H36 observability | MERGE → H35∪36 | SPLIT into H35 + H36 | X | **SPLIT (B wins)** |
| H37 Feature flags + A/B | RETAIN | ABSORB → D19+H36 | X | **RETAIN (A wins)** — B's absorption base sur mis-identified D19 scope |
| H38 Hot reload | ABSORB A1 | ABSORB A1 | V | ABSORBED A1 (with A1 extraction form enrichment note) |

**Kappa brut** : 3/5 = 60% ("moderate", juste au seuil).

**Arbitrage DIV-H35/H36** :
- **Position A (MERGE)** : same Firebase SDK surface, same privacy manifest footprint, same integration-point, solo indie decides once.
- **Position B (SPLIT)** : disjoint evidence bases — reliability engineering (symbolication, ANR detection, MetricKit, Android Vitals) vs game telemetry (funnel, cohorts, D7 retention). Different communities + different ISO anchors (Reliability vs Quality-in-use engagement) + different SWEBOK KAs (KA6 Ops vs KA9 Management). Merged PICOC would have incoherent outcomes list.

**Arbitrage superviseur** : **B wins — SPLIT**. Rationale :
1. Phase 2.1 literature keywords are materially different : "crashlytics mobile symbolication" vs "game analytics D7 retention cohort".
2. Outcome frames are incompatible : crash-free session rate is ISO 25010 Reliability ; D7 retention is ISO 25019 engagement KPI (NOT in 25010).
3. Cross-link documented : same-SDK bundling pattern (Firebase all-in-one) is a PATTERN observation that emerges at synthesis, not a reason to fuse PICOCs at formulation.

**Arbitrage DIV-H37** :
- **Position A (RETAIN)** : feature flags + remote config + A/B = distinct runtime-config architecture decision. Firebase Remote Config, LaunchDarkly, Split.io, Statsig. Overlap with E22b (ad UX) and D17 (staged rollout) documented but primitive is distinct.
- **Position B (ABSORB)** : flag mechanism → D19 ; measurement half → H36. No distinct yield.

**Arbitrage superviseur** : **A wins — RETAIN**. Rationale :
1. **B's absorption rationale incorrect** : B assumed "D19 covers remote config / kill-switch governance". Looking at actual Batch D file : **D19 = Post-install dynamic content delivery under offline-first constraint** (Play Asset Delivery, iOS On-Demand Resources, in-app updates). D19 covers ASSET delivery, NOT runtime config flags.
2. Feature flags / Remote Config SDK class (Firebase Remote Config, LaunchDarkly, custom-CDN-JSON, Unity Remote Config) IS a distinct architectural decision with its own anchors (ISO 25010 Flexibility/Adaptability + Accelerate experimentation chapter).
3. A/B methodology at low-DAU solo indie (CUPED, sequential testing, MAB) IS a distinct evidence base even if underpowered at pilot scale.

**Final Batch H = 5 PICOCs** : H33, H34, H35, H36, H37.

## PICOCs retenus — Batch H final

### PICOC #H33 — CI/CD build + test + artifact promotion pipeline (pre-store boundary)

| Element | Valeur |
|---------|--------|
| **P** | Dev indie solo (or very small team) produisant un jeu mobile 2D pixel-art portrait offline-first cross-platform Android+iOS avec ads+IAP+leaderboards, single-repo codebase, devant produire signed release-candidate artifacts pour both platforms from commits. **Boundary explicite avec D17** : H33 ends at signed `.aab` / `.ipa` in CI artifact store ; D17 begins at "upload to App Store Connect / Play Console". |
| **I** | Classe des **CI/CD architectures pre-store**. Axes : (a) choix CI host (GitHub Actions, GitLab CI, Bitrise, Codemagic, Xcode Cloud, self-hosted runner Mac mini + Linux/Windows Android) ; (b) pipeline topology (monorepo trunk-based + protected main ↔ short-lived feature branches ↔ release branches) ; (c) code-signing strategy (fastlane match, Xcode Cloud managed signing, manual keystore, Play App Signing enrollment) ; (d) promotion model (continuous deployment to internal track ↔ explicit manual promotion gates) ; (e) secrets management (OIDC federation, CI-native vaults, 1Password CLI) ; (f) build-variant management (debug/staging/release). Includes **baseline no-CI** (local-machine builds) as intervention for comparison. |
| **C** | À découvrir systématiquement en Phase 2.1 (recherche : fastlane + Codemagic + Xcode Cloud + GitHub Actions mobile docs, DORA reports mobile-specific, indie CI/CD postmortems, ACM papers on mobile CI). **Pre-identification prohibée per Amendement G-1.** |
| **O** | **DORA metrics adapted to mobile release cadence** : (a) **deployment frequency** (builds successfully promoted per week) ; (b) **lead time for changes** (commit to store-ready artifact, hours/days) ; (c) **change failure rate** (% builds failing store upload or rolled back) ; (d) **mean time to restore** (MTTR broken build pipeline, hours). **Secondary SE** : (e) pipeline cost (CI minutes × price, particularly macOS minutes dominating for iOS — $/month) ; (f) build reproducibility (bit-identical ou hash-stable artifacts from identical source — %) ; (g) signing-incident rate (expired certs, revoked provisioning profiles, lost keystore — incidents/year) ; (h) time-to-first-green-build new contributor (hours) ; (i) solo-indie feasibility (can one person operate without dedicated DevOps — binary + rationale). **ISO 25010** : Maintainability (Modifiability pipeline), Reliability (Pipeline availability), Portability (Runner-host independence). |
| **Co** | Cross-platform game engine (A1-dependent — build steps differ Unity Cloud Build path / Flutter `flutter build` / Godot export templates / native toolchains) ; dual-store (Google Play + App Store) ; **solo indie budget constraint** (macOS runner cost is HARD constraint : Apple Silicon self-hosted Mac mini vs metered cloud macOS minutes is concrete tradeoff) ; offline-first client (no server-side build deps except F26 backend) ; ads + IAP SDKs in build (binary size + signing-certificate scope) ; dev cadence typical indie (weeks-to-months between releases, NOT daily) ; **ISO 29110-4-3 VSE** directly applicable. |
| **Question** | "Pour un dev indie solo produisant un jeu mobile 2D pixel-art cross-platform Android+iOS, **quelle classe d'architecture CI/CD pre-store** (hosted managed Bitrise/Codemagic/Xcode Cloud ↔ generic cloud GitHub Actions ↔ self-hosted runner ↔ no-CI baseline) optimise DORA metrics (deploy frequency + lead time + change failure rate + MTTR) + pipeline cost + build reproducibility + signing-incident resistance + solo-indie feasibility, dans les contraintes macOS runner cost + cross-platform engine + VSE process envelope ?" |
| **Anchor** | **DORA Metrics** (Accelerate book, Forsgren/Humble/Kim). **SWEBOK v4** : KA5 Testing (pipeline test gates), KA8 Software Configuration Management (build + signing + artifact mgmt), KA6 SE Operations. **ISO/IEC 25010:2023** : Maintainability, Reliability, Portability. **ISO/IEC 29110-4-3** : VSE lifecycle. |
| **Dependances** | **Hard boundary with D17** : signed artifact handoff. **Cross-link H34** (test matrix invoked from pipeline). **Cross-link A1** (engine determines build steps). |

---

### PICOC #H34 — Device testing strategy + test-matrix design

| Element | Valeur |
|---------|--------|
| **P** | Dev indie solo mobile 2D pixel-art portrait offline-first Android+iOS avec ads+IAP+leaderboards, required to validate build across fragmented Android OEM/OS versions + iOS device/OS matrix prior to public release. Unit of study = **test matrix** : (device model × OS version × form-factor × locale × network-state) tuples + execution infrastructure. |
| **I** | Classe des **device-testing strategies**. 4 sous-classes : (a) cloud device farm (Firebase Test Lab now primary Google ; Xcode Cloud iOS ; BrowserStack ; AWS Device Farm ; Sauce Labs ; Kobiton) ; (b) self-hosted physical device lab (rack de real Android + iOS devices connected to CI runners) ; (c) emulator/simulator-only strategy (Android Emulator on CI + iOS Simulator on macOS runner) ; (d) hybrid (emulator every-commit smoke + physical-farm pre-release certification). Includes : test-matrix selection heuristic (top-N devices by install-share from Play Console/App Store analytics ↔ explicit matrix OS-version boundaries ↔ random-sampling ↔ crash-weighted prioritization from H35 data) ; test types (UI instrumentation Espresso/XCUITest, game-engine-specific Unity Test Framework + Flutter integration tests, monkey/fuzz, game-specific playtest automation via replay + deterministic simulation). |
| **C** | À découvrir systématiquement en Phase 2.1 (recherche : Firebase Test Lab + Xcode Cloud docs + cloud device farm comparatives, mobile testing academic ACM/IEEE, indie postmortems device testing, Android fragmentation studies). **Pre-identification prohibée per Amendement G-1.** |
| **O** | **Mesurables** : (a) escaped-defect rate (defects found by players post-release that a given test-matrix would have detected) ; (b) device-coverage ratio (% install-base covered by test matrix weighted by Play Console/App Store Connect usage) ; (c) test-execution wall-clock time per pipeline run (gates H33 lead time, minutes) ; (d) cost per test run (cloud-farm minute pricing × frequency, $/month) ; (e) flakiness rate (non-deterministic test failures per 100 runs — critical for games due to frame-timing + animation sensitivity) ; (f) frame-rate regression detection rate ; (g) Android-fragmentation-specific defect detection (OEM-skin bugs — Samsung One UI / Xiaomi HyperOS/MIUI / OPPO ColorOS) ; (h) iOS-OS-upgrade regression detection. **User-facing** : (i) Android Vitals improvement attributable to H34 matrix coverage ; (j) MetricKit hang/crash reduction iOS. |
| **Co** | **2D pixel-art specific** : game is GPU-light (no shader-heavy Metal/Vulkan content) → shifts emphasis from GPU-family coverage to touch-input + aspect-ratio + notch handling ; portrait-only → eliminates orientation-flip test axis ; offline-first → network-state testing axis (airplane mode, flaky connectivity via Firebase Test Lab network shaping) ; ads+IAP → requires test accounts on both stores (sandbox IAP flows need store-signed builds) ; leaderboards → online features require network-enabled test devices ; solo indie budget → physical-device-lab CapEx vs cloud-farm OpEx tradeoff acute ; cross-platform → engine-level test reuse possible (Unity Test Framework same tests Android+iOS). |
| **Question** | "Pour un jeu mobile 2D pixel-art indie solo portrait offline-first Android+iOS dual-store, **quelle classe de device-testing strategy** (cloud farm ↔ self-hosted lab ↔ emulator-only ↔ hybrid) avec quelle heuristique de test-matrix selection optimise escaped-defect rate + device-coverage ratio + test-execution time + cost per run + flakiness rate + fragmentation-specific defect detection, dans les contraintes 2D pixel-art (GPU-light, portrait-only) + solo indie budget + cross-platform engine ?" |
| **Anchor** | **SWEBOK v4** : KA5 Software Testing. **ISO/IEC 25010:2023** : Compatibility (Co-existence device cohort, Interoperability OEM skins), Reliability (Fault tolerance), Performance Efficiency (across device spectrum — critical for pixel-art low-end Android). **ISO/IEC 25023** : measurement. **Google Play Android Vitals** (stability metrics = ANR + crash thresholds against which test-matrix coverage is validated). **Apple MetricKit** (iOS counterpart). Firebase Test Lab docs. |
| **Dependances** | **Cross-link H33** (test matrix invoked from pipeline). **Cross-link Batch I** (Quality batch — test matrix execution is where quality gates fire). **Cross-link A1** (engine determines test framework options). **Seam with C-family performance measurement** : if study measures quality attribute ON device → C-family ; if study SELECTS/justifies device set itself → H34. |

---

### PICOC #H35 — Crash reporting + ANR detection + APM (reliability observability)

| Element | Valeur |
|---------|--------|
| **P** | Dev indie solo mobile 2D pixel-art portrait offline-first Android+iOS in production responsible for **reliability incident detection + triage without dedicated SRE/support function**. Covered telemetry streams : unhandled exceptions, signal crashes, ANRs on Android, watchdog terminations iOS, startup time, memory pressure, jank, battery drain. Solo dev on-call constraints (no 24/7 rotation). |
| **I** | Classe des **crash reporting + ANR + APM architectures**. 5 sous-classes : (a) platform-native only (Android Vitals + Apple MetricKit, NO third-party SDK — lowest privacy footprint) ; (b) single third-party SDK (Crashlytics OR Sentry OR Bugsnag OR Instabug OR Embrace) ; (c) dual third-party SDK (rare, but may occur for platform parity) ; (d) platform-native + third-party hybrid ; (e) no crash reporting baseline (reliance on store reviews + user reports). Includes : native + engine-level crash capture integration (Unity IL2CPP symbols, Godot ahead-of-time, Flutter dart stack trace), symbolication workflow (dSYM upload, ProGuard/R8 mapping upload, engine-specific symbol maps), offline-crash queueing + flush on reconnect. |
| **C** | À découvrir systématiquement en Phase 2.1 (recherche : Crashlytics + Sentry + Bugsnag mobile docs, Android Vitals + Apple MetricKit official docs, academic reliability engineering papers mobile, engine-specific crash reporting integration — Unity / Godot / Flutter crash postmortems). **Pre-identification prohibée per Amendement G-1.** |
| **O** | **Mesurables reliability** : (a) crash-free user rate (%) ; (b) crash-free session rate (%) — Play Vitals threshold ; (c) ANR rate (Android Vitals threshold ≥ 0.47% user-perceived ANR rate flagged as bad behavior) ; (d) hang rate iOS (MetricKit) ; (e) mean time to detect (MTTD) production incidents (hours) ; (f) MTTR production crashes (hours — DORA). **SDK-side** : (g) symbolication success rate (%) ; (h) offline-captured crash recovery rate after reconnect (%) ; (i) SDK binary-size overhead (MB) ; (j) SDK init-time overhead on cold start (ms) ; (k) battery-impact delta attributable to SDK (mAh/hour). **Store-compliance** : (l) Apple MetricKit integration coverage ; (m) Play Vitals threshold conformance (crash-free-session ≥ 99.x%, ANR ≤ 0.47%). |
| **Co** | Solo dev NO on-call rotation ; offline-first MEANS material fraction of crashes occur offline → queued client-side for later upload ; non-native engine runtimes (Unity/Godot/Flutter) complicate crash capture car engine runtimes may catch signals before SDK's native handler ; privacy-manifest disclosure obligations ALREADY accepted at D20 (NOT re-litigated) ; ATT/consent gating ALREADY handled at D20 mechanics. Platform-native (Vitals + MetricKit) = minimum-privacy-footprint option. |
| **Question** | "Pour un jeu mobile 2D pixel-art indie solo offline-first Android+iOS in production avec solo dev on-call constraints, **quelle classe de crash reporting + ANR + APM architecture** (platform-native only ↔ single third-party SDK ↔ dual SDK ↔ hybrid ↔ no-reporting baseline) optimise crash-free user + session rate + ANR rate + MTTD/MTTR + symbolication success + offline-crash recovery, tout en gardant SDK binary-size + init overhead + battery impact acceptable + store-compliance thresholds met ?" |
| **Anchor** | **SWEBOK v4** : KA6 SE Operations (incident detection + triage). **ISO/IEC 25010:2023** : Reliability (Maturity — crash-free metric, Fault tolerance, Recoverability — offline queue flush), Performance Efficiency (SDK overhead). **ISO/IEC 25023** : measurement for reliability. **Google Play Android Vitals** thresholds (crash rate + ANR rate). **Apple MetricKit** framework. **DORA Metrics** MTTD/MTTR. |
| **Dependances** | **Cross-link D20** (SDK = privacy manifest disclosure, taken as given). **Cross-link F28** (user-id propagation for crash attribution). **Cross-link H33** (symbolication artifact upload is CI step). **Cross-link H36** : same-SDK bundling pattern (Firebase Crashlytics + Analytics) = pattern observation at synthesis, NOT justification to merge PICOCs. **Cross-link D19** (kill-switch triggered by crash signal — D19 has mis-scope, actually lives in H37). |

---

### PICOC #H36 — Engagement + retention + progression analytics (game telemetry observability)

| Element | Valeur |
|---------|--------|
| **P** | Dev indie solo mobile 2D pixel-art portrait offline-first Android+iOS in production avec leaderboards, devant mesurer **player engagement + progression + retention** pour informer content et LiveOps decisions sans dedicated data/analytics function. |
| **I** | Classe des **game-analytics telemetry stacks**. 5 sous-classes : (a) platform-store-analytics only (Play Console engagement + App Store Connect — no custom SDK) ; (b) vendor-managed third-party (Firebase Analytics, Amplitude, Mixpanel, deltaDNA, GameAnalytics) ; (c) self-hosted OSS (PostHog) ; (d) engine-native (Unity Analytics, Godot equivalent) ; (e) no custom analytics baseline. Includes event-schema decision (predefined funnel events GameAnalytics taxonomy "progression / design / business" ↔ ad-hoc ↔ standards-based). Covers : event-schema design (session start/end, level start/complete/fail, progression milestones, feature usage), cohorted retention (D1/D7/D30), session-length + session-count tracking, **offline event queueing + deduplication + clock-skew handling on reconnect**. |
| **C** | À découvrir systématiquement en Phase 2.1 (recherche : Firebase Analytics + Amplitude + GameAnalytics + Unity Analytics docs, indie analytics postmortems, academic papers mobile game analytics, retention KPI measurement literature). **Pre-identification prohibée per Amendement G-1.** |
| **O** | **Mesurables event-stream quality** : (a) retention cohort completeness (% sessions successfully instrumented + uploaded) ; (b) D1/D7/D30 retention measurability ; (c) funnel drop-off identification latency (hours post-release to actionable funnel data) ; (d) event-loss rate under offline conditions (%) ; (e) deduplication correctness on reconnect (%) ; (f) SDK binary-size + init-time overhead (MB + ms). **Decision-quality proxy** : (g) evidence that solo dev ACTUALLY used the data (qualitative : analytics → shipped content change, per primary-study reporting). **User-facing / game KPIs** : (h) session length + count measurability ; (i) feature usage tracking coverage ; (j) progression milestone tracking coverage. **Developer UX** : (k) analytics dashboard learnability for solo operator (time-to-first-insight). |
| **Co** | Solo developer lacks data-engineering capacity → vendor-managed strongly preferred in most studies, BUT cost at scale + data-residency concerns may invert ; **offline-first gameplay = events generated before network availability** → REQUIRES durable client-side queueing ; portrait 2D pixel-art → session lengths tend shorter + more numerous than console-style titles (affects event-volume budgeting) ; leaderboard integration (F26) generates its own telemetry overlapping partially with progression analytics (dedupe at schema-design time). |
| **Question** | "Pour un jeu mobile 2D pixel-art indie solo offline-first Android+iOS avec leaderboards, **quelle classe de game-analytics telemetry stack** (platform-store-only ↔ vendor-managed third-party ↔ self-hosted OSS ↔ engine-native ↔ no-analytics baseline) avec quelle event-schema maturity optimise retention cohort completeness + D1/D7/D30 measurability + offline event queueing correctness + dedupe on reconnect + SDK overhead + analytics dashboard learnability solo, dans les contraintes absence de data-engineering + offline-first = mandatory durable queueing ?" |
| **Anchor** | **SWEBOK v4** : KA6 Operations, KA9 SE Management (decision-loop framing). **ISO/IEC 25019** : Data quality in use (event-stream quality). **ISO/IEC 25023** : measurement. **ISO/IEC 25010** : Functional Suitability (Appropriateness), Usability (developer-facing analytics dashboard). **Note** : game-specific retention KPIs (D1/D7/D30) NOT in ISO 25010 directly — treated as domain-specific outcomes justified by mobile-game-2d context. |
| **Dependances** | **Seam strict with E-family** : monetization funnels (IAP conversion, ad impression → reward, eCPM, ARPDAU, LTV) → E-family, NOT H36. H36 keeps engagement/retention/progression KPIs only. **Cross-link D20** (analytics SDK = privacy manifest disclosure). **Cross-link F28** (user-id propagation for funnel continuity). **Cross-link H35** : same-SDK bundling pattern (Firebase Crashlytics + Analytics) — pattern observation at synthesis, not justification to merge. **Cross-link H37** : measurement half of experimentation loop. |

---

### PICOC #H37 — Remote configuration + feature flags + A/B experimentation

**Note arbitrage** : B proposed absorbing H37 into D19 + H36 but D19 actual scope (dynamic ASSET delivery : PAD, ODR, in-app updates) does NOT cover runtime config. Retained per A's correct identification of distinct intervention surface.

| Element | Valeur |
|---------|--------|
| **P** | Dev indie solo mobile 2D pixel-art portrait offline-first Android+iOS avec ads+IAP+leaderboards, requerant **runtime configurability of client behavior without shipping a new build** : feature gating (hide/show content per cohort), game-balance tuning (drop rates, difficulty curves, energy-system timers), ad-UX experiments (interstitial cadence, rewarded placement — cross-link E22b), IAP storefront experiments (price points, bundle composition), server-driven UI fragments (event banners, seasonal content). **Scope exclut** server-authoritative game state (F26 concern) et build-time configuration (H33 concern). Focus = client-side runtime-config fetch + cache + apply loop. |
| **I** | Classe des **runtime-config + feature-flag + experimentation systems**. 5 sous-classes : (a) Firebase Remote Config (strongly bundled with H35/H36 Firebase observability — integration pull) ; (b) general-purpose feature-flag SaaS (LaunchDarkly, Statsig, Split.io) ; (c) engine-native (Unity Remote Config ou equivalent) ; (d) custom JSON-blob-on-CDN (simplest, common indie) ; (e) no remote config baseline (ship in binary). Additional axes : experiment-assignment strategy (server-side random ↔ client-side hash-based) ; rollout-orchestration coupling with D17 staged rollout (feature-flag-gated ↔ store-track-based) ; targeting granularity (per-user ↔ per-cohort ↔ per-country). |
| **C** | À découvrir systématiquement en Phase 2.1 (recherche : Firebase Remote Config + LaunchDarkly + Statsig docs, academic papers on feature flag architecture + A/B testing for low-DAU apps, CUPED + sequential testing + multi-armed bandits methodology). **Pre-identification prohibée per Amendement G-1.** |
| **O** | **Mesurables experimentation** : (a) experiment-cycle time (idea → deployed experiment → statistically-significant result, days) ; (b) A/B statistical power achievable given game's DAU (% detectable effect at alpha=0.05) ; (c) feature-flag incident blast-radius (ability to kill a bad release via remote kill-switch without store roundtrip, minutes to rollback vs D17 staged rollout baseline). **Mesurables config** : (d) configuration freshness (seconds from publish to client-apply, affected by fetch cadence + cache TTL) ; (e) offline config fallback (last-known-good cache behavior, % sessions correctly served cached config offline). **Cost + compliance** : (f) cost per experiment (SaaS tier + engineering effort) ; (g) privacy/compliance footprint (remote-config SDK telemetry — cross-link D20) ; (h) integration complexity with ad-UX policy E22b + IAP storefront. **Cross-link** : (i) E22b ad cadence experimentation coverage ; (j) kill-switch as inverse deployment (DORA deployment frequency). |
| **Co** | Offline-first : remote-config fetch must tolerate long offline periods — last-known-good cache semantics matter ; ads + IAP heavy → decision most often exercised via remote config = ad cadence / IAP pricing → strong coupling to E22, E23 ; **solo indie low-DAU → statistical-power constraint severe** (thousands not millions DAU) → traditional A/B underpowered ; literature on "feature flags as kill-switch + staged rollout for low-DAU apps" more relevant than industrial-scale A/B ; platform policy : Apple ASRG 3.2.2 (IAP pricing must not be dynamically altered in misleading way) + Google Play Policy on deceptive behavior → remote-config-driven storefront changes have compliance constraints. |
| **Question** | "Pour un jeu mobile 2D pixel-art indie solo offline-first low-DAU avec ads+IAP+leaderboards, **quelle classe de runtime-config + feature-flag + experimentation system** (Firebase Remote Config bundled ↔ LaunchDarkly/Statsig SaaS ↔ engine-native ↔ custom JSON CDN ↔ no-remote-config baseline) optimise experiment-cycle time + statistical power at low DAU + kill-switch blast-radius + config freshness + offline fallback, tout en gardant SaaS cost + privacy footprint + compliance platform (ASRG 3.2.2 + Play deceptive) acceptable ?" |
| **Anchor** | **SWEBOK v4** : KA9 Management (experimentation governance). **ISO/IEC 25010:2023** : Flexibility/Adaptability, Maintainability (Modifiability runtime). **Accelerate book** experimentation culture chapter. **DORA deployment frequency** (kill-switches = inverse deployments). **Apple App Store Review Guidelines** §3.2.2 (IAP pricing integrity). **Google Play Developer Program Policy** deceptive behavior. |
| **Dependances** | **Cross-link D17** staged rollout (feature flag vs store-track rollout — bidirectional, both strategies complementary). **Cross-link E22b** (ad cadence experimentation = most common flag in mobile game ad monetization lit). **Cross-link H36** (measurement half of experimentation loop — statistical power measurement). **Cross-link D20** (remote-config SDK privacy manifest). **Not absorbed by D19** : D19 = dynamic asset delivery (PAD/ODR), NOT runtime config flags. |

---

## Decisions dropped / absorbed

| Decision | Action | Justification |
|----------|--------|---------------|
| H38 Hot reload / live code | ABSORBED A1 | Hot reload = engine-toolchain property (Flutter hot reload, Unity Enter Play Mode, Godot GDScript reload, native Compose/SwiftUI previews). Engine choice (A1) determines regime. Minimal residual once A1 fixed. |

**A1 extraction form enrichment** (action item from Batch H) : A1's extraction form doit inclure explicit field "hot-reload / live-code patching availability + state preservation semantics" to prevent silent evidence loss. Documente en Phase 1.4 amendments.

## Open questions pour Phase 1.5 + cross-batch

### Cross-batch seams

1. **H33 ↔ D17 boundary** : signed artifact handoff. Primary studies describing end-to-end "commit to store" pipelines must be extracted TWICE (once per PICOC, each scoped to its side of the seam) with cross-reference, per Amendment G-1 anti-double-counting.
2. **H34 ↔ C-family seam** (when Batch I Quality is formulated) : if study measures quality attribute ON device → Batch I ; if study SELECTS/justifies device set itself → H34.
3. **H36 ↔ E-family seam** : primary study whose outcome is monetization KPI (ARPDAU, ARPPU, LTV, conversion rate) → E-family, even if uses analytics SDK. H36 keeps engagement/retention/progression KPIs only.
4. **H35 ↔ H36 same-SDK bundling** : Firebase Crashlytics + Analytics = pattern observation at synthesis. Cross-link but separate evidence extraction.
5. **H37 ↔ H36 experimentation loop** : H37 = infrastructure (flag mechanism) ; H36 = measurement (analytics stream). Studies covering full loop extracted into both with cross-reference.

### Questions Agent C Phase 1.5

6. Verifier : **Android Vitals ANR threshold** (0.47% user-perceived) current 2026-04.
7. Verifier : **Apple MetricKit** API current scope (versions added in iOS 16+/17+/18+).
8. Verifier : **Firebase Remote Config** SDK current capabilities (conditional targeting, A/B testing integration).
9. Verifier : **Apple ASRG §3.2.2** IAP pricing integrity clause current wording.

### Phase 2.1 extraction guidance

10. Phase 2.1 pour H33 : chercher **indie solo mobile CI/CD postmortems** (filter dedicated-build-engineer AAA studies).
11. Phase 2.1 pour H34 : chercher **emulator-vs-physical false-negative rate studies** for 2D touch-input games specifically.
12. Phase 2.1 pour H36 : chercher **offline-first event queueing + deduplication** empirical studies.
13. Phase 2.1 pour H37 : chercher **A/B testing at low-DAU** methodology papers (CUPED sensitivity at <10k DAU).

## Statut Batch H

- **5 PICOCs retenues** : H33 (CI/CD), H34 (device testing), H35 (crash+APM), H36 (engagement analytics), H37 (feature flags + A/B)
- **Kappa brut** : 3/5 = 60% ("moderate", just above 0.6 threshold)
- **Divergences principielles documentees** : H35/H36 split (B wins, disjoint evidence bases) + H37 retention (A wins, B mis-identified D19 scope)
- **1 absorption confirmee** : H38 → A1 (with extraction form enrichment action item)
- **Running total apres Batch H : 29 + 5 = 34 PICOCs**

**APPROVED pour Phase 1.3 Batch I (quality).**
