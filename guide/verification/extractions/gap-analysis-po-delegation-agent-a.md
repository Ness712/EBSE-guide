# Extraction EBSE — Agent A
## Gap analysis : Délégation PO non-technique → agent IA autonome

**Date** : 2026-04-16
**Mots-clés** : "autonomous software agent delegation framework", "principal agent AI systems software development", "human AI teaming autonomous agent", "LLM agent design patterns orchestration", "autonomous coding agent evaluation benchmark", "AI agent autonomy levels human oversight", "agentic AI deployment practices", "non-technical manager AI agent delegation"

---

## I. SOURCES RETENUES

### SOURCE 1 — Lilian Weng "LLM Powered Autonomous Agents" (2023)
**Référence** : Weng, L. "LLM Powered Autonomous Agents." Lil'Log, 23 juin 2023. https://lilianweng.github.io/posts/2023-06-23-agent/
**Niveau pyramide** : 4 (expert reconnu, Head of Safety OpenAI, post fondateur massivement cité)
**Dimensions couvertes** : D3 (task decomposition), D14 (self-reflection/error handling), D15 (memory systems), architecture fondatrice Planning/Memory/Tool Use
**Citation verbatim** : "The agent breaks down large tasks into smaller, manageable subgoals, enabling efficient handling of complex tasks." / "Self-reflection is a vital aspect that allows autonomous agents to improve iteratively by refining past action decisions."
**Statut** : INCLURE (classique fondateur 2023)

### SOURCE 2 — HULA : Human-In-the-Loop Software Development Agents (ICSE SEIP 2025)
**Référence** : Takerngsaksiri et al. arXiv:2411.12924. ICSE SEIP 2025. Déployé Atlassian JIRA.
**Niveau pyramide** : 2 (venue top-tier SE)
**Dimensions couvertes** : D5 (HITL points d'intervention), D1 (spécification tâche), D7 (quality oversight), D13 (délégation graduelle)
**Citation verbatim** : "allows software engineers to refine and guide LLMs when generating coding plans and source code"
**Statut** : INCLURE

### SOURCE 3 — Anthropic : Measuring AI Agent Autonomy in Practice (2026)
**Référence** : McCain et al. (Anthropic). (2026). https://www.anthropic.com/research/measuring-agent-autonomy
**Niveau pyramide** : 3 (millions d'interactions réelles)
**Dimensions couvertes** : D2 (autonomy levels empiriques), D5 (oversight patterns), D11 (monitoring), D12 (calibration : médiane 45s, p99.9 >45min)
**Citation verbatim** : "autonomy is not a fixed property of a model or system but an emergent characteristic of a deployment" / "effective oversight doesn't require approving every action but being in a position to intervene when it matters"
**Statut** : INCLURE

### SOURCE 4 — SE 3.0 : Rise of AI Teammates (456 535 PRs GitHub)
**Référence** : Li, Zhang, Hassan (Queen's University). arXiv:2507.15003, 2025.
**Niveau pyramide** : 3 (456 535 PRs GitHub)
**Dimensions couvertes** : D2 (autonomy levels taxonomie SE 1.0→3.0), D4 (human role shift → orchestrateur), D6 (trust gap), D9 (governance), D10 (accountability, traceability)
**Citation verbatim** : "The developer's role shifts to orchestration: setting goals, permissions, and reviewing final changes." / "Although agents frequently outperform humans in speed, our analysis shows their pull requests are accepted less frequently, revealing a stark gap between benchmark performance and real-world trust and utility."
**Statut** : INCLURE

### SOURCE 5 — Levels of Autonomy for AI Agents (UW / Columbia 2025)
**Référence** : Feng, McDonald, Zhang (UW). arXiv:2506.12469, juin 2025. Knight First Amendment Institute.
**Niveau pyramide** : 3
**Dimensions couvertes** : D2 (cadre 5 niveaux : Operator/Collaborator/Consultant/Approver/Observer), D6 (accountability décroît avec autonomie), D7 (reversibility)
**Citation verbatim** : "Autonomy can instead be a deliberate design decision made by agent developers." / "Autonomy is a double-edged sword...simultaneously unlocking transformative possibilities and serious risks."
**Statut** : INCLURE

### SOURCE 6 — ALMAS : Autonomous LLM-based Multi-Agent Software Engineering (JPMorgan Chase AI Research)
**Référence** : Tawosi et al. (JPMorgan Chase AI Research). arXiv:2510.03463, 2025.
**Niveau pyramide** : 3
**Dimensions couvertes** : D4 (role mapping agile → agents), D1 (task specification : clarity/completeness évalués), D5 (handover humain quand issues persistent), dual modes autonomous/interactive
**Citation verbatim** : "orchestrates coding agents aligned with the diverse roles found in agile...from product managers and sprint planners to developers, testers, and peer reviewers"
**Statut** : INCLURE

### SOURCE 7 — Agyn : Multi-Agent System for Team-Based Autonomous SE (Mila 2026)
**Référence** : Benkovich, Valkov (Mila). arXiv:2602.01465, 2026. 72.2% SWE-bench 500.
**Niveau pyramide** : 3
**Dimensions couvertes** : D4 (team structure : manager/researcher/engineer/reviewer), D3 (delegation totale zéro intervention), D1 (task spec → implementation → review itératif)
**Citation verbatim** : "Real-world software development is organized as a collaborative activity carried out by teams following shared methodologies, with clear role separation." / "Progress in agent infrastructure and organizational design may play a role as important as improvements in underlying models."
**Statut** : INCLURE

### SOURCE 8 — ChatCollab : Collaboration Between Humans and AI Agents (Stanford 2024)
**Référence** : Klieger et al. (Stanford). arXiv:2412.01992, 2024.
**Niveau pyramide** : 3
**Dimensions couvertes** : D5 (human oversight : dashboard admin), D4 (team composition configurable), D14 (supervision sans micro-management)
**Citation verbatim** : "agents can be taught or give feedback by the human participants through direct, iterative interactions" / "swapping an AI agent with a human is as simple as having the human join the channel"
**Statut** : INCLURE

### SOURCE 9 — Human-AI Teaming Scoping Review (Frontiers in AI 2023)
**Référence** : Berretta et al. (2023). *Defining human-AI teaming the human-centered way*. Frontiers in AI. PMC10570436.
**Niveau pyramide** : 2 (scoping review peer-reviewed, indexé PubMed)
**Dimensions couvertes** : D5 (Human-AI teaming : définition rigoureuse), D6 (trust comme dimension la plus étudiée), D2 (autonomie haute agency requise)
**Citation verbatim** : "Interdependence in activity and outcomes involving one or more humans and one or more autonomous agents, wherein each human and autonomous agent is recognized as a unique team member occupying a distinct role on the team."
**Statut** : INCLURE

### SOURCE 10 — Fundamentals of Building Autonomous LLM Agents (TUM 2025)
**Référence** : de Lamo et al. (TUM/UPC). arXiv:2510.09244, 2025.
**Niveau pyramide** : 4
**Dimensions couvertes** : D3 (architecture complète Perception/Reasoning/Memory/Execution), D14 (error propagation en multi-step), D15 (memory systems)
**Citation verbatim** : "Error propagation becomes more complex when failures can occur at multiple levels (perception, planning, execution)."
**Statut** : INCLURE

### SOURCE 11 — Evaluation and Benchmarking of LLM Agents : Survey (KDD 2025, SAP Labs)
**Référence** : Mohammadi et al. (SAP Labs). KDD 2025. arXiv:2507.21504.
**Niveau pyramide** : 2 (venue top-tier)
**Dimensions couvertes** : D7 (taxonomie évaluation : Task Completion / Output Quality / Latency & Cost / Tool Use / Planning & Reasoning / Memory / Multi-Agent / Consistency / Robustness / Safety / Compliance), enterprise (RBAC, compliance GDPR/HIPAA)
**Citation verbatim** : "Unlike LLMs, which are primarily assessed for text generation or question answering, LLM agents operate in dynamic, interactive environments."
**Statut** : INCLURE

### SOURCE 12 — CLEAR : Multi-Dimensional Framework for Evaluating Enterprise Agentic AI
**Référence** : Mehta (2025). arXiv:2511.14136.
**Niveau pyramide** : 3 (framework empiriquement validé, ρ=0.83 correlation production)
**Dimensions couvertes** : D8 (coût : 50x variations $0.10→$5.00), D7 (reliability : 60%→25% en 8 runs), D7 (CLEAR corrèle mieux production : ρ=0.83 vs ρ=0.41)
**Citation verbatim** : "agents exhibit 50x cost variations (from $0.10 to $5.00 per task) for similar accuracy levels" / "CLEAR better predicts production success (correlation ρ=0.83) compared to accuracy-only evaluation (ρ=0.41)"
**Statut** : INCLURE

### SOURCE 13 — 2025 AI Agent Index (Cambridge/Washington/Harvard/Stanford/MIT)
**Référence** : Staufer et al. arXiv:2602.17753, 2026. (30 systèmes réels, 45 champs, 4 semaines review)
**Niveau pyramide** : 2
**Dimensions couvertes** : D11 (safety gaps : 25/30 sans résultats safety publiés), D10 (transparency : 21/30 sans disclosure), D2 (autonomy : browser agents L4-L5)
**Citation verbatim** : "25/30 agents disclose no internal safety results, and 23/30 agents have no third-party testing." / "21/30 agents have no documented default disclosure behavior."
**Statut** : INCLURE

### SOURCE 14 — Agentic AI : Architectures, Taxonomies, Evaluation (survey 2026)
**Référence** : Arunkumar et al. arXiv:2601.12560, 2026.
**Niveau pyramide** : 3
**Dimensions couvertes** : D9 (orchestration contrôlable : state machines, guard nodes), D13 (protocoles MCP/Computer Use), D14 (risques : hallucination → actions irréversibles, infinite loops, prompt injection)
**Citation verbatim** : "A major practical shift is toward controllable orchestration, where developers specify explicit state transitions and guardrails" / "Once a model can execute actions such as modifying files, running code, or operating a desktop interface, hallucinations can become concrete failures"
**Statut** : INCLURE

### SOURCE 15 — Orchestration of Multi-Agent Systems (2025, données enterprise)
**Référence** : Adimulam et al. arXiv:2601.13671, 2025.
**Niveau pyramide** : 3 (données enterprise réelles)
**Dimensions couvertes** : D13 (protocoles MCP + A2A), D4 (architecture layers), D7 (quality assurance, monitoring), D9 (governance enterprise)
**Citation verbatim** : "MCP and A2A form the dual foundation of agent communication—MCP for tool access and A2A for peer collaboration"
**Statut** : INCLURE

### SOURCE 16 — Agentic AI Security (survey sécurité 2025)
**Référence** : Datta et al. arXiv:2510.23883, 2025.
**Niveau pyramide** : 3
**Dimensions couvertes** : D10 (sécurité : prompt injection, tool misuse 87%, MCP/A2A vulnérabilités, memory poisoning), D8 (IAM, access control)
**Citation verbatim** : "Prompt injection attacks occur when malicious data, embedded within content processed by the LLM, manipulates the model's behavior to perform unauthorized or unintended actions"
**Statut** : INCLURE

### SOURCE 17 — Survey Benchmarks LLM-Empowered Agentic System (50+ benchmarks)
**Référence** : Guo et al. arXiv:2510.09721, 2025.
**Niveau pyramide** : 3
**Dimensions couvertes** : D12 (calibration capacité réelle : function-level → repository-level), D5 (autonomy spectrum : prompt → fine-tuning → agent-based)
**Citation verbatim** : "An 'agent' is a system that can perceive its environment, create and decompose plans, utilize external tools, and learn from feedback to achieve a high-level goal."
**Statut** : INCLURE

### SOURCE 18 — Beyond Task Completion : Assessment Framework (IIIT-Hyderabad 2025)
**Référence** : Akshathala et al. (IIIT-Hyderabad/MontyCloud). arXiv:2512.12791, 2025.
**Niveau pyramide** : 3
**Dimensions couvertes** : D7 (évaluation 4 piliers : LLM/Memory/Tools/Environment), D5 (policy adherence), D11 (behavioral uncertainty)
**Citation verbatim** : "existing evaluations rely on binary task-completion metrics that fail to capture behavioral uncertainty"
**Statut** : INCLURE

### SOURCE 19 — ISACA : Best Practices for Agentic AI Workflows (2025)
**Référence** : Murali (ISACA). 1 juillet 2025. https://www.isaca.org/resources/news-and-trends/industry-news/2025/safeguarding-the-enterprise-ai-evolution-best-practices-for-agentic-ai-workflows
**Niveau pyramide** : 4
**Dimensions couvertes** : D10 (IAM agents : identités distinctes, least-privilege), D8 (zero trust), D11 (audit logging), D5 (human oversight mécanismes)
**Citation verbatim** : "An AI agent's role should be limited to its assigned tasks." / "Zero trust is often distilled into 'never trust, always verify.'"
**Statut** : INCLURE

---

## II. TABLE DES DIMENSIONS ÉMERGENTES

| # | Dimension | Sources |
|---|-----------|---------|
| D1 | Spécification de tâche (Goal/Task Input) | Weng, HULA, ALMAS, Feng |
| D2 | Niveaux d'autonomie et positionnement | Feng, Anthropic, Li/SE3.0 |
| D3 | Décomposition de tâches (Task Planning) | Weng, TUM, Arunkumar, Agyn |
| D4 | Structure organisationnelle et rôles | ALMAS, Agyn, ChatCollab, Li/SE3.0 |
| D5 | Human-in/on/out-of-the-loop | Berretta, HULA, ChatCollab, Feng, Anthropic |
| D6 | Trust et accountability | Li/SE3.0, Feng, Agyn, Berretta, Index 2026 |
| D7 | Évaluation qualité livrables (CLEAR) | SAP KDD, Mehta, IIIT-Hyderabad, Guo |
| D8 | Coût et efficacité économique | Mehta, SAP KDD, Arunkumar |
| D9 | Sécurité et risques techniques | Datta, ISACA, Arunkumar, Adimulam |
| D10 | IAM agents | ISACA, Datta, Adimulam, Index 2026 |
| D11 | Monitoring, observabilité, audit | Anthropic, ISACA, Adimulam, Index 2026 |
| D12 | Calibration capacité réelle | SWE-bench Pro, Li/SE3.0, TUM |
| D13 | Protocoles inter-agents (MCP/A2A) | Adimulam, Arunkumar, Datta |
| D14 | Gestion erreurs et récupération | Weng, TUM, Arunkumar, HULA |
| D15 | Mémoire et contexte | Weng, TUM, SAP KDD, Arunkumar |

---

## III. GAPS APPARENTS (ce que la littérature ne couvre pas)

| ID | Gap | Confirmation |
|----|-----|-------------|
| GAP 1 | Frameworks de délégation spécifiques aux PO non-techniques | Absent — littérature générique "operator/developer" |
| GAP 2 | Spécification du niveau de détail requis dans les inputs (non-technique) | Critique connu (ALMAS, HULA) mais pas de guidance non-technique empirique |
| GAP 3 | Mécanismes de vérification accessibles au non-technique | Frameworks d'évaluation assument évaluateurs techniques |
| GAP 4 | Économie de la délégation long-terme (ROI, dette technique agents) | Études coût transactionnelles, pas longitudinales |
| GAP 5 | Dégradation qualité dans le temps (architectural drift) | Aucune données longitudinales sur qualité codebases agents |
| GAP 6 | Gouvernance des conflits inter-agents (vue PO) | MCP/A2A technique couvert, gouvernance PO absent |
| GAP 7 | Onboarding et formation du PO à l'orchestration | Littérature assume profil technique ou délégation totale |
| GAP 8 | Impact sur culture produit et processus agiles | ChatCollab seul à aborder équipes mixtes, sans données agile |
