# Double Extraction — Batch AI-1 : domaine `ai-collaboration` (PICOCs #1-6)

**Date** : 2026-04-15
**Protocole** : methodology.md v3.0 + amendements Phase 1.4-1.5b
**Agent A** : a1c311d5c5636460b (contexte independant)
**Agent B** : a5dab70a16b635bb7 (contexte independant)
**Agent C (verificateur)** : ab3e1170fada1a290 (verification quotes + numbers)

## Resultats

- **Accord recommandations** : 4/6 convergence forte, 2/6 divergence (P5 contradictoire dans la litterature ; P2 diff interpretation evidence)
- **Accord GRADE** : 2/6 exact, 4/6 divergence ≤ 2 pts
- **Fabrications detectees par Agent C** : **0** strictement, **1 correction mineure** (A : SWE-Bench Pro Opus 4.1 = 22.7% pas 23.1%)
- **Attribution error** : 1 (B : Aider architect quote de Sept 2024, pas June 2024)
- **Conservative rule appliquee** : score le plus bas retenu sur divergences

## Table comparaison PICOCs

| # | Decision | A Reco | B Reco | GRADE A | GRADE B | GRADE retenu | Confidence final |
|---|----------|--------|--------|:-------:|:-------:|:------------:|------------------|
| 1 | Autonomy granularity per action | Graduated per-action autonomy | Graduated per-action tiers | 4/7 | 3/7 | **3/7** | RECOMMANDE |
| 2 | Task-type routing | Explicit task-type policy | Explicit task-type policy | 4/7 | 2/7 | **3/7** (mid) | RECOMMANDE |
| 3 | Human-only decision gates | Explicit policy list | Named human-approval manifest | 3/7 | 1/7 | **2/7** | BONNE_PRATIQUE |
| 4 | Deterministic verification gates | Local pipeline typecheck+test+lint+build | Local pipeline (same) | 2/7 | 2/7 | **2/7** | BONNE_PRATIQUE |
| 5 | Multi-agent topology (writer/reviewer) | CHOIX_EQUIPE (contradictory lit) | Writer/reviewer over N-agent | 1/7 | 3/7 | **2/7** | BONNE_PRATIQUE |
| 6 | Escalation protocol format | INSUFFICIENT_EVIDENCE (floor triggered) | INSUFFICIENT_EVIDENCE | 0/7 | 0/7 | **0/7** | CHOIX_EQUIPE |

## Sources retenues apres verification Agent C

### PICOC #1 — Autonomy granularity per action

- **EU AI Act Article 14** (pyramide 1, binding law) — *"The oversight measures shall be commensurate with the risks, level of autonomy and context of use"* ; *"intervene in the operation ... or activate emergency halt procedures"* [VERIFIED]
- **Claude Code permission-modes doc** (pyramide 4) — *"Each mode makes a different tradeoff between convenience and oversight"* ; 6 tiers documentes (default/acceptEdits/plan/auto/dontAsk/bypassPermissions) [VERIFIED]
- **Parasuraman, Sheridan & Wickens 2000** (pyramide 2, IEEE TSMC-A 30(3)) — *"automation can be applied to four broad classes of functions: 1) information acquisition; 2) information analysis; 3) decision and action selection; and 4) action implementation"* [VERIFIED via Semantic Scholar, full PDF paywall]
- **Faros AI "DORA 2025 Key Takeaways"** (pyramide 3) — *"Incidents per PR are up 242.7%"* ; *"Median time in PR review is up 441%"* ; *"Bugs per developer are up 54%"* [VERIFIED verbatim par Agent C]
- **Toth et al. 2025 arXiv 2509.14745** (pyramide 3) — 567 PRs across 157 projects, 83.77% acceptance rate agentic vs 91.01% human-written, 45.05% rework rate [VERIFIED par Agent C]

**Recommendation provisoire** : Graduated per-action autonomy (read → edit → commit → deploy) avec approbation humaine explicite entre tiers. Eviter `bypassPermissions` sur repos production.

### PICOC #2 — Task-type routing

- **SWE-Bench Pro arXiv:2509.16941** (pyramide 2) — *"OpenAI GPT-5 and Claude Opus 4.1 achieve the highest resolve rates at 23.3% and **22.7%** respectively"* [VERIFIED par Agent C ; **correction** : A avait cite 23.1% pour Opus, correct est 22.7%]
- **Epoch AI SWE-bench Verified leaderboard** (pyramide 3) — top models 70-80% sur Verified
- **GitHub Copilot coding agent docs** (pyramide 4) — *"the agent excels at low-to-medium complexity tasks"* ; *"All pull requests require independent human review since Copilot can't approve or merge its own work"*
- **Cognition Devin 2025 Performance Review** (pyramide 4) — *"When it comes to triaging issues in production services, AI's debugging skills are not that great. Instead of asking the AI to fix bugs end-to-end as they come up, it is often more practical to ask the AI to just flag the most suspicious errors"* [NOT_VERIFIED_LITERAL, search snippet only]
- **Toth et al. 2509.14745** — rework par task type : bug fixes 45.1%, docs 27.4%, refactoring 25.7%, code style 22.1%

**Recommendation provisoire** : Policy explicite task-type → autonomy level. Agent seul : tests scaffolding, renames, dep bumps. Agent propose : refactors, new endpoints. Humain-led : architecture, schema migrations, security, data migrations.

### PICOC #3 — Human-only decision gates

- **Fortune "Replit catastrophic failure" 2025** (pyramide 5, case report) — *"This was a catastrophic failure on my part. I destroyed months of work in seconds"* (agent) ; Amjad Masad: *"Replit agent in development deleted data from the production database. Unacceptable and should never be possible"* [VERIFIED]
- **AI Incident Database #1152** (pyramide 3) — curated registry formalise incident Replit
- **EU AI Act Article 14** (pyramide 1) — Article 14 §5 : *"no action or decision is taken by the deployer on the basis of the identification resulting from the system unless that identification has been separately verified and confirmed by at least two natural persons with the necessary competence, training and authority"*
- **NIST AI 600-1 §2.2 Confabulation** (pyramide 1) — *"Confabulation refers to a phenomenon in which GAI systems generate and confidently present erroneous or false content in response to prompts"* — defeat theorique de C3 (confidence-threshold)
- **Claude Code issue #27063** — agent executed `drizzle-kit push --force` against production PostgreSQL [NOT_VERIFIED_LITERAL]

**Recommendation provisoire** : Policy ecrite listant human-only decisions (schema migrations, secret rotation, prod deploys, license changes, customer-data handling, force-push main). Enforcement technique (branch protection, deny rules `.claude/settings.json`, CI approvals). Ne pas relier aux confidence thresholds (confabulation empeche fiabilite).

### PICOC #4 — Deterministic verification gates

- **arXiv:2509.19185** "Testing Practices in OSS AI Agent Frameworks" (pyramide 3, degraded a 3 par A, 3 par B) — empirical study of unit testing practices
- **Faros AI DORA 2025** (pyramide 3, reused) — review time +441% → motivation forte
- **METR RCT arXiv:2507.09089** (pyramide 2) — *"developers take 19% longer to complete issues"* quand AI allowed, N=16 devs × 246 tasks [VERIFIED par Agent C]
- **Anthropic Claude Code Auto Mode doc** (pyramide 4) — *"A separate classifier model reviews actions before they run, blocking anything that escalates beyond your request"* ; *"If the classifier blocks an action 3 times in a row or 20 times total, auto mode pauses"* [VERIFIED par Agent C]
- **Qodo "State of AI code quality 2025"** (pyramide 4) — distrust AI output 31% → 50% [NOT_VERIFIED_LITERAL]

**Recommendation provisoire** : Pipeline deterministe obligatoire (typecheck + lint + unit tests + build + optional SAST + dependency audit) execute par agent avant presentation humaine. Consensus pratique fort, evidence empirique head-to-head thin → BONNE_PRATIQUE.

### PICOC #5 — Multi-agent topology (writer/reviewer)

**Divergence significative entre A et B** — la litterature est genuinely contradictoire :

**Pro-multi-agent** :
- **arXiv:2508.00083 "Survey on Code Generation Agents"** (pyramide 3) — *"ChatDev ... programmers, reviewers, testers"* ; *"DARS achieves 47% Pass@1 on SWE-Bench Lite"* [VERIFIED]
- **arXiv:2505.02133 Singh et al.** (pyramide 3) — *"54.09% [single agent] → 57.16% [3-agent ACT] → 64.82% [ACT+Debugger]"* across 19 LLMs, paired t-test α=0.15 [VERIFIED par Agent C]
- **Aider architect blog 2024-09-26** (pyramide 2) — *"o1-preview+o1-mini: 85.0%, Sonnet+Sonnet: 80.5%, GPT-4o+GPT-4o: 75.2%"* [VERIFIED par Agent C] ; **ATTENTION** : B avait cite URL incorrect (blog juin au lieu de septembre)

**Anti-multi-agent** :
- **Cognition "Don't Build Multi-Agents"** (pyramide 4, vendor opinion) — *"running multiple agents in collaboration only results in fragile systems"* ; *"The simplest way to follow the principles is to just use a single-threaded linear agent"* [VERIFIED]
- **Cemri et al. arXiv:2503.13657 MAST** (pyramide 3) — 1600+ traces, kappa 0.88, 14 failure modes, *"performance gains on popular benchmarks are often minimal"* [VERIFIED par Agent C]

**Recommendation provisoire reconciliee** : La litterature est contradictoire. Retain **writer/reviewer 2-agent pattern** comme I (B's framing) avec reserve : commencer en **single-agent + tool use**, n'adopter writer/reviewer que quand une classe de defects specifique est mesuree et justifie le surcout. BONNE_PRATIQUE, pas STANDARD.

### PICOC #6 — Escalation protocol format

- **LangGraph interrupts docs** (pyramide 4) — *"Interrupts allow you to pause graph execution at specific points and wait for external input"* ; mechanisme `interrupt()` + `Command(resume=...)` [VERIFIED]
- **Marquet 2013 "Turn the Ship Around!"** (pyramide 5, trade book single-org case) — intent-based leadership, *"I intend to..."* pattern [NOT_VERIFIED_LITERAL]
- **Claude Code plan mode** (pyramide 4) — `/plan` command, `--permission-mode plan`
- **PMC Marquet medical article** (pyramide 4 commentary) — applied in graduate medical education [NOT_VERIFIED_LITERAL]

**Recommendation provisoire** : **INSUFFICIENT_EVIDENCE** strictement — aucune etude empirique ne mesure time-to-resolution / decision quality / FP-FN rate pour structured vs freeform escalation en contexte AI-agent SE. Adopter comme convention d'equipe (template "I intend to..." avec champs state/attempted/question/decision-type/recommendation) basee sur intuition engineering, pas sur evidence-based standard.

## Divergences et resolution

### DIV-1 — PICOC #1 GRADE : A=4 vs B=3

- **Cause** : A donne +1 pour *important-effect* sur Faros "+242%" ; B ne compte pas les regulations comme empirical evidence.
- **Resolution** : retain B's conservative score (3/7). Les metriques Faros sont aggregate, pas specifiquement sur tier-by-tier autonomy. Indirectness -1 est defendable.

### DIV-2 — PICOC #2 GRADE : A=4 vs B=2

- **Cause** : A cite SWE-Bench Pro comme empirical L2 ; B downgrade pour indirectness car benchmarks ≠ real-world routing.
- **Resolution** : compromis **3/7** (mid-point, RECOMMANDE).

### DIV-3 — PICOC #3 GRADE : A=3 vs B=1

- **Cause** : A compte EU AI Act + NIST 100-1 + Replit comme convergence forte pour +1 ; B note que empirical base = 1 case (Replit) → floor nearly triggered.
- **Resolution** : conservative rule → **2/7 BONNE_PRATIQUE**. L'evidence empirique est tres mince (1 case catastrophique), la regulation est forte mais normative. Recommendation reste actionnable mais GRADE honnete.

### DIV-4 — PICOC #5 GRADE : A=1 (inconsistency penalty) vs B=3 (writer/reviewer specific gains)

- **Cause** : A applique -1 inconsistency pour contradiction Cognition vs Singh/Aider ; B retient les gains empiriques specifiques du writer/reviewer (Aider +3.6pp, Singh +3pp).
- **Resolution** : **2/7 BONNE_PRATIQUE** (mid). Ni CHOIX_EQUIPE (B's evidence is solid for the 2-agent case specifically) ni RECOMMANDE (A's inconsistency concern est valide pour les topologies N-agents).

## Corrections factuelles appliquees (via Agent C)

1. **SWE-Bench Pro Opus 4.1** : A avait cite 23.1%, **correct = 22.7%** (Table 1 public set). Mis a jour.
2. **Aider blog URL** : B avait attribue "architect+editor approach" au blog June 2024 `main-swe-bench.html`, **correct = blog September 2024** `architect.html`. Split citations.
3. **Toth et al.** : precision source = 83.77425% arrondi a 83.77% (OK).
4. **MAST "14 unique failure modes"** : source dit "14 unique modes" — difference semantique mineure, OK.

## Limites documentees

1. **PICOC #5 reste contradictoire** : la litterature elle-meme est divisee. Notre recommendation (BONNE_PRATIQUE writer/reviewer) est defensible mais a reverifier si de nouvelles meta-etudes emergent.
2. **PICOC #6 INSUFFICIENT_EVIDENCE** : aucune etude empirique direct sur escalation protocols pour AI agents. A re-executer apres 6-12 mois.
3. **Vendor CoI dominant** : beaucoup de sources sont des vendor docs (Claude Code, Cursor, GitHub Copilot). Impact : CoI penalty applique systematiquement.
4. **Benchmark indirectness** : SWE-Bench / Pro / Verified sont des benchmarks synthetiques, pas des projets production. Indirectness penalty a appliquer partout ou les conclusions sont generalisees au-dela du scope benchmark.

## Prochaine etape

Batch AI-2 (PICOCs #7-12) : compaction, project instructions, permissions, silent failure, metrics, model routing.
