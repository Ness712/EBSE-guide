# Extraction Form — PICOC B9 : Audio Runtime + Mixer Subsystem

**Domain** : mobile-game-2d
**PICOC #** : B9
**Year** : 2026
**Reviewers** : A + B (isolated) + Agent C verification
**Protocol** : Kitchenham & Charters 2007 §2.4 (Data Extraction) + Amendment G-1 + #3 + MG-2 + MG-6

## 1. PICOC formel

| Element | Value |
|---------|-------|
| **P** (Population) | Solo indie dev + 2D pixel-art mobile game + Android + iOS + portrait + offline-first + music loops (cozy/farming stem layering) + UI/SFX (tens-to-low-hundreds cues) + ambience beds + gameplay-reactive mixer behaviors (music ducking on dialogue, crossfade on area transition, time-of-day layering) + mobile audio-session conformance (call interruption, Bluetooth connect/disconnect, silent-switch iOS, OS-level ducking, backgrounding). |
| **I** (Intervention) | Audio runtime + mixer subsystem class selection. 4 archetype sub-classes (G-1) : (a) engine-built-in audio subsystem as-is ; (b) third-party commercial audio middleware with mobile runtime + authoring tool ; (c) open-source audio library integrated atop engine ; (d) low-level platform-audio hand-wrap (OpenSL ES / AAudio Android, AVAudioEngine / AudioToolbox iOS). |
| **C** (Comparator) | Discovered via systematic Phase 2.1 search across engine docs, GDC Vault audio track, GitHub topic `audio-middleware`, AES conference proceedings, Apple / Google platform audio guidelines, indie postmortems. No pre-identification per G-1. |
| **O** (Outcome) | Cold init latency (ms) ; mixer voice capacity under CPU budget ; dropout rate under load ; trigger-to-first-sample latency + jitter ; binary size delta ; audio-graph memory footprint ; licensing cost ; authoring ramp hours ; iteration latency ; ducking/crossfade smoothness ; interruption-handling pass/fail matrix ; iOS silent-switch + background-policy conformance ; ad-SDK video-ad audio handover correctness. |
| **Context** | Solo indie budget=open-source strict (self-host OSS only) ; offline-first ; ads + IAP (rewarded-video audio handover critical) ; Apple ASRG audio-session ; Google Play audio-focus ; ≤1 composer/sound designer ; ai_agent=yes ; scale=mvp. |
| **Anchor** | SWEBOK v4 KA3 Design + KA4 Construction + KA14 Professional Practice ; ISO/IEC 25010:2023 Performance Efficiency (time behaviour, resource utilization) + Reliability (fault tolerance interruption, recoverability from audio-focus loss) + Compatibility (co-existence ad SDKs + OS audio services) ; Apple App Store Review Guidelines audio-session rules ; Google Play Developer Program Policy audio-focus ; Apple HIG Playing Audio. |

## 2. Candidates discovered (G-1 archetype classes)

| # | Candidate | Archetype class | License | Mobile support | Evidence tier |
|---|-----------|-----------------|---------|:--------------:|:-------------:|
| 1 | Godot built-in AudioStreamPlayer + AudioBus + AudioEffect | (a) engine-built-in | MIT | yes | L1 engine docs |
| 2 | FMOD Studio + FMOD Core | (b) commercial middleware | Proprietary, indie free <200k USD | yes | L1 vendor docs |
| 3 | Wwise by Audiokinetic | (b) commercial middleware | Proprietary tiered | yes | L1 vendor docs |
| 4 | miniaudio single-header C library | (c) OSS library | MIT-0 / public domain | yes | L1 repo + docs |
| 5 | SoLoud | (c) OSS library | zlib/libpng | yes | L1 repo + docs |
| 6 | OpenAL Soft | (c) OSS library | LGPL | yes | L1 project docs |
| 7 | Platform hand-wrap (AAudio + AVAudioEngine) | (d) platform-audio | Platform SDK | yes (2x eng cost) | L1 Android NDK + Apple docs |
| 8 | Criware ADX2 | (b) commercial middleware | Proprietary | yes | L1 vendor (JP) |

## 3. Exclusions E1-E5

| Candidate | Criterion | Reason |
|-----------|-----------|--------|
| Criware ADX2 | E5 commercial-tier incompatible with budget=open-source strict | Proprietary, paid licensing, opaque pricing for Western indie — violates budget gate. |
| FMOD Studio | E5 proprietary runtime | Even under indie-free revenue cap, runtime is closed-source binary — violates open-source strict. Retained only for historical comparator context. |
| Wwise | E5 proprietary runtime + pricing | Closed-source runtime; tiered licensing — violates open-source strict. |
| libsndfile-only | E1 scope mismatch | Codec library, not mixer subsystem. |
| Superpowered SDK | E2 obsolescence | Repo signals dormancy; mobile audio SDKs must be actively maintained. |

**Effective candidate set under budget=open-source strict**: Godot built-in (a), miniaudio (c), SoLoud (c), OpenAL Soft (c), platform hand-wrap (d).

## 4. O-matrix (ordinal 1-5, higher=better ; O1 is hard constraint gate)

| Candidate | O1 Budget=OSS compliance (gate) | O2 Mixer expressiveness | O3 Platform audio-session correctness | O4 Authoring ramp (solo) | O5 Ad-SDK audio-focus handover | Sigma |
|-----------|:-------------------------------:|:-----------------------:|:-------------------------------------:|:-------------------------:|:------------------------------:|:-----:|
| Godot built-in | 5 PASS | 3 | 4 | 5 | 3 | 20 |
| miniaudio | 5 PASS | 3 | 3 | 2 | 2 | 15 |
| SoLoud | 5 PASS | 3 | 3 | 3 | 2 | 16 |
| OpenAL Soft | 3 (LGPL iOS friction) | 2 | 2 | 2 | 2 | 11 |
| Platform hand-wrap | 5 PASS (platform SDK unavoidable) | 3 | 5 | 1 | 3 | 17 |
| FMOD Studio | 1 FAIL | 5 | 5 | 3 | 4 | excluded |
| Wwise | 1 FAIL | 5 | 5 | 2 | 4 | excluded |

O1 below 3 disqualifies the candidate. OpenAL Soft scores 3 on O1 due to LGPL dynamic-linking obligation that adds store-submission friction on iOS (static linking requires license-compatibility exceptions) — borderline pass.

## 5. Top-3 with rationale

1. **Godot built-in AudioStreamPlayer + AudioBus + AudioEffect** (sigma 20). MIT license, zero integration cost given A1 Godot engine alignment, AudioBus routing covers ducking + crossfade + time-of-day layering via script-driven parameter automation. Platform-bridge delegates to AAudio + AVAudioSession handling interruptions per engine implementation.
2. **Platform hand-wrap AAudio + AVAudioEngine** (sigma 17). Highest O3 (native audio-session fidelity), but O4 is 1 (2x engineering cost rewriting mixer graph, routing, crossfade, reactive layers). Retained as a fallback for the case where engine built-in proves insufficient for a specific reactive behavior.
3. **SoLoud** (sigma 16). Pure OSS (zlib/libpng), engine-style API, cross-platform mixer + filters. Best OSS-library candidate if a second audio engine is ever needed alongside Godot built-in or if A1 candidate shifts to a runtime with weaker built-in audio.

## 6. Kappa A vs B

Tier agreement on ranked effective set (5 candidates post-exclusion): A ranks Godot > platform > SoLoud > miniaudio > OpenAL ; B ranks Godot > SoLoud > miniaudio > platform > OpenAL. Top-1 and bottom-1 agree; interior tier swap between platform hand-wrap and SoLoud/miniaudio. Tier-level agreement 4/5 = 80%, kappa brut ~0.75 "substantial".

Divergence DIV-platform-vs-OSS-lib : A ranks platform hand-wrap second (values O3 audio-session fidelity for interruption correctness) ; B ranks SoLoud second (values O4 ramp + MIT-style license simplicity). Both rankings place Godot built-in unambiguously first. Arbitrage by supervisor: top-1 decision unaffected; platform hand-wrap recorded as tier-B fallback for narrowly scoped interruption-edge-case residues.

## 7. GRADE with factors (no convergence bonus, monoculture discount)

Starting score : 2 (pyramid L3 baseline — engine docs L1 + vendor docs L1 + grey-literature GDC/indie postmortems L5, no systematic mobile audio benchmark primary source).

Positive factors :
- +1 large effect : zero integration cost for engine built-in vs ~40-80 developer-hours for a hand-wrapped mixer graph and iOS audio-session wiring. Effect size is decisive for solo VSE.

Negative factors :
- -1 indirectness : Godot AudioBus expressiveness is weaker than dedicated Studio snapshots/parameter systems; rules out some dynamic-music patterns (vertical remixing with composer-authored parameter curves).
- -1 imprecision : no primary benchmark of trigger-to-first-sample P95 or mixer voice capacity under load across mid-range Android hardware for the effective candidate set.
- -1 monoculture discount : Godot audio evidence base concentrates on Godot Foundation docs + forum threads; heavy single-ecosystem voice.
- 0 inconsistency : rankings converge at top-1.

Score final : 2 + 1 - 3 = **1/7 -> ACCEPTABLE**. Evidence supports the recommendation operationally but remains thin on quantitative device-level measurements.

## 8. Sources Table 2

| # | Source | Pyramid level | Year | Role |
|---|--------|:-------------:|:----:|------|
| 1 | Godot Foundation official docs (AudioStreamPlayer, AudioBus, AudioEffect) | L1 | 2026 | Primary API reference |
| 2 | miniaudio GitHub README + API reference | L1 | 2025 | OSS single-header capability |
| 3 | SoLoud project docs | L1 | 2025 | OSS mixer library |
| 4 | OpenAL Soft project docs + LGPL text | L1 | 2025 | OSS library + license constraints |
| 5 | Apple AVAudioSession + App Store Review Guidelines audio-session rules | L1 platform policy | 2025 | Interruption correctness anchor |
| 6 | Android AAudio NDK guide + Play Developer Policy audio-focus | L1 platform policy | 2025 | Audio-focus correctness anchor |
| 7 | GDC Vault audio-track talks (MG-2 grey-lit) | L5 | varied | Mixer architecture patterns |
| 8 | AES conference interactive-audio proceedings | L2 | varied | Academic mixer architecture |

## 9. Primary recommendation

Adopt **Godot built-in AudioStreamPlayer + AudioBus + AudioEffect** for the pilot. Implement music ducking + crossfade + time-of-day layering via script-driven bus parameter automation. Route ad-SDK audio-focus events through the engine's platform bridge (audio pause/resume on rewarded-video trigger, silent-switch respect, background handling). Retain SoLoud as an OSS-library fallback should reactive mixing outgrow AudioBus expressiveness; retain platform hand-wrap only as a targeted patch for interruption residues that cannot be resolved via the engine abstraction.

## 10. Decision + traceability

**Decision** : Godot built-in audio subsystem. Status GRADE ACCEPTABLE (1/7). Solo-indie + open-source strict + A1 engine alignment constraints dominate. FMOD / Wwise excluded by budget gate despite higher expressiveness.

**Traceability** :
- PICOC source : `verification/picoc/mobile-game-picoc-batch-B.md` §B9
- Protocol amendments : G-1 + #3 + MG-2 grey-lit acceptance + MG-6 cross-PICOC tagging
- Cross-references : A1 engine choice (upstream) ; A8 audio asset shipping (Ogg Vorbis / Opus bundle) ; E22 ad SDK audio-focus handover ; D20 privacy manifest (no audio SDKs declaring data collection).
- Anti-double-counting : audio asset codec choice credited to A8 ; mixer subsystem choice credited to B9 ; ad audio-focus specification credited to E22 — this form only consumes those claims.

Word count : ~1080 words.
