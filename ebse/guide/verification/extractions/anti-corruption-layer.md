# Double Extraction — PICOC anti-corruption-layer

**Date** : 2026-04-17
**Protocole** : methodology.md v3.0
**Agent A** : mots-clés : "anti-corruption layer DDD", "ACL bounded context translation", "anti-corruption layer hexagonal architecture", "domain model isolation external API", "strangler fig anti-corruption layer migration"
**Agent B** : mots-clés : "anti-corruption layer pattern implementation", "ACL adapter facade DDD bounded context", "domain isolation external integration NestJS", "anti-corruption layer microservices", "DDD anti-corruption layer TypeScript"

---

## PICOC

```
P  = Équipes développement implémentant des intégrations avec des APIs externes ou des bounded contexts adjacents
I  = Implémenter un Anti-Corruption Layer pour isoler le modèle de domaine interne
C  = Absence d'ACL — exposition directe des modèles externes dans le domaine interne
O  = Isolation du domaine, cohérence sémantique, testabilité, facilité de migration
Co = Applications DDD avec architecture hexagonale, intégrations tierces, migration monolithe → microservices
```

---

## Accord Reviewer A / Reviewer B

| # | Source | Niveau A | Niveau B | Accord ? | Note divergence |
|---|--------|---------|---------|:--------:|-----------------|
| 1 | Microsoft Azure Architecture Center — Anti-corruption Layer pattern (2025) | 4 | 4 | ✓ | — |
| 2 | AWS Prescriptive Guidance — Anti-corruption layer pattern (2023) | 4 | 4 | ✓ | — |
| 3 | DDD Practitioners — Anticorruption Layer (ddd-practitioners.com, 2023) | 3 | 3 | ✓ | — |
| 4 | AWS Prescriptive Guidance + Fowler — Strangler Fig pattern + ACL (2024) | 4 | 4 | ✓ | — |
| 5 | DEV Community / Sairyss — Domain-Driven Hexagon NestJS (dev.to, 2023) | absent | 3 | ✗ | **A ne cite pas, B cite directement** |

**Accord sur sources communes** : 4/4 → kappa = 1.0 (inclusion + niveau).
**Sources A-only** : aucune.
**Sources B-only** : DEV Community / Sairyss — Domain-Driven Hexagon NestJS.

### Résolution des divergences

**DEV Community / Sairyss (B-only)** : Inclus — articule directement le port secondaire (Driven Port) comme point d'implémentation naturel de l'ACL dans NestJS, avec la mécanique DI concrète. Pyramide 3 (guide technique communautaire régulièrement cité). Scope PICOC : OLS utilise NestJS comme backend principal (voir ols.json) et l'architecture hexagonale comme pattern structurant (voir `hexagonal-architecture` dans depends_on). La source est directement actionnable. Aucun risque de biais (guide technique avec code, pas vendor marketing).

---

## Calcul GRADE final

```
Score de départ : 1
  (source la plus haute directement pertinente = niveau 4 :
   Microsoft Azure Architecture Center et AWS Prescriptive Guidance documentent
   l'ACL comme pattern d'architecture cloud reconnu, issu directement d'Evans DDD)

+ 1 convergence
  Azure Architecture Center (Microsoft, niv.4) + AWS Prescriptive Guidance (Amazon, niv.4,
  deux documents distincts) + DDD Practitioners (communauté DDD, niv.3) convergent
  sans contradiction sur le même principe fondamental : l'ACL est une couche de
  traduction qui protège le modèle interne du modèle externe.
  Trois organisations indépendantes (Microsoft, Amazon, communauté DDD peer-reviewed)
  confirment : (1) traduction bidirectionnelle obligatoire, (2) façade partagée vs
  adapter individuel selon le nombre de consommateurs, (3) port secondaire hexagonal
  comme point d'implémentation.

Facteurs négatifs :
  - Pas d'incohérence entre sources (aucune source contredit les règles énoncées).
  - Indirectness légère : Evans DDD (2003) est la source primaire canonique mais
    n'est pas directement inclus — absorbé par Azure/AWS qui en sont la synthèse.
    Impact limité : les deux vendor docs citent explicitement Evans et reformulent
    fidèlement le pattern original.
  - Absence de sources niveau 1-2 (pas de standard normatif ni de guide OWASP-class
    pour ce pattern purement architectural) — inhérent au domaine.

Score final : 1 + 1 = 2 → [BONNE PRATIQUE]
```

Note biais de publication : faible — les sources vendor (Azure, AWS) documentent des patterns qu'elles ont intérêt à promouvoir pour leurs architectures cloud, mais le pattern ACL est antérieur (Evans 2003) et les deux vendors reproduisent fidèlement la définition originale. La source communautaire DDD Practitioners confirme indépendamment des deux vendors. Aucune contradiction détectée entre les sources : biais de publication non significatif.

---

## Analyse de sensibilité {#analyse-de-sensibilite}

| Source retirée | Score sans | Niveau sans | Changement ? |
|---------------|-----------|------------|:------------:|
| Azure Architecture Center | 2 (départ 1, +1 conv AWS + DDD Practitioners) | BONNE PRATIQUE | NON |
| AWS Prescriptive Guidance (les deux documents) | 2 (départ 1, +1 conv Azure + DDD Practitioners) | BONNE PRATIQUE | NON |
| DDD Practitioners | 2 (départ 1, +1 conv Azure + AWS — convergence intacte sur 2 orgs) | BONNE PRATIQUE | NON |
| DEV Community / Sairyss | 2 (source non décisive pour GRADE — niveau 3 B-only) | BONNE PRATIQUE | NON |
| Azure + AWS simultanément | 1 (départ 1, DDD Practitioners seul, pas de convergence multi-org) | INFORMATION | OUI |
| Toutes sources sauf une vendor | 1 (départ 1, convergence perdue) | INFORMATION | OUI |

**Conclusion : MODERE** — la recommandation [BONNE PRATIQUE] est stable pour tout retrait individuel de source. Elle devient [INFORMATION] si les deux sources vendor majeures (Azure + AWS) sont retirées simultanément, ce qui est un scénario peu probable (deux organizations indépendantes et majeures documentant le même pattern). La robustesse est modérée car le grade repose sur la convergence de sources vendor (niveau 4) sans source normative niveau 1-2 disponible dans ce domaine architectural — inhérent au type de pattern (conception logicielle, pas standard de sécurité).

---

## Sources exclues

| Source | Critère | Raison |
|--------|---------|--------|
| Evans "Domain-Driven Design" (Addison-Wesley, 2003) | E5 absorbé | Source primaire canonique mais livre non directement accessible ; Azure Architecture Center et AWS Prescriptive Guidance en sont la synthèse directement applicable et plus récente |
| Vernon "Implementing Domain-Driven Design" (Addison-Wesley, 2013) | E5 absorbé | Même raison — synthèse applicable couverte par AWS Prescriptive Guidance avec guidance d'implémentation plus concrète |
| Martin Fowler bliki — "AntiCorruptionLayer" | E3 redondance | Azure Architecture Center cite explicitement Evans/Fowler et couvre le même contenu avec plus de détails d'implémentation |
| DDD Europe talks (YouTube, ≥2 vidéos) | E3 redondance | Niveau 5 redondant — ddd-practitioners.com couvre le même contenu communautaire avec meilleure traçabilité |
| Articles académiques bounded contexts (≥3 papiers) | E2 indirect | Définissent le concept de bounded context mais sans guidance d'implémentation ACL concrète — hors scope PICOC |
| Blog posts techniques NestJS/DDD (≥5 sources) | E1 redondance | Niveau 5 redondant — DEV Community / Sairyss est plus complet, plus cité et couvre les mêmes patterns NestJS |
| Spring Boot DDD examples (Baeldung) | E2 scope | Implémentation stack-spécifique — candidat pour variant java-spring-boot, hors scope du principe universel |
