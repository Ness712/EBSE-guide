# Audit de couverture matrice → guide

**Date** : 2026-04-14
**Methode** : comparaison systematique de chaque decision de matrix.md avec les pages guide

## Resultats

| Categorie | Count |
|-----------|-------|
| Decisions couvertes par une page dediee | ~70 |
| Decisions couvertes partiellement (dans une page existante) | ~12 |
| Decisions exclues avec justification | ~7 |
| Pages sans case matrice explicite (justifiees par ISO 9241) | 8 |

## Decisions couvertes partiellement (pas de page dediee)

Ces decisions sont traitees dans une page existante, pas dans une page separee :

| Decision matrice | Couverte dans | Justification |
|---|---|---|
| Stress testing / capacity planning | performance-testing.md | k6 couvre le load et stress testing |
| Docker networking / port mapping | containerization.md | Section Docker Compose |
| Zero-downtime deploy | deployment-strategy.md | Rolling update = zero-downtime |
| Alert severity classification | alerting.md | Section escalation |
| Optimistic UI / double-submit | forms.md | Section validation timing |
| Auto-scaling (HPA, KEDA) | scaling.md + containerization.md | Decision tree dans scaling |
| Flaky test management | unit-tests.md | Beck: "delete non-deterministic tests" |
| Shared library versioning | dependencies.md | Lockfiles + versioning |
| Complexity metrics | linting.md | SonarQube mesure la complexite |
| Refactoring strategy | tech-debt.md | Boy scout rule + 20% sprint |
| Third-party integration security | input-validation.md + rate-limiting.md | Validation + rate limiting couvrent les integrations |
| DI framework | module-structure.md | Spring DI est le defaut, pas un choix |

## Decisions exclues avec justification

| Decision matrice | Raison d'exclusion |
|---|---|
| Priorisation MoSCoW/RICE | Gestion de projet, pas decision technique. SWEBOK SE Management KA. |
| A/B testing (PostHog, Unleash) | Feature product, pas infrastructure. Peut etre ajoute quand le besoin emerge. |
| Risk register / risk assessment | Gestion de projet, pas decision technique de code/config. |
| PWA (service worker, manifest) | Decision feature, pas universelle. Ajouter quand le projet le decide. |
| CRUD vs task-based API style | Trop granulaire — depend de chaque endpoint, pas une decision globale. |
| Webhook verification (HMAC) | Trop specifique — a traiter quand le besoin de webhooks emerge. |
| Icon library (Lucide, Heroicons) | Choix cosmetique, pas d'evidence-based answer. [CHOIX D'EQUIPE]. |

## Pages sans case matrice explicite (justifiees)

| Page | Justification |
|---|---|
| typography | ISO 9241-125 "visual presentation" + WCAG 1.4.8/1.4.12 |
| colors | ISO 9241-125 + WCAG 1.4.3 (contrast) |
| spacing | ISO 9241-112 "regular spacing for readability" |
| shadows | ISO 9241-125 "visual presentation" — depth/hierarchy |
| visual-trends | User engagement × Design (convergence M3 + Apple HIG) |
| user-effectiveness | ISO 25019:2023 quality-in-use (gap analysis) |
| backend-framework | Functional Suitability × Architecture — choix de stack |
| frontend-framework | Functional Suitability × Architecture — choix de stack |

Ces 8 pages sont derivees de sous-caracteristiques ISO qui ne sont pas nommees explicitement dans la matrice mais sont couvertes par les cases "User engagement × Design" et "Functional Suitability × Architecture".
