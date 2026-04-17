# PRISMA Flow — dry-principle

**Date de recherche** : 2026-04-17
**Agents** : Reviewer A (indépendant) + Reviewer B (indépendant) — contextes séparés
**Bases interrogées** : SWEBOK v4, littérature SE classique (Hunt & Thomas, McConnell, Fowler), IEEE TSE / ACM DL (Kapser, Mäntylä, Koschke), Google Scholar, arXiv, Dagstuhl Seminar Proceedings
**Mots-clés Agent A** : "DRY don't repeat yourself software engineering", "code duplication maintainability", "abstraction premature refactoring", "single source of truth code", "code clone defect density"
**Mots-clés Agent B** : "rule of three refactoring", "code clone detection impact", "duplicate code defect density", "WET vs DRY tradeoff", "code smell duplication empirical"

---

## Flux PRISMA

```
IDENTIFICATION
  Sources identifiées par base :
    - Standards IEEE/ISO (SWEBOK v4, ISO 25010)             : 2 références
    - Livres SE classiques (Hunt & Thomas, McConnell,
      Fowler, Beck, Martin)                                 : 5 sources
    - Peer-reviewed empirique IEEE TSE / ACM DL
      (Kapser 2008, Mäntylä 2006, Koschke 2007,
       Juergens 2009, Roy 2009)                             : 5 sources
    - Surveys / proceedings Dagstuhl                        : 2 sources
    - Google Scholar (blogs influents, articles SO survey)  : ~5 sources
    - Snowballing (références croisées)                     : ~4 additionnelles
  Total identifié : ~23
  Doublons retirés : -3
  Total après déduplication : ~20

SCREENING (titre + résumé)
  Sources screenées : 20
  Sources exclues au screening : -8
    - E1 (> 5 ans ET non-standard/non-classique) : -2
    - E2 (blog individuel sans peer review)       : -4
    - E3 (marketing outil de detection clones)    : -1
    - E5 (hors périmètre — design patterns
          génériques sans lien DRY/duplication)   : -1

ÉLIGIBILITÉ (lecture complète)
  Sources évaluées en détail : 12
  Sources exclues après lecture : -5 (voir extraction file)

INCLUSION
  Sources incluses dans la synthèse : 7
    - Niveau 1 (standard IEEE normatif)                       : 1
    - Niveau 3 (peer-reviewed empirique IEEE TSE / Dagstuhl) : 3
    - Niveau 5 (experts reconnus, livres fondateurs)          : 3
```

---

## Documentation recherche (Table 2 Kitchenham)

| Base | Termes utilisés | Date | Retenus |
|------|----------------|------|---------|
| SWEBOK v4 | "software construction", "duplication", "single source of truth" | 2026-04-17 | 1 (SWEBOK v4 ch.4) |
| Littérature SE classique | "Hunt Thomas Pragmatic Programmer", "McConnell Code Complete", "Fowler Refactoring rule of three" | 2026-04-17 | 3 |
| IEEE TSE | "Kapser Godfrey code clones", "Mäntylä Lassenius code smells" | 2026-04-17 | 2 |
| Dagstuhl / ACM | "Koschke clone survey", "Roy Cordy clone taxonomy" | 2026-04-17 | 1 (Koschke 2007) |
| Google Scholar | "WET DRY tradeoff empirical", "code duplication defect density" | 2026-04-17 | 0 (exclus E1/E2) |
