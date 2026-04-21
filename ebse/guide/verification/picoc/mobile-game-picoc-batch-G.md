# Phase 1.3 Batch G — PICOCs : Localization / i18n (domaine `mobile-game-2d`)

**Protocole** : methodology.md v3.0 §1.3 + Amendement G-1 + Amendement #3
**Date** : 2026-04-21
**Methode** : double extraction + reconciliation
**Tracability** :
- Reviewer A : agent `aea460e78cf2a86a4`
- Reviewer B : agent `a89f829b5c6f8abe0`

## Cadre upstream

26 PICOCs formulees. Batch G reprend l'i18n defer de Batch B + commissioning Categorie G.

**Rappel B8** (Batch B) : couvre **font rendering strategy** (bitmap / TTF / SDF / hybrid) + **multi-script glyph coverage** (CJK baseline + Cyrillic + Arabic extended). B8 est rendering-pipeline concern.

## Reconciliation A vs B

| Decision | Verdict A | Verdict B | Accord | Reconciliation |
|----------|-----------|-----------|:------:|----------------|
| G30 workflow + G32 pluralization | MERGE → G30' | KEEP SEPARATE | X | **B wins** : interventions distinctes |
| G31 original (font rendering) | ABSORB B8 | ABSORB B8 | V | ABSORBED |
| G31 residual (RTL/BiDi layout) | RETAIN narrowed → G31' | ABSORB B8 (no residual) | X | **A wins** : layout ≠ rendering, UAX #9 genuine orphan |

**Kappa brut** : 1/3 = 33% ("poor/fair") sur divergences, MAIS **convergence forte** sur G31 font-rendering absorption. Les divergences sont principielles (granularite + boundary-detection), pas arbitraires.

**Arbitrage DIV-G30/G32 merge** :
- **Position A** : catalog format (ICU MessageFormat, gettext PO, stringsdict, XLIFF) bundles storage + plural + interpolation. Solo indie can't decouple. Split = artificial duplication.
- **Position B** : workflow intervention (TMS, translator handoff, CI, storefront sync) != message-format intervention (ICU/CLDR). Overlap 60-70% borderline. Intervention surface NOT singular.

**Arbitrage superviseur** : **B wins (keep separate)**. Rationale :
1. Phase 2.1 literature bases are distinct : (a) TMS evaluations + indie localization workflow postmortems vs (b) ICU MessageFormat spec papers + CLDR plural rule studies + BiDi text rendering academic CL/NLP literature.
2. Intervention surfaces NOT collapsible : you can use Crowdin with stringsdict OR with ICU MessageFormat OR with PO. Workflow is orthogonal to format.
3. Cross-link documented explicitly : catalog format choice constrains workflow options, noted in dependencies.

**Arbitrage DIV-G31 residual** :
- **Position A** : G31' retained narrowed = RTL/BiDi layout (UAX #9) + UI mirroring (start/end, HUD anchors, swipe direction). Genuine orphan — NOT rendering (B8), NOT strings (G30), NOT format (G32).
- **Position B** : "B8 covers multi-script glyph coverage" → fallback chains are rendering mechanism, all absorbed.

**Arbitrage superviseur** : **A wins (retain narrowed)**. Rationale :
1. B8 is strictly about **glyph rendering** (drawing correct glyphs for each Unicode codepoint). B8 does NOT cover layout direction, UI mirroring, or BiDi algorithm for mixed-direction paragraphs.
2. UAX #9 BiDi Algorithm is a **layout-level concern** handling mixed-direction (Arabic paragraph + embedded English brand names + Latin numerals).
3. UI mirroring (HUD elements reversing sides, swipe semantics flipping, progress-bar fill direction) is a **UX/interaction concern**, distinct from rendering.
4. Pixel-art HUDs with hand-placed sprites often bypass automatic platform mirroring → specific pain point for pilot P.

**Final Batch G = 3 PICOCs** : G30 (workflow), G31 (RTL/BiDi layout narrowed), G32 (message format + CLDR pluralization).

## PICOCs retenus — Batch G final

### PICOC #G30 — Localization workflow + release pipeline

| Element | Valeur |
|---------|--------|
| **P** | Dev indie solo produisant un jeu mobile 2D pixel-art portrait offline-first Android+iOS monetise ads+IAP+leaderboards, shippant **multi-language support launch-critical** (EN baseline + ≥2 additional locales from top casual/indie markets : ES, FR, DE, PT-BR, JA, ZH-Hans, KO typical). Unit of study = localization pipeline owned by solo dev : source-string authorship, catalog management, translator handoff (including MT + human post-edit given solo budget), build-time bundling, runtime locale resolution, storefront-side localized listing lifecycle (Play Console + App Store Connect metadata, screenshots, keywords). |
| **I** | Classe des **localization workflows + release pipelines**. 5 axes : (a) **string catalog format** (gettext `.po`, XLIFF 1.2/2.0 OASIS, Android `strings.xml`, Apple `.strings`/`.stringsdict`, Flutter `.arb`, Unity Localization Package native, Godot CSV/PO native) ; (b) **tooling** (open-source / SaaS TMS : Crowdin, Lokalise, Weblate, Transifex, POEditor ; engine-native editors ; spreadsheet-only pipelines) ; (c) **process controls** (pseudo-localization during QA avec length expansion 30-50%, translation memory reuse, continuous-localization CI integration, style-guide + glossary enforcement, in-context screenshot export for translators) ; (d) **storefront workflow** (localized listing authoring aligned Apple HIG + Material Design Localization patterns, localized screenshots/trailers, locale-specific ASO keywords) ; (e) **compliance** (GDPR-mandated locale-specific privacy disclosures + age-rating translations + locale-specific legal text). |
| **C** | À découvrir systématiquement en Phase 2.1 (recherche : TMS vendor docs + independant TMS comparatives, indie game localization postmortems, IGDA Localization SIG resources, W3C i18n WG best practices, academic papers on i18n pipelines). **Pre-identification prohibée per Amendement G-1** (pas de "Crowdin vs Weblate"). |
| **O** | **Mesurables** : (a) locale coverage achieved at launch + sustained across updates (count locales, % strings translated per locale, stale-string ratio) ; (b) defect rates per locale (untranslated strings in release, UI-truncation/overflow on portrait pixel-art UI, encoding defects, mojibake incidents, date/number/currency mis-formatting) ; (c) release-cadence impact (days additional lead time per locale per release, regression rate after adding new locale) ; (d) solo-developer effort (hours per locale per release). **User-facing + market** : (e) market outcomes per locale (downloads, D1/D7/D30 retention, ARPDAU, store-listing conversion rate where reported) ; (f) store-listing / in-app drift (rejection-risk per Apple ASRG §2.3 accurate metadata + Google Play localized listings policy). **Compliance** : (g) presence + accuracy locale-specific privacy disclosures + age-rating translations (GDPR, LGPD pt-BR, PIPL zh-Hans). **Maintenance** : (h) maintainability ISO 25010 modifiability adding new locale post-launch. |
| **Co** | Solo dev NO dedicated localization manager ; budget contraint typically precludes enterprise TMS seats → reliance sur volunteer/community translation, fiverr-tier freelancers, ou LLM-assisted MT avec selective post-edit ; cross-platform build pipeline (Flutter/Unity/Godot/native) producing Android + iOS ; **offline-first MEANS translations must be bundled** (no server-side CMS fetch as primary channel, delta updates in-scope) ; **portrait pixel-art UI severe horizontal budget** on translated labels → truncation risk for DE / RU / FI ; dual-store release + locale-specific regulatory context (GDPR, LGPD, PIPL). |
| **Question** | "Pour un dev indie solo shippant un jeu mobile 2D pixel-art multi-language launch Android+iOS offline-first, **quelle classe de localization workflow + release pipeline** (catalog format + tooling + process controls + storefront workflow + compliance handling) optimise locale coverage + defect rates + release-cadence sustainability + solo-effort hours, dans les contraintes portrait pixel-art UI + offline-first bundling + dual-store + regulatory GDPR/LGPD/PIPL ?" |
| **Anchor** | **SWEBOK v4** : KA1 Requirements (i18n NFRs), KA4 Construction (build pipeline integration), KA9 SE Management (localization process VSE fit). **ISO/IEC 25010:2023** : Maintainability (Modifiability adding new locale), Compatibility (Interoperability TMS + engine + stores), Portability (Adaptability cross-locale). **ISO/IEC 25019** : Quality-in-use locale experience. **ISO/IEC 25023** : measurement. **W3C Internationalization WG** best-practice notes. **Unicode CLDR** locale metadata baseline. **Apple App Store Review Guidelines** §2.3 Accurate Metadata (localized descriptions). **Apple HIG Localization**. **Material Design Localization**. **Google Play Developer Program Policy** localized store listings. **GDPR** Art. 13/14 (localized privacy disclosures), **LGPD**, **PIPL**. **ISO/IEC 29110-4-3** : VSE profile. |
| **Dependances** | **Cross-link G32** (catalog format choice constrains message-format options) — distinct PICOCs but strong coupling, Phase 2.1 extraction tag catalog format per source. **Cross-link B8** (font glyph coverage per locale from B8 feeds G30 workflow inputs — e.g., CJK glyphs required before CJK locale ready). **Cross-link B11** (in-context screenshot export for translators uses pixel-art authoring assets). **Cross-link D20** (locale-specific privacy declarations). **Cross-link D17** (localized store listing = part of release orchestration). |

---

### PICOC #G31 — RTL / BiDi layout + locale-dependent UI mirroring (narrowed)

**Note scope narrowing** : original G31 "font fallback / multi-script support" largely absorbed by B8 (font rendering + glyph coverage). **Retained residual** = RTL/BiDi **layout** + UI mirroring (distinct from rendering per Unicode UAX #9 + Apple HIG / Material Design RTL guidance).

| Element | Valeur |
|---------|--------|
| **P** | Dev indie solo mobile 2D pixel-art portrait Android+iOS declaring support for **≥1 RTL locale** (Arabic `ar`, Hebrew `he`, Persian `fa`, Urdu `ur`), avec in-game HUD + menus + dialogue panels + store-synced assets qui doivent mirror ou explicitly opt out of mirroring (e.g., in-world signage + numerals + progression arrows tied to game-world physics direction). Pixel-art portrait UI avec hand-placed sprites → automatic platform layout mirroring (Apple leading/trailing, Android `supportsRtl` + `start`/`end`) often bypassed par custom game renderers. |
| **I** | Classe des **RTL / BiDi layout handling strategies**. 5 sous-classes / axes : (a) **platform-automatic mirroring** (Android `supportsRtl="true"` + `start`/`end` layout attributes + iOS leading/trailing NSLayoutConstraint / SwiftUI semantic edges) ; (b) **engine-level RTL support** (Unity TextMeshPro Arabic plugin + HarfBuzz integration, Godot BiDi via HarfBuzz, Flutter `Directionality` widget) ; (c) **manual mirroring** of custom-drawn pixel-art HUD sprites avec per-asset opt-out flags for elements that must NOT mirror (e.g., left-facing player-sprite arrow indicating forward motion) ; (d) **BiDi algorithm compliance** (Unicode UAX #9) for mixed-direction strings (Arabic dialogue + embedded English brand names / Latin numerals) ; (e) **input-direction handling** for swipe gestures + progress bars + timeline scrubbers ou "forward in time" conventionally flows right-to-left in RTL but game mechanics may override. |
| **C** | À découvrir systématiquement en Phase 2.1 (recherche : Unicode UAX #9 Bidirectional Algorithm spec, Apple HIG Right-to-Left, Material Design Bidirectionality, indie mobile game RTL support postmortems, academic papers on BiDi algorithm implementation). **Pre-identification prohibée per Amendement G-1** (pas de "Unity TextMeshPro Arabic vs custom BiDi"). |
| **O** | **Mesurables** : (a) layout correctness — % HUD elements rendering in semantically correct start/end position per locale ; (b) BiDi string correctness — rate of correct mixed-direction rendering (Arabic + Latin numerals / brand names per UAX #9) ; (c) mirroring-error count — incorrectly mirrored game-world sprites carrying false semantics ; (d) additional art/asset cost to produce mirrored pixel-art sprites + per-asset opt-out metadata (developer-hours + new sprite count) ; (e) input direction correctness under RTL (swipe semantic correctness % ; progress-bar fill direction correctness % ; timeline scrubber user-comprehension) ; (f) HarfBuzz + OpenType shaping engine integration cost + binary size delta. **User-facing** : (g) RTL-locale user-facing defect rate from store reviews + crash/NPS proxies ; (h) perceived polish quality RTL users (expert review or playtest rating). **Compliance** : (i) Apple HIG RTL conformance score (binary or rubric) ; (j) Material Design Bidirectionality conformance ; (k) Apple ASRG §4 Design quality risk (broken RTL presentation rejection risk). |
| **Co** | Portrait 2D pixel-art UI avec hand-placed HUD ; solo indie NO dedicated localization QA, limited art budget for mirrored assets ; **offline-first** (no server-driven layout swap) ; dual-store avec differing default RTL support maturity (Android automatic since API 17 when declared ; iOS automatic since iOS 9 with Auto Layout, but custom game renderers bypass Auto Layout) ; interacts avec B8 (glyph rendering for Arabic script shaping via HarfBuzz) ; interacts avec G32 (Arabic plural categories = 6 CLDR classes compounding with RTL layout). |
| **Question** | "Pour un jeu mobile 2D pixel-art portrait indie solo supportant ≥1 RTL locale avec hand-placed pixel-art HUD, **quelle classe de RTL / BiDi layout handling strategy** (platform-automatic mirroring / engine-level RTL / manual mirroring avec opt-out flags / BiDi UAX #9 / input-direction handling) optimise layout correctness + BiDi string correctness + mirroring-error count + additional-art-cost + input-direction semantics ?" |
| **Anchor** | **Unicode Standard Annex #9** (Bidirectional Algorithm). **Unicode CLDR** locale metadata (character direction). **SWEBOK v4** : KA3 Design (UI/layout design), KA4 Construction (platform integration). **ISO/IEC 25010:2023** : Usability (Operability RTL, Inclusivity/Accessibility, User error protection — swipe direction misinterpretation), Compatibility (Interoperability cross-locale). **ISO/IEC 25019** : Quality-in-use RTL users. **Apple Human Interface Guidelines** Right-to-Left. **Material Design** Bidirectionality. **Apple App Store Review Guidelines** §4 Design. **W3C i18n WG** Structural markup RTL (analogous principles). |
| **Dependances** | **Downstream B8** (glyph rendering Arabic via HarfBuzz ou equivalent is prerequisite to layout). **Cross-link G30** (RTL locales = subset of G30 locales list). **Cross-link G32** (Arabic 6-plural-class interaction with layout). **Cross-link A6** (input / gesture direction semantics in RTL). |

---

### PICOC #G32 — Message format correctness + CLDR pluralization + locale-aware interpolation

| Element | Valeur |
|---------|--------|
| **P** | Dev indie solo mobile 2D pixel-art portrait offline-first Android+iOS, scope narrowed a **runtime message resolution layer + authored message-format artifacts**. Strings containing variable interpolation (player name, score, item count, currency, time remaining), plural-dependent phrases (`1 coin` / `N coins` avec richer CLDR zero/one/two/few/many/other partition AR/RU/PL/CS/GA/CY), gender-selected phrases, locale-aware number/date/currency/relative-time formatting. Locales in scope = CLDR plural-rule equivalence classes actually hit by pilot target-market set (minimum EN + ES + FR + DE + PT-BR + JA + ZH-Hans + KO, plus RU ou AR ou plural complexity est non-trivial). |
| **I** | Classe des **message format + CLDR pluralization + locale-aware interpolation strategies**. 5 axes : (a) **ICU MessageFormat** (ou conformant subset/port — Fluent from Mozilla, `messageformat.js`, `intl-messageformat`, Android ICU bindings, Apple `stringsdict`, Unity SmartFormat, Flutter `intl` generating ARB with ICU syntax) for plural/select/ordinal selectors + named placeholders ; (b) **CLDR plural rules** as authoritative category source (via maintained CLDR snapshot vs hand-coded `if (n==1)` heuristics) ; (c) **locale-aware formatters** (numbers `Intl.NumberFormat` / `NSNumberFormatter` / `NumberFormat`, dates/times, currencies IAP display, relative time leaderboard events, lists) ; (d) **named-placeholder + positional-reorder discipline** so translators can reorder arguments for SOV languages (JA, KO) + RTL (AR, HE) without code changes ; (e) **escape/quoting conventions** for ICU-reserved characters + Unicode bidi controls (LRM/RLM/FSI) where mixed-direction content appears in pixel-art HUDs. |
| **C** | À découvrir systématiquement en Phase 2.1 (recherche : Unicode CLDR spec + plural rules tables, ICU MessageFormat spec, W3C i18n WG, academic papers on i18n message formats, indie mobile game i18n postmortems, engine-specific i18n docs Unity Localization / Flutter `intl` / Godot / Apple stringsdict / Android plurals.xml). **Pre-identification prohibée per Amendement G-1** (pas de "ICU MessageFormat vs Fluent vs gettext"). |
| **O** | **Mesurables linguistic correctness** : (a) mis-pluralised strings count ; (b) wrong gender form count ; (c) incorrect ordinal forms ; (d) number/date/currency wrong locale format incidents ; (e) bidi rendering errors mixed-direction ; (f) placeholder-order bugs post-translation. **Measured via** : locale-reviewer audit rate + crash/assertion counts from malformed messages + player-reported locale bug tickets. **Mesurables translator productivity** : (g) queries per 100 strings (ambiguity = translator questions) ; (h) rework rate ; (i) ability to reorder placeholders without developer intervention (% messages correctly reordered by translator). **Mesurables coverage** : (j) coverage of CLDR plural categories actually exercised by shipped messages (correctness-completeness metric). **Mesurables runtime/build** : (k) runtime performance overhead of message-format library (parse/cache cost per frame-safe budget on low-end Android) ; (l) binary-size impact ICU data or CLDR subsets (MB delta) ; (m) maintainability ISO 25010 modifiability adding new locale whose plural class differs (e.g., adding AR after EN/ES/FR). **User-facing** : (n) user-perceived linguistic quality ISO 25019 per locale. |
| **Co** | Runtime contraints offline-first 2D pixel-art mobile : NO server-side formatting fallback, ICU data MUST fit app bundle (Android ICU system-provided API ≥ 24, iOS Foundation formatters, cross-platform engines ship their own ICU subset — Unity/Flutter/Godot differ in CLDR coverage + update cadence) ; portrait pixel-art HUD tight glyph budgets making length-sensitive plural forms (RU "many", DE compound nouns) a **layout hazard** (interacts with B8 font + G31 layout but message-format semantics is G32's unit) ; monetization context IAP price display + leaderboard rank/score = high-frequency plural/number targets ; ad-related disclosure copy must be locale-correct for store compliance. |
| **Question** | "Pour un jeu mobile 2D pixel-art indie solo offline-first multi-language Android+iOS, **quelle classe de message format + CLDR pluralization + locale-aware interpolation strategy** (ICU MessageFormat / Fluent / stringsdict-plurals / hand-rolled / printf-positional / binary-only pluralization) optimise linguistic correctness + translator productivity + CLDR plural-category coverage + runtime/build cost + maintainability adding new plural classes ?" |
| **Anchor** | **Unicode CLDR** (authoritative plural rules). **Unicode Standard** + **UAX #35** (locale data). **ICU User Guide** MessageFormat specification. **SWEBOK v4** : KA2 Design (message format design), KA4 Construction (i18n library integration). **ISO/IEC 25010:2023** : Functional Suitability (Correctness — linguistic), Usability (Appropriateness Recognizability, Inclusivity), Performance Efficiency (runtime message-format parsing), Maintainability (Modifiability adding locales). **ISO/IEC 25019** : Quality-in-use linguistic correctness per locale. **W3C Internationalization WG** best-practice Strings + Structured Text. **Apple HIG** Localization (stringsdict plurals). **Material Design** Localization (plurals + gender). **ISO/IEC 29110-4-3** : VSE profile. |
| **Dependances** | **Strong coupling G30** (catalog format choice in G30 constrains message format options — stringsdict+plurals.xml vs ICU Message inline vs PO). **Cross-link G31** (bidi controls LRM/RLM/FSI in interpolated strings). **Cross-link B8** (font coverage for numerals + ordinals per script). **Cross-link E23** (IAP price display = high-frequency G32 number formatter usage). **Cross-link F26** (leaderboard rank ordinals + score plurals). |

---

## Decisions dropped / absorbed

| Decision | Action | Justification |
|----------|--------|---------------|
| G31 original font fallback / multi-script glyph coverage | ABSORBED B8 | B8 scope = font rendering + multi-script glyph coverage. Fallback chains = mechanism achieving coverage. (a)(b)(c) sub-topics from G31 original all covered by B8. |
| OS share sheet localization | OUT OF SCOPE | OS share sheet trivial integration (already ruled out in F29 narrowing). Localized share text = runtime interpolation = G32 scope. |

## Open questions pour Phase 1.5 + cross-batch

1. **G30 + G32 strong coupling** : bien que PICOCs separes, l'extraction Phase 2.1 doit tagger chaque source par le catalog format pour permettre cross-reference. G30 literature focus = process/workflow ; G32 focus = format semantics ; catalog format is joint variable.
2. **G31 + G32 + B8 layout+rendering chain** : Phase 2 synthesis doit articuler : B8 rendering → G31 layout → G32 semantics. Failure in any layer breaks RTL experience.
3. **Amendement post-pilot possible** : si Phase 2.1 literature surface montre G30 + G32 treated as single unit dans la grande majorite des studies, revisite merge en Phase 1.5b.

### Questions Agent C Phase 1.5

4. Verifier : **Unicode UAX #9 current version** (2026-04).
5. Verifier : **CLDR latest release** + plural rules current tables.
6. Verifier : **ICU MessageFormat spec** current scope.
7. Verifier : **Apple HIG Right-to-Left** + **Material Design Bidirectionality** scope.

### Phase 2.1 extraction guidance

8. Phase 2.1 pour G30 : chercher **indie scale localization postmortems** (filter AAA MMO studies).
9. Phase 2.1 pour G31 : chercher **pixel-art RTL UI mirroring** specifically (custom renderer bypass of platform auto-mirror).
10. Phase 2.1 pour G32 : chercher **CLDR plural category coverage** empirical studies + binary-size vs CLDR subset trade-offs.

## Statut Batch G

- **3 PICOCs retenues** : G30 (workflow), G31 (RTL/BiDi layout narrowed), G32 (message format + pluralization)
- **Kappa brut divergences** : 1/3 = 33% (poor/fair) — arbitrage principiel documente
- **Kappa global** : convergence forte sur G31 font-rendering absorption par B8
- **Running total apres Batch G : 26 + 3 = 29 PICOCs**

**APPROVED pour Phase 1.3 Batch H (dev tooling).**
