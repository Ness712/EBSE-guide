# Phase 1.3 — PICOC : domaine `ai-collaboration`

**Protocole** : `methodology.md` v3.0, section 1.3 (Kitchenham & Charters 2007 §5.3, Specifying research questions)
**Date** : 2026-04-15
**Methode** : double extraction (A + B) + verification outils (Agent C) + reconciliation
**Tracability** : [`verification/extractions/phase-1-3-ai-collaboration-picoc.md`](../extractions/phase-1-3-ai-collaboration-picoc.md)

## Population P (commune a toutes les PICOCs)

Sauf precision differente, **P = "Equipe d'ingenierie logicielle, 1-10 devs, developpant une application web backend+frontend, utilisant quotidiennement un agent de codage IA (Claude Code, Cursor, Devin, Copilot, Aider, Cline, Continue, ou equivalent), dans un contexte pre-production ou production"**.

Cette population herite des hypotheses scope du guide EBSE existant (web app, equipes petites-moyennes) et ajoute la contrainte *"utilise un agent de codage IA"*.

## Liste finale — 27 PICOCs

### PICOC #1 — Autonomy granularity par action

| Element | Valeur |
|---------|--------|
| **I** | Autonomie graduee par type d'action (read-only → edit branch → commit → push → deploy), avec approbation humaine explicite entre tiers |
| **C** | (1) Full autonomous "YOLO" mode (Claude Code `--permission-mode bypassPermissions`, Cursor YOLO mode) ; (2) Suggest-only (Copilot inline completions, Cursor tab) ; (3) Binary PR gate (agent propose full diff, humain accepte/rejette) |
| **O** | Change failure rate (DORA), time to review, rework ratio, security defect introduction, developer trust |
| **Co** | Varied risk tiers (prototype, internal, production) ; commercial stack |
| **Question** | *"Pour une equipe de 1-10 devs utilisant un agent IA sur un codebase production-adjacent, l'autonomie graduee par action fournit-elle un change failure rate plus bas et une meilleure confiance developpeur que les modes fully autonomous, suggest-only, ou binary gate ?"* |
| **Anchor** | SWEBOK KA 9 (SE Management — AI-based SDLCs) ; ISO/IEC 42001:2023 §8 (operation controls) ; NIST AI RMF MANAGE-2.3 ; **Parasuraman, Sheridan & Wickens 2000** (LoA 10-level scale, IEEE TSMC Part A) |

### PICOC #2 — Task-type routing (delegation par classe de tache)

| Element | Valeur |
|---------|--------|
| **I** | Policy explicite mapping task classes → autonomy level (ex: agent seul pour test scaffolding / renames / dep bumps ; agent propose pour refactors / new endpoints ; humain-led pour architecture / security / data migrations). Inclut la distinction generative (new code) vs modification (refactor/fix) comme sous-taxonomie |
| **C** | (1) Autonomie uniforme quelle que soit la tache ; (2) Discretion dev ad hoc (pas de policy ecrite) ; (3) Routing par path/module uniquement (pas par semantic de tache) |
| **O** | Defect density par task category, review time, agent-introduced regressions, compliance audit |
| **Co** | Team avec portfolio de taches mixtes ; codebase a criticalite tieree |
| **Question** | *"Un mapping explicite task-type → autonomy level reduit-il les defects et le review burden vs routing uniforme ou ad hoc ?"* |
| **Anchor** | SWEBOK KA 4 §5.1 (AI-assisted programming) ; KA 16 §9.6 (AI for SE) ; ISO/IEC 5338:2023 (AI life cycle — task-level definition) ; Hou et al. 2024 LLM4SE SLR (donnees heterogenes sur performance par task type) |

### PICOC #3 — Human-only decision gates

| Element | Valeur |
|---------|--------|
| **I** | Policy explicite listant les decisions qui doivent **rester humaines** quelle que soit la confiance agent : schema migrations, secret rotation, prod deploys, license changes, customer-data handling, architectural boundaries, force-push main |
| **C** | (1) Pas de liste explicite — case-by-case judgement ; (2) Path-based rules uniquement (ex: `migrations/**` requires human) ; (3) Confidence-threshold (agent auto-approves when self-reported confidence > X) |
| **O** | Irreversible-incident count, policy-violation count, audit-trail completeness |
| **Co** | Domaines regles ou compliance-sensitive (health, finance, GDPR) |
| **Question** | *"Une policy explicite human-only-gates reduit-elle les irreversible incidents vs ad hoc ou confidence-based gating ?"* |
| **Anchor** | ISO/IEC 42001:2023 §8.2 (controls) + §9.2 (internal audit) ; ISO/IEC 23894:2023 (risk treatment) ; NIST AI RMF GOVERN-1.1 (policies) ; NIST AI 600-1 §2.7 Human-AI Configuration |

### PICOC #4 — Deterministic verification gates (pre-acceptance)

| Element | Valeur |
|---------|--------|
| **I** | Pipeline deterministe obligatoire avant acceptance : typecheck + lint + unit tests + build + (optional) SAST + dependency audit. Execute localement par l'agent avant presentation a l'humain |
| **C** | (1) Agent self-reports success sans executer (trust agent claim) ; (2) CI only (checks apres PR creation) ; (3) Pre-commit hooks only ; (4) No gates |
| **O** | False-accept rate, wall-clock par change, human review effort, escaped defect rate |
| **Co** | Projets avec tooling mature (TypeScript, Python typed, Rust, Go) |
| **Question** | *"Exiger que l'agent execute typecheck+test+lint+build localement avant presentation reduit-il le false-accept rate vs self-report ou CI-only ?"* |
| **Anchor** | SWEBOK KA 5 §7.1-§7.2 (testing levels & techniques) ; KA 16 §9.6 (SE for AI) ; ISO/IEC 42001:2023 §8.3 (V&V) ; NIST AI 600-1 (Confabulation risk controls) |

### PICOC #5 — Multi-agent topology (incluant writer/reviewer)

| Element | Valeur |
|---------|--------|
| **I** | Pattern writer/reviewer a 2 agents (un redige, un critique avant review humaine). Exemples : Claude Code sub-agents, Aider architect + coder modes |
| **C** | (1) Single agent avec self-reflection prompt ; (2) Orchestrator-worker N-agents (Microsoft Agent Framework, CrewAI, LangGraph supervisors) ; (3) Parallel multi-agent best-of-N ; (4) Single agent avec tool use (pas de specialisation roles) |
| **O** | Defect rate atteignant human review, token cost par accepted change, task success rate (SWE-bench Verified), cascading failure rate |
| **Co** | Taches non-triviales (> 500 LOC touched, multi-file) ; budget constraints |
| **Question** | *"Pour des taches non-triviales multi-file, le pattern writer/reviewer 2-agents reduit-il les defects atteignant l'humain vs single-agent self-reflection ou orchestrator-worker, a cout-token acceptable ?"* |
| **Anchor** | SWEBOK KA 16 §9.6 (AI for SE) ; KA 5 (testing/review as quality gate) ; ISO/IEC 5338:2023 (AI lifecycle composition) ; **He, Treude, Lo 2024/25** (LMA for SE review) |

### PICOC #6 — Escalation protocol format

| Element | Valeur |
|---------|--------|
| **I** | Schema d'escalation structure avec champs obligatoires : current state + attempted approaches + specific question + blocking decision-type + recommended option (format "I intend to..." de Marquet 2013) |
| **C** | (1) Free-text "I'm stuck" message ; (2) Hard-fail on uncertainty (agent stops avec error, pas de proposal) ; (3) No escalation — agent continues et guesses ; (4) Time/iteration cap (non-semantique) |
| **O** | Time to resolution, decision quality apres unblock, escalation false-positive/false-negative rates, human cognitive load per escalation |
| **Co** | Async teams ; agents tournant en background/CI |
| **Question** | *"Un schema d'escalation structure reduit-il le time-to-resolution et ameliore-t-il la decision quality vs freeform ou escalation absente ?"* |
| **Anchor** | SWEBOK KA 9 (SE Management) ; ISO/IEC 23894:2023 (risk communication) ; NIST AI RMF GOVERN-5 (stakeholder engagement) ; **Marquet 2013** *Turn the Ship Around!* (intent-based leadership) |

### PICOC #7 — Context compaction during long sessions

| Element | Valeur |
|---------|--------|
| **I** | Active compaction strategy (summarize-and-restart avec handoff note). Exemples : Claude Code `/compact`, summarize+reinject pattern |
| **C** | (1) Naive truncation (drop oldest) ; (2) RAG over full conversation history (documented dans Cursor) ; (3) Hard task-split (humain decoupe en < 1 window chunks) ; (4) Extended-context model sans compaction (Claude 1M, Gemini 1M) |
| **O** | Task completion rate pour long tasks, coherence drift (contradictions avec earlier decisions), token cost |
| **Co** | Refactors ou migrations complexes spanning plusieurs heures |
| **Question** | *"Pour les taches depassant 100k tokens d'interaction, la compaction active summarize-restart yields-elle un higher completion rate et lower drift vs truncation, RAG-over-history, ou extended-context continuous ?"* |
| **Anchor** | SWEBOK KA 9 (management of long-running work) ; KA 16 §9.6 |

### PICOC #8 — Project-level persistent instructions

| Element | Valeur |
|---------|--------|
| **I** | Committed project-instruction file agent-specific : **CLAUDE.md** (Anthropic), **AGENTS.md** (emerging open format stewarded par Agentic AI Foundation under Linux Foundation, adopte par OpenAI Codex, Cursor, Google Jules, Aider, Factory, 20k+ repos), `.cursorrules` / `.cursor/rules/*.mdc` (Cursor), `.clinerules/` directory (Cline), `.github/copilot-instructions.md` (GitHub Copilot) |
| **C** | (1) Pas de fichier agent-specific — rely on per-session system prompt ; (2) README/CONVENTIONS.md comme seule source (pas de fichier agent-specific) ; (3) IDE-level rules uniquement (user-scoped, non committed) ; (4) Ambient RAG over repo (Sourcegraph Cody, Tabnine) sans instructions curees |
| **O** | Convention-adherence rate du code genere, onboarding time nouveau contributeur (humain ou agent), rework du aux convention violations, first-try success rate |
| **Co** | Multi-repo orgs ; codebases long-lived avec conventions fortes |
| **Question** | *"Un fichier project-instructions committed (CLAUDE.md/AGENTS.md/equivalent) ameliore-t-il l'adherence aux conventions et reduit-il le rework vs README-only ou per-session prompting ?"* |
| **Anchor** | SWEBOK KA 4 §5.1 ; KA 9 (configuration & knowledge management) ; ISO/IEC 42001:2023 §7.5 (documented information) |

### PICOC #9 — Permissions & sandbox (blast-radius limitation)

| Element | Valeur |
|---------|--------|
| **I** | Execution sandboxed avec tool allow-list deny-by-default (Claude Code `--allowedTools` / `--disallowedTools`, Cursor Project deny lists, container-based isolation E2B/Firecracker microVMs, Devin VM, **Sculptor by Imbue** (Docker-based parallel-agent UI), devcontainers) |
| **C** | (1) Unrestricted host access ; (2) Read-only sandbox ; (3) Git-worktree isolation sans process sandbox ; (4) Manual approval de chaque tool call (synchronous prompts) |
| **O** | Incidents per 1000 agent-hours, secret exfiltration events, destructive-command events, developer friction (interrupts/hour) |
| **Co** | Repos touching secrets, infra, ou customer data |
| **Question** | *"Le sandboxing container/VM avec allow-lists explicites reduit-il les incidents agent sans materially reduire le throughput vs host access ou per-call approvals ?"* |
| **Anchor** | ISO/IEC 42001:2023 §8.4 (operation controls) ; ISO/IEC 23894:2023 (risk treatment) ; NIST AI RMF MANAGE-2.2 ; NIST AI 600-1 (Information Security, Value Chain risk categories) |

### PICOC #10 — Silent failure monitoring

| Element | Valeur |
|---------|--------|
| **I** | Pipeline automatise de detection pour silent-failure classes : (a) package-hallucination detection (**Socket**, Snyk dependency audit, `pip-audit`), (b) semantic-drift detection (regression testing on untouched behavior), (c) SAST/DAST triggered on agent diffs, (d) runtime observability (GlitchTip, Sentry, OpenTelemetry) |
| **C** | (1) CI test suite only ; (2) Manual spot-check by reviewer ; (3) No monitoring beyond agent's self-report ; (4) LLM-as-judge post-hoc review |
| **O** | Silent-failure detection rate, time-to-detection, false-alarm rate, MTTR |
| **Co** | Langages avec package ecosystems vulnerables a slopsquatting (Python, JS) ; production runtime |
| **Question** | *"Un pipeline silent-failure monitoring detecte-t-il plus de defects agent earlier que CI-only ou manual review ?"* |
| **Anchor** | SWEBOK KA 5 §7.2 (testing techniques) ; NIST AI 600-1 (Confabulation, Data Integrity) ; ISO/IEC 42001:2023 §9.1 (monitoring, measurement, analysis, evaluation) |

### PICOC #11 — Human+agent team metrics (adapted DORA/SPACE)

| Element | Valeur |
|---------|--------|
| **I** | Metric set adapte combinant DORA 4 keys (deployment frequency, lead time, change failure rate, MTTR) avec attribution agent vs humain + SPACE 5 dimensions (Forsgren et al. 2021 ACM Queue) + agent-specific (agent-authored LOC ratio, human-override rate, escalation rate, cost per merged PR) |
| **C** | (1) DORA only (sans attribution) ; (2) SPACE only ; (3) Vanity metrics (Copilot acceptance rate, Cursor tab-accept rate) ; (4) No measurement |
| **O** | Predictive validity (les metriques predisent-elles les outages/CFR ?), Goodhart resistance, actionability |
| **Co** | Teams avec pre-existing DORA instrumentation |
| **Question** | *"Un DORA+SPACE compose adapte aux agents predit-il le change failure rate et team health mieux que DORA, SPACE, ou acceptance-rate seuls ?"* |
| **Anchor** | SWEBOK KA 9 (SE Management — measurement) ; ISO/IEC 5338:2023 §6.3.7 (Measurement process, sous Technical management processes) ; NIST AI RMF MEASURE-2 ; **Forsgren et al. 2021 "The SPACE of Developer Productivity"** (ACM Queue 19(1), DOI 10.1145/3454122.3454124) |

### PICOC #12 — Model routing policy par task complexity

| Element | Valeur |
|---------|--------|
| **I** | Router rule task-aware : cheap/fast model (Haiku, Sonnet, GPT-4o-mini) pour scaffolding/renames/docs ; strong reasoning model (Opus, o1) pour architecture/debug/security. Implementations : Cursor model picker, Aider `--model`/`--weak-model`, LiteLLM routers, Claude Code model switching |
| **C** | (1) Single strong model pour tout ; (2) Single cheap model pour tout ; (3) User-manual selection per prompt ; (4) Auto-router base sur prompt complexity heuristic (Cursor auto, OpenRouter) |
| **O** | Cost per successful task, task success rate, latency, developer satisfaction |
| **Co** | Budget-constrained teams ; mixed task portfolio |
| **Question** | *"Le task-aware model routing reduit-il le cost per successful task vs single-model strategies ?"* |
| **Anchor** | ISO/IEC 5338:2023 §6.2.2 (Infrastructure management process) et §6.2.4 (Human resource management process), sous Organizational project-enabling processes ; SWEBOK KA 9 (economic management) |

### PICOC #13 — Human situational awareness on critical paths

| Element | Valeur |
|---------|--------|
| **I** | Practices pour preserver la competence humaine sur le code critique : (a) mandatory human line-by-line read-through on designated critical-path files (auth, payment, data deletion), (b) rotation "hands-on" days, (c) agent-generated explanations/tours avant merge, (d) human writes un pourcentage du code manuellement (ex: >=30% sur paths critiques) |
| **C** | (1) Trust-and-merge (pas de read-through enforce) ; (2) Post-hoc learning only (read when it breaks) ; (3) Uniform policy (same for all files, no criticality distinction) |
| **O** | Incident-response time lorsque agent-written code fails, diagnostic accuracy sous stress, tacit knowledge retention tests, long-term skill degradation (longitudinal) |
| **Co** | Teams running production services avec on-call rotation |
| **Question** | *"Des SA-maintenance practices structurees preservent-elles l'incident-response capability mieux que trust-and-merge ou post-hoc learning dans les teams agent-heavy ?"* |
| **Anchor** | SWEBOK KA 9 (SE Management — human factors) ; ISO/IEC 23894:2023 (risk treatment) ; NIST AI RMF GOVERN-3.2 (human-AI teaming competencies) ; **Bainbridge 1983 "Ironies of Automation"** (Automatica 19(6), DOI 10.1016/0005-1098(83)90046-8) |

### PICOC #14 — Prompt / specification discipline

| Element | Valeur |
|---------|--------|
| **I** | Workflows spec-first structures : plan-then-code (Claude Code plan mode via `/plan` et `--permission-mode plan`, Aider `/architect`), TDD-for-agents (voir PICOC #15), acceptance criteria explicites dans issue, spec-driven development (**Amazon Kiro**, **GitHub Spec-Kit** avec `constitution.md`) |
| **C** | (1) Freeform chat prompting ; (2) Single-shot "do X" prompts ; (3) Example-based prompts (few-shot avec past PRs) |
| **O** | First-try success rate, nombre d'iterations par task, rework ratio, defect escape rate |
| **Co** | Feature-development tasks de non-trivial size |
| **Question** | *"Une discipline spec-first ou plan-then-code ameliore-t-elle le first-try success et reduit-elle les iterations vs freeform ou single-shot prompting ?"* |
| **Anchor** | SWEBOK KA 4 §5.1 (construction — planning) ; KA 1 (Software Requirements) ; ISO/IEC 5338:2023 §6.4.2 (Stakeholder needs and requirements definition process) et §6.4.3 (System requirements definition process), sous Technical processes |

### PICOC #15 — TDD agent loop

| Element | Valeur |
|---------|--------|
| **I** | TDD-with-agent : humain ecrit failing test specifiant l'intent, agent iterates implementation jusqu'a tests verts + existing tests toujours verts, pas de human review per iteration |
| **C** | (1) Agent writes both tests and implementation (agent-TDD) ; (2) Humain writes implementation avec agent assistance ; (3) Agent-first puis tests comme post-hoc validation ; (4) No TDD discipline |
| **O** | Defect rate, spec-conformance rate, iteration count, wall-clock |
| **Co** | Projets avec mature test infrastructure, well-specifiable tasks |
| **Question** | *"Pour des taches bien specifiables dans des projets avec test infrastructure mature, human-written-test + agent-iterates-to-green yields-t-il un lower defect rate et higher spec conformance vs agent-authored tests ou human-led implementation ?"* |
| **Anchor** | SWEBOK KA 5 §7.1 (test-driven development) ; KA 4 §5.1 ; KA 16 §9.6 |

### PICOC #16 — Cost & latency budget ceilings per task

| Element | Valeur |
|---------|--------|
| **I** | Triple cap obligatoire : max iterations + max tokens + max wall-clock, avec hard-stop + escalation on breach. Implementations : Claude Code session limits, Cursor usage limits, **LiteLLM budget enforcement**, orchestrator-level guardrails |
| **C** | (1) Token budget only ; (2) Iteration cap only ; (3) Monthly org cap only (pas de per-task) ; (4) No cap (run until natural stop) ; (5) Soft warnings only |
| **O** | Runaway-loop frequency, cost overrun incidents, cost per completed task, completion rate (les caps peuvent causer des stops prematures) |
| **Co** | Commercial usage avec APIs metees ; bootstrapped teams / startups / open-source maintainers |
| **Question** | *"Une triple-cap policy (iterations+tokens+wall-clock) prevent-elle les runaway-loop cost incidents sans materially reduire le throughput vs single-dimension caps ou no caps ?"* |
| **Anchor** | ISO/IEC 5338:2023 §6.2.2 (Infrastructure management process) et §6.3.1 (Project planning process) ; ISO/IEC 42001:2023 §8.1 (Operational planning and control) ; SWEBOK KA 9 (cost management) |

### PICOC #17 — Provenance & audit trail of agent-generated code

| Element | Valeur |
|---------|--------|
| **I** | Audit trail structure per agent session : model name+version, prompt, tool calls, cost, final diff, lie au git commit via trailer ou metadata. Includes session replay storage si possible |
| **C** | (1) No tracking ; (2) Git `Co-Authored-By` trailer only ; (3) Vendor-side logs (Anthropic console, Cursor dashboards) sans linkage git local ; (4) Full session replay stockee |
| **O** | Auditability (time to answer "who/what produced this line"), reproducibility rate, compliance audit pass/fail, storage cost |
| **Co** | Organisations ISO 42001-certifying ou aspirantes ; regulated industries (health, finance, GDPR) |
| **Question** | *"Un audit trail structure lie aux git commits fournit-il une auditabilite suffisante pour ISO 42001 §8 operational records vs git-trailer-only ou vendor-side logging ?"* |
| **Anchor** | ISO/IEC 42001:2023 §7.5 + §8 (documented information, operation) ; ISO/IEC 5338:2023 §6 (lifecycle records) ; NIST AI RMF GOVERN (accountability) |

## Tableau recapitulatif

| # | Short title | Rationale | Anchor principal |
|---|-------------|:---------:|------------------|
| 1 | Autonomy granularity per action | Strong | Parasuraman Sheridan Wickens 2000 + KA 9 |
| 2 | Task-type routing | Strong | KA 4 §5.1 + Hou 2024 SLR |
| 3 | Human-only decision gates | Strong | ISO 42001 §8.2 + NIST GOVERN-1.1 |
| 4 | Deterministic verification gates | Very strong | KA 5 §7.1-7.2 + NIST 600-1 |
| 5 | Multi-agent topology (+ writer/reviewer) | Strong | KA 16 §9.6 + He 2024/25 SLR |
| 6 | Escalation protocol format | Moderate | KA 9 + Marquet 2013 |
| 7 | Context compaction (session-level) | Strong | KA 9 + KA 16 |
| 8 | Project-level persistent instructions | Strong | KA 9 + ISO 42001 §7.5 |
| 9 | Permissions & sandbox | Very strong | ISO 42001 §8.4 + NIST 600-1 |
| 10 | Silent failure monitoring | Strong | KA 5 §7.2 + NIST 600-1 |
| 11 | Adapted DORA/SPACE metrics | Strong | Forsgren 2021 SPACE + KA 9 |
| 12 | Model routing per task | Moderate-strong | ISO 5338 §6.3 |
| 13 | Human situational awareness | Moderate | Bainbridge 1983 + NIST GOVERN-3.2 |
| 14 | Prompt/spec discipline | Strong | KA 4 §5.1 + KA 1 |
| 15 | TDD agent loop | Strong | KA 5 §7.1 + KA 4 §5.1 |
| 16 | Cost/budget caps per task | Strong | ISO 5338 §6.3 + ISO 42001 §8.1 |
| 17 | Provenance/audit trail | Strong | ISO 42001 §7.5 + §8 |

**Total : 18 PICOCs** (dans target 10-20 methodology.md §1.3).

### PICOC #19 — Verification method (grep vs lecture vs agent independant)

| Element | Valeur |
|---------|--------|
| **I** | Verification par lecture complete des fichiers sources + agent independant avec contexte frais pour les verifications critiques |
| **C** | (1) Grep / pattern matching comme methode principale de verification d'alignement ; (2) Auto-verification par l'agent lui-meme (meme contexte) |
| **O** | Taux de faux negatifs (gaps non detectes), precision de la verification, detection de violations semantiques |
| **Co** | Agents IA autonomes (Claude Code, Cursor, Copilot, Devin) verifiant qu'un document/code est aligne a une reference (template, conventions, spec) |
| **Question** | *"Pour un agent IA verifiant l'alignement semantique entre une implementation et une reference (template, conventions, spec), la lecture complete + agent independant reduit-elle les faux negatifs vs grep/pattern matching ou auto-verification ?"* |
| **Anchor** | Lu et al. 2025 arXiv:2512.02304 (solver vs verifier gain) ; Wataoka et al. 2024 arXiv:2410.21819 (self-preference bias) ; AGENTIF arXiv:2505.16944 NeurIPS 2025 (constraint types) ; NIST AI 600-1 §2.2 Confabulation ; Manning et al. IR textbook (grep semantique) |

### PICOC #20 — Accountability et gouvernance agentique

| Element | Valeur |
|---------|--------|
| **I** | Framework d'accountability explicite : chaine d'imputabilite humaine documentee, registre d'actions auditable, points de controle d'approbation humaine significatifs avant actions a fort impact |
| **C** | (1) Deploiement sans framework de gouvernance formalise (responsabilite implicite ou distribuee) ; (2) Gouvernance basee sur la confiance au modele uniquement |
| **O** | Clarte d'imputabilite en cas de defaillance, conformite reglementaire, detectabilite des incidents, confiance des parties prenantes |
| **Co** | Systemes de developpement logiciel autonomes avec delegation PO→agent, contexte production |
| **Question** | *"Un framework d'accountability explicite (chaine d'imputabilite, registre d'actions, checkpoints humains) ameliore-t-il la detectabilite des incidents et la conformite reglementaire vs deploiement sans gouvernance formalisee ?"* |
| **Anchor** | OpenAI Practices for Governing Agentic AI 2023 ; IMDA Model AI Governance Framework 2026 ; WEF AI Agents in Action 2025 ; Feng et al. Levels of Autonomy 2025 |

### PICOC #21 — Calibration performance reelle des agents

| Element | Valeur |
|---------|--------|
| **I** | Calibration des attentes sur les performances reelles en production : taux de succes par type de tache mesure en conditions reelles, gap benchmark vs production documente et communique au PO |
| **C** | (1) Calibration basee sur les benchmarks academiques (SWE-bench, HumanEval) sans ajustement production ; (2) Confiance par defaut basee sur les benchmarks marketing |
| **O** | Precision des attentes PO, taux de sur-delegation/sous-delegation, qualite des decisions de delegation, desillusion post-deploiement |
| **Co** | Delegation PO→agent autonome en contexte production reel, taches de developpement logiciel |
| **Question** | *"Calibrer les attentes sur les performances reelles en production (vs benchmarks) ameliore-t-il la qualite des decisions de delegation et reduit-il le taux de desillusion post-deploiement ?"* |
| **Anchor** | SWE-bench (Jimenez 2024) ; SWE-bench Pro (Drozdov 2025) ; ReliabilityBench (2026) ; Anthropic Measuring Agent Autonomy 2026 ; Mehta CLEAR 2025 |

### PICOC #22 — Securite agentique (prompt injection, IAM, tool misuse)

| Element | Valeur |
|---------|--------|
| **I** | Mesures de securite specifiques aux agents autonomes : identites distinctes (IAM), least-privilege, sandboxing, defense contre prompt injection, audit logging des actions |
| **C** | (1) Securite perimetrique classique sans adaptation aux risques specifiques des agents ; (2) Confiance implicite dans les inputs de l'agent |
| **O** | Taux d'exploitation reussi, surface d'attaque, blast radius en cas de compromission, incidents de securite agent-specific |
| **Co** | Agents autonomes de developpement logiciel avec acces a des outils (code execution, file system, APIs, web) |
| **Question** | *"Les mesures de securite specifiques aux agents (IAM distinct, least-privilege, sandboxing, defense prompt injection) reduisent-elles significativement le taux d'exploitation et le blast radius vs securite perimetrique classique ?"* |
| **Anchor** | Datta et al. Agentic AI Security 2025 ; ISACA Best Practices Agentic AI 2025 ; Arunkumar et al. Agentic AI Architectures 2026 ; AI Agent Index 2026 |

### PICOC #23 — Evaluation multi-dimensionnelle (CLEAR)

| Element | Valeur |
|---------|--------|
| **I** | Framework d'evaluation multi-dimensionnel des livrables d'agents : Cost, Latency, Efficacy, Assurance, Reliability (CLEAR ou equivalent) couvrant dimensions economiques et operationnelles |
| **C** | (1) Evaluation basee sur le task completion binaire (succes/echec) uniquement ; (2) Accuracy ou pass@1 comme metrique principale |
| **O** | Precision de prediction du succes en production, detection precoce des problemes de reliability et de cout, correlation avec valeur metier reelle |
| **Co** | Systemes agentiques de developpement logiciel en contexte enterprise, evaluation par PO |
| **Question** | *"Un framework d'evaluation multi-dimensionnel (CLEAR : Cost, Latency, Efficacy, Assurance, Reliability) predit-il mieux le succes en production que l'evaluation basee sur le task completion ou l'accuracy seule ?"* |
| **Anchor** | Mehta CLEAR arXiv:2511.14136 2025 (rho=0.83) ; Mohammadi SAP KDD 2025 ; Akshathala IIIT-Hyderabad 2025 ; Arunkumar CLASSic 2026 |

### PICOC #24 — Structure organisationnelle equipe agents (SE 3.0)

| Element | Valeur |
|---------|--------|
| **I** | Structure organisationnelle explicite avec roles distincts pour les agents : manager / researcher / engineer / reviewer (ou equivalent agile), avec separations de responsabilites documentees |
| **C** | (1) Agent unique polyvalent sans structure de roles ; (2) Topologie non-structuree sans separation de responsabilites ; (3) Structure ad hoc per-tache |
| **O** | Taux de resolution de taches complexes, qualite architecturale des livrables, coherence des outputs multi-agents |
| **Co** | Systemes multi-agents pour le developpement logiciel autonome delegue par un PO |
| **Question** | *"Une structure organisationnelle explicite avec separation des roles (manager/researcher/engineer/reviewer) ameliore-t-elle le taux de resolution et la qualite vs agent unique ou topologie non-structuree ?"* |
| **Anchor** | Agyn arXiv:2602.01465 2026 (72.2% SWE-bench 500) ; ALMAS JPMorgan 2025 ; Li/Zhang/Hassan SE 3.0 arXiv:2507.15003 2025 (456 535 PRs) ; ChatCollab Stanford 2024 |

### PICOC #25 — Taxonomie des modes de defaillance agentiques (MAST)

| Element | Valeur |
|---------|--------|
| **I** | Connaissance et prise en compte explicite d'une taxonomie des modes de defaillance specifiques aux agents (system design / inter-agent misalignment / task verification) dans le design du systeme |
| **C** | (1) Design sans modele formel des modes de defaillance agents ; (2) Application des taxonomies de defaillance logicielle classiques sans adaptation agents |
| **O** | Taux de detection precoce des defaillances, qualite du design, frequence des modes de defaillance en production |
| **Co** | Systemes multi-agents LLM pour developpement logiciel, contexte enterprise |
| **Question** | *"Integrer une taxonomie des modes de defaillance specifiques aux agents (ex: MAST) dans le design reduit-il la frequence et l'impact des defaillances vs design sans modele formel ?"* |
| **Anchor** | Cemri et al. MAST ICLR 2025 arXiv:2503.13657 (kappa=0.88, 1600+ traces) ; Zhang et al. arXiv:2604.08906 2026 (409 bugs, 5 frameworks) |

### PICOC #26 — Supervision sans micro-management (Human-On-The-Loop)

| Element | Valeur |
|---------|--------|
| **I** | Architecture Human-On-The-Loop (HOTL) : supervision par exception, definition d'objectifs de haut niveau, capacite d'intervention sans approbation de chaque action individuelle |
| **C** | (1) Human-In-The-Loop (approbation de chaque action, micro-management) ; (2) Human-Out-Of-The-Loop (zero supervision) |
| **O** | Qualite de supervision, detection des derives comportementales, charge cognitive du superviseur, autonomie preservee, taux d'intervention pertinente |
| **Co** | PO ou managers supervisant des agents IA autonomes en developpement logiciel |
| **Question** | *"Une architecture Human-On-The-Loop (supervision par exception + objectifs HN) maintient-elle une qualite de supervision equivalente au HITL en reduisant la charge cognitive vs micro-management action-par-action ?"* |
| **Anchor** | Anthropic Measuring Agent Autonomy 2026 ; Zhou et al. OrchVis arXiv:2510.24937 2025 ; Feng et al. Levels of Autonomy arXiv:2506.12469 2025 ; Berretta et al. HAT Frontiers AI 2023 |

### PICOC #27 — Redesign des processus pour delegation agentique

| Element | Valeur |
|---------|--------|
| **I** | Redesign explicite des processus de developpement pour la delegation agentique : adapter les workflows, les ceremonies, et les definitions of done a la collaboration PO→agent plutot qu'automatiser les processus humains existants |
| **C** | (1) Automatisation directe des processus existants sans redesign (memes steps, memes criteres, meme organisation) ; (2) Adoption incrementale sans changement de processus |
| **O** | Taux de succes des initiatives agentiques, valeur metier livree, taux d'echec lie aux processus inadaptes |
| **Co** | Organisations adoptant des agents IA autonomes pour le developpement logiciel, en remplacement ou complement d'une equipe humaine |
| **Question** | *"Le redesign explicite des processus (vs automatisation de l'existant) ameliore-t-il significativement le taux de succes des initiatives agentiques et la valeur metier livree ?"* |
| **Anchor** | Deloitte Tech Trends 2026 (40%+ projets echoueront si mauvaise gouvernance) ; Cemri MAST 2025 (system design = categorie defaillance) ; McKinsey QuantumBlack 2026 (SDD) |

## Corrections factuelles appliquees (via Agent C)

1. **"Dagger for Cursor"** (cite par Reviewer A) → **SUPPRIME**, fabrication detectee. Remplace par **"Sculptor (Imbue)"** (Docker-based parallel-agent UI, reel mais pas un Cursor tool).
2. **Continue `config.json`** → `config.yaml` (config.json est deprecated).
3. **Qodo Merge "previously PR-Agent"** → distincts : PR-Agent = legacy OSS, Qodo Merge = commercial.
4. **AutoGen (Microsoft)** → en **maintenance mode** ; successeur : Microsoft Agent Framework (MAF).
5. **OpenAI Swarm** → experimental/educational ; successeur : **OpenAI Agents SDK**.
6. **Parasuraman & Sheridan 2000** → correct citation : **Parasuraman, Sheridan & Wickens 2000** (3 auteurs, IEEE TSMC Part A 30(3), pp. 286-297, DOI 10.1109/3468.844354).
7. **Claude Code "ExitPlanMode"** → user-facing name : "plan mode" / `/plan` / `--permission-mode plan`.
8. **Langfuse guardrails/budgets** → reattribute a **LiteLLM** (explicit cost/budget features). Langfuse = observability/tracing uniquement.

## Limites documentees

1. **Enumeration C alternatives** : certaines PICOCs listent 3-4 alternatives concretes ; l'espace complet peut contenir des outils emergents post-2026-04-15. A reverifier lors de Phase 2.1 (systematic search per PICOC).

2. **Task-type taxonomy PICOC #2** : utilise une taxonomie provisoire (new feature / bugfix / refactor / test writing / docs / infra). Une taxonomie formelle peut etre derivee de SWEBOK v4 KA 4 en Phase 2.

3. **Evidence base tres recente** : beaucoup de PICOCs auront des sources primaires de 2024-2026 avec peu de replication. Impact anticipe sur Phase 2.3 (quality assessment) : scores de qualite moderes par defaut, GRADE `-1` pour imprecision possible.

4. **PICOC #13 situational awareness** : ancrage sur Bainbridge 1983 via KA 9. Le papier Bainbridge n'est pas un SWEBOK/ISO mais un papier de reference canonique. Anchor oblique accepte.

5. **PICOC #5 multi-agent** : SWE-bench Verified et Multi-SWE-bench sont ecologiquement-invalides pour des production codebases long-lived. L'evidence base sera benchmark-heavy et field-light. A documenter comme indirectness en Phase 2.5 GRADE.

6. **PICOCs non retenues** : licensing/IP provenance of agent-generated code (considere par A mais reporte a une future SLR legal/compliance) ; agent UX/IDE integration depth (considere par A mais rejete comme product-preference, pas EBSE-answerable).

## Prochaine etape

**Phase 1.4** — Review protocol : inheritance de methodology.md v3.0, documentation des deviations observees Phase 1.1-1.3 (search string complementaire Phase 1.1, corpus fixe Phase 1.2, 1 fabrication Phase 1.3 detectee), puis **Phase 1.5** — peer review du protocole + pilotage sur 3-5 PICOCs representatives.
