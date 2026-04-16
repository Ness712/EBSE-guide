# PRISMA Flow — PICOC #27 : ai-agent-process-redesign

**Date de recherche** : 2026-04-16  
**Bases interrogées** : McKinsey.com, Deloitte Insights, PwC.com, Bain.com, arXiv (cs.SE), HBR  
**Mots-clés Agent A** : "AI process redesign vs automation productivity", "McKinsey AI State 2025 process redesign", "business process reengineering AI agents", "AI adoption process transformation empirical", "workflow redesign artificial intelligence benefit"  
**Mots-clés Agent B** : "automation without redesign failure AI", "AI agent workflow transformation empirical study", "Deloitte AI Tech Trends 2026", "AI software development process change organizational", "rethinking software process AI agents empirical"  
**Protocole** : methodology.md v3.0 §2.1 — double extraction indépendante + vérification Agent C

---

## Flux

```
IDENTIFICATION
  Sources identifiées par base (Agent A + Agent B combinés, avant déduplication) :
    - McKinsey / BCG / Deloitte / PwC / Bain (WebSearch) : ~15 résultats candidats
    - arXiv (cs.SE, cs.AI) : ~20 résultats candidats
    - HBR / MIT Sloan / Stanford Social Innovation Review : ~8 résultats
    - Snowballing (références McKinsey, Deloitte) : ~6 sources
  Total identifié (brut, combiné A+B) : ~49
  Doublons retirés : 2 (McKinsey, METR retrouvés par les deux agents)
  Total après déduplication : ~47

SCREENING (titre + résumé)
  Sources screenées : ~47
  Sources exclues au screening : ~30
    - E1 (adoption IA générale sans angle processus/redesign) : ~15
    - E2 (études d'automatisation pré-LLM — RPA, BPM) : ~8
    - E3 (théoriques/prescriptifs sans données) : ~7

ELIGIBILITÉ (lecture complète)
  Sources évaluées en détail : ~17
  Sources exclues après lecture complète : ~12
    - Pas de comparaison redesign vs automatisation (mesure d'un seul état) : 6
    - Données non quantifiées ou non reproductibles : 4
    - Doublon partiel : 2

INCLUSION
  Sources incluses dans la synthèse : 5 + 1 corroborante
    - Niveau 1 : 1 (METR RCT — indirect, corroborant)
    - Niveau 2 : 0
    - Niveau 3 : 4 (McKinsey N=1993 ; Deloitte Tech Trends 2026 ;
                     PwC N=1217 ; Bain Automation Scorecard)
    - Niveau 4 : 1 (HBR Wilson/Daugherty — practitioner essay corroborant)

  Corrections factuelles Agent C obligatoires :
    - McKinsey "3.6x enterprise-level impact" = REFORMULATION INCORRECTE ;
      le vrai claim = high performers "nearly 3x more likely to redesign workflows"
      ET redesign = prédicteur EBIT #1 parmi 25 attributs
    - McKinsey "25-30% vs 10-15%" = NOT_VERIFIED verbatim dans sources primaires
    - Deloitte "workslop" = CONFIRMÉ dans document officiel
```

---

## Documentation recherche (Table 2 Kitchenham)

### Agent A — bases interrogées

| Élément | Valeur |
|---------|--------|
| Bases | McKinsey.com, Bain.com, HBR, arXiv (cs.AI) |
| Mots-clés | "McKinsey AI State 2025 process redesign", "business process reengineering AI agents" |
| Période couverte | 2024-2026 |
| Sources identifiées | ~26 |
| Sources retenues | 3 (McKinsey, HBR, Bain) |
| Date d'extraction | 2026-04-16 |

### Agent B — bases interrogées

| Élément | Valeur |
|---------|--------|
| Bases | Deloitte.com, PwC.com, arXiv (cs.SE), METR.org |
| Mots-clés | "Deloitte AI Tech Trends 2026", "automation without redesign failure AI" |
| Période couverte | 2024-2026 |
| Sources identifiées | ~23 |
| Sources retenues | 4 (Deloitte, METR, PwC, McKinsey agentic) |
| Date d'extraction | 2026-04-16 |

---

## Note sur la nature du corpus

Ce PICOC est dominé par des rapports de cabinets de conseil (McKinsey, Deloitte, PwC, Bain) — c'est une limitation intrinsèque du corpus disponible : peu d'études académiques peer-reviewed existent sur ce sujet spécifique en contexte IA. La seule source empirique rigoureuse (METR RCT) mesure l'automatisation de l'existant sans redesign, non le redesign lui-même. Cette asymétrie du corpus est documentée dans le GRADE (base 2, -1 biais commercial).

## Sources exclues — raisons documentées

| Source | Raison exclusion |
|--------|-----------------|
| Chiffres "25-30% vs 10-15%" attribués McKinsey | NOT_VERIFIED verbatim dans sources primaires — agrégation de sources secondaires |
| RPA/BPM automation studies pré-LLM | Contexte pré-IA — indirectness trop forte pour les agents LLM |
| Études adoption IA sans mesure de processus | Mesurent l'adoption générale, pas le différentiel redesign vs automatisation |
