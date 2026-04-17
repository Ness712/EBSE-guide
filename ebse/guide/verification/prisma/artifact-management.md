# PRISMA Flow — PICOC artifact-management

**Date de recherche** : 2026-04-17
**Bases interrogées** : npm Docs (docs.npmjs.com), SLSA / OpenSSF (slsa.dev), Docker Docs (docs.docker.com), GitHub Docs, OWASP, WebSearch général
**Mots-clés Agent A** : "npm lockfile reproducibility ci", "npm ci strict lockfile adherence", "SLSA provenance npm publish", "Docker multi-stage build security", "artifact management supply chain CI", "GHCR GitHub Container Registry authentication"
**Mots-clés Agent B** : "package-lock.json npm ci abort inconsistency", "SLSA supply chain levels software artifacts", "Docker multi-stage build minimal image", "artifact retention policy CI CD", "Docker image tag immutable production", "Trivy Grype vulnerability scan CI gate"
**Protocole** : methodology.md v3.0 §2.1 — double extraction indépendante (Agents A + B, mots-clés différents) + synthèse Agent C

---

## Flux

```
IDENTIFICATION
  Sources identifiées par base (Agent A + Agent B combinés, avant déduplication) :
    - Documentation officielle (npm, Docker, GitHub, SLSA/OpenSSF) : ~10 résultats candidats
    - Guides sécurité supply chain (OWASP, CNCF, OpenSSF) : ~8 résultats candidats
    - Documentation outils (Trivy, Grype, Snyk, Cosign) : ~6 résultats candidats
    - Articles de blog / tutoriels techniques : ~14 résultats candidats
    - Articles académiques / surveys CI/CD security : ~5 résultats candidats
    - Snowballing backward (références citées par sources principales) : ~4 sources
  Total identifié (brut, combiné A+B) : ~47
  Doublons retirés (même source identifiée par A et B) : 4 (npm package-lock.json, SLSA v1.0, Docker multi-stage builds, npm provenance statements)
  Total après déduplication : ~43

SCREENING (titre + résumé)
  Sources screenées : ~43
  Sources exclues au screening : ~30
    - E1 (blog opinion sans données ou méthodologie) : ~10
    - E2 (hors scope PICOC — artefacts build en général, pas reproductibilité/traçabilité/sécurité) : ~7
    - E3 (doublons partiels — couverts par sources primaires déjà incluses) : ~6
    - E4 (vendeur / marketing sans substance technique) : ~7

ELIGIBILITÉ (lecture complète)
  Sources évaluées en détail : ~13
  Sources exclues après lecture complète : ~9
    - Hors scope PICOC strict (sécurité supply chain générale sans focus artefacts) : 3
    - Niveau de preuve insuffisant (tutoriel sans fondement normatif) : 3
    - Redondance forte avec sources primaires incluses : 3

INCLUSION
  Sources incluses dans la synthèse : 4
    - Niveau 3 : 4 (npm provenance docs, SLSA v1.0 slsa.dev, Docker multi-stage docs, npm package-lock.json docs)

  Sources exclues avec raison documentée : 9
    - GitHub Actions OIDC documentation : couvert par npm provenance docs, pas d'apport différencié
    - CNCF Software Supply Chain Best Practices : principes généraux absorbés par SLSA v1.0
    - Sigstore / Cosign documentation : outil complémentaire, hors scope PICOC (images Docker signées distinctement des artefacts npm)
    - OWASP Top 10 CI/CD Security Risks : couvert par SLSA pour le périmètre artefacts ; candidat pour PICOC supply-chain-security
    - Snyk documentation : outil commercial, principe de scan couvert par Trivy/Grype (open source)
    - Trivy / Grype documentation : outils de scan — mentionnés dans le principe mais pas sources primaires du GRADE
    - Articles académiques CI/CD security (3 papiers) : mesurent la prévalence des problèmes mais n'apportent pas de guidance prescriptive supplémentaire
    - npm workspaces / monorepo lockfile patterns : hors scope du principe universel (variant)
    - Docker Content Trust / Notary v2 : supplanté par SLSA + Sigstore pour les cas d'usage modernes
```

---

## Documentation recherche (Table 2 Kitchenham)

### Agent A — bases interrogées

| Élément | Valeur |
|---------|--------|
| Bases | npm Docs, SLSA/OpenSSF, Docker Docs, GitHub Docs, WebSearch général |
| Mots-clés | "npm lockfile reproducibility ci", "npm ci strict lockfile adherence", "SLSA provenance npm publish", "Docker multi-stage build security", "artifact management supply chain CI", "GHCR authentication" |
| Période couverte | 2023-2024 |
| Sources identifiées | ~25 |
| Sources retenues | 4 |
| Date d'extraction | 2026-04-17 |

### Agent B — bases interrogées

| Élément | Valeur |
|---------|--------|
| Bases | npm Docs, SLSA/OpenSSF, Docker Docs, OWASP, WebSearch, documentation outils scan |
| Mots-clés | "package-lock.json npm ci abort inconsistency", "SLSA supply chain levels software artifacts", "Docker multi-stage build minimal image", "artifact retention policy CI CD", "Docker image tag immutable production", "Trivy Grype vulnerability scan CI gate" |
| Période couverte | 2023-2024 |
| Sources identifiées | ~22 |
| Sources retenues | 4 (convergence totale avec A) |
| Date d'extraction | 2026-04-17 |

---

## Sources exclues — raisons documentées

| Source | Raison exclusion |
|--------|-----------------|
| GitHub Actions OIDC documentation | Redondance — couvert par npm provenance docs qui référence OIDC comme mécanisme sous-jacent, pas d'apport différencié pour le principe |
| CNCF Software Supply Chain Best Practices | Principes généraux de haut niveau absorbés par SLSA v1.0 (plus précis, plus opérationnel) |
| Sigstore / Cosign documentation | Hors scope PICOC strict — signature des images Docker avec Cosign est un PICOC distinct (supply-chain-security) |
| OWASP Top 10 CI/CD Security Risks (2022) | Principes artefacts couverts par SLSA ; candidat pour PICOC supply-chain-security dont artifact-management dépend |
| Snyk vulnerability scanning documentation | Outil commercial — principe de scan de vulnérabilités couvert par sources open source (Trivy, Grype) ; pas de valeur différenciée pour le GRADE |
| Trivy / Grype / Aqua Scanner documentation | Outils d'implémentation du principe de scan — le principe est dans le GRADE mais la documentation des outils n'est pas une source primaire |
| Articles académiques CI/CD security (3 papiers arXiv/IEEE) | Mesurent la prévalence des mauvaises pratiques sans apport de guidance prescriptive supplémentaire aux sources officielles |
| npm workspaces lockfile patterns | Hors scope du principe universel — spécificité monorepo, candidat pour variant |
| Docker Content Trust / Notary v2 | Supplanté par SLSA + Sigstore pour les cas d'usage modernes de signature d'images |
