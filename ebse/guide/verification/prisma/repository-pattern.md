# PRISMA Flow — PICOC repository-pattern

**Date de recherche** : 2026-04-17
**Bases interrogées** : martinfowler.com (PEAA catalog), cosmicpython.com / O'Reilly, matthiasnoback.nl, learn.microsoft.com (.NET Architecture Guide), docs.nestjs.com, github.com/prisma/prisma/discussions, khalilstemmler.com, WebSearch général
**Mots-clés Agent A** : "Repository pattern domain driven design", "Data Mapper persistence ignorance Fowler", "fake repository unit testing in-memory", "AbstractRepository port adapter pattern", "Repository pattern testability NestJS TypeORM"
**Mots-clés Agent B** : "Repository pattern Prisma NestJS", "custom repository TypeORM NestJS injectable", "Prisma repository pattern wrapper functions", "DDD repository pattern TypeScript", "making NestJS services testable repository"
**Protocole** : methodology.md v3.0 §2.1 — double extraction indépendante (Agents A + B, mots-clés différents) + synthèse Agent C

---

## Flux

```
IDENTIFICATION
  Sources identifiées par base (Agent A + Agent B combinés, avant déduplication) :
    - Livres et patterns fondateurs (Fowler PEAA, Percival & Gregory) : ~4 résultats candidats
    - Guides institutionnels (Microsoft .NET Architecture Guide) : ~3 résultats candidats
    - Documentation framework (NestJS TypeORM, NestJS Prisma recipe) : ~6 résultats candidats
    - Discussions communauté (Prisma GitHub, Stack Overflow) : ~8 résultats candidats
    - Blogs experts reconnus (khalilstemmler.com, matthiasnoback.nl) : ~6 résultats candidats
    - Articles académiques / surveys : ~3 résultats candidats
    - Snowballing backward (références citées par sources principales) : ~4 sources
  Total identifié (brut, combiné A+B) : ~34
  Doublons retirés (même source identifiée par A et B) : 4 (Fowler PEAA, Microsoft .NET Guide, NestJS TypeORM docs, Prisma Discussion #10584)
  Total après déduplication : ~30

SCREENING (titre + résumé)
  Sources screenées : ~30
  Sources exclues au screening : ~19
    - E1 (blog opinion sans données ni méthodologie) : ~7
    - E2 (hors scope PICOC — Repository pattern non-NestJS, langage autre) : ~5
    - E3 (doublons partiels — couverts par sources primaires) : ~4
    - E4 (vendeur / marketing sans substance technique) : ~3

ELIGIBILITÉ (lecture complète)
  Sources évaluées en détail : ~11
  Sources exclues après lecture complète : ~2
    - Medium "Making Your NestJS Services Testable" : couvert par Percival & Gregory + Noback avec plus de rigueur
    - Discussions Stack Overflow sur Repository vs DAO : hors scope PICOC strict (pas de guidance prescriptive actionnable)

INCLUSION
  Sources incluses dans la synthèse : 9
    - Niveau 5 : 2 (Fowler PEAA — Repository, Fowler PEAA — Data Mapper)
    - Niveau 4 : 1 (Microsoft .NET Architecture Guide 2023)
    - Niveau 3 : 6 (Percival & Gregory 2020, Noback 2018, NestJS TypeORM docs, NestJS Prisma recipe, Prisma Discussion #10584, Stemmler 2019)

  Sources exclues avec raison documentée : 4
    - Medium "Making Your NestJS Services Testable" : absorbé par Percival & Gregory + Noback (même contenu, moindre rigueur)
    - Stemmler K. khalilstemmler.com : inclus avec nuance (blog expert reconnu mais personnel — non peer-reviewed)
    - Stack Overflow discussions Repository vs DAO : pas de guidance prescriptive actionnable
    - Articles académiques sur l'efficacité du Repository pattern : trop indirects (population différente — systèmes legacy non-NestJS)
```

---

## Documentation recherche (Table 2 Kitchenham)

### Agent A — bases interrogées

| Élément | Valeur |
|---------|--------|
| Bases | martinfowler.com, cosmicpython.com / O'Reilly, matthiasnoback.nl, learn.microsoft.com, WebSearch général |
| Mots-clés | "Repository pattern domain driven design", "Data Mapper persistence ignorance Fowler", "fake repository unit testing in-memory", "AbstractRepository port adapter pattern", "Repository pattern testability NestJS TypeORM" |
| Période couverte | 2002-2024 |
| Sources identifiées | ~18 |
| Sources retenues | 5 (Fowler PEAA x2, Percival & Gregory, Noback, Microsoft .NET Guide) |
| Date d'extraction | 2026-04-17 |

### Agent B — bases interrogées

| Élément | Valeur |
|---------|--------|
| Bases | docs.nestjs.com, github.com/prisma/prisma/discussions, khalilstemmler.com, WebSearch général, Medium |
| Mots-clés | "Repository pattern Prisma NestJS", "custom repository TypeORM NestJS injectable", "Prisma repository pattern wrapper functions", "DDD repository pattern TypeScript", "making NestJS services testable repository" |
| Période couverte | 2018-2024 |
| Sources identifiées | ~16 |
| Sources retenues | 6 (Fowler PEAA, Microsoft .NET Guide, NestJS TypeORM docs, NestJS Prisma recipe, Prisma Discussion #10584, Stemmler 2019) |
| Date d'extraction | 2026-04-17 |

---

## Sources exclues — raisons documentées

| Source | Raison exclusion |
|--------|-----------------|
| Medium "Making Your NestJS Services Testable" [niv.3] | Contenu absorbé par Percival & Gregory 2020 (cosmicpython.com / O'Reilly) et Noback 2018 — mêmes points (custom repository améliore testabilité vs injection ORM directe) couverts avec plus de rigueur et de précision par ces deux sources |
| Stack Overflow — discussions Repository vs DAO (multiples) | Pas de guidance prescriptive actionnable. Opinions individuelles sans référence ni méthodologie. Non auditable. |
| Articles académiques sur Repository pattern (3 sources) | Trop indirects — études menées sur des systèmes legacy Java EE / .NET non-NestJS. Indirectness sévère (population différente). Non inclus car le score GRADE n'est pas modifié par ces sources et leur apport prescriptif est nul pour le contexte NestJS/TypeScript. |
| Fowler M. — "Repository" (Refactoring.com — catalog en ligne) | Redondant avec martinfowler.com/eaaCatalog/repository.html — même contenu, même auteur, même source. |
