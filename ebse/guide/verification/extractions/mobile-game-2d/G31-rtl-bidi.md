# Extraction Form — PICOC G31 : RTL / BiDi Layout + Locale-Dependent UI Mirroring

**Domain** : mobile-game-2d
**PICOC #** : G31
**Date extraction** : 2026-04-21
**Reviewers** : A + B (isolated) + Agent C verification
**Protocol** : Kitchenham & Charters 2007 §2.4 (Data Extraction) + Amendment G-1 + #3 + MG-6 (cross-PICOC tagging : downstream B8 glyph rendering, cross-link G30 locale set, cross-link G32 Arabic plural classes, cross-link A6 gesture direction)

## PICOC formel

| Element | Value |
|---------|-------|
| **P** (Population) | Solo indie dev shipping a 2D pixel-art portrait offline-first Android+iOS game with ads+IAP+leaderboards, declaring support for at least 1 RTL locale (Arabic `ar`, Hebrew `he`, Persian `fa`, Urdu `ur`). In-game HUD + menus + dialogue panels + store-synced assets must either mirror or explicitly opt out of mirroring for elements tied to game-world direction (in-world signage, numerals, progression arrows). Portrait pixel-art HUD with hand-placed sprites frequently bypasses automatic platform mirroring. Engine anchor = Godot (supports `layout_direction` + HarfBuzz-based shaping) ; extraction stays engine-agnostic for Unity / Flutter fallback paths. Budget open-source strict : no SaaS RTL testing service. |
| **I** (Intervention) | RTL / BiDi layout handling strategy class. Five sub-classes / axes : (a) **platform-automatic mirroring** (Android `supportsRtl="true"` + `start` / `end` attributes + iOS leading/trailing constraints / SwiftUI semantic edges) ; (b) **engine-level RTL support** (Godot `Control.layout_direction` + HarfBuzz shaping ; Unity TextMeshPro Arabic plugin ; Flutter `Directionality`) ; (c) **manual mirroring** of custom-drawn pixel-art HUD sprites with **per-sprite `rtl_policy` opt-out** metadata (mirror / no-mirror / mirror-with-flip-correction) ; (d) **BiDi algorithm compliance via UAX #9 isolates** (LRI/RLI/FSI/PDI) for mixed-direction strings ; (e) **input-direction handling** (swipe gestures, progress-bar fill direction, timeline scrubbers). Includes **no-RTL-support baseline** for comparison. |
| **C** (Comparator) | Discovered via Phase 2.1 systematic search (G-1) — no pre-identification |
| **O** (Outcome) | Layout correctness per locale (% HUD elements rendering in semantically correct start/end position) ; BiDi string correctness for mixed-direction (Arabic + Latin numerals / brand names per UAX #9) ; mirroring-error count (incorrectly mirrored game-world sprites carrying false semantics) ; additional art cost to produce mirrored pixel-art sprites + per-asset opt-out metadata (dev-hours + new sprite count) ; input-direction correctness under RTL (swipe semantic correctness %, progress-bar fill direction, timeline comprehension) ; HarfBuzz + OpenType shaping integration cost + binary-size delta ; RTL-locale user-facing defect rate from store reviews ; Apple HIG RTL conformance rubric ; Material Bidirectionality conformance ; Apple ASRG §4 Design rejection risk |
| **C** (Context) | Portrait 2D pixel-art UI with hand-placed HUD ; solo indie, limited art budget for mirrored assets, no dedicated localization QA ; **offline-first** (no server-driven layout swap) ; dual-store with differing default RTL maturity (Android auto since API 17 when declared ; iOS auto since iOS 9 with Auto Layout, bypassed by custom game renderers) ; interacts with B8 (HarfBuzz Arabic shaping) and G32 (Arabic 6 CLDR plural classes compounding with layout) ; **budget strict-OSS** — HarfBuzz OSS, Godot built-in RTL OSS, no paid RTL testing SaaS. |
| **Anchor** | Unicode Standard Annex #9 (Bidirectional Algorithm) ; Unicode CLDR locale metadata (character direction) ; SWEBOK v4 KA3 Design + KA4 Construction ; ISO/IEC 25010:2023 Usability (Operability RTL, Inclusivity/Accessibility, User error protection — swipe direction misinterpretation), Compatibility (Interoperability cross-locale) ; ISO/IEC 25019 Quality-in-use RTL users ; Apple HIG Right-to-Left ; Material Design Bidirectionality ; Apple App Store Review Guidelines §4 Design ; W3C i18n WG Structural markup RTL (analogous principles) |

## Candidates discovered (not pre-identified, G-1 archetype classes)

| # | Archetype class | Representative | HarfBuzz required | OSS | Evidence |
|---|-----------------|----------------|:-----------------:|:---:|----------|
| 1 | **UAX #9 isolates + engine `layout_direction` + per-sprite `rtl_policy`** | **Godot `layout_direction` + HarfBuzz shaping + custom sprite metadata** | yes (bundled) | yes | Godot docs + UAX #9 + HarfBuzz |
| 2 | Platform-automatic mirroring only | Android `supportsRtl` + iOS leading/trailing | partial | yes | platform docs |
| 3 | Engine plugin RTL (Unity) | TextMeshPro Arabic plugin | yes | mixed | Unity docs |
| 4 | Manual mirroring only (no isolates) | hand-flipped sprites, naive string concat | no | yes | indie postmortems |
| 5 | No-RTL-support baseline | ship LTR only, exclude AR/HE/FA/UR | no | yes | default |

**Excluded at screening (E1-E5)** :
- Manual mirroring without UAX #9 isolates — **E2 indirectness** (mixed-direction strings render incorrectly, BiDi algorithm bypassed)
- Platform-automatic-only for custom game renderer — **E2 indirectness** (custom pixel-art renderer bypasses Auto Layout / supportsRtl)
- No-RTL-support baseline when P declares RTL locale — **E4 P mismatch**
- Proprietary RTL testing SaaS — **E3 budget violation** (strict-OSS)
- Unity TextMeshPro Arabic plugin as primary — **E4 engine mismatch** (pilot Godot) but retained as cross-engine evidence

## O-matrix (ordinal 1-5, higher=better)

| Candidate | O1 Layout correctness | O2 BiDi string correctness | O3 Mirroring-error avoidance | O4 Art-cost frugality | O5 Input-direction correctness | O6 Strict-OSS fit | Σ |
|-----------|:---------------------:|:--------------------------:|:----------------------------:|:---------------------:|:------------------------------:|:-----------------:|:-:|
| UAX #9 isolates + Godot `layout_direction` + per-sprite `rtl_policy` | 5 | 5 | 5 | 4 | 5 | 5 | 29 |
| Platform-automatic only | 3 | 4 | 2 | 5 | 3 | 5 | 22 |
| Unity TMP Arabic plugin | 4 | 5 | 4 | 3 | 4 | 3 | 23 |
| Manual mirroring only | 2 | 1 | 2 | 3 | 3 | 5 | 16 |
| No-RTL-support | — | — | — | — | — | — | excluded (E4) |

**Tie-break** : UAX #9 isolates + `layout_direction` + `rtl_policy` wins on (a) standards-based BiDi correctness, (b) per-sprite override preserves pixel-art intent, (c) OSS HarfBuzz bundled in Godot, (d) mixed-direction strings (Arabic + Latin numerals + English brand) render per UAX #9.

## Reviewer A ranking

1. **UAX #9 isolates (LRI/RLI/FSI/PDI) + Godot `Control.layout_direction` + HarfBuzz shaping + per-sprite `rtl_policy` metadata (mirror / no-mirror / mirror-with-flip-correction)** (A-tier)
2. Platform-automatic mirroring supplemented by manual opt-out (B+) — cheaper but insufficient for custom renderer
3. Unity TMP Arabic plugin (B) — cross-engine evidence only, pilot is Godot
4. Manual mirroring without UAX #9 (C) — E2
5. No-RTL baseline (excluded) — E4

## Reviewer B ranking

1. **UAX #9 isolates + `layout_direction` + per-sprite `rtl_policy`** (A-tier) — same #1
2. Platform-automatic (B+) — B more skeptical of custom renderer bypass
3. Unity TMP Arabic (B) — engine mismatch
4. Manual mirroring (C) — E2
5. No-RTL baseline (excluded) — E4

## Kappa A vs B

**Tier agreement** : 5/5 canonical rows = 100% "almost perfect". **Kappa brut ≈ 1.0**.

**Divergence** : none substantive. Both reviewers converge on UAX #9 isolates + engine `layout_direction` + per-sprite `rtl_policy` as the only RTL-correct option for custom pixel-art HUD.

**Supervisor arbitrage** : primary recommendation confirmed unchanged.

## GRADE synthesis

**Starting score** : 2 (pyramid L2 — UAX #9 Unicode standard + CLDR + Apple HIG RTL + Material Bidirectionality + HarfBuzz + Godot docs)

**Positive factors** :
- **+1 major evidence** : UAX #9 is a Unicode Consortium standard with extensive implementation reference (ICU, HarfBuzz). Apple HIG RTL + Material Bidirectionality provide platform rubrics.

**Negative factors** :
- **-1 indirectness** : pixel-art-HUD-specific RTL postmortems are scarce in academic literature (MG-2 grey-lit : indie dev blogs, Godot community forums). Most RTL literature targets text-heavy apps, not hand-placed sprite HUDs.
- **-1 imprecision** : mirroring-error count + additional art cost + per-sprite `rtl_policy` authoring time UNVERIFIED against normalized benchmark.

**Score final** : 2 + 1 - 2 = **1/7 → A CONSIDERER**. Standards anchor is strong (UAX #9 + CLDR + HarfBuzz) but operational cost deltas at solo-indie pixel-art scale under-benchmarked.

## Sources extracted (Kitchenham Table 2)

| # | Source | Pyramid level | Year | Role |
|---|--------|:-------------:|:----:|------|
| 1 | Unicode Standard Annex #9 Bidirectional Algorithm | L1 (standard) | current | BiDi algorithm anchor |
| 2 | Unicode CLDR locale metadata (character direction) | L1 (standard) | current | Locale direction anchor |
| 3 | HarfBuzz OpenType shaping engine docs | L1 (OSS) | current | Arabic shaping implementation |
| 4 | Godot Engine RTL + `Control.layout_direction` docs | L1 (engine) | current | Primary engine binding |
| 5 | Apple Human Interface Guidelines Right-to-Left | L1 (platform) | current | iOS rubric |
| 6 | Material Design Bidirectionality | L1 (platform) | current | Android rubric |
| 7 | Apple App Store Review Guidelines §4 Design | L1 (platform) | current | Rejection-risk anchor |
| 8 | W3C i18n WG Structural markup RTL notes | L1 (consortium) | current | Analogous layout principles |
| 9 | Android `supportsRtl` + `start` / `end` attrs docs | L1 (platform) | current | Platform auto-mirroring anchor |
| 10 | ISO/IEC 25010:2023 + 25019 | L1 (standard) | current | Outcome framework |
| 11 | Unity TextMeshPro Arabic plugin docs | L1 (engine plugin) | current | Cross-engine evidence only |
| 12 | Indie pixel-art RTL postmortems (Godot community, indie blogs) | L4-L5 (MG-2 grey-lit) | 2020-2026 | Pixel-art-specific context |

**UNVERIFIED flags** :
- Mirroring-error count empirical distribution in pixel-art HUD — UNVERIFIED.
- Additional art cost per RTL locale for opt-out sprite metadata — UNVERIFIED.
- Godot HarfBuzz Arabic shaping full CLDR coverage — partially verified (Godot 4 ships HarfBuzz, full glyph coverage locale-dependent on font — cross-link B8).

## Verification Agent C (Phase 2.5, 2026-04-21)

**Claim verified** : Godot `Control.layout_direction` property + HarfBuzz integration is standards-consistent for RTL handling. UAX #9 isolate characters (LRI U+2066, RLI U+2067, FSI U+2068, PDI U+2069) are authoritative for mixed-direction string embedding.
**Status** : PASS.
**Impact on ranking** : None — primary recommendation confirmed.

**Outstanding verification** : Godot `rtl_policy` metadata pattern (documented custom pattern, not engine-native) — standard emerges from community, not native Godot feature. Flagged for Phase 2.1 WebFetch confirmation of community convention.

## Decision

**Primary recommendation for Acres pilot P** : **UAX #9 isolate-based BiDi handling (LRI/RLI/FSI/PDI) + Godot `Control.layout_direction` + HarfBuzz shaping (bundled Godot 4) + custom per-sprite `rtl_policy` metadata field (mirror / no-mirror / mirror-with-flip-correction)**.

- String-level : all interpolated mixed-direction strings (Arabic dialogue + embedded English brand + Latin numerals from G32 number formatter) wrapped with FSI/PDI or LRI/RLI/PDI per UAX #9. No naive concatenation.
- Layout-level : top-level `Control` nodes carry `layout_direction = LAYOUT_DIRECTION_LOCALE` ; custom HUD sprite scenes carry an exported `rtl_policy` field checked by the HUD layout script.
- Sprite-level : for every hand-placed HUD sprite, author decides : **mirror** (default for directional arrows, progress bars, swipe affordances), **no-mirror** (player-facing logos, in-world physics indicators), **mirror-with-flip-correction** (asymmetric sprites whose meaning inverts when flipped — author provides corrected mirrored asset).
- Input-direction (cross-link A6) : swipe gestures map to semantic "forward/back" in RTL ; progress bars fill from trailing edge ; timeline scrubbers follow UAX #9 direction of text flow.
- Testing : run portrait pixel-art HUD under all declared RTL locales in Godot editor + on-device Android + iOS simulator (H34 emulator-only strategy) ; check every HUD frame for mirroring-error and mixed-direction rendering.

**Runner-up** : platform-automatic mirroring (Android `supportsRtl="true"` + iOS leading/trailing) supplemented by manual opt-out for custom renderer — acceptable fallback if engine-level `layout_direction` unavailable.

**Rejected** : manual mirroring without UAX #9 isolates (E2, BiDi algorithm bypassed) ; no-RTL baseline (E4, P declares RTL locale) ; proprietary RTL testing SaaS (E3, strict-OSS).

**Cross-link B8** : HarfBuzz Arabic glyph shaping is prerequisite — B8 extraction must confirm glyph coverage per declared RTL locale font.
**Cross-link G30** : RTL locales = subset of G30 locale set ; Weblate PO editor must correctly preserve UAX #9 isolate characters through round-trip.
**Cross-link G32** : Arabic 6 CLDR plural classes interact with RTL layout — G32 message formatter emits plural-selected strings that flow through UAX #9 isolates.
**Cross-link A6** : gesture / input direction semantics in RTL governed by this PICOC's input-direction axis.

**Traceability** : `verification/picoc/mobile-game-picoc-batch-G.md` §G31 + `verification/amendments/mobile-game-amendments.md` MG-6.
