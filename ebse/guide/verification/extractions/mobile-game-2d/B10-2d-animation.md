# Extraction Form — PICOC B10 : 2D Animation Representation + Authoring Toolchain

**Domain** : mobile-game-2d
**PICOC #** : B10
**Year** : 2026
**Reviewers** : A + B (isolated) + Agent C verification
**Protocol** : Kitchenham & Charters 2007 §2.4 + Amendment G-1 + #3 + MG-2 + MG-6

## 1. PICOC formel

| Element | Value |
|---------|-------|
| **P** (Population) | Solo indie dev with combined dev+art role, shipping a 2D pixel-art mobile game (portrait, Android+iOS, farming-sim archetype) requiring animated entities : player avatar (idle/walk/run/action directional cycles), NPCs (idle + context animations), crops (multi-stage growth), creatures, environmental (water, foliage sway, weather), UI/feedback. Pixel-art cultural norm favors discrete-frame animation visible at native resolution. Multi-month solo cycle. |
| **I** (Intervention) | Combined **animation representation + authoring toolchain** class. Entangled 2-axis choice. Representation ∈ {frame-by-frame sprite sheet per-frame data, skeletal 2D rig with bones + deformers, mesh-deformation / cutout, declarative tween + state-machine}. Authoring locus ∈ {engine-native animation editor, external dedicated 2D animation tool + runtime-import library, code-driven / data-declarative state machines authored in text}. |
| **C** (Comparator) | Discovered via systematic Phase 2.1 search : GDC Vault animation track, GitHub topics `2d-animation` / `skeletal-animation`, engine animation docs, pixel-art community tooling surveys, ACM CG / SIGGRAPH 2D skeletal + mesh deformation literature, indie postmortems. No pre-identification per G-1. |
| **O** (Outcome) | Authoring throughput (frames or poses authored per developer-day baseline) ; per-character memory footprint ; per-frame animation-update CPU cost for N on-screen entities ; max simultaneous animated instances before frame-budget breach ; bundle-size contribution per animation ; runtime import-library binary size ; iteration latency edit-to-device-preview ; rework cost on character redesign ; perceived animation quality ; pixel-art aesthetic preservation (binary no-integer-pixel-artifacts) ; input-to-animation-reaction latency ; frame-time stability. |
| **Context** | Solo dev combined art+dev role ; budget=open-source strict (self-host OSS only) ; pixel-art style is product differentiator (HARD CONSTRAINT) ; offline-first in-bundle assets ; portrait mobile moderate entity density ; ai_agent=yes ; scale=mvp ; ISO/IEC 29110-4-3 VSE. |
| **Anchor** | SWEBOK v4 KA3 Design (animation system design) + KA4 Construction (runtime integration authoring-tool exports) ; ISO/IEC 25010:2023 Performance Efficiency + Usability (user-interface aesthetics appropriateness recognizability via fidelity preservation) + Maintainability ; Apple HIG Games (motion) ; Material Design motion. |

## 2. Candidates discovered (G-1 archetype classes)

| # | Candidate | Representation | Authoring locus | License | Mobile support |
|---|-----------|----------------|-----------------|---------|:--------------:|
| 1 | Godot AnimationPlayer + AnimatedSprite2D (sprite-sheet + keyframes) | Frame-by-frame + tween/state | Engine-native | MIT | yes |
| 2 | Aseprite .aseprite import (frame tags, per-frame pivot) + godot-aseprite-importer | Frame-by-frame | External (Aseprite) + engine import | GPLv2 source + MIT importer | yes |
| 3 | Spine 2D skeletal runtime | Skeletal (bones + deformers) | External (Spine editor) + runtime | Proprietary editor + proprietary runtime | yes |
| 4 | DragonBones open format | Skeletal | External (DragonBones Pro) + runtime | MIT format + MIT runtime libs | yes |
| 5 | Godot SkeletonModifier2D / Skeleton2D | Skeletal | Engine-native | MIT | yes |
| 6 | Live2D Cubism | Mesh-deform | External + runtime | Proprietary tiered | yes |
| 7 | Code-driven state machine + tween libs | Declarative / tween | Text / code | MIT (tween lib) | yes |
| 8 | PixiJS / custom atlas frame-stepping | Frame-by-frame | Code-driven | MIT | yes (web/hybrid) |

## 3. Exclusions E1-E5

| Candidate | Criterion | Reason |
|-----------|-----------|--------|
| Spine 2D | E5 commercial-tier incompatible with budget=open-source strict | Proprietary editor + proprietary runtime licensing tiers violate budget gate. |
| Live2D Cubism | E5 commercial-tier incompatible with budget | Proprietary ; mesh-deform aesthetic also misaligned with pixel-art HARD CONSTRAINT. |
| PixiJS custom atlas | E4 platform-mismatch for native mobile pilot | Web-first ; pilot P ships native Android+iOS via engine runtime, not web wrapper. |
| DragonBones | E2 obsolescence signal | Upstream editor maintenance has been intermittent ; runtime libs are MIT but tooling stability risk for a multi-year indie cycle. |
| Aseprite Steam binary (paid binary distribution) | E5 partial — paid channel | Steam binary is a one-off payment ; the GPLv2 source-build path preserves open-source strict compliance. Kept only via self-compile route. |

## 4. O-matrix (ordinal 1-5, higher=better ; O1 gate)

| Candidate | O1 Budget=OSS (gate) | O2 Pixel-art fidelity | O3 Authoring throughput solo | O4 Runtime cost (memory + CPU) | O5 Iteration latency (edit-to-device) | Sigma |
|-----------|:--------------------:|:---------------------:|:---------------------------:|:------------------------------:|:-------------------------------------:|:-----:|
| Godot AnimationPlayer + AnimatedSprite2D | 5 PASS | 5 | 3 | 5 | 4 | 22 |
| Aseprite (self-compiled GPLv2) + godot-aseprite-importer | 5 PASS | 5 | 5 | 5 | 4 | 24 |
| Godot Skeleton2D | 5 PASS | 2 | 3 | 3 | 3 | 16 |
| Code-driven state machine + tween | 5 PASS | 4 | 2 | 5 | 3 | 19 |
| Spine 2D | 1 FAIL | 2 | 4 | 3 | 4 | excluded |
| Live2D | 1 FAIL | 1 | 3 | 2 | 3 | excluded |

Pixel-art fidelity (O2) downgrades skeletal and mesh-deform classes because bone-driven interpolation emits non-integer-pixel artifacts that violate the HARD CONSTRAINT unless manually constrained (integer translation + snap-to-grid shader).

## 5. Top-3 with rationale

1. **Aseprite (self-compiled GPLv2) + godot-aseprite-importer** (sigma 24). Highest O2 (pixel-art-native tool, per-frame tags, slices, palette discipline) and O3 (solo authoring throughput dominates — Aseprite is purpose-built for pixel-art animation). Pairs directly with B11 pixel-art authoring. GPLv2 source-build path meets budget gate.
2. **Godot AnimationPlayer + AnimatedSprite2D** (sigma 22). MIT engine-native, zero integration cost ; AnimationPlayer supports method calls + AudioStreamPlayer triggers alongside sprite frames. Falls behind Aseprite only on O3 solo throughput because pixel-art-specific authoring ergonomics are weaker inside the Godot editor than in Aseprite.
3. **Code-driven state machine + tween** (sigma 19). For UI feedback animations, particles, crop growth stages — declarative tween libs in GDScript or a small state-machine scaffold outperform sprite-sheet authoring for parametric motion. Retained as a specialized complement to the primary sprite-sheet path.

## 6. Kappa A vs B

Effective set (4 post-exclusion). A ranks Aseprite > Godot built-in > state-machine > Skeleton2D. B ranks Aseprite > Godot built-in > Skeleton2D > state-machine. Top-2 agree. Interior swap at positions 3/4. Tier agreement 3/4 = 75%, kappa ~0.67 "substantial".

Divergence DIV-state-machine-vs-skeleton : A prioritizes state-machine for crop-growth parametric animation ; B prioritizes Skeleton2D as a native engine answer for character animation beyond sprite-sheet limits. Supervisor arbitrage : both use cases are legitimate and non-competing ; retain state-machine for parametric motion, retain Skeleton2D as optional for characters whose frame count exceeds tractable hand-authored sheets.

## 7. GRADE with factors

Starting score : 2 (pyramid L3 — engine docs L1 + Aseprite docs L1 + pixel-art community grey-lit MG-2 L5 + SIGGRAPH 2D skeletal L2).

Positive factors :
- +1 large effect : Aseprite + importer reduces per-frame authoring time by a factor of 3-5x vs generic image editors per community surveys, with per-frame tags + slices surviving import.

Negative factors :
- -1 imprecision : frame-by-frame vs skeletal cost-curve inflection point (entity count) is not quantified in primary sources for mid-range Android hardware.
- -1 monoculture discount : Aseprite + Godot evidence dominates the relevant grey-literature ; comparator diversity is thin once commercial candidates are excluded.
- -1 indirectness : SIGGRAPH 2D skeletal literature targets smooth vector animation, not pixel-art integer-grid discipline — partial relevance only.
- 0 inconsistency : rankings converge at top-2.

Score final : 2 + 1 - 3 = **1/7 -> ACCEPTABLE**.

## 8. Sources Table 2

| # | Source | Pyramid level | Year | Role |
|---|--------|:-------------:|:----:|------|
| 1 | Aseprite official docs + .aseprite format spec + GPLv2 source | L1 | 2025 | Tool + format reference |
| 2 | Godot Foundation AnimationPlayer + AnimatedSprite2D docs | L1 | 2026 | Engine-native animation reference |
| 3 | godot-aseprite-importer OSS repo | L1 | 2025 | Import pipeline |
| 4 | Godot Skeleton2D + SkeletonModifier2D docs | L1 | 2026 | Skeletal option reference |
| 5 | Pixel-art community surveys + Lospec articles | L5 MG-2 grey-lit | 2024-2025 | Authoring throughput evidence |
| 6 | SIGGRAPH 2D skeletal deformation papers | L2 | varied | Academic context, partial relevance |
| 7 | GDC Vault animation-track talks | L5 MG-2 grey-lit | varied | Authoring pattern evidence |
| 8 | ISO/IEC 25010:2023 Usability + Performance Efficiency | L1 standard | 2023 | Outcome anchor |

## 9. Primary recommendation

Adopt a **frame-by-frame representation authored in Aseprite (self-compiled from GPLv2 source) + imported to Godot via godot-aseprite-importer**, with **Godot AnimationPlayer + AnimatedSprite2D** as the runtime. Use **code-driven tween + state-machine** only for parametric motion (crop growth interpolation, UI feedback) where sprite-sheet authoring is wasteful. Defer **Skeleton2D** as an optional third path for any character whose frame count becomes intractable in sheets ; evaluate aesthetic preservation case by case because skeletal interpolation routinely breaches pixel-grid discipline.

## 10. Decision + traceability

**Decision** : Aseprite + godot-aseprite-importer + Godot AnimationPlayer / AnimatedSprite2D. Status GRADE ACCEPTABLE (1/7). Pixel-art HARD CONSTRAINT + open-source strict + solo authoring throughput dominate. Spine + Live2D excluded by budget gate. Skeleton2D deferred pending character-specific need.

**Traceability** :
- PICOC source : `verification/picoc/mobile-game-picoc-batch-B.md` §B10
- Protocol amendments : G-1 + #3 + MG-2 grey-lit + MG-6 cross-PICOC tagging
- Cross-references : A1 engine choice (Godot primary, reinforces engine-native path) ; B11 pixel-art authoring (Aseprite produces both static sprites and animation sheets — B11 supplies, B10 consumes) ; A8 asset pipeline (sheet packing + compression) ; A4' simulation update timing (frame-advance coupled fixed-step vs delta-time is weak coupling for farming-sim archetype).
- Anti-double-counting : tool selection credited to B10 ; source-format interchange + palette discipline credited to B11 ; runtime sheet packing credited to A8.

Word count : ~1130 words.
