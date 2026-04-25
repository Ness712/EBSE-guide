---
# Template de regle path-scopee Claude Code
# Copier ce fichier dans .claude/rules/<nom-domaine>.md
# Remplacer les [CONFIGURER] et supprimer les commentaires
#
# Source : PICOC ai-agent-path-scoped-context GRADE 3 RECOMMANDE
#          docs.anthropic.com/en/docs/claude-code/memory#rules
#
# Principe : ce fichier est charge UNIQUEMENT quand Claude accede aux fichiers
# correspondants aux paths ci-dessous. Zero cout contextuel pour les autres domaines.
#
# Garder CLAUDE.md < 200 lignes (pointeurs) — externaliser ici les regles specialisees.
paths:
  - "[CONFIGURER: ex: src/auth/**]"
  - "[CONFIGURER: ex: src/auth/**/*.ts]"
---

# Regles [NOM DU DOMAINE]

[CONFIGURER: regles specifiques a ce domaine — exemple ci-dessous pour auth]

## Exemple : auth

Toute modification dans `src/auth/**` :
- Necessite une review ligne par ligne du PO (chemin critique)
- Inclure dans la description de PR une explication de chaque changement
- Verifier : pas de secret en clair, tokens expires, sessions revocables

## Exemple : migrations

Toute modification dans `prisma/migrations/**` :
- Gate humaine obligatoire (schema DB)
- Verifier idempotence de la migration
- Inclure rollback procedure dans la description de PR
