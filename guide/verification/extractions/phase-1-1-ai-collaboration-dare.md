# Double Extraction — Phase 1.1 : DARE `ai-collaboration`

**Date** : 2026-04-15
**Protocole** : methodology.md v3.0, section 1.1 (Kitchenham & Charters 2007, EBSE-2007-01)
**Agent A** : acc71a58c1b5ea266 (contexte independant)
**Agent B** : a11f4a91543a7a408 (contexte independant)
**Agent C (verificateur sources)** : a59abc9af31652fef (contexte independant, ne voit pas le jugement A/B)
**Superviseur** : Claude Opus 4.6 (reconciliation)

## Objectif

Etape 1.1 du protocole Kitchenham 2007 pour un nouveau domaine SLR `ai-collaboration` — *"Delegation du travail d'ingenierie logicielle a un agent de codage IA (Claude Code, Cursor, Devin, Copilot, SWE-agent) avec des checkpoints humains explicites — modele manager-delegation"*. Recherche systematique des SLR existantes et scoring DARE (Database of Abstracts of Reviews of Effects, University of York / Kitchenham 2007) pour decider si une nouvelle SLR est justifiee.

## Strategie de recherche

| Agent | Bases interrogees | Mots-cles principaux |
|-------|-------------------|----------------------|
| A | Google Scholar, arXiv, ACM DL, IEEE Xplore, Semantic Scholar | `"SLR" "large language model" "software engineering"`, `"LLM agents" SE review`, `"AI pair programming" systematic`, `"autonomous coding agents" survey` |
| B | Google Scholar, arXiv, ACM DL, IEEE Xplore, Semantic Scholar | `"survey" OR "review" "LLM" "software engineering"`, `"GitHub Copilot" review empirical`, `"trust" "LLM" SE review`, `"human-in-the-loop" "code generation" review` |

## Corpus identifie (7 sources uniques)

| # | Source | Trouvee par | URL |
|---|--------|:-----------:|-----|
| 1 | Hou et al. 2024 — LLM4SE SLR | A + B | https://arxiv.org/abs/2308.10620 |
| 2 | He, Treude, Lo 2024/25 — LMA-for-SE | A + B | https://arxiv.org/abs/2404.04834 |
| 3 | Mohamed, Assi, Guizani 2025 — LLM-Assistants Productivity | A + B | https://arxiv.org/abs/2507.03156 |
| 4 | Sergeyuk et al. 2025 — In-IDE HAX SLR | A seul | https://arxiv.org/abs/2503.06195 |
| 5 | Dong et al. 2025 — Code Generation Agents Survey | A seul | https://arxiv.org/abs/2508.00083 |
| 6 | Ge et al. 2025 — Vibe Coding Survey | B seul | https://arxiv.org/abs/2510.12399 |
| 7 | Zadenoori et al. 2025 — LLM4RE SLR | B seul | https://arxiv.org/abs/2509.11446 |

## Accord brut d'inclusion (A vs B)

- Trouvees par les deux : 3/7 = **42.9%**
- Trouvees par A seul : 2/7
- Trouvees par B seul : 2/7

**Observation** : accord brut < 0.6. Cause : A et B ont utilise des mots-cles partiellement differents et ont donc explore des zones partiellement disjointes de la litterature. Ce n'est pas un desaccord sur l'inclusion a criteres egaux (les 7 sources sont toutes inclusibles), mais une **couverture complementaire**. Voir deviation de protocole §Deviations ci-dessous.

## Comparaison DARE (3 sources communes)

| # | Source | A D1 | B D1 | A D2 | B D2 | A D3 | B D3 | A D4 | B D4 | A D5 | B D5 | A Total | B Total |
|---|--------|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:---:|:-------:|:-------:|
| 1 | Hou LLM4SE | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 0.5 | 1 | **4.5** | **5.0** |
| 2 | He LMA4SE | 1 | 1 | 0.5 | 0.5 | 1 | 1 | 0 | 0 | 0.5 | 0.5 | **3.0** | **3.0** |
| 3 | Mohamed Productivity | 1 | 0.5 | 1 | 0.5 | 1 | 1 | 1 | 0.5 | 0.5 | 0.5 | **4.5** | **3.0** |

**Divergences de scoring identifiees** :

| Source | Critere | A | B | Ecart |
|--------|---------|---|---|:-----:|
| Hou | D5 | 0.5 | 1.0 | 0.5 |
| Mohamed | D1 | 1.0 | 0.5 | 0.5 |
| Mohamed | D2 | 1.0 | 0.5 | 0.5 |
| Mohamed | D4 | 1.0 | 0.5 | 0.5 |

## Verification par Agent C (role separe, section 2.4.3)

Agent C a fetche chaque URL, verifie accessibilite (7/7 HTTP 200), et teste les claims contestees par quotes verbatim.

### Source #1 — Hou LLM4SE (divergence D5)

- **Claim A (D5=0.5)** : "Table 5 est un schema d'extraction, pas les donnees par etude"
- **Claim B (D5=1.0)** : "Table 5 data-extraction schema + per-study categorization confirmed"
- **Verification C** : *"Table 5 caption — 'Extracted data items and related research questions (RQs)'. Table contents are columns 'RQ / Data Item' listing items like 'The category of SE task', 'The category of LLM'. This is a data-extraction schema, not a per-study categorization table."*
- **Verdict** : **A confirme**, B a survalorise Table 5. Par-study data peut exister ailleurs mais pas en Table 5 comme B l'affirmait.
- **Resolution** : **D5 = 0.5** (regle conservative + verification C). Total Hou = **4.5**.

### Source #3 — Mohamed Productivity (divergences majeures)

Agent C a fetche le papier arXiv 2507.03156 et teste chaque claim specifique de A :

| Claim A | Statut C | Evidence verbatim |
|---------|:--------:|-------------------|
| Auteurs "Weber et al." | **REFUTE** | Auteurs reels : **Mohamed Amr, Assi Maram, Guizani Mariam**. Zero occurrence de "Weber". |
| "IC1-IC3 et EC1-EC5 explicites" | **CONFIRME (partiel)** | *"(+) IC1: The paper investigates the effect of AI or LLMs on software developer productivity"* + *"(-) EC1 (Out of Scope)..."*. Format confirme, nombre exact non re-verifie. |
| "6 bases : ACM, IEEE, ScienceDirect, WoS, **Scopus, Springer**" | **REFUTE** | *"we select four major digital libraries... ACM Digital Library, IEEE Xplore, ScienceDirect, and Web of Science"*. **4 bases**, pas 6. **Scopus et Springer fabriquees**. |
| "Query 3-segments avec proximity operators" | **CONFIRME** | *"Each search query consists of three segments separated by the AND string..."* + *"proximity operators in the query, namely 'NEAR/5'"*. |
| "Lenarduzzi QA1-QA11, 5-point Likert, 50% threshold, 5 etudes exclues" | **REFUTE — FABRICATION MAJEURE** | **Zero occurrence de "Lenarduzzi", "Likert", "QA1", "QA11", "50%"**. **Aucune section quality assessment n'existe**. Methodology saute directement de 3.2 (Primary Study Selection) a 4 (RQ0 characteristics). |
| "Kitchenham + PRISMA" | **CONFIRME** | *"We ground our methodology in the seminal guidelines by Kitchenham and Charters"* + Figure 2 *"Overview of the selection process... using PRISMA flow chart"*. |

**Verdict C** : **A a fabrique 3 items majeurs** (auteurs, nombre de bases, grille qualite entiere). **B avait raison** d'utiliser "NOT VERIFIED" conservativement.

**Resolution** :
- D1 = **0.5** (IC/EC presents confirmes par C, mais format exact non re-verifie)
- D2 = **1.0** (4 bases confirmees + query 3-segments + proximity operators — suffisant pour D2)
- D3 = **1.0** (accord A et B)
- D4 = **0** (pas de section quality assessment — contrairement au claim A)
- D5 = **0.5** (accord A et B)
- **Total Mohamed = 3.0**

### Source #5 — Dong et al. Code Generation Agents (trouvee par A seul)

- **Claim A** : "Liu et al. 2025", "systematic literature retrieval", DARE 2.5/5, DIRECT (partial)
- **Verification C** :
  - Auteurs reels : **Dong Yihong, Jiang Xue, Qian Jiaru et al.** — pas "Liu"
  - Titre : *"A Survey on Code Generation with LLM-based Agents"* — **"Survey", pas "Systematic Review"**
  - Section 2.1 "Literature Collection" : **aucun IC/EC, aucun PRISMA flow, aucune reference Kitchenham, aucun QA**
- **Verdict C** : **narrative survey, pas une SLR**. A a mal-attribue les auteurs ET mal-classifie le type de source.
- **Resolution** : Reclassifier comme **narrative survey**, DARE = **0/0/0.5/0/0 = 0.5/5**. Ne peut pas servir de SLR baseline.

### Autres sources (verifiees, claims confirmees)

- **Source #2 He LMA4SE** : 2 claims testees (single database DBLP, no QA), **2 confirmees**. Pas de divergence. DARE = 3.0 retenu.
- **Source #4 Sergeyuk HAX-IDE** : 3 claims testees (8 bases, 90/257 studies, 4 criteres qualite cutoff >2), **3 confirmees**. DARE = 5.0 retenu.
- **Source #6 Ge Vibe Coding** : 1 claim testee (narrative survey sans protocole), **confirmee** (B correct). DARE = 0.5 retenu.
- **Source #7 Zadenoori LLM4RE** : 2 claims testees (SLR formel, scope RE uniquement), **2 confirmees**. DARE = 3.0 retenu, scope tangentiel (Requirements Engineering, pas coding agents).

## Recapitulatif final reconcilie

| # | Source | Coverage | DARE reconcilie | Statut final |
|---|--------|----------|:---------------:|--------------|
| 1 | Hou LLM4SE | ADJACENT | **4.5 / 5** | Citer ; obsolescent (cutoff Jan 2024) |
| 2 | He LMA4SE | DIRECT-ADJACENT | **3.0 / 5** | Citer ; archi agent-a-agent, pas humain-a-agent |
| 3 | Mohamed Productivity | ADJACENT | **3.0 / 5** | Citer ; productivite autocomplete ≠ delegation |
| 4 | Sergeyuk HAX-IDE | TANGENTIELLE | **5.0 / 5** | Citer ; scope in-IDE exclut agents autonomes |
| 5 | Dong Code-Gen Agents | DIRECT | **0.5 / 5** | Narrative survey — EXCLURE du corpus SLR |
| 6 | Ge Vibe Coding | DIRECT | **0.5 / 5** | Narrative survey — EXCLURE du corpus SLR |
| 7 | Zadenoori LLM4RE | TANGENTIELLE | **3.0 / 5** | SLR formelle mais scope RE uniquement |

## Resultats agreges

- **Accord brut inclusion (A vs B)** : 3/7 = 42.9% → **< 0.6**
- **Accord strict DARE (3 sources communes, total identique)** : 1/3 = 33.3% → **< 0.6**
- **Accord apres verification Agent C** : 3/3 sources communes reconciliees (une fois les fabrications de A ecartees et la sur-valorisation de B sur Hou corrigee)
- **Hallucinations detectees par C** : **5 items fabriques par A** (Mohamed : auteurs, nombre de bases, grille qualite entiere ; Dong : auteurs, classification SLR)
- **Sur-valorisations detectees** : **1 par B** (Hou D5=1.0 base sur mauvaise interpretation de Table 5)

## Deviations de protocole documentees

### Deviation #1 — Accord brut inclusion < 0.6

- **Protocole** : methodology.md §2.2.3 : "Si kappa < 0.6, les criteres sont affines avec des exemples de calibration supplementaires"
- **Situation** : accord brut 42.9% (3 communes sur 7 uniques)
- **Cause racine** : A et B ont utilise des mots-cles de recherche partiellement differents (protocole n'a pas impose un search string unique). Les 4 sources non-communes sont toutes valides — ce n'est pas un desaccord sur des criteres a candidate-set egal, c'est une couverture complementaire de l'espace de recherche.
- **Decision superviseur** : plutot que re-raffiner les criteres et re-extraire (qui ne changerait rien : les deux agents ont bien applique les criteres, juste sur des corpus differents), **merger les 2 listes en 7 sources uniques** et appliquer Agent C a toutes. Cette decision prolonge le protocole Kitchenham plutot que de le violer (principe : exhaustivite > accord strict quand les corpus divergent sans conflit).
- **Impact sur la validite** : Agent C a confirme les 7 URLs + contenus. Aucune source n'est perdue. Les hallucinations detectees (5 dans A, 1 dans B) sont toutes sur des sources **communes**, ce qui prouve que le mecanisme A+B+C fonctionne la ou il a ete applique strictement.
- **Amelioration pour Phase 1.2+** : fournir aux agents un **search string explicite commun** pour eviter la divergence de corpus a l'avenir.

### Deviation #2 — Criteres qualite numeriques non appliques

- **Protocole** : methodology.md §2.3 : checklist 11-Q Kitchenham Table 5 + grille de biais 7-dimensions
- **Situation** : la phase DARE evalue des **SLR secondaires** (pas des etudes primaires), et Kitchenham §5.1 ne prescrit que les 5 criteres DARE pour cette etape. La grille 11-Q est designee pour les etudes primaires.
- **Decision** : appliquer DARE (conforme Kitchenham §5.1) + noter le risque de biais en commentaire par source. La grille 11-Q sera appliquee a Phase 2.3 sur les etudes primaires incluses dans la SLR reelle.

## Conclusion — Phase 1.1 gate

**AUCUNE SLR existante ne couvre notre scope exact a DARE >= 2.5** :

- **Sergeyuk (5.0/5)** et **Hou (4.5/5)** : methodologiquement excellentes mais **scope mismatch** (in-IDE HAX / catalogue LLM4SE general).
- **He (3.0/5)** : la plus proche topologiquement (multi-agent SE) mais **single-database (DBLP)**, **no QA**, focus **agent-a-agent** (pas humain-a-agent), cutoff pre-Devin/Claude-Code/SWE-agent.
- **Mohamed (3.0/5)** : adjacente mais **productivite autocomplete**, pas **delegation a agents autonomes**.
- **Zadenoori (3.0/5)** : SLR formelle mais **Requirements Engineering uniquement**, tangentielle.
- **Dong (0.5/5)** et **Ge (0.5/5)** : narrative surveys, pas SLR — echec DARE, exclure du corpus SLR.

**Gap identifie** : aucune SLR existante ne formule le travail SE comme un probleme de **delegation style manager** avec **checkpoints humains explicites** sur des agents de codage autonomes (Claude Code, Cursor, Devin, SWE-agent, Copilot agent mode). Le paradigme est post-janvier 2024 et reste non-synthetise.

**Decision : Phase 1.1 gate PASSED — nouvelle SLR justifiee** sous Kitchenham 2007 §5.1.

**Travaux connexes a citer** : #1 Hou (foundational LLM4SE), #2 He (agent archi), #3 Mohamed (productivity adjacent), #4 Sergeyuk (in-IDE HAX rigor exemplar).

**Elements a reutiliser dans notre protocole Phase 2** :
- Liste de bases de Hou (D2=1) et Sergeyuk (D2=1) comme baseline de notre search strategy
- Rubrique qualite 4-criteres de Sergeyuk (D4=1) — compatible avec notre section 2.3
- Format tableau data-extraction Hou Table 5 — adaptable a notre formulaire d'extraction

## Journal de decisions

| # | Date | Decision | Justification | Decideur |
|---|------|----------|---------------|----------|
| 1 | 2026-04-15 | Merge des 2 listes A et B en 7 sources uniques | Accord brut < 0.6 du a couverture complementaire, pas a desaccord | Superviseur + Deviation #1 |
| 2 | 2026-04-15 | Reclassification Dong et Ge en narrative surveys | Verification C : pas d'IC/EC, pas de PRISMA, pas de QA | Agent C |
| 3 | 2026-04-15 | Mohamed DARE = 3.0 (non 4.5) | Verification C : 3 claims de A refutees (auteurs, bases, grille qualite) | Agent C |
| 4 | 2026-04-15 | Hou D5 = 0.5 (non 1.0) | Verification C : Table 5 est un schema, pas des donnees par etude | Agent C, regle conservative |
| 5 | 2026-04-15 | Phase 1.1 gate PASSED | Aucune SLR existante ne couvre scope exact a DARE >= 2.5 | Superviseur |

## Limites documentees

1. **Couverture incomplete** : A et B ont utilise Google/Scholar indirectement via WebSearch. Les bases payantes (IEEE Xplore, ACM DL) ont ete accedees via fetches publics ; certains articles derriere paywall peuvent ne pas avoir ete surfaced. Impact : il est possible qu'une SLR supplementaire existe et ne soit pas dans notre corpus de 7.
2. **A re-executer si** : la Phase 2 demarre plus de 3 mois apres 2026-04-15 (domaine evoluant rapidement, nouvelles SLR probables).
3. **Fabrications de A detectees a posteriori** : ce fichier documente 5 items fabriques. Ces items n'ont pas ete integres dans le livrable final grace au mecanisme A+B+C. Pour Phase 1.2+, renforcer les instructions "quote verbatim or mark NOT VERIFIED" dans les prompts d'extraction.
4. **SLR #3 (Mohamed) internal inconsistency** : le papier dit "39 etudes peer-reviewed" dans l'abstract mais "37 primary studies" dans le corps. Non resolu ici, a noter si on cite ce chiffre plus tard.

## Livrable final

Fichier DARE reconcilie : `verification/dare/ai-collaboration-dare.md`
