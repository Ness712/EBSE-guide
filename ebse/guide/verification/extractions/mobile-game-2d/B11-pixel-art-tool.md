# Extraction Form — PICOC B11 : Pixel-Art Sprite Authoring Tool + Source-Format Interchange

**Domain** : mobile-game-2d
**PICOC #** : B11
**Year** : 2026
**Reviewers** : A + B (isolated) + Agent C verification
**Protocol** : Kitchenham & Charters 2007 §2.4 + Amendment G-1 + #3 + MG-2 + MG-6

## 1. PICOC formel

| Element | Value |
|---------|-------|
| **P** (Population) | Solo indie dev with combined dev+art role producing pixel-art sources for a 2D pixel-art mobile game (Android+iOS) : character sprite sheets with per-frame origin/pivot + animation frame tags + 9-slice regions for UI panels + hitbox rectangles + palette swap tables, tilesets (consumed by B7), UI sprites, store icon assets (Play listing + App Store). Assets move from authoring tool to engine runtime preserving metadata ; git-versioned alongside code ; multi-month project. |
| **I** (Intervention) | Class of **pixel-art sprite authoring tool + source-format interchange**. 4 archetype sub-classes : (a) dedicated pixel-art editor with native format carrying rich metadata (frame tags, slices, palette) consumed by an engine-side import library ; (b) generic raster PNG + sidecar metadata JSON/TOML describing slices + tags ; (c) layered-document format (PSD-class) with layer-name conventions interpreted at import ; (d) in-engine sprite editor with engine-proprietary metadata storage. |
| **C** (Comparator) | Discovered via systematic Phase 2.1 search : pixel-art tool surveys, engine import-pipeline docs, GitHub topics `aseprite-importer` / `sprite-importer` / `pixel-art-editor`, pixel-art community forums + blogs, indie postmortems. No pre-identification per G-1. |
| **O** (Outcome) | Sprites authored per developer-hour ; per-sprite authoring-to-runtime round-trip latency ; metadata fidelity preservation rate (% slices / tags / pivots surviving import) ; import-library binary size ; source-format git-diff reviewability ; scriptability / headless invocation for A8 pipeline ; palette consistency violations per project ; tool licensing cost ; shipped-art aesthetic cohesion ; post-launch update cycle time for art change ; consistency of sprite pivots + hitboxes at runtime. |
| **Context** | Solo indie combined art+dev ; budget=open-source strict (self-host OSS only) ; offline-first ; pixel-art style strict palette + pixel-grid discipline ; git-hosted assets alongside code ; tool must run on dev's OS (Windows/macOS/Linux) ; ai_agent=yes ; scale=mvp ; ISO/IEC 29110-4-3 VSE. |
| **Anchor** | SWEBOK v4 KA4 Construction (construction tools, asset import pipeline) + KA8 Configuration Management (asset versioning) ; ISO/IEC 25010:2023 Maintainability (modifiability, reusability) + Compatibility (interoperability with downstream tooling) ; ISO/IEC 29110-4-3 VSE. |

## 2. Candidates discovered (G-1 archetype classes)

| # | Candidate | Archetype class | License | Scriptable | Metadata richness |
|---|-----------|-----------------|---------|:----------:|:-----------------:|
| 1 | Aseprite (self-compiled GPLv2 source) + .aseprite format | (a) dedicated editor + native format | GPLv2 source + paid Steam binary | yes (Lua CLI + headless) | high (frame tags, slices, palette) |
| 2 | LibreSprite (Aseprite fork) | (a) dedicated editor | MIT (fork of pre-relicense Aseprite) | yes (Lua) | high |
| 3 | Pixelorama (open-source pixel editor) | (a) dedicated editor | MIT | partial | medium (layers, palette, animation) |
| 4 | Krita pixel-art workspace + PNG export + sidecar JSON | (b) PNG + sidecar | GPLv3 | yes (Python) | medium (sidecar-authored) |
| 5 | GIMP + PNG + manual sidecar | (b) PNG + sidecar | GPLv3 | yes (Script-Fu, Python) | low (hand-rolled sidecar) |
| 6 | PSD-class + layer-name conventions | (c) layered doc | N/A (format) ; via Krita, GIMP | partial | medium (layer-conv interpreted) |
| 7 | Godot in-engine TileSet + sprite editor | (d) in-engine | MIT | engine-scripted | medium (engine-proprietary) |
| 8 | Photoshop + Aseprite workflow | commercial | Proprietary | yes | high |

## 3. Exclusions E1-E5

| Candidate | Criterion | Reason |
|-----------|-----------|--------|
| Photoshop | E5 commercial-tier incompatible with budget=open-source strict | Paid SaaS subscription ; budget gate rejects. |
| PSD via Photoshop | E5 commercial dependency | Krita / GIMP can open PSD but the format is not native open ; retained only in the (c) archetype for tool-independent interchange. |
| Aseprite Steam binary (purchased) | E5 partial — paid distribution | Purchased binary is a one-off payment, not SaaS, and does not recur. Under budget=open-source strict the GPLv2 source-build path is the compliant path. Kept via self-compile route only. |
| Pixelorama | E2 maturity signal relative to Aseprite | Active but younger ; metadata fidelity for animation frame tags + slices not yet at parity with Aseprite. Retained as secondary. |
| GIMP-only | E1 scope mismatch | General raster editor ; lacks pixel-art-specific ergonomics (onion-skin, per-frame timeline, palette lock) at a level that preserves authoring throughput. |

## 4. O-matrix (ordinal 1-5, higher=better ; O1 gate)

| Candidate | O1 Budget=OSS (gate) | O2 Metadata fidelity preservation | O3 Authoring throughput solo | O4 Scriptability / CLI | O5 Git-diff reviewability | Sigma |
|-----------|:--------------------:|:--------------------------------:|:---------------------------:|:----------------------:|:-------------------------:|:-----:|
| Aseprite self-compiled (GPLv2) + importer | 5 PASS | 5 | 5 | 5 | 2 (binary .aseprite) | 22 |
| LibreSprite | 5 PASS | 4 | 4 | 4 | 2 | 19 |
| Pixelorama | 5 PASS | 3 | 3 | 3 | 2 | 16 |
| Krita + PNG + sidecar JSON | 5 PASS | 3 | 3 | 4 | 5 (text PNG+JSON) | 20 |
| GIMP + PNG + sidecar | 5 PASS | 2 | 2 | 3 | 5 | 17 |
| Godot in-engine sprite editor | 5 PASS | 3 | 2 | 3 | 3 | 16 |
| Photoshop + Aseprite | 1 FAIL | 5 | 5 | 5 | 2 | excluded |

## 5. Top-3 with rationale

1. **Aseprite (self-compiled from GPLv2 source) + godot-aseprite-importer** (sigma 22). Highest O2 (rich metadata : frame tags, slices, pivot, palette, 9-slice) and O3 (pixel-art-native ergonomics : timeline, onion-skin, palette lock, tilemap mode). O5 git-diff reviewability is weak because .aseprite is binary, but compensated by scripted CLI export to PNG for diffable intermediates. GPLv2 source-build path meets budget=open-source strict.
2. **Krita + PNG + sidecar JSON** (sigma 20). Best O5 (both PNG and JSON are text-diffable / visual-diff-friendly). Scriptable via Python. O2 + O3 lag Aseprite because pixel-art ergonomics (timeline, per-frame tags) require sidecar discipline rather than native representation. Retained as a fallback for dev preference or Aseprite-source-build friction.
3. **LibreSprite** (sigma 19). MIT fork of pre-relicense Aseprite ; same interaction model, slightly older feature set. Strongest pure-MIT alternative if GPLv2 copyleft is a concern for combined distribution.

## 6. Kappa A vs B

Effective set (6 post-exclusion). A ranks Aseprite > Krita+sidecar > LibreSprite > Pixelorama > Godot > GIMP. B ranks Aseprite > LibreSprite > Krita+sidecar > Pixelorama > Godot > GIMP. Top-1 agrees. Tier 2-3 swap (LibreSprite vs Krita+sidecar). Tier agreement 5/6 = 83%, kappa ~0.79 "substantial".

Divergence DIV-LibreSprite-vs-Krita : A values git-diff reviewability (Krita+PNG+JSON wins O5) ; B values metadata fidelity preservation (LibreSprite wins O2). Supervisor arbitrage : Aseprite self-compiled top-1 is unaffected ; record both as tier-2 alternates depending on whether git diff discipline or metadata fidelity dominates for a given project.

## 7. GRADE with factors

Starting score : 2 (pyramid L3 — Aseprite docs L1 + GPLv2 source repo L1 + pixel-art community grey-lit MG-2 L5 + engine import pipeline docs L1).

Positive factors :
- +1 large effect : Aseprite + importer preserves frame tags, slices, pivot across round-trips ; community-reported authoring throughput gains are decisive for a solo art+dev role.

Negative factors :
- -1 monoculture discount : evidence base strongly concentrated on Aseprite + Godot ; the "pixel-art editor" category has few mature alternatives that a solo indie would actually adopt.
- -1 imprecision : metadata-preservation fidelity rate is not quantified across importers in primary peer-reviewed sources ; relies on grey-lit and issue-tracker threads.
- 0 indirectness : tools measured directly against outcomes.
- 0 inconsistency : rankings converge at top-1.

Score final : 2 + 1 - 2 = **1/7 -> ACCEPTABLE**.

## 8. Sources Table 2

| # | Source | Pyramid level | Year | Role |
|---|--------|:-------------:|:----:|------|
| 1 | Aseprite official docs + .aseprite format spec + GPLv2 source | L1 | 2025 | Tool + format anchor |
| 2 | godot-aseprite-importer OSS repo | L1 | 2025 | Import pipeline evidence |
| 3 | LibreSprite repo + docs | L1 | 2025 | MIT fork alternative |
| 4 | Pixelorama repo + docs | L1 | 2025 | OSS secondary |
| 5 | Krita + Python scripting docs | L1 | 2025 | Sidecar workflow capability |
| 6 | Lospec palette + pixel-art community surveys | L5 MG-2 grey-lit | 2024-2025 | Authoring throughput evidence |
| 7 | ISO/IEC 25010:2023 Maintainability + Compatibility | L1 standard | 2023 | Outcome anchor |
| 8 | ISO/IEC 29110-4-3 VSE | L1 standard | — | Solo-dev process anchor |

## 9. Primary recommendation

Adopt **Aseprite self-compiled from GPLv2 source + godot-aseprite-importer** as the primary pixel-art authoring path. Commit .aseprite files to git as the source of truth and automate CLI export to PNG + JSON atlas as a build step so that (a) diffable PNG intermediates exist for reviewability and (b) the A8 asset pipeline consumes deterministic outputs. Retain **Krita + PNG + sidecar JSON** as a documented fallback for contributors whose environment does not support self-compiling Aseprite. Retain **LibreSprite** as a pure-MIT alternative should GPLv2 copyleft become a distribution concern.

## 10. Decision + traceability

**Decision** : Aseprite (self-compiled GPLv2 source) + godot-aseprite-importer. Status GRADE ACCEPTABLE (1/7). Pixel-art HARD CONSTRAINT + open-source strict + combined art+dev role throughput dominate. Photoshop excluded by budget gate.

**Traceability** :
- PICOC source : `verification/picoc/mobile-game-picoc-batch-B.md` §B11 (independently identified by Reviewer A and B as a gap — reinforces gap legitimacy per MG-6)
- Protocol amendments : G-1 + #3 + MG-2 grey-lit + MG-6 cross-PICOC tagging
- Cross-references : B7 tile editor (consumes Aseprite tileset mode output) ; B10 animation (consumes Aseprite sprite-sheet + frame tags) ; A8 asset pipeline (CLI export integration) ; J43 AI asset render validation (Aseprite palette-lock enables palette-conformance gate).
- Anti-double-counting : tool selection credited to B11 ; downstream tile-editor authoring credited to B7 ; runtime sheet packing credited to A8.

Word count : ~1180 words.
