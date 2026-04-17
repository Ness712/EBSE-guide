# PRISMA Flow — dora-metrics

**Date de recherche** : 2026-04-17
**Agents** : Reviewer A (indépendant) + Reviewer B (indépendant) — contextes séparés
**Bases interrogées** : DORA State of DevOps Reports (2014-2024), littérature SE fondatrice (Forsgren/Humble/Kim Accelerate), ACM Queue / ACM DL, IEEE Computer, Google Scholar, dora.dev
**Mots-clés Agent A** : "DORA metrics deployment frequency lead time", "change failure rate MTTR software delivery", "four keys DevOps performance measurement", "Accelerate Forsgren Humble Kim", "elite performers DevOps 2024"
**Mots-clés Agent B** : "software delivery performance metrics empirical", "DevOps metrics GitHub Actions automation", "DORA four keys open source pipeline", "SPACE developer productivity framework", "MTTR deployment frequency correlation organizational performance"

---

## Flux PRISMA

```
IDENTIFICATION
  Sources identifiées par base :
    - Rapports DORA annuels (2015-2024, Google/DORA)          : 10 références
    - Livres fondateurs (Accelerate, Phoenix Project,
      DevOps Handbook)                                         : 3 sources
    - Peer-reviewed (ACM Queue, ACM DL, IEEE Computer)        : 4 sources
    - Implémentations open source (DORA Four Keys,
      GitHub Actions workflows)                               : 2 sources
    - Google Scholar (frameworks dérivés, études sectorielles) : ~6 sources
    - Snowballing (références croisées)                        : ~3 additionnelles
  Total identifié : ~28
  Doublons retirés : -4 (rapports DORA antérieurs remplacés par 2024)
  Total après déduplication : ~24

SCREENING (titre + résumé)
  Sources screenées : 24
  Sources exclues au screening : -10
    - E1 (> 5 ans ET non-standard/non-classique)  : -5
      (rapports DORA 2015-2019 remplacés par 2024 cumulation)
    - E2 (blog individuel sans peer review)        : -3
    - E3 (marketing outil DevOps)                  : -2

ÉLIGIBILITÉ (lecture complète)
  Sources évaluées en détail : 14
  Sources exclues après lecture : -8 (voir section Sources exclues)

INCLUSION
  Sources incluses dans la synthèse : 6
    - Niveau 3 (peer-reviewed / rapport empirique large-échelle
      / source primaire officielle)                              : 4
    - Niveau 4 (rapport observationnel large-échelle)            : 1
    - Niveau 5 (experts reconnus, livre fondateur)               : 1
```

---

## Documentation recherche (Table 2 Kitchenham)

| Base | Termes utilisés | Date | Retenus |
|------|----------------|------|---------|
| dora.dev / Google DORA | "DORA metrics definitions 2024", "five metrics 2024 rework rate" | 2026-04-17 | 2 (State of DevOps 2024 + definitions officielles) |
| Littérature fondatrice | "Accelerate Forsgren Humble Kim", "Shingo Award DevOps" | 2026-04-17 | 1 (Accelerate 2018) |
| ACM Queue | "SPACE developer productivity Forsgren Storey 2021" | 2026-04-17 | 1 (SPACE ACM Queue 2021) |
| GitHub / Open Source | "DORA four keys open source BigQuery", "fourkeys dora-team" | 2026-04-17 | 1 (DORA Four Keys 2024) |
| ACM DL / ICSP | "DORA metrics microservice automated real-time 2024" | 2026-04-17 | 1 (Kearsely ICSP 2024) |
| Google Scholar | "DevOps performance metrics empirical validation" | 2026-04-17 | 0 (absorbés par sources retenues) |

---

## Accord Reviewer A / Reviewer B

### Sources évaluées par les deux reviewers

| # | Source | Niveau A | Niveau B | Accord inclusion ? | Note divergence |
|---|--------|---------|---------|:-----------------:|-----------------|
| 1 | DORA 2024 State of DevOps Report (n=39 000+) | 4 | 4 | ✓ | — |
| 2 | Forsgren, Humble, Kim — Accelerate (2018) | 5 | 5 | ✓ | — |
| 3 | DORA — dora.dev definitions 2024 | 3 | 3 | ✓ | — |
| 4 | Forsgren, Storey et al. — SPACE ACM Queue (2021) | 3 | 3 | ✓ | — |
| 5 | DORA Four Keys — Google Cloud Open Source (2024) | 3 | 3 | ✓ | — |
| 6 | Kearsely et al. — ACM ICSP 2024 | 3 | non trouvé | ✓ A / ✗ B | **Divergence inclusion** |
| 7 | Kim et al. — The Phoenix Project (IT Revolution, 2013) | 5 | 5 | ✗ | Exclu : fiction, pas source empirique |
| 8 | Kim et al. — DevOps Handbook (IT Revolution, 2016) | 5 | 5 | ✗ | Absorbé par Accelerate (plus récent, plus rigoureux) |

**Sources identifiées par A uniquement** : Kearsely et al. ACM ICSP 2024
**Sources identifiées par B uniquement** : aucune nouvelle

**Accord sur inclusion des sources communes** : 4/6 → accord sur toutes les sources clés.
**Désaccords d'inclusion** : Kearsely ICSP 2024 (A seulement) ; Phoenix Project et DevOps Handbook (accord exclusion).

### Résolution des divergences

**Kearsely et al. ACM ICSP 2024 (A seulement, niveau 3)** : inclus. Source peer-reviewed ACM directement pertinente sur la mesure automatisée des métriques DORA au niveau microservice — apporte la dimension implémentation concrète absente des autres sources. Non trouvé par B car ses mots-clés ciblaient les frameworks généraux plutôt que les publications récentes sur l'automatisation.

**The Phoenix Project (Kim et al., 2013)** : exclu (accord A/B). Roman à valeur pédagogique, non peer-reviewed, non empirique. Contenu conceptuel absorbé par Accelerate (rigueur empirique supérieure).

**DevOps Handbook (Kim et al., 2016)** : exclu (accord A/B). Ouvrage prescriptif absorbé par Accelerate (2018) qui est plus récent et apporte la validation statistique manquante au Handbook.

---

## Sources exclues

| Source | Critère | Raison |
|--------|---------|--------|
| Kim et al. — The Phoenix Project (2013) | E5 | Fiction. Valeur pédagogique uniquement. Contenu empirique nul. |
| Kim et al. — DevOps Handbook (IT Revolution, 2016) | E5 | Absorbé par Accelerate 2018 (plus récent, base empirique plus rigoureuse). |
| DORA State of DevOps Reports 2015-2021 | E1 | Remplacés par le rapport 2024 qui cumule les tendances multi-annuelles et contient les données AI. |
| Puppet — State of DevOps Report (Puppet Labs, 2014-2019) | E3 | Rapports produits par un vendor DevOps (biais commercial). Données partiellement reprises dans DORA. |
| Atlassian / CircleCI DevOps surveys | E3 | Sources marketing / vendor. Biais commercial explicite. |
| Blogs "How to implement DORA metrics" (multiples) | E2 | Articles individuels sans peer review. Contenu procédural absorbé par DORA Four Keys open source. |
| Forsgren N. — PhD thesis (2016) | E5 partiel | Contenu absorbé par Accelerate 2018 (publication plus accessible et plus complète). |
| McLaughlin K. et al. — ICSE 2020 (metrics CI/CD) | E5 | Hors périmètre direct — mesure des pipelines CI/CD, pas des métriques DORA en tant que telles. |
