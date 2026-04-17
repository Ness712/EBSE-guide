# PRISMA Flow — feature-flags-lifecycle

**Date de recherche** : 2026-04-17
**Agents** : Reviewer A (indépendant) + Reviewer B (indépendant) — contextes séparés
**Bases interrogées** : martinfowler.com, Springer EMSE, ACM DL, IEEE Xplore, CNCF Landscape, SEC EDGAR, dora.dev, GitHub (OpenFeature, Unleash, Piranha), Google Scholar
**Mots-clés Agent A** : "feature flags lifecycle management technical debt", "feature toggles cleanup expiration empirical", "feature flag types release experiment ops permissioning", "Knight Capital feature flag incident", "OpenFeature CNCF vendor agnostic"
**Mots-clés Agent B** : "feature toggle debt accumulation practices", "stale feature flags removal automation", "feature flags trunk based development DORA", "feature flag incident postmortem", "feature flag NestJS React implementation"

---

## Flux PRISMA

```
IDENTIFICATION
  Sources identifiées par base :
    - Blogs experts reconnus (martinfowler.com)                : 1 source
    - Peer-reviewed empirique Springer EMSE / ACM FSE          : 2 sources
    - Documentation incident réglementaire (SEC + analyses)    : 1 source
    - Standards organisationnels (CNCF OpenFeature)            : 1 source
    - Rapports industrie (DORA 2024, trunkbaseddevelopment.com): 1 source
    - Documentation outils (Unleash, LaunchDarkly, Piranha)    : ~4 sources
    - Google Scholar (autres articles feature flags)           : ~8 sources
    - Snowballing (références croisées)                        : ~5 additionnelles
  Total identifié : ~23
  Doublons retirés : -3
  Total après déduplication : ~20

SCREENING (titre + résumé)
  Sources screenées : 20
  Sources exclues au screening : -9
    - E1 (> 5 ans ET non-standard/non-classique)  : -3
    - E2 (blog individuel sans peer review)        : -4
    - E3 (marketing outil propriétaire)            : -2

ÉLIGIBILITÉ (lecture complète)
  Sources évaluées en détail : 11
  Sources exclues après lecture : -5 (voir section Sources exclues)

INCLUSION
  Sources incluses dans la synthèse : 6
    - Niveau 2 (standard organisationnel CNCF)              : 1
    - Niveau 3 (peer-reviewed empirique / post-mortem officiel / rapport industrie) : 4
    - Niveau 5 (expert reconnu, référence de facto)         : 1
```

---

## Documentation recherche (Table 2 Kitchenham)

| Base | Termes utilisés | Date | Retenus |
|------|----------------|------|---------|
| martinfowler.com | "feature toggles", "feature flags lifecycle" | 2026-04-17 | 1 (Fowler/Hodgson 2017) |
| Springer EMSE | "feature flags empirical practices", "feature toggle technical debt" | 2026-04-17 | 1 (Kavaler 2021) |
| ACM DL / FSE | "feature flags scale Microsoft", "feature toggle management" | 2026-04-17 | 1 (Meijer 2022) |
| SEC EDGAR + analyses | "Knight Capital Group 2012 incident", "SMACRS feature flag" | 2026-04-17 | 1 (Knight Capital 2012) |
| CNCF / openfeature.dev | "OpenFeature specification SDK NestJS" | 2026-04-17 | 1 (OpenFeature CNCF 2023) |
| dora.dev / DORA 2024 | "trunk based development feature flags high performance" | 2026-04-17 | 1 (DORA 2024) |
| Documentation outils | "Unleash NestJS", "LaunchDarkly stale flags", "Uber Piranha" | 2026-04-17 | 0 (exclus E3) |
| Google Scholar | "feature flag defect incident empirical" | 2026-04-17 | 0 (absorbés par sources retenues) |

---

## Sources exclues (après lecture complète)

| Source | Critère | Raison |
|--------|---------|--------|
| Hodgson P. — "Testing with Feature Flags" (2017) | E5 partiel | Traite spécifiquement des stratégies de test avec les flags, pas du lifecycle. Contenu sur le cleanup absorbé par le même auteur dans "Feature Toggles" 2017 plus complet. |
| Schermann G. et al. — "An Empirical Study on the Usage of the Easy Button in CI" (MSR 2018) | E5 partiel | Traite des feature flags en contexte CI/CD mais sans étudier spécifiquement le lifecycle ou le cleanup. Insights absorbés par DORA 2024 + Meijer 2022. |
| Unleash docs — "Feature Toggle Types" | E3 | Documentation outil propriétaire. Taxonomie des types absorbée par Fowler/Hodgson 2017, plus complète et non biaisée commercialement. |
| LaunchDarkly — "The Definitive Guide to Feature Flags" | E3 | Whitepaper commercial. Statistiques utiles (73 % flags jamais supprimés) citées comme donnée industrie avec nuance — source principale non retenue comme référence primaire. |
| Rahman A. et al. — "Feature Flags in Practice" (arxiv 2021) | E1 | Preprint non peer-reviewed. Insights partiellement couverts par Kavaler 2021 (Springer EMSE, peer-reviewed). |
