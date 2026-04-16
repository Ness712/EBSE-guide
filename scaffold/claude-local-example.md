# CLAUDE.local.md — Template consignes temporaires (PAS commite)

> Ce fichier va a la racine du projet, a cote de CLAUDE.md.
> Il est dans .gitignore — JAMAIS commite.
> Il contient des **overrides contextuels** qui changent selon le stade du projet.
> Quand une consigne n'est plus valide → **supprimer la ligne** (l'agent retombe sur les regles permanentes de CLAUDE.md).
> **Supprimer ce bloc d'en-tete apres copie.**

---

## Overrides gates humaines

<!-- Decommenter et adapter selon votre contexte actuel -->

<!-- ### Override : DB schema reset autorise
Contexte : zero utilisateurs en production. Tu peux consolider les migrations
(modifier V1/V2 directement) et reset la DB au lieu d'empiler des versions.
**Supprimer cette consigne quand les premiers vrais utilisateurs arrivent.** -->

<!-- ### Override : acces serveur direct
Tu peux executer des commandes directement sur le serveur via SSH.
Toujours confirmer au PO avant les actions destructives (DROP, restart, suppression).
**Supprimer quand l'acces n'est plus necessaire.** -->

## Consignes de sprint / contexte actuel

<!-- Decommenter et adapter -->

<!-- ### Sprint en cours
Focus sur : [description du sprint actuel]
Ne PAS toucher a : [parties du code a ne pas modifier ce sprint] -->

<!-- ### Contrainte temporaire
[Ex: "Le serveur staging est down, tester uniquement en local"]
[Ex: "Le token GlitchTip expire le 2026-05-01, renouveler avant"]
**Supprimer quand resolue.** -->
