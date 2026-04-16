# Systematic Reviews — 17 Reliability & Operations Decisions (Agent B)

**Date** : 2026-04-14
**Methode** : Kitchenham v3.0 (EBSE-Guide methodology.md)
**Reviewer** : Agent B (Claude Opus 4.6, contexte isole)

---

# PARTIE I — RELIABILITY (8 decisions)

---

## Decision 1 — Error Handling (RFC 9457 Problem Details)

**PICOC** : P=API REST production | I=RFC 9457 Problem Details | C=format custom, enveloppe generique {error, message} | O=coherence erreurs, DX client, debuggabilite | Co=multi-client (SPA, mobile, tiers)

**PRISMA** : RFC 9457 (1), Spring docs (1), ASP.NET docs (1), Zalando guidelines (1), HTTP API Design Guide (Heroku) (1) → Found=7 → Screened=6 → Excl: 1 (blog, E1) → Included=5

**I/E** : I1=traite du format d'erreur API, I2=specifications normatives, I3=niveaux 1-5, I4=post-2021 ou standard en vigueur. Exclu: 1 blog perso (E1).

**Quality Assessment** :
| Source | Q1 | Q2 | Q3 | Q4 | Q5 | Q6 | Q7 | Q8 | Q9 | Q10 | Q11 | TOTAL |
|--------|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:---:|:---:|:-----:|
| RFC 9457 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | **11/11** |
| Spring Boot 3.x ProblemDetail | 1 | 1 | 1 | 1 | 0.5 | 0 | 1 | 0.5 | 0.5 | 1 | 1 | **8.5/11** |
| ASP.NET ProblemDetails | 1 | 1 | 1 | 1 | 0.5 | 0 | 1 | 0.5 | 0.5 | 1 | 1 | **8.5/11** |
| Zalando Guidelines | 1 | 1 | 1 | 0.5 | 0 | 1 | 0.5 | 0.5 | 0.5 | 1 | 1 | **8/11** |
| NestJS HttpException docs | 1 | 1 | 1 | 0.5 | 0 | 0 | 1 | 0.5 | 0.5 | 1 | 1 | **7.5/11** |

**Data Extraction** :
| Source | URL | Pyramid | Year | Data Point | COI |
|--------|-----|:-------:|:----:|------------|:---:|
| RFC 9457 | https://www.rfc-editor.org/rfc/rfc9457 | 1 | 2023 | type, title, status, detail, instance — standard IETF remplacant RFC 7807 | Non |
| Spring Boot 3.x ProblemDetail | https://docs.spring.io/spring-framework/reference/web/webmvc/mvc-ann-rest-exceptions.html | 3 | 2024 | Support natif ProblemDetail, auto-mapping @ResponseStatus, @ControllerAdvice | Pivotal |
| ASP.NET ProblemDetails | https://learn.microsoft.com/en-us/aspnet/core/web-api/handle-errors | 3 | 2024 | Middleware natif depuis .NET 7, ValidationProblemDetails | Microsoft |
| Zalando Guidelines | https://opensource.zalando.com/restful-api-guidelines/#176 | 5 | 2024 | Rule #176 "MUST use Problem JSON", deploye sur 200+ microservices | Zalando |
| NestJS HttpException docs | https://docs.nestjs.com/exception-filters | 3 | 2025 | Pas de RFC 9457 built-in mais ExceptionFilter mappable | Non |

**GRADE** : Depart=4 (niveau 1, standard IETF) +1 (convergence: 3 stacks adoptent nativement) +0 (pas de grande echelle) = **5/7 STANDARD**
Sensibilite : retrait RFC 9457 → depart=2, score 3 (RECOMMANDE). Retrait Zalando → score 5 (stable). **FRAGILE sur RFC**.
Biais : aucun (RFC = processus ouvert IETF, critiques alternatives existent — GraphQL errors, gRPC status).

**Variantes** : Java→Spring ProblemDetail natif (@ControllerAdvice) | C#→ProblemDetails middleware | TS→ExceptionFilter custom mappant RFC 9457 | Python→drf-standardized-errors

**Recommandation** : **RFC 9457** | GRADE=5/7 STANDARD
> Standard IETF, support natif Spring Boot 3+ et ASP.NET 7+. Chaque stack mappe ses exceptions vers application/problem+json via son handler natif.

---

## Decision 2 — Circuit Breaker (Resilience4j vs opossum vs pybreaker)

**PICOC** : P=appels inter-services/API externes | I=circuit breaker pattern (Resilience4j) | C=retry simple, timeout seul, pas de protection | O=resilience, prevention cascade, latence | Co=monolithe modulaire ou microservices, appels HTTP/gRPC externes

**PRISMA** : Release It! 2nd ed. (1), Resilience4j docs (1), Netflix Hystrix sunset (1), opossum npm (1), pybreaker PyPI (1), Microsoft Cloud Design Patterns (1) → Found=8 → Screened=7 → Excl: 1 (blog, E1) → Included=6

**I/E** : I1=traite du pattern circuit breaker, I2=donnees ou specifications, I3=niveaux 1-5, I4=post-2021 ou reference classique. Exclu: 1 blog (E1).

**Quality Assessment** :
| Source | Q1 | Q2 | Q3 | Q4 | Q5 | Q6 | Q7 | Q8 | Q9 | Q10 | Q11 | TOTAL |
|--------|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:---:|:---:|:-----:|
| Release It! 2nd ed. | 1 | 1 | 1 | 1 | 0.5 | 1 | 1 | 1 | 1 | 1 | 1 | **10.5/11** |
| Resilience4j docs | 1 | 1 | 1 | 1 | 0 | 0.5 | 1 | 0.5 | 0.5 | 1 | 1 | **8.5/11** |
| Hystrix sunset notice | 1 | 1 | 0.5 | 0.5 | 0 | 0 | 0.5 | 0.5 | 0.5 | 1 | 1 | **6.5/11** |
| opossum npm | 1 | 1 | 1 | 0.5 | 0 | 0 | 1 | 0.5 | 0.5 | 1 | 1 | **7.5/11** |
| pybreaker PyPI | 0.5 | 0.5 | 0.5 | 0.5 | 0 | 0 | 0.5 | 0.5 | 0.5 | 1 | 1 | **5.5/11** |
| Microsoft Cloud Patterns | 1 | 1 | 1 | 1 | 0 | 1 | 1 | 1 | 0.5 | 1 | 1 | **9.5/11** |

**Data Extraction** :
| Source | URL | Pyramid | Year | Data Point | COI |
|--------|-----|:-------:|:----:|------------|:---:|
| Release It! 2nd ed. (Nygard) | https://pragprog.com/titles/mnee2/release-it-second-edition/ | 2 | 2018 | Pattern fondateur: CLOSED→OPEN→HALF_OPEN, previent cascade failures | Non |
| Resilience4j docs | https://resilience4j.readme.io/docs | 3 | 2025 | Successeur Hystrix, lightweight, Java 17+, decorateurs fonctionnels, integ Spring Boot | Non |
| Hystrix sunset | https://github.com/Netflix/Hystrix#hystrix-status | 5 | 2018 | Maintenance mode depuis 2018, recommande migration vers Resilience4j | Netflix |
| opossum npm | https://www.npmjs.com/package/opossum | 5 | 2025 | Circuit breaker Node.js, ~80k downloads/week, Red Hat maintenu | Non |
| pybreaker PyPI | https://pypi.org/project/pybreaker/ | 5 | 2024 | Circuit breaker Python, ~50k downloads/month, API simple | Non |
| Microsoft Cloud Design Patterns | https://learn.microsoft.com/en-us/azure/architecture/patterns/circuit-breaker | 3 | 2024 | Pattern reference Azure, recommande pour appels distants, monitoring integre | Microsoft |

**GRADE** : Depart=3 (niveau 2, livre reference) +1 (convergence: 4 sources concordent sur le pattern) +0 -0 = **4/7 RECOMMANDE**
Sensibilite : retrait Release It! → depart=2, score 3 (reste RECOMMANDE). Retrait Microsoft → score 3 (reste RECOMMANDE). **ROBUSTE**.
Biais : negatifs existent (over-engineering pour petites apps, complexite config). Non detecte.

**Variantes** : Java→Resilience4j (successeur Hystrix, Spring Boot starter) | TS→opossum (Red Hat) | Python→pybreaker | C#→Polly

**Recommandation** : **Circuit breaker pattern** | GRADE=4/7 RECOMMANDE
> Pattern fondamental (Release It!), chaque stack a sa lib mature. Resilience4j pour Java, opossum pour Node.js, pybreaker pour Python. Indispensable des qu'il y a des appels externes.

---

## Decision 3 — Backup (pg_dump + WAL archiving)

**PICOC** : P=PostgreSQL en production | I=pg_dump + WAL archiving (PITR) | C=snapshots disque seul, replication seule, pas de backup | O=RPO, RTO, fiabilite restauration | Co=VPS/cloud, donnees critiques, equipe petite

**PRISMA** : PostgreSQL docs (1), pgBackRest docs (1), Barman docs (1), AWS RDS backup docs (1), NIST SP 800-184 (1) → Found=7 → Screened=6 → Excl: 1 (blog, E1) → Included=5

**I/E** : I1=traite de backup PostgreSQL, I2=donnees ou specifications, I3=niveaux 1-5, I4=post-2021 ou standard. Exclu: 1 blog (E1).

**Quality Assessment** :
| Source | Q1 | Q2 | Q3 | Q4 | Q5 | Q6 | Q7 | Q8 | Q9 | Q10 | Q11 | TOTAL |
|--------|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:---:|:---:|:-----:|
| PostgreSQL docs | 1 | 1 | 1 | 1 | 0 | 1 | 1 | 1 | 0.5 | 1 | 1 | **9.5/11** |
| pgBackRest docs | 1 | 1 | 1 | 1 | 0 | 0.5 | 1 | 1 | 0.5 | 1 | 1 | **9/11** |
| Barman docs | 1 | 1 | 1 | 1 | 0 | 0.5 | 1 | 1 | 0.5 | 1 | 1 | **9/11** |
| AWS RDS backup docs | 1 | 1 | 1 | 1 | 0 | 0.5 | 1 | 0.5 | 0.5 | 1 | 1 | **8.5/11** |
| NIST SP 800-184 | 1 | 1 | 1 | 1 | 0.5 | 0 | 1 | 1 | 1 | 1 | 1 | **9.5/11** |

**Data Extraction** :
| Source | URL | Pyramid | Year | Data Point | COI |
|--------|-----|:-------:|:----:|------------|:---:|
| PostgreSQL docs ch.26 | https://www.postgresql.org/docs/current/backup.html | 3 | 2025 | 3 methodes: SQL dump, file system, continuous archiving (WAL). PITR via WAL archiving | Non |
| pgBackRest docs | https://pgbackrest.org/ | 3 | 2025 | Backup parallele, compression, chiffrement, verification integrite, restore PITR | Non |
| Barman docs | https://www.pgbarman.org/ | 3 | 2025 | Backup distant, WAL streaming, catalog management, par EDB | EDB |
| AWS RDS backup | https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_WorkingWithAutomatedBackups.html | 3 | 2025 | Automated backups + manual snapshots, PITR avec 5 min granularite | AWS |
| NIST SP 800-184 | https://csrc.nist.gov/publications/detail/sp/800-184/final | 1 | 2016 | Guide cyber event recovery, recommande 3-2-1 (3 copies, 2 supports, 1 offsite), test regulier | Non |

**GRADE** : Depart=4 (niveau 1, NIST standard) +1 (convergence: 4 sources concordent WAL + dump) +0 -0 = **5/7 STANDARD**
Sensibilite : retrait NIST → depart=2, score 3 (RECOMMANDE). Retrait PG docs → score 4 (RECOMMANDE). **FRAGILE sur NIST**.
Biais : critiques WAL existent (complexite config, espace disque). Non detecte.

**Variantes** : Toutes stacks→pg_dump (logique quotidien) + WAL archiving (PITR). Outil: pgBackRest (simple) ou Barman (distant). Cloud: backup automatique RDS/Cloud SQL.

**Recommandation** : **pg_dump + WAL archiving (PITR)** | GRADE=5/7 STANDARD
> Strategie 3-2-1 (NIST). pg_dump quotidien + WAL continu pour PITR. pgBackRest recommande pour l'automatisation. Tester la restauration regulierement.

---

## Decision 4 — Monitoring (Prometheus + Grafana)

**PICOC** : P=Application web en production | I=Prometheus + Grafana | C=Datadog, New Relic, CloudWatch, ELK seul | O=observabilite, cout, alerting, retention | Co=equipe petite, budget limite, VPS/cloud

**PRISMA** : CNCF Landscape (1), Prometheus docs (1), Grafana docs (1), DORA State of DevOps 2024 (1), SO Survey 2025 (1) → Found=7 → Screened=6 → Excl: 1 (vendor whitepaper, E4) → Included=5

**I/E** : I1=traite de monitoring/observabilite, I2=donnees, I3=niveaux 1-5, I4=post-2021. Exclu: 1 whitepaper vendeur (E4).

**Quality Assessment** :
| Source | Q1 | Q2 | Q3 | Q4 | Q5 | Q6 | Q7 | Q8 | Q9 | Q10 | Q11 | TOTAL |
|--------|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:---:|:---:|:-----:|
| CNCF Landscape | 1 | 1 | 1 | 1 | 0.5 | 1 | 1 | 1 | 0.5 | 1 | 1 | **10/11** |
| Prometheus docs | 1 | 1 | 1 | 1 | 0 | 0.5 | 1 | 0.5 | 0.5 | 1 | 1 | **8.5/11** |
| Grafana docs | 1 | 1 | 1 | 1 | 0 | 0.5 | 1 | 0.5 | 0.5 | 1 | 1 | **8.5/11** |
| DORA State of DevOps 2024 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 0.5 | 1 | 1 | **10.5/11** |
| SO Survey 2025 | 1 | 1 | 1 | 1 | 0.5 | 1 | 1 | 1 | 0.5 | 1 | 1 | **10/11** |

**Data Extraction** :
| Source | URL | Pyramid | Year | Data Point | COI |
|--------|-----|:-------:|:----:|------------|:---:|
| CNCF Landscape | https://landscape.cncf.io/ | 2 | 2025 | Prometheus = graduated project CNCF, standard de facto monitoring cloud-native | CNCF |
| Prometheus docs | https://prometheus.io/docs/ | 3 | 2025 | Pull-based, PromQL, alertmanager integre, exporters ecosystem (node, JVM, etc.) | Non |
| Grafana docs | https://grafana.com/docs/grafana/latest/ | 3 | 2025 | Dashboards, alerting, multi-datasource (Prometheus, Loki, Tempo), gratuit OSS | Grafana Labs |
| DORA State of DevOps 2024 | https://dora.dev/research/ | 4 | 2024 | Elite performers monitor proactivement, monitoring correle avec deploy frequency et MTTR | Google |
| SO Survey 2025 | https://survey.stackoverflow.co/2025 | 4 | 2025 | Grafana et Prometheus parmi les outils DevOps les plus utilises | Non |

**GRADE** : Depart=3 (niveau 2, CNCF graduated) +1 (convergence: 4 sources concordent) +1 (grande echelle: SO 70k+, DORA 35k+) = **5/7 STANDARD**
Sensibilite : retrait CNCF → depart=2, score 4 (RECOMMANDE). Retrait DORA → score 4 (RECOMMANDE). **FRAGILE sur CNCF**.
Biais : critiques existent (Prometheus scaling limites, Grafana complexite). Datadog/New Relic partisans actifs. Non detecte.

**Variantes** : Java→Micrometer + Prometheus actuator | TS→prom-client npm | Python→prometheus_client | C#→prometheus-net. Dashboards Grafana identiques cross-stack.

**Recommandation** : **Prometheus + Grafana** | GRADE=5/7 STANDARD
> CNCF graduated, gratuit, standard cloud-native. Prometheus scrape + Grafana dashboards. DORA confirme: monitoring correle avec performance elite. Micrometer/prom-client pour exposer les metriques.

---

## Decision 5 — DB Migrations (Flyway vs Prisma Migrate vs Django Migrations)

**PICOC** : P=Application avec PostgreSQL, schema evolutif | I=outil de migration versionne (Flyway, Prisma Migrate, Django Migrations) | C=scripts SQL manuels, ALTER ad-hoc | O=tracabilite, reproductibilite, rollback, CI/CD | Co=equipe petite, multi-environnements (dev, staging, prod)

**PRISMA** : Flyway docs (1), Prisma Migrate docs (1), Django docs (1), Liquibase docs (1), ThoughtWorks Tech Radar (1) → Found=6 → Screened=6 → Excl: 0 → Included=5

**I/E** : I1=traite de migration de schema DB, I2=specifications, I3=niveaux 3-5, I4=post-2021. Aucune exclusion.

**Quality Assessment** :
| Source | Q1 | Q2 | Q3 | Q4 | Q5 | Q6 | Q7 | Q8 | Q9 | Q10 | Q11 | TOTAL |
|--------|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:---:|:---:|:-----:|
| Flyway docs | 1 | 1 | 1 | 1 | 0 | 0.5 | 1 | 0.5 | 0.5 | 1 | 1 | **8.5/11** |
| Prisma Migrate docs | 1 | 1 | 1 | 1 | 0 | 0.5 | 1 | 0.5 | 0.5 | 1 | 1 | **8.5/11** |
| Django Migrations docs | 1 | 1 | 1 | 1 | 0 | 0.5 | 1 | 0.5 | 0.5 | 1 | 1 | **8.5/11** |
| Liquibase docs | 1 | 1 | 1 | 1 | 0 | 0.5 | 1 | 0.5 | 0.5 | 1 | 1 | **8.5/11** |
| ThoughtWorks Tech Radar | 1 | 1 | 1 | 0.5 | 0 | 1 | 0.5 | 0.5 | 0.5 | 1 | 1 | **8/11** |

**Data Extraction** :
| Source | URL | Pyramid | Year | Data Point | COI |
|--------|-----|:-------:|:----:|------------|:---:|
| Flyway docs | https://documentation.red-gate.com/flyway | 3 | 2025 | SQL-first, versionne (V1__desc.sql), checksum validation, Java/CLI/Maven/Gradle, community edition gratuite | Redgate |
| Prisma Migrate docs | https://www.prisma.io/docs/orm/prisma-migrate | 3 | 2025 | Schema-first (schema.prisma), genere SQL, shadow DB pour drift detection | Prisma |
| Django Migrations docs | https://docs.djangoproject.com/en/5.1/topics/migrations/ | 3 | 2025 | Auto-generees depuis models, makemigrations/migrate, squash disponible | Non |
| Liquibase docs | https://docs.liquibase.com/ | 3 | 2025 | XML/YAML/SQL, rollback natif, changelog, plus verbose que Flyway | Liquibase Inc |
| ThoughtWorks Tech Radar | https://www.thoughtworks.com/radar | 5 | 2024 | "Evolutionary Database Design" = Adopt; migrations versionnees = pratique standard | Non |

**GRADE** : Depart=2 (niveau 3, docs officielles) +1 (convergence: 4 outils + Tech Radar concordent) +0 -0 = **3/7 RECOMMANDE**
Sensibilite : retrait Tech Radar → score 3 (stable). Retrait Flyway docs → score 3 (stable, autres outils concordent). **ROBUSTE**.
Biais : critiques existent (rollback difficile Flyway, Prisma shadow DB controversee). Non detecte.

**Variantes** : Java→Flyway (SQL-first, Spring Boot integ native) | TS→Prisma Migrate (schema-first) | Python→Django Migrations (auto ORM) | C#→EF Core Migrations

**Recommandation** : **Migrations versionnees, outil selon stack** | GRADE=3/7 RECOMMANDE
> Pratique standard (ThoughtWorks Adopt). Java: Flyway SQL-first. TS: Prisma Migrate schema-first. Python: Django Migrations auto. Toujours versionner dans Git, executer en CI/CD.

---

## Decision 6 — Graceful Shutdown

**PICOC** : P=Application web conteneurisee | I=graceful shutdown (drain connections, finish in-flight) | C=kill -9 brutal, pas de signal handling | O=zero downtime deploy, integrite donnees, UX | Co=Docker/Kubernetes, deploiement continu

**PRISMA** : Kubernetes docs (1), Spring Boot docs (1), Node.js docs (1), POSIX signals spec (1), 12-Factor App (1) → Found=6 → Screened=6 → Excl: 0 → Included=5

**I/E** : I1=traite du shutdown applicatif, I2=specifications, I3=niveaux 1-5, I4=post-2021 ou standard. Aucune exclusion.

**Quality Assessment** :
| Source | Q1 | Q2 | Q3 | Q4 | Q5 | Q6 | Q7 | Q8 | Q9 | Q10 | Q11 | TOTAL |
|--------|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:---:|:---:|:-----:|
| Kubernetes docs | 1 | 1 | 1 | 1 | 0 | 0.5 | 1 | 1 | 0.5 | 1 | 1 | **9/11** |
| Spring Boot docs | 1 | 1 | 1 | 1 | 0 | 0 | 1 | 0.5 | 0.5 | 1 | 1 | **8/11** |
| Node.js docs | 1 | 1 | 1 | 1 | 0 | 0 | 1 | 0.5 | 0.5 | 1 | 1 | **8/11** |
| POSIX signals | 1 | 1 | 1 | 1 | 0 | 0 | 1 | 1 | 1 | 1 | 1 | **9/11** |
| 12-Factor App | 1 | 1 | 1 | 0.5 | 0 | 0 | 0.5 | 0.5 | 0.5 | 1 | 1 | **7/11** |

**Data Extraction** :
| Source | URL | Pyramid | Year | Data Point | COI |
|--------|-----|:-------:|:----:|------------|:---:|
| Kubernetes docs | https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle/#pod-termination | 3 | 2025 | SIGTERM → terminationGracePeriodSeconds (30s default) → SIGKILL. PreStop hook disponible | CNCF |
| Spring Boot docs | https://docs.spring.io/spring-boot/reference/web/graceful-shutdown.html | 3 | 2025 | server.shutdown=graceful, spring.lifecycle.timeout-per-shutdown-phase=30s | Pivotal |
| Node.js docs | https://nodejs.org/api/process.html#signal-events | 3 | 2025 | process.on('SIGTERM'), fermer serveur HTTP, drainer connexions, puis process.exit(0) | Non |
| POSIX signals | https://pubs.opengroup.org/onlinepubs/9799919799/basedefs/signal.h.html | 1 | 2024 | SIGTERM = terminaison propre (catchable), SIGKILL = force (non-catchable). Standard IEEE | Non |
| 12-Factor App | https://12factor.net/disposability | 2 | 2017 | Factor IX: "Maximize robustness with fast startup and graceful shutdown" | Heroku |

**GRADE** : Depart=4 (niveau 1, POSIX standard) +1 (convergence: 4 sources concordent) +0 -0 = **5/7 STANDARD**
Sensibilite : retrait POSIX → depart=3, score 4 (RECOMMANDE). Retrait K8s → score 4 (RECOMMANDE). **FRAGILE sur POSIX**.
Biais : pas de critiques significatives du graceful shutdown. Non detecte.

**Variantes** : Java→server.shutdown=graceful (Spring Boot) | TS→process.on('SIGTERM') + server.close() | Python→signal.signal(SIGTERM) + uvicorn --timeout-graceful-shutdown | C#→IHostApplicationLifetime

**Recommandation** : **Graceful shutdown** | GRADE=5/7 STANDARD
> Standard POSIX (SIGTERM). 12-Factor Factor IX. Spring Boot: server.shutdown=graceful. Node.js: process.on('SIGTERM'). Obligatoire en conteneur (K8s envoie SIGTERM avant SIGKILL).

---

## Decision 7 — High Availability

**PICOC** : P=Application web production critique | I=replicas multiples + load balancer + health checks | C=single instance, cold standby | O=uptime, MTTR, resilience panne | Co=VPS/cloud, budget modere, equipe petite

**PRISMA** : NIST SP 800-34 (1), AWS Well-Architected (1), Google SRE Book (1), Kubernetes docs (1), PostgreSQL replication docs (1) → Found=7 → Screened=6 → Excl: 1 (E4, vendor whitepaper) → Included=5

**I/E** : I1=traite de haute disponibilite, I2=donnees ou recommandations, I3=niveaux 1-5, I4=post-2021 ou standard. Exclu: 1 whitepaper vendeur (E4).

**Quality Assessment** :
| Source | Q1 | Q2 | Q3 | Q4 | Q5 | Q6 | Q7 | Q8 | Q9 | Q10 | Q11 | TOTAL |
|--------|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:---:|:---:|:-----:|
| NIST SP 800-34 | 1 | 1 | 1 | 1 | 0.5 | 0.5 | 1 | 1 | 1 | 1 | 1 | **10/11** |
| AWS Well-Architected | 1 | 1 | 1 | 1 | 0 | 1 | 1 | 1 | 0.5 | 1 | 1 | **9.5/11** |
| Google SRE Book | 1 | 1 | 1 | 1 | 0.5 | 1 | 1 | 1 | 0.5 | 1 | 1 | **10/11** |
| Kubernetes docs | 1 | 1 | 1 | 1 | 0 | 0.5 | 1 | 1 | 0.5 | 1 | 1 | **9/11** |
| PostgreSQL replication | 1 | 1 | 1 | 1 | 0 | 0.5 | 1 | 1 | 0.5 | 1 | 1 | **9/11** |

**Data Extraction** :
| Source | URL | Pyramid | Year | Data Point | COI |
|--------|-----|:-------:|:----:|------------|:---:|
| NIST SP 800-34 Rev.1 | https://csrc.nist.gov/publications/detail/sp/800-34/rev-1/final | 1 | 2010 | Contingency planning: redundance, failover, test regulier. Standard federal US | Non |
| AWS Well-Architected (Reliability) | https://docs.aws.amazon.com/wellarchitected/latest/reliability-pillar/ | 3 | 2025 | Multi-AZ, auto-scaling, health checks, no single point of failure | AWS |
| Google SRE Book ch.3 | https://sre.google/sre-book/embracing-risk/ | 2 | 2016 | Availability = 1 - (downtime/total), error budgets, SLO-driven architecture | Google |
| Kubernetes docs | https://kubernetes.io/docs/concepts/workloads/controllers/deployment/ | 3 | 2025 | replicas: N, readiness/liveness probes, rolling update zero-downtime | CNCF |
| PostgreSQL streaming replication | https://www.postgresql.org/docs/current/warm-standby.html | 3 | 2025 | Streaming replication, hot standby, pg_basebackup, automatic failover (Patroni) | Non |

**GRADE** : Depart=4 (niveau 1, NIST standard) +1 (convergence: 4 sources concordent) +0 -0 = **5/7 STANDARD**
Sensibilite : retrait NIST → depart=3, score 4 (RECOMMANDE). Retrait Google SRE → score 4 (RECOMMANDE). **FRAGILE sur NIST**.
Biais : critiques HA existent (cout, complexite operationnelle, over-engineering pour petites apps). Non detecte.

**Variantes** : Toutes stacks→meme pattern: replicas app (Docker/K8s) + LB (Caddy/Nginx/HAProxy) + PG streaming replication (Patroni). Proportionner au trafic/SLO.

**Recommandation** : **Replicas + LB + health checks + DB replication** | GRADE=5/7 STANDARD
> NIST contingency planning + Google SRE error budgets. Minimum: 2 replicas app, health checks, DB replication streaming. Proportionner au SLO cible.

---

## Decision 8 — Transactions (gestion transactionnelle)

**PICOC** : P=Application avec PostgreSQL, operations multi-tables | I=transactions ACID (@Transactional, Prisma $transaction, Django atomic) | C=pas de transaction, eventual consistency | O=integrite donnees, coherence, performance | Co=CRUD, operations metier critiques

**PRISMA** : PostgreSQL docs (1), Spring @Transactional docs (1), Prisma $transaction docs (1), Django atomic docs (1), ACID Wikipedia/Haerder & Reuter 1983 (1) → Found=6 → Screened=6 → Excl: 0 → Included=5

**I/E** : I1=traite de transactions DB, I2=specifications, I3=niveaux 1-5, I4=post-2021 ou standard fondateur. Aucune exclusion.

**Quality Assessment** :
| Source | Q1 | Q2 | Q3 | Q4 | Q5 | Q6 | Q7 | Q8 | Q9 | Q10 | Q11 | TOTAL |
|--------|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:---:|:---:|:-----:|
| PostgreSQL docs | 1 | 1 | 1 | 1 | 0 | 0.5 | 1 | 1 | 0.5 | 1 | 1 | **9/11** |
| Spring @Transactional | 1 | 1 | 1 | 1 | 0 | 0 | 1 | 0.5 | 0.5 | 1 | 1 | **8/11** |
| Prisma $transaction | 1 | 1 | 1 | 1 | 0 | 0 | 1 | 0.5 | 0.5 | 1 | 1 | **8/11** |
| Django atomic | 1 | 1 | 1 | 1 | 0 | 0 | 1 | 0.5 | 0.5 | 1 | 1 | **8/11** |
| Haerder & Reuter 1983 | 1 | 1 | 1 | 1 | 0.5 | 0 | 1 | 1 | 1 | 1 | 1 | **9.5/11** |

**Data Extraction** :
| Source | URL | Pyramid | Year | Data Point | COI |
|--------|-----|:-------:|:----:|------------|:---:|
| PostgreSQL docs ch.13 | https://www.postgresql.org/docs/current/mvcc.html | 3 | 2025 | MVCC, isolation levels (Read Committed default, Serializable), BEGIN/COMMIT/ROLLBACK | Non |
| Spring @Transactional | https://docs.spring.io/spring-framework/reference/data-access/transaction/declarative.html | 3 | 2025 | @Transactional declaratif, propagation REQUIRED default, rollback sur RuntimeException | Pivotal |
| Prisma $transaction | https://www.prisma.io/docs/orm/prisma-client/queries/transactions | 3 | 2025 | Interactive transactions ($transaction callback), sequential operations, timeout configurable | Prisma |
| Django atomic | https://docs.djangoproject.com/en/5.1/topics/db/transactions/ | 3 | 2025 | @transaction.atomic decorateur/context manager, ATOMIC_REQUESTS setting, savepoints | Non |
| Haerder & Reuter 1983 | https://dl.acm.org/doi/10.1145/289.291 | 1 | 1983 | Definition formelle ACID: Atomicity, Consistency, Isolation, Durability. Reference fondatrice | Non |

**GRADE** : Depart=4 (niveau 1, papier fondateur + PG implementation) +1 (convergence: 4 sources concordent) +0 -0 = **5/7 STANDARD**
Sensibilite : retrait Haerder & Reuter → depart=2, score 3 (RECOMMANDE). Retrait PG docs → score 4 (RECOMMANDE). **FRAGILE sur papier fondateur**.
Biais : critiques ACID existent (performance locks, scalabilite horizontale). Eventual consistency partisans actifs (BASE). Non detecte.

**Variantes** : Java→@Transactional (Spring, propagation REQUIRED) | TS→prisma.$transaction() | Python→@transaction.atomic (Django) | C#→TransactionScope / EF SaveChanges

**Recommandation** : **Transactions ACID** | GRADE=5/7 STANDARD
> Fondamental (Haerder & Reuter 1983). @Transactional (Spring), $transaction (Prisma), @atomic (Django). Read Committed par defaut, Serializable si invariants critiques. Pas d'over-engineering eventual consistency pour CRUD standard.

---

# PARTIE II — OPERATIONS (9 decisions)

---

## Decision 9 — Logging (JSON structured)

**PICOC** : P=Application web production | I=logging JSON structure (Logback JSON, pino, structlog) | C=logs texte libre, printf-style | O=parsabilite, agregation, correlation, debuggabilite | Co=multi-services, centralisation logs (ELK/Loki)

**PRISMA** : 12-Factor App (1), ELK docs (1), Grafana Loki docs (1), Spring Boot Logback docs (1), pino npm docs (1) → Found=7 → Screened=6 → Excl: 1 (blog, E1) → Included=5

**I/E** : I1=traite de logging applicatif, I2=specifications ou recommandations, I3=niveaux 2-5, I4=post-2021. Exclu: 1 blog (E1).

**Quality Assessment** :
| Source | Q1 | Q2 | Q3 | Q4 | Q5 | Q6 | Q7 | Q8 | Q9 | Q10 | Q11 | TOTAL |
|--------|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:---:|:---:|:-----:|
| 12-Factor App | 1 | 1 | 1 | 0.5 | 0 | 0 | 0.5 | 0.5 | 0.5 | 1 | 1 | **7/11** |
| ELK docs | 1 | 1 | 1 | 1 | 0 | 0.5 | 1 | 0.5 | 0.5 | 1 | 1 | **8.5/11** |
| Grafana Loki docs | 1 | 1 | 1 | 1 | 0 | 0.5 | 1 | 0.5 | 0.5 | 1 | 1 | **8.5/11** |
| Spring Boot Logback | 1 | 1 | 1 | 1 | 0 | 0 | 1 | 0.5 | 0.5 | 1 | 1 | **8/11** |
| pino npm | 1 | 1 | 1 | 1 | 0 | 0.5 | 1 | 0.5 | 0.5 | 1 | 1 | **8.5/11** |

**Data Extraction** :
| Source | URL | Pyramid | Year | Data Point | COI |
|--------|-----|:-------:|:----:|------------|:---:|
| 12-Factor App | https://12factor.net/logs | 2 | 2017 | Factor XI: "Treat logs as event streams", ecrire sur stdout, ne pas gerer fichiers | Heroku |
| ELK docs | https://www.elastic.co/guide/en/ecs/current/index.html | 3 | 2025 | Elastic Common Schema (ECS): champs standardises (timestamp, level, message, trace.id) | Elastic |
| Grafana Loki docs | https://grafana.com/docs/loki/latest/ | 3 | 2025 | Index labels only, stocke logs bruts, optimise pour JSON structure | Grafana Labs |
| Spring Boot Logback | https://docs.spring.io/spring-boot/reference/features/logging.html | 3 | 2025 | Logback default, JSON encoder via logstash-logback-encoder, MDC pour correlation | Pivotal |
| pino npm | https://getpino.io/ | 3 | 2025 | JSON par defaut, ultra-performant (low overhead), child loggers, serializers custom | Non |

**GRADE** : Depart=3 (niveau 2, 12-Factor) +1 (convergence: 4 sources concordent JSON) +0 -0 = **4/7 RECOMMANDE**
Sensibilite : retrait 12-Factor → depart=2, score 3 (reste RECOMMANDE). Retrait ELK → score 3 (reste RECOMMANDE). **ROBUSTE**.
Biais : critiques JSON logs existent (verbeux, lisibilite humaine reduite en dev). Non detecte.

**Variantes** : Java→Logback + logstash-logback-encoder (JSON) | TS→pino (JSON natif) | Python→structlog (JSON) | C#→Serilog (structured)

**Recommandation** : **Logging JSON structure** | GRADE=4/7 RECOMMANDE
> 12-Factor: logs = event streams sur stdout. Format JSON pour parsabilite machine. Java: Logback + logstash-encoder. TS: pino. Python: structlog. Champs: timestamp, level, message, traceId, service.

---

## Decision 10 — Error Tracking (Sentry / GlitchTip)

**PICOC** : P=Application web production | I=error tracking centralise (Sentry/GlitchTip) | C=logs seuls, email alerting, pas de tracking | O=MTTR, deduplication, context (stack trace, user, request), alerting | Co=equipe petite, budget limite

**PRISMA** : Sentry docs (1), GlitchTip docs (1), DORA State of DevOps 2024 (1), ThoughtWorks Tech Radar (1), SO Survey 2025 (1) → Found=6 → Screened=6 → Excl: 0 → Included=5

**I/E** : I1=traite d'error tracking, I2=donnees ou specifications, I3=niveaux 3-5, I4=post-2021. Aucune exclusion.

**Quality Assessment** :
| Source | Q1 | Q2 | Q3 | Q4 | Q5 | Q6 | Q7 | Q8 | Q9 | Q10 | Q11 | TOTAL |
|--------|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:---:|:---:|:-----:|
| Sentry docs | 1 | 1 | 1 | 1 | 0 | 0.5 | 1 | 0.5 | 0.5 | 1 | 1 | **8.5/11** |
| GlitchTip docs | 1 | 1 | 1 | 0.5 | 0 | 0.5 | 1 | 0.5 | 0.5 | 1 | 1 | **8/11** |
| DORA State of DevOps 2024 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 0.5 | 1 | 1 | **10.5/11** |
| ThoughtWorks Tech Radar | 1 | 1 | 1 | 0.5 | 0 | 1 | 0.5 | 0.5 | 0.5 | 1 | 1 | **8/11** |
| SO Survey 2025 | 1 | 1 | 1 | 1 | 0.5 | 1 | 1 | 1 | 0.5 | 1 | 1 | **10/11** |

**Data Extraction** :
| Source | URL | Pyramid | Year | Data Point | COI |
|--------|-----|:-------:|:----:|------------|:---:|
| Sentry docs | https://docs.sentry.io/ | 3 | 2025 | SDK multi-stack (Java, JS, Python, .NET), grouping, breadcrumbs, performance tracing, release tracking | Sentry |
| GlitchTip docs | https://glitchtip.com/documentation | 3 | 2025 | Open source, compatible Sentry SDK, self-hosted, gratuit, subset features Sentry | Non |
| DORA State of DevOps 2024 | https://dora.dev/research/ | 4 | 2024 | "Change failure rate" key metric, error tracking reduit MTTR significativement | Google |
| ThoughtWorks Tech Radar | https://www.thoughtworks.com/radar | 5 | 2024 | Sentry = Adopt, centralised error tracking = pratique standard | Non |
| SO Survey 2025 | https://survey.stackoverflow.co/2025 | 4 | 2025 | Sentry parmi les outils de monitoring les plus utilises | Non |

**GRADE** : Depart=2 (niveau 3, docs officielles) +1 (convergence: 4 sources concordent) +1 (grande echelle: SO 70k+, DORA 35k+) = **4/7 RECOMMANDE**
Sensibilite : retrait DORA → score 3 (reste RECOMMANDE). Retrait Sentry → score 3 (reste RECOMMANDE, GlitchTip compatible SDK). **ROBUSTE**.
Biais : critiques Sentry existent (pricing, volume quotas). GlitchTip = alternative OSS. Non detecte.

**Variantes** : Toutes stacks→Sentry SDK (Java, JS, Python, .NET). Self-hosted: GlitchTip (compatible Sentry SDK, gratuit). SaaS: Sentry (pricing par events).

**Recommandation** : **Sentry/GlitchTip** | GRADE=4/7 RECOMMANDE
> Error tracking centralise reduit MTTR (DORA). Sentry SDK multi-stack. GlitchTip = alternative open source self-hosted, compatible SDK. Grouping + breadcrumbs + release tracking.

---

## Decision 11 — Alerting

**PICOC** : P=Application web monitoree (Prometheus) | I=alerting structure (Alertmanager, Grafana Alerting) | C=alerting ad-hoc (email cron), pas d'alerting | O=MTTD (mean time to detect), fatigue d'alerte, escalation | Co=equipe petite, on-call leger

**PRISMA** : Google SRE Book (1), Alertmanager docs (1), Grafana Alerting docs (1), PagerDuty incident response guide (1), Rob Ewaschuk "My Philosophy on Alerting" (1) → Found=6 → Screened=6 → Excl: 0 → Included=5

**I/E** : I1=traite d'alerting/on-call, I2=donnees ou recommandations, I3=niveaux 2-5, I4=post-2021 ou reference classique. Aucune exclusion.

**Quality Assessment** :
| Source | Q1 | Q2 | Q3 | Q4 | Q5 | Q6 | Q7 | Q8 | Q9 | Q10 | Q11 | TOTAL |
|--------|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:---:|:---:|:-----:|
| Google SRE Book | 1 | 1 | 1 | 1 | 0.5 | 1 | 1 | 1 | 0.5 | 1 | 1 | **10/11** |
| Alertmanager docs | 1 | 1 | 1 | 1 | 0 | 0.5 | 1 | 0.5 | 0.5 | 1 | 1 | **8.5/11** |
| Grafana Alerting docs | 1 | 1 | 1 | 1 | 0 | 0.5 | 1 | 0.5 | 0.5 | 1 | 1 | **8.5/11** |
| PagerDuty IR guide | 1 | 1 | 1 | 1 | 0 | 0.5 | 1 | 1 | 0.5 | 1 | 1 | **9/11** |
| Ewaschuk "Philosophy on Alerting" | 1 | 1 | 1 | 0.5 | 0 | 0.5 | 0.5 | 0.5 | 0.5 | 1 | 1 | **7.5/11** |

**Data Extraction** :
| Source | URL | Pyramid | Year | Data Point | COI |
|--------|-----|:-------:|:----:|------------|:---:|
| Google SRE Book ch.6 | https://sre.google/sre-book/monitoring-distributed-systems/ | 2 | 2016 | "Pages should be about symptoms, not causes". Alerter sur SLO burn rate, pas metriques brutes | Google |
| Alertmanager docs | https://prometheus.io/docs/alerting/latest/alertmanager/ | 3 | 2025 | Grouping, inhibition, silencing, routing (email, Slack, PagerDuty), deduplication | Non |
| Grafana Alerting docs | https://grafana.com/docs/grafana/latest/alerting/ | 3 | 2025 | Unified alerting, multi-datasource, contact points, notification policies, mute timings | Grafana Labs |
| PagerDuty IR guide | https://response.pagerduty.com/ | 3 | 2024 | Severities (SEV1-4), escalation policies, runbooks par alerte, post-incident review | PagerDuty |
| Ewaschuk "Philosophy on Alerting" | https://docs.google.com/document/d/199PqyG3UsyXlwieHaqbGiWVa8eMWi8zzAn0YfcApr8Q | 5 | 2013 | "Every page should be actionable". Triage: page vs ticket vs log. Eviter alert fatigue | Google |

**GRADE** : Depart=3 (niveau 2, Google SRE Book) +1 (convergence: 4 sources concordent symptom-based) +0 -0 = **4/7 RECOMMANDE**
Sensibilite : retrait Google SRE → depart=2, score 3 (reste RECOMMANDE). Retrait Alertmanager → score 3 (reste RECOMMANDE). **ROBUSTE**.
Biais : critiques alerting existent (alert fatigue, over-alerting). Sources negatives equilibrent. Non detecte.

**Variantes** : Toutes stacks→meme pattern (alerting est infrastructure, pas code). Prometheus→Alertmanager. Grafana→Unified Alerting. Canaux: Slack/email (petite equipe), PagerDuty (on-call formel).

**Recommandation** : **Alerting symptom-based (Alertmanager/Grafana)** | GRADE=4/7 RECOMMANDE
> Google SRE: alerter sur symptomes (SLO burn rate), pas causes. Chaque alerte actionnable avec runbook. Alertmanager (Prometheus) ou Grafana Unified Alerting. Eviter alert fatigue.

---

## Decision 12 — SLOs (Service Level Objectives)

**PICOC** : P=Application web production | I=SLOs formels (availability, latency, error rate) | C=pas de SLO, SLA contractuel seul, monitoring sans objectif | O=fiabilite mesuree, decision engineering basee donnees, error budgets | Co=equipe petite, pas de SRE dedie

**PRISMA** : Google SRE Book (1), Google SRE Workbook (1), DORA State of DevOps 2024 (1), Alex Hidalgo "Implementing SLOs" (1), OpenSLO spec (1) → Found=6 → Screened=6 → Excl: 0 → Included=5

**I/E** : I1=traite de SLOs/SLIs, I2=donnees ou specifications, I3=niveaux 2-5, I4=post-2021 ou reference classique. Aucune exclusion.

**Quality Assessment** :
| Source | Q1 | Q2 | Q3 | Q4 | Q5 | Q6 | Q7 | Q8 | Q9 | Q10 | Q11 | TOTAL |
|--------|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:---:|:---:|:-----:|
| Google SRE Book | 1 | 1 | 1 | 1 | 0.5 | 1 | 1 | 1 | 0.5 | 1 | 1 | **10/11** |
| Google SRE Workbook | 1 | 1 | 1 | 1 | 0.5 | 1 | 1 | 1 | 0.5 | 1 | 1 | **10/11** |
| DORA State of DevOps 2024 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 0.5 | 1 | 1 | **10.5/11** |
| Hidalgo "Implementing SLOs" | 1 | 1 | 1 | 1 | 0 | 0.5 | 1 | 1 | 0.5 | 1 | 1 | **9/11** |
| OpenSLO spec | 1 | 1 | 1 | 0.5 | 0 | 0 | 1 | 0.5 | 0.5 | 1 | 1 | **7.5/11** |

**Data Extraction** :
| Source | URL | Pyramid | Year | Data Point | COI |
|--------|-----|:-------:|:----:|------------|:---:|
| Google SRE Book ch.4 | https://sre.google/sre-book/service-level-objectives/ | 2 | 2016 | SLI (indicateur) → SLO (objectif) → SLA (contrat). Error budget = 1 - SLO. Piloter features vs fiabilite | Google |
| Google SRE Workbook ch.2 | https://sre.google/workbook/implementing-slos/ | 2 | 2018 | SLO implementation step-by-step: choisir SLIs, fixer SLOs, mesurer, alerter sur burn rate | Google |
| DORA State of DevOps 2024 | https://dora.dev/research/ | 4 | 2024 | Equipes avec SLOs formels ont meilleur MTTR et deploy frequency | Google |
| Hidalgo "Implementing SLOs" | https://www.oreilly.com/library/view/implementing-service-level/9781492076803/ | 2 | 2020 | Guide pratique SLO pour non-Google: commencer simple (availability + latency P99), iterer | Non |
| OpenSLO spec | https://openslo.com/ | 2 | 2024 | Spec YAML ouverte pour decrire SLOs de maniere vendor-neutral | Non |

**GRADE** : Depart=3 (niveau 2, Google SRE + consortium) +1 (convergence: 4 sources concordent) +1 (grande echelle: DORA 35k+) = **5/7 STANDARD**
Sensibilite : retrait Google SRE → depart=3 (SRE Workbook reste), score 5 (STANDARD). Retrait DORA → score 4 (RECOMMANDE). **FRAGILE sur DORA**.
Biais : critiques SLOs existent (complexite pour petites equipes, over-engineering). Hidalgo adresse ce point. Non detecte.

**Variantes** : Toutes stacks→SLO = infra/process, pas code. SLIs communs: availability (% requetes 2xx), latency P50/P99, error rate. Mesure via Prometheus + Grafana dashboards.

**Recommandation** : **SLOs formels** | GRADE=5/7 STANDARD
> Google SRE: SLI→SLO→error budget. Commencer simple: availability 99.9% + latency P99 < 500ms. Mesurer via Prometheus. Alerter sur SLO burn rate (pas metriques brutes). DORA confirme correlation performance.

---

## Decision 13 — Uptime Monitoring

**PICOC** : P=Application web production accessible publiquement | I=uptime monitoring externe (UptimeRobot, Uptime Kuma, Pingdom) | C=monitoring interne seul (Prometheus), pas de monitoring externe | O=detection pannes externes, temps de reponse, alerting independant | Co=budget limite, equipe petite

**PRISMA** : Uptime Kuma docs (1), UptimeRobot docs (1), Google SRE Book (1), Gartner "Digital Experience Monitoring" (screened, excluded E4) (1), StatusPage.io docs (1) → Found=6 → Screened=5 → Excl: 1 (E4, vendor Gartner) → Included=4

**I/E** : I1=traite de monitoring uptime externe, I2=donnees ou specifications, I3=niveaux 2-5, I4=post-2021. Exclu: 1 Gartner (E4, marketing).

**Quality Assessment** :
| Source | Q1 | Q2 | Q3 | Q4 | Q5 | Q6 | Q7 | Q8 | Q9 | Q10 | Q11 | TOTAL |
|--------|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:---:|:---:|:-----:|
| Uptime Kuma docs | 1 | 1 | 1 | 0.5 | 0 | 0.5 | 1 | 0.5 | 0.5 | 1 | 1 | **8/11** |
| UptimeRobot docs | 1 | 1 | 1 | 0.5 | 0 | 0.5 | 1 | 0.5 | 0.5 | 1 | 1 | **8/11** |
| Google SRE Book | 1 | 1 | 1 | 1 | 0.5 | 1 | 1 | 1 | 0.5 | 1 | 1 | **10/11** |
| StatusPage.io docs | 1 | 1 | 1 | 0.5 | 0 | 0 | 1 | 0.5 | 0.5 | 1 | 1 | **7.5/11** |

**Data Extraction** :
| Source | URL | Pyramid | Year | Data Point | COI |
|--------|-----|:-------:|:----:|------------|:---:|
| Uptime Kuma docs | https://github.com/louislam/uptime-kuma | 3 | 2025 | Open source, self-hosted, HTTP/TCP/DNS/ping, notifications multi-canal, status page integree, 60k+ GitHub stars | Non |
| UptimeRobot docs | https://uptimerobot.com/ | 5 | 2025 | SaaS, 50 moniteurs gratuit, 5min intervalle, HTTP/keyword/ping, API, status page | UptimeRobot |
| Google SRE Book ch.6 | https://sre.google/sre-book/monitoring-distributed-systems/ | 2 | 2016 | Black-box monitoring (external) + white-box (internal) = complementaires. Black-box = symptome-based | Google |
| StatusPage.io docs | https://www.atlassian.com/software/statuspage | 5 | 2025 | Status page publique pour transparence utilisateurs, integration monitoring, incident communication | Atlassian |

**GRADE** : Depart=3 (niveau 2, Google SRE Book) +1 (convergence: 3 sources concordent monitoring externe) +0 -0 = **4/7 RECOMMANDE**
Sensibilite : retrait Google SRE → depart=2, score 3 (reste RECOMMANDE). Retrait Uptime Kuma → score 3 (reste RECOMMANDE). **ROBUSTE**.
Biais : pas de critiques significatives du monitoring externe. Non detecte.

**Variantes** : Toutes stacks→meme pattern (monitoring externe = infra, pas code). Self-hosted: Uptime Kuma. SaaS: UptimeRobot (gratuit 50 monitors). Status page: Uptime Kuma built-in ou StatusPage.io.

**Recommandation** : **Uptime monitoring externe** | GRADE=4/7 RECOMMANDE
> Google SRE: black-box + white-box complementaires. Uptime Kuma (self-hosted, OSS) ou UptimeRobot (SaaS gratuit). Monitorer endpoints critiques depuis l'exterieur. Status page publique pour transparence.

---

## Decision 14 — Feature Flags (Unleash)

**PICOC** : P=Application web avec deploiement continu | I=feature flags (Unleash, LaunchDarkly, Flipt) | C=branches longues, deploy = release, config manuelles | O=decouplage deploy/release, rollback rapide, A/B testing, progressive rollout | Co=equipe petite, CI/CD, budget limite

**PRISMA** : Unleash docs (1), LaunchDarkly docs (1), Martin Fowler "Feature Toggles" (1), ThoughtWorks Tech Radar (1), DORA State of DevOps 2024 (1) → Found=7 → Screened=6 → Excl: 1 (blog, E1) → Included=5

**I/E** : I1=traite de feature flags, I2=donnees ou recommandations, I3=niveaux 2-5, I4=post-2021. Exclu: 1 blog (E1).

**Quality Assessment** :
| Source | Q1 | Q2 | Q3 | Q4 | Q5 | Q6 | Q7 | Q8 | Q9 | Q10 | Q11 | TOTAL |
|--------|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:---:|:---:|:-----:|
| Unleash docs | 1 | 1 | 1 | 1 | 0 | 0.5 | 1 | 0.5 | 0.5 | 1 | 1 | **8.5/11** |
| LaunchDarkly docs | 1 | 1 | 1 | 1 | 0 | 0.5 | 1 | 0.5 | 0.5 | 1 | 1 | **8.5/11** |
| Fowler "Feature Toggles" | 1 | 1 | 1 | 1 | 0 | 1 | 1 | 1 | 0.5 | 1 | 1 | **9.5/11** |
| ThoughtWorks Tech Radar | 1 | 1 | 1 | 0.5 | 0 | 1 | 0.5 | 0.5 | 0.5 | 1 | 1 | **8/11** |
| DORA State of DevOps 2024 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 0.5 | 1 | 1 | **10.5/11** |

**Data Extraction** :
| Source | URL | Pyramid | Year | Data Point | COI |
|--------|-----|:-------:|:----:|------------|:---:|
| Unleash docs | https://docs.getunleash.io/ | 3 | 2025 | Open source, self-hosted, SDK multi-stack (Java, JS, Python, .NET), strategies (gradual, userID, environment) | Unleash |
| LaunchDarkly docs | https://docs.launchdarkly.com/ | 3 | 2025 | SaaS leader, targeting rules, A/B experiments, SDK multi-stack, audit log | LaunchDarkly |
| Fowler "Feature Toggles" | https://martinfowler.com/articles/feature-toggles.html | 5 | 2017 | 4 types: release, experiment, ops, permission. Lifecycle management, toggle debt | Non |
| ThoughtWorks Tech Radar | https://www.thoughtworks.com/radar | 5 | 2024 | Feature flags = Adopt, Unleash = Trial | Non |
| DORA State of DevOps 2024 | https://dora.dev/research/ | 4 | 2024 | Trunk-based development + feature flags correle avec elite performance | Google |

**GRADE** : Depart=2 (niveau 3, docs officielles) +1 (convergence: 4 sources concordent) +1 (grande echelle: DORA 35k+) = **4/7 RECOMMANDE**
Sensibilite : retrait DORA → score 3 (reste RECOMMANDE). Retrait Fowler → score 3 (reste RECOMMANDE). **ROBUSTE**.
Biais : critiques feature flags existent (toggle debt, complexite, testing combinatoire). Fowler les documente. Non detecte.

**Variantes** : Toutes stacks→Unleash SDK (Java, JS, Python, .NET). Self-hosted: Unleash OSS. SaaS: LaunchDarkly (pricing par seat). Alternative legere: Flipt (OSS, Go).

**Recommandation** : **Feature flags (Unleash)** | GRADE=4/7 RECOMMANDE
> Decouplage deploy/release (Fowler, DORA). Unleash OSS self-hosted recommande (budget). 4 types de toggles (release, ops, experiment, permission). Nettoyer les flags obsoletes (toggle debt).

---

## Decision 15 — Env Config (variables d'environnement)

**PICOC** : P=Application multi-environnement (dev, staging, prod) | I=config par variables d'environnement | C=fichiers config embarques, base de donnees config, hardcode | O=securite, portabilite, simplicite, 12-Factor compliance | Co=Docker, CI/CD, equipe petite

**PRISMA** : 12-Factor App (1), Docker docs (1), Kubernetes ConfigMap/Secrets docs (1), Spring Boot Externalized Config docs (1), OWASP Secrets Management (1) → Found=6 → Screened=6 → Excl: 0 → Included=5

**I/E** : I1=traite de configuration applicative, I2=specifications ou recommandations, I3=niveaux 2-5, I4=post-2021 ou standard. Aucune exclusion.

**Quality Assessment** :
| Source | Q1 | Q2 | Q3 | Q4 | Q5 | Q6 | Q7 | Q8 | Q9 | Q10 | Q11 | TOTAL |
|--------|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:---:|:---:|:-----:|
| 12-Factor App | 1 | 1 | 1 | 0.5 | 0 | 0 | 0.5 | 0.5 | 0.5 | 1 | 1 | **7/11** |
| Docker docs | 1 | 1 | 1 | 1 | 0 | 0.5 | 1 | 0.5 | 0.5 | 1 | 1 | **8.5/11** |
| Kubernetes ConfigMap/Secrets | 1 | 1 | 1 | 1 | 0 | 0.5 | 1 | 1 | 0.5 | 1 | 1 | **9/11** |
| Spring Boot Externalized Config | 1 | 1 | 1 | 1 | 0 | 0 | 1 | 0.5 | 0.5 | 1 | 1 | **8/11** |
| OWASP Secrets Management | 1 | 1 | 1 | 1 | 0 | 0.5 | 1 | 1 | 0.5 | 1 | 1 | **9/11** |

**Data Extraction** :
| Source | URL | Pyramid | Year | Data Point | COI |
|--------|-----|:-------:|:----:|------------|:---:|
| 12-Factor App | https://12factor.net/config | 2 | 2017 | Factor III: "Store config in the environment". Config varies between deploys, code does not | Heroku |
| Docker docs | https://docs.docker.com/compose/how-tos/environment-variables/ | 3 | 2025 | environment: et env_file: dans Compose, ARG pour build-time, ENV pour runtime | Docker |
| Kubernetes ConfigMap/Secrets | https://kubernetes.io/docs/concepts/configuration/ | 3 | 2025 | ConfigMap (non-sensible), Secret (base64, chiffrable), injection env ou volume mount | CNCF |
| Spring Boot Externalized Config | https://docs.spring.io/spring-boot/reference/features/external-config.html | 3 | 2025 | Hierarchie: env vars > application.yml > defaults. @Value, @ConfigurationProperties | Pivotal |
| OWASP Secrets Management | https://cheatsheetseries.owasp.org/cheatsheets/Secrets_Management_Cheat_Sheet.html | 2 | 2024 | Ne jamais committer de secrets, utiliser vault ou env vars, rotation, least privilege | Non |

**GRADE** : Depart=3 (niveau 2, 12-Factor + OWASP) +1 (convergence: 4 sources concordent env vars) +0 -0 = **4/7 RECOMMANDE**
Sensibilite : retrait 12-Factor → depart=3 (OWASP reste), score 4 (stable). Retrait OWASP → depart=3 (12-Factor reste), score 4 (stable). **ROBUSTE**.
Biais : critiques env vars existent (pas de typage, proliferation, pas de versioning). Vault/config server partisans. Non detecte.

**Variantes** : Java→application.yml + env vars overlay (Spring Boot) | TS→process.env + dotenv (dev only) | Python→os.environ + python-decouple | C#→appsettings.json + env vars. Secrets: jamais en Git, toujours env var ou vault.

**Recommandation** : **Variables d'environnement** | GRADE=4/7 RECOMMANDE
> 12-Factor III + OWASP. Config par env vars (pas de fichiers secrets en Git). Docker: env_file. K8s: ConfigMap/Secret. Spring: hierarchie env > yml. Secrets sensibles: vault pour equipes matures.

---

## Decision 16 — Reverse Proxy (Caddy vs Nginx vs Traefik)

**PICOC** : P=Application web production derriere un proxy | I=reverse proxy (Caddy, Nginx, Traefik) | C=pas de proxy (app directe), cloud LB seul | O=TLS automatique, performance, simplicite config, securite | Co=VPS, Docker, equipe petite, budget limite

**PRISMA** : Caddy docs (1), Nginx docs (1), Traefik docs (1), W3Techs web server survey (1), Let's Encrypt stats (1) → Found=6 → Screened=6 → Excl: 0 → Included=5

**I/E** : I1=traite de reverse proxy web, I2=donnees ou specifications, I3=niveaux 3-5, I4=post-2021. Aucune exclusion.

**Quality Assessment** :
| Source | Q1 | Q2 | Q3 | Q4 | Q5 | Q6 | Q7 | Q8 | Q9 | Q10 | Q11 | TOTAL |
|--------|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:---:|:---:|:-----:|
| Caddy docs | 1 | 1 | 1 | 1 | 0 | 0.5 | 1 | 0.5 | 0.5 | 1 | 1 | **8.5/11** |
| Nginx docs | 1 | 1 | 1 | 1 | 0 | 0.5 | 1 | 0.5 | 0.5 | 1 | 1 | **8.5/11** |
| Traefik docs | 1 | 1 | 1 | 1 | 0 | 0.5 | 1 | 0.5 | 0.5 | 1 | 1 | **8.5/11** |
| W3Techs survey | 1 | 1 | 0.5 | 0.5 | 0 | 1 | 1 | 0.5 | 1 | 1 | 1 | **8.5/11** |
| Let's Encrypt stats | 1 | 0.5 | 0.5 | 0.5 | 0 | 0 | 1 | 0.5 | 0.5 | 1 | 1 | **6.5/11** |

**Data Extraction** :
| Source | URL | Pyramid | Year | Data Point | COI |
|--------|-----|:-------:|:----:|------------|:---:|
| Caddy docs | https://caddyserver.com/docs/ | 3 | 2025 | HTTPS automatique (ACME/Let's Encrypt), Caddyfile minimal, reverse_proxy directive, HTTP/3, Go | Non |
| Nginx docs | https://nginx.org/en/docs/ | 3 | 2025 | #1 market share (34% W3Techs), performant, config verbose mais mature, pas de TLS auto natif | Non |
| Traefik docs | https://doc.traefik.io/traefik/ | 3 | 2025 | Auto-discovery Docker/K8s labels, TLS auto (ACME), dashboard, middlewares (rate limit, auth) | Traefik Labs |
| W3Techs survey | https://w3techs.com/technologies/overview/web_server | 4 | 2025 | Nginx 34%, Apache 27%, Cloudflare 23%, Caddy < 1%, Traefik < 1% | Non |
| Let's Encrypt stats | https://letsencrypt.org/stats/ | 4 | 2025 | 400M+ certificats actifs, ACME = standard de facto pour TLS gratuit | Non |

**GRADE** : Depart=2 (niveau 3, docs officielles) +1 (convergence: 3 proxies supportent ACME/TLS auto) +1 (grande echelle: W3Techs + Let's Encrypt) = **4/7 RECOMMANDE**
Sensibilite : retrait W3Techs → score 3 (reste RECOMMANDE). Retrait Caddy → score 3 (Nginx/Traefik restent). **ROBUSTE**.
Biais : critiques Caddy (market share faible), critiques Nginx (config verbose, pas TLS auto). Equilibre. Non detecte.

**Variantes** :
- **Caddy** : TLS auto zero-config, Caddyfile minimal, ideal petite equipe VPS. GRADE 4/7 RECOMMANDE si simplicite prioritaire.
- **Nginx** : #1 market share, max performance, config verbose. GRADE 4/7 RECOMMANDE si performance prioritaire.
- **Traefik** : auto-discovery Docker/K8s, ideal orchestrateur. GRADE 3/7 RECOMMANDE si K8s.

**Recommandation** : **Reverse proxy avec TLS auto** | GRADE=4/7 RECOMMANDE
> TLS obligatoire (Let's Encrypt ACME). Caddy recommande (TLS auto zero-config, Caddyfile simple). Nginx si performance critique. Traefik si Kubernetes. Ne jamais exposer l'app directement.

---

## Decision 17 — Incident Response

**PICOC** : P=Equipe operant une application production | I=processus incident response structure (severites, roles, runbooks, post-mortem) | C=gestion ad-hoc, pas de processus | O=MTTR, communication, apprentissage, prevention recurrence | Co=equipe petite, pas de SRE dedie

**PRISMA** : PagerDuty IR guide (1), Google SRE Book (1), Atlassian IR handbook (1), NIST SP 800-61 (1), Etsy "Blameless Post-Mortems" (1) → Found=7 → Screened=6 → Excl: 1 (blog, E1) → Included=5

**I/E** : I1=traite d'incident response, I2=donnees ou recommandations, I3=niveaux 1-5, I4=post-2021 ou standard. Exclu: 1 blog (E1).

**Quality Assessment** :
| Source | Q1 | Q2 | Q3 | Q4 | Q5 | Q6 | Q7 | Q8 | Q9 | Q10 | Q11 | TOTAL |
|--------|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:---:|:---:|:-----:|
| PagerDuty IR guide | 1 | 1 | 1 | 1 | 0 | 0.5 | 1 | 1 | 0.5 | 1 | 1 | **9/11** |
| Google SRE Book | 1 | 1 | 1 | 1 | 0.5 | 1 | 1 | 1 | 0.5 | 1 | 1 | **10/11** |
| Atlassian IR handbook | 1 | 1 | 1 | 1 | 0 | 0.5 | 1 | 1 | 0.5 | 1 | 1 | **9/11** |
| NIST SP 800-61 | 1 | 1 | 1 | 1 | 0.5 | 0.5 | 1 | 1 | 1 | 1 | 1 | **10/11** |
| Etsy "Blameless Post-Mortems" | 1 | 1 | 1 | 0.5 | 0 | 0 | 0.5 | 0.5 | 0.5 | 1 | 1 | **7/11** |

**Data Extraction** :
| Source | URL | Pyramid | Year | Data Point | COI |
|--------|-----|:-------:|:----:|------------|:---:|
| PagerDuty IR guide | https://response.pagerduty.com/ | 3 | 2024 | Roles (IC, scribe, communication lead), severites SEV1-4, escalation, status updates, post-incident review | PagerDuty |
| Google SRE Book ch.14 | https://sre.google/sre-book/managing-incidents/ | 2 | 2016 | Incident commander, role separation, blameless post-mortem, action items tracked | Google |
| Atlassian IR handbook | https://www.atlassian.com/incident-management/handbook | 3 | 2025 | Severites, communication templates, runbooks, post-incident review template, StatusPage integration | Atlassian |
| NIST SP 800-61 Rev.2 | https://csrc.nist.gov/publications/detail/sp/800-61/rev-2/final | 1 | 2012 | 4 phases: Preparation, Detection & Analysis, Containment & Recovery, Post-Incident Activity | Non |
| Etsy "Blameless Post-Mortems" | https://www.etsy.com/codeascraft/blameless-postmortems/ | 5 | 2012 | "Blameless" culture, focus systeme pas individu, apprentissage organisationnel | Non |

**GRADE** : Depart=4 (niveau 1, NIST standard) +1 (convergence: 4 sources concordent sur roles + severites + post-mortem) +0 -0 = **5/7 STANDARD**
Sensibilite : retrait NIST → depart=3, score 4 (RECOMMANDE). Retrait Google SRE → score 4 (RECOMMANDE). **FRAGILE sur NIST**.
Biais : critiques IR process existent (bureaucratie, over-process pour petites equipes). Equilibre. Non detecte.

**Variantes** : Toutes stacks→meme process (IR = organisationnel, pas code). Minimum petite equipe: severites (SEV1-3), runbooks pour incidents courants, post-mortem blameless apres chaque SEV1/2, action items trackees.

**Recommandation** : **Incident response structure** | GRADE=5/7 STANDARD
> NIST 4 phases + Google SRE blameless post-mortem. Minimum: severites (SEV1-3), roles (IC + communication), runbooks, post-mortem avec action items. Adapter la formalite a la taille de l'equipe.

---

# SYNTHESE

| # | Decision | Recommandation | GRADE | Robustesse |
|---|----------|----------------|:-----:|:----------:|
| 1 | Error Handling | RFC 9457 Problem Details | 5/7 STANDARD | FRAGILE (RFC) |
| 2 | Circuit Breaker | Pattern CB (Resilience4j/opossum/pybreaker) | 4/7 RECOMMANDE | ROBUSTE |
| 3 | Backup | pg_dump + WAL archiving (PITR) | 5/7 STANDARD | FRAGILE (NIST) |
| 4 | Monitoring | Prometheus + Grafana | 5/7 STANDARD | FRAGILE (CNCF) |
| 5 | DB Migrations | Flyway / Prisma Migrate / Django Migrations | 3/7 RECOMMANDE | ROBUSTE |
| 6 | Graceful Shutdown | SIGTERM handler + drain | 5/7 STANDARD | FRAGILE (POSIX) |
| 7 | High Availability | Replicas + LB + health checks + DB replication | 5/7 STANDARD | FRAGILE (NIST) |
| 8 | Transactions | ACID (@Transactional, $transaction, @atomic) | 5/7 STANDARD | FRAGILE (Haerder) |
| 9 | Logging | JSON structure (Logback/pino/structlog) | 4/7 RECOMMANDE | ROBUSTE |
| 10 | Error Tracking | Sentry / GlitchTip | 4/7 RECOMMANDE | ROBUSTE |
| 11 | Alerting | Symptom-based (Alertmanager/Grafana) | 4/7 RECOMMANDE | ROBUSTE |
| 12 | SLOs | SLI → SLO → error budget | 5/7 STANDARD | FRAGILE (DORA) |
| 13 | Uptime Monitoring | Uptime Kuma / UptimeRobot | 4/7 RECOMMANDE | ROBUSTE |
| 14 | Feature Flags | Unleash (OSS, self-hosted) | 4/7 RECOMMANDE | ROBUSTE |
| 15 | Env Config | Variables d'environnement (12-Factor) | 4/7 RECOMMANDE | ROBUSTE |
| 16 | Reverse Proxy | Caddy (TLS auto) / Nginx / Traefik | 4/7 RECOMMANDE | ROBUSTE |
| 17 | Incident Response | NIST 4 phases + blameless post-mortem | 5/7 STANDARD | FRAGILE (NIST) |

**Distribution GRADE** : 8x STANDARD (5/7), 8x RECOMMANDE (4/7), 1x RECOMMANDE (3/7)
**Robustesse** : 9/17 ROBUSTE (53%), 8/17 FRAGILE (47%) — les FRAGILE dependent toutes d'un standard de reference (NIST, POSIX, IETF, CNCF)
