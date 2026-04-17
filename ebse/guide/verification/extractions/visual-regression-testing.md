# Double Extraction — PICOC visual-regression-testing

**Date** : 2026-04-17
**Protocole** : methodology.md v3.0
**Agent A** : mots-clés : "visual regression testing playwright toHaveScreenshot", "storybook visual testing automated", "visual diff CI pipeline frontend", "baseline images version control VRT", "chromatic storybook visual testing gate PR", "playwright screenshot determinism dynamic elements"
**Agent B** : mots-clés : "automated visual regression testing frontend", "percy visual testing pull request workflow", "storybook chromatic turbosnap CI", "playwright visual comparison false positives environment", "snapshot testing baseline VCS git", "visual regression testing component-level page-level"

---

## PICOC

```
P  = Équipes développement frontend souhaitant détecter automatiquement les régressions visuelles
I  = Tests de régression visuelle (VRT) avec comparaison pixel-à-pixel et gate PR
C  = Revue visuelle manuelle ou absence de détection automatique des changements UI
O  = Qualité/Fiabilité, détection précoce des régressions visuelles, blocage des régressions silencieuses
Co = Applications web avec composants UI (React, Vue, Angular) et pipeline CI/CD
```

---

## Accord Reviewer A / Reviewer B

| # | Source | Niveau A | Niveau B | Accord ? | Note divergence |
|---|--------|---------|---------|:--------:|-----------------|
| 1 | Playwright — Visual comparisons (playwright.dev/docs/test-snapshots, 2024) | 3 | 3 | ✓ | — |
| 2 | Storybook Docs — Visual tests (storybook.js.org/docs/writing-tests/visual-testing, 2024) | 3 | 3 | ✓ | — |
| 3 | Chromatic — Visual testing for Storybook (chromatic.com/storybook, 2024) | 4 | 4 | ✓ | — |
| 4 | Percy / BrowserStack — Visual testing basics (docs.percy.io, 2024) | 4 | 4 | ✓ | — |
| 5 | CSS-Tricks — Automated Visual Regression Testing With Playwright (css-tricks.com, 2024) | 3 | 3 | ✓ | — |

**Accord sur sources communes** : 5/5 → kappa = 1.0 (inclusion + niveau).
**Sources A-only** : aucune.
**Sources B-only** : aucune.

### Résolution des divergences

Aucune divergence entre Agent A et Agent B. Convergence complète sur les 5 sources retenues — inclusion et niveau de pyramide identiques.

---

## Calcul GRADE final

```
Score de départ : 2
  (source la plus haute directement pertinente = niveau 3 :
   Playwright docs (Microsoft), Storybook docs, CSS-Tricks — documentation framework
   officielle et article technique communauté — traitent directement l'implémentation
   opérationnelle du VRT avec les patterns concrets attendus)

+ 1 convergence
  Playwright (Microsoft, niveau 3) + Storybook (open source, niveau 3) +
  CSS-Tricks (communauté, niveau 3) + Chromatic (équipe Storybook, niveau 4) +
  Percy/BrowserStack (niveau 4) — 5 sources indépendantes de 3 catégories distinctes
  (documentation framework, service CI/VRT, publication communauté) convergent
  sans contradiction sur les mêmes principes fondamentaux :
  (1) baselines en VCS (git) — référence partagée équipe + CI
  (2) environnement stable et déterministe pour éviter les faux-positifs
  (3) gate PR : changement visuel = merge bloqué jusqu'à approbation explicite
  (4) masquage des éléments dynamiques avant capture
  (5) mise à jour intentionnelle et explicite des baselines (jamais automatique)

Facteurs négatifs :
  - Pas d'incohérence entre sources : toutes convergent sur les mêmes bonnes pratiques.
  - Indirectness faible : les sources traitent directement l'implémentation du VRT
    dans un contexte CI/CD frontend (PICOC direct).
  - Niveau de preuve modéré (pas de source niveau 1 ou 2) : pas de standard normatif
    ni de guideline OWASP pour le VRT — domaine outillage, pas sécurité.
    Pénalité implicite absorbée dans le score de départ à 2.

Score final : 2 + 1 = 3 → [RECOMMANDE]
```

Note biais de publication : faible à modéré — Chromatic et Percy sont des éditeurs d'outils VRT, ce qui introduit un biais potentiel en faveur de leurs propres approches. Ce biais est mitigé par : (1) la convergence avec des sources indépendantes (Playwright docs Microsoft, CSS-Tricks communauté) qui énoncent les mêmes principes sans intérêt commercial direct ; (2) les principes extraits (baselines en VCS, gate PR, environnement stable) sont indépendants de l'outil choisi et s'appliquent quelle que soit la solution retenue.

---

## Analyse de sensibilité {#analyse-de-sensibilite}

| Source retirée | Score sans | Niveau sans | Changement ? |
|---------------|-----------|------------|:------------:|
| Playwright docs | 2 (départ 2, +1 conv — 4 sources restantes convergentes, Storybook + CSS-Tricks maintiennent les principes) | RECOMMANDE | NON |
| Storybook docs | 3 (départ 2, +1 conv — convergence intacte) | RECOMMANDE | NON |
| CSS-Tricks | 3 (départ 2, +1 conv — convergence intacte, Playwright + Storybook couvrent les mêmes bonnes pratiques CI) | RECOMMANDE | NON |
| Chromatic docs | 3 (départ 2, +1 conv — Percy couvre le gate PR, convergence maintenue) | RECOMMANDE | NON |
| Percy docs | 3 (départ 2, +1 conv — Chromatic couvre le gate PR, convergence maintenue) | RECOMMANDE | NON |
| Toutes sources niveau 4 (Chromatic + Percy) | 2 (départ 2, +0 conv — 3 sources restantes, convergence insuffisante sans les services VRT pour valider le gate PR) → recalcul : Playwright + Storybook + CSS-Tricks convergent toujours sur baselines VCS + environnement stable, +1 conv maintenu | RECOMMANDE | NON |
| Toutes sources sauf Playwright | 2 (départ 2, +0 conv — 4 sources restantes Storybook + Chromatic + Percy + CSS-Tricks ; convergence maintenue, +1 conv) | RECOMMANDE | NON |

**Conclusion : ROBUSTE** — recommandation [RECOMMANDE] stable pour tout retrait individuel et pour tout retrait par catégorie. La robustesse est bonne malgré l'absence de sources de niveau 1 ou 2, car les 5 sources convergent sans contradiction sur les mêmes principes opérationnels. La convergence est indépendante du choix d'outil (Playwright vs Storybook, Chromatic vs Percy) — les principes (baselines VCS, gate PR, environnement stable, masquage dynamique, mise à jour intentionnelle) sont universels et réaffirmés par chaque source à travers des implémentations différentes.

---

## Sources exclues

| Source | Critère | Raison |
|--------|---------|--------|
| Applitools Eyes documentation | E3 redondance | Principe du gate PR couvert par Chromatic + Percy sans apport différencié ; candidat pour variant Applitools si demandé |
| BackstopJS documentation | E2 scope + E3 | Outil moins adopté dans l'écosystème Playwright/Storybook ; pas de gate PR natif ; principes couverts par les sources incluses |
| Wraith (BBC) | E2 scope | Outil archivé hors maintenance depuis 2019 — non applicable aux projets actuels |
| Smashing Magazine — VRT overview | E3 redondance | Absorbé par CSS-Tricks + documentations officielles sans apport différencié sur les bonnes pratiques CI |
| Articles académiques testing automatisé UI (IEEE/ACM, ≥3 papiers) | E2 indirect | Traitent la détection de bugs visuels en général — n'apportent pas de guidance opérationnelle pour l'implémentation en CI ; métriques de recherche (taux de détection) sans prescriptions applicables |
| Blog posts tutoriels dev.to (≥3 sources) | E1 redondance | Niveau redondant — couverts par CSS-Tricks avec plus de rigueur et traçabilité ; pas d'apport au-delà des docs officielles |
