# Phase 1.3 Batch B — PICOCs : Asset Pipeline Tooling (domaine `mobile-game-2d`)

**Protocole** : `methodology.md` v3.0, section 1.3 + Amendement G-1 + Amendement #3
**Date** : 2026-04-21
**Methode** : double extraction (Reviewer A + Reviewer B, contextes isoles) + reconciliation superviseur
**Tracability** :
- Reviewer A : agent `a523e1240e6d5fb47`
- Reviewer B : agent `a90b1d18c45d25f3a`
- Superviseur humain : Gabriel (PO)

## Cadre upstream

Batch A a etabli 5 PICOCs : A1 (engine selection), A4' (simulation update), A6 (input), A7 (offline-first persistence), A8 (asset pipeline + bundle **architecture**).

**Ligne d'orthogonalite Batch B vs A8** :
- A8 = **architecture** du pipeline (build-time vs runtime packing, compression format class, bundle split strategies, hot reload pipeline-level)
- Batch B = **tool-category choice** par type d'asset (tile editor, font strategy, audio mixer, animation workflow, sprite authoring)

## Decisions candidates initiales (commissioning §1.2 Categorie B)

4 decisions pre-identifiees :
- B7. Tile-based level editor / pipeline
- B8. Font rendering strategy
- B9. Audio mixer / sound pipeline
- B10. 2D animation workflow

## Reconciliation A vs B

### Accord binaire

| # | Decision | Verdict A | Verdict B | Accord |
|---|----------|-----------|-----------|:------:|
| B7 | Tile-based level editor | RETAIN | RETAIN | V |
| B8 | Font rendering | RETAIN | RETAIN | V |
| B9 | Audio mixer | RETAIN | RETAIN | V |
| B10 | 2D animation | RETAIN (merged authoring+runtime) | RETAIN | V |

**Accord sur les 4 candidats initiaux : 4/4 = 100%. Kappa = 1.0 ("almost perfect")** — largement au-dessus du seuil 0.6. Convergence methodologique forte sur ce batch.

### Propositions hors liste initiale

| # propose | Decision | Propose par | Etat |
|-----------|----------|:-----------:|------|
| B11 (A: "B12") / B11 (B) | Pixel-art sprite authoring tool + source-format interchange | **A et B independamment** | CONVERGENCE FORTE - retenu |
| B11 (A: "B11") | Localization string catalog + extraction + pluralization pipeline | A seul (B l'absorbe dans B8) | DIVERGENCE - redirige vers Batch G |

**Convergence independante sur le pixel-art authoring tool** : A et B ont tous deux identifie spontanement ce gap (non dans la liste initiale des 4 candidats). Cela valide la proposition methodologiquement — c'est un vrai gap de scope non un ajout arbitraire. **RETENU comme B11**.

**Divergence i18n pipeline** :
- Position A (retenir comme B11) : le string catalog + pluralization + extraction est orthogonal a A1/A8/B8 (font rendering). Literature distincte (ICU MessageFormat, gettext PO, XLIFF, W3C i18n).
- Position B (absorb dans B8) : parsimony — font coverage et string tables se couplent fortement.

**Arbitrage superviseur** : **DROP de Batch B**. Rationale :
1. Le commissioning Phase 1.2 a une **Categorie G dediee a la localization** avec 3 decisions candidates (G30 workflow, G31 font fallback multi-script, G32 pluralization+interpolation). Promouvoir l'i18n en B11 duplique le futur Batch G.
2. Position B retenue partiellement : l'aspect "font coverage multi-script" reste dans B8 (c'est bien un concern font).
3. Position A retenue partiellement : le string catalog + extraction + pluralization merite une PICOC separée, **mais dans Batch G**, pas Batch B.

**Resultat** : l'i18n est propose comme PICOC *dans Batch G*, pas Batch B. Le reviewer A aura eu raison sur l'orthogonalite — juste sur le placement.

### Notes sur les framings A vs B sur les 4 PICOCs communes

**B7 Tile editor** :
- A propose 3 classes : (a) external declarative editor + format ; (b) engine-native integrated ; (c) hand-rolled data-driven
- B propose 3 classes equivalentes avec framing legerement different
- Convergence sur outcomes (throughput, iteration latency, format stability)
- **Framing retenu** : fusion - 3 classes de A (plus explicite), outcomes mesurables combines

**B8 Font rendering** :
- A propose 4 classes : bitmap atlas / TTF-runtime-raster / SDF-MSDF / hybrid
- B propose meme taxonomie avec axes de comparaison
- A mentionne CJK comme stretch target ; B comme part of P
- **Arbitrage** : CJK **dans P** (partie du multi-language baseline). Impact : Phase 2.1 devra evaluer serieusement le CJK glyph coverage par strategy.

**B9 Audio** :
- A propose 4 classes : engine built-in / commercial middleware / OSS library / hand-wrapped platform-audio
- B propose equivalent mais souligne **interaction ad-SDK audio-focus**
- **Retenu** : framing A (4 classes explicites) + ad-SDK audio-focus concern de B dans Co

**B10 Animation** :
- A propose entangled merge (representation + toolchain) comme seule PICOC
- B propose meme approche, flag possibilite split B10a/B10b mais garde merged
- **Retenu** : merged framing A/B convergence. Pas de split.

## PICOCs retenus - Batch B final

### PICOC #B7 — Tile-based level authoring workflow + interchange format

| Element | Valeur |
|---------|--------|
| **P** | Dev indie solo produisant un jeu mobile 2D pixel-art **tile-based** (farming-sim / strategy / puzzle archetypes), portrait Android+iOS stores, offline-first, avec representation du monde en layers grid-aligned (tile layers, object/entity layers, collision/metadata layers), map count typique 20-200 levels, edition frequente sur cycle multi-mois, scale de levels 64x64 a chunks infinis. |
| **I** | Classe de **tile-based level authoring workflow + interchange data format**. 3 sous-classes non-exhaustives : (a) external standalone declarative tile editor exportant un format communautaire documente, consume au runtime par un loader library ; (b) engine-native integrated scene/tilemap editor avec serialization engine-proprietaire ; (c) hand-rolled data-driven authoring (CSV/JSON/in-game editor) avec bespoke runtime loader. Axes : authoring-tool locus + format portability + loader maturity. |
| **C** | À découvrir systématiquement en Phase 2.1 (recherche multi-bases : GitHub topics `tilemap-editor`/`level-editor`, engine marketplace listings, indie post-mortems, GDC Vault, Stack Overflow Developer Survey tool-usage bands, community directories `awesome-gamedev`, CG academic literature procedural/authored level representation). **Pre-identification prohibée per Amendement G-1.** |
| **O** | **Mesurables** : (a) map-authoring throughput (tiles places / heure, controlled task) ; (b) iteration latency (s de "save-in-editor" a "visible change in running mobile build") ; (c) import-library binary size delta (KB ajoutes a APK/IPA) ; (d) runtime map-load time pour 64×64 multi-layer tile map (ms, cold + warm) ; (e) memory footprint loaded map (MB) ; (f) format migration cost au tool version bump (dev-hours + LOC diff) ; (g) format lock-in risk score (proprietaire binaire vs documented open text). **User-facing** : (h) perceived level-loading smoothness (no stutter > 16 ms at transition) ; (i) level-design expressiveness (number of tile layers / object types supported) ; (j) playable-world consistency cross-device. **Ecosystem** : (k) ecosystem longevity (commit activity, last release recency). |
| **Co** | Solo indie, near-zero licensing budget (tolere one-off < 100 USD), Android + iOS shipping, offline-first, tile sizes 16-32 px pixel-art, maps git-versioned alongside code, asset changes reviewable as text diffs where feasible. ISO/IEC 29110-4-3 VSE (minimal ceremony). |
| **Question** | "Pour un dev indie solo produisant un jeu 2D pixel-art tile-based mobile Android+iOS portrait offline-first, **quelle classe de tile-based level authoring workflow + interchange format** (external declarative editor + community format vs engine-native scene/tilemap editor vs hand-rolled data format) optimise le compromis authoring throughput + iteration latency + runtime load performance + format-lock-in risk, sur un maintenance window multi-annees ?" |
| **Anchor** | **SWEBOK v4** : KA2 Design (data modelling level representation), KA4 Construction (tooling ecosystem integration), KA8 Configuration Management (stability authored artifacts cross tool versions). **ISO/IEC 25010:2023** : Maintainability (modifiability of levels, reusability of tilesets), Portability (adaptability engine/platform), Performance Efficiency (time behaviour map load, resource utilization). **ISO/IEC 29110-4-3** : VSE profile. |
| **Dependances** | **Partial A1** (engine constrains which loader libraries are production-grade), **partial A8** (map tile atlas shares pipeline — A8 packing, B7 authoring). **Weak dep B11** (tileset authoring happens in B11, B7 consumes). |

---

### PICOC #B8 — Font rendering strategy for pixel-art + multi-script mobile UI

| Element | Valeur |
|---------|--------|
| **P** | Dev indie solo shippant un jeu mobile 2D pixel-art portrait Android+iOS avec UI text = dialogue + menus + HUD counters + legal/privacy text + tutorial, cible localization **incluant au minimum Latin-1 + extended European + CJK (Simplified Chinese, Japanese) + optionnellement Cyrillic/Arabic/Hebrew (RTL)** pour store reach global, preservation aesthetique pixel-art, readability device DPIs 160-500+ dpi. |
| **I** | Classe de **font rendering strategy**. 4 sous-classes : (a) pre-rasterized bitmap font atlas fixed pixel sizes (optionally multi-size) ; (b) runtime vector rasterization TTF/OTF via vector-font library ; (c) distance-field representation (single-channel SDF ou multi-channel MSDF) avec shader-based reconstruction ; (d) hybrid = bitmap atlas pour Latin pixel-font identity + runtime-raster fallback pour CJK/extended. Axes : rasterization locus (build-time vs runtime), memory footprint par script, scaling fidelity, pixel-art integrity preservation. |
| **C** | À découvrir systématiquement en Phase 2.1 (recherche : ACM DL / IEEE Xplore signed-distance-field text rendering, engine docs font subsystems, GitHub topics `msdf`/`bitmap-font`, pixel-art community blogs font-authoring practice, W3C i18n WG, Apple HIG / Material Design typography guidance). **Pre-identification prohibée per Amendement G-1.** |
| **O** | **Mesurables** : (a) glyph memory footprint par script (MB GPU + CPU) ; (b) cold startup text-readiness latency (ms engine init → first rendered glyph) ; (c) per-frame text-draw cost dialogue screen (ms/frame) ; (d) APK/IPA size delta per added script (MB) ; (e) runtime text-layout correctness bidirectional/complex-shaping scripts (pass/fail localization test corpus) ; (f) CJK glyph-coverage ratio (% top-N frequency glyphs). **User-facing** : (g) legibility native resolution (MOS user test ou expert heuristic) ; (h) pixel-art aesthetic preservation (crispness + no anti-alias bleed when intended) ; (i) zoom/scale stability sans re-rasterization artifacts ; (j) accessibility compliance (WCAG 2.2 SC 1.4.4 Resize Text, SC 1.4.12 Text Spacing ; HIG Dynamic Type ; Material Design type system). |
| **Co** | Solo indie ; pas de designer font ; open-licensed ou one-off affordable fonts ; offline-first (pas de font download runtime comme seule path) ; store compliance legal text rendu dans localized languages ; WCAG 2.2 text-contrast + minimum-size applies. |
| **Question** | "Pour un jeu mobile 2D pixel-art indie solo avec multi-script localization (Latin + CJK baseline), **quelle classe de font rendering strategy** (bitmap atlas / TTF runtime raster / SDF-MSDF / hybrid) maximise le compromis pixel-art aesthetic fidelity + memory footprint + startup latency + scaling stability + per-script authoring/integration cost + accessibility conformance ?" |
| **Anchor** | **SWEBOK v4** : KA3 Design (UI subsystem), KA4 Construction (font pipeline integration), KA1 Requirements (i18n NFRs). **ISO/IEC 25010:2023** : Usability (appropriateness recognizability, user-interface aesthetics, Inclusivity/Accessibility), Performance Efficiency (resource utilization, time behaviour), Compatibility (portability cross-locales). **ISO/IEC 25019** : Quality-in-use for visual outputs. **WCAG 2.2** : 1.4.x Perceivable (Resize Text 1.4.4, Text Spacing 1.4.12, Contrast 1.4.3). **Apple HIG** typography + Dynamic Type. **Material Design** type system. |
| **Dependances** | **Partial A1** (engine defaults shape viable paths), pas absorbed by A8 (A8 ships font artifact, B8 chooses class). **Weak dep B11** (i18n string catalog in Batch G) : B8 fournit la glyph coverage, Batch G fournit le catalog. |

---

### PICOC #B9 — Audio runtime + mixer subsystem choice

| Element | Valeur |
|---------|--------|
| **P** | Dev indie solo produisant un jeu mobile 2D pixel-art Android+iOS avec audio scope = ambient/music loops (layered/stem-based cozy/farming, optionally dynamic pour action) + UI/SFX events (tens-to-low-hundreds distinct cues) + optional ambience beds + dialogue-adjacent one-shots, avec comportements gameplay-reactifs (music ducking on dialogue, crossfade on area transitions, time-of-day layering), conformite mobile audio-session (interruption call/Bluetooth/background/foreground, OS-level ducking, silent-switch iOS). |
| **I** | Classe de **audio runtime + mixer subsystem**. 4 sous-classes : (a) engine-built-in audio subsystem as-is ; (b) third-party commercial audio middleware avec mobile runtime + authoring tool ; (c) open-source audio library integree atop engine ; (d) low-level platform-audio abstraction hand-wrapped (OpenSL ES / AAudio Android, AVAudioEngine / AudioToolbox iOS). Axes : authoring-tool presence, mixer-graph expressiveness, licensing cost, runtime overhead, platform audio-session correctness, **ad-SDK audio-focus interoperability**. |
| **C** | À découvrir systématiquement en Phase 2.1 (recherche : audio-middleware vendor docs, GDC audio track talks, GitHub topics `audio-middleware`/`game-audio`, engine audio subsystem docs, AES conference papers interactive audio, Apple + Android platform audio guidelines, indie dev surveys on audio). **Pre-identification prohibée per Amendement G-1.** |
| **O** | **Mesurables** : (a) audio-subsystem cold init latency (ms) ; (b) mixer voice limit mid-range mobile hardware (concurrent voices at ≤ X% CPU budget) ; (c) audio dropout/glitch rate sous simulated load (events/minute) ; (d) trigger-to-first-sample latency median + jitter (ms) ; (e) binary size delta audio runtime (MB) ; (f) memory footprint loaded audio graph (MB) ; (g) licensing cost a solo-indie revenue tier (USD) ; (h) authoring-tool learning ramp (dev-hours a ship first mixer graph) ; (i) iteration loop time (edit-in-tool → hear-in-game, s). **User-facing** : (j) perceptual smoothness music ducking + crossfade (expert rubric) ; (k) correct interruption behavior (call, Bluetooth connect/disconnect, backgrounding, alarm, voice assistant — pass/fail test matrix) ; (l) silent-switch + background-audio-policy conformance iOS ; (m) ad-SDK video-ad audio handover (no glitch, no focus-loss residue). |
| **Co** | Solo indie, revenue-share licensing OK si below store-review thresholds ; Apple ASRG audio-session ; Google Play audio-focus ; offline-first (pas de streaming network-only path) ; portrait mobile game avec ads + IAP (rewarded-video audio handover CRITIQUE) ; ≤1 composer/sound designer (solo dev ou contracted). |
| **Question** | "Pour un jeu mobile 2D pixel-art indie solo Android+iOS avec music + SFX + reactive mixer behaviors et monetization ads+IAP, **quelle classe de audio runtime + mixer subsystem** (engine built-in / commercial middleware / OSS library / hand-wrapped platform-audio) optimise le compromis mixer-graph expressiveness + runtime cost + licensing fit + platform audio-session compliance + ad-SDK audio-focus interoperability ?" |
| **Anchor** | **SWEBOK v4** : KA3 Design (audio subsystem architecture), KA4 Construction (third-party integration), KA14 Professional Practice (licensing compliance). **ISO/IEC 25010:2023** : Performance Efficiency (time, resource utilization), Reliability (recoverability from audio-focus loss, fault tolerance interruption), Compatibility (co-existence with ad SDKs + OS audio services). **Apple App Store Review Guidelines** audio-session rules. **Google Play Developer Program Policy** audio-focus + ads interaction. **Apple HIG** Playing Audio. |
| **Dependances** | **Partial A1** (engine built-in is default option). Orthogonal A8 (audio assets shippes via A8 pipeline ; mixer choix est B9). Ad-SDK interaction surface ici mais sera PICOC separee en Batch E (monetization). |

---

### PICOC #B10 — 2D animation representation + authoring toolchain (pixel-art)

| Element | Valeur |
|---------|--------|
| **P** | Dev indie solo avec role combine dev+art produisant un jeu mobile 2D pixel-art (portrait Android+iOS, farming-sim genre) requerant animated entities : player avatar (idle/walk/run/action directional cycles), NPCs (idle + context animations), crops (multi-stage growth), creatures, environmental (water, foliage sway, weather), UI/feedback. Cultural norm pixel-art favorise discrete-frame animation visible native resolution. Cycle multi-mois solo. |
| **I** | Classe de **combined animation representation + authoring toolchain**. 2 axes entangled : **representation** ∈ {frame-by-frame sprite sheet per-frame data, skeletal 2D rig bones+deformers, mesh-deformation/cutout, declarative tween + state-machine} PAIRE **authoring locus** ∈ {engine-native animation editor, external dedicated 2D animation tool + runtime-import library, code-driven/data-declarative state machines text-authored}. Tuple-joint car representation souvent dicte toolchain (skeletal → external tool avec runtime ; frame-by-frame → engine-native OK). |
| **C** | À découvrir systématiquement en Phase 2.1 (recherche : GDC Vault animation track, GitHub topics `2d-animation`/`skeletal-animation`, engine animation docs, pixel-art community tooling surveys, ACM CG/SIGGRAPH literature 2D skeletal systems + mesh deformation, indie postmortems animation scope). **Pre-identification prohibée per Amendement G-1.** |
| **O** | **Mesurables** : (a) authoring throughput (frames ou poses authored / developer-day for baseline character spec) ; (b) per-character memory footprint (MB texture + skeleton/mesh data) ; (c) per-frame animation-update CPU cost for N on-screen animated entities (ms/frame a 60 fps target) ; (d) max simultaneous animated instances before frame-budget breach ; (e) bundle-size contribution per animation (bytes) ; (f) runtime import-library binary size (MB) ; (g) iteration latency (animation-edit → on-device preview, s) ; (h) rework cost character redesign (hours a re-author). **User-facing** : (i) perceived animation quality + expressiveness (playtest/heuristic rating) ; (j) pixel-art aesthetic preservation (binary : visible non-integer-pixel artifacts YES/NO) ; (k) input-to-animation-reaction latency (ms) ; (l) frame-time stability scenes many animated entities (jank-frame ratio). |
| **Co** | Solo dev combined role, licensing budget prefer open ou one-off < 100 USD ; pixel-art aesthetic product differentiator (HARD CONSTRAINT) ; animation assets ship in-bundle (offline-first) ; portrait mobile moderate density on-screen animated entities (pas AAA crowd). ISO/IEC 29110-4-3 VSE. |
| **Question** | "Pour un jeu mobile 2D pixel-art indie solo, **quelle classe combinee de 2D animation representation + authoring toolchain** (frame-by-frame vs skeletal vs mesh-deform vs declarative state-machine, pairee avec engine-native vs external-tool vs code-driven) optimise authoring throughput + on-device animated-instance capacity + pixel-art aesthetic fidelity strict ?" |
| **Anchor** | **SWEBOK v4** : KA3 Design (animation system design), KA4 Construction (runtime integration authoring-tool exports). **ISO/IEC 25010:2023** : Performance Efficiency (time behaviour, resource utilization), Usability (user-interface aesthetics appropriateness recognizability via fidelity preservation), Maintainability (modifiability/reusability rigs/sheets). **Apple HIG** Games (motion). **Material Design** motion. |
| **Dependances** | **Partial A1** (engine ecosystem constrains mature runtime-import libraries). Orthogonal A8 (A8 ships binary artifact, B10 choisit representation). Weak dep A4' (animation advancement couple simulation update strategy fixed-step vs delta-time ; pour farming-sim couplage faible). **Strong dep B11** (si frame-by-frame retenu, B11 pixel-art tool = primary animation tool). |

---

### PICOC #B11 — Pixel-art sprite authoring tool + source-format interchange

**Note** : ce PICOC a ete identifie **independamment** par Reviewer A (comme B12) ET Reviewer B (comme B11) comme gap du batch initial — forte convergence.

| Element | Valeur |
|---------|--------|
| **P** | Dev indie solo avec role combine dev+art produisant sources pixel-art pour un jeu mobile 2D pixel-art Android+iOS : character sprite sheets avec per-frame origin/pivot + animation frame tags + 9-slice regions UI panels + hitbox rectangles + palette swap tables, tilesets (consomme par B7), UI sprites, icon assets store (Google Play listing, Apple App Store). Must move assets from authoring tool to engine runtime preserving metadata ; git-versioned alongside code ; multi-month project. |
| **I** | Classe de **pixel-art sprite authoring tool + source-format interchange**. 4 sous-classes : (a) dedicated pixel-art editor native format riche metadata (frame tags, slices, palette) consume par engine-side import library ; (b) generic raster format (PNG) + sidecar metadata JSON/TOML decrivant slices+tags ; (c) layered-document format (PSD-class) avec layer-name conventions interpretees a import ; (d) in-engine sprite editor avec engine-proprietary metadata storage. Axes : palette discipline support, animation timeline fidelity, tileset-export alignment avec B7, batch/CLI scriptability pour A8 integration, cross-platform authoring-OS availability. |
| **C** | À découvrir systématiquement en Phase 2.1 (recherche : pixel-art tool surveys, engine import-pipeline docs, GitHub topics `aseprite-importer`/`sprite-importer`/`pixel-art-editor`, pixel-art community forums + blogs, indie postmortems pixel-art tooling). **Pre-identification prohibée per Amendement G-1.** |
| **O** | **Mesurables** : (a) sprites authored per developer-hour (baseline spec) ; (b) per-sprite authoring-to-runtime round-trip latency (s) ; (c) metadata fidelity preservation rate (% slices/tags/pivots surviving import) ; (d) import-library binary size (KB) ; (e) source-format git-diff reviewability (text-diff vs binary-blob — binary pass/fail + if binary: diff tool available YES/NO) ; (f) scriptability / headless invocation for A8 pipeline (boolean + evidence) ; (g) palette consistency violations per project (count off-palette pixels in shipped atlas) ; (h) tool licensing cost (USD one-off). **User-facing** : (i) shipped-art aesthetic cohesion (playtest/heuristic palette + style consistency) ; (j) post-launch update cycle time for art change (days) ; (k) consistency of sprite pivots + hitboxes at runtime (QA pass rate gameplay alignment). |
| **Co** | Solo indie combined art+dev ; offline-first ; pixel-art style strict palette + pixel-grid discipline ; assets live in git repo ; tool must run on dev's OS (Windows/Mac/Linux); ISO/IEC 29110-4-3 VSE. |
| **Question** | "Pour un dev indie solo d'un jeu mobile 2D pixel-art, **quelle classe de pixel-art sprite authoring tool + source-format interchange** (dedicated pixel editor native format vs PNG+sidecar JSON vs PSD+layer conventions vs in-engine sprite editor) maximise authoring throughput + palette/style consistency + metadata fidelity + integration avec downstream B7 tile editor + B10 animation + A8 pipeline ?" |
| **Anchor** | **SWEBOK v4** : KA4 Construction (construction tools, asset import pipeline), KA8 Configuration Management (asset versioning). **ISO/IEC 25010:2023** : Maintainability (modifiability, reusability), Compatibility (interoperability with downstream tooling). **ISO/IEC 29110-4-3** VSE. |
| **Dependances** | **Upstream of B7 + B10 + A8**. Orthogonal A1 (engine-agnostic authoring typical) sauf (d) in-engine editor qui impose A1 coupling. |

---

## Decisions dropped / merged

| Decision | Action | Justification | Redirection |
|----------|--------|---------------|-------------|
| A's "B11" i18n pipeline | DROP de Batch B | Categorie G du commissioning Phase 1.2 dedie a la localization (G30 workflow, G31 font fallback, G32 pluralization) | Promote vers **Batch G** (a formuler plus tard). Font coverage multi-script reste dans B8. |
| Texture compression format per asset type | ABSORBED A8 | A8 explicitly scope "texture compression FORMAT selection class" | — |
| Atlas packing build-time vs runtime | ABSORBED A8 | Idem | — |
| Audio codec choice (Ogg/Opus/AAC) | ABSORBED A8 | Closer to A8 compression-format-class que B9 mixer choice | — |
| Per-density multi-resolution output | ABSORBED A8 | — | — |
| Pipeline-level hot-reload of assets | ABSORBED A8 | A8 outcome (h) hot-reload pipeline-level ; B7/B10/B11 ont leur iteration latency propre mesuree separement | — |
| String/localization table delivery format | ABSORBED A8 | A8 = bundle delivery. Catalog FORMAT decision = Batch G | — |
| Particle/VFX authoring tool | OUT OF SCOPE | Pour farming-sim pixel-art pilot : VFX = sprite-sheet animations absorbed B10. Revisite si genre pilot change. | — |
| Shader authoring tool | OUT OF SCOPE | Pixel-art P minimizes shader work. Tout shader authoring = engine-coupled activity (A1), not pipeline tool category. | — |
| Cutscene / dialogue / narrative tool | OUT OF SCOPE | Genre-dependent, farming/puzzle/strategy P canonique exclut narrative-heavy | — |

## Open questions pour Phase 1.5 + Agent C

### Questions scope a trancher par PO

1. **CJK glyph coverage dans P de B8** : retenu comme **baseline** (pas stretch). Impact : Phase 2.1 doit serieusement evaluer CJK support par strategy. PO confirme ?
2. **Ad-SDK audio-focus dans B9** : laisse comme contrainte Co mais sera **CROSS-REFERENCE** avec PICOC Batch E monetization (E22 ad SDK). Pas de redondance, mais cross-link dans consolidated PICOC file.
3. **B11 placement** : l'upstream-of-B7-B10-A8 positioning implique que B11 sera probablement **le premier PICOC a extraire en Phase 2** dans la sequence dependance. A tenir en tete pour Phase 1.5 pilot ordering.

### Questions Agent C (Phase 1.5 verification)

4. Verifier verbatim : **WCAG 2.2 SC 1.4.4 Resize Text** et **SC 1.4.12 Text Spacing** existent et sont correct pour B8 anchor.
5. Verifier verbatim : **Apple ASRG audio-session rules** existent et section Audio.
6. Verifier existence : **ISO/IEC 29110-4-3 VSE profile** part 4-3 confirme.
7. Verifier : **SIGGRAPH publications 2D skeletal deformation** existent et sont citables (B10 anchor).

### Questions Phase 2.1 extraction

8. Phase 2.1 pour B7 : chercher aussi **chunked/streaming tilemap** literature (pour maps > 64×64 non-chargees at-once).
9. Phase 2.1 pour B8 : chercher specifiquement **pixel-art preservation sous SDF** (generalement SDF = smooth, risque artefacts pour pixel discret).
10. Phase 2.1 pour B10 : **frame-by-frame vs skeletal cost curve** in function of entity count (point de bascule).
11. Phase 2.1 pour B11 : chercher literature sur **metadata preservation** cross-tool (lossy vs lossless import).

## Statut Batch B

- **5 PICOCs retenues** : B7, B8, B9, B10, B11
- **Kappa brut** : 4/4 = 100% sur candidats initiaux + convergence independante sur B11 pixel-art authoring = **kappa ~ 1.0 "almost perfect"**
- **Cross-batch dependencies** documentees (A1, A7, A8, B7↔B11, B10↔B11, B9↔Batch E, B8↔Batch G)
- **Coverage matrix** : ISO 25010 couverture (Maintainability, Performance Efficiency, Usability, Compatibility, Reliability), SWEBOK KA3/4/8/14 plus KA1 (i18n) pour B8

**APPROVED pour Phase 1.3 Batch C.**
