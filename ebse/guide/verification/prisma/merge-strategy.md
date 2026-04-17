# PRISMA Flow — PICOC merge-strategy

**Date de recherche** : 2026-04-17
**Bases interrogées** : GitHub Docs, Atlassian Developer Docs, conventionalcommits.org, SEI CMU Blog, WebSearch général (articles techniques ingénieurs)
**Mots-clés Agent A** : "squash merge vs rebase vs merge commit git history", "git squash merge pull request best practice", "conventional commits semver automation changelog", "linear git history git bisect debugging", "GitHub pull request merge strategy settings"
**Mots-clés Agent B** : "rebase vs merge commit github workflow", "git squash merge feature branch trunk", "conventional commits specification v1.0.0 SemVer", "git bisect clean history O(log n)", "force push shared branch danger git"
**Protocole** : methodology.md v3.0 §2.1 — double extraction indépendante (Agents A + B, mots-clés différents) + synthèse Agent C

---

## Flux

```
IDENTIFICATION
  Sources identifiées par base (Agent A + Agent B combinés, avant déduplication) :
    - Documentation officielle VCS/plateforme (GitHub Docs, GitLab Docs) : ~6 résultats candidats
    - Documentation outillage CI/CD et pratiques DevOps (Atlassian, Microsoft DevBlogs) : ~8 résultats candidats
    - Spécifications et standards ouverts (conventionalcommits.org, semver.org) : ~4 résultats candidats
    - Blogs institutionnels (SEI CMU, Google Engineering) : ~6 résultats candidats
    - Articles techniques ingénieurs expérimentés (git bisect, linear history) : ~10 résultats candidats
    - Snowballing backward (références citées par sources principales) : ~4 sources
  Total identifié (brut, combiné A+B) : ~38
  Doublons retirés (même source identifiée par A et B) : 5 (GitHub Docs, Conventional Commits, SEI CMU Blog, Atlassian TBD, articles git bisect)
  Total après déduplication : ~33

SCREENING (titre + résumé)
  Sources screenées : ~33
  Sources exclues au screening : ~22
    - E1 (blog opinion sans données ou méthodologie) : ~9
    - E2 (hors scope PICOC — git en général, pas stratégie de merge) : ~6
    - E3 (doublons partiels — couverts par sources primaires déjà incluses) : ~4
    - E4 (vendeur / marketing sans substance technique) : ~3

ELIGIBILITÉ (lecture complète)
  Sources évaluées en détail : ~11
  Sources exclues après lecture complète : ~6
    - Hors scope PICOC strict (git flow complexe, multi-repo, monorepo spécifique) : 3
    - Niveau de preuve insuffisant (opinion non étayée sur squash vs rebase) : 2
    - Redondance forte avec GitHub Docs sans apport supplémentaire : 1

INCLUSION
  Sources incluses dans la synthèse : 5
    - Niveau 3 : 2 (GitHub Docs, Conventional Commits v1.0.0)
    - Niveau 4 : 3 (Atlassian TBD, SEI CMU Blog, articles techniques git bisect)

  Sources exclues avec raison documentée : 6
    - GitLab Docs — Merge methods : couvert par GitHub Docs ; même principe, contexte plateforme différent
    - Google Engineering Practices — Small CLs : indirect — traite la taille des commits, pas la stratégie de merge
    - semver.org spec v2.0.0 : absorbé par Conventional Commits v1.0.0 (qui référence SemVer directement)
    - Microsoft Azure DevOps — Merge strategies : redondant avec GitHub Docs, moins de détail sur squash
    - release-please / semantic-release docs : implémentation outillage — hors scope du principe universel
    - Pro Git book (Chacon, Straub) — chapitre rebasing : bon niveau mais traite le rebase en général, pas la stratégie de merge PR spécifiquement
```

---

## Documentation recherche (Table 2 Kitchenham)

### Agent A — bases interrogées

| Élément | Valeur |
|---------|--------|
| Bases | GitHub Docs, Atlassian, conventionalcommits.org, SEI CMU Blog, WebSearch général |
| Mots-clés | "squash merge vs rebase vs merge commit git history", "git squash merge pull request best practice", "conventional commits semver automation changelog", "linear git history git bisect debugging", "GitHub pull request merge strategy settings" |
| Période couverte | 2022-2024 |
| Sources identifiées | ~20 |
| Sources retenues | 5 |
| Date d'extraction | 2026-04-17 |

### Agent B — bases interrogées

| Élément | Valeur |
|---------|--------|
| Bases | GitHub Docs, Atlassian, conventionalcommits.org, articles techniques ingénieurs, WebSearch |
| Mots-clés | "rebase vs merge commit github workflow", "git squash merge feature branch trunk", "conventional commits specification v1.0.0 SemVer", "git bisect clean history O(log n)", "force push shared branch danger git" |
| Période couverte | 2022-2024 |
| Sources identifiées | ~18 |
| Sources retenues | 5 (convergence complète avec A) |
| Date d'extraction | 2026-04-17 |

---

## Sources exclues — raisons documentées

| Source | Raison exclusion |
|--------|-----------------|
| GitLab Docs — Merge methods | Redondance — même principe que GitHub Docs, contexte plateforme différent sans apport différencié |
| Google Engineering Practices — Small CLs | Indirect — traite la taille des commits (taille, atomicité) mais pas la stratégie de merge PR spécifiquement |
| semver.org spec v2.0.0 | Absorbé — Conventional Commits v1.0.0 référence et explique SemVer directement ; la spec brute n'apporte pas de guidance supplémentaire |
| Microsoft Azure DevOps — Merge strategies | Redondant avec GitHub Docs, moins précis sur squash merge et message de commit |
| release-please / semantic-release documentation | Hors scope — implémentation outillage spécifique, candidat pour variant ci-cd-tools ; le principe général est couvert par SEI CMU Blog |
| Pro Git book — chapitre rebasing (Chacon, Straub) | Scope trop large — traite le rebase en général (rebase interactif, rebase de base) ; la partie pertinente est absorbée par les sources retenues |
