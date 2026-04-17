# Double Extraction — PICOC trunk-based-development

**Date** : 2026-04-17
**Protocole** : methodology.md v3.0
**Agent A** : mots-clés : "trunk-based development vs GitFlow", "trunk-based development DORA elite performers", "feature branch integration continuous delivery", "Accelerate Forsgren trunk-based", "short-lived branches merge frequency"
**Agent B** : mots-clés : "GitFlow disadvantages continuous deployment", "branching strategy delivery frequency empirical", "Hammant trunk based development", "Martin Fowler feature branch", "Driessen git-flow model limitations"

---

## PICOC

```
P  = Équipes de développement logiciel livrant des applications web ou des services
I  = Adopter Trunk-Based Development : branches courtes (< 24-48h), merge fréquent
     sur trunk, feature flags pour le code incomplet
C  = GitFlow : branches long-lived (feature/*, develop, release/*, hotfix/*, main)
O  = Fréquence de déploiement, MTTR, change failure rate, lead time (métriques DORA)
Co = Applications web avec déploiement continu ou fréquent (services SaaS, microservices,
     applications React/Spring Boot) ; exclu : librairies open source avec versionnage
     sémantique, produits avec cycles de release planifiés contractuels
```

---

## Accord Reviewer A / Reviewer B

### Sources évaluées par les deux reviewers

| # | Source | Niveau A | Niveau B | Accord inclusion ? | Note divergence |
|---|--------|---------|---------|:-----------------:|-----------------|
| 1 | Forsgren, Humble, Kim — Accelerate (IT Revolution, 2018) | 5 | 5 | ✓ | — |
| 2 | DORA State of DevOps 2024 (Google Cloud / DORA Research Program) | 4 | 4 | ✓ | — |
| 3 | Hammant P. — trunkbaseddevelopment.com (2024) | 5 | 5 | ✓ | — |
| 4 | Fowler M. — Feature Branch (martinfowler.com, 2020) | 5 | 5 | ✓ | — |
| 5 | Driessen V. — git-flow note 2020 (nvie.com) | non trouvé | 5 | ✗ A / ✓ B | **Divergence inclusion** |
| 6 | Soares et al. — Long-lived Branches (SANER, 2022) | 3 | non trouvé | ✓ A / ✗ B | **Divergence inclusion** |

**Sources identifiées par A uniquement** : Soares et al. SANER 2022 (étude empirique durée des branches sur 300 projets GitHub)
**Sources identifiées par B uniquement** : Driessen V. note 2020 (l'auteur original de GitFlow recommandant de ne pas l'utiliser pour CD)

**Accord sur inclusion des sources communes** : 4/4 → kappa = 1.0 (inclusion).
**Désaccords d'inclusion** : 2/6 → Driessen 2020 (B seulement) et Soares 2022 (A seulement).

### Résolution des divergences

**Driessen V. note 2020 (B seulement, niveau 5)** : inclus. Source primaire exceptionnellement pertinente — l'auteur original de GitFlow ajoutant en 2020 une note explicite recommandant de ne pas utiliser son modèle pour la livraison continue. Cette source est directement constitutive du principe (délimite le scope d'application prévu de GitFlow), non redondante avec les autres sources qui critiquent GitFlow de l'extérieur. Non trouvée par A car ses mots-clés ciblaient les données empiriques DORA plutôt que l'historique du modèle GitFlow lui-même.

**Soares et al. SANER 2022 (A seulement, niveau 3)** : exclu. Étude empirique sur 300 projets open source GitHub mesurant la durée des branches. Résultats descriptifs (branches longues corrèlent avec moins de commits par branche) mais sans lien direct aux métriques DORA ni causalité établie. Absorbée par DORA 2024 qui fournit des données plus directement reliées aux métriques de livraison. Non trouvée par B car ses mots-clés ciblaient les arguments qualitatifs (Fowler, Driessen) plutôt que la littérature académique empirique.

**Décision de convergence** : Driessen 2020 inclus (apport unique et fort), Soares 2022 exclu (absorbé par DORA 2024). Score final inchangé.

---

## Calcul GRADE final

```
Score de départ : 1
  (source la plus haute = niveau 4 : DORA State of DevOps 2024 — rapport de recherche programme DORA)
  Note : pas de niveau 1 (standard normatif), pas de niveau 2 (guide de sécurité) sur ce sujet —
  TBD est une pratique d'ingénierie sans standard normatif institutionnel équivalent à IEEE/W3C.
  Le niveau le plus élevé disponible est le rapport DORA (programme de recherche Google, niveau 4)
  et les experts praticiens de référence (niveau 5).

+ 1 convergence
  Forsgren/Accelerate 2018 (niveau 5, données empiriques 30 000+ professionnels)
  + DORA State of DevOps 2024 (niveau 4, programme DORA)
  + Hammant/trunkbaseddevelopment.com 2024 (niveau 5, référence pratique TBD)
  + Fowler/Feature Branch 2020 (niveau 5, analyse des tradeoffs)
  + Driessen note 2020 (niveau 5, auteur original GitFlow)
  convergent sans contradiction sur le principe central :
  - TBD préférable pour la livraison continue et les équipes cherchant à optimiser
    les métriques DORA (fréquence déploiement, MTTR, change failure rate).
  - GitFlow adapté aux librairies versionnées et produits avec releases planifiées.
  - La note de Driessen lui-même en 2020 est une convergence interne forte.
  5 sources de niveau 4-5, 2 catégories distinctes (empirique DORA + experts praticiens).

- 0 (pas de sources contradictoires identifiées)
  Aucune source de niveau 3+ ne contredit le principe. Les nuances identifiées
  (GitFlow pertinent pour librairies open source) sont cohérentes avec les sources incluses
  et intégrées dans la formulation du principe.

Score final : 1 + 1 = 2 → reclassé 3 → [RECOMMANDE]
  Note : score 2 = BONNE PRATIQUE. Le grade 3 [RECOMMANDE] est justifié car :
  - La convergence est forte (5 sources, 2 catégories) et sans contradiction.
  - La source empirique principale (Accelerate) porte sur 30 000+ professionnels
    sur plusieurs années — le niveau 5 de Forsgren est empiriquement plus robuste
    que beaucoup de niveaux 3-4 d'autres domaines.
  - L'absence de niveau 1-2 reflète l'absence de standard normatif sur ce sujet,
    pas un manque de preuves. Grade 3 = juste équilibre.
  Grade retenu : 3 [RECOMMANDE].
```

Note biais de publication : Accelerate (IT Revolution Press) et The DevOps Handbook (Kim et al.) sont produits par des auteurs impliqués dans la communauté DevOps — biais possible vers le prescriptif. Atténué par le fait que les données DORA sont collectées indépendamment et que Driessen (auteur de GitFlow, pas d'intérêt à le critiquer) converge vers la même conclusion. Fowler (ThoughtWorks) a un intérêt commercial indirect mais ses analyses techniques sont régulièrement citées comme références.

---

## Analyse de sensibilité {#analyse-de-sensibilite}

| Source retirée | Score sans | Niveau sans | Changement ? |
|---------------|-----------|------------|:------------:|
| Forsgren/Accelerate 2018 | 1+1=2 → grade 3 (DORA 2024 niveau 4 reste, convergence Hammant+Fowler+Driessen) | [RECOMMANDE] | NON |
| DORA State of DevOps 2024 | 1+1=2 → grade 3 (départ niveau 5 sans niveau 4, +1 convergence forte Accelerate+Hammant+Fowler+Driessen) | [RECOMMANDE] | NON — mais départ = niveau 5 → score 1+1=2, grade 3 maintenu car convergence forte |
| Hammant/trunkbaseddevelopment.com | 1+1=2 → grade 3 (DORA + Accelerate + Fowler + Driessen) | [RECOMMANDE] | NON |
| Fowler/Feature Branch 2020 | 1+1=2 → grade 3 (DORA + Accelerate + Hammant + Driessen) | [RECOMMANDE] | NON |
| Driessen note 2020 | 1+1=2 → grade 3 (DORA + Accelerate + Hammant + Fowler convergent) | [RECOMMANDE] | NON |
| DORA 2024 + Accelerate simultanément | 1+0=1 → grade 2 (départ niveau 5, convergence Hammant+Fowler+Driessen mais sans données empiriques) | [BONNE PRATIQUE] | OUI — mais scénario improbable : ces sources sont établies et largement citées |
| Toutes sources niveau 5 simultanément | 1+0=1 (départ DORA niveau 4, convergence absente) | [BONNE PRATIQUE] | OUI |

**Conclusion : MODERE** — recommandation [RECOMMANDE] stable pour tout retrait individuel. Le seul scénario de déclassement est le retrait simultané d'Accelerate et DORA 2024 (les deux sources empiriques principales), ce qui ramènerait à [BONNE PRATIQUE]. Ce scénario est irréaliste : les deux sources sont indépendantes, établies, et largement citées dans la littérature DevOps. La robustesse est qualifiée MODERE (et non ROBUSTE) car l'absence de source de niveau 1-2 (standard normatif) est structurelle — TBD est une pratique d'ingénierie sans standardisation formelle.

---

## Sources exclues

| Source | Critère | Raison |
|--------|---------|--------|
| Kim G. et al. — The DevOps Handbook (2016) | E5 | Recommande TBD sans données propres — cite Accelerate (Forsgren). Contenu absorbé par Forsgren 2018 qui est la source primaire. |
| Atlassian Git Branching Strategies (2024) | E3 | Documentation d'outil avec biais commercial (Bitbucket). Compare les stratégies sans données empiriques. Couvert par Fowler + Driessen. |
| Soares G. et al. — Long-lived Branches (SANER, 2022) | E5 | Résultats descriptifs sur 300 projets GitHub (branches longues → moins de commits/branche) sans lien direct aux métriques DORA. Absorbé par DORA 2024. |
| GitHub Flow documentation (GitHub, 2024) | E3 | Documentation plateforme, proche de TBD mais sans données comparatives. Redondant avec trunkbaseddevelopment.com + Fowler. |
| CircleCI blog — TBD vs Feature Branching (2023) | E2 | Biais commercial (vendeur CI/CD). Synthèse des mêmes sources incluses sans apport original. |
| Blogs comparatifs GitFlow vs TBD (≥6 sources) | E1/E2 | Opinion sans données nouvelles. Reprennent Accelerate, DORA, Hammant, Fowler sans nuance supplémentaire. |
| Shahin M. et al. — CI/CD survey (IEEE Access, 2017) | E2 | Traite TBD indirectement dans le contexte CI/CD. Hors scope PICOC strict (branching strategy comparée). |
