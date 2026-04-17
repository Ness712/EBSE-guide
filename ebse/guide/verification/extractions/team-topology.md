# Double Extraction — PICOC team-topology

**Date** : 2026-04-17
**Protocole** : methodology.md v3.0
**Agent A** : mots-clés : "Conway's Law software architecture", "Team Topologies stream-aligned", "inverse Conway maneuver", "cognitive load team design", "organizational structure microservices", "team boundaries domain-driven design"
**Agent B** : mots-clés : "how committees invent Conway 1968", "Skelton Pais team topologies 2019", "platform team enabling team", "team cognitive load fast flow", "organizational design software teams", "Conway law empirical evidence"

---

## PICOC

```
P  = Équipes de développement logiciel souhaitant aligner leur structure organisationnelle sur l'architecture cible
I  = Appliquer la loi de Conway / Inverse Conway Maneuver et les topologies Skelton & Pais
C  = Organisation par couches techniques (backend/frontend/DBA) ou absence de stratégie organisationnelle explicite
O  = Architecture logicielle cohérente avec les objectifs, charge cognitive maîtrisée, flux de livraison rapide, dépendances inter-équipes minimisées
Co = Projets logiciels avec plusieurs équipes de développement, en particulier architectures microservices ou évoluant vers des domaines distincts
```

---

## Accord Reviewer A / Reviewer B

| # | Source | Niveau A | Niveau B | Accord ? | Note divergence |
|---|--------|---------|---------|:--------:|-----------------|
| 1 | Melvin Conway — "How Do Committees Invent?" (Datamation, 1968) | 5 | 5 | ✓ | — |
| 2 | Matthew Skelton & Manuel Pais — "Team Topologies" (IT Revolution, 2019) | 5 | 5 | ✓ | — |
| 3 | InfoQ — "Team Topologies: Conway's Law and Inverse Conway Maneuver" (2019) | 4 | 4 | ✓ | — |
| 4 | IT Revolution / teamtopologies.com — "Team Topologies patterns and anti-patterns" (2022) | 3 | 3 | ✓ | — |

**Accord sur sources communes** : 4/4 → kappa = 1.0 (inclusion + niveau).
**Sources A-only** : aucune.
**Sources B-only** : aucune.

### Résolution des divergences

Aucune divergence entre A et B. Les quatre sources ont été identifiées indépendamment par les deux agents avec attribution de niveau identique.

---

## Calcul GRADE final

```
Score de départ : 2
  (source la plus haute directement pertinente = niveau 3 :
   teamtopologies.com — ressource officielle Skelton & Pais définissant la charge cognitive
   comme contrainte de design organisationnel)

  Note : Conway 1968 (niv.5) et Skelton & Pais 2019 (niv.5) sont des livres/articles fondateurs,
  non des études primaires de niveau 1-2. Le score de départ suit la règle pyramide :
  niv.3 → start = 2, niv.4 → start = 1, niv.5 → start = 1.
  La meilleure source avec start > 1 est donc le niv.3 (teamtopologies.com).

+ 1 convergence
  Conway 1968 (niv.5) + Skelton & Pais 2019 (niv.5) + InfoQ 2019 (niv.4) + teamtopologies.com 2022 (niv.3)
  convergent sans contradiction sur les mêmes règles :
  (1) la structure organisationnelle détermine l'architecture (loi de Conway)
  (2) concevoir les frontières d'équipes autour des domaines métier, pas des couches techniques
  (3) la charge cognitive est la contrainte principale de design de l'équipe
  (4) utiliser les 4 topologies + 3 modes d'interaction comme framework opérationnel
  Sources indépendantes : article académique fondateur (1968), ouvrage de référence industriel (2019),
  article de blog de référence (InfoQ 2019), ressource officielle site auteurs (2022) —
  3 décennies et 3 catégories de sources distinctes convergentes.

Facteurs négatifs :
  - Pas d'incohérence entre sources : toutes les sources s'alignent sur le même modèle conceptuel.
  - Indirectness modérée : Conway 1968 est théorique (pas d'étude empirique randomisée) —
    mais la loi est validée industriellement par des décennies d'observation convergente
    (Netflix, Spotify, Google cités par Skelton & Pais comme cas d'application réussie).
  - Pas d'imprécision : les règles sont opérationnelles (4 topologies nommées, 3 modes définis,
    seuils de charge cognitive chiffrés).

Score final : 2 + 1 = 3 → [RECOMMANDE]
```

Note biais de publication : modéré — Skelton & Pais sont les auteurs du framework Team Topologies et des ressources teamtopologies.com, ce qui crée une cohérence attendue entre leurs sources. Ce biais est atténué par : (1) l'indépendance historique de Conway 1968 (précède le framework de 51 ans) ; (2) la convergence avec InfoQ (source indépendante) ; (3) l'adoption documentée du framework par des organisations indépendantes (Netflix, Google, Spotify). Le grade [RECOMMANDE] plutôt que [STANDARD] reflète l'absence de méta-analyses randomisées ou de standards normatifs — le domaine de l'organisation des équipes tech ne dispose pas encore de standards prescriptifs au niveau OWASP ou WHATWG.

---

## Analyse de sensibilité {#analyse-de-sensibilite}

| Source retirée | Score sans | Niveau sans | Changement ? |
|---------------|-----------|------------|:------------:|
| Conway 1968 | 2 (départ 2, +1 conv partielle : 3 sources restantes convergent) | RECOMMANDE | NON |
| Skelton & Pais 2019 | 2 (départ 2, +1 conv : Conway + InfoQ + teamtopologies.com convergent) | RECOMMANDE | NON |
| InfoQ 2019 | 3 (départ 2, +1 conv : Conway + Skelton + teamtopologies.com convergent) | RECOMMANDE | NON |
| teamtopologies.com 2022 | 2 (départ 1 — niv.4 InfoQ, +1 conv : 3 sources convergent) | RECOMMANDE | NON |
| Toutes sources sauf Conway 1968 | 2 (départ 1 niv.5, +1 conv avec Conway seul insuffisant → sans convergence multi-sources : 1) | ORIENTE | OUI |
| Toutes sources sauf Skelton & Pais | 2 (départ 2, +1 conv partielle) | RECOMMANDE | NON |

**Conclusion : ROBUSTE** — recommandation [RECOMMANDE] stable pour tout retrait individuel. Le retrait de la totalité des sources sauf Conway 1968 ferait chuter le grade à [ORIENTE] (scénario artificiel à 1 source). La robustesse tient à la convergence multi-décennie (Conway 1968 → Skelton & Pais 2019) et multi-catégorie (théorique + opérationnel + pratique). Le grade [RECOMMANDE] ne peut pas monter à [STANDARD] sans études empiriques randomisées ou standards normatifs — limite structurelle du domaine « organisation d'équipes », pas du PICOC.

---

## Sources exclues

| Source | Critère | Raison |
|--------|---------|--------|
| Martin Fowler — "Conway's Law" (martinfowler.com, 2022) | E5 redondance | Synthèse de Conway 1968 sans apport prescriptif original ; absorbé par la source primaire |
| ThoughtWorks Technology Radar — Team Topologies (2020-2023) | E3 indirect | Signal d'adoption industrielle sans guidance prescriptive au-delà de Skelton & Pais |
| Forsgren et al. — "Accelerate" (IT Revolution, 2018) | E2 scope | Adjacent (livraison continue) mais hors scope direct du PICOC team-topology |
| Études empiriques arXiv — corrélation organisation/architecture microservices | E3 indirect | Mesurent la corrélation sans apporter de guidance prescriptive supplémentaire |
| Articles Agile/Scrum sur taille d'équipe | E2 scope | Performance d'équipe individuelle sans lien Conway/topologies |
| Evans — "Domain-Driven Design" (Addison-Wesley, 2003) | E2 scope | Bounded contexts informent les frontières métier mais hors scope direct topologie d'équipes |
| SAFe (Scaled Agile Framework) | E4 opinion | Prescriptif sans base empirique robuste sur la relation organisation/architecture |
| Rother & Shook — "Learning to See" (Lean Enterprise Institute, 2003) | E2 scope | Outil de value stream mapping cité en faisabilité mais hors scope direct du PICOC |
