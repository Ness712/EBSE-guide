# Extraction Form — PICOC A8 : Cross-Platform Asset Pipeline & Bundle Architecture

**Domain** : mobile-game-2d
**PICOC #** : A8
**Date** : 2026
**Reviewers** : A + B (isolated contexts) + Agent C verification
**Protocol** : Kitchenham & Charters 2007 §2.4 + Amendment G-1 + Amendment #3 + methodology.md v2026.04.7

## 1. PICOC formal

| Element | Value |
|---------|-------|
| **P** | Solo indie mobile game developer shipping a 2D pixel-art farming-sim on Android + iOS, managing sprites + tilemaps + sprite-atlas packing + multi-resolution output for heterogeneous displays (ldpi→xxxhdpi, @1x→@3x), texture compression format choice (ASTC on recent devices, ETC2 fallback on Android), audio asset encoding, bundle splitting against the Google Play 150 MB APK cap (App Bundle delivery) and the Apple App Store 200 MB cellular-download cap |
| **I** | Class of asset-pipeline + bundle architectures: manual export pipelines, engine-integrated asset import pipelines, scripted self-host CI-driven pipelines, atlas packers (runtime vs build-time), compressed-texture toolchains, app-bundle splitting strategies (per-density, per-ABI, asset packs / on-demand resources). End-to-end "asset → import → package → deploy" workflow |
| **C** | Discovered systematically in Phase 2.1 — no pre-identification per Amendment G-1 |
| **O** | Final release bundle size per platform in MB (APK + AAB splits for Android, IPA for iOS) ; runtime texture memory footprint MB on reference mid-range 2026 device ; asset-build time from clean (s) ; pixel-art visual fidelity objective (zero filtering artifacts + integer scaling preserved, screenshot-diff) ; dev-hours to add a new asset end-to-end ; bundle-split correctness (user downloads only needed config) ; asset hot-reload latency dev-time (s from edit to see-in-app) |
| **Co** | Pixel-art demands nearest-neighbor + integer scale — strong constraint on filtering + compression (lossy block compression can mangle pixel-art) ; Android App Bundle mandatory on Play ; Apple App Thinning standard ; transverses = budget=open-source strict (CI runs on self-host runner or local machine, no hosted CI free tier ; GitHub code hosting + workflow YAML accepted per §3.1.1 Rule 6 facet decomposition), ai_agent=yes, team_size=ebse-default, scale=mvp |
| **Anchor** | SWEBOK v4 KA2 Architecture (deployment) + KA4 Construction (build systems) + KA8 Configuration Management (asset/artifact) + KA9 Management (effort) ; ISO/IEC 25010:2023 Performance Efficiency (Resource utilization — texture memory + bundle size) + Compatibility (Interoperability with stores) + Portability (Adaptability multi-density + multi-ABI) ; Google Play Developer Program Policy (App Bundle mandate, size optimization) ; Apple ASRG §2.3 (accurate metadata, app thinning) |

## 2. Candidates discovered (archetype classes)

| # | Archetype class | Description |
|---|-----------------|-------------|
| 1 | Engine-integrated pipeline + build-time atlas packing | Engine import step packs atlases + selects compression at build ; asset watcher triggers rebuild ; hot-reload over editor link |
| 2 | External standalone atlas packer + engine consumes atlas | CLI atlas packer (open tool) invoked by a Makefile/Justfile, output consumed by engine ; pipeline visible and scriptable |
| 3 | Self-host CI-driven pipeline | Self-hosted runner invokes packer + compression + bundle split ; YAML in repo (portable), compute on developer-owned machine — budget=open-source strict compliant |
| 4 | Runtime atlas packing | Source sprites shipped individually, atlas built at first-run ; simplest pipeline, worst runtime cost |
| 5 | Hybrid build-time + on-demand resource packs | Core assets build-time-packed into base bundle ; optional assets in Play Asset Delivery / iOS On-Demand Resources ; applies only for assets exceeding base cap |
| 6 | Dedicated asset-management tool with DB + metadata | Asset catalog with UUID per asset, metadata queries ; heavier but scalable beyond MVP |

## 3. Exclusions at screening

| Candidate | Exclusion code | Reason |
|-----------|:--------------:|--------|
| SaaS asset-processing service | E1 | Budget=open-source strict rejects SaaS even free tier |
| GitHub Actions hosted runners | E1 | Per §3.1.1 Rule 6 facet decomposition: hosted compute = SaaS → rejected ; self-hosted runner + YAML accepted |
| Proprietary build-farm service | E1 | SaaS — rejected |
| Commercial sprite-packer (paid licence, no self-host) | E1 | Paid proprietary — rejected |
| Engine cloud-build services (e.g. hosted build services) | E1 | SaaS — rejected |

## 4. O-matrix (ordinal 1–5, higher = better)

| Archetype | O1 Bundle size | O2 Runtime texture memory | O3 Asset-build time | O4 Pixel-art fidelity | O5 Hot-reload latency | O6 Impl. effort (solo) | O7 Budget=OSS strict | Σ |
|-----------|:-------------:|:------------------------:|:-------------------:|:---------------------:|:---------------------:|:----------------------:|:--------------------:|:-:|
| 1. Engine-integrated build-time | 4 | 4 | 4 | 5 | 5 | 5 | 5 | 32 |
| 2. External packer + Makefile | 4 | 4 | 3 | 5 | 3 | 4 | 5 | 28 |
| 3. Self-host CI-driven | 5 | 4 | 4 | 5 | 2 | 3 | 5 | 28 |
| 4. Runtime atlas packing | 3 | 3 | 5 | 3 | 4 | 5 | 5 | 28 |
| 5. Hybrid + on-demand packs | 5 | 5 | 3 | 5 | 2 | 2 | 5 | 27 |
| 6. Asset-mgmt tool + DB | 4 | 4 | 3 | 5 | 3 | 2 | 5 | 26 |

## 5. Top-3 ranking with rationale

1. **Engine-integrated pipeline + build-time atlas packing (archetype 1)** — Lowest implementation effort for a solo developer ; hot-reload latency dominated by editor-live-link (seconds, not minutes) ; pixel-art fidelity preserved by engine-native nearest-neighbor + integer-scale settings. Covers MVP scope fully.
2. **External packer + Makefile / Justfile (archetype 2)** — Visible, scriptable pipeline if the engine's built-in packer is inadequate or if cross-project reuse is desired. Loses the editor hot-reload convenience but gains transparency.
3. **Self-host CI-driven pipeline (archetype 3) on top of archetype 1 or 2** — Activated when release-cut packaging (AAB splits, App Thinning) must be reproducible. Budget=open-source strict compliant via self-hosted runner (workflow YAML is portable text per §3.1.1 Rule 6).

## 6. Kappa A vs B

Agreement on archetype ranking: 5/6 → **κ ≈ 0.80 ("substantial / almost perfect")**. Single divergence: Reviewer A places archetype 2 second on transparency grounds ; Reviewer B places archetype 4 second on simplicity grounds. Supervisor arbitrage: archetype 2 wins — runtime atlas packing fails pixel-art fidelity O4 under lossy texture compression and carries runtime cost that contradicts the 60 Hz simulation budget from A4'.

## 7. GRADE synthesis

Starting score : **3** (highest source = L1 Google Play App Bundle docs + L1 Apple App Thinning docs + L1 ISO/IEC 25010 Resource utilization).

Positive factors:
- **+1 large_effect** — App Bundle + App Thinning reduce shipped bundle size by roughly half compared to monolithic APK/IPA in published platform case studies ; the quantitative bundle reduction is material for a 150 MB / 200 MB cap.
- **+1 major_evidence** — Google Play App Bundle has been mandatory since Aug 2021 and is documented first-party ; Apple App Thinning is documented first-party ; both are anchored in platform standards rather than community practice.

Convergence factor **OMITTED** (monoculture discount — platform docs and engine docs reference each other ; no true independent evidence).

Negative factors:
- **−1 indirectness** — Pixel-art preservation under texture compression (ASTC / ETC2 / PVRTC) is sparsely benchmarked ; most compression literature targets photographic content, not discrete-pixel art.
- **−1 imprecision** — Asset-build time and hot-reload latency are empirically unverified across archetype exemplars on reference dev hardware.

No −1 inconsistency ; no −1 bias.

Final score : 3 + 2 − 2 = **3/7 → RECOMMANDE**.

## 8. Sources extracted (Kitchenham Table 2)

| # | Source | Pyramid level | Year | Role |
|---|--------|:-------------:|:----:|------|
| 1 | Google Play App Bundle documentation | L1 platform | 2026 | Mandate + split strategies |
| 2 | Apple App Thinning documentation | L1 platform | 2026 | Thinning strategies |
| 3 | ISO/IEC 25010:2023 Resource utilization | L1 standard | 2023 | Quality anchor |
| 4 | ASTC / ETC2 / PVRTC format specifications | L1 / L2 | 2013–2024 | Compression anchor |
| 5 | Engine-official asset-pipeline docs (per A1 exemplar) | L1 vendor | 2026 | Integrated pipeline details |
| 6 | GDC Vault indie asset-pipeline talks (MG-2 grey-lit) | L5 flagged | 2021–2025 | Practitioner evidence |
| 7 | Toftedahl & Engström SMS (engine catalogues) | L3 | 2021 | Survey reference |
| 8 | Pixel-art community tooling surveys (MG-2 grey-lit) | L5 flagged | 2022–2025 | Fidelity under compression |

## 9. Primary recommendation for pilot P

**Engine-integrated build-time pipeline (archetype 1)** with pixel-art fidelity safeguards: nearest-neighbor texture sampling, integer-scale viewport, lossless compression for tilesets and character sheets (e.g. ETC2 RGBA8 uncompressed on Android, uncompressed on iOS where bundle cap permits), and build-time atlas packing via the engine's native packer. Release-cut steps (AAB splits, App Thinning) scripted in a Justfile that can be driven locally or from a self-hosted runner. Dev-time hot-reload uses the engine's native editor-live-link for sprite edits. Budget=open-source strict compliant: no SaaS, no hosted CI compute.

## 10. Decision with traceability

**Decision** : Adopt archetype 1 (engine-integrated build-time pipeline) as primary, archetype 2 (external packer + Makefile) as fallback, archetype 3 (self-host CI) as release-cut envelope.

**Traceability** : PICOC definition in `verification/picoc/mobile-game-picoc-batch-A.md` §A8 ; addresses the PO-documented pain point on asset localization in source PNG via outcomes O5 (hot-reload) + dev-hours to add asset ; upstream for B7 (tile-map assets), B10 (animation assets), B11 (pixel-art sprite assets) ; downstream consumer D19 (dynamic delivery) + H33 (CI/CD orchestration).
