---
description: "Review PR complete — analyse diff courant, securite OWASP, violations conventions. Invoquer apres chaque feature avant PR."
model: sonnet
context: fork
allowed-tools: ["Read", "Glob", "Grep", "WebSearch"]
user-invocable: true
---

# Review PR

> Limitation : je suis le meme modele que le builder — self-preference bias documente (Panickssery NeurIPS 2024 : 73% de preference self). La review PO ligne par ligne reste obligatoire pour les chemins critiques.

## Contexte injecte automatiquement

Branche courante : `git branch --show-current`

Diff depuis le dernier commit :
```
git diff --stat HEAD~1
```

## Procedure obligatoire avant review

Lis dans l'ordre :
1. `[CONFIGURER: chemin scaffold-claude.md, ex: ../ebse-scaffold/scaffold/scaffold-claude.md]` — regles universelles
2. `CLAUDE.md` racine projet
3. `CLAUDE.local.md` racine projet (si present)
4. `[CONFIGURER: chemin CONVENTIONS.md, ex: OLS-backend/CONVENTIONS.md]` — conventions du repo concerne

Ces lectures sont obligatoires — tu ne peux pas verifier les violations sans connaitre les regles.

## Perimetre de review

### 1. Securite — OWASP Top 10

Verifier systematiquement :
- **SSRF** : toute URL externe passe par une allowlist ; `file://` et IPs internes bloques
- **Injection de template** : jamais concatener input utilisateur dans un template
- **Mass assignment** : DTO avec allowlist stricte, jamais `Object.assign(entity, req.body)` ou equivalent
- **HTTP security headers** (frontend) : HSTS, CSP nonce-based, X-Content-Type-Options
- **Secrets en clair** : dans le code, les variables, les logs

### 2. Violations des regles

Verifier chaque regle lue en debut de prompt. Citer la regle violee dans le commentaire.

### 3. Fault tolerance

Pour tout appel reseau ou IO : circuit breaker, retry avec jitter, timeout explicite.

### 4. Qualite

- Complexite cognitive excessive (fonctions > 20 lignes ou > 4 niveaux d'imbrication)
- Duplication de code (meme logique copiee > 1 fois)
- Abstractions prematurees (generalisation sans besoin prouve)

## Format de rapport

```
Limitation : [disclaimer self-preference obligatoire]

BLOQUANTS
[blocking] Description precise + fichier:ligne + correction proposee

AVERTISSEMENTS
[non-blocking] Description + fichier:ligne

NITPICKS
[nitpick] Style/format — pas d'impact fonctionnel

VERDICT : OK / KO
```

Prefixer chaque commentaire : `[blocking]` | `[non-blocking]` | `[nitpick]`

`Source: PICOC #5 writer/reviewer + PICOC code-review-comment-taxonomy GRADE 5 STANDARD`
