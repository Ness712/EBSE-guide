# Extraction Form — PICOC I39 : Game-Specific Accessibility Accommodations (Residual)

**Domain** : mobile-game-2d
**PICOC #** : I39
**Protocol** : Kitchenham & Charters 2007 §2.4 + Amendment G-1 + MG-1 (GAG grey-lit anchor) + MG-3 + MG-4 (EAA 2025 inflection)

## PICOC formel

| Element | Value |
|---------|-------|
| **P** | Solo indie 2D pixel-art mobile game (Android + iOS, portrait, offline-first) with ads + IAP + leaderboards, GLOBAL distribution (US CVAA + EU post-EAA-2025). Scope : gameplay mechanics, dialogue, visual design (palette, motion), audio cues. Out-of-scope : UI-control a11y (A6), text rendering (B8), RTL / BiDi (G31), ad-unit a11y (E22b) |
| **I** | Tiered set of game-internal a11y features by GAG Basic / Intermediate × 5 modality categories — Visual (colorblind, non-colour-alone encoding) ; Motor (input-timing, auto-aim, one-handed, pause-anywhere) ; Cognitive (reduced-motion, difficulty sliders, skippable events) ; Hearing (captions, speaker ID, directional indicators) ; Haptic (redundant feedback) |
| **C** | Discovered systematically per G-1 |
| **O** | GAG Basic count (/31) ; GAG Intermediate count (/55) ; EAA 2025 Annex I §IV readiness for in-scope e-commerce surfaces ; ASRG §1.5 pass-rate ; a11y-mode activation reach ; ISO 25019 §6 playtest scores ; implementation cost engineer-days (ISO 29110-4-3) ; palette coherence ; retention differential for a11y activators |
| **C** | Solo indie ; **pixel-art constraint** (palette-indexed lookup makes palette-swap trivial ; low-resolution invalidates daltonization filter) ; portrait touch-only ; GLOBAL (CVAA + EAA) ; post-EAA-2025 (active ~10 months) ; offline-first (no cloud TTS) ; budget = open-source strict ; ai_agent = yes ; scale = MVP |
| **Anchor** | Game Accessibility Guidelines (community grey-lit per MG-1) ; CVAA 47 U.S.C. §§303 / 716 + FCC §203 ; EAA 2025 Directive (EU) 2019/882 Annex I §IV (enforcement 2025-06-28) ; Apple ASRG §1.5 + HIG Accessibility ; Android Accessibility Developer Guide ; WCAG 2.2 residual baseline ; ISO 25010:2023 Usability + Inclusivity ; ISO 25019 §6 ; ISO 29110-4-3 |

## Candidates discovered (G-1 — not pre-identified)

| # | Candidate | Modality | Pixel-art fit | Evidence |
|---|-----------|----------|:-------------:|----------|
| 1 | **Palette-swap colorblind modes** (Prot / Deut / Tri via palette-indexed lookup) | Visual | trivial | GAG + Xbox Accessibility |
| 2 | Non-colour-alone encoding (shape / pattern cues) | Visual | favourable | GAG Visual |
| 3 | Auto-aim + input-timing leniency | Motor | partial | GAG Motor |
| 4 | Difficulty sliders on independent axes | Motor + Cognitive | yes | GAG |
| 5 | Pause-anywhere + one-handed portrait | Motor | yes | GAG Motor |
| 6 | **OS-bridged reduced-motion** (iOS + Android via Godot OS signal) | Cognitive | yes | GAG + Apple HIG + Android |
| 7 | On-demand tutorials + skippable timed events | Cognitive | yes | GAG Cognitive |
| 8 | Captions (dialogue + non-speech, speaker ID + directional) | Hearing | yes | GAG Hearing |
| 9 | Redundant haptic for key gameplay events | Haptic | yes | GAG cross-channel |
| 10 | GAG Basic tier complete (all 5 cats) | Aggregate | yes | GAG canonical |
| 11 | GAG Basic + Intermediate full | Aggregate | partial (budget) | GAG canonical |
| 12 | Real-time daltonization filter (LMS) | Visual alt | poor (quantization) | colour-vision lit |
| 13 | Zero-a11y baseline | None | — | — |

**Exclusions (E1-E5)** :

- **E4 (structural mismatch)** : Screen-reader dialogue passthrough at gameplay parity — offline-first precludes cloud TTS ; canvas pixel-art has no semantic text surface
- **E2 (surface misfit)** : Real-time daltonization filter — pixel-art quantization invalidates filter fidelity ; palette-swap is the structurally correct substitute
- **E2 (platform misfit)** : Console controller remapping — portrait touch-only pilot P
- **E3 (budget gate)** : AAA subtitle authoring pipelines — disproportionate ; GAG Basic patterns OSS-authorable
- **E3 (budget gate)** : Paid accessibility-audit SaaS — violates budget=open-source strict

## O-matrix (ordinal 1-5, higher = better)

| Candidate | O1 GAG Basic | O2 GAG Intermediate | O3 EAA / ASRG readiness | O4 Implementation cost | O5 Pixel-art palette coherence | Σ |
|-----------|:-:|:-:|:-:|:-:|:-:|:-:|
| **Pixel-art-aware pack : palette-swap + GAG Basic 5/5 + OS-bridged reduced-motion** | 5 | 4 | 4 | 4 | 5 | 22 |
| GAG Basic only (all 5 modality cats, no palette-swap) | 5 | 2 | 3 | 5 | 5 | 20 |
| GAG Basic + Intermediate full | 5 | 5 | 5 | 2 | 4 | 21 |
| GAG Visual + Hearing only (partial Basic) | 3 | 1 | 2 | 5 | 5 | 16 |
| Standard real-time daltonization filter only | 4 | 3 | 4 | 3 | 2 | 16 |
| Zero-a11y baseline | 0 | 0 | 0 | 5 | 5 | 10 |

**Tie-break (Pixel-art-aware pack vs Basic + Intermediate full)** : Solo-dev budget is dispositive. Full Basic + Intermediate ≈ 30-45 engineer-days (Xbox Accessibility Team order-of-magnitude). Pixel-art-aware pack ≈ 10-15 engineer-days because palette-indexed art reduces palette-swap to lookup indirection. Intermediate features layer post-MVP without re-architecture. GAG counts : Basic = 31, Intermediate = 55, Advanced = 26.

## Top-3 ranking

1. **Pixel-art-aware pack : palette-swap colorblind (Prot / Deut / Tri) + GAG Basic all 5 categories + OS-bridged reduced-motion** — A-tier, covers ~26-28 / 31 Basic + ~32-38 / 55 Intermediate at ~10-15 engineer-days
2. **GAG Basic minimum (all 5 categories, no palette-swap)** — A-/B+, legal-minimum fallback
3. **GAG Basic + Intermediate full** — B+, feasibility-blocked at solo-dev budget

## Kappa A vs B

Tier agreement 6/6 = 100%. Kappa brut ≈ 1.00 ("almost perfect"). Both reviewers surface identical pixel-art-aware pack at position 1 with identical composition ; identical legal-minimum fallback at position 2. No divergence on primary recommendation.

## GRADE synthesis

**Starting score** : 2 (L2 GAG grey-lit per MG-1 + L1 EAA / CVAA / ASRG / HIG / ISO).

**Positive** :

- **+1 major evidence** : Palette-swap has structural fit to palette-indexed 2D art — lookup indirection avoids the quantization pitfall of real-time daltonization
- **+1 regulatory anchor** : EAA 2025 (active ~10 months at extraction) makes a11y-readiness load-bearing for EU in-scope e-commerce surfaces ; €100k / 4%-revenue penalty exposure non-trivial

**Negative** :

- **-1 indirectness** : GAG is community grey-lit (MG-1 flag) rather than peer-reviewed standard
- **-1 imprecision** : Reach-impact outcome at pilot-P scale extrapolated from Xbox / Microsoft benchmarks

**Scope clarification** : CVAA §203 applies to Advanced Communications Services only ; single-player pilot P has no ACS and falls outside CVAA. EAA 2025 distinguishes content (gameplay, exempt) from service (e-commerce, in-scope) — storefront, IAP flow, and website owned upstream by A6 / B8 / G31 / E22b for WCAG 2.1 AA.

**Score final** : 2 + 2 − 2 = **2/7 → BONNE PRATIQUE**.

## Sources extracted (Kitchenham Table 2)

| # | Source | Level | Year | Role |
|---|--------|:-----:|:----:|------|
| 1 | Game Accessibility Guidelines — Basic / Intermediate / Advanced | L5 (grey-lit per MG-1) | 2024-2026 | Primary anchor |
| 2 | EAA 2025 — Directive (EU) 2019/882, Annex I §IV | L1 | 2019 + 2025 | Regulatory anchor |
| 3 | CVAA — 47 U.S.C. §§303 / 716 + FCC §203 | L1 | 2010+ | Regulatory anchor (ACS-scoped) |
| 4 | Apple ASRG §1.5 Accessibility | L1 | 2024-2026 | Store compliance anchor |
| 5 | Apple HIG Accessibility | L1 | 2024-2026 | Platform design anchor |
| 6 | Android Accessibility Developer Guide | L1 | 2024-2026 | Platform anchor |
| 7 | ISO/IEC 25010:2023 — Usability + Inclusivity | L1 | 2023 | Quality-attribute anchor |
| 8 | ISO/IEC 25019:2023 §6 accessibility-in-use | L1 | 2023 | Quality-in-use anchor |
| 9 | ISO/IEC 29110-4-3 VSE profile | L1 | 2018 | Solo-dev budget anchor |
| 10 | Xbox Accessibility Team + Microsoft inclusive design | L3 | 2018-2025 | Reach / benchmark evidence |
| 11 | Can I Play That? + IGDA Game Accessibility SIG | L5 (grey-lit MG-1) | 2018-2025 | Evidence-of-use |
| 12 | Academic game-accessibility empirical studies | L2-L3 | 2015-2024 | Outcome evidence |
| 13 | Pixel-art colorblind palette design | L5 | 2020-2025 | Structural-fit evidence |

## Decision

**Primary recommendation for pilot P** : **Pixel-art-aware pack** — palette-swap colorblind modes (Prot / Deut / Tri via palette-indexed lookup, zero shader cost) + GAG Basic across all 5 modality categories + OS-bridged reduced-motion respecting iOS and Android system settings via Godot OS signals. Expected coverage ~26-28 / 31 GAG Basic + ~32-38 / 55 Intermediate at ~10-15 engineer-days. All tooling OSS.

Pixel-art wins : palette-swap = lookup indirection ; reduced-motion = dampened screen shake + disabled parallax + reduced particle density ; chunky silhouettes aid non-colour-alone encoding.

**Runner-up** : GAG Basic minimum across 5 categories without palette-swap — fallback if palette-lookup indirection fails to integrate with Godot renderer.

**Aspirational (post-MVP)** : incremental GAG Intermediate features per release cycle.

**Rejected** :

- Zero-a11y baseline — violates ISO 25010 Inclusivity + ASRG §1.5 + EAA storefront obligations
- Real-time daltonization filter — pixel-art quantization invalidates filter fidelity
- Full GAG Basic + Intermediate upfront — solo-dev budget prohibitive ; phase post-MVP
- Paid accessibility SaaS — violates budget=open-source strict

**Out-of-scope** : CVAA §203 (no ACS) ; EAA gameplay (content exempt ; in-scope surfaces owned upstream by A6 / B8 / G31 / E22b).

**Traceability** : `verification/synthesis/mobile-game-phase2-synthesis.md` row I39 ; MG-1 grey-lit anchor ; MG-4 EAA inflection.
