# PRISMA Flow — PICOC #26 : ai-agent-hotl-supervision

**Date de recherche** : 2026-04-16  
**Bases interrogées** : arXiv (cs.AI, cs.HC, cs.SE), ICSE SEIP 2025 proceedings, Information Processing & Management, DTIC, Knight Columbia  
**Mots-clés Agent A** : "human-on-the-loop AI agent supervision", "levels of autonomy agentic AI", "human oversight AI agent software development", "HITL vs HOTL autonomous agent", "AI agent supervision without micromanagement"  
**Mots-clés Agent B** : "agentic AI human control autonomy spectrum", "Sheridan Verplank levels of automation AI", "agent oversight mechanism production", "levels of autonomy AI agents framework"  
**Protocole** : methodology.md v3.0 §2.1 — double extraction indépendante + vérification Agent C

---

## Flux

```
IDENTIFICATION
  Sources identifiées par base (Agent A + Agent B combinés, avant déduplication) :
    - arXiv (cs.AI, cs.HC, cs.SE) : ~30 résultats candidats
    - ICSE/CHI proceedings : ~8 résultats
    - WebSearch (Anthropic blog, Knight Columbia, IP&M) : ~10 résultats
    - DTIC (Sheridan 1978) : 1 source fondatrice
  Total identifié (brut, combiné A+B) : ~49
  Doublons retirés : 3 (Magentic-UI, Anthropic, Feng et al. retrouvés par les deux agents)
  Total après déduplication : ~46

SCREENING (titre + résumé)
  Sources screenées : ~46
  Sources exclues au screening : ~30
    - E1 (supervision humaine générale, non-agentique) : ~12
    - E2 (systèmes HITL non-LLM — robotique, IoT) : ~8
    - E3 (théoriques sans implémentation) : ~6
    - E4 (focus sécurité/safety pur, pas supervision pratique) : ~4

ELIGIBILITÉ (lecture complète)
  Sources évaluées en détail : ~16
  Sources exclues après lecture complète : ~10
    - Pas d'évaluation quantitative de la supervision (OrchVis — prototype uniquement) : 3
    - Domaine hors SE (téléopération robotique moderne) : 3
    - Doublon conceptuel : 2
    - N insuffisant : 2

INCLUSION
  Sources incluses dans la synthèse : 6
    - Niveau 1 : 0
    - Niveau 2 : 2 (HULA Atlassian ICSE SEIP 2025 N=663 ; Geninatti Cossatin IP&M Q1 N=230)
    - Niveau 3 : 1 (Magentic-UI arXiv:2507.22358 — simulé, Microsoft Research)
    - Niveau 4 : 3 (Anthropic Measuring Autonomy institutionnel ; Feng et al. conceptuel ; Sheridan & Verplank 1978 fondateur)
    - Niveau 5 : 0

  Corrections factuelles Agent C obligatoires :
    - Magentic-UI : +71% = amélioration RELATIVE (30.3%→51.9%), pas absolue ;
      utilisateurs SIMULÉS (GPT-4o), pas réels
    - "Feng et al. 2025 OrchVis" = DOUBLE ERREUR : OrchVis est de Jieyu Zhou (Georgia Tech),
      Feng et al. est un framework LOA conceptuel distinct (arXiv:2506.12469)
    - OrchVis exclu : prototype sans évaluation empirique
```

---

## Documentation recherche (Table 2 Kitchenham)

### Agent A — bases interrogées

| Élément | Valeur |
|---------|--------|
| Bases | arXiv (cs.AI, cs.HC), ICSE proceedings, Anthropic Research blog |
| Mots-clés | "human-on-the-loop AI agent supervision", "HITL vs HOTL autonomous agent" |
| Période couverte | 1978-2026 (fondateurs inclus) |
| Sources identifiées | ~26 |
| Sources retenues | 3 (Magentic-UI, Anthropic, HULA) |
| Date d'extraction | 2026-04-16 |

### Agent B — bases interrogées

| Élément | Valeur |
|---------|--------|
| Bases | arXiv (cs.AI, cs.CY), DTIC, Information Processing & Management, Knight Columbia |
| Mots-clés | "Sheridan Verplank levels of automation AI", "levels of autonomy AI agents framework" |
| Période couverte | 1978-2026 |
| Sources identifiées | ~23 |
| Sources retenues | 5 (Sheridan & Verplank, Feng et al., Geninatti Cossatin, AI Agent Index, Adewumi) |
| Date d'extraction | 2026-04-16 |

---

## Note sur la distinction HOTL/HITL

La littérature empirique disponible porte principalement sur le HITL (approbation d'actions spécifiques) — Magentic-UI, HULA. Le HOTL strict (supervision par exception, intervention uniquement sur anomalie) est principalement documenté par des sources institutionnelles (Anthropic) et conceptuelles (Feng et al., Sheridan & Verplank). Cette asymétrie est une limite intrinsèque du corpus actuel.

## Sources exclues — raisons documentées

| Source | Raison exclusion |
|--------|-----------------|
| OrchVis (arXiv:2510.24937 — Zhou) | Prototype sans évaluation empirique ; user studies = travail futur |
| AI Agent Index (arXiv:2602.17753) | Audit descriptif — pas d'évaluation de supervision HOTL/HITL |
| Adewumi et al. 2025 (arXiv:2507.23330) | Position paper normatif, pas d'évaluation empirique |
| Systèmes HITL robotique modernes | Domaine hors SE — indirectness trop forte |
