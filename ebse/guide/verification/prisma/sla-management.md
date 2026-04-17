# PRISMA Flow — sla-management

**Date de recherche** : 2026-04-17
**Agents** : Reviewer A (indépendant) + Reviewer B (indépendant) — contextes séparés
**Bases interrogées** : sre.google (SRE Book + Workbook), ITIL 4 / Axelos, GitHub (Sloth, Pyrra, prom-client), docs.nestjs.com, Prometheus/Grafana docs, Google Scholar, IEEE Xplore, ACM DL
**Mots-clés Agent A** : "SLI SLO SLA error budget definition", "burn rate alerting SRE multiwindow", "service level objectives implementation Prometheus", "NestJS health check terminus SLO", "ITIL service level management"
**Mots-clés Agent B** : "error budget policy feature freeze", "SLO based alerting false positive reduction", "Sloth Pyrra SLO Prometheus generator", "availability SLO calibration empirical", "service level agreement SMART definition"

---

## Flux PRISMA

```
IDENTIFICATION
  Sources identifiées par base :
    - Livres experts Google SRE (sre.google)                   : 2 sources
    - Standards framework ITSM (ITIL 4)                        : 1 source
    - Documentation outils open-source (Sloth, Pyrra)          : 2 sources
    - Documentation framework officielle (NestJS Terminus)     : 1 source
    - Documentation monitoring (Prometheus, Grafana)           : ~3 sources
    - Google Scholar (articles empiriques SLO adoption)        : ~6 sources
    - IEEE Xplore / ACM DL (études reliability SRE)            : ~4 sources
    - Snowballing (références croisées)                        : ~4 additionnelles
  Total identifié : ~23
  Doublons retirés : -4
  Total après déduplication : ~19

SCREENING (titre + résumé)
  Sources screenées : 19
  Sources exclues au screening : -9
    - E1 (> 5 ans ET non-standard/non-classique)  : -2
    - E2 (blog individuel sans peer review)        : -4
    - E3 (documentation outil commercial/biaisée)  : -3

ÉLIGIBILITÉ (lecture complète)
  Sources évaluées en détail : 10
  Sources exclues après lecture : -4 (voir section Sources exclues)

INCLUSION
  Sources incluses dans la synthèse : 5
    - Niveau 3 (standard framework / documentation outil établi / doc officielle) : 3
    - Niveau 5 (experts reconnus, livres de référence Google SRE)                : 2
```

---

## Documentation recherche (Table 2 Kitchenham)

| Base | Termes utilisés | Date | Retenus |
|------|----------------|------|---------|
| sre.google | "SLI SLO SLA error budget", "burn rate alerting multiwindow" | 2026-04-17 | 2 (SRE Book 2016, SRE Workbook 2018) |
| ITIL 4 / Axelos | "service level management", "SLA SMART", "XLA" | 2026-04-17 | 1 (ITIL 4 SLM Practice 2019) |
| GitHub / sloth | "Sloth SLO Prometheus generator", "Pyrra alternative" | 2026-04-17 | 1 (Sloth 2021) |
| docs.nestjs.com | "terminus health check HTTP TypeORM memory disk" | 2026-04-17 | 1 (NestJS Terminus) |
| Prometheus / Grafana docs | "recording rules alerting", "dashboard SLO" | 2026-04-17 | 0 (absorbés par Sloth) |
| Google Scholar | "SLO empirical adoption teams reliability" | 2026-04-17 | 0 (pas d'étude RCT peer-reviewed trouvée) |
| IEEE Xplore / ACM DL | "service level objectives measurement empirical" | 2026-04-17 | 0 (études trop générales ou hors périmètre) |

---

## Sources exclues (après lecture complète)

| Source | Critère | Raison |
|--------|---------|--------|
| Pyrra (github.com/pyrra-dev/pyrra) | E5 partiel | Alternative à Sloth avec UI web. Fonctionnellement équivalent pour la génération de règles Prometheus. Retenu comme mention mais pas comme source principale — Sloth est plus documenté dans la littérature CNCF et plus stable (pas de breaking changes récents signalés). |
| Datadog — "SLO Best Practices Guide" | E3 | Whitepaper commercial. Définitions correctes mais biais commercial implicite (vente de fonctionnalité SLO Datadog). Contenu absorbé par SRE Book + ITIL 4. |
| Circonus — "The SLA vs SLO vs SLI Guide" | E2/E3 | Blog d'un fournisseur monitoring. Définitions redondantes avec SRE Book, source non indépendante. |
| Kleppmann M. — Designing Data-Intensive Applications (2017) | E5 partiel | Traite brièvement des SLAs dans le contexte de la fiabilité des systèmes distribués (ch. 1). Trop indirect sur la question PICOC (implémentation SLI/SLO avec Prometheus). Insights absorbés par SRE Book ch. 4. |
