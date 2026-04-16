# PRISMA Flow — PICOC #24 : ai-agent-org-structure

**Date de recherche** : 2026-04-16  
**Bases interrogées** : arXiv (cs.SE, cs.AI, cs.MA), ICLR 2024 proceedings, GitHub datasets  
**Mots-clés Agent A** : "multi-agent software engineering LLM roles", "MetaGPT autonomous agent team structure", "AI agent team organization performance", "agent role specialization software development", "collaborative AI agents code generation"  
**Mots-clés Agent B** : "autonomous agent organizational structure software", "LLM agent team topology ablation", "multi-agent hierarchy vs flat organization empirical", "drop the hierarchy agents autonomous", "agent collaboration protocol software engineering"  
**Protocole** : methodology.md v3.0 §2.1 — double extraction indépendante + vérification Agent C

---

## Flux

```
IDENTIFICATION
  Sources identifiées par base (Agent A + Agent B combinés, avant déduplication) :
    - arXiv (cs.SE, cs.AI, cs.MA) : ~38 résultats candidats
    - ICLR/NeurIPS/ICSE proceedings (via WebSearch) : ~12 résultats
    - Snowballing (références MetaGPT, Agyn) : ~10 sources
    - GitHub repos + datasets (AIDev) : ~4 sources
  Total identifié (brut, combiné A+B) : ~64
  Doublons retirés : 4 (MetaGPT, Agyn, Dochkina, AIDev retrouvés par les deux agents)
  Total après déduplication : ~60

SCREENING (titre + résumé)
  Sources screenées : ~60
  Sources exclues au screening : ~45
    - E1 (agents mono-tâche sans structure organisationnelle) : ~20
    - E2 (systèmes multi-agents non-LLM) : ~10
    - E3 (hors scope SE — jeux, planification générale) : ~10
    - E4 (workshop papers sans données quantitatives) : ~5

ELIGIBILITÉ (lecture complète)
  Sources évaluées en détail : ~15
  Sources exclues après lecture complète : ~8
    - Pas de comparaison de structures (une seule architecture) : 4
    - Données insuffisantes (N trop faible, aucun benchmark) : 2
    - Doublon partiel : 2

INCLUSION
  Sources incluses dans la synthèse : 5 + 2 contextuelles
    - Niveau 1 : 0
    - Niveau 2 : 1 (AIDev/SE 3.0 — Li et al. 2507.15003, N=456 000 PRs)
    - Niveau 3 : 4 (MetaGPT ICLR 2024 ; Agyn 2602.01465 ; Dochkina 2603.28990 N=25K ; Ashrafi 2505.02133)
    - Niveau 4 : 0 (ALMAS exclu — workshop sans benchmark ; ChatCollab exclu — qualitatif)
    - Niveau 5 : 0

  Corrections factuelles Agent C obligatoires :
    - MetaGPT : score exact 85.9% HumanEval (pas 85%), 87.7% MBPP
    - Dochkina : +44% = spread Sequential vs Shared (pas "vs pleine autonomie" strictement) ;
      finding conditionnel au niveau de capacité du modèle
    - AIDev : N=456 000 PRs (pas 456 535)
    - Ashrafi : dégradation modeste en accuracy (-0.75%), plus visible en robustesse
```

---

## Documentation recherche (Table 2 Kitchenham)

### Agent A — bases interrogées

| Élément | Valeur |
|---------|--------|
| Bases | arXiv (cs.SE, cs.AI), ICLR 2024 proceedings, GitHub AIDev |
| Mots-clés | "MetaGPT autonomous agent team structure", "multi-agent LLM development team hierarchy" |
| Période couverte | 2023-2026 |
| Sources identifiées | ~34 |
| Sources retenues | 4 (MetaGPT, Agyn, Dochkina, Ashrafi) |
| Date d'extraction | 2026-04-16 |

### Agent B — bases interrogées

| Élément | Valeur |
|---------|--------|
| Bases | arXiv (cs.MA, cs.AI), WebSearch, ASE workshop proceedings |
| Mots-clés | "drop the hierarchy agents autonomous", "LLM agent team topology ablation" |
| Période couverte | 2023-2026 |
| Sources identifiées | ~30 |
| Sources retenues | 5 (convergence avec A + ALMAS, ChatCollab, AIDev) |
| Date d'extraction | 2026-04-16 |

---

## Résultat contre-intuitif documenté

Le résultat central de ce PICOC est contre-intuitif et mérite documentation explicite au niveau PRISMA : ni la hiérarchie de rôles rigide (MetaGPT-style) ni la pleine autonomie émergente ne maximisent la performance. L'étude Dochkina (N=25 000, 8 protocoles) montre que le protocole hybride — séquentialité fixe + sélection de rôles autonome — surpasse les deux extrêmes. Ce résultat n'a pas encore été répliqué indépendamment (solo-author).

## Sources exclues — raisons documentées

| Source | Raison exclusion |
|--------|-----------------|
| ALMAS (arXiv:2510.03463) | Workshop paper MAS-GAIN@ASE 2025 — aucun benchmark quantitatif |
| ChatCollab (arXiv:2412.01992) | Étude qualitative, N non quantifié |
| MetaGPT-style ablations (multiples) | Vendor bias trop fort — auteurs = développeurs des systèmes |
