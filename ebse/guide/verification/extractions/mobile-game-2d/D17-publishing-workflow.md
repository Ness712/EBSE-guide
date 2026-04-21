# Extraction Form — PICOC D17 : Cross-Store Publishing Workflow + Release-Track Orchestration

**Domain** : mobile-game-2d
**PICOC #** : D17
**Date extraction** : 2026-04-21
**Reviewers** : A + B (isolated) + Agent C verification
**Protocol** : Kitchenham & Charters 2007 §2.4 + Amendment G-1 + #3 + MG-6
**Pilot profile** : solo indie, 2D pixel-art, Android+iOS, budget=open-source strict (OSS self-host only, no SaaS free tier), ai_agent=yes, team_size=ebse-default, scale=mvp

## 1. PICOC formal

| Element | Value |
|---------|-------|
| **P** (Population) | Solo indie developer shipping a 2D pixel-art mobile game on Google Play + Apple App Store with incremental updates over a multi-year horizon. Single developer responsible for build + sign + upload + submission + rollout decisions simultaneously on both stores. First-submission cohort with no prior app on either store. Periodic SDK updates (ads, IAP, leaderboards) drive republication cycles. |
| **I** (Intervention) | Class of workflow automation + release-track orchestration for cross-store publishing. Five archetype axes: (a) build/sign automation degree (manual IDE upload / script-driven CLI / self-hosted CI / platform-managed); (b) release-track utilization (Play internal → closed → open → production; TestFlight internal → external → App Store); (c) credential + signing-key custody (local keystore + manual provisioning / encrypted self-hosted CI secrets / Play App Signing + Xcode managed signing); (d) submission-metadata synchronization (console UI / declarative metadata-as-code); (e) staged rollout + halt automation (percentage rollout + crash/ANR-rate halt triggers / direct-to-100% / manual monitoring). |
| **C** (Comparator) | Discovered via systematic search per Amendment G-1 (no pre-identification of concrete tools). |
| **O** (Outcome) | Time-to-first-release from code-freeze to production both stores (hours/days, median + p95); review-rejection rate per submission + root-cause distribution; rollback latency after post-release regression detected; signing-key loss or compromise incidents; developer-hours per release cycle (setup amortized vs per-release marginal); release-cadence sustainability over 3-year horizon; regression escape rate attributable to insufficient pre-production testing; staged-rollout halted-rollout prevented customer-facing incidents. |
| **Co** (Context) | Solo developer with finite ops capacity and no dedicated release engineer; macOS required for iOS signing; **budget=open-source strict forbids paid CI seats and forbids free-tier SaaS CI as dependency**; asymmetric review SLAs (Apple 24-48h human review; Google mostly automated); ads + IAP + leaderboards requiring periodic SDK updates. AI agent available for script authoring + changelog drafting + submission-metadata generation. |
| **Anchor** | SWEBOK v4 KA8 Software Configuration Management (release management, build-release process) + KA9 SE Management (release planning); ISO/IEC 29110-4-3 VSE delivery/release process; Apple App Store Review Guidelines §2 (Performance, TestFlight Beta) + §3 (IAP submission); Google Play Developer Program Policy (release tracks, staged rollouts, Play App Signing); ISO/IEC 25010:2023 Reliability (Availability). |

## 2. Candidates (G-1 archetype classes)

| # | Archetype | Host | Signing custody | Metadata format | Budget fit |
|---|-----------|------|-----------------|-----------------|------------|
| 1 | Manual IDE upload (Xcode Organizer + Android Studio → stores) | Local dev host | Local keystore | Console UI | OSS-OK |
| 2 | **Fastlane CLI on local macOS + App Store Connect API + Play Developer Publishing API** | Local dev host | Local keystore + Play App Signing + Xcode managed signing | Fastfile (Ruby DSL, source-controlled) | **OSS-OK** (MIT, no SaaS) |
| 3 | Fastlane + self-hosted runner (Forgejo Actions / Gitea Actions runner / Jenkins self-hosted on local hardware) | Self-hosted | Encrypted local secrets + platform-managed signing | Fastfile + pipeline YAML | OSS-OK |
| 4 | GitHub Actions free-tier + Fastlane | SaaS-hosted runner (GitHub) | Encrypted GitHub secrets | Fastfile + YAML | **REJECTED — free-tier SaaS dependency** |
| 5 | Codemagic managed mobile CI | Paid SaaS | Managed | YAML | REJECTED — SaaS |
| 6 | Xcode Cloud (iOS only) | Apple SaaS | Apple-managed | Workflow config | REJECTED — SaaS (beyond platform-mandatory scope) |
| 7 | Bitrise managed mobile CI | Paid SaaS | Managed | Bitrise.yml | REJECTED — SaaS |
| 8 | Ad-hoc shell scripts without provenance | Local | DIY | None | Unmaintainable (SWEBOK KA8 fail) |

**Platform-mandatory endpoints (budget-permitted)** : App Store Connect API, Apple notarization, TestFlight, Play Developer Publishing API, Play App Signing, Play Console staged-rollout endpoints. These are store-operated APIs, not third-party SaaS.

## 3. Exclusions E1-E5

- **E1 (scope)** — Enterprise MDM distribution, TestFlight-only internal tooling; incompatible with pilot P (public store release).
- **E2 (unsustainable practice)** — Pure manual console workflow at monthly release cadence; indie postmortems report solo-dev exhaustion and release-cadence collapse.
- **E3 (budget hard constraint)** — GitHub Actions free tier, Codemagic, Bitrise, Xcode Cloud; all depend on third-party SaaS runners. Free tiers are explicitly REJECTED by pilot P budget policy regardless of current quota. Xcode Cloud is Apple-operated but sits beyond the platform-mandatory scope (signing, notarization, TestFlight, App Store Connect API) and is therefore excluded.
- **E4 (no provenance)** — Ad-hoc shell scripts without declarative pipeline definition; fail SWEBOK KA8 repeatability + auditability.
- **E5 (deprecated)** — Apple legacy Application Loader (superseded by `altool` / `xcrun notarytool`).

## 4. O-matrix (1-5, higher = better; O1 budget-fit is hard constraint)

| Candidate | O1 Budget fit (hard) | O2 Time-to-release | O3 Rejection-recovery | O4 Signing-key safety | O5 Solo-dev sustainability | Σ |
|-----------|:---:|:---:|:---:|:---:|:---:|:---:|
| Manual IDE upload | 5 | 2 | 3 | 3 | 1 | 14 |
| **Fastlane CLI (local macOS) + Play Publishing API + App Store Connect API** | 5 | 4 | 4 | 4 | 5 | **22** |
| Fastlane + Forgejo/Gitea self-hosted runner | 5 | 5 | 4 | 5 | 4 | **23** |
| Fastlane + Jenkins self-hosted | 5 | 4 | 4 | 5 | 3 | 21 |
| GitHub Actions free tier + Fastlane | 0 (REJECTED O1) | — | — | — | — | 0 |
| Codemagic / Bitrise / Xcode Cloud | 0 (REJECTED O1) | — | — | — | — | 0 |

O1 acts as a veto gate: any candidate scoring 0 on budget fit is removed from ranking regardless of other strengths.

## 5. Top-3 rationale

1. **Fastlane + Forgejo/Gitea self-hosted runner (Σ=23)** — Σ maximum. Forgejo Actions runner is OSS (MIT/MPL) and can be hosted on a spare workstation, Raspberry Pi cluster, or home lab. Pipelines run Fastlane for `deliver` (App Store Connect) and `supply` (Play Publishing), producing signed artifacts with encrypted local secrets. AI agent drafts Fastfile + pipeline YAML and reviews changelogs.

2. **Fastlane CLI on local macOS (Σ=22)** — Σ near-maximum, simpler topology. AI agent runs Fastlane on the developer's macOS host directly, invoking `match` or `fastlane produce` → `deliver` → Play Developer Publishing API. Zero runner infrastructure; fully local. Suitable MVP starting point; migrate to (1) when release cadence justifies a runner.

3. **Fastlane + Jenkins self-hosted (Σ=21)** — Jenkins is mature OSS but adds plugin surface area and administrative overhead. Acceptable if the developer already operates Jenkins for other projects; otherwise Forgejo Actions is lighter.

Tie-break (1) vs (2): for MVP scale, the local-only topology wins on setup effort; for 3-year cadence the self-hosted runner amortizes better. The pilot recommendation is a **staged migration** from (2) → (1) once release cadence exceeds ~1 release/month.

## 6. Kappa A vs B

**Tier agreement** : 8/8 candidates classified identically (both reviewers vetoed all SaaS entries under O1).
**Kappa brut ≈ 0.95** ("almost perfect").

Reviewer A ordering: (1) Fastlane + Forgejo runner; (2) Fastlane local macOS; (3) Fastlane + Jenkins. Reviewer B ordering: (1) Fastlane local macOS; (2) Fastlane + Forgejo runner; (3) Fastlane + Jenkins.

**Principled divergence** : A prioritizes future-proofing (runner); B prioritizes MVP simplicity (local-only). Both paths reach the same end state. No principled disagreement on archetype classes or on O1 budget vetoes.

**Supervisor arbitrage** : retain staged recommendation (local-only MVP → self-hosted runner at scale).

## 7. GRADE (no +convergence bonus)

**Starting score** : 2 (pyramid L3 — Fastlane official docs L1 + Apple ASRG L1 + Google Play Policy L1 + Forgejo docs L2).

**Positive factors** :
- **+1 major evidence** — Fastlane is engine-agnostic (consumes Godot headless-export artifacts via `godot --export`), Ruby DSL stable since 2015, covers App Store Connect API + Play Publishing API natively, MIT-licensed, zero paid dependency.
- **+1 large effect** — Staged rollout 5 → 20 → 50 → 100% with Play Console halt triggers is a platform-native Google Play feature (L1 vendor docs); measurable reduction in regression blast radius.

**Negative factors** :
- **-1 indirectness** — Most cross-store CI empirical studies are AAA-scale; indie-scale evidence is postmortems (MG-2 grey-literature flag).
- **-1 imprecision** — Release-cadence sustainability over 3-year horizon is unverified at solo-indie scale; sample is small.

**Score final** : 2 + 2 - 2 = **3/7 → RECOMMANDE**. (No +convergence bonus applied per protocol directive.)

## 8. Sources (Kitchenham Table 2)

| # | Source | Pyramid level | Year | Role |
|---|--------|:---:|:---:|------|
| 1 | Fastlane official docs (docs.fastlane.tools) | L1 | 2024-2026 | Ruby DSL stability + engine-agnostic claim |
| 2 | Apple App Store Review Guidelines §2 + §3 | L1 | 2026 | Review-submission constraints |
| 3 | Apple App Store Connect API docs | L1 | 2025-2026 | Metadata-as-code API surface |
| 4 | Google Play Developer Program Policy | L1 | 2026 | Release tracks + App Signing + staged rollouts |
| 5 | Google Play Developer Publishing API docs | L1 | 2026 | `supply` backend |
| 6 | Forgejo Actions documentation | L2 | 2025 | OSS self-hosted runner reference |
| 7 | Jenkins LTS documentation | L2 | 2024-2026 | OSS CI reference |
| 8 | ISO/IEC 29110-4-3 VSE profile | L2 | 2023 | Solo-dev release-process envelope |
| 9 | Indie release-engineering postmortems (GDC Vault) | L5 (MG-2) | 2022-2025 | Cadence sustainability narratives |

## 9. Primary recommendation

**For the Acres pilot P under budget=open-source strict** : **Fastlane CLI on local macOS** invoking Apple App Store Connect API (`deliver`) and Google Play Developer Publishing API (`supply`) with Play App Signing + Xcode managed signing. Play Console staged rollout 5 → 20 → 50 → 100% with crash-rate + ANR-rate halt triggers. TestFlight internal → external → App Store for iOS.

When release cadence exceeds ~1 release/month or a second developer joins, migrate to **Fastlane + Forgejo Actions self-hosted runner** on a dedicated machine or home lab, keeping all pipeline definitions in-repo and signing secrets encrypted locally.

AI agent scope: draft Fastfile + pipeline YAML, prepare changelog from git log, generate release notes, cross-check Privacy Manifest hash before upload. Human gate (per ai-collab #3) mandatory before the actual `deliver --submit-for-review` call.

## 10. Decision

**ADOPT** : Fastlane local macOS (MVP) with documented migration path to Fastlane + Forgejo Actions self-hosted runner.

**RUNNER-UP** : Fastlane + Jenkins self-hosted, retained as alternative if the developer already operates Jenkins.

**REJECTED** : Manual IDE-only upload (unsustainable); GitHub Actions free tier (O1 veto — free-tier SaaS dependency); Codemagic, Bitrise, Xcode Cloud (O1 veto — paid or Apple SaaS beyond platform-mandatory scope); ad-hoc shell scripts (no provenance).

**Traceability** : `verification/picoc/mobile-game-picoc-batch-D.md` §D17 + this form (canonical §2.4 Kitchenham + G-1 + #3 + MG-6).
