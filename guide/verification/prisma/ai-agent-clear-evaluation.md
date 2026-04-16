# PRISMA Flow — PICOC #23 : ai-agent-clear-evaluation

**Date de recherche** : 2026-04-16  
**Bases interrogées** : arXiv (cs.AI, cs.SE, cs.CL), KDD 2025 proceedings, ACM Digital Library, ICSE proceedings  
**Mots-clés Agent A** : "AI agent evaluation framework multi-dimensional", "LLM agent benchmark evaluation production", "AI coding agent quality metrics beyond task completion", "agent performance evaluation empirical study", "multi-metric AI agent assessment"  
**Mots-clés Agent B** : "autonomous agent capability evaluation real-world", "beyond accuracy agent evaluation software development", "CLEAR agent benchmark framework", "AlphaEval production tasks enterprise", "agent reliability measurement methodology"  
**Protocole** : methodology.md v3.0 §2.1 — double extraction indépendante + vérification Agent C

---

## Flux

```
IDENTIFICATION
  Sources identifiées par base (Agent A + Agent B combinés, avant déduplication) :
    - arXiv (cs.AI, cs.SE, cs.CL) : ~45 résultats candidats
    - KDD/ICSE/ACM proceedings (via WebSearch) : ~10 résultats
    - WebSearch général (blogs, rapports METR, Anthropic) : ~8 résultats
    - Snowballing (références des surveys Yehudai, Mohammadi) : ~12 sources
  Total identifié (brut, combiné A+B) : ~75
  Doublons retirés (convergence A+B élevée) : 6 (METR, AlphaEval, Mehta, Rabanser, Pan, Mohammadi)
  Total après déduplication : ~69

SCREENING (titre + résumé)
  Sources screenées : ~69
  Sources exclues au screening : ~50
    - E1 (benchmarks LLM génériques non-agentiques) : ~20
    - E2 (théoriques sans données) : ~15
    - E3 (hors scope PICOC — focus médical/juridique uniquement) : ~8
    - E4 (whitepapers vendor sans méthodologie) : ~7

ELIGIBILITÉ (lecture complète)
  Sources évaluées en détail : ~19
  Sources exclues après lecture complète : ~10
    - Pas de dimension multi-dimensionnelle (métrique unique uniquement) : 5
    - N insuffisant ou méthodologie non reproductible : 3
    - Doublon partiel avec source retenue : 2

INCLUSION
  Sources incluses dans la synthèse : 9
    - Niveau 1 : 1 (METR RCT — indirect mais contexte motivant critique)
    - Niveau 2 : 3 (Pan/Berkeley N=306 ; Mohammadi KDD 2025 peer-reviewed ; Rabanser Princeton)
    - Niveau 3 : 5 (Mehta CLEAR ; AlphaEval Lu et al. ; Yehudai survey ; Yin empirique SE ; Akshathala IIIT-H)
    - Niveau 4 : 0
    - Niveau 5 : 0

  Corrections factuelles Agent C obligatoires :
    - Mehta CLEAR : dimensions correctes = Cost, Latency, Efficacy, Assurance, Reliability
      (pas "Completeness, Efficiency" — "Efficacy" pas "Efficiency")
    - AlphaEval : scores "39-64/100" NOT_VERIFIED dans l'abstract
    - Mehta : auteur unique sans affiliation institutionnelle — biais potentiel à noter
```

---

## Documentation recherche (Table 2 Kitchenham)

### Agent A — bases interrogées

| Élément | Valeur |
|---------|--------|
| Bases | arXiv (cs.AI, cs.SE), WebSearch, METR.org |
| Mots-clés | "AI agent evaluation framework multi-dimensional", "CLEAR agent benchmark" |
| Période couverte | 2024-2026 |
| Sources identifiées | ~40 |
| Sources retenues | 5 |
| Date d'extraction | 2026-04-16 |

### Agent B — bases interrogées

| Élément | Valeur |
|---------|--------|
| Bases | arXiv (cs.CL, cs.CY), KDD proceedings, Anthropic Research blog |
| Mots-clés | "beyond accuracy agent evaluation", "AlphaEval production tasks enterprise" |
| Période couverte | 2024-2026 |
| Sources identifiées | ~35 |
| Sources retenues | 6 (convergence partielle avec A) |
| Date d'extraction | 2026-04-16 |

---

## Convergence A+B

Forte convergence sur les sources principales (Mehta, AlphaEval, METR, Rabanser). Agent B a identifié des sources complémentaires institutionnelles (Pan/Berkeley, Geninatti Cossatin) que A n'avait pas trouvées. La convergence sur le constat principal (métrique unique insuffisante) est totale entre A et B.

## Sources exclues — raisons documentées

| Source | Raison exclusion |
|--------|-----------------|
| arXiv:2602.04813 (Vatsal healthcare) | Domaine médical uniquement — indirectness trop forte |
| arXiv:2509.14647 (AgentCompass) | Post-deployment monitoring — angle différent de l'évaluation PO |
| arXiv:2411.12924 (HULA Atlassian) | Focus HITL en SE, pas framework multi-dimensionnel général |
| Benchmarks HumanEval, MBPP, SWE-bench | Constituent l'objet de comparaison, pas l'Intervention |
