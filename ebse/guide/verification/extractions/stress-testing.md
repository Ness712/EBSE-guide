# Double Extraction — PICOC stress-testing

**Date** : 2026-04-17
**Protocole** : methodology.md v3.0
**Agent A** : mots-clés : "stress testing web API k6", "load testing spike testing soak testing taxonomy", "k6 thresholds SLO pass fail criteria", "performance testing saturation point identification", "average load testing baseline APM"
**Agent B** : mots-clés : "ISO 25010 performance efficiency sub-characteristics", "ISTQB performance testing certification CT-PT taxonomy", "Gatling injection rampUsers atOnceUsers", "Google SRE load testing reliability", "JMeter throughput latency error rate best practices"

---

## PICOC

```
P  = Équipes développant des APIs ou services web avec des SLAs de performance
I  = Planifier et exécuter des tests de stress, spike, soak avec des seuils SLO définis
C  = Tests de performance absents ou uniquement manuels
O  = Identifier les points de saturation, valider les SLOs, prévenir les dégradations en production
Co = Applications web (NestJS/Spring Boot) avec CI/CD GitHub Actions
```

---

## Accord Reviewer A / Reviewer B

### Sources évaluées par les deux reviewers

| # | Source | Niveau A | Niveau B | Accord inclusion ? | Note divergence |
|---|--------|---------|---------|:-----------------:|-----------------|
| 1 | Grafana Labs k6 "Stress testing" (2024) | 2 | 2 | ✓ | — |
| 2 | Grafana Labs k6 "Spike testing" (2024) | 2 | 2 | ✓ | — |
| 3 | Grafana Labs k6 "Soak testing" (2024) | 2 | 2 | ✓ | — |
| 4 | Grafana Labs k6 "Thresholds" (2024) | 2 | 2 | ✓ | — |
| 5 | Grafana Labs k6 "Average-load testing" (2024) | 2 | 2 | ✓ | — |
| 6 | ISO/IEC 25010 Performance Efficiency (2023) | non trouvé | 3 | ✗ A / ✓ B | **Divergence inclusion** |
| 7 | ISTQB CT-PT (2024) | non trouvé | 3 | ✗ A / ✓ B | **Divergence inclusion** |
| 8 | Gatling "Injection — Test-as-code concepts" (2024) | non trouvé | 3 | ✗ A / ✓ B | **Divergence inclusion** |
| 9 | Google SRE Book ch.17 et ch.21 (2016) | non trouvé | 3 | ✗ A / ✓ B | **Divergence inclusion** |
| 10 | Apache JMeter "User Manual: Best Practices" (2024) | non trouvé | 4 | ✗ A / ✓ B | **Divergence inclusion** |

**Sources identifiées par A uniquement** : néant — les 5 documents k6 Grafana Labs constituent le corpus central, tous identifiés par A.
**Sources identifiées par B uniquement** : ISO 25010, ISTQB CT-PT, Gatling docs, Google SRE Book, JMeter Best Practices.

**Accord sur inclusion des sources communes** : 5/5 → kappa = 1.0 (inclusion).
**Désaccords d'inclusion** : 5/10 — toutes en faveur de l'inclusion (B propose, A n'a pas cherché dans ces bases).

### Résolution des divergences

**ISO/IEC 25010 (B seulement, niveau 3)** : inclus. Norme internationale définissant les sous-caractéristiques de performance efficiency (Time behaviour, Resource utilization, Capacity). Fournit le référentiel normatif qui fonde le choix des métriques à instrumenter. Non trouvé par A car ses mots-clés ciblaient les outils et la pratique, pas les normes qualité.

**ISTQB CT-PT (B seulement, niveau 3)** : inclus. Certification spécialisée performance testing avec taxonomie canonique (load, stress, spike, endurance) et métriques standard (throughput, response time, error rate). Convergence directe avec la taxonomie k6 — constitue une validation indépendante par une organisation de certification professionnelle. Non trouvé par A pour la même raison que ISO 25010.

**Gatling docs (B seulement, niveau 3)** : inclus. Documentation officielle d'un framework de performance testing alternatif documentant les profils d'injection progressifs. Justifie la recommandation Gatling pour Spring Boot et fonde le principe de rampe progressive. Non trouvé par A dont les mots-clés étaient centrés sur k6.

**Google SRE Book ch.17/21 (B seulement, niveau 3)** : inclus. Référence fondatrice SRE intégrant les tests de charge dans la validation de fiabilité et définissant les points de saturation observables. Fournit la justification de l'impact opérationnel (prévention incidents). Non trouvé par A dont les mots-clés étaient pratiques plutôt que conceptuels.

**JMeter Best Practices (B seulement, niveau 4)** : inclus avec réserve. Documentation outil de niveau 4 — apport marginal (métriques standard déjà couvertes par ISO 25010 et ISTQB). Inclus pour compléter la justification de JMeter comme alternative valide pour équipes Java sans budget Gatling. Non inclus comme source critique.

**Décision de convergence** : toutes les sources B-only sont complémentaires (normatif, certification, outil alternatif, SRE) et ne contredisent pas le corpus k6. Toutes incluses — l'absence chez A est due à des mots-clés pratiques vs conceptuels, pas à une divergence de fond.

---

## Calcul GRADE final

```
Score de départ : 3
  (source la plus haute = niveau 2 : Grafana Labs k6 documentation officielle)

+ 1 convergence
  5 documents k6 Grafana (niveau 2) convergent sans contradiction sur :
  - Les 4 types de tests et leurs objectifs distincts
  - L'ordre d'exécution obligatoire (smoke → average-load → stress → spike → soak)
  - Le mécanisme de thresholds comme critères pass/fail codifiés
  - Le principe de baseline APM avant tout test de stress

  ISO 25010 (niveau 3) + ISTQB CT-PT (niveau 3) convergent sur :
  - La même taxonomie 4 types (terminologie légèrement différente mais convergente)
  - Les mêmes métriques (throughput, response time p50/p95/p99, error rate)

  Google SRE Book (niveau 3) converge sur :
  - Les tests de charge comme partie de la validation de fiabilité
  - Les points de saturation observables comme objectif

  Gatling docs (niveau 3) + JMeter (niveau 4) convergent sur :
  - Les profils d'injection progressifs (ramp-up) pour éviter les artefacts de démarrage

  5 contextes distincts : framework officiel (k6), norme (ISO 25010),
  certification professionnelle (ISTQB), ingénierie fiabilité (SRE), outils alternatifs.
  Aucune contradiction entre sources.

+ 1 effet important
  Absence de tests de performance = cause documentée d'incidents de disponibilité
  sous charge (Google SRE ch.17). Impact opérationnel direct et mesurable.
  Les SLOs codifiés comme critères CI = feedback automatique objectif.
  Réduction des incidents production = valeur business démontrable.

Score final : 3 + 1 + 1 = 5 → [STANDARD]
```

Note biais de publication : k6 docs = documentation framework (biais possible vers l'usage de k6). Atténué par la convergence avec ISO 25010 (norme), ISTQB (certification indépendante) et Google SRE (référence indépendante de tout outil). Les métriques et la taxonomie sont validées indépendamment de l'outil.

---

## Analyse de sensibilité {#analyse-de-sensibilite}

| Source retirée | Score sans | Niveau sans | Changement ? |
|---------------|-----------|------------|:------------:|
| k6 "Stress testing" seul | 5 (4 autres docs k6 + ISO 25010 + ISTQB maintiennent la taxonomie) | [STANDARD] | NON |
| Tous les docs k6 simultanément | 3+1=4 (départ niveau 3 ISO/ISTQB/SRE, convergence maintenue sur taxonomie et métriques) | [RECOMMANDE] | OUI — mais scénario irréaliste : k6 est le framework de référence de l'industrie (Grafana Labs, open-source, 21k GitHub stars) |
| ISO/IEC 25010 | 5 (ISTQB CT-PT couvre les mêmes métriques) | [STANDARD] | NON |
| ISTQB CT-PT | 5 (ISO 25010 + k6 docs couvrent la taxonomie et les métriques) | [STANDARD] | NON |
| Google SRE Book | 5 (k6 docs + ISTQB maintiennent la justification de l'impact) | [STANDARD] | NON |
| Gatling docs | 5 (la recommandation outil Spring Boot reste justifiable sans Gatling docs formels) | [STANDARD] | NON |
| JMeter Best Practices | 5 (source de niveau 4 non critique) | [STANDARD] | NON |
| Toutes sources niveau 3+ simultanément | 3+0=3 (départ niveau 2 k6, convergence absente sans sources externes) | [RECOMMANDE] | OUI |

**Conclusion : ROBUSTE** — recommandation [STANDARD] stable pour tout retrait individuel. Le seul scénario de déclassement réaliste est le retrait de l'ensemble des 5 documents k6, ce qui ramènerait le départ au niveau 3 (ISO 25010 ou ISTQB) → score 3+1=4 [RECOMMANDE]. Ce scénario est très improbable : k6 est le framework de performance testing open-source le plus référencé de l'industrie en 2024 et sa documentation est activement maintenue par Grafana Labs. La convergence avec des sources normatives indépendantes (ISO, ISTQB) conforte la robustesse de la taxonomie et des métriques.

---

## Sources exclues

| Source | Critère | Raison |
|--------|---------|--------|
| Locust documentation (locust.io, 2024) | E3 | Framework Python de load testing. Couvert par k6 (JavaScript) et Gatling (Java/Scala) qui sont plus pertinents pour la stack OLS (NestJS/Spring Boot). Taxonomie et métriques identiques — apport différencié nul. |
| Artillery documentation (2024) | E3 | Framework Node.js de load testing. Couvert par k6 qui est plus riche en fonctionnalités (thresholds, scénarios complexes, intégration Grafana native). Redondant sans apport différencié. |
| DORA "Accelerate" — Forsgren et al. (2018) | E2 | Traite des métriques de livraison (deployment frequency, MTTR) mais pas directement des tests de performance ou des SLOs de latence. Hors scope PICOC strict. |
| Blogs "k6 tutorial" (multiples) | E1 | Tutoriels sans peer review ni autorité institutionnelle. Contenu couvert par la documentation officielle k6. |
| New Relic / Datadog blog posts sur les SLOs | E4 | Contenu marketing avec biais commercial implicite. Les métriques SLO sont couvertes par ISO 25010 et ISTQB sans biais. |
| RFC performance testing (IETF) | E2 | Standards IETF sur les protocoles réseau, pas sur les méthodologies de test de performance applicative. Hors scope PICOC. |
