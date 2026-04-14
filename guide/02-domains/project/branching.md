# Branching Strategy

**[STANDARD]** Trunk-based development avec branches courtes (< 2 jours) | Score GRADE : 5/7

```
"Trunk-based development combined with automated testing in CI reduces
 change failure rate by 50% compared to long-lived branches."
 — DORA State of DevOps 2024
```

## Workflow

```
feature/OLS-123-description  →  staging  →  main
        (< 2 jours)           (auto-deploy)  (auto-deploy + tag)
```

## Regles

| Regle | Source |
|-------|--------|
| Branches < 2 jours | DORA/Accelerate — predictor of elite performance |
| Pas de long-lived branches | DORA — correle avec +50% change failure rate |
| Feature flags pour travail incomplet | trunk-based development best practice |
| PR review obligatoire avant merge | DORA — quality gate |

## Pourquoi pas GitFlow

GitFlow (develop, release, hotfix branches) ajoute de la complexite et retarde le feedback. DORA montre que les equipes elite utilisent trunk-based, pas GitFlow.

Sources : DORA/Accelerate 30k+ devs (niv. 4), DORA State of DevOps 2019-2024 (niv. 4), trunkbaseddevelopment.com (niv. 5), GitHub Flow docs (niv. 3)
