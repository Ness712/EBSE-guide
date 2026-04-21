# Phase 1.3 Batch F — PICOCs : Social / Platform Services (domaine `mobile-game-2d`)

**Protocole** : methodology.md v3.0 §1.3 + Amendement G-1 + Amendement #3
**Date** : 2026-04-21
**Methode** : double extraction + reconciliation
**Tracability** :
- Reviewer A : agent `a9ef90d812aef0737`
- Reviewer B : agent `a19c9d8a1a21abd26`

## Cadre upstream

23 PICOCs formulees : A1-A8, B7-B11, C12-C15, D17-D21, E22-E25.

**Ligne Batch F** : services sociaux et platforme (leaderboards, achievements, cross-device identity, social sharing).

## Reconciliation A vs B

| # initial | Decision | Verdict A | Verdict B | Accord | Reconciliation |
|-----------|----------|-----------|-----------|:------:|----------------|
| F26 | Leaderboards | RETAIN (merge F27) | RETAIN (merge F27) | V | RETAIN → F26 (merged) |
| F27 | Achievements | ABSORB F26 | ABSORB F26 | V | ABSORBED |
| F28 | Cross-device profile | RETAIN (narrowed → identity) | RETAIN (narrowed → identity) | V | RETAIN → F28 (identity/auth only ; save-data → A7) |
| F29 | Social sharing | RETAIN (bundle share+deep+attribution) | DROP (trivial + unstable lit) | X | RETAIN NARROWED : deep-link + attribution SDK (drop share sheet trivial) |

**Kappa brut** : 3/4 = 75% ("substantial", > 0.6 threshold).

**Arbitrage DIV-F29** :
- Position A (RETAIN bundled) : share + deep + attribution est un architectural bundle user-journey viral acquisition loop. MASVS V6 deep-link validation + Privacy Manifest attribution SDK sont vrais concerns.
- Position B (DROP) : OS share sheet (UIActivityViewController / Intent.ACTION_SEND) est trivial. Firebase Dynamic Links deprecated Aug 2025 → literature unstable. Pas de phenomene SE distinct suffisant pour un PICOC.

**Arbitrage superviseur** : **RETAIN F29 NARROWED**. Split :
- **KEEP** : deep link architecture (Universal Links, App Links, deep-link payload validation MASVS V6), attribution SDK class choice (Branch, Adjust, AppsFlyer, Apple AdAttributionKit, SKAdNetwork — discovered via Phase 2.1)
- **DROP** : OS share sheet invocation (trivial, non-researchable per B)
- **FLAG Phase 2.1** : post-Firebase DDL literature unstable — extraction may return inconclusive. Extraction template tag "Firebase DDL era / post-deprecation" sur chaque source.

**Rationale** : pilot P (farming sim offline-first solo indie) ne mentionne pas social sharing / viral acquisition dans acres.md. F29 retenu pour generalisability du domaine + cas future P ; mais scope reduit pour eviter trivialites.

**Final Batch F = 3 PICOCs** : F26 (unified leaderboards+achievements), F28 (identity/auth), F29 (deep-linking + attribution SDK).

## PICOCs retenus — Batch F final

### PICOC #F26 — Social gaming services backend (leaderboards + achievements unified)

| Element | Valeur |
|---------|--------|
| **P** | Dev indie solo ou petite equipe (≤5) mobile 2D pixel-art portrait offline-first distribues sur Google Play + Apple App Store, monetises via ads + IAP, featuring **score-ranked gameplay (leaderboards)** ET/OU **progression milestones (achievements)** visibles across player base, cross-platform codebase. Production context solo-indie (no dedicated backend engineer, no SRE) → strong preference pour managed BaaS vs self-hosted. |
| **I** | Classe des **architectures backend pour leaderboards + achievements**. Couvre : (a) choix backend (platform-native : Google Play Games Services v2 + Apple Game Center ; cross-platform BaaS : Nakama, Firebase, GameAnalytics leaderboards, Lootlocker ; self-hosted minimal VPS ; hybrid) ; (b) score-submission lifecycle (offline queue, idempotent submission keys, retry avec exponential backoff, dedup on server) ; (c) server-side anti-cheat heuristics (plausibility bounds, submission-rate throttling, statistical outlier flagging, shadow-banning — complementing client-side C15 HMAC/nonce controls) ; (d) achievement unlock semantics (incremental progress, hidden achievements, unlock-event idempotency cross offline-replay) ; (e) cross-platform leaderboard unification strategy (per-store isolated boards ↔ merged boards keyed by custom account layer — interacts with F28) ; (f) client-SDK integration pattern (direct vs service-abstraction layer). |
| **C** | À découvrir systématiquement en Phase 2.1 (recherche : Google Play Games Services v2 docs + Apple Game Center docs + cross-platform BaaS comparatives, indie postmortems leaderboard architecture, ACM/IEEE papers on mobile social services backends, MASVS V8 Resilience server-side sections). **Pre-identification prohibée per Amendement G-1.** |
| **O** | **Mesurables SE** : (a) integration effort (person-days solo indie) ; (b) score submission success rate under intermittent connectivity (% submissions completed correctly within 24h) ; (c) duplicate-suppression correctness (% duplicate submissions caught) ; (d) cheater-induced leaderboard pollution rate (% top-N scores flagged as suspicious by server-side heuristics) ; (e) SDK size / app-bundle impact (cross-link A8 — MB delta) ; (f) time-to-first-submission latency (ms) ; (g) SDK upgrade burden over 3-5 year indie lifespan (upgrade events/year + engineering-hours per upgrade) ; (h) ongoing operational cost (managed $0 for GPGS/GC ↔ BaaS $/month ↔ self-hosted $/month + maintenance hours) ; (i) cross-platform parity effort (LOC diff Android/iOS adapters) ; (j) achievement unlock idempotency under replay (% events correctly deduplicated). **User-facing** : (k) leaderboard freshness / staleness (user perception) ; (l) achievement unlock UI timing correctness. **Compliance** : (m) conformance Apple ASRG §5.3 (Gaming Services rules) + Google Play Games Services Policy. |
| **Co** | Solo indie resourcing no dedicated backend expertise ; Android + iOS parity requirement ; offline-first primary game loop + sporadic connectivity for score sync ; ads + IAP monetization already integrated (so networking + identity surface exists) ; leaderboards/achievements assumed **optional engagement feature** (not core mechanic) ; 2D portrait pixel-art → low ARPU + high price sensitivity on both player willingness + operational budget ; GDPR Art. 6 + Art. 17 apply to leaderboard display names + account deletion. |
| **Question** | "Pour un jeu mobile 2D pixel-art indie solo cross-platform Android+iOS offline-first avec leaderboards + achievements optional features, **quelle classe d'architecture backend social gaming services** (platform-native GPGS+GC per-platform ↔ cross-platform BaaS ↔ custom minimal self-hosted ↔ hybrid) optimise le compromis integration effort + score submission reliability under intermittent connectivity + server-side anti-cheat efficacy + operational cost + cross-platform parity + compliance, dans les contraintes solo-indie resource envelope ?" |
| **Anchor** | **SWEBOK v4** : KA3 Design (component integration, architectural styles), KA9 SE Management (third-party service selection), KA13 Software Security. **ISO/IEC 25010:2023** : Functional Suitability (Completeness — feature coverage), Reliability (Availability — submission success, Fault tolerance — intermittent connectivity), Security (Integrity — anti-cheat efficacy), Maintainability (Modifiability — SDK churn, Testability), Portability (Adaptability cross-store). **ISO/IEC 25019** : Data quality in use (leaderboard entry accuracy). **Apple App Store Review Guidelines** §5.3 (Gaming Services rules, Game Center usage). **Google Play Games Services Policy** (score integrity, attribution). **Google Play Developer Program Policy** (gamification services, account deletion). **OWASP MASVS** V5 Network + V8 Resilience (server-side complementing C15 client-side). **ISO/IEC 29110-4-3** : VSE deployment processes. **GDPR** Art. 6, 17. |
| **Dependances** | **Complements C15** (F26 server-side anti-cheat ; C15 client-side tamper resistance — defence-in-depth pair, distinct literatures, both extracted in Phase 2). **Cross-link D20** (leaderboard identifiers = personal data → privacy manifest declarations). **Downstream A7** (offline queue reuses A7 offline-first reconciliation vocabulary). **Downstream F28** (authentication binding for score submission). |
| **Note merge F27** | F27 (achievements) absorbed : same SDK, same backend, same authentication surface, same policy envelope. Extraction sub-dimension pas PICOC separee. |

---

### PICOC #F28 — Player identity + cross-device authentication (narrowed scope)

**Note reformulation** : F28 original "cloud-synced player profile / cross-device progression" overlappait avec A7 (save data sync). **Reformulated to identity/auth ONLY** — save-data sync stays A7.

| Element | Valeur |
|---------|--------|
| **P** | Dev indie solo mobile 2D pixel-art portrait offline-first Android+iOS avec ads+IAP+leaderboards, ou le player a **persistent progression** (save data via A7, IAP entitlements via E25, leaderboard scores via F26, achievements via F26) qui doit etre **bound to a stable account** to enable cross-device continuity + purchase restoration + server-authoritative operations. Player journey : (a) single device anonymous guest ↔ (b) single device + opt-in platform identity ↔ (c) cross-device migration (especially awkward Android↔iOS migration typical indie). |
| **I** | Classe des **architectures player identity + authentication flow**. 6 sous-classes : (a) anonymous/device-bound IDs (IDFV iOS, Android ID / install-ID) with opt-in upgrade ; (b) platform gaming identity (Game Center player ID, Google Play Games Services player ID) ; (c) platform OS identity (Sign in with Apple — **mandatory per ASRG §4.8 if any third-party sign-in offered** ; Google Sign-In) ; (d) third-party federated identity (Facebook, generic OAuth) ; (e) custom email/password ou magic-link ; (f) hybrid (anonymous-first with lazy upgrade). Includes session lifecycle (token refresh, re-auth on device change), account-linking semantics (merging anonymous progress into named account), **account deletion** (ASRG §5.1.1(v) + Play + GDPR Art. 17). |
| **C** | À découvrir systématiquement en Phase 2.1 (recherche : Sign in with Apple docs + ASRG §4.8, Google Sign-In + Google Identity Services, PGS sign-in flow, GC authentication, OAuth 2.0 / OpenID Connect academic literature, MASVS V4 Authentication & Session Management, GDPR compliance guides account deletion). **Pre-identification prohibée per Amendement G-1.** |
| **O** | **Mesurables** : (a) sign-in flow friction (drop-off at auth prompt — % users abandoning at sign-in screen) ; (b) silent-reauth success rate on launch (% sessions where token refresh succeeds without user interaction) ; (c) account-recovery success rate on device change (% users restoring progress cross-device) ; (d) orphaned-progress incidents (% saves unrecoverable after device loss without cloud save) ; (e) authentication strength (MASVS V4 — token storage Keychain/Keystore, phishing resistance) ; (f) provider SDK churn over 3-5 year indie lifespan (upgrade events/year) ; (g) solo-indie integration effort (person-days). **User-facing** : (h) time-to-playable from first launch (sign-in friction affects first-session retention) ; (i) account-linking edge cases resolution (merging anonymous → authenticated success rate). **Compliance** : (j) Sign in with Apple presence when any third-party social sign-in offered (ASRG §4.8 — binary gate) ; (k) in-app account-deletion flow presence (ASRG §5.1.1(v) + Play — binary gate) ; (l) GDPR Art. 6 lawful basis documented ; (m) GDPR Art. 17 erasure cascade correctness. |
| **Co** | Solo indie no dedicated security engineer ; Android + iOS dual distribution ; offline-first primary gameplay (unauthenticated gameplay MUST remain viable — authentication = progressive enhancement, NOT gate) ; leaderboards require platform identity to submit scores → tension offline-first + authenticated competitive features ; IAP restore flows depend on **store account** (Apple ID / Google account) — orthogonal to **game account** (F28's scope) ; EU users in scope (GDPR) ; Apple Privacy Manifest requires declared reasons for any device-ID-equivalent API. |
| **Question** | "Pour un jeu mobile 2D pixel-art offline-first dual-store indie solo avec ads+IAP+leaderboards, **quelle classe de strategie player identity + authentication** (anonymous device-bound / platform gaming GC+PGS / platform OS Sign-in-with-Apple+Google / third-party federated / custom email / hybrid anonymous-first-upgrade) optimise le compromis sign-in friction + token security (MASVS V4) + silent-reauth reliability + account-recovery success + provider SDK churn + solo-indie integration effort + compliance (ASRG §4.8 + §5.1.1(v) + Play account-deletion + GDPR Art. 17), tout en preservant offline-first playability pour unauthenticated users ?" |
| **Anchor** | **SWEBOK v4** : KA13 Software Security (authentication + session management). **ISO/IEC 25010:2023** : Usability (Appropriateness Recognizability sign-in clarity, Operability silent reauth, Learnability), Security (Authenticity, Confidentiality token handling), Reliability (Fault tolerance reauth), Compatibility (Interoperability avec F26/A7/E23/E25). **ISO/IEC 25019** : Data quality in use (identity-linkage correctness). **Apple App Store Review Guidelines** §4.8 (Sign in with Apple equivalence), §5.1.1(v) (account deletion mandatory when creation offered), §5.3 (Game Center data-use). **Google Play Developer Program Policy** : account management + account-deletion policy + Data Safety. **OWASP MASVS** V4 Authentication & Session Management. **Apple Privacy Manifest** required-reason APIs for device-ID-equivalents. **GDPR** Art. 5 (minimization), Art. 6 (lawful basis), Art. 17 (erasure), Art. 20 (portability), Art. 25 (privacy by design), Art. 32 (security of processing). **ISO/IEC 29110-4-3** : VSE profile. |
| **Dependances** | **Upstream of F26** (authentication binding for leaderboard/achievement submission). **Upstream of A7** (stable player ID for save-slot binding). **Upstream of D20** (SDKs determined here → privacy manifest declarations). **Upstream of D21** (first-run sign-in prompt = launch surface concern). **Cross-link E23+E25** (IAP restore via store account ≠ F28 game account — critical distinction). **Explicit scope-split with A7** : F28 owns identity/auth ; A7 owns save-data content sync. |

---

### PICOC #F29 — Deep linking + attribution SDK architecture (narrowed scope)

**Note scope narrowing** : original F29 "social sharing" bundled 3 sub-concerns. Post-reconciliation :
- **DROPPED** : OS native share sheet (UIActivityViewController / Intent.ACTION_SEND — trivial integration, non-researchable)
- **KEPT** : deep linking (Universal Links, App Links, deep-link payload validation) + attribution SDK class (referral attribution, deferred deep links post-Firebase DDL deprecation 2025)

| Element | Valeur |
|---------|--------|
| **P** | Dev indie solo mobile 2D pixel-art portrait offline-first Android+iOS avec ads+IAP, ou user-acquisition channels MAY include : (a) inbound deep links routing from ad creatives / marketing campaigns / shared content to specific in-game destinations (level, shop, invited-friend instance) ; (b) player-initiated invitations + referral flows + attribution. Scope **excludes** OS native share sheet (trivial). |
| **I** | Classe des **deep linking + attribution architectures**. 2 sous-axes couples : (a) **deep-linking infrastructure** — Apple Universal Links + Android App Links + deferred deep links (install-then-route) + URI scheme fallback ; hosting `apple-app-site-association` + `assetlinks.json` metadata ; deep-link payload **validation** (MASVS V6 Platform Interaction — unvalidated deep links = attack vector) ; (b) **attribution SDK class** (for referral attribution correlating post-install session with inviting player / ad campaign) — first-party attribution using SKAdNetwork + Apple AdAttributionKit + Android Play Install Referrer, third-party attribution SaaS (Branch, Adjust, AppsFlyer, etc.), no attribution baseline. ATT compliance on iOS 14.5+ constrains third-party attribution. |
| **C** | À découvrir systématiquement en Phase 2.1 (recherche : Apple Universal Links + Android App Links docs, MASVS V6 deep-link validation, Apple AdAttributionKit + SKAdNetwork 4.0, Play Install Referrer, mobile attribution SDK comparatives, ATT impact studies). **Pre-identification prohibée per Amendement G-1.** **FLAG** : post-Firebase Dynamic Links deprecation (Aug 2025) literature is unstable — extraction may return inconclusive. Phase 2.1 extraction template tag each source with "pre-DDL-deprecation / post-DDL-deprecation era". |
| **O** | **Mesurables SE** : (a) deep-link resolution success rate (% inbound deep links correctly routed to target in-game destination) ; (b) cold-start deep-link latency (ms from app launch to target screen) ; (c) deferred deep-link correlation success (% install-then-route sessions where inviting context is preserved) ; (d) deep-link payload validation coverage (% deep-links through validation gate vs. bypass — MASVS V6) ; (e) attribution SDK binary size impact (MB delta bundle) ; (f) attribution SDK Privacy Manifest compliance rate (SDK ships valid `PrivacyInfo.xcprivacy` — YES/NO per candidate) ; (g) integration effort solo indie (person-days) ; (h) ongoing operational cost (attribution SaaS $ / month — zero for first-party SKAdNetwork/Play Install Referrer). **User-facing** : (i) inbound deep-link user experience (correct routing, no "stuck on splash" bugs) ; (j) attribution-driven onboarding quality (referred users land on correct onboarding flow). **Compliance** : (k) Apple Privacy Manifest attribution SDK declared categories accuracy ; (l) ATT prompt interaction compliance (attribution must respect ATT status) ; (m) Google Play Data Safety accurate declarations. |
| **Co** | Solo indie ; dual-store release ; offline-first (share/deep-link actions must degrade gracefully if no network at share time — queue + retry) ; iOS 14.5+ ATT in force (attribution cannot rely on IDFA without consent — affects referral design) ; Apple Privacy Manifest + Google Play Data Safety apply to attribution SDK ; GDPR Art. 6 lawful basis for referrer-data processing ; pilot Acres does NOT explicitly need viral acquisition — F29 retained for **generalisability + future-P coverage** + MASVS V6 security concern always relevant. |
| **Question** | "Pour un jeu mobile 2D pixel-art indie solo Android+iOS optionally doing referral acquisition / marketing deep-link campaigns, **quelle classe d'architecture deep linking + attribution SDK** (Universal Links + App Links + first-party SKAdNetwork/Play Install Referrer / third-party attribution SaaS / no attribution baseline) optimise le compromis deep-link resolution success + MASVS V6 payload validation coverage + attribution correlation success + Privacy Manifest compliance + integration effort + operational cost, dans les contraintes ATT iOS + GDPR + post-Firebase-DDL-deprecation unstable literature ?" |
| **Anchor** | **SWEBOK v4** : KA3 Design (platform-integration architecture), KA13 Software Security (deep-link validation as attack surface). **ISO/IEC 25010:2023** : Compatibility (Interoperability avec OS URL handling + messaging apps + browsers), Security (Integrity — deep-link payload validation), Reliability (deep-link resolution + screenshot generation robustness), Maintainability (module testability). **Apple Universal Links** specification. **Android App Links** specification. **Apple ATT framework** + **SKAdNetwork 4.0** + **AdAttributionKit** specifications. **OWASP MASVS** V6 Platform Interaction (deep-link / intent validation). **Apple Privacy Manifest** declared API reasons for attribution SDKs. **Google Play Data Safety**. **GDPR** Art. 6, 7 (consent for referrer-data). |
| **Dependances** | **Cross-link E22** (ad attribution + referral attribution share infrastructure SKAdNetwork / AdAttributionKit — F29+E22 may extract same studies but distinct RQs : ad-network mediation vs invitation attribution). **Cross-link D20** (attribution SDK triggers Privacy Manifest declared API usage). **Cross-link D21** (inbound deep link = launch surface variant — cold start into specific destination). **Downstream of F28** (referral attribution may require logged-in inviter). **Scope narrowed** : OS share sheet explicitly dropped. |

---

## Decisions dropped / absorbed

| Decision | Action | Justification |
|----------|--------|---------------|
| F27 Achievements | ABSORBED F26 | Same SDK, backend, authentication surface, policy envelope (Apple ASRG §5.3, Play Games Services Policy). Literature treats as single "social/gamification services" bundle. |
| F28 original "cloud-synced player profile" save-data sync | ABSORBED A7 | Save data sync is A7 scope. F28 narrowed to identity/auth only. |
| F29 OS native share sheet | OUT OF SCOPE | Trivial integration (UIActivityViewController / Intent.ACTION_SEND). Per Reviewer B — non-researchable, no distinct software-quality phenomenon. |
| F29 Firebase Dynamic Links-style pre-deprecation libs | OUT OF SCOPE | Firebase Dynamic Links deprecated Aug 2025. Unstable literature. Phase 2.1 will focus on Universal Links/App Links + first-party attribution + mature third-party SaaS. |

## Open questions pour Phase 1.5 + cross-batch

### Cross-batch interactions

1. **F28 ↔ A7 binding protocol** : explicit extraction Phase 2 du binding protocol entre F28-provided stable player ID + A7's save slot. Les deux PICOCs partagent ce integration point.
2. **F26 ↔ C15 defence-in-depth** : F26 server-side anti-cheat + C15 client-side tamper resistance forment defence-in-depth pair. Phase 2.5 synthesis doit les traiter jointement meme si extractions separees.
3. **F29 ↔ E22 attribution overlap** : SKAdNetwork/AdAttributionKit partage infra entre ad attribution (E22) + referral attribution (F29). Distinct RQs — extraction peut partager sources mais RQ separee.
4. **F28 ↔ E23/E25 IAP restore** : IAP restore via **store account** (StoreKit/Play Billing native) is ORTHOGONAL to F28 **game account**. Critical distinction a preserver en Phase 2.1 extraction (false-positive hits possible).

### Questions Agent C Phase 1.5

5. Verifier : **Apple ASRG §4.8** Sign in with Apple equivalence requirement current (2026-04).
6. Verifier : **Apple ASRG §5.1.1(v)** in-app account deletion mandatory status.
7. Verifier : **Play Developer Program Policy** account-deletion policy scope + deadline.
8. Verifier : **Firebase Dynamic Links** deprecation date (Aug 2025 claimed par Reviewer B) + replacement recommendations.
9. Verifier : **Apple Universal Links** + **Android App Links** specs current.
10. Verifier : **SKAdNetwork 4.0** + **AdAttributionKit** scope (AdAttributionKit released 2024+).
11. Verifier : **OWASP MASVS V4** (Authentication) + **V6** (Platform Interaction) current version numbers MASVS 2.0+.

### Phase 2.1 extraction guidance

12. Phase 2.1 pour F26 : chercher **indie-scale leaderboard backend** studies specifiquement (filter AAA MMO studies).
13. Phase 2.1 pour F28 : chercher **Sign in with Apple + Google Sign-In coexistence** papers + account-linking edge cases (GC player ID + PGS player ID merge).
14. Phase 2.1 pour F29 : **tag each source** "pre-DDL-deprecation / post-DDL-deprecation / DDL-agnostic". Expect inconclusive zones.

## Statut Batch F

- **3 PICOCs retenues** : F26 (leaderboards+achievements), F28 (identity/auth narrowed), F29 (deep-link + attribution narrowed)
- **Kappa brut** : 3/4 = 75% ("substantial")
- **Cross-batch dependencies** dense : A7, C15, D20, D21, E22, E23, E25
- **Running total apres Batch F : 23 + 3 = 26 PICOCs**

**APPROVED pour Phase 1.3 Batch G (localization).**
