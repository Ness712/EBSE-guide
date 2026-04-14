# EBSE Guide — Guide de decisions techniques

**Version** : 0.1 (en construction)
**Date** : 2026-04
**Methode** : Evidence-Based Software Engineering (EBSE)
**Couverture** : 77 recommandations techniques organisees par domaine

## Comment utiliser ce guide

1. **Tu commences un projet ?** → Va dans [01-stack-profiles/](01-stack-profiles/) pour une stack complete recommandee
2. **Tu cherches une decision specifique ?** → Va dans la section par domaine ci-dessous
3. **Tu veux verifier une recommandation ?** → Chaque recommandation a un lien vers sa justification detaillee dans [justifications/](../cases/)

## Niveaux de confiance

| Badge | Signification | Base sur |
|-------|--------------|----------|
| **[STANDARD]** | Quasi-indiscutable | Standards internationaux (ISO, W3C) + consensus total |
| **[RECOMMANDE]** | Meilleur choix selon les sources | Enquetes + docs + experts convergents |
| **[BONNE PRATIQUE]** | Recommande avec reserves | Experts convergents, peu de donnees quantitatives |
| **[CHOIX D'EQUIPE]** | Pas de consensus | Sources insuffisantes ou contradictoires |

---

## Partie 1 — Profils de stack

Combinaisons completes, coherentes et validees par type de projet.

- [Web App — Java/React](01-stack-profiles/web-app-java-react.md)
- (autres profils a venir : Python/Django, Node/React, etc.)

---

## Partie 2 — Recommandations par domaine

77 recommandations organisees en 13 domaines.

### A. Accessibilite (2)

- [Internationalisation (i18n)](02-domains/accessibility/i18n.md)
- [Niveau WCAG cible](02-domains/accessibility/wcag-level.md)

### B. Architecture (5)

- [Protocole API (REST/GraphQL/gRPC)](02-domains/architecture/api-protocol.md)
- [Versioning d'API](02-domains/architecture/api-versioning.md)
- [Base de donnees](02-domains/architecture/database.md)
- [Structure des modules/packages](02-domains/architecture/module-structure.md)
- [Specification OpenAPI](02-domains/architecture/openapi.md)

### C. CI/CD & Deploiement (5)

- [Pipeline CI](02-domains/cicd/ci-pipeline.md)
- [Container registry](02-domains/cicd/container-registry.md)
- [Containerisation](02-domains/cicd/containerization.md)
- [Strategie de deploiement](02-domains/cicd/deployment-strategy.md)
- [Infrastructure as Code](02-domains/cicd/infrastructure.md)

### D. Qualite de code (5)

- [Code review](02-domains/code-quality/code-review.md)
- [Linting](02-domains/code-quality/linting.md)
- [Conventions de nommage](02-domains/code-quality/naming.md)
- [Null safety](02-domains/code-quality/null-safety.md)
- [TypeScript strict mode](02-domains/code-quality/typescript-strict.md)

### E. Donnees (3)

- [Gestion des dates et heures](02-domains/data/date-time.md)
- [Encoding](02-domains/data/encoding.md)
- [Precision numerique](02-domains/data/numeric-precision.md)

### F. Design & Interface (16)

- [Animations et transitions](02-domains/design/animations.md)
- [Graphiques et data visualization](02-domains/design/charts.md)
- [Palette de couleurs et contraste](02-domains/design/colors.md)
- [Bibliotheque de composants](02-domains/design/component-library.md)
- [Empty states](02-domains/design/empty-states.md)
- [Formulaires](02-domains/design/forms.md)
- [Loading states](02-domains/design/loading-states.md)
- [Navigation et architecture de l'information](02-domains/design/navigation.md)
- [Real-time (WebSocket, SSE)](02-domains/design/realtime.md)
- [Responsive design](02-domains/design/responsive.md)
- [Recherche](02-domains/design/search.md)
- [Shadows et elevation](02-domains/design/shadows.md)
- [Systeme de spacing](02-domains/design/spacing.md)
- [Typographie](02-domains/design/typography.md)
- [Efficacite utilisateur](02-domains/design/user-effectiveness.md)
- [Tendances visuelles](02-domains/design/visual-trends.md)

### G. Operations & Monitoring (7)

- [Alerting](02-domains/operations/alerting.md)
- [Configuration par environnement](02-domains/operations/env-config.md)
- [Error tracking](02-domains/operations/error-tracking.md)
- [Feature flags](02-domains/operations/feature-flags.md)
- [Logging structure](02-domains/operations/logging.md)
- [SLOs et error budgets](02-domains/operations/slos.md)
- [Uptime monitoring](02-domains/operations/uptime.md)

### H. Performance (4)

- [Bundle optimization](02-domains/performance/bundle-optimization.md)
- [Caching](02-domains/performance/caching.md)
- [Connection pooling](02-domains/performance/connection-pooling.md)
- [Tests de performance](02-domains/performance/performance-testing.md)

### I. Gestion de projet (3)

- [Strategie de branching](02-domains/project/branching.md)
- [Conventions de commit](02-domains/project/commit-conventions.md)
- [Gestion des dependances](02-domains/project/dependencies.md)

### J. Fiabilite & Resilience (6)

- [Backup et disaster recovery](02-domains/reliability/backup-recovery.md)
- [Circuit breaker](02-domains/reliability/circuit-breaker.md)
- [Migrations de base de donnees](02-domains/reliability/database-migrations.md)
- [Gestion des erreurs](02-domains/reliability/error-handling.md)
- [Graceful shutdown](02-domains/reliability/graceful-shutdown.md)
- [Monitoring](02-domains/reliability/monitoring.md)

### K. Safety & Conformite (4)

- [Confirmation des actions destructives](02-domains/safety/destructive-confirmation.md)
- [RGPD et protection des donnees](02-domains/safety/gdpr.md)
- [Safe defaults](02-domains/safety/safe-defaults.md)
- [Alerte modifications non sauvegardees](02-domains/safety/unsaved-changes.md)

### L. Securite (10)

- [Audit logging](02-domains/security/audit-logging.md)
- [Authentification](02-domains/security/authentication.md)
- [Scanning de dependances](02-domains/security/dependency-scanning.md)
- [Encryption](02-domains/security/encryption.md)
- [HTTP security headers](02-domains/security/http-headers.md)
- [Validation des entrees](02-domains/security/input-validation.md)
- [Hashing des mots de passe](02-domains/security/password-hashing.md)
- [Rate limiting](02-domains/security/rate-limiting.md)
- [Gestion des secrets](02-domains/security/secrets-management.md)
- [Threat modeling](02-domains/security/threat-modeling.md)

### M. Testing (7)

- [Tests de contrat](02-domains/testing/contract-tests.md)
- [Tests E2E](02-domains/testing/e2e-tests.md)
- [Tests d'integration](02-domains/testing/integration-tests.md)
- [Mocking](02-domains/testing/mocking.md)
- [Mutation testing](02-domains/testing/mutation-testing.md)
- [Donnees de test](02-domains/testing/test-data.md)
- [Tests unitaires](02-domains/testing/unit-tests.md)

---

## Partie 3 — Justifications

Chaque recommandation est liee a une [case detaillee](../cases/) contenant :
- Question PICO
- Sources consultees avec formulaires d'extraction
- Calcul GRADE
- Double extraction verifiee

---

## Tracabilite

Cette structure est derivee mecaniquement de la [matrice ISO 25010 x SWEBOK](../matrix.md).
Chaque section indique de quelles cases ISO elle est derivee.
Aucune section n'a ete ajoutee sans correspondance dans la matrice.
