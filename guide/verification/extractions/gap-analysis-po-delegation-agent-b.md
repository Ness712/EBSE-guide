# Extraction EBSE — Agent B
## Gap analysis : Délégation PO non-technique → agent IA autonome

**Date** : 2026-04-16
**Mots-clés** : "SWE-agent autonomous software engineering evaluation", "AI agent governance human control", "multi-agent system human oversight framework", "LLM agent reliability failure modes", "AI agent task delegation trust", "autonomous agent monitoring observability", "agentic workflow best practices enterprise", "AI coding agent non-developer user"

---

## I. SOURCES RETENUES

### SOURCE 1 — SWE-bench (ICLR 2024 oral)
**Référence** : Jimenez et al. (2024). *SWE-bench: Can Language Models Resolve Real-World GitHub Issues?* ICLR 2024. arXiv:2310.06770
**Niveau pyramide** : 3
**Dimensions couvertes** : D1 (calibration performance réelle), D2 (sélection tâches)
**Citation verbatim** : "Given a codebase along with a description of an issue to be resolved, a language model is tasked with editing the codebase to address the issue"
**Statut** : INCLURE

### SOURCE 2 — SWE-agent (NeurIPS 2024)
**Référence** : Yang et al. (2024). *SWE-agent: Agent-Computer Interfaces Enable Automated Software Engineering*. NeurIPS 2024. arXiv:2405.15793
**Niveau pyramide** : 3
**Dimensions couvertes** : D2 (environment/scaffolding comme levier de performance)
**Citation verbatim** : "SWE-agent's custom agent-computer interface (ACI) significantly enhances an agent's ability to create and edit code files, navigate entire repositories, and execute tests and other programs."
**Statut** : INCLURE

### SOURCE 3 — SWE-Bench Pro
**Référence** : Scale AI / Drozdov et al. (2025). *SWE-Bench Pro*. arXiv:2509.16941
**Niveau pyramide** : 3
**Dimensions couvertes** : D1 (calibration performance réelle — 23% SOTA sur tâches complexes enterprise)
**Citation verbatim** : "The benchmark features long-horizon tasks that may require hours to days for a professional software engineer to complete, often involving patches across multiple files and substantial code modifications."
**Statut** : INCLURE

### SOURCE 4 — OpenAI Practices for Governing Agentic AI Systems
**Référence** : Shavit et al. (OpenAI). (2023). *Practices for Governing Agentic AI Systems*. OpenAI Technical Report.
**Niveau pyramide** : 5
**Dimensions couvertes** : D4 (niveaux d'autonomie), D5 (accountability), D6 (legibility/registre), D7 (interruptibilité), D8 (scope/permissions), D13 (déploiement progressif)
**Citation verbatim** : "At least one human entity should be accountable for every uncompensated direct harm caused by an agentic AI system, creating incentives to reduce harm."
**Statut** : INCLURE

### SOURCE 5 — MAST : Why Do Multi-Agent LLM Systems Fail? (ICLR 2025)
**Référence** : Cemri et al. (2025). *Why Do Multi-Agent LLM Systems Fail?* ICLR 2025 Workshop. arXiv:2503.13657
**Niveau pyramide** : 3 (kappa=0.88, 1600+ traces annotées)
**Dimensions couvertes** : D11 (taxonomie modes de défaillance : 14 modes en 3 catégories)
**Citation verbatim** : "Despite enthusiasm for Multi-Agent LLM Systems (MAS), their performance gains on popular benchmarks are often minimal, highlighting a critical need for a principled understanding of why MAS fail."
**Statut** : INCLURE

### SOURCE 6 — Bug Triggers in Agentic Frameworks
**Référence** : Zhang et al. (Concordia). (2026). *Dissecting Bug Triggers and Failure Modes in Modern Agentic Frameworks*. arXiv:2604.08906
**Niveau pyramide** : 3 (409 bugs sur 5 frameworks)
**Dimensions couvertes** : D11, D3 (erreurs de configuration utilisateur = catégorie significative)
**Citation verbatim** : "The study uncovers specialized symptoms, such as unexpected execution sequences and user configurations ignored, which are unique to autonomous orchestration."
**Statut** : INCLURE

### SOURCE 7 — Failed Agentic PRs on GitHub
**Référence** : Ehsani et al. (2025). *Where Do AI Coding Agents Fail?* arXiv:2601.15195 (33 000 PRs)
**Niveau pyramide** : 3
**Dimensions couvertes** : D9 (boucle review humaine), D16 (facteurs sociotechniques)
**Citation verbatim** : "The study reveals that agentic PR failures are often rooted in socio-technical and human-AI collaboration challenges, moving beyond just technical metrics."
**Statut** : INCLURE

### SOURCE 8 — ReliabilityBench
**Référence** : Anonymes (2026). *ReliabilityBench*. arXiv:2601.06112 (1280 épisodes)
**Niveau pyramide** : 3
**Dimensions couvertes** : D1 (performance réelle vs benchmark), D10 (observabilité production)
**Citation verbatim** : "pass@1 metrics on clean data provide dangerously optimistic estimates. Systematic fault injection reveals true production reliability."
**Statut** : INCLURE

### SOURCE 9 — Task Delegation from AI to Humans : Principal-Agent Perspective (ICIS 2023)
**Référence** : Guggenberger et al. (Fraunhofer FIT). (2023). ICIS 2023. https://aisel.aisnet.org/icis2023/hti/hti/13/
**Niveau pyramide** : 3
**Dimensions couvertes** : D16 (sociotechnique), fondement théorique Principal-Agent Theory
**Citation verbatim** : "The article identifies new causes of tensions that arise specifically in AI-to-human delegation and calls for special mechanisms beyond the classical solutions of PAT."
**Statut** : INCLURE

### SOURCE 10 — AI Knowledge: Improving AI Delegation (CHI 2023)
**Référence** : Pinski et al. (2023). CHI 2023. DOI:10.1145/3544548.3580794 (n=111)
**Niveau pyramide** : 3
**Dimensions couvertes** : D12 (littératie PO), formation du principal
**Citation verbatim** : "AI knowledge-enabled humans align their delegation decisions more closely with their assessment of how suitable a task is for humans or AI."
**Statut** : INCLURE

### SOURCE 11 — WEF AI Agents in Action (2025)
**Référence** : WEF / Capgemini. (2025). *AI Agents in Action: Foundations for Evaluation and Governance*.
**Niveau pyramide** : 5
**Dimensions couvertes** : D4, D10, D13, gouvernance progressive
**Citation verbatim** : "With 82% of executives planning to adopt agents within the next one to three years, the gap between accelerating experimentation and mature oversight is widening."
**Statut** : INCLURE

### SOURCE 12 — IMDA Singapore Model AI Governance Framework for Agentic AI (2026)
**Référence** : IMDA. (2026). *Model AI Governance Framework for Agentic AI*. Janvier 2026.
**Niveau pyramide** : 5
**Dimensions couvertes** : D4, D5, D7, D8, D12, D13 — framework gouvernemental opérationnel
**Citation verbatim** : "The framework provides guidance to organisations on how to deploy agents responsibly, recommending technical and non-technical measures to mitigate risks, while emphasising that humans are ultimately accountable."
**Statut** : INCLURE

### SOURCE 13 — Authenticated Delegation and Authorized AI Agents
**Référence** : South et al. (2025). arXiv:2501.09674
**Niveau pyramide** : 4
**Dimensions couvertes** : D8 (scope, access control, blast radius), D5 (accountability chain cryptographique)
**Citation verbatim** : "Users issue delegation credentials that include the AI system's unique identity and properties, delegated permissions with contextual scope restrictions, user metadata, and cryptographic signatures for verifiability."
**Statut** : INCLURE (avec réserve : preprint)

### SOURCE 14 — OrchVis : Hierarchical Multi-Agent Orchestration
**Référence** : Zhou et al. (2025). arXiv:2510.24937
**Niveau pyramide** : 4
**Dimensions couvertes** : D14 (supervision sans micro-management)
**Citation verbatim** : "OrchVis enables humans to supervise complex multi-agent workflows without micromanaging each step through hierarchical goal alignment, task assignment, and conflict resolution."
**Statut** : INCLURE

### SOURCE 15 — Anthropic : Measuring AI Agent Autonomy in Practice (2026)
**Référence** : McCain et al. (Anthropic). (2026). Research Report. https://www.anthropic.com/research/measuring-agent-autonomy
**Niveau pyramide** : 5
**Dimensions couvertes** : D2, D4, D10, D11 — données empiriques millions d'interactions
**Citation verbatim** : "Effective oversight of agents will require new forms of post-deployment monitoring infrastructure and new human-AI interaction paradigms that help both the human and the AI manage autonomy and risk together."
**Statut** : INCLURE

### SOURCE 16 — McKinsey QuantumBlack : Agentic Workflows for Software Development (2026)
**Référence** : QuantumBlack (McKinsey). (2026). Medium publication.
**Niveau pyramide** : 5
**Dimensions couvertes** : D3 (Spec-Driven Development), D15 (convention-over-configuration)
**Citation verbatim** : "The value comes when agents operate inside conventions, structured specifications, and deterministic processes"
**Statut** : INCLURE

### SOURCE 17 — Deloitte : The Agentic Reality Check (Tech Trends 2026)
**Référence** : Deloitte Insights. (2026). Tech Trends 2026.
**Niveau pyramide** : 5
**Dimensions couvertes** : D15 (redesign processus), D1 (40%+ projets échoueront si mauvaise gouvernance)
**Citation verbatim** : "Many early agentic AI initiatives have not delivered transformative results because they automated old processes instead of redesigning them."
**Statut** : INCLURE

---

## II. TABLE DES DIMENSIONS ÉMERGENTES

| Dimension | Description | Sources |
|-----------|-------------|---------|
| D1 — Calibrage attentes performance | Taux réels 12-23% tâches complexes vs 70%+ benchmarks ; benchmarks ≠ production | SRC 1,2,3,8 |
| D2 — Sélection et découpage tâches | Types déléguables vs non-déléguables ; décomposer en sous-tâches bornées | SRC 3,7,16,17 |
| D3 — Spécification de tâche (input quality) | Specs structurées > prompts ad hoc ; ambiguïté → clarification demandée | SRC 6,9,10,16 |
| D4 — Niveaux d'autonomie et checkpoints | Classification L1-L5 ; décision de design délibérée | SRC 4,11,12,15 |
| D5 — Accountability et imputabilité | Au moins 1 humain responsable par action agentique | SRC 4,12,13 |
| D6 — Registre actions et lisibilité | Log auditable de toutes les actions ; PO doit pouvoir reconstruire | SRC 4,11,14 |
| D7 — Interruptibilité et kill switch | Mécanisme d'arrêt fiable obligatoire | SRC 4,12 |
| D8 — Scope et contrôle d'accès | Permissions minimales ; éviter blast radius | SRC 4,12,13 |
| D9 — Boucle review humaine | Structurer feedback humain sur outputs ; abandon reviewer = cause n°1 non-merge | SRC 7,15 |
| D10 — Observabilité production et monitoring | Traces, métriques, détection dérive ; benchmarks ne prédisent pas fiabilité prod | SRC 8,11,15 |
| D11 — Modes de défaillance connus | Taxonomie MAST (14 modes) ; user configurations ignored | SRC 5,6 |
| D12 — Formation du principal (PO literacy) | Former PO sur capacités/limites réelles → meilleure délégation ; sans formation = sur/sous-délégation | SRC 10 |
| D13 — Déploiement progressif | Commencer faible risque, monitorer, élargir | SRC 4,11,12,17 |
| D14 — Supervision sans micro-management | Architecture hiérarchique : PO fixe objectifs HN, orchestrateur gère détail | SRC 14,15 |
| D15 — Redesign des processus | Délégation requiert repenser le processus, pas automatiser l'existant | SRC 17 |
| D16 — Interactions sociotechniques | Échecs souvent sociotechniques (humain-IA-organisation) | SRC 7,9 |

---

## III. GAPS APPARENTS (ce que la littérature ne couvre pas)

| ID | Gap | Confirmation |
|----|-----|-------------|
| G1 | Perspective PO non-technique comme unité d'analyse centrale | Aucune source — perspective générique "operator/user" |
| G2 | Protocoles de spécification tâche pour non-développeurs | Prescriptif uniquement, 0 étude empirique |
| G3 | Métriques de succès lisibles par non-technique | Benchmarks techniques uniquement |
| G4 | Gestion coût économique long-terme | Coût par tâche couvert, ROI longitudinal absent |
| G5 | Validation conformité fonctionnelle par non-développeur | Assumée technique dans toute la littérature |
| G6 | Évolution long-terme de la confiance | Anthropic montre tendance, pas modèle formel |
| G7 | Vue multi-agents pour principal unique non-technique | Coordination inter-agents couverte, pas interface PO |
| G8 | Délégation en contextes réglementés | IMDA général, secteurs spécifiques absents |
