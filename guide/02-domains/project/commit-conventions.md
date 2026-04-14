# Conventions de commit

**[RECOMMANDE]** **Conventional Commits** | Score GRADE : 4/7

## Format

```
OLS-{TICKET} {type}({scope}): {description}

# Exemples
OLS-142 feat(mycologie): ajouter identification par microscopie
OLS-143 fix(chat): corriger deconnexion WebSocket en veille
OLS-144 refactor(lab): extraire service de validation des reponses
OLS-145 test(auth): ajouter tests integration JWT refresh
```

## Types

| Type | Usage | Impact version |
|------|-------|---------------|
| feat | Nouvelle fonctionnalite | minor (1.x.0) |
| fix | Correction de bug | patch (1.0.x) |
| refactor | Restructuration sans changement de comportement | - |
| docs | Documentation | - |
| test | Ajout/modification de tests | - |
| chore | Maintenance (deps, CI, config) | - |

## Versioning automatise

```yaml
# semantic-release — version auto basee sur les types de commit
- uses: cycjimmy/semantic-release-action@v4
  with:
    branches: ['main']
# feat → minor, fix → patch, BREAKING CHANGE → major
```

Sources : conventionalcommits.org v1.0.0 (niv. 5), Angular commit guidelines (niv. 3), semantic-release docs (niv. 3), DORA — commit discipline correle avec deployment frequency (niv. 4)
