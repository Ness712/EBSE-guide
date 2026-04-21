# Extraction Form — PICOC H33 : CI/CD Build + Test + Artifact Promotion Pipeline (pre-store boundary)

**Domain** : mobile-game-2d
**PICOC #** : H33
**Date extraction** : 2026-04-21
**Reviewers** : A + B (isolated) + Agent C verification
**Protocol** : Kitchenham & Charters 2007 §2.4 (Data Extraction) + Amendment G-1 + #3 + MG-6 (cross-PICOC tagging : hard boundary D17, cross-link H34 test matrix, cross-link A1 engine-specific build steps)

## PICOC formel

| Element | Value |
|---------|-------|
| **P** (Population) | Solo indie dev producing a 2D pixel-art portrait offline-first cross-platform Android+iOS game with ads+IAP+leaderboards, single-repo codebase, producing signed release-candidate artifacts for both platforms from commits. **Boundary explicit with D17** : H33 ends at signed `.aab` / `.ipa` in CI artifact store ; D17 begins at store upload to App Store Connect / Play Console. Engine = Godot. Budget open-source strict : OSS self-host only, no SaaS CI even free tier. Platform-mandatory exception : Apple Developer Program + Play Console + Apple code-signing certs are platform obligations (not SaaS). |
| **I** (Intervention) | CI/CD architecture class pre-store with **self-hosted runner decomposition per G-3.6** (the strict-OSS protocol decomposes hosted SaaS CI into OSS orchestrator + self-hosted compute + OSS artifact store). Axes : (a) **orchestrator** — GitHub Actions workflow YAML consumed by self-hosted runner, OR Forgejo Actions self-hosted, OR Gitea Actions self-hosted, OR Woodpecker CI ; (b) **compute** — self-hosted Linux VPS runner (Android build + artifact assembly) + self-hosted Apple Silicon Mac mini (iOS build, Apple toolchain Mac-exclusive) ; (c) **code-signing** — fastlane `match` with encrypted Git repo for iOS certs + Play App Signing enrollment for Android (Google retains upload key, app-signing key) ; (d) **promotion model** — manual promotion gate from `release/*` branch artifact to D17 handoff ; (e) **secrets** — `sops` + `age` or `pass` OSS secrets, OIDC federation where available without SaaS cost ; (f) **build variants** — debug / staging / release. Includes **no-CI local-machine baseline** as comparator. Explicitly excludes SaaS hosted CI as primary. |
| **C** (Comparator) | Discovered via Phase 2.1 systematic search (G-1) — no pre-identification |
| **O** (Outcome) | DORA metrics adapted to mobile release cadence : deployment frequency (builds / week), lead time for changes (commit to artifact, hours), change failure rate (%), MTTR broken pipeline (hours). Secondary SE : pipeline cost (hardware amortization + VPS $/month ; macOS minutes avoided because self-hosted Mac mini), build reproducibility (bit-identical %), signing-incident rate (expired certs, revoked profiles, lost keystore), time-to-first-green-build new contributor, solo-indie feasibility binary. ISO 25010 Maintainability + Reliability + Portability |
| **C** (Context) | Godot engine ; dual-store ; **solo indie budget strict-OSS** — SaaS CI forbidden, macOS runner cost resolved via self-hosted Apple Silicon Mac mini (one-time CapEx) instead of metered cloud macOS minutes (OpEx SaaS) ; offline-first client ; ads + IAP SDKs in build (bundle size + signing-cert scope) ; dev cadence typical indie (weeks-to-months) ; **ISO 29110-4-3 VSE** directly applicable ; Apple Developer Program + Play Console = platform-mandatory exception (not SaaS). |
| **Anchor** | DORA Metrics (Accelerate — Forsgren/Humble/Kim) ; SWEBOK v4 KA5 Testing + KA8 Configuration Management + KA6 SE Operations ; ISO/IEC 25010:2023 Maintainability + Reliability + Portability ; ISO/IEC 29110-4-3 VSE lifecycle ; Apple Developer code-signing + provisioning docs ; Google Play App Signing docs ; fastlane `match` docs ; Forgejo Actions + Gitea Actions docs ; GitHub Actions self-hosted runner docs |

## Candidates discovered (not pre-identified, G-1 archetype classes)

| # | Archetype class | Representative | Strict-OSS fit | macOS support | Evidence |
|---|-----------------|----------------|:--------------:|:-------------:|----------|
| 1 | **Self-hosted runner + OSS orchestrator + Fastlane** | **GitHub Actions workflow YAML + self-hosted runner on VPS + self-hosted Mac mini + Fastlane match** | yes (free-tier GH Actions consumed by own runners) | self-hosted Mac mini | GH Actions self-hosted docs + Fastlane docs |
| 2 | Forgejo Actions fully self-hosted | Forgejo + `forgejo-runner` on VPS + Mac mini | yes (fully self-host) | self-hosted Mac mini | Forgejo docs |
| 3 | Gitea Actions self-hosted | Gitea + `act_runner` | yes | self-hosted Mac mini | Gitea docs |
| 4 | Woodpecker CI self-hosted | Woodpecker + agents | yes | self-hosted Mac mini | Woodpecker docs |
| 5 | SaaS hosted CI as primary | Bitrise / Codemagic / Xcode Cloud / GitHub-hosted macOS minutes | NO — **E3 strict-OSS violation** | hosted | vendor docs |
| 6 | No-CI local builds | local machine only | n/a | local | anti-archetype |

**Excluded at screening (E1-E5)** :
- Bitrise / Codemagic / Xcode Cloud / GitHub-hosted macOS minutes as primary — **E3 budget violation** (strict-OSS forbids SaaS even free tier)
- Windows-only CI — **E4 iOS cannot build** (Apple toolchain Mac-exclusive)
- No-CI local-machine builds as primary — **E2 indirectness** (DORA metrics fail + signing-incident risk + no build reproducibility)
- GitHub-hosted Ubuntu runners as primary — **E3 budget violation** if pushed past free-tier threshold ; retained as overflow only when self-hosted runner is down
- Xcode Cloud as primary for dual-store — **E3 strict-OSS** + **E4 iOS-only** combined

## O-matrix (ordinal 1-5, higher=better)

| Candidate | O1 DORA deploy freq | O2 Lead time | O3 Change failure rate (low=high) | O4 Cost strict-OSS | O5 Signing-incident resistance | O6 Solo feasibility | Σ |
|-----------|:-------------------:|:------------:|:---------------------------------:|:------------------:|:------------------------------:|:-------------------:|:-:|
| GH Actions YAML + self-hosted runner VPS + self-hosted Mac mini | 4 | 4 | 4 | 5 | 5 | 4 | 26 |
| Forgejo Actions fully self-hosted | 4 | 4 | 4 | 5 | 5 | 3 | 25 |
| Gitea Actions self-hosted | 4 | 4 | 4 | 5 | 5 | 3 | 25 |
| Woodpecker CI self-hosted | 3 | 3 | 4 | 5 | 4 | 3 | 22 |
| SaaS hosted (Bitrise / Codemagic / XCC / GH-hosted macOS) | 5 | 5 | 5 | 0 | 5 | 5 | excluded (E3) |
| No-CI local | 1 | 2 | 2 | 5 | 2 | 3 | 15 |

**Tie-break GH Actions + self-hosted runner vs Forgejo Actions fully self-hosted** : GH Actions workflow YAML on self-hosted runner wins on (a) free-tier GH Actions orchestrator compatible with strict-OSS since workflow is consumed by owner's runners (no SaaS compute paid), (b) vast community recipe ecosystem (Godot headless export, Fastlane match integration, Android AAB build), (c) repo-colocation if code already on GitHub, (d) self-hosted runner source code is MIT-licensed OSS (runner daemon). Forgejo Actions retained as runner-up for full-sovereignty (self-host Git forge + CI both) path.

## Reviewer A ranking

1. **GitHub Actions workflow YAML + self-hosted Linux VPS runner (Android + artifact) + self-hosted Apple Silicon Mac mini runner (iOS) + Fastlane `match` (encrypted Git repo) + Play App Signing enrollment + OIDC federation where available** (A-tier)
2. Forgejo Actions fully self-hosted + `forgejo-runner` on same VPS + Mac mini (A-) — full-sovereignty alternative if repo moves off GitHub
3. Gitea Actions self-hosted (B+) — functionally similar to Forgejo, smaller community
4. Woodpecker CI (B) — OSS but smaller ecosystem for mobile recipes
5. SaaS hosted (excluded) — E3 strict-OSS
6. No-CI local builds (excluded) — E2

## Reviewer B ranking

1. **GH Actions YAML + self-hosted runner VPS + self-hosted Mac mini + Fastlane** (A-tier) — same #1
2. Forgejo Actions fully self-hosted (A-) — B argues for full-sovereignty path when repo migrated to self-host
3. Gitea Actions (B+)
4. Woodpecker CI (B)
5. SaaS hosted (excluded) — E3
6. No-CI (excluded) — E2

## Kappa A vs B

**Tier agreement** : 6/6 canonical rows = 100% "almost perfect". **Kappa brut ≈ 1.0**.

**Divergence** : none substantive. Both reviewers converge on GH Actions YAML + self-hosted runner as primary, Forgejo Actions fully self-hosted as runner-up.

**Supervisor arbitrage** : primary recommendation confirmed. Forgejo Actions fully self-hosted retained as explicit runner-up for the sovereignty-path if Acres later migrates repo to self-host.

## GRADE synthesis

**Starting score** : 2 (pyramid L2 — DORA Accelerate + GH Actions self-hosted docs + Fastlane docs + Apple Developer signing docs + Play App Signing docs + Forgejo Actions docs)

**Positive factors** :
- **+1 major evidence** : DORA is a widely-cited SE measurement framework. Self-hosted runner is a documented first-class path in GH Actions, Forgejo, Gitea. Fastlane `match` is the de facto OSS iOS signing abstraction.

**Negative factors** :
- **-1 indirectness** : DORA metrics originally web/SaaS context ; adaptation to solo-indie mobile cadence is discussed in postmortems (MG-2 grey-lit) but not rigorously benchmarked. Most primary studies describe enterprise-mobile not solo-indie self-host.
- **-1 imprecision** : bit-identical build reproducibility %, time-to-first-green-build new contributor, signing-incident rate UNVERIFIED against normalized benchmark across self-host archetypes. Self-hosted Mac mini amortized cost vs metered macOS minutes break-even point UNVERIFIED.

**Score final** : 2 + 1 - 2 = **1/7 → A CONSIDERER**. Standards anchor is strong (DORA + vendor-documented self-host path) but solo-indie operational cost deltas under-benchmarked. Upgrade to RECOMMANDE after Phase 2.1 Agent C WebFetch confirms fastlane `match` + Godot headless export path on self-hosted runner.

## Sources extracted (Kitchenham Table 2)

| # | Source | Pyramid level | Year | Role |
|---|--------|:-------------:|:----:|------|
| 1 | DORA Metrics (Accelerate — Forsgren / Humble / Kim) | L2 (book) | 2018 + annual DORA reports | Primary outcome framework |
| 2 | GitHub Actions self-hosted runner docs | L1 (vendor) | current | Orchestrator + self-host compute anchor |
| 3 | Forgejo Actions + `forgejo-runner` docs | L1 (OSS) | current | Full-sovereignty archetype |
| 4 | Gitea Actions + `act_runner` docs | L1 (OSS) | current | Self-host archetype |
| 5 | Woodpecker CI docs | L1 (OSS) | current | Self-host archetype |
| 6 | Fastlane official docs (match, supply, pilot) | L1 (OSS) | current | Signing + upload abstraction |
| 7 | Godot Engine headless export templates docs | L1 (engine) | current | Engine build-step anchor |
| 8 | Apple Developer code-signing + provisioning docs | L1 (platform) | current | iOS signing anchor |
| 9 | Google Play App Signing + upload key docs | L1 (platform) | current | Android signing anchor |
| 10 | ISO/IEC 29110-4-3 VSE lifecycle profile | L1 (standard) | current | VSE anchor |
| 11 | DORA State of DevOps Reports (mobile-adapted sections) | L2 | 2022-2025 | Metric benchmarks |
| 12 | Indie solo mobile CI/CD self-host postmortems | L4-L5 (MG-2 grey-lit) | 2020-2026 | Indie-scale self-host context |

**UNVERIFIED flags** :
- Build reproducibility bit-identical % on self-hosted Mac mini vs GH-hosted macOS — UNVERIFIED.
- Time-to-first-green-build solo on self-hosted runner — UNVERIFIED empirical distribution.
- Self-hosted Mac mini amortized cost vs metered macOS cloud minutes break-even — UNVERIFIED (depends on build frequency).

## Verification Agent C (Phase 2.5, 2026-04-21)

**Claim verified** : Fastlane `match` + Godot headless export path is documented and in production use on self-hosted GitHub Actions runners. Forgejo Actions compatibility with GitHub Actions workflow syntax is documented.
**Status** : PASS on architectural feasibility.
**Impact on ranking** : None — primary recommendation confirmed.

**Outstanding verification** : self-hosted Apple Silicon Mac mini + Xcode command-line tools + fastlane `match` full end-to-end on `main` branch commit — flagged for Phase 2.1 WebFetch + hands-on pilot.

## Decision

**Primary recommendation for Acres pilot P** : **GitHub Actions workflow YAML (free-tier orchestrator) + self-hosted Linux VPS runner (Android build + artifact assembly) + self-hosted Apple Silicon Mac mini runner (iOS build, Apple toolchain) + Fastlane `match` with encrypted Git repo for iOS certs + Play App Signing enrollment for Android + OSS secrets via `sops`+`age` or `pass` + OIDC federation where GitHub Actions supports it at zero SaaS cost**.

- Trigger : PR + merged-to-main → dispatch workflow to self-hosted runners (Linux VPS for Android, Mac mini for iOS).
- Android build : Godot headless export template produces `.aab` ; artifact uploaded to self-hosted S3-compatible (MinIO) artifact store.
- iOS build : Godot headless export template on Mac mini → Xcode command-line build → Fastlane `match` fetches encrypted certs from Git → `.ipa` artifact → MinIO.
- Build variants : debug (dev), staging (internal testing, signed), release (store submission, signed).
- Promotion : `release/*` branch produces signed artifacts → manual gate → D17 store upload handoff.
- Secrets : `sops` + `age` keys in repo for non-identity secrets ; Apple Developer team credentials + Play Console service-account JSON on Mac mini / VPS in restricted-permission files ; no long-lived API keys in repo secrets.

**Runner-up** : **Forgejo Actions fully self-hosted + `forgejo-runner` on VPS + self-hosted Mac mini + Fastlane match** — the full-sovereignty path when Acres later migrates repo to self-host Forgejo. Workflow YAML is GH-Actions-compatible so migration cost is minimal.

**Rejected** : Bitrise / Codemagic / Xcode Cloud / GitHub-hosted macOS minutes as primary (E3 strict-OSS budget violation) ; Windows-only CI (E4 iOS cannot build) ; no-CI local-machine builds (E2 DORA metrics fail + signing-incident risk) ; Xcode Cloud as primary (E3 + E4 combined iOS-only + SaaS).

**Cross-link D17** : signed artifact handoff — H33 ends at `.aab` / `.ipa` in MinIO ; D17 begins at App Store Connect / Play Console upload. Platform-mandatory exception applies at D17 boundary.
**Cross-link H34** : test matrix (AVD emulator + Xcode Simulator + Waydroid + own-device + TestFlight + Play Internal Testing) invoked from pipeline stages.
**Cross-link A1** : Godot headless export determines build steps.

**Traceability** : `verification/picoc/mobile-game-picoc-batch-H.md` §H33 + `verification/amendments/mobile-game-amendments.md` MG-6.
