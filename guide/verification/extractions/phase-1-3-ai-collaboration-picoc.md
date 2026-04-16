# Double Extraction — Phase 1.3 : PICOC `ai-collaboration`

**Date** : 2026-04-15
**Protocole** : methodology.md v3.0, section 1.3 (Kitchenham & Charters 2007 §5.3, Specifying research questions)
**Agent A** : abe7c02475d14dc86 (contexte independant)
**Agent B** : aac0373422a2ab5bc (contexte independant)
**Agent C (verificateur)** : a10ca0c564c4fa743 (contexte independant, verification des outils cites)
**Superviseur** : Claude Opus 4.6 (reconciliation)

## Objectif

Formuler les questions PICOC (Population, Intervention, Comparison, Outcome, Context) pour chaque decision du domaine `ai-collaboration`. Les 5 anchors Phase 1.2 (ISO 5338, 42001, 23894, NIST 100-1, 600-1) et les 3+1 KAs SWEBOK (KA 4 §5.1, KA 5 §7.1-7.2, KA 9 intro, KA 16 §9.6) fournissent le scope. La liste candidat de 13 decisions a ete fournie comme **point de depart** ; A et B pouvaient raffiner/ajouter/fusionner.

## Sortie brute A et B

| Reviewer | Nombre de PICOCs | Decisions ajoutees | Decisions fusionnees |
|----------|:----------------:|-------------------|----------------------|
| A | 14 | Prompt/spec discipline, Cost/latency budgets | Writer/reviewer → gates (#3) ; Onboarding → context (#6) |
| B | 15 | TDD agent loop, Budget caps, Provenance/audit trail | Writer/reviewer → multi-agent (#5) ; Split #1 en generative/modification ; Split #7 en session compaction / project instructions |

## Points de convergence (11 decisions communes)

Les deux reviewers ont formule une PICOC similaire pour :

1. Level of automation (axe autonomy)
2. Human-only decision gates
3. Deterministic verification gates
4. Escalation protocol format
5. Single vs multi-agent architecture
6. Context management (handled diff. par A et B, voir ci-dessous)
7. Permissions & sandbox
8. Silent failure monitoring
9. Human+agent metrics (DORA/SPACE adaptes)
10. Model routing per task
11. Human situational awareness

## Divergences reconcilees

### DIV-PICOC-1 : Writer/reviewer pattern — ou merger ?

- **A** : merged dans #3 Deterministic gates (writer/reviewer comme un I parmi d'autres : "deterministic + LLM reviewer")
- **B** : merged dans #5 Multi-agent topology (writer/reviewer comme une topology 2-agents)
- **Argument A** : les deux (gates deterministes et LLM-as-judge) contribuent au pre-merge verification, donc meme PICOC
- **Argument B** : writer/reviewer est architecturalement un multi-agent topology (2 agents avec roles distincts), pas un gate

**Resolution superviseur** : retain **B's merge**. Architecturalement, writer/reviewer IS un multi-agent topology (single agent + self-reflection ; 2-agent writer/reviewer ; N-agent orchestrator-worker). Les gates deterministes (typecheck, test, lint, SAST) sont une classe differente de verification : ils sont **mechaniques**, pas **generatifs**. Les melanger dans une seule PICOC creerait une comparaison mal posee.

**Impact** : PICOC #4 gates reste pur (typecheck/test/lint/build/SAST uniquement) ; PICOC #5 multi-agent inclut writer/reviewer comme un I specifique.

### DIV-PICOC-2 : Split de #1 Level of automation

- **A** : split en "autonomy granularity per action" (LoA escalier par type d'action : read → edit → commit → deploy) + "task-type routing" (quel task-class l'agent fait seul vs avec humain)
- **B** : split en "LoA generative (new code)" + "LoA modification (refactor/bugfix)"

**Argument A** : 2 axes orthogonaux. Granularity = LoA Parasuraman/Sheridan applique aux *actions*. Task-type routing = quelle *classe de taches* on delegue.

**Argument B** : generative et modification ont des profils de risque differents (regression risk domine en modification).

**Resolution superviseur** : retain **A's 2-way split** (autonomy granularity + task-type routing) comme decomposition principale. **Inclure B's generative/modification comme sous-cas dans PICOC #2 task-type routing** (ce sont 2 valeurs du task-type dimension). Ceci couvre les deux angles sans duplication.

### DIV-PICOC-3 : Context management — un ou deux PICOCs ?

- **A** : un seul PICOC #6 "Context & onboarding" qui merge starting #7 context management + #13 project onboarding
- **B** : **deux** PICOCs : #6 context compaction during session (runtime) + #7 project-level persistent instructions (static, committed)

**Argument A** : project instructions sont l'**initialisation** du context management ; meme tool class.

**Argument B** : deux engineering decisions distinctes avec alternatives differentes :
- Compaction session : summarize-restart vs naive truncation vs RAG-over-history vs extended-context model
- Project instructions : CLAUDE.md vs AGENTS.md vs .cursorrules vs README-only vs none

**Resolution superviseur** : retain **B's split**. Les alternatives ne se recoupent pas. Un team peut decider d'une strategie de compaction independamment de son choix de project instructions file. Deux decisions = deux PICOCs.

### DIV-PICOC-4 : Nouvelles decisions ajoutees

| Nouvelle decision | Ajoutee par | Retenue ? | Rationale |
|-------------------|:-----------:|:---------:|-----------|
| Prompt/spec discipline | A | **OUI** | Distinct de TDD : prompt discipline est broad (spec-first, plan-then-code, few-shot), TDD est un pattern specifique |
| TDD agent loop | B | **OUI** | Pattern specifique (human writes test, agent iterates to green), alternatives concretes, anchor SWEBOK KA 5 §7.1 |
| Cost/latency budget governance | A | **OUI (merge)** | = B's "Budget caps per task". Merge en une PICOC |
| Budget caps per task | B | **OUI (merge)** | idem ci-dessus |
| Provenance/audit trail | B | **OUI** | Directement ancre ISO/IEC 42001 §7.5 + §8 (A n'avait pas ajoute cette decision, B a identifie le gap) |

**Total apres reconciliation** : 17 PICOCs (dans target 10-20).

## Verification Agent C — resultats

Agent C a verifie **36 items** (outils, frameworks, standards, references academiques) cites par A et B.

### Fabrication detectee (1)

**"Sculptor / Dagger for Cursor"** (cite par Reviewer A dans PICOC #7 Permissions/sandbox) :
- **Sculptor** est un outil reel (**Imbue**, https://github.com/imbue-ai/sculptor), "UI for running parallel coding agents in safe, isolated sandboxes" — **mais c'est un standalone UI sur Docker, pas un Cursor add-on**
- **"Dagger for Cursor"** n'existe pas. Dagger (dagger.io) est un outil CI/CD pipeline reel mais il n'y a aucune integration Cursor nommee ainsi.
- **Resolution** : remplacer le nom par "Sculptor (Imbue, Docker-based parallel-agent UI)" et supprimer la reference "Dagger for Cursor". Reviewer A avait **explicitement flag cet item** comme uncertain — le protocole double extraction + Agent C a fonctionne.

### Corrections factuelles requises (8)

| # | Claim | Correction |
|---|-------|-----------|
| 1 | Continue `config.json` pour system prompts | `config.json` deprecated, migrer vers `config.yaml` |
| 2 | "Qodo Merge (previously PR-Agent)" | Distincts : PR-Agent = legacy open source, Qodo Merge = commercial product |
| 3 | AutoGen (Microsoft) comme multi-agent framework actif | En **maintenance mode** ; successeur : Microsoft Agent Framework (MAF) |
| 4 | OpenAI Swarm comme multi-agent framework actif | **Experimental/educational** ; successeur : OpenAI Agents SDK |
| 5 | Parasuraman & Sheridan 2000 | Ajouter Wickens comme co-auteur : **Parasuraman, Sheridan & Wickens 2000** (IEEE TSMC Part A, 30(3), 286-297) |
| 6 | Claude Code `ExitPlanMode` tool | User-facing name : **"plan mode"** / `/plan` / `--permission-mode plan`. `ExitPlanMode` est un internal tool symbol, pas documente en public CLI ref. |
| 7 | Langfuse guardrails / budgets | Langfuse = observability/tracing. Guardrails/budgets → **LiteLLM** (explicit). |
| 8 | OpenHands "previously OpenDevin" | Drop ou citer primary source ; le rename historique est vrai mais pas confirmable depuis le GitHub README fetch d'Agent C |

### Items verifies (30)

**Core coding agents** : Claude Code (tous flags confirmes), Cursor (.cursorrules confirmes, Background Agents confirmes, YOLO mode confirme), Devin (human-loop confirm), GitHub Copilot (.github/copilot-instructions.md confirmee), SWE-agent Princeton (distinct de Devin), OpenHands (MIT), Aider (/architect, /ask, --auto-lint, --auto-test, --weak-model tous confirmes), Cline (.clinerules dir confirmee), Continue (existe, config deprecated).

**Agent frameworks** : AutoGen (confirme mais maintenance), CrewAI, LangGraph (`interrupt()` HITL confirmee), OpenAI Swarm (confirme mais experimental), LiteLLM (router + guardrails + cost tracking explicites), Langfuse (tracing uniquement).

**Sandbox** : E2B (Firecracker microVMs), Sculptor (Imbue) confirme mais pas "Dagger for Cursor".

**Context files** : **AGENTS.md** (verifie comme emerging community standard, stewarded by Agentic AI Foundation under Linux Foundation, 20k+ repos adopters, backed by OpenAI Codex, Cursor, Google Jules, Factory). Reviewer B avait flag ceci, Agent C confirme.

**Review tools** : CodeRabbit, Qodo Merge (commercial) distinct de PR-Agent (legacy), Sourcegraph Cody, Tabnine.

**Security** : Socket (slopsquatting detection confirmee), Snyk, pip-audit.

**Spec/planning** : Amazon Kiro (AWS agentic IDE spec-driven, confirmed), GitHub Spec-Kit (github/spec-kit, uses constitution.md).

**Observability** : GlitchTip (Sentry-compatible), Sentry, OpenTelemetry.

**Benchmarks** : SWE-bench Verified (collaboration OpenAI+Princeton, pas "OpenAI's version"), Multi-SWE-bench (7 languages, NeurIPS 2025).

**References academiques** : Parasuraman Sheridan Wickens 2000 (IEEE Xplore DOI 10.1109/3468.844354), Sheridan & Verplank 1978 (MIT Man-Machine Systems Lab, NASA NTRS 19790007441), Bainbridge 1983 "Ironies of Automation" (Automatica 19(6), DOI 10.1016/0005-1098(83)90046-8, Wikipedia + sciencedirect), Forsgren et al. 2021 SPACE (ACM Queue 19(1), DOI 10.1145/3454122.3454124).

## Resultats agreges

- **Accord brut sur les decisions retenues (union des listes)** : 11/17 en accord total + 6 divergences tranchees = **reconciliation complete**
- **Fabrications detectees par Agent C** : **1** (A : "Dagger for Cursor")
- **Corrections factuelles** : **8** (appliquees au livrable final)
- **Items verifies correctement** : **30/36** (83.3%)
- **Items avec nuances/erreurs mineures** : **6/36** (16.7%)

Le protocole double extraction + Agent C a **de nouveau** detecte une fabrication avant qu'elle n'entre dans le livrable. Le pattern est coherent avec Phase 1.1 (5 fabrications chez A) et Phase 1.2 (1 fabrication chez B) : les deux reviewers fabriquent occasionnellement, et le troisieme verifieur attrape ces erreurs. Le protocole est robuste **parce que** il assume la faillibilite des agents.

## Journal de decisions

| # | Date | Decision | Justification | Decideur |
|---|------|----------|---------------|----------|
| 1 | 2026-04-15 | Split #1 en autonomy granularity + task-type routing (A's split) | 2 axes orthogonaux ; couvre aussi B's generative/modification comme sous-cas | Superviseur |
| 2 | 2026-04-15 | Writer/reviewer → multi-agent topology (B's merge) | Architecturalement un multi-agent pattern, pas un gate | Superviseur |
| 3 | 2026-04-15 | Context split en 2 PICOCs (B's split) | Alternatives distinctes : compaction vs project instructions | Superviseur |
| 4 | 2026-04-15 | Ajouter Prompt/spec discipline (A) | Distinct de TDD, anchor KA 4 §5.1 | Retenu A |
| 5 | 2026-04-15 | Ajouter TDD agent loop (B) | Pattern specifique, anchor KA 5 §7.1 | Retenu B |
| 6 | 2026-04-15 | Ajouter Provenance/audit trail (B) | Anchor direct ISO 42001 §7.5/§8 | Retenu B |
| 7 | 2026-04-15 | Merge Cost/latency budget (A) + Budget caps (B) | Meme decision | Superviseur |
| 8 | 2026-04-15 | Drop "Dagger for Cursor" | Fabrication A detectee par C | Agent C |
| 9 | 2026-04-15 | 8 corrections factuelles appliquees | Verification Agent C | Agent C |

## Limites documentees

1. **Enumeration C alternatives incomplete** : certaines PICOCs ont 3-4 alternatives concretes mais le veritable espace d'alternatives peut contenir des outils emergents non couverts par les reviewers. A reverifier en Phase 2.1 lors de la search systematique par PICOC.

2. **Task-type taxonomy limitee** : PICOC #2 task-type routing utilise une taxonomie provisoire (new feature / bugfix / refactor / test / docs / infra). Une taxonomie formelle pourrait etre derivee de SWEBOK v4 KA 4 (Software Construction activities) en Phase 2. A noter comme refinement possible.

3. **Evidence base "AI for SE"** : plusieurs PICOCs s'appuient sur des etudes tres recentes (2024-2026) avec peu de replication. Impact probable sur Phase 2.3 (study quality assessment) : beaucoup de sources recentes auront un score de qualite modere par defaut. A anticiper.

4. **Bainbridge 1983 anchoring** : PICOC #14 (situational awareness) s'appuie sur Bainbridge via KA 9 risk management. L'anchor direct sur Bainbridge n'est pas un SWEBOK/ISO mais un papier de reference ancien. Accepter cette justification oblique.

5. **Items SWEBOK KAs 10/11/12** non retenus en Phase 1.2 : aucune des 17 PICOCs finales n'a fait emerger un besoin de ces KAs. Confirmation que Phase 1.2 NOT_RETAINED etait correct.

## Livrable final

Fichier PICOC reconcilie : `verification/picoc/ai-collaboration-picoc.md` (17 decisions avec format PICOC complet, alternatives C concretes verifiees, anchors Phase 1.2).

## Prochaine etape

**Phase 1.4** — Review protocol (inherit methodology.md + document amendments) puis **Phase 1.5** — Peer review du protocole + pilotage sur 3-5 PICOCs representatives avant Phase 2.
