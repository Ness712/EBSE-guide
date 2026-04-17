# PRISMA Flow — PICOC supply-chain-security

**Date de recherche** : 2026-04-17
**Bases interrogées** : NIST (publications spéciales), CISA (cybersecurity guidance), OpenSSF/SLSA, OWASP (Top 10, Cheat Sheets), Linux Foundation/Sigstore, GitHub Docs, WebSearch général
**Mots-clés Agent A** : "secure software supply chain NIST SSDF", "SLSA levels build provenance OpenSSF", "sigstore cosign container signing OIDC", "software bill of materials SBOM SPDX CycloneDX", "SolarWinds Codecov supply chain attack CI pipeline"
**Mots-clés Agent B** : "OWASP A06 vulnerable outdated components npm audit", "SLSA v1.0 supply chain integrity", "GitHub Actions security hardening pin SHA", "CISA SBOM Executive Order 14028", "dependency confusion typosquatting npm attack"
**Protocole** : methodology.md v3.0 §2.1 — double extraction indépendante (Agents A + B, mots-clés différents) + synthèse Agent C

---

## Flux

```
IDENTIFICATION
  Sources identifiées par base (Agent A + Agent B combinés, avant déduplication) :
    - Standards normatifs gouvernementaux (NIST, CISA, EO 14028) : ~5 résultats candidats
    - Fondations open source (OpenSSF/SLSA, Linux Foundation/Sigstore, CNCF) : ~8 résultats candidats
    - OWASP (Top 10, Cheat Sheets, outils) : ~7 résultats candidats
    - Documentation opérateurs CI/registres (GitHub, GitLab, Docker Hub) : ~6 résultats candidats
    - Spécifications techniques (SPDX, CycloneDX, in-toto) : ~4 résultats candidats
    - Post-mortems incidents (SolarWinds, Codecov, XZ Utils) : ~10 résultats candidats (blogs, news, analyses)
    - Snowballing backward (références citées par sources principales) : ~6 sources
  Total identifié (brut, combiné A+B) : ~46
  Doublons retirés (même source identifiée par A et B) : 5
    (NIST SP 800-218, CISA SBOM, SLSA v1.0, OWASP A06:2021, Sigstore/cosign)
  Total après déduplication : ~41

SCREENING (titre + résumé)
  Sources screenées : ~41
  Sources exclues au screening : ~28
    - E1 (blogs individuels sans données, opinion non étayée) : ~10
    - E2 (hors scope PICOC — supply chain générique sans guidance prescriptive) : ~6
    - E3 (doublons partiels — couverts par sources primaires déjà incluses) : ~7
    - E4 (documentation outil à biais commercial sans apport prescriptif propre) : ~5

ELIGIBILITÉ (lecture complète)
  Sources évaluées en détail : ~13
  Sources exclues après lecture complète : ~7
    - Spécifications trop granulaires pour le niveau du principe (in-toto, SPDX spec) : 2
    - Documentation outil redondante avec les guides normatifs déjà inclus : 3
    - Post-mortems journalistiques (faits couverts par SLSA v1.0) : 2

INCLUSION
  Sources incluses dans la synthèse : 6
    - Niveau 1 : 2 (NIST SP 800-218, CISA SBOM)
    - Niveau 2 : 4 (SLSA v1.0, OWASP A06:2021, Sigstore/cosign, GitHub Docs hardening)
    - Niveau 3 : 0
    - Niveau 5 : 0

  Sources exclues avec raison documentée : 9 (voir extractions/supply-chain-security.md)
```

---

## Documentation recherche (Table 2 Kitchenham)

### Agent A — bases interrogées

| Élément | Valeur |
|---------|--------|
| Bases | NIST publications, CISA guidance, OpenSSF/SLSA, Linux Foundation/Sigstore, OWASP, WebSearch général |
| Mots-clés | "secure software supply chain NIST SSDF", "SLSA levels build provenance OpenSSF", "sigstore cosign container signing OIDC", "software bill of materials SBOM SPDX CycloneDX", "SolarWinds Codecov supply chain attack CI pipeline" |
| Période couverte | 2021-2024 |
| Sources identifiées | ~26 |
| Sources retenues | 5 (NIST SP 800-218, CISA SBOM, SLSA v1.0, OWASP A06:2021, Sigstore/cosign) |
| Date d'extraction | 2026-04-17 |

### Agent B — bases interrogées

| Élément | Valeur |
|---------|--------|
| Bases | OWASP, GitHub Docs, CISA, OpenSSF/SLSA, npm registry advisories, WebSearch général |
| Mots-clés | "OWASP A06 vulnerable outdated components npm audit", "SLSA v1.0 supply chain integrity", "GitHub Actions security hardening pin SHA", "CISA SBOM Executive Order 14028", "dependency confusion typosquatting npm attack" |
| Période couverte | 2021-2024 |
| Sources identifiées | ~20 |
| Sources retenues | 6 (NIST SP 800-218, CISA SBOM, SLSA v1.0, OWASP A06:2021, Sigstore/cosign, GitHub Docs hardening) |
| Date d'extraction | 2026-04-17 |

---

## Sources exclues — raisons documentées

| Source | Raison exclusion |
|--------|-----------------|
| Executive Order 14028 (Maison Blanche, 2021) | Absorbé par NIST SP 800-218 et CISA SBOM qui en implémentent les exigences avec guidance technique |
| OWASP Dependency-Track documentation | Documentation outil — redondante avec OWASP A06 (principes) et CISA SBOM (stratégie). Pas de guidance prescriptive propre. |
| npm audit documentation (npm, 2024) | Absorbée par OWASP A06 qui cite npm audit explicitement comme outil recommandé |
| CycloneDX specification (OWASP, 2023) | Spécification de format absorbée par CISA SBOM qui référence CycloneDX comme format officiel |
| in-toto specification (CNCF, 2023) | Trop granulaire pour le niveau du principe — substrat technique de SLSA v1.0, absorbé par celui-ci |
| Anchore Syft / Grype documentation | Biais commercial (Anchore). Outil mentionné dans le principe sur la base des recommandations CISA/SLSA |
| Renovate documentation (Mend, 2024) | Biais commercial (Mend/WhiteSource). Outil mentionné sur la base de OWASP A06 |
| Post-mortems SolarWinds/Codecov (blogs, news) | Sources journalistiques — les faits pertinents sont documentés dans SLSA v1.0 (niveau 2) |
| GitHub Advisory Database | Base de données CVE, pas de guidance prescriptive propre — absorbée par OWASP A06 et Dependabot |
