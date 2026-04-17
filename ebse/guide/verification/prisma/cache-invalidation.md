# PRISMA Flow — PICOC cache-invalidation

**Date de recherche** : 2026-04-17
**Bases interrogées** : Redis documentation officielle, Microsoft Azure Architecture Center, NestJS documentation officielle, martinfowler.com, WebSearch général
**Mots-clés Agent A** : "cache invalidation strategies TTL write-through write-behind", "cache-aside pattern lazy loading implementation", "Redis DEL UNLINK cache invalidation", "event-driven cache invalidation domain events", "cache stampede thundering herd mitigation"
**Mots-clés Agent B** : "write-through write-behind cache consistency tradeoffs", "Microsoft Azure cache-aside pattern", "NestJS cache-manager CACHE_MANAGER invalidation", "Redis eviction policies expiration", "Phil Karlton cache invalidation naming things"
**Protocole** : methodology.md v3.0 §2.1 — double extraction indépendante (Agents A + B, mots-clés différents) + synthèse Agent C

---

## Flux

```
IDENTIFICATION
  Sources identifiées par base (Agent A + Agent B combinés, avant déduplication) :
    - Documentation officielle Redis (redis.io) : ~8 résultats candidats
    - Microsoft Azure Architecture Center : ~6 résultats candidats
    - NestJS documentation officielle : ~4 résultats candidats
    - martinfowler.com / bliki : ~5 résultats candidats
    - Articles académiques / performance engineering : ~6 résultats candidats
    - Blog posts techniques (engineering blogs) : ~12 résultats candidats
    - Snowballing backward (références citées par sources principales) : ~4 sources
  Total identifié (brut, combiné A+B) : ~45
  Doublons retirés (même source identifiée par A et B) : 4 (Redis docs, Azure Cache-Aside, NestJS docs, Karlton quote via Fowler)
  Total après déduplication : ~41

SCREENING (titre + résumé)
  Sources screenées : ~41
  Sources exclues au screening : ~29
    - E1 (blog opinion sans données ou méthodologie) : ~10
    - E2 (hors scope PICOC — cache HTTP, CDN, browser cache) : ~8
    - E3 (doublons partiels — couverts par sources primaires déjà incluses) : ~6
    - E4 (vendeur / marketing sans substance technique) : ~5

ELIGIBILITÉ (lecture complète)
  Sources évaluées en détail : ~12
  Sources exclues après lecture complète : ~7
    - Hors scope PICOC strict (cache distribué multi-nœuds, pas invalidation applicative) : 3
    - Niveau de preuve insuffisant (anecdotique, pas de guidance prescriptive) : 2
    - Redondance forte avec sources incluses sans apport différencié : 2

INCLUSION
  Sources incluses dans la synthèse : 5
    - Niveau 3 : 4 (Redis docs, Azure Cache-Aside, Azure Write-Through/Write-Behind, NestJS docs)
    - Niveau 5 : 1 (Karlton 1996 via Fowler)

  Sources exclues avec raison documentée : 7
    - Google Cloud Memorystore docs : couvert par Redis docs (même API, même patterns)
    - AWS ElastiCache docs : couvert par Redis docs, scope AWS hors sujet
    - Varnish Cache documentation : hors scope (proxy cache HTTP, pas applicatif)
    - Fowler "PoEAA" — pattern Cache : absorbé par Azure Architecture Center (plus récent, plus opérationnel)
    - Hazard G. — "Write-Through, Write-Around, Write-Back" blog : niveau 5 redondant avec Azure docs
    - Academic papers sur cache consistency : très théoriques, peu prescriptifs pour l'implémentation
    - Spring Cache docs : hors scope du principe universel (variant stack)
```

---

## Documentation recherche (Table 2 Kitchenham)

### Agent A — bases interrogées

| Élément | Valeur |
|---------|--------|
| Bases | Redis documentation, Azure Architecture Center, martinfowler.com, WebSearch général |
| Mots-clés | "cache invalidation strategies TTL write-through write-behind", "cache-aside pattern lazy loading", "Redis DEL UNLINK cache invalidation", "event-driven cache invalidation" |
| Période couverte | 2020-2024 |
| Sources identifiées | ~24 |
| Sources retenues | 4 |
| Date d'extraction | 2026-04-17 |

### Agent B — bases interrogées

| Élément | Valeur |
|---------|--------|
| Bases | Microsoft Azure docs, NestJS documentation, martinfowler.com/bliki, Redis documentation |
| Mots-clés | "write-through write-behind cache consistency tradeoffs", "Microsoft Azure cache-aside pattern", "NestJS cache-manager CACHE_MANAGER invalidation", "Redis eviction policies expiration" |
| Période couverte | 2020-2024 |
| Sources identifiées | ~21 |
| Sources retenues | 5 (convergence élevée avec A + Karlton via Fowler en plus) |
| Date d'extraction | 2026-04-17 |

---

## Sources exclues — raisons documentées

| Source | Raison exclusion |
|--------|-----------------|
| Google Cloud Memorystore documentation | Redondance — même API Redis, patterns identiques. Couvert par Redis docs officielle |
| AWS ElastiCache documentation | Redondance — même patterns Redis. Scope AWS cloud hors sujet pour principe universel |
| Varnish Cache documentation | Hors scope PICOC — cache HTTP proxy, pas invalidation cache applicatif côté serveur |
| Fowler — Patterns of Enterprise Application Architecture (cache pattern) | Absorbé par Azure Architecture Center (2023, plus opérationnel et plus récent) |
| Blog posts engineering (≥5 sources) | Niveau 5 redondant — Azure docs couvrent les mêmes patterns avec plus de rigueur |
| Papers académiques cache consistency | Très théoriques (CAP theorem, linearizability) — peu prescriptifs pour l'implémentation |
| Spring Cache / @Cacheable docs | Hors scope du principe universel — candidat pour variant java-spring-boot |
