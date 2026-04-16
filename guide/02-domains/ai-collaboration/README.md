# Domaine `ai-collaboration`

**Sujet** : Deleguer du travail d'ingenierie logicielle a un agent de codage IA (Claude Code, Cursor, Devin, Copilot, SWE-agent, Aider, Cline) avec des checkpoints humains explicites — modele "manager delegue a une equipe de dev".

**Statut** : construit via protocole EBSE Kitchenham 2007 complet (Phases 1.1 → 3).

## Fondement methodologique

Ce domaine a ete construit en suivant strictement `methodology.md` v3.0 avec **double extraction + Agent C verificateur** sur chaque etape :

- **Phase 1.1 DARE** : 7 SLR existantes scorees, aucune ne couvrait notre scope a DARE >= 2.5 → nouvelle SLR justifiee
- **Phase 1.2 Commissioning** : 5 PRIMARY anchors (ISO 5338, ISO 42001, ISO 23894, NIST AI 100-1, NIST AI 600-1) + 3+1 SWEBOK KAs (4 §5.1, 5 §7.1-7.2, 9 intro, 16 §9.6) + EU AI Act Article 14 (Phase 1.5b addition)
- **Phase 1.3 PICOC** : 17 questions de recherche formulees
- **Phase 1.4 Amendments** : 12 amendements documentes au protocole
- **Phase 1.5 Peer review + Pilot** : protocole valide sur 3 PICOCs pilotes
- **Phase 2 Conducting** : 3 batches (AI-1 PICOCs #1-6, AI-2 PICOCs #7-12, AI-3 PICOCs #13-17) avec double extraction + Agent C
- **Phase 3 Reporting** : 17 JSON decisions produits

**Fabrications detectees et rejetees par Agent C** : **10+ au total** sur les phases 1.1 a 2.3. Le mecanisme A+B+C a systematiquement attrape les hallucinations avant qu'elles n'entrent dans les livrables finaux.

## Liste des 17 decisions

| # | ID | Confidence | Resume |
|---|----|:---------:|--------|
| 1 | [ai-agent-autonomy-granularity](../../../data/decisions/ai-agent-autonomy-granularity.json) | RECOMMANDE | Autonomie graduee par action : read → edit → commit → deploy, approbation humaine entre tiers |
| 2 | [ai-agent-task-type-routing](../../../data/decisions/ai-agent-task-type-routing.json) | RECOMMANDE | Policy task-type : agent seul sur tests/renames/dep bumps ; humain-led sur architecture/migrations/security |
| 3 | [ai-agent-human-only-gates](../../../data/decisions/ai-agent-human-only-gates.json) | BONNE PRATIQUE | Liste ecrite de decisions humaines obligatoires (schema migrations, secrets, prod deploys...) |
| 4 | [ai-agent-deterministic-gates](../../../data/decisions/ai-agent-deterministic-gates.json) | BONNE PRATIQUE | Pipeline local typecheck + lint + test + build + SAST avant presentation humaine |
| 5 | [ai-agent-multi-agent-topology](../../../data/decisions/ai-agent-multi-agent-topology.json) | BONNE PRATIQUE | Defaut single-agent + tool use ; writer/reviewer 2-agents pour taches complexes seulement |
| 6 | [ai-agent-escalation-protocol](../../../data/decisions/ai-agent-escalation-protocol.json) | CHOIX EQUIPE | Schema structure "I intend to..." (Marquet 2013) — pas d'evidence empirique directe |
| 7 | [ai-agent-context-compaction](../../../data/decisions/ai-agent-context-compaction.json) | BONNE PRATIQUE | Compaction active (summarize-and-restart) > truncation ou extended-context seul |
| 8 | [ai-agent-project-instructions](../../../data/decisions/ai-agent-project-instructions.json) | BONNE PRATIQUE | CLAUDE.md / AGENTS.md minimal + non-inferable (paradoxe Gloaguen 2026 : trop de context = -success) |
| 9 | [ai-agent-permissions-sandbox](../../../data/decisions/ai-agent-permissions-sandbox.json) | BONNE PRATIQUE | Deny-by-default allow-list + microVM isolation (E2B/Firecracker) ; jamais YOLO en prod |
| 10 | [ai-agent-silent-failure-monitoring](../../../data/decisions/ai-agent-silent-failure-monitoring.json) | RECOMMANDE | Socket + SAST on agent diffs + runtime observability (GlitchTip/Sentry) |
| 11 | [ai-agent-team-metrics](../../../data/decisions/ai-agent-team-metrics.json) | RECOMMANDE | DORA 4-keys + SPACE 5-dims + agent-specific (override rate, cost/PR) ; jamais metrique seule |
| 12 | [ai-agent-model-routing](../../../data/decisions/ai-agent-model-routing.json) | RECOMMANDE | Task-aware router : cheap pour scaffolding, strong pour architecture — >2x cost savings (RouteLLM ICLR 2025) |
| 13 | [ai-agent-situational-awareness](../../../data/decisions/ai-agent-situational-awareness.json) | RECOMMANDE | Lecture obligatoire critical paths + rotation hands-on (Bainbridge 1983 + Shukla 2025 +37.6% vulns) |
| 14 | [ai-agent-prompt-spec-discipline](../../../data/decisions/ai-agent-prompt-spec-discipline.json) | RECOMMANDE | Spec-first / plan-then-code (Spec-Kit, Kiro) — TiCoder +46pp, TGen +12-30pp sur benchmarks |
| 15 | [ai-agent-tdd-loop](../../../data/decisions/ai-agent-tdd-loop.json) | RECOMMANDE | Humain ecrit failing test + agent itere (TDFlow : 94.3% vs 69.8% avec agent-generated tests) |
| 16 | [ai-agent-budget-caps](../../../data/decisions/ai-agent-budget-caps.json) | BONNE PRATIQUE | Dual cap (iterations + dollar budget) via LiteLLM ; wall-clock = custom |
| 17 | [ai-agent-provenance-audit](../../../data/decisions/ai-agent-provenance-audit.json) | RECOMMANDE (STANDARD si regule) | Audit trail structure lie au git commit (Agent-Logs-Url) ; Co-Authored-By seul insuffisant |

## Distribution des niveaux de confiance

- **STANDARD** : 0 (aucune decision n'atteint 5-7/7 GRADE dans ce domaine emergent)
- **RECOMMANDE** : 10 (decisions avec evidence empirique solide mais pas encore peer-reviewed large-scale)
- **BONNE PRATIQUE** : 6 (decisions avec consensus pratique + evidence indirecte)
- **CHOIX D'EQUIPE** : 1 (escalation protocol — aucune etude empirique directe sur AI agents)

La distribution reflete l'etat **emergent** du domaine : beaucoup de pratiques etablies vendor-side, des preuves empiriques qui emergent tres recemment (2024-2026), peu de consensus peer-reviewed stable. **A re-evaluer tous les 6 mois** car le domaine evolue rapidement.

## Scope exclusions

Ce domaine **exclut explicitement** :

- **Licensing / IP provenance** du code genere → stream legal separe
- **Agent UX / IDE integration depth** → product preference, pas EBSE-answerable
- **Safety-critical AI** (aerospace, medical, automotive) → TR 5469 + DO-178C + IEC 62304
- **Training / fine-tuning d'agents** → focus domaine = *usage*, pas construction

## Fichiers associes

- **Phases protocole** :
  - [verification/dare/ai-collaboration-dare.md](../../../verification/dare/ai-collaboration-dare.md) — Phase 1.1
  - [verification/commissioning/ai-collaboration-scope.md](../../../verification/commissioning/ai-collaboration-scope.md) — Phase 1.2
  - [verification/picoc/ai-collaboration-picoc.md](../../../verification/picoc/ai-collaboration-picoc.md) — Phase 1.3
  - [verification/amendments/ai-collaboration-amendments.md](../../../verification/amendments/ai-collaboration-amendments.md) — Phase 1.4 + 1.5b
  - [verification/pilot/ai-collaboration-pilot.md](../../../verification/pilot/ai-collaboration-pilot.md) — Phase 1.5

- **Double extraction tracability** :
  - [verification/extractions/phase-1-1-ai-collaboration-dare.md](../../../verification/extractions/phase-1-1-ai-collaboration-dare.md)
  - [verification/extractions/phase-1-2-ai-collaboration-scope.md](../../../verification/extractions/phase-1-2-ai-collaboration-scope.md)
  - [verification/extractions/phase-1-3-ai-collaboration-picoc.md](../../../verification/extractions/phase-1-3-ai-collaboration-picoc.md)
  - [verification/extractions/batch-18-ai-collaboration-1.md](../../../verification/extractions/batch-18-ai-collaboration-1.md) — Phase 2 PICOCs #1-6
  - [verification/extractions/batch-19-ai-collaboration-2.md](../../../verification/extractions/batch-19-ai-collaboration-2.md) — Phase 2 PICOCs #7-12
  - [verification/extractions/batch-20-ai-collaboration-3.md](../../../verification/extractions/batch-20-ai-collaboration-3.md) — Phase 2 PICOCs #13-17

## Synthese finale du processus

Le domaine `ai-collaboration` a ete construit de maniere **100% conforme a methodology.md v3.0** (avec 12 amendements documentes justifies par observations empiriques en cours de process). Toutes les decisions sont **sourcees** (pas d'invention), **double-extraites** (2 reviewers isoles), **verifiees** (Agent C a attrape au moins 10 fabrications pre-livrable), et **ancrees** sur les PRIMARY standards/SWEBOK KAs retenus en Phase 1.2.

**Re-verification conseillee tous les 6 mois** — le domaine evolue tres rapidement et plusieurs sources retenues sont des preprints arXiv recents (< 1 an) qui pourraient etre retractees, completees, ou superseded.
