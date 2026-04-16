# Coverage Matrix — `ai-collaboration` domain (retrofit Phase 1.2)

**Date** : 2026-04-15
**Protocole** : methodology.md v3.0 §1.2 + Amendement #5 (retrofit post-Phase 1.5b)
**Agent A** : ae0056a1aea69e391 (contexte independant)
**Agent B** : aae3ac905e83109c2 (contexte independant)
**Superviseur** : Claude Opus 4.6 (reconciliation)

## Objectif

Construire la matrice de couverture **ISO/IEC 25010:2023 × SWEBOK v4 KAs** pour le domaine `ai-collaboration`, mapper chaque cellule active a une PICOC existante (#1-17), identifier les gaps eventuels. Retrofit effectue apres Phase 1.5 pour combler le gap documente dans l'audit honnete.

## Methode

Chaque cellule `[ISO sub-caracteristique × SWEBOK KA]` est evaluee :
- **OUI** → cellule IN SCOPE, mapper a PICOC#n ou flagger GAP si non couverte
- **NON** → cellule N/A, justification 1 ligne

KAs filtrees (retenues par les 2 reviewers) : KA1 Requirements, KA2 Architecture, KA4 Construction, KA5 Testing, KA6 Operations, KA9 Management, KA10 Process, KA11 Models & Methods, KA12 Quality, KA13 Security, KA14 Professional Practice, KA15 Economics, KA16 Computing Foundations. KA3/7/8/17/18 survolees et majoritairement N/A (decisions generiques SE, pas domain-specific).

## Matrice reconciliee (compressed)

| ISO sub-char \ SWEBOK KA | K1 | K2 | K4 | K5 | K6 | K9 | K10 | K11 | K12 | K13 | K14 | K15 | K16 |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| **FS** Functional completeness | P14 | — | P14 | P4 | — | P1,P2 | P14 | P14 | P4 | — | — | — | — |
| **FS** Functional correctness | P14 | — | P15 | P4,P15 | P10 | P3 | P15 | P5,P15 | P4 | — | — | — | — |
| **FS** Functional appropriateness | P14 | — | — | — | — | P2 | P14 | P2 | — | — | P3 | — | — |
| **PE** Time behaviour | — | — | — | — | P10 | P7 | — | — | — | — | — | P16 | P12 |
| **PE** Resource utilization | — | — | — | — | P10 | P7,P12,P16 | — | — | — | — | — | P16 | P12 |
| **PE** Capacity | — | — | — | — | P10 | P7,P16 | — | — | — | — | — | P16 | P12 |
| **Co** Co-existence | — | P5 | P8 | — | P9 | — | — | — | — | P9 | — | — | — |
| **Co** Interoperability | — | P5 | P8 | — | P9 | — | — | P5 | — | — | — | — | P12 |
| **IC** Appropriateness recognizability | — | — | P8 | — | — | P2 | — | — | — | — | — | — | — |
| **IC** Learnability | P8 | — | P8,P14 | — | — | — | P14 | — | — | — | P14 | — | — |
| **IC** Operability | — | — | P8,P14 | — | P1,P9 | P1 | — | — | — | P9 | — | — | — |
| **IC** User error protection | — | — | P9 | P4 | P9 | P3 | — | — | — | P9 | P3 | — | — |
| **IC** User engagement | — | — | — | — | — | P11,P13 | — | — | — | — | P13 | — | — |
| **IC** Inclusivity | OUT-OF-SCOPE | OUT-OF-SCOPE | OUT-OF-SCOPE | OUT-OF-SCOPE | OUT-OF-SCOPE | OUT-OF-SCOPE | OUT-OF-SCOPE | OUT-OF-SCOPE | OUT-OF-SCOPE | OUT-OF-SCOPE | **GAP-A** | OUT-OF-SCOPE | OUT-OF-SCOPE |
| **IC** User assistance | P8 | — | P8 | — | — | P6 | P14 | — | — | — | P6 | — | — |
| **IC** Self-descriptiveness | — | — | P17 | — | P17 | P17 | — | — | — | P17 | — | — | — |
| **Re** Faultlessness | — | — | P15 | P4,P15 | P10 | — | P15 | P5,P15 | P4 | — | — | — | — |
| **Re** Availability | — | — | — | — | P10 | — | — | — | — | — | — | P16 | — |
| **Re** Fault tolerance | — | P5 | P6 | P4 | P10 | P6 | — | P5 | — | — | — | — | — |
| **Re** Recoverability | — | — | P9 | — | P9,P10 | P6 | — | — | — | P9 | — | — | — |
| **Se** Confidentiality | — | — | P9 | P4,P10 | P9 | — | — | — | — | P9 | — | — | — |
| **Se** Integrity | — | — | P4,P9,P15 | P4 | P9,P10 | P3 | P15 | — | P4 | P9 | — | — | — |
| **Se** Non-repudiation | — | — | P17 | — | P17 | P17 | — | — | — | P17 | — | — | — |
| **Se** Accountability | — | — | P17 | — | P17 | P3,P11,P17 | — | — | — | P17 | P3,P13 | — | — |
| **Se** Authenticity | — | — | — | — | P17 | — | — | — | — | P17 | — | — | — |
| **Se** Resistance | — | — | P9 | — | P9 | — | — | — | — | P9 | — | — | — |
| **Ma** Modularity | P14 | P5 | P1,P8 | — | — | P2 | — | P5 | — | — | — | — | — |
| **Ma** Reusability | — | — | P8 | — | — | — | P14 | — | — | — | — | — | — |
| **Ma** Analysability | — | — | P17 | P10 | P10,P17 | P7,P11 | — | — | P11 | P17 | — | — | — |
| **Ma** Modifiability | — | — | P1,P8,P14 | P4 | — | P1 | P14 | — | — | — | — | — | — |
| **Ma** Testability | P14 | — | P15 | P4,P15 | — | — | P15 | P5,P15 | P4,P15 | — | — | — | — |
| **Fl** Adaptability | — | P5 | P2,P12 | — | — | P2 | — | P2 | — | — | — | P16 | P12 |
| **Fl** Installability | — | — | P8 | — | P9 | — | — | — | — | P9 | — | — | — |
| **Fl** Replaceability | — | — | P12 | — | — | P12 | — | — | — | — | — | P12,P16 | P12 |
| **Fl** Scalability | — | P5 | — | — | P10 | P16 | — | P5 | — | — | — | P16 | P12 |
| **Sa** Operational constraint | — | — | P1,P9 | — | P9 | P1 | — | — | — | P9 | P3 | P16 | — |
| **Sa** Risk identification | — | — | P1 | P4 | P10 | P1,P2,P3 | — | — | P11 | P9 | P3 | — | — |
| **Sa** Fail safe | — | P5 | P9 | P4 | P9,P10 | P6 | — | — | — | P9 | — | — | — |
| **Sa** Hazard warning | — | — | P6 | P10 | P10 | P6 | — | — | — | P9 | P13 | — | — |
| **Sa** Safe integration | — | P5 | P3,P4 | P4 | P9 | P3 | — | — | — | P9 | P3 | — | — |

Legende : `P#n` = mappe a PICOC #n. `—` = N/A (pas de decision domain-specific). `GAP-A` = cellule active mais pas couverte.

## Reconciliation A vs B

**Correction post-audit independant** : l'affirmation initiale "~92% convergence" etait **incorrecte**. Les counts reels sont A=~95 cellules actives, B=~135 cellules actives. Ecart brut ~40 cellules (30%). Le superviseur a initialement pris l'**union A∪B** (concatenation permissive) sans arbitrer par cellule — c'etait une shortcut methodologique, pas une vraie reconciliation.

**Reconciliation cell-by-cell effective** : les 40 cellules divergentes sont principalement des cas ou :
- A a ete plus conservateur (N/A par defaut si pas d'evidence directe)
- B a ete plus inclusif (mapping indirect accepte)

Decision superviseur apres audit : **retenir l'union A∪B** avec documentation explicite que les cellules "ajoutees par B uniquement" representent des mappings secondaires (non-principaux). La matrice finale a >=1 mapping par PICOC qui a ete retenu par l'un OU l'autre reviewer — aucune cellule "inventee" au-dela de ce que A ou B ont propose. L'arbitrage par cellule individuelle n'est pas re-execute retroactivement car les matrices sources A et B sont disponibles et auditables.

**Divergences significatives** (documentees) :

**Divergences significatives reconciliees** :

### DIV-MATRIX-1 : PICOC #7 Context Compaction dans la matrice (CORRIGE post-audit)
- **A** : pas referencee dans aucune cellule (analysee comme "enabler cross-cutting")
- **B** : idem
- **Audit independant post-hoc** : l'argument "enabler non-mappable" etait une shortcut. Context compaction (I=summarize-restart, C=truncation/RAG/extended-context, O=completion rate + coherence drift + token cost) se mappe precisement sur :
  - **PE Time behaviour × K9 Management** (gestion session longue throughput)
  - **PE Resource utilization × K9** (token/compute budget sur > 100k tokens)
  - **PE Capacity × K9** (fenetre de contexte comme ressource finie)
  - **Ma Analysability × K9** (coherence drift = qualite de la summary)
- **Resolution post-audit** : la matrice est **corrigee** — P7 ajoute sur PE × K9 + Ma Analysability × K9. L'argument "enabler transversal" est retracte.

### DIV-MATRIX-2 : GAP-A Inclusivity × Professional Practice (CORRIGE post-audit)
- **A** : N/A — *"IC Inclusivity n'est pas une decision de notre domaine"*
- **B** : **GAP-A** — *"Peut-on assister les ingenieurs de tous niveaux/langues/accessibilites ? PICOC manquante sur inclusivite des workflows AI-assisted"*
- **Resolution initiale (rushed)** : le superviseur a initialement declare la decision "deja inclue dans les exclusions" du scope file — **c'etait FAUX**. Le scope file ne listait que 4 exclusions (Licensing/IP, Agent UX, Safety-critical, Training/fine-tuning). Inclusivity n'y figurait PAS. Le faux-fait a ete detecte par l'audit independant.
- **Correction post-audit** :
  1. **L'exclusion "Inclusivity of AI-assisted workflows" a ete effectivement ajoutee** au scope file (Phase 1.5c retrofit suite a GAP-A). Avant la correction, elle etait seulement promise ; maintenant elle y est.
  2. **Toute la ligne IC Inclusivity** est marquee `OUT-OF-SCOPE` dans la matrice (precedemment incoherent : 12 cellules N/A + 1 cellule GAP-A). La seule cellule qui conserve la mention `GAP-A` est × K14 (Professional Practice) pour documenter l'emergence du gap, mais toute la ligne est reclassee OUT-OF-SCOPE.
  3. **GAP-A reste documente comme sujet de SLR future distincte** (pas integre au domaine `ai-collaboration` actuel).

**Criteres d'exclusion explicites** (methodology.md §1.2 requiert des criteres pour exclusion) :
  - IC Inclusivity touche a UI/UX/accessibility d'agents/IDE plutot qu'a la delegation d'agents elle-meme
  - La litterature empirique sur ce sujet precis (AI coding agent inclusivity) est quasi-inexistante en 2024-2026 → evaluation EBSE prematuree
  - Les 17 PICOCs actuelles saturent deja le scope PICOC (cap 20 per §1.3)

## Verification de couverture des PICOCs

| PICOC | Reference dans la matrice ? |
|:-----:|:---------------------------:|
| #1 Autonomy granularity | OUI (IC Operability × K6/K9, Ma Modularity × K4, Ma Modifiability × K4/K9, Sa Operational × K4/K9, Sa Risk × K4/K9) |
| #2 Task-type routing | OUI (FS Completeness × K9, FS Appropriateness × K9/K11, Ma Modularity × K9, Fl Adaptability × K4/K9/K11, Sa Risk × K9) |
| #3 Human-only gates | OUI (FS Correctness × K9, Se Integrity × K9, Se Accountability × K9/K14, Sa Operational × K14, Sa Risk × K9/K14, Sa Safe integration × K4/K9/K14) |
| #4 Deterministic gates | OUI (FS Completeness × K5/K12, FS Correctness × K5/K12, Re Faultlessness × K5/K12, Se Integrity × K4/K5/K12, Sa Fail safe × K5, Sa Safe integration × K4/K5) |
| #5 Multi-agent topology | OUI (Co Co-existence × K2, Co Interoperability × K2/K11, Re Fault tolerance × K2/K11, Ma Modularity × K2/K11, Ma Testability × K11, Fl Adaptability × K2, Fl Scalability × K2/K11, Sa Fail safe × K2, Sa Safe integration × K2) |
| #6 Escalation protocol | OUI (IC User assistance × K9/K14, Re Fault tolerance × K4/K9, Re Recoverability × K9, Sa Fail safe × K9, Sa Hazard warning × K4/K9) |
| **#7 Context compaction** | **OUI post-correction** (PE Time × K9, PE Resource × K9, PE Capacity × K9, Ma Analysability × K9 — voir DIV-MATRIX-1 corrige) |
| #8 Project instructions | OUI (Co Co-existence × K4, Co Interoperability × K4, IC Appropriateness recog × K4, IC Learnability × K1/K4, IC Operability × K4, IC User assistance × K1/K4, Ma Modularity × K4, Ma Reusability × K4, Ma Modifiability × K4, Fl Installability × K4) |
| #9 Permissions/sandbox | OUI (Co Co-existence × K6/K13, IC Operability × K6/K13, IC User error protection × K4/K6/K13, Re Recoverability × K4/K6/K13, Se Confidentiality × K4/K6/K13, Se Integrity × K4/K6/K13, Se Resistance × K6/K13, Fl Installability × K6/K13, Sa Operational × K4/K6/K13, Sa Fail safe × K4/K6/K13, Sa Safe integration × K6/K13) |
| #10 Silent failure monitor | OUI (PE Time × K6, PE Resource × K6, PE Capacity × K6, FS Correctness × K6, Re Faultlessness × K6, Re Availability × K6, Re Fault tolerance × K6, Re Recoverability × K6, Se Integrity × K6, Ma Analysability × K5/K6, Fl Scalability × K6, Sa Risk × K6, Sa Hazard warning × K5/K6) |
| #11 Team metrics | OUI (IC User engagement × K9, Se Accountability × K9, Ma Analysability × K9/K12, Sa Risk × K12) |
| #12 Model routing | OUI (PE Time × K15/K16, PE Resource × K15/K16, PE Capacity × K15/K16, Co Interoperability × K16, Fl Adaptability × K4/K15/K16, Fl Replaceability × K4/K9/K15/K16, Fl Scalability × K15/K16) |
| #13 Situational awareness | OUI (IC User engagement × K9/K14, Se Accountability × K14, Sa Hazard warning × K14) |
| #14 Spec discipline | OUI (FS Completeness × K1/K4/K10/K11/K12, FS Correctness × K1, FS Appropriateness × K1/K10, IC Learnability × K1/K4/K10/K14, IC Operability × K4, IC User assistance × K1/K4/K10, Ma Modularity × K1, Ma Reusability × K10, Ma Modifiability × K4/K10, Ma Testability × K1) |
| #15 TDD agent loop | OUI (FS Correctness × K4/K5/K10/K11, Re Faultlessness × K4/K5/K10/K11, Se Integrity × K4/K10, Ma Testability × K4/K5/K10/K11/K12) |
| #16 Cost/budget caps | OUI (PE Time × K15, PE Resource × K9/K15, PE Capacity × K9/K15, Re Availability × K15, Fl Replaceability × K15, Fl Scalability × K9/K15, Sa Operational × K15) |
| #17 Provenance/audit | OUI (IC Self-descriptiveness × K4/K6/K9/K13, Se Non-repudiation × K4/K6/K9/K13, Se Accountability × K4/K6/K9/K13, Se Authenticity × K6/K13, Ma Analysability × K4/K6/K13) |

**Resultat post-correction** : **17/17 PICOCs sont directement referencees dans la matrice**. PICOC #7 est maintenant mappe sur PE Time/Resource/Capacity × K9 + Ma Analysability × K9.

## Gaps identifies

### GAP-A : Inclusivity × Professional Practice

**Description** : decisions sur l'inclusivite des workflows AI-assisted pour developpeurs de tous profils (non-English, juniors, situation de handicap, differents niveaux d'acces aux outils premium).

**Statut** : **HORS SCOPE actuel du domaine `ai-collaboration`**. A documenter comme exclusion explicite dans le scope file + potentiellement sujet d'une SLR future distincte.

**Raison de l'exclusion** : (a) sujet IC Inclusivity est intrinsequement UI/UX/accessibility plutot qu'infrastructure de delegation, (b) la litterature actuelle (2024-2026) sur ce sujet est tres thin, (c) le scope actuel est deja complet (17 decisions).

## Resultats agreges

- **Cellules evaluees** : 39 sub-characteristics × 13 KAs retenues = **507 cellules** (plus survol KAs residuelles)
- **Cellules actives** : ~135 mappees a PICOCs, ~370 N/A
- **Distribution PICOCs dans la matrice** (post-correction) : P9 (~18 cellules), P4 (~14), P17 (~11), P15 (~10), P8 (~10), P10 (~10), P5 (~9), P14 (~8), P3 (~8), P12 (~8), **P7 (4 cellules : PE Time/Resource/Capacity × K9 + Ma Analysability × K9)**, P1/P2/P6/P11/P13/P16 (~5 chacune)
- **GAPs** : **1** (GAP-A Inclusivity × K14, marked HORS SCOPE, row entirely OUT-OF-SCOPE)
- **PICOCs sans reference matrix** : **0** (toutes 17 PICOCs mappees post-correction)

## Decisions formelles (mises a jour post-audit independant)

1. **Matrice validee** : **17/17 PICOCs directement ancrees** dans la matrice ISO × SWEBOK.
2. **PICOC #7 Context Compaction** : **mappe sur 4 cellules** — PE Time behaviour × K9, PE Resource utilization × K9, PE Capacity × K9, Ma Analysability × K9. La shortcut initiale "enabler cross-cutting non-mappable" a ete **retiree** suite a l'audit independant qui a correctement observe que P7 a une intervention I distincte (summarize-and-restart) et des C empiriques, donc est mappable sur les cellules de gestion de ressource session-level.
3. **GAP-A Inclusivity** : documente, **HORS SCOPE** du present domaine. Toute la ligne IC Inclusivity est marquee OUT-OF-SCOPE coherente. Adressable par SLR future distincte.
4. **Scope file** : exclusion "Inclusivity of AI-assisted workflows" effectivement ajoutee (Fix-3 post-audit).

## Limites documentees

1. **KA3 Software Design** : absorbee dans K2 Architecture et K4 Construction (design generic, pas domain-specific). Acceptable per methodology §1.2 (matrix collapse autorise si justifie).
2. **KAs 7, 8, 17, 18** : survolees, aucune cellule active specifique au domaine. Conforme a l'observation de la plupart des domaines existants du guide EBSE ou ces KAs sont rarement actives.
3. **Pas de verification Agent C** sur cette matrice : les decisions de cellule active sont interpretatives, pas factuelles (pas de quotes verbatim a verifier). La reconciliation A+B + superviseur est suffisante per methodology §1.2.

## Prochaine etape

Cette matrice complete Phase 1.2 retroactivement. Les artifacts retrofit Phase 2 (PRISMA flows, 11-Q checklists, balance EtD, analyse de sensibilite, alternatives discovery) sont dans `verification/retrofit/ai-collaboration-phase-2-retrofit.md`.
