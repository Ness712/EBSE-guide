# PRISMA Flow — PICOC anti-corruption-layer

**Date de recherche** : 2026-04-17
**Bases interrogées** : Microsoft Azure Architecture Center, AWS Prescriptive Guidance, DDD community (ddd-practitioners.com, Martin Fowler bliki), DEV Community, WebSearch général
**Mots-clés Agent A** : "anti-corruption layer DDD", "ACL bounded context translation", "anti-corruption layer hexagonal architecture", "domain model isolation external API", "strangler fig anti-corruption layer migration"
**Mots-clés Agent B** : "anti-corruption layer pattern implementation", "ACL adapter facade DDD bounded context", "domain isolation external integration NestJS", "anti-corruption layer microservices", "DDD anti-corruption layer TypeScript"
**Protocole** : methodology.md v3.0 §2.1 — double extraction indépendante (Agents A + B, mots-clés différents) + synthèse Agent C

---

## Flux

```
IDENTIFICATION
  Sources identifiées par base (Agent A + Agent B combinés, avant déduplication) :
    - Documentation architecture cloud (Azure Architecture Center, AWS Prescriptive Guidance) : 4 résultats candidats
    - Communautés DDD (ddd-practitioners.com, Fowler bliki, DDD Europe) : ~8 résultats candidats
    - Documentation framework (NestJS, Spring Boot) + guides DDD technique : ~10 résultats candidats
    - Articles blog + DEV Community (DDD/hexagonal architecture) : ~15 résultats candidats
    - Articles académiques / livres (Evans DDD, Vernon IDDD) : ~6 résultats candidats
    - Snowballing backward (références citées par Azure/AWS docs) : ~4 sources
  Total identifié (brut, combiné A+B) : ~47
  Doublons retirés (même source identifiée par A et B) : 4 (Azure Architecture Center, AWS ACL pattern, DDD Practitioners, AWS Strangler Fig)
  Total après déduplication : ~43

SCREENING (titre + résumé)
  Sources screenées : ~43
  Sources exclues au screening : ~28
    - E1 (blog opinion sans données ou méthodologie) : ~12
    - E2 (hors scope PICOC — DDD général, pas ACL spécifiquement) : ~8
    - E3 (doublons partiels — couverts par sources primaires déjà incluses) : ~5
    - E4 (vendeur / marketing sans substance technique) : ~3

ELIGIBILITÉ (lecture complète)
  Sources évaluées en détail : ~15
  Sources exclues après lecture complète : ~10
    - Hors scope PICOC strict (DDD général, pas ACL comme pattern d'implémentation) : 4
    - Niveau de preuve insuffisant (pure opinion, pas de référence à Evans ou source primaire) : 3
    - Redondance forte avec Azure Architecture Center ou AWS sans apport supplémentaire : 3

INCLUSION
  Sources incluses dans la synthèse : 5
    - Niveau 3 : 2 (DDD Practitioners, DEV Community / Sairyss NestJS)
    - Niveau 4 : 3 (Azure Architecture Center 2025, AWS ACL pattern 2023, AWS Strangler Fig 2024)

  Sources exclues avec raison documentée : 10
    - Evans "Domain-Driven Design" (2003) : source primaire canonique mais livre — absorbé par Azure/AWS docs qui en sont la synthèse directement applicable
    - Vernon "Implementing Domain-Driven Design" (2013) : même raison — synthèse applicable couverte par AWS Prescriptive Guidance
    - Martin Fowler bliki — "AntiCorruptionLayer" : redondant avec Azure Architecture Center qui cite explicitement Evans/Fowler
    - DDD Europe talks (YouTube) : niveau 5, redondant avec ddd-practitioners.com
    - Articles académiques sur bounded contexts (≥3) : indirects — définissent le concept sans guidance d'implémentation
    - Blog posts techniques NestJS/DDD (≥5) : niveau 5 redondant avec DEV Community / Sairyss qui est plus complet et cité
```

---

## Documentation recherche (Table 2 Kitchenham)

### Agent A — bases interrogées

| Élément | Valeur |
|---------|--------|
| Bases | Azure Architecture Center, AWS Prescriptive Guidance, ddd-practitioners.com, Martin Fowler bliki, WebSearch général |
| Mots-clés | "anti-corruption layer DDD", "ACL bounded context translation", "anti-corruption layer hexagonal architecture", "domain model isolation external API", "strangler fig anti-corruption layer migration" |
| Période couverte | 2003-2025 |
| Sources identifiées | ~24 |
| Sources retenues | 4 |
| Date d'extraction | 2026-04-17 |

### Agent B — bases interrogées

| Élément | Valeur |
|---------|--------|
| Bases | AWS Prescriptive Guidance, DEV Community, NestJS docs, DDD community blogs, WebSearch |
| Mots-clés | "anti-corruption layer pattern implementation", "ACL adapter facade DDD bounded context", "domain isolation external integration NestJS", "anti-corruption layer microservices", "DDD anti-corruption layer TypeScript" |
| Période couverte | 2013-2024 |
| Sources identifiées | ~23 |
| Sources retenues | 5 (convergence élevée avec A + DEV Community / Sairyss NestJS en plus) |
| Date d'extraction | 2026-04-17 |

---

## Sources exclues — raisons documentées

| Source | Raison exclusion |
|--------|-----------------|
| Evans "Domain-Driven Design" (Addison-Wesley, 2003) | Absorbé — source primaire canonique mais livre ; Azure Architecture Center et AWS Prescriptive Guidance en sont la synthèse directement applicable et plus récente |
| Vernon "Implementing Domain-Driven Design" (Addison-Wesley, 2013) | Même raison qu'Evans — synthèse applicable couverte par AWS Prescriptive Guidance avec guidance d'implémentation plus concrète |
| Martin Fowler bliki — "AntiCorruptionLayer" | Redondance — Azure Architecture Center cite explicitement Evans/Fowler et couvre le même contenu avec plus de détails d'implémentation |
| DDD Europe talks (YouTube, ≥2 vidéos) | Niveau 5 redondant — ddd-practitioners.com couvre le même contenu communautaire avec meilleure traçabilité |
| Articles académiques bounded contexts (≥3 papiers) | Indirects — définissent le concept de bounded context mais sans guidance d'implémentation ACL concrète |
| Blog posts techniques NestJS/DDD (≥5 sources) | Niveau 5 redondant — DEV Community / Sairyss est plus complet, plus cité et couvre les mêmes patterns NestJS |
| AWS CDK / CloudFormation patterns | Hors scope PICOC — implémentation infra, pas architecture logicielle applicative |
| Spring Boot DDD examples (Baeldung) | Hors scope du principe universel — candidat pour variant java-spring-boot |
