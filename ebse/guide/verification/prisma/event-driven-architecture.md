# PRISMA Flow — PICOC event-driven-architecture

**Date de recherche** : 2026-04-17
**Bases interrogées** : martinfowler.com, ACM Digital Library, IEEE Xplore, Manning Publications, microservices.io, docs.nestjs.com, Temporal.io, WebSearch général
**Mots-clés Agent A** : "event-driven architecture patterns microservices", "domain events DDD bounded context", "transactional outbox pattern dual-write", "saga pattern distributed transactions choreography orchestration", "NestJS event emitter microservices"
**Mots-clés Agent B** : "event notification event sourcing CQRS comparison Fowler", "outbox pattern at-least-once delivery idempotent consumer", "saga choreography vs orchestration formal verification", "NestJS Redis Streams cross-process events", "event-driven debugging distributed tracing complexity"
**Protocole** : methodology.md v3.0 §2.1 — double extraction indépendante (Agents A + B, mots-clés différents) + synthèse Agent C

---

## Flux

```
IDENTIFICATION
  Sources identifiées par base (Agent A + Agent B combinés, avant déduplication) :
    - Experts fondateurs / livres référence (Fowler, Evans, Richardson) : ~8 résultats candidats
    - Sites de référence patterns (microservices.io, martinfowler.com) : ~10 résultats candidats
    - Documentation framework (NestJS docs, Spring docs) : ~9 résultats candidats
    - Peer-reviewed (IEEE Xplore, ACM) : ~7 résultats candidats
    - Blogs entreprise / guides pratiques (Conduktor, AWS, OneUptime, Temporal) : ~14 résultats candidats
    - Snowballing backward (références citées par sources principales) : ~6 sources
  Total identifié (brut, combiné A+B) : ~54
  Doublons retirés (même source identifiée par A et B) : 8 (Fowler x2, Evans, Richardson Manning,
    Richardson Saga site, NestJS event-emitter, Temporal.io, Conduktor, AWS)
  Total après déduplication : ~46

SCREENING (titre + résumé)
  Sources screenées : ~46
  Sources exclues au screening : ~30
    - E1 (blog opinion sans données ou méthodologie) : ~10
    - E2 (hors scope PICOC — EDA général sans focus microservices/garanties livraison) : ~8
    - E3 (doublons partiels — couverts par sources primaires déjà incluses) : ~7
    - E4 (vendeur / marketing sans substance technique différenciée) : ~5

ELIGIBILITÉ (lecture complète)
  Sources évaluées en détail : ~16
  Sources exclues après lecture complète : ~6
    - Hors scope PICOC strict (EDA côté théorique sans implémentation) : 2
    - Niveau de preuve insuffisant (blog entreprise couvert par sources plus rigoureuses) : 2
    - Redondance forte sans apport différencié : 2

INCLUSION
  Sources incluses dans la synthèse : 10
    - Niveau 3 (peer-reviewed) : 1 (IEEE Xplore 2022 — Choreography vs Orchestration LTS/PAT)
    - Niveau 3 (documentation framework) : 2 (NestJS event-emitter docs, NestJS Redis Microservices docs)
    - Niveau 4 (expert praticien) : 1 (Temporal.io — Saga Orchestration vs Choreography)
    - Niveau 5 (expert fondateur / livre référence) : 6 (Fowler 2005, Fowler 2017, Evans 2003,
        Richardson Manning 2018, Richardson Outbox microservices.io, Richardson Saga microservices.io)

  Sources exclues avec raison documentée : 3
    - Conduktor — Outbox Pattern : guide pratique Kafka/Debezium, couvert par Richardson microservices.io
    - AWS Prescriptive Guidance Outbox : documentation vendor, couvert par Richardson sans biais commercial
    - OneUptime Engineering Blog 2026 : blog entreprise, complexité debugging couverte par Fowler 2017 + IEEE 2022
```

---

## Documentation recherche (Table 2 Kitchenham)

### Agent A — bases interrogées

| Élément | Valeur |
|---------|--------|
| Bases | martinfowler.com, Manning Publications, microservices.io, docs.nestjs.com, Temporal.io, WebSearch général |
| Mots-clés | "event-driven architecture patterns microservices", "domain events DDD bounded context", "transactional outbox pattern dual-write", "saga pattern distributed transactions choreography orchestration", "NestJS event emitter microservices" |
| Période couverte | 2003-2026 |
| Sources identifiées | ~28 |
| Sources retenues | 7 |
| Date d'extraction | 2026-04-17 |

### Agent B — bases interrogées

| Élément | Valeur |
|---------|--------|
| Bases | martinfowler.com, IEEE Xplore, ACM Digital Library, microservices.io, docs.nestjs.com, Temporal.io, WebSearch |
| Mots-clés | "event notification event sourcing CQRS comparison Fowler", "outbox pattern at-least-once delivery idempotent consumer", "saga choreography vs orchestration formal verification", "NestJS Redis Streams cross-process events", "event-driven debugging distributed tracing complexity" |
| Période couverte | 2003-2026 |
| Sources identifiées | ~26 |
| Sources retenues | 9 (convergence élevée avec A + IEEE 2022 et NestJS Redis docs en plus) |
| Date d'extraction | 2026-04-17 |

---

## Sources exclues — raisons documentées

| Source | Raison exclusion |
|--------|-----------------|
| Conduktor — Outbox Pattern for Reliable Event Publishing | Redondance — guide pratique Kafka/Debezium couvert intégralement par Richardson microservices.io Outbox Pattern avec rigueur supérieure et sans biais outil |
| AWS Prescriptive Guidance — Transactional Outbox Pattern | Documentation vendor AWS — couvert sans biais commercial par Richardson Manning 2018 + Richardson microservices.io. Pas d'apport différencié. |
| OneUptime Engineering Blog 2026 | Blog d'entreprise — complexité debugging EDA couverte par Fowler 2017 (avertissement sur la complexité asynchrone) et IEEE 2022 (observabilité choreography). Niveau de rigueur insuffisant par rapport aux sources retenues. |
| Debezium documentation (CDC for Outbox) | Documentation outil spécifique (CDC) — pertinent pour l'implémentation détaillée mais hors scope du principe universel. Candidat pour variant implementation-outbox-nestjs. |
| Spring Events / ApplicationEventPublisher | Hors scope PICOC — contexte est NestJS TypeScript. Candidat pour variant java-spring-boot si le PICOC est étendu. |
| arXiv preprints EDA microservices (≥3 articles) | Non peer-reviewed — thèses et preprints couvrant l'EDA en général sans focus sur les patterns de fiabilité spécifiques. Contenu absorbé par IEEE Xplore 2022 (peer-reviewed). |
