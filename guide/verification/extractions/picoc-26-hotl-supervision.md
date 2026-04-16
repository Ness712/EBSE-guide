# Double Extraction EBSE — PICOC #26 : ai-agent-hotl-supervision

**Date de recherche** : 2026-04-16  
**Protocole** : methodology.md v3.0 §2.1 — double extraction indépendante + vérification Agent C  
**Question PICOC** : Comment superviser efficacement un agent IA autonome sans micro-management, et à quel niveau d'autonomie déléguer selon le type de tâche (Human-On-The-Loop vs Human-In-The-Loop) ?

---

## Agent A — Extraction

**Mots-clés** : "human-on-the-loop AI agent supervision", "levels of autonomy agentic AI", "human oversight AI agent software development", "HITL vs HOTL autonomous agent", "AI agent supervision without micromanagement", "human-AI collaboration oversight empirical"

### A1 — Magentic-UI — arXiv:2507.22358

- **Auteurs** : Hussein Mozannar, Gagan Bansal, Cheng Tan, Adam Fourney, Victor Dibia, Jingya Chen et al. (Microsoft Research — 20 auteurs)
- **Année** : 2025 (soumis 30 juillet 2025)
- **Venue** : arXiv preprint (cs.AI, cs.HC) — non peer-reviewed
- **Quote abstract** : *"AI agents powered by large language models are increasingly capable of autonomously completing complex, multi-step tasks using external tools. Yet, they still fall short of human-level performance in most domains including computer use, software development, and research. Their growing autonomy and ability to interact with the outside world, also introduces safety and security risks including potentially misaligned actions and adversarial manipulation. We argue that human-in-the-loop agentic systems offer a promising path forward, combining human oversight and control with AI efficiency to unlock productivity from imperfect systems."*
- **Quote résultat clé** : *"Magentic-UI with the simulated user that has access to side information improves the accuracy of autonomous Magentic-UI by 71%, from a 30.3% task-completion rate to a 51.9% task-completion rate."*
- **N** : 162 tâches GAIA (validation set), utilisateurs simulés (GPT-4o) — pas d'étude utilisateurs réels publiée
- **CORRECTION Agent C** : +71% est une amélioration RELATIVE (30.3%→51.9% = +21.6 pts absolus). L'utilisateur est SIMULÉ (GPT-4o), pas réel. Valeur indicative, pas démonstrative de la valeur avec utilisateurs réels.
- **Niveau pyramide** : 3 (preprint Microsoft Research, benchmark simulé)
- **Statut** : VÉRIFIÉ — claim +71% confirmé avec nuances

### A2 — Anthropic "Measuring AI Agent Autonomy in Practice"

- **Auteurs** : Miles McCain, Thomas Millar, Saffron Huang et al. (20 auteurs Anthropic)
- **Date** : 18 février 2026
- **Venue** : Anthropic Research Blog — rapport institutionnel, non peer-reviewed
- **Quote clé** : *"Effective oversight doesn't require approving every action but being in a position to intervene when it matters."*
- **N** : ~2 millions d'interactions — 998 481 tool calls API + données Claude Code (500 000 interruptions, 500 000 turns complétés)
- **Résultat** : Les utilisateurs expérimentés migrent naturellement vers HOTL (taux d'auto-approbation ×2 après 750 sessions)
- **Biais** : Anthropic mesure ses propres produits — biais institutionnel non négligeable
- **Niveau pyramide** : 4 (institutionnel, très large N mais non peer-reviewed)
- **Statut** : VÉRIFIÉ

### A3 — HULA — arXiv:2411.12924 (ICSE SEIP 2025)

- **Auteurs** : Wannita Takerngsaksiri, Jirat Pasuksmit, Patanamon Thongtanunam, Chakkrit Tantithamthavorn, Ruixiong Zhang, Fan Jiang, Jing Li, Evan Cook, Kun Chen, Ming Wu (Atlassian + Monash University)
- **Venue** : ICSE SEIP 2025 (peer-reviewed, venue rang A en SE)
- **Quote abstract** : *"we introduce a Human-in-the-loop LLM-based Agents framework (HULA) for software development that allows software engineers to refine and guide LLMs when generating coding plans and source code for a given task."*
- **N** : 663 work items Jira sur 2 mois (déploiement interne Atlassian)
- **Résultats** : 79% taux de génération de plans de code ; 82% taux d'approbation des plans générés
- **Niveau pyramide** : 2 (empirique peer-reviewed, étude industrielle déployée)
- **Statut** : VÉRIFIÉ

---

## Agent B — Extraction

**Mots-clés** : "agentic AI human control autonomy spectrum", "AI agent autonomy granularity empirical", "Sheridan Verplank levels of automation AI", "agent oversight mechanism production", "collaborative human-AI task delegation", "levels of autonomy AI agents framework"

### B1 — Feng, McDonald & Zhang 2025 — arXiv:2506.12469

- **Auteurs** : K. J. Kevin Feng, David W. McDonald, Amy X. Zhang (University of Washington)
- **Venue** : Knight First Amendment Institute, Columbia University — essai conceptuel
- **Quote abstract** : *"We define five levels of escalating agent autonomy, characterized by the roles a user can take when interacting with an agent: operator, collaborator, consultant, approver, and observer."*
- **Méthode** : Framework conceptuel — 5 niveaux : operator, collaborator, consultant, approver, observer
- **Note** : Ce n'est PAS une étude empirique — travail normatif/conceptuel
- **Niveau pyramide** : 4 (conceptuel, non empirique)
- **Statut** : VÉRIFIÉ

### B2 — Sheridan & Verplank 1978

- **Titre exact** : "Human and Computer Control of Undersea Teleoperators"
- **Auteurs** : Thomas B. Sheridan, William L. Verplank
- **Institution** : MIT Man-Machine Systems Laboratory
- **Venue** : Rapport technique DTIC ADA057655
- **Contenu** : Taxonomie 10 niveaux d'automatisation (LOA) allant de "l'opérateur fait tout" (niveau 1) à "l'ordinateur agit entièrement de façon autonome sans informer l'opérateur" (niveau 10)
- **Note** : Référence classique fondatrice — pas d'étude empirique directe. Concerne la téléopération sous-marine des années 1970, pas les agents LLM.
- **Niveau pyramide** : 4 (référence classique fondatrice, non empirique)
- **Statut** : VÉRIFIÉ — DTIC ADA057655 confirmé

### B3 — Geninatti Cossatin et al. 2026 — IP&M

- **Auteurs** : Angelo Geninatti Cossatin, Fabio Ferrero, Liliana Ardissono, Noemi Mauro (Université de Turin)
- **Venue** : Information Processing & Management (Elsevier, SJR Q1), DOI: 10.1016/j.ipm.2026.104681, vol. 63:5 (juillet 2026)
- **N** : 230 participants
- **Méthode** : Étude expérimentale — 3 conditions (baseline manuel, autonomie moyenne avec confirmation, haute autonomie proactive) ; NASA-TLX workload + métriques précision/rappel
- **Résultats** : Précision >82% pour les deux conditions IA vs 65% baseline ; rappel 63% (haute autonomie) vs 14% (baseline) ; **autonomie moyenne = meilleur équilibre productivité + préférences de contrôle**
- **Niveau pyramide** : 2 (empirique peer-reviewed, revue SJR Q1)
- **Statut** : VÉRIFIÉ — DOI, N=230, résultats confirmés

### B4 — OrchVis — arXiv:2510.24937 (EXCLU)

- **Auteur** : Jieyu Zhou (Georgia Institute of Technology) — auteur unique
- **EXCLU** : Prototype sans évaluation empirique ; user studies listées comme travail futur. Aucun résultat quantitatif publiable.
- **CORRECTION CRITIQUE** : Source initialement attribuée à "Feng et al." dans le brief — ERREUR. OrchVis est de Jieyu Zhou, Feng et al. (arXiv:2506.12469) est un framework LOA conceptuel distinct.

---

## Agent C — Corrections et vérification

### C1 — Magentic-UI : +71% mal formulé

**Avant** : "+71% absolu sur tâches web complexes"  
**Après** : +71% est une **amélioration relative** du taux de complétion : 30.3% → 51.9% (+21.6 points absolus). Avec **utilisateur SIMULÉ** (GPT-4o), pas un utilisateur réel. Les auteurs précisent : *"These experiments reflect a lower bound on the value of human feedback, since real users can step in at any time."* → Valeur indicative uniquement.  
**Sévérité** : Importante — la formulation initiale surestimait significativement le résultat

### C2 — "Feng et al. 2025 — OrchVis" : double erreur

**Correction** : Deux sources distinctes ont été confondues :
1. **Feng, McDonald & Zhang arXiv:2506.12469** = framework conceptuel LOA à 5 niveaux (UW, Knight Columbia)
2. **Jieyu Zhou arXiv:2510.24937** = OrchVis prototype (Georgia Tech, solo-author, aucune évaluation empirique)

Les deux sont distincts. OrchVis exclu de l'analyse GRADE.  
**Sévérité** : Importante

### C3 — Sheridan & Verplank 1978 : confirmé

Titre, année, institution, 10 niveaux LOA — tout confirmé via DTIC ADA057655.

### C4 — Anthropic : biais institutionnel

Source valide mais à traiter comme niveau 4 (institutionnel) — Anthropic mesure ses propres produits.

### Fabrications détectées : AUCUNE

---

## Sources retenues

| # | Source | Retenue | Raison |
|---|--------|---------|--------|
| 1 | Magentic-UI 2507.22358 | **OUI** | Microsoft Research, claim vérifié (+71% relatif, simulé) |
| 2 | Anthropic Measuring Autonomy | **OUI** | N~2M, données réelles — biais institutionnel noté |
| 3 | HULA 2411.12924 | **OUI** | ICSE SEIP 2025, N=663, déploiement réel Atlassian |
| 4 | Geninatti Cossatin IP&M 2026 | **OUI** | Peer-reviewed SJR Q1, N=230, autonomie moyenne optimale |
| 5 | Feng et al. 2506.12469 | **OUI** | Framework LOA, conceptuel, utile pour taxonomie |
| 6 | Sheridan & Verplank 1978 | **OUI** | Référence fondatrice 10 niveaux LOA |
| 7 | OrchVis 2510.24937 | **EXCLU** | Prototype sans évaluation empirique |

---

## GRADE calculé

| Facteur | Valeur | Justification |
|---------|--------|---------------|
| Base | +3 | Sources niveau 2 peer-reviewed : HULA (ICSE SEIP) + Geninatti Cossatin (IP&M Q1) |
| Convergence | +1 | S1, S2, S3, S4 convergent : supervision par exception > absence de supervision ; autonomie moyenne > extrêmes |
| Effet important | +1 | +71% relatif Magentic-UI ; précision +26 pts + rappel +49 pts (IP&M) ; 82% taux approbation HULA |
| Biais | -1 | Magentic-UI = utilisateurs simulés (biais validité externe) ; Anthropic = auto-mesure institutionnelle |
| Indirectness | -1 | HULA/Magentic-UI mesurent HITL (approbation de plans), pas HOTL strictement ; Sheridan 1978 = téléopération sous-marine, pas agents LLM |

**GRADE = 3 + 1 + 1 - 1 - 1 = 3/7 — RECOMMANDE FRAGILE**

---

## Principe recommandé

Appliquer HITL (approbation de chaque action critique) pour les tâches à forte irréversibilité ou ambiguïté domaine (auth, schema DB, infra), où le gain de taux de complétion justifie la friction (+71% relatif avec accès au contexte, Magentic-UI ; 82% taux d'approbation en SE réel, HULA). Appliquer HOTL (supervision par exception) pour les tâches routinières à fort volume, où l'autonomie moyenne maximise le trade-off productivité/contrôle (N=230, IP&M 2026) et où les praticiens expérimentés convergent naturellement (Anthropic, ~2M interactions). **Règle de routage : criticité × irréversibilité → HITL ; volume × routinisation → HOTL.**

## Robustesse

**PARTIELLE**

- Sources peer-reviewed (HULA, IP&M) portent sur HITL, pas directement HOTL comme supervision par exception
- La source la plus directe sur l'évolution naturelle vers HOTL (Anthropic) est institutionnelle et biaisée
- Magentic-UI repose sur des utilisateurs simulés — valeur indicative seulement
- Aucun RCT peer-reviewed comparant directement HITL vs HOTL sur des agents de développement logiciel avec utilisateurs réels

---

## Divergences A vs B

| Divergence | Agent A | Agent B | Résolution |
|-----------|---------|---------|------------|
| "Feng et al. OrchVis" | Associé à supervision multi-agents | Identifié comme deux sources distinctes | Agent C : deux sources différentes — OrchVis exclu, Feng et al. = conceptuel uniquement |
| Sheridan & Verplank | Non trouvé (mots-clés A) | Trouvé via mots-clés spécifiques | Retenu comme référence fondatrice (niveau 4) |
| Geninatti Cossatin | Non trouvé | Trouvé via "autonomy spectrum" | Retenu — seule source empirique peer-reviewed directe sur spectre d'autonomie |

## Analyse de sensibilité

Sans Magentic-UI (utilisateurs simulés) : GRADE inchangé à 3/7 car le score repose sur HULA et Geninatti Cossatin. Sans les deux sources peer-reviewed (HULA + IP&M) : GRADE recule à 2/7 (Anthropic institutionnel + Magentic-UI preprint simulé uniquement).
