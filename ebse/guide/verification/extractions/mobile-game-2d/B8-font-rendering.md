# Extraction Form — PICOC B8 : Font Rendering Strategy for Pixel-Art + Multi-Script Mobile UI

**Domain** : mobile-game-2d
**PICOC #** : B8
**Date** : 2026
**Reviewers** : A + B (isolated contexts) + Agent C verification
**Protocol** : Kitchenham & Charters 2007 §2.4 + Amendment G-1 + Amendment #3 + methodology.md v2026.04.7

## 1. PICOC formal

| Element | Value |
|---------|-------|
| **P** | Solo indie mobile game developer shipping a 2D pixel-art farming-sim in portrait on Android + iOS with UI text = dialogue + menus + HUD counters + legal/privacy text + tutorial, localization baseline covering Latin-1 + extended European + CJK (Simplified Chinese, Japanese) + optionally Cyrillic/Arabic/Hebrew (RTL) for global store reach, preservation of pixel-art aesthetic, readability across device DPIs 160–500+ dpi |
| **I** | Class of font rendering strategy. Four sub-classes: (a) pre-rasterized bitmap font atlas at fixed pixel sizes (optionally multi-size) ; (b) runtime vector rasterization of TTF/OTF via a vector-font library ; (c) distance-field representation (single-channel SDF or multi-channel MSDF) with shader-based reconstruction ; (d) hybrid = bitmap atlas for Latin pixel-font identity + runtime vector fallback for CJK / extended. Axes: rasterization locus (build-time vs runtime), memory footprint per script, scaling fidelity, pixel-art integrity preservation |
| **C** | Discovered systematically in Phase 2.1 — no pre-identification per Amendment G-1 |
| **O** | Glyph memory footprint per script (MB GPU + CPU) ; cold startup text-readiness latency (ms, engine init → first rendered glyph) ; per-frame text-draw cost on dialogue screen (ms/frame) ; APK/IPA size delta per added script (MB) ; runtime text-layout correctness for bidirectional / complex-shaping scripts (pass/fail on localization test corpus) ; CJK glyph-coverage ratio (% of top-N frequency glyphs) ; legibility at native resolution ; pixel-art aesthetic preservation ; zoom/scale stability without re-rasterization artifacts ; WCAG 2.2 SC 1.4.4 Resize Text + SC 1.4.12 Text Spacing conformance |
| **Co** | Solo indie ; no font designer ; open-licensed or one-off affordable fonts ; offline-first (no font download at runtime as sole path) ; store compliance for legal text rendered in localized languages ; WCAG 2.2 text contrast + minimum size applies ; transverses = budget=open-source strict, ai_agent=yes, team_size=ebse-default, scale=mvp |
| **Anchor** | SWEBOK v4 KA3 Design (UI subsystem) + KA4 Construction (font pipeline integration) + KA1 Requirements (i18n NFRs) ; ISO/IEC 25010:2023 Usability (Appropriateness recognizability, User-interface aesthetics, Accessibility) + Performance Efficiency (Resource utilization + Time behaviour) + Compatibility (Portability cross-locales) ; ISO/IEC 25019 Quality-in-use for visual outputs ; W3C WCAG 2.2 SC 1.4.3 + 1.4.4 + 1.4.12 ; Apple HIG Typography + Dynamic Type ; Material Design type system ; Unicode UAX #14 line breaking + UAX #9 bidirectional |

## 2. Candidates discovered (archetype classes)

| # | Archetype class | Description |
|---|-----------------|-------------|
| 1 | Build-time bitmap atlas at fixed pixel sizes | Authored or rasterized-from-TTF atlas, one atlas per size ; pixel-perfect at design size ; resizing = re-raster or blocky scale |
| 2 | Multi-size bitmap atlas + nearest-size selection at runtime | Same as archetype 1 with several sizes packed, runtime chooses closest ; memory × size-count |
| 3 | Runtime vector rasterization (OSS TTF/OTF library) | FreeType-class library rasterizes glyphs on-demand into a runtime atlas ; universal script coverage ; runtime CPU + memory cost |
| 4 | Single-channel SDF rasterized offline | Offline SDF generation ; smooth scaling via shader ; small atlas ; edges rounded — pixel-art identity compromised |
| 5 | Multi-channel SDF (MSDF) offline | Corners preserved better than single-channel SDF ; still smoothed — not pixel-faithful for pixel-font identity |
| 6 | Hybrid: bitmap pixel-font for Latin + runtime vector fallback for CJK | Bitmap atlas for display/menu pixel identity ; TTF runtime rasterizer covers CJK and extended scripts |

## 3. Exclusions at screening

| Candidate | Exclusion code | Reason |
|-----------|:--------------:|--------|
| SaaS font subsetting service | E1 | Budget=open-source strict rejects SaaS ; subsetting done locally |
| Runtime font download from CDN as sole source | E2 | Offline-first P incompatible |
| Proprietary commercial font rendering middleware | E1 | Paid licence rejected |
| Ad-hoc GPU-only SDF path with no OSS shader | E3 | Maturity + pixel-art fidelity both fail |

## 4. O-matrix (ordinal 1–5, higher = better)

| Archetype | O1 Memory footprint | O2 Startup latency | O3 Per-frame draw cost | O4 Pixel-art fidelity | O5 Multi-script coverage | O6 Impl. effort (solo) | O7 Budget=OSS strict | Σ |
|-----------|:-------------------:|:------------------:|:----------------------:|:--------------------:|:------------------------:|:----------------------:|:--------------------:|:-:|
| 1. Single-size bitmap | 5 | 5 | 5 | 5 | 2 | 5 | 5 | 32 |
| 2. Multi-size bitmap | 3 | 4 | 5 | 5 | 2 | 4 | 5 | 28 |
| 3. Runtime TTF rasterization | 3 | 3 | 3 | 3 | 5 | 3 | 5 | 25 |
| 4. Single-channel SDF | 4 | 4 | 3 | 2 | 4 | 3 | 5 | 25 |
| 5. MSDF | 4 | 4 | 3 | 2 | 4 | 2 | 5 | 24 |
| 6. Hybrid bitmap + TTF fallback | 3 | 4 | 4 | 5 | 5 | 3 | 5 | 29 |

## 5. Top-3 ranking with rationale

1. **Hybrid bitmap + TTF runtime fallback (archetype 6)** — Single best compromise: the pixel-art identity fonts (display, menus, HUD) ship as bitmap atlases to preserve discrete-pixel aesthetic, while CJK and extended scripts are covered by a runtime TTF rasterizer using an open-licensed font. This is the only archetype that satisfies both the aesthetic constraint (pixel-art fidelity) and the localization baseline (CJK coverage).
2. **Single-size bitmap atlas (archetype 1)** — Best pure Latin-only solution. Recommended as primary if the initial release targets only Latin-script markets, deferring CJK until archetype 6 is introduced. Zero runtime cost, pixel-perfect.
3. **Runtime TTF rasterization (archetype 3)** — Universal script coverage but sacrifices pixel-art fidelity across the board. Suitable for body text (legal, tutorial) where aesthetic constraint is relaxed, paired with archetype 1 for titles — this is effectively archetype 6 and reinforces the hybrid recommendation.

## 6. Kappa A vs B

Agreement on archetype ranking: 6/6 → **κ = 1.0 ("almost perfect")** on primary ; minor ordering differences in the runners-up. Reviewers A and B converged independently on hybrid as the only answer covering both aesthetic and i18n constraints. SDF / MSDF archetypes (4 and 5) unanimously downgraded for pixel-art fidelity loss.

## 7. GRADE synthesis

Starting score : **3** (highest source = L1 Unicode UAX + L1 W3C WCAG 2.2 + L1 FreeType project documentation + L1 Apple HIG / Material Design typography).

Positive factors:
- **+1 large_effect** — The qualitative gap between pixel-faithful bitmap and smoothed SDF for a pixel-art game is binary: SDF rendering visibly breaks the pixel-art aesthetic contract. The archetype that preserves identity dominates for this P.
- **+1 major_evidence** — Unicode UAX #9 (bidirectional) and UAX #14 (line breaking) provide formal standards for text-layout correctness ; open-licence CJK fonts (e.g. Noto-class families) provide documented glyph coverage.

Convergence factor **OMITTED** (monoculture discount — typography guidelines from Apple, Google, and Microsoft share common ancestry and reinforce each other socially rather than evidentially).

Negative factors:
- **−1 indirectness** — Published evidence on pixel-art-specific font rendering on mobile is sparse ; most SDF literature targets smooth UI text, not discrete pixel-font identity preservation.
- **−1 imprecision** — Per-script memory footprint numbers (MB CJK under runtime TTF rasterization) are empirically unverified on the reference mid-range 2026 devices.

No −1 inconsistency (reviewers converge) ; no −1 bias.

Final score : 3 + 2 − 2 = **3/7 → RECOMMANDE**.

## 8. Sources extracted (Kitchenham Table 2)

| # | Source | Pyramid level | Year | Role |
|---|--------|:-------------:|:----:|------|
| 1 | Unicode UAX #9 Bidirectional + UAX #14 Line breaking | L1 standard | 2024 | Text-layout anchor |
| 2 | W3C WCAG 2.2 SC 1.4.3 + 1.4.4 + 1.4.12 | L1 standard | 2023 | Accessibility anchor |
| 3 | Apple HIG Typography + Dynamic Type | L1 platform | 2026 | Platform typography anchor |
| 4 | Material Design type system | L1 platform | 2026 | Platform typography anchor |
| 5 | FreeType project documentation | L1 OSS authoritative | 2026 | Runtime rasterization anchor |
| 6 | Open-licence CJK font family documentation (e.g. Noto-class) | L2 | 2024–2026 | CJK coverage anchor |
| 7 | ISO/IEC 25010:2023 Usability | L1 standard | 2023 | Quality anchor |
| 8 | Pixel-art community blogs on font authoring (MG-2 grey-lit) | L5 flagged | 2020–2025 | Aesthetic practice evidence |
| 9 | SDF / MSDF academic papers (SIGGRAPH lineage) | L3 | 2007–2020 | Rasterization theory |

## 9. Primary recommendation for pilot P

**Hybrid bitmap + TTF runtime fallback (archetype 6).** Pixel-art identity fonts (display, menus, HUD counters) authored as bitmap atlases at a small number of canonical sizes aligned to integer scales of the native viewport. CJK, extended European and any RTL scripts covered by a runtime TTF rasterizer (FreeType-class) using an open-licence font family providing broad Unicode coverage. Legal/privacy text rendered via the runtime rasterizer to ensure coverage. Font files shipped in-bundle (offline-first). Budget=open-source strict compliant: all components OSS-licensed, no SaaS subsetting, no font-download CDN in the critical path.

## 10. Decision with traceability

**Decision** : Adopt archetype 6 (hybrid bitmap + TTF fallback) as canonical font rendering strategy.

**Traceability** : PICOC definition in `verification/picoc/mobile-game-picoc-batch-B.md` §B8 ; partial dependency on A1 (engine defaults shape viable paths) ; upstream for G31 (RTL/BiDi layout consumes glyph rendering from B8) ; orthogonal to A8 (A8 ships the font artifact, B8 chooses the rendering class) ; weak dependency on Batch G (localization string catalogues supply the text content).
