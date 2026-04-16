# Phase 1.4 — Protocol Amendments : domaine `ai-collaboration`

**Protocole de base** : `methodology.md` v3.0 (Kitchenham & Charters 2007, EBSE-2007-01)
**Date** : 2026-04-15
**Domaine couvert** : `ai-collaboration`

## Heritage

Le protocole de base `methodology.md` v3.0 s'applique integralement au domaine `ai-collaboration` sans modification substantielle. Les 13 etapes Kitchenham (3 phases, Planning / Conducting / Reporting) sont executees telles quelles.

## Amendements formels

### Amendement #1 — Recherche avec corpus fixe (Phase 1.2+)

- **Protocole original (methodology.md §2.1.1)** : "Derive search terms from the research questions (PICOC)" — laisse entendre que chaque reviewer derive ses propres search strings independamment.
- **Observation Phase 1.1** : A et B ont utilise des mots-cles partiellement differents pour la DARE, resultant en un accord brut d'inclusion de 42.9% (< 0.6 threshold). Les 7 sources retenues etaient toutes valides, mais 4/7 etaient complementaires (trouvees par un seul reviewer). Aucune fabrication de sources, juste couverture non-identique.
- **Amendement** : pour les etapes ou le **corpus candidat est connu a l'avance** (verification de standards, de SWEBOK KAs, ou validation de decisions pre-identifiees), le **superviseur fournit une liste fixe** aux deux reviewers. Ceci elimine la divergence de corpus tout en preservant l'independance du scoring/extraction par reviewer.
- **Etapes concernees** : 1.2 (Commissioning/Scope), 1.3 (PICOC), 1.5 (Pilot).
- **Etapes NON concernees** : 1.1 (DARE — par nature, les SLR existantes ne sont pas connues a l'avance) et 2.1 (Identification of research — le but est precisement de decouvrir les sources primaires via search strategy).
- **Validation** : accord brut Phase 1.2 standards = 72.7%, Phase 1.3 decisions = 11/17 convergence complete. L'amendement a ameliore l'accord sans reduire l'independance des jugements.

### Amendement #2 — Agent C verifie les fabrications tool/reference par defaut

- **Protocole original (methodology.md §2.4.3)** : Agent C verifie les URLs et citations verbatim des sources.
- **Observation Phases 1.1-1.3** : au-dela des citations de sources academiques, les reviewers citent aussi des **tools/frameworks/products** (Claude Code, Cursor, AGENTS.md, etc.) comme alternatives C dans les PICOCs et comme elements d'intervention. Plusieurs fabrications detectees :
  - Phase 1.1 : A a fabrique 5 faits specifiques sur Mohamed 2507.03156 (faux auteurs, fausses bases, grille qualite entierement inventee) + 2 sur Dong 2508.00083
  - Phase 1.2 : B a ajoute 3 mots non-verbatim a une quote SWEBOK KA 9 ; A a rate le passage cle KA 4 §5.1
  - Phase 1.3 : A a fabrique "Dagger for Cursor" (non-existant)
- **Amendement** : Agent C doit verifier systematiquement **les noms de tools/frameworks/products cites** en plus des citations de sources. Le prompt d'Agent C inclut une section dediee "verify tool/framework existence + feature claims" avec fetch de la documentation officielle.
- **Validation** : Phase 1.3 a detecte 1 fabrication et 8 corrections factuelles grace a Agent C. Mecanisme robuste.

### Amendement #3 — Format PICOC avec anchor Phase 1.2

- **Protocole original (methodology.md §1.3)** : format PICOC standard (P, I, C, O, Co + question).
- **Observation Phase 1.3** : pour un domaine nouveau comme `ai-collaboration`, il est important que chaque PICOC soit **explicitement ancree** sur un SWEBOK KA et/ou un standard ISO/NIST retenu en Phase 1.2. Sans cet ancrage, une PICOC peut deriver hors scope.
- **Amendement** : le format PICOC inclut un champ obligatoire **"Anchor"** qui liste le(s) KA(s) SWEBOK et/ou le(s) standard(s) Phase 1.2 qui justifient la pertinence de la question. Si un PICOC ne peut pas etre ancree, elle doit etre flagged pour arbitrage superviseur (peut-etre hors scope, peut-etre revelant un gap du scope 1.2 a corriger).
- **Etapes concernees** : 1.3 et toutes les futures extractions Phase 2.
- **Validation** : les 17 PICOCs retenues ont toutes un anchor ; aucune n'a ete flagged.

### Amendement #4 — Citations academiques au-dela de la pyramide standard

- **Protocole original (methodology.md §2.3)** : la pyramide de preuves prescrit niveau 1-5 (Standards → Consortia → Official docs → Surveys → Expert consensus).
- **Observation Phase 1.3** : plusieurs PICOCs s'appuient sur des **papiers academiques anciens mais canoniques** (Parasuraman Sheridan Wickens 2000, Bainbridge 1983, Forsgren et al. 2021 SPACE, Marquet 2013 "Turn the Ship Around"). Ces papiers ne sont pas des standards (niveau 1) ni des surveys quantitatives (niveau 4), mais ils sont indispensables pour ancrer des concepts comme "Levels of Automation" ou "Ironies of Automation".
- **Amendement** : autoriser les **papiers academiques canoniques** (peer-reviewed, >100 citations, concepts operationnels) comme sources de niveau **4 ou 5** selon leur nature :
  - Niveau 4 : papiers empiriques avec donnees quantitatives grande echelle (ex: Forsgren SPACE paper)
  - Niveau 5 : papiers conceptuels canoniques (ex: Bainbridge 1983, Marquet 2013 livre)
  Le risque de biais (section 2.3) reste a evaluer normalement.
- **Validation** : applicable en Phase 2.

## Non-amendements (protocole applique tel quel)

- **Phases Kitchenham 2-3** : executees sans modification.
- **Double extraction + Agent C** : mecanisme de base inchange, simplement applique rigoureusement a chaque etape.
- **Scoring GRADE** : inchange, applique tel quel en Phase 2.5.
- **PRISMA flow** : inchange, applique tel quel en Phase 2.1.
- **Formulaires d'extraction** : inchange.

## Journal cumule des decisions (Phases 1.1-1.3)

| # | Phase | Date | Decision | Type | Source |
|---|-------|------|----------|:----:|--------|
| 1 | 1.1 | 2026-04-15 | Merge corpus A+B (Phase 1.1 inclusion agreement bas) | Deviation one-time | Superviseur |
| 2 | 1.1 | 2026-04-15 | Reclassify Dong + Ge comme narrative surveys | Correction | Agent C |
| 3 | 1.1 | 2026-04-15 | Mohamed DARE 3.0 (pas 4.5) — 3 fabrications A refutees | Correction | Agent C |
| 4 | 1.1 | 2026-04-15 | Hou D5 = 0.5 (Table 5 est schema, pas extraction par etude) | Correction | Agent C |
| 5 | 1.2 | 2026-04-15 | Corpus fixe a l'avance pour reviewers (Amendement #1) | Amendement | Superviseur |
| 6 | 1.2 | 2026-04-15 | ISO 42001 → PRIMARY (A correct, B lisait promo HTML) | Correction | Agent C |
| 7 | 1.2 | 2026-04-15 | KA 4 §5.1 → PRIMARY (B correct, A avait miss) | Correction | Agent C |
| 8 | 1.2 | 2026-04-15 | KA 9 retain A wording (B avait ajoute "different types or" non-verbatim) | Correction | Agent C |
| 9 | 1.3 | 2026-04-15 | Drop "Dagger for Cursor" (fabrication A) | Correction | Agent C |
| 10 | 1.3 | 2026-04-15 | 8 corrections factuelles (Continue config, AutoGen MAF, Parasuraman add Wickens, etc.) | Correction | Agent C |
| 11 | 1.3 | 2026-04-15 | 17 PICOCs retenues (13 de depart → 11 communes + 4 nouvelles + reorganisations) | Scope | Superviseur |

## Approbation du protocole amende

Le protocole `methodology.md` v3.0 + les 4 amendements ci-dessus constitue le protocole complet pour la SLR `ai-collaboration`.

**Approbation formelle** : requise en Phase 1.5 via peer review par un reviewer isole + pilotage sur 3 PICOCs representatives.

**Statut** : Phase 1.5 terminee (peer review + pilot OK), Phase 1.5b executee (ISO clauses verifies, SWEBOK KAs 10/11/12 confirmes NOT_RETAINED, EU AI Act + ISO 25059 + exclusions ajoutees au scope).

## Phase 1.5b — corrections post-peer-review appliquees

### 1. ISO clause verification (Agent C aa9ea262a653b9d1c4)

**ISO 42001:2023** — 7/7 clauses confirmees (titles verbatim via TOC iteh.ai preview) :
- §7.5 Documented information ✓
- §8.1 Operational planning and control ✓
- §8.2 AI risk assessment ✓ (duplique §6.1.2)
- §8.3 AI risk treatment ✓ (duplique §6.1.3)
- §8.4 AI system impact assessment ✓ (duplique §6.1.4)
- §9.1 Monitoring, measurement, analysis and evaluation ✓
- §9.2 Internal audit ✓

**ISO 5338:2023** — **3 REFUTATIONS** critiques (PICOC anchors etaient faux) :
- §6.2 est "Organizational project-enabling processes" (PAS "requirements engineering")
- §6.3 est "Technical management processes" (PAS "resource management")
- §6.4 est "Technical processes" (PAS "measurement process")

**Corrections appliquees aux PICOCs** :
- PICOC #11 (DORA/SPACE metrics) : anchor ISO 5338 §6.4 → corrige en §6.3.7 (Measurement process, sous Technical management processes)
- PICOC #12 (Model routing) : anchor ISO 5338 §6.3 → corrige en §6.2.2 (Infrastructure management) + §6.2.4 (HR management)
- PICOC #14 (Prompt/spec discipline) : anchor ISO 5338 §6.2 → corrige en §6.4.2 (Stakeholder needs) + §6.4.3 (System requirements)
- PICOC #16 (Budget caps) : anchor ISO 5338 §6.3 → corrige en §6.2.2 (Infrastructure) + §6.3.1 (Project planning)

### 2. SWEBOK KAs 10/11/12 re-scan (agent a6797e28e72ff652e)

**Re-scan independant** du PDF SWEBOK v4 (6 MB extracted) sur termes "AI", "ML", "LLM", "generative", "agent", "automated", "human-in-the-loop", etc.

**Resultats** :
- KA 10 (SE Process) : 0 AI content → **CONFIRMED NOT_RETAINED**
- KA 11 (SE Models & Methods) : 0 AI content (tous les "heuristic"/"automated" sont CI/CD/MDD classiques) → **CONFIRMED NOT_RETAINED**
- KA 12 (Software Quality) : 0 AI content (tous les "automated" sont CI/Git/static analysis classiques) → **CONFIRMED NOT_RETAINED**

**Conclusion** : Reviewer A avait raison sur ces 3 KAs. Le miss de KA 4 §5.1 etait isole, pas systemique.

### 3. Scope update (EU AI Act + ISO 25059 + exclusions)

Ajoutes au fichier `verification/commissioning/ai-collaboration-scope.md` :

**PRIMARY additionnel** :
- **Regulation (EU) 2024/1689 — AI Act — Article 14 "Human oversight"** — ancrage legal/regulatoire UE pour PICOCs #1, #3, #13

**SECONDARY additionnel** :
- **ISO/IEC 25059:2023** (Quality model for AI systems) — extension ISO 25010 pour AI

**Exclusions explicites** :
- Licensing/IP provenance du code genere (stream legal separe)
- Agent UX/IDE integration depth (product preference, pas EBSE-answerable)
- Safety-critical AI (couvert par TR 5469 + DO-178C + IEC 62304)
- Training/fine-tuning d'agents (focus = usage, pas construction)

## Gate Phase 1.5b — statut

**PROTOCOL APPROVED for Phase 2 execution**. Tous les items critiques et mineurs du peer reviewer ont ete adresses :
- ✓ ISO clause numbers verifies (7/7 42001 confirmees, 3 corrections appliquees pour 5338)
- ✓ Pilot execute avec kappa convergent
- ✓ EU AI Act Article 14 ajoute
- ✓ ISO/IEC 25059 ajoute
- ✓ Liste sources additionnelles Phase 2.1 commitee (Amendement #8)
- ✓ Cutoff 3 ans vendor docs (Amendement #9)
- ✓ Licensing/IP exclusion explicite dans scope
- ✓ SWEBOK KAs 10/11/12 re-scan → NOT_RETAINED confirme

Phase 2 peut commencer sans nouveau peer review (items factuels, pas methodologiques).

## Amendement #13 — Retrofit retrospectif : estimations `~N` acceptables pour artifacts non logges en temps reel

- **Protocole original** : methodology.md §2.1 Table 2 Kitchenham prescrit des counts exacts pour le flux PRISMA (identification, deduplication, screening, eligibility, inclusion).
- **Situation observee** : l'execution initiale de Phase 2 (Batches AI-1, AI-2, AI-3) n'a pas loggue les counts exacts par PICOC au moment de la search. Les batch files documentent les sources incluses mais pas les comptes de sources examinees puis rejetees.
- **Probleme** : impossible de retrofitter des counts exacts a posteriori.
- **Amendement** : pour tout retrofit retrospectif d'artifacts Phase 2.1 (PRISMA counts), **accepter les estimations `~N` declarees explicitement** comme valides dans le formalisme Kitchenham Table 2, a condition que :
  1. Le count est marque `~N` (tilde) pour indiquer l'estimation
  2. Le count est produit par les reviewers A ET B de maniere independante puis reconcilie (conservative rule)
  3. La marge d'erreur entre A et B reste < 20% (sinon, declarer divergence significative)
- **Rationale** : la regle "NO INVENTION" est preservee car les estimations sont declarees comme telles. L'alternative (re-executer toute Phase 2 avec search logging) est disproportionnee si les decisions finales de GRADE sont convergentes et les sources retenues sont identiques.
- **Scope de l'amendement** : uniquement pour retrofit retrospectif. Pour toutes les futures Phase 2 executions initiales, les counts doivent etre exacts.
- **Items impactes** : §2.1 PRISMA counts (estimations acceptees), §2.1 alternatives discovery counts (idem), §2.1 snowballing per-batch logging (accepte comme PARTIAL si non logge initialement).

## Amendement #14 — Retrofit double extraction (post-audit independant)

- **Protocole original** : methodology.md §2.3 et §2.5 prescrivent double extraction A+B pour la checklist qualite 11-Q, l'analyse de sensibilite, la balance EtD.
- **Situation observee** : le retrofit Phase 2 initial (fichier `ai-collaboration-phase-2-retrofit.md`) a ete produit par un **seul agent**, non double extrait. Detecte par l'auditeur independant (agent ae311f4f...).
- **Amendement** : execution d'un **Reviewer B retrofit independant** (agent a80a4382...) sans voir le travail de A. Les 2 outputs sont consolides dans `ai-collaboration-phase-2-retrofit-consolidated.md` avec conservative rule appliquee par cellule.
- **Items impactes** : §2.3 11-Q (double extraction effective post-consolidation), §2.5 EtD + sensibilite (idem), §2.1 alternatives discovery (idem).
- **Status** : fix applique retroactivement. Apres consolidation : FAIL → PASS.

## Amendement #15 — Corrections post-audit independant

- **Fix-1** : Marquet 2013 quote supprimee de `ai-agent-escalation-protocol.json` (source excluded au seuil 11-Q 4/11 < 5/11, quote residue violait regle "zero invention")
- **Fix-2** : PICOC #6 `grade_factors_applied` reecrit pour refleter `floor_triggered: true` au lieu d'une trajectoire artificielle start/plus/minus
- **Fix-3** : "Inclusivity of AI-assisted workflows" effectivement ajoutee aux exclusions du scope file (etait declaree dans la matrice mais pas dans le scope file — faux-fait corrige)
- **Fix-4** : Matrice corrigee — P7 Context Compaction mappe sur PE × K9 + Ma Analysability × K9 (au lieu de "enabler cross-cutting" shortcut)
- **Fix-5** : Matrice corrigee — Se Confidentiality × K5 Testing = P4,P10 (pas N/A)
- **Fix-6** : Matrice corrigee — PE Resource × K9 + PE Capacity × K9 = P7,P12,P16 (pas seulement P16)
- **Fix-7** : Matrice corrigee — toute ligne IC Inclusivity marquee OUT-OF-SCOPE coherente
- **Fix-8** : Matrice narrative — faux "~92% convergence" corrige honnetement (A=95, B=135, union retenue avec documentation de la divergence)
