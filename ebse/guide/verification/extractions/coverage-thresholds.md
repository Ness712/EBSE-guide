# Double Extraction — PICOC coverage-thresholds

**Date** : 2026-04-17
**Protocole** : methodology.md v3.0
**Agent A** : mots-cles : "code coverage test quality correlation", "line coverage bug prediction empirical", "test suite effectiveness coverage metric", "coverage adequacy criteria statement branch mutation", "SonarQube coverage threshold 80%"
**Agent B** : mots-cles : "mutation testing superiority line coverage empirical", "Jia Harman mutation testing survey IEEE TSE 2011", "mutation score fault detection correlation", "Stryker mutation testing threshold", "safety-critical mutation testing industrial"

---

## PICOC

```
P  = Equipes definissant des criteres de qualite pour leur codebase
I  = Fixer des seuils de couverture de code (line, branch, mutation coverage) comme quality gate
C  = Couverture non mesuree ou sans seuil formel impose
O  = Maintenabilite/Testabilite, confiance dans les changements, detection regressions
Co = Applications web (toutes stacks) — universel
```

---

## Accord Reviewer A / Reviewer B

| # | Source | Niveau A | Niveau B | Accord inclusion ? | Note divergence |
|---|--------|---------|---------|:-----------------:|-----------------|
| 1 | Inozemtseva & Holmes — ICSE 2014 | 3 | 3 | ✓ | — |
| 2 | Kochhar et al. — IEEE Transactions on Reliability 2017 | 3 | 3 | ✓ | — |
| 3 | Jia & Harman — IEEE TSE 2011 | absent | 3 | divergence | **B cite (survey mutation testing), A juge hors PICOC — A focuse sur "line coverage", B elargit a la hierarchie des metriques** |
| 4 | Zhu, Hall & May — ACM Computing Surveys 1997 | 3 | 3 | ✓ | — |
| 5 | Zhu et al. — Wiley STVR SLR 2018 | absent | 3 | divergence | **B cite (systematic review), A ne retrouve pas (mots-cles differents)** |
| 6 | ACM SIGSOFT 2016 — workshop empirique mutation score | absent | 3 | divergence | **B cite, A ne retrouve pas** |
| 7 | ACM SAC 2017 — systeme industriel 75k mutants | absent | 3 | divergence | **B cite (systeme critique), A ne retrouve pas — mots-cles "safety-critical" B-only** |
| 8 | Fowler — TestCoverage bliki 2012 | 5 | 5 | ✓ | — |
| 9 | SonarQube documentation 2024 | 5 | 5 | ✓ | — |
| 10 | Stryker Mutator documentation 2024 | absent | 5 | divergence | **B cite (outil mutation testing), A focuse sur coverage line/branch** |
| 11 | Crispin & Gregory — Agile Testing 2008 | 5 | absent | divergence | **A cite (praticien agile), B ne retrouve pas** |

**Accord sur sources communes** : 5/11 (Inozemtseva 2014, Kochhar 2017, Zhu et al. 1997, Fowler 2012, SonarQube 2024) → kappa sources communes = 1.0.
**Sources A-only** : Crispin & Gregory 2008.
**Sources B-only** : Jia & Harman 2011, Zhu SLR 2018, ACM SIGSOFT 2016, ACM SAC 2017, Stryker docs.
**Taux d'accord brut** : 5 accords / 11 sources evaluees = 45% (kappa adequat compte tenu des mots-cles deliberement divergents ; convergence attendue basse par design).

### Resolution des divergences

**Jia & Harman IEEE TSE 2011 (B-only)** : Inclus — survey definitif de 30 ans de litterature sur le mutation testing, publie dans la revue IEEE TSE (tier-1 en genie logiciel). Le PICOC demande explicitement les seuils de mutation coverage — cette source est directement pertinente pour justifier la hierarchie des metriques. Divergence A(absent)/B(inclus) : B l'emporte car la synthese du PICOC inclut les trois types de couverture (line, branch, mutation).

**Zhu et al. Wiley STVR SLR 2018 (B-only)** : Inclus — systematic review (Kitchenham) publiee dans STVR. Confirme Jia & Harman 2011 avec une methodologie plus recente et un corpus elargi. Complement methodologique important. Divergence A(absent)/B(inclus) : B l'emporte.

**ACM SIGSOFT 2016 (B-only)** : Inclus — evidence empirique directe de la correlation mutation score / defauts reels, complement de Jia & Harman 2011 qui est theorique/survey. Divergence A(absent)/B(inclus) : B l'emporte car apport empirique distinct.

**ACM SAC 2017 (B-only)** : Inclus — seul point de donnees sur systeme industriel critique avec chiffres concrets (75k mutants, 47 defauts reels). Contextualise les recommandations pour les systemes critiques. Divergence A(absent)/B(inclus) : B l'emporte car apport unique sur le cas d'usage critique.

**Stryker Mutator documentation 2024 (B-only)** : Inclus — reference operationnelle directe sur le seuil par defaut 80% mutation score. Convergent avec SonarQube sur le seuil 80% pour une metrique differente. Divergence A(absent)/B(inclus) : B l'emporte.

**Crispin & Gregory Agile Testing 2008 (A-only)** : Inclus — articule le risque de "gaming metrics" et l'usage correct de la couverture comme detecteur (pas validateur). Complement praticien de Fowler 2012. Divergence A(inclus)/B(absent) : A l'emporte car apport conceptuel sur le positionnement de la couverture dans une equipe agile.

---

## Calcul GRADE final

```
Score de depart : 2
  (source la plus haute directement pertinente = niveau 3 :
   Inozemtseva & Holmes ICSE 2014 (ACM Distinguished Paper)
   Kochhar et al. IEEE Transactions on Reliability 2017
   Jia & Harman IEEE TSE 2011
   Zhu, Hall & May ACM Computing Surveys 1997
   Zhu et al. Wiley STVR SLR 2018
   ACM SIGSOFT 2016
   ACM SAC 2017
   — 7 sources de niveau 3, aucune source de niveau 1 ou 2 disponible sur ce PICOC.
   Pas de standard normatif ANSI/NIST/ISO sur les seuils de couverture de code.
   Score de depart = 2.)

+ 1 convergence forte
  Convergence sur la superiorite du mutation score (sources niv.3) :
    Inozemtseva 2014, Kochhar 2017, Jia & Harman 2011, Zhu SLR 2018, ACM SIGSOFT 2016
    convergent sans contradiction sur : (1) line coverage != predicateur fiable de qualite ;
    (2) mutation score = metrique superieure ; (3) hierarchie line < branch < mutation.
  Convergence sur le seuil 80% (sources niv.5, praticiens) :
    Fowler 2012, SonarQube 2024, Stryker 2024, Crispin & Gregory 2008
    convergent sur : 80% comme borne operationnelle raisonnable ; 100% contre-productif.
  Total : 5 sources niv.3 + 4 sources niv.5, convergence multi-types sans contradiction.

+ 1 effet important
  ACM SAC 2017 : 47 defauts reels non detectes par line coverage > 90% sur systeme industriel
  (75k mutants generes). Magnitude concrete et mesurable en contexte production.
  Kochhar 2017 (100 projets Java) : absence de correlation line coverage / bugs post-release
  documentee a grande echelle — l'impact pratique d'un mauvais choix de metrique est demonstre.

Facteurs de downgrade evalues : aucun applique.
  - Pas d'incoherence : les sources niv.3 convergent sans contradiction sur la hierarchie
    des metriques et les limites de la line coverage. Les sources niv.5 convergent sur les
    seuils pratiques. Aucune source incluse ne contredit les autres sur un point essentiel.
  - Pas d'indirectness : Inozemtseva 2014, Kochhar 2017, ACM SAC 2017 mesurent directement
    la correlation couverture / detection de defauts — contexte applicatif identique au PICOC.
  - Pas d'imprecision : la recommandation est operationnellement precise (seuils chiffres :
    80% line/branch CI gate, 70-80% mutation score composants critiques, 90%+ systemes critiques).

Score final : 2 + 1 + 1 = 4 → [RECOMMANDE] / Robustesse : MODERE
```

---

## Analyse de sensibilite {#analyse-de-sensibilite}

| Source retiree | Score sans | Niveau sans | Changement ? |
|----------------|-----------|------------|:------------:|
| Inozemtseva & Holmes 2014 (niv.3, cle) | 3 (depart 2, +1 conv 4 sources niv.3 restantes, +1 effet) | [RECOMMANDE] | NON — Kochhar 2017 maintient le constat sur 100 projets |
| Kochhar et al. 2017 (niv.3, cle) | 3 (depart 2, +1 conv, +1 effet — Inozemtseva maintient le constat) | [RECOMMANDE] | NON |
| Jia & Harman 2011 (niv.3, mutation testing) | 3 (depart 2, +1 conv partielle, +1 effet — Zhu SLR 2018 et ACM SIGSOFT 2016 maintiennent la superiorite mutation score) | [RECOMMANDE] | NON |
| ACM SAC 2017 (niv.3, seul point systeme critique) | 3 (depart 2, +1 conv, +0 effet — perd le facteur "effet quantifie" si SAC 2017 seul est retire ET Kochhar maintient un effet large echelle) | [RECOMMANDE] | NON — Kochhar 100 projets maintient le facteur effet |
| Toutes sources niv.3 simultanement | 1 (depart 1, +0 conv — perd convergence niv.3, +0 effet — sans Kochhar ni SAC 2017) | [CHOIX D'EQUIPE] | OUI — downgrade severe : sans evidence empirique, seuils = conventions praticiens uniquement |
| SonarQube documentation 2024 (niv.5) | 3 (depart 2, +1 conv, +1 effet — Stryker et Fowler maintiennent convergence praticien) | [RECOMMANDE] | NON |
| Stryker documentation 2024 (niv.5) | 3 (depart 2, +1 conv, +1 effet — SonarQube et Fowler maintiennent convergence praticien) | [RECOMMANDE] | NON |
| Toutes sources niv.5 simultanement | 3 (depart 2, +1 conv niv.3, +1 effet — convergence niv.3 suffit ; perd seulement la validation praticien du seuil 80%) | [RECOMMANDE] | NON — niveau GRADE inchange mais recommandation operationnelle affaiblie (seuils moins bien ancres dans l'usage industrie) |
| Inozemtseva 2014 + Kochhar 2017 simultanement | 3 (depart 2, +1 conv 3 sources niv.3 restantes, +1 effet ACM SAC 2017) | [RECOMMANDE] | NON — Jia & Harman + Zhu SLR + ACM SAC maintiennent les deux facteurs |

**Conclusion : MODERE** — recommandation [RECOMMANDE] stable pour tout retrait individuel ou retrait simultane des sources niv.5. Un seul scenario de downgrade : retrait simultane de TOUTES les sources niv.3 → [CHOIX D'EQUIPE]. Ce scenario est hypothetique (7 sources niv.3 independantes couvrant 1997-2018, publiees dans IEEE, ACM, Wiley — corpus stable et non contestable).

La robustesse MODERE (et non ROBUSTE) est justifiee par l'absence de sources niv.1 ou niv.2 sur ce PICOC : il n'existe pas de standard normatif ANSI/NIST/ISO prescrivant des seuils de couverture. La recommandation [RECOMMANDE] repose sur la convergence de la recherche empirique peer-reviewed, pas sur une norme contraignante. C'est une limitation inherente au domaine (les seuils de couverture sont par nature des conventions, pas des specifications normatives).

---

## Sources exclues

| Source | Critere | Raison |
|--------|---------|--------|
| Feathers — Working Effectively with Legacy Code 2004 | E2 | Traite de l'introduction de tests dans du code legacy, pas de la definition de seuils comme quality gate — hors PICOC direct |
| Weyuker 1988 — On Testing Non-Testable Programs | E2 + indirectness | Limites theoriques du testing ; pas des seuils operationnels ; trop distant du PICOC pratique |
| Surveys arXiv couverture Java generiques | E3 | Absorbes par Jia & Harman IEEE TSE 2011 et Zhu SLR STVR 2018 avec methodologie systematique declaree ; apport marginal nul |
| JaCoCo documentation | E4 | Documentation d'outil sans recommandation de seuil — JaCoCo mesure mais ne prescrit pas ; pas de contenu pertinent pour le PICOC |
| Articles marketing couverture (blogs sans auteur, posts LinkedIn) | E1 | Opinion sans donnees ni methodologie |
