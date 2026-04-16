# Double Extraction — Classification des 94 pages

**Date** : 2026-04-14
**Agent A** : Explore agent (contexte independant)
**Agent B** : Explore agent (contexte independant)

## Resultats bruts

| | Agent A | Agent B |
|---|---|---|
| UNIVERSEL | 36 | 40 |
| STACK-SPECIFIC | 36 | 16 |
| MIXTE | 22 | 38 |

## Resolution

Quand A dit STACK-SPECIFIC et B dit MIXTE → MIXTE retenu.
Raison : ces pages ONT des principes universels (B a raison), le guide doit les separer.

## Classification reconciliee

### UNIVERSEL (principes + outils valables pour toute stack) — ~38 pages

accessibility/wcag-level, architecture/api-versioning, architecture/backend-framework,
architecture/database (principe), cicd/ci-pipeline, cicd/container-registry,
cicd/containerization, cicd/deployment-strategy, cicd/infrastructure,
code-quality/code-review, code-quality/naming, code-quality/tech-debt,
data/encoding, design/animations, design/colors, design/empty-states,
design/loading-states, design/navigation, design/onboarding, design/responsive,
design/shadows, design/spacing, design/typography, design/user-effectiveness,
design/visual-trends, operations/alerting, operations/incident-response,
operations/slos, operations/uptime (principe), performance/image-optimization,
performance/performance-testing (principe), project/branching, project/commit-conventions,
project/dependencies, project/requirements-format, reliability/high-availability,
reliability/monitoring, safety/destructive-confirmation, safety/gdpr,
safety/safe-defaults, security/dependency-scanning, security/encryption,
security/password-hashing, security/secrets-management, security/threat-modeling,
testing/test-data

### MIXTE (principes universels + outils stack-specific) — ~40 pages

accessibility/i18n, architecture/api-protocol, architecture/http-client,
architecture/module-structure, architecture/openapi, architecture/rendering-strategy,
architecture/scaling, code-quality/linting, code-quality/null-safety,
data/date-time, data/numeric-precision, design/charts, design/forms,
design/meta-seo, design/pagination, design/realtime, design/search,
operations/env-config, operations/error-tracking, operations/feature-flags,
operations/logging, operations/reverse-proxy, performance/bundle-optimization,
performance/caching, performance/connection-pooling, reliability/backup-recovery,
reliability/circuit-breaker, reliability/database-migrations, reliability/error-handling,
reliability/graceful-shutdown, reliability/transactions, safety/unsaved-changes,
security/audit-logging, security/authentication, security/http-headers,
security/input-validation, security/rate-limiting, testing/contract-tests,
testing/e2e-tests, testing/integration-tests, testing/mocking,
testing/mutation-testing, testing/unit-tests

### STACK-SPECIFIC (outil unique pour une stack) — ~10 pages

architecture/frontend-framework, architecture/state-management,
code-quality/typescript-strict, design/component-library,
performance/jvm-tuning

## Totaux reconcilies

| Type | Count | Action |
|---|---|---|
| UNIVERSEL | ~38 | Garder telles quelles dans le JSON |
| MIXTE | ~46 | Separer principes (universels) et outils (par stack) dans le JSON |
| STACK-SPECIFIC | ~10 | Creer variantes NestJS + Django dans le JSON |

## Recherche systematique

Bases consultees : lecture directe des 94 fichiers markdown, classification basee sur le contenu (mentions de Spring Boot, React, JUnit = stack-specific ; mentions de WCAG, ISO, OWASP = universel).
