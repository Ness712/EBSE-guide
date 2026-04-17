# PRISMA Flow — PICOC cqrs

**Date de recherche** : 2026-04-17
**Bases interrogées** : martinfowler.com, vladikk.com, microservices.io, Microsoft Azure Architecture Center, ACM Digital Library, NestJS documentation, WebSearch général, KPI Science News
**Mots-clés Agent A** : "CQRS command query responsibility segregation", "CQRS risky complexity over-engineering", "CQRS event sourcing difference", "NestJS CQRS CqrsModule CommandBus QueryBus", "CQRS when to use criteria", "OWASP CQRS architecture pattern"
**Mots-clés Agent B** : "CQRS scalability asymmetric reads writes", "CQRS microservices materialized views", "CQRS anti-pattern DDD conflict", "when not to use CQRS CRUD simple", "CQRS cyclomatic complexity reduction empirical", "Greg Young CQRS objects separation"
**Protocole** : methodology.md v3.0 §2.1 — double extraction indépendante (Agents A + B, mots-clés différents) + synthèse Agent C

---

## Flux

```
IDENTIFICATION
  Sources identifiées par base (Agent A + Agent B combinés, avant déduplication) :
    - Experts architectures logicielles (Fowler, Young, Khononov) : ~6 résultats candidats
    - Experts microservices (Richardson, microservices.io) : ~4 résultats candidats
    - Documentation institutionnelle (Microsoft Azure, AWS, Google) : ~6 résultats candidats
    - Documentation frameworks (NestJS, Spring, Axon) : ~8 résultats candidats
    - Publications académiques (ACM, IEEE, EuroPLoP) : ~7 résultats candidats
    - Études empiriques et mesures (KPI Science, recherches complexité) : ~5 résultats candidats
    - Blogs d'opinion (DZone, abdullin.com, GeeksforGeeks) : ~10 résultats candidats
    - Snowballing backward (références citées par sources principales) : ~6 sources
  Total identifié (brut, combiné A+B) : ~52
  Doublons retirés (même source identifiée par A et B) : 8 (Fowler CQRS, Young CQRS ES,
    NestJS CQRS docs, Azure Architecture Center, Kabbedijk & Jansen EuroPLoP 2014,
    KPI Science mCQRS, abdullin.com, DZone anti-pattern)
  Total après déduplication : ~44

SCREENING (titre + résumé)
  Sources screenées : ~44
  Sources exclues au screening : ~30
    - E1 (blog opinion sans données ou méthodologie tracée) : ~10
    - E2 (hors scope PICOC — Event Sourcing seul, DDD general sans CQRS) : ~8
    - E3 (doublons partiels — couverts par sources primaires déjà incluses) : ~7
    - E4 (documentation framework autre stack sans apport universel) : ~5

ELIGIBILITÉ (lecture complète)
  Sources évaluées en détail : ~14
  Sources exclues après lecture complète : ~6
    - Niveau de preuve insuffisant (opinion personnelle sans références empiriques) : 3
    - Redondance forte avec sources incluses de niveau supérieur : 2
    - Hors scope PICOC (CQRS dans contexte gaming / temps réel uniquement) : 1

INCLUSION
  Sources incluses dans la synthèse : 8
    - Niveau 3 : 3 (NestJS CQRS docs, Kabbedijk & Jansen EuroPLoP 2014, KPI Science mCQRS 2024)
    - Niveau 4 : 1 (Microsoft Azure Architecture Center)
    - Niveau 5 : 4 (Fowler, Young, Khononov, Richardson)

  Sources exclues avec raison documentée : 3
    - abdullin.com "When NOT to use CQRS?" : couvert par Fowler + Khononov avec plus de rigueur
    - DZone "CQRS Is an Anti-Pattern for DDD" : opinion partielle, claim trop absolu
    - GeeksforGeeks "Difference Between CQRS and Event Sourcing" : couvert par Richardson + Young
```

---

## Documentation recherche (Table 2 Kitchenham)

### Agent A — bases interrogées

| Élément | Valeur |
|---------|--------|
| Bases | martinfowler.com, NestJS docs, Microsoft Azure Architecture Center, ACM Digital Library, WebSearch général |
| Mots-clés | "CQRS command query responsibility segregation", "CQRS risky complexity over-engineering", "CQRS event sourcing difference", "NestJS CQRS CqrsModule CommandBus QueryBus", "CQRS when to use criteria", "CQRS architecture pattern EuroPLoP" |
| Période couverte | 2010-2024 |
| Sources identifiées | ~25 |
| Sources retenues | 6 |
| Date d'extraction | 2026-04-17 |

### Agent B — bases interrogées

| Élément | Valeur |
|---------|--------|
| Bases | vladikk.com, microservices.io, Microsoft Azure Architecture Center, NestJS docs, KPI Science News, WebSearch général |
| Mots-clés | "CQRS scalability asymmetric reads writes", "CQRS microservices materialized views", "CQRS anti-pattern DDD conflict", "when not to use CQRS CRUD simple", "CQRS cyclomatic complexity reduction empirical", "Greg Young CQRS objects separation" |
| Période couverte | 2010-2024 |
| Sources identifiées | ~27 |
| Sources retenues | 8 (convergence élevée avec A + Khononov + Richardson en plus) |
| Date d'extraction | 2026-04-17 |

---

## Sources exclues — raisons documentées

| Source | Raison exclusion |
|--------|-----------------|
| abdullin.com — "When NOT to use CQRS?" | Blog d'opinion (niveau 4 déclassé). Contenu absorbé par Fowler (martinfowler.com, 2011) et Khononov (vladikk.com, 2017) qui traitent les mêmes anti-patterns avec plus de rigueur argumentative et d'autorité reconnue dans la communauté DDD/CQRS. |
| DZone — "CQRS Is an Anti-Pattern for DDD" | Opinion partielle dont le claim principal ("CQRS est un anti-pattern pour DDD") est trop absolu et non soutenu empiriquement. La nuance légitime (tension possible entre CQRS et DDD dans certains contextes) est couverte par Khononov avec plus de précision. |
| GeeksforGeeks — "Difference Between CQRS and Event Sourcing" | Documentation généraliste de vulgarisation (niveau 3 déclassé). La distinction CQRS vs Event Sourcing est couverte de façon plus rigoureuse et primaire par Richardson (microservices.io) et Young (inventeur du pattern) qui sont des sources de niveau 5 sur le même sujet. |
| Axon Framework documentation — CQRS implementation | Documentation framework Java (Axon), hors scope NestJS/TypeScript. Apport sur l'implémentation absorbé par NestJS CQRS docs qui est directement applicable. Candidat pour un futur variant java-spring. |
| AWS Architecture Blog — CQRS with DynamoDB | Spécifique à un contexte cloud AWS + NoSQL, population différente du PICOC (applications web générales). Classé hors scope (indirectness). |
| Vaughn Vernon — Implementing Domain-Driven Design (IDDD, 2013) | Traite CQRS dans le contexte DDD agrégats mais de façon moins focalisée que Young sur la définition du pattern et moins que Khononov sur les conditions d'application. Redondance avec sources incluses de niveau supérieur. |
