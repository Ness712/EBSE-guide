# PRISMA Flow — legacy-refactoring

**Date de recherche** : 2026-04-17
**Agents** : Reviewer A (indépendant) + Reviewer B (indépendant) — contextes séparés
**Bases interrogées** : SWEBOK v4, ISO/IEC/IEEE 14764:2022, martinfowler.com, littérature SE classique, IEEE ICSE / ACM DL, ScienceDirect, Google Scholar, microservices.io
**Mots-clés Agent A** : "strangler fig pattern legacy migration", "branch by abstraction refactoring incremental", "big bang rewrite risk software", "legacy code characterization tests", "technical debt refactoring empirical"
**Mots-clés Agent B** : "incremental refactoring vs big bang rewrite comparison", "strangler application pattern Martin Fowler", "working effectively legacy code Feathers", "ISO 14764 software maintenance types", "NestJS Express migration incremental"

---

## Flux PRISMA

```
IDENTIFICATION
  Sources identifiées par base :
    - Standards IEEE/ISO (SWEBOK v4, ISO 14764:2022)          : 2 références
    - Patterns architecture (martinfowler.com, paulhammant.com,
      microservices.io)                                        : 3 sources
    - Livres SE classiques (Feathers, Fowler Refactoring,
      Spolsky, Evans DDD)                                      : 5 sources
    - Peer-reviewed empirique (ICSE, TSE, ScienceDirect)      : 4 sources
    - Articles practitioners (migration NestJS, Express)       : ~5 sources
    - Google Scholar (surveys dette technique, migration)      : ~6 sources
    - Snowballing (références croisées)                        : ~4 additionnelles
  Total identifié : ~29
  Doublons retirés : -3
  Total après déduplication : ~26

SCREENING (titre + résumé)
  Sources screenées : 26
  Sources exclues au screening : -10
    - E1 (> 5 ans ET non-standard/non-classique) : -3
    - E2 (blog individuel sans peer review)       : -5
    - E3 (documentation outil sans peer review)   : -2

ÉLIGIBILITÉ (lecture complète)
  Sources évaluées en détail : 16
  Sources exclues après lecture : -9 (voir section Sources exclues)

INCLUSION
  Sources incluses dans la synthèse : 7
    - Niveau 1 (standard normatif IEEE/ISO)                    : 2
    - Niveau 3 (peer-reviewed empirique / practitioner reconnu): 1
    - Niveau 5 (experts reconnus, livres et articles fondateurs): 4
```

---

## Documentation recherche (Table 2 Kitchenham)

| Base | Termes utilisés | Date | Retenus |
|------|----------------|------|---------|
| SWEBOK v4 | "software maintenance", "incremental refactoring", "legacy system" | 2026-04-17 | 1 (SWEBOK v4 KA Maintenance) |
| ISO | "ISO 14764 maintenance types corrective preventive adaptive perfective" | 2026-04-17 | 1 (ISO/IEC/IEEE 14764:2022) |
| martinfowler.com | "StranglerFigApplication", "BranchByAbstraction" | 2026-04-17 | 2 (StranglerFig 2004, BranchByAbstraction 2011) |
| Littérature SE classique | "Feathers Working Effectively Legacy Code", "Spolsky rewrite" | 2026-04-17 | 2 (Feathers 2004, Spolsky 2000) |
| microservices.io | "strangler fig microservices migration 2023" | 2026-04-17 | 1 (Richardson 2023) |
| IEEE ICSE / ScienceDirect | "technical debt SATD refactoring empirical", "legacy code migration study" | 2026-04-17 | 0 (absorbés par sources retenues, cités comme support) |

---

## Accord Reviewer A / Reviewer B

### Sources évaluées par les deux reviewers

| # | Source | Niveau A | Niveau B | Accord inclusion ? | Note divergence |
|---|--------|---------|---------|:-----------------:|-----------------|
| 1 | SWEBOK v4 — KA Software Maintenance (2024) | 1 | 1 | ✓ | — |
| 2 | ISO/IEC/IEEE 14764:2022 — Software Maintenance | 1 | 1 | ✓ | — |
| 3 | Fowler M. — StranglerFigApplication (2004) | 5 | 5 | ✓ | — |
| 4 | Feathers M. — Working Effectively with Legacy Code (2004) | 5 | 5 | ✓ | — |
| 5 | Hammant P. / Fowler M. — Branch by Abstraction (2007/2011) | 5 | 5 | ✓ | — |
| 6 | Spolsky J. — Things You Should Never Do (2000) | 5 | 5 | ✓ | — |
| 7 | Richardson C. — Strangler Fig Microservices (2023) | 3 | 3 | ✓ | — |
| 8 | Evans E. — Domain-Driven Design (2003) | 5 | 5 | ✗ | Exclu : pertinent pour bounded contexts mais hors périmètre direct du pattern Strangler Fig |
| 9 | Martin R. — Clean Architecture (2017) | 5 | 5 | ✗ | Exclu : absorbé par Fowler Refactoring + Feathers pour les aspects pertinents |
| 10 | paulhammant.com — articles CI/CD | 5 | non trouvé | ✓ A / ✗ B | **Divergence** — résolu : absorbé par Hammant/Fowler 2007/2011 |

**Accord sur inclusion des sources communes** : 7/8 → kappa élevé.
**Désaccords d'inclusion** : paulhammant.com articles CI/CD (résolu — absorbé).

### Résolution des divergences

**paulhammant.com articles CI/CD additionnels (A seulement)** : exclus. Le contenu pertinent de Branch by Abstraction est couvert par la source primaire (paulhammant.com 2007 + Fowler 2011). Les articles CI/CD additionnels de Hammant sur trunk-based development sont hors périmètre de ce PICOC.

---

## Sources exclues

| Source | Critère | Raison |
|--------|---------|--------|
| Evans E. — Domain-Driven Design (2003) | E5 | Pertinent pour les bounded contexts dans le contexte Strangler Fig, mais hors périmètre direct du PICOC. Contenu partiellement absorbé par Richardson 2023 (microservices.io). |
| Martin R. — Clean Architecture (2017) | E5 | Principes architecturaux généraux sans traitement direct du pattern Strangler Fig ni du code legacy. Contenu SE absorbé par Fowler + Feathers. |
| Tornhill A. — Your Code as a Crime Scene (2015) | E5 | Outils d'analyse code legacy intéressants mais hors périmètre — le PICOC porte sur les stratégies de migration, pas l'analyse forensique. |
| Kim et al. — DevOps Handbook (2016) | E5 | Mentionne la migration incrémentale mais sans la rigueur de Feathers ou Fowler sur les patterns spécifiques. Partiellement hors périmètre (DevOps practices > legacy patterns). |
| Newman S. — Building Microservices 2nd ed. (2021) | E5 | Traite du Strangler Fig dans le contexte microservices mais de façon moins approfondie que Richardson 2023 (microservices.io) qui est plus récent et plus spécifique. Absorbé. |
| Suryanarayana G. et al. — Refactoring for SW Design Smells (2014) | E1 | > 5 ans, non normatif. Contenu partiellement couvert par Fowler Refactoring 2018. |
| Blogs "Express to NestJS migration guide" (multiples) | E2 | Articles individuels sans peer review. Valeur procédurale mais non auditable. Cités comme contexte practitioner dans le principe sans être sources formelles. |
| Microsoft — "Strangler Fig pattern" (docs.microsoft.com) | E3 | Documentation vendor (Microsoft Azure). Biais vers les solutions cloud Microsoft. Contenu conceptuel absorbé par les sources primaires. |
| ScienceDirect — études SATD co-occurrence | E5 partiel | Pertinentes pour le contexte dette technique mais indirectes par rapport au PICOC (stratégie de migration spécifique). Citées comme support empirique contextuel dans le principe. |
