---
description: "Charge les conventions du repo en contexte courant. Invoquer en debut de session quand on travaille sur un repo dont les conventions ne sont pas chargees."
model: haiku
allowed-tools: ["Read"]
user-invocable: true
---

# Chargement des conventions projet

Lis integralement le fichier de conventions du repo courant et confirme qu'elles sont chargees en contexte.

## Fichier a lire

`[CONFIGURER: chemin vers CONVENTIONS.md du repo, ex: OLS-backend/CONVENTIONS.md]`

## Apres lecture

Confirmer en une ligne : "Conventions [NOM-REPO] chargees — N regles actives."

Ne pas resumer le contenu — les conventions sont maintenant en contexte et seront appliquees automatiquement pour le reste de la session.

## Quand invoquer ce skill

- Debut de session de travail sur un repo specifique
- Apres un `/compact` ou `context: fork` qui a vide le contexte
- Quand Claude demande "je ne connais pas les conventions de ce repo"

## Note d'architecture

Ce skill n'utilise PAS `context: fork` — il charge deliberement les conventions dans le contexte courant (l'inverse de review/audit qui isolent dans un sous-agent). L'objectif est que les regles restent actives pendant tout le travail de la session.

`Source: PICOC coding-standards-vs-guidelines GRADE 5 STANDARD + PICOC ai-agent-model-routing (haiku pour taches simples)`
