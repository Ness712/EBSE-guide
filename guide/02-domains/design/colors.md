# Palette de couleurs et contraste

**[STANDARD]** 2-3 teintes + neutres, contraste WCAG AA 4.5:1 minimum | Score GRADE : 6/7

## Palette

- 1 teinte primaire (marque) avec 10 nuances (50-950)
- 1 teinte accent/secondaire
- 1 jeu semantique : vert (succes), ambre (warning), rouge (erreur)
- Echelle neutre : 10 nuances du quasi-blanc au quasi-noir
- Maximum **5 ± 2** familles de teintes (ISO 9241-125, loi de Miller)

## Contraste

| Element | Ratio minimum | Source |
|---------|--------------|--------|
| Texte normal (< 24px) | 4.5:1 | WCAG 2.2 SC 1.4.3 (AA) |
| Texte large (>= 24px ou >= 18.66px bold) | 3:1 | WCAG 2.2 SC 1.4.3 |
| Composants UI et graphiques | 3:1 | WCAG 2.2 SC 1.4.11 |
| Indicateurs de focus | 3:1 | WCAG 2.2 SC 2.4.11 |

- Ne JAMAIS utiliser la couleur seule pour transmettre une information (WCAG 1.4.1)
- Dark mode : memes ratios, tester separement
- 95.9% des pages web echouent au contraste AA (WebAIM Million 2024)

## Verification

```bash
# axe-core detecte les problemes de contraste automatiquement
# Chrome DevTools → Accessibility panel → Contrast ratio
```

Sources : WCAG 2.2 SC 1.4.3 (niv. 1), ISO 9241-125 (niv. 1), Material Design 3 Color System (niv. 5), WebAIM Million 2024 (niv. 4)
