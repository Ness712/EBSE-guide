# PRISMA Flow — PICOC coupling-cohesion-metrics

**Date de recherche** : 2026-04-17
**Bases interrogées** : IEEE Xplore, Empirical Software Engineering (Springer), IEEE Computer Society (SWEBOK), Pearson/Prentice Hall/Addison-Wesley/O'Reilly (livres de référence), SonarQube docs, NestJS docs, WebSearch général
**Mots-clés Agent A** : "coupling cohesion software design metrics", "CBO LCOM CK metrics object-oriented", "software component instability abstractness Martin", "DIT WMC coupling empirical fault prediction", "SonarQube cognitive cyclomatic complexity thresholds"
**Mots-clés Agent B** : "coupling cohesion measurement software quality", "lack of cohesion methods LCOM5 bug prediction", "component principles clean architecture ADP SDP SAP", "fitness functions architectural coupling JDepend", "NestJS circular dependency module coupling smell"
**Protocole** : methodology.md v3.0 §2.1 — double extraction indépendante (Agents A + B, mots-clés différents) + synthèse Agent C

---

## Flux

```
IDENTIFICATION
  Sources identifiées par base (Agent A + Agent B combinés, avant déduplication) :
    - Standards normatifs (SWEBOK, IEEE standards) : 3 résultats candidats
    - Livres de référence (Martin, Hunt & Thomas, McConnell, Ford et al., Khononov) : ~12 résultats candidats
    - Articles empiriques peer-reviewed (IEEE TSE, Empirical Software Engineering, IEEE Xplore) : ~15 résultats candidats
    - Documentation tooling (SonarQube, JDepend, NestJS, TypeScript) : ~10 résultats candidats
    - Blogs / opinion (Martin blog, DZone, Medium) : ~8 résultats candidats
    - Snowballing backward (références citées par sources principales) : ~6 sources
  Total identifié (brut, combiné A+B) : ~54
  Doublons retirés (même source identifiée par A et B) : 4 (SWEBOK v4, Martin Agile SD 2002, Chidamber & Kemerer 1994, Khononov 2024)
  Total après déduplication : ~50

SCREENING (titre + résumé)
  Sources screenées : ~50
  Sources exclues au screening : ~32
    - E1 (blog opinion sans données ou méthodologie) : ~8
    - E2 (hors scope PICOC — métriques non liées à couplage/cohésion : LOC, halstead, etc.) : ~10
    - E3 (doublons partiels — couverture identique à une source primaire déjà retenue) : ~9
    - E4 (vendeur/marketing sans substance technique ou biais commercial fort) : ~5

ELIGIBILITÉ (lecture complète)
  Sources évaluées en détail : ~18
  Sources exclues après lecture complète : ~8
    - Scope PICOC insuffisant (métriques OO mais pas couplage/cohésion spécifiquement) : 3
    - Niveau de preuve insuffisant (opinion sans données empiriques ni référence normative) : 2
    - Redondance forte avec sources déjà incluses sans apport différencié : 3

INCLUSION
  Sources incluses dans la synthèse : 10
    - Niveau 1 : 1 (SWEBOK v4 — IEEE Computer Society 2024)
    - Niveau 3 : 4 (Chidamber & Kemerer IEEE TSE 1994, IEEE TSE 2017 empirical study,
                    IEEE Xplore LCOM case study 2021, Palomba et al. Empirical SE 2018)
    - Niveau 3 tooling : 2 (SonarQube docs seuils, NestJS Circular Dependencies docs)
    - Niveau 5 : 3 (Martin Agile SD 2002, Martin Clean Architecture 2017,
                    Ford/Parsons/Kua Building Evolutionary Architectures 2022)
    - Niveau 5 récent : 1 (Khononov Balancing Coupling 2024)

  Sources exclues avec raison documentée : 8
    - Martin R. Clean Code (2008) : mentions superficielles du couplage, absorbé par Agile SD 2002 + Clean Architecture 2017
    - Gamma et al. Design Patterns (GoF, 1994) : pertinent indirectement (patterns réduisant le couplage) mais n'adresse pas les métriques
    - SonarQube Ce/Ca documentation pre-v6 : supprimée depuis SonarQube v6.x — mentionné comme note dans le principe
    - Lorenz & Kidd OO Software Metrics (1994) : absorbé par Chidamber & Kemerer (même génération, C&K plus cité)
    - Briand et al. — Unified Framework for Coupling Measurement (IEEE TSE 1999) : pertinent mais couverture similaire à C&K 1994 + IEEE TSE 2017 sans apport différencié net
    - arXiv preprints sur les métriques OO : non peer-reviewed, remplacés par les études IEEE TSE incluses
    - McCabe — A Complexity Measure (IEEE TSE 1976) : couvert via SonarQube docs (Cyclomatic Complexity) — source outil plus actionnable
    - CAST Software Research — Structural quality metrics : rapport éditeur commercial, biais implicite
```

---

## Documentation recherche (Table 2 Kitchenham)

### Agent A — bases interrogées

| Élément | Valeur |
|---------|--------|
| Bases | IEEE Xplore, ACM Digital Library, SWEBOK, Pearson/O'Reilly catalogue, SonarQube docs, WebSearch général |
| Mots-clés | "coupling cohesion software design metrics", "CBO LCOM CK metrics object-oriented", "software component instability abstractness Martin", "DIT WMC coupling empirical fault prediction", "SonarQube cognitive cyclomatic complexity thresholds" |
| Période couverte | 1994–2024 |
| Sources identifiées | ~25 |
| Sources retenues | 6 (SWEBOK v4, C&K 1994, IEEE TSE 2017, Martin Agile SD 2002, Khononov 2024, SonarQube docs) |
| Date d'extraction | 2026-04-17 |

### Agent B — bases interrogées

| Élément | Valeur |
|---------|--------|
| Bases | IEEE Xplore, Empirical Software Engineering (Springer), Prentice Hall/Addison-Wesley/O'Reilly catalogue, NestJS docs, WebSearch général |
| Mots-clés | "coupling cohesion measurement software quality", "lack of cohesion methods LCOM5 bug prediction", "component principles clean architecture ADP SDP SAP", "fitness functions architectural coupling JDepend", "NestJS circular dependency module coupling smell" |
| Période couverte | 1994–2024 |
| Sources identifiées | ~29 (convergence partielle avec A + sources B-uniquement) |
| Sources retenues | 8 (SWEBOK v4, C&K 1994, IEEE Xplore LCOM5 2021, Palomba 2018, Martin Clean Architecture 2017, Ford et al. 2022, Khononov 2024, NestJS docs) |
| Date d'extraction | 2026-04-17 |

---

## Sources exclues — raisons documentées

| Source | Raison exclusion |
|--------|-----------------|
| Martin R. — Clean Code (2008) | Couverture du couplage superficielle et indirecte — absorbée intégralement par Agile SD 2002 et Clean Architecture 2017 qui adressent spécifiquement les métriques |
| Gamma et al. — Design Patterns GoF (1994) | Pertinent indirectement (patterns réduisant le couplage) mais hors scope PICOC : n'adresse pas les métriques objectives de mesure |
| SonarQube Ce/Ca documentation pré-v6 | Obsolète — supprimée depuis SonarQube v6.x. Mentionné comme note dans le principe pour éviter les erreurs d'implémentation |
| Lorenz & Kidd — Object-Oriented Software Metrics (1994) | Absorbé par Chidamber & Kemerer 1994 (même génération, C&K cite 5× plus dans la littérature et couvre les mêmes métriques avec rigueur supérieure) |
| Briand et al. — A Unified Framework for Coupling Measurement (IEEE TSE 1999) | Couverture similaire à C&K 1994 + IEEE TSE 2017 combinés sans apport différencié net sur la question PICOC |
| arXiv preprints métriques OO (≥3 papiers) | Non peer-reviewed — remplacés par les études IEEE TSE et Empirical SE incluses |
| McCabe — A Complexity Measure (IEEE TSE 1976) | Couvert via SonarQube docs (Cyclomatic Complexity seuil ≤ 10) — la documentation outil est plus directement actionnable |
| CAST Software Research — structural quality metrics report | Rapport éditeur commercial — biais implicite vers la promotion de leur outil de mesure |
