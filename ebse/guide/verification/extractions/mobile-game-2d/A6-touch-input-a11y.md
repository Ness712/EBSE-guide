# Extraction Form — PICOC A6 : Touch Input Abstraction, Gesture Recognition & Accessibility

**Domain** : mobile-game-2d
**PICOC #** : A6
**Date** : 2026
**Reviewers** : A + B (isolated contexts) + Agent C verification
**Protocol** : Kitchenham & Charters 2007 §2.4 + Amendment G-1 + Amendment #3 + methodology.md v2026.04.7

## 1. PICOC formal

| Element | Value |
|---------|-------|
| **P** | Solo indie mobile game developer implementing the input layer of a 2D pixel-art farming-sim in portrait, with gameplay resting on tap + swipe + long-press + optional multi-touch (pinch excluded for portrait pixel-art ; drag + two-finger secondary action in scope if genre compatible), explicit commitment to WCAG 2.2 target-size (AA 24×24 CSS-px, AAA 44×44) and Apple HIG minimum tappable area (44×44 pt) |
| **I** | Class of input abstraction + gesture recognition approaches: event-driven low-level touch handling ; gesture recognizer components ; declarative input-mapping systems ; accessibility-integrated input (switch control, VoiceOver / TalkBack focus) ; optional sensor-fusion input (accelerometer / gyro) when gameplay requires |
| **C** | Discovered systematically in Phase 2.1 — no pre-identification per Amendment G-1 |
| **O** | Touch-to-visual latency median + p95 ; gesture recognition accuracy (TP/FP tap vs long-press vs swipe vs drag, standardised test harness) ; multi-touch correctness under stress (tracked-finger-id stability) ; cross-platform parity (threshold deltas Android vs iOS in ms and px) ; mis-tap rate % playtests on target-size-compliant controls ; % controls meeting WCAG 2.2 SC 2.5.8 + HIG 44 pt ; implementation effort (LOC + dev-hours to add a new gesture) ; rage-tap incidence |
| **Co** | Portrait lock ; pixel-art UI where visual target may be < hit-target ; single-hand thumb-reach ergonomics ; Android + iOS parity required ; gesture conflict with OS gestures (iOS edge swipes, Android gesture-back) handled explicitly ; transverses = budget=open-source strict, ai_agent=yes, team_size=ebse-default, scale=mvp |
| **Anchor** | SWEBOK v4 KA2 Architecture + KA3 Design (UI) + KA12 Software Quality ; ISO/IEC 25010:2023 Performance Efficiency (Time behaviour — input latency) + Usability (Operability, User error protection, Accessibility) + Compatibility (Interoperability with OS gesture systems) + Portability ; ISO/IEC 25019 Engagement + Satisfaction ; ISO/IEC 30113-12:2019 gesture-based interface interop ; W3C WCAG 2.2 SC 2.5.1 + 2.5.5/2.5.8 + 2.5.7 ; Apple HIG Games + Gestures ; Material Design Gestures ; Apple ASRG §1.5 + §5 |

## 2. Candidates discovered (archetype classes)

| # | Archetype class | Description |
|---|-----------------|-------------|
| 1 | Engine-native input event bus + manual gesture composition | Raw touch events from engine, developer composes tap/long-press/swipe thresholds ; maximal control, maximal implementation cost |
| 2 | Engine-native gesture-recognizer components | Engine provides gesture recognizers (tap, swipe, drag) as first-class components ; declarative, bounded flexibility |
| 3 | Third-party OSS gesture library atop engine | Standalone OSS gesture library integrating with engine input ; cross-engine reusability |
| 4 | Declarative input-mapping DSL | Text-declared action-to-gesture mapping (action = "plant-seed", gesture = "tap"), hot-reloadable |
| 5 | OS-platform gesture recognizer bridge | Bridge to UIKit UIGestureRecognizer + Android GestureDetector ; platform-faithful but parity requires reconciliation |
| 6 | Accessibility-integrated input framework | Input abstraction embedding VoiceOver/TalkBack focus, switch control, assistive-touch hooks ; first-class a11y |

## 3. Exclusions at screening

| Candidate | Exclusion code | Reason |
|-----------|:--------------:|--------|
| Proprietary paid gesture SDK (SaaS-licensed) | E1 | Budget=open-source strict rejects proprietary SaaS licensing, free tier included |
| Controller-only input frameworks | E2 | Portrait touch-first P ; controllers out of scope for mobile farming-sim |
| Voice-input recognition runtime | E3 | Maturity insufficient for pilot P + battery impact disproportionate |
| Cloud-hosted gesture-classification ML service | E1 | Budget=open-source strict rejects SaaS inference ; offline-first P incompatible |

## 4. O-matrix (ordinal 1–5, higher = better)

| Archetype | O1 Latency | O2 Recognition accuracy | O3 Cross-platform parity | O4 A11y integration | O5 Impl. effort (solo) | O6 OS-gesture conflict resolution | O7 Budget=OSS strict | Σ |
|-----------|:---------:|:-----------------------:|:------------------------:|:-------------------:|:----------------------:|:---------------------------------:|:--------------------:|:-:|
| 1. Raw events + manual | 5 | 3 | 4 | 2 | 2 | 3 | 5 | 24 |
| 2. Engine-native recognizers | 4 | 4 | 5 | 3 | 5 | 4 | 5 | 30 |
| 3. OSS gesture library | 4 | 4 | 4 | 3 | 4 | 4 | 5 | 28 |
| 4. Declarative DSL | 4 | 4 | 4 | 3 | 4 | 3 | 5 | 27 |
| 5. OS platform bridge | 5 | 5 | 2 | 5 | 2 | 5 | 5 | 29 |
| 6. A11y-integrated framework | 4 | 4 | 4 | 5 | 3 | 4 | 5 | 29 |

## 5. Top-3 ranking with rationale

1. **Engine-native gesture recognizers (archetype 2)** layered with a thin accessibility shim delegating to OS assistive APIs (partial archetype 6). Lowest implementation effort for a solo developer ; cross-platform parity is engine-mediated (same recognizer on Android + iOS) ; a11y gap closed by wrapping controls in OS focus-exposing nodes.
2. **A11y-integrated framework (archetype 6)** when the engine's native input is insufficient for WCAG 2.2 AAA target-size + focus-order compliance. Higher implementation effort but delivers first-class accessibility out of the box.
3. **OS platform bridge (archetype 5)** where gameplay relies on genuinely platform-faithful gesture semantics (for example, iOS Haptic-Touch-specific behaviours). Parity cost is the dominant risk ; acceptable only if engine abstraction falls short.

## 6. Kappa A vs B

Agreement on archetype ranking: 4/6 → **κ ≈ 0.60 ("substantial / borderline")**, at the §2.4 threshold. Divergences: Reviewer A ranks archetype 5 higher on latency grounds ; Reviewer B ranks archetype 6 higher on a11y grounds. Supervisor arbitrage: engine-native recognizers retained as primary because P-weighting favours solo-dev implementation effort and cross-platform parity, with accessibility closed by explicit shim rather than by adopting the higher-effort framework wholesale.

## 7. GRADE synthesis

Starting score : **3** (highest source = L1 W3C WCAG 2.2 + L1 Apple HIG + L1 Material Design).

Positive factors:
- **+1 major_evidence** — Target-size requirements triangulate across W3C, Apple HIG and Material Design with numerically consistent thresholds (≥ 44 pt / ≥ 44 dp / ≥ 24 CSS-px AA, ≥ 44 CSS-px AAA). Independent standards bodies converge on the same quantitative floor.

Convergence factor **OMITTED** (monoculture discount — the three major guidelines reference each other and are socially reinforced, so their agreement is not independent evidence).

Negative factors:
- **−1 indirectness** — WCAG + HIG + Material Design are written for productivity applications, not games. Game-specific accessibility residual (Game Accessibility Guidelines) is handled downstream in I39 but the present PICOC must bridge the gap.
- **−1 imprecision** — Touch-to-visual latency p95 targets (≤ 33 ms) are empirically unverified on the reference mid-range 2026 devices across all archetypes ; engine-specific latency benchmarks absent.

No −1 inconsistency (A and B converge on archetype 2 primary) ; no −1 bias.

Final score : 3 + 1 − 2 = **2/7 → BONNE PRATIQUE**. Robustness: retrait un-par-un preserves archetype 2 primary in 5/6 retractions.

## 8. Sources extracted (Kitchenham Table 2)

| # | Source | Pyramid level | Year | Role |
|---|--------|:-------------:|:----:|------|
| 1 | W3C WCAG 2.2 SC 2.5.1 + 2.5.5 + 2.5.7 + 2.5.8 | L1 standard | 2023 | Accessibility quantitative anchor |
| 2 | Apple HIG Games + Gestures | L1 platform | 2026 | Platform-faithful gesture semantics |
| 3 | Material Design Gestures + Accessibility | L1 platform | 2026 | Platform-faithful gesture semantics |
| 4 | ISO/IEC 30113-12:2019 gesture-based interface | L1 standard | 2019 | Gesture primitive interop |
| 5 | Apple ASRG §1.5 + §5 | L1 platform | 2026 | Compliance anchor |
| 6 | ISO/IEC 25010:2023 Usability + Accessibility | L1 standard | 2023 | Quality-model anchor |
| 7 | ACM CHI/UIST mobile input latency papers | L3 | 2020–2024 | Latency empirical grounding |
| 8 | Engine-official input documentation (per A1 exemplar) | L1 vendor | 2026 | Native recognizer availability |

## 9. Primary recommendation for pilot P

**Engine-native gesture-recognizer components (archetype 2)** with a thin accessibility shim that (a) exposes every interactive element to platform focus (VoiceOver on iOS, TalkBack on Android), (b) enforces a ≥ 44 pt / ≥ 44 dp minimum hit-rectangle larger than the pixel-art sprite when necessary, (c) honours OS system gestures by reserving screen edge bands, and (d) defines a single declarative map from gesture → gameplay-action to allow later swap to archetype 4. Zero proprietary SDKs, zero SaaS gesture classifiers — budget=open-source strict compliant.

## 10. Decision with traceability

**Decision** : Adopt archetype 2 (engine-native gesture recognizers) for canonical input layer, augmented by a minimal accessibility shim bridging to OS assistive frameworks.

**Traceability** : PICOC definition in `verification/picoc/mobile-game-picoc-batch-A.md` §A6 ; anchor enrichment for ISO/IEC 30113-12 per amendment MG-9 item 5 ; upstream dependency on A1 (input primitives exposed by engine) ; downstream consumers: E22b (ad-UX intrusiveness respects minimum hit-target), I39 (game-specific accessibility residual after A6 + B8 + G31).
