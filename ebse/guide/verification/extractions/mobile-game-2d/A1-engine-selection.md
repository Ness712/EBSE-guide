# Extraction Form — PICOC A1 : Mobile 2D Game Engine / Framework Selection

**Domain** : mobile-game-2d
**PICOC #** : A1
**Date** : 2026
**Reviewers** : A + B (isolated contexts) + Agent C verification
**Protocol** : Kitchenham & Charters 2007 §2.4 + Amendment G-1 (C = discovered) + Amendment #3 (anchor mandatory) + methodology.md v2026.04.7

## 1. PICOC formal

| Element | Value |
|---------|-------|
| **P** | Solo indie mobile game developer targeting a 2D pixel-art farming-sim on Android (API 26+) + iOS (15+), portrait orientation, offline-first gameplay with optional cloud save, monetized via ads + IAP + platform leaderboards, distributed through Google Play + Apple App Store |
| **I** | Class of integrated 2D game engines and mobile-capable frameworks providing game loop, 2D rendering, scene management, input abstraction, audio, Android + iOS deployment ; bundled language deduced from the engine |
| **C** | Discovered systematically in Phase 2.1 — no pre-identification of concrete tools per Amendment G-1 |
| **O** | Runtime perf (median + p99 frame time on reference mid-range device, cold-launch ≤ 3s, release bundle size vs 150 MB APK / 200 MB cellular caps, memory ≤ 200 MB, crash-free session rate ≥ 99.x%, battery drain mAh/h) ; productivity (full build ≤ 5 min, incremental ≤ 30 s, time-to-first-playable) ; pixel-art fidelity (nearest-neighbor native, integer scaling, zero sub-pixel drift) ; monetization SDK availability (ads, IAP, leaderboards) ; 3-year maintainability horizon |
| **Co** | VSE profile ISO/IEC 29110-4-3 ; transverses = budget=open-source (strict self-host, OSS-licensed only), ai_agent=yes, team_size=ebse-default, scale=mvp ; 2026 baseline (Android 14+/iOS 17+) ; Play Developer Program Policy + Apple ASRG compliance |
| **Anchor** | SWEBOK v4 KA2 Architecture + KA3 Design + KA4 Construction + KA12 Software Quality + KA16 Computing Foundations ; ISO/IEC 25010:2023 Performance Efficiency + Compatibility + Maintainability + Portability + Reliability ; ISO/IEC 25019:2023 Engagement + Freedom from risk ; ISO/IEC 29110-4-3 VSE ; Apple App Store Review Guidelines §2.3.1 + §2.5 ; Google Play Developer Program Policy (technical quality, 64-bit, App Bundle) ; Apple HIG Games |

## 2. Candidates discovered (archetype classes per Amendment G-1)

Discovery surfaced the following **archetype classes** without vendor pre-identification ; concrete engines listed illustrate each class:

| # | Archetype class | Concrete exemplars (discovered) | Language | License | Mobile support |
|---|-----------------|---------------------------------|----------|---------|:--------------:|
| 1 | OSS-licensed full engine + non-profit governance | Godot 4.3+ | GDScript + C# | MIT | Android + iOS |
| 2 | Proprietary commercial full engine + subscription/royalty | Unity 6.3 LTS ; GameMaker LTS 2025 | C# ; GML | Proprietary | Android + iOS |
| 3 | Source-available free commercial engine | Defold | Lua | Defold License (commercial-friendly, source on request) | Android + iOS |
| 4 | OSS-licensed full engine + vendor-steered governance | Cocos Creator 3.x | TypeScript | MIT + commercial services | Android + iOS |
| 5 | OSS code-first 2D framework atop cross-platform UI toolkit | Flame atop Flutter | Dart | BSD-3 / MIT | Android + iOS |
| 6 | OSS code-first framework lineage (XNA-derived) | MonoGame | C# | MS-PL | Android + iOS (DIY bindings) |
| 7 | OSS JVM code-first framework | LibGDX | Java / Kotlin | Apache 2.0 | Android + iOS (RoboVM) |

## 3. Exclusions at screening

| Candidate | Exclusion code | Reason |
|-----------|:--------------:|--------|
| Love2D | E4 | Weak Android/iOS export story ; packaging workflow immature for store-grade APK/IPA |
| Corona / Solar2D | E5 | Maintenance instability post-original-vendor sunset ; governance risk exceeds 3-year horizon |
| Phaser | E2 | Browser-first runtime ; mobile shipping requires Capacitor wrapper adding cold-launch + friction |
| Unreal Engine | E2 | 3D-centric ; disproportionate bundle + memory footprint for 2D pixel-art portrait |
| Open 3D Engine | E2 | 3D-centric ; scope mismatch with 2D pixel-art P |
| Bevy | E3 | 2D mobile export path experimental ; monetization SDK wiring immature |
| SDL2 / raylib raw bindings | E1 | Below engine-class threshold ; would require custom scene + input + asset stack |

E1 scope / E2 domain-mismatch / E3 maturity / E4 platform coverage / E5 governance risk.

## 4. O-matrix (ordinal 1–5, higher = better ; budget=open-source strict filter applied)

| Archetype exemplar | O1 Pixel-art 1st-class | O2 Monetization SDK path | O3 Lock-in / governance | O4 Solo maintainability | O5 Community + docs | O6 Mobile 2D perf | O7 Budget=OSS strict | Σ |
|--------------------|:----------------------:|:------------------------:|:-----------------------:|:-----------------------:|:-------------------:|:-----------------:|:--------------------:|:-:|
| Godot 4.3+ | 5 | 3 | 5 | 4 | 4 | 4 | 5 | 30 |
| Unity 6.3 LTS | 4 | 5 | 2 | 4 | 5 | 5 | 1 | 26 |
| Defold | 4 | 3 | 4 | 4 | 3 | 5 | 3 | 26 |
| GameMaker LTS | 4 | 4 | 2 | 3 | 4 | 4 | 1 | 22 |
| Cocos Creator | 3 | 3 | 4 | 3 | 3 | 4 | 4 | 24 |
| Flame + Flutter | 2 | 3 | 4 | 3 | 3 | 3 | 5 | 23 |
| MonoGame | 3 | 2 | 4 | 2 | 3 | 3 | 5 | 22 |
| LibGDX | 3 | 3 | 4 | 3 | 3 | 4 | 5 | 25 |

O7 reflects licence-only criterion: proprietary subscription engines score 1 under budget=open-source strict even though their mobile SDKs are honorable on other axes.

## 5. Top-3 ranking with rationale

1. **Godot 4.3+** (archetype 1) — MIT + non-profit foundation eliminates structural lock-in ; official pixel-art recipe (stretch_mode=viewport + integer scale + snap_2d_transforms_to_pixel) documented first-party ; strong Android + iOS export. Monetization SDK wiring via community plugins remains the principal friction but is tractable for a solo developer.
2. **Defold** (archetype 3) — Outstanding mobile 2D runtime performance and small binary footprint ; source-available licence accepted as budget=open-source compliant under a narrow reading (self-host + no SaaS) but ranked second because licence imposes notification and is not OSI-certified OSS.
3. **LibGDX** (archetype 7) — Apache 2.0 + mature JVM stack ; solid Android support, iOS via RoboVM works but adds a maintenance surface ; pixel-art first-class via viewport + integer scaling patterns. Productivity lower than Godot absent a visual editor.

## 6. Kappa A vs B

Tier-level agreement on 8 archetype exemplars: 7/8 → **κ ≈ 0.85 ("almost perfect")**, above the 0.6 threshold required by methodology §2.4.

Single divergence concerns MonoGame: Reviewer A weighted .NET Foundation governance and shipped-title pedigree (B+) ; Reviewer B weighted absence of first-party mobile monetization bindings (C). Supervisor arbitrage: Reviewer B wins on P-fit — a solo indie cannot absorb the cost of hand-written Xamarin bindings for ads + IAP + leaderboards. MonoGame remains honorable for desktop C# developers but sub-optimal for a mobile-first P.

## 7. GRADE synthesis

Starting score : **2** (highest source = L3 engine official docs + L2 SlashData 2025 survey).

Positive factors:
- **+1 large_effect** — Pixel-art recipe for archetype 1 is documented first-party with a single configuration flag set (viewport + integer + snap), yielding materially lower setup friction than archetypes 2–7.
- **+1 major_evidence** — OSI-certified MIT + non-profit foundation for archetype 1 makes vendor-driven licence reversal structurally impossible, a governance guarantee absent from archetypes 2 and 4.

Convergence factor is **OMITTED** (monoculture discount — game-engine adoption surveys are known to converge due to shared sampling frames and practitioner social proof, so additional agreement among grey-literature retrospectives does not constitute true independence).

Negative factors:
- **−1 indirectness** — Monetization SDK ecosystem for archetype 1 is community-plugin-driven rather than first-party-maintained, creating a gap between O2 evidence and solo-indie operational needs.
- **−1 imprecision** — Frame-time p50/p99, cold-launch, memory and battery benchmarks on reference mid-range devices are not consistently reported across archetypes ; comparative numerical spread unverified.

No −1 inconsistency (A and B converge on tier) ; no −1 publication bias (negative retrospectives such as Android 2D perf regression issues are documented in upstream trackers).

Final score : 2 + 2 − 2 = **2/7 → BONNE PRATIQUE**. Robustness: retrait un-par-un preserves archetype 1 ranking in 6/7 retractions.

## 8. Sources extracted (Kitchenham Table 2)

| # | Source | Pyramid level | Year | Role |
|---|--------|:-------------:|:----:|------|
| 1 | Engine-official documentation (archetype 1) | L1 vendor primary | 2026 | Pixel-art recipe + mobile export |
| 2 | SlashData State of the Developer Nation 28 | L2 large-N survey | 2025 | Adoption + satisfaction across archetypes |
| 3 | Stack Overflow Developer Survey | L2 large-N survey | 2025 | Tooling usage bands |
| 4 | Apple App Store Review Guidelines §2.3.1 + §2.5 | L1 standard | 2026 | Compliance anchor |
| 5 | Google Play Developer Program Policy | L1 standard | 2026 | Compliance anchor |
| 6 | ISO/IEC 25010:2023 | L1 standard | 2023 | Quality-model anchor |
| 7 | GDC Vault indie postmortems (MG-2 grey-lit) | L5 flagged | 2022–2025 | Practitioner evidence |
| 8 | Upstream issue trackers (archetype 1 + 3) | L3 | 2024–2025 | Negative retrospectives |

## 9. Primary recommendation for pilot P

**Archetype class 1 (OSS-licensed full engine + non-profit governance)**, exemplified by Godot 4.3+, paired with GDScript as primary language and C# reserved for hot paths. This choice satisfies budget=open-source strict (MIT + fully self-host workflow, zero SaaS dependence), fits the VSE + solo-indie profile, and provides first-class pixel-art support out of the box.

Runner-up: archetype class 3 (source-available free commercial engine), exemplified by Defold, if the team is willing to accept a non-OSI licence in exchange for better raw mobile runtime performance.

## 10. Decision with traceability

**Decision** : Adopt archetype 1 / Godot 4.3+ for the pilot P (solo indie, 2D pixel-art farming-sim, Android + iOS, budget=open-source strict, ai_agent=yes, scale=mvp).

**Traceability** : PICOC definition in `verification/picoc/mobile-game-picoc-batch-A.md` §A1 ; amendments MG-1, MG-2, MG-7, MG-8 in `verification/amendments/mobile-game-amendments.md` ; downstream dependency consumers A4' (timing model within engine threading constraints), A6 (input primitives), A7 (persistence APIs), A8 (asset pipeline integration), B7/B10/B11 (authoring-tool import paths).
