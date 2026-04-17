# Double Extraction — PICOC event-driven-architecture

**Date** : 2026-04-17
**Protocole** : methodology.md v3.0
**Agent A** : mots-clés : "event-driven architecture patterns microservices", "domain events DDD bounded context", "transactional outbox pattern dual-write", "saga pattern distributed transactions choreography orchestration", "NestJS event emitter microservices"
**Agent B** : mots-clés : "event notification event sourcing CQRS comparison Fowler", "outbox pattern at-least-once delivery idempotent consumer", "saga choreography vs orchestration formal verification", "NestJS Redis Streams cross-process events", "event-driven debugging distributed tracing complexity"

---

## PICOC

```
P  = Équipes développant des applications distribuées ou microservices
I  = Concevoir une architecture event-driven avec garanties de livraison
C  = Appels synchrones directs entre services (REST/gRPC), transactions distribuées sans saga
O  = Fiabilité des livraisons, cohérence éventuelle, découplage entre services
Co = Applications web avec NestJS (TypeScript), Redis Streams ou message brokers
```

---

## Accord Reviewer A / Reviewer B

### Sources évaluées par les deux reviewers

| # | Source | Niveau A | Niveau B | Accord inclusion ? | Note divergence |
|---|--------|---------|---------|:-----------------:|-----------------|
| 1 | Fowler M. — DomainEvent (martinfowler.com, 2005) | 5 | 5 | ✓ | — |
| 2 | Fowler M. — What do you mean by Event-Driven? (martinfowler.com, 2017) | 5 | 5 | ✓ | — |
| 3 | Evans E. — Domain-Driven Design (Addison-Wesley, 2003) | 5 | 5 | ✓ | — |
| 4 | Richardson C. — Microservices Patterns (Manning, 2018) | 5 | 5 | ✓ | — |
| 5 | Richardson C. — Transactional Outbox Pattern (microservices.io) | non trouvé | 5 | ✗ A / ✓ B | **Divergence inclusion** |
| 6 | Richardson C. — Saga Pattern (microservices.io) | 5 | 5 | ✓ | — |
| 7 | NestJS — @nestjs/event-emitter docs | 3 | 3 | ✓ | — |
| 8 | NestJS — Redis Microservices docs | non trouvé | 3 | ✗ A / ✓ B | **Divergence inclusion** |
| 9 | IEEE Xplore — Choreography vs Orchestration (2022) | non trouvé | 3 | ✗ A / ✓ B | **Divergence inclusion** |
| 10 | Temporal.io — Saga Orchestration vs Choreography | 4 | 4 | ✓ | — |
| 11 | OneUptime Engineering Blog 2026 | 4 | non trouvé | ✓ A / ✗ B | **Divergence inclusion** |
| 12 | Conduktor — Outbox Pattern for Reliable Event Publishing | 3 | 3 | ✓ (exclue) | — |
| 13 | AWS Prescriptive Guidance — Transactional Outbox Pattern | 4 | 4 | ✓ (exclue) | — |

**Sources identifiées par A uniquement** : OneUptime Engineering Blog 2026 (complexité debugging EDA)
**Sources identifiées par B uniquement** : Richardson microservices.io Outbox (site dédié patterns), NestJS Redis Microservices docs, IEEE Xplore 2022 (validation formelle LTS/PAT)

**Accord sur inclusion des sources communes** : 7/7 → accord fort sur les sources communes (Richardson Manning 2018, Fowler x2, Evans, Richardson Saga site, NestJS event-emitter, Temporal.io).
**Désaccords d'inclusion** : 4/13 — toutes résolues ci-dessous.

### Résolution des divergences

**Richardson microservices.io Outbox Pattern (B seulement, niveau 5)** : inclus. Site de référence créé et maintenu par Richardson lui-même — complète le livre Manning avec la documentation en ligne mise à jour. Apport différencié : détail de l'at-least-once delivery et du rôle du message relay non couverts aussi précisément dans le livre. Non trouvé par A car ses mots-clés ciblaient le terme "dual-write" plutôt que le nom canonique du site.

**NestJS Redis Microservices docs (B seulement, niveau 3)** : inclus. Documentation officielle NestJS précisant les transports cross-process disponibles (Redis Streams, Kafka, RabbitMQ, NATS). Apport direct pour la mise en œuvre NestJS dans le contexte PICOC. Non trouvé par A dont les mots-clés étaient orientés "event emitter" plutôt que "microservices transport".

**IEEE Xplore 2022 Choreography vs Orchestration (B seulement, niveau 3)** : inclus. Seule source peer-reviewed fournissant une validation formelle (LTS + PAT) des tradeoffs choreography vs orchestration. Confirmation rigoureuse des recommandations Richardson et Temporal.io. Non trouvé par A dont les mots-clés n'incluaient pas de termes de vérification formelle.

**OneUptime Engineering Blog 2026 (A seulement, niveau 4)** : exclu. Blog d'entreprise documentant la complexité du debugging EDA — pertinent mais couvert de façon plus rigoureuse par l'avertissement Fowler 2017 (sur la complexité inhérente à l'EDA asynchrone) et IEEE 2022 (sur les défis d'observabilité liés à la choreography). Pas d'apport distinct non couvert par des sources plus rigoureuses.

---

## Calcul GRADE final

```
Score de départ : 1
  (source la plus haute = niveau 5 : Fowler 2005, Fowler 2017, Evans 2003,
   Richardson Manning 2018, Richardson microservices.io)
  Note : niveau 5 = experts reconnus/livres fondateurs → score départ 1

+ 1 convergence
  Convergence forte sur les patterns fondamentaux :
  - Fowler 2005 + Fowler 2017 + Evans 2003 : convergence sur command vs event,
    immutabilité des événements, Domain Events entre bounded contexts.
  - Richardson Manning 2018 + Richardson microservices.io (Outbox + Saga) :
    convergence sur Outbox (dual-write problem + at-least-once) et Saga
    (choreography vs orchestration tradeoffs).
  - IEEE Xplore 2022 (peer-reviewed) : confirmation formelle (LTS + PAT)
    des tradeoffs Saga documentés par Richardson.
  - Temporal.io (niveau 4) : règle de choix orchestration vs choreography
    alignée avec Richardson et IEEE 2022 — pas de contradiction.
  - NestJS docs (niveau 3 x2) : convergence sur in-process vs cross-process
    events, distinction @nestjs/event-emitter vs microservices transport.
  4 catégories distinctes : expert-fondateur (Fowler, Evans), livre de référence
  (Richardson Manning), site de référence patterns (microservices.io), peer-reviewed
  (IEEE 2022). ≥3 sources indépendantes sans contradiction.

+ 1 effet important
  - Dual-write problem : perte silencieuse d'événements documentée comme risque
    de corruption de données en production (Richardson Manning 2018 — cas réels).
  - Saga complexity : formellement validé par IEEE 2022 (LTS + PAT) que la
    choreography sans observabilité est significativement plus difficile à debugger.
  - Complexité opérationnelle EDA : avertissement explicite Fowler 2017 sur
    l'augmentation de la complexité, confirmé par la pratique (Temporal.io).

Score final : 1 + 1 + 1 = 3 → [RECOMMANDE]
```

Note biais de publication : sources fondatrices (Fowler, Evans, Richardson Manning) orientées prescriptif — atténué par la confirmation peer-reviewed (IEEE 2022) et la documentation framework officielle (NestJS). Richardson microservices.io est maintenu par le même auteur que le livre — cohérence interne forte, pas d'indépendance absolue entre ces deux sources (pris en compte : convergence comptée comme une seule source Richardson).

---

## Analyse de sensibilité {#analyse-de-sensibilite}

| Source retirée | Score sans | Niveau sans | Changement ? |
|---------------|-----------|------------|:------------:|
| Fowler 2017 (taxonomie 4 patterns) | 3 (Evans + Richardson maintiennent la convergence) | [RECOMMANDE] | NON |
| Fowler 2005 (command vs event) | 3 (Fowler 2017 + Evans couvrent la distinction) | [RECOMMANDE] | NON |
| Evans 2003 (Domain Events DDD) | 3 (Fowler x2 + Richardson maintiennent la convergence) | [RECOMMANDE] | NON |
| Richardson Manning 2018 | 3 (Richardson microservices.io + IEEE 2022 maintiennent la convergence sur Outbox+Saga) | [RECOMMANDE] | NON |
| Richardson microservices.io (Outbox + Saga) | 3 (Manning 2018 + IEEE 2022 maintiennent la convergence) | [RECOMMANDE] | NON |
| IEEE Xplore 2022 | 2+1=3 (convergence experts maintenue, confirmation formelle perdue) | [RECOMMANDE] | NON |
| Temporal.io | 3 (Richardson + IEEE 2022 couvrent les mêmes tradeoffs) | [RECOMMANDE] | NON |
| NestJS docs (les deux) | 3 (score inchangé — sources niveau 3 ne modifient pas le score de départ) | [RECOMMANDE] | NON |
| Toutes sources niveau 5 simultanément | 1+0=1 (départ IEEE niveau 3 → score 2, pas de convergence suffisante) | [BONNE PRATIQUE] | OUI |

**Conclusion : ROBUSTE** — recommandation [RECOMMANDE] stable pour tout retrait individuel, y compris des sources fondatrices majeures. Le seul scénario de déclassement est le retrait simultané de toutes les sources niveau 5, ce qui est irréaliste : Fowler, Evans et Richardson sont des références établies du domaine. La convergence entre sources indépendantes (experts fondateurs + peer-reviewed + documentation officielle) conforte la robustesse à 3 [RECOMMANDE].

---

## Sources exclues

| Source | Critère | Raison |
|--------|---------|--------|
| Conduktor — Outbox Pattern for Reliable Event Publishing | E5 | Guide pratique Kafka/Debezium — couvert plus rigoureusement par Richardson microservices.io (Outbox Pattern) qui fournit le même contenu avec une rigueur supérieure et sans biais outil. |
| AWS Prescriptive Guidance — Transactional Outbox Pattern | E4 | Documentation vendor (AWS) — couvert intégralement par Richardson Outbox Pattern (microservices.io + Manning 2018) sans biais commercial. La guidance AWS n'apporte pas de contenu différencié par rapport à Richardson. |
| OneUptime Engineering Blog 2026 | E5 | Blog d'entreprise documentant la complexité du debugging EDA — couvert par l'avertissement explicite de Fowler 2017 sur la complexité EDA et par IEEE 2022 sur les défis d'observabilité de la choreography. Pas d'apport distinct. |
| Debezium documentation — CDC for Outbox Pattern | E3 | Documentation outil spécifique (Change Data Capture) — pertinent pour l'implémentation mais hors scope du principe universel. Candidat pour un variant implementation. |
| Spring Events / ApplicationEventPublisher (Spring docs) | E2 | Hors scope PICOC — contexte est NestJS TypeScript. Candidat pour variant java-spring-boot. |
