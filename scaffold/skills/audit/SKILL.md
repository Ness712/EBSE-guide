---
description: "Audit pre-release — conventions Git, alignement EBSE, quality gates, chemins critiques. Declencher uniquement avant merge vers main."
model: sonnet
context: fork
allowed-tools: ["Read", "Glob", "Grep", "Bash(git log*)", "Bash(git diff*)"]
user-invocable: true
---

# Audit pre-release

> Limitation : je suis le meme modele que le builder — self-preference bias documente (Panickssery NeurIPS 2024 : 73% de preference self). La relecture PO ligne par ligne reste obligatoire pour les chemins critiques.

**Quand declencher** :
- PRs vers **main** : audit complet obligatoire (PICOC #29)
- PRs vers **staging** : review sub-agent independant suffit — ne pas declencher ce skill

## Contexte injecte automatiquement

Branche courante : `git branch --show-current`

10 derniers commits :
```
git log --oneline -10
```

## Procedure obligatoire avant audit

Lis dans l'ordre :
1. `[CONFIGURER: chemin scaffold-claude.md, ex: ../ebse-scaffold/scaffold/scaffold-claude.md]` — regles universelles
2. `CLAUDE.md` racine projet
3. `CLAUDE.local.md` racine projet (si present)
4. `[CONFIGURER: chemin CONVENTIONS.md, ex: OLS-backend/CONVENTIONS.md]` — conventions repo
5. `[CONFIGURER: chemin recommendations EBSE, ex: ../ebse-scaffold/ebse/guide/data/stacks/ols-recommendations.json]`

## Perimetre d'audit

### 1. Conventions Git

Format attendu pour chaque commit : `OLS-{TICKET} {type}({scope}): {description}` ou `{type}: {description}`.
Types valides : `feat`, `fix`, `refactor`, `docs`, `test`, `chore`.
Chaque commit hors format → **AVERTISSEMENT**.
Co-Authored-By manquant sur commits agent → **AVERTISSEMENT**.

### 2. Chemins critiques

Lister les fichiers modifies sur la branche :
```
git diff --name-only main...HEAD
```

Pour chaque fichier dans un chemin critique `[CONFIGURER: liste — ex: src/auth/**, src/common/guards/**, .env*, docker-compose*.yml, deploy.yml]` :
- Verifier que la description de PR contient une explication ligne par ligne
- Si explication absente → **BLOQUANT**

### 3. Alignement recommandations EBSE

Pour chaque recommandation `applicable: true` dans le fichier de recommandations :
- Verifier l'alignement avec le code du diff
- Ecart non justifie → **BLOQUANT**
- Ecart documente intentionnellement → **AVERTISSEMENT**

### 4. Quality gates

Verifier que les commandes suivantes passent (sans erreur) :

```bash
# [CONFIGURER: adapter selon le projet]
# Tests
pnpm test

# Lint
pnpm lint

# Typecheck
pnpm typecheck
```

Chaque gate en echec → **BLOQUANT**.

## Format de rapport

```
Limitation : [disclaimer self-preference obligatoire]

REPOS AUDITES : [liste]

BLOQUANTS
[blocking] Description precise + fichier:ligne ou commit + correction requise

AVERTISSEMENTS
[warning] Description + element concerne

CORRECTIONS AUTONOMES
[auto] fichier:ligne — correction appliquee directement

A TRAITER PAR PO
[po] element necessitant decision ou relecture humaine

STATUT GLOBAL : OK / KO
```

`Source: PICOC ai-agent-pre-release-review GRADE 3 + PICOC #29 audit-methodology STANDARD`
