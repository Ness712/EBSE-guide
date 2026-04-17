# PRISMA Flow — kiss-yagni

**Date de recherche** : 2026-04-17
**Agents** : Reviewer A (indépendant) + Reviewer B (indépendant) — contextes séparés
**Bases interrogées** : ACM Digital Library, IEEE Xplore, SWEBOK v4, Google Scholar, martinfowler.com, Addison-Wesley classics, pragprog.com
**Mots-clés Agent A** : "YAGNI you aren't gonna need it XP", "KISS principle software design", "over-engineering technical debt", "premature abstraction cost", "speculative generality code smell"
**Mots-clés Agent B** : "accidental complexity Brooks", "simple design XP Kent Beck", "speculative generality code smell Fowler", "big design up front vs evolutionary design", "make it work make it right make it fast"

---

## Flux PRISMA

```
IDENTIFICATION
  Sources identifiées par base :
    - SWEBOK v4 (IEEE Computer Society, 2024)           : 1 source directe (ch.2 Software Design)
    - Google Scholar / ACM — XP literature              : ~12 sources candidates
    - Google Scholar / IEEE — complexity management     : ~8 sources candidates
    - martinfowler.com (catalogue code smells + essays) : ~5 sources candidates
    - Addison-Wesley / pragprog — ouvrages experts      : ~6 sources candidates
    - Snowballing (citations croisées)                  : ~4 additionnelles
  Total identifié : ~36
  Doublons retirés : -7
  Total après déduplication : ~29

SCREENING (titre + résumé)
  Sources screenées : 29
  Sources exclues au screening : -13
    - E1 (> 5 ans ET non-classique, non-fondateur) : -3
    - E2 (blog individuel sans revue par pairs)    : -5
    - E3 (marketing vendeur)                       : -2
    - E5 (hors périmètre : UX design, hardware)   : -3

ÉLIGIBILITÉ (lecture complète)
  Sources évaluées en détail : 16
  Sources exclues après lecture : -9 (voir extraction file — sources exclues)

INCLUSION
  Sources incluses dans la synthèse : 7
    - Niveau 1 (standard normatif IEEE — SWEBOK v4)     : 1
    - Niveau 5 (experts reconnus convergents)           : 6
      - Beck 2004 (XP Explained, formulation YAGNI)
      - Fowler 2018 (Refactoring, Speculative Generality)
      - Brooks 1987 (No Silver Bullet, complexité essentielle/accidentelle)
      - McConnell 2004 (Code Complete, gestion complexité)
      - Fowler 2004 (Is Design Dead?, nuance architecturale)
      - Hunt & Thomas 2019 (Pragmatic Programmer, ETC principle)
```

---

## Documentation recherche (Table 2 Kitchenham)

| Base | Termes utilisés | Date | Retenus |
|------|----------------|------|---------|
| SWEBOK v4 IEEE | "software design simplicity accidental complexity" | 2026-04-17 | 1 (ch.2 Software Design) |
| Google Scholar | "YAGNI you aren't gonna need it Beck" | 2026-04-17 | 1 (Beck 2004 XP Explained) |
| ACM DL | "speculative generality code smell refactoring" | 2026-04-17 | 1 (Fowler 2018 Refactoring) |
| IEEE Xplore | "accidental complexity essential complexity Brooks" | 2026-04-17 | 1 (Brooks 1987 No Silver Bullet) |
| Google Scholar | "Code Complete complexity management McConnell" | 2026-04-17 | 1 (McConnell 2004) |
| martinfowler.com | "is design dead YAGNI architecture" | 2026-04-17 | 1 (Fowler 2004 Is Design Dead?) |
| pragprog.com / Scholar | "ETC easier to change pragmatic programmer" | 2026-04-17 | 1 (Hunt & Thomas 2019) |
