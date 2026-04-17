# PRISMA Flow — design-patterns-gof

**Date de recherche** : 2026-04-17
**Agents** : Reviewer A (indépendant) + Reviewer B (indépendant) — contextes séparés
**Bases interrogées** : SWEBOK v4, IEEE TSE / ACM DL, Springer JSEP / IST, littérature SE classique (Gamma, Fowler, Shalloway, Freeman), Google Scholar, documentation officielle NestJS, Refactoring.Guru, arXiv
**Mots-clés Agent A** : "GoF design patterns software quality empirical", "design patterns impact maintainability", "design patterns TypeScript NestJS", "GoF patterns fault-proneness", "design patterns systematic review"
**Mots-clés Agent B** : "anti-patterns TypeScript microservices", "Singleton abuse dependency injection", "design patterns composition over inheritance", "GoF patterns testability coupling", "design smells TypeScript"

---

## Flux PRISMA

```
IDENTIFICATION
  Sources identifiées par base :
    - Standards IEEE/ISO (SWEBOK v4)                          : 1 référence
    - Livres SE classiques (Gamma, Fowler PEAA, Shalloway,
      Freeman, Brown)                                         : 5 sources
    - Peer-reviewed empirique IEEE TSE / ACM / Springer
      (Palomba 2017, Zhang 2019, Ampatzoglou 2013,
       Zaidman 2021, ScienceDirect 2024)                      : 5 sources
    - Documentation officielle (NestJS Docs 2024)             : 1 source
    - Blogs experts / références communautaires
      (LogRocket 2023, Refactoring.Guru 2024)                 : 2 sources
    - Google Scholar (articles généraux, blogs non peer-rev)  : ~8 sources
    - Snowballing (références croisées)                       : ~4 additionnelles
  Total identifié : ~26
  Doublons retirés : -4
  Total après déduplication : ~22

SCREENING (titre + résumé)
  Sources screenées : 22
  Sources exclues au screening : -8
    - E1 (> 5 ans ET non-standard/non-classique)  : -1
    - E2 (blog individuel sans peer review)        : -5
    - E5 (hors périmètre — SOLID / DDD sans GoF)  : -2

ÉLIGIBILITÉ (lecture complète)
  Sources évaluées en détail : 14
  Sources exclues après lecture : -5 (voir extraction file)

INCLUSION
  Sources incluses dans la synthèse : 14
    - Niveau 1 (standard IEEE normatif)                            : 1
    - Niveau 3 (peer-reviewed empirique IEEE TSE/Springer/ICSM
                + documentation officielle)                        : 6
    - Niveau 5 (experts reconnus, livres fondateurs, illustratifs) : 7
```

---

## Documentation recherche (Table 2 Kitchenham)

| Base | Termes utilisés | Date | Retenus |
|------|----------------|------|---------|
| SWEBOK v4 | "software design", "design patterns", "recurring solutions", "trade-offs" | 2026-04-17 | 1 (SWEBOK v4 KA Software Design) |
| IEEE TSE / ICSM | "Palomba design patterns quality", "Zhang design patterns systematic review", "Ampatzoglou patterns quality attributes" | 2026-04-17 | 3 |
| Springer JSEP / IST | "Zaidman TypeScript anti-patterns", "design smells TypeScript microservices" | 2026-04-17 | 2 |
| Littérature SE classique | "Gamma Helm Johnson Vlissides Design Patterns", "Fowler Patterns Enterprise Application", "Shalloway Trott Design Patterns Explained", "Freeman Robson Head First" | 2026-04-17 | 4 |
| Documentation officielle | "NestJS providers singleton scope", "NestJS custom providers factory" | 2026-04-17 | 1 (NestJS Docs 2024) |
| Références communautaires | "Refactoring.Guru TypeScript patterns", "LogRocket Node.js design patterns" | 2026-04-17 | 2 (illustratif niv.5) |
| Brown AntiPatterns | "Brown AntiPatterns refactoring software architectures" | 2026-04-17 | 1 (Brown 2012) |
