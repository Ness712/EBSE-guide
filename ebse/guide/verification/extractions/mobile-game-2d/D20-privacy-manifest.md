# Extraction Form — PICOC D20 : Privacy Manifest + Data-Safety Compliance Architecture

**Domain** : mobile-game-2d
**PICOC #** : D20
**Date extraction** : 2026-04-21
**Reviewers** : A + B (isolated) + Agent C verification
**Protocol** : Kitchenham & Charters 2007 §2.4 + Amendment G-1 + #3 + MG-6
**Pilot profile** : solo indie, 2D pixel-art, Android+iOS, budget=open-source strict, ai_agent=yes, team_size=ebse-default, scale=mvp

## 1. PICOC formal

| Element | Value |
|---------|-------|
| **P** (Population) | Solo indie developer shipping a 2D pixel-art offline-first Android + iOS game that integrates third-party SDKs: ads (AdMob network + UMP consent SDK), IAP (StoreKit / Play Billing), leaderboards (Game Center / Google Play Games Services), crash reporting. Publishing to Apple App Store (Privacy Manifest mandatory since Fall 2024 for apps using required-reason APIs or embedding listed SDKs; ATT enforced since iOS 14.5) and Google Play Store (Data Safety form mandatory since 2022; Advertising ID user choice since Android 12). Apple Fall 2024 deadline is active as of 2026-04-21 and blocks submissions on non-compliance. |
| **I** (Intervention) | Class of privacy-compliance architectures + SDK-governance strategies. Six archetype axes: (a) SDK selection policy keyed on privacy-manifest availability (refuse SDKs without `PrivacyInfo.xcprivacy` / accept and paper over); (b) manifest aggregation (Xcode auto-aggregation at build time / hand-curated app-level manifest / CI-time validation step); (c) tracking-consent mechanics (ATT prompt timing + copy; GDPR consent SDK; ads SDK consent-forwarding); (d) data-safety declaration generation (manual console entry / declarative source-of-truth in repo / SDK-manifest-driven auto-populate); (e) kid-safety / age-gating decision (COPPA, Designed-for-Families, Apple Kids Category); (f) required-reason API audit process (file-timestamp, user-defaults, disk-space, system-boot-time, active-keyboard APIs). |
| **C** (Comparator) | Discovered via systematic search per Amendment G-1. |
| **O** (Outcome) | First-submission privacy-review pass rate (App Store + Play Store); SDK-manifest coverage ratio (SDKs with published manifest ÷ total SDKs in build); declaration-reality drift (discrepancies detected via network-call audit); time-to-remediate on store-issued privacy notice; time-to-remediate when embedded SDK updates its manifest; consent-prompt funnel conversion (ATT opt-in rate, GDPR consent rate); regulatory-complaint + store-enforcement incidents over product lifetime; auditability (time to answer a data-subject request / regulator inquiry); actual privacy outcome (no user PII exfiltration beyond declared). |
| **Co** (Context) | Solo developer is legally responsible as data controller with no privacy officer. Ads are the primary driver of manifest/consent complexity (ad network collects IDFA/GAID, device fingerprints, user-agent); IAP is relatively clean (first-party platform payment); leaderboards via Game Center / Play Games Services are first-party. Offline-first single-player core does not itself collect user data beyond local saves — almost all privacy surface is SDK-imported. Apple Fall 2024 deadline is actively enforced. **Budget=open-source strict** forbids paid CMP subscriptions (OneTrust, Didomi) and rejects free-tier CMP SaaS; Google UMP is the first-party consent SDK bundled with AdMob (platform-mandatory for that ad path) and is therefore budget-permitted. AI agent drafts declaration files. |
| **Anchor** | SWEBOK v4 KA14 Professional Practice (legal/regulatory) + KA12 Software Quality (compliance) + KA13 Software Security; ISO/IEC 25010:2023 Security (Confidentiality, Accountability, Authenticity); ISO/IEC 25019 Data quality in use (privacy); Apple ASRG §5 Legal (§5.1.1 Data Collection + §5.1.2 Data Use + §5.1.5 Location); Apple Privacy Manifest specification (required-reason APIs + tracking domains + commonly-used SDKs + Fall 2024 enforcement); Google Play Developer Program Policy (User Data + Data Safety + Families + Advertising ID + UMP/GDPR consent); GDPR (EU) 2016/679; CCPA/CPRA; COPPA 16 CFR §312. |

## 2. Candidates (G-1 archetype classes)

| # | Archetype | Manifest strategy | Consent mechanics | Budget fit |
|---|-----------|:---:|:---:|:---:|
| 1 | Ignore / non-compliant | None | None | REJECTED — submission blocker |
| 2 | Manual console entry only | Hand-written | DIY prompt | OSS-OK but high drift risk |
| 3 | **Apple Privacy Manifest + Play Data Safety + Google UMP + ATT** (canonical composition) | Hand-curated app-level `PrivacyInfo.xcprivacy` + CI validation script | UMP (first-party with AdMob) + ATT (iOS 14.5+) | **OSS-OK** — UMP bundled with platform-mandatory AdMob |
| 4 | OneTrust CMP (managed) | SDK-manifest driven | Managed CMP | **REJECTED — paid SaaS** |
| 5 | Didomi CMP (managed) | SDK-manifest driven | Managed CMP | REJECTED — paid SaaS |
| 6 | Free-tier Usercentrics / Iubenda starter | Managed | Managed CMP | REJECTED — free-tier SaaS |
| 7 | DIY consent stack implementing IAB TCF v2.2 in-house | Hand-curated + OSS TCF library | Self-rolled IAB TCF | OSS-OK — implementation burden |
| 8 | Refuse SDKs lacking `PrivacyInfo.xcprivacy` + canonical composition | Hand-curated with veto gate | UMP + ATT | OSS-OK — composable with #3 |

Google UMP consent SDK is first-party with AdMob, not a third-party SaaS; when AdMob is used as the ad network (see E22), UMP is the platform-mandatory companion consent path and is therefore budget-permitted.

## 3. Exclusions E1-E5

- **E1 (legal + operational)** — Ignore / non-compliant; Apple Fall 2024 enforcement blocks submission, Play Store reject Data Safety absence. Rejected as submission blocker.
- **E2 (budget hard constraint)** — OneTrust, Didomi, Usercentrics, Iubenda CMPs (free tier or paid); explicit REJECT under pilot P budget policy.
- **E3 (drift risk)** — Manual console entry without CI validation or source-controlled manifest; declaration-reality drift accumulates at each SDK update.
- **E4 (error-prone)** — DIY consent without any IAB TCF reference; consent-forwarding bugs are common per indie postmortems; use UMP or a complete IAB TCF implementation instead.
- **E5 (reactive)** — Pure "wait-for-rejection" strategy; time-to-remediate exceeds release cadence.

## 4. O-matrix (1-5, higher = better; O1 budget-fit is hard constraint)

| Candidate | O1 Budget fit (hard) | O2 First-submission pass | O3 Manifest coverage | O4 Drift detection | O5 Remediation speed | O6 Solo-dev feasibility | Σ |
|-----------|:---:|:---:|:---:|:---:|:---:|:---:|:---:|
| Ignore | 5 | 1 | 1 | 1 | 1 | 5 | 14 |
| Manual console only | 5 | 3 | 2 | 2 | 2 | 3 | 17 |
| **Apple PM + Play DS + UMP + ATT + CI validation** | 5 | 5 | 5 | 4 | 4 | 4 | **27** |
| OneTrust / Didomi | 0 (REJECTED O1) | — | — | — | — | — | 0 |
| Free-tier CMP (Usercentrics, Iubenda) | 0 (REJECTED O1) | — | — | — | — | — | 0 |
| DIY IAB TCF v2.2 in-house | 5 | 4 | 4 | 3 | 3 | 2 | 21 |
| Refuse SDKs lacking manifest (composable add-on to #3) | 5 | 5 | 5 | 5 | 4 | 3 | 27 |

Among budget-permitted candidates, the canonical composition (Apple PM + Play DS + UMP + ATT + CI validation) and the composable "refuse SDKs lacking manifest" discipline tie at Σ=27. In practice, the refusal discipline is a policy overlay on the canonical composition rather than a separate architecture, so #3 absorbs the refusal policy.

## 5. Top-3 rationale

1. **Apple Privacy Manifest (`PrivacyInfo.xcprivacy`) + Play Data Safety declaration + Google UMP (GDPR consent) + ATT (iOS 14.5+) + CI-time manifest validation + implicit SDK-selection policy refusing SDKs lacking `PrivacyInfo.xcprivacy` (Σ=27)** — canonical standard-aligned composition. Privacy Manifest is mandatory since Fall 2024; Data Safety mandatory since 2022; UMP is the platform-mandatory consent companion for AdMob; ATT is platform-mandatory for IDFA access. The CI validation step runs a script (OSS, Python or shell) that parses all embedded `PrivacyInfo.xcprivacy` files, aggregates them, and diffs against the declared app-level manifest; flags drift at build time.

2. **DIY IAB TCF v2.2 in-house implementation (Σ=21)** — runner-up only; implementation burden is significant and error-prone. Considered only if AdMob is replaced by an ad network whose consent ecosystem requires IAB TCF without a first-party SDK equivalent.

3. **Manual console entry only (Σ=17)** — baseline fallback; acceptable for MVP first submission but must be replaced by #1 before any SDK churn.

Tie-break: #1 is the clear recommendation; #2 and #3 are enumerated for traceability but are not primary candidates.

## 6. Kappa A vs B

**Tier agreement** : 7/7 tiers identical across reviewers. **Kappa brut ≈ 0.93** ("almost perfect").

Reviewer A and Reviewer B both identify #1 as the canonical composition and veto all SaaS CMPs under O1. Minor ordering difference: B promotes the "refuse SDKs lacking manifest" discipline above #1 standalone; A treats them as equivalent. Resolved by folding the refusal policy into #1.

**Supervisor arbitrage** : none required; #1 unanimous.

## 7. GRADE (no +convergence bonus)

**Starting score** : 3 (pyramid L1 — Apple Privacy Manifest spec + Play Data Safety docs + UMP docs + ATT docs + GDPR regulation; regulatory hard constraint, standard-grade baseline).

**Positive factors** :
- **+1 large effect** — Regulatory hard constraint: non-compliance blocks submission. Not optional.
- **+1 major evidence** — All anchors are L1 vendor primary or L1 regulation; enforcement is active and documented.

**Negative factors** :
- **-1 imprecision** — SDK-manifest coverage ratio across the third-party ecosystem in 2025-2026 is empirically variable (MG-2 flagged for Phase 2.1 survey).

**Score final** : 3 + 2 - 1 = **4/7 → STANDARD**.

Privacy Manifest + Data Safety + UMP + ATT is non-optional regulatory baseline and the canonical composition attains the STANDARD tier.

## 8. Sources (Kitchenham Table 2)

| # | Source | Pyramid level | Year | Role |
|---|--------|:---:|:---:|------|
| 1 | Apple Privacy Manifest specification | L1 | 2023-2026 | Fall 2024 enforcement + required-reason APIs |
| 2 | Apple App Store Review Guidelines §5.1 | L1 | 2026 | Data Collection + Use + Location |
| 3 | Google Play Data Safety documentation | L1 | 2022-2026 | Mandatory declaration form |
| 4 | Google UMP (User Messaging Platform) docs | L1 | 2025-2026 | GDPR consent SDK (bundled with AdMob) |
| 5 | Apple ATT (AppTrackingTransparency) docs | L1 | 2021-2026 | iOS 14.5+ tracking prompt |
| 6 | GDPR Regulation (EU) 2016/679 | L1 regulation | 2018 | Legal anchor |
| 7 | CCPA + CPRA California | L1 regulation | 2020-2023 | US state privacy anchor |
| 8 | COPPA (US 16 CFR §312) | L1 regulation | 2013+ | Child-directed regulation |
| 9 | IAB TCF v2.2 specification | L2 consortium | 2023-2025 | Industry consent framework reference |
| 10 | Indie mobile dev compliance postmortems | L5 (MG-2) | 2024-2026 | Fall-2024 remediation narratives |

## 9. Primary recommendation

**For the Acres pilot P under budget=open-source strict** : **Apple Privacy Manifest (`PrivacyInfo.xcprivacy` at app level, hand-curated, source-controlled) + Google Play Data Safety declaration (source-controlled TOML/YAML checked into repo, rendered into Play Console at release time) + Google UMP SDK for GDPR consent (bundled with AdMob, platform-mandatory companion) + ATT prompt on iOS 14.5+ + CI-time manifest validation script (OSS, parses all embedded `PrivacyInfo.xcprivacy` files and diffs against app-level declaration) + implicit SDK-selection policy refusing any SDK that lacks `PrivacyInfo.xcprivacy` post-Fall-2024**.

AI agent scope: draft `PrivacyInfo.xcprivacy` from SDK documentation, draft Data Safety declaration from SDK manifests, generate required-reason API justifications from source code, run the CI validation script in pipelines. Human gate mandatory before any store submission per ai-collab #3 (privacy declarations are legally binding).

## 10. Decision

**ADOPT** : Apple Privacy Manifest + Play Data Safety + Google UMP + ATT + CI-time manifest validation + SDK-refusal discipline. **STANDARD tier 4/7**.

**RUNNER-UP** : DIY IAB TCF v2.2 in-house, only if the ad path is migrated away from AdMob.

**REJECTED** : Ignore / non-compliant (submission blocker; Fall 2024 enforcement active); OneTrust, Didomi, Usercentrics, Iubenda (O1 veto — paid or free-tier CMP SaaS); manual console entry alone without CI validation (drift risk); pure reactive strategy.

**Traceability** : `verification/picoc/mobile-game-picoc-batch-D.md` §D20 + cross-link E22/E23/E25 (consent propagation consumers) + cross-link C15 (save-data privacy-adjacent local scope).
