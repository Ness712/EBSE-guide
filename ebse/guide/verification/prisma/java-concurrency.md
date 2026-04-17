# PRISMA Flow — PICOC java-concurrency

**Date de recherche** : 2026-04-17
**Bases interrogées** : OpenJDK JEP repository, docs.spring.io / spring.io/blog, InfoQ, Oracle Java documentation, Addison-Wesley library, WebSearch général
**Mots-clés Agent A** : "JEP 444 virtual threads Java 21", "virtual threads pinning synchronized carrier thread", "thread-per-request model Java Loom", "virtual threads pooling anti-pattern", "JFR jdk.VirtualThreadPinned diagnostic"
**Mots-clés Agent B** : "structured concurrency JEP 453 StructuredTaskScope", "Spring Boot virtual threads spring.threads.virtual.enabled", "ScopedValue ThreadLocal virtual threads JEP 446", "virtual threads CPU-bound limitations", "ReentrantLock synchronized virtual threads migration"
**Protocole** : methodology.md v3.0 §2.1 — double extraction indépendante (Agents A + B, mots-clés différents) + synthèse Agent C

---

## Flux

```
IDENTIFICATION
  Sources identifiées par base (Agent A + Agent B combinés, avant déduplication) :
    - Standards normatifs (JEPs OpenJDK/JCP) : 4 résultats candidats (JEP 444, JEP 453, JEP 446, JEP 425)
    - Documentation framework (Spring Boot, Quarkus, Micronaut) : ~6 résultats candidats
    - Livres de référence (Goetz JCIP, Lea CPJ) : ~3 résultats candidats
    - Articles experts / conférences (InfoQ, JVM Summit, Devoxx) : ~10 résultats candidats
    - Benchmarks / études de performance (TechEmpower, mesures communauté) : ~5 résultats candidats
    - Snowballing backward (références citées par JEP 444 et JEP 453) : ~3 sources
  Total identifié (brut, combiné A+B) : ~31
  Doublons retirés (même source identifiée par A et B) : 5 (JEP 444, JEP 453, Spring Boot docs, Goetz JCIP, Parlog/InfoQ)
  Total après déduplication : ~26

SCREENING (titre + résumé)
  Sources screenées : ~26
  Sources exclues au screening : ~17
    - E1 (blog opinion sans données ou méthodologie) : ~7
    - E2 (hors scope PICOC — concurrence générale, pas virtual threads Java 21) : ~4
    - E3 (doublons partiels — couverts par JEPs déjà inclus) : ~3
    - E4 (vendeur / marketing sans substance technique) : ~3

ELIGIBILITÉ (lecture complète)
  Sources évaluées en détail : ~9
  Sources exclues après lecture complète : ~4
    - Hors scope PICOC strict (Quarkus/Micronaut virtual threads — implémentation framework non-Spring) : 2
    - Niveau de preuve insuffisant (benchmarks communauté non reproductibles, méthodologie absente) : 1
    - Redondance forte avec JEP 444 sans apport supplémentaire (JEP 425 — preview Java 19) : 1

INCLUSION
  Sources incluses dans la synthèse : 5
    - Niveau 1 : 2 (JEP 444, JEP 453)
    - Niveau 3 : 1 (Spring Boot documentation 3.2+)
    - Niveau 4 : 1 (InfoQ / Nicolai Parlog)
    - Niveau 5 : 1 (Brian Goetz — Java Concurrency in Practice)

  Sources exclues avec raison documentée : 4
    - JEP 446 — ScopedValue (preview) : absorbé par Parlog/InfoQ qui documente ScopedValue vs ThreadLocal avec plus de nuance opérationnelle
    - JEP 425 — Virtual Threads (preview Java 19) : supplanté par JEP 444 (version finale Java 21 LTS)
    - TechEmpower benchmarks virtual threads : méthodologie insuffisamment documentée pour le contexte PICOC (benchmarks micro, pas représentatifs d'applications réelles)
    - Quarkus/Micronaut virtual threads documentation : hors scope — OLS utilise Spring Boot ; couverture universelle assurée par JEPs + Spring Boot docs
```

---

## Documentation recherche (Table 2 Kitchenham)

### Agent A — bases interrogées

| Élément | Valeur |
|---------|--------|
| Bases | OpenJDK JEP repository, Oracle Java docs, InfoQ, WebSearch général |
| Mots-clés | "JEP 444 virtual threads Java 21", "virtual threads pinning synchronized carrier thread", "thread-per-request model Java Loom", "virtual threads pooling anti-pattern", "JFR jdk.VirtualThreadPinned diagnostic" |
| Période couverte | 2006-2024 |
| Sources identifiées | ~16 |
| Sources retenues | 4 |
| Date d'extraction | 2026-04-17 |

### Agent B — bases interrogées

| Élément | Valeur |
|---------|--------|
| Bases | OpenJDK JEP repository, docs.spring.io, spring.io/blog, Addison-Wesley library, WebSearch |
| Mots-clés | "structured concurrency JEP 453 StructuredTaskScope", "Spring Boot virtual threads spring.threads.virtual.enabled", "ScopedValue ThreadLocal virtual threads JEP 446", "virtual threads CPU-bound limitations", "ReentrantLock synchronized virtual threads migration" |
| Période couverte | 2006-2024 |
| Sources identifiées | ~15 |
| Sources retenues | 5 (convergence élevée avec A + Spring Boot docs en plus) |
| Date d'extraction | 2026-04-17 |

---

## Sources exclues — raisons documentées

| Source | Raison exclusion |
|--------|-----------------|
| JEP 446 — ScopedValue (OpenJDK, preview) | Absorbé — Parlog/InfoQ documente ScopedValue vs ThreadLocal avec la nuance opérationnelle nécessaire ; JEP 446 lui-même encore en évolution (non finalisé Java 21) |
| JEP 425 — Virtual Threads preview Java 19 (OpenJDK, 2022) | Supplanté par JEP 444 (version finale stable Java 21 LTS — même auteurs, même contenu, version normative plus récente) |
| TechEmpower Framework Benchmarks — virtual threads (2023) | Méthodologie benchmarks micro insuffisamment documentée pour conclure sur des applications réelles ; JEP 444 fournit le cadre théorique plus fiable sur le modèle de performance |
| Quarkus virtual threads documentation (Red Hat, 2024) | Hors scope — OLS stack est Spring Boot ; couverture du principe universel assurée par JEPs + Spring Boot docs ; candidat pour variant quarkus si ajouté |
| Micronaut virtual threads documentation (Object Computing, 2024) | Hors scope — même raison que Quarkus ; la règle universelle (JEPs) couvre l'essentiel indépendamment du framework |
