# PRISMA Flow — PICOC team-topology

**Date de recherche** : 2026-04-17
**Bases interrogées** : Google Scholar, ACM Digital Library, IEEE Xplore, InfoQ, teamtopologies.com, martinfowler.com, ThoughtWorks Technology Radar, WebSearch général
**Mots-clés Agent A** : "Conway's Law software architecture", "Team Topologies stream-aligned", "inverse Conway maneuver", "cognitive load team design", "organizational structure microservices", "team boundaries domain-driven design"
**Mots-clés Agent B** : "how committees invent Conway 1968", "Skelton Pais team topologies 2019", "platform team enabling team", "team cognitive load fast flow", "organizational design software teams", "Conway law empirical evidence"
**Protocole** : methodology.md v3.0 §2.1 — double extraction indépendante (Agents A + B, mots-clés différents) + synthèse Agent C

---

## Flux

```
IDENTIFICATION
  Sources identifiées par base (Agent A + Agent B combinés, avant déduplication) :
    - Articles fondateurs (Conway 1968, Skelton & Pais 2019) : 2 résultats candidats
    - Livres et ouvrages techniques (IT Revolution, O'Reilly) : ~5 résultats candidats
    - Articles et blogs de référence (InfoQ, Martin Fowler, ThoughtWorks) : ~14 résultats candidats
    - Ressources officielles (teamtopologies.com, patterns documentés) : ~6 résultats candidats
    - Articles académiques empiriques (études organisations tech) : ~8 résultats candidats
    - Snowballing backward (références citées par Skelton & Pais) : ~7 sources
  Total identifié (brut, combiné A+B) : ~42
  Doublons retirés (même source identifiée par A et B) : 4 (Conway 1968, Skelton & Pais 2019, InfoQ Inverse Conway, teamtopologies.com)
  Total après déduplication : ~38

SCREENING (titre + résumé)
  Sources screenées : ~38
  Sources exclues au screening : ~26
    - E1 (blog opinion sans données ni méthodologie) : ~10
    - E2 (hors scope PICOC — organisation générale non tech, ou architecture sans lien équipes) : ~7
    - E3 (doublons partiels — couverts par sources primaires déjà incluses) : ~5
    - E4 (contenu marketing framework agile sans substance sur l'organisation/architecture) : ~4

ELIGIBILITÉ (lecture complète)
  Sources évaluées en détail : ~12
  Sources exclues après lecture complète : ~8
    - Hors scope PICOC strict (organisation agile générale sans lien Conway/topologies) : 3
    - Niveau de preuve insuffisant (anecdotes de cas sans généralisation) : 2
    - Redondance forte avec Skelton & Pais 2019 sans apport supplémentaire : 3

INCLUSION
  Sources incluses dans la synthèse : 4
    - Niveau 3 : 1 (teamtopologies.com — ressources officielles 2022)
    - Niveau 4 : 1 (InfoQ — Inverse Conway Maneuver 2019)
    - Niveau 5 : 2 (Conway 1968, Skelton & Pais 2019)

  Sources exclues avec raison documentée : 8
    - Martin Fowler — "Conway's Law" (martinfowler.com, 2022) : redondance — synthèse de Conway 1968 sans apport original, absorbé par les sources primaires
    - ThoughtWorks Technology Radar — Team Topologies (2020-2023) : signal de popularité industrielle mais pas de guidance prescriptive au-delà de Skelton & Pais
    - Forsgren et al. — "Accelerate" (IT Revolution, 2018) : pertinent pour la livraison continue mais hors scope principal team-topology (pas de guidance directe sur les frontières d'équipes)
    - Études empiriques arXiv sur organisations microservices : indirectes — mesurent la corrélation organisation/architecture sans apporter de guidance prescriptive supplémentaire
    - Articles Agile/Scrum sur la taille d'équipe : hors scope — traitent la performance d'équipe individuelle sans lien Conway/topologies
    - DDD (Domain-Driven Design) — Evans 2003 : adjacent mais hors scope — les bounded contexts informent les frontières métier mais ne constituent pas une guidance directe sur la topologie d'équipes
    - SAFe (Scaled Agile Framework) : E4 — contenu framework prescriptif sans base empirique robuste sur la relation organisation/architecture
    - Rother & Shook — "Learning to See" (value stream mapping) : outil utile mentionné en faisabilité mais hors scope direct du PICOC
```

---

## Documentation recherche (Table 2 Kitchenham)

### Agent A — bases interrogées

| Élément | Valeur |
|---------|--------|
| Bases | Google Scholar, ACM Digital Library, InfoQ, teamtopologies.com, martinfowler.com |
| Mots-clés | "Conway's Law software architecture", "Team Topologies stream-aligned", "inverse Conway maneuver", "cognitive load team design", "organizational structure microservices" |
| Période couverte | 1968-2024 |
| Sources identifiées | ~22 |
| Sources retenues | 4 |
| Date d'extraction | 2026-04-17 |

### Agent B — bases interrogées

| Élément | Valeur |
|---------|--------|
| Bases | Google Scholar, IEEE Xplore, ThoughtWorks Technology Radar, teamtopologies.com, WebSearch |
| Mots-clés | "how committees invent Conway 1968", "Skelton Pais team topologies 2019", "platform team enabling team", "team cognitive load fast flow", "Conway law empirical evidence" |
| Période couverte | 1968-2024 |
| Sources identifiées | ~20 |
| Sources retenues | 4 (convergence élevée avec A) |
| Date d'extraction | 2026-04-17 |

---

## Sources exclues — raisons documentées

| Source | Raison exclusion |
|--------|-----------------|
| Martin Fowler — "Conway's Law" (martinfowler.com, 2022) | Redondance — synthèse de Conway 1968 sans apport prescriptif original ; absorbé par la source primaire |
| ThoughtWorks Technology Radar — Team Topologies (2020-2023) | Signal d'adoption industrielle utile mais pas de guidance prescriptive au-delà de Skelton & Pais |
| Forsgren et al. — "Accelerate" (IT Revolution, 2018) | Adjacent (livraison continue) mais hors scope direct du PICOC team-topology |
| Études empiriques arXiv — corrélation organisation/architecture microservices | Indirectes — mesurent la corrélation sans apporter de guidance prescriptive supplémentaire |
| Articles Agile/Scrum sur taille d'équipe | Hors scope — performance d'équipe individuelle sans lien Conway/topologies |
| Evans — "Domain-Driven Design" (Addison-Wesley, 2003) | Adjacent — bounded contexts informent les frontières métier mais hors scope direct topologie d'équipes |
| SAFe (Scaled Agile Framework) | E4 — prescriptif sans base empirique robuste sur la relation organisation/architecture |
| Rother & Shook — "Learning to See" (value stream mapping) | Outil utile cité en faisabilité mais hors scope direct du PICOC |
