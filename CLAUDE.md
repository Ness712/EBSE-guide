# CLAUDE.md — ebse-scaffold

## Role

Ce repo contient deux composants distincts :
- **guide/** : decisions techniques universelles basees sur la methodologie EBSE (PICOCs, GRADE, sources)
- **scaffold/** : templates operationnels pour configurer un agent Claude Code (CLAUDE.md template, hooks, settings, commandes)

Tu travailles dessus pour : ajouter des decisions, corriger des decisions existantes, mettre a jour le scaffold.

**Methodologie obligatoire** : voir [guide/methodology.md](guide/methodology.md) — source unique. **Lire methodology.md en entier avant toute modification.** Suivre a 100%, sans raccourcis.

**Source d'abord, regle ensuite** : toute regle ajoutee au guide ou au scaffold doit avoir sa source identifiee AVANT d'etre ecrite. Si aucune source n'existe → noter le gap, traiter comme tache EBSE dediee.

---

## Ou trouver quoi

| Besoin | Fichier |
|--------|---------|
| Protocole complet (DARE, PICOC, extraction, GRADE, kappa) | [guide/methodology.md](guide/methodology.md) |
| Decisions existantes (PICOCs, GRADE, sources) | [guide/data/decisions/](guide/data/decisions/) |
| Scaffold CLAUDE.md template | [scaffold/claude-md-autonomous-agent.md](scaffold/claude-md-autonomous-agent.md) |
| Scaffold settings, hooks, commandes | [scaffold/](scaffold/) |
| Matrice decisions | [matrix.md](matrix.md) |
| Plan guide | [PLAN.md](PLAN.md) |
