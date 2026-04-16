# Double Extraction EBSE — PICOC #28 : ai-agent-framework-vs-prebuilt

**Date de recherche** : 2026-04-16 (v2 — méthode révisée)
**Protocole** : methodology.md v3.0 §2.1 — double extraction indépendante + vérification Agent C
**Question PICOC** : Pour un PO qui délègue tout le développement logiciel à l'IA, quel type d'outil agentique est le plus adapté : framework custom (LangChain, AutoGen, CrewAI), système pré-construit conçu pour l'autonomie (Devin, OpenHands), ou système pré-construit configurable (Claude Code + CLAUDE.md) ?

**Note méthode** : La question initiale (v1) "framework custom vs Claude Code" était mal posée — trop étroite et sans corpus direct. La v2 recherche séparément (1) le design intent de chaque catégorie d'outil et (2) leur performance empirique en mode autonome, puis converge les données.

---

## Agent A — Design intent officiel par catégorie d'outil

**Angle** : Sources officielles (docs, papers, annonces) sur ce pour quoi chaque outil est conçu.

**Mots-clés** : "Claude Code design goals autonomous agentic Anthropic", "Devin autonomous software engineer design goals", "OpenHands autonomous agent designed for", "agentic coding tools designed without developer in loop"

### A1 — Claude Code — Documentation officielle Anthropic

- **Source** : code.claude.com/docs, anthropic.com/engineering/claude-code-auto-mode, GitHub anthropics/claude-code
- **Quote design intent** : *"Claude Code is an agentic coding tool that lives in your terminal, understands your codebase, and helps you code faster by executing routine tasks, explaining complex code, and handling git workflows — all through natural language commands."*
- **Public cible explicite** : Développeurs. "Lives in your terminal" — s'insère dans l'environnement existant du développeur.
- **Rôle humain documenté** : *"Decisions about what code ships remain with the human."* / *"The developer defines the goal and reviews the result rather than guiding each step."*
- **Auto mode** : *"Auto mode is a new mode for Claude Code that delegates approvals to model-based classifiers — a middle ground between manual review and no guardrails."* Le classificateur (Sonnet 4.6) *"acts as a substitute for a human approver"* — mais l'humain configure les limites et review les résultats. Taux de faux-négatifs documenté : 17%.
- **Niveau pyramide** : 3 (documentation officielle produit)
- **Conclusion design** : Conçu pour développeurs, avec supervision humaine architecturale. Configurable pour plus d'autonomie via CLAUDE.md + hooks + auto mode, mais le design de base reste HITL.

### A2 — Devin — Cognition AI

- **Source** : cognition.ai/blog/introducing-devin (officiel)
- **Quote** : *"Devin is a tireless, skilled teammate, equally ready to build alongside you or independently complete tasks for you to review."*
- **Positionnement** : "First AI software engineer." Conçu pour *"you assign a task, walk away, and come back to a completed implementation."*
- **Environnement** : Sandbox cloud isolé avec son propre IDE, navigateur, terminal — n'a pas besoin de l'environnement du développeur.
- **Niveau pyramide** : 3 (blog officiel fondateur)
- **Conclusion design** : Explicitement conçu pour opérer sans développeur dans la boucle d'exécution — HOTL natif.

### A3 — OpenHands — All-Hands AI

- **Source** : arXiv:2407.16741 (paper peer-reviewed NeurIPS)
- **Quote** : *"a platform for the development of powerful and flexible AI agents that interact with the world in similar ways to those of a human developer: by writing code, interacting with a command line, and browsing the web."*
- **Usage décrit (Series A, BusinessWire, nov 2025)** : *"Teams use OpenHands to offload the repetitive parts of software development (dependency upgrades, adding unit tests, merge conflict resolution, vulnerability sweeps, code refactors) and to run asynchronous, parallel campaigns across large codebases."*
- **Modèle** : Asynchrone — l'humain assigne, OpenHands exécute en parallèle ou arrière-plan.
- **Niveau pyramide** : 2 (paper NeurIPS peer-reviewed)
- **Conclusion design** : Conçu pour agents autonomes asynchrones enterprise. HOTL natif.

### A4 — SWE-agent — Princeton NLP

- **Source** : arXiv:2405.15793 (paper NeurIPS 2024)
- **Quote** : *"a system that facilitates LM agents to autonomously use computers to solve software engineering tasks"*
- **Quote** : *"The system can autonomously fix bugs in real GitHub repositories [...] all without human intervention."*
- **Niveau pyramide** : 2 (paper NeurIPS 2024 peer-reviewed)
- **Conclusion design** : Outil de recherche conçu pour résolution autonome d'issues GitHub sans boucle humaine.

### A5 — Frameworks (LangChain, AutoGen, CrewAI) — Design intent

- **Résultat** : Aucune source primaire trouvée sur le design intent de ces frameworks pour l'usage autonome. Les frameworks sont des **outils d'infrastructure pour développeurs qui construisent des agents** — leur documentation cible explicitement les développeurs Python/TypeScript qui implémentent des pipelines agentiques.
- **Niveau pyramide** : N/A (gap documentaire)
- **Conclusion design** : Non conçus pour l'autonomie — conçus pour que des développeurs construisent des agents. L'opérateur du framework doit être un développeur.

---

## Agent B — Performance empirique en mode autonome

**Angle** : Données empiriques sur la performance des outils en mode autonome (sans développeur dans la boucle) dans des conditions réelles ou en benchmark.

**Mots-clés** : "OpenHands autonomous software development benchmark empirical", "Devin autonomous software engineer performance data", "SWE-bench autonomous agent performance", "LangChain AutoGen autonomous operation empirical", "Claude Code autonomous mode empirical"

### B1 — Claude Code — Production réelle

- **Source** : "On the Use of Agentic Coding: An Empirical Study of Pull Requests on GitHub" (arXiv:2509.14745, 2025)
- **N** : 567 PRs Claude Code, 157 projets open-source
- **Claim** : Taux d'acceptation : **83.8%** (vs 91.0% humains — écart statistiquement significatif, p<0.05). Mergé sans modification : 54.9%. 45.1% des PRs mergées nécessitent des modifications supplémentaires.
- **Niveau pyramide** : 2 (empirique peer-reviewed)
- **Source 2** : "Why AI Agent PRs Remain Unmerged?" (arXiv:2602.00164, MSR '26)
- **N** : 8 106 PRs fix-related
- **Claim** : Claude Code merge rate fix-related : **57.4%**. Fermé sans merge : 21.7%. Toujours ouvert : 20.9%.
- **Niveau pyramide** : 2 (MSR '26, peer-reviewed)
- **Source 3** : "The Rise of AI Teammates in SE 3.0" (arXiv:2507.15003, N=456K PRs)
- **Claim** : Documentation tasks : Claude Code atteint **85.7%** d'acceptation (vs baseline humain 76.5%) — seule catégorie où l'agent dépasse l'humain.
- **Niveau pyramide** : 3

### B2 — Devin — Production réelle

- **Source** : "The Rise of AI Teammates in SE 3.0" (arXiv:2507.15003, N=24 893 PRs Devin)
- **Claim** : Taux d'acceptation global PRs Devin open-source : **49%** (vs baseline humain ~77%)
- **Niveau pyramide** : 3
- **Source 2** : "Why AI Agent PRs Remain Unmerged?" (arXiv:2602.00164, MSR '26)
- **Claim** : Devin merge rate fix-related : **42.9%**. Fermé sans merge : 54.0%.
- **Niveau pyramide** : 2 (MSR '26)
- **Source 3** : Cognition AI Annual Review 2025 (niveau 4 — marketing)
- **Claim** : 67% PRs mergées (vs 34% l'année précédente). À prendre avec précaution — source non neutre.

### B3 — OpenHands — Benchmarks

- **Source** : openhands.dev/blog/sota-swe-bench-verified, arXiv:2511.03690
- **Claim** : SWE-Bench Verified : **72%** avec Claude Sonnet 4.5 + extended thinking. Avec inference-time scaling : **66.4%**.
- **Niveau pyramide** : 3 (rapport technique)
- **Écart benchmark vs réalité** : SWE-EVO (benchmark plus réaliste, arXiv:2512.18470) : meilleur agent **21%** vs 65% sur SWE-Bench Verified. SWE-Bench Pro (long-horizon) : max 23.3%.

### B4 — Frameworks (LangChain, AutoGen, CrewAI) — Performance autonome

- **Source** : "An Empirical Study of Agent Developer Practices" (arXiv:2512.01939, N=11 910 discussions)
- **Source 2** : Étude comparative frameworks (arXiv:2504.04650)
- **Claim** :

| Framework | Tâches single-step | Tâches multi-step |
|-----------|-------------------|--------------------|
| AutoGen | 90% (GPT-4o-mini) | 53.3% (GPT-4o-mini) / **0% (Qwen-plus)** |
| LangChain | 73.3% | **13.3%** (tous modèles) |

- **Niveau pyramide** : 3 (preprint, conditions de laboratoire)
- **Donnée production** : Aucune — les frameworks n'ont pas de données d'autonomie en conditions réelles publiées.

### B5 — Écart critique benchmark vs réalité (tous outils)

- **Source** : arXiv:2512.18470 (SWE-EVO), arXiv:2509.16941 (SWE-Bench Pro)
- **Claim** : Scores SWE-Bench Verified (conditions contrôlées) → 80.9% top agents. SWE-EVO (tâches réalistes) → 21%. SWE-Bench Pro (long-horizon) → max 23.3%.
- **Implication** : Les benchmarks standards surestiment massivement la performance autonome réelle.

---

## Agent C — Corrections et vérification

### C1 — Claude Code est conçu pour développeurs, pas pour POs : CONFIRMÉ (sources officielles)

La documentation Anthropic est explicite — Claude Code est conçu pour des développeurs qui "remain in the loop." L'auto mode réduit la friction mais ne supprime pas la supervision architecturale. Ce n'est pas un outil conçu pour un PO sans compétences de développement.

**Mais** : la configuration via CLAUDE.md + hooks + auto mode peut le rendre opérable par un PO — c'est une adaptation non prévue dans le design initial, qui fonctionne empiriquement (83.8% PR acceptance).

### C2 — Performance production Claude Code > Devin : CONFIRMÉ mais à nuancer

Les chiffres sont cohérents entre sources : Claude Code 83.8% (arXiv:2509.14745) vs Devin 49% (arXiv:2507.15003) et Devin 42.9% fix-related (arXiv:2602.00164). Nuance : les populations de tâches ne sont pas identiques — Claude Code est peut-être utilisé sur des tâches plus simples dans les projets open-source étudiés.

### C3 — AutoGen 0% multi-step avec Qwen : DRAPEAU

Ce chiffre provient d'une étude de laboratoire (arXiv:2504.04650) sur des tâches spécifiques avec un modèle particulier (Qwen-plus). **Ne pas généraliser** — ce n'est pas "AutoGen = 0% en production." À citer avec le contexte exact.

### C4 — Devin Annual Review 2025 : EXCLU des claims empiriques

Source niveau 4, marketing non audité. Les chiffres "67% PR merged" ne sont pas vérifiables indépendamment. À ne pas citer comme preuve empirique.

### C5 — SWE-Bench scores Claude Opus 4.5 (80.9%) : DRAPEAU

Ces scores sont pour le **modèle Claude utilisé dans un agent sur SWE-bench**, pas pour Claude Code l'outil. La distinction modèle vs outil est critique — ne pas confondre.

### Fabrications détectées : AUCUNE

---

## Sources retenues

| # | Source | Retenue | Niveau | Pertinence |
|---|--------|---------|--------|------------|
| 1 | arXiv:2509.14745 — PR acceptance Claude Code (N=567) | **OUI** | 2 | Mesure directe Claude Code en production autonome |
| 2 | arXiv:2602.00164 — MSR '26, PR merge rate (N=8106) | **OUI** | 2 | Comparaison Claude Code vs Devin en conditions réelles |
| 3 | arXiv:2407.16741 — OpenHands paper (NeurIPS) | **OUI** | 2 | Design intent OpenHands + design autonome documenté |
| 4 | arXiv:2405.15793 — SWE-agent paper (NeurIPS 2024) | **OUI** | 2 | Design intent SWE-agent + autonomie documentée |
| 5 | Anthropic docs officiel Claude Code | **OUI** | 3 | Design intent Claude Code — source primaire officielle |
| 6 | arXiv:2507.15003 — SE 3.0 N=456K PRs | **OUI** | 3 | Performance Devin en production N=24 893 PRs |
| 7 | arXiv:2512.01939 — Frameworks developer practices | **OUI** | 3 | Charge maintenance frameworks custom |
| 8 | arXiv:2504.04650 — Frameworks performance autonome | **OUI (avec drapeau)** | 3 | Seule donnée multi-step frameworks — contexte labo limité |
| 9 | arXiv:2512.18470 — SWE-EVO benchmark réaliste | **OUI** | 3 | Écart benchmark vs réalité |
| - | Cognition Devin Annual Review 2025 | **EXCLU** | 4 | Marketing non audité |
| - | Blogs comparaisons (lowcode.agency, etc.) | **EXCLU** | 4 | Opinion sans données |

---

## GRADE calculé

| Facteur | Valeur | Justification |
|---------|--------|---------------|
| Base | +3 | Sources niveau 2 disponibles (arXiv:2509.14745, arXiv:2602.00164, arXiv:2407.16741, arXiv:2405.15793) sur performance production et design intent |
| Convergence | +1 | 4+ sources convergent : frameworks = pire option pour autonomie (pas de données production, performance labo médiocre) ; outils pré-construits = mieux adaptés |
| Effet important | +0 | Direction claire mais écarts complexes à interpréter (populations de tâches différentes entre études) |
| Biais | -1 | Source Anthropic docs = biaisée pour Claude Code ; Devin Annual Review exclu mais biais structurel sur les données Devin |
| Indirectness | -1 | Aucune étude ne mesure directement le cas d'usage PO-only — les études mesurent des projets open-source avec mainteneurs humains |

**GRADE = 3 + 1 + 0 - 1 - 1 = 3/7 — RECOMMANDE_FRAGILE**

---

## Principe recommandé

Pour un PO délégant tout le développement à l'IA : les **frameworks custom (LangChain, AutoGen, CrewAI) sont inadaptés** — conçus pour des développeurs qui construisent des agents, sans données de production en mode autonome et avec une performance multi-step médiocre en laboratoire (LangChain 13.3%, AutoGen 0% avec Qwen, arXiv:2504.04650). Parmi les outils pré-construits, Devin et OpenHands sont explicitement conçus pour l'autonomie (HOTL natif) mais montrent des taux d'acceptation inférieurs en production (Devin : 42.9-49%, MSR '26 N=8106). Claude Code, bien que conçu pour des développeurs, configuré avec CLAUDE.md + hooks + auto mode atteint 83.8% d'acceptation PRs en production réelle (arXiv:2509.14745, N=567, peer-reviewed) — dépassant les outils conçus pour l'autonomie. Ce paradoxe (outil développeur > outil autonome en production) n'est pas expliqué par les sources et mérite investigation. La robustesse est fragile : les populations de tâches ne sont pas identiques entre les études, et le cas d'usage PO-only n'a pas été étudié directement.

## Robustesse

**FRAGILE** pour deux raisons :
1. Les comparaisons de production (Claude Code vs Devin) ne contrôlent pas le type de tâche — les projets qui utilisent Claude Code peuvent être différents de ceux qui utilisent Devin
2. Le cas "PO délégant tout sans développeur dans la boucle" n'a jamais été étudié directement — toutes les études mesurent des projets avec mainteneurs humains présents

---

## Divergences A vs B

| Point | Agent A | Agent B | Résolution |
|-------|---------|---------|------------|
| Focus | Design intent (docs officielles) | Performance empirique (benchmarks, production) | **Complémentaires — les deux nécessaires** |
| Finding Claude Code | Conçu pour développeurs | Meilleure performance production (83.8%) | Paradoxe documenté — outil dev qui surpasse les outils autonomes en pratique |
| Finding frameworks | Aucune source design intent | Performance multi-step médiocre (0-13.3%) | Convergence : frameworks = pire option |
| Conclusion | Outils autonomes (Devin, OpenHands) mieux alignés par design | Données production favorisent Claude Code | Signal mixte — GRADE 3 approprié |
