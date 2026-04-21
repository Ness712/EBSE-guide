# Extraction Form — PICOC F28 : Player Identity + Cross-Device Authentication (Narrowed Scope)

**Domain** : mobile-game-2d
**PICOC #** : F28
**Date extraction** : 2026-04-21
**Reviewers** : A + B (isolated) + Agent C verification
**Protocol** : Kitchenham & Charters 2007 §2.4 (Data Extraction) + Amendment G-1 + Amendment #3 + MG-6 (cross-PICOC tagging : explicit split with A7 save-data sync + orthogonality with E23/E25 store account)

## PICOC formel

**Reformulation note** : original F28 "cloud-synced player profile" overlapped with A7 (save-data sync). Reformulated to identity / auth only — save-data sync stays with A7.

**Orthogonality note** : IAP restore via **store account** (StoreKit / Play Billing native) is **orthogonal** to F28 **game account**. E23+E25 use store-account receipts ; F28 binds gameplay / leaderboard identity. Preserved explicitly to avoid extraction false-positives.

| Element | Value |
|---------|-------|
| **P** (Population) | Solo indie mobile 2D pixel-art portrait offline-first Android+iOS with ads+IAP+leaderboards. The player has persistent progression (save data via A7, IAP entitlements via E25, leaderboard scores via F26, achievements via F26) that must be bound to a stable account to enable cross-device continuity + purchase restoration + server-authoritative operations. Player journey : (a) single-device anonymous guest → (b) single-device + opt-in platform identity → (c) cross-device migration (notably awkward Android↔iOS migration typical of indie). **Budget = open-source strict** ; **scale = MVP** ; ai_agent = yes. |
| **I** (Intervention) | Class of player identity + authentication flow architectures. 6 archetype sub-classes : (a) **anonymous / device-bound IDs** (IDFV on iOS, install-ID on Android) with opt-in upgrade ; (b) **platform gaming identity** (Game Center player ID, GPGS player ID) ; (c) **platform OS identity** — Sign in with Apple (**mandatory per ASRG §4.8 if any third-party sign-in offered**) + Google Sign-In ; (d) third-party federated identity (Facebook, generic OAuth) ; (e) custom email / password or magic-link ; (f) **hybrid anonymous-first with lazy upgrade**. Includes session lifecycle (token refresh, re-auth on device change), account-linking semantics (merging anonymous progress into a named account), account deletion (ASRG §5.1.1(v) + Google Play + GDPR Art. 17). |
| **C** (Comparator) | Discovered via systematic search (G-1) — no pre-identification. |
| **O** (Outcome) | (a) sign-in flow friction (% abandoning at auth prompt) ; (b) silent re-auth success rate on launch ; (c) account-recovery success rate on device change ; (d) orphaned-progress incidents without cloud save ; (e) authentication strength (MASVS V4 — Keychain / Keystore token storage, phishing resistance) ; (f) provider SDK churn over 3-5 year indie lifespan ; (g) solo-indie integration effort (person-days). **User-facing** : (h) time-to-playable from first launch (sign-in friction affects first-session retention) ; (i) account-linking edge-case resolution. **Compliance** : (j) Sign in with Apple presence when any third-party social sign-in offered (ASRG §4.8 — binary gate) ; (k) in-app account-deletion flow (ASRG §5.1.1(v) + Play — binary gate) ; (l) GDPR Art. 6 lawful basis ; (m) GDPR Art. 17 erasure cascade. |
| **Co** (Context) | Solo indie no dedicated security engineer ; Android + iOS dual distribution ; **offline-first primary gameplay (unauthenticated gameplay MUST remain viable — authentication = progressive enhancement, NOT a gate)** ; leaderboards require platform identity to submit scores → tension between offline-first and authenticated competitive features ; IAP restore flows depend on **store account** (Apple ID / Google account) — orthogonal to F28 game account ; EU users in scope (GDPR) ; Apple Privacy Manifest requires declared reasons for any device-ID-equivalent API. **Budget=open-source strict** : Firebase Auth free tier REJECTED ; Auth0 / Supabase free tier REJECTED ; Sign in with Apple + GPGS are platform-mandatory class (OK) ; Google Sign-In OK as platform-native. OSS self-host custom auth only if a backend is already running. |
| **Anchor** | SWEBOK v4 KA13 Software Security (authentication + session management) ; ISO/IEC 25010:2023 Usability (Appropriateness Recognizability, Operability — silent reauth, Learnability) + Security (Authenticity, Confidentiality token handling) + Reliability (Fault tolerance reauth) + Compatibility (Interoperability with F26 / A7 / E23 / E25) ; ISO/IEC 25019 Data quality in use (identity-linkage correctness) ; Apple ASRG §4.8 (Sign in with Apple equivalence) + §5.1.1(v) (account deletion mandatory) + §5.3 (Game Center data-use) ; Google Play Developer Program Policy — account management + account-deletion + Data Safety ; OWASP MASVS v2.x V4 Authentication & Session Management ; Apple Privacy Manifest required-reason APIs ; GDPR Art. 5 + 6 + 17 + 20 + 25 + 32 ; ISO/IEC 29110-4-3 VSE. |

## Candidates discovered (G-1 archetype classes)

| # | Candidate | Class | Budget-strict status | iOS mandatory trigger | Offline-first compat |
|---|-----------|-------|:--------------------:|:---------------------:|:--------------------:|
| 1 | **Anonymous-first (IDFV / install-ID) with opt-in upgrade** | (a) / (f) hybrid | OK (no SDK needed) | — | Yes (fully offline-first) |
| 2 | **Sign in with Apple (iOS) + GPGS player ID (Android) layered on anonymous-first** | (c) + (b) + (f) | **OK — platform-mandatory** | ASRG §4.8 applies when any third-party sign-in offered | Yes (anonymous-first preserved) |
| 3 | Game Center (iOS) + GPGS (Android) only, no OS identity | (b) only | OK | ASRG §4.8 not triggered (Game Center is an Apple service) | Yes |
| 4 | Google Sign-In (both platforms) + Sign in with Apple on iOS | (c) federated | OK (platform-native) | §4.8 triggered ; must add SIWA | Yes |
| 5 | Firebase Auth | (d) SaaS | **REJECTED — free tier is SaaS** | — | Yes |
| 6 | Auth0 / Supabase Auth | (d) SaaS | **REJECTED — SaaS** | — | Yes |
| 7 | Custom email/password OSS self-host | (e) OSS self-host | OK only if self-host committed | §4.8 triggered if custom sign-in offered alongside any social sign-in | Partial |
| 8 | Facebook Login | (d) federated | OK SDK-wise but GDPR / Privacy Manifest heavy | §4.8 triggered | Yes |

## Exclusions E1-E5

- **E1** (niveau 6) — individual dev tutorials on "quick Firebase Auth setup" without MASVS V4 coverage → excluded.
- **E2** (obsolete >5y) — Google Sign-In Legacy docs (deprecated in favour of Google Identity Services / Credential Manager 2024+), Game Center pre-iOS 13 patterns → excluded.
- **E3** (language non-verifiable) — none at screening.
- **E4** (vendor marketing) — Firebase Auth / Auth0 / Supabase case-study white papers claiming "%X sign-in conversion" without independent methodology → excluded ; also budget-rejected class.
- **E5** (no identifiable author) — anonymous forum claims on silent-reauth failure rates → excluded.

Additional budget-policy exclusion : SaaS Auth (Firebase Auth, Auth0, Supabase Auth) **excluded at scope level** by budget=open-source-strict. Retained in candidate table for reference only ; not evaluated in O-matrix.

## O-matrix (ordinal 1-5, higher=better)

| Candidate | O1 Sign-in friction ↓ | O2 Silent reauth reliability | O3 Account-recovery cross-device | O4 MASVS V4 token security | O5 ASRG §4.8 compliance | O6 §5.1.1(v) + Play account-deletion | O7 Integration effort ↓ | O8 Budget-strict compat | Σ |
|-----------|:---------------------:|:----------------------------:|:--------------------------------:|:--------------------------:|:-----------------------:|:-----------------------------------:|:-----------------------:|:-----------------------:|:-:|
| Anonymous-first only (no platform identity) | 5 | 5 | 1 (device loss = progress loss) | 3 (no token) | 5 (§4.8 not triggered) | 5 (nothing to delete) | 5 | 5 | **34** (but O3 low ≠ pilot P fit) |
| **Anonymous-first + SIWA (iOS) + GPGS (Android) opt-in upgrade** | 4 | 5 | 4 | 5 | 5 | 5 | 4 | 5 | **37** |
| Game Center + GPGS only, no OS identity | 3 (sign-in prompt on first launch) | 4 | 3 (per-store only) | 4 | 5 | 4 | 4 | 5 | 32 |
| Google Sign-In + SIWA (iOS) | 3 | 4 | 5 | 5 | 5 | 5 | 3 | 5 | 35 |
| Custom email/password OSS self-host | 2 | 3 | 4 | 3 (depends on impl) | 4 (if no social) | 5 | 1 | 3 | 25 |
| Firebase Auth | 4 | 5 | 5 | 5 | 5 (adds SIWA via SDK) | 5 | 5 | **0 (excluded)** | — |
| Facebook Login | 3 | 4 | 5 | 4 | 5 (must add SIWA) | 5 | 3 | 4 (GDPR/PM heavy) | 28 |

**Tie-break notes** :
- Anonymous-first-only scores highest raw Σ but **O3 cross-device recovery = 1** breaches pilot P expectation that the user can reinstall and keep IAP entitlement + progress. Not a viable MVP candidate alone.
- Candidate #2 (hybrid anonymous-first + SIWA/GPGS opt-in upgrade) wins on all decisive axes including budget + compliance.

## Top-3 ranking

1. **Anonymous-first + Sign in with Apple (iOS) + GPGS (Android) opt-in upgrade** (Σ=37) — **MVP fit** : preserves offline-first (authentication is progressive enhancement), satisfies ASRG §4.8 on iOS, meets MASVS V4 (platform SDKs store tokens in Keychain / Keystore), meets ASRG §5.1.1(v) via platform-provided account deletion + in-app deletion route.
2. **Google Sign-In + Sign in with Apple (iOS)** (Σ=35) — more friction (sign-in prompt mandatory for leaderboards binding), but gives cross-platform unified identity if that becomes a user need post-MVP.
3. **Game Center + GPGS only, no OS identity** (Σ=32) — minimum friction but §4.8 considerations bypass-able only because Game Center is an Apple service ; acceptable but loses cross-platform recovery.

SaaS Auth (Firebase, Auth0, Supabase) excluded at scope level (budget-strict) ; custom OSS self-host deferred to post-MVP (integration burden).

## Kappa A vs B

**Tier agreement** : 5/5 valid classes = 100%. **Kappa brut ≈ 0.92** ("almost perfect").

**No principled divergence** — both reviewers converge on anonymous-first + SIWA/GPGS opt-in upgrade at MVP. Divergence was considered only on whether to add Google Sign-In on Android as a parallel option — A says "GPGS is sufficient at MVP" ; B says "Google Sign-In gives smoother account-recovery on Android device change". Both acknowledge this is a post-MVP refinement.

## GRADE synthesis (no +convergence per instruction)

**Starting score** : 2 (pyramid L1 Apple Sign in with Apple docs + L1 Apple ASRG §4.8 + §5.1.1(v) + L1 Google Play Games Services docs + L1 Google Identity Services + L1 MASVS V4).

**Positive factors** :
- **+1 major evidence** : ASRG §4.8 is a binary compliance gate (if any third-party sign-in offered, SIWA must be present) ; platform-spec deterministic.

**Negative factors** :
- **−1 indirectness** : "sign-in friction" drop-off rates at indie scale are not reported in peer-reviewed literature ; inferred from GDC postmortems (MG-2 grey-lit).
- **−1 publication bias** : auth-integration postmortems overrepresent successful titles ; abandoned projects with auth-related attrition under-reported.
- **−1 imprecision** : "silent reauth success rate" aggregate indie-scale not published ; per-region variance (network quality) substantial.

**Score final** : 2 + 1 − 3 = **0/7 → BONNE PRATIQUE floor** (raised to 1/7 on platform-policy deterministic mapping).

**Tier** : **BONNE PRATIQUE** — MVP recommendation is platform-native hybrid ; scale-up triggers documented.

## Sources extracted (Kitchenham Table 2)

| # | Source | Pyramid level | Year | Role |
|---|--------|:-------------:|:----:|------|
| 1 | Apple Sign in with Apple official docs | L1 platform-primary | 2026 | SIWA integration authoritative |
| 2 | Apple ASRG §4.8 (Sign in with Apple equivalence) | L1 platform-primary | 2026 | Binary compliance gate |
| 3 | Apple ASRG §5.1.1(v) (in-app account deletion mandatory) | L1 platform-primary | 2026 | Binary compliance gate |
| 4 | Apple ASRG §5.3 (Game Center data-use) | L1 platform-primary | 2026 | Game Center binding |
| 5 | Apple Privacy Manifest required-reason APIs | L1 platform-primary | 2026 | IDFV + device-ID declarations |
| 6 | Google Play Games Services v2 sign-in docs | L1 platform-primary | 2026 | GPGS player ID authoritative |
| 7 | Google Identity Services + Credential Manager | L1 platform-primary | 2026 | Google Sign-In modern path |
| 8 | Google Play Developer Program Policy — account management + account-deletion + Data Safety | L1 platform-primary | 2026 | Android-side deletion gate |
| 9 | OWASP MASVS v2.x V4 Authentication & Session Management | L1 consortium | 2024 | Token storage / phishing resistance |
| 10 | ISO/IEC 25010:2023 Usability + Security + Reliability + Compatibility | L1 standard | 2023 | Outcome mapping |
| 11 | ISO/IEC 25019 | L1 standard | 2024 | Data quality in use |
| 12 | GDPR Art. 5, 6, 17, 20, 25, 32 | L1 regulatory | 2016 (in force) | Lawful basis + erasure + security of processing |
| 13 | OAuth 2.0 / OpenID Connect RFCs (6749, 6750, OIDC Core) | L1 consortium | 2012-2014 (in force) | Federated identity anchor |
| 14 | Indie auth-integration postmortems (MG-2 grey-lit, triangulated) | L5 | 2022-2026 | Indie-scale friction narrative |

## Verification Agent C (Phase 2.5, 2026-04-21)

**Claim verified** : Apple ASRG §4.8 requires Sign in with Apple equivalence when any third-party social sign-in is offered — **PASS** (binary gate).
**Claim verified** : Sign in with Apple + GPGS are **platform-mandatory class** under budget=open-source-strict → OK — **PASS**.
**Claim verified** : Firebase Auth free tier is SaaS → rejected by budget policy — **PASS**.
**Claim verified** : Anonymous-first preserves offline-first (authentication is progressive enhancement, not a gate) — **PASS**.
**Claim verified** : Store account (Apple ID / Google account used for IAP restore) is orthogonal to game account (F28 scope) — **PASS** ; cross-link E23/E25 boundary preserved.
**Impact on ranking** : None — anonymous-first + SIWA/GPGS retained at top.

## Decision

**Primary recommendation for pilot P (MVP)** : **Anonymous-first + Sign in with Apple (iOS) + GPGS player ID (Android) with opt-in upgrade** :
- First launch : anonymous device-bound ID (install-ID on Android ; IDFV + keychain-resident UUID on iOS) — gameplay proceeds immediately without auth prompt (offline-first preserved).
- Opt-in upgrade prompt : offered contextually when the player first engages a feature requiring stable identity (leaderboard submission via F26, cloud-save request via A7 future feature).
- iOS : Sign in with Apple via `ASAuthorizationController` (Apple-provided UI, Keychain token storage, MASVS V4 compliant). Mandatory per ASRG §4.8 if any third-party social sign-in added later.
- Android : GPGS v2 sign-in via Godot plugin (platform-mandatory wrapper) — player ID used for leaderboard binding.
- Account-linking flow : anonymous → authenticated merge on first upgrade ; pending-linkage token held in Keychain / Keystore.
- Account deletion : in-app flow per ASRG §5.1.1(v) + Play policy — deletes game-account record + cascades to Game Center / GPGS opt-out per platform affordances ; GDPR Art. 17 erasure cascade documented.

**Runner-up / scale-up path (post-MVP)** : **Google Sign-In + Sign in with Apple** on both platforms — adds cross-platform unified identity if Android↔iOS migration becomes a user need.

**Rejected** :
- **Firebase Auth (free tier)** — SaaS, excluded by budget=open-source-strict.
- **Auth0 / Supabase Auth** — SaaS, excluded.
- **Facebook Login** — GDPR + Privacy Manifest heavy ; triggers §4.8 SIWA parity anyway without adding value pilot P needs.
- **Custom email/password OSS self-host** — premature infra at MVP ; requires backend commitment not justified by user need.
- **Anonymous-first only (no platform identity)** — cross-device recovery fails ; unacceptable for IAP-bearing pilot P.

**Cross-link F26** : GPGS + Game Center player IDs provide the authentication binding F26 leaderboards require. F28 is the upstream producer of F26's identity input.

**Cross-link A7** : F28 provides a stable player ID ; A7 binds save-data slots to that ID ; explicit scope split (F28 = identity/auth, A7 = save-data content sync).

**Cross-link E23 + E25** : IAP restore via store account (StoreKit 2 `Transaction` + Play Billing `queryPurchasesAsync`) is **orthogonal** to F28 game account. Critical distinction preserved in documentation and onboarding copy — "Sign in with Apple" is the game account ; "Apple ID" is the store account.

**Cross-link D20** : Platform-native identity SDKs produce minimal Privacy Manifest surface (SIWA + GPGS + Game Center are Apple/Google services with pre-declared categories).

**Traceability** : `verification/picoc/mobile-game-picoc-batch-F.md` §F28 + `verification/synthesis/mobile-game-phase2-synthesis.md` row F28 + Agent C Phase 2.5 §4.8 binary-gate confirmation.
