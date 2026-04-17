# PRISMA Flow — coding-standards-vs-guidelines

**Date de recherche** : 2026-04-17
**Agents** : Reviewer A (indépendant) + Reviewer B (indépendant) — contextes séparés
**Bases interrogées** : IEEE standards, ISO/IEC standards, SWEBOK v4, littérature SE classique (McConnell, Beck, Fowler, Hunt & Thomas), Google Engineering Practices, Linux Kernel Coding Style, ACM DL / TSE (Sadowski 2018)
**Mots-clés Agent A** : "coding standards mandatory", "shall vs should software engineering", "enforceable coding rules", "conventions vs guidelines SE", "coding standards definition IEEE", "automated enforcement code quality"
**Mots-clés Agent B** : "coding standards vs guidelines", "mandatory vs recommended rules", "coding conventions definition", "linting automation code standards", "shall should may software engineering"

---

## Flux PRISMA

```
IDENTIFICATION
  Sources identifiées par base :
    - Standards IEEE/ISO (730, 25010, 42010, 12207, 26511) : 5 normes
    - SWEBOK v4 (IEEE CS, 2024)                            : 1 référence
    - Livres SE classiques (McConnell, Beck, Fowler,
      Hunt & Thomas, Martin)                               : 5 sources
    - Google Engineering Practices / SWE Book              : 2 sources
    - Linux Kernel Coding Style                            : 1 source
    - Peer-reviewed empirique (Sadowski TSE 2018,
      Storey ICSE 2017, Aniche MSR 2020)                  : 3 sources
    - Snowballing                                          : ~3 additionnelles
  Total identifié : ~20
  Doublons retirés : -2
  Total après déduplication : ~18

SCREENING (titre + résumé)
  Sources screenées : 18
  Sources exclues au screening : -7
    - E1 (> 5 ans ET non-standard/non-classique) : -1
    - E2 (blog individuel)                        : -3
    - E3 (marketing vendeur)                      : -2
    - E5 (hors périmètre — design patterns génériques) : -1

ÉLIGIBILITÉ (lecture complète)
  Sources évaluées en détail : 11
  Sources exclues après lecture : -2 (voir extraction file)

INCLUSION
  Sources incluses dans la synthèse : 9
    - Niveau 1 (standards IEEE/ISO normatifs)     : 3
    - Niveau 2 (livres reconnus + pratique indus.) : 5
    - Niveau 3 (peer-reviewed empirique)           : 1
```

---

## Documentation recherche (Table 2 Kitchenham)

| Base | Termes utilisés | Date | Retenus |
|------|----------------|------|---------|
| IEEE standards | "730", "42010", "25010", "coding standards" | 2026-04-17 | 3 (IEEE 730, SWEBOK v4, ISO 25010) |
| Littérature SE | "McConnell", "Beck XP", "Hunt Thomas", "Fowler" | 2026-04-17 | 4 |
| Google / Linux | "Google Engineering Practices", "Linux Kernel Style" | 2026-04-17 | 2 |
| IEEE TSE | "Sadowski code review Google" | 2026-04-17 | 1 |
