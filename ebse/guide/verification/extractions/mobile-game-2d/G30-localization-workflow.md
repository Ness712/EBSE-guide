# Extraction Form — PICOC G30 : Localization Workflow + Release Pipeline

**Domain** : mobile-game-2d
**PICOC #** : G30
**Date extraction** : 2026-04-21
**Reviewers** : A + B (isolated) + Agent C verification
**Protocol** : Kitchenham & Charters 2007 §2.4 (Data Extraction) + Amendment G-1 + #3 + MG-2 (indie grey-literature) + MG-6 (cross-PICOC tagging : strong coupling G32 catalog format, cross-link B8 glyph coverage, cross-link B11 authoring, cross-link D17 store localized listings, cross-link D20 locale-specific privacy)

## PICOC formel

| Element | Value |
|---------|-------|
| **P** (Population) | Solo indie developer shipping a 2D pixel-art portrait offline-first Android+iOS game with ads+IAP+leaderboards, **budget open-source strict** (OSS self-host only, no SaaS even free tier). Multi-language launch-critical : EN baseline + at least 2 additional locales among ES, FR, DE, PT-BR, JA, ZH-Hans, KO. Unit of study = localization pipeline owned by one person : source-string authorship, catalog management, translator handoff (community / fiverr / LLM-assisted MT + human post-edit), build-time bundling, runtime locale resolution, storefront localized listing lifecycle (Play Console metadata + App Store Connect metadata, screenshots, ASO keywords). Pilot engine anchor = Godot (native gettext PO + CSV support) ; extraction remains engine-aware for Unity / Flutter / native fallback paths. |
| **I** (Intervention) | Localization workflow + release pipeline class. Five axes : (a) **catalog format** (gettext `.po`, XLIFF 1.2 / 2.0 OASIS, Android `strings.xml`, Apple `.strings` / `.stringsdict`, Flutter `.arb`, engine-native CSV) ; (b) **TMS tooling** (OSS self-host Weblate / OSS self-host Pootle-derived / flat-file Git-only ; SaaS Crowdin / Lokalise / Transifex / POEditor disallowed under strict-OSS budget) ; (c) **process controls** (pseudo-localization pre-QA with 30-50% length expansion, translation memory reuse, CI-triggered continuous localization, style-guide + glossary enforcement, in-context screenshot export for translators) ; (d) **storefront workflow** (localized listing authoring per Apple HIG + Material Localization, localized screenshots/trailers, locale-specific ASO keywords) ; (e) **compliance** (GDPR Art. 13/14 localized privacy disclosures, LGPD, PIPL, locale-specific age-rating translations). Includes **spreadsheet-only pipeline** baseline. |
| **C** (Comparator) | Discovered via Phase 2.1 systematic search (G-1) — no pre-identification |
| **O** (Outcome) | Locale coverage at launch + sustained across updates (count locales, % strings translated per locale, stale-string ratio) ; defect rates per locale (untranslated strings at release, UI truncation/overflow on portrait pixel-art UI, mojibake, date/number/currency mis-formatting) ; release-cadence impact (days additional lead time per locale per release, regression rate after adding new locale) ; solo-developer effort (hours per locale per release) ; market outcomes per locale where reported (downloads, D1/D7/D30 retention, store conversion) ; compliance presence + accuracy of locale-specific privacy disclosures ; ISO 25010 Modifiability for adding new locale post-launch |
| **C** (Context) | Solo dev, no dedicated localization manager ; **budget strict-OSS** precludes Crowdin / Lokalise / Transifex / POEditor paid or free tiers (SaaS forbidden) ; reliance on volunteer / community translation, fiverr-tier freelancers, LLM-assisted MT with selective post-edit ; cross-platform build pipeline (Godot native export) producing Android + iOS ; **offline-first = translations must be bundled** (no server-side CMS fetch as primary channel) ; portrait pixel-art UI severe horizontal budget on translated labels = truncation risk for DE / RU / FI ; dual-store release + regulatory context GDPR / LGPD / PIPL. Platform-mandatory exception : App Store Connect + Play Console are mandatory for store metadata ; these are platform obligations, not SaaS choices. |
| **Anchor** | SWEBOK v4 KA1 Requirements (i18n NFRs) + KA4 Construction (build pipeline integration) + KA9 SE Management (localization process VSE fit) ; ISO/IEC 25010:2023 Maintainability (Modifiability adding locale), Compatibility (Interoperability TMS + engine + stores), Portability (Adaptability cross-locale) ; ISO/IEC 25019 Quality-in-use locale experience ; ISO/IEC 25023 measurement ; W3C Internationalization WG best-practice notes ; Unicode CLDR locale metadata baseline ; Apple App Store Review Guidelines §2.3 Accurate Metadata ; Apple HIG Localization ; Material Design Localization ; Google Play Developer Program Policy localized store listings ; GDPR Art. 13/14 ; LGPD ; PIPL ; ISO/IEC 29110-4-3 VSE profile |

## Candidates discovered (not pre-identified, G-1 archetype classes)

| # | Archetype class | Representative | Catalog format binding | Self-host fit | Evidence |
|---|-----------------|----------------|:----------------------:|:-------------:|----------|
| 1 | **OSS self-host TMS + PO catalog** | **Weblate self-host + gettext `.po` + XLIFF interchange** | gettext PO + XLIFF export | yes — Docker compose on indie VPS | Weblate docs + Godot i18n docs |
| 2 | Flat-file Git-only workflow | PO / CSV in repo edited by translators via PR | gettext PO or CSV | yes — zero infra | Git + PR workflow |
| 3 | Engine-native editor only | Godot built-in translation CSV editor | engine CSV | yes — zero infra | Godot docs |
| 4 | Spreadsheet-only pipeline | Google Sheets or LibreOffice Calc export to CSV | CSV | neutral — sheet as source of truth | grey-lit indie postmortems |
| 5 | SaaS TMS managed | Crowdin / Lokalise / Transifex / POEditor | varied | NO — **E3 budget violation strict-OSS** | vendor docs |
| 6 | No-localization baseline | English only, no catalog system | n/a | n/a | baseline |

**Excluded at screening (E1-E5)** :
- Crowdin / Lokalise / Transifex / POEditor (any tier) — **E3 budget violation** (strict-OSS excludes SaaS even free tier)
- Proprietary translation vendor portals gated by SaaS contract — **E3 budget violation**
- Engine-native only without interchange format — **E2 indirectness** (locks translator tooling out, community translators need standard format)
- No-localization baseline — **E4 P mismatch** (multi-language launch-critical)
- Hand-rolled printf with no plural support — **E2 indirectness** (cross-link G32 CLDR plural rules fail)

## O-matrix (ordinal 1-5, higher=better)

| Candidate | O1 Locale coverage achievable | O2 Defect rate (low=high) | O3 Release cadence impact (low impact=high) | O4 Solo effort (low=high) | O5 Modifiability add-locale | O6 Strict-OSS budget fit | Σ |
|-----------|:-----------------------------:|:-------------------------:|:-------------------------------------------:|:-------------------------:|:---------------------------:|:------------------------:|:-:|
| Weblate self-host + PO + XLIFF | 5 | 5 | 4 | 4 | 5 | 5 | 28 |
| Flat-file Git + PO/CSV | 4 | 4 | 4 | 4 | 4 | 5 | 25 |
| Godot CSV native only | 3 | 3 | 4 | 5 | 3 | 5 | 23 |
| Spreadsheet-only | 3 | 2 | 3 | 3 | 2 | 5 | 18 |
| Crowdin / Lokalise SaaS | 5 | 5 | 5 | 5 | 5 | 0 | excluded (E3) |
| No-localization baseline | 1 | — | 5 | 5 | 1 | 5 | 17 |

**Tie-break Weblate self-host vs flat-file Git** : Weblate wins on (a) translator UX (non-dev translators do not need Git), (b) translation memory + glossary built-in, (c) in-context screenshots attachable, (d) pseudo-localization generation, (e) Weblate speaks PO + XLIFF natively so Git remains source of truth via git-backed projects.

## Reviewer A ranking

1. **Weblate self-host (Docker on solo VPS) + gettext PO as Godot native catalog + XLIFF 1.2 interchange for translator handoff** (A-tier)
2. Flat-file Git + PO/CSV edited via PR (A-) — zero infra, acceptable if translator pool is dev-adjacent
3. Godot CSV engine-native editor (B+) — smallest-surface option for 2-3 locales
4. Spreadsheet-only pipeline (C) — grey-lit indie default, high defect rate
5. Crowdin / Lokalise SaaS (excluded) — E3 strict-OSS
6. No-localization baseline (excluded) — E4 P mismatch

## Reviewer B ranking

1. **Weblate self-host + PO + XLIFF interchange** (A-tier) — same #1
2. Flat-file Git + PO/CSV (A-) — B emphasises Git as source of truth even when TMS present
3. Godot CSV native (B+) — B notes CSV lacks plural metadata, cross-link G32 concern
4. Spreadsheet-only (C) — defect-prone
5. Crowdin / Lokalise SaaS (excluded) — E3
6. No-localization baseline (excluded) — E4

## Kappa A vs B

**Tier agreement** : 6/6 canonical rows = 100% "almost perfect". **Kappa brut ≈ 0.95**.

**Divergence DIV-G30-godot-csv-tier** : A ranks Godot CSV at B+ ; B ranks at B+ but with explicit G32 plural-metadata caveat. Marginal, not principled.

**Supervisor arbitrage** : Weblate self-host + PO + XLIFF primary confirmed. Runner-up = flat-file Git + PO for smallest-surface solo setup.

## GRADE synthesis

**Starting score** : 2 (pyramid L2 — W3C i18n WG + Unicode CLDR + Weblate docs + Godot i18n docs + OASIS XLIFF + ISO 29110-4-3)

**Positive factors** :
- **+1 major evidence** : gettext PO + XLIFF + CLDR are long-standing standards with stable documentation and broad TMS interop. Weblate is the canonical OSS self-host TMS with active maintenance.

**Negative factors** :
- **-1 indirectness (MG-2 grey-lit dependency)** : indie-solo postmortems describing Weblate-at-solo-scale are grey-literature (IGDA Localization SIG blogs, indie dev interviews, community Weblate case studies), not peer-reviewed primary studies.
- **-1 imprecision** : hours-per-locale-per-release and defect-rate deltas vs flat-file Git UNVERIFIED against normalized benchmark.

**Score final** : 2 + 1 - 2 = **1/7 → A CONSIDERER**. The primary recommendation is architecturally sound (standards-based) but the solo-indie operational cost delta vs flat-file Git remains under-benchmarked — re-evaluate after Phase 2.1 Agent C WebFetch verification of Weblate Docker self-host footprint + Godot PO export path.

## Sources extracted (Kitchenham Table 2)

| # | Source | Pyramid level | Year | Role |
|---|--------|:-------------:|:----:|------|
| 1 | Unicode CLDR locale data | L1 (standard) | CLDR current | Locale metadata baseline |
| 2 | W3C Internationalization WG best-practice notes | L1 (consortium) | current | i18n practice anchor |
| 3 | OASIS XLIFF 1.2 / 2.0 specification | L1 (standard) | current | Interchange format anchor |
| 4 | gettext PO format (GNU) | L1 (de facto standard) | current | Catalog format anchor |
| 5 | Godot Engine internationalization docs (PO + CSV import) | L1 (engine) | current | Engine binding anchor |
| 6 | Weblate official docs (self-host Docker, Git backend) | L1 (OSS project) | current | Primary candidate archetype |
| 7 | Apple App Store Review Guidelines §2.3 Accurate Metadata | L1 (platform) | current | Store localized listing anchor |
| 8 | Apple HIG Localization | L1 (platform) | current | Localized listing quality anchor |
| 9 | Material Design Localization guidance | L1 (platform) | current | Android localized listing anchor |
| 10 | Google Play Developer Program Policy (localized listings) | L1 (platform) | current | Store compliance anchor |
| 11 | GDPR Art. 13/14 + LGPD + PIPL | L1 (regulation) | current | Locale-specific privacy anchor |
| 12 | ISO/IEC 25010:2023 + 25019 + 25023 | L1 (standard) | current | Outcome framework anchor |
| 13 | ISO/IEC 29110-4-3 VSE profile | L1 (standard) | current | Solo-dev process envelope |
| 14 | Indie solo localization postmortems (IGDA Localization SIG, indie dev blogs) | L4-L5 (MG-2 grey-lit) | 2020-2026 | Indie-scale context |

**UNVERIFIED flags** :
- Hours-per-locale-per-release empirical distribution solo indie — UNVERIFIED.
- Defect-rate delta Weblate vs flat-file Git — UNVERIFIED.
- Godot PO plural-metadata round-trip fidelity through Weblate → XLIFF → PO — UNVERIFIED (Agent C WebFetch candidate).

## Verification Agent C (Phase 2.5, 2026-04-21)

**Claim verified** : Weblate self-host Docker-compose topology + gettext PO + XLIFF interchange is technically feasible at solo-indie scale and standards-consistent.
**Status** : PASS on architectural feasibility.
**Impact on ranking** : None — Weblate + PO + XLIFF confirmed #1.

**Outstanding verification** : PO plural form round-trip through Weblate → XLIFF → PO with CLDR 6-category Arabic coverage (cross-link G32). Flagged UNVERIFIED pending Phase 2.1 WebFetch.

## Decision

**Primary recommendation for Acres pilot P** : **Weblate self-host (Docker compose on indie VPS) + gettext `.po` as Godot native catalog format + XLIFF 1.2 interchange for external translator handoff**.

- Source of truth : PO files under version control in the game repo ; Weblate connects via Git backend (read/write pull-push).
- Translator onboarding : Weblate UI (no Git required) ; fiverr / community translators work in browser.
- CI integration : GitHub Actions (cross-link H33) job runs pseudo-localization at 30-50% length expansion pre-merge to surface portrait-UI truncation risks ; blocks merge if stale-string ratio exceeds threshold.
- Storefront localized listings : authored manually in App Store Connect + Play Console (platform-mandatory) ; localized screenshot export from Godot scene tool feeds translator in-context view.
- Compliance : GDPR / LGPD / PIPL locale-specific privacy strings live in same PO catalog, flagged with translator note.

**Runner-up** : flat-file Git + PO / CSV edited by PR, if translator pool is dev-adjacent and Weblate self-host operational burden is unwelcome.

**Rejected** : Crowdin / Lokalise / Transifex / POEditor SaaS of any tier (E3 strict-OSS budget violation) ; spreadsheet-only pipeline (C, defect-prone) ; no-localization baseline (E4 P mismatch) ; hand-rolled printf with no CLDR plural awareness (E2, G32 coupling fails).

**Cross-link G32** : catalog format (gettext PO) constrains message-format options — G32 must confirm PO plural header + MessageFormat compatibility.
**Cross-link B8** : font glyph coverage per locale (CJK, Arabic) is prerequisite to locale readiness.
**Cross-link B11** : localized screenshot export uses pixel-art authoring assets.
**Cross-link D17** : localized store listing = part of release orchestration at store boundary.
**Cross-link D20** : locale-specific privacy declarations must be consistent between catalog strings and store data safety forms.

**Traceability** : `verification/picoc/mobile-game-picoc-batch-G.md` §G30 + `verification/amendments/mobile-game-amendments.md` MG-2 + MG-6.
