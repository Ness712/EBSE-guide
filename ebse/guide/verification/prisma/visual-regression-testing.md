# PRISMA Flow — PICOC visual-regression-testing

**Date de recherche** : 2026-04-17
**Bases interrogées** : Playwright docs (Microsoft), Storybook docs, Chromatic docs, Percy/BrowserStack docs, CSS-Tricks, WebSearch général
**Mots-clés Agent A** : "visual regression testing playwright toHaveScreenshot", "storybook visual testing automated", "visual diff CI pipeline frontend", "baseline images version control VRT", "chromatic storybook visual testing gate PR", "playwright screenshot determinism dynamic elements"
**Mots-clés Agent B** : "automated visual regression testing frontend", "percy visual testing pull request workflow", "storybook chromatic turbosnap CI", "playwright visual comparison false positives environment", "snapshot testing baseline VCS git", "visual regression testing component-level page-level"
**Protocole** : methodology.md v3.0 §2.1 — double extraction indépendante (Agents A + B, mots-clés différents) + synthèse Agent C

---

## Flux

```
IDENTIFICATION
  Sources identifiées par base (Agent A + Agent B combinés, avant déduplication) :
    - Documentation framework officielle (Playwright, Storybook) : 4 résultats candidats
    - Documentation service/outil VRT (Chromatic, Percy, Applitools) : ~8 résultats candidats
    - Articles techniques communauté (CSS-Tricks, Smashing Magazine, dev.to) : ~12 résultats candidats
    - Articles académiques / conférences testing : ~6 résultats candidats
    - Snowballing backward (références citées par sources principales) : ~4 sources
  Total identifié (brut, combiné A+B) : ~34
  Doublons retirés (même source identifiée par A et B) : 5 (Playwright docs, Storybook docs, Chromatic docs, Percy docs, CSS-Tricks Playwright VRT)
  Total après déduplication : ~29

SCREENING (titre + résumé)
  Sources screenées : ~29
  Sources exclues au screening : ~18
    - E1 (blog opinion sans données ou méthodologie) : ~7
    - E2 (hors scope PICOC — testing général, pas régression visuelle spécifiquement) : ~5
    - E3 (doublons partiels — couverts par sources primaires déjà incluses) : ~4
    - E4 (vendeur / marketing sans substance technique) : ~2

ELIGIBILITÉ (lecture complète)
  Sources évaluées en détail : ~11
  Sources exclues après lecture complète : ~6
    - Hors scope PICOC strict (outils VRT non maintenus ou legacy : BackstopJS, Wraith) : 2
    - Niveau de preuve insuffisant (tutoriels blog sans bonnes pratiques, pas de guidance CI) : 2
    - Redondance forte avec sources incluses sans apport supplémentaire : 2

INCLUSION
  Sources incluses dans la synthèse : 5
    - Niveau 3 : 3 (Playwright docs, Storybook docs, CSS-Tricks)
    - Niveau 4 : 2 (Chromatic docs, Percy/BrowserStack docs)

  Sources exclues avec raison documentée : 6
    - Applitools Eyes documentation : redondance avec Chromatic/Percy sur le principe du gate PR — candidat pour variant spécifique Applitools
    - BackstopJS documentation : outil moins adopté, hors écosystème Playwright/Storybook, pas de gate PR natif
    - Wraith (BBC) : outil archivé, hors maintenance depuis 2019
    - Smashing Magazine — VRT overview : absorbé par CSS-Tricks + docs officielles sans apport différencié
    - Articles académiques testing automatisé UI (3 papiers IEEE/ACM) : traitent la détection de bugs visuels en général, pas la mise en œuvre opérationnelle du VRT en CI
    - Tutorial blog posts (≥3 sources dev.to) : niveaux redondants — couverts par CSS-Tricks avec plus de rigueur
```

---

## Documentation recherche (Table 2 Kitchenham)

### Agent A — bases interrogées

| Élément | Valeur |
|---------|--------|
| Bases | Playwright docs, Storybook docs, Chromatic docs, CSS-Tricks, WebSearch général |
| Mots-clés | "visual regression testing playwright toHaveScreenshot", "storybook visual testing automated", "visual diff CI pipeline frontend", "baseline images version control VRT", "chromatic storybook visual testing gate PR", "playwright screenshot determinism dynamic elements" |
| Période couverte | 2022-2024 |
| Sources identifiées | ~18 |
| Sources retenues | 5 |
| Date d'extraction | 2026-04-17 |

### Agent B — bases interrogées

| Élément | Valeur |
|---------|--------|
| Bases | Percy/BrowserStack docs, Storybook docs, Playwright docs, WebSearch général, dev.to, Smashing Magazine |
| Mots-clés | "automated visual regression testing frontend", "percy visual testing pull request workflow", "storybook chromatic turbosnap CI", "playwright visual comparison false positives environment", "snapshot testing baseline VCS git", "visual regression testing component-level page-level" |
| Période couverte | 2022-2024 |
| Sources identifiées | ~16 |
| Sources retenues | 5 (convergence élevée avec A) |
| Date d'extraction | 2026-04-17 |

---

## Sources exclues — raisons documentées

| Source | Raison exclusion |
|--------|-----------------|
| Applitools Eyes documentation | Redondance — principe du gate PR couvert par Chromatic + Percy sans apport différencié ; candidat pour variant Applitools |
| BackstopJS documentation | Outil moins adopté dans l'écosystème Playwright/Storybook ; pas de gate PR natif ; couvert par les sources incluses sur les principes fondamentaux |
| Wraith (BBC) | Outil archivé, hors maintenance depuis 2019 — non applicable aux projets actuels |
| Smashing Magazine — Visual Regression Testing overview | Absorbé par CSS-Tricks + documentation officielles sans apport différencié sur les bonnes pratiques CI |
| Articles académiques testing automatisé UI (IEEE/ACM) | Traitent la détection de bugs visuels en général — n'apportent pas de guidance opérationnelle supplémentaire pour l'implémentation en CI |
| Blog posts tutoriels dev.to (≥3 sources) | Redondance niveau 5 — couverts par CSS-Tricks avec plus de rigueur et de traçabilité |
