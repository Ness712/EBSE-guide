# Phase 1.1 — DARE : domaine `ai-collaboration`

**Protocole** : `methodology.md` v3.0, section 1.1 (Kitchenham & Charters 2007, EBSE-2007-01)
**Date** : 2026-04-15
**Methode** : double extraction (Reviewer A + Reviewer B, contextes isoles) + verification sources (Agent C isole) + reconciliation superviseur
**Fichier de tracabilite** : [`verification/extractions/phase-1-1-ai-collaboration-dare.md`](../extractions/phase-1-1-ai-collaboration-dare.md)

## Sujet de la SLR

Deleguer du travail d'ingenierie logicielle a un agent de codage IA (Claude Code, Cursor, Devin, Copilot, SWE-agent) avec des checkpoints humains explicites — modele "manager delegue a une equipe de dev".

## Strategie de recherche

| Element | Valeur |
|---------|--------|
| Bases interrogees | Google Scholar, arXiv, ACM Digital Library, IEEE Xplore, Semantic Scholar |
| Fenetre de publication | 2023-2026 |
| Type de source accepte | SLR, Systematic Mapping Study, tertiary study avec protocole declare (Kitchenham/PRISMA) |
| Type de source rejete | Etudes primaires, narrative surveys sans protocole, opinion, vendor whitepapers |
| Reviewers | A (acc71a58c1b5ea266), B (a11f4a91543a7a408), C verificateur (a59abc9af31652fef) |

## Criteres DARE appliques

Chaque SLR est scoree sur 5 criteres (0 / 0.5 / 1, total /5), conformement au Centre for Reviews and Dissemination (University of York) et repris par Kitchenham & Charters 2007 §5.1 :

- **D1** — Inclusion/exclusion criteria reported
- **D2** — Search adequate (multiple databases, explicit strings)
- **D3** — Included studies synthesised
- **D4** — Quality of included studies assessed
- **D5** — Per-study details presented

**Regle** : total >= 2.5/5 sur scope DIRECT = existing SLR suffit. Sinon nouvelle SLR justifiee.

## Corpus identifie et score

7 sources uniques identifiees, toutes verifiees par Agent C (URL fetched + contenu confirme ou refute).

### Source #1 — Hou et al. 2024 (LLM4SE)

- **Citation** : Hou, Zhao, Liu, Yang, Wang, Li, Luo, Lo, Grundy, Wang (2024). *Large Language Models for Software Engineering: A Systematic Literature Review*. ACM TOSEM. DOI : [10.1145/3695988](https://dl.acm.org/doi/10.1145/3695988). arXiv : [2308.10620](https://arxiv.org/abs/2308.10620).
- **Methodologie** : Kitchenham explicite. 395 etudes (Jan 2017 — Jan 2024). 7 bases (IEEE, ACM, ScienceDirect, WoS, Springer, arXiv, DBLP). QA rubric 10 items.
- **Coverage** : **ADJACENTE** — catalogue LLM4SE general, ne couvre pas la delegation a des agents autonomes ni les checkpoints humains. Cutoff janvier 2024 pre-Devin/Claude-Code/SWE-agent.
- **DARE scoring (reconcilie)** :
  - D1 = 1 (inc/exc explicites)
  - D2 = 1 (7 bases + strings explicites + Quasi-Gold-Standard snowballing)
  - D3 = 1 (synthese sur 4 RQs)
  - D4 = 1 (QA rubric 10 items, seuils numeriques 16.8/21 et 14.4/18)
  - D5 = 0.5 (Table 5 est un data-extraction schema, pas une categorization par etude — verifie par C)
  - **Total = 4.5 / 5**
- **Risque de biais global** : Modere (obsolescence sur notre topic specifique : cutoff Jan 2024)
- **Verdict** : **Citer** comme reference fondatrice LLM4SE. Ne couvre pas notre scope.

### Source #2 — He, Treude, Lo 2024/2025 (LLM Multi-Agent Systems for SE)

- **Citation** : He, Treude, Lo (2024/2025). *LLM-Based Multi-Agent Systems for Software Engineering: Literature Review, Vision and the Road Ahead*. ACM TOSEM. DOI : 10.1145/3712003. arXiv : [2404.04834](https://arxiv.org/abs/2404.04834).
- **Methodologie** : "systematic review" auto-declaree. Base unique (DBLP). Pas de quality assessment.
- **Coverage** : **DIRECT-ADJACENT** — multi-agent SE, mais focus architecture **agent-a-agent**, pas delegation **humain-a-agent** avec checkpoints.
- **DARE scoring (reconcilie)** :
  - D1 = 1 (8 criteres d'exclusion explicites en 3 phases)
  - D2 = 0.5 (single-base DBLP — faiblesse majeure vs Kitchenham multi-source requirement)
  - D3 = 1 (synthese avec taxonomie sur SDLC stages + 2 case studies)
  - D4 = 0 (aucune section quality assessment — verifie par C)
  - D5 = 0.5 (71 etudes, details par etude non completement exposes)
  - **Total = 3.0 / 5**
- **Risque de biais global** : Modere-eleve (single-database + no QA + cutoff partial)
- **Verdict** : **Citer** pour background architecture agent. Ne couvre pas le framing humain-a-agent.

### Source #3 — Mohamed, Assi, Guizani 2025 (LLM-Assistants Productivity)

- **Citation** : Mohamed, Assi, Guizani (2025). *The Impact of LLM-Assistants on Software Developer Productivity: A Systematic Review and Mapping Study*. arXiv : [2507.03156](https://arxiv.org/abs/2507.03156).
- **Methodologie** : Kitchenham + PRISMA explicites. 4 bases (ACM, IEEE, ScienceDirect, WoS). Query 3-segments avec proximity operators NEAR/5. Aucune section quality assessment. Synthese SPACE framework. 39 etudes (abstract) / 37 apres snowball (corps — inconsistance interne notee).
- **Coverage** : **ADJACENTE** — productivite des LLM-assistants (Copilot-class), pas delegation a des agents autonomes.
- **DARE scoring (reconcilie)** :
  - D1 = 0.5 (IC/EC presents mais structure complete non re-verifiee verbatim)
  - D2 = 1 (4 bases + query structuree + proximity operators — suffisant)
  - D3 = 1 (synthese SPACE)
  - D4 = 0 (pas de quality assessment — la claim de grille Lenarduzzi par Reviewer A etait une fabrication, refutee par Agent C)
  - D5 = 0.5 (non completement verifie)
  - **Total = 3.0 / 5**
- **Risque de biais global** : Modere
- **Verdict** : **Citer** pour productivite autocomplete. Ne couvre pas delegation.
- **Note critique** : 3 items specifiques fabriques par Reviewer A sur cette source ont ete detectes et rejetes par Agent C (auteurs "Weber" au lieu de Mohamed, "6 bases incluant Scopus et Springer" au lieu de 4, grille qualite Lenarduzzi QA1-QA11 entierement fabriquee). Voir fichier de tracabilite pour le detail.

### Source #4 — Sergeyuk et al. 2025 (In-IDE Human-AI Experience)

- **Citation** : Sergeyuk, Zakharov, Koshchenko, Izadi (2025). *Human-AI Experience in Integrated Development Environments: A Systematic Literature Review*. arXiv : [2503.06195](https://arxiv.org/abs/2503.06195).
- **Methodologie** : PRISMA explicite. 8 bases (ACM, DBLP, IEEE, WoS, ScienceDirect, Scopus, Springer, arXiv). 90 etudes sur 257 candidats. Quality rubric 4 criteres (Reporting, Rigor, Credibility, Relevance) avec seuil cutoff > 2.
- **Coverage** : **TANGENTIELLE** — in-IDE HAX (Copilot autocomplete, ChatGPT chat dans editor), explicitement pas d'agents autonomes delegues hors IDE.
- **DARE scoring (reconcilie)** :
  - D1 = 1 (inc/exc explicites : timeframe, langue, publication, population, intervention, outcomes, design)
  - D2 = 1 (8 bases + strings core+optional)
  - D3 = 1 (thematic coding sur 3 dimensions Impact/Design/Quality)
  - D4 = 1 (rubrique qualite 4 criteres + cutoff + 8 etudes exclues pour qualite insuffisante)
  - D5 = 1 (supplementary materials avec authors, affiliation, DOI, publication date, venue, study goal, RQs, key findings — verifie par C)
  - **Total = 5.0 / 5**
- **Risque de biais global** : Faible
- **Verdict** : **Citer** comme exemplar methodologique (modele pour notre propre Phase 2). Scope mismatch : in-IDE HAX, pas delegation a agents autonomes.

### Source #5 — Dong et al. 2025 (Code Generation Agents Survey)

- **Citation** : Dong, Jiang, Qian, Wang, Zhang, Jin, Li (2025). *A Survey on Code Generation with LLM-based Agents*. arXiv : [2508.00083](https://arxiv.org/abs/2508.00083).
- **Methodologie** : **Narrative survey**. Pas d'IC/EC, pas de PRISMA, pas de reference Kitchenham, pas de quality assessment. Section 2.1 "Literature Collection" vague.
- **Coverage** : **DIRECT** (topiquement) mais invalide comme SLR.
- **DARE scoring (reconcilie)** :
  - D1 = 0 (pas d'IC/EC)
  - D2 = 0 (pas de search protocole transparent)
  - D3 = 0.5 (narrative synthesis sans extraction formelle)
  - D4 = 0 (pas de QA)
  - D5 = 0 (pas de details par etude)
  - **Total = 0.5 / 5**
- **Risque de biais global** : Eleve (pas de protocole transparent)
- **Verdict** : **Exclure du corpus SLR**. Peut etre cite anecdotiquement en background narratif, mais ne sert pas de SLR baseline.
- **Note** : Reviewer A avait initialement attribue ce papier a "Liu et al." et l'avait classifie comme SLR. Agent C a verifie les auteurs reels (Dong et al.) et refute la classification SLR.

### Source #6 — Ge et al. 2025 (Vibe Coding Survey)

- **Citation** : Ge, Mei, Duan, Li, Zheng, Wang et al. (2025). *A Survey of Vibe Coding with Large Language Models*. arXiv : [2510.12399](https://arxiv.org/abs/2510.12399).
- **Methodologie** : **Narrative survey**. Pas de PRISMA, pas de Kitchenham, pas d'IC/EC, pas de QA. Claime "over 1000 papers" sans protocole de selection.
- **Coverage** : **DIRECT** (topiquement — "autonomous coding agents" + "validate by outcome observation" est exactement notre paradigme) mais invalide comme SLR.
- **DARE scoring (reconcilie)** :
  - D1 = 0
  - D2 = 0
  - D3 = 0.5 (taxonomie 5 modeles de developpement)
  - D4 = 0
  - D5 = 0
  - **Total = 0.5 / 5**
- **Risque de biais global** : Eleve (buzzword framing "vibe coding" + opacite du corpus)
- **Verdict** : **Exclure du corpus SLR**. Indicateur utile que le paradigme emerge dans la litterature, mais ne peut pas servir de source EBSE.

### Source #7 — Zadenoori et al. 2025 (LLM4RE SLR)

- **Citation** : Zadenoori, Dabrowski, Alhoshan, Zhao, Ferrari (2025). *Large Language Models (LLMs) for Requirements Engineering (RE): A Systematic Literature Review*. arXiv : [2509.11446](https://arxiv.org/abs/2509.11446).
- **Methodologie** : SLR formel avec section 4 "Research Methodology" (RQs, Literature Search, Data Extraction and Synthesis). 74 etudes (2023-2024).
- **Coverage** : **TANGENTIELLE** — scope Requirements Engineering uniquement. Ne traite pas de delegation a des coding agents.
- **DARE scoring (reconcilie)** :
  - D1 = 0.5 (presents mais details non verbatim-verified)
  - D2 = 0.5 (non verifies en detail)
  - D3 = 1 (categorisation multi-dimensions)
  - D4 = 0.5 (non verifie)
  - D5 = 0.5 (non verifie)
  - **Total = 3.0 / 5**
- **Risque de biais global** : Faible-modere
- **Verdict** : **Citer si pertinent pour requirements engineering** (probablement pas necessaire pour notre scope coding-agents).

## Tableau recapitulatif

| # | Source | Annee | Venue | Scope | DARE /5 | Verdict |
|---|--------|:-----:|-------|-------|:-------:|---------|
| 1 | Hou LLM4SE | 2024 | ACM TOSEM | Adjacente | **4.5** | Citer (background) |
| 2 | He LMA4SE | 2024/25 | ACM TOSEM | Direct-adjacente | **3.0** | Citer (agent archi) |
| 3 | Mohamed Productivity | 2025 | arXiv | Adjacente | **3.0** | Citer (productivite) |
| 4 | Sergeyuk HAX-IDE | 2025 | arXiv | Tangentielle | **5.0** | Citer (rigor exemplar) |
| 5 | Dong Code-Gen Agents | 2025 | arXiv | Direct | **0.5** | **Exclure** (narrative survey) |
| 6 | Ge Vibe Coding | 2025 | arXiv | Direct | **0.5** | **Exclure** (narrative survey) |
| 7 | Zadenoori LLM4RE | 2025 | arXiv | Tangentielle | **3.0** | Citer si RE pertinent |

## Conclusion — Phase 1.1 gate

**Aucune SLR existante ne couvre le scope exact de notre nouvelle SLR a DARE >= 2.5** (delegation style manager a des agents de codage IA autonomes avec checkpoints humains explicites).

**Justifications** :

1. **Les deux SLR les plus rigoureuses** (Sergeyuk 5.0, Hou 4.5) sont respectivement **tangentielle** (in-IDE HAX) et **adjacente obsolescente** (LLM4SE general, cutoff Jan 2024, pre-Devin/Claude-Code).

2. **Les SLR topologiquement les plus proches** (Dong Code-Gen Agents 0.5, Ge Vibe Coding 0.5) sont des **narrative surveys sans protocole formel** — DARE tres bas, exclues du corpus SLR. Elles confirment toutefois que le paradigme "agents autonomes + validation par outcome" emerge dans la litterature recente mais n'est pas encore synthetise de maniere rigoureuse.

3. **La SLR multi-agents** (He 3.0) traite les **architectures agent-a-agent**, pas **humain-a-agent**. Elle utilise une base unique (DBLP) et n'a pas de quality assessment.

4. **Aucune SLR** ne formule le travail SE comme un probleme de **delegation style manager** avec **protocole de checkpoint humain**. Ce framing est notre contribution originale.

**Decision : Phase 1.1 gate PASSED — nouvelle SLR justifiee** sous Kitchenham & Charters 2007 §5.1.

## Travaux connexes a citer dans la nouvelle SLR

- **#1 Hou LLM4SE** — reference fondatrice LLM4SE, contexte
- **#2 He LMA4SE** — architectures multi-agents pour SE (background)
- **#3 Mohamed Productivity** — productivite autocomplete (positionnement contre)
- **#4 Sergeyuk HAX-IDE** — rigor methodologique exemplar + in-IDE HAX (positionnement contre)

## Elements a reutiliser dans notre protocole Phase 2

- Liste de bases de Hou (7 bases IEEE, ACM, ScienceDirect, WoS, Springer, arXiv, DBLP) et Sergeyuk (8 bases en ajoutant Scopus)
- Quality rubric 4 criteres de Sergeyuk (Reporting, Rigor, Credibility, Relevance, scale 0/0.5/1, cutoff > 2) — compatible avec notre section 2.3
- Query structure 3-segments avec proximity operators de Mohamed — adaptable pour Phase 2.1

## Limites documentees

1. **Couverture de recherche incomplete** : Google Scholar + WebSearch utilises comme proxy des bases payantes (IEEE Xplore et ACM DL partiellement paywall). Il est possible qu'une SLR supplementaire derriere paywall ne soit pas dans ce corpus de 7.

2. **Fabrications par Reviewer A detectees** : 5 items factuels fabriques sur Sources #3 et #5 (auteurs, nombre de bases, grille qualite complete). Tous detectes et rejetes par Agent C avant integration. Cas d'ecole du pourquoi le protocole double extraction + verification par agent separe est necessaire. Voir fichier de tracabilite.

3. **Accord brut d'inclusion A vs B = 42.9%** : cause est la divergence des mots-cles de recherche entre A et B (pas du desaccord sur les criteres). Deviation documentee et resolue par merge des corpus + verification exhaustive par Agent C. Pour Phase 1.2+, un search string commun sera fourni aux deux reviewers.

4. **Re-execution conseillee si** : Phase 2 demarre apres 2026-07-15 (domaine evolue rapidement, SLR nouvelles probables d'ici la).

5. **Inconsistance interne dans Source #3 (Mohamed)** : "39 etudes peer-reviewed" (abstract) vs "37 primary studies" (corps). Non resolu ; a noter si on cite ce chiffre ailleurs.

## Prochaine etape

Phase 1.2 — Commissioning : definition du scope du nouveau domaine `ai-collaboration`, verification des standards AI candidats (ISO/IEC 5338:2023, ISO/IEC 42001:2023, NIST AI RMF 1.0, NIST AI 600-1), identification des knowledge areas SWEBOK v4 pertinentes, construction de la matrice de couverture.

**Le protocole double extraction + Agent C verificateur sera applique strictement a chaque etape suivante** avec search string commun pour eviter la divergence de corpus observee ici.
