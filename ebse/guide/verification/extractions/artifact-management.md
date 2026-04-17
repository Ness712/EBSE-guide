# Double Extraction — PICOC artifact-management

**Date** : 2026-04-17
**Protocole** : methodology.md v3.0
**Agent A** : mots-clés : "npm lockfile reproducibility ci", "npm ci strict lockfile adherence", "SLSA provenance npm publish", "Docker multi-stage build security", "artifact management supply chain CI", "GHCR GitHub Container Registry authentication"
**Agent B** : mots-clés : "package-lock.json npm ci abort inconsistency", "SLSA supply chain levels software artifacts", "Docker multi-stage build minimal image", "artifact retention policy CI CD", "Docker image tag immutable production", "Trivy Grype vulnerability scan CI gate"

---

## PICOC

```
P  = Équipes développement gérant des pipelines CI/CD avec publication de packages npm et d'images Docker
I  = Lockfile committé + npm ci + provenance SLSA + multi-stage builds + tags immuables + scan de vulnérabilités
C  = Builds non reproductibles (npm install sans lockfile strict), artefacts sans traçabilité, images Docker non minimalistes, tag latest en production
O  = Reproductibilité des builds, traçabilité cryptographique des artefacts, sécurité de la chaîne de livraison
Co = Projets utilisant npm (Node.js/TypeScript) et Docker avec CI/CD (GitHub Actions ou équivalent)
```

---

## Accord Reviewer A / Reviewer B

| # | Source | Niveau A | Niveau B | Accord ? | Note divergence |
|---|--------|---------|---------|:--------:|-----------------|
| 1 | npm Docs — Generating provenance statements (docs.npmjs.com, 2024) | 3 | 3 | ✓ | — |
| 2 | SLSA — Supply-chain Levels for Software Artifacts v1.0 (slsa.dev, 2023) | 3 | 3 | ✓ | — |
| 3 | Docker Docs — Multi-stage builds (docs.docker.com, 2024) | 3 | 3 | ✓ | — |
| 4 | npm Docs — package-lock.json (docs.npmjs.com, 2024) | 3 | 3 | ✓ | — |

**Accord sur sources communes** : 4/4 → kappa = 1.0 (inclusion + niveau).
**Sources A-only** : aucune.
**Sources B-only** : aucune.

### Résolution des divergences

Aucune divergence A/B. Les quatre sources ont été identifiées indépendamment par les deux extracteurs avec attribution de niveaux identiques. La convergence totale est cohérente avec la nature des sources : toutes sont des documentations officielles de leurs organisations respectives (npm/GitHub, OpenSSF/Google, Docker Inc.), sans ambiguïté sur leur niveau dans la pyramide des preuves.

---

## Calcul GRADE final

```
Score de départ : 2
  (source la plus haute directement pertinente = niveau 3 :
   npm Docs (docs.npmjs.com), SLSA v1.0 (slsa.dev), Docker Docs (docs.docker.com)
   Toutes sont documentations officielles niv.3 — aucune source de niveau 1 ou 2 disponible
   sur ce PICOC spécifique. SLSA v1.0 est la spécification la plus proche d'un standard
   normatif mais émane d'OpenSSF (consortium industrie), pas d'un organisme W3C/IETF/ISO.)

+ 1 convergence
  npm Docs package-lock.json (npmjs.com) + npm Docs provenance (npmjs.com) +
  SLSA v1.0 (OpenSSF/Google) + Docker Docs multi-stage (Docker Inc.) —
  4 sources indépendantes de 3 organisations distinctes convergent sans contradiction
  sur les mêmes principes :
  (1) lockfile commité + npm ci pour la reproductibilité
  (2) provenance SLSA signée cryptographiquement pour la traçabilité
  (3) multi-stage builds + nettoyage dans la même RUN pour les images minimalistes
  Sources indépendantes : écosystème npm, standard sécurité supply chain, conteneurisation —
  3 catégories distinctes et convergentes.

Facteurs négatifs :
  - Pas d'incohérence entre sources.
  - Indirectness légère : absence de sources niveau 1 (standard normatif W3C/IETF/ISO) ou
    niveau 2 (guide sécurité applicatif type OWASP) directement dédiées à l'artifact management.
    Les sources niveau 3 sont des documentations officielles exhaustives et prescriptives,
    mais ne constituent pas des standards au sens strict. Ce facteur maintient le score à 3
    (RECOMMANDE) plutôt que de monter à 4+ (STANDARD).

Score final : 2 + 1 = 3 → [RECOMMANDE]
```

Note biais de publication : faible — les sources sont prescriptives par nature (documentation officielle). SLSA v1.0 est soutenu par Google, Microsoft, GitHub, et l'OpenSSF, ce qui lui confère une autorité industrielle forte même sans statut ISO/W3C. La convergence multi-organisations (npm/GitHub, OpenSSF, Docker Inc.) sur des principes cohérents réduit le risque de biais d'un éditeur unique.

---

## Analyse de sensibilité {#analyse-de-sensibilite}

| Source retirée | Score sans | Niveau sans | Changement ? |
|---------------|-----------|------------|:------------:|
| npm Docs — package-lock.json | 3 (départ 2, +1 conv — 3 sources restantes toujours convergentes) | RECOMMANDE | NON |
| npm Docs — provenance statements | 3 (départ 2, +1 conv — 3 sources restantes toujours convergentes) | RECOMMANDE | NON |
| SLSA v1.0 | 3 (départ 2, +1 conv — npm + Docker convergent sur reproductibilité et images ; provenance npm couvre la traçabilité sans SLSA nommément) | RECOMMANDE | NON |
| Docker Docs — multi-stage builds | 3 (départ 2, +1 conv — npm + SLSA convergent sur reproductibilité et traçabilité) | RECOMMANDE | NON |
| Toutes sources npm (2 sources npm retirées) | 2 (départ 2, convergence entre 2 sources SLSA + Docker seulement — seuil convergence non atteint) | ACCEPTABLE | OUI |
| SLSA + Docker simultanément | 2 (départ 2, source npm unique — pas de convergence inter-organisations) | ACCEPTABLE | OUI |

**Conclusion : ROBUSTE** — recommandation [RECOMMANDE] stable pour tout retrait individuel. Le grade est sensible au retrait de deux sources ou plus appartenant à des organisations distinctes, ce qui reflète correctement la fragilité relative d'un grade reposant entièrement sur des sources niveau 3 (documentation officielle sans standard normatif niveau 1/2). La robustesse reste satisfaisante pour un PICOC de domaine project/CI-CD où les sources niveau 1 n'existent pas par nature (pas de RFC ou W3C sur la gestion d'artefacts).

---

## Sources exclues

| Source | Critère | Raison |
|--------|---------|--------|
| GitHub Actions OIDC documentation | E5 redondance | Mécanisme sous-jacent documenté par npm provenance docs ; pas d'apport différencié pour le principe |
| CNCF Software Supply Chain Best Practices | E3 absorbé | Principes généraux de haut niveau intégralement couverts par SLSA v1.0 (plus précis et opérationnel) |
| Sigstore / Cosign documentation | E2 scope | Signature des images Docker avec Cosign relève de supply-chain-security (PICOC distinct dont artifact-management dépend) |
| OWASP Top 10 CI/CD Security Risks (2022) | E2 scope | Couvert pour le périmètre artefacts par SLSA ; relève principalement de supply-chain-security |
| Snyk vulnerability scanning documentation | E4 vendeur | Documentation outil commercial — principe couvert par sources open source (Trivy, Grype) sans valeur différenciée |
| Trivy / Grype / Aqua Scanner documentation | E3 indirect | Documentations d'outils d'implémentation — le principe de scan est dans le GRADE mais les docs outils ne sont pas sources primaires |
| Articles académiques CI/CD security (3 papiers) | E3 indirect | Mesurent la prévalence des problèmes sans apport de guidance prescriptive supplémentaire aux sources officielles |
| npm workspaces / monorepo lockfile patterns | E2 scope | Spécificité monorepo — hors scope du principe universel, candidat pour variant |
| Docker Content Trust / Notary v2 | E5 supplanté | Supplanté par SLSA + Sigstore pour les cas d'usage modernes de vérification d'intégrité d'images |
