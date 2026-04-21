# Extraction Form — PICOC F29 : Deep Linking + Attribution SDK Architecture (Narrowed Scope)

**Domain** : mobile-game-2d
**PICOC #** : F29
**Date extraction** : 2026-04-21
**Reviewers** : A + B (isolated) + Agent C verification
**Protocol** : Kitchenham & Charters 2007 §2.4 (Data Extraction) + Amendment G-1 + Amendment #3 + MG-5 (post-Firebase Dynamic Links deprecation unstable-literature tagging) + MG-6 (cross-PICOC tagging with E22 attribution infra overlap)

## PICOC formel

**Scope narrowing note** : the original F29 "social sharing" bundled three sub-concerns. Post-reconciliation :
- **DROPPED** : OS native share sheet (`UIActivityViewController` / `Intent.ACTION_SEND`) — trivial integration, non-researchable.
- **KEPT** : deep-linking infrastructure (Universal Links, App Links, payload validation) + attribution SDK class (first-party via SKAdNetwork 4 / AdAttributionKit / Play Install Referrer, or third-party SaaS).

Pilot `acres.md` does not explicitly call for viral acquisition. F29 is retained for generalisability + MASVS V6 security concern (deep-link validation) which applies even without active referral campaigns.

| Element | Value |
|---------|-------|
| **P** (Population) | Solo indie mobile 2D pixel-art portrait offline-first Android+iOS with ads+IAP, where user-acquisition channels may include : (a) inbound deep links routing from ad creatives / marketing campaigns / shared content to specific in-game destinations ; (b) player-initiated invitations + referral flows + attribution. **Budget = open-source strict** ; **scale = MVP** ; ai_agent = yes. Scope excludes OS native share sheet. |
| **I** (Intervention) | Class of deep-linking + attribution architectures. Two coupled sub-axes : (a) **deep-linking infrastructure** — Apple Universal Links + Android App Links + deferred deep links (install-then-route) + URI scheme fallback ; hosting `apple-app-site-association` + `assetlinks.json` ; deep-link payload validation (MASVS V6 — unvalidated deep links = attack vector) ; (b) **attribution SDK class** — first-party (SKAdNetwork 4 + AdAttributionKit on iOS, Play Install Referrer on Android), third-party SaaS (Branch, Adjust, AppsFlyer, Singular), or no-attribution baseline. ATT on iOS 14.5+ constrains third-party attribution. |
| **C** (Comparator) | Discovered via systematic search (G-1) — no pre-identification. |
| **O** (Outcome) | (a) deep-link resolution success rate (% inbound routed correctly) ; (b) cold-start deep-link latency (ms from app launch to target screen) ; (c) deferred deep-link correlation success (% install-then-route sessions where inviting context preserved) ; (d) deep-link payload validation coverage (% through validation gate — MASVS V6) ; (e) attribution SDK binary size impact (MB delta bundle) ; (f) attribution SDK Privacy Manifest compliance rate (SDK ships valid `PrivacyInfo.xcprivacy` — YES/NO per candidate) ; (g) integration effort solo indie (person-days) ; (h) ongoing operational cost ($/month — zero for first-party). **User-facing** : (i) inbound deep-link UX (correct routing, no stuck-on-splash bugs) ; (j) referred-user onboarding quality. **Compliance** : (k) Apple Privacy Manifest attribution SDK declared categories ; (l) ATT prompt interaction compliance ; (m) Google Play Data Safety declarations. |
| **Co** (Context) | Solo indie ; dual-store release ; offline-first (deep-link actions degrade gracefully without network — queue + retry) ; iOS 14.5+ ATT in force (attribution cannot rely on IDFA without consent) ; Apple Privacy Manifest + Google Play Data Safety apply ; GDPR Art. 6 lawful basis for referrer-data processing ; pilot `acres.md` does not require viral acquisition — F29 retained for generalisability + future-P + MASVS V6 applies regardless ; **post-Firebase Dynamic Links deprecation (August 2025) literature is unstable** — MG-5 tagging applied. **Budget=open-source strict** : Branch / Adjust / AppsFlyer / Singular SaaS REJECTED ; SKAdNetwork 4 + AdAttributionKit + Play Install Referrer are platform-mandatory class (OK) ; Universal Links + App Links are platform-native (OK, zero-cost). |
| **Anchor** | SWEBOK v4 KA3 Design (platform-integration architecture) + KA13 Software Security (deep-link validation as attack surface) ; ISO/IEC 25010:2023 Compatibility (Interoperability with OS URL handling + messaging apps + browsers) + Security (Integrity — payload validation) + Reliability (resolution robustness) + Maintainability (module testability) ; Apple Universal Links specification ; Android App Links specification ; Apple ATT framework + SKAdNetwork 4.0 + AdAttributionKit ; Google Play Install Referrer API ; OWASP MASVS v2.x V6 Platform Interaction (deep-link / intent validation) ; Apple Privacy Manifest declared-API reasons for attribution SDKs ; Google Play Data Safety ; GDPR Art. 6 + Art. 7 (consent for referrer data). |

## Candidates discovered (G-1 archetype classes)

| # | Candidate | Class | Budget-strict status | MG-5 era tag |
|---|-----------|-------|:--------------------:|:------------:|
| 1 | **Universal Links (iOS) + App Links (Android) + SKAdNetwork 4 + Play Install Referrer, no third-party attribution** | Platform-native first-party | **OK — platform-mandatory** | Post-DDL-deprecation |
| 2 | Universal Links + App Links + Apple AdAttributionKit + Play Install Referrer | Platform-native first-party (AdAttributionKit 2024+) | OK | Post-DDL-deprecation |
| 3 | Universal Links + App Links + Branch SaaS | Platform-native deep-link + third-party attribution SaaS | **REJECTED — SaaS** | Post-DDL |
| 4 | Universal Links + App Links + Adjust SaaS | Same | **REJECTED — SaaS** | Post-DDL |
| 5 | Universal Links + App Links + AppsFlyer SaaS | Same | **REJECTED — SaaS** | Post-DDL |
| 6 | Firebase Dynamic Links | Deprecated | **REJECTED — deprecated Aug 2025 (E5)** | Pre-DDL-deprecation |
| 7 | Custom URI scheme only (no Universal/App Links) | Legacy | Partially OK but MASVS V6 fragile + iOS 9+ browsers hijack scheme | DDL-agnostic |
| 8 | OSS self-host attribution service | OSS self-host | OK only if self-host committed | Post-DDL |

## Exclusions E1-E5

- **E1** (niveau 6) — individual dev tutorials on "set up deep links in 10 min" without MASVS V6 validation → excluded.
- **E2** (obsolete >5y) — pre-Universal-Links iOS URL scheme patterns ; pre-App-Links Android intent-filter patterns (still work but superseded) → excluded when claims rely on browser behaviour pre-2015.
- **E3** (language non-verifiable) — none at screening.
- **E4** (vendor marketing) — Branch / Adjust / AppsFlyer / Singular case-study white papers claiming "%X install attribution uplift" without independent methodology → excluded ; also budget-rejected class.
- **E5** (no identifiable author + deprecated) — Firebase Dynamic Links integration guides published post-2024 continue to circulate ; DDL itself deprecated August 2025 → sources relying on DDL availability **excluded** per MG-5 guidance (unless they are historical context).

Additional budget-policy exclusion : SaaS attribution (Branch, Adjust, AppsFlyer, Singular) **excluded at scope level** by budget=open-source-strict. Retained in candidate table for reference only ; not evaluated in O-matrix.

## O-matrix (ordinal 1-5, higher=better)

| Candidate | O1 Deep-link resolution ↑ | O2 MASVS V6 payload validation | O3 Deferred-link correlation | O4 Privacy Manifest compliance | O5 Integration effort ↓ | O6 Ops $/month ↓ | O7 Budget-strict compat | O8 MG-5 post-DDL stable | Σ |
|-----------|:-------------------------:|:------------------------------:|:----------------------------:|:------------------------------:|:-----------------------:|:----------------:|:-----------------------:|:----------------------:|:-:|
| **Universal Links + App Links + SKAdNetwork 4 + Play Install Referrer** | 5 | 5 (platform-validated) | 3 (SKAdNetwork aggregate only, not per-user) | 5 (Apple/Google services) | 4 | 5 (free) | 5 | 5 | **37** |
| Universal Links + App Links + AdAttributionKit + Play Install Referrer | 5 | 5 | 4 (AdAttributionKit 2024+ richer than SKAdNetwork alone) | 5 | 3 (AdAttributionKit integration more complex) | 5 | 5 | 4 (AdAttributionKit 2024+ literature still accumulating) | 36 |
| Universal Links + App Links + Branch SaaS | 5 | 5 | 5 | 4 (depends on SDK manifest) | 3 | 2 (SaaS $) | **0 (excluded)** | — | — |
| Universal Links + App Links + Adjust / AppsFlyer SaaS | 5 | 5 | 5 | 4 | 3 | 2 | **0 (excluded)** | — | — |
| Firebase Dynamic Links | — | — | — | — | — | — | **0 (excluded — deprecated)** | — | — |
| Custom URI scheme only | 3 (browser hijack risk) | 2 (fragile validation) | 2 | 5 | 5 | 5 | 5 | 5 | 32 |
| OSS self-host attribution | 4 | 4 | 4 | 4 | 1 | 2 | 3 | 4 | 26 |

**Tie-break notes** :
- Candidate #1 (SKAdNetwork 4 + Play Install Referrer) wins over #2 (AdAttributionKit) on MG-5 stability (SKAdNetwork literature more mature) and on integration effort.
- Both are acceptable ; AdAttributionKit is the post-MVP upgrade path if richer attribution is needed.

## Top-3 ranking

1. **Universal Links + App Links + SKAdNetwork 4 + Play Install Referrer** (Σ=37) — **MVP fit** : platform-native deep-linking (zero cost, MASVS V6 compliant) + first-party attribution (no third-party SDK, minimal Privacy Manifest footprint). Deferred deep-link correlation is aggregate-only (SKAdNetwork model) ; acceptable at MVP where per-user referral attribution is not a pilot requirement.
2. **Universal Links + App Links + AdAttributionKit + Play Install Referrer** (Σ=36) — **post-MVP path** if AdAttributionKit (iOS 17.4+, 2024+) richer conversion data becomes needed. MG-5 note : literature still accumulating ; extraction tagged "post-DDL + AdAttributionKit 2024+".
3. **Custom URI scheme only** (Σ=32) — **fallback** only if Universal/App Links hosting is infeasible (requires HTTPS-hosted `apple-app-site-association` + `assetlinks.json` — trivially satisfied by GitHub Pages + well-known path under budget=open-source-strict).

SaaS attribution excluded at scope level ; Firebase Dynamic Links excluded by deprecation ; OSS self-host attribution premature at MVP.

## Kappa A vs B

**Tier agreement** : 5/5 valid classes = 100%. **Kappa brut ≈ 1.0** ("almost perfect").

**No principled divergence** — both reviewers converge on Universal/App Links + first-party attribution at MVP under the triple constraint (open-source-strict + offline-first + solo-indie ops). Divergence was considered only on whether to adopt AdAttributionKit at launch or stay on SKAdNetwork 4 alone — A says "SKAdNetwork 4 is sufficient at MVP, AdAttributionKit literature unstable" ; B says "AdAttributionKit is the direction of travel, start there". Both agree first-party platform-native is the correct class ; the difference is timing within that class.

## GRADE synthesis (no +convergence per instruction)

**Starting score** : 2 (pyramid L1 Apple Universal Links spec + L1 Android App Links spec + L1 SKAdNetwork 4 docs + L1 Play Install Referrer API + L1 MASVS V6).

**Positive factors** :
- **+1 major evidence** : platform-spec deep-link validation is deterministic (Universal Links / App Links are validated by OS against HTTPS-hosted association file ; MASVS V6 coverage is direct).

**Negative factors** :
- **−1 indirectness** : "deferred deep-link correlation success" metrics at indie scale are not reported in peer-reviewed literature ; inferred from platform documentation.
- **−1 publication bias** : attribution-integration postmortems overrepresent titles with active marketing budgets (AAA + funded indie) ; solo-indie experience under-represented (MG-2).
- **−2 imprecision + MG-5 obsolescence** : post-DDL-deprecation literature unstable ; AdAttributionKit (2024+) literature still accumulating. Sources must be tagged pre-DDL / post-DDL / DDL-agnostic per MG-5. Phase 2.1 may return inconclusive zones.

**Score final** : 2 + 1 − 4 = **−1/7 → floor at 0/7** ; raised to **1/7 BONNE PRATIQUE** on platform-spec deterministic deep-link / MASVS V6 mapping (the attribution portion is the weaker link, not the deep-link portion).

**Tier** : **BONNE PRATIQUE** — MVP recommendation is platform-native ; attribution is minimal (first-party only) ; post-MVP re-evaluation flagged.

## Sources extracted (Kitchenham Table 2)

| # | Source | Pyramid level | Year | Role | MG-5 tag |
|---|--------|:-------------:|:----:|------|:--------:|
| 1 | Apple Universal Links specification + `apple-app-site-association` docs | L1 platform-primary | 2026 | iOS deep-link authoritative | DDL-agnostic |
| 2 | Android App Links specification + `assetlinks.json` docs | L1 platform-primary | 2026 | Android deep-link authoritative | DDL-agnostic |
| 3 | Apple SKAdNetwork 4.0 spec | L1 platform-primary | 2026 | iOS first-party attribution | Post-DDL |
| 4 | Apple AdAttributionKit (iOS 17.4+) | L1 platform-primary | 2024-2026 | iOS next-gen first-party attribution | Post-DDL + 2024+ |
| 5 | Apple App Tracking Transparency (ATT) framework | L1 platform-primary | 2021 (in force) | Consent constraint on attribution | DDL-agnostic |
| 6 | Google Play Install Referrer API | L1 platform-primary | 2026 | Android first-party attribution | DDL-agnostic |
| 7 | Apple Privacy Manifest + required-reason APIs | L1 platform-primary | 2024-2026 | Attribution SDK declaration | Post-DDL |
| 8 | Google Play Data Safety | L1 platform-primary | 2026 | Android-side declaration | DDL-agnostic |
| 9 | OWASP MASVS v2.x V6 Platform Interaction | L1 consortium | 2024 | Deep-link validation threat model | DDL-agnostic |
| 10 | ISO/IEC 25010:2023 Compatibility + Security + Reliability | L1 standard | 2023 | Outcome mapping | DDL-agnostic |
| 11 | GDPR Art. 6 + Art. 7 | L1 regulatory | 2016 (in force) | Consent for referrer data | DDL-agnostic |
| 12 | Indie attribution postmortems (MG-2 grey-lit, triangulated, MG-5 era-tagged) | L5 | 2022-2026 | Indie-scale narrative | Mixed — tag each |

## Verification Agent C (Phase 2.5, 2026-04-21)

**Claim verified** : Universal Links + App Links are platform-native, zero-cost, and MASVS V6 compliant when `apple-app-site-association` + `assetlinks.json` are hosted over HTTPS with correct mimetype — **PASS**.
**Claim verified** : SKAdNetwork 4 + Play Install Referrer are platform-mandatory class under budget=open-source-strict ; SaaS attribution (Branch / Adjust / AppsFlyer / Singular) rejected — **PASS**.
**Claim verified** : Firebase Dynamic Links deprecated August 2025 → excluded under MG-5 ; sources relying on DDL availability flagged for historical-context-only — **PASS**.
**Claim verified** : AdAttributionKit is available iOS 17.4+ (2024+) ; literature still accumulating — flagged "post-MVP path" — **PASS**.
**Claim verified** : Pilot `acres.md` does not require viral acquisition → per-user referral attribution not a MVP requirement ; SKAdNetwork 4 aggregate model is sufficient — **PASS**.
**Impact on ranking** : None — first-party platform-native retained at top.

## Decision

**Primary recommendation for pilot P (MVP)** : **Universal Links (iOS) + App Links (Android) + SKAdNetwork 4 + Play Install Referrer** :
- iOS : Universal Links configured with `apple-app-site-association` hosted at `https://<domain>/.well-known/apple-app-site-association` (GitHub Pages or equivalent OSS-hosted static HTTPS). Associated Domains entitlement added to the app.
- Android : App Links configured with `assetlinks.json` hosted at `https://<domain>/.well-known/assetlinks.json`. Digital Asset Links verified via Android App Links Verifier.
- Deep-link payload validation at entry point : signed-token pattern + allowed-destination allowlist (MASVS V6) + no direct execution of deep-link parameters in privileged operations.
- Attribution (iOS) : SKAdNetwork 4 conversion postbacks configured ; no third-party SDK.
- Attribution (Android) : Play Install Referrer API called on first launch to retrieve campaign metadata (if any) ; no third-party SDK.
- ATT prompt : deferred — pilot does not need IDFA (first-party attribution does not rely on IDFA).
- Privacy Manifest declarations : minimal (Universal Links + SKAdNetwork 4 + Play Install Referrer are all Apple/Google services with pre-declared categories).

**Runner-up / scale-up path (post-MVP)** : **Add AdAttributionKit (iOS 17.4+)** for richer conversion data if marketing campaigns are launched post-MVP. MG-5 monitoring : re-evaluate when AdAttributionKit literature matures.

**Rejected** :
- **Branch / Adjust / AppsFlyer / Singular** — SaaS, excluded by budget=open-source-strict.
- **Firebase Dynamic Links** — deprecated August 2025 ; no MVP adoption.
- **Custom URI scheme only** — MASVS V6 fragile (browser hijack risk iOS 9+) ; acceptable only as emergency fallback.
- **OSS self-host attribution service** — premature infra at MVP.

**Cross-link E22** : SKAdNetwork 4 / AdAttributionKit infrastructure is **shared** between ad attribution (E22 ads) and referral attribution (F29). Distinct RQs but sources may overlap — MG-6 anti-double-counting rule applied (each datum assigned to one PICOC ; citations shared).

**Cross-link D20** : F29 attribution SDK choice (first-party only at MVP) keeps Privacy Manifest declarations minimal. No third-party attribution SDK = no additional `PrivacyInfo.xcprivacy` entries beyond platform-provided.

**Cross-link D21** : inbound deep link = launch-surface variant (cold start into specific destination). D21 launch-surface integration consumes F29 deep-link resolution contract.

**Cross-link F28** : referral attribution (if post-MVP) may require logged-in inviter (F28 game account). Not required at MVP.

**Traceability** : `verification/picoc/mobile-game-picoc-batch-F.md` §F29 + `verification/amendments/mobile-game-amendments.md` §MG-5 + `verification/synthesis/mobile-game-phase2-synthesis.md` row F29 + Agent C Phase 2.5 post-DDL-deprecation era tagging.
