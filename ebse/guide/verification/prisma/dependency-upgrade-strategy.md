# PRISMA Flow — dependency-upgrade-strategy

**Date de recherche** : 2026-04-17
**Agents** : Reviewer A (indépendant) + Reviewer B (indépendant) — contextes séparés
**Bases interrogées** : IEEE Xplore / ASE proceedings, Springer Empirical Software Engineering, ACM Digital Library, Snyk reports, npm security advisories, GitHub Dependabot docs, Renovate documentation, Google Scholar
**Mots-clés Agent A** : "automated dependency update bot npm", "Dependabot security pull requests empirical", "npm vulnerability fix lag", "dependency management automation GitHub"
**Mots-clés Agent B** : "Renovate Dependabot comparison npm", "npm CVE patch delay empirical", "automated dependency upgrade maintainability", "software supply chain security npm ecosystem"

---

## Flux PRISMA

```
IDENTIFICATION
  Sources identifiées par base :
    - IEEE Xplore / ASE proceedings
      (Mirhosseini 2017)                                      : 1 source
    - Springer Empirical Software Engineering
      (Rebatchi 2024, npm CVE lags)                          : 2 sources
    - IEEE/ACM peer-reviewed empirique
      (Chinthanet 2021 — npm vulnerabilities)                : 1 source
    - Rapports industriels / observatoires
      (Snyk State of Open Source Security 2024)              : 1 source
    - Documentation de référence outils
      (Renovate Mend.io, GitHub Dependabot)                  : 2 sources
    - Google Scholar (blogs, articles secondaires)           : ~6 sources
    - Snowballing (références croisées)                      : ~3 additionnelles
  Total identifié : ~16
  Doublons retirés : -2
  Total après déduplication : ~14

SCREENING (titre + résumé)
  Sources screenées : 14
  Sources exclues au screening : -5
    - E1 (> 5 ans ET non-standard/non-classique) : -1
    - E2 (blog individuel sans peer review)       : -3
    - E3 (marketing outil sécurité)              : -1

ÉLIGIBILITÉ (lecture complète)
  Sources évaluées en détail : 9
  Sources exclues après lecture : -2 (voir extraction file)

INCLUSION
  Sources incluses dans la synthèse : 7
    - Niveau 3 (peer-reviewed empirique IEEE/ACM/Springer)   : 4
    - Niveau 3 (documentation de référence outil majeur)    : 2
    - Niveau 4 (rapport industriel avec données quantifiées) : 1
```

---

## Documentation recherche (Table 2 Kitchenham)

| Base | Termes utilisés | Date | Retenus |
|------|----------------|------|---------|
| IEEE Xplore / ASE | "automated dependency bot npm GitHub", "Greenkeeper Dependabot empirical study" | 2026-04-17 | 1 (Mirhosseini 2017) |
| Springer ESE | "Dependabot security pull requests", "npm vulnerability fix propagation lag" | 2026-04-17 | 2 (Rebatchi 2024, npm CVE lags) |
| IEEE/ACM DL | "npm security vulnerabilities empirical", "open source package vulnerabilities" | 2026-04-17 | 1 (Chinthanet 2021) |
| Snyk / rapports industriels | "state of open source security 2024", "npm dependency audit" | 2026-04-17 | 1 (Snyk 2024) |
| Documentation officielle | "Renovate configuration grouping automerge", "Dependabot version updates npm" | 2026-04-17 | 2 (Renovate, Dependabot docs) |
| Google Scholar | "Renovate Dependabot comparison", "automerge semver strategy" | 2026-04-17 | 0 (exclus E2/E3) |
