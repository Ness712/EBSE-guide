# PRISMA Flow — PICOC #21 : ai-agent-performance-calibration

**Date de recherche** : 2026-04-16
**Bases interrogées** : arXiv (cs.SE, cs.AI), METR.org, SWE-bench leaderboard, MSR/CMU proceedings, GitHub AIDEV-POP dataset
**Mots-clés Agent A** : "autonomous software agent productivity empirical", "LLM coding agent real-world performance gap benchmark", "SWE-bench production performance discrepancy", "AI developer productivity measurement", "coding agent evaluation real tasks", "AI software development productivity study"
**Mots-clés Agent B** : "SWE-agent autonomous software engineering evaluation", "AI coding agent benchmark versus production", "LLM agent reliability benchmark evaluation", "developer productivity AI tools empirical", "coding agent real tasks evaluation benchmark gap"
**Protocole** : methodology.md v3.0 §2.1 — double extraction indépendante + vérification Agent C

---

## Flux

```
IDENTIFICATION
  Sources identifiées par base (Agent A + Agent B combinés, avant déduplication) :
    - arXiv (cs.SE, cs.AI) : ~42 résultats candidats
    - WebSearch général / METR.org / leaderboards : ~18 résultats candidats
    - MSR/CMU/ICSE proceedings (via WebSearch) : ~10 résultats
    - GitHub AIDEV-POP dataset documentation : 2 sources
  Total identifié (brut, combiné A+B) : ~72
  Doublons retirés (convergence A+B élevée) : 5 (METR, SWE-Bench Pro, Princeton, PR study, CMU)
  Total après déduplication : ~67

SCREENING (titre + résumé)
  Sources screenées : ~67
  Sources exclues au screening : ~48
    - E1 (benchmarks purement techniques sans corrélation production) : ~18
    - E2 (théoriques sans données) : ~12
    - E3 (hors scope PICOC — focus développeur humain, pas agent) : ~10
    - E4 (marketing / whitepaper vendor) : ~8

ELIGIBILITÉ (lecture complète)
  Sources évaluées en détail : ~19
  Sources exclues après lecture complète : ~12
    - Pas de comparaison benchmark/production (un seul environnement) : 6
    - Données insuffisamment quantifiées : 3
    - Doublon partiel avec source retenue : 3

INCLUSION
  Sources incluses dans la synthèse : 7
    - Niveau 1 : 1 (METR RCT — quasi-crossover, correction arXiv ID → 2507.09089)
    - Niveau 2 : 5 (SWE-Bench Pro, Princeton reliability, CMU MSR'26, AlphaEval, ReliabilityBench)
    - Niveau 3 : 1 (PR merge study arXiv:2509.14745 — correction venue/N)
    - Niveau 4 : 0
    - Niveau 5 : 0

  Sources exclues avec raison documentée : 0 (toutes retenues après corrections Agent C)
  Sources avec corrections factuelles obligatoires : 3
    - METR : arXiv ID corrigé (2507.09479 → 2507.09089)
    - PR merge study : venue corrigée (pas TOSEM, = arXiv preprint) ; N corrigé (567, pas 33K)
    - CMU MSR'26 : chiffres corrigés (+30.26% warnings et +41.64% complexity)
```

---

## Documentation recherche (Table 2 Kitchenham)

### Agent A — bases interrogées

| Élément | Valeur |
|---------|--------|
| Bases | arXiv (cs.SE, cs.AI), METR.org, SWE-bench leaderboard |
| Mots-clés | "autonomous software agent productivity empirical", "LLM coding agent real-world performance gap" |
| Période couverte | 2024-2026 |
| Sources identifiées | ~38 |
| Sources retenues | 7 |
| Date d'extraction | 2026-04-16 |

### Agent B — bases interrogées

| Élément | Valeur |
|---------|--------|
| Bases | arXiv (cs.SE), WebSearch, GitHub repositories |
| Mots-clés | "SWE-agent autonomous software engineering evaluation", "AI coding agent benchmark production gap" |
| Période couverte | 2024-2026 |
| Sources identifiées | ~34 |
| Sources retenues | 6 (convergence totale avec A) |
| Date d'extraction | 2026-04-16 |

---

## Convergence A+B

Les deux agents ont identifié **exactement les mêmes 6 sources principales** via des mots-clés distincts. Cette convergence totale est un signal de robustesse du corpus — il existe peu d'autres études empiriques sur le gap benchmark/production en développement logiciel agentique.

## Sources exclues — raisons documentées

| Source | Raison exclusion |
|--------|-----------------|
| HumanEval, MBPP, SWE-bench Lite (benchmarks simples) | Constituent l'objet de comparaison (Comparaison), pas l'Intervention |
| Études LLM seul (sans agent) | Hors scope — portent sur les LLMs, pas les agents autonomes |
| Études de cas vendor (GitHub Copilot, Cursor, Devin) | Vendor bias ou N trop faible pour généralisation |
