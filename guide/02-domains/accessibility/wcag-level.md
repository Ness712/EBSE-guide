# Niveau WCAG cible

**[STANDARD]** **WCAG 2.2 Level AA** | Score GRADE : 7/7

## Pourquoi AA et pas AAA

| Critere | AA | AAA |
|---------|-----|-----|
| Contraste texte | 4.5:1 | 7:1 (limite severement la palette) |
| Niveau de lecture | Pas de restriction | Niveau college requis (impossible pour contenu scientifique) |
| Legislation | **Obligatoire** (EU, US, Canada) | Aucune legislation ne l'exige |

## Criteres cles a implementer (AA)

| Critere | Description |
|---------|-------------|
| 1.1.1 | Alt text pour toutes les images |
| 1.3.1 | HTML semantique (headings, landmarks, lists) |
| 1.4.3 | Contraste 4.5:1 (texte normal) |
| 1.4.11 | Contraste 3:1 (composants UI) |
| 2.1.1 | Accessible au clavier |
| 2.4.7 | Focus visible |
| 2.4.11 | Focus non obscurci (nouveau WCAG 2.2) |
| 2.5.8 | Cible tactile min 24x24px (nouveau WCAG 2.2) |
| 3.3.8 | Authentification accessible (nouveau WCAG 2.2) |
| 4.1.2 | ARIA roles/states |

## Outillage

```bash
# Automatise (~30-40% des issues detectees)
npm install -D @axe-core/react
# En dev : import '@axe-core/react' — log violations dans la console

# CI
npx axe --rules wcag2a,wcag2aa https://localhost:3000

# Manuel (necessaire pour les 60-70% restants)
# Navigation clavier complete + test screen reader (NVDA/VoiceOver)
```

Sources : WCAG 2.2 W3C Recommendation 2023 (niv. 1), EU Web Accessibility Directive 2016/2102 (niv. 1), ADA/Section 508 (niv. 1), ISO 9241-171 (niv. 1), WebAIM Million 2024 — 95.9% echouent AA (niv. 4), axe-core Deque — 30-40% detection auto (niv. 3)
