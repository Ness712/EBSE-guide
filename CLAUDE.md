# CLAUDE.md — EBSE-Guide

## Role

Ce repo est un **guide de decisions techniques universel** base sur la methodologie EBSE. Tu travailles dessus pour : ajouter des decisions, corriger des decisions existantes, mettre a jour les templates.

**Methodologie obligatoire** : voir [methodology.md](methodology.md) — source unique. **Lire methodology.md en entier avant toute modification du guide.** Suivre a 100%, sans raccourcis.

La double extraction requiert deux sous-agents independants :
```
Agent A : extrait les donnees de la source sans voir le travail de B
Agent B : extrait les donnees de la meme source sans voir le travail de A
Agent C : compare A et B, identifie les divergences, tranche
```
Ne jamais faire l'extraction soi-meme en "simulant" deux agents — lancer de vrais sous-agents separement.

---

## Ou trouver quoi

| Besoin | Fichier |
|--------|---------|
| Protocole complet (DARE, PICOC, extraction, GRADE, kappa) | [methodology.md](methodology.md) |
| Templates CLAUDE.md / settings pour projets | [templates/](templates/) |
| Decisions existantes | [data/decisions/](data/decisions/) |
| Matrice decisions | [matrix.md](matrix.md) |
| Plan guide | [PLAN.md](PLAN.md) |
