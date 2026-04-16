# PRISMA Flow — PICOC #25 : ai-agent-mast-failure-modes

**Date de recherche** : 2026-04-16  
**Bases interrogées** : arXiv (cs.AI, cs.SE, cs.CL), NeurIPS 2025 / ICML 2025 / MSR 2026 proceedings, OpenReview, UC Berkeley Sky Lab  
**Mots-clés Agent A** : "AI agent failure modes taxonomy", "autonomous agent error classification", "MAST agent failure taxonomy", "LLM agent failure detection", "agentic AI silent failure", "multi-agent failure diagnosis"  
**Mots-clés Agent B** : "agent error pattern empirical study", "coding agent failure analysis production", "autonomous software agent reliability failure", "LLM agent debugging failure modes", "agent task failure attribution multi-agent"  
**Protocole** : methodology.md v3.0 §2.1 — double extraction indépendante + vérification Agent C

---

## Flux

```
IDENTIFICATION
  Sources identifiées par base (Agent A + Agent B combinés, avant déduplication) :
    - arXiv (cs.AI, cs.SE, cs.CL) : ~35 résultats candidats
    - NeurIPS/ICML/MSR/ICSE proceedings (via OpenReview, WebSearch) : ~15 résultats
    - UC Berkeley Sky Lab, Penn State, Princeton project pages : ~5 sources
    - Snowballing (références MAST) : ~8 sources
  Total identifié (brut, combiné A+B) : ~63
  Doublons retirés : 3 (MAST, Who&When, Rabanser retrouvés par les deux agents)
  Total après déduplication : ~60

SCREENING (titre + résumé)
  Sources screenées : ~60
  Sources exclues au screening : ~42
    - E1 (fiabilité LLM générique non-agentique) : ~18
    - E2 (défaillances robotiques/systèmes embarqués, hors LLM) : ~10
    - E3 (théoriques sans données) : ~8
    - E4 (whitepapers sans méthodologie) : ~6

ELIGIBILITÉ (lecture complète)
  Sources évaluées en détail : ~18
  Sources exclues après lecture complète : ~12
    - Pas de taxonomie ou de données quantitatives sur modes de défaillance : 6
    - Focus sur prévention uniquement, pas sur identification des modes : 3
    - Doublon partiel : 3

INCLUSION
  Sources incluses dans la synthèse : 6
    - Niveau 1 : 0
    - Niveau 2 : 6 (MAST NeurIPS 2025 ; Who&When ICML 2025 Spotlight ;
                     Ehsani MSR 2026 ; ReliabilityBench preprint ;
                     Rabanser Princeton ; Bugs in Frameworks Concordia)
    - Niveau 3 : 0
    - Niveau 4 : 0

  Corrections factuelles Agent C obligatoires :
    - MAST : deux κ distincts — κ=0.88 (développement, 150 traces) et κ=0.79
      (validation out-of-domain) — les deux doivent être reportés
    - MAST : catégories exactes = specification issues / inter-agent misalignment /
      task verification (pas "system design issues")
    - Who&When : venue = ICML 2025 Spotlight (pas NeurIPS)
```

---

## Documentation recherche (Table 2 Kitchenham)

### Agent A — bases interrogées

| Élément | Valeur |
|---------|--------|
| Bases | arXiv (cs.AI), NeurIPS/ICML proceedings, UC Berkeley Sky Lab |
| Mots-clés | "MAST agent failure taxonomy", "AI agent failure modes taxonomy" |
| Période couverte | 2024-2026 |
| Sources identifiées | ~32 |
| Sources retenues | 3 (MAST, Who&When, ReliabilityBench) |
| Date d'extraction | 2026-04-16 |

### Agent B — bases interrogées

| Élément | Valeur |
|---------|--------|
| Bases | arXiv (cs.SE), MSR 2026 proceedings, GitHub repos |
| Mots-clés | "coding agent failure analysis production", "LLM agent debugging failure modes" |
| Période couverte | 2024-2026 |
| Sources identifiées | ~31 |
| Sources retenues | 5 (Ehsani, Rabanser, Bugs in Frameworks, Zhu — + convergence avec A) |
| Date d'extraction | 2026-04-16 |

---

## Note sur la complémentarité A+B

Agent A a identifié les sources sur les taxonomies MAS génériques (MAST, Who&When). Agent B a identifié les sources sur les coding agents en production réelle (Ehsani MSR 2026, Bugs in Frameworks). Les deux angles sont complémentaires : la taxonomie MAST fournit la structure, Ehsani et Bugs in Frameworks la valident en conditions réelles de développement logiciel.

## Sources exclues — raisons documentées

| Source | Raison exclusion |
|--------|-----------------|
| Zhu et al. arXiv:2602.21806 (998 bugs CrewAI/LangChain) | Chevauchement fort avec Bugs in Frameworks (2604.08906) — apport marginal une fois cette source incluse |
| Études adversarial/sécurité (prompt injection) | Hors scope — couverts par PICOC #22 (sécurité agentique) |
| Études de bugs LLM génériques (non-agentiques) | Hors scope — défaillances agents ≠ défaillances LLM standalone |
