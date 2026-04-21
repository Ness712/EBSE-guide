# Extraction Form — PICOC J43 : Perceptual / Rendered Validation Gate for AI-Generated Game Assets

**Domain** : mobile-game-2d
**PICOC #** : J43
**Protocol** : Kitchenham & Charters 2007 §2.4 + Amendment G-1 + MG-6 + MG-9 (J43 C-class archetype clarification)

## PICOC formel

| Element | Value |
|---------|-------|
| **P** | Solo indie 2D pixel-art mobile game (Android + iOS, portrait, offline-first, ads + IAP + leaderboards) developed with AI coding agents (Claude Code, Cursor, Copilot, Aider, equivalent) where the agent produces / modifies / imports / wires sprite sheets, tile atlases, animations, particle definitions, shader snippets, audio clips, or manifest metadata (pivots, frame timings, UVs, loop points, palette indices) |
| **I** | **Pre-merge composed perceptual verification gate**, all OSS : (i) palette-lock + alpha-policy linting ; (ii) atlas-UV + pivot-offset JSON schema validation (sub-pixel drift) ; (iii) pHash golden-image rendered-frame diff per device-class ; (iv) audio fingerprint + loop-continuity (sample rate, loop points, click / pop) ; (v) threshold-triggered human visual / audio spot-check ; (vi) provenance manifest binding license + generation params + model card to commit |
| **C** | Archetype classes per MG-9 G-1 clarification : (C1) text-level CI gates only (ai-collab #4 alone) ; (C2) human-only manual QA ; (C3) post-merge / post-release detection via user bug reports or store-review signals ; (C4) no AI-generated assets |
| **O** | (a) defective-asset rate to main per 100 AI-authored PRs ; (b) rendered-output regression rate (pivot drift, palette corruption, atlas bleeding, audio click / pop, frame-order bugs) ; (c) mean review-cycle time ; (d) defect-escape ratio perceptual vs text-level ; (e) rework rate ; (f) store-review graphical-glitch complaint rate ; (g) asset-rollback frequency ; (h) solo-dev time-to-detect ; (i) auditability (composes ai-collab #17) ; (j) license provenance coverage |
| **C** | Solo indie, no QA / art director ; **pixel-art sensitivity critical** (1-pixel errors visible ; palette-indexed assets sensitive to quantization) ; portrait-mobile multi-device ; offline-first (no post-ship fixups) ; monetised surfaces (defects impair conversion + retention) ; **automation load-bearing** ; budget = open-source strict ; ai_agent = yes ; scale = MVP |
| **Anchor** | ISO/IEC 25010:2023 — Functional Correctness, Reliability, Maintainability, Performance ; ISO/IEC 25019:2023 data quality in use ; ISO/IEC 42001:2023 AI management system ; NIST AI 600-1 Generative AI risk profile ; OWASP MASVS V3 Integrity ; ai-collab PICOCs extended : #4 (render-time sibling), #15 (perceptual reviewer role), #17 (provenance binding) |

## Candidates discovered (G-1 — not pre-identified)

| # | Candidate component | Sub-class | OSS | Evidence |
|---|---------------------|-----------|:---:|----------|
| 1 | **pHash / golden-image diff per device-class** | Perceptual auto | ImageHash (MIT), pHash (GPL), OpenCV SSIM | widely published |
| 2 | **Audio fingerprint + loop-continuity** | Perceptual auto | librosa (ISC), Chromaprint (LGPL), ffmpeg | OSS ecosystem |
| 3 | **Palette-lock + alpha-policy linting** | Schema / lint | custom Python / GDScript | pixel-art community |
| 4 | **Atlas-UV + pivot-offset schema validation** | Schema | JSON Schema + checker | pipeline patterns |
| 5 | **Threshold-triggered human spot-check** | Human-in-loop | native PR UI | ai-collab #15 |
| 6 | **Provenance manifest** (license + params + model card) | Audit trail | commit-attached YAML | ISO 42001 + NIST AI 600-1 + #17 |
| 7 | **Composed gate : (1)+(2)+(3)+(4)+(5)+(6)** | Composite | all OSS | this study |
| 8 | Fully-automated gate (drop human threshold) | Alternative | yes | — |
| 9 | Text-only CI gates (C1 — ai-collab #4 alone) | Baseline | yes | ai-collab #4 |
| 10 | Human-only manual QA (C2) | Baseline | yes | — |
| 11 | Post-merge / post-release detection (C3) | Baseline | yes | store signal |
| 12 | No AI-generated assets (C4) | Baseline | yes | human-authored |

**Exclusions (E1-E5)** :

- **E4 (surface misfit + compute)** : CLIP-based semantic similarity — compute prohibitive in CI ; opaque failure modes at pixel-art sensitivity
- **E3 (budget gate)** : Commercial DAM enterprise platforms — violates budget=open-source strict
- **E2 (failure-mode mismatch)** : VMAF / PSNR-HVS — codec metrics, wrong surface for pixel-art sprites
- **E3 (budget gate)** : Paid visual-regression SaaS (Percy / Chromatic enterprise) — violates budget=open-source strict ; OSS pHash covers the surface

## O-matrix (ordinal 1-5, higher = better)

| Candidate architecture | O1 Defective to main | O2 Regression escape | O3 Review-cycle time | O4 Solo-dev time-to-detect | O5 Auditability | Σ |
|------------------------|:-:|:-:|:-:|:-:|:-:|:-:|
| **Composed gate : palette-lock + atlas-UV + pHash + audio FP + human threshold + provenance** | 5 | 5 | 4 | 5 | 5 | 24 |
| Fully-automated (no human threshold) | 3 | 3 | 5 | 3 | 4 | 18 |
| Text-only CI gates (C1) | 1 | 1 | 5 | 1 | 3 | 11 |
| Human-only manual (C2) | 3 | 3 | 1 | 2 | 2 | 11 |
| Post-merge detection (C3) | 1 | 1 | 5 | 1 | 2 | 10 |
| No AI-assets (C4) | 5 | 5 | n/a | n/a | 5 | n/a |

**Tie-break (Composed vs Fully-automated)** : Threshold-triggered human spot-check is load-bearing for pixel-art 1-pixel-visible sensitivity. Fully-automated gates with pHash-distance thresholds alone risk missing aesthetic regressions below the numerical threshold that still degrade perceived quality (off-by-one pivot, palette-index swap within perceptually-close hues, silhouette-readability degradation). Threshold-trigger preserves solo-dev capacity by invoking human review only on flagged diffs.

## Top-3 ranking

1. **Composed gate : palette-lock + atlas-UV schema + pHash + audio fingerprint + threshold-triggered human spot-check + provenance manifest** — A-tier, all OSS, architecturally complete via ai-collab #4 / #15 / #17 composition
2. **Fully-automated composed gate (drop human threshold)** — B+, maximum throughput but aesthetic-miss risk
3. **Human-only manual QA (C2)** — C+, preserves aesthetic judgement but fails sustainability and auditability

## Kappa A vs B

Tier agreement 5/5 = 100%. Kappa brut ≈ 1.00 ("almost perfect"). Both reviewers surface the identical 5-component composed gate at position 1 with the same composition and the same threshold-trigger rationale. No divergence on primary recommendation.

## GRADE synthesis

**Starting score** : 1 (pyramid L4-L5 — AI-generated asset validation is emerging practice 2024-2026 with sparse peer-reviewed case-study evidence at indie scale ; strongest anchors are L1 ISO/IEC 42001 + NIST AI 600-1 + OWASP MASVS + inherited ai-collaboration PICOCs).

**Positive factors** :

- **+1 major evidence** : Composition with ai-collaboration #4 (deterministic verification gates) + #15 (writer / reviewer gates) + #17 (audit trail) provides structural completeness — J43 is the game-asset-specific instantiation of the generic ai-collab gate triad, not a novel invention. Each primitive (pHash, audio fingerprint, JSON Schema, palette lint) is independently validated OSS ; load-bearing claim is the composition
- **+1 tooling fit** : Every gate component has mature OSS implementations (ImageHash, librosa / Chromaprint, JSON Schema, native PR review UI) compatible with budget=open-source strict ; no paid SaaS dependency

**Negative factors** :

- **-2 indirectness** : No empirical primary study on "perceptual gate for AI-generated pixel-art game assets at solo-indie scale". Most golden-image regression literature is web-UI (Percy, Chromatic, BackstopJS) or AAA game QA ; ISO/IEC 42001 + NIST AI 600-1 are governance frameworks rather than empirically validated game-asset gates
- **-1 publication bias** : Emerging practice 2024-2026 skews toward vendor promotion and positive case studies ; balanced empirical base sparse
- **-2 imprecision** : Threshold tuning (pHash distance, audio similarity, alpha-channel delta tolerance) not calibrated from a pilot-P comparable baseline ; defective-asset-rate-to-main and mean review-cycle time not quantified from solo-indie evidence

**Score final** : 1 + 2 − 5 = **−2 floored at 1/7 → INFORMATIONNEL**.

## Sources extracted (Kitchenham Table 2)

| # | Source | Level | Year | Role |
|---|--------|:-----:|:----:|------|
| 1 | ISO/IEC 42001:2023 — AI management system | L1 | 2023 | AI audit-trail anchor |
| 2 | NIST AI 600-1 — Generative AI risk profile | L1 | 2024 | Output-validation anchor |
| 3 | OWASP MASVS V3 — Integrity | L1 | 2024 | Client-side asset-integrity anchor |
| 4 | `ai-collaboration` PICOCs #4 + #15 + #17 (inherited) | internal | 2026 | Composition anchor |
| 5 | ISO/IEC 25010:2023 — Functional Correctness + Reliability + Maintainability + Performance | L1 | 2023 | Quality-attribute anchor |
| 6 | ISO/IEC 25019:2023 — data quality in use | L1 | 2023 | Asset-manifest anchor |
| 7 | pHash / perceptual-hash OSS (ImageHash, pHash, OpenCV SSIM) + academic literature | L2-L3 | 2010+ | Perceptual primitive |
| 8 | librosa / Chromaprint / ffmpeg audio fingerprinting | L1 (OSS primary) | varied | Audio primitive |
| 9 | Percy / Chromatic / BackstopJS golden-image regression | L3 | varied | Methodological analog (web) |
| 10 | Pixel-art palette-indexed community practice | L5 (grey-lit MG-2) | varied | Palette-lock rationale |
| 11 | Emerging AI-generated asset validation case studies | L4-L5 | 2024-2026 | Emerging-practice signal |
| 12 | JSON Schema specification | L1 | 2020 | Schema validation anchor |

## Decision

**Primary recommendation for pilot P** : **Composed gate, all OSS, self-hosted**. Six components wired as a single pre-merge gate :

- **(i) Palette-lock + alpha-policy linting** : no colours outside declared palette-index set ; no alpha values outside declared policy per asset class
- **(ii) Atlas-UV + pivot-offset JSON schema validation** : AI-authored atlas metadata preserves pivot + UV invariants ; integer-only UV constraint for pixel-art (sub-pixel drift detection)
- **(iii) pHash golden-image rendered-frame diff** : perceptual-hash distance threshold on rendered sprite + animation-frame diff vs previous main, parametrised per target device-class resolution
- **(iv) Audio fingerprint + loop-continuity** : sample rate + loop points + click / pop detection via librosa + Chromaprint + ffmpeg filters
- **(v) Threshold-triggered human spot-check** : when any of (i)-(iv) exceed thresholds, human review required before merge (composes ai-collab #15)
- **(vi) Provenance manifest** : AI-asset license + generation parameters + model card attached to commit via ai-collab #17, ISO 42001 + NIST AI 600-1 aligned

**Runner-up** : Fully-automated composed gate (drop (v)) — acceptable if solo-dev review capacity saturates and threshold calibration demonstrates acceptable aesthetic-regression catch rate.

**Rejected** :

- **Text-only CI gates (C1)** — ai-collab #4 alone fails the perceptual surface
- **Human-only manual (C2)** — does not scale solo-dev ; fatigue drift and non-auditability
- **Post-merge detection (C3)** — store-review graphical-glitch complaints as primary detection = unacceptable UX + brand risk
- **No-AI-assets (C4)** — disallows AI acceleration ; out of pilot-P scope given ai_agent = yes

**Threshold calibration during adoption** : pHash distance, audio-fingerprint similarity, and alpha-channel delta tolerance tuned on first cohort of AI-authored PRs. Provenance manifest coverage tracked per PR.

**Traceability** : `verification/synthesis/mobile-game-phase2-synthesis.md` row J43 ; `mobile-game-picoc-batch-J.md` PICOC #J43 ; MG-9 amendment ; ai-collab #4 / #15 / #17 composition inheritance.
