# PRISMA Flow — PICOC gitops

**Date de recherche** : 2026-04-17
**Bases interrogées** : CNCF (opengitops.dev, argo-cd.readthedocs.io, fluxcd.io), Weaveworks blog, IEEE/ResearchGate, CNCF Annual Survey 2023, WebSearch général
**Mots-clés Agent A** : "GitOps principles declarative pull-based", "Argo CD GitOps Kubernetes continuous delivery", "GitOps vs push-based CD comparison", "GitOps drift detection reconciliation", "GitOps repository structure app config separation", "OpenGitOps CNCF TAG App Delivery"
**Mots-clés Agent B** : "Flux GitOps Kubernetes multi-tenancy", "GitOps pull model security benefits", "GitOps environment promotion PR workflow", "GitOps CI CD separation responsibilities", "GitOps empirical study deployment metrics", "Weaveworks GitOps operations pull request"
**Protocole** : methodology.md v3.0 §2.1 — double extraction indépendante (Agents A + B, mots-clés différents) + synthèse Agent C

---

## Flux

```
IDENTIFICATION
  Sources identifiées par base (Agent A + Agent B combinés, avant déduplication) :
    - Spécifications et standards CNCF (OpenGitOps, TAG App Delivery) : 3 résultats candidats
    - Documentation officielle outils (Argo CD, Flux, Weaveworks) : ~10 résultats candidats
    - Articles de recherche (IEEE, ResearchGate, ACM) : ~8 résultats candidats
    - CNCF surveys et rapports d'adoption : ~5 résultats candidats
    - Blogs techniques et conference talks (KubeCon, GitOpsCon) : ~15 résultats candidats
    - Snowballing backward (références citées par sources principales) : ~6 sources
  Total identifié (brut, combiné A+B) : ~47
  Doublons retirés (même source identifiée par A et B) : 4 (OpenGitOps v1.0.0, Argo CD docs, Flux docs, Weaveworks 2017)
  Total après déduplication : ~43

SCREENING (titre + résumé)
  Sources screenées : ~43
  Sources exclues au screening : ~30
    - E1 (blog opinion sans données ou méthodologie) : ~12
    - E2 (hors scope PICOC — GitOps général sans focus synchronisation automatique / réconciliation) : ~8
    - E3 (doublons partiels — couverts par sources primaires déjà incluses) : ~6
    - E4 (vendeur / marketing sans substance technique) : ~4

ELIGIBILITÉ (lecture complète)
  Sources évaluées en détail : ~13
  Sources exclues après lecture complète : ~8
    - Hors scope PICOC strict (GitOps pour non-Kubernetes uniquement, sans principe généralisable) : 3
    - Niveau de preuve insuffisant (conférences sans peer-review, slides sans données) : 3
    - Redondance forte avec OpenGitOps v1.0.0 sans apport supplémentaire : 2

INCLUSION
  Sources incluses dans la synthèse : 5
    - Niveau 2 : 4 (OpenGitOps v1.0.0, Argo CD docs CNCF Graduated, Flux docs CNCF Graduated, Weaveworks 2017)
    - Niveau 3 : 1 (IEEE/ResearchGate 2022 — données empiriques)

  Sources exclues avec raison documentée : 8
    - CNCF Annual Survey 2023 (données d'adoption) : données d'adoption sans guidance prescriptive — utilisé comme contexte, pas source de principe
    - GitOpsCon talks (KubeCon 2022, 2023) : conférences sans peer-review, principes couverts par OpenGitOps
    - Codefresh blog — GitOps best practices : niveau 5 redondant avec sources CNCF Graduated
    - WeaveWorks — "Guide to GitOps" (2022) : couvert intégralement par article fondateur 2017 + Flux docs officielles
    - Tekton / Jenkins X docs : hors scope (outils CI, pas agents GitOps pull-based)
    - ArgoProj ecosystem docs (Argo Rollouts, Argo Events) : hors scope PICOC (synchronisation état désiré, pas progressive delivery)
    - Ansible GitOps patterns : implémentation non-Kubernetes — principe generalisable couvert par OpenGitOps
    - Terraform GitOps : domaine IaC distinct (infrastructure provisioning vs application deployment)
```

---

## Documentation recherche (Table 2 Kitchenham)

### Agent A — bases interrogées

| Élément | Valeur |
|---------|--------|
| Bases | CNCF (opengitops.dev, argo-cd.readthedocs.io), IEEE Xplore, ResearchGate, WebSearch général |
| Mots-clés | "GitOps principles declarative pull-based", "Argo CD GitOps Kubernetes continuous delivery", "GitOps vs push-based CD comparison", "GitOps drift detection reconciliation", "OpenGitOps CNCF TAG App Delivery" |
| Période couverte | 2017-2024 |
| Sources identifiées | ~24 |
| Sources retenues | 4 |
| Date d'extraction | 2026-04-17 |

### Agent B — bases interrogées

| Élément | Valeur |
|---------|--------|
| Bases | fluxcd.io, Weaveworks blog, ResearchGate, CNCF Annual Survey, GitOpsCon proceedings, WebSearch |
| Mots-clés | "Flux GitOps Kubernetes multi-tenancy", "GitOps pull model security benefits", "GitOps environment promotion PR workflow", "GitOps CI CD separation responsibilities", "GitOps empirical study deployment metrics", "Weaveworks GitOps operations pull request" |
| Période couverte | 2017-2024 |
| Sources identifiées | ~23 |
| Sources retenues | 5 (convergence élevée avec A + IEEE 2022 en plus) |
| Date d'extraction | 2026-04-17 |

---

## Sources exclues — raisons documentées

| Source | Raison exclusion |
|--------|-----------------|
| CNCF Annual Survey 2023 (données d'adoption Argo CD / Flux) | Données d'adoption sans guidance prescriptive — contexte utile, pas source de principe |
| GitOpsCon KubeCon talks (2022, 2023) | Conférences sans peer-review ; les principes énoncés sont couverts et formalisés par OpenGitOps v1.0.0 |
| Codefresh blog — GitOps best practices | Niveau 5 redondant — perspective vendeur couverte par sources CNCF Graduated sans apport différencié |
| Weaveworks — "Guide to GitOps" (2022) | Couvert intégralement par l'article fondateur Richardson 2017 + docs officielles Flux ; pas d'apport supplémentaire |
| Tekton / Jenkins X documentation | Hors scope PICOC — outils CI (build/push), pas agents GitOps pull-based (reconciliation) |
| Argo Rollouts / Argo Events documentation | Hors scope PICOC — progressive delivery et event-driven, pas synchronisation état désiré |
| Ansible GitOps patterns | Implémentation non-Kubernetes spécifique — principe généralisable déjà couvert par OpenGitOps v1.0.0 |
| Terraform GitOps patterns | Domaine IaC distinct (infrastructure provisioning) — hors scope PICOC (synchronisation application + état désiré) |
