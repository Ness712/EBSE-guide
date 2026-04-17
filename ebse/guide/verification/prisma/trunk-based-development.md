# PRISMA Flow — PICOC trunk-based-development

**Date de recherche** : 2026-04-17
**Bases interrogées** : trunkbaseddevelopment.com, martinfowler.com, DORA Research Program (Google Cloud), IT Revolution Press, nvie.com, Google Scholar, WebSearch général
**Mots-clés Agent A** : "trunk-based development vs GitFlow", "trunk-based development DORA elite performers", "feature branch integration continuous delivery", "Accelerate Forsgren trunk-based", "short-lived branches merge frequency"
**Mots-clés Agent B** : "GitFlow disadvantages continuous deployment", "branching strategy delivery frequency empirical", "Hammant trunk based development", "Martin Fowler feature branch", "Driessen git-flow model limitations"
**Protocole** : methodology.md v3.0 §2.1 — double extraction indépendante (Agents A + B, mots-clés différents) + synthèse Agent C

---

## Flux

```
IDENTIFICATION
  Sources identifiées par base (Agent A + Agent B combinés, avant déduplication) :
    - Ouvrages de référence DevOps (Accelerate, The DevOps Handbook) : 3 candidats
    - Rapports DORA State of DevOps (2019-2024) : 6 candidats
    - Sites experts reconnus (trunkbaseddevelopment.com, martinfowler.com, nvie.com) : 5 candidats
    - Documentation Git / GitHub / Atlassian : ~8 candidats
    - Articles académiques (IEEE, ACM) sur branching et intégration continue : ~7 candidats
    - Blog posts et articles techniques : ~15 candidats
    - Snowballing backward (références citées par Accelerate et trunkbaseddevelopment.com) : ~6 sources
  Total identifié (brut, combiné A+B) : ~50
  Doublons retirés (même source identifiée par A et B) : 4 (Accelerate, DORA 2024, trunkbaseddevelopment.com, Fowler Feature Branch)
  Total après déduplication : ~46

SCREENING (titre + résumé)
  Sources screenées : ~46
  Sources exclues au screening : ~33
    - E1 (blog opinion sans données ni méthodologie) : ~14
    - E2 (hors scope PICOC — branching général, pas impact sur livraison) : ~8
    - E3 (doublons partiels — couverts par sources primaires) : ~7
    - E4 (documentation d'outil / vendeur sans substance comparative) : ~4

ELIGIBILITÉ (lecture complète)
  Sources évaluées en détail : ~13
  Sources exclues après lecture complète : ~8
    - Hors scope PICOC strict (comparatifs de syntaxe Git, pas de stratégie) : 3
    - Niveau de preuve insuffisant (opinion sans données empiriques ni référence) : 2
    - Redondance forte avec Accelerate ou DORA sans apport supplémentaire : 2
    - Biais commercial marqué (vendeur d'outil CI/CD recommandant TBD) : 1

INCLUSION
  Sources incluses dans la synthèse : 5
    - Niveau 4 : 1 (DORA State of DevOps 2024)
    - Niveau 5 : 4 (Forsgren/Accelerate 2018, Hammant/trunkbaseddevelopment.com 2024, Fowler/martinfowler.com 2020, Driessen note 2020)

  Sources exclues avec raison documentée : voir section ci-dessous
```

---

## Documentation recherche (Table 2 Kitchenham)

### Agent A — bases interrogées

| Élément | Valeur |
|---------|--------|
| Bases | DORA Research Program, IT Revolution Press, Google Scholar, martinfowler.com, trunkbaseddevelopment.com, WebSearch général |
| Mots-clés | "trunk-based development vs GitFlow", "trunk-based development DORA elite performers", "feature branch integration continuous delivery", "Accelerate Forsgren trunk-based", "short-lived branches merge frequency" |
| Période couverte | 2010-2024 |
| Sources identifiées | ~25 |
| Sources retenues | 4 (Accelerate, DORA 2024, trunkbaseddevelopment.com, Fowler) |
| Date d'extraction | 2026-04-17 |

### Agent B — bases interrogées

| Élément | Valeur |
|---------|--------|
| Bases | nvie.com, martinfowler.com, Google Scholar (IEEE/ACM branching strategies), Atlassian Git tutorials, DORA Research Program, WebSearch |
| Mots-clés | "GitFlow disadvantages continuous deployment", "branching strategy delivery frequency empirical", "Hammant trunk based development", "Martin Fowler feature branch", "Driessen git-flow model limitations" |
| Période couverte | 2010-2024 |
| Sources identifiées | ~21 |
| Sources retenues | 5 (Accelerate, DORA 2024, trunkbaseddevelopment.com, Fowler, Driessen note 2020) |
| Date d'extraction | 2026-04-17 |

---

## Sources exclues — raisons documentées

| Source | Raison exclusion |
|--------|-----------------|
| Kim G., Behr K., Spafford G. — The Phoenix Project (2013) | Roman illustratif — pas une source empirique ou prescriptive directe sur TBD. Contenu absorbé par Accelerate (même auteurs, données empiriques). |
| Kim G. et al. — The DevOps Handbook (2016) | Recommande TBD mais sans données propres — cite Accelerate. Redondant avec Forsgren 2018 qui est la source primaire des données. |
| Atlassian Git Branching Strategies (2024) | Documentation d'outil avec biais commercial implicite (promotion de Bitbucket). Compare GitFlow/GitHub Flow/TBD sans données empiriques. Couvert par Fowler + Driessen. |
| Shahin M. et al. — Continuous Integration, Delivery, and Deployment (IEEE Access, 2017) | Article académique IEEE sur CI/CD — traite TBD indirectement, pas d'études comparatives directes TBD vs GitFlow. Hors scope PICOC strict. |
| Soares G. et al. — An Empirical Study of Long-lived Branches in Version Control Systems (SANER, 2022) | Étude empirique sur la durée des branches — données sur 300 projets open source GitHub. Pertinente mais résultats descriptifs (branches longues corrèlent avec moins de commits) sans causalité claire ni DORA metrics. Absorbée par DORA 2024 plus direct. |
| GitHub Flow documentation (GitHub, 2024) | Documentation d'outil/plateforme. Proche de TBD mais avec merge via PR sur main directement. Redondant avec trunkbaseddevelopment.com + Fowler sur les principes. |
| CircleCI blog — Trunk Based Development vs Feature Branching (2023) | Niveau 5 redondant — synthèse des mêmes sources (Accelerate, DORA, Hammant) sans apport original. Biais possible (vendeur CI/CD). |
| Blog posts comparatifs GitFlow vs TBD (≥6 sources) | Niveau 5 redondant — reprennent les mêmes arguments sans données nouvelles. Aucun n'apporte de nuance non couverte par les 5 sources incluses. |
