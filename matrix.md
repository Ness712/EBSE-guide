# Matrice ISO 25010:2023 x SWEBOK v4

**Date** : 2026-04
**Methode** : double extraction (2 reviewers IA independants)
**Reviewer A** : 114 cases actives / **Reviewer B** : 173 cases actives
**Resultat apres reconciliation** : voir ci-dessous

## KAs retenus (13)

| # | Knowledge Area | Justification |
|---|---|---|
| 1 | Software Requirements | Decisions d'elicitation, format, tracabilite |
| 2 | Software Architecture | Decisions structurelles majeures |
| 3 | Software Design | Decisions de conception UI/API/patterns |
| 4 | Software Construction | Decisions de codage, outils, config |
| 5 | Software Testing | Decisions de strategie et outils de test |
| 6 | Software Engineering Operations | Decisions de deploiement, monitoring, ops |
| 7 | Software Maintenance | Decisions de mise a jour, migration |
| 8 | Software Configuration Management | Decisions de versioning, branching, CI/CD |
| 9 | Software Engineering Management | Decisions de SLO, planification maintenance |
| 12 | Software Quality | Decisions de quality gates, metriques |
| 13 | Software Security | Decisions de securite specifiques |
| 16 | Computing Foundations | Decisions d'algo, structures de donnees, precision |

## KAs exclus (6)

| # | Knowledge Area | Raison |
|---|---|---|
| 10 | SE Process | Processus organisationnel, pas de decision technique concrete |
| 11 | SE Models and Methods | Methodes formelles, pas d'outil concret pour web app |
| 14 | SE Professional Practice | Ethique, deontologie — pas de decision technique |
| 15 | SE Economics | Analyse cout/benefice — pas de decision technique |
| 17 | Mathematical Foundations | Theorie pure, pas de decision concrete |
| 18 | Engineering Foundations | Theorie pure, pas de decision concrete |

## Matrice consolidee

### 1. FUNCTIONAL SUITABILITY

#### Functional Completeness

| KA | Decision(s) | Accord |
|---|---|---|
| Requirements | Format des requirements (user stories, acceptance criteria), outil de tracabilite (Jira, GitHub Issues) | A+B |
| Architecture | Decoupage en modules/services pour couvrir tous les domaines fonctionnels | B seul |
| Design | Contrats API qui exposent toutes les operations requises | B seul |
| Testing | Outil de test d'acceptance (Playwright, Cypress), tracabilite requirements-tests | A+B |
| Quality | Definition de "done", quality gates pour completude fonctionnelle | A+B |

#### Functional Correctness

| KA | Decision(s) | Accord |
|---|---|---|
| Design | Strategie de validation (ou valider, quelle lib: Zod, Bean Validation), representation des erreurs | A+B |
| Construction | Strictness TypeScript, regles linting pour correctness, null safety (Optional, nullish coalescing) | A+B |
| Testing | Framework de test unitaire (JUnit, Vitest), assertion lib, mutation testing (PIT, Stryker) | A+B |
| Quality | Process de code review, quality gates dans CI | B seul |
| Computing Foundations | Precision floating-point (BigDecimal pour monnaie), encoding (UTF-8), date/time (java.time, dayjs) | A+B |

#### Functional Appropriateness

| KA | Decision(s) | Accord |
|---|---|---|
| Requirements | Priorisation (MoSCoW, RICE), prototypage, validation avec utilisateurs | A+B |
| Design | Style API (CRUD vs task-based), patterns UX (wizard vs formulaire, pagination vs infinite scroll) | A+B |
| Testing | Usability testing, A/B testing infra (PostHog, Unleash) | B seul |

### 2. PERFORMANCE EFFICIENCY

#### Time Behaviour

| KA | Decision(s) | Accord |
|---|---|---|
| Architecture | Caching (Redis, CDN), async (message queue), SSR/CSR/SSG, connection pooling (HikariCP) | A+B |
| Design | Query optimization, pagination (offset vs cursor), data fetching (React Query), debounce/throttle | A+B |
| Construction | Bundle optimization (tree shaking, code splitting, Vite), images (WebP/AVIF), compression (gzip/brotli) | A+B |
| Testing | Performance testing (k6, Lighthouse CI), performance budgets dans CI | A+B |
| Operations | APM (Prometheus+Grafana, Datadog), CDN config, cache headers | A+B |
| Computing Foundations | Complexite algorithmique, choix data structures, concurrence (virtual threads, event loop) | A+B |

#### Resource Utilization

| KA | Decision(s) | Accord |
|---|---|---|
| Architecture | JVM config (heap, GC: G1 vs ZGC), container resource limits (Docker/K8s) | A+B |
| Design | Stream vs batch, lazy init, pagination pour grands datasets | B seul |
| Construction | Prevention memory leaks (cleanup useEffect, AbortController), serialization (JSON vs Protobuf) | A+B |
| Operations | Dashboards ressources (Grafana), alerting CPU/memoire, log rotation | A+B |
| Computing Foundations | Modele memoire (stack vs heap), tuning GC, thread pool sizing | B seul |

#### Capacity

| KA | Decision(s) | Accord |
|---|---|---|
| Architecture | Horizontal vs vertical scaling, sharding, rate limiting (bucket4j), load balancer | A+B |
| Design | Bulk operations, file upload limits, chunked upload, connection pool sizing | B seul |
| Testing | Stress testing (k6, Gatling), capacity planning | A+B |
| Operations | Auto-scaling rules, DB capacity monitoring, storage alerts | A+B |

### 3. COMPATIBILITY

#### Co-existence

| KA | Decision(s) | Accord |
|---|---|---|
| Architecture | Docker networking, port mapping, schema isolation | A+B |
| Operations | Docker Compose/orchestration, reverse proxy (Nginx/Traefik) | A+B |
| Config Management | Namespacing env vars, config isolation | B seul |

#### Interoperability

| KA | Decision(s) | Accord |
|---|---|---|
| Architecture | Protocole API (REST/GraphQL/gRPC), format (JSON, Protobuf), versioning API | A+B |
| Design | OpenAPI/Swagger, webhook payloads, CORS config | A+B |
| Construction | HTTP client (Axios, fetch, WebClient), serialization config (Jackson), CORS | A+B |
| Testing | Contract testing (Pact, Spring Cloud Contract), mock server (WireMock, MSW) | A+B |
| Config Management | Versioning des contrats API, gestion credentials externes | B seul |

### 4. INTERACTION CAPABILITY

#### Appropriateness Recognizability

| KA | Decision(s) | Accord |
|---|---|---|
| Design | Navigation pattern (sidebar, top-nav), info architecture, onboarding | A+B |
| Construction | Component library (shadcn/ui, Radix), icon library (Lucide), meta tags/OpenGraph | B seul |

#### Learnability

| KA | Decision(s) | Accord |
|---|---|---|
| Design | Progressive disclosure, tooltip/tour lib (Shepherd.js), design system conventions | A+B |
| Construction | i18n framework (react-i18next), help components, command palette | A+B |

#### Operability

| KA | Decision(s) | Accord |
|---|---|---|
| Design | Form patterns, keyboard navigation, responsive breakpoints, touch targets | A+B |
| Construction | CSS framework (Tailwind), form lib (React Hook Form), state management (Zustand) | A+B |
| Testing | E2E testing workflows (Playwright), cross-browser, responsiveness | B seul |

#### User Error Protection

| KA | Decision(s) | Accord |
|---|---|---|
| Design | Confirmation dialogs, undo/redo, auto-save, input constraints (masks, dropdowns) | A+B |
| Construction | Validation timing (real-time vs on-submit), optimistic UI, double-submit prevention | A+B |

#### User Engagement

| KA | Decision(s) | Accord |
|---|---|---|
| Design | Notifications (in-app, push, email), real-time (WebSocket vs SSE), loading states (skeletons) | A+B |
| Construction | WebSocket lib (SockJS, Socket.IO), animation lib (Framer Motion), PWA config | A+B |

#### Inclusivity

| KA | Decision(s) | Accord |
|---|---|---|
| Design | Niveau WCAG (AA vs AAA), contraste couleurs, semantic HTML, i18n architecture | A+B |
| Construction | i18n lib, accessibility tools (axe-core, jsx-a11y), ARIA, reduced-motion | A+B |
| Testing | Tests accessibilite dans CI (axe-core), screen reader testing | A+B |

#### User Assistance

| KA | Decision(s) | Accord |
|---|---|---|
| Design | Systeme d'aide (tooltips, FAQ, help center), strategie messages d'erreur, recherche | A+B |
| Construction | Search impl (MeiliSearch, Algolia), Error Boundaries React, toast/notifications | A+B |

#### Self-descriptiveness

| KA | Decision(s) | Accord |
|---|---|---|
| Design | URL design, breadcrumbs, status indicators, empty states, data viz | A+B |
| Construction | Chart lib (Recharts, Chart.js), skeleton components, routing (React Router) | A+B |

### 5. RELIABILITY

#### Faultlessness

| KA | Decision(s) | Accord |
|---|---|---|
| Design | Error handling strategy, defensive patterns, invariant enforcement | A+B |
| Construction | Static analysis (SonarQube, ESLint strict), null safety, exception hierarchy | A+B |
| Testing | Coverage tool + seuil (JaCoCo >=80%, Istanbul), mutation testing, quality gates CI | A+B |
| Quality | Quality gates SonarQube (zero new bugs, coverage threshold), code review checklist | A+B |

#### Availability

| KA | Decision(s) | Accord |
|---|---|---|
| Architecture | Redundance (multi-instance, replication DB), health checks, load balancer | A+B |
| Operations | Uptime monitoring (UptimeRobot, Prometheus blackbox), zero-downtime deploy, on-call (PagerDuty) | A+B |
| Management | SLA/SLO definition, maintenance windows, incident response process | A+B |
| Maintenance | Maintenance windows, DB migration sans downtime (Flyway backward-compatible) | B seul |

#### Fault Tolerance

| KA | Decision(s) | Accord |
|---|---|---|
| Architecture | Circuit breaker (Resilience4j), retry + backoff, fallback/degradation, bulkhead | A+B |
| Design | Graceful degradation UI, timeout strategy, dead letter queue | B seul |
| Construction | Retry lib (Resilience4j, axios-retry), timeout config, offline capability (service worker) | A+B |
| Operations | Alerting error rates, graceful shutdown config, rolling deploy zero-downtime | A+B |

#### Recoverability

| KA | Decision(s) | Accord |
|---|---|---|
| Architecture | Backup strategy, disaster recovery (RPO/RTO), data replication | A+B |
| Design | Transaction management (saga), idempotency keys, checkpoint/resume | B seul |
| Operations | Backup automation (pg_dump cron), restore testing, point-in-time recovery, rollback | A+B |
| Config Management | Infrastructure as Code (Docker Compose, Terraform), migration versioning (Flyway) | A+B |

### 6. SECURITY

#### Confidentiality

| KA | Decision(s) | Accord |
|---|---|---|
| Architecture | Encryption at-rest/in-transit, secrets management (Vault, env vars), PII segregation | A+B |
| Design | Field-level encryption, PII handling, data masking, session storage (httpOnly cookies) | B seul |
| Construction | HTTPS/HSTS, .env exclusion git, secure cookies (HttpOnly, Secure, SameSite), log sanitization | A+B |
| Testing | SAST (SonarQube, Snyk), DAST (OWASP ZAP), secrets scanning (GitLeaks) | B seul |
| Operations | TLS cert management (Let's Encrypt), network security, backup encryption | B seul |
| Config Management | Never commit secrets, .gitignore strategy, encrypted config per environment | B seul |
| Security | Encryption standards (AES-256), password hashing (Argon2id), key rotation | A+B |

#### Integrity

| KA | Decision(s) | Accord |
|---|---|---|
| Design | Input validation (whitelist), CSRF protection, DB constraints (FK, unique, check) | A+B |
| Construction | SQL injection prevention (JPA, parameterized), XSS prevention (CSP, DOMPurify) | A+B |
| Testing | Security scanning (OWASP ZAP), dependency vulnerability scanning (Dependabot) | A+B |
| Security | CSP config, Subresource Integrity, HTTP security headers (Helmet.js) | A+B |

#### Non-repudiation

| KA | Decision(s) | Accord |
|---|---|---|
| Design | Audit log schema (who, what, when, where), immutable logs, digital signatures | A+B |
| Construction | Structured audit logging (SLF4J, Winston), correlation IDs, timestamps UTC | A+B |
| Operations | Log aggregation + retention (ELK, Loki), log immutability | A+B |
| Security | Log integrity protection, timestamp authority | B seul |

#### Accountability

| KA | Decision(s) | Accord |
|---|---|---|
| Design | User action tracking, admin logging, role-based audit trails | A+B |
| Construction | Audit trail middleware, request logging with user identity, centralized logging | A+B |
| Operations | Log aggregation, anomaly detection, compliance reporting | A+B |

#### Authenticity

| KA | Decision(s) | Accord |
|---|---|---|
| Architecture | Auth architecture (session vs JWT vs OAuth2), identity provider (Auth0, Keycloak) | A+B |
| Design | Token lifecycle (access/refresh), MFA design, password policy, session management | B seul |
| Construction | Auth framework (Spring Security, Passport.js), password hashing (Argon2id), JWT config | A+B |
| Testing | Auth bypass testing, token expiration testing | B seul |
| Security | Credential storage, brute-force protection, rate limiting login, secure password reset | A+B |

#### Resistance

| KA | Decision(s) | Accord |
|---|---|---|
| Architecture | WAF (Cloudflare), DDoS mitigation, network segmentation | A+B |
| Design | Rate limiting design (per-user/IP/endpoint), CAPTCHA, bot detection, input size limits | B seul |
| Construction | Rate limiting lib (bucket4j, express-rate-limit), header hardening, dependency scanning | A+B |
| Operations | WAF management, intrusion detection (fail2ban), security alerting, patch management | A+B |
| Security | Threat modeling (STRIDE), penetration testing, security hardening checklist | A+B |

### 7. MAINTAINABILITY

#### Modularity

| KA | Decision(s) | Accord |
|---|---|---|
| Architecture | Package structure (feature-based vs layer), monorepo vs polyrepo, module boundaries, dependency rules | A+B |
| Design | Component decomposition (atomic design), DI framework, interface segregation | A+B |
| Construction | Module organization (ESM), barrel files, boundary enforcement (ArchUnit, eslint-plugin-boundaries) | A+B |
| Maintenance | Impact analysis, dependency visualization, breaking change management | B seul |

#### Reusability

| KA | Decision(s) | Accord |
|---|---|---|
| Design | Shared component library, utility organization, composition vs inheritance, custom hooks | A+B |
| Construction | Shared packages (npm workspace, Maven modules), generic components, shared types | A+B |
| Config Management | Shared library versioning, artifact repository (GitHub Packages, npm) | B seul |

#### Analysability

| KA | Decision(s) | Accord |
|---|---|---|
| Design | Logging strategy (niveaux, structured), observability (traces, metrics, logs) | B seul |
| Construction | Logging lib (SLF4J, Pino), distributed tracing (OpenTelemetry), error tracking (Sentry) | A+B |
| Operations | Log aggregation (ELK, Loki+Grafana), APM, dashboards, alerting | A+B |
| Maintenance | Debugging tooling, root cause analysis process | B seul |
| Quality | Complexity metrics (SonarQube), code smell detection, technical debt tracking | A+B |

#### Modifiability

| KA | Decision(s) | Accord |
|---|---|---|
| Architecture | Patterns pour changement (ports-adapters, CQRS), abstraction layers, event-driven | A+B |
| Design | Design patterns extensibles (strategy, observer), ORM vs raw SQL, CSS architecture (Tailwind vs BEM) | A+B |
| Construction | Formatter (Prettier, google-java-format), linting strictness, naming conventions | A+B |
| Maintenance | Strategie refactoring, gestion dette technique, deprecation/migration | A+B |
| Config Management | Branching strategy (GitFlow, trunk-based), merge strategy, code review process | B seul |

#### Testability

| KA | Decision(s) | Accord |
|---|---|---|
| Architecture | DI pour testability, test DB strategy (H2 vs Testcontainers), test environment | A+B |
| Design | Pure functions, side-effect isolation, mockability (repository pattern) | A+B |
| Construction | Test framework (JUnit, Vitest), mocking lib (Mockito, vi.mock), test data factories | A+B |
| Testing | Test pyramid (ratio unit/integration/E2E), CI pipeline, coverage enforcement, flaky test management | A+B |
| Quality | Test quality metrics (coverage, mutation score), test review, maintenance cost | B seul |

### 8. FLEXIBILITY

#### Adaptability

| KA | Decision(s) | Accord |
|---|---|---|
| Architecture | Config externalization (env vars, feature flags), multi-tenancy, plugin architecture | A+B |
| Design | Feature flag design (granularite, lifecycle), theming, configurable business rules | B seul |
| Construction | Feature flag lib (Unleash, LaunchDarkly), env-specific config, dynamic config loading | A+B |
| Config Management | Config management dev/staging/prod, feature branch strategy, config versioning | B seul |

#### Installability

| KA | Decision(s) | Accord |
|---|---|---|
| Operations | Containerization (Dockerfile multi-stage), CI/CD tool (GitHub Actions), container registry (GHCR) | A+B |
| Config Management | IaC (Docker Compose, Terraform), env config management, setup automation (Makefile) | A+B |

#### Replaceability

| KA | Decision(s) | Accord |
|---|---|---|
| Architecture | Abstraction layers (interfaces), anti-corruption layer, protocoles standard vs vendor-specific | A+B |
| Design | Adapter pattern, repository pattern, vendor-agnostic interfaces (email, storage, payment) | A+B |

#### Scalability

| KA | Decision(s) | Accord |
|---|---|---|
| Architecture | Stateless design (Redis sessions), horizontal scaling, read replicas, cache layer (Redis) | A+B |
| Design | Pagination large datasets, background job processing, eventual consistency | B seul |
| Operations | Auto-scaling (HPA, KEDA), load balancer, connection pool monitoring, capacity planning | A+B |
| Testing | Load tests increasing concurrency, bottleneck identification, production-like data volumes | B seul |
| Computing Foundations | Concurrence model, connection pool algorithm, data structures high-throughput | A seul |

### 9. SAFETY

#### Operational Constraint

| KA | Decision(s) | Accord |
|---|---|---|
| Requirements | Contraintes reglementaires (RGPD, HIPAA), data retention, consentement utilisateur | A seul |
| Design | Input validation boundaries, business rule constraints, confirmation workflows | A+B |
| Construction | RGPD implementation (consent banner, data export, right-to-erasure), cookie consent | A+B |
| Security | Data residency, privacy-by-design, age verification | A seul |

#### Risk Identification

| KA | Decision(s) | Accord |
|---|---|---|
| Design | Error classification (recoverable vs fatal), risk-aware logging | B seul |
| Management | Risk register, risk assessment methodology | A seul |
| Operations | Anomaly detection alerts (trafic, error spikes), security monitoring | B seul |
| Quality | Quality risk analysis, risk-based test prioritization, tech debt risk | A seul |
| Security | Threat modeling (STRIDE), OWASP Top 10 risks, dependency vulnerability monitoring | A+B |

#### Fail Safe

| KA | Decision(s) | Accord |
|---|---|---|
| Architecture | Graceful degradation, safe defaults (deny-by-default), DB transaction rollback | A+B |
| Design | Default-deny authorization, safe default config, graceful shutdown sequences | B seul |
| Construction | Default-deny implementation, safe error responses (pas de stack traces prod), resource cleanup, @Transactional | A+B |
| Operations | Health check failure response (auto restart), deployment rollback triggers, circuit breaker monitoring | A+B |

#### Hazard Warning

| KA | Decision(s) | Accord |
|---|---|---|
| Design | Confirmation UI pour actions destructives, warning data loss, session expiration, unsaved changes | A+B |
| Construction | Confirmation dialog implementation, beforeunload handler, 429 Retry-After | A+B |
| Operations | Alert severity classification, warning thresholds, PagerDuty/OpsGenie integration | B seul |

#### Safe Integration

| KA | Decision(s) | Accord |
|---|---|---|
| Architecture | Third-party sandboxing, API gateway, webhook verification (HMAC) | B seul |
| Design | Input validation external data, timeout + circuit breaker, rollback mechanisms | B seul |
| Testing | Integration tests third-party, smoke tests post-deploy, contract testing | A+B |
| Operations | Blue-green/canary deploy, rollback procedure, dependency health dashboards | A+B |
| Config Management | Dependency version pinning (lockfiles), update review process | A seul |

---

## Statistiques consolidees

| Caracteristique ISO | Cases actives |
|---|---|
| Functional Suitability | 13 |
| Performance Efficiency | 17 |
| Compatibility | 9 |
| Interaction Capability | 21 |
| Reliability | 17 |
| Security | 27 |
| Maintainability | 23 |
| Flexibility | 14 |
| Safety | 18 |
| **TOTAL** | **159** |

**159 cases actives** apres reconciliation des 2 reviewers.
Beaucoup de ces cases partagent des decisions (ex: "Logging lib" apparait dans Analysability, Accountability, Non-repudiation). Le guide regroupera ces decisions en evitant les doublons.
