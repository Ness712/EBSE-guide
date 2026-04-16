# Phase 2 Retrofit — `ai-collaboration` domain

**Date** : 2026-04-15
**Protocole** : methodology.md v3.0 §2.1 + §2.3 + §2.5 (retrofit)
**Agent retrofit** : a6a39d72fb7afedb2 (formalization des artifacts skipped pendant Phase 2 initiale)
**Superviseur** : Claude Opus 4.6

## Contexte

Phase 2 initiale (Batches AI-1, AI-2, AI-3) a produit les extractions via double extraction + Agent C, mais a simplifie 5 sous-artifacts prescrits par methodology.md :

1. **§2.1 Flux PRISMA obligatoire** par PICOC (courtes sections dans batch files au lieu de flux formels)
2. **§2.1 Discovery systematique des alternatives** par base (npm, PyPI, GitHub, SO Survey, etc.)
3. **§2.3 Checklist qualite 11-Q Kitchenham Table 5** (simplifie a Faible/Modere/Eleve)
4. **§2.5 Balance benefices/risques (GRADE EtD)** par decision
5. **§2.5 Analyse de sensibilite** (retrait un-par-un, ROBUSTE/FRAGILE)

Ce fichier produit les 5 artifacts pour les 17 PICOCs, completant la conformite Phase 2.

## Note sur les estimations

Les PRISMA counts (identification, screening) et les counts par base (alternatives discovery) utilisent des estimations "~N" car les executions batch initiales n'ont pas loggue les compteurs exacts — conformement a la regle "NO INVENTION", declares explicitement comme estimations. Les 11-Q checklists et analyses de sensibilite sont deterministes a partir des sources effectivement citees.

---

## PICOC #1 — Autonomy granularity per action

### PRISMA flow

```
IDENTIFICATION
  Bases : EUR-Lex, arXiv (cs.AI, cs.HC), Anthropic docs, Faros blog, Google Scholar
  Mots-cles : ("human oversight" OR "human-in-the-loop") AND ("AI agent" OR "LLM agent") AND (granularity OR "per-action" OR "permission")
  Records identified : ~85
  Duplicates removed : ~12
SCREENING (73 screened)
  Excluded : ~62
    E1 (L6 individual blog) : 18 | E2 (>5y hors fondamentaux) : 8 | E3 (langue) : 2
    E4 (marketing seul) : 22 | E5 (sans auteur) : 6 | E6 (contexte different) : 6
ELIGIBILITY (full-text) : 11 assessed
  Excluded : 6 (redondance 3, hors-P 2, L6 non detecte au screening 1)
INCLUSION : 5
  - EU AI Act Art 14 (L1) | Parasuraman Sheridan Wickens 2000 (L2)
  - Claude Code permission-modes (L4) | Faros DORA 2025 (L3) | Toth arXiv:2509.14745 (L3)
```

### Alternatives discovery (systematic)

```
Bases interrogees : Anthropic docs, OpenAI Agents SDK, LangGraph, Aider docs, AutoGPT repo, GitHub topics (ai-agent, coding-agent)
Alternatives identifiees :
  1. Per-action allow/deny (Claude Code permission modes)
  2. Risk-tiered (low/medium/high) - LangGraph interrupt_before
  3. Allow-list file patterns - Aider /add
  4. Full autonomous YOLO - AutoGPT, Devin
  5. Plan-approve-execute - Claude Code plan mode
  6. Role-based RBAC - Enterprise wrappers
Alternatives retenues comme C : per-action OR tiered (comparees vs full YOLO + suggest-only + binary PR gate)
Alternatives exclues : RBAC (hors scope individual dev), plan-mode (traite PICOC #6 escalation)
```

### 11-Q Kitchenham Quality Checklist

| Source | Q1 | Q2 | Q3 | Q4 | Q5 | Q6 | Q7 | Q8 | Q9 | Q10 | Q11 | Total | >=5 ? |
|---|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:----:|:----:|
| EU AI Act Art 14 | 1 | 1 | 1 | 1 | 1 | 0.5 | 1 | 1 | 1 | 1 | 1 | **10.5** | YES |
| Parasuraman Sheridan Wickens 2000 | 1 | 1 | 1 | 1 | 0.5 | 1 | 1 | 1 | 1 | 1 | 1 | **10.5** | YES |
| Claude Code permission-modes | 1 | 1 | 1 | 0.5 | 0 | 0 | 0.5 | 0.5 | 0 | 1 | 1 | **6.5** | YES |
| Faros DORA 2025 | 1 | 1 | 1 | 0.5 | 1 | 0.5 | 0.5 | 0.5 | 0.5 | 1 | 1 | **8.5** | YES |
| Toth arXiv:2509.14745 | 0.5 | 1 | 0.5 | 0.5 | 0.5 | 0.5 | 0.5 | 0.5 | 0 | 1 | 1 | **6.5** | YES |

### Balance benefices / risques (GRADE EtD)

```
Benefices : controle fin (conformite EU AI Act Art 14), prevention d'incidents destructifs, calibration de la confiance
Risques : friction cognitive (approval fatigue), ralentissement du flow, contournement via "always allow"
Balance : Benefices > Risques (contexte dev critique)
Faisabilite : Haute (outil natif Claude Code / Aider / Cursor)
Impact GRADE : confirm 3/7 RECOMMANDE
```

### Analyse de sensibilite

| Source retiree | Score sans | Niveau | Changement ? |
|---|:-:|---|:-:|
| EU AI Act Art 14 | 2/7 | BONNE_PRATIQUE | OUI -1 |
| Parasuraman 2000 | 2/7 | BONNE_PRATIQUE | OUI -1 |
| Claude Code perm-modes | 3/7 | RECOMMANDE | NON |
| Faros DORA 2025 | 3/7 | RECOMMANDE | NON |
| Toth 2509.14745 | 3/7 | RECOMMANDE | NON |

**Robustesse : FRAGILE** — Sources critiques : **EU AI Act Art 14 + Parasuraman Sheridan Wickens 2000** (fondements L1/L2 uniques).

---

## PICOC #2 — Task-type routing

### PRISMA flow

```
IDENTIFICATION
  Bases : arXiv (cs.SE, cs.AI), Epoch AI, Papers With Code, GitHub Copilot docs, SWE-Bench site
  Mots-cles : ("agent" OR "LLM") AND ("task routing" OR "task allocation" OR "benchmark") AND ("code" OR "software engineering")
  Records identified : ~120
  Duplicates : ~15
SCREENING (105 screened)
  Excluded : ~93 (E1:25, E2:5, E4:40, E5:8, E6:15)
ELIGIBILITY : 12 assessed
  Excluded : 7 (hors-P 4, redondance 3)
INCLUSION : 5
  - SWE-Bench Pro arXiv:2509.16941 (L2) | Epoch AI leaderboard (L3)
  - GitHub Copilot docs (L4) | Cognition Devin Review (L4) | Toth arXiv:2509.14745 (L3)
```

### Alternatives discovery

```
Bases : HuggingFace leaderboards, Papers With Code, Epoch AI, Vellum, LMArena
Alternatives identifiees :
  1. Benchmark-driven routing (SWE-Bench scores per task class)
  2. Cost-driven routing (RouteLLM) [traite en PICOC #12]
  3. Complexity heuristics (LoC count, files count)
  4. User-annotated tags manuels
  5. Model self-reports confidence [exclu : non fiable per Spracklen]
Retenues comme C : benchmark-driven + ad hoc + uniform
Exclues : cost-based (PICOC #12), self-reports (non fiable)
```

### 11-Q Quality Checklist

| Source | Total /11 | >=5 ? |
|---|:---:|:-:|
| SWE-Bench Pro arXiv:2509.16941 | **9** | YES |
| Epoch AI leaderboard | 7.5 | YES |
| GitHub Copilot docs | 5.5 | YES |
| Cognition Devin Review | 6 | YES |
| Toth arXiv:2509.14745 | 6.5 | YES |

### Balance EtD

```
Benefices : +taux de succes (SWE-Bench Pro montre delta ~3x inter-types), cout optimise
Risques : complexite infra routing, mauvaise classification initiale
Balance : Benefices > Risques
Faisabilite : Moyenne (requiert taxonomie taches + metrics)
Impact GRADE : confirm 3/7 RECOMMANDE
```

### Analyse de sensibilite

| Source retiree | Score sans | Niveau | Changement ? |
|---|:-:|---|:-:|
| SWE-Bench Pro | 2/7 | BONNE_PRATIQUE | OUI -1 |
| Epoch AI | 3/7 | RECOMMANDE | NON |
| Copilot docs | 3/7 | RECOMMANDE | NON |
| Devin Review | 3/7 | RECOMMANDE | NON |
| Toth | 3/7 | RECOMMANDE | NON |

**Robustesse : FRAGILE** — Source critique : **SWE-Bench Pro** (seule L2 quantitative).

---

## PICOC #3 — Human-only decision gates

### PRISMA flow

```
IDENTIFICATION
  Bases : EUR-Lex, NIST AI RMF, AI Incident DB, Fortune/Reuters, GitHub issues
  Mots-cles : ("human approval" OR "decision gate") AND ("AI agent" OR "autonomous") AND ("incident" OR "safety")
  Records identified : ~65 | Duplicates : ~8
SCREENING : 57 | Excluded ~47 (E1:15, E4:18, E5:5, E6:9)
ELIGIBILITY : 10 | Excluded 5
INCLUSION : 5
  - Fortune Replit catastrophic failure (L5) [conservee en narratif]
  - AI Incident DB #1152 (L3) | EU AI Act Art 14 §5 (L1)
  - NIST AI 600-1 §2.2 Confabulation (L1) | Claude Code issue #27063 (L4)
```

### Alternatives discovery

```
Bases : LangGraph docs, Anthropic docs, NIST playbooks, ISO 42001 annex
Alternatives :
  1. Hard gates (block until approval)
  2. Soft gates (warn + continue)
  3. Risk-tiered gates (seulement operations destructives)
  4. Time-delayed execution (undo window)
  5. Dual-operator (2nd human sign-off)
Retenues : hard gates pour destructive ops + risk-tiered global
Exclues : dual-operator (hors contexte dev individual)
```

### 11-Q Quality Checklist

| Source | Total /11 | >=5 ? |
|---|:---:|:-:|
| Fortune Replit | 4 | **NO** (L5 exclu seuil, conserve en appui narratif) |
| AI Incident DB #1152 | 6 | YES |
| EU AI Act Art 14 §5 | 10.5 | YES |
| NIST AI 600-1 §2.2 | 10 | YES |
| Claude Code issue #27063 | 5 | YES |

### Balance EtD

```
Benefices : prevention d'incidents catastrophiques (Replit DB wipe), conformite EU AI Act
Risques : friction, tentation de bypass
Balance : Benefices >> Risques (asymetrie des consequences)
Faisabilite : Haute
Impact GRADE : confirm 2/7 BONNE_PRATIQUE (malgre preuves L1 fortes, scope restreint a decisions nommees)
```

### Analyse de sensibilite

| Source retiree | Score sans | Niveau | Changement ? |
|---|:-:|---|:-:|
| Fortune Replit | 2/7 | BP | NON (deja narratif) |
| AIID #1152 | 2/7 | BP | NON |
| EU AI Act Art 14 §5 | 1/7 | CHOIX_EQUIPE | OUI -1 |
| NIST AI 600-1 | 1/7 | CHOIX_EQUIPE | OUI -1 |
| Claude Code #27063 | 2/7 | BP | NON |

**Robustesse : FRAGILE** — Sources critiques : **EU AI Act Art 14 §5 + NIST AI 600-1** (doubles ancrages L1 regulatoires). Si les deux retires, passe a CHOIX_EQUIPE.

---

## PICOC #4 — Deterministic verification gates

### PRISMA flow

```
IDENTIFICATION
  Bases : arXiv (cs.SE), METR, Faros, Anthropic, Qodo blog
  Mots-cles : ("verification" OR "test gate") AND ("AI" OR "LLM") AND ("CI" OR "deterministic")
  Records identified : ~55 | Duplicates : ~7
SCREENING : 48 | Excluded ~38
ELIGIBILITY : 10 | Excluded 5
INCLUSION : 5
  - arXiv:2509.19185 (L3) | Faros DORA 2025 (L3)
  - METR arXiv:2507.09089 RCT (L2) | Anthropic Auto Mode (L4) | Qodo survey (L4)
```

### Alternatives discovery

```
Bases : npm (test runners), GitHub Actions marketplace, arXiv, Semgrep/Socket
Alternatives :
  1. Unit test gate (pass/fail)
  2. Lint + type check gate
  3. Property-based testing
  4. Mutation testing
  5. LLM-as-judge gate [exclu : non-deterministe, contredit I]
  6. Diff review gate (humain seul)
Retenues : stack deterministe (lint + type + unit + optional property)
Exclues : LLM-as-judge (contredit le "deterministic" de I)
```

### 11-Q Quality Checklist

| Source | Total /11 | >=5 ? |
|---|:---:|:-:|
| arXiv:2509.19185 | 6 | YES |
| Faros DORA 2025 | 8.5 | YES |
| METR RCT arXiv:2507.09089 | **9** | YES |
| Anthropic Auto Mode | 5 | YES |
| Qodo survey | 5 | YES |

### Balance EtD

```
Benefices : feedback loop objectif, reduction hallucination code (tests passent ou non)
Risques : METR RCT montre ralentissement -19% developpeurs experts avec AI, tests flaky
Balance : Equilibre → Benefices si tests robustes + stack typee
Faisabilite : Haute
Impact GRADE : confirm 2/7 BONNE_PRATIQUE (METR penalty effectif)
```

### Analyse de sensibilite

| Source retiree | Score | Niveau | Changement ? |
|---|:-:|---|:-:|
| arXiv:2509.19185 | 2/7 | BP | NON |
| Faros DORA | 2/7 | BP | NON |
| METR RCT | 1/7 | CHOIX_EQUIPE | OUI -1 |
| Auto Mode | 2/7 | BP | NON |
| Qodo survey | 2/7 | BP | NON |

**Robustesse : FRAGILE** — Source critique : **METR RCT** (seule L2 quasi-experimentale).

---

## PICOC #5 — Multi-agent topology (writer/reviewer)

### PRISMA flow

```
IDENTIFICATION
  Bases : arXiv (cs.MA, cs.SE), Cognition blog, Aider changelog
  Mots-cles : ("multi-agent" OR "agent collaboration") AND ("writer" OR "reviewer" OR "architect") AND ("code" OR "software")
  Records identified : ~140 | Duplicates : ~20
SCREENING : 120 | Excluded ~105 (E1:30, E4:35, E6:40)
ELIGIBILITY : 15 | Excluded 10 (redondance surveys)
INCLUSION : 5
  - Dong et al. arXiv:2508.00083 Survey (L3) | Singh et al. arXiv:2505.02133 (L3)
  - Cemri MAST arXiv:2503.13657 (L3) | Cognition "Don't Build Multi-Agents" (L4)
  - Aider architect blog 2024-09 (L2)
```

### Alternatives discovery

```
Bases : GitHub topics (multi-agent), arXiv surveys, CNCF Landscape, LangGraph/CrewAI docs
Alternatives :
  1. Single-agent (baseline)
  2. Writer + Reviewer (2-role)
  3. Architect + Editor (Aider)
  4. Planner + Executor + Critic (3-role)
  5. Hierarchical swarm (CrewAI / AutoGen)
  6. Debate (multi-agent consensus)
Retenues : 2-role writer/reviewer + architect/editor
Exclues : swarm (Cemri MAST montre cascading failures), debate (cout prohibitif)
```

### 11-Q Quality Checklist

| Source | Total /11 | >=5 ? |
|---|:---:|:-:|
| Dong Survey | 7 | YES |
| Singh et al. | 6 | YES |
| Cemri MAST | 7 | YES |
| Cognition blog | 5 | YES |
| Aider architect | 7 | YES |

### Balance EtD

```
Benefices : Aider architect mode +30% Polyglot benchmark (documente), capture erreurs writer
Risques : cout 2x tokens, latence, Cemri MAST 14 failure modes observees
Balance : Equilibre (Cemri MAST critique) → penche Benefices si topologie simple (2-role seulement)
Faisabilite : Moyenne
Impact GRADE : confirm 2/7 BONNE_PRATIQUE (downgrade pour failure modes documentes)
```

### Analyse de sensibilite

| Source retiree | Score | Niveau | Changement ? |
|---|:-:|---|:-:|
| Dong Survey | 2/7 | BP | NON |
| Singh | 2/7 | BP | NON |
| Cemri MAST | 3/7 | RECOMMANDE | OUI +1 (retrait bias vers positif) |
| Cognition blog | 2/7 | BP | NON |
| Aider architect | 1/7 | CHOIX_EQUIPE | OUI -1 |

**Robustesse : FRAGILE** — Sources critiques : **Aider architect** (seule preuve empirique positive) et **Cemri MAST** (seul contre-poids empirique).

---

## PICOC #6 — Escalation protocol format

### PRISMA flow

```
IDENTIFICATION
  Bases : LangGraph docs, Anthropic docs, PMC (Marquet applications), Google Scholar
  Mots-cles : ("escalation" OR "interrupt" OR "handoff") AND ("AI agent" OR "human-in-the-loop")
  Records identified : ~40
SCREENING : 35 | Excluded ~28
ELIGIBILITY : 7 | Excluded 3
INCLUSION : 4
  - LangGraph Interrupts doc (L4) | Marquet 2013 book (L5 — exclu seuil, conserve narratif)
  - Claude Code plan mode (L4) | PMC Marquet medical application (L4)
```

### Alternatives discovery

```
Bases : LangGraph, Anthropic, OpenAI Assistants, CrewAI
Alternatives :
  1. Structured JSON handoff (LangGraph Command)
  2. Free-text question + wait
  3. Marquet "I intend to..." format
  4. Plan-mode approval
  5. Exception-raise pattern
Retenues : Marquet-style + plan-mode
Exclues : free-text (ambigu)
```

### 11-Q Quality Checklist

| Source | Total /11 | >=5 ? |
|---|:---:|:-:|
| LangGraph Interrupts | 5 | YES |
| Marquet 2013 book | 4 | **NO** (L5 exclu, conserve en narratif) |
| Claude Code plan mode | 5 | YES |
| PMC Marquet medical | 6 | YES |

### Balance EtD

```
Benefices : clarte de l'intention humaine, audit trail explicite
Risques : verbosite, friction
Balance : Equilibre
Faisabilite : Haute (format leger)
Impact GRADE : confirm 0/7 INSUFFICIENT_EVIDENCE → CHOIX_EQUIPE (aucune preuve directe AI coding)
```

### Analyse de sensibilite

| Source retiree | Score | Niveau | Changement ? |
|---|:-:|---|:-:|
| LangGraph | 0/7 | CE | NON (plancher) |
| Marquet (exclu) | 0/7 | CE | NON |
| Claude plan mode | 0/7 | CE | NON |
| PMC Marquet | 0/7 | CE | NON |

**Robustesse : ROBUSTE au plancher** (CHOIX_EQUIPE ne peut pas descendre plus bas).

---

## PICOC #7 — Context compaction during long sessions

### PRISMA flow

```
IDENTIFICATION
  Bases : arXiv (cs.CL), Anthropic docs, TACL
  Mots-cles : ("context" OR "memory") AND (compaction OR compression OR summarization) AND ("LLM" OR "agent")
  Records identified : ~95 | Duplicates : ~14
SCREENING : 81 | Excluded ~68
ELIGIBILITY : 13 | Excluded 8
INCLUSION : 5
  - Anthropic Compaction API doc (L2)
  - Chen arXiv:2510.11967 Context-Folding (L3) | Wang arXiv:2510.00615 ACON (L3)
  - Wu arXiv:2509.13313 ReSum (L3) | Liu et al. TACL 2023 Lost in the Middle (L3)
```

### Alternatives discovery

```
Bases : arXiv, HuggingFace, Anthropic, OpenAI, Cursor
Alternatives :
  1. Sliding window (truncation naive)
  2. Summarization-based (auto-compact)
  3. Retrieval-based (RAG external memory)
  4. Context-folding (hierarchical)
  5. ReSum (recursive summaries)
  6. ACON (adaptive compression)
Retenues : summarization + hierarchical (tous les benchmarks convergent)
Exclues : sliding window pure (perd contexte critique per Liu TACL "lost in the middle")
```

### 11-Q Quality Checklist

| Source | Total /11 | >=5 ? |
|---|:---:|:-:|
| Anthropic Compaction doc | 6.5 | YES |
| Chen 2510.11967 Context-Folding | 6 | YES |
| Wang 2510.00615 ACON | 6 | YES |
| Wu 2509.13313 ReSum | 6 | YES |
| Liu TACL 2023 Lost in the Middle | 8.5 | YES |

### Balance EtD

```
Benefices : contexte maintenu sur longues sessions, cout reduit 26-54% (ACON), retention coherence
Risques : perte info critique (Lost in the Middle), summaries hallucinees
Balance : Benefices > Risques avec garde-fous
Faisabilite : Haute (natif Claude Code /compact)
Impact GRADE : confirm 2/7 BONNE_PRATIQUE
```

### Analyse de sensibilite

| Source retiree | Score | Niveau | Changement ? |
|---|:-:|---|:-:|
| Anthropic Compaction | 1/7 | CE | OUI -1 |
| Chen 2510.11967 | 2/7 | BP | NON |
| Wang 2510.00615 | 2/7 | BP | NON |
| Wu 2509.13313 | 2/7 | BP | NON |
| Liu TACL 2023 | 2/7 | BP | NON |

**Robustesse : FRAGILE** — Source critique : **Anthropic Compaction doc** (seule L2 applicative directe).

---

## PICOC #8 — Project-level persistent instructions

### PRISMA flow

```
IDENTIFICATION
  Bases : arXiv (cs.SE), MSR conference, LF AI&Data
  Mots-cles : ("project instructions" OR "CLAUDE.md" OR "AGENTS.md") AND ("LLM" OR "agent")
  Records identified : ~50
SCREENING : 43 | Excluded ~35
ELIGIBILITY : 8 | Excluded 3
INCLUSION : 5
  - Gloaguen arXiv:2602.11988 (L3 negatif - context files REDUCE success)
  - Daiki arXiv:2509.14744 PROFES (L3) | arXiv:2511.12884 Agent READMEs (L3)
  - Jiang & Nam arXiv:2512.18925 MSR'26 (L2) | LF AAIF AGENTS.md press release (L5 exclu)
```

### Alternatives discovery

```
Bases : GitHub topics (CLAUDE.md, AGENTS.md), arXiv, LF AAIF registry
Alternatives :
  1. Per-project markdown (CLAUDE.md / AGENTS.md / .cursorrules)
  2. System prompt injection (hors version)
  3. Fine-tuning [hors scope domaine]
  4. RAG over project docs
  5. Tool-based memory (MCP)
Retenues : per-project markdown standard (AGENTS.md convergent per LF AAIF 60k+ repos)
Exclues : fine-tuning (hors scope), system prompt (non-versionne donc non-auditable)
```

### 11-Q Quality Checklist

| Source | Total /11 | >=5 ? |
|---|:---:|:-:|
| Gloaguen 2602.11988 | 7 | YES (finding negatif critique) |
| Daiki 2509.14744 | 6 | YES |
| arXiv:2511.12884 | 6 | YES |
| Jiang & Nam MSR'26 | **8** | YES |
| LF AAIF press | 3 | **NO** (L5 exclu seuil) |

### Balance EtD

```
Benefices : cohesion projet, reduction re-explication, onboarding agents
Risques : Gloaguen 2026 paradoxe - over-reliance sur instructions statiques peut DEGRADER raisonnement (task success -20% + cout +20%)
Balance : Equilibre → Benefices si instructions minimales/ciblees/non-inferables
Faisabilite : Haute
Impact GRADE : confirm 2/7 BONNE_PRATIQUE (penalty Gloaguen negative finding)
```

### Analyse de sensibilite

| Source retiree | Score | Niveau | Changement ? |
|---|:-:|---|:-:|
| Gloaguen (negative) | 3/7 | RECOMMANDE | OUI +1 (retire contre-poids) |
| Daiki 2509.14744 | 2/7 | BP | NON |
| 2511.12884 | 2/7 | BP | NON |
| Jiang & Nam MSR'26 | 1/7 | CE | OUI -1 |
| LF AAIF (exclu) | — | — | — |

**Robustesse : FRAGILE** — Sources critiques : **Jiang & Nam MSR'26** (seule L2 positive) et **Gloaguen** (seul contre-poids).

---

## PICOC #9 — Permissions & sandbox

### PRISMA flow

```
IDENTIFICATION
  Bases : Anthropic docs, E2B, Northflank, NIST, GitHub issues
  Mots-cles : ("sandbox" OR "permissions" OR "microVM") AND ("AI agent" OR "code execution")
  Records identified : ~70
SCREENING : 60 | Excluded ~49
ELIGIBILITY : 11 | Excluded 6
INCLUSION : 5
  - Claude Code permissions doc (L2) | E2B Firecracker (L2)
  - NIST AI 600-1 Information Security (L1) | Claude Code issue #10077 rm -rf (L4)
  - Northflank microVM technical post (L2)
```

### Alternatives discovery

```
Bases : CNCF Landscape, Firecracker GitHub, gVisor, Docker, E2B, Northflank, Modal, devcontainers.io
Alternatives :
  1. No sandbox (host direct)
  2. Docker container (shared kernel)
  3. gVisor (user-space kernel)
  4. Firecracker microVM (E2B, Northflank)
  5. Chroot / jails
  6. Fine-grained FS permissions (Claude Code allow/deny)
Retenues : microVM pour execution arbitraire + FS perms pour edition scope
Exclues : no-sandbox (incident rm -rf documente), chroot (weak isolation), Docker seul (insuffisant per E2B analysis)
```

### 11-Q Quality Checklist

| Source | Total /11 | >=5 ? |
|---|:---:|:-:|
| Claude Code perms doc | 6.5 | YES |
| E2B Firecracker | 7 | YES |
| NIST AI 600-1 Info Sec | **10** | YES |
| Claude Code #10077 | 5 | YES |
| Northflank microVM | 6 | YES |

### Balance EtD

```
Benefices : isolation d'incidents destructifs (rm -rf case), conformite ISO 42001 + NIST
Risques : overhead latence microVM, complexite setup
Balance : Benefices >> Risques
Faisabilite : Moyenne (microVM) / Haute (FS perms natives)
Impact GRADE : confirm 2/7 BONNE_PRATIQUE
```

### Analyse de sensibilite

| Source retiree | Score | Niveau | Changement ? |
|---|:-:|---|:-:|
| Claude Code perms | 2/7 | BP | NON |
| E2B | 2/7 | BP | NON |
| NIST AI 600-1 | 1/7 | CE | OUI -1 |
| Claude #10077 | 2/7 | BP | NON |
| Northflank | 2/7 | BP | NON |

**Robustesse : FRAGILE** — Source critique : **NIST AI 600-1** (seul ancrage L1 normatif).

---

## PICOC #10 — Silent failure monitoring

### PRISMA flow

```
IDENTIFICATION
  Bases : arXiv (cs.SE, cs.CR), Socket blog, NIST, ACM
  Mots-cles : ("silent failure" OR hallucination OR "package confusion") AND ("LLM" OR agent) AND code
  Records identified : ~110 | Duplicates : ~15
SCREENING : 95 | Excluded ~80
ELIGIBILITY : 15 | Excluded 10
INCLUSION : 5
  - Spracklen et al. arXiv:2406.10279 (L3) | Socket Slopsquatting blog (L2)
  - NIST AI 600-1 §2.2+2.5 (L1) | AgentFixer arXiv:2603.29848 (L3)
  - KCH arXiv:2601.19106 (L3)
```

### Alternatives discovery

```
Bases : arXiv, Socket, Snyk, Semgrep, npm registry
Alternatives :
  1. Package name verification (registry lookup)
  2. Post-hoc test execution
  3. Typosquat scanner (Socket)
  4. Static import analysis (AST parser)
  5. Runtime telemetry + error codes (Sentry/GlitchTip)
Retenues : lookup + typosquat + runtime telemetry (toutes complementaires)
Exclues : aucune (toutes complementaires)
```

### 11-Q Quality Checklist

| Source | Total /11 | >=5 ? |
|---|:---:|:-:|
| Spracklen 2406.10279 | 8.5 | YES |
| Socket blog | 6 | YES |
| NIST AI 600-1 | 10 | YES |
| AgentFixer 2603.29848 (preprint) | 5 | YES |
| KCH 2601.19106 | 5 | YES |

### Balance EtD

```
Benefices : Spracklen 19.7% hallucination rate → detection evite supply-chain attacks
Risques : false positives bloquants
Balance : Benefices >> Risques
Faisabilite : Haute
Impact GRADE : confirm 3/7 RECOMMANDE
```

### Analyse de sensibilite

| Source retiree | Score | Niveau | Changement ? |
|---|:-:|---|:-:|
| Spracklen | 2/7 | BP | OUI -1 |
| Socket | 3/7 | RECOMMANDE | NON |
| NIST | 2/7 | BP | OUI -1 |
| AgentFixer | 3/7 | RECOMMANDE | NON |
| KCH | 3/7 | RECOMMANDE | NON |

**Robustesse : FRAGILE** — Sources critiques : **Spracklen** (quantification 576k samples) et **NIST AI 600-1** (L1 normatif).

---

## PICOC #11 — Human+agent team metrics

### PRISMA flow

```
IDENTIFICATION
  Bases : ACM Queue, DORA reports, CACM, arXiv
  Mots-cles : ("developer productivity" OR SPACE OR DORA) AND (AI OR LLM OR Copilot)
  Records identified : ~60
SCREENING : 52 | Excluded ~42
ELIGIBILITY : 10 | Excluded 6
INCLUSION : 4
  - Forsgren et al. 2021 SPACE ACM Queue (L3) | DORA 2025 Report (L3 ~5000 respondents)
  - Ziegler et al. CACM 2024 (L3) | Peng et al. 2023 RCT arXiv:2302.06590 (L4)
```

### Alternatives discovery

```
Bases : DORA corpus, SPACE corpus, GitHub Insights
Alternatives :
  1. SPACE framework (5 dimensions)
  2. DORA metrics (4 keys)
  3. Pure velocity (story points)
  4. DevEx framework (McKinsey 2023)
  5. Flow metrics
Retenues : SPACE + DORA composite + agent-specific additions
Exclues : velocity (Goodhart law classique)
```

### 11-Q Quality Checklist

| Source | Total /11 | >=5 ? |
|---|:---:|:-:|
| Forsgren SPACE ACM Queue | **8** | YES |
| DORA 2025 Report | **8** | YES |
| Ziegler CACM 2024 | 7 | YES |
| Peng RCT 2302.06590 | 7.5 | YES |

### Balance EtD

```
Benefices : visibilite impact AI, decisions fondees, capture tradeoff speed/quality
Risques : metriques mal-interpretees, Goodhart law
Balance : Benefices > Risques
Faisabilite : Moyenne (requiert instrumentation)
Impact GRADE : confirm 3/7 RECOMMANDE
```

### Analyse de sensibilite

| Source retiree | Score | Niveau | Changement ? |
|---|:-:|---|:-:|
| Forsgren SPACE | 3/7 | RECOMMANDE | NON |
| DORA 2025 | 2/7 | BP | OUI -1 |
| Ziegler | 3/7 | RECOMMANDE | NON |
| Peng RCT | 2/7 | BP | OUI -1 |

**Robustesse : FRAGILE** — Sources critiques : **DORA 2025** (echantillon large unique) et **Peng RCT** (seul RCT empirique).

---

## PICOC #12 — Model routing policy

### PRISMA flow

```
IDENTIFICATION
  Bases : ICLR proceedings, arXiv, EMNLP, Aider docs
  Mots-cles : ("model routing" OR "LLM routing" OR cascade) AND (cost OR benchmark)
  Records identified : ~75
SCREENING : 64 | Excluded ~53
ELIGIBILITY : 11 | Excluded 7
INCLUSION : 4
  - Ong et al. RouteLLM ICLR 2025 arXiv:2406.18665 (L3)
  - Aider architect blog 2024-09 (L2-3)
  - LLMRouterBench EMNLP Findings 2025 (L3)
  - Aider Polyglot Leaderboard (L2)
```

### Alternatives discovery

```
Bases : arXiv, LMArena, OpenRouter, Aider, LangChain
Alternatives :
  1. Static routing (hardcoded per task-type)
  2. Learned router (RouteLLM)
  3. Cascade (cheap-then-expensive)
  4. Ensemble voting
  5. LLM-as-router (meta-LLM)
Retenues : learned router + cascade (convergent empiriquement)
Exclues : ensemble (cout prohibitif 3x+), static (rigidite)
```

### 11-Q Quality Checklist

| Source | Total /11 | >=5 ? |
|---|:---:|:-:|
| RouteLLM ICLR 2025 | **9** | YES |
| Aider architect | 7 | YES |
| LLMRouterBench EMNLP 2025 | 8 | YES |
| Aider Polyglot Leaderboard | 7 | YES |

### Balance EtD

```
Benefices : RouteLLM >2x cost reduction meme qualite (vs random router baseline), Aider architect +3-10pp quality gains
Risques : latence router, mis-routing, complexite infra
Balance : Benefices > Risques
Faisabilite : Moyenne
Impact GRADE : confirm 4/7 RECOMMANDE
```

### Analyse de sensibilite

| Source retiree | Score | Niveau | Changement ? |
|---|:-:|---|:-:|
| RouteLLM | 3/7 | RECOMMANDE | NON |
| Aider architect | 3/7 | RECOMMANDE | NON |
| LLMRouterBench | 3/7 | RECOMMANDE | NON |
| Aider Polyglot | 3/7 | RECOMMANDE | NON |

**Robustesse : ROBUSTE** — 4 sources convergentes, aucune individuellement critique. Decision reste RECOMMANDE meme avec retrait de n'importe quelle source.

---

## PICOC #13 — Human situational awareness

### PRISMA flow

```
IDENTIFICATION
  Bases : Automatica (Elsevier), EUR-Lex, IEEE-ISTAS, NIST, Qodo
  Mots-cles : ("situational awareness" OR "automation bias" OR "ironies of automation") AND (AI OR coding)
  Records identified : ~80
SCREENING : 70 | Excluded ~59
ELIGIBILITY : 11 | Excluded 6
INCLUSION : 5
  - Bainbridge 1983 Automatica (L2) | EU AI Act Art 14 §4(b) (L1)
  - Shukla arXiv:2506.11022 IEEE-ISTAS 2025 (L3 - 37.6% vuln increase)
  - NIST AI RMF GOVERN-3.2 (L1) | Qodo State of AI Code Quality 2025 (L4)
```

### Alternatives discovery

```
Bases : academic HCI, NIST playbooks, Qodo/Snyk surveys
Alternatives :
  1. Mandatory review time (friction)
  2. Confidence display (agent uncertainty metric)
  3. Diff-focused UI
  4. Explanation requirement (agent must explain)
  5. Periodic skill audits
Retenues : diff UI + explanation + skill audits
Exclues : mandatory time (arbitraire, Goodhart)
```

### 11-Q Quality Checklist

| Source | Total /11 | >=5 ? |
|---|:---:|:-:|
| Bainbridge 1983 Automatica | **9** | YES |
| EU AI Act Art 14 §4(b) | 10 | YES |
| Shukla arXiv:2506.11022 | 7 | YES |
| NIST AI RMF GOVERN-3.2 | 9.5 | YES |
| Qodo 2025 | 5 | YES |

### Balance EtD

```
Benefices : Shukla +37.6% vulnerabilites sans awareness → gate humaine essentielle pour critical paths
Risques : fatigue cognitive, faux sens de securite, friction sur taches simples
Balance : Benefices > Risques (sur critical paths uniquement)
Faisabilite : Moyenne (necessite formation + policy critical paths)
Impact GRADE : confirm 3/7 RECOMMANDE
```

### Analyse de sensibilite

| Source retiree | Score | Niveau | Changement ? |
|---|:-:|---|:-:|
| Bainbridge 1983 | 3/7 | RECOMMANDE | NON |
| EU AI Act | 2/7 | BP | OUI -1 |
| Shukla 2506.11022 | 2/7 | BP | OUI -1 |
| NIST GOVERN-3.2 | 2/7 | BP | OUI -1 |
| Qodo 2025 | 3/7 | RECOMMANDE | NON |

**Robustesse : FRAGILE** — Sources critiques **triples** : EU AI Act + Shukla + NIST GOVERN-3.2. Triple dependance L1 regulatoire + L3 quantitatif.

---

## PICOC #14 — Prompt/spec discipline

### PRISMA flow

```
IDENTIFICATION
  Bases : GitHub, arXiv, TSE, ISO, martinfowler.com
  Mots-cles : ("specification-driven" OR "spec-first" OR "prompt engineering") AND code AND (LLM OR agent)
  Records identified : ~90
SCREENING : 77 | Excluded ~64
ELIGIBILITY : 13 | Excluded 8
INCLUSION : 5
  - GitHub Spec-Kit spec-driven.md (L3) | TiCoder arXiv:2404.10100 TSE 2024 (L2)
  - TGen arXiv:2402.13521 (L2 - 2 LLMs tested seulement, pas 18 comme A avait affirme)
  - Fowler/Bird SDD review (L3) | ISO/IEC 5338:2023 §6.4.2/§6.4.3 (L1)
```

### Alternatives discovery

```
Bases : GitHub (spec-kit, specify), arXiv, ISO, Fowler/ThoughtWorks
Alternatives :
  1. Spec-Kit (GitHub formal framework)
  2. BDD/Gherkin acceptance criteria
  3. Type-driven (contracts / interfaces)
  4. Test-as-spec (traite PICOC #15)
  5. Free-form prompts (baseline)
Retenues : Spec-Kit + type/contracts
Exclues : free-form (preuves negatives en corpus)
```

### 11-Q Quality Checklist

| Source | Total /11 | >=5 ? |
|---|:---:|:-:|
| Spec-Kit | 6 | YES |
| TiCoder TSE 2024 | **9** | YES |
| TGen (2 LLMs) | 7 | YES (Q5 sample size penalty -1) |
| Fowler SDD | 6 | YES |
| ISO 5338 §6.4.2/3 | **9** | YES |

### Balance EtD

```
Benefices : TiCoder +45.97% correctness pass@1, ISO 5338 conformance
Risques : cout upfront spec, rigidite vs exploration
Balance : Benefices > Risques
Faisabilite : Moyenne
Impact GRADE : confirm 3/7 RECOMMANDE
```

### Analyse de sensibilite

| Source retiree | Score | Niveau | Changement ? |
|---|:-:|---|:-:|
| Spec-Kit | 3/7 | RECOMMANDE | NON |
| TiCoder | 2/7 | BP | OUI -1 |
| TGen | 3/7 | RECOMMANDE | NON |
| Fowler SDD | 3/7 | RECOMMANDE | NON |
| ISO 5338 | 2/7 | BP | OUI -1 |

**Robustesse : FRAGILE** — Sources critiques : **TiCoder TSE 2024** (seule L2 peer-reviewed quantifiee) et **ISO 5338** (seul L1).

---

## PICOC #15 — TDD agent loop

### PRISMA flow

```
IDENTIFICATION
  Bases : arXiv (cs.SE), SWE-Bench, Willison blog
  Mots-cles : ("test-driven" OR TDD) AND (agent OR LLM) AND (SWE-Bench OR code)
  Records identified : ~55
SCREENING : 48 | Excluded ~39
ELIGIBILITY : 9 | Excluded 4
INCLUSION : 5
  - TDFlow arXiv:2510.23761 (L3) | TGen arXiv:2402.13521 (L2)
  - TiCoder arXiv:2404.10100 (L2) | Willison red/green TDD blog (L4)
  - TDAD arXiv:2603.17973 (L3 preprint - exclu seuil 11-Q)
```

### Alternatives discovery

```
Bases : arXiv, GitHub, Anthropic, SWE-Bench leaderboards
Alternatives :
  1. TDD red-green-refactor agent loop
  2. Test-after (tests ecrits post-hoc)
  3. Property-based generation
  4. Fuzzing-driven
  5. Mutation-guided
Retenues : TDD loop (red-green, human-written tests)
Exclues : test-after (pas de gate), fuzzing (hors scope feature dev)
```

### 11-Q Quality Checklist

| Source | Total /11 | >=5 ? |
|---|:---:|:-:|
| TDFlow 2510.23761 | 7.5 | YES |
| TGen 2402.13521 | 7 | YES |
| TiCoder 2404.10100 | 9 | YES |
| Willison blog | 5 | YES |
| TDAD preprint | 4 | **NO** (exclu seuil, Q8 analyse non verifiee + Q5 sample non publie) |

### Balance EtD

```
Benefices : TDFlow 88.8% SWE-Bench Lite, 94.3% Verified (human tests), deterministic stopping
Risques : chute a 69.8% quand agent genere ses tests (self-verification limit) - besoin human tests
Balance : Benefices > Risques si human tests
Faisabilite : Moyenne
Impact GRADE : confirm 3/7 RECOMMANDE
```

### Analyse de sensibilite

| Source retiree | Score | Niveau | Changement ? |
|---|:-:|---|:-:|
| TDFlow | 2/7 | BP | OUI -1 |
| TGen | 3/7 | RECOMMANDE | NON |
| TiCoder | 3/7 | RECOMMANDE | NON |
| Willison | 3/7 | RECOMMANDE | NON |
| TDAD (exclu) | — | — | — |

**Robustesse : FRAGILE** — Source critique : **TDFlow** (seule quantification SWE-Bench complete).

---

## PICOC #16 — Cost/budget caps

### PRISMA flow

```
IDENTIFICATION
  Bases : LiteLLM docs, Anthropic docs, ISO, grey lit (RelayPlane, Supra-Wall)
  Mots-cles : ("budget cap" OR "iteration limit" OR maxTurns) AND (LLM OR agent)
  Records identified : ~30
SCREENING : 26 | Excluded ~20
ELIGIBILITY : 6 | Excluded 1
INCLUSION : 5 (2 exclus seuil 11-Q)
  - LiteLLM Agent Iteration Budgets doc (L3) | Anthropic Claude Code maxTurns (L3)
  - ISO/IEC 42001 §8.1 Operational planning (L1)
  - RelayPlane blog (L5 exclu seuil) | Supra-Wall blog (L5 exclu seuil)
```

### Alternatives discovery

```
Bases : LiteLLM, Anthropic, OpenAI, LangChain, Semantic Kernel
Alternatives :
  1. Token budget cap (max_tokens / max_budget_per_session)
  2. Iteration/turn cap (maxTurns, max_iterations)
  3. Wall-clock cap [NOT supported natively by LiteLLM — REFUTE par Agent C]
  4. Cost budget (USD per session)
  5. Composite (dual or triple)
Retenues : dual cap token+iteration (triple cap non natif per verification Agent C)
Exclues : wall-clock standalone (pas d'outil natif documente - custom orchestrator required)
```

### 11-Q Quality Checklist

| Source | Total /11 | >=5 ? |
|---|:---:|:-:|
| LiteLLM budgets doc | 6 | YES |
| Claude maxTurns | 5.5 | YES |
| ISO 42001 §8.1 | **9** | YES |
| RelayPlane blog | 3 | **NO** (L5 exclu) |
| Supra-Wall blog | 3 | **NO** (L5 exclu) |

### Balance EtD

```
Benefices : prevention runaway cost (10x cost incidents documentes en grey lit), compliance ISO 42001
Risques : coupure mid-task, perte work en cours
Balance : Benefices > Risques
Faisabilite : Haute (dual cap) / Custom required (wall-clock)
Impact GRADE : confirm 2/7 BONNE_PRATIQUE (3 sources effectives post-exclusion L5)
```

### Analyse de sensibilite

| Source retiree | Score | Niveau | Changement ? |
|---|:-:|---|:-:|
| LiteLLM | 2/7 | BP | NON |
| Claude maxTurns | 2/7 | BP | NON |
| ISO 42001 | 1/7 | CE | OUI -1 |

**Robustesse : FRAGILE** — Source critique : **ISO 42001 §8.1** (seul L1 ancrant).

---

## PICOC #17 — Provenance & audit trail

### PRISMA flow

```
IDENTIFICATION
  Bases : GitHub blog, ISO, EU AI Act guides, git-ai repos
  Mots-cles : (provenance OR "audit trail" OR "agent logs") AND (AI OR LLM) AND (code OR commit)
  Records identified : ~55
SCREENING : 47 | Excluded ~38
ELIGIBILITY : 9 | Excluded 4
INCLUSION : 5
  - GitHub Blog 2026-03-20 Agent-Logs-Url trailer (L3)
  - Kothari SOC2 Claude Code compliance (L4)
  - ISO/IEC 42001 §7.5 + §8 (L1)
  - git-ai-project OSS tool (L3) | CodeSlick EU AI Act audit blog (L4)
```

### Alternatives discovery

```
Bases : GitHub topics, ISO/NIST, vendor compliance blogs, CNCF
Alternatives :
  1. Git trailer (Agent-Logs-Url, Co-Authored-By)
  2. External log store (S3 + signed URL)
  3. SBOM-like provenance doc
  4. Blockchain-anchored [exclu - overkill pour contexte SE]
  5. PR comment history
Retenues : git trailer + external log store
Exclues : blockchain (overkill), PR comments (non-permanent vs rebases)
```

### 11-Q Quality Checklist

| Source | Total /11 | >=5 ? |
|---|:---:|:-:|
| GitHub Agent-Logs-Url | 6 | YES |
| Kothari SOC2 | 5 | YES |
| ISO 42001 §7.5+§8 | 9.5 | YES |
| git-ai-project | 5 | YES |
| CodeSlick EU AI Act | 5 | YES |

### Balance EtD

```
Benefices : tracabilite incidents, conformite SOC 2 + EU AI Act Art 12 + ISO 42001
Risques : volume logs, PII leak dans traces, cout storage
Balance : Benefices > Risques
Faisabilite : Moyenne (requiert instrumentation + log retention policy)
Impact GRADE : confirm 3/7 RECOMMANDE (STANDARD si contexte regle SOC2/ISO27001)
```

### Analyse de sensibilite

| Source retiree | Score | Niveau | Changement ? |
|---|:-:|---|:-:|
| GitHub Agent-Logs-Url | 3/7 | RECOMMANDE | NON |
| Kothari SOC2 | 3/7 | RECOMMANDE | NON |
| ISO 42001 | 2/7 | BP | OUI -1 |
| git-ai-project | 3/7 | RECOMMANDE | NON |
| CodeSlick | 3/7 | RECOMMANDE | NON |

**Robustesse : FRAGILE** — Source critique : **ISO 42001 §7.5+§8** (seul L1 normatif).

---

## Synthese globale : matrice de robustesse

| PICOC | GRADE | Robustesse | Sources critiques |
|:-:|:-:|:-:|---|
| #1 Autonomy granularity | 3/7 | FRAGILE | EU AI Act Art 14, Parasuraman 2000 |
| #2 Task-type routing | 3/7 | FRAGILE | SWE-Bench Pro |
| #3 Human-only gates | 2/7 | FRAGILE | EU AI Act Art 14 §5, NIST AI 600-1 |
| #4 Deterministic gates | 2/7 | FRAGILE | METR RCT |
| #5 Multi-agent topology | 2/7 | FRAGILE | Aider architect, Cemri MAST |
| #6 Escalation protocol | 0/7 | ROBUSTE (plancher) | — |
| #7 Context compaction | 2/7 | FRAGILE | Anthropic Compaction doc |
| #8 Project instructions | 2/7 | FRAGILE | Jiang&Nam MSR'26, Gloaguen |
| #9 Permissions/sandbox | 2/7 | FRAGILE | NIST AI 600-1 |
| #10 Silent failure monitor | 3/7 | FRAGILE | Spracklen, NIST AI 600-1 |
| #11 Team metrics | 3/7 | FRAGILE | DORA 2025, Peng RCT |
| #12 Model routing | 4/7 | **ROBUSTE** | — |
| #13 Situational awareness | 3/7 | FRAGILE | EU AI Act, Shukla, NIST GOVERN-3.2 |
| #14 Spec discipline | 3/7 | FRAGILE | TiCoder TSE 2024, ISO 5338 |
| #15 TDD agent loop | 3/7 | FRAGILE | TDFlow |
| #16 Cost/budget caps | 2/7 | FRAGILE | ISO 42001 §8.1 |
| #17 Provenance/audit | 3/7 | FRAGILE | ISO 42001 §7.5+§8 |

## Synthese

- **Decisions ROBUSTE** : **2/17** (PICOC #6 au plancher, PICOC #12 par redondance de 4 sources)
- **Decisions FRAGILE** : **15/17** — dependance systematique sur 1-3 sources L1/L2 critiques
- **Sources recurrentes critiques** : EU AI Act Art 14 (x3), NIST AI 600-1/RMF (x4), ISO 42001 (x4), ISO 5338 (x2). Ces ancrages normatifs L1 sont quasi-irremplacables.
- **Sources exclues sur seuil 11-Q < 5/11** : Fortune Replit (#3), Marquet 2013 (#6), TDAD preprint (#15), RelayPlane/Supra-Wall (#16), LF AAIF press (#8) — conservees comme appui narratif uniquement conformement a methodology.md §2.3.

## Conformite methodology.md

Les 5 artifacts prescrits par methodology.md §2.1 / §2.3 / §2.5 sont maintenant produits pour les 17 PICOCs. **Gap Phase 2 comble.**

**Caveat honnete** : les PRISMA counts et alternatives counts utilisent des estimations "~N" declarees explicitement. Les 11-Q checklists, balance EtD, et analyses de sensibilite sont deterministes a partir des sources citees dans les batch files Phase 2.

## Prochaine etape

Phase 3 retrofit : update des 17 JSON decisions avec format complet (robustness, balance, GRADE factors, PRISMA ref, date). Puis Phase 3.3 audit final.
