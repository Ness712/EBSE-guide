# Revue systematique Kitchenham v3.0 — Reliability & Operations (17 decisions)

**Agent** : A | **Date** : 2026-04-14 | **Methode** : EBSE Kitchenham (PICOC, PRISMA, I/E, Q1-Q11, GRADE, sensitivity, pub bias, multi-stack)

---

# PARTIE I — RELIABILITY (8 decisions)

---

## Decision 1 — Error Handling (RFC 9457 Problem Details)

**PICOC** : P=API REST multi-stack | I=RFC 9457 (Problem Details) | C=custom error JSON, GraphQL errors, gRPC status codes | O=interoperabilite, debuggabilite, coherence client | C=API publique/interne, multi-consommateurs

**PRISMA** : Sources : IETF, Spring Boot docs, Zalando guidelines, NestJS docs, DRF docs | Trouves=9 | Filtres (I1 post-2020, E1 blogs perso)=7 | Inclus=5

| # | Source | URL | Pyramide | Annee | Data point | CoI |
|---|--------|-----|----------|-------|------------|-----|
| S1 | RFC 9457 (IETF) | https://www.rfc-editor.org/rfc/rfc9457.html | 1-Standard | 2023 | Remplace RFC 7807, application/problem+json, adopte par Spring Boot 3+, ASP.NET 7+ | Aucun |
| S2 | Spring Boot 3.x docs | https://docs.spring.io/spring-boot/reference/web/servlet.html#web.servlet.spring-mvc.error-handling | 1-Doc officielle | 2025 | ProblemDetail natif via ErrorResponse, @ControllerAdvice auto-mapping | Pivotal |
| S3 | Zalando RESTful Guidelines | https://opensource.zalando.com/restful-api-guidelines/ | 3-Guide industrie | 2024 | "MUST use Problem JSON" (rule #176), 100+ equipes Zalando | Zalando |
| S4 | NestJS exception filters | https://docs.nestjs.com/exception-filters | 1-Doc officielle | 2025 | HttpException + ExceptionFilter, pas de RFC 9457 natif mais mappable | Aucun |
| S5 | Django REST Framework | https://www.django-rest-framework.org/api-guide/exceptions/ | 1-Doc officielle | 2025 | custom_exception_handler(), libs tierces (drf-problems) pour RFC 9457 | Aucun |

**Qualite** (Q1-Q11) : S1=10.5 S2=9.0 S3=8.0 S4=8.5 S5=8.0 — Moyenne=8.8/11

**GRADE** : Depart HAUTE (1 RFC IETF standard) | -0 incoherence | -0 indirectness | = **STANDARD**
Sensibilite : retrait S1 (RFC) → pas de standard normatif, tombe a BONNE_PRATIQUE. Reco fragile sans RFC.
Biais publication : aucun (RFC = processus ouvert IETF multi-parties).

**Variantes** : Java→ProblemDetail natif (Spring Boot 3+) | TS→HttpException + filter mappant RFC 9457 | Python→drf-standardized-errors ou custom handler

**Recommandation** : **RFC 9457 (Problem Details)** | GRADE=STANDARD
> Standard IETF adopte nativement par Spring Boot 3+. Chaque stack implemente via son handler d'exceptions (@ControllerAdvice, ExceptionFilter, custom_exception_handler).

---

## Decision 2 — Circuit Breaker (Resilience4j / opossum / pybreaker)

**PICOC** : P=microservices/monolithe avec appels externes | I=Resilience4j (Java) | C=Hystrix (deprecated), opossum (Node.js), pybreaker (Python), Polly (.NET) | O=resilience, latence, cascading failure prevention | C=appels HTTP/DB externes, Spring Boot + options multi-stack

**PRISMA** : Sources : Resilience4j docs, Spring Cloud Circuit Breaker, npm opossum, GitHub stats | Trouves=10 | Filtres=7 | Inclus=5

| # | Source | URL | Pyramide | Annee | Data point | CoI |
|---|--------|-----|----------|-------|------------|-----|
| S1 | Resilience4j docs | https://resilience4j.readme.io/docs/circuitbreaker | 1-Doc officielle | 2025 | FSM 3 etats (CLOSED/OPEN/HALF_OPEN), sliding window, v3 requiert Java 21 | Aucun |
| S2 | Spring Cloud Circuit Breaker | https://docs.spring.io/spring-cloud-circuitbreaker/reference/spring-cloud-circuitbreaker-resilience4j.html | 1-Doc officielle | 2025 | Integration native Spring Boot, auto-config via starters | Pivotal |
| S3 | GitHub resilience4j | https://github.com/resilience4j/resilience4j | 3-Donnees adoption | 2025 | 9.8k stars, successeur officiel de Hystrix (Netflix, deprecated 2018) | Aucun |
| S4 | npm opossum | https://www.npmjs.com/package/opossum | 3-Donnees adoption | 2025 | 1.5k+ stars, v9.0, 196 dependants, Red Hat maintenu | Red Hat |
| S5 | Martin Fowler - Circuit Breaker | https://martinfowler.com/bliki/CircuitBreaker.html | 4-Expert opinion | 2014 | Pattern canonique : detect, open, half-open, close. Reference industrie | Aucun |

**Qualite** : S1=9.5 S2=9.0 S3=7.0 S4=7.0 S5=8.5 — Moyenne=8.2/11

**GRADE** : Depart HAUTE (pattern etabli + docs officielles) | -0 | = **STANDARD**
Sensibilite : retrait S5 (Fowler) → pattern reste documente dans S1/S2. Retrait Resilience4j → Hystrix deprecated, pas d'alternative Java mature. Reco stable.
Biais : S4 maintenu par Red Hat (interesse) mais corrobore par stars/dependants independants.

**Variantes** : Java→Resilience4j 3.x (Java 21) | TS→opossum 9.x (Red Hat) | Python→pybreaker | .NET→Polly

**Recommandation** : **Resilience4j** (Java) / **opossum** (Node.js) | GRADE=STANDARD
> Pattern circuit breaker canonique (Fowler). Resilience4j = successeur Hystrix, integration native Spring Cloud. opossum = reference Node.js (Red Hat).

---

## Decision 3 — Backup (pg_dump + WAL archiving + pgBackRest)

**PICOC** : P=base PostgreSQL production | I=pg_dump + WAL archiving | C=pg_basebackup seul, Barman, WAL-G, replicas seuls | O=RPO minimal, PITR, fiabilite restauration | C=PostgreSQL 16+, VPS unique, donnees critiques (utilisateurs, cours, quiz)

**PRISMA** : Sources : PostgreSQL docs, Percona blog, pgBackRest docs, dev.to comparatif | Trouves=11 | Filtres=8 | Inclus=5

| # | Source | URL | Pyramide | Annee | Data point | CoI |
|---|--------|-----|----------|-------|------------|-----|
| S1 | PostgreSQL PITR docs | https://www.postgresql.org/docs/current/continuous-archiving.html | 1-Doc officielle | 2025 | pg_basebackup + WAL archiving = PITR, restore a n'importe quel point dans le temps | Aucun |
| S2 | Percona PG backup strategy | https://www.percona.com/blog/postgresql-backup-strategy-enterprise-grade-environment/ | 3-Guide industrie | 2024 | pgBackRest = gold standard, incremental, parallel, compression, verification | Percona |
| S3 | pgBackRest docs | https://pgbackrest.org/ | 1-Doc officielle | 2025 | Full/differential/incremental, parallel backup/restore, cloud storage (S3/GCS) | Aucun |
| S4 | Top 5 PG backup tools 2025 | https://dev.to/rostislav_dugin/top-5-postgresql-backup-tools-in-2025-5801 | 4-Analyse | 2025 | pgBackRest #1, Barman #2, WAL-G #3 (cloud-native), pg_dump pour logical only | Aucun |
| S5 | PostgreSQL pg_dump docs | https://www.postgresql.org/docs/current/app-pgdump.html | 1-Doc officielle | 2025 | Logical backup, cross-version compatible, ne suffit pas pour PITR | Aucun |

**Qualite** : S1=10.0 S2=8.0 S3=9.0 S4=6.5 S5=9.5 — Moyenne=8.6/11

**GRADE** : Depart HAUTE (doc officielle PostgreSQL) | -0 | = **STANDARD**
Sensibilite : retrait S2 (Percona vendor) → pgBackRest reste recommande par S4 et communaute. pg_dump seul = pas de PITR → insuffisant. Reco stable.
Biais : S2 Percona vend du support PG mais recommandation alignee avec docs officielles.

**Variantes** : Toutes stacks→pgBackRest (physique + PITR) + pg_dump (logical, cross-version) | Cloud→WAL-G (S3 natif) | Petit projet→pg_dump cron + WAL archive manuelle

**Recommandation** : **pg_dump (logical) + pgBackRest (PITR)** | GRADE=STANDARD
> pg_dump pour backups logiques portables. pgBackRest pour PITR avec incremental/parallel. WAL archiving obligatoire en production pour RPO proche de zero.

---

## Decision 4 — Monitoring (Prometheus + Grafana)

**PICOC** : P=infrastructure prod (VPS, containers, DB) | I=Prometheus + Grafana | C=Datadog, New Relic, Zabbix, VictoriaMetrics | O=observabilite, cout, extensibilite | C=equipe 2 devs, budget limite, stack self-hosted

**PRISMA** : Sources : Grafana Observability Survey 2025, CNCF, Prometheus docs, Grafana docs | Trouves=12 | Filtres=9 | Inclus=5

| # | Source | URL | Pyramide | Annee | Data point | CoI |
|---|--------|-----|----------|-------|------------|-----|
| S1 | Grafana Observability Survey 2025 | https://grafana.com/observability-survey/2025/ | 2-Enquete | 2025 | 67% utilisent Prometheus en prod, 75% adoption Kubernetes, #1 open-source monitoring | Grafana Labs |
| S2 | CNCF Graduated Project | https://www.cncf.io/projects/prometheus/ | 1-Standard | 2025 | Prometheus = CNCF graduated (meme niveau que Kubernetes), standard de facto cloud-native | Aucun |
| S3 | Prometheus docs | https://prometheus.io/docs/introduction/overview/ | 1-Doc officielle | 2025 | Pull-based, PromQL, multi-dimensional data model, service discovery natif | Aucun |
| S4 | Grafana docs | https://grafana.com/docs/grafana/latest/ | 1-Doc officielle | 2025 | 100+ data sources, alerting integre, dashboards communautaires, LGTM stack | Grafana Labs |
| S5 | Rootly SRE + Prometheus | https://rootly.com/sre/how-sres-use-prometheus-and-grafana-to-crush-mttr-in-2025 | 4-Analyse | 2025 | Prometheus + Grafana = stack SRE standard, reduit MTTR | Aucun |

**Qualite** : S1=8.5 S2=9.5 S3=9.5 S4=9.0 S5=7.0 — Moyenne=8.7/11

**GRADE** : Depart HAUTE (CNCF graduated + enquete large) | -0.5 (S1 = vendor Grafana Labs) | = **STANDARD**
Sensibilite : retrait S1 (vendor survey) → CNCF graduation + docs officielles suffisent. Reco stable.
Biais : S1 et S4 par Grafana Labs, mais CNCF (S2) independant corrobore.

**Variantes** : Self-hosted→Prometheus + Grafana | Cloud→Datadog/New Relic (cout eleve) | Leger→VictoriaMetrics (drop-in Prometheus, moins RAM)

**Recommandation** : **Prometheus + Grafana** | GRADE=STANDARD
> CNCF graduated, 67% adoption prod, standard de facto. PromQL puissant, Grafana 100+ sources. Cout zero (self-hosted) vs Datadog ($15+/host/mois).

---

## Decision 5 — DB Migrations (Flyway / Prisma Migrate / Django migrations)

**PICOC** : P=schema PostgreSQL versionne | I=Flyway | C=Liquibase, Prisma Migrate, Django migrations, Alembic | O=fiabilite migrations, simplicite, integration CI/CD | C=Spring Boot, equipe 2 devs, schema relationnel complexe

**PRISMA** : Sources : Flyway docs, Bytebase comparatif, Baeldung, Spring Boot docs, Prisma docs | Trouves=10 | Filtres=7 | Inclus=5

| # | Source | URL | Pyramide | Annee | Data point | CoI |
|---|--------|-----|----------|-------|------------|-----|
| S1 | Flyway docs | https://documentation.red-gate.com/flyway | 1-Doc officielle | 2025 | SQL-first, versioned migrations (V1__), repeatable (R__), callbacks, flyway.toml (2025) | Redgate |
| S2 | Bytebase Flyway vs Liquibase 2026 | https://www.bytebase.com/blog/flyway-vs-liquibase/ | 4-Analyse | 2026 | Flyway = plus simple, SQL-first. Liquibase = plus flexible (50+ DB), changelog XML/YAML/JSON | Bytebase |
| S3 | Spring Boot Flyway integration | https://docs.spring.io/spring-boot/how-to/data-initialization.html#howto.data-initialization.migration-tool.flyway | 1-Doc officielle | 2025 | Auto-config Flyway via spring.flyway.*, migration au demarrage, baseline-on-migrate | Pivotal |
| S4 | Prisma Migrate docs | https://www.prisma.io/docs/orm/prisma-migrate | 1-Doc officielle | 2025 | Schema-first (schema.prisma → SQL), shadow DB pour drift detection | Prisma |
| S5 | Django migrations docs | https://docs.djangoproject.com/en/5.2/topics/migrations/ | 1-Doc officielle | 2025 | Auto-generated depuis models, squash, RunPython, integration native Django ORM | Aucun |

**Qualite** : S1=9.0 S2=7.0 S3=9.0 S4=8.5 S5=9.0 — Moyenne=8.5/11

**GRADE** : Depart BONNE (pas de standard universel, choix lie au framework) | +0.5 (integration native Spring Boot) | = **BONNE_PRATIQUE**
Sensibilite : retrait S2 → aucun impact (analyse tier). Flyway vs Liquibase = choix de simplicite vs flexibilite. Reco stable pour Spring Boot.
Biais : S1 par Redgate (proprietaire Flyway) mais integration Spring Boot (S3) objective.

**Variantes** : Java/Spring→Flyway (SQL-first, integration native) | TS/Prisma→Prisma Migrate | Python/Django→Django migrations | Python/SQLAlchemy→Alembic

**Recommandation** : **Flyway** (Spring Boot) | GRADE=BONNE_PRATIQUE
> SQL-first, integration native Spring Boot, simple pour equipe 2 devs. Liquibase si 50+ bases ou rollback automatique requis. Chaque framework a son outil natif.

---

## Decision 6 — Graceful Shutdown

**PICOC** : P=application containerisee (Docker/K8s) | I=graceful shutdown natif (SIGTERM + drain) | C=kill -9, pas de gestion, custom signal handler | O=zero downtime deploy, requetes non perdues | C=Spring Boot sur Docker, deploiement continu

**PRISMA** : Sources : Spring Boot docs, Kubernetes docs, Thoughtworks, guides pratiques | Trouves=10 | Filtres=7 | Inclus=5

| # | Source | URL | Pyramide | Annee | Data point | CoI |
|---|--------|-----|----------|-------|------------|-----|
| S1 | Spring Boot graceful shutdown | https://docs.spring.io/spring-boot/reference/web/graceful-shutdown.html | 1-Doc officielle | 2025 | server.shutdown=graceful, spring.lifecycle.timeout-per-shutdown-phase=30s, Tomcat/Netty/Jetty | Pivotal |
| S2 | Kubernetes pod termination | https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle/#pod-termination | 1-Doc officielle | 2025 | SIGTERM → preStop hook → terminationGracePeriodSeconds (defaut 30s) | Aucun |
| S3 | Thoughtworks graceful shutdown K8s | https://www.thoughtworks.com/insights/blog/cloud/shutdown-services-kubernetes | 3-Guide industrie | 2024 | preStop hook + endpoint deregistration + drain connections, timing critique | Aucun |
| S4 | NestJS shutdown hooks | https://docs.nestjs.com/fundamentals/lifecycle-events#application-shutdown | 1-Doc officielle | 2025 | app.enableShutdownHooks(), onModuleDestroy(), beforeApplicationShutdown() | Aucun |
| S5 | Node.js process signals | https://nodejs.org/api/process.html#signal-events | 1-Doc officielle | 2025 | process.on('SIGTERM'), server.close() pour drainer connections HTTP | Aucun |

**Qualite** : S1=9.5 S2=10.0 S3=8.0 S4=8.5 S5=9.0 — Moyenne=9.0/11

**GRADE** : Depart HAUTE (docs officielles Spring + Kubernetes) | -0 | = **STANDARD**
Sensibilite : retrait S3 (Thoughtworks) → docs officielles suffisent. Pattern identique tous frameworks. Reco stable.
Biais : aucun (docs officielles multi-editeurs).

**Variantes** : Java→server.shutdown=graceful (Spring Boot natif) | TS→app.enableShutdownHooks() + process.on('SIGTERM') | Python→signal.signal(SIGTERM) + uvicorn --timeout-graceful-shutdown | Docker→STOPSIGNAL SIGTERM + healthcheck

**Recommandation** : **Graceful shutdown natif** | GRADE=STANDARD
> Spring Boot : server.shutdown=graceful + timeout 30s. K8s : preStop hook + terminationGracePeriodSeconds > timeout app. Pattern universel, toujours activer en prod.

---

## Decision 7 — High Availability (HA)

**PICOC** : P=application web prod sur VPS unique | I=Docker restart policies + health checks | C=Kubernetes HA, HAProxy+Keepalived, replicas multi-nodes | O=uptime, failover automatique, complexite acceptable | C=equipe 2 devs, VPS unique, budget limite

**PRISMA** : Sources : Docker docs, Kubernetes HA, PostgreSQL streaming replication, HAProxy docs | Trouves=10 | Filtres=7 | Inclus=5

| # | Source | URL | Pyramide | Annee | Data point | CoI |
|---|--------|-----|----------|-------|------------|-----|
| S1 | Docker restart policies | https://docs.docker.com/engine/containers/start-containers-automatically/ | 1-Doc officielle | 2025 | restart: unless-stopped/always, redemarrage auto apres crash, suffisant VPS unique | Aucun |
| S2 | Docker healthcheck | https://docs.docker.com/reference/dockerfile/#healthcheck | 1-Doc officielle | 2025 | HEALTHCHECK CMD curl -f http://localhost:8080/actuator/health, restart si unhealthy | Aucun |
| S3 | PostgreSQL streaming replication | https://www.postgresql.org/docs/current/warm-standby.html | 1-Doc officielle | 2025 | Primary/standby async, promotion automatique possible avec Patroni | Aucun |
| S4 | Kubernetes HA considerations | https://github.com/kubernetes/kubeadm/blob/main/docs/ha-considerations.md | 1-Doc officielle | 2025 | Multi-control-plane + HAProxy/Keepalived ou kube-vip pour VIP failover | Aucun |
| S5 | Google SRE Book - Embracing Risk | https://sre.google/sre-book/embracing-risk/ | 4-Expert opinion | 2016 | Cout de HA exponentiel, choisir le niveau adapte au business (99.9% vs 99.99%) | Aucun |

**Qualite** : S1=9.0 S2=9.0 S3=9.5 S4=8.5 S5=8.5 — Moyenne=8.9/11

**GRADE** : Depart BONNE (pas de standard unique, depend du contexte) | +0 | = **BONNE_PRATIQUE**
Sensibilite : VPS unique = Docker restart + healthcheck suffisant. Multi-node → K8s ou HAProxy. Reco conditionnelle au contexte.
Biais : aucun (docs officielles multi-editeurs).

**Variantes** : VPS unique→Docker restart:unless-stopped + healthcheck | Multi-node→K8s ou Docker Swarm | DB→streaming replication + Patroni | Budget→Cloudflare Tunnel + failover DNS

**Recommandation** : **Docker restart + healthcheck** (VPS unique) | GRADE=BONNE_PRATIQUE
> Pour VPS unique : restart:unless-stopped + HEALTHCHECK. Evolution vers K8s ou replicas quand le besoin justifie la complexite. HA = proportionnel au cout business du downtime.

---

## Decision 8 — Transactions (ACID + @Transactional)

**PICOC** : P=operations multi-tables dans un monolithe | I=@Transactional (Spring) | C=saga pattern, 2PC, transactions manuelles, event sourcing | O=integrite donnees, simplicite, performance | C=monolithe Spring Boot, PostgreSQL, pas de microservices distribues

**PRISMA** : Sources : Spring docs, PostgreSQL docs, Baeldung, microservices.io saga | Trouves=10 | Filtres=7 | Inclus=5

| # | Source | URL | Pyramide | Annee | Data point | CoI |
|---|--------|-----|----------|-------|------------|-----|
| S1 | Spring @Transactional docs | https://docs.spring.io/spring-framework/reference/data-access/transaction/declarative/annotations.html | 1-Doc officielle | 2025 | @Transactional sur service layer, propagation REQUIRED par defaut, rollback sur RuntimeException | Pivotal |
| S2 | PostgreSQL transactions docs | https://www.postgresql.org/docs/current/tutorial-transactions.html | 1-Doc officielle | 2025 | BEGIN/COMMIT/ROLLBACK, MVCC, isolation levels (READ COMMITTED defaut), SERIALIZABLE | Aucun |
| S3 | Baeldung @Transactional guide | https://www.baeldung.com/transaction-configuration-with-jpa-and-spring | 3-Guide pratique | 2025 | readOnly=true pour queries, isolation level, rollbackFor, best practices proxy-based | Aucun |
| S4 | microservices.io Saga pattern | https://microservices.io/patterns/data/saga.html | 3-Guide industrie | 2024 | Saga pour transactions distribuees, compensating transactions, orchestration vs choreography | Aucun |
| S5 | Vlad Mihalcea JPA transactions | https://vladmihalcea.com/a-beginners-guide-to-transaction-isolation-levels-in-enterprise-java/ | 4-Expert opinion | 2023 | READ COMMITTED optimal pour OLTP, SERIALIZABLE pour conflits critiques, eviter REPEATABLE READ sur PG | Aucun |

**Qualite** : S1=9.5 S2=10.0 S3=7.5 S4=8.0 S5=8.0 — Moyenne=8.6/11

**GRADE** : Depart HAUTE (standard ACID + docs officielles) | -0 | = **STANDARD**
Sensibilite : retrait S5 (expert) → docs officielles suffisent. Saga non pertinent en monolithe. Reco stable.
Biais : aucun (pattern ACID = fondamental SGBD).

**Variantes** : Java→@Transactional (Spring) | TS→Prisma.$transaction() ou TypeORM QueryRunner | Python→Django @transaction.atomic | Distribue→Saga (orchestration + Temporal)

**Recommandation** : **@Transactional (Spring)** | GRADE=STANDARD
> @Transactional sur couche service, propagation REQUIRED, rollbackFor=Exception.class. READ COMMITTED par defaut (PostgreSQL). Saga uniquement si migration vers microservices distribues.

---

# PARTIE II — OPERATIONS (9 decisions)

---

## Decision 9 — Logging (JSON structure)

**PICOC** : P=application multi-container prod | I=JSON structured logging | C=plain text logs, syslog, custom formats | O=parsabilite, correlation, aggregation efficace | C=stack Docker, Loki/ELK possible, multi-services

**PRISMA** : Sources : Uptrace guide, structlog docs, OpenObserve blog, Grafana Loki docs | Trouves=10 | Filtres=7 | Inclus=5

| # | Source | URL | Pyramide | Annee | Data point | CoI |
|---|--------|-----|----------|-------|------------|-----|
| S1 | Uptrace structured logging guide | https://uptrace.dev/glossary/structured-logging | 3-Guide industrie | 2025 | JSON = choix par defaut, supporte par tous les agregateurs (Loki, ELK, Datadog) | Uptrace |
| S2 | Logback JSON encoder (Spring) | https://logback.qos.ch/manual/encoders.html | 1-Doc officielle | 2025 | JsonEncoder natif Logback 1.5+, champs custom via MDC (traceId, userId) | Aucun |
| S3 | Grafana Loki docs | https://grafana.com/docs/loki/latest/ | 1-Doc officielle | 2025 | JSON parsing natif, label extraction, LogQL pour queries structurees | Grafana Labs |
| S4 | structlog (Python) docs | https://www.structlog.org/en/stable/logging-best-practices.html | 1-Doc officielle | 2025 | JSON renderer, processors pipeline, OTel integration (trace_id auto) | Aucun |
| S5 | OpenObserve structured logging | https://openobserve.ai/blog/structured-logging-best-practices/ | 3-Guide industrie | 2025 | Champs obligatoires : timestamp ISO8601 UTC, level, service, traceId, message | OpenObserve |

**Qualite** : S1=7.5 S2=9.0 S3=9.0 S4=9.0 S5=7.0 — Moyenne=8.3/11

**GRADE** : Depart BONNE (consensus industrie, pas de standard formel) | +0.5 (adoption unanime) | = **STANDARD**
Sensibilite : retrait S1 ou S5 (vendors) → docs Logback + Loki suffisent. JSON = consensus universel. Reco stable.
Biais : S1 et S5 vendors mais alignes avec docs officielles independantes.

**Variantes** : Java→Logback JsonEncoder + MDC (traceId) | TS→pino (JSON par defaut) | Python→structlog + JSON renderer | Champs→timestamp, level, service, traceId, userId, message

**Recommandation** : **JSON structured logging** | GRADE=STANDARD
> JSON par defaut, parsable par tous les agregateurs. Champs obligatoires : timestamp (ISO8601), level, service, traceId, message. Logback JsonEncoder pour Spring Boot, pino pour Node.js.

---

## Decision 10 — Error Tracking (Sentry / GlitchTip)

**PICOC** : P=application prod multi-stack | I=GlitchTip (self-hosted) | C=Sentry SaaS, Sentry self-hosted, Bugsnag, Rollbar | O=cout, simplicite self-hosted, SDK compatibilite | C=equipe 2 devs, budget limite, VPS unique

**PRISMA** : Sources : GlitchTip docs, Sentry docs, comparatifs 2026, Better Stack review | Trouves=10 | Filtres=7 | Inclus=5

| # | Source | URL | Pyramide | Annee | Data point | CoI |
|---|--------|-----|----------|-------|------------|-----|
| S1 | GlitchTip docs | https://glitchtip.com/documentation | 1-Doc officielle | 2026 | Compatible Sentry SDK, 512MB RAM, Docker single-container, gratuit self-hosted | Aucun |
| S2 | Sentry docs | https://docs.sentry.io/ | 1-Doc officielle | 2025 | SDK 20+ langages, source maps, performance monitoring, replays session | Sentry |
| S3 | GlitchTip vs Sentry comparison | https://earezki.com/ai-news/2026-03-14-glitchtip-vs-sentry/ | 4-Analyse | 2026 | GlitchTip 512MB vs Sentry 1000+ lines Docker Compose, 5-6x moins cher a haut volume | Aucun |
| S4 | Better Stack error tracking 2026 | https://betterstack.com/community/comparisons/error-tracking-tools/ | 4-Analyse | 2026 | GlitchTip = meilleur rapport qualite/prix self-hosted, Sentry = plus complet (features) | Aucun |
| S5 | Sentry alternatives 2026 | https://signoz.io/comparisons/sentry-alternatives/ | 4-Analyse | 2026 | GlitchTip = drop-in replacement Sentry, meme SDKs, ideal petites equipes | SigNoz |

**Qualite** : S1=8.5 S2=9.5 S3=7.0 S4=7.0 S5=6.5 — Moyenne=7.7/11

**GRADE** : Depart BONNE (pas de standard, choix contextuel) | +0 | = **BONNE_PRATIQUE**
Sensibilite : retrait S3-S5 (analyses) → docs officielles S1/S2 suffisent pour comparaison. GlitchTip = viable si budget contraint. Reco stable.
Biais : S5 par SigNoz (concurrent) mais conclusion alignee avec S3/S4.

**Variantes** : Self-hosted budget→GlitchTip | SaaS complet→Sentry | Full observability→SigNoz ou Highlight.io | Tous→Sentry SDK (compatible GlitchTip)

**Recommandation** : **GlitchTip** (self-hosted) | GRADE=BONNE_PRATIQUE
> Compatible Sentry SDK, 512MB RAM, gratuit self-hosted. Ideal petite equipe budget limite. Migration vers Sentry SaaS possible sans changer le code (meme SDK).

---

## Decision 11 — Alerting (Grafana Alerting + Alertmanager)

**PICOC** : P=infrastructure monitoree (Prometheus + Grafana) | I=Grafana Alerting | C=Alertmanager standalone, PagerDuty, Opsgenie, custom scripts | O=detection rapide, routing, deduplication, reduction alert fatigue | C=Prometheus + Grafana deja en place, equipe 2 devs

**PRISMA** : Sources : Grafana Alerting docs, Alertmanager docs, PagerDuty integration, best practices | Trouves=9 | Filtres=6 | Inclus=5

| # | Source | URL | Pyramide | Annee | Data point | CoI |
|---|--------|-----|----------|-------|------------|-----|
| S1 | Grafana Alerting docs | https://grafana.com/docs/grafana/latest/alerting/ | 1-Doc officielle | 2025 | Multi-condition alerts, contact points (Slack, PagerDuty, email), notification policies, silences | Grafana Labs |
| S2 | Prometheus Alertmanager docs | https://prometheus.io/docs/alerting/latest/alertmanager/ | 1-Doc officielle | 2025 | Deduplication, grouping, routing, inhibition, silencing. Integration native Prometheus | Aucun |
| S3 | Grafana + PagerDuty integration | https://grafana.com/docs/grafana/latest/alerting/configure-notifications/manage-contact-points/integrations/pager-duty/ | 1-Doc officielle | 2025 | Contact point PagerDuty natif, integration key, severity mapping | Grafana Labs |
| S4 | PagerDuty incident response guide | https://response.pagerduty.com/ | 3-Guide industrie | 2025 | Escalation policies, on-call rotations, runbooks lies aux alerts | PagerDuty |
| S5 | Grafana alerting best practices | https://grafana.com/docs/grafana/latest/alerting/best-practices/ | 1-Doc officielle | 2025 | Eviter over-alerting, seuils significatifs, tester regulierement, PromQL efficace | Grafana Labs |

**Qualite** : S1=9.5 S2=9.5 S3=8.5 S4=8.0 S5=8.5 — Moyenne=8.8/11

**GRADE** : Depart HAUTE (integration native Prometheus/Grafana) | -0.5 (sources Grafana Labs dominantes) | = **STANDARD**
Sensibilite : retrait S4 (PagerDuty vendor) → Grafana Alerting + Alertmanager autonomes. Reco stable.
Biais : S1/S3/S5 par Grafana Labs mais Alertmanager (S2) CNCF independant.

**Variantes** : Grafana stack→Grafana Alerting (unifie) | Prometheus natif→Alertmanager standalone | Enterprise→PagerDuty/Opsgenie | Budget→Grafana Alerting → Slack/Discord/email

**Recommandation** : **Grafana Alerting** | GRADE=STANDARD
> Unifie avec Prometheus/Grafana deja en place. Contact points Slack/email gratuits. PagerDuty si on-call necessaire. Eviter over-alerting : alerter sur symptomes (latence, erreurs), pas causes (CPU).

---

## Decision 12 — SLOs (Service Level Objectives)

**PICOC** : P=service web en production | I=SLOs bases sur golden signals | C=pas de SLO, SLA contractuel uniquement, metrics ad hoc | O=fiabilite mesuree, error budgets, equilibre feature/stabilite | C=equipe 2 devs, app e-learning, pas de SLA contractuel externe

**PRISMA** : Sources : Google SRE Book, Google SRE Workbook, Grafana SLO feature, incident.io guide | Trouves=9 | Filtres=6 | Inclus=5

| # | Source | URL | Pyramide | Annee | Data point | CoI |
|---|--------|-----|----------|-------|------------|-----|
| S1 | Google SRE Book - SLOs | https://sre.google/sre-book/service-level-objectives/ | 4-Expert opinion | 2016 | SLI = ratio good/total events, SLO = target (ex: 99.9%), error budget = 100% - SLO | Aucun |
| S2 | Google SRE Workbook - Implementing SLOs | https://sre.google/workbook/implementing-slos/ | 4-Expert opinion | 2018 | Max 5 SLOs par service, commencer par availability + latency, revue trimestrielle | Aucun |
| S3 | Google Cloud SRE fundamentals | https://cloud.google.com/blog/products/devops-sre/sre-fundamentals-sli-vs-slo-vs-sla | 3-Guide industrie | 2025 | SLI→SLO→SLA hierarchy, golden signals (latency, traffic, errors, saturation) | Google Cloud |
| S4 | incident.io SLO/SLA guide | https://incident.io/blog/slo-sla-sli | 3-Guide industrie | 2025 | SLO owned by product/CTO, error budget policies, burn rate alerts | Aucun |
| S5 | Grafana SLO feature docs | https://grafana.com/docs/grafana-cloud/alerting-and-irm/slo/ | 1-Doc officielle | 2025 | SLO natif Grafana Cloud, burn rate alerting, multi-window, error budget dashboard | Grafana Labs |

**Qualite** : S1=9.0 S2=9.0 S3=8.0 S4=7.5 S5=8.0 — Moyenne=8.3/11

**GRADE** : Depart BONNE (expert opinion Google SRE, pas de standard formel) | +0.5 (adoption large industrie) | = **BONNE_PRATIQUE**
Sensibilite : retrait S5 (Grafana vendor) → Google SRE books suffisent. Reco stable.
Biais : S3/S5 vendors mais Google SRE books (S1/S2) = reference independante de facto.

**Variantes** : Toutes stacks→meme approche (SLI = ratio, SLO = target) | Monitoring→Grafana SLO ou Prometheus recording rules | Simple→2 SLOs (availability 99.9%, latency p99 < 500ms)

**Recommandation** : **SLOs bases sur golden signals** | GRADE=BONNE_PRATIQUE
> Commencer par 2 SLOs : availability (99.9% = 43min downtime/mois) + latency p99. Error budget = budget d'innovation. Revue trimestrielle. Pas de SLA externe tant que pas de clients payants.

---

## Decision 13 — Uptime Monitoring (Uptime Kuma)

**PICOC** : P=endpoints publics (API, frontend, staging) | I=Uptime Kuma (self-hosted) | C=UptimeRobot, Better Stack, Pingdom, StatusCake | O=cout, simplicite, alerting, status page | C=equipe 2 devs, budget limite, VPS pour self-hosted

**PRISMA** : Sources : Uptime Kuma GitHub, UptimeRobot docs, comparatifs 2026 | Trouves=9 | Filtres=6 | Inclus=5

| # | Source | URL | Pyramide | Annee | Data point | CoI |
|---|--------|-----|----------|-------|------------|-----|
| S1 | Uptime Kuma GitHub | https://github.com/louislam/uptime-kuma | 3-Donnees adoption | 2025 | 65k+ stars, 20s intervals, 100+ notification types, status page integree, Docker one-liner | Aucun |
| S2 | UptimeRobot docs | https://uptimerobot.com/docs/ | 1-Doc officielle | 2025 | Free plan = 50 monitors / 5min, mais commercial-use payant depuis Oct 2024, prix +425% (Jul 2025) | Aucun |
| S3 | SigNoz UptimeRobot alternatives | https://signoz.io/comparisons/uptimerobot-alternatives/ | 4-Analyse | 2026 | Uptime Kuma = meilleur self-hosted, unlimited monitors, zero cout recurrent | SigNoz |
| S4 | Uptime Kuma vs UptimeRobot | https://odown.com/blog/UptimeKuma-vs-UptimeRobot/ | 4-Analyse | 2025 | Uptime Kuma : unlimited monitors, 20s intervals, interne+externe. UptimeRobot : externe only, SaaS | Aucun |
| S5 | Better Stack uptime tools 2026 | https://betterstack.com/community/comparisons/best-uptime-monitoring-tools/ | 4-Analyse | 2026 | Top 11 outils, Uptime Kuma = #1 self-hosted, UptimeRobot = #1 SaaS free (avec restrictions) | Better Stack |

**Qualite** : S1=7.5 S2=8.0 S3=6.5 S4=6.5 S5=7.0 — Moyenne=7.1/11

**GRADE** : Depart BONNE (pas de standard, choix contextuel) | -0.5 (sources surtout analyses tier) | = **BONNE_PRATIQUE**
Sensibilite : retrait S3-S5 → GitHub stars (65k+) et docs suffisent. UptimeRobot viable si SaaS prefere. Reco stable.
Biais : S3 par SigNoz mais conclusion alignee avec tous les comparatifs.

**Variantes** : Self-hosted→Uptime Kuma (gratuit, unlimited) | SaaS gratuit→UptimeRobot (50 monitors, restrictions) | Enterprise→Better Stack, Pingdom, Datadog Synthetics

**Recommandation** : **Uptime Kuma** (self-hosted) | GRADE=BONNE_PRATIQUE
> 65k+ stars, unlimited monitors, 20s intervals, status page integree, Docker one-liner. Zero cout. UptimeRobot si monitoring externe requis (mais restrictions free plan depuis 2024).

---

## Decision 14 — Feature Flags (Unleash)

**PICOC** : P=application avec deploiement continu | I=Unleash (self-hosted) | C=LaunchDarkly, Flagsmith, PostHog, env vars | O=deploiement progressif, A/B testing, kill switch, cout | C=equipe 2 devs, budget limite, VPS pour self-hosted

**PRISMA** : Sources : Unleash docs, LaunchDarkly docs, Amplitude comparatif, WorkOS comparatif | Trouves=10 | Filtres=7 | Inclus=5

| # | Source | URL | Pyramide | Annee | Data point | CoI |
|---|--------|-----|----------|-------|------------|-----|
| S1 | Unleash docs | https://docs.getunleash.io/ | 1-Doc officielle | 2025 | Open source, API-first, activation strategies, SDK 15+ langages, self-hosted gratuit | Unleash |
| S2 | LaunchDarkly docs | https://docs.launchdarkly.com/ | 1-Doc officielle | 2025 | 5500+ clients, 25% Fortune 500, SDK 20+ langages, mais pricing MAU-based (cout eleve) | LaunchDarkly |
| S3 | Amplitude feature flag tools 2026 | https://amplitude.com/compare/best-feature-flag-tools | 4-Analyse | 2026 | Unleash = best open-source, LaunchDarkly = enterprise leader, Flagsmith = alternative OSS | Amplitude |
| S4 | WorkOS feature flag providers 2025 | https://workos.com/blog/the-best-feature-flag-providers-for-apps-in-2025 | 4-Analyse | 2025 | Unleash 4.7/5 G2 (119 reviews), unlimited flags/projects/envs en self-hosted | Aucun |
| S5 | PostHog feature flags | https://posthog.com/docs/feature-flags | 1-Doc officielle | 2025 | Feature flags + analytics integres, open-source, mais plus lourd qu'Unleash seul | PostHog |

**Qualite** : S1=9.0 S2=9.0 S3=7.0 S4=7.0 S5=8.0 — Moyenne=8.0/11

**GRADE** : Depart BONNE (pas de standard, choix contextuel) | +0 | = **BONNE_PRATIQUE**
Sensibilite : retrait S3/S4 (analyses) → docs officielles S1/S2 suffisent. LaunchDarkly = meilleur mais 10x plus cher. Reco stable.
Biais : S1 par Unleash, S2 par LaunchDarkly, mais comparatifs tiers (S3/S4) corroborent.

**Variantes** : Self-hosted budget→Unleash OSS | Enterprise→LaunchDarkly | Analytics integres→PostHog | Minimal→env vars + restart (pas de feature flags)

**Recommandation** : **Unleash** (self-hosted) | GRADE=BONNE_PRATIQUE
> Open source, self-hosted gratuit, SDK 15+ langages, activation strategies. LaunchDarkly si budget enterprise. Pour equipe 2 devs, env vars suffisent au debut, Unleash quand deploiement progressif requis.

---

## Decision 15 — Environment Configuration (12-Factor + dotenv + secrets manager)

**PICOC** : P=application multi-environnement (dev, staging, prod) | I=12-Factor config (env vars) | C=fichiers config commites, hardcoded values, config server (Spring Cloud Config) | O=securite secrets, portabilite, simplicite | C=Docker Compose, VPS, CI/CD GitHub Actions

**PRISMA** : Sources : 12-Factor App, Docker docs, Spring Boot externalized config, dotenv docs | Trouves=9 | Filtres=6 | Inclus=5

| # | Source | URL | Pyramide | Annee | Data point | CoI |
|---|--------|-----|----------|-------|------------|-----|
| S1 | 12-Factor App - Config | https://12factor.net/config | 3-Guide industrie | 2017 | Config dans env vars, pas dans le code, strict separation code/config | Heroku |
| S2 | Docker Compose env_file | https://docs.docker.com/compose/how-tos/environment-variables/ | 1-Doc officielle | 2025 | env_file directive, .env auto-load, variable substitution, secrets Docker | Aucun |
| S3 | Spring Boot externalized config | https://docs.spring.io/spring-boot/reference/features/external-config.html | 1-Doc officielle | 2025 | application.yml + env vars override, profils (dev/staging/prod), @Value injection | Pivotal |
| S4 | GitHub Actions secrets | https://docs.github.com/en/actions/security-for-github-actions/security-guides/using-secrets-in-github-actions | 1-Doc officielle | 2025 | Secrets chiffres, injectes en env vars, jamais loggues, rotation manuelle | Aucun |
| S5 | HashiCorp Vault docs | https://developer.hashicorp.com/vault/docs | 1-Doc officielle | 2025 | Dynamic secrets, rotation automatique, audit trail, ACL fine-grained | HashiCorp |

**Qualite** : S1=8.0 S2=9.0 S3=9.5 S4=9.0 S5=9.0 — Moyenne=8.9/11

**GRADE** : Depart HAUTE (12-Factor = consensus industrie + docs officielles) | -0 | = **STANDARD**
Sensibilite : retrait S1 (12-Factor old) → Docker + Spring Boot docs suffisent, pattern identique. Vault optionnel pour petite equipe. Reco stable.
Biais : S1 par Heroku mais pattern devenu universel. S5 par HashiCorp mais pattern applicable a tout secret manager.

**Variantes** : Dev→.env + dotenv | Staging/Prod→Docker env_file + GitHub Actions secrets | Enterprise→HashiCorp Vault ou AWS Secrets Manager | Spring→application-{profil}.yml + env vars override

**Recommandation** : **12-Factor env vars** | GRADE=STANDARD
> Env vars via Docker env_file (prod) + .env (dev). Secrets dans GitHub Actions secrets (CI/CD). .env jamais commite (.gitignore). Vault si rotation automatique requise.

---

## Decision 16 — Reverse Proxy (Caddy / Nginx / Traefik)

**PICOC** : P=application web avec HTTPS et routing | I=Caddy | C=Nginx, Traefik, HAProxy, Apache | O=simplicite HTTPS, performance, configuration | C=VPS unique, Docker Compose, equipe 2 devs, HTTPS obligatoire

**PRISMA** : Sources : Caddy docs, Nginx docs, comparatifs benchmark 2026, ZeonEdge analysis | Trouves=10 | Filtres=7 | Inclus=5

| # | Source | URL | Pyramide | Annee | Data point | CoI |
|---|--------|-----|----------|-------|------------|-----|
| S1 | Caddy docs | https://caddyserver.com/docs/ | 1-Doc officielle | 2025 | HTTPS automatique (Let's Encrypt + ZeroSSL), Caddyfile declaratif, reverse_proxy directive | Aucun |
| S2 | Nginx docs | https://nginx.org/en/docs/ | 1-Doc officielle | 2025 | 65% market share, haute performance, config manuelle HTTPS (certbot), event-driven | Aucun |
| S3 | ZeonEdge Nginx vs Caddy vs Traefik 2026 | https://zeonedge.com/blog/nginx-vs-caddy-vs-traefik-comparison | 4-Analyse | 2026 | Nginx 65% market share, Traefik 22%, Caddy 13%. Caddy = simplicite, Nginx = performance brute | Aucun |
| S4 | Benchmark Caddy vs Nginx | https://blog.tjll.net/reverse-proxy-hot-dog-eating-contest-caddy-vs-nginx/ | 2-Benchmark | 2025 | Nginx marginal lead en raw throughput, difference negligeable < 10k req/s | Aucun |
| S5 | SelfHostWise Traefik vs Caddy vs Nginx 2026 | https://selfhostwise.com/posts/traefik-vs-caddy-vs-nginx-proxy-manager-which-reverse-proxy-should-you-choose-in-2026/ | 4-Analyse | 2026 | Caddy = best pour nouveaux projets, Traefik = cloud-native/K8s, Nginx = legacy + performance | Aucun |

**Qualite** : S1=9.0 S2=9.5 S3=7.0 S4=7.5 S5=7.0 — Moyenne=8.0/11

**GRADE** : Depart BONNE (pas de standard unique, 3 choix viables) | +0 | = **BONNE_PRATIQUE**
Sensibilite : retrait S3-S5 (analyses) → docs officielles suffisent. Caddy vs Nginx = simplicite vs performance. Reco conditionnelle.
Biais : aucun (docs officielles + benchmarks independants).

**Variantes** : Simplicite HTTPS→Caddy (zero-config TLS) | Performance brute→Nginx | Cloud-native/K8s→Traefik | Legacy→Nginx (65% market share)

**Recommandation** : **Caddy** | GRADE=BONNE_PRATIQUE
> HTTPS automatique (zero config Let's Encrypt), Caddyfile declaratif, reverse_proxy natif. Performance equivalente a Nginx sous 10k req/s. Nginx si performance brute critique ou equipe deja experte.

---

## Decision 17 — Incident Response (runbooks + post-mortem)

**PICOC** : P=equipe ops/dev gerant incidents prod | I=runbooks structures + post-mortem blameless | C=pas de processus, ad hoc, ticket JIRA seul | O=MTTR reduit, apprentissage continu, prevention recurrence | C=equipe 2 devs, pas d'on-call formel, app e-learning

**PRISMA** : Sources : PagerDuty incident response, Google SRE postmortem, incident.io guide, Atlassian guide | Trouves=9 | Filtres=6 | Inclus=5

| # | Source | URL | Pyramide | Annee | Data point | CoI |
|---|--------|-----|----------|-------|------------|-----|
| S1 | PagerDuty incident response docs | https://response.pagerduty.com/ | 3-Guide industrie | 2025 | Severity levels (SEV1-4), roles (IC, scribe, comms), escalation, runbooks lies aux alerts | PagerDuty |
| S2 | Google SRE - Postmortem culture | https://sre.google/sre-book/postmortem-culture/ | 4-Expert opinion | 2016 | Blameless postmortem, timeline, root cause, action items, partage public optionnel | Aucun |
| S3 | Google SRE Workbook - Postmortem | https://sre.google/workbook/postmortem-culture/ | 4-Expert opinion | 2018 | Template structure : summary, impact, timeline, root cause, action items, lessons learned | Aucun |
| S4 | incident.io blog | https://incident.io/blog/slo-sla-sli | 3-Guide industrie | 2025 | Lier SLOs aux incidents, error budget burn = declencheur incident, automated workflows | Aucun |
| S5 | Atlassian incident management | https://www.atlassian.com/incident-management/handbook | 3-Guide industrie | 2025 | Detect→respond→recover→learn, communication template, severity matrix, post-incident review | Atlassian |

**Qualite** : S1=8.5 S2=9.0 S3=9.0 S4=7.5 S5=8.0 — Moyenne=8.4/11

**GRADE** : Depart BONNE (expert opinion Google SRE, pas de standard formel) | +0.5 (adoption large industrie) | = **BONNE_PRATIQUE**
Sensibilite : retrait S1 (PagerDuty vendor) → Google SRE books + Atlassian suffisent. Reco stable.
Biais : S1 par PagerDuty, S5 par Atlassian, mais Google SRE (S2/S3) = reference independante.

**Variantes** : Minimal→runbooks Markdown dans repo + post-mortem Google Docs | Mature→PagerDuty/incident.io + Slack bot | Toutes stacks→meme processus (pas lie a la techno)

**Recommandation** : **Runbooks Git + post-mortem blameless** | GRADE=BONNE_PRATIQUE
> Runbooks versionnes dans le repo (Markdown), lies aux alertes Grafana. Post-mortem blameless apres chaque incident (template Google SRE). Pour 2 devs : simple doc + action items trackees. PagerDuty si on-call formel necessaire.

---

# RESUME DES RECOMMANDATIONS

| # | Decision | Recommandation | GRADE | Niveau |
|---|----------|---------------|-------|--------|
| 1 | Error handling | RFC 9457 (Problem Details) | STANDARD | HAUTE |
| 2 | Circuit breaker | Resilience4j (Java) / opossum (Node.js) | STANDARD | HAUTE |
| 3 | Backup | pg_dump + pgBackRest (PITR) | STANDARD | HAUTE |
| 4 | Monitoring | Prometheus + Grafana | STANDARD | HAUTE |
| 5 | DB migrations | Flyway (Spring Boot) | BONNE_PRATIQUE | BONNE |
| 6 | Graceful shutdown | server.shutdown=graceful (Spring Boot) | STANDARD | HAUTE |
| 7 | High availability | Docker restart + healthcheck (VPS) | BONNE_PRATIQUE | BONNE |
| 8 | Transactions | @Transactional (Spring) | STANDARD | HAUTE |
| 9 | Logging | JSON structured (Logback JsonEncoder) | STANDARD | HAUTE |
| 10 | Error tracking | GlitchTip (self-hosted) | BONNE_PRATIQUE | BONNE |
| 11 | Alerting | Grafana Alerting | STANDARD | HAUTE |
| 12 | SLOs | Golden signals (availability + latency) | BONNE_PRATIQUE | BONNE |
| 13 | Uptime monitoring | Uptime Kuma (self-hosted) | BONNE_PRATIQUE | BONNE |
| 14 | Feature flags | Unleash (self-hosted) | BONNE_PRATIQUE | BONNE |
| 15 | Env config | 12-Factor env vars + Docker env_file | STANDARD | HAUTE |
| 16 | Reverse proxy | Caddy (HTTPS automatique) | BONNE_PRATIQUE | BONNE |
| 17 | Incident response | Runbooks Git + post-mortem blameless | BONNE_PRATIQUE | BONNE |

**Stats** : 8/17 STANDARD (HAUTE), 9/17 BONNE_PRATIQUE (BONNE), 0/17 EMERGING
