# Phase 1.2 — Scope : domaine `mobile-game-2d`

**Protocole** : `methodology.md` v3.0, section 1.2 (Kitchenham & Charters 2007 §5.2, Commissioning), + Amendement G-1 (anti-biais, 2026-04-21)
**Date** : 2026-04-21
**Methode** : double extraction (Reviewer A + Reviewer B, contextes isoles) + verification sources (Agent C isole) + reconciliation superviseur
**Tracability** : `verification/extractions/phase-1-2-mobile-game-2d-scope.md` (a produire lors du pilot 1.5)

## Sujet du nouveau domaine

Domaine `mobile-game-2d` : decisions techniques pour **developper un jeu mobile 2D destine a une distribution grand public** (Apple App Store + Google Play) par un dev indie / petite equipe (≤ 5 personnes), en respectant :

- Les contraintes runtime du mobile (frame budget, memoire, batterie, stockage, thermal)
- Les exigences des stores (Apple App Store Review Guidelines, Google Play Developer Program Policy)
- Les patterns architecturaux specifiques aux jeux (game loop, scene graph, asset pipeline, input, audio mixer)
- Les besoins typiques d'un jeu commercial ou hobbyist (sauvegarde, progression, monetisation, classements, multi-langue)

## Justification de l'ajout du domaine

Le domaine est justifie par le gate Phase 1.1 (DARE) — voir `verification/dare/mobile-game-dare.md` : aucune SLR existante ne couvre ce scope a DARE >= 2.5/5.

**Justifications complementaires** :

1. **methodology.md §1.2 (post-Amendement G-1)** liste le mobile game (2D/3D) comme "Pas couvert" — le domaine a donc un mandat explicite pour une SLR dediee.
2. **Conformement a la Regle anti-biais (§1.2 post-G-1)** : ce fichier de scope NE PRE-IDENTIFIE PAS de frameworks/engines candidats. Les alternatives seront decouvertes systematiquement en Phase 1.3 via les bases appropriees.
3. **Separation `mobile-game` vs `mobile-app`** : le P est fondamentalement different. Un jeu mobile a un game loop, un asset pipeline pixel/sprite, un frame budget serre (16.67 ms pour 60 fps), un modele de monetisation typiquement IAP+ads, et des dependances SDK specifiques (Game Center, Google Play Games Services) — la plupart absents du P "mobile-app". Traiter les deux ensemble produirait un P flou et des PICOCs inapplicables.
4. **Separation 2D vs 3D** : le 3D mobile a un pipeline PBR/mesh/skinning, un moteur physique 3D, et des engines dominants radicalement differents (Unity/Unreal vs. 2D-focused). Le present scope se limite explicitement au 2D ; le 3D fera l'objet d'une SLR separee (`mobile-game-3d`).

## Ancrage de scope — 3 niveaux (coherence avec methodology.md §1.2)

### Niveau 1 — SCOPE (quels sujets couvrir)

Le scope heritant du guide (ISO 25010:2023 + ISO 25019:2023 + SWEBOK v4) est **etendu** pour ce domaine avec les standards mobile-game-specifiques suivants.

#### Standards PRIMARY — inherites du guide global

| # | Standard | Role | Acces |
|---|----------|------|-------|
| 1 | **ISO/IEC 25010:2023** | Product quality model — 9 caracteristiques applicables aux jeux | [iso.org/standard/78176](https://www.iso.org/standard/78176.html) |
| 2 | **ISO/IEC 25019:2023** | Quality-in-use model — particulierement critique pour les jeux (User engagement, Satisfaction, Freedom from risk) | [iso.org/standard/78177](https://www.iso.org/standard/78177.html) |
| 3 | **SWEBOK v4 (2024)** | 18 knowledge areas — applicables aux decisions de dev de jeu | IEEE Computer Society |
| 4 | **ISO/IEC 25023** | Metriques pour ISO 25010 | [iso.org/standard/35747](https://www.iso.org/standard/35747.html) |
| 5 | **ISO/IEC/IEEE 12207:2017** | Software life cycle processes | [iso.org/standard/63712](https://www.iso.org/standard/63712.html) |

#### Standards PRIMARY — specifiques mobile-game-2d

| # | Standard / source | Role | Acces |
|---|----------|------|-------|
| 6 | **Apple App Store Review Guidelines** | Exigences techniques normatives pour publier sur App Store : performance (20s launch), memoire, IAP obligatoire pour currency de jeu, safety, mini-apps | [developer.apple.com/app-store/review/guidelines](https://developer.apple.com/app-store/review/guidelines/) (free, verbatim) |
| 7 | **Google Play Developer Program Policy** | Exigences techniques normatives pour publier sur Play Store : target audience, ads, families policy, privacy, IAP | [support.google.com/googleplay/android-developer/answer/16944162](https://support.google.com/googleplay/android-developer/answer/16944162?hl=en) (free) |
| 8 | **Google Play Families Policies** | Exigences additionnelles si audience <13 ans ou mixte (Ads SDK certifies, data privacy) | [support.google.com/googleplay/android-developer/answer/9893335](https://support.google.com/googleplay/android-developer/answer/9893335?hl=en) (free) |
| 9 | **W3C WCAG 2.2** | Accessibility — applique aux jeux via App Store/Play review et reglementation (EAA 2025 en UE) | [w3.org/TR/WCAG22](https://www.w3.org/TR/WCAG22/) (free) |
| 10 | **ISO/IEC 29110-4-3** | Profil Very Small Entity (VSE) — applicable au dev indie solo / petite equipe. Seulement cite en contexte (limites documentees par Kasurinen & Laine 2013 qui trouvent le profil VSE trop waterfall pour le jeu) | [iso.org/standard/58835](https://www.iso.org/standard/58835.html) |

**Verbatim cles a verifier en Phase 1.5 par Agent C** :

- Apple App Store Review Guidelines §2.5.1 (Performance) : *"Apps should start up quickly and stay responsive"* + launch time limit (verifier chiffre 20s)
- Apple App Store Review Guidelines §3.1.1 (In-App Purchase) : *"If you want to unlock features or functionality within your app [...] you must use in-app purchase"*
- Google Play Developer Program Policy — section "Families" + "Ads" + "Privacy, Deception, Device Abuse"
- WCAG 2.2 Success Criteria applicables : 1.4.3 Contrast, 2.1.1 Keyboard (ou equivalent touch), 2.5.5 Target Size (AAA — applicable)

#### Standards SECONDARY (cite-only, hors anchors principaux)

| # | Standard | Role |
|---|----------|------|
| 11 | **ISO/IEC 30113-12:2019** | Information technology — User interface — Gesture-based interface | Peut eclairer input tactile si PICOC emerge |
| 12 | **PEGI / ESRB** rating systems | Content rating | Non-technique (decision produit) — cite-only pour contexte store |
| 13 | **Apple Human Interface Guidelines (HIG)** — section Games | Design system Apple — niveau 5 (enterprise design system) | Hook si PICOC UX emerge |
| 14 | **Material Design 3** — adaptation aux jeux | Design system Google — niveau 5 | Idem |

### Exclusions explicites (scope)

Le domaine `mobile-game-2d` **exclut explicitement** les topics suivants (a couvrir en SLR separees si besoin) :

- **Jeux mobiles 3D** (mesh rendering, PBR, physique 3D, skinned meshes) → SLR dediee `mobile-game-3d`
- **Jeux console/PC AAA** → hors P (budget, equipe, contraintes radicalement differents)
- **Jeux web / PWA** → couvert par `web-mobile-strategy.md` (batch 16) + eventuel futur `web-game` SLR
- **Jeux AR/VR/MR mobile** → SLR dediee future (ARKit, ARCore, Vision Pro ont leur propre stack)
- **Gambling / real-money games** → standards distincts (iGSA, GLI, legal streams par juridiction). Exclu du P.
- **Serious games / educational games** → P distinct, standards distincts (effectiveness pedagogique)
- **Game content design** : level design, balancing economy, narrative, monetization optimization par genre — decisions **produit**, pas techniques. Hors scope EBSE — `ebse-scaffold` ne tranche pas le design produit.
- **Multiplayer realtime architecture** (matchmaking, netcode, dedicated servers, anti-cheat multi-joueur) → si besoin emerge, SLR dediee `game-netcode`
- **Contenu / narrative / assets art direction** → hors scope EBSE

### Niveau 2 — MESURE (comment savoir si c'est atteint)

- **ISO/IEC 25023** (inherited) — metriques ISO 25010
- **Google Play Android Vitals** metrics : ANR rate, Crash rate, Excessive wakeups, Excessive Wake locks, Stuck partial wake locks, Slow rendering (>16 ms, >700 ms), Slow cold startup (>5s), Frozen frames — niveau 3 (platform official)
- **Apple App Store Connect Analytics** + **MetricKit** — crash rate, hang rate, battery, memory — niveau 3
- **Sensor Tower / data.ai / Appfigures** — market metrics (DAU, retention, LTV) — niveau 4

### Niveau 3 — OPERATIONNALISATION (standards specialises par domaine)

Les standards operationnels emergeront des PICOCs en Phase 1.3. Anticipation (a verifier en 1.3) :

- **OWASP Mobile Top 10** / **OWASP MASVS** — si PICOC securite mobile (client-side auth, IAP receipts, save tamper) emerge
- **Google Developer Play Games Services** — si PICOC leaderboard/achievements emerge
- **Apple GameKit / Game Center** — idem
- **Google Mobile Ads SDK (AdMob)** — si PICOC ads emerge
- **Apple StoreKit 2** — si PICOC IAP emerge
- **Google Play Billing Library** — idem
- **LDtk, Tiled** — si PICOC tile-editor emerge (a decouvrir, pas pre-identifier)
- **GPUDriver docs** (Vulkan, Metal, OpenGL ES) — si PICOC rendering emerge

## Equipe de recherche (section 1.2 methodology.md)

- **Reviewer A** : Agent IA 1 (contexte isole par session)
- **Reviewer B** : Agent IA 2 (contexte isole par session)
- **Agent C** : Verificateur de sources + fabrications (contexte isole, role separe A/B) — verifie aussi les noms de tools/SDKs (Amendement #2 ai-collaboration)
- **Superviseur humain** : Gabriel (approbation du protocole, resolution des divergences non tranchees par C, validation scope)

## Scope et plateformes

| Plateforme | Applicabilite domaine `mobile-game-2d` |
|-----------|----------------------------------------|
| **Android** (phone + tablet) | Oui — primary scope |
| **iOS** (iPhone + iPad) | Oui — primary scope |
| **Cross-platform Android + iOS** | Oui — primary scope (cas le plus courant pour indie) |
| **Web** (navigateur) | Hors scope (guide existant) — sauf hybride web-mobile |
| **Windows/Mac/Linux desktop** | Hors scope principal ; pertinent uniquement si un engine cross-platform le fournit "gratuitement" (Godot, Unity, Flame/Flutter, etc.) |
| **Console (Switch, PS5, Xbox)** | Hors scope |

**Note importante** : pour le pilot 1.5, le P sera restreint au cas `solo-dev + 2D + pixel art + portrait + offline-first avec cloud save optionnel + stores + monetisation gems via ads+IAP`, correspondant a l'application Acres. Les recommandations seront ensuite generalisees a d'autres P compatibles (autres genres 2D, orientation landscape, paid-premium au lieu de freemium, etc.) via variantes dans le JSON de sortie.

## Matrice de couverture (placeholder pour Phase 1.3)

La matrice complete `sub-caracteristiques ISO 25010 × SWEBOK sous-topics` pour `mobile-game-2d` sera construite en Phase 1.3 avec double extraction. Pre-identification des cellules probablement actives (a valider en 1.3) :

| Sub-caracteristique ISO 25010 | KA SWEBOK pertinente | Decision probable |
|-------------------------------|---------------------|-------------------|
| PE Time behaviour | KA 2 + KA 16 | Game loop architecture, frame budget |
| PE Resource utilization | KA 2 + KA 16 | Memoire, batterie, thermal |
| PE Capacity | KA 2 + KA 4 | Asset count, sprite atlas taille, store bundle limit |
| IC User engagement | KA 3 + KA 12 | Game feel, progression, feedback loops |
| IC Operability | KA 3 | Controles tactiles, one-thumb design |
| IC Inclusivity | KA 3 | Colorblind modes, screen reader, scaling |
| Re Faultlessness | KA 5 + KA 12 | Crash-free session rate (store ranking factor) |
| Re Recoverability | KA 4 | Save-on-interrupt, resume state |
| Se Integrity | KA 13 | Save file tamper prevention, IAP receipt validation |
| Ma Modifiability | KA 4 | Content updates, LiveOps, config remote |
| Ma Testability | KA 5 | Automated game testing (challenges) |
| Fl Installability | KA 6 | AAB/IPA, install size, asset delivery |
| Fl Adaptability | KA 4 | Multiple screen sizes, aspect ratios |
| Fu Correctness | KA 4 + KA 5 | Game state consistency, save/load |
| Sa Operational constraint | KA 14 + KA 12 | Dark patterns, addiction risk, loot box regulation |

(Les cellules finales + decisions fixees par double extraction en Phase 1.3.)

## Pre-identification des decisions candidates du domaine

Liste de depart pour Phase 1.3 (formulation PICOC). **Aucune solution pre-identifiee** — les alternatives C seront decouvertes systematiquement par reviewer en Phase 1.3. Chaque decision est une question a resoudre via EBSE.

### Categorie A — Framework et architecture

1. **Mobile game framework/engine** (central — determine la majorite des autres decisions)
2. **Langage de programmation** (typiquement determine par l'engine — mais a verifier)
3. **Rendering pipeline / graphics abstraction** (conditionnel sur l'engine)
4. **Game loop architecture** (fixed timestep, variable, ECS, MVC, etc.)
5. **Scene / screen management** (scene graph, router, stack)
6. **Input abstraction** (touch events, gestures, multi-touch)

### Categorie B — Asset pipeline

7. **Sprite atlas / texture packing** — *point de douleur identifie par le PO : "identifier manuellement l'asset dans le PNG"*
8. **Tile-based level editor / pipeline**
9. **Asset import / hot reload workflow**
10. **Font rendering** (bitmap font pour pixel art, TTF avec hinting, SDF)
11. **Audio mixer / sound pipeline** (music + SFX, ducking, crossfade)

### Categorie C — Persistance

12. **Local save file format** (JSON, binary, protobuf, custom)
13. **Local storage engine** (SQLite, key-value, flat file, embedded DB)
14. **Save-on-interrupt strategy** (autosave, checkpoint, continuous)
15. **Cloud save backend** (Google Play Saved Games, Game Center iCloud, custom)
16. **Save migration strategy** entre versions du jeu

### Categorie D — Store publishing

17. **Publishing workflow Android + iOS** (bundles, signing, review flow)
18. **Bundle format / install size optimization** (AAB, app thinning, on-demand resources)
19. **Dynamic delivery / asset packs** (Google Play Asset Delivery, iOS On-Demand Resources)
20. **Privacy manifest / data safety declaration** (iOS Privacy Manifest, Play Data Safety)
21. **App icon / splash screen pipeline** (adaptive icons, dark mode, multiple densities)

### Categorie E — Monetisation

22. **Ads SDK** (interstitial, rewarded, banner)
23. **In-App Purchase (IAP)** SDK et abstraction cross-platform
24. **Monetization model** (F2P, freemium, premium, subscription) — choix conditionnel au P
25. **Anti-fraud / receipt validation** pour IAP server-side

### Categorie F — Social / plateformes

26. **Leaderboards** (Google Play Games Services, Game Center, backend custom)
27. **Achievements** (Google Play, Game Center, custom)
28. **Cloud-synced player profile / cross-device progression**
29. **Social sharing** (screenshot share, invite friends)

### Categorie G — Multi-langue

30. **Localization workflow** (format de fichiers, editeur, import/export)
31. **Font fallback / multi-script support** (CJK, arabic, cyrillic si applicable)
32. **Pluralization + interpolation format** (ICU, gettext, custom)

### Categorie H — Outillage developpement

33. **CI/CD pour jeu mobile** (build Android+iOS, signing, store upload automatise)
34. **Device testing strategy** (sur quels devices, physique vs emulateur/simulateur, Firebase Test Lab, Xcode Cloud)
35. **Crash reporting** (Crashlytics, Sentry mobile, custom, platform-native)
36. **Analytics pour jeu** (funnel, events, retention)
37. **A/B testing in-app** (config remote, feature flags)
38. **Hot reload / live code** (dev velocity)

### Categorie I — Qualite

39. **Testing strategy pour jeu** (unit pour gameplay logic, integration, playtest, replay-based tests)
40. **Performance budget** (frame time budget, memory cap, install size cap)
41. **Accessibility** specifique au jeu 2D (colorblind, dyslexia, motor assist, reduced motion)
42. **Crash-free rate target** (gate store ranking)

### Categorie J — AI collaboration (herite)

43. **Setup agent IA pour dev de jeu** — herite du domaine `ai-collaboration` (17 decisions existantes). Potentiel ajustement specifique jeu (ex: validation qu'un asset generatif a bien ete rendu correctement).

## Limites documentees (Phase 1.2)

1. **Scope limite au 2D mobile** — le 3D mobile, AR/VR, PC/console, web, serious games, gambling, multiplayer temps-reel sont explicitement exclus. Une SLR future pourra les couvrir.
2. **Abstracts ISO lus via iteh.ai** (pour ISO 29110 et autres paywalled) — corps des standards non fetches verbatim.
3. **Apple HIG et Material Design** traites comme niveau 5 (design systems d'entreprise, pas standards internationaux) — conformement aux clarifications methodology.md §2.3.
4. **ISO/IEC 29110-4-3 VSE profile** retenu en PRIMARY mais avec reserve : une source academique (Kasurinen & Laine 2013) documente que le profil VSE est insuffisamment agile pour le dev de jeux. A reconfirmer en Phase 2.
5. **Sensor Tower, GDC, Slashdata surveys** classes niveau 4 (enquetes grande echelle) avec biais documentes :
   - GDC State of the Industry : biais **PC-focused** (80% PC en 2025) — utilisable uniquement avec extraction de la sous-section mobile
   - Unity Gaming Report : biais **vendor** (conflit d'interet) — flag obligatoire
   - Sensor Tower Big Game Engines Report : biais **top-charts** (echantillon = top mobile games, pas representatif de l'indie solo) — flag lors de l'usage

## Prochaine etape

**Phase 1.3** — Specifying research questions : formulation des questions PICOC pour chaque decision du domaine, **avec C = a decouvrir systematiquement** (pas pre-selectionne), avec double extraction et verification. Le corpus candidat de ~43 decisions ci-dessus sera **valide, raffine, et eventuellement etendu ou reduit** par les reviewers A et B sur la base du scope defini dans ce fichier.

**Pilot Phase 1.5** : sera conduit sur 3 PICOCs representatives couvrant plusieurs categories (ex: D1 framework, D7 sprite atlas pipeline — pain point PO, D22 ads SDK — conditionnel sur categorie monetisation). Le pilot validera (a) le temps moyen par PICOC, (b) le kappa inter-reviewers, (c) l'applicabilite des criteres d'inclusion/exclusion aux sources game dev (qui sont plus helerogenes que le web).

**Status** : scope provisoire, en attente de (1) Reviewer B independant (DARE + scope), (2) validation PO.
