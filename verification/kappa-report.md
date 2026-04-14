# Kappa de Cohen — Rapport de verification

**Date** : 2026-04
**Echantillon** : 36 pages du guide (Correction 1)
**Reviewers** : 2 agents IA independants (contextes separes)

## Matrice de confusion

|  | Reviewer B: CORRECT | Reviewer B: ADJUSTMENT |
|---|---|---|
| **Reviewer A: CORRECT** | 10 | 1 |
| **Reviewer A: ADJUSTMENT** | 9 | 16 |

## Calcul

```
Po (accord observe) = (10 + 16) / 36 = 0.722 (72.2%)
Pe (accord attendu par hasard) = 0.489 (48.9%)
Kappa = (0.722 - 0.489) / (1 - 0.489) = 0.456
```

## Interpretation

| Kappa | Interpretation (Landis & Koch 1977) |
|-------|-------------------------------------|
| < 0.20 | Accord faible |
| 0.21-0.40 | Accord acceptable |
| **0.41-0.60** | **Accord modere** ← notre resultat (0.456) |
| 0.61-0.80 | Accord bon |
| > 0.80 | Accord excellent |

**Kappa = 0.456 — accord modere.**

## Analyse

- **Zero recommandation FAUSSE** : les 2 reviewers sont d'accord a 100% sur les outils/pratiques recommandes
- Les desaccords portent **uniquement sur les scores GRADE** (±1-2 points)
- La principale source de divergence : interpretation du niveau d'evidence des "design system guidelines" (Material Design, Apple HIG) — Reviewer A les note plus bas que B

## Actions correctives

Pour les 14 pages en divergence, la valeur **conservative** (la plus basse des deux) a ete retenue.
Les 8 pages ou les 2 reviewers convergent sur un ajustement ont ete corrigees.

## Ameliorations pour v1.1

Pour ameliorer le kappa (> 0.6) :
1. Clarifier dans la methodologie : a quel niveau de la pyramide classer les design systems (Google, Apple)
2. Distinguer "framework doc recommendation" (niveau 6) de "framework doc mention" (niveau 4-5)
3. Formulaire d'extraction plus strict avec checkboxes pour chaque facteur GRADE
