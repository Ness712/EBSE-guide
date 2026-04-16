# Synthèse — Gap Analysis : Guide EBSE vs Délégation PO → Agent Autonome

**Date** : 2026-04-16
**Protocole** : Double extraction A+B (mots-clés différents, contexte indépendant)
**Agent A** : 19 sources, 15 dimensions, 8 gaps
**Agent B** : 17 sources, 16 dimensions, 8 gaps
**Question** : Quels principes/pratiques existent dans la littérature pour un PO non-technique qui délègue tout le développement logiciel à des agents IA autonomes ?

---

## I. MAPPING DIMENSIONS → PICOCs EXISTANTS

| Dimension (union A+B) | PICOC existant | Statut |
|----------------------|----------------|--------|
| Niveaux d'autonomie | #1 autonomy-granularity | **Couvert** |
| Routing de tâches | #2 task-type-routing | **Couvert** |
| Human-only gates | #3 human-only-gates | **Couvert** |
| Deterministic gates | #4 deterministic-gates | **Couvert** |
| Escalation | #5 escalation-protocol | **Couvert** |
| Mémoire / context compaction | #6 context-compaction | **Couvert** |
| Décomposition / délégation sous-tâches | #7 intermediate-task-delegation | **Couvert** |
| Model routing | #8 model-routing | **Couvert** |
| Topologie multi-agent (writer/reviewer) | #9 multi-agent-topology | **Partiel** — technique, pas organisationnel |
| Permissions / sandbox | #10 permissions-sandbox | **Partiel** — permissions, pas IAM agents ni prompt injection |
| Project instructions | #11 project-instructions | **Couvert** |
| Prompt spec discipline | #12 prompt-spec-discipline | **Partiel** — côté agent, pas côté PO input |
| Provenance / audit trail | #13 provenance-audit | **Partiel** — traçabilité oui, accountability chain non |
| Silent failure monitoring | #14 silent-failure-monitoring | **Couvert** |
| Situational awareness | #15 situational-awareness | **Partiel** — état interne, pas calibration performance réelle |
| Budget caps | #16 budget-caps | **Partiel** — caps, pas économie long-terme ni CLEAR |
| TDD loop | #17 tdd-loop | **Partiel** — tests, pas évaluation multi-dimensionnelle (CLEAR) |
| Team metrics | #18 team-metrics | **Couvert** |
| Verification method | #19 verification-method | **Couvert** |
| **Accountability chain (gouvernance)** | — | **ABSENT** |
| **Calibration performance réelle vs benchmarks** | — | **ABSENT** |
| **Structure organisationnelle d'équipe agents** | — | **ABSENT** |
| **Sécurité agentique (prompt injection, IAM)** | — | **ABSENT** |
| **Taxonomie modes de défaillance (MAST)** | — | **ABSENT** |
| **Évaluation multi-dimensionnelle (CLEAR)** | — | **ABSENT** |
| **Supervision sans micro-management** | — | **ABSENT** |
| **Redesign des processus** | — | **ABSENT** |
| **Interactions sociotechniques** | — | **ABSENT** |

---

## II. CONVERGENCES ENTRE AGENTS A ET B

| Gap | Agent A | Agent B | Convergence |
|-----|---------|---------|:-----------:|
| PO non-technique comme unité d'analyse | GAP 1 | G1 | OUI |
| Spécification tâche pour non-développeurs | GAP 2 | G2 | OUI |
| Vérification qualité accessible au non-technique | GAP 3 | G3+G5 | OUI |
| Économie / coût long-terme | GAP 4 | G4 | OUI |
| Formation / littératie du PO | GAP 7 | G2 partiel | OUI (partiel) |
| Dérive qualité long-terme | GAP 5 | G6 | OUI (partiel) |
| Vue multi-agents pour principal unique | GAP 6 | G7 | OUI |
| Impact agile et culture produit | GAP 8 | — | Agent A uniquement |
| Contextes réglementés | — | G8 | Agent B uniquement |

---

## III. NOUVEAUX PICOC CANDIDATS (littérature suffisante)

Ces dimensions sont **absentes des 19 PICOCs** et ont des **sources empiriques disponibles** dans les extractions A+B. Elles peuvent faire l'objet d'une recherche EBSE formelle.

| Priorité | PICOC candidat | Sources disponibles | Grade estimé |
|----------|---------------|---------------------|:------------:|
| 1 | **Accountability et gouvernance agentique** — qui est responsable des actions de l'agent ? | OpenAI Practices, IMDA 2026, WEF 2025, Feng 2025, Li/SE3.0 | 3-4 |
| 2 | **Calibration performance réelle** — gap benchmark vs production | SWE-bench, SWE-bench Pro, ReliabilityBench, Anthropic 2026, Mehta CLEAR | 3-4 |
| 3 | **Sécurité agentique** — prompt injection, IAM agents, tool misuse | Datta 2025, ISACA 2025, Arunkumar 2026, Index 2026 | 3 |
| 4 | **Évaluation multi-dimensionnelle (CLEAR)** — au-delà du task completion | Mehta 2025 (ρ=0.83), SAP KDD 2025, IIIT-Hyderabad 2025 | 3 |
| 5 | **Structure organisationnelle équipe agents** — rôles, topologie, SE 3.0 | ALMAS, Agyn, ChatCollab, Li/SE3.0, Berretta scoping review | 3 |
| 6 | **Modes de défaillance agentiques** — taxonomie MAST | Cemri 2025 MAST (ICLR, kappa=0.88), Zhang 2026 | 3 |
| 7 | **Supervision sans micro-management (HOTL)** — Human-On-The-Loop | OrchVis, Anthropic 2026, Feng 2025 | 3-4 |
| 8 | **Redesign des processus** — conditions d'échec si automatisation de l'existant | Deloitte 2026, MAST 2025 | 2-3 |

---

## IV. GAPS DANS LA LITTÉRATURE ELLE-MÊME (pas de PICOC possible)

Ces gaps sont confirmés par les deux agents : **la littérature elle-même ne couvre pas ces dimensions de manière empirique**. Pas de PICOC possible sans nouvelles études primaires.

| Gap | Confirmation | Note |
|-----|-------------|------|
| Framework délégation spécifique PO non-technique | A+B convergent | Perspective "operator" générique uniquement |
| Spécification de tâche opérationnelle pour non-développeur | A+B convergent | Prescriptif uniquement (CHI 2023 proche mais pas directement) |
| Validation qualité accessible au non-technique | A+B convergent | Tous les frameworks assument un évaluateur technique |
| Dérive qualité architecturale long-terme (codebases agents) | A partiel, B partiel | 0 étude longitudinale |
| Adaptation processus agile pour équipes d'agents | Agent A uniquement | ChatCollab (Stanford) seul, sans données agile empiriques |
| Littératie minimale du PO orchestrateur | A+B convergent | CHI 2023 proche (knowledge → délégation) mais pas spécifique orchestration |

---

## V. VERDICT

**PICOCs absents (littérature disponible)** : 8 candidats prioritaires, grade estimé 3-4.

**Gaps dans la littérature** : 6 dimensions non couvertes empiriquement — pas de PICOC possible, documenter comme "preuve insuffisante, pratique pionnière".

**Conclusion principale** : Le guide couvre bien les 19 PICOCs existants (autonomie, délégation, gates, monitoring, sécurité de base). Il manque les dimensions de **gouvernance/accountability**, **performance réelle**, **sécurité agentique avancée**, et **évaluation multi-dimensionnelle** — toutes documentées dans la littérature récente 2024-2026. Le cas "PO non-technique qui délègue tout" n'est pas encore couvert par des études empiriques directes.

---

## Sources critiques (les plus robustes)

1. Li/Zhang/Hassan 2025 arXiv:2507.15003 — 456 535 PRs, SE 3.0, trust gap empirique
2. Cemri 2025 arXiv:2503.13657 — MAST, 1600+ traces, ICLR 2025, kappa=0.88
3. Mehta 2025 arXiv:2511.14136 — CLEAR, ρ=0.83 prédiction production
4. Anthropic 2026 — millions d'interactions réelles, données primaires uniques
5. IMDA 2026 — framework gouvernemental opérationnel, niveau régulateur
6. OpenAI Practices 2023 — framework fondateur accountability/governance
7. Staufer 2026 arXiv:2602.17753 — AI Agent Index, 30 systèmes réels, 45 champs
