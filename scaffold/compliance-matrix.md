# Compliance Matrix BSAF — scaffold-claude.md
# Plan 1 — Classification Mandatory / Required / Advisory

**Date :** 2026-04-18
**Méthode :** BSAF (Behavioral Specification and Assurance Framework) — PICOC ai-agent-scaffold-methodology GRADE 5
**Niveaux :**
- **Mandatory** : règle absolue, dérogation impossible — doit être implémentée par un hook déterministe
- **Required** : règle importante — CLAUDE.md, dérogation via Deviation Record signé PO
- **Advisory** : recommandation — CLAUDE.md, dérogation sans formalité

**Implémentation :**
- `HOOK` : implémenté en hook Claude Code (`.claude/hooks/`)
- `DENY` : implémenté en deny list (`.claude/settings.json`)
- `CLAUDE.md` : règle texte uniquement (dépend de la compréhension LLM)
- `PARTIAL` : partiellement implémenté
- `NONE` : aucune implémentation mécanique — gap potentiel

---

## Section 1 — Rôle / Routage

| Règle | Niveau | Implémentation | Source PICOC | Statut |
|-------|--------|---------------|--------------|--------|
| Avant d'escalader : guide EBSE → doc officielle → escalade PO | Required | CLAUDE.md | #1, #2, #6 | OK |
| Revenir vers PO uniquement si 3 conditions remplies | Required | CLAUDE.md | #6 | OK |
| Plan approuvé = pas une gate pour chaque item | Required | CLAUDE.md | #1 | OK |
| Règle de routage universel vs projet-spécifique | Required | CLAUDE.md | #2 | OK |

---

## Section 2 — Gates humaines

| Règle | Niveau | Implémentation | Source PICOC | Statut |
|-------|--------|---------------|--------------|--------|
| Gate : schema / database migrations | **Mandatory** | HOOK | #3 | ✅ `pre-commit-quality.sh` — détecte `migrations/*.sql` + `schema.prisma` stagés |
| Gate : secret rotation / credential management | **Mandatory** | HOOK | #3 | ✅ `pre-commit-quality.sh` — détecte fichiers `.env*` stagés |
| Gate : production deploys | **Mandatory** | PARTIAL | #3 | ⚠️ GAP PARTIEL — deny `git push --force` mais pas deploy direct |
| Gate : force-push branches protégées | **Mandatory** | DENY | #3 | ✅ `Bash(git push --force*)` + `Bash(git push -f*)` |
| Gate : license changes / dépendances restrictives | **Mandatory** | HOOK | #3 | ✅ `pre-push-quality.sh` — `npx license-checker --failOn GPL;AGPL` |
| Gate : customer data handling (PII) | **Mandatory** | NONE | #3 | ⚠️ GAP — aucun mécanisme |
| Gate : changements d'architecture | **Mandatory** | NONE | #3 | ⚠️ GAP — signal faible, non hookable fiablement (étude séparée) |
| Gate : merge vers main ou staging | **Mandatory** | DENY + HOOK | #3 | ✅ deny + pre-push hook |
| Ne jamais se fier à sa propre confiance pour bypasser | **Mandatory** | CLAUDE.md | NIST AI 600-1 | ⚠️ NON HOOKABLE — comportement LLM |
| Chaine accountability : principal désigné | Required | CLAUDE.md | #20 | OK |
| Chaine accountability : registre auditable tool calls | **Mandatory** | HOOK | #20 | ✅ `audit-tool-use.sh` (PostToolUse *) |
| Chaine accountability : interruptibilité PO | Required | CLAUDE.md | #20 | OK |
| Chaine accountability : déploiement progressif autonomie | Required | CLAUDE.md | #20 | OK |

---

## Section 3 — Plan = Contrat

| Règle | Niveau | Implémentation | Source PICOC | Statut |
|-------|--------|---------------|--------------|--------|
| Ne pas changer l'approche sans re-approbation PO | Required | CLAUDE.md | Feedback PO | OK |
| Ne pas ajouter features non demandées | Required | CLAUDE.md | Feedback PO | OK |
| Ne pas refactorer hors scope du plan | Required | CLAUDE.md | Feedback PO | OK |
| Ne pas sauter une étape du plan | Required | CLAUDE.md | Feedback PO | OK |
| Stop immédiat si plan ne marche pas mid-execution | Required | CLAUDE.md | Anthropic BEA | OK |
| Format d'escalation structuré obligatoire | Required | CLAUDE.md | #6 | OK |

---

## Section 4 — Qualité du code (Conventions mécanisées)

| Règle | Niveau | Implémentation | Source PICOC | Statut |
|-------|--------|---------------|--------------|--------|
| Pas de suppression de warning (eslint-disable, @SuppressWarnings, noqa) | **Mandatory** | HOOK | coding-standards | ✅ `pre-commit-quality.sh` |
| Pas de marqueurs @deprecated / TODO:remove laissés | **Mandatory** | HOOK | coding-standards | ✅ `pre-commit-quality.sh` |

---

## Section 5 — Vérification proactive / Pipeline déterministe

| Règle | Niveau | Implémentation | Source PICOC | Statut |
|-------|--------|---------------|--------------|--------|
| Typecheck + lint avant de présenter le travail | **Mandatory** | HOOK | #4 | ✅ `post-edit-lint.sh` (soft) + `pre-commit-quality.sh` (hard) |
| Tests unitaires (zéro régression) | **Mandatory** | HOOK | #4 | ✅ `pre-push-quality.sh` (à configurer par projet) |
| Build vérifié avant push | **Mandatory** | HOOK | #4 | ✅ `pre-push-quality.sh` (à configurer) |
| Si Dockerfile modifié : docker build --check avant push | **Mandatory** | HOOK | containerization | ✅ `pre-push-quality.sh` — détecte Dockerfile/docker-compose modifiés |
| Attente pipeline CI via `gh run watch` (jamais polling) | Required | CLAUDE.md | #4 | OK |
| Dependency audit (`npm audit --audit-level=high`) | **Mandatory** | HOOK | #4 | ✅ `pre-push-quality.sh` (à configurer) |
| SAST avant PR | Required | PARTIAL | #13 | ⚠️ GAP PARTIEL — mentionné mais non hookable automatiquement |
| Sub-agent review obligatoire avant PR | Required | CLAUDE.md | #5 | OK (vérifié par pre-pr-create.sh à configurer) |
| Chemins critiques : review ligne par ligne PO | **Mandatory** | CLAUDE.md | #13 | ⚠️ GAP — détection des fichiers critiques modifiés non hookée |
| Test E2E navigateur pour changements frontend | Required | CLAUDE.md | Playwright MCP | OK |
| Ne jamais fermer le navigateur Playwright | **Mandatory** | CLAUDE.md | Feedback PO | ⚠️ NON HOOKABLE |
| Vérification existence package avant install | Required | CLAUDE.md | #10 | OK |
| TDD : tests en premier, avant le code | Required | CLAUDE.md | #15 | OK |
| Sécurité agentique : moindre privilège | Required | CLAUDE.md | #22 | OK |
| Sécurité agentique : isolation des agents | Required | CLAUDE.md | #22 | OK |
| Sécurité agentique : sanitisation inputs | Required | CLAUDE.md | #22 | OK |
| Sécurité agentique : monitoring tool calls | **Mandatory** | HOOK | #22 | ✅ `audit-tool-use.sh` |
| Audit pre-release complet (PICOC #29) | Required | CLAUDE.md | #29 | OK (déclenché par pre-pr-create.sh) |

---

## Section 6 — Workflow Git

| Règle | Niveau | Implémentation | Source PICOC | Statut |
|-------|--------|---------------|--------------|--------|
| Branche par tâche | Required | CLAUDE.md | #17 | OK |
| Worktree si autre branche active | Advisory | CLAUDE.md | — | OK |
| Commits incrémentaux (jamais mega-commit) | Advisory | CLAUDE.md | Feedback PO | OK |
| Documentation dans même commit | Required | CLAUDE.md | Feedback PO | OK |
| PR dans ordre obligatoire (plan → reviewer → PR) | Required | HOOK | #5 | ✅ `pre-pr-create.sh` (à configurer sections) |
| Ne pas merger vers branches protégées | **Mandatory** | DENY + HOOK | #3 | ✅ deny list + pre-push |
| Audit trail Co-Authored-By dans chaque commit | Required | CLAUDE.md | #17 | OK |

---

## Section 7 — Gestion du quota

| Règle | Niveau | Implémentation | Source PICOC | Statut |
|-------|--------|---------------|--------------|--------|
| Sub-agents légers (haiku/sonnet) pour tâches simples | Advisory | CLAUDE.md | #12 | OK |
| Context minimal (grep ciblé, pas fichiers entiers) | Advisory | CLAUDE.md | #7 | OK |
| Hooks preprocessing pour outputs volumineux | Advisory | CLAUDE.md | #7 | OK |

---

## Section 8 — Monitoring

| Règle | Niveau | Implémentation | Source PICOC | Statut |
|-------|--------|---------------|--------------|--------|
| Monitoring proactif (alerte-driven, pas passif) | Required | CLAUDE.md | #30 | OK |
| Vérifier erreurs runtime après chaque deploy | Required | CLAUDE.md | #10 | OK |
| SessionStart hook : charger tokens + health-check | **Mandatory** | HOOK | Claude Code docs | ✅ `session-start.sh` |
| Évaluation CLEAR (5 dimensions) | Advisory | CLAUDE.md | #23 | OK |

---

## Section 9 — Décomposition des tâches

| Règle | Niveau | Implémentation | Source PICOC | Statut |
|-------|--------|---------------|--------------|--------|
| Consulter guide EBSE avant toute décision technique | Required | CLAUDE.md | #1, #2 | OK |
| Produire plan décomposé + présenter au PO (si non-trivial) | Required | CLAUDE.md | #14 | OK |
| Calibration attentes vs benchmarks | Advisory | CLAUDE.md | #21 | OK |
| Process redesign avant délégation | Advisory | CLAUDE.md | #27 | OK |
| HITL pour tâches irréversibles, HOTL pour routinières | Required | CLAUDE.md | #26 | OK |
| Routing par type (scaffold / agent propose / humain-led) | Required | CLAUDE.md | #2 | OK |
| Sous-agent avec contexte frais, CLAUDE.md en premier | **Mandatory** | CLAUDE.md | #18 | ⚠️ NON HOOKABLE — comportement LLM |
| Vérification livrables après retour sous-agent | Required | CLAUDE.md | #10 | OK |

---

## Section 10 — Méthode d'audit

| Règle | Niveau | Implémentation | Source PICOC | Statut |
|-------|--------|---------------|--------------|--------|
| Source-first pour toute vérification sémantique | Required | CLAUDE.md | #19 | OK |
| Agent indépendant (contexte frais) pour audits | Required | CLAUDE.md | #5 | OK |
| Package hallucination check (npm info avant install) | Required | CLAUDE.md | #10 | OK |
| Semantic-drift : tests régression sur fonctionnalités non modifiées | Required | CLAUDE.md | #10 | OK |
| SAST sur diffs agent (`git diff main...HEAD`) | Required | CLAUDE.md | #13 | OK |

---

## Section 11 — Exhaustivité

| Règle | Niveau | Implémentation | Source PICOC | Statut |
|-------|--------|---------------|--------------|--------|
| Grep exhaustif (toutes occurrences, pas les premières) | Required | CLAUDE.md | Feedback PO | OK |
| Suivi item par item lors dispatch sous-agents | Required | CLAUDE.md | Feedback PO | OK |

---

## Section 12 — Communication proactive

| Règle | Niveau | Implémentation | Source PICOC | Statut |
|-------|--------|---------------|--------------|--------|
| Informer PO début / progression / fin / blocage | Advisory | CLAUDE.md | #6, #13 | OK |
| Découverte inattendue → signaler hors scope | Required | CLAUDE.md | #6 | OK |

---

## Section 13 — Vérité et non-invention

| Règle | Niveau | Implémentation | Source PICOC | Statut |
|-------|--------|---------------|--------------|--------|
| Ne jamais fabriquer de packages, APIs, fonctions, quotes, chiffres | **Mandatory** | CLAUDE.md | #10, NIST | ⚠️ NON HOOKABLE — comportement LLM intrinsèque |
| Ne jamais dire "c'est fait" si ce n'est pas fait | **Mandatory** | CLAUDE.md | Feedback PO | ⚠️ NON HOOKABLE |
| Ne jamais masquer un échec (test, build) | **Mandatory** | CLAUDE.md | Feedback PO | ⚠️ NON HOOKABLE |
| Vérifier ses propres claims (npm info, docs) | Required | CLAUDE.md | #10 | OK |

---

## Section 14 — Consignes temporaires (CLAUDE.local.md)

| Règle | Niveau | Implémentation | Source PICOC | Statut |
|-------|--------|---------------|--------------|--------|
| CLAUDE.local.md non commité (.gitignore) | **Mandatory** | HOOK | Claude Code docs | ✅ `pre-commit-quality.sh` — détecte CLAUDE.local.md stagé dans repos production |
| Overrides ajustent les gates, ne les suppriment pas | Required | CLAUDE.md | #3 | OK |

---

## Récapitulatif global

| Niveau | Total | Hookés / Mécanisés | Gaps critiques |
|--------|-------|--------------------|----------------|
| **Mandatory** | 24 | 17 ✅ | 7 ⚠️ |
| Required | 31 | 3 (hooks partiels) | — |
| Advisory | 9 | 0 (par définition) | — |

*Mise à jour 2026-04-18 : +6 hooks Mandatory implémentés (migrations DB, secrets .env, CLAUDE.local.md, chemins critiques warning, Docker build --check, license check GPL/AGPL).*

---

## Gaps Mandatory prioritaires (à résoudre)

### Gaps hookables (peuvent être mécanisés)

| Gap | Mécanisme possible |
|-----|-------------------|
| Gate migrations DB non détectée | Hook pre-commit : détecter `prisma migrate` / `flyway migrate` / commandes SQL DDL |
| Gate secret rotation non détectée | Hook pre-commit : détecter patterns `rotate`, `revoke`, fichiers `.env` modifiés |
| Gate architecture non détectée | Hook pre-pr : détecter mots-clés (nouvelle stack, nouveau service, restructuration) dans le body PR — difficile, signal faible |
| Docker build --check manquant | Hook pre-push : si `Dockerfile` ou `docker-compose` dans les fichiers modifiés → `docker build --check` |
| Chemins critiques non hookés | Hook pre-commit : détecter fichiers dans `auth/**`, `security/**`, `migrations/**` → message warning PO obligatoire |
| CLAUDE.local.md dans .gitignore | Hook pre-commit : vérifier `.gitignore` contient `CLAUDE.local.md` |
| License check manquant | Hook pre-push : `npx license-checker --failOn GPL` ou équivalent |

### Gaps non hookables (comportement LLM intrinsèque)

Ces règles sont Mandatory par nature mais ne peuvent pas être imposées mécaniquement — elles dépendent du modèle de langage. La seule mitigation est la formulation claire en CLAUDE.md + tests de robustesse du wording (PICOC ai-agent-instruction-compliance).

| Gap | Mitigation |
|-----|-----------|
| Ne jamais fabriquer de packages/APIs | Wording clair + vérification systématique avant action |
| Ne jamais masquer un échec | Wording clair + reviewer indépendant |
| Sous-agent : lire CLAUDE.md en premier | Prompt engineering + vérification après retour |
| Ne pas bypasser les gates par confiance excessive | Wording clair + gates mécaniques pour les gates mécanisables |

---

## Prochaine étape

**Plan 2 — SDMF** : appliquer les 6 phases pour trouver les dimensions manquantes dans le scaffold (au-delà de ce qui existe déjà).
