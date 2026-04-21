# Extraction Form — PICOC G32 : Message Format + CLDR Pluralization + Locale-Aware Interpolation

**Domain** : mobile-game-2d
**PICOC #** : G32
**Date extraction** : 2026-04-21
**Reviewers** : A + B (isolated) + Agent C verification
**Protocol** : Kitchenham & Charters 2007 §2.4 (Data Extraction) + Amendment G-1 + #3 + MG-6 (strong coupling G30 catalog format, cross-link G31 UAX #9 isolates, cross-link B8 glyph coverage, cross-link E23 IAP price display, cross-link F26 leaderboard rank ordinal / score plural)

## PICOC formel

| Element | Value |
|---------|-------|
| **P** (Population) | Solo indie dev shipping a 2D pixel-art portrait offline-first Android+iOS game with ads+IAP+leaderboards. Scope narrowed to the **runtime message resolution layer + authored message-format artifacts**. Strings with variable interpolation (player name, score, item count, currency, time remaining), plural-dependent phrases (CLDR 6 categories : zero/one/two/few/many/other for AR/RU/PL/CS/GA/CY), gender-selected phrases, locale-aware number/date/currency/relative-time formatting. Locales in scope = CLDR plural-rule equivalence classes hit by pilot target-market set : EN + ES + FR + DE + PT-BR + JA + ZH-Hans + KO plus RU and/or AR. Budget open-source strict : no SaaS message-format tooling. |
| **I** (Intervention) | Message format + CLDR pluralization + locale-aware interpolation strategy class. Five axes : (a) **ICU MessageFormat 1** (or conformant subset/port — Fluent, `messageformat.js`, Android ICU bindings, Apple `stringsdict`, Unity SmartFormat, Flutter `intl` ARB, Godot gettext PO with `plural-forms` header) ; (b) **CLDR plural rules** as authoritative category source (maintained CLDR snapshot vs hand-coded `if (n==1)` heuristics) ; (c) **locale-aware formatters** (numbers, dates, currencies, relative time, lists) ; (d) **named-placeholder + positional-reorder discipline** so translators can reorder arguments for SOV languages (JA, KO) + RTL (AR, HE) without code changes ; (e) **escape/quoting conventions** for ICU-reserved characters + Unicode bidi controls (LRM / RLM / FSI) where mixed-direction content appears in pixel-art HUDs. Includes **hand-rolled printf** baseline. |
| **C** (Comparator) | Discovered via Phase 2.1 systematic search (G-1) — no pre-identification |
| **O** (Outcome) | Linguistic correctness : mis-pluralised strings count, wrong gender form count, incorrect ordinal forms, wrong locale number/date/currency format incidents, BiDi rendering errors, placeholder-order bugs post-translation. Translator productivity : queries per 100 strings (ambiguity = questions), rework rate, % messages correctly reordered without dev intervention. Coverage of CLDR plural categories actually exercised (correctness-completeness metric). Runtime/build : message-format library parse/cache cost per frame-safe budget on low-end Android, binary-size impact of ICU data or CLDR subsets (MB delta), ISO 25010 Modifiability for adding a locale with new plural class. User-facing ISO 25019 perceived linguistic quality per locale |
| **C** (Context) | Offline-first : no server-side formatting fallback, ICU data MUST fit app bundle (Android ICU system-provided API ≥ 24, iOS Foundation formatters, cross-platform engines ship their own ICU subset — Godot PO + message-format library candidate) ; portrait pixel-art HUD tight glyph budgets making length-sensitive plural forms (RU many, DE compound nouns) a layout hazard ; IAP price display + leaderboard rank/score = high-frequency plural/number targets ; ad-related disclosure copy must be locale-correct for store compliance ; **budget strict-OSS** — ICU4C / ICU4J / CLDR / `messageformat` OSS libraries only, no SaaS message-format service. |
| **Anchor** | Unicode CLDR (authoritative plural rules) ; Unicode Standard + UAX #35 (locale data) ; ICU User Guide MessageFormat 1 specification ; SWEBOK v4 KA2 Design + KA4 Construction ; ISO/IEC 25010:2023 Functional Suitability (Correctness linguistic), Usability (Appropriateness Recognizability, Inclusivity), Performance Efficiency (message-format parsing), Maintainability (Modifiability adding locales) ; ISO/IEC 25019 Quality-in-use linguistic correctness ; W3C Internationalization WG best-practice Strings + Structured Text ; Apple HIG Localization (stringsdict plurals) ; Material Design Localization (plurals + gender) ; ISO/IEC 29110-4-3 VSE |

## Candidates discovered (not pre-identified, G-1 archetype classes)

| # | Archetype class | Representative | CLDR plural coverage | Bundled-ICU cost | Evidence |
|---|-----------------|----------------|:--------------------:|:----------------:|----------|
| 1 | **ICU MessageFormat 1 + CLDR 6 categories** | **`messageformat` lib + CLDR plural data** | full (6 categories) | moderate | ICU + CLDR docs |
| 2 | gettext PO `plural-forms` header | gettext native (Godot native path) | partial (Plural-Forms header expression) | minimal | gettext docs |
| 3 | Apple `stringsdict` + Android `plurals.xml` | platform-native plural containers | full CLDR | zero (OS-provided) | Apple + Android docs |
| 4 | Fluent (Mozilla) | `fluent-rs` / `fluent-dom` | full CLDR | moderate | Mozilla docs |
| 5 | Hand-rolled `if (n==1)` printf | hardcoded plural heuristic | fails beyond EN/simple Romance | zero | anti-archetype |
| 6 | Positional printf only | `%1$s got %2$d coins` | no plural support | zero | anti-archetype |

**Excluded at screening (E1-E5)** :
- Hand-rolled `if (n==1)` heuristic — **E2 indirectness** (fails CLDR Arabic 6 classes + Russian many)
- Positional printf without plural selector — **E2 indirectness** (no plural correctness)
- SaaS message-format managed services — **E3 budget violation** (strict-OSS)
- Platform-native `stringsdict` / `plurals.xml` as primary when cross-platform engine is chosen — **E4 engine mismatch** (Godot does not natively consume Apple stringsdict or Android plurals.xml) ; retained as cross-platform reference
- Fluent (Mozilla) — retained but **E5 ecosystem narrowness** flag for game-engine integration at indie scale (fewer engine ports than ICU MessageFormat 1)

## O-matrix (ordinal 1-5, higher=better)

| Candidate | O1 Linguistic correctness | O2 CLDR coverage completeness | O3 Translator productivity | O4 Runtime/binary cost | O5 Modifiability add-locale | O6 Strict-OSS fit | Σ |
|-----------|:-------------------------:|:-----------------------------:|:--------------------------:|:----------------------:|:---------------------------:|:-----------------:|:-:|
| ICU MessageFormat 1 + CLDR 6 categories | 5 | 5 | 5 | 3 | 5 | 5 | 28 |
| gettext PO `plural-forms` (Godot native) | 4 | 4 | 4 | 5 | 4 | 5 | 26 |
| Apple stringsdict + Android plurals.xml | 5 | 5 | 4 | 5 | 4 | 5 | 28 (platform-only) |
| Fluent (Mozilla) | 5 | 5 | 4 | 3 | 4 | 4 | 25 |
| Hand-rolled `if (n==1)` printf | 2 | 1 | 3 | 5 | 1 | 5 | 17 |
| Positional printf only | 2 | 1 | 3 | 5 | 1 | 5 | 17 |

**Tie-break ICU MF 1 + CLDR vs Apple stringsdict + Android plurals.xml** : cross-platform engine (Godot) does not consume platform-native plural containers ; ICU MessageFormat 1 + CLDR is the canonical cross-platform path used by most OSS message-format libraries. Platform-native stringsdict / plurals.xml retained as reference only.

## Reviewer A ranking

1. **ICU MessageFormat 1 + CLDR 6 plural categories (zero / one / two / few / many / other) + named-placeholder + ICU-reserved escape discipline** (A-tier)
2. gettext PO `plural-forms` expression header (Godot native) (A-) — strong runtime/binary cost, acceptable when CLDR-subset is encoded in plural-forms expression ; weaker translator productivity without ICU select/plural nesting
3. Apple stringsdict + Android plurals.xml (B+) — platform-only, not pilot-applicable
4. Fluent (B) — E5 ecosystem narrowness at indie scale
5. Hand-rolled `if (n==1)` printf (C) — E2
6. Positional printf only (C) — E2

## Reviewer B ranking

1. **ICU MessageFormat 1 + CLDR 6 categories** (A-tier) — same #1
2. gettext PO `plural-forms` (A-) — B argues Godot native path is lowest-friction at pilot scale
3. Apple stringsdict + Android plurals.xml (B+) — platform-only
4. Fluent (B) — E5
5. Hand-rolled printf (C) — E2
6. Positional printf only (C) — E2

## Kappa A vs B

**Tier agreement** : 6/6 canonical rows = 100% "almost perfect". **Kappa brut ≈ 1.0**.

**Divergence** : none substantive. Both reviewers converge on ICU MessageFormat 1 + CLDR 6 categories as primary, gettext PO `plural-forms` as Godot-native runner-up.

**Supervisor arbitrage** : primary recommendation confirmed. Hybrid adopted : PO as on-disk catalog (G30 coupling) with ICU MessageFormat 1 syntax inside `msgstr` for plural / select / ordinal selectors, resolved at runtime by an OSS `messageformat` library bundled in the Godot export.

## GRADE synthesis

**Starting score** : 2 (pyramid L1-L2 — Unicode CLDR + ICU MessageFormat 1 spec + UAX #35 + W3C i18n + Apple HIG Localization + Material Localization)

**Positive factors** :
- **+1 major evidence** : CLDR + ICU MessageFormat 1 are long-standing Unicode Consortium standards with extensive implementation references (ICU4C, ICU4J, `messageformat.js`, Android ICU, iOS Foundation). CLDR plural-rule tables are authoritative.

**Negative factors** :
- **-1 indirectness** : pixel-art-HUD-tight-layout plural-form stress testing is grey-literature (indie postmortems, MG-2), not peer-reviewed primary studies. Most ICU MessageFormat 1 documentation targets enterprise web/mobile, not game HUDs.
- **-1 imprecision** : runtime parse/cache cost on low-end Android + binary-size delta of CLDR subset UNVERIFIED against normalized benchmark for Godot-bundled message-format library.

**Score final** : 2 + 1 - 2 = **1/7 → A CONSIDERER**. Standards anchor strong (CLDR + ICU MessageFormat 1 + UAX #35) but operational cost at solo-indie pixel-art scale with Godot bundling under-benchmarked.

## Sources extracted (Kitchenham Table 2)

| # | Source | Pyramid level | Year | Role |
|---|--------|:-------------:|:----:|------|
| 1 | Unicode CLDR plural rules tables | L1 (standard) | CLDR current | Authoritative plural category source |
| 2 | ICU User Guide MessageFormat 1 specification | L1 (standard) | current | Primary syntax anchor |
| 3 | Unicode Standard + UAX #35 Locale Data Markup | L1 (standard) | current | Locale data anchor |
| 4 | ICU4C / ICU4J / `messageformat` OSS library docs | L1 (OSS) | current | Implementation reference |
| 5 | gettext PO `Plural-Forms` header specification (GNU) | L1 (de facto) | current | PO plural path (G30 coupling) |
| 6 | Apple HIG Localization (stringsdict) | L1 (platform) | current | Platform reference |
| 7 | Material Design Localization (plurals + gender) | L1 (platform) | current | Platform reference |
| 8 | W3C Internationalization WG Strings + Structured Text | L1 (consortium) | current | i18n practice anchor |
| 9 | ISO/IEC 25010:2023 + 25019 | L1 (standard) | current | Outcome framework |
| 10 | ISO/IEC 29110-4-3 VSE profile | L1 (standard) | current | Solo-dev process envelope |
| 11 | Indie solo message-format postmortems (i18n bug reports, CLDR community) | L4-L5 (MG-2 grey-lit) | 2020-2026 | Pixel-art HUD stress context |

**UNVERIFIED flags** :
- CLDR subset binary-size delta when bundled in Godot Android export — UNVERIFIED.
- Runtime parse/cache cost per frame of OSS `messageformat` library on low-end Android — UNVERIFIED.
- Gettext PO `plural-forms` round-trip fidelity with ICU-nested plural/select syntax — UNVERIFIED (Agent C WebFetch candidate, cross-link G30).

## Verification Agent C (Phase 2.5, 2026-04-21)

**Claim verified** : ICU MessageFormat 1 specification + CLDR plural-rule tables are the canonical Unicode Consortium artefacts for plural correctness. Arabic `zero/one/two/few/many/other` is the standard 6-category partition per CLDR plural rules.
**Status** : PASS.
**Impact on ranking** : None — primary recommendation confirmed.

**Outstanding verification** : compatibility of `msgstr` containing ICU MessageFormat 1 syntax nested inside gettext PO entries, when transported through Weblate (G30) — flagged for Phase 2.1 WebFetch.

## Decision

**Primary recommendation for Acres pilot P** : **ICU MessageFormat 1 + CLDR 6 plural categories (zero / one / two / few / many / other) + named-placeholder + ICU-reserved-character escape discipline**, carried on disk as gettext PO entries (cross-link G30 Weblate + PO) with ICU MessageFormat 1 syntax inside `msgstr` values, resolved at runtime by an OSS `messageformat`-class library statically linked into the Godot Android + iOS exports.

- Plural authoring : every plural-sensitive source string carries `{count, plural, zero {...} one {...} two {...} few {...} many {...} other {...}}` ICU MessageFormat 1 selectors so translators can populate exactly the CLDR categories their locale uses.
- Number / currency / date / relative-time : ICU `{amount, number, :: currency/XYZ}` + `{t, date, short}` + `{t, relativeTime}` selectors ; locale currency symbol from CLDR.
- Gender / select : `{gender, select, feminine {...} masculine {...} other {...}}` for pronoun-bearing strings.
- Ordinal : `{rank, selectordinal, one {#st} two {#nd} few {#rd} other {#th}}` for leaderboard ranks (cross-link F26).
- UAX #9 escaping : LRM / RLM / FSI emitted inside interpolated strings that embed Latin numerals / brand names in Arabic / Hebrew text (cross-link G31).
- Named placeholders only : no positional `{0}` / `{1}` — named placeholders allow translators to reorder without code change (JA, KO SOV ; AR, HE RTL).
- Runtime : bundle CLDR subset limited to the declared locale set (G30) to bound binary-size ; benchmark parse/cache cost per frame-safe budget on low-end Android (cross-link A1 perf regression gate, MG-7).

**Runner-up** : gettext PO `Plural-Forms` header-only (Godot native, without ICU MessageFormat 1 inner syntax) if runtime/binary budget proves too tight on low-end Android post-benchmark. This runner-up sacrifices ICU select / ordinal / nested-plural expressiveness for smaller binary footprint.

**Rejected** : hand-rolled `if (n==1)` heuristic (E2, fails CLDR beyond EN/simple Romance) ; positional printf without plural selector (E2, no plural correctness) ; SaaS message-format managed services (E3, strict-OSS violation) ; Fluent (E5, ecosystem narrowness at indie scale with Godot) ; platform-native stringsdict / plurals.xml as primary (E4, engine mismatch with Godot cross-platform).

**Cross-link G30** : catalog format (gettext PO) carries ICU MessageFormat 1 `msgstr` content — Weblate must round-trip ICU syntax losslessly.
**Cross-link G31** : UAX #9 LRM / RLM / FSI escape characters embedded in interpolated mixed-direction strings.
**Cross-link B8** : glyph coverage for CLDR numeral systems (Arabic-Indic digits, CJK ideographs) is prerequisite.
**Cross-link E23** : IAP price display is high-frequency `{amount, number, :: currency/XYZ}` consumer.
**Cross-link F26** : leaderboard rank ordinal + score plural consume ICU `selectordinal` and `plural`.

**Traceability** : `verification/picoc/mobile-game-picoc-batch-G.md` §G32 + `verification/amendments/mobile-game-amendments.md` MG-6.
