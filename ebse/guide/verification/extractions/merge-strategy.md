# Double Extraction — PICOC merge-strategy

**Date** : 2026-04-17
**Protocole** : methodology.md v3.0
**Agent A** : mots-clés : "squash merge vs rebase vs merge commit git history", "git squash merge pull request best practice", "conventional commits semver automation changelog", "linear git history git bisect debugging", "GitHub pull request merge strategy settings"
**Agent B** : mots-clés : "rebase vs merge commit github workflow", "git squash merge feature branch trunk", "conventional commits specification v1.0.0 SemVer", "git bisect clean history O(log n)", "force push shared branch danger git"

---

## PICOC

```
P  = Équipes développement gérant un historique git sur des dépôts avec branches de feature
I  = Choisir et appliquer une stratégie de merge cohérente (squash, rebase, merge commit)
C  = Pas de stratégie définie (merge commits ad hoc, rebase aléatoire, historique pollué)
O  = Lisibilité de l'historique, traçabilité, déboguabilité (git bisect), automatisation SemVer/CHANGELOG
Co = Projets avec CI/CD, branches main/staging protégées, convention de commits structurés
```

---

## Accord Reviewer A / Reviewer B

| # | Source | Niveau A | Niveau B | Accord ? | Note divergence |
|---|--------|---------|---------|:--------:|-----------------|
| 1 | GitHub Docs — About pull request merges (docs.github.com, 2024) | 3 | 3 | ✓ | — |
| 2 | Atlassian — Trunk-based Development (atlassian.com, 2024) | 4 | 4 | ✓ | — |
| 3 | Conventional Commits — v1.0.0 (conventionalcommits.org, 2024) | 3 | 3 | ✓ | — |
| 4 | SEI CMU Blog — Versioning with Git Tags and Conventional Commits (2023) | 4 | 4 | ✓ | — |
| 5 | Articles techniques — A tidy, linear Git history / git bisect (2022-2023) | 4 | 4 | ✓ | — |

**Accord sur sources communes** : 5/5 → kappa = 1.0 (inclusion + niveau).
**Sources A-only** : aucune.
**Sources B-only** : aucune.

### Résolution des divergences

Aucune divergence — convergence complète entre Agent A et Agent B sur les 5 sources retenues.

---

## Calcul GRADE final

```
Score de départ : 2
  (source la plus haute directement pertinente = niveau 3 :
   GitHub Docs — définit opérationnellement les 3 modes de merge ;
   Conventional Commits v1.0.0 — spécification de référence pour le format de commit)

+ 1 convergence
  GitHub Docs (niv.3), Conventional Commits (niv.3, communauté ouverte multi-organisations),
  SEI CMU Blog (niv.4), Atlassian (niv.4), articles techniques (niv.4) convergent
  sans contradiction sur le même principe :
  (1) squash merge = stratégie par défaut pour les PRs de feature vers main
  (2) rebase = synchronisation locale uniquement, jamais sur branches partagées
  (3) Conventional Commits = format obligatoire pour le commit squashé
  (4) historique linéaire = prérequis pour git bisect en O(log n)
  Sources indépendantes : plateforme (GitHub), outillage DevOps (Atlassian), spécification
  ouverte (conventionalcommits.org), institution académique (CMU), praticiens ingénieurs —
  4 organisations distinctes convergentes.

Facteurs négatifs :
  - Pas d'incohérence entre sources (aucune source contredit les règles énoncées).
  - Légère indirectness : pas de RCT ou étude empirique contrôlée sur l'impact de la
    stratégie de merge — les sources sont normatives/prescriptives ou basées sur
    l'expérience pratique. Atténuée par la convergence multi-organisations et la
    justification algorithmique du git bisect (O(log n) est une propriété mathématique,
    pas une opinion).

Score final : 2 + 1 = 3 → [RECOMMANDE]
```

Note biais de publication : faible — les sources prescriptives (GitHub Docs, Conventional Commits) reflètent des pratiques adoptées par des milliers de projets. La justification git bisect est mathématiquement vérifiable (recherche binaire). Aucune source n'a d'intérêt commercial dans la recommandation d'une stratégie de merge spécifique.

---

## Analyse de sensibilité {#analyse-de-sensibilite}

| Source retirée | Score sans | Niveau sans | Changement ? |
|---------------|-----------|------------|:------------:|
| GitHub Docs | 2 (départ 2 via Conventional Commits, +1 conv intacte via 4 autres sources) | RECOMMANDE | NON |
| Conventional Commits v1.0.0 | 2 (départ 2 via GitHub Docs, +1 conv intacte) | RECOMMANDE | NON |
| SEI CMU Blog | 3 (convergence maintenue par 4 sources restantes) | RECOMMANDE | NON |
| Atlassian TBD | 3 (convergence maintenue par 4 sources restantes) | RECOMMANDE | NON |
| Articles git bisect | 2 (départ 2, convergence réduite à 3 sources — +1 maintenu) | RECOMMANDE | NON |
| Toutes sources niv.4 simultanément | 2 (départ 2, +1 conv via GitHub Docs + Conventional Commits) | RECOMMANDE | NON |
| Toutes sources sauf GitHub Docs | 2 (départ 2 Conventional Commits, +1 conv 3 sources restantes) | RECOMMANDE | NON |

**Conclusion : ROBUSTE** — recommandation [RECOMMANDE] stable pour tout retrait individuel et pour tout retrait par catégorie. La convergence est maintenue avec au minimum 3 sources indépendantes quelle que soit la combinaison de retraits testée. La robustesse est élevée malgré le grade modéré (3) car les sources convergent sur des règles précises et opérationnelles, pas sur des généralisations vagues.

---

## Sources exclues

| Source | Critère | Raison |
|--------|---------|--------|
| GitLab Docs — Merge methods | E5 redondance | Couvert par GitHub Docs ; même principe (squash/rebase/merge commit), contexte plateforme différent sans apport différencié pour le principe universel |
| Google Engineering Practices — Small CLs | E2 scope | Traite la taille des commits et l'atomicité — adjacent mais pas la stratégie de merge PR spécifiquement ; candidat pour PICOC commit-size |
| semver.org spec v2.0.0 | E5 supplanté | Absorbé par Conventional Commits v1.0.0 qui définit le mapping feat/fix/BREAKING CHANGE → SemVer directement |
| Microsoft Azure DevOps — Merge strategies | E5 redondance | Redondant avec GitHub Docs, moins précis sur la configuration squash et le message de commit squashé |
| release-please / semantic-release documentation | E2 scope | Implémentation outillage spécifique — candidat pour variant ci-cd-release-tools ; le principe d'automatisation est couvert par SEI CMU Blog |
| Pro Git book — chapitre rebasing (Chacon, Straub) | E3 scope trop large | Traite le rebase en général (interactif, de base, onto) ; la partie pertinente à la stratégie de merge PR est absorbée par GitHub Docs et articles techniques retenus |
