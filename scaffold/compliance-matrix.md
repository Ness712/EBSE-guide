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
| Gate : customer data handling (PII) | **Mandatory** | HOOK | #3 | ✅ `pre-commit-quality.sh` — détecte patterns SSN + gate PO |
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
| Ne jamais fermer le navigateur Playwright | **Mandatory** | DENY | Feedback PO | ✅ `settings.json` — deny `mcp__playwright__browser_close` |
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
| **Mandatory** | 24 | 23 ✅ | 1 ⚠️ |
| Required | 31 | 3 (hooks partiels) | — |
| Advisory | 9 | 0 (par définition) | — |

*Mise à jour 2026-04-18 (Plan 1+2 complet) :*
- *+10 mécanismes Mandatory Plan 1+2 : migrations DB, secrets .env, CLAUDE.local.md, Docker build --check, license check, Co-Authored-By, secrets patterns, PII detection, settings.json readonly, browser_close deny*
- *+2 mécanismes Mandatory Plan 2 Phase A : H10 prompt injection filter (pre-tool-use), gate architecture (pre-pr warning)*
- *Wording tests non-hookables : 4 règles renforcées (estimations interdites, "devrait marcher" interdit, formulation prompt sous-agent obligatoire, seul PO via CLAUDE.local.md peut lever une gate)*

---

## Gaps Mandatory résiduels

### Gap non hookable résiduel (comportement LLM intrinsèque)

Ces règles sont Mandatory par nature mais ne peuvent pas être imposées mécaniquement. Mitigation : wording renforcé (2026-04-18) + reviewer indépendant + audit pre-release.

| Gap | Wording actuel (renforcé 2026-04-18) | Risque résiduel | Mécanismes compensatoires |
|-----|--------------------------------------|-----------------|--------------------------|
| Ne jamais fabriquer de packages/APIs/chiffres | "même comme suggestion, estimation ou approximation" | Moyen — PICOC compliance -61.8% sur reformulations | `npm info` / vérification systématique, audit-tool-use.sh |
| Ne jamais masquer un échec | "Ne pas signaler = masquer" | Moyen | reviewer indépendant, audit pre-release |
| Sous-agent : lire CLAUDE.md en premier | Formulation obligatoire dans prompt : "Avant toute chose, lis [CLAUDE.md path]" | Faible — formulation prescrite | Vérification après retour sous-agent |
| Ne pas bypasser les gates par confiance excessive | "Seul le PO peut lever une gate via CLAUDE.local.md" | Faible — mécanisme de levée défini | Gates mécaniques pour tout ce qui est hookable |

### Gate architecture (signal faible)

Implémentée en **warning uniquement** (pas bloquant) dans `pre-pr-create.sh` — détecte fichiers infra/config modifiés + mots-clés dans body PR. Taux faux positifs trop élevé pour blocage. Monitoring : si 3+ faux positifs sur 10 PRs → réévaluer.

---

## Prochaine étape

**Plan 3 SLRs** : 5 SLRs Tier 1 à lancer (file upload security, MinIO, DB backup/DR, STOMP auth, enterprise SSO). Nécessite approbation PO par PICOC.
**Phase C PICOCs** : 3 protocoles créés (`ai-agent-prompt-injection-defense`, `ai-agent-incident-response`, `ai-agent-mast-monitoring-runtime`) — SLRs à lancer sur approbation PO.
