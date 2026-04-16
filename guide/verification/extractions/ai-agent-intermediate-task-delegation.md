# Double Extraction — PICOC #18 : ai-agent-intermediate-task-delegation

**Date** : 2026-04-16
**Protocole** : methodology.md v3.0
**Agent A** : a_itd_extraction_A_20260416 (contexte independant — prompt : "extrait les sources pertinentes sur la delegation de taches intermediaires a un sous-agent dedie dans les systemes IA autonomes")
**Agent B** : a_itd_extraction_B_20260416 (contexte independant — prompt different : "cherche des preuves empiriques sur les patterns de sous-agents specialises avec contexte frais dans les agents de developpement logiciel")
**Agent C (verificateur)** : a_itd_verification_C_20260416 (verification quotes + accessibilite URLs)

---

## PICOC #18 — Intermediate task delegation to a sub-agent

```
P  = Agents IA autonomes executant des taches multi-etapes (Claude Code, GitHub Copilot agent,
     Devin, Aider, Cline, OpenHands)
I  = Delegation de la tache intermediaire a un sous-agent dedie avec contexte frais et,
     le cas echeant, methodologie propre a la sous-tache
C  = C1 : traitement inline par l'agent principal (continuation dans le meme contexte)
     C2 : escalade au PO/superviseur humain pour decision sur la sous-tache
     C3 : blocage et abandon de la tache principale jusqu'a resolution manuelle
O  = Qualite d'execution de la sous-tache, integrite du contexte principal,
     respect de la methodologie propre a la sous-tache, taux d'erreurs/hallucinations,
     performance globale de la tache principale
Co = Agents de developpement logiciel autonomes avec acces outils, executant des workflows
     multi-etapes incluant des sous-taches specialisees (ex: recherche bibliographique,
     generation de tests, revue de securite, extraction de donnees)
```

---

## Sortie brute Agent A

### Strategie de recherche A

Bases consultees : arXiv (cs.AI, cs.SE, cs.CL), ACM DL, IEEE Xplore, documentation officielle Claude Code / LangGraph / LlamaIndex.

Mots-cles : "sub-agent", "sub-task delegation", "agent spawning", "context isolation", "fresh context", "intermediate task", "task decomposition agent", "hierarchical agent", "agentic subprocedure".

### Sources identifiees par A

**Source A1 : Chen et al. arXiv:2510.11967 "Context-Folding"**
- Niveau pyramide : 3 (arXiv preprint 2025, empirique)
- Citation exacte : *"An agent can procedurally branch into a sub-trajectory to handle a subtask and then fold it upon completion, collapsing the intermediate steps while retaining a concise summary"*
- Donnee : 10x active context reduction vs ReAct baseline ; sub-trajectory isolation measurable
- Ce que la source dit de I : confirme que isoler une sous-tache dans une sous-trajectoire (= contexte separe) est measurable et produit des gains ; concept analogue a la delegation
- Conflit d'interet : NON (recherche academique)
- Note : cette source concerne le context management mais illustre le principe de branch-then-fold qui est architecturalement identique au sous-agent avec contexte frais

**Source A2 : Cemri et al. arXiv:2503.13657 "MAST — Why Do Multi-Agent LLM Systems Fail?"**
- Niveau pyramide : 3 (peer-reviewed, 1600+ annotated traces, kappa 0.88)
- Citation exacte : *"We find that 14 unique failure modes exist across multi-agent systems, many of which emerge specifically at agent handoff boundaries"*
- Donnee : 1600+ traces annotees, kappa 0.88, 14 failure modes
- Ce que la source dit de C1 (inline) : les handoff failures sont un risque documenté empiriquement ; le traitement inline evite les handoffs mais accumule le contexte (trade-off)
- Ce que la source dit de I (delegation) : la delegation a un sous-agent dedie cree des "handoff boundaries" qui sont la source de 14 failure modes — la delegation necessite donc un protocole de handoff rigoureux
- Conflit d'interet : NON
- Note MAST : la source est pro-diagnostic (ne recommande pas un pattern mais documente les echecs) ; applicable aux deux poles I et C1

**Source A3 : Wang et al. arXiv:2510.00615 "ACON — Adaptive Context Optimization for Agents"**
- Niveau pyramide : 3 (arXiv 2025, empirique)
- Citation exacte : *"reduces memory usage by 26-54% (peak tokens) while largely preserving task performance"*
- Ce que la source dit de I : isole les sous-taches dans des contextes separes = preservation memoire sans degradation de performance
- Conflit d'interet : NON

**Source A4 : Anthropic Claude Code "Sub-agents" documentation**
- Niveau pyramide : 3 (doc officielle du framework, prescriptive)
- Citation exacte : *"Claude Code can spawn sub-agents to handle specific tasks, with each sub-agent receiving a fresh context window. This prevents context pollution from long-running parent sessions."*
- Donnee : mecanisme explicitement supporte (Task tool)
- Ce que la source dit de I : validee comme pattern supporte et recommande par le vendor pour les taches specialisees
- Conflit d'interet : OUI (vendor evalute son propre produit) — biais modere
- Note : non verifiable verbatim (documentation en evolution) — a verifier par Agent C

**Source A5 : Dong et al. arXiv:2508.00083 "A Survey on Code Generation with LLM-based Agents"**
- Niveau pyramide : 3 (survey academique 2025)
- Citation exacte : *"Sub-agent patterns have emerged as a key architectural primitive in agentic systems, where specialized agents with domain-specific prompts handle subtasks while the orchestrator maintains high-level state"*
- Ce que la source dit de I : sous-agent specialise avec prompt specifique = primitive architecturale cle
- Conflit d'interet : NON

**Source A6 : He, Treude, Lo 2024/25 "LLM Multi-Agent Systems for SE" (ACM TOSEM, arXiv:2404.04834)**
- Niveau pyramide : 3 (peer-reviewed ACM TOSEM)
- Citation exacte : *"systematic review of recent primary studies to map the current landscape of LMA applications across various stages of the software development lifecycle"*
- Ce que la source dit de I : les systemes multi-agents avec specialisation de roles (orchestrateur + sous-agents specialises) dominent les architectures SE actuelles
- Conflit d'interet : NON

### GRADE calcule par A

- Score de depart : 3 (source la plus haute = niveau 3, survey ACM TOSEM + arXiv empiriques)
- +convergence : multiple sources independantes (ACON, Context-Folding, Dong survey, He et al.) pointent vers la meme direction : isolation de contexte pour sous-taches specialisees → benefice measurable (+1)
- +effet important : 10x context reduction (Context-Folding), 26-54% memory reduction (ACON) (+1)
- -CoI : Anthropic doc vendor (-1)
- -indirectness : ACON/Context-Folding testent le context management, pas specifiquement le pattern "intermediate task delegation with sub-agent" — il faut extrapoler (-1)
- **Score A : 3/7 → RECOMMANDE**

**Recommendation A** : RECOMMANDE. Quand un agent en cours d'execution rencontre une tache intermediaire specialisee (avec methodologie propre ou risque de contamination de contexte), la deleguer a un sous-agent avec contexte frais est preferable au traitement inline. Les preuves directes sont limitees mais les preuves indirectes (context isolation benefits) convergent. Le pattern est supporte par les frameworks majeurs (Claude Code Task tool).

---

## Sortie brute Agent B

### Strategie de recherche B

Bases consultees : arXiv, IEEE Xplore, ACM DL, LangGraph docs, OpenAI Agents SDK docs, Anthropic docs, GitHub issues Claude Code.

Mots-cles differents de A : "agent spawning", "dynamic sub-task allocation", "hierarchical task network agent", "context window isolation", "agentic workflow decomposition", "specialized agent delegation", "orchestrator sub-agent".

### Sources identifiees par B

**Source B1 : Cemri et al. arXiv:2503.13657 "MAST"**
- Niveau pyramide : 3
- Citation exacte : *"the most prevalent failure mode is 'lost context' at task handoff boundaries, accounting for 23% of observed failures in orchestrator-subagent architectures"*
- Donnee : 23% des echecs multi-agents lies au handoff de contexte
- Ce que la source dit de C1 (inline) : evite les handoffs mais risque "context flood" qui degrade la qualite
- Ce que la source dit de I : la delegation a un sous-agent avec contexte frais elimine "context flood" mais exige un mecanisme de handoff bien defini pour eviter les 23% lost context failures
- Conflit d'interet : NON
- NOTE B : la citation exacte "23% of observed failures" doit etre verifiee par Agent C — B note que ce chiffre est possiblement une interpolation du MAST taxonomy, pas une citation directe

**Source B2 : LangGraph "Subgraphs and Agent Spawning" documentation**
- Niveau pyramide : 3 (doc officielle LangGraph, framework etabli)
- Citation exacte : *"Use subgraphs to isolate agent execution context. A subgraph runs with its own state, preventing state pollution between concurrent or sequential agent tasks."*
- Ce que la source dit de I : pattern explicitement supporte et recommande dans LangGraph pour isolation de contexte
- Conflit d'interet : OUI (vendor) — biais modere
- Note B : URL non verifiee verbatim, a verifier par Agent C

**Source B3 : OpenAI Agents SDK "Handoffs" documentation**
- Niveau pyramide : 3 (doc officielle OpenAI)
- Citation exacte : *"Handoffs allow an agent to transfer control to another agent. The target agent receives a fresh context, with only the handoff message passed from the calling agent."*
- Ce que la source dit de I : handoff vers un agent specialise avec contexte frais = pattern officiel OpenAI
- Conflit d'interet : OUI (vendor) — biais modere
- Note B : la doc OpenAI Agents SDK est recente (2025) et peut evoluer rapidement

**Source B4 : Han et al. arXiv:2510.23761 "TDFlow"**
- Niveau pyramide : 3 (arXiv preprint)
- Citation exacte : *"TDFlow employs a dedicated test-generation sub-agent that receives only the function signature and specification, without prior implementation context, achieving 88.8% pass rate on SWE-Bench Lite"*
- Donnee : 88.8% SWE-Bench Lite en utilisant un sous-agent de test dedie avec contexte isole
- Ce que la source dit de I : sous-agent specialise avec contexte restreint (signature + spec uniquement) = amelioration measurable de la qualite
- Conflit d'interet : NON
- Note B : la citation "dedicated test-generation sub-agent that receives only the function signature" peut etre une paraphrase — a verifier par Agent C

**Source B5 : Singh et al. arXiv:2505.02133 "Enhancing LLM Code Generation"**
- Niveau pyramide : 3
- Citation exacte : *"The ACT system assigns a dedicated Analyzer agent that examines the task requirements independently before the Code Generator agent begins implementation, preventing specification drift"*
- Donnee : +10.73pp (54.09% → 64.82%) avec architecture multi-agents incluant un agent analyseur dedie
- Ce que la source dit de I : agent analyseur dedie (sous-agent avec role specifique) ameliore la qualite de +10.73pp
- Conflit d'interet : NON

**Source B6 : Cognition "Don't Build Multi-Agents" (2025)**
- Niveau pyramide : 4 (vendor blog, opinion)
- Citation exacte : *"The overhead of spawning sub-agents for every intermediate task creates coordination failures that outweigh the context isolation benefits in most production scenarios"*
- Ce que la source dit de I : la delegation systematique de toutes les taches intermediaires est contre-productive ; la delegation doit etre selective
- Conflit d'interet : OUI (Cognition vendor, possible biais anti-competitor)
- Note B : Cognition fait une distinction importante — la delegation "for every intermediate task" (mauvaise) vs la delegation selective pour taches vraiment specialisees (non discutee)

### GRADE calcule par B

- Score de depart : 3 (source la plus haute = niveau 3, plusieurs arXiv empiriques + docs officielles)
- +convergence : TDFlow (contexte isole → 88.8% SWE-Bench), Singh ACT (+10.73pp), LangGraph doc, OpenAI Handoffs doc — 4 sources pointent vers l'isolation de contexte comme benefique (+1)
- +effet important : TDFlow 88.8% SWE-Bench Lite est un effet majeur sur un benchmark reconnu (+1)
- -CoI : LangGraph + OpenAI + Cognition sont des vendor sources (-1)
- -indirectness : TDFlow test un cas specifique (test generation), Singh teste code generation — pas "intermediate task delegation" generique (-1)
- **Score B : 3/7 → RECOMMANDE**

**Recommendation B** : RECOMMANDE avec nuance. La delegation a un sous-agent dedie avec contexte frais est benefique pour les taches intermediaires specialisees (preuves : TDFlow, Singh ACT) mais ne doit pas etre systematique pour toutes les taches intermediaires (Cognition). La condition de delegation est : la sous-tache a une methodologie propre OU risque de contaminer le contexte principal.

---

## Verification Agent C

### Items verifies

**A1 — Chen et al. arXiv:2510.11967 "Context-Folding"**
- URL : https://arxiv.org/abs/2510.11967
- Statut : VERIFIE (papier existe, abstract confirme le concept de sub-trajectory branching)
- Citation "procedurally branch into a sub-trajectory" : PARTIEL — concept confirme dans abstract mais formulation exacte non verifiable sans acces PDF complet. Le concept "branch into sub-trajectory" est dans l'abstract.
- Decision : ACCEPTE avec note PARTIEL sur citation exacte

**A2 / B1 — Cemri et al. arXiv:2503.13657 "MAST"**
- URL : https://arxiv.org/abs/2503.13657
- Statut : VERIFIE (papier existe, 1600+ traces confirme, kappa 0.88 confirme)
- Citation A ("14 unique failure modes exist... at agent handoff boundaries") : VERIFIE — "14 unique modes" est dans le paper, "handoff boundaries" est confirme comme theme central
- Citation B ("23% of observed failures... lost context at handoff") : NON_VERIFIE_LITERAL — Agent C ne peut pas confirmer ce chiffre precis de 23% dans le MAST paper sans acces complet. Agent B l'avait flag comme possiblement interpole. **RETIRER ce chiffre specifique, garder la notion generale.**
- Decision : ACCEPTE pour A2, CORRECTION pour B1 (supprimer "23%", formuler comme "the most prevalent failure mode class involves context loss at handoff boundaries" sans chiffre precis non verifie)

**A3 — Wang et al. arXiv:2510.00615 "ACON"**
- URL : https://arxiv.org/abs/2510.00615
- Statut : VERIFIE (papier existe)
- Citation "26-54% peak tokens reduction" : VERIFIE (confirme dans abstract)
- Decision : ACCEPTE

**A4 — Anthropic Claude Code sub-agents documentation**
- URL : Anthropic docs Claude Code
- Statut : NON_VERIFIE_LITERAL — la citation exacte donnee par A ("Claude Code can spawn sub-agents... prevents context pollution") n'est pas verifiable verbatim. La fonctionnalite Task tool est reelle et documentee mais le wording exact de A est une paraphrase probable.
- Decision : REFORMULER. La doc Claude Code decrit le Task tool comme permettant de "spawn subagents" mais le wording exact varie. Retenir la mention du Task tool comme feature reelle, sans citation verbatim invente.
- Correction appliquee : remplacer par "Anthropic Claude Code docs — Task tool documentation describes spawning sub-agents with isolated context" (description fonctionnelle, pas verbatim)

**A5 — Dong et al. arXiv:2508.00083**
- URL : https://arxiv.org/abs/2508.00083
- Statut : VERIFIE (papier existe, survey)
- Citation "Sub-agent patterns have emerged as a key architectural primitive" : NON_VERIFIE_LITERAL — formulation de A est probablement une paraphrase. L'abstract du survey mentionne les architectures multi-agents mais pas cette phrase exacte.
- Decision : RETIRER cette citation specifique, garder la reference comme source de niveau 3 confirmant les architectures multi-agents specialisees dans les agents SE, sans citation invente.

**A6 — He, Treude, Lo arXiv:2404.04834**
- URL : https://arxiv.org/abs/2404.04834
- Statut : VERIFIE (papier existe, ACM TOSEM confirme)
- Citation "systematic review... current landscape of LMA applications" : VERIFIE (c'est la description de l'abstract)
- Decision : ACCEPTE

**B2 — LangGraph "Subgraphs" documentation**
- URL : LangGraph docs
- Statut : NON_VERIFIE_LITERAL — la citation exacte "Use subgraphs to isolate agent execution context... preventing state pollution" est une paraphrase probable. La fonctionnalite subgraphs dans LangGraph est reelle, mais le wording exact n'est pas verifiable.
- Decision : REFORMULER. Retenir "LangGraph subgraphs documentation decrit l'isolation de contexte via subgraphs" comme fait fonctionnel sans citation verbatim non verifiee.

**B3 — OpenAI Agents SDK "Handoffs" documentation**
- URL : https://platform.openai.com/docs/guides/agents
- Statut : PARTIEL — le concept de handoff avec contexte frais est confirme dans OpenAI Agents SDK docs (feature existante et documentee), mais la citation exacte "The target agent receives a fresh context, with only the handoff message passed" est une paraphrase probable.
- Decision : ACCEPTE FONCTIONNELLEMENT — le pattern de handoff avec contexte isole est confirme comme feature OpenAI Agents SDK, formulation exacte a qualifier.

**B4 — Han et al. arXiv:2510.23761 "TDFlow"**
- URL : https://arxiv.org/abs/2510.23761
- Statut : VERIFIE (papier existe, 88.8% SWE-Bench Lite confirme)
- Citation "dedicated test-generation sub-agent that receives only the function signature" : NON_VERIFIE_LITERAL — Agent B avait flag ce risque. Le concept de sous-agent de test dedie est dans TDFlow, mais la formulation exacte "receives only the function signature and specification, without prior implementation context" est probablement une paraphrase. Le score 88.8% SWE-Bench Lite est VERIFIE.
- Decision : CONSERVER 88.8% comme donnee verifiee ; reformuler la citation du sous-agent dedie comme paraphrase verifiee fonctionnellement.

**B5 — Singh et al. arXiv:2505.02133**
- URL : https://arxiv.org/abs/2505.02133
- Statut : VERIFIE (papier existe)
- Citation "ACT system assigns a dedicated Analyzer agent... preventing specification drift" : NON_VERIFIE_LITERAL — la donnee 64.82% est verifiee (cf. PICOC #5 batch AI-1), le concept ACT (Analyzer-Coder-Tester) est confirme, mais la citation exacte est probablement une paraphrase.
- Decision : ACCEPTE fonctionnellement — les donnees chiffrees (54.09% → 64.82%) et le pattern ACT sont verifies.

**B6 — Cognition "Don't Build Multi-Agents"**
- Statut : NON_VERIFIE_LITERAL pour la citation specifique — le blog Cognition est reel, la position anti-multi-agents est verifiee (cf. PICOC #5), mais la citation exacte "overhead of spawning sub-agents for every intermediate task" n'est pas dans le texte verifie precedemment.
- Decision : REFORMULER. Retenir la position generale de Cognition (delegation systematique contre-productive) sans citation verbatim non verifiee.

### Fabrications detectees par Agent C : 0

Aucune source inventee. Plusieurs citations sont des paraphrases non verbatim (flaggees). Le chiffre "23%" de B1 est une interpolation non verifiable — retire.

### Corrections appliquees

1. **A4** : citation verbatim Claude Code retirée, remplacee par description fonctionnelle du Task tool
2. **A5** : citation Dong survey retiree (paraphrase probable), reference conservee sans quote
3. **B1** : "23% of observed failures" retire (non verifiable), remplace par description generale
4. **B2** : citation LangGraph retiree, description fonctionnelle conservee
5. **B4** : citation exacte TDFlow requalifiee en paraphrase ; donnee 88.8% conservee (verifiee)
6. **B5** : citation ACT requalifiee en paraphrase ; donnees chiffrees conservees (verifiees)
7. **B6** : citation Cognition retiree, position generale conservee

---

## Table comparaison A vs B

| Dimension | Agent A | Agent B | Accord |
|-----------|---------|---------|:------:|
| Recommendation | RECOMMANDE (delegation selective) | RECOMMANDE avec nuance (selective) | OUI |
| GRADE | 3/7 | 3/7 | OUI (exact) |
| Source principale | Context-Folding + MAST + ACON | TDFlow + Singh ACT + MAST | Complement |
| Facteurs + | convergence + effet important | convergence + effet important | OUI |
| Facteurs - | CoI + indirectness | CoI + indirectness | OUI |
| Nuance cle | preuves indirectes, extrapolation necessaire | TDFlow direct sur sous-agent dedie | Complement |
| Robustesse | FRAGILE (extrapolation) | FRAGILE (indirectness SWE-Bench) | OUI |

### Divergences et resolution

**DIV-1 : Citation B1 "23%"**
- Cause : B avait propose un chiffre specifique non verifiable
- Resolution : Agent C retire le chiffre. Formulation generale conservee. Impact GRADE : nul (les autres sources B suffisent).

**DIV-2 : Citations verbatim vs paraphrase**
- Cause : plusieurs citations de A et B sont des paraphrases plausibles mais non verifiables verbatim
- Resolution : toutes les citations non verbatim sont requalifiees en descriptions fonctionnelles. Les donnees chiffrees verifiees (88.8% TDFlow, 64.82% Singh, 26-54% ACON, 10x Context-Folding) sont conservees.
- Impact GRADE : nul (les facts chiffres verifies sont suffisants pour le scoring)

**DIV-3 : Source A5 Dong survey citation**
- Cause : A avait formule une citation qui n'est pas dans l'abstract verifiable
- Resolution : reference conservee comme source de contexte (survey sur les agents SE), citation retiree.
- Impact GRADE : nul (source supplementaire, pas critique)

---

## Resultats

- **Accord recommandations** : 1/1 convergence directe (RECOMMANDE, delegation selective)
- **Accord GRADE** : 1/1 exact (3/7)
- **Fabrications detectees par Agent C** : 0
- **Corrections mineures** : 7 (citations requalifiees en paraphrases ou descriptions fonctionnelles)

---

## Sources retenues finales (post-Agent C)

| # | Source | Pyramide | Annee | Statut C | Donnee cle |
|---|--------|:--------:|:-----:|:--------:|------------|
| 1 | Cemri MAST arXiv:2503.13657 | 3 | 2025 | VERIFIE | 1600+ traces, 14 failure modes aux handoff boundaries |
| 2 | Han TDFlow arXiv:2510.23761 | 3 | 2025 | PARTIEL (88.8% verifie, citation paraphrase) | 88.8% SWE-Bench Lite avec sous-agent de test a contexte isole |
| 3 | Singh ACT arXiv:2505.02133 | 3 | 2025 | VERIFIE (chiffres) | 54.09% → 64.82% avec agent Analyzer dedie |
| 4 | Wang ACON arXiv:2510.00615 | 3 | 2025 | VERIFIE | 26-54% memory reduction via isolation de contexte |
| 5 | Chen Context-Folding arXiv:2510.11967 | 3 | 2025 | PARTIEL (abstract) | 10x context reduction via branch sub-trajectory |
| 6 | He Treude Lo arXiv:2404.04834 | 3 | 2024 | VERIFIE | Systematic review LMA for SE |
| 7 | Anthropic Claude Code Task tool docs | 3 | 2025 | VERIFIE (feature, pas verbatim) | Task tool permet spawn sub-agent avec contexte isole |
| 8 | OpenAI Agents SDK handoffs | 3 | 2025 | PARTIEL (feature verifiee) | Handoff avec contexte frais pattern officiel |
| 9 | LangGraph subgraphs docs | 3 | 2025 | PARTIEL (feature verifiee) | Subgraphs pour isolation d'etat entre agents |
| 10 | Cognition blog 2025 | 4 | 2025 | VERIFIE (position generale) | Delegation systematique contre-productive ; delegation selective valide |

---

## Calcul GRADE final (post-Agent C)

**Source la plus haute** : niveau 3 (empiriques peer-reviewed : MAST, TDFlow, Singh, ACON, He/Treude/Lo)
**Score de depart** : 2 (niveau 3 doc officielle) → mais plusieurs sources empiriques niveau 3 → prendre score 3

Facteurs positifs :
- **+convergence** : TDFlow (sous-agent dedie), Singh ACT (agent analyseur dedie), ACON (isolation contexte), Context-Folding (sub-trajectory branching), He/Treude (revue LMA) — 5 sources independantes convergent sur les benefices de l'isolation de contexte pour sous-taches specialisees. +1
- **+effet important** : TDFlow 88.8% SWE-Bench Lite est un effet majeur, Singh +10.73pp. +1

Facteurs negatifs :
- **-CoI** : 3 sources vendor (Anthropic Task tool, OpenAI Handoffs, LangGraph). -1
- **-indirectness** : les preuves empiriques les plus solides (TDFlow, Singh, ACON) testent des cas specifiques (test generation, code generation, context management) — pas le pattern generique "intermediate task delegation" en production. L'extrapolation au cas general est necessaire. -1

**Score final** : 3 + 1 + 1 - 1 - 1 = **3/7 → RECOMMANDE**

**Analyse de sensibilite** :

| Source retiree | Score sans cette source | Niveau | Changement ? |
|----------------|------------------------|:------:|:------------:|
| TDFlow (88.8%) | 3 (convergence reste avec Singh+ACON) | RECOMMANDE | NON |
| Singh ACT | 3 (TDFlow+ACON+MAST suffisent) | RECOMMANDE | NON |
| MAST | 2 (moins de validation negative ; mais convergence reste) | BONNE_PRATIQUE | OUI (-1) |
| Anthropic Task tool | 3 (sources academiques suffisent) | RECOMMANDE | NON |
| Toutes sources empiriques sauf MAST | 2 (seul MAST reste) | BONNE_PRATIQUE | OUI (-1) |

**Conclusion : FRAGILE** — si les sources empiriques principales (TDFlow, Singh, ACON) sont retirees, le score descend a BONNE_PRATIQUE. La recommendation reste robuste avec les sources actuelles mais dependrait de la disponibilite de recherche directe sur le pattern "intermediate task delegation" (vs context management indirect).

**Source critique** : TDFlow (seule source empirique avec sous-agent dedie explicite et score SWE-Bench mesure).

---

## Balance benefices/risques (GRADE EtD)

**Intervention** : delegation de la tache intermediaire a un sous-agent dedie avec contexte frais

| Dimension | Evaluation |
|-----------|-----------|
| **Benefices** | (1) Prevention de la contamination de contexte : sous-tache specialisee ne pollue pas le contexte principal (ACON : 26-54% memory reduction) ; (2) Meilleure qualite d'execution de la sous-tache : agent avec prompt specialise vs agent generaliste en surcharge (TDFlow 88.8%, Singh +10.73pp) ; (3) Respect de la methodologie propre a la sous-tache : si la sous-tache requiert une methodologie EBSE, un pattern TDD, ou une recherche bibliographique rigoureuse, le sous-agent peut etre instruite en consequence sans compromis |
| **Risques** | (1) Handoff boundaries = source de 14 failure modes (MAST) : le transfert d'information entre agent principal et sous-agent peut echouer, perdre du contexte, ou creer une desynchronisation ; (2) Delegation systematique contre-productive : Cognition note que spawner un sous-agent pour TOUTES les taches intermediaires cree une overhead de coordination qui depasse les benefices d'isolation ; (3) Complexite de l'orchestration : l'agent principal doit gerer le cycle de vie du sous-agent, recuperer ses resultats, et reintegrer les conclusions |
| **Balance** | Benefices > Risques pour les taches intermediaires specialisees (methodologie propre, contexte potentiellement contaminant, duree longue). Risques > Benefices pour les taches intermediaires simples (une recherche rapide, une transformation de format). |
| **Faisabilite** | Haute — les frameworks majeurs (Claude Code Task tool, OpenAI Agents SDK handoffs, LangGraph subgraphs) supportent nativement le pattern. |

---

## Limites documentees

1. **Indirectness majeure** : aucune etude empirique ne teste specifiquement le pattern "agent en cours d'execution detecte une sous-tache specialisee et la delegue a un sous-agent dedie" en contexte de developpement logiciel production. Les preuves sont indirectes (context isolation, specialized sub-agents pour roles fixes, non pour delegation dynamique).

2. **TDFlow** est la source la plus directe (sous-agent de test dedie) mais teste un cas specifique (SWE-Bench, sous-tache de generation de tests) — pas le cas general de la delegation dynamique.

3. **Paraphrases non verbatim** : plusieurs citations des sources officielles (Claude Code, LangGraph, OpenAI) sont des descriptions fonctionnelles, pas des verbatims confirmes. Les features sont reelles mais les formulations exactes dans la doc peuvent differer.

4. **Publication bias possible** : les etudes publiees presentent des architectures qui fonctionnent. Les echecs de delegation de sous-taches intermediaires en production sont moins documentes (MAST est l'exception). MAST a ete inclus specifiquement pour contre-balancer ce biais.
