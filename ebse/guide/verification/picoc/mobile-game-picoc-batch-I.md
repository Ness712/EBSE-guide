# Phase 1.3 Batch I — PICOCs : Quality (domaine `mobile-game-2d`)

**Protocole** : methodology.md v3.0 §1.3 + Amendement G-1 + Amendement #3
**Date** : 2026-04-21
**Methode** : double extraction + reconciliation
**Tracability** :
- Reviewer A : agent `afa07d29bb6bf97c9`
- Reviewer B : agent `aa5f85791c76f98cd`

## Cadre upstream

34 PICOCs formulees. Quality concerns largely distributed upstream :
- **A1** : frame time, cold-launch, bundle size vs store caps (150/200 MB), memory, crash-free, battery drain, pixel-art fidelity
- **A6** : input + WCAG 2.2 + HIG accessibility
- **B8** : font + text scaling accessibility
- **G31** : RTL/BiDi layout
- **E22b** : ad UX accessibility
- **H34** : device testing matrix
- **H35** : crash-free rate + ANR + Android Vitals thresholds

## Reconciliation A vs B

| Decision | Verdict A | Verdict B | Accord | Reconciliation |
|----------|-----------|-----------|:------:|----------------|
| I37 Test methodology | RETAIN | RETAIN | V | RETAIN |
| I38 Perf budget | RETAIN NARROWED | ABSORB A1+G30+H35 | X | **ABSORB (B wins)** |
| I39 Game-specific a11y | RETAIN | RETAIN | V | RETAIN |
| I40 Crash-free target | DROP (→ H35) | DROP (→ H35) | V | DROP |

**Kappa : 3/4 = 75% ("substantial")**.

**Arbitrage DIV-I38** :
- **Position A (RETAIN NARROWED)** : I38' scope = perf budgeting governance + battery + thermal + install-cap store compliance. Exclusion A1-owned outcomes.
- **Position B (ABSORB)** : A1 outcomes déjà couvrent frame time / cold-launch / bundle size vs store caps / memory / battery drain. Reframing attempts collapse into A1 + G30 + H35.

**Arbitrage superviseur** : **B wins — ABSORB**. Rationale :
1. **Relecture A1 outcomes confirme** : A1 outcome list explicit (a) median+p99 CPU frame time, (b) cold-launch time, (c) release bundle size vs store caps (Play 150MB / App Store 200MB), (d) memory footprint, (e) crash-free session rate, (f) battery drain mAh/hour session active. **Install-cap compliance EST inclus dans A1**.
2. Residuels thin identifies par A :
   - **Thermal throttling** : absent explicite de A1 → absorbe comme A1 extraction sub-finding
   - **CI perf regression gates** : = H33 "automated test gates" scope
   - **RUM post-launch perf monitoring** : = H36 analytics scope
3. Amendement G-1 aggressive absorption directive : residuels trop thin pour PICOC distincte. Pattern noted at synthesis, not reified at formulation.

**Action** : A1 extraction form enriched (Phase 1.4 amendments) avec explicit sub-findings slot pour "thermal throttling onset + governance" + "perf regression CI gate effectiveness cross-reference H33".

**Final Batch I = 2 PICOCs** : I37 (test methodology), I39 (game-specific a11y).

## PICOCs retenus — Batch I final

### PICOC #I37 — Test design methodology for gameplay code

**Rationale retention** : distinct from H34 (infrastructure — devices) et A4' (determinism runtime property). Addresses *how* gameplay logic tested — methodology question per SWEBOK KA5 + ISO 29119-4.

| Element | Valeur |
|---------|--------|
| **P** | Source code artifacts of solo indie / small team (≤5 FTE) 2D pixel-art portrait mobile games (Android + iOS), offline-first, monetized ads+IAP+server-backed leaderboards, ou V&V activity budget contraint (≤20% engineering time per SWEBOK KA5 solo-team norms ISO 29110-4-3). Specifically gameplay logic modules : ECS systems, physics handlers, state machines, procedural generation, save/load, economy/IAP logic, leaderboard submission paths. **Out-of-scope** : 3D games, multiplayer netcode (no netcode in pilot P), console/PC ports, middleware SDK internals, device-farm infrastructure (H34), determinism property itself (A4'). |
| **I** | Classe des **test design methodologies** applied to gameplay code. 5 sous-classes : (a) **unit testing** of pure gameplay functions (damage calc, state transitions, economy formulas) avec mocking engine subsystems ; (b) **integration testing** of engine-game boundary (scene loading, asset pipeline, save/load round-trip) ; (c) **property-based testing** (Hypothesis/fast-check-style generators) for invariants (e.g., "score monotonic", "inventory weight ≤ cap", "RNG stream reproducible") ; (d) **replay-based regression testing** (record input stream, assert deterministic output — consumes A4' determinism property) ; (e) **playtesting protocols** (moderated/unmoderated, think-aloud, telemetry-instrumented) as empirical test technique per ISO 29119-4 Annex on experience-based techniques. Selection = mix-and-weighting of techniques under solo-indie budget constraint. |
| **C** | À découvrir systématiquement en Phase 2.1 (recherche : ISO 29119-4 test design techniques catalog, ACM/IEEE game testing literature, GDC QA talks, property-based testing in games academic papers — e.g., Hughes QuickCheck original + game-specific applications, replay-based regression case studies, indie game postmortems V&V activities). **Pre-identification prohibée per Amendement G-1.** |
| **O** | **Mesurables defect detection** : (a) pre-release defects found per test technique (count + severity distribution) ; (b) escape rate to production within 30 days of launch (defects leaked per release) ; (c) regression catch rate across patch releases (% regressions caught pre-release) ; (d) defect-detection effectiveness per engineer-hour invested per technique. **Coverage metrics** : (e) line/branch coverage on gameplay modules (%) ; (f) **state-space coverage** for state-machine-heavy code ; (g) replay-scenario coverage (% of critical input sequences validated). **Execution characteristics** : (h) test-suite execution time on solo-indie CI (GitHub Actions free tier, self-hosted MacBook — minutes for full suite) ; (i) **flakiness rate** (replay tests particularly sensitive to determinism gaps — cross-link A4') ; (j) effort cost (author-hours per test, maintenance overhead per release). **Playtest-specific** : (k) session completion rate, critical-incident count, qualitative usability severity (ISO 25019 quality-in-use). |
| **Co** | Solo indie / 1-5 person studio ; 2D pixel-art mobile game ; offline-first ; Android + iOS dual-target ; typical release cadence (frequent patches for live-ops with leaderboards) ; pre-launch + post-launch patch phases ; constrained CI budget ; NO dedicated QA engineer typical ; A4' determinism property available (enables replay-based testing if chosen). |
| **Question** | "Pour un dev indie solo / small team shippant un jeu mobile 2D pixel-art offline-first Android+iOS avec gameplay logic modules (ECS, physics, state machines, save/load, economy/IAP, leaderboard paths), **quelle classe / quel mix de test design methodologies** (unit + integration + property-based + replay-based + playtesting — ad-hoc baseline vs structured mix) optimise defect-detection effectiveness + regression catch rate + coverage state-space + execution time + flakiness + effort cost sous budget V&V contraint ≤20% engineering time ?" |
| **Anchor** | **SWEBOK v4** : KA5 Software Testing (§2 test levels, §3 test techniques). **ISO/IEC/IEEE 29119-4** (test design techniques — specification-based, structure-based, experience-based). **ISO/IEC 29119-1** (test process framework). **ISO/IEC 25010:2023** : Functional Suitability (Correctness), Reliability (Faultlessness). **ISO/IEC 25019** : Quality-in-use (playtest outcomes). **ISO/IEC 29110-4-3** : VSE profile V&V resource-proportionality. |
| **Dependances** | **Consumes A4'** (determinism property enables replay-based regression). **Cross-link H34** (infrastructure devices for running tests ; H34 = on what, I37 = what tests). **Cross-link H33** (CI automated test gates). **Cross-link H35** (pre-release V&V informs production-side crash-free target). **Seam H34** : if study measures quality ON device → H34 ; if study SELECTS/designs tests → I37. |

---

### PICOC #I39 — Game-specific accessibility accommodations (residual)

**Rationale retention** : residuel après A6 (input WCAG 2.2), B8 (font WCAG text scaling), G31 (RTL/BiDi), E22b (ad UX a11y). Residuel = **gameplay-layer** accommodations addressed by Game Accessibility Guidelines + CVAA + EAA 2025 — distinct body of knowledge + increasingly legal requirement (EAA 2025 enforceable June 2025 ; current date 2026-04-21 place ~10 months post-enforcement).

| Element | Valeur |
|---------|--------|
| **P** | Dev indie solo mobile 2D pixel-art portrait offline-first Android+iOS avec ads+IAP+leaderboards, **global distribution** (inherently includes US CVAA jurisdiction + EU post-EAA-2025). **Scope** : gameplay mechanics, dialogue/narrative systems, visual design (palette, motion), audio cues. **Out-of-scope** : UI control a11y (A6), text rendering (B8), RTL/BiDi (G31), ad-unit a11y (E22b), assistive-tech OS APIs (partial A6 overlap — focus here = game-internal accommodations, not OS integration). |
| **I** | Classe des **game-internal accessibility features**, organized par Game Accessibility Guidelines tiers (Basic + Intermediate + Advanced). 4 categories : **(a) Visual** : colorblind modes (Protanopia, Deuteranopia, Tritanopia palette shifts ; daltonization filters) ; non-color-alone information encoding (shape/pattern cues) ; high-contrast sprite modes beyond B8 text ; adjustable sprite outline/silhouette emphasis. **(b) Motor (gameplay-level)** : auto-aim / aim-assist ; hold-to-toggle for sustained inputs (rapid-fire, charge) ; adjustable input-timing windows (parry/dodge leniency) ; **difficulty sliders** or granular difficulty axes (damage taken, damage dealt, enemy speed independent) ; pause-anywhere ; one-handed portrait layout option. **(c) Cognitive** : **reduced motion** mode (dampened screen shake, disabled parallax, reduced particle density ; respect `prefers-reduced-motion` OS setting where bridged) ; on-demand tutorials ; objective reminders ; adjustable game speed ; skippable timed events. **(d) Hearing** : **captions for dialogue** avec speaker ID ; captions for non-speech audio (important SFX — footsteps, directional cues) ; visual indicators for directional audio ; customizable caption size/background (intersects B8 but game-side surfaces). **(e) Haptic** (cross-channel) : redundant haptic feedback for gameplay events (sensory substitution for audio). |
| **C** | À découvrir systématiquement en Phase 2.1 (recherche : Game Accessibility Guidelines gameaccessibilityguidelines.com tier catalog, Can I Play That ? reviews, Xbox Accessibility Team publications, CVAA §§202-203 captioning guidance, EAA 2025 Directive (EU) 2019/882 Annex I §IV audio-visual media, academic papers game accessibility empirical studies, IGDA Game Accessibility SIG resources). **Pre-identification prohibée per Amendement G-1.** |
| **O** | **Mesurables conformance** : (a) Game Accessibility Guidelines Basic tier conformance (binary per guideline — count satisfied / total) ; (b) Intermediate tier conformance (count satisfied) ; (c) CVAA §203 captioning conformance (binary, applies if game has advanced-communications features like in-game chat) ; (d) EAA 2025 Annex I §IV conformance readiness (binary, given June-2025 enforcement + current 2026-04-21 → active obligation) ; (e) Apple App Store Review Guidelines §1.5 Accessibility pass-rate (proxy : rejection-on-accessibility count). **Reach impact** : (f) measured reach impact (% players with disability-related accessibility-mode activation — industry benchmarks via Xbox/Microsoft Accessibility Team publications, Steam Hardware Survey). **User-reported** : (g) accessibility-focused playtest panel usability scores (ISO 25019 §6 accessibility-in-use) ; (h) store-review sentiment on a11y features ; (i) 1-star rate citing a11y gaps. **Implementation cost** : (j) implementation cost per feature (engineer-days — CRITICAL for solo-indie ISO 29110-4-3 budget) ; (k) pixel-art palette constraint impact (e.g., deuteranopia/protanopia-safe 16-color ramps vs 32-color base palette trade-offs). **Legal-risk exposure** : (l) EAA 2025 non-compliance penalties exposure EU jurisdiction. **Engagement** : (m) engagement/retention differential parmi players activating each feature. |
| **Co** | Solo indie with severely limited design/engineering budget ; **2D pixel-art constraint** (low-resolution limits some visual a11y techniques — e.g., complex daltonization filters — but simplifies others — e.g., palette swap trivial in pixel art, chunky shapes aid readable silhouettes) ; **mobile form-factor** (portrait touch-only input — constrains motor-assist options vs controller-based console games) ; **global distribution** (CVAA US + EAA EU jurisdictions) ; **post-EAA-2025 regulatory environment** (current date 2026-04-21 — EAA active ~10 months, literature base accumulated) ; offline-first (NO cloud-based a11y services, e.g., cloud TTS fallback unavailable). |
| **Question** | "Pour un jeu mobile 2D pixel-art indie solo offline-first globalement distribue Android+iOS post-EAA-2025, **quel tiered set de game-internal accessibility features** (Visual palette+contrast / Motor aim-assist+difficulty+one-handed / Cognitive reduced-motion+difficulty-sliders+pause-anywhere / Hearing captions+visual-audio-indicators / Haptic) satisfait Game Accessibility Guidelines Basic+Intermediate tiers + CVAA + EAA 2025 conformance + ASRG §1.5 + ISO 25019 accessibility-in-use, tout en gardant implementation cost solo dev sustainable + pixel-art palette coherence preserved ?" |
| **Anchor** | **Game Accessibility Guidelines** (community-maintained Basic/Intermediate/Advanced tiers — flagged as grey-literature anchor per Amendement #3, widely cited in practice but not formal standard). **CVAA** (47 U.S.C. §§303/716, FCC rules) — applies to advanced-communications-services ; arguable extension via leaderboard/chat features. **EAA 2025** — European Accessibility Act, Directive (EU) 2019/882, Annex I §IV, enforcement 28 June 2025. **Apple App Store Review Guidelines** §1.5 (Accessibility). **Apple HIG Accessibility**. **Android Accessibility Developer Guide** (game-surface applications beyond stock widgets). **WCAG 2.2** as **residual baseline only** (upstream-owned in A6/B8/G31/E22b ; NOT primary anchor here). **ISO/IEC 25010:2023** : Usability (Inclusivity sub-characteristic new 2023). **ISO/IEC 25019** : Quality-in-use §6 accessibility. **ISO/IEC 29110-4-3** : VSE profile. |
| **Dependances** | **Orthogonal to A6** (A6 = touch-target WCAG 2.5.8 ; I39 = gameplay behavior — auto-aim, one-handed mode, difficulty sliders). **Orthogonal to B8** (B8 = UI text ; I39 = SFX captions + palette + animation reduction non-text modalities). **Orthogonal to G31** (G31 = RTL layout ; I39 = perceptual/motor modalities). **Orthogonal to E22b** (E22b = ad-close-button ; I39 = game-world interaction NOT ad unit). **Cross-link H34** : device testing matrix doit inclure accessibility-mode validation. |

---

## Decisions dropped / absorbed

| Decision | Action | Justification |
|----------|--------|---------------|
| I38 Perf budget | ABSORBED A1 + H33 + H36 | A1 outcomes déjà couvrent frame time + cold-launch + bundle size vs store caps + memory + battery drain + crash-free. Thermal = A1 extraction sub-finding (action item for Phase 1.4 amendments). CI perf regression gates = H33 scope. RUM post-launch perf monitoring = H36 analytics scope. Amendement G-1 aggressive absorption — residuels trop thin pour PICOC distincte. |
| I40 Crash-free rate target | ABSORBED H35 | H35 déjà owns crash-free-users-rate + ANR rate + Android Vitals bad-behaviour thresholds (Google Play default 1.09% crash / 0.47% ANR) + Apple MetricKit. I40 = just outcome side of H35 (target setting without distinct intervention). |

**Action items Phase 1.4 amendments** :
1. **A1 extraction form enriched** : explicit sub-findings slot for (i) thermal throttling onset governance, (ii) perf regression CI gate effectiveness cross-reference H33, (iii) RUM post-launch perf monitoring cross-reference H36. Prevents silent evidence loss from I38 absorption.

## Open questions Phase 1.5 + cross-batch

### Cross-batch interactions

1. **I37 ↔ H34 seam** : if study measures quality ON device → H34 ; if study SELECTS/designs tests → I37. Phase 2.1 extraction tag clearly.
2. **I37 ↔ A4' consumption** : replay-based regression tests consume A4' determinism property. Joint extraction (studies on replay regression testing mention determinism prerequisite) flagged in both PICOCs.
3. **I39 ↔ A6/B8/G31/E22b WCAG-mapped upstream** : extraction template doit tagger chaque a11y study par which PICOC owns it. Games-specific guidelines (GAG) flags vs WCAG flags separated clearly.
4. **I39 ↔ H34 device testing a11y** : H34 matrix should include accessibility-mode validation (colorblind mode, caption mode) as explicit test types.
5. **I38 absorption → A1 extraction enrichment** : verify A1 extraction form captures thermal + perf regression governance sub-findings in Phase 2.

### Questions Agent C Phase 1.5

6. Verifier : **Game Accessibility Guidelines** Basic/Intermediate/Advanced tier structure current (gameaccessibilityguidelines.com).
7. Verifier : **EAA 2025 Annex I §IV** audio-visual media requirements scope + applicability to mobile games.
8. Verifier : **CVAA §203** captioning scope for games with communications features (in-game chat).
9. Verifier : **Android Vitals thresholds** current values (crash rate 1.09% + ANR 0.47% per H35) 2026-04.
10. Verifier : **iOS MetricKit** energy + thermal APIs current scope.
11. Verifier : **ISO/IEC 29119-4** test design techniques catalog current version.

### Phase 2.1 extraction guidance

12. Phase 2.1 pour I37 : chercher **solo indie game V&V postmortems** specifiquement (filter AAA QA team studies).
13. Phase 2.1 pour I37 : chercher **replay-based regression testing for games** empirical studies.
14. Phase 2.1 pour I37 : chercher **property-based testing in games** applications (invariants on state machines + RNG streams).
15. Phase 2.1 pour I39 : chercher **post-EAA-2025 mobile game compliance** empirical studies (will accumulate through 2026).
16. Phase 2.1 pour I39 : chercher **pixel-art colorblind palette design** specifique (constrained palette a11y trade-offs).

## Statut Batch I

- **2 PICOCs retenues** : I37 (test methodology), I39 (game-specific a11y residual)
- **Kappa brut** : 3/4 = 75% ("substantial")
- **2 absorptions confirmees** : I38 → A1+H33+H36 (with A1 enrichment action item) ; I40 → H35
- **Running total apres Batch I : 34 + 2 = 36 PICOCs**

**APPROVED pour Phase 1.3 Batch J (AI collaboration inheritance).**
