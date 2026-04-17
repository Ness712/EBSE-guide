# PRISMA Flow — solid-principles

**Date de recherche** : 2026-04-17
**Agents** : Reviewer A (indépendant) + Reviewer B (indépendant) — contextes séparés
**Bases interrogées** : IEEE Xplore, ACM Digital Library, arXiv (cs.SE), SWEBOK, Spring Documentation, Google Scholar (top venues SE : TSE, ICSE, FSE, EMSE, ICSME)
**Mots-clés Agent A** : "SOLID principles software design", "single responsibility principle maintainability", "dependency inversion spring IoC", "open closed principle extensibility", "god class refactoring maintainability", "cohesion coupling object oriented"
**Mots-clés Agent B** : "Robert Martin clean code principles", "SOLID empirical evidence", "interface segregation principle Java", "Liskov substitution principle inheritance", "SOLID over-engineering criticism", "code smells maintainability empirical", "object oriented design principles SWEBOK"

---

## Flux PRISMA

```
IDENTIFICATION
  Sources identifiées par base :
    - SWEBOK v4 (IEEE Computer Society, 2024)         : 1 source (ch.2 Software Design)
    - ACM Digital Library / IEEE Xplore (TSE, EMSE)  : ~8 sources candidates
    - ACM Digital Library (FSE, ICSME, ICSE)         : ~6 sources candidates
    - Ouvrages reconnus (Martin, McConnell, Fowler)   : ~4 sources candidates
    - Documentation officielle frameworks (Spring)    : ~2 sources candidates
    - Snowballing (références croisées SWEBOK)        : ~4 additionnelles
  Total identifié : ~25
  Doublons retirés : -4 (Yamashita 2013 cité dans SWEBOK + identifié directement)
  Total après déduplication : ~21

SCREENING (titre + résumé)
  Sources screenées : 21
  Sources exclues au screening : -10
    - E1 (> 5 ans ET non-classique et non-fondateur) : -3
    - E2 (blog individuel, non peer-reviewed)         : -4
    - E3 (marketing vendeur, formations en ligne)     : -2
    - E5 (hors périmètre : patterns architecturaux
          ≠ principes de conception OO)               : -1

ÉLIGIBILITÉ (lecture complète)
  Sources évaluées en détail : 11
  Sources exclues après lecture : -4 (voir section "Sources exclues" dans extraction)

INCLUSION
  Sources incluses dans la synthèse : 7
    - Niveau 1 (standard international IEEE)              : 1
    - Niveau 3 (documentation officielle + peer-reviewed) : 4
    - Niveau 5 (experts reconnus convergents)             : 2
```

---

## Documentation recherche (Table 2 Kitchenham)

| Base | Termes utilisés | Date | Retenus |
|------|----------------|------|---------|
| SWEBOK v4 | "software design principles OO" (ch.2) | 2026-04-17 | 1 (SWEBOK v4 ch.2) |
| IEEE TSE | "single responsibility principle maintainability" | 2026-04-17 | 1 (Yamashita & Counsell 2013) |
| EMSE / ICSME | "god class change-proneness SOLID" | 2026-04-17 | 1 (Palomba et al. 2019) |
| ACM FSE / SIGSOFT | "cohesion reuse object-oriented" | 2026-04-17 | 1 (Bieman & Kang 1995) |
| Spring Documentation | "dependency inversion IoC container" | 2026-04-17 | 1 (Spring Framework docs 2024) |
| Ouvrages Martin | "SOLID principles agile clean code" | 2026-04-17 | 2 (Martin 2002, Martin 2008) |
| Google Scholar | "SOLID over-engineering criticism" | 2026-04-17 | 0 (absorbé par Martin 2002 + SWEBOK note "heuristics") |
