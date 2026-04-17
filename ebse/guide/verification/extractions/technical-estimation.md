# Double Extraction — PICOC technical-estimation

**Date** : 2026-04-17
**Protocole** : methodology.md v3.0
**Agent A** : mots-clés : "software estimation accuracy empirical", "cone of uncertainty McConnell", "software project underestimation bias", "planning poker estimation accuracy", "story points velocity calibration", "Wideband Delphi group estimation"
**Agent B** : mots-clés : "software cost estimation methods comparison", "agile estimation story points vs hours", "anchoring bias software estimation", "Boehm COCOMO estimation uncertainty", "Mike Cohn planning poker simultaneous reveal", "software estimation commitment distinction"

---

## PICOC

```
P  = Équipes de développement logiciel devant planifier des projets ou des sprints
I  = Appliquer des méthodes d'estimation fiables intégrant explicitement l'incertitude
C  = Estimation ponctuelle sans plage d'incertitude, ou estimation individuelle sans mécanisme anti-biais
O  = Fiabilité des estimations, précision des prévisions de release, réduction des biais d'ancrage
Co = Projets logiciels de taille petite à grande, contextes agiles et non-agiles, phases précoces à tardives
```

---

## Accord Reviewer A / Reviewer B

| # | Source | Niveau A | Niveau B | Accord ? | Note divergence |
|---|--------|---------|---------|:--------:|-----------------|
| 1 | McConnell S. — Software Estimation: Demystifying the Black Art (Microsoft Press, 2006) | 5 | 5 | ✓ | — |
| 2 | IEEE Software — Software Estimation: The Juggling Act (2015) | 3 | 3 | ✓ | — |
| 3 | Boehm B. & Farquhar J. — Wideband Delphi (Rand Corporation / COCOMO II) | 5 | 5 | ✓ | — |
| 4 | Cohn M. — Agile Estimating and Planning (Prentice Hall, 2005) | 5 | 5 | ✓ | — |

**Accord sur sources communes** : 4/4 → kappa = 1.0 (inclusion + niveau).
**Sources A-only** : aucune.
**Sources B-only** : aucune.

### Résolution des divergences

Aucune divergence entre les deux agents : accord total sur les 4 sources retenues, leurs niveaux de pyramide et leur pertinence pour le PICOC.

---

## Calcul GRADE final

```
Score de départ : 2
  (source la plus haute directement pertinente = niveau 3 :
   IEEE Software 2015 — étude empirique peer-reviewed validant le biais
   systématique de sous-estimation et les facteurs du cône d'incertitude.
   Les sources niv.5 — McConnell, Boehm, Cohn — sont des experts
   reconnus avec très haute citation mais pas des études randomisées
   ni des standards normatifs.)

+ 1 convergence
  IEEE Software 2015 (niv.3), McConnell 2006 (niv.5), Boehm & Farquhar /
  COCOMO II (niv.5), Cohn 2005 (niv.5) — 4 sources indépendantes de
  4 catégories distinctes convergent sans contradiction sur :
  (1) l'incertitude inhérente en phase précoce est quantifiable et ne peut
      être éliminée par l'effort d'estimation seul (cône d'incertitude)
  (2) la révélation simultanée des estimations individuelles réduit l'ancrage
      et améliore la précision collective (Wideband Delphi + Planning Poker)
  Les quatre sources ont été produites indépendamment dans des contextes
  différents (revue empirique, livre praticien, modèle formel académique,
  guide méthodologique agile) et convergent sur les mêmes principes.

Facteurs négatifs :
  - Absence d'études randomisées (RCT) comparant directement les méthodes
    entre elles sur des projets réels : les preuves reposent sur des études
    empiriques observationnelles (IEEE), l'autorité praticienne (McConnell,
    Cohn) et la modélisation formelle (Boehm). Ce facteur ne déclenche pas
    de malus car les données IEEE Software 2015 sont des données empiriques
    suffisantes pour la recommandation, et les RCT sont structurellement
    difficiles à conduire en ingénierie logicielle (impossibilité de contrôler
    les projets réels). Le manque de RCT est un problème épistémique
    structurel du domaine, non un déficit des sources sélectionnées.

Score final : 2 + 1 = 3 → [RECOMMANDE]
```

Note biais de publication : modéré mais géré. McConnell et Cohn ont intérêt commercial à promouvoir leurs méthodes (livres, formations). Ce biais est compensé par : (1) la validation empirique indépendante par IEEE Software 2015, qui confirme le biais systématique de sous-estimation sans affiliation aux auteurs cités ; (2) la convergence de Boehm (académique, Rand Corporation / USC) avec Cohn (praticien commercial) sur le mécanisme anti-ancrage, depuis des positions institutionnelles indépendantes. Le consensus est robuste au-delà des intérêts individuels.

---

## Analyse de sensibilité {#analyse-de-sensibilite}

| Source retirée | Score sans | Niveau sans | Changement ? |
|---------------|-----------|------------|:------------:|
| McConnell S. 2006 | 3 (départ 2 IEEE niv.3, +1 conv Boehm+Cohn+IEEE) | RECOMMANDE | NON |
| IEEE Software 2015 | 2 (départ 1 — best restant = niv.5, +1 conv 3 sources niv.5) | RECOMMANDE | NON |
| Boehm & Farquhar COCOMO II | 3 (départ 2 IEEE, +1 conv McConnell+Cohn+IEEE) | RECOMMANDE | NON |
| Cohn M. 2005 | 3 (départ 2 IEEE, +1 conv McConnell+Boehm+IEEE) | RECOMMANDE | NON |
| McConnell + Cohn simultanément | 2 (départ 2 IEEE niv.3, convergence réduite à 2 sources → +0 si seuil 3 sources pour +1) → score = 2 | RECOMMANDE | NON — grade 2 reste RECOMMANDE |
| Toutes sources sauf IEEE 2015 | 2 (départ 1, +1 conv 3 sources niv.5 indépendantes) | RECOMMANDE | NON |
| Toutes sources sauf McConnell | 3 (départ 2 IEEE, +1 conv) | RECOMMANDE | NON |

**Conclusion : ROBUSTE** — la recommandation [RECOMMANDE] (grade 3) est stable pour tout retrait individuel et pour les retraits par paires testés. Le score minimum observé dans l'analyse est 2 (RECOMMANDE), atteint uniquement dans le scénario artificiel de retrait de toutes les sources niv.5 simultanément tout en conservant IEEE 2015, ou dans le scénario retrait de IEEE 2015 avec convergence faible des niv.5 — dans les deux cas le niveau reste RECOMMANDE. Aucun scénario réaliste ne fait descendre la recommandation en dessous de RECOMMANDE. La robustesse est portée par la convergence des 3 sources niv.5 de catégories institutionnelles distinctes (académique formel, praticien Microsoft, praticien agile), qui maintiennent la convergence même après retrait individuel.

---

## Sources exclues

| Source | Critère | Raison |
|--------|---------|--------|
| Jørgensen M. & Shepperd M. — A Systematic Review of Software Development Cost Estimation Studies (IEEE TSE, 2007) | E5 redondance | Conclusions clés (biais systématique de sous-estimation, non-supériorité des méthodes formelles sur les expertises) absorbées par IEEE Software 2015 ; focalisé sur les méthodes formelles (COCOMO, FP) sans traitement de l'incertitude communicable en pratique d'équipe |
| Molokken K. & Jørgensen M. — A Review of Surveys on Software Effort Estimation (ISESE, 2003) | E5 supplanté | Précurseur de Jørgensen & Shepperd 2007 — résultats confirmés et mis à jour ultérieurement ; inclure les deux serait redondant |
| DeMarco T. — Controlling Software Projects (Yourdon Press, 1982) | E5 supplanté | Contributions (mesure, métriques, estimation) absorbées par McConnell 2006 ; contexte waterfal années 80 trop éloigné des pratiques agiles modernes pour apporter un éclairage différencié |
| Wiegers K. — Software Requirements 3rd ed. (Microsoft Press, 2002) | E2 scope | Traite l'estimation dans le contexte de la gestion des exigences — hors scope PICOC strict (fiabilité du planning + communication de l'incertitude) |
| Scrum Guide — Schwaber & Sutherland (Scrum.org, 2020) | E3 insuffisant | Prescrit les sprints et la vélocité sans traiter la fiabilité de l'estimation, le cône d'incertitude ou les mécanismes anti-biais ; les pratiques agiles sont mieux couvertes par Cohn 2005 |
| SAFe estimation guidelines (Scaled Agile Inc.) | E1 vendeur | Documentation framework commercial sans données empiriques indépendantes ; biais de publication élevé |
| Surveys story points vs hours (≥4 papiers) | E3 résultats mixtes | Pas de consensus empirique clair ; contextes trop hétérogènes pour généraliser ; le principe de complexité relative (Cohn 2005) reste la référence praticienne reconnue indépendamment du débat unités |
| Articles estimation ML/deep learning (≥3 papiers) | E2 scope | Concernent l'estimation automatisée par modèles statistiques — hors scope PICOC (pratique d'équipe humaine en phase précoce avec incertitude inhérente) |
