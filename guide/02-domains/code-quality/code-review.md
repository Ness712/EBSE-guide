# Code Review

**[RECOMMANDE]** Review obligatoire par au moins 1 pair avant merge | Score GRADE : 4/7

La code review est le moyen le plus efficace de detecter des defauts. Les etudes montrent qu'elle trouve 60-70% des defauts, contre 25-30% pour les tests unitaires seuls.

## Processus

```
1. Auteur ouvre une PR avec description claire
2. Reviewer assigne (au moins 1, idealement connaissance du domaine)
3. Review dans les 24h (ne pas bloquer le flux)
4. Auteur applique les changements ou discute
5. Reviewer approuve → merge autorise
```

## Checklist de review

| Categorie | Points a verifier |
|-----------|-------------------|
| Correctness | La logique est-elle correcte ? Edge cases geres ? |
| Securite | Injection, auth, validation des inputs ? |
| Lisibilite | Nommage clair, pas de code mort, commentaires utiles ? |
| Tests | Tests presents et pertinents ? Cas limites couverts ? |
| Performance | Requetes N+1, boucles inutiles, complexite ? |
| Design | Respect de l'architecture, pas de couplage fort ? |

## Bonnes pratiques reviewer

| Pratique | Raison |
|----------|--------|
| Critiquer le code, pas la personne | Psycho safety, apprentissage |
| Distinguer bloquant vs suggestion | `nit:` pour les suggestions non bloquantes |
| Limiter a 400 lignes par review | Au-dela, la qualite de la review chute (SmartBear) |
| Review dans les 24h | Ne pas bloquer le cycle de deploiement |

## Bonnes pratiques auteur

| Pratique | Raison |
|----------|--------|
| PRs petites et focalisees | Plus faciles a review, merge plus rapide |
| Description claire (quoi + pourquoi) | Le reviewer comprend le contexte sans demander |
| Self-review avant assignation | Eliminer les erreurs evidentes |

## Sources

- [niv. 1] SWEBOK v4 — code inspection as verification technique
- [niv. 4] SmartBear study — 400 LOC max per review, 60-70% defect detection rate
- [niv. 5] Google Engineering Practices — code review guidelines, reviewer responsibilities
