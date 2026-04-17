# PRISMA Flow — PICOC stress-testing

**Date de recherche** : 2026-04-17
**Bases interrogées** : Grafana Labs k6 documentation, ISO 25000 Portal, ISTQB documentation officielle, Gatling documentation, Google SRE Book (publié en accès libre), Apache JMeter documentation, WebSearch général
**Mots-clés Agent A** : "stress testing web API k6", "load testing spike testing soak testing taxonomy", "k6 thresholds SLO pass fail criteria", "performance testing saturation point identification", "average load testing baseline APM"
**Mots-clés Agent B** : "ISO 25010 performance efficiency sub-characteristics", "ISTQB performance testing certification CT-PT taxonomy", "Gatling injection rampUsers atOnceUsers", "Google SRE load testing reliability", "JMeter throughput latency error rate best practices"
**Protocole** : methodology.md v3.0 §2.1 — double extraction indépendante (Agents A + B, mots-clés différents) + synthèse Agent C

---

## Flux

```
IDENTIFICATION
  Sources identifiées par base (Agent A + Agent B combinés, avant déduplication) :
    - Documentation frameworks de test (k6, Gatling, JMeter, Locust, Artillery) : ~18 résultats candidats
    - Normes et certifications (ISO 25010, ISTQB CT-PT, IEEE) : ~8 résultats candidats
    - Références SRE / fiabilité (Google SRE Book, SRE Workbook) : ~5 résultats candidats
    - Articles académiques (ACM, IEEE Transactions) : ~9 résultats candidats
    - Blogs et tutoriels experts (Martin Fowler, Netflix Tech Blog, etc.) : ~14 résultats candidats
    - Snowballing backward (références citées par sources principales) : ~6 sources
  Total identifié (brut, combiné A+B) : ~60
  Doublons retirés (même source identifiée par A et B) : 5 (les 5 docs k6 Grafana)
  Total après déduplication : ~55

SCREENING (titre + résumé)
  Sources screenées : ~55
  Sources exclues au screening : ~38
    - E1 (blog opinion sans données ou méthodologie) : ~12
    - E2 (hors scope PICOC — performance réseau ou base de données uniquement, pas API web) : ~8
    - E3 (doublons partiels — frameworks alternatifs couverts par k6/Gatling) : ~10
    - E4 (vendeur / marketing sans substance technique) : ~8

ELIGIBILITÉ (lecture complète)
  Sources évaluées en détail : ~17
  Sources exclues après lecture complète : ~7
    - Hors scope PICOC strict (performance CPU/GPU, pas latence API) : 3
    - Niveau de preuve insuffisant (tutoriels sans référence normative) : 2
    - Redondance forte avec k6 docs sans apport supplémentaire : 2

INCLUSION
  Sources incluses dans la synthèse : 10
    - Niveau 2 : 5 (Grafana Labs k6 — Stress testing, Spike testing, Soak testing, Thresholds, Average-load testing)
    - Niveau 3 : 4 (ISO/IEC 25010, ISTQB CT-PT, Gatling injection docs, Google SRE Book ch.17/21)
    - Niveau 4 : 1 (Apache JMeter User Manual Best Practices)

  Sources exclues avec raison documentée : 6
    - Locust documentation : redondance avec k6 — framework Python non pertinent pour stack NestJS/Java
    - Artillery documentation : redondance avec k6 — moins riche en fonctionnalités pour la stack OLS
    - DORA "Accelerate" (Forsgren 2018) : métriques de livraison, pas de performance applicative — hors scope PICOC
    - New Relic / Datadog blog posts sur SLOs : contenu marketing, métriques couvertes par ISO 25010 et ISTQB
    - RFC IETF performance (protocoles réseau) : hors scope — tests protocole, pas tests applicatifs
    - Articles arXiv sur la performance testing (3 articles) : indirects — mesurent des contextes spécifiques (mobile, IoT) non représentatifs de la stack OLS
```

---

## Documentation recherche (Table 2 Kitchenham)

### Agent A — bases interrogées

| Élément | Valeur |
|---------|--------|
| Bases | Grafana Labs k6 documentation, WebSearch général |
| Mots-clés | "stress testing web API k6", "load testing spike testing soak testing taxonomy", "k6 thresholds SLO pass fail criteria", "performance testing saturation point identification", "average load testing baseline APM" |
| Période couverte | 2016-2024 |
| Sources identifiées | ~30 |
| Sources retenues | 5 (les 5 documents k6 Grafana Labs) |
| Date d'extraction | 2026-04-17 |

### Agent B — bases interrogées

| Élément | Valeur |
|---------|--------|
| Bases | ISO 25000 Portal, ISTQB documentation, Gatling documentation, Google SRE Book, Apache JMeter documentation, WebSearch général |
| Mots-clés | "ISO 25010 performance efficiency sub-characteristics", "ISTQB performance testing certification CT-PT taxonomy", "Gatling injection rampUsers atOnceUsers", "Google SRE load testing reliability", "JMeter throughput latency error rate best practices" |
| Période couverte | 2016-2024 |
| Sources identifiées | ~30 |
| Sources retenues | 5 (ISO 25010, ISTQB CT-PT, Gatling docs, Google SRE Book, JMeter Best Practices) |
| Date d'extraction | 2026-04-17 |

---

## Sources exclues — raisons documentées

| Source | Raison exclusion |
|--------|-----------------|
| Locust documentation (locust.io, 2024) | Redondance — framework Python de load testing. k6 (JavaScript) et Gatling (Java/Scala) sont plus pertinents pour NestJS/Spring Boot. Taxonomie et métriques identiques, apport différencié nul. |
| Artillery documentation (artillery.io, 2024) | Redondance — framework Node.js alternatif à k6. Moins riche en fonctionnalités (pas de thresholds natifs aussi expressifs, intégration Grafana moins directe). Couvert par k6. |
| DORA "Accelerate" — Forsgren et al. (2018) | Hors scope PICOC — traite des métriques de livraison (DORA four keys) pas des SLOs de latence applicative. Aucune prescription sur les tests de performance. |
| New Relic blog "SLO best practices" | Biais commercial implicite (vente de plateforme d'observabilité). Métriques SLO couvertes par ISO 25010 et ISTQB sans biais. |
| Datadog blog "Load testing guide" | Biais commercial implicite (vente de plateforme de monitoring). Contenu générique couvert par k6 docs avec plus de précision. |
| RFC 2544 (IETF — benchmarking methodology network devices) | Hors scope — standards de benchmarking réseau (débit, latence réseau), pas tests de performance applicative (latence API, throughput HTTP). |
| Articles arXiv performance testing mobile/IoT | Contexte non représentatif — métriques et contraintes spécifiques aux environnements mobiles/embarqués, non transposables aux APIs web NestJS/Spring Boot. |
