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
#
# BUG CONNU (GitHub #16299) : les patterns glob dans `paths` ne supportent pas
# encore la syntaxe `**` recursive sur toutes les implementations. Si un path-scope
# ne se declenche pas, essayer le pattern exact sans glob (ex: "src/auth/").
# Surveiller : github.com/anthropics/claude-code/issues/16299
paths:
  - "[CONFIGURER: ex: src/auth/**]"
  - "[CONFIGURER: ex: src/auth/**/*.ts]"
---

# Regles [NOM DU DOMAINE]

[CONFIGURER: regles specifiques a ce domaine — exemples ci-dessous]

---

## Exemple : auth (chemin critique)

Toute modification dans `src/auth/**` :

- **Gate PO obligatoire** — ce chemin est critique : review ligne par ligne requise avant merge
- Inclure dans la description de PR une explication de **chaque changement** (pas de resume global)
- Verifier avant tout commit :
  - Pas de secret en clair (token, mot de passe, cle API)
  - Tokens avec expiration explicite
  - Sessions revocables (logout, invalidation)
  - Guards appliques sur toutes les routes protegees
- Ne jamais affaiblir un controle d'acces existant sans gate PO

---

## Exemple : migrations (schema DB)

Toute modification dans `prisma/migrations/**` ou `prisma/schema.prisma` :

- **Gate humaine obligatoire** — les migrations DB sont irreversibles en prod
- Verifier idempotence : la migration peut-elle etre rejouee sans erreur ?
- Inclure dans la description de PR :
  - Ce que la migration fait (tables/colonnes ajoutees, modifiees, supprimees)
  - Procedure de rollback si migration destructive
  - Impact sur les donnees existantes (migration de donnees requise ?)
- En prod : ne jamais modifier une migration deja appliquee (checksum Prisma)

---

## Quand utiliser rules vs CLAUDE.md

| Cas | Ou l'ecrire |
|-----|------------|
| Regle activee uniquement pour certains fichiers | `.claude/rules/<domaine>.md` (path-scope) |
| Regle globale projet (tout fichier) | `CLAUDE.md` racine projet |
| Regle universelle (tout projet pourrait l'avoir) | `ebse-scaffold/scaffold/scaffold-claude.md` |
| Override temporaire (une session, une exception) | `CLAUDE.local.md` (non commite) |

**Principe** : CLAUDE.md < 200 lignes. Externaliser dans rules/ tout ce qui est long et domaine-specifique.

`Source: PICOC ai-agent-path-scoped-context GRADE 3 RECOMMANDE`
