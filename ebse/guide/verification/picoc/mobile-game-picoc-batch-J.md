# Phase 1.3 Batch J — PICOCs : AI Collaboration Inheritance (domaine `mobile-game-2d`)

**Protocole** : methodology.md v3.0 §1.3 + Amendement G-1 + Amendement #3
**Date** : 2026-04-21
**Methode** : double extraction + reconciliation
**Tracability** :
- Reviewer A : agent `a90593a9552aa77a1`
- Reviewer B : agent `a2dd4c4fa68a03c62`

## Cadre upstream

36 PICOCs formulees dans Batches A-I + **17 PICOCs hérités du domaine `ai-collaboration`** (formulated in prior SLR) :
1. Autonomy granularity per action ; 2. Task-type routing ; 3. Human-only decision gates ; 4. Deterministic verification gates ; 5. Multi-agent topology ; 6. Escalation protocol ; 7. Context compaction ; 8. CLAUDE.md/AGENTS.md persistent instructions ; 9. Permissions & sandbox ; 10. Silent-failure monitoring ; 11. DORA/SPACE metrics ; 12. Model routing ; 13. Situational awareness ; 14. Prompt/spec discipline ; 15. Writer/reviewer gates ; 16. Budget caps ; 17. Audit trail.

## Reconciliation A vs B

**Convergence parfaite**. Both reviewers identify exactly the same residual :

| Decision | Verdict A | Verdict B | Accord |
|----------|-----------|-----------|:------:|
| J43 AI asset render validation gate | NEW PICOC (J43) | NEW PICOC (J43.1) | V |
| Gameplay determinism + AI code | INHERITED (#4 extended) | CROSS-LINK A4' + #4 composition | V |
| AI-generated assets through A8 pipeline | INHERITED (#4 + #17 + A8) | COVERED by A8 + #17 | V |
| Game design review / fun-factor | OUT OF SCOPE EBSE | REJECTED (ai-collab #3 covers structural gate) | V |
| Prompt libraries / API cost / engine idioms | — | REJECTED (#14, #16, #8) | V |

**Kappa : 5/5 = 100% ("almost perfect")**. Strongest convergence of the entire Phase 1.3.

**Rationale shared** :
- `ai-collaboration` #4 (deterministic verification gates) covers **textual** gates (unit tests, lint, type-check, build) — does NOT cover **perceptual/rendered** validation
- `ai-collaboration` #10 (silent-failure monitoring) = runtime anomalies post-ship — not pre-merge asset correctness
- `ai-collaboration` #15 (writer/reviewer gates) = code review — does NOT address pixel-accurate / golden-image review

→ Genuine game-specific residual : **perceptual verification of AI-generated / AI-wired game assets** (sprites, animations, tilemaps, audio, shaders).

## PICOC retenu — Batch J final (1 PICOC)

### PICOC #J43 — Perceptual / rendered validation gate for AI-generated or AI-wired game assets

| Element | Valeur |
|---------|--------|
| **P** | Dev indie solo 2D pixel-art mobile games (Android+iOS, portrait, offline-first, ads+IAP+leaderboards) developped avec AI coding agents (Claude Code, Cursor, Copilot, Aider, ou equivalent) ou l'agent produces, modifies, imports, references, ou wires : sprite sheets, tile atlases, animations, particle definitions, shader snippets, audio clips/loops, ou leur manifest metadata (pivots, frame timings, UVs, loop points, palette indices). |
| **I** | **Pre-merge perceptual verification gate** executed on any AI-authored or AI-touched asset change. 5 sous-composants : (i) automated **golden-image / perceptual-hash diff** on rendered sprite + animation frames per device-class resolution ; (ii) **audio fingerprint / loop-continuity checks** on generated or re-encoded audio (sample rate, loop points, click/pop detection) ; (iii) **palette-lock + alpha-channel-policy linting** for pixel-art fidelity (pixel-art strict palette discipline) ; (iv) **atlas-UV + pivot-offset schema validation** (sub-pixel drift detection) ; (v) **mandatory human visual/audio spot-check review** for any diff exceeding perceptual threshold. Gate enforced in CI + in agent's sandboxed test loop (composes with ai-collab #4 + #9 + #15). |
| **C** | À découvrir systématiquement en Phase 2.1. **Alternatives de comparaison** : (C1) AI agent setup avec **text-level CI gates only** (ai-collab #4 alone : unit tests + lint + type-check + build), no perceptual/rendered validation ; (C2) Human-only manual QA of rendered assets without automated perceptual diffing ; (C3) Post-merge / post-release detection via user bug reports ou store-review graphical-glitch signals ; (C4) No AI-generated assets (human-authored only). **Pre-identification prohibée per Amendement G-1** (pas de "PerceptualDiff tool X vs Y"). |
| **O** | **Primary** (ISO 25010 Functional Correctness + ISO 25019 data quality asset manifests) : (a) rate of visually/audibly defective assets reaching main per 100 AI-authored asset PRs ; (b) rate of rendered-output regressions (pivot drift, palette corruption, atlas bleeding, audio click/pop, animation frame-order bugs) escaping to production builds. **Secondary** (ISO 25010 Reliability/Maintainability) : (c) mean review-cycle time per asset PR ; (d) defect-escape ratio (perceptual vs text-level) ; (e) rework rate on AI-generated asset batches. **Tertiary operational** : (f) store-review graphical-glitch complaint rate ; (g) asset-rollback frequency ; (h) solo-dev time-to-detect perceptual defects. **Safety/governance** (ISO 42001, NIST AI 600-1) : (i) auditability of which AI-generated assets were human-verified (composes with ai-collab #17 audit trail) ; (j) coverage of AI-asset-license provenance checks attached to the gate. |
| **Co** | Solo-indie resourcing (NO dedicated QA/art director) ; 2D pixel-art **aesthetic sensitivity CRITICAL** (1-pixel errors user-visible, palette-indexed art sensitive to quantization) ; portrait-mobile target resolutions across Android + iOS device classes ; offline-first runtime (NO server-side asset fixups) ; monetized surfaces (ads + IAP + leaderboards) ou visual/audio defects directly impair conversion + retention ; solo developer CANNOT sustain manual visual review of every generated asset → **automation is load-bearing**. **Scope explicit exclusions** : generic code-level AI-agent controls (already ai-collaboration #1-17) ; gameplay-loop determinism (A4' cross-link) ; pipeline packaging/compression invariants (A8 cross-link). |
| **Question** | "Pour un jeu mobile 2D pixel-art indie solo offline-first Android+iOS portrait developpe avec AI coding agents produisant/modifiant/cablant assets (sprites/atlases/animations/tilemaps/audio/shaders/manifest metadata), **quelle classe de perceptual/rendered validation gate pre-merge** (automated golden-image + audio-fingerprint + palette-lock + atlas-UV + human spot-check threshold-triggered vs text-level gates only vs human-only manual vs post-merge detection vs no-AI-assets baseline) minimise rate of visually/audibly defective assets reaching main + rendered-output regression escape rate + mean review-cycle time, tout en gardant auditability (ai-collab #17) + provenance + solo-dev time-to-detect sustainable ?" |
| **Anchor** | **ISO/IEC 25010:2023** : Functional Suitability (Correctness of rendered output), Reliability (Maturity — regression rate asset bugs), Maintainability (Modularity — gate separable from pipeline), Performance Efficiency (Resource utilization — atlas size / audio memory post-generation). **ISO/IEC 25019** : Data quality in use (asset manifest integrity, palette fidelity). **ISO 42001** : AI management system (audit trail AI-generated content). **NIST AI 600-1** : Generative AI risk (output validation). **OWASP MASVS** : V3 Integrity (asset integrity client-side). **`ai-collaboration` PICOCs extended** : #4 (deterministic verification gates — J43 adds render-time sibling gate alongside existing textual gates) ; #15 (writer/reviewer gates — J43 provides perceptual reviewer role) ; #17 (audit trail — J43 binds provenance to render-validated assets). |
| **Dependances** | **Extends ai-collab #4** (adds render-time sibling gate alongside textual gates for asset sub-population). **Composes with ai-collab #9** (sandbox — gate runs in agent sandbox before merge). **Composes with ai-collab #15** (writer/reviewer — human spot-check is reviewer role for perceptual diffs). **Composes with ai-collab #17** (audit trail bound to render-validated assets). **Cross-link A4'** (gameplay determinism verification for AI-generated gameplay code is absorbed into A4' + ai-collab #4 composition, NOT J43 scope). **Cross-link A8** (pipeline packaging invariants covered by A8 — J43 operates pre-pipeline at source-asset level). **Cross-link B10** (if AI-generated animations, J43 perceptual diff applies). **Cross-link B11** (pixel-art authoring tool — J43 verifies AI-generated sprites conform to palette/authoring conventions). |

---

## Ai-collaboration PICOCs — inheritance confirmation

Les 17 PICOCs `ai-collaboration` sont **hérités tels quels** pour le domaine `mobile-game-2d`, avec parameter adjustments au synthesis time :

| # | ai-collab PICOC | Inheritance | Parameter adjustment pour jeu |
|---|-----------------|-------------|-------------------------------|
| #1 | Autonomy granularity per action | Inherited as-is | Agent write access to `assets/` + gameplay code paths |
| #2 | Task-type routing | Inherited as-is | Game task types : rendering, audio, gameplay logic, IAP/ads |
| #3 | Human-only gates | Inherited as-is | Game-specific gates : monetization tuning, balance changes, store-listing updates |
| #4 | Deterministic verification gates | **Extended by J43** | J43 adds render-time sibling gate alongside textual gates |
| #5 | Multi-agent topology | Inherited as-is | Possible art-agent + code-agent + design-agent split |
| #6 | Escalation protocol | Inherited as-is | J43 gate failures escalate per #6 |
| #7 | Context compaction | Inherited as-is | Long game-dev sessions (months) |
| #8 | CLAUDE.md / AGENTS.md persistent instructions | Inherited — **game-specific content** | Pixel-art constraints, palette lock, Flame/Flutter patterns, 2D mobile idioms |
| #9 | Permissions & sandbox | Inherited as-is | `assets/` + `lib/` + `android/` + `ios/` paths sandbox |
| #10 | Silent-failure monitoring | Inherited as-is | Post-ship monitoring = H35 crash-free + H36 analytics |
| #11 | DORA/SPACE metrics adapted | Inherited — **game-specific metrics** | Asset iteration cycle time, gameplay test suite runtime |
| #12 | Model routing | Inherited as-is | Smaller models for asset metadata ; larger for gameplay logic |
| #13 | Situational awareness human | Inherited as-is | Solo dev stays in loop on core gameplay + monetization changes |
| #14 | Prompt/spec discipline | Inherited as-is | Game-specific style guides + conventions |
| #15 | Writer/reviewer gates | **J43 extends** | Perceptual reviewer role for asset diffs |
| #16 | Budget caps + cost controls | Inherited as-is | Image/audio generation API cost caps critical for solo indie |
| #17 | Audit trail linked to commits | **J43 composes** | Provenance of AI-generated assets bound to render-validated audit trail |

## Decisions dropped / out-of-scope

| Decision | Action | Justification |
|----------|--------|---------------|
| Game design review (balancing, fun-factor, creative direction) | OUT OF SCOPE EBSE | Product-level creative decisions evaluated via playtesting + design heuristics, NOT software engineering evidence synthesizable in EBSE SLR per Kitchenham 2007 scope definition. ai-collab #3 covers structural gate (what human must approve) without prescribing creative content. |
| AI-generated gameplay code + determinism interaction | INHERITED via A4' + ai-collab #4 | A4' determinism invariants enforced by ai-collab #4 verification gates. Parameter adjustment, not new PICOC. |
| AI-generated assets through A8 pipeline | INHERITED via A8 + ai-collab #17 | A8 pipeline invariants agnostic to source (human vs AI). ai-collab #17 provides provenance audit trail. |
| Prompt libraries for pixel-art style consistency | INHERITED ai-collab #14 (prompt/spec discipline) | Operational, not SLR-worthy. |
| Image/audio generation API cost | INHERITED ai-collab #16 (budget caps) | — |
| Agent knowledge of Flame/Flutter/Unity/Godot idioms | INHERITED ai-collab #8 (CLAUDE.md/AGENTS.md) | Parameter adjustment. |
| Agent-induced IAP/ads SDK misconfiguration | INHERITED Batch D/E PICOCs + ai-collab #3 + #4 | — |
| Multi-agent orchestration art+code+design | INHERITED ai-collab #5 (multi-agent topology) | — |
| Agent modifying balance/economy tuning | INHERITED ai-collab #3 (human-only gates) | Design-sensitive region. |

## Open questions Phase 1.5

### Cross-batch coordination

1. **J43 ↔ ai-collab #4 composition** : Phase 2.1 extraction doit tagger chaque study par whether it studies (a) textual gates only, (b) perceptual gates only, (c) composed gates. Studies on composed gate strategies particularly valuable.
2. **J43 ↔ A8 boundary** : J43 operates pre-pipeline at source-asset level ; A8 operates at pipeline level. Joint extraction rule : if study addresses WHAT the asset contains semantically → J43 ; if study addresses HOW it's packed/compressed/delivered → A8.
3. **J43 ↔ B11 pixel-art authoring convention** : J43 palette-lock linting validates conformance to B11 authoring conventions. Cross-reference in extraction.

### Questions Agent C Phase 1.5

4. Verifier : **ISO 42001:2023** AI management system scope for asset generation validation.
5. Verifier : **NIST AI 600-1** output validation guidance for generative AI.
6. Verifier : **OWASP MASVS V3 Integrity** scope asset integrity.
7. Verifier : `ai-collaboration` PICOCs #4, #15, #17 current wording in `verification/picoc/ai-collaboration-picoc.md` for composition correctness.

### Phase 2.1 extraction guidance

8. Phase 2.1 : chercher **perceptual-hash diff** + **golden-image testing for games** empirical studies.
9. Phase 2.1 : chercher **audio fingerprinting for loop-continuity** tools + studies.
10. Phase 2.1 : chercher **AI-generated asset validation** case studies (if any emerging 2024-2026).
11. Phase 2.1 : chercher **pixel-art palette preservation** under AI generation (Stable Diffusion style control, ControlNet palette conditioning).

## Statut Batch J

- **1 nouvelle PICOC retenue** : J43 (AI-generated asset perceptual validation gate)
- **Kappa brut** : 5/5 = 100% ("almost perfect") — strongest convergence of entire Phase 1.3
- **17 ai-collab PICOCs inherited as-is** with parameter adjustments at synthesis
- **4 game-specific candidates inherited/cross-linked** without separate PICOCs
- **Running total** : 36 (Batches A-I) + 1 (Batch J) = **37 PICOCs mobile-game-2d**
- **Plus 17 ai-collab inherited** = **54 PICOCs applicables au total**

**Phase 1.3 COMPLETE. APPROVED pour Phase 1.3 consolidated file + Phase 1.4 Amendments.**
