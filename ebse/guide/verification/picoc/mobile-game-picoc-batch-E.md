# Phase 1.3 Batch E — PICOCs : Monetization (domaine `mobile-game-2d`)

**Protocole** : methodology.md v3.0 §1.3 + Amendement G-1 + Amendement #3
**Date** : 2026-04-21
**Methode** : double extraction + reconciliation
**Tracability** :
- Reviewer A : agent `a2ae9e750f9b04cb2`
- Reviewer B : agent `a0872325d4387335f`

## Cadre upstream

18 PICOCs formulees : A1-A8 (Batch A), B7-B11 (Batch B), C12-C15 (Batch C), D17, D19, D20, D21 (Batch D).

**Ligne Batch E** : monetization **technical** decisions (SDK integrations, entitlement architecture, receipt validation). Strictly avoid :
- **D20 territory** : ATT/UMP *mechanics* + Privacy Manifest + Data Safety are D20's. Batch E consumes consent signals, does NOT re-derive them.
- **Business decisions** : pricing, revenue optimization copy, ASO — hors EBSE-SE.
- **C15 territory** : save file as persistence mechanism. Batch E (E25) owns entitlement *semantics* ; C15 stores opaque bytes.

## Decisions candidates (commissioning §1.2 Categorie E)

- E22. Ads SDK (interstitial, rewarded, banner)
- E23. IAP SDK + cross-platform abstraction
- E24. Monetization model (F2P / freemium / premium / subscription)
- E25. Anti-fraud / receipt validation

Plus deferrals-to-check : consent UX optimization (from D20), ad mediation strategy (E22 sub-axis).

## Reconciliation A vs B

| PICOC | Verdict A | Verdict B | Accord | Arbitrage |
|-------|-----------|-----------|:------:|-----------|
| E22 ads | RETAIN (split mediation) | RETAIN (merged as I-axis) | V (granularite diff) | B's merge : single PICOC E22 avec mediation comme axe de l'I |
| E22b ad UX policy | RETAIN (incl. consent UX) | DROP (UX research) | X | **RETAIN scoped** : strictement ad placement + frequency + format policy. Consent UX drop (deja D20). |
| E23 IAP | RETAIN | RETAIN | V | RETAIN |
| E24 monetization model | DROP (business) | RETAIN (SE architectural driver) | X | **RETAIN (B's narrow framing)** : "SE quality attributes differ across model families" — PAS "which model is best" |
| E25 receipt validation | RETAIN | RETAIN (+ C15 split explicit) | V | RETAIN (B's C15 split framework) |

**Kappa brut : 3/5 = 60% ("moderate")** — juste au seuil 0.6. 2 divergences principielles, arbitrees avec raisonnement documente.

**Arbitrage DIV-E22b** : B's critique sur "consent UX = UX research not SE" est correcte pour la partie consent prompt copy optimization. MAIS ad placement / frequency capping / format mix / banner vs interstitial UI overlap / accessibility close-button reachability sont des **engineering-controllable outcomes mesurables** avec ancrages ISO 25010 (Usability, User error protection, Accessibility) + ASRG §4 (advertising behaviour) + Google Play Ads Policy. **Scope final** : ad UX policy *excluant* consent prompt UX.

**Arbitrage DIV-E24** : A's position "business, not EBSE" correcte pour "which model earns more". MAIS B's reframing "what SE quality attributes differ across model families" est EBSE-answerable : subscription model impose server-authoritative entitlement (↑ SE complexity) vs premium unlock (↓ SDK footprint). Pilot P a deja fixe "ads + IAP + leaderboards" (hybrid F2P), mais E24 garde valeur pour :
1. Documenter que hybrid F2P est SE-compatible pour solo indie
2. Future alternative P (premium-only)
3. Decision point future : "should subscription be added ?" avec SE answer (not business ROI)

## PICOCs retenus — Batch E final

### PICOC #E22 — Ads integration architecture + mediation stack

| Element | Valeur |
|---------|--------|
| **P** | Dev indie solo ou petite equipe produisant un jeu mobile 2D pixel-art portrait offline-first Android+iOS, incorporating **ads monetization channel** (interstitial + rewarded video + banner + optionnellement app-open), devant selectionner et integrer un ou plusieurs ad-network SDKs plus (optionnellement) un mediation layer orchestrating waterfall ou in-app bidding. Session model : short-run discrete episodes (level / wave / puzzle) typique casual/hyper-casual pixel-art. |
| **I** | Classe des **ad-SDK integration topologies**. 4 sous-classes : (a) single-network direct SDK (one ad network SDK, no mediation) ; (b) first-party mediation platform with waterfall (network-priority ordering) ; (c) first-party mediation with in-app bidding / header bidding ; (d) hybrid (mediation + reserved direct campaigns). Axes : initialization ordering relative au game loop ; consent-signal propagation *receipt* (as D20 output consumer) ; ad-format selection ; lifecycle hooks (pause, backgrounding, ad-sandbox isolation) ; maintenance story on adapter version churn. |
| **C** | À découvrir systématiquement en Phase 2.1 (recherche : ad mediation docs Google AdMob Mediation + AppLovin MAX + IronSource, mobile ad SDK integration postmortems, ACM papers on mobile ad architecture, MASVS-NETWORK/PRIVACY guidance, indie mobile monetization surveys). **Pre-identification prohibée per Amendement G-1** (pas de "AdMob vs Unity Ads vs AppLovin"). |
| **O** | **Mesurables SE** : (a) cold-start delta attributable to ads SDK init (ms) ; (b) frame-time variance during ad fetch/show (p99 ms) ; (c) main-thread stalls attributable to SDK init (ms) ; (d) APK/IPA size delta per added network adapter (MB) ; (e) crash-free-session rate regression attributable to ad SDK (%) ; (f) ANR frequency attributable to ads (ANR/1000 sessions) ; (g) integration LoC + number of manifest/Info.plist entries per added network ; (h) build-time delta ; (i) adapter version-churn frequency (updates/year) ; (j) fill-rate telemetry completeness (ad requests traced correctly) ; (k) privacy-signal plumbing effort propagating ATT/UMP consent through mediation (engineering-hours). **User-facing** : (l) perceived app launch smoothness vs no-ads baseline ; (m) privacy-manifest divergence incidents (SDK behavior vs declared categories). **EXCLUDED** : eCPM, ARPDAU, LTV, revenue (business outcomes, not SE). |
| **Co** | Solo indie no dedicated ads engineer + no ops team for waterfall tuning ; 2D pixel-art portrait games ou banner/interstitial competes with portrait-locked UI real-estate ; offline-first design ou ad availability non-guaranteed (must degrade gracefully) ; dual-store ou policy changes (ASRG §3/§4, Play Families, Play ad-ID deprecation cadence) propagate as SDK-version requirements ; cross-platform engine ou ad SDK consumed via plugin/wrapper. |
| **Question** | "Pour un jeu mobile 2D pixel-art indie solo portrait offline-first Android+iOS avec ads monetization, **quelle classe d'ad-SDK integration topology** (single-SDK direct / mediation waterfall / in-app bidding / hybrid) optimise le compromis performance (cold-start, frame-time, size) + reliability (crash-free, ANR) + maintainability (adapter churn, privacy-signal propagation) + portability (parity Android/iOS), dans les contraintes solo-dev ops envelope et offline-first degradation ?" |
| **Anchor** | **SWEBOK v4** : KA4 Construction (SDK integration), KA8 Configuration Management (adapter version churn), KA13 Software Security. **ISO/IEC 25010:2023** : Performance Efficiency (resource utilization, time behaviour), Reliability (Fault tolerance), Maintainability (Modifiability, Analysability), Portability (Adaptability). **OWASP MASVS** : V6 Network (ad request patterns), V7 Privacy (consumer of D20 declarations). **Apple App Store Review Guidelines** : §4 Design (advertising behaviour). **Google Play Developer Program Policy** : Ads (disruptive ads, full-screen interstitial rules), Families Policy. **ISO/IEC 29110-4-3** : VSE profile. |
| **Dependances** | **Downstream consumer of D20** (consent signals, ATT status, Privacy Manifest entries as inputs — E22 does NOT re-derive them). **Cross-link A8** (adapter SDK footprint affects bundle size). **Cross-link D19** (adapter footprint affects dynamic delivery strategy). **Upstream of E22b** (integration topology determines placement policies feasible). |

---

### PICOC #E22b — Ad placement + format-mix + frequency capping UX policy

**Note post-reconciliation** : PICOC scope **strictly excludes** consent prompt UX (already D20 territory) and pure copy/timing optimization (UX-research discipline outside EBSE-SE). Retained scope = technically-controllable ad surface decisions with SE-measurable outcomes.

| Element | Valeur |
|---------|--------|
| **P** | Dev indie solo mobile 2D pixel-art portrait offline-first Android+iOS with short-session gameplay (discrete run / level / wave) + ads monetization (integrated per E22). Pilot P inclut interstitial-between-runs et rewarded-continue comme idiomatic patterns. |
| **I** | Classe de **ad placement + format-mix + frequency capping UX policies**. 4 axes : (a) format deployment (which formats used where : interstitial triggers between-runs ou on-menu-return ; rewarded-ad integration into game economy for gems/continues ; banner presence/absence on gameplay vs menu screens ; app-open ads permitted ou disabled) ; (b) frequency-capping rules (time-based, session-based, event-based ; minimum gap between full-screen ads) ; (c) rewarded-ad opt-in flow (pre-prompt presence + value-exchange framing transparency) ; (d) portrait UI accessibility (close-button reachability with thumb in portrait mode ; banner overlap with interactive game UI zones ; ad-click-through-safe-zones). **Explicitly NOT in scope** : consent prompt UX / ATT prompt timing / UMP copy optimization (→ D20). |
| **C** | À découvrir systématiquement en Phase 2.1 (recherche : indie casual game ad-UX postmortems, ASRG / Play Policy casebook on disruptive ads, IAB/MMA ad format standards, rewarded-ad integration studies in ACM CHI PLAY, mobile ad UX A/B studies — extract SE outcomes only not revenue). **Pre-identification prohibée per Amendement G-1.** |
| **O** | **Mesurables SE** : (a) compliance pass rate under Apple ASRG §4 (advertising) + Google Play Ads Policy (disruptive-ads, full-screen interstitial rules, families-policy restrictions) ; (b) accidental-click rate (% ad interactions attributable to UI mis-tap) ; (c) banner-overlay UI interference incidents (% sessions ou banner occluded mandatory UI) ; (d) rewarded-ad opt-in rate as UX conversion (% users accepting value exchange — proxy for perceived fairness, NOT revenue) ; (e) short-term retention proxies (D1 session count, uninstall rate within first session) as ISO 25019 quality-in-use outcomes ; (f) accessibility close-button target-size compliance (WCAG 2.2 SC 2.5.8 + Apple HIG 44pt + Material 48dp). **User-facing** : (g) user-reported intrusiveness (playtest rubric + review sentiment on "too many ads") ; (h) rage-tap incidence analytics ; (i) 1-star review rate attributable to ad placement. **EXCLUDED** : eCPM, ARPDAU, LTV, revenue conversion. |
| **Co** | Short-session casual/hyper-casual 2D pixel-art portrait ; **Offline-first gracefully degrades** when ads fail to load (no forced-ad-or-no-play gates) ; ATT/UMP obligations propagate from D20 ; Google Play Families policy sensitivity si app rated under-13 audiences (even opportunistic — disrupts ad-network eligibility) ; portrait UI real-estate limits banner placement options. |
| **Question** | "Pour un jeu mobile 2D pixel-art indie solo portrait offline-first ads-monetized, **quelle classe de ad placement + format-mix + frequency-capping UX policy** (documented policy with specific format deployment + frequency rules + rewarded opt-in flow + accessibility compliance) minimise compliance risk + accidental-click rate + retention degradation + review-sentiment-negative-rate, tout en gardant placement options viable sur portrait UI real-estate contrainte ?" |
| **Anchor** | **SWEBOK v4** : KA3 Design (UI/UX design, advertising surface integration). **ISO/IEC 25010:2023** : Usability (Appropriateness Recognizability, Learnability, Operability, User error protection, Inclusivity/Accessibility). **ISO/IEC 25019** : Quality in Use (User engagement retention, Satisfaction, Freedom from risk). **W3C WCAG 2.2** : SC 2.5.8 Target Size Minimum. **Apple HIG** 44pt touch targets + Apple HIG Games (ad placement norms). **Apple App Store Review Guidelines** : §4 Design (advertising behaviour). **Google Play Ads Policy** : disruptive-ads classification, full-screen interstitial restrictions post-2022, Families Policy. |
| **Dependances** | **Downstream of E22** (which SDK + mediation determines which formats/frequency-caps are technically available). **Downstream of D20** (consent state drives whether personalized ad formats can be shown at all). **Cross-link A6** (touch target + WCAG/HIG accessibility standards apply to ad close buttons). |

---

### PICOC #E23 — IAP cross-platform abstraction vs platform-native direct

| Element | Valeur |
|---------|--------|
| **P** | Dev indie solo mobile 2D pixel-art portrait offline-first Android+iOS offrant in-app purchases (consumables, non-consumables ; subscriptions non-pilot-requis mais architecture must not exclude them), sur plateforme-cross engine/toolchain avec contrainte cross-platform shipping. IAP catalogue scope : durable unlocks + consumable currency (gems) + optional future subscription. Ads + IAP coexistence required (cross-link E22). |
| **I** | Classe des **IAP integration architectures**. 4 sous-classes : (a) engine-native IAP abstraction (engine ou plugin fournit unified product-catalogue + purchase + restore + entitlement API + delegues internally to StoreKit/Play Billing) ; (b) direct platform SDK calls (StoreKit 2 iOS + Play Billing Library v6+ Android via parallel platform-specific modules, via conditional compilation ou dependency injection, sans unifying abstraction) ; (c) third-party IAP orchestration layer (SaaS wrappers style Adapty/RevenueCat as SE dependency — architectural choice, not vendor endorsement) ; (d) hybrid (direct one OS, abstraction other). Axes : product-catalogue definition (local vs remote) ; purchase-flow state machine ; pending/deferred purchase handling ; purchase restoration flow (ASRG §3.1.1 mandatory) ; subscription lifecycle events (renewal, grace, billing retry, refund, expiration) ; promotional offer plumbing. |
| **C** | À découvrir systématiquement en Phase 2.1 (recherche : StoreKit 2 + Play Billing v6+ official docs, engine-native IAP abstraction docs Unity/Godot/Flutter, third-party IAP wrapper docs, indie dev postmortems IAP integration, subscription lifecycle case studies, DMA third-party billing post-2024 jurisdictional analyses). **Pre-identification prohibée per Amendement G-1.** |
| **O** | **Mesurables** : (a) completeness of purchase-flow state coverage (pending / deferred / interrupted / restored / refunded / revoked — % of 7+ states handled) ; (b) subscription lifecycle event coverage (renewal / grace / billing retry / refund — % covered) ; (c) successful-purchase completion rate ; (d) orphan-purchase rate (charged but not granted — critical metric) ; (e) grant idempotency under retry (deterministic behavior) ; (f) SDK version upgrade friction (engineering-hours per Play Billing forced-upgrade cadence) ; (g) abstraction leakiness (how often platform specifics escape the wrapper — count of platform-specific if-checks in gameplay code) ; (h) porting effort / LOC delta adding second store post-launch ; (i) test coverage achievable on-device vs CI (sandbox fidelity) ; (j) binary size footprint. **User-facing** : (k) user-facing purchase-flow clarity (time from tap to success confirmation, error message clarity per locale) ; (l) restore-purchases success rate on reinstall (ASRG §3.1.1 critical). **Compliance** : (m) correctness of digital-goods routing through native billing (no prohibited external-payment patterns per ASRG §3.1 + Play Billing exclusivity) ; (n) subscription grace periods handling (ASRG §3.1.2). |
| **Co** | Solo indie NO dedicated billing engineer ; cross-platform engine ou IAP layer is one of MOST platform-asymmetric subsystems ; offline-first (purchases initiated online but entitlement MUST survive offline sessions — hands off to E25 / C15) ; **Apple ASRG §3 Business** (IAP, subscriptions, auto-renewable, exceptions, restore-purchases mandatory) ; **Google Play Billing Policy** (Play Billing exclusivity, subscription rules, real-money transactions) ; policy-churn context (StoreKit 2 migration, Play Billing deprecation cadence, regional regulatory changes DMA post-2024 treated as backdrop). |
| **Question** | "Pour un dev indie solo shippant un jeu mobile 2D pixel-art cross-platform Android+iOS avec IAP (consumables + non-consumables + future-compatible subscriptions), **quelle classe d'architecture IAP integration** (engine-native abstraction / direct StoreKit+Play-Billing / third-party orchestration / hybrid) optimise le compromis functional correctness (state coverage, idempotency) + reliability (completion rate, no orphan purchases) + maintainability (SDK churn, abstraction leakiness) + compliance (ASRG §3 + Play Billing exclusivity + restore-purchases mandatory) + portability (LOC delta dual-store) + testability ?" |
| **Anchor** | **SWEBOK v4** : KA3 Design (abstraction / information hiding), KA4 Construction (platform SDK integration), KA5 Testing (testability — sandbox fidelity), KA13 Software Security. **ISO/IEC 25010:2023** : Functional Suitability (Correctness, Completeness), Reliability (Faultlessness, Availability), Maintainability (Modifiability, Testability, Analysability, Reusability), Portability (Adaptability, Installability). **Apple App Store Review Guidelines** : §3.1.1 IAP (mandatory, Restore Purchases), §3.1.2 Subscriptions, §3.1.3 exceptions. **Google Play Developer Program Policy** : Payments / Billing / Subscriptions (Play Billing exclusivity, voided purchases, acknowledgement). **OWASP MASVS** : V5 Network, V7 Privacy. **ISO/IEC 29110-4-3** : VSE profile. |
| **Dependances** | **Feeds E25** (E23 delivers the receipt ; E25 validates + persists entitlement). **Cross-link C12-C15** (purchase acknowledgement + entitlement persistence save-lifecycle plumbing). **Cross-link D21** (launch surface — restore-purchases flow integrates with app-open). **Cross-link E22** (IAP + ads coexistence — both affect portrait UI real-estate). **Downstream of E24** (monetization model determines IAP catalogue structure). |

---

### PICOC #E24 — Monetization model as SE architectural driver

**Note framing (B's reconciliation)** : Cette PICOC est **strictement SE architectural** — pas business/pricing. RQ : "how does model choice constrain SE architecture" (SDK footprint, entitlement authority, analytics surface, failure-mode inventory). Business KPIs (eCPM, LTV, retention × model) extraits en Phase 2 **uniquement comme context**, pas comme primary O. Scope-guard : si Phase 2 screening ne surface que business-KPI studies pour E24, la PICOC peut etre **degradée to context-only ou merged E22+E23** en post-pilot amendment.

| Element | Valeur |
|---------|--------|
| **P** | Dev indie solo mobile 2D pixel-art portrait Android+iOS ou le **monetization model choice** (premium paid upfront / F2P with ads / F2P with IAP / freemium hybrid ads+IAP / subscription / paid-with-IAP) drive **software-engineering architectural commitments** — PAS as marketing/business choice mais comme constraint set sur la codebase. Pilot P a fixe hybrid F2P (ads+IAP+leaderboards) — E24 evalue les SE consequences de ce choix vs alternatives, et future decision points (add subscription ? switch to premium ?). |
| **I** | Adoption des **SE commitments induites par un specific monetization model** : (a) entitlement model (none / one-shot unlock / consumable economy / time-boxed subscription) ; (b) server-side authority requirements (premium = no server ; subscription = server-authoritative state reconciliation) ; (c) analytics instrumentation density (F2P requires deep funnel analytics ; premium does not) ; (d) SDK footprint (premium → minimal ; freemium hybrid → maximal : ads SDK + IAP SDK + attribution + analytics) ; (e) feature-flag / remote-config surface to operate the model ; (f) offline-first compatibility (premium naturally offline ; subscription needs online-reconciliation on some cadence). |
| **C** | À découvrir systématiquement en Phase 2.1 (recherche : ACM/IEEE mobile monetization SE studies, indie game postmortems per model, Apple + Google policy docs per model type, ISO 29110 VSE process fit studies). **Pre-identification prohibée per Amendement G-1.** |
| **O** | **Mesurables SE strict** : (a) modifiability / maintainability — count of monetization-coupled modules + third-party SDKs required per model + frequency of monetization-driven release triggers ; (b) performance efficiency — cold-start + memory footprint delta attributable to SDK stack the model demands ; (c) reliability — surface area of monetization-adjacent failure modes (ad-fetch failure, purchase interruption, subscription state desync) correlated with model ; (d) security / integrity — attack surface size as function of entitlement model (server-authoritative subscription vs local premium-unlock differ orders of magnitude in threat model) ; (e) data quality in use — volume + sensitivity of telemetry necessitated ; (f) offline-first compatibility (% gameplay sessions unaffected by network loss per model) ; (g) process fit ISO 29110-4-3 (implementability solo developer process envelope — engineering-hours / month to operate the model). **EXPLICITLY EXCLUDED** : revenue per user, conversion rate, retention, churn — business KPIs, context-only. |
| **Co** | Solo indie resource envelope CORE CONSTRAINT — monetization models differ ordre de grandeur in ongoing-ops burden, ce qui est key discriminator single-developer ; offline-first design CONSTRAINS models assuming always-online validation (subscriptions in particular) ; 2D pixel-art genre context ou some models have established cultural fit et d'autres non (paid-premium harder on mobile than desktop indie storefronts — shapes SE choice set) ; platform policy context (Apple ASRG § 3 + Play Billing Policy) applies per model. |
| **Question** | "Comment le choix de monetization model (premium / F2P ads / F2P IAP / freemium hybrid / subscription) **contraint les decisions SE architecturales** (SDK footprint, entitlement authority, analytics surface, failure-mode inventory, offline-first compatibility) dans les jeux mobile 2D indie solo, et quels SE quality-attribute trade-offs sont empiriquement rapportes cross-modeles ?" |
| **Anchor** | **SWEBOK v4** : KA2 Design (architectural drivers), KA9 SE Management (VSE process fit). **ISO/IEC 25010:2023** : Maintainability (Modifiability), Performance Efficiency (Resource utilization), Reliability (Fault tolerance surface area), Security (Integrity — entitlement attack surface). **ISO/IEC 25019** : Data quality in use (telemetry surface sensitivity). **OWASP MASVS** : V8 Resilience (per model), V6 Authorization (per model). **Apple App Store Review Guidelines** : §3.1 (IAP, subscriptions). **Google Play Developer Program Policy** : Billing + Subscriptions. **ISO/IEC 29110-4-3** : VSE process applicability. |
| **Dependances** | **Upstream of E22, E23, E25** (E24 determines whether E22 applies + how intensely E23's IAP state machine must handle subscriptions + how much E25 server-authority is required). **Cross-link C15** (entitlement model determines what C15 persists). **Cross-link D17, D19** (subscription models couple to delivery cadence). |

---

### PICOC #E25 — Server-side receipt validation + entitlement persistence + anti-fraud

| Element | Valeur |
|---------|--------|
| **P** | Dev indie solo mobile 2D pixel-art offline-first Android+iOS avec IAP (consumables + non-consumables + optionally subscriptions) ou chaque purchase produces a receipt (Apple StoreKit 2 signed JWS ou Google Play purchase token + signature) qui doit etre (a) verified as authentic, (b) converted into a persisted entitlement, (c) protected against replay + sharing + local tampering — all within offline-first operating model + solo-dev resource envelope. Threat model = casual hex-edit griefers + community-shared save-edit tools, NOT determined adversary (cross-link C15). |
| **I** | Classe des **receipt-validation + entitlement-persistence architectures**. 4 sous-classes : (a) client-only validation (local signature verification StoreKit 2 `Transaction.verificationResult` + Play Billing local signature check ; entitlement persisted directly to local save per C15) ; (b) server-side validation (client posts signed transaction to dev-owned backend ; backend calls Apple App Store Server API + Google Play Developer API ; verifies crypto ; stores canonical entitlement ; returns signed entitlement to client) ; (c) hybrid (server validation with signed-entitlement token cached locally for offline use — most common fit offline-first) ; (d) third-party validation service (SaaS as SE dependency, no self-hosted infra). **Anti-fraud controls within SE scope** : receipt replay detection, device/account binding, subscription-state reconciliation (grace period, billing retry, refund revocation), obfuscation/integrity posture (MASVS-RESILIENCE) for local entitlement cache. |
| **C** | À découvrir systématiquement en Phase 2.1 (recherche : Apple App Store Server API docs + Google Play Developer API docs + StoreKit 2 JWS validation, OWASP MASVS V6 Authorization + V8 Resilience, indie dev IAP fraud postmortems, server-side validation cost analyses at indie scale). **Pre-identification prohibée per Amendement G-1.** |
| **O** | **Mesurables** : (a) receipt-forgery resistance + replay-attack resistance + local-cache tamper resistance (adversarial test matrix pass rate) ; (b) key-material handling correctness (no embedded secrets in client, MASVS-CRYPTO) ; (c) entitlement availability during offline sessions (% availability vs offline-first baseline) ; (d) correctness of reconciliation when connectivity returns (% state converged correctly) ; (e) handling of refund-while-offline + subscription-expiry-while-offline (correct revocation) ; (f) idempotency of entitlement grant under retry (no double-grant, no silent drop) ; (g) adherence to platform-mandated validation patterns (ASRG §3 + Play Billing purchase acknowledgement policy) ; (h) subscription lifecycle event handling (renewal, grace, billing retry — cross ref E23) ; (i) operational burden solo indie (backend uptime requirements, API key rotation, Apple App Store Server Notifications v2 endpoint, Google Real-time Developer Notifications ; engineering-hours + $/month) ; (j) data integrity cross OS reinstalls + account migrations + device changes (cross-link C14 save migration) ; (k) privacy data-minimisation implications routing purchase metadata through dev-owned server (cross-link D20). **User-facing** : (l) legitimate-user false-positive rate (honest users flagged as cheaters — CRITICAL, must not break IAP restore for honest users) ; (m) IAP restore flow success rate (ASRG §3.1.1 mandatory). |
| **Co** | Solo indie NO ops team ; offline-first game loop (entitlement MUST remain usable sans reachable backend ; reconciliation is eventual — PUSHES toward hybrid signed-cache) ; dual-store MASVS V6 Authorization compliance ; "purchases must be acknowledged" clauses Google Play Billing ; Apple server-notification responsibilities if subscriptions offered ; fraud threat surface indie 2D = **lower-value-per-account** than AAA → shifts cost/benefit ratio of heavy anti-fraud investment (relevant interpreting evidence from non-indie studies). |
| **Question** | "Pour un jeu mobile 2D pixel-art offline-first indie solo Android+iOS avec IAP (consumables + non-consumables + potentiellement subscriptions), **quelle classe de receipt-validation + entitlement-persistence architecture** (client-only / server-authoritative / hybrid signed-cache / third-party SaaS) optimise integrity (fraud resistance + tamper resistance) + reliability (offline availability + reconciliation correctness + idempotency) + correctness (lifecycle coverage + restore flow) + SE-operational feasibility solo dev (backend ops burden + false-positive honest users) ?" |
| **Anchor** | **OWASP MASVS** : V6 Authorization (server-side enforcement entitlement), V7 Privacy, V8 Resilience (anti-tamper), V9 Cryptography. **SWEBOK v4** : KA3 Design (security design), KA13 Software Security. **ISO/IEC 25010:2023** : Security (Authenticity, Integrity, Non-repudiation, Accountability, Resistance), Reliability (Recoverability, Fault tolerance). **ISO/IEC 25019** : Data quality in use (integrity). **Apple App Store Review Guidelines** : §3.1 (receipt validation, subscription server notifications, refund handling), App Store Server API docs. **Google Play Developer Program Policy** : Billing + Subscriptions (purchase acknowledgement, voided purchases, Real-time Developer Notifications). **ISO/IEC 29110-4-3** : VSE process (accounting for solo-indie ops cost as real constraint). |
| **Dependances** | **Explicit split with C15** (per B's reconciliation) : C15 owns *save file as persistence mechanism* (atomic writes, schema migration, cloud-save reconciliation — medium-agnostic about what it persists) ; E25 owns *entitlement semantics* (what is valid entitlement, how obtained via receipt validation, crypto binding, revocation semantics). Boundary : signed-entitlement token produced by E25 STORED by C15's persistence layer. C15 treats as opaque bytes with integrity requirements ; E25 treats C15 as black-box durable store. Joint concern : local entitlement cache integrity spans both. **Downstream of E23** (receipt comes from IAP integration). **Downstream of E24** (model determines reconciliation complexity). **Cross-link D20** (dev-owned server data-flow declared in Privacy Manifest). |

---

## Decisions dropped / absorbed

| Decision | Action | Justification |
|----------|--------|---------------|
| E24 "which model earns more" | DROP business-level | Business strategy question, not EBSE-SE. Kept E24 PICOC but narrowed to SE architectural driver framing. |
| Consent prompt UX copy/timing optimization | DROP | (1) Consent mechanics already D20. (2) Copy optimization = UX-research/behavioral-study discipline outside EBSE-SE. |
| Reward economy design (how many gems per ad, pricing tiers) | OUT OF SCOPE | Product game-design decision, not SE quality-attribute question. |
| Pure vendor benchmarks (eCPM comparisons between specific ad networks) | OUT OF SCOPE | Time-variable market data, not engineering evidence. |
| Revenue optimization / ASO / pricing strategy | OUT OF SCOPE | Marketing-ops + business strategy. |
| IAP catalogue pricing (price points, regional pricing, promo) | OUT OF SCOPE | Business decision. E23 covers architecture + lifecycle only. |

## Open questions pour Phase 1.5 + cross-batch

### Cross-batch interactions

1. **E25 vs C15 split** : precisely documented (medium-agnostic storage C15 ; entitlement semantics E25 ; composable controls). Phase 2.1 extraction doit tagger source par which boundary they study.
2. **E24 potential degradation** : si Phase 2 screening surface ne couvre que business-KPI studies (pas SE outcomes), E24 peut etre demote to context-only ou merged into E22+E23 en post-pilot amendment. Flag pour Phase 1.5 pilot si E24 est selectionne comme pilote PICOC.
3. **E22b + A6 touch-target** : ad close-button accessibility compliance cross-references A6 input + WCAG 2.2. Cross-batch validation en Phase 2.5.

### Questions Agent C Phase 1.5

4. Verifier : **Apple App Store Server API** endpoints + **App Store Server Notifications v2** existence + current scope.
5. Verifier : **Google Play Developer API** endpoints for purchases + subscriptions + Real-time Developer Notifications.
6. Verifier : **OWASP MASVS** V5/V6/V7/V8/V9 current version numbering (MASVS 2.0+).
7. Verifier : **Play Billing Library v6+** deprecation timeline for v5.
8. Verifier : **DMA third-party billing** post-2024 status (may have changed ASRG §3.1.3 exceptions).
9. Verifier : **iOS 18 StoreKit 2** features vs StoreKit 1 legacy deprecation status.

### Phase 2.1 extraction guidance

10. Phase 2.1 pour E22 : chercher **ad SDK integration postmortems indie scale** specifiquement (eviter AAA studies biais).
11. Phase 2.1 pour E22b : chercher **frequency capping + placement A/B studies** mais extract SE outcomes only (compliance + intrusiveness + accessibility), IGNORE revenue figures.
12. Phase 2.1 pour E23 : chercher **engine-native IAP abstraction leakiness** empirical studies.
13. Phase 2.1 pour E25 : chercher **hybrid signed-cache pattern** empirical studies (offline-first IAP specifically).

## Statut Batch E

- **5 PICOCs retenues** : E22 (ads architecture + mediation), E22b (ad UX policy scoped), E23 (IAP abstraction), E24 (SE architectural driver), E25 (receipt validation + entitlement)
- **Kappa brut** : 3/5 = 60% ("moderate", just above 0.6 threshold)
- **Divergences principielles documentees** : E22b scope narrowing (consent UX excluded) + E24 reframing (SE driver not business)
- **23 PICOCs total dans mobile-game-2d apres Batch E**

**APPROVED pour Phase 1.3 Batch F (social/platform).**
