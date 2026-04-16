# Double Extraction — Batch 17 : Pratiques par taille d'equipe

**Date** : 2026-04-14
**Agent A** : a37fcf1935dce8180
**Agent B** : adccfcc299308fdac

## Resultats

- **Accord : 7/7 (100%)**
- **Conclusion convergente** : 6/7 pratiques sont universelles (le principe ne change pas avec la taille). Seule l'onboarding est vraiment dependante de la taille.

| Pratique | Varie ? | Agent A | Agent B |
|---|---|---|---|
| Code review | Non (parametres seulement) | ✓ | ✓ |
| CI/CD | Non (scale avec produit) | ✓ | ✓ |
| Documentation | Scope varie, pratique universelle | ✓ | ✓ |
| Code ownership | Outillage varie, principe universel | ✓ | ✓ |
| Branching | Non (governance varie) | ✓ | ✓ |
| Definition of done | Non (format varie) | ✓ | ✓ |
| Onboarding | **OUI** (seule dependante) | ✓ | ✓ |

## Implication pour l'arbre de decision

La question team-size est utile pour le contexte mais ne filtre quasiment aucune recommandation technique. Les pratiques DORA (CI/CD, trunk-based, code review, automated testing) sont recommandees a TOUTE taille d'equipe.

Sources : DORA/Accelerate (7+ ans, 30k+ repondants), Google Engineering Practices, Microsoft Research (Rigby & Bird 2013, Bird et al.), Scrum Guide 2020, SWEBOK v4.
