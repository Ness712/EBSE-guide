# Double Extraction v3.0 — Enum vs Label (1 decision)

**Date** : 2026-04-15
**Agent A** : aaca963eab92324b7
**Agent B** : abff35e2e52d50353
**Methode** : Kitchenham v3.0 complete (PICOC, PRISMA, I/E, Q1-Q11, GRADE, sensitivity, pub bias)

## Resultats

- **Accord outil : 1/1 (100%)**
- **0 divergence**
- **Les deux agents convergent sur le meme discriminant principal : "le code branche-t-il sur la valeur ?"**

| # | Decision | Reco | GRADE conservatif | Robustesse |
|---|----------|------|-------------------|------------|
| 1 | Enum vs Label configurable | 3 questions : code branches? → users add? → needs metadata? | 4/7 [RECOMMANDE] | ROBUSTE |

## Notes
- Agent A propose un test a 3 questions, Agent B un flowchart a 5 questions — le core est identique (D1: code branches = discriminant principal)
- 7-8 sources (Bloch, Evans, Fowler, Karwin, Vernon, Microsoft, +2) convergent sur 20 ans de litterature (2003-2023)
- Aucune etude empirique mesurant les defauts ou couts de maintenance (GRADE reste Moderate)
- Publication bias moderate : toutes les sources viennent de l'ecole "clean architecture" (DDD, Fowler, Bloch)
- Sensitivity ROBUSTE : aucune source individuelle ne change la recommandation
