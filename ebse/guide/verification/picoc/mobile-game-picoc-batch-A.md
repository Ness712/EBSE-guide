# Phase 1.3 Batch A — PICOCs : Framework & Architecture (domaine `mobile-game-2d`)

**Protocole** : `methodology.md` v3.0, section 1.3 (Kitchenham & Charters 2007 §5.3) + Amendement G-1 (2026-04-21, anti-biais) + Amendement #3 (ai-collaboration, anchor obligatoire)
**Date** : 2026-04-21
**Methode** : double extraction (Reviewer A + Reviewer B, contextes isoles) + reconciliation superviseur
**Tracability** :
- Reviewer A : agent `a444f8df0f3ca35f4` (transcript dans `.claude/tmp/tasks/`)
- Reviewer B : agent `a6018dfe94e790285` (transcript dans `.claude/tmp/tasks/`)
- Superviseur humain : Gabriel (PO)
- Agent C verification : a executer en Phase 1.5 (verif anchors + fabrication tools/standards)

## Decisions candidates initiales (commissioning §1.2)

6 decisions pre-identifiees, sans pre-selection de solutions (Amendement G-1) :
- A1. Mobile game framework/engine
- A2. Programming language
- A3. Rendering pipeline / graphics abstraction
- A4. Game loop architecture (timing + paradigme)
- A5. Scene / screen management
- A6. Input abstraction

## Reconciliation A vs B

### Kappa brut

Accord binaire sur les 6 decisions initiales :

| # | Decision | Verdict A | Verdict B | Accord |
|---|----------|-----------|-----------|:------:|
| A1 | Engine / framework | RETAIN (merge A2) | RETAIN (merge A2) | V |
| A2 | Language | DROP (merge A1) | DROP (deducible) | V |
| A3 | Rendering | RETAIN (residual) | DROP (deducible) | X |
| A4 | Game loop | SPLIT (timing + paradigm) | KEEP timing only | PARTIAL |
| A5 | Scene management | RETAIN | DROP (engine-provided) | X |
| A6 | Input abstraction | RETAIN | RETAIN | V |

**Accord complet : 3/6 = 50%** (kappa brut ~0.30, "fair")

Seuil methodology §2.2 : kappa >= 0.6. **Seuil non atteint.** Conformement au protocole, les divergences sont arbitrees par le superviseur apres analyse des justifications — pas considerees comme erreurs, mais comme des divergences de framing principielles.

### Propositions hors liste initiale (par Reviewer B)

| # | Decision | Propose par | Justification |
|---|----------|:-----------:|---------------|
| A7 | Offline-first persistence + cloud-save sync | B | Pilot P mentionne explicitement "offline-first avec cloud save" — commitment architectural foundationnel, difficile a retrofitter, cross-engine |
| A8 | Cross-platform asset pipeline + bundle architecture | B | Bundle size caps (Play 150 MB / App Store 200 MB cellular) + pixel-art compression choices = decision architecturale early-bound ; adresse directement le pain point PO "ou est l'asset dans le PNG" |

Reviewer A a flagge "platform-native bridge layer" en open question mais ne l'a pas propose comme PICOC. Il sera traite en Batch D (store publishing) ou Batch E (monetization).

### Analyse des divergences principielles

#### DIV-A3 : Rendering pipeline

**Position A** (retenir comme "decision residuelle") : Scope A3 comme "etant donne l'engine choisi, reste-t-on a son abstraction ou descend-on plus bas ?". Argumente qu'un framework (pas engine) peut ne pas offrir de renderer 2D optimise pour pixel-art.

**Position B** (drop comme deducible) : Pour un P = solo/VSE + indie + 2D, ecrire un custom renderer (Metal/Vulkan/GLES3) est hors capacite. Le pixel-art rendering (nearest-neighbor, integer scaling, viewport) est **configuration** dans l'engine, pas architecture choice.

**Arbitrage superviseur** : **Position B retenue.**

- Le P explicit (solo + VSE + ISO 29110-4-3) rules out custom renderer comme option realiste
- La qualite pixel-perfect (nearest neighbor, integer scaling, absence de filter blur) devient une **outcome dimension de A1** (dans l'objectif "pixel-art fidelity" de A1)
- Si la Phase 2.1 decouvre des candidats A1 qui ne fournissent PAS de renderer 2D adequate (ex: framework pur type SDL bindings), le PICOC A3 sera **revu en Phase 1.5b** comme PICOC conditionnel

**Conclusion** : A3 DROP. Integre comme outcome de A1 ("pixel-art rendering fidelity").

#### DIV-A4 : Game loop — split ou keep timing only

**Position A** (split en A4a timing + A4b paradigm) : Argumente que le paradigme architectural (OOP vs ECS vs FRP) a une litterature distincte (data-oriented design, ACM DL, IEEE Xplore) independante de l'engine. Split yields plus sharp questions.

**Position B** (keep A4' timing only) : Le paradigme est **fortement prescrit** par l'engine (Godot scene-tree OOP, Unity DOTS ECS, Flame ECS, etc.). Une comparaison cross-engine ECS-vs-OOP en Phase 2.1 confondrait paradigme avec engine, produisant literature non transferable pour un P solo/indie.

**Arbitrage superviseur** : **Position B retenue.**

- L'argument "confoundment paradigm-engine" est methodologiquement solide (Kitchenham §2.3 Performance bias)
- Le P solo/VSE : le cost d'aller contre le paradigm de l'engine est prohibitif
- Les outcomes de maintainability et testability de A4b sont absorbes dans A1 outcomes (maintainability index, churn, testability)
- A4' (timing strategy) reste PICOC independant car la literature pattern (Fiedler gafferongames, Gregory Ch.8) est cross-engine

**Conclusion** : Seul A4' conserve. Paradigm absorbé dans A1 outcomes.

#### DIV-A5 : Scene management

**Position A** (retain) : Argumente que la correctness sous lifecycle events (OS kill, background, interrupt), la save-on-interrupt integrity, et le transition latency sont des decisions non triviales cross-engine.

**Position B** (drop) : Tous les engines 2D mobiles mainstream fournissent un scene graph / screen manager. La comparaison scene management cross-engine confondrait avec engine choice. Dependent strictement sur A1.

**Arbitrage superviseur** : **Position B retenue, avec redirection des concerns A-legitimes.**

- Les concerns A (lifecycle + save integrity + IAP flow) sont REELS et important
- Mais ils appartiennent a d'autres PICOCs :
  - Save-on-interrupt + lifecycle → **A7 Offline-first persistence** (outcome: recovery time after offline-online transition + save integrity under OS kill)
  - IAP flow compliance → Batch D/E (monetization) PICOCs dediees (non-batch-A)
- Pas de DIV-A5-induced scope loss : les concerns sont preserves, juste relocalises

**Conclusion** : A5 DROP. Concerns redirigés vers A7 + Batches ulterieurs.

## PICOCs retenus — Batch A final

### PICOC #A1 — Mobile 2D game engine / framework selection

| Element | Valeur |
|---------|--------|
| **P** | Dev indie solo ou petite equipe (1-5 personnes) construisant un **jeu mobile 2D pixel-art portrait** ciblant **Android (API 26+) ET iOS (15+)**, distribue via Google Play + Apple App Store, gameplay offline-first avec cloud save optionnel, monetise via ads (interstitial/rewarded) + IAP (consumable/non-consumable) + leaderboards plateforme. Pas de budget de licensing engine dedie hors royalties-share indie tier. Pas d'expertise engine prealable presumee. Stabilite de l'engine attendue sur ≥ 3 ans (support cycle indie). |
| **I** | Classe des **engines 2D integres et frameworks mobile-capables** — tout software stack fournissant au minimum : game loop, rendering 2D, scene management, input abstraction, audio, et tooling Android + iOS deployable. Inclut engines complets (editor + runtime + asset pipeline) et frameworks code-first (library/runtime sans GUI editor). **Inclut la langue de programmation associee** (deduite de I par couplage fort — cf. DIV-A2 arbitrage). |
| **C** | À découvrir systématiquement en Phase 2.1 (recherche multi-bases : IEEE Xplore, ACM DL, Scopus, SpringerLink, DBLP, Google Scholar, GitHub topics `game-engine`/`2d-game-engine`/`mobile-game`, Stack Overflow Developer Survey game-dev segment, SlashData State of the Developer Nation, Itch.io tools directory, engine directories `awesome-gamedev`, GDC Vault). **Pre-identification prohibée per Amendement G-1.** L'ensemble C = resultat du screening Phase 2.2 sur I. |
| **O** | **Mesurables runtime** : (a) median + p99 CPU frame time sur device reference mid-range 2026 (Pixel 6a / iPhone SE 2022) en ms @ 60 FPS target ; (b) cold-launch time sur device reference (target ≤ 3 s, Apple ASRG §2.3.1) ; (c) release bundle size (APK/AAB et IPA) en MB vs caps store (Play 150 MB APK base / App Store 200 MB cellular) ; (d) memory footprint resident en MB sur device reference (target ≤ 200 MB) ; (e) crash-free session rate % (Play Vitals + App Store Connect, target ≥ 99.x%) ; (f) battery drain en mAh/heure session active. **Mesurables productivite** : (g) build iteration time full rebuild (target ≤ 5 min) et incremental (target ≤ 30 s) ; (h) time-to-first-playable sur device (proxy solo-dev productivity, en heures ou jours depuis `init`) ; (i) maintainability index + cyclomatic complexity gameplay code (ISO 25023) ; (j) disponibilite documentee des monetization SDKs (ads/IAP/leaderboards) avec integration paths. **Pixel-art specifiques** : (k) nearest-neighbor sampling natif, (l) integer scaling support, (m) zero sub-pixel drift verifiable via screenshot-diff. **User-facing** : (n) retention D1/D7 des jeux reference, (o) median touch-to-visual latency ms, (p) distribution rating App Store/Play Store des jeux built avec I. |
| **Co** | Solo ou small team indie (ISO/IEC 29110-4-3 VSE) ; Android + iOS mandatory ; offline-first avec cloud save optionnel ; pixel-art (nearest-neighbor, integer scaling — non-negotiable) ; portrait lock ; conformite Apple App Store Review Guidelines §2-5 + Google Play Developer Program Policy + Google Play Families Policy (si audience <13 ans) + Apple HIG Games section ; 2026 baseline (Android 14+ / iOS 17+, Android 15 / iOS 18 imminent) ; monetization SDKs (ads/IAP/leaderboards) integrable sans forker l'engine ; maintainability horizon ≥ 3 ans. |
| **Question** | "Pour un dev indie solo ou petite equipe (1-5) developpant un jeu mobile 2D pixel-art portrait cross-platform Android+iOS avec gameplay offline-first, cloud save optionnel, et monetisation ads+IAP+leaderboards, **quelle classe d'engines 2D mobile-capables** (decouverte systematiquement en Phase 2.1) produit le meilleur compromis entre (a) performance runtime (frame time, launch time, bundle size, memory, battery, crash rate), (b) productivite dev (time-to-prototype, build iteration time, learning curve), (c) fidelite pixel-art (nearest-neighbor, integer scaling), (d) integration monetization SDKs, et (e) conformite stores — dans le contexte VSE/indie avec horizon maintenance ≥ 3 ans ?" |
| **Anchor** | **SWEBOK v4** : KA2 Architecture (pattern selection fondamental), KA3 Design (framework-imposed constraints), KA4 Construction (toolchain couple), KA12 Software Quality (maintainability), KA16 Computing Foundations (runtime model). **ISO/IEC 25010:2023** : Performance Efficiency (time, resource, capacity), Compatibility (co-existence, interoperability avec store SDKs), Maintainability (toutes sous-carac.), Portability (adaptability Android+iOS, installability), Reliability (faultlessness via crash-free rate). **ISO/IEC 25019:2023** : User engagement (retention), Freedom from risk (perf stable). **ISO/IEC 25023** : metric operationalization. **ISO/IEC 29110-4-3** : VSE profile (P context). **Apple App Store Review Guidelines** §2.3.1 (performance, launch time), §2.5 (software requirements). **Google Play Developer Program Policy** (technical quality, 64-bit, App Bundle). **Apple HIG Games** (niveau 5, enterprise design system). |

**Sous-findings absorbes** (ex-A2, A3, A4b paradigm, A5) :
- **A2 Language** : deduction directe de la selection A1 (langue prescrite par l'engine). Si la Phase 2.1 surface un engine polyglot avec degre de liberte reel (ex: Godot GDScript vs C#), la sous-finding est documentee dans l'extraction de ce candidat A1 specifique, pas comme PICOC separe.
- **A3 Rendering** : couvert par outcomes (k)(l)(m) pixel-art de A1. Si la Phase 2.1 surface un framework A1 candidat SANS renderer 2D optimise (ex: pure bindings SDL/GLES3), PICOC A3 sera activee en sous-question conditionnelle (Phase 1.5b revisite).
- **A4b Paradigm (ECS/OOP)** : couvert par outcomes (h)(i) productivite + maintainability de A1.
- **A5 Scene management** : couvert par outcomes (h) productivite + par PICOC A7 pour les concerns save-on-interrupt.

---

### PICOC #A4' — Simulation update strategy (timing model & determinism)

| Element | Valeur |
|---------|--------|
| **P** | Dev indie solo ou petite equipe implementant la **boucle de simulation** d'un jeu mobile 2D pixel-art ou le gameplay depend d'update behavior deterministe ou near-deterministe : mouvement pixel-perfect, runs replayables, scores leaderboard-submittable verifiables. Tourne sur hardware Android/iOS heterogene (60/90/120 Hz displays, CPU battery-throttled, OS-driven vsync). |
| **I** | Classe des **patterns de timestep et d'update-decoupling** : fixed-step simulation avec render interpole/extrapole ; variable-step simulation ; semi-fixed/accumulator (style Fiedler) avec max dt clamped ; deterministe vs non-deterministe integration. Dans le sous-espace autorise par la configuration de l'engine A1 (le threading model impose par l'engine est une **contrainte**, pas un intervention). |
| **C** | À découvrir systématiquement en Phase 2.1. **Pre-identification prohibée per Amendement G-1.** Sources attendues : literature real-time simulation (gafferongames.com, Gregory "Game Engine Architecture" Ch. 8), ACM DL game pattern papers, engine defaults audits, GDC Vault talks. |
| **O** | **Mesurables** : (a) input-to-visual latency median + p95 en ms (target ≤ 2 frames @ 60 Hz = ~33 ms) ; (b) simulation jitter = variance σ² du dt effectif sur 60 s gameplay sample ; (c) determinism rate = % de runs identiques sur 100 replays d'une input sequence enregistree sur meme device (target ≥ 99%) ; (d) frame drops % sur 60/90/120 Hz panels ; (e) CPU time par simulation step en ms ; (f) behavior sous thermal throttling (onset time en s avant first throttle event). **User-facing** : (g) perceived smoothness (Likert 5-point pilot testing) ; (h) leaderboard score reject rate (non-reproducible score submissions rejected par validation). |
| **Co** | Pixel-art : tolerance elevee au stutter visuel (mouvement discret) MAIS determinisme critique pour leaderboard integrity ; portrait lock ; offline-first (pas de reconciliation server-side pour masquer non-determinisme) ; OS background/foreground interrompt la boucle ; thermal throttling change le frame budget in-session. Leaderboards : Apple App Store review (score validation), Google Play server-side validation best practices. |
| **Question** | "Pour un jeu 2D pixel-art mobile deterministic-leaning tournant sur devices Android+iOS variable-refresh et thermally throttled avec leaderboard-eligible gameplay, **quelle classe de pattern timestep** (fixed interpole, variable, semi-fixed accumulator, autre decouvert en Phase 2.1) minimise input latency + jitter + frame drops tout en preservant determinism replay, dans les contraintes du threading model impose par l'engine A1 ?" |
| **Anchor** | **SWEBOK v4** : KA2 Architecture (control-flow styles), KA3 Design (real-time/reactive patterns), KA16 Computing Foundations (concurrency, timing). **ISO/IEC 25010:2023** : Performance Efficiency (Time behaviour — response, throughput), Reliability (Maturity — deterministic replay, Fault tolerance sous frame drops). **ISO/IEC 25019** : Quality in Use (Freedom from risk — leaderboard integrity). **Apple App Store Review Guidelines** §2.3.1 (accurate reliable performance), §2.5.1 (no excessive battery drain). **Google Play** ANR / jank thresholds (Play Vitals). |

**Dependance** : partial dependance sur A1 (le threading model et l'autorisation d'override du timestep par defaut sont engine-dependent). Phase 2.1 extraction doit separer : (i) pattern fondamental (pre-existant dans la literature cross-engine), (ii) configurabilite dans chaque candidat A1.

---

### PICOC #A6 — Touch input abstraction, gesture recognition & accessibility

| Element | Valeur |
|---------|--------|
| **P** | Dev indie solo ou petite equipe implementant la **couche input** d'un jeu mobile 2D pixel-art portrait, avec gameplay reposant sur tap + swipe + long-press + optionnellement multi-touch (pinch exclu pour portrait pixel-art ; drag + two-finger secondary action dans le scope si genre compatible), engagement explicite de conformite WCAG 2.2 target-size (AA 24×24 CSS px equivalent, AAA 44×44) et Apple HIG minimum tappable area (44×44 pt). |
| **I** | Classe des **approches d'abstraction input et gesture recognition** : event-driven low-level touch handling ; gesture recognizer components ; declarative input-mapping systems ; accessibility-integrated input (switch control, VoiceOver/TalkBack focus) ; sensor-fusion input (accelerometer/gyro) optionnel si gameplay le requiert. |
| **C** | À découvrir systématiquement en Phase 2.1. **Pre-identification prohibée per Amendement G-1.** Sources attendues : GitHub topics `gesture-recognition`/`touch-input`/`virtual-joystick`, ACM CHI/UIST papers mobile input latency, engine doc crawls, Apple HIG gesture reference, Material Design gesture reference, mobile-input benchmarking repos. |
| **O** | **Mesurables** : (a) touch-to-visual latency median + p95 en ms ; (b) gesture recognition accuracy (TP/FP rate tap vs long-press vs swipe vs drag, test harness standardise) ; (c) multi-touch correctness sous stress (tracked-finger-id stability) ; (d) cross-platform parity — diff recognition thresholds Android vs iOS (ms, px) ; (e) mis-tap rate % user playtests sur target-size-compliant controls ; (f) % controls meeting WCAG 2.2 SC 2.5.8 (Target Size Minimum) + Apple HIG 44pt ; (g) implementation effort LOC + dev-hours pour ajouter new gesture. **User-facing** : (h) accessibility-user reported usability (pilot avec ≥ 1 assistive-tech user en Phase 3) ; (i) rage-tap incidence analytics. |
| **Co** | Portrait lock ; pixel-art UI (target visuel peut etre < hit-target) ; single-hand thumb-reach ergonomics ; Android + iOS parity requise ; App Store rejection risk sur ASRG 1.5 / 5 (accessibility concerns) ; Google Play Families Policy si mixed ages. Gesture conflicts avec system gestures (iOS edge swipes, Android gesture-back nav) a gerer. |
| **Question** | "Pour un jeu mobile 2D pixel-art portrait avec gameplay tap/swipe/long-press et optionnel multi-touch, **quelle classe d'abstraction input + gesture recognition** (decouverte en Phase 2.1) maximise le compromis recognition accuracy + input latency + WCAG 2.2/HIG accessibility + implementation effort + cross-platform parity, etant donne les input primitives exposees par A1 ?" |
| **Anchor** | **SWEBOK v4** : KA2 Architecture, KA3 Design (UI design), KA12 Software Quality, KA13 Software Security (input validation secondary). **ISO/IEC 25010:2023** : Performance Efficiency (Time behaviour — input latency), Usability (Operability, User error protection, Inclusivity/Accessibility), Compatibility (Interoperability avec OS gesture systems), Portability (Adaptability Android+iOS). **ISO/IEC 25019** : User engagement, Satisfaction. **W3C WCAG 2.2** : SC 2.5.1 Pointer Gestures, 2.5.5/2.5.8 Target Size, 2.5.7 Dragging Movements. **Apple HIG Games** + Apple HIG Gestures. **Material Design** Gestures. **Apple App Store Review Guidelines** §1.5 accessibility, §5 safety. |

---

### PICOC #A7 — Offline-first local persistence & optional cloud-save sync

| Element | Valeur |
|---------|--------|
| **P** | Dev indie solo ou petite equipe construisant un jeu mobile 2D pixel-art dont le **gameplay core tourne entierement offline** (flights, metros, reseaux instables), avec **cloud save optionnel** cross-device et cross-platform, gestion des save-state conflicts quand meme user joue sur plusieurs devices, preservation des IAP entitlements + leaderboard score validity sur reinstalls. Lifecycle mobile hostile : OS kill possible a tout moment (Android low-memory, iOS background termination). |
| **I** | Classe des **architectures offline-first persistence + sync** : local file-based saves, embedded relational stores, embedded key-value stores, document-oriented local stores, avec sync strategies pairees (last-write-wins, version-vector, CRDT-based merge, server-arbitrated reconciliation), sur backends cloud platform-native ou third-party. |
| **C** | À découvrir systématiquement en Phase 2.1. **Pre-identification prohibée per Amendement G-1.** Sources attendues : academic literature offline-first (CRDTs, Automerge, Yjs papers), GitHub topics `offline-first`/`sync`/`save-game`, Apple CloudKit + Google Play Games Services docs, indie postmortems sur cross-device sync. |
| **O** | **Mesurables** : (a) save/load latency en ms pour game state representative (~500 KB) ; (b) conflict-resolution correctness = % scenarios multi-device resolus sans data loss (simule en test harness) ; (c) sync bandwidth en KB/session ; (d) recovery time apres offline→online transition en s ; (e) storage footprint en MB on-device ; (f) IAP entitlement restoration success rate sur reinstall (test matrix) ; (g) save integrity sous OS kill (zero corrupted save sur N=100 force-kill tests mid-save). **User-facing** : (h) reported save-loss incidence store reviews, (i) cross-device continuity satisfaction score user pilot. |
| **Co** | Offline-first mandatory, cloud **optionnel** et doit degrader gracefully ; Apple StoreKit entitlement restoration requise (ASRG 3.1.1) ; Google Play Billing v6+ consistency ; GDPR/COPPA si Families Policy applique ; end-user privacy expectations 2026 ; team inability to operate custom backend → argument vers platform-native solutions mais Phase 2.1 doit confirmer empiriquement, pas presumer. Hosting costs : zero toleration (indie budget). |
| **Question** | "Pour un jeu mobile 2D pixel-art offline-first Android+iOS avec cloud save optionnel cross-device, **quelle classe de pattern persistence locale + sync architecture** (decouverte en Phase 2.1) minimise save/load latency + storage footprint + conflict-driven data-loss risk tout en satisfaisant exigences stores (ASRG 3.1.1 entitlement restoration, Play Data Safety) + privacy regulations + sustainability cost indie, dans les contraintes des file + network APIs de A1 ?" |
| **Anchor** | **SWEBOK v4** : KA2 Architecture (data architecture, offline-first patterns), KA6 Operations (lifecycle, sync), KA13 Software Security (data-at-rest, PII handling). **ISO/IEC 25010:2023** : Reliability (Recoverability — sauvegarde sous OS kill, Fault tolerance offline→online), Security (Confidentiality, Integrity save data), Performance Efficiency (Time behaviour save/load). **ISO/IEC 25019** : Freedom from risk (data loss). **Apple App Store Review Guidelines** §3.1.1 (restore purchases). **Google Play Developer Program Policy** (Data Safety section). **Google Play Families Policy** / COPPA / GDPR si in-scope. **Apple Privacy Manifest** requirements. |

**Absorbes** : lifecycle-event correctness + save-on-interrupt ex-A5 (outcome (g) de A7).

---

### PICOC #A8 — Cross-platform asset pipeline & bundle architecture

| Element | Valeur |
|---------|--------|
| **P** | Dev indie solo ou petite equipe shippant un jeu mobile 2D **pixel-art** Android + iOS, gerant sprites + tilemaps + sprite-atlas packing + multi-resolution output pour ecrans heterogenes (ldpi→xxxhdpi, @1x→@3x), choix de format de texture compression (ASTC devices recents, ETC2 fallback Android, PVRTC legacy iOS si besoin), encoding audio assets, bundle splitting contre cap Google Play (150 MB base APK, App Bundle delivery) et Apple App Store (200 MB cellular-download cap). |
| **I** | Classe des **architectures asset pipeline + bundle** : manual export pipelines, engine-integrated asset import pipelines, scripted CI-driven pipelines, atlas packers (runtime vs build-time), compressed-texture toolchains, app-bundle splitting strategies (per-density, per-ABI, asset packs / on-demand resources). Inclut le workflow "asset → import → package → deploy" end-to-end. |
| **C** | À découvrir systématiquement en Phase 2.1. **Pre-identification prohibée per Amendement G-1.** Sources attendues : GitHub topics `texture-packer`/`sprite-atlas`/`asset-pipeline`, Google Play Asset Delivery + Apple On-Demand Resources docs, GDC talks asset pipelines indie, pixel-art community tooling surveys, Toftedahl & Engstrom 2021 SMS (localization) pour engines catalogues. |
| **O** | **Mesurables** : (a) final release bundle size par platform en MB (APK + AAB splits pour Android, IPA pour iOS) ; (b) runtime texture memory footprint en MB sur reference device ; (c) asset-build time from clean en s ; (d) pixel-art visual fidelity objective = zero filtering artifacts + integer scaling preserve (screenshot-diff test) ; (e) pixel-art fidelity subjective = expert-eye diff vs source ; (f) dev-hours pour ajouter un new asset end-to-end (sprite → deploy) ; (g) bundle split correctness = user telecharge seulement les assets needed pour sa config ; (h) asset hot-reload latency dev-time (edit sprite → voir in-app) en s. **User-facing** : (i) install-size friction (Play Console install-conversion delta vs bundle size) ; (j) first-run perceived quality (pas blurry sprites) ; (k) storage-footprint complaints dans store reviews. |
| **Co** | Pixel-art exige nearest-neighbor + integer scale — contraint fortement filtering + compression (lossy block compression peut mangler pixel-art) ; Android App Bundle mandatory sur Play depuis Aug 2021 ; Apple App Thinning standard ; team cannot afford dedicated build engineer ; CI budget typiquement free-tier GitHub Actions / Xcode Cloud free. Store gates : Play size limits, App Store thinning. |
| **Question** | "Pour un jeu mobile 2D pixel-art cross-platform Android+iOS built par solo/small team, **quelle classe de pattern asset-pipeline + bundle-architecture** (decouverte en Phase 2.1) minimise release bundle size + runtime texture memory tout en preservant fidelite pixel-art + maintenant asset-build time + dev overhead acceptable + hot-reload efficace, dans les contraintes Play App Bundle + App Thinning + CI free-tier ?" |
| **Anchor** | **SWEBOK v4** : KA2 Architecture (deployment architecture), KA4 Construction (build systems), KA8 Configuration Management (asset/artifact management), KA9 Management (effort). **ISO/IEC 25010:2023** : Performance Efficiency (Resource utilization texture memory + bundle size), Compatibility (Interoperability avec stores), Portability (Adaptability multi-density + multi-ABI). **Google Play Developer Program Policy** (App Bundle mandate, size optimization). **Apple App Store Review Guidelines** §2.3 (accurate metadata, app thinning). |

**Note PO** : cette PICOC adresse directement le pain point documente ("identifier manuellement ou est l'asset dans le PNG est fastidieux"). L'outcome (h) asset hot-reload + (f) dev-hours to add asset sont des proxies mesurables de ce pain point.

---

## Decisions dropped / merged

| Decision | Action | Justification | Redirection |
|----------|--------|--------------|-------------|
| A2 Programming language | DROP merged into A1 | Deduit de l'engine choix dans 100% des 2D mobile engines mainstream. Comparaison cross-engine confondrait language + engine. | Sub-finding dans A1 outcome (h) learning curve + (i) maintainability |
| A3 Rendering pipeline | DROP deducible from A1 | P = VSE/solo → custom renderer hors scope. Pixel-art fidelity = config dans engine. | Outcomes A1 (k)(l)(m) pixel-art fidelity. Revisite Phase 1.5b si Phase 2.1 surface framework candidate SANS 2D renderer |
| A4b Game loop paradigm (ECS/OOP) | DROP merged into A1 | Paradigme fortement engine-prescribed → confoundment risk. | A1 outcomes (h) productivity + (i) maintainability |
| A5 Scene management | DROP deducible from A1 | Scene graph = primitive engine-provided ubiquitous. | Lifecycle concerns → A7 outcome (g). IAP flow → Batches D/E |

## Open questions pour reconciliation / Phase 1.5

### Questions de scope a trancher par PO avant Phase 2.1

1. **Placement de A7 et A8 dans Batch A** vs deferral a batch ulterieur (ops/build) — OK par superviseur, a confirmer PO. Rationale : decisions architecturales early-bound.
2. **Cloud save provider split** (platform-native iCloud/GPGS vs third-party backend) — keep as single A7 ou split en A7a persistence + A7b sync backend ? Decision : **keep A7 single** avec outcome explicit diff (platform-native vs third-party) comme sub-finding en extraction Phase 2.4.
3. **Reference device 2026** — Pixel 6a / iPhone SE 2022 (Reviewer B) vs Pixel 4a / iPhone SE 2020 (Reviewer A) ? Decision : **Pixel 6a + iPhone SE 2022** pour 2026 baseline (plus representatif devices utilises fin 2025). A fixer definitivement en Phase 1.4 amendments.
4. **Determinism threshold A4'** — ≥ 99% replay identical runs accepte ? Decision : a fixer en Phase 1.4 apres pilot.
5. **Accessibility scope dans A6** — WCAG 2.2 + HIG integral (Reviewer B framing) vs gesture-only (alternative) ? Decision : **B framing retenu** — accessibility est partie integrante input architecture per ISO 25019.

### Questions pour Agent C (Phase 1.5 verification)

6. Verifier verbatim : **Apple App Store Review Guidelines §2.3.1** existe et contient le claim "performance/launch time" reference en A1 outcome (b).
7. Verifier verbatim : **Google Play 150 MB base APK limit** est toujours en vigueur 2026 (peut avoir change avec App Bundle mandate).
8. Verifier : **ISO/IEC 29110-4-3 VSE profile** (partie 4-3) existe et s'applique au P solo/indie (vs partie 4-1 etc.).
9. Verifier : **WCAG 2.2 SC 2.5.8 Target Size Minimum** (Level AA 24×24) et **SC 2.5.5/AAA 44×44** — cites corrects.
10. Verifier fabrication : tous les anchors ISO/NIST/W3C/SWEBOK existent.

### Questions pour Phase 2.1 (extraction)

11. Phase 2.1 discovery doit explicitement documenter **l'ensemble C final pour A1** apres screening (I1-I5, E1-E6). Target : au moins 8-15 candidats survivant au screening.
12. Phase 2.1 pour A7 doit chercher sources sur **CRDT vs last-write-wins** specifiquement pour game save context (pas juste collaborative editing generique).
13. Phase 2.1 pour A8 doit chercher specifiquement **pixel-art preservation sous texture compression** (ASTC/ETC2/PVRTC lossy impact).

## Statut de Batch A

- **5 PICOCs retenues** : A1, A4', A6, A7, A8
- **Coverage matrix provisoire** : mappee sur ISO 25010 Performance/Compatibility/Maintainability/Portability/Reliability + SWEBOK KA2/KA3/KA4/KA6/KA8/KA13/KA16
- **Sensibilite au biais** : kappa brut 50% — rapporte honnetement, arbitrage superviseur documente, aucune divergence muette
- **Next step** : Batch B (asset pipeline detaille — 5 candidates, mais A8 couvre deja le bundle-level ; Batch B devra se concentrer sur les pipeline tools a une couche plus fine : sprite atlas packing tools, tile editors, font pipelines, audio mixer, asset watcher)

**APPROVED pour Phase 1.3 Batch B formulation.**
