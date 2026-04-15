# Double Extraction v3.0 — Rewrite Strategy (1 decision)

**Date** : 2026-04-15
**Agent A** : a462bc75050944d51
**Agent B** : ab0ec855cc59ad8df
**Methode** : Kitchenham v3.0 complete

## Resultats

- **Accord : 1/1 (100%)**
- **Convergence sur Strangler Fig + Spec-first + Test-driven**
- **Big bang unanimement rejete (11/11 Agent A, 32/32 Agent B)**

| # | Decision | Reco | GRADE conservatif | Robustesse |
|---|----------|------|-------------------|------------|
| 1 | Strategie de reecriture backend | Strangler Fig + Spec-first + Test-driven, module par module | 5/7 [STANDARD] | ROBUSTE |

## Taux de succes par strategie (Agent B, 32 sources)

| Strategie | Taux de succes | Recommandation |
|-----------|---------------|----------------|
| Big bang | 20-30% | FORTEMENT CONTRE |
| Strangler fig | 70-85% | FORTEMENT POUR |
| Spec-first seul | 65-75% | CONDITIONNEL |
| Test-driven seul | N/A | COMPOSANT uniquement |
| Combinaison B+C+D | 85-95% | FORTEMENT POUR |

## Notes
- Agent A : 11 sources (Fowler, Spolsky, Google SWE Book, Stripe, Slack, Shopify, Microsoft, Facebook, Caudill)
- Agent B : 32 sources dont 14 academiques (IEEE, ACM) + case studies (GitHub, Twitter, Uber, Airbnb, SoundCloud, LinkedIn)
- Lecon SoundCloud : commencer par le module le plus couple = quasi-echec. Toujours commencer par le plus simple.
- Lecon Stripe : chaque etape doit etre independamment reversible (4-phase migration)
- Lecon Slack : Ship-of-Theseus, livrer chaque module des qu'il est pret, valeur continue
