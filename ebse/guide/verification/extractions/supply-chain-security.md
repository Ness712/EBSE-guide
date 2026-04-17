# Double Extraction — PICOC supply-chain-security

**Date** : 2026-04-17
**Protocole** : methodology.md v3.0
**Agent A** : mots-clés : "secure software supply chain NIST SSDF", "SLSA levels build provenance OpenSSF", "sigstore cosign container signing OIDC", "software bill of materials SBOM SPDX CycloneDX", "SolarWinds Codecov supply chain attack CI pipeline"
**Agent B** : mots-clés : "OWASP A06 vulnerable outdated components npm audit", "SLSA v1.0 supply chain integrity", "GitHub Actions security hardening pin SHA", "CISA SBOM Executive Order 14028", "dependency confusion typosquatting npm attack"

---

## PICOC

```
P  = Équipes DevOps gérant des dépendances open source et des pipelines CI/CD
I  = Sécuriser la chaîne d'approvisionnement : SBOM, signature artefacts,
     analyse dépendances, niveaux SLSA
C  = Déploiement sans traçabilité des dépendances, actions CI non épinglées
O  = Réduction du risque de compromission via dépendances, intégrité des artefacts
Co = Applications avec npm/Maven/Docker, GitHub Actions (NestJS + Spring Boot)
```

---

## Accord Reviewer A / Reviewer B

### Sources évaluées par les deux reviewers

| # | Source | Niveau A | Niveau B | Accord inclusion ? | Note divergence |
|---|--------|---------|---------|:-----------------:|-----------------|
| 1 | NIST SP 800-218 — SSDF v1.1 (NIST, 2022) | 1 | 1 | ✓ | — |
| 2 | CISA — Software Bill of Materials SBOM (CISA, 2023) | 1 | 1 | ✓ | — |
| 3 | SLSA v1.0 — Build Track (OpenSSF/Google, 2023) | 2 | 2 | ✓ | — |
| 4 | OWASP Top 10 2021 — A06: Vulnerable and Outdated Components | 2 | 2 | ✓ | — |
| 5 | Sigstore — Signing Containers with Cosign (Linux Foundation, 2024) | 2 | 2 | ✓ | — |
| 6 | GitHub Docs — Security hardening for GitHub Actions (GitHub, 2024) | non trouvé | 2 | ✗ A / ✓ B | **Divergence inclusion** |

**Sources identifiées par A uniquement** : aucune exclusive après résolution.
**Sources identifiées par B uniquement** : GitHub Docs Security hardening for GitHub Actions (documentation opérateur CI).

**Accord sur inclusion des sources communes** : 5/5 → kappa ≈ 1.0 (inclusion).
**Désaccords d'inclusion** : 1/6 → GitHub Docs hardening (B seulement).

### Résolution des divergences

**GitHub Docs — Security hardening for GitHub Actions (B seulement, niveau 2)** : inclus. Documentation officielle de l'opérateur de la plateforme CI la plus utilisée dans l'écosystème (GitHub Actions). Source directement actionnable sur le vecteur d'attaque Codecov (action tierce compromise → accès secrets). La recommandation d'épinglage SHA est absente des autres sources incluses — c'est un apport non redondant. Non trouvé par A car ses mots-clés étaient orientés "build provenance et SLSA" plutôt que "hardening CI Actions spécifique". Inclus sur décision de l'Agent C.

---

## Calcul GRADE final

```
Score de départ : 4
  (sources les plus hautes = niveau 1 : NIST SP 800-218 + CISA SBOM)

+ 1 convergence
  NIST SP 800-218 (niveau 1, mandaté EO 14028) + CISA SBOM (niveau 1)
  + SLSA v1.0 (OpenSSF, niveau 2) + OWASP A06:2021 (niveau 2)
  + Sigstore/cosign (Linux Foundation, niveau 2)
  + GitHub Docs hardening (GitHub, niveau 2)
  convergent sans contradiction sur les 4 pratiques centrales :
  - SBOM comme inventaire obligatoire des dépendances transitives
  - Audit de dépendances en CI avec échec sur CVE high/critical
  - Signature cryptographique des artefacts produits
  - Épinglage et durcissement du pipeline CI
  4 catégories distinctes : normatif gouvernemental (NIST/CISA),
  open source foundation (OpenSSF, Linux Foundation, GitHub),
  sécurité applicative (OWASP), opérateur CI (GitHub).

+ 1 effet important
  OWASP A06 quantifie : 30 457 occurrences, taux d'incidence max 27.96%.
  SLSA documente SolarWinds (18 000 organisations compromises via
  l'outil de build) et Codecov (exfiltration secrets CI de milliers
  d'équipes). XZ Utils (2024) : backdoor introduit sur 2 ans dans un
  mainteneur open source de confiance. Ces incidents sont publics,
  documentés, et établissent le coût réel de l'absence des pratiques.

- 0 malus
  Les sources convergent sans contradiction. Les nuances opérationnelles
  (faux positifs npm audit, overhead Dependabot) sont des risques
  d'implémentation, non des contradictions sur les principes.

Score final : 4 + 1 + 1 = 6 → [STANDARD]
```

Note biais de publication : les sources de niveau 1 (NIST, CISA) sont des publications gouvernementales mandatées, non soumises au biais de publication académique. Les sources de niveau 2 (SLSA, OWASP, Sigstore, GitHub) sont des guides publiés par des fondations ou organisations institutionnelles — biais possible vers la promotion des outils qu'elles maintiennent (cosign/Sigstore pour Linux Foundation, OWASP Dependency Check pour OWASP). Ce biais est atténué par la convergence inter-organisations indépendantes et par la corroboration empirique des incidents documentés.

---

## Analyse de sensibilité {#analyse-de-sensibilite}

| Source retirée | Score sans | Niveau sans | Changement ? |
|---------------|-----------|------------|:------------:|
| NIST SP 800-218 (niveau 1) | 4+1+1=6 (CISA niveau 1 reste, convergence et effet maintenus) | [STANDARD] | NON |
| CISA SBOM (niveau 1) | 4+1+1=6 (NIST niveau 1 reste, convergence et effet maintenus) | [STANDARD] | NON |
| NIST + CISA simultanément | 2+1+1=4 (départ niveau 2, convergence SLSA+OWASP+Sigstore+GitHub, effet incidents) | [RECOMMANDE] | OUI — mais scénario improbable : deux publications d'agences fédérales US mandatées par EO 14028 |
| SLSA v1.0 | 4+1+1=6 (NIST+CISA niveau 1, OWASP+Sigstore+GitHub convergent) | [STANDARD] | NON |
| OWASP A06:2021 | 4+1+1=6 (quantification incidents couverte par SLSA pour SolarWinds/Codecov) | [STANDARD] | NON |
| Sigstore/cosign | 4+1+1=6 (NIST+CISA+SLSA+OWASP+GitHub convergent, signature couverte par SLSA L2) | [STANDARD] | NON |
| GitHub Docs hardening | 4+1+1=6 (épinglage SHA couvert implicitement par SLSA L3) | [STANDARD] | NON |
| Toutes sources niveau 2 simultanément | 4+0+0=4 (NIST+CISA niveau 1, plus de convergence ni d'effet documenté sans niveau 2) | [RECOMMANDE] | OUI |

**Conclusion : ROBUSTE** — recommandation [STANDARD] stable pour tout retrait individuel, y compris le retrait de l'une des deux sources de niveau 1. Le seul scénario de déclassement est le retrait simultané des deux sources de niveau 1 (NIST + CISA), ce qui ramènerait le départ à niveau 2 → score 2+1+1=4 [RECOMMANDE]. Ce scénario est irréaliste : il s'agit de deux publications d'agences fédérales américaines mandatées par décret présidentiel (EO 14028), largement citées et établies. L'autre scénario de déclassement est le retrait simultané de toutes les sources de niveau 2, ce qui éliminerait la convergence et l'effet — également improbable. La robustesse est renforcée par la documentation empirique des incidents (SolarWinds, Codecov, XZ Utils) qui existent indépendamment des sources incluses.

---

## Sources exclues

| Source | Critère | Raison |
|--------|---------|--------|
| Executive Order 14028 (Maison Blanche, 2021) | E3 | Source primaire réglementaire, mais absorbée entièrement par NIST SP 800-218 et CISA SBOM qui en implémentent les exigences. Redondant sans apport technique supplémentaire. |
| OWASP Dependency-Track documentation | E3 | Outil de gestion SBOM. Documentation outil redondante avec OWASP A06 sur les principes, et avec les guides CISA/NIST sur le SBOM. Candidat pour une note d'implémentation, pas pour le principe. |
| npm audit documentation (npm, 2024) | E3 | Documentation outil. Absorbée par OWASP A06 qui cite explicitement npm audit comme outil recommandé. |
| GitHub Advisory Database | E3 | Base de données CVE. Outil de référence absorbé par OWASP A06 et par Dependabot (qui l'utilise). Pas de guidance prescriptive propre. |
| Anchore Syft / Grype documentation | E4 | Documentation outil commercial (Anchore). Biais fournisseur. Syft mentionné dans le principe uniquement comme outil parmi d'autres sur la base de la recommandation CISA/SLSA. |
| Post-mortems SolarWinds / Codecov (blogs, news) | E2 | Sources journalistiques ou billets de blog. Les faits pertinents sont documentés dans SLSA v1.0 (source normative niveau 2) qui cite explicitement ces incidents. |
| CycloneDX specification (OWASP, 2023) | E3 | Spécification de format. Absorbée par CISA SBOM qui référence CycloneDX comme format officiel. Pas d'apport prescriptif supplémentaire sur la stratégie. |
| Renovate documentation (Mend, 2024) | E4 | Documentation outil à biais commercial (Mend/WhiteSource). Outil mentionné dans le principe sur la base de OWASP A06 (qui recommande les outils d'automatisation des mises à jour). |
| in-toto specification (CNCF, 2023) | E2 | Framework de provenance des artefacts. Hors scope PICOC strict — trop granulaire pour le niveau du principe. Partiellement absorbé par SLSA v1.0 qui s'appuie sur in-toto comme substrat technique. |
