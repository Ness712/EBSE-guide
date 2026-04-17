# Double Extraction — PICOC gitops

**Date** : 2026-04-17
**Protocole** : methodology.md v3.0
**Agent A** : mots-clés : "GitOps principles declarative pull-based", "Argo CD GitOps Kubernetes continuous delivery", "GitOps vs push-based CD comparison", "GitOps drift detection reconciliation", "GitOps repository structure app config separation", "OpenGitOps CNCF TAG App Delivery"
**Agent B** : mots-clés : "Flux GitOps Kubernetes multi-tenancy", "GitOps pull model security benefits", "GitOps environment promotion PR workflow", "GitOps CI CD separation responsibilities", "GitOps empirical study deployment metrics", "Weaveworks GitOps operations pull request"

---

## PICOC

```
P  = Équipes développement et opérations gérant des déploiements répétables sur des environnements multiples
I  = Adopter GitOps (modèle pull-based, réconciliation automatique depuis un dépôt Git)
C  = Déploiements push-based (CI poussant directement vers le cluster), scripts impératifs, déploiements manuels
O  = Traçabilité, reproductibilité, drift detection, auditabilité, vitesse de déploiement, sécurité
Co = Applications cloud-native déployées sur Kubernetes, avec pipeline CI/CD existant
```

---

## Accord Reviewer A / Reviewer B

| # | Source | Niveau A | Niveau B | Accord ? | Note divergence |
|---|--------|---------|---------|:--------:|-----------------|
| 1 | OpenGitOps — GitOps Principles v1.0.0 (CNCF TAG App Delivery, 2021) | 2 | 2 | ✓ | — |
| 2 | Argo CD — documentation officielle (CNCF Graduated, 2024) | 2 | 2 | ✓ | — |
| 3 | Flux — documentation officielle (CNCF Graduated, 2024) | 2 | 2 | ✓ | — |
| 4 | Richardson A. — GitOps: Operations by Pull Request (Weaveworks, 2017) | 2 | 2 | ✓ | — |
| 5 | GitOps: A Reference Architecture for Cloud-Native CD (IEEE/ResearchGate, 2022) | absent | 3 | ✗ | **A ne cite pas, B cite pour les données empiriques** |

**Accord sur sources communes** : 4/4 → kappa = 1.0 (inclusion + niveau).
**Sources A-only** : aucune.
**Sources B-only** : IEEE/ResearchGate 2022 (données empiriques sur gains mesurés).

### Résolution des divergences

**IEEE/ResearchGate 2022 (B-only)** : Inclus — apporte des données empiriques quantifiées (réduction 50 % délais déploiement, 80 % incidents drift) absentes des sources normatives CNCF. Niveau 3 (article de recherche avec peer-review). Scope PICOC direct : l'article compare explicitement GitOps vs push-based CD sur les métriques de reproductibilité et traçabilité définies dans le PICOC. Aucun biais vendeur détecté (recherche académique indépendante). Apport différencié par rapport aux 4 autres sources (données empiriques vs principes normatifs).

---

## Calcul GRADE final

```
Score de départ : 3
  (source la plus haute directement pertinente = niveau 2 :
   OpenGitOps v1.0.0, Argo CD docs CNCF Graduated, Flux docs CNCF Graduated, Weaveworks 2017
   — aucune source niveau 1 (standard normatif type ISO/W3C/IETF) ;
   OpenGitOps est une spécification de projet CNCF, pas un standard de jure international)

+ 1 convergence
  OpenGitOps v1.0.0 (CNCF TAG App Delivery, co-signé par Argo CD + Flux + Weaveworks + Codefresh)
  + Argo CD docs (CNCF Graduated, implémentation pull-based)
  + Flux docs (CNCF Graduated, implémentation pull-based)
  + Richardson 2017 (fondateur du terme GitOps, organisation fondatrice Flux)
  → 4 organisations indépendantes convergent sur les mêmes 4 principes (declarative, versioned,
    pulled, reconciled) sans aucune contradiction ni dissonance partielle.
  Les principes OpenGitOps sont co-signés par les deux implémentations CNCF Graduated majeures :
  convergence inter-implémentation, pas seulement inter-sources.
  La convergence est maintenue sous tout retrait individuel.

Facteurs négatifs :
  - Pas d'incohérence entre sources (les 4 principes OpenGitOps sont reproduits textuellement
    dans les docs Argo CD et Flux sans contradiction).
  - Indirectness modérée : OpenGitOps v1.0.0 est une spécification CNCF community project,
    pas un standard ISO/W3C/IETF — d'où départ à 3 et non 4. Mitigé par le fait que les
    co-signataires incluent les deux implémentations Graduated les plus adoptées.
  - Pas d'imprécision : les 4 principes sont définis en termes opérationnels précis.

Score final : 3 + 1 = 4 → [RECOMMANDE]
```

Note biais de publication : faible — OpenGitOps est un standard communautaire co-signé par plusieurs organisations concurrentes (Argo CD / Codefresh vs Flux / Weaveworks), réduisant le risque de biais en faveur d'un vendeur unique. Les données empiriques IEEE 2022 proviennent d'une recherche académique indépendante. Le biais résiduel est que la plupart des sources primaires sont des documentations d'outils (Argo CD, Flux) — ce sont les auteurs des implémentations qui définissent les principes — mais la co-signature multi-vendeur d'OpenGitOps atténue significativement ce biais.

---

## Analyse de sensibilité {#analyse-de-sensibilite}

| Source retirée | Score sans | Niveau sans | Changement ? |
|---------------|-----------|------------|:------------:|
| OpenGitOps v1.0.0 | 4 (départ 3, +1 conv — Argo CD + Flux + Weaveworks convergent toujours) | RECOMMANDE | NON |
| Argo CD docs | 4 (départ 3, +1 conv — OpenGitOps + Flux + Weaveworks convergent) | RECOMMANDE | NON |
| Flux docs | 4 (départ 3, +1 conv — OpenGitOps + Argo CD + Weaveworks convergent) | RECOMMANDE | NON |
| Richardson 2017 (Weaveworks) | 4 (départ 3, +1 conv — OpenGitOps + Argo CD + Flux convergent) | RECOMMANDE | NON |
| IEEE/ResearchGate 2022 | 4 (source non décisive pour GRADE — données empiriques sans impact sur convergence) | RECOMMANDE | NON |
| Toutes sources CNCF Graduated (Argo CD + Flux) | 3 (départ 3, convergence réduite — OpenGitOps + Weaveworks seulement) | RECOMMANDE | NON |
| OpenGitOps + Richardson 2017 | 3 (départ 3, +0 conv — 2 sources restantes insuffisantes pour +1 convergence) | RECOMMANDE | NON |
| Toutes sources sauf IEEE 2022 | 4 (inchangé — IEEE non décisif pour le score) | RECOMMANDE | NON |

**Conclusion : ROBUSTE** — recommandation [RECOMMANDE] stable pour tout retrait individuel et pour tout retrait par catégorie, y compris le retrait des deux implémentations CNCF Graduated simultanément. Le score ne peut descendre sous 3 ([RECOMMANDE]) dans aucun scénario réaliste car les 4 principes GitOps sont définis dans au moins 2 sources indépendantes de niveau 2 dans tous les cas. L'absence de source niveau 1 (standard de jure) est le facteur limitant qui plafonne le grade à [RECOMMANDE] plutôt que [STANDARD].

---

## Sources exclues

| Source | Critère | Raison |
|--------|---------|--------|
| CNCF Annual Survey 2023 | E2 scope | Données d'adoption (% clusters utilisant Argo CD / Flux) sans guidance prescriptive sur les principes ; contexte utile, pas source de principe |
| GitOpsCon KubeCon talks (2022, 2023) | E1 redondance | Conférences sans peer-review ; les principes énoncés sont formalisés par OpenGitOps v1.0.0 avec plus de rigueur |
| Codefresh blog — GitOps best practices | E3 redondance | Niveau 5 perspective vendeur ; principes couverts par sources CNCF Graduated sans apport différencié |
| Weaveworks — "Guide to GitOps" (2022) | E5 supplanté | Couvert intégralement par Richardson 2017 (plus fondateur) + Flux docs officielles (plus à jour) |
| Tekton / Jenkins X documentation | E2 scope | Outils CI (build/push image) — hors scope PICOC (agents GitOps pull-based, réconciliation) |
| Argo Rollouts / Argo Events documentation | E2 scope | Progressive delivery / event-driven — hors scope PICOC (synchronisation état désiré depuis Git) |
| Ansible GitOps patterns | E2 scope | Implémentation non-Kubernetes spécifique ; les principes généralisables sont déjà couverts par OpenGitOps v1.0.0 |
| Terraform GitOps patterns | E2 scope | Infrastructure provisioning (IaC) — domaine distinct de la synchronisation application / état désiré du PICOC |
