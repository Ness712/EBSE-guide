# PRISMA Flow — PICOC coverage-thresholds

**Date de recherche** : 2026-04-17
**Bases interrogees** : ACM Digital Library (ICSE, ASE, ISSTA proceedings), IEEE Xplore (TSE, Transactions on Reliability), Wiley STVR (Software Testing, Verification and Reliability), WebSearch general (bliki Fowler, SonarQube docs, Stryker docs, Agile Testing)
**Mots-cles Agent A** : "code coverage test quality correlation", "line coverage bug prediction empirical", "test suite effectiveness coverage metric", "coverage adequacy criteria statement branch mutation", "Inozemtseva Holmes ICSE 2014 mutation coverage correlation", "SonarQube coverage threshold 80%"
**Mots-cles Agent B** : "mutation testing superiority line coverage empirical", "Jia Harman mutation testing survey IEEE TSE 2011", "mutation score fault detection correlation", "Stryker mutation testing threshold", "coverage quality gate industry standard", "safety-critical mutation testing industrial"
**Protocole** : methodology.md v3.0 §2.1 — double extraction independante (Agents A + B, mots-cles differents)

---

## Flux

```
IDENTIFICATION
  Sources identifiees par base (Agent A + Agent B combines, avant deduplication) :
    - ACM Digital Library (ICSE, ASE, ISSTA, SAC, SIGSOFT) : 7 sources candidates
    - IEEE Xplore (TSE, Transactions on Reliability) : 4 sources candidates
    - Wiley STVR (systematic reviews, empirical studies) : 2 sources candidates
    - Outils / documentation industrie : 4 sources candidates (SonarQube, Stryker, PIT, JaCoCo)
    - Livres praticiens : 3 sources candidates (Fowler bliki, Crispin & Gregory, Working Effectively with Legacy Code)
    - WebSearch general : 3 sources candidates
  Total identifie (brut, combine A+B) : ~23
  Doublons retires (meme source identifiee par A et B) : 3 (Inozemtseva 2014, Kochhar 2017, Zhu et al. ACM CS 1997)
  Total apres deduplication : ~20

SCREENING (titre + resume)
  Sources screenees : ~20
  Sources exclues au screening : ~6
    - E1 (opinion sans donnees, blogs sans methodologie) : 2
    - E2 (hors scope PICOC — test selection, test generation, pas seuils) : 2
    - E4 (vendeur sans methodologie — JaCoCo docs, articles marketing) : 2

ELIGIBILITE (lecture complete)
  Sources evaluees en detail : ~14
  Sources exclues apres lecture complete : 3
    - Michael Feathers "Working Effectively with Legacy Code" 2004 : traite de l'introduction de tests
      dans du code legacy, pas des seuils de couverture comme quality gate — hors PICOC direct (E2)
    - Weyuker 1988 "On Testing Non-Testable Programs" : traite des limites theoriques du testing,
      pas des seuils operationnels — trop indirect (E2 + indirectness)
    - Survey arXiv couverture Java generiques (2 sources) : niveau 4-5, absorbes par Jia & Harman 2011
      et Zhu SLR 2018 qui couvrent la meme litterature avec une methodologie systematique (E3)

INCLUSION
  Sources incluses dans la synthese : 11
    - Niveau 3 (peer-reviewed, empirical, systematic review) : 7
        Inozemtseva & Holmes ICSE 2014 (ACM Distinguished Paper)
        Kochhar et al. IEEE Transactions on Reliability 2017
        Jia & Harman IEEE TSE 2011 (survey mutation testing)
        Zhu, Hall & May ACM Computing Surveys 1997
        Zhu et al. Wiley STVR SLR 2018
        ACM SIGSOFT 2016 (workshop empirique)
        ACM SAC 2017 (systeme industriel critique)
    - Niveau 5 (praticiens, documentation industrie) : 4
        Fowler — TestCoverage bliki 2012
        SonarQube documentation 2024
        Stryker Mutator documentation 2024
        Crispin & Gregory — Agile Testing 2008

  Sources exclues avec raison documentee : 3 (voir section "Sources exclues")
```

---

## Documentation recherche (Table 2 Kitchenham)

### Agent A — bases interrogees

| Element | Valeur |
|---------|--------|
| Bases | ACM Digital Library (ICSE, ASE, ISSTA), IEEE Xplore (TSE), WebSearch general (Fowler bliki, SonarQube) |
| Mots-cles | "code coverage test quality correlation", "line coverage bug prediction empirical", "test suite effectiveness coverage metric", "coverage adequacy criteria", "SonarQube coverage threshold 80%" |
| Periode couverte | 1997-2024 |
| Sources identifiees | ~13 |
| Sources retenues | 6 |
| Date d'extraction | 2026-04-17 |

### Agent B — bases interrogees

| Element | Valeur |
|---------|--------|
| Bases | IEEE Xplore (TSE, Transactions on Reliability), Wiley STVR, ACM (SAC, SIGSOFT), Stryker docs, outils industrie |
| Mots-cles | "mutation testing superiority line coverage empirical", "Jia Harman IEEE TSE 2011", "mutation score fault detection", "Stryker mutation testing threshold", "safety-critical mutation testing industrial" |
| Periode couverte | 2011-2024 |
| Sources identifiees | ~12 |
| Sources retenues | 8 |
| Date d'extraction | 2026-04-17 |

---

## Sources exclues — raisons documentees

| Source | Raison exclusion |
|--------|-----------------|
| Feathers — Working Effectively with Legacy Code (2004) | E2 — traite de l'introduction de tests dans du code legacy, pas des seuils de couverture comme quality gate — hors PICOC direct sur la definition de seuils |
| Weyuker 1988 — On Testing Non-Testable Programs | E2 + indirectness — limites theoriques du testing, pas des seuils operationnels ; trop distant du PICOC pratique |
| Surveys arXiv couverture Java generiques | E3 — absorbes par Jia & Harman IEEE TSE 2011 et Zhu SLR STVR 2018 qui couvrent la meme litterature avec methodologie systematique declaree (Kitchenham) ; apport marginal nul |
| JaCoCo documentation | E4 — documentation d'outil sans recommandation de seuil : JaCoCo ne prescrit pas de seuil, se contente de mesurer. Pas de contenu pertinent pour le PICOC |
| Articles marketing couverture (blogs sans auteur, posts LinkedIn) | E1 — opinion sans donnees, sans methodologie, sans possibilite de verification de la source |
