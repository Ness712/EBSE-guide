# Double Extraction EBSE — PICOC #25 : ai-agent-mast-failure-modes

**Date de recherche** : 2026-04-16  
**Protocole** : methodology.md v3.0 §2.1 — double extraction indépendante + vérification Agent C  
**Question PICOC** : Quels sont les modes de défaillance spécifiques aux agents IA autonomes et comment les anticiper systématiquement pour minimiser les erreurs silencieuses en développement logiciel ?

---

## Agent A — Extraction

**Mots-clés** : "AI agent failure modes taxonomy", "autonomous agent error classification", "MAST agent failure taxonomy", "LLM agent failure detection", "agentic AI silent failure", "multi-agent failure diagnosis"

### A1 — MAST — arXiv:2503.13657 (NeurIPS 2025)

- **Titre** : "Why Do Multi-Agent LLM Systems Fail?"
- **Auteurs** : Mert Cemri, Melissa Z. Pan, Shuyi Yang, Lakshya A. Agrawal, Bhavya Chopra, Rishabh Tiwari, Kurt Keutzer, Aditya Parameswaran, Dan Klein, Kannan Ramchandran, Matei Zaharia, Joseph E. Gonzalez, Ion Stoica
- **Affiliation** : UC Berkeley Sky Computing Lab
- **Venue** : NeurIPS 2025, Track on Datasets and Benchmarks (OpenReview ID: fAjbYBmonr) — VÉRIFIÉ
- **Quote abstract** : *"Despite growing enthusiasm for Multi-Agent LLM Systems (MAS), their performance gains on popular benchmarks often remain minimal compared with single-agent frameworks. This gap highlights the need to systematically analyze the challenges hindering MAS effectiveness. We present MAST (Multi-Agent System Failure Taxonomy), the first empirically grounded taxonomy designed to understand MAS failures. We analyze seven popular MAS frameworks across over 200 tasks, involving six expert human annotators."*
- **N** : 1600+ traces annotées (MAST-Data), 150 traces pour développement taxonomie, 7 frameworks, 6 annotateurs experts
- **κ** : 0.88 (développement taxonomie) ; **0.79 (validation out-of-domain)** — CORRECTION Agent C
- **Taux d'échec** : 41% à 86.7% sur 7 frameworks MAS SOTA open-source
- **Taxonomie — 14 modes, 3 catégories** :
  - **FC1 — Specification issues** : FM-1.1 Disobey Task Specification (15.7%), FM-1.2 Disobey Role Specification, FM-1.3 Step Repetition (13.2%), FM-1.4 Loss of Conversation History (8.2%), FM-1.5 Unaware of Termination Conditions
  - **FC2 — Inter-agent misalignment** : FM-2.1 Conversation Reset (2.2%), FM-2.2 Fail to Ask for Clarification (6.8%), FM-2.3 Task Derailment (7.4%), FM-2.4 Information Withholding (0.85%), FM-2.5 Ignored Other Agent's Input (1.9%), FM-2.6 Reasoning-Action Mismatch (13.2%)
  - **FC3 — Task verification** : FM-3.1 Premature Termination (1.5%), FM-3.2 No or Incomplete Verification (9.1%), FM-3.3 Incorrect Verification (2.8%)
- **Niveau pyramide** : 2 (empirique observationnelle annotée, NeurIPS 2025)
- **Statut** : VÉRIFIÉ Agent C

### A2 — Who&When — arXiv:2505.00212 (ICML 2025 Spotlight)

- **Titre** : "Which Agent Causes Task Failures and When? On Automated Failure Attribution of LLM Multi-Agent Systems"
- **Auteurs** : Shaokun Zhang, Ming Yin, Jieyu Zhang, Jiale Liu, Zhiguang Han, Jingyang Zhang, Beibin Li, Chi Wang, Huazheng Wang, Yiran Chen, Qingyun Wu
- **Affiliation** : Penn State University, Duke University, Google DeepMind
- **Venue** : ICML 2025 Spotlight — VÉRIFIÉ
- **N** : 127 systèmes multi-agents LLM avec annotations fine-grained
- **Résultat** : 53.5% accuracy d'identification de l'agent défaillant (meilleure méthode) ; 14.2% pour l'étape précise. Certaines méthodes performent sous le niveau aléatoire.
- **"Identification rate"** : taux de réussite à identifier correctement quel agent dans le pipeline est causalement responsable de l'échec — pas seulement détecter un échec
- **Niveau pyramide** : 2 (empirique, ICML 2025 Spotlight)
- **Statut** : VÉRIFIÉ

### A3 — ReliabilityBench — arXiv:2601.06112

- **Auteur** : Aayush Gupta (auteur unique)
- **N** : 1280 episodes ; 2 modèles (Gemini 2.0 Flash, GPT-4o) ; 2 architectures (ReAct, Reflexion) ; 4 domaines
- **Méthode** : chaos engineering — injection pannes (timeouts, rate limits, partial responses, schema drift)
- **Résultats** : succès 96.9% à ε=0, chute à 88.1% à ε=0.2. Rate limiting = panne la plus dommageable. ReAct plus robuste que Reflexion sous stress combiné.
- **Niveau pyramide** : 2 (empirique expérimentale — auteur unique, preprint)
- **Statut** : VÉRIFIÉ

---

## Agent B — Extraction

**Mots-clés** : "agent error pattern empirical study", "coding agent failure analysis production", "autonomous software agent reliability failure", "LLM agent debugging failure modes", "agent task failure attribution multi-agent"

### B1 — Ehsani et al. — arXiv:2601.15195 (MSR 2026)

- **Titre** : "Where Do AI Coding Agents Fail? An Empirical Study of Failed Agentic Pull Requests in GitHub"
- **Auteurs** : Ramtin Ehsani, Sakshi Pathak, Shriya Rawal, Abdullah Al Mujahid, Mia Mohammad Imran, Preetha Chatterjee
- **Venue** : MSR 2026 (Mining Software Repositories, peer-reviewed) — VÉRIFIÉ
- **Quote abstract** : *"AI coding agents are now submitting pull requests (PRs) to software projects, acting not just as assistants but as autonomous contributors. As these agentic contributions are rapidly increasing across real repositories, little is known about how they behave in practice and why many of them fail to be merged. In this paper, we conduct a large-scale study of 33k agent-authored PRs made by five coding agents across GitHub."*
- **N** : 33 000 PRs, 5 agents coding, 600 PRs analysés qualitativement
- **Résultats** : documentation/CI/build = meilleur taux de merge ; performance/bug-fix = pire. Raisons rejet : manque d'engagement reviewer, PRs dupliquées, features non désirées, misalignment agent
- **Niveau pyramide** : 2 (empirique observationnelle grande échelle, MSR 2026 peer-reviewed)
- **Statut** : VÉRIFIÉ

### B2 — Rabanser et al. — arXiv:2602.16666

- **Auteurs** : Stephan Rabanser, Sayash Kapoor, Peter Kirgis, Kangheng Liu, Saiteja Utpala, Arvind Narayanan (Princeton)
- **Résultat** : "nearly two years of rapid capability progress have produced only modest reliability gains"
- **N** : 14 modèles, 2 benchmarks, 12 métriques / 4 dimensions
- **Niveau pyramide** : 2 (empirique comparative, Princeton)
- **Statut** : VÉRIFIÉ (identique PICOC #21 et #23)

### B3 — Bugs in Agentic Frameworks — arXiv:2604.08906

- **Titre** : "Dissecting Bug Triggers and Failure Modes in Modern Agentic Frameworks: An Empirical Study"
- **Auteurs** : Xiaowen Zhang, Hannuo Zhang, Shin Hwei Tan (Concordia University)
- **N** : 409 bugs corrigés, 5 frameworks (CrewAI, AutoGen, LangChain, LangGraph, SmolAgents)
- **Résultats** : causes racines = model-related faults, cognitive context mismanagement, orchestration faults. Bugs concentrés dans l'abstraction d'orchestration.
- **Niveau pyramide** : 2 (empirique observationnelle)
- **Statut** : VÉRIFIÉ

---

## Agent C — Corrections et vérification

### C1 — MAST κ : deux valeurs, pas une

**Avant** : "κ=0.88"  
**Après** :
- κ=0.88 : accord inter-annotateurs pendant le **développement** de la taxonomie (150 traces, processus itératif)
- κ=0.79 : validation finale sur traces **out-of-domain** avec la taxonomie finalisée

Les deux sont robustes (>0.6 = accord substantiel). Mais citer κ=0.88 seul sans mentionner κ=0.79 est incomplet.  
**Sévérité** : Modérée

### C2 — MAST catégories : noms exacts

**Avant** : "system design issues" (certaines sources secondaires)  
**Après** : Noms exacts = **(i) specification issues, (ii) inter-agent misalignment, (iii) task verification**. "System design issues" est une paraphrase incorrecte.  
**Sévérité** : Modérée

### C3 — MAST venue NeurIPS 2025

NeurIPS 2025 Datasets and Benchmarks Track — CONFIRMÉ via OpenReview (forum ID: fAjbYBmonr). Tier-1 conférence.

### C4 — Who&When : ICML 2025 Spotlight (pas NeurIPS)

Venue exacte = ICML 2025 Spotlight — CONFIRMÉ. Pas NeurIPS comme parfois mal cité.

### C5 — ReliabilityBench : auteur unique, preprint

Aayush Gupta = auteur unique, preprint sans venue conférence confirmée. À traiter avec précaution.

### Fabrications détectées : AUCUNE

---

## Sources retenues

| # | Source | arXiv | Retenue | Justification |
|---|--------|-------|---------|---------------|
| 1 | MAST | 2503.13657 | **OUI** | NeurIPS 2025 D&B, κ=0.79/0.88, N=1600+, référence pour la taxonomie |
| 2 | Who&When | 2505.00212 | **OUI** | ICML 2025 Spotlight, 53.5% identification, N=127 |
| 3 | Ehsani | 2601.15195 | **OUI** | MSR 2026, N=33K PRs, production réelle |
| 4 | ReliabilityBench | 2601.06112 | **OUI** | Chaos engineering, 1280 episodes |
| 5 | Rabanser | 2602.16666 | **OUI** | Princeton, 14 modèles, capability-reliability gap |
| 6 | Bugs in Frameworks | 2604.08906 | **OUI** | Angle complémentaire : bugs framework-level |
| 7 | Zhu et al. | 2602.21806 | **EXCLU** | Chevauchement fort avec S6 — apport marginal |

---

## GRADE calculé

| Facteur | Valeur | Justification |
|---------|--------|---------------|
| Base | +3 | Toutes sources niveau 2 empirique (NeurIPS, ICML, MSR, Princeton) |
| Convergence | +1 | 5 sources indépendantes convergent sur l'existence de défaillances systémiques et non-détectées |
| Effet important | +1 | 41-86.7% taux d'échec (MAST) ; 53.5% identification max (Who&When) ; stagnation fiabilité malgré 2 ans progrès (Rabanser) |
| Biais | -1 | S1 = 7 frameworks spécifiques (sélection) ; S3 = 5 agents GitHub (sélection) ; S4 = auteur unique |
| Indirectness | 0 | Non appliqué : S3 directement sur coding agents en production GitHub ; S1 analyse MAS = indirectness partielle seulement |

**GRADE = 3 + 1 + 1 - 1 = 4/7 — RECOMMANDE**

---

## Principe recommandé

Traiter chaque appel outil d'un agent comme un point de défaillance potentiellement silencieux : les modes les plus fréquents (Disobey Task Specification 15.7%, Reasoning-Action Mismatch 13.2%, Step Repetition 13.2%, Incomplete Verification 9.1%) produisent des sorties syntaxiquement valides mais sémantiquement incorrectes que ni le pipeline ni l'humain ne détectent sans assertions explicites. Dans un système multi-agents, l'attribution causale de l'agent défaillant est non-résolue (53.5% meilleure méthode — Who&When ICML 2025) : concevoir les pipelines pour que chaque agent loggue son état de confiance et ses hypothèses, non seulement ses outputs.

## Robustesse

**PARTIELLE**

- Forte convergence sur existence/taxonomie des modes (NeurIPS 2025 + ICML 2025 Spotlight = tier-1)
- S3 (MSR 2026, N=33K) valide en conditions réelles production
- Fragile : MAST dérivé de 7 frameworks 2024-2025 (évolution rapide) ; S4 preprint auteur unique ; aucun RCT possible ; pas d'étude longitudinale

## Divergences A vs B

| Divergence | Résolution |
|-----------|------------|
| A = taxonomies MAS génériques, B = coding agents production | Complémentaires — les deux angles retenus |
| κ=0.88 seul vs κ=0.79 validation | Agent C : les deux valeurs reportées |
| B trouve Zhu et al. (998 bugs) | Exclu — chevauchement fort avec Bugs in Frameworks |

## Analyse de sensibilité {#analyse-de-sensibilite}

Sans MAST (source principale taxonomie) : GRADE recule à 3/7 — les autres sources (Who&When, Ehsani, Rabanser) confirment l'existence des défaillances mais sans taxonomie structurée. La recommandation de monitoring des assertions reste valide mais moins précise sur les catégories à surveiller.
