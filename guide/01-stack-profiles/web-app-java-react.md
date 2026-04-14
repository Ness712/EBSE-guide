# Profil de stack : Web App — Java/React

**Version** : 2026.04
**Contexte** : Web application avec API REST, equipe 1-10 devs

Ce profil regroupe toutes les recommandations du guide en une stack coherente et validee.
Chaque choix est lie a sa page detaillee.

---

## Stack technique

| Couche | Outil | Niveau | Score | Page |
|--------|-------|--------|-------|------|
| **Backend** | Spring Boot 4 (Java 21) | [RECOMMANDE] | 5/7 | — |
| **Frontend** | React 19 + TypeScript | [RECOMMANDE] | 4/7 | — |
| **CSS** | Tailwind CSS 4 | [RECOMMANDE] | 4/7 | — |
| **UI Components** | shadcn/ui (Radix) | [RECOMMANDE] | 3/7 | [component-library](../02-domains/design/component-library.md) |
| **State** | Zustand | [RECOMMANDE] | 3/7 | — |
| **Base de donnees** | PostgreSQL | [STANDARD] | 5/7 | [database](../02-domains/architecture/database.md) |
| **Cache** | Redis | [RECOMMANDE] | 5/7 | [caching](../02-domains/performance/caching.md) |
| **Build frontend** | Vite 7 | [RECOMMANDE] | 4/7 | [bundle-optimization](../02-domains/performance/bundle-optimization.md) |

## Securite

| Decision | Outil/Pratique | Niveau | Score | Page |
|----------|---------------|--------|-------|------|
| Auth | Spring Security + JWT HttpOnly cookies | [RECOMMANDE] | 4/7 | [authentication](../02-domains/security/authentication.md) |
| Password hashing | Argon2id | [RECOMMANDE] | 4/7 | [password-hashing](../02-domains/security/password-hashing.md) |
| Validation input | Bean Validation + Zod + JPA parametrise | [STANDARD] | 6/7 | [input-validation](../02-domains/security/input-validation.md) |
| Encryption | TLS 1.3 + HSTS + AES-256 | [STANDARD] | 6/7 | [encryption](../02-domains/security/encryption.md) |
| Headers | CSP + HSTS + X-Content-Type + X-Frame | [STANDARD] | 6/7 | [http-headers](../02-domains/security/http-headers.md) |
| Rate limiting | Bucket4j | [RECOMMANDE] | 4/7 | [rate-limiting](../02-domains/security/rate-limiting.md) |
| Secrets | Env vars + GitHub Secrets + GitLeaks | [STANDARD] | 5/7 | [secrets-management](../02-domains/security/secrets-management.md) |
| Dependency scan | Dependabot + npm audit + OWASP plugin | [STANDARD] | 6/7 | [dependency-scanning](../02-domains/security/dependency-scanning.md) |

## Design & UI

| Decision | Valeur | Niveau | Score | Page |
|----------|--------|--------|-------|------|
| Spacing | 8px grid (4/8/12/16/24/32/48) | [STANDARD] | 4/7 | [spacing](../02-domains/design/spacing.md) |
| Typographie | Body 16px, line-height 1.5, max 75 chars | [STANDARD] | 6/7 | [typography](../02-domains/design/typography.md) |
| Couleurs | 2-3 teintes + neutres, contraste 4.5:1 | [STANDARD] | 5/7 | [colors](../02-domains/design/colors.md) |
| Animations | 200-300ms, ease-out/ease-in | [STANDARD] | 4/7 | [animations](../02-domains/design/animations.md) |
| Shadows | Subtiles, diffuses (sm/md/lg) | [RECOMMANDE] | 3/7 | [shadows](../02-domains/design/shadows.md) |
| Responsive | Mobile-first, Tailwind breakpoints | [STANDARD] | 5/7 | [responsive](../02-domains/design/responsive.md) |
| Formulaires | React Hook Form + Zod | [RECOMMANDE] | 4/7 | [forms](../02-domains/design/forms.md) |
| Loading | Skeleton screens | [RECOMMANDE] | 4/7 | [loading-states](../02-domains/design/loading-states.md) |
| WCAG | Niveau AA | [STANDARD] | 7/7 | [wcag-level](../02-domains/accessibility/wcag-level.md) |
| i18n | react-i18next | [RECOMMANDE] | 4/7 | [i18n](../02-domains/accessibility/i18n.md) |

## Testing

| Decision | Outil/Pratique | Niveau | Score | Page |
|----------|---------------|--------|-------|------|
| Strategie | Pyramide 70/20/10 | [STANDARD] | 5/7 | [unit-tests](../02-domains/testing/unit-tests.md) |
| Unit backend | JUnit 5 + AssertJ + Mockito | [RECOMMANDE] | 5/7 | [unit-tests](../02-domains/testing/unit-tests.md) |
| Unit frontend | Vitest + Testing Library | [RECOMMANDE] | 4/7 | [unit-tests](../02-domains/testing/unit-tests.md) |
| Integration | Testcontainers + @SpringBootTest | [STANDARD] | 5/7 | [integration-tests](../02-domains/testing/integration-tests.md) |
| E2E | Playwright | [RECOMMANDE] | 5/7 | [e2e-tests](../02-domains/testing/e2e-tests.md) |
| Coverage | 75% global, 90% nouveau code | [BONNE PRATIQUE] | 2/7 | [unit-tests](../02-domains/testing/unit-tests.md) |

## Qualite de code

| Decision | Outil | Niveau | Score | Page |
|----------|-------|--------|-------|------|
| Linter JS/TS | ESLint | [RECOMMANDE] | 5/7 | [linting](../02-domains/code-quality/linting.md) |
| Formatter JS/TS | Prettier | [RECOMMANDE] | 5/7 | [linting](../02-domains/code-quality/linting.md) |
| Linter Java | Checkstyle (google_checks.xml) | [BONNE PRATIQUE] | 2/7 | [linting](../02-domains/code-quality/linting.md) |
| Formatter Java | google-java-format | [BONNE PRATIQUE] | 2/7 | [linting](../02-domains/code-quality/linting.md) |
| Static analysis | SonarQube (Sonar way gate) | [RECOMMANDE] | 4/7 | [linting](../02-domains/code-quality/linting.md) |

## Operations & Monitoring

| Decision | Outil | Niveau | Score | Page |
|----------|-------|--------|-------|------|
| Monitoring | Prometheus + Grafana | [RECOMMANDE] | 4/7 | [monitoring](../02-domains/reliability/monitoring.md) |
| Error tracking | Sentry / GlitchTip | [RECOMMANDE] | 4/7 | [error-tracking](../02-domains/operations/error-tracking.md) |
| Logging | SLF4J + Logback JSON structure | [STANDARD] | 6/7 | [logging](../02-domains/operations/logging.md) |
| Error handling | RFC 9457 + @ControllerAdvice + Error Boundaries | [STANDARD] | 6/7 | [error-handling](../02-domains/reliability/error-handling.md) |
| Circuit breaker | Resilience4j | [RECOMMANDE] | 4/7 | [circuit-breaker](../02-domains/reliability/circuit-breaker.md) |
| Backup | pg_dump + WAL archiving | [STANDARD] | 5/7 | [backup-recovery](../02-domains/reliability/backup-recovery.md) |

## CI/CD & Deploiement

| Decision | Outil | Niveau | Score | Page |
|----------|-------|--------|-------|------|
| CI | GitHub Actions | [RECOMMANDE] | 4/7 | [ci-pipeline](../02-domains/cicd/ci-pipeline.md) |
| Container | Docker (multi-stage) | [STANDARD] | 6/7 | [containerization](../02-domains/cicd/containerization.md) |
| Orchestration | Docker Compose | [STANDARD] | 5/7 | [containerization](../02-domains/cicd/containerization.md) |
| Config | application-{profile}.yml + env vars | [STANDARD] | 6/7 | [env-config](../02-domains/operations/env-config.md) |

## Architecture & Projet

| Decision | Pratique | Niveau | Score | Page |
|----------|---------|--------|-------|------|
| Structure | Package-by-feature | [RECOMMANDE] | 4/7 | [module-structure](../02-domains/architecture/module-structure.md) |
| API doc | OpenAPI / springdoc | [STANDARD] | 5/7 | [openapi](../02-domains/architecture/openapi.md) |
| Branching | Trunk-based (< 2 jours) | [STANDARD] | 5/7 | [branching](../02-domains/project/branching.md) |
| Commits | Conventional Commits | [RECOMMANDE] | 4/7 | [commit-conventions](../02-domains/project/commit-conventions.md) |
| Encoding | UTF-8 partout | [STANDARD] | 7/7 | [encoding](../02-domains/data/encoding.md) |
| Date/time | java.time + dayjs, UTC serveur | [STANDARD] | 6/7 | [date-time](../02-domains/data/date-time.md) |
| Precision | BigDecimal (monnaie) | [STANDARD] | 5/7 | [numeric-precision](../02-domains/data/numeric-precision.md) |

---

## Interdependances validees

Chaque outil est compatible avec les autres dans ce profil (verifie via docs officielles) :

```
Spring Boot → JUnit 5 + AssertJ + Mockito (spring-boot-starter-test)
Spring Boot → Logback JSON (logging.structured.format.console=ecs)
Spring Boot → Argon2PasswordEncoder (spring-security-crypto)
Spring Boot → HikariCP (defaut DataSource)
Spring Boot → Flyway (spring-boot-starter-data-jpa)
Spring Boot → Testcontainers (@ServiceConnection depuis 3.1)
Spring Boot → Resilience4j (spring-cloud-circuitbreaker)
Spring Boot → RFC 9457 ProblemDetail (spring.mvc.problemdetails.enabled=true)
Vite → Vitest (vite.config.ts partage)
Vite → React 19 + TypeScript (natif)
Vite → Tailwind CSS 4 (natif)
React → shadcn/ui (Radix + Tailwind)
React → React Hook Form + Zod
React → react-i18next
ESLint → eslint-plugin-react-hooks (React recommande)
ESLint → eslint-config-prettier (React recommande)
Docker → Spring Boot layered JARs (Dockerfile multi-stage)
GitHub Actions → Docker + SonarQube + Dependabot (natif)
PostgreSQL → Flyway + Testcontainers + pg_dump/WAL
```

---

## Methode

Ce profil est derive de la [matrice ISO 25010 x SWEBOK](../../matrix.md) (159 cases actives → 45 pages de recommandations). Chaque score GRADE est calcule mecaniquement via la [methodologie EBSE](../../methodology.md). Aucune recommandation n'est inventee — toutes sont sourcees et verifiables.
