# PRISMA Flow — PICOC technical-estimation

**Date de recherche** : 2026-04-17
**Bases interrogées** : IEEE Xplore, ACM Digital Library, Google Scholar, Microsoft Press / Prentice Hall (livres de référence), Rand Corporation (COCOMO II), Mountain Goat Software, WebSearch général
**Mots-clés Agent A** : "software estimation accuracy empirical", "cone of uncertainty McConnell", "software project underestimation bias", "planning poker estimation accuracy", "story points velocity calibration", "Wideband Delphi group estimation"
**Mots-clés Agent B** : "software cost estimation methods comparison", "agile estimation story points vs hours", "anchoring bias software estimation", "Boehm COCOMO estimation uncertainty", "Mike Cohn planning poker simultaneous reveal", "software estimation commitment distinction"
**Protocole** : methodology.md v3.0 §2.1 — double extraction indépendante (Agents A + B, mots-clés différents) + synthèse Agent C

---

## Flux

```
IDENTIFICATION
  Sources identifiées par base (Agent A + Agent B combinés, avant déduplication) :
    - Livres de référence praticiens (McConnell, Cohn, DeMarco, Wiegers) : ~8 résultats candidats
    - Articles académiques empiriques (IEEE Software, EMSE, IST) : ~14 résultats candidats
    - Modèles formels et rapports techniques (Boehm/COCOMO II, Rand Corporation) : ~6 résultats candidats
    - Guides méthodologiques agiles (Scrum Guide, SAFe, Mountain Goat) : ~10 résultats candidats
    - Surveys et méta-analyses (Jørgensen & Shepperd, Molokken & Jørgensen) : ~8 résultats candidats
    - Snowballing backward (références citées par sources principales) : ~6 sources
  Total identifié (brut, combiné A+B) : ~52
  Doublons retirés (même source identifiée par A et B) : 8 (McConnell 2006, IEEE Software 2015, Boehm COCOMO II, Cohn 2005, Jørgensen & Shepperd 2007, Molokken & Jørgensen 2003, DeMarco 1982, Wiegers 2002)
  Total après déduplication : ~44

SCREENING (titre + résumé)
  Sources screenées : ~44
  Sources exclues au screening : ~30
    - E1 (blog opinion sans données ou méthodologie) : ~9
    - E2 (hors scope PICOC — estimation non-logicielle ou aspects hors incertitude/fiabilité) : ~7
    - E3 (doublons partiels — couverts par sources primaires déjà incluses) : ~8
    - E4 (vendeur / marketing sans substance technique) : ~6

ELIGIBILITÉ (lecture complète)
  Sources évaluées en détail : ~14
  Sources exclues après lecture complète : ~10
    - Hors scope PICOC strict (estimation formelle COCOMO sans traitement de l'incertitude communicable) : 3
    - Niveau de preuve insuffisant (données auto-rapportées sans groupe contrôle, n < 10 projets) : 3
    - Redondance forte avec McConnell 2006 sans apport supplémentaire : 2
    - Résultats contradictoires non résolus, contexte trop différent du développement logiciel moderne : 2

INCLUSION
  Sources incluses dans la synthèse : 4
    - Niveau 3 : 1 (IEEE Software 2015)
    - Niveau 5 : 3 (McConnell 2006, Boehm & Farquhar / COCOMO II, Cohn 2005)

  Sources exclues avec raison documentée : 10
    - Jørgensen M. & Shepperd M. — A Systematic Review of Software Development Cost Estimation Studies (IEEE TSE, 2007) : couvert par IEEE Software 2015 sur les conclusions clés ; méta-analyse sur méthodes formelles (COCOMO, FP) plus que sur l'incertitude communicable
    - Molokken K. & Jørgensen M. — A Review of Surveys on Software Effort Estimation (ISESE, 2003) : précurseur de Jørgensen & Shepperd 2007, résultats absorbés par IEEE Software 2015
    - DeMarco T. — Controlling Software Projects (Yourdon Press, 1982) : précurseur historique pertinent mais résultats absorbés et mis à jour par McConnell 2006 ; ancienneté réduisant l'applicabilité aux contextes modernes
    - Wiegers K. — Software Requirements 3rd ed. (Microsoft Press, 2002) : traite l'estimation dans le contexte des exigences, pas du planning — hors scope PICOC strict
    - Scrum Guide (Schwaber & Sutherland, 2020) : prescrit les sprints et la vélocité mais ne traite pas directement la fiabilité de l'estimation ni le cône d'incertitude
    - SAFe estimation guidelines : documentation fournisseur (Scaled Agile Inc.) sans données empiriques indépendantes
    - Surveys académiques story points vs hours (≥4 papiers) : résultats mixtes sans consensus clair, contextes trop variables pour généraliser ; les principes Cohn 2005 restent la référence praticienne
    - Articles arXiv estimation deep learning (≥3 papiers) : hors scope — concernent l'estimation automatisée par ML, pas la pratique d'équipe en phase précoce
```

---

## Documentation recherche (Table 2 Kitchenham)

### Agent A — bases interrogées

| Élément | Valeur |
|---------|--------|
| Bases | IEEE Xplore, ACM Digital Library, Google Scholar, Microsoft Press |
| Mots-clés | "software estimation accuracy empirical", "cone of uncertainty McConnell", "software project underestimation bias", "planning poker estimation accuracy", "story points velocity calibration", "Wideband Delphi group estimation" |
| Période couverte | 2000-2024 |
| Sources identifiées | ~27 |
| Sources retenues | 4 |
| Date d'extraction | 2026-04-17 |

### Agent B — bases interrogées

| Élément | Valeur |
|---------|--------|
| Bases | ACM Digital Library, Google Scholar, Rand Corporation, Prentice Hall, Mountain Goat Software, WebSearch |
| Mots-clés | "software cost estimation methods comparison", "agile estimation story points vs hours", "anchoring bias software estimation", "Boehm COCOMO estimation uncertainty", "Mike Cohn planning poker simultaneous reveal", "software estimation commitment distinction" |
| Période couverte | 2000-2024 |
| Sources identifiées | ~25 |
| Sources retenues | 4 (convergence totale avec A) |
| Date d'extraction | 2026-04-17 |

---

## Sources exclues — raisons documentées

| Source | Raison exclusion |
|--------|-----------------|
| Jørgensen M. & Shepperd M. — A Systematic Review of Software Development Cost Estimation Studies (IEEE TSE, 2007) | Redondance — conclusions clés absorbées par IEEE Software 2015 ; focalisé sur méthodes formelles (COCOMO, Function Points) plus que sur l'incertitude communicable en pratique d'équipe |
| Molokken K. & Jørgensen M. — A Review of Surveys on Software Effort Estimation (ISESE, 2003) | Précurseur supplanté — résultats intégralement confirmés et mis à jour par Jørgensen & Shepperd 2007 puis IEEE Software 2015 |
| DeMarco T. — Controlling Software Projects (Yourdon Press, 1982) | Ancienneté — précurseur historique dont les contributions sont absorbées par McConnell 2006 ; contexte (projets waterfall années 80) trop différent des pratiques modernes |
| Wiegers K. — Software Requirements 3rd ed. (Microsoft Press, 2002) | Hors scope PICOC — traite l'estimation dans le contexte de la gestion des exigences, pas de la fiabilité du planning et de la communication de l'incertitude |
| Scrum Guide — Schwaber & Sutherland (Scrum.org, 2020) | Insuffisant — prescrit les sprints et la vélocité sans traiter la fiabilité de l'estimation ni la gestion du cône d'incertitude ; la pratique story points est mieux couverte par Cohn 2005 |
| SAFe estimation guidelines (Scaled Agile Inc.) | Vendeur — documentation framework commercial sans données empiriques indépendantes validant l'efficacité des pratiques recommandées |
| Surveys story points vs hours (≥4 papiers arXiv/ICSE) | Résultats mixtes — pas de consensus empirique clair sur la supériorité d'une unité d'estimation ; le principe Cohn (complexité relative) reste la référence praticienne reconnue |
| Articles estimation par ML/deep learning (≥3 papiers) | Hors scope PICOC — concernent l'estimation automatisée par modèles statistiques, pas la pratique d'équipe en phase précoce avec incertitude inhérente |
