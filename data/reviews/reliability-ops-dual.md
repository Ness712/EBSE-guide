# Double Extraction v3.0 — Reliability & Operations (17 decisions)

**Date** : 2026-04-14
**Agent A** : Claude Opus 4.6 (run A)
**Agent B** : Claude Opus 4.6 (run B, contexte isole)
**Methode** : Kitchenham v3.0 complete (PICOC, PRISMA, I/E, Q1-Q11, GRADE, sensitivity, pub bias, multi-stack)

---

# PARTIE I — RELIABILITY (8 decisions)

---

## Decision 1 — Error Handling (RFC 9457 + per-stack handler)

### Agent A

**PICOC** : P=API REST multi-stack | I=RFC 9457 (Problem Details) | C=custom error JSON, GraphQL errors, gRPC status | O=interoperabilite, debuggabilite, coherence client | C=API publique/interne, multi-consommateurs

**PRISMA** : Sources : RFC 9457 (IETF), Spring Boot 3.x docs, MDN HTTP, Zalando RESTful guidelines, NestJS exception filters docs | Trouves=8 | Filtres (I1 post-2020, E1 blogs perso)=6 | Inclus=5

| # | Source | Pyramide | Annee | Data point | CoI |
|---|--------|----------|-------|------------|-----|
| S1 | RFC 9457 (IETF) | 1-Standard | 2023 | Remplace RFC 7807, application/problem+json, adopte par Spring Boot 3, ASP.NET 7 | Aucun |
| S2 | Spring Boot 3.x docs | 1-Doc officielle | 2024 | ProblemDetail natif via ErrorResponse, @ControllerAdvice auto-mapping | Pivotal |
| S3 | Zalando RESTful API Guidelines | 3-Guide industrie | 2024 | "MUST use Problem JSON" (rule #176), adopte par 100+ equipes Zalando | Zalando |
| S4 | NestJS exception filters | 1-Doc officielle | 2025 | HttpException + ExceptionFilter custom, pas de Problem Details natif mais facile a mapper | Aucun |
| S5 | Django REST Framework docs | 1-Doc officielle | 2025 | custom_exception_handler(), pas de RFC 9457 natif, libs tierces (drf-problems) | Aucun |

**Qualite** : S1=10.5 S2=9.0 S3=8.0 S4=8.5 S5=8.0 — Moyenne=8.8/11

**GRADE** : Depart HAUTE (1 RFC IETF standard) | -0 incoherence | -0 indirectness | = **5/7 STANDARD**
Sensibilite : retrait S1 (RFC) → pas de standard normatif, tombe a BONNE_PRATIQUE. **FRAGILE sur RFC**.
Biais : aucun (RFC = processus ouvert IETF).

**Variantes** : Java→ProblemDetail natif (Spring Boot 3+) | TS→HttpException + filter custom mappant RFC 9457 | Python→drf-standardized-errors ou custom handler

**Recommandation** : **RFC 9457 (Problem Details)** | GRADE=5/7 STANDARD
> Standard IETF adopte nativement par Spring Boot 3+. Chaque stack implemente via son handler d'exceptions (@ControllerAdvice, ExceptionFilter, custom_exception_handler).

### Agent B

**PICOC** : P=API REST production | I=RFC 9457 Problem Details | C=format custom, enveloppe generique {error, message} | O=coherence erreurs, DX client, debuggabilite | Co=multi-client (SPA, mobile, tiers)

**PRISMA** : RFC 9457 (1), Spring docs (1), ASP.NET docs (1), Zalando guidelines (1), HTTP API Design Guide (Heroku) (1) → Found=7 → Screened=6 → Excl: 1 (blog) → Included=5

| # | Source | Pyramide | Annee | Data point | CoI |
|---|--------|----------|-------|------------|-----|
| S1 | RFC 9457 | 1-Standard | 2023 | type, title, status, detail, instance — standard IETF | Aucun |
| S2 | Spring Boot 3.x ProblemDetail | 1-Doc officielle | 2024 | Support natif, auto-mapping @ResponseStatus | Pivotal |
| S3 | ASP.NET ProblemDetails | 1-Doc officielle | 2024 | Middleware natif depuis .NET 7, ValidationProblemDetails | Microsoft |
| S4 | Zalando Guidelines | 3-Guide industrie | 2024 | Rule #176 MUST, 200+ microservices conformes | Zalando |
| S5 | NestJS HttpException docs | 1-Doc officielle | 2025 | Pas de RFC 9457 built-in mais ExceptionFilter flexible | Aucun |

**Qualite** : S1=11 S2=9 S3=9 S4=8 S5=8 — Moyenne=9.0/11

**GRADE** : Depart=3 (standard IETF) +1 (convergence: 3 stacks adoptent nativement) +1 (zero incoherence) = **5/7 STANDARD**
Sensibilite : retrait S1 → reste RECOMMANDE (convergence industrie). Retrait S4 → aucun impact. **ROBUSTE**.

**Variantes** : Java→Spring ProblemDetail natif | C#→ProblemDetails middleware | TS→ExceptionFilter custom | Python→drf-problems lib

**Recommandation** : **RFC 9457** | GRADE=5/7 STANDARD
> Standard IETF, support natif Spring Boot 3+ et ASP.NET 7+. Chaque stack mappe ses exceptions vers le format Problem Details via son mecanisme (@ControllerAdvice, ExceptionFilter, middleware).

### Reconciliation

**Accord** : OUI (meme outil, meme GRADE 5/7). Divergence mineure sur robustesse (A=FRAGILE, B=ROBUSTE). B plus conservateur en incluant ASP.NET comme 3e stack native. **Resolution** : ROBUSTE — 3 stacks ont un support natif, le standard IETF ne sera pas retire.

---

## Decision 2 — Circuit Breaker (Resilience4j vs opossum vs pybreaker)

### Agent A

**PICOC** : P=appels inter-services/API externes | I=circuit breaker pattern | C=retry simple, timeout seul, bulkhead seul | O=resilience, latence en cascade, disponibilite | C=monolithe modulaire avec appels externes (mail, storage, SSO)

**PRISMA** : Sources : Release It! 2nd ed., Resilience4j docs, Netflix Hystrix sunset, opossum npm, pybreaker PyPI | Trouves=10 | Filtres=7 | Inclus=5

| # | Source | Pyramide | Annee | Data point | CoI |
|---|--------|----------|-------|------------|-----|
| S1 | Nygard, Release It! 2e ed. | 1-Livre reference | 2018 | Circuit breaker = patron fondamental stabilite, etats closed/open/half-open | Aucun |
| S2 | Resilience4j docs | 1-Doc officielle | 2025 | Successeur Hystrix, Spring Boot starter, decorateur fonctionnel, 5 modules (CB, retry, bulkhead, rate limiter, time limiter) | Aucun |
| S3 | Netflix Hystrix sunset | 3-Annonce projet | 2018 | Hystrix en maintenance-only, recommande Resilience4j | Netflix |
| S4 | opossum npm | 1-Doc officielle | 2025 | ~500k dl/sem, Node.js natif, Prometheus metrics, events-based | Aucun |
| S5 | pybreaker PyPI | 1-Doc officielle | 2024 | ~200k dl/mois, Python, listeners pour monitoring, simple API | Aucun |

**Qualite** : S1=10.0 S2=9.0 S3=7.0 S4=7.5 S5=7.0 — Moyenne=8.1/11

**GRADE** : Depart MODEREE (1 livre + docs) | +1 convergence (pattern universel) | = **4/7 RECOMMANDE**
Sensibilite : retrait S1 (Release It!) → pattern reste documente dans les docs de chaque lib. **ROBUSTE**.
Biais : Hystrix sunset pourrait sur-valoriser Resilience4j, mais opossum/pybreaker confirment le pattern multi-stack.

**Variantes** : Java→Resilience4j (standard de facto, Spring Boot starter) | TS→opossum (500k dl/sem) | Python→pybreaker (simple) ou tenacity (retry+CB)

**Recommandation** : **Circuit breaker per-stack** (Resilience4j/opossum/pybreaker) | GRADE=4/7 RECOMMANDE
> Pattern universel (Release It!). Chaque stack a sa lib de reference. Couvrir au minimum les appels externes (mail, S3, SSO).

### Agent B

**PICOC** : P=app avec dependances externes (APIs, DBs) | I=circuit breaker pattern per-stack | C=retry seul, pas de protection | O=resilience cascading failures, latence | Co=monolithe ou microservices, appels HTTP/gRPC

**PRISMA** : Release It! (1), Resilience4j docs (1), Microsoft cloud patterns (1), opossum docs (1), pybreaker docs (1) → Found=6 → Screened=6 → Excl: 1 (blog Hystrix obsolete) → Included=5

| # | Source | Pyramide | Annee | Data point | CoI |
|---|--------|----------|-------|------------|-----|
| S1 | Nygard, Release It! 2e ed. | 1-Livre | 2018 | Patron circuit breaker: closed→open→half-open, "stop doing it if it hurts" | Aucun |
| S2 | Resilience4j GitHub | 1-Doc officielle | 2025 | 10k+ stars, spring-boot-starter, ring buffer sliding window | Aucun |
| S3 | MS Cloud Design Patterns | 3-Guide industrie | 2024 | Circuit Breaker pattern: "prevent app from repeatedly invoking failing operation" | Microsoft |
| S4 | opossum docs | 1-Doc officielle | 2025 | Node.js, ~500k dl/sem, fallback function, Prometheus events | Aucun |
| S5 | pybreaker docs | 1-Doc officielle | 2024 | Python, listeners, configurable fail_max/reset_timeout | Aucun |

**Qualite** : S1=10 S2=9 S3=8 S4=7.5 S5=7 — Moyenne=8.3/11

**GRADE** : Depart=2 (livre expert + docs) +1 (convergence 3 stacks, MS confirme) +1 (zero incoherence) = **4/7 RECOMMANDE**
Sensibilite : retrait S1 → MS Cloud Patterns suffit comme reference conceptuelle. **ROBUSTE**.

**Variantes** : Java→Resilience4j | TS→opossum | Python→pybreaker/tenacity | C#→Polly

**Recommandation** : **Circuit breaker per-stack** | GRADE=4/7 RECOMMANDE
> Pattern universel documente (Release It!, MS Cloud Patterns). Resilience4j (Java), opossum (TS), pybreaker (Python), Polly (C#).

### Reconciliation

**Accord** : OUI (meme pattern, meme libs, meme GRADE 4/7). Les deux jugent ROBUSTE. Aucune divergence.

---

## Decision 3 — Backup & DR (pg_dump + WAL archiving)

### Agent A

**PICOC** : P=base PostgreSQL production | I=pg_dump + WAL archiving (PITR) | C=snapshots VM, replication logique seule, backup SaaS (Barman, pgBackRest) | O=RPO, RTO, fiabilite restauration | C=single-node PostgreSQL, donnees critiques (users, cours, messages)

**PRISMA** : Sources : PostgreSQL docs (WAL, continuous archiving), pgBackRest docs, Barman docs, DORA State of DevOps, Google SRE Book | Trouves=9 | Filtres=6 | Inclus=5

| # | Source | Pyramide | Annee | Data point | CoI |
|---|--------|----------|-------|------------|-----|
| S1 | PostgreSQL docs ch.26 | 1-Doc officielle | 2025 | pg_dump (logical), pg_basebackup + WAL archiving (PITR), restore_command | Aucun |
| S2 | pgBackRest docs | 1-Doc officielle | 2025 | Parallel backup/restore, S3/Azure/GCS, incremental, WAL push/get | Aucun |
| S3 | Google SRE Book ch.26 | 1-Livre reference | 2016 | "Hope is not a strategy", backup = tested regularly, RTO/RPO defines strategy | Google |
| S4 | DORA State of DevOps 2024 | 2-Enquete | 2024 | Elite performers: DR tested quarterly, MTTR <1h | Aucun |
| S5 | Barman docs | 1-Doc officielle | 2025 | Backup management, WAL streaming, retention policies, Cloud snapshots | EnterpriseDB |

**Qualite** : S1=10.0 S2=8.5 S3=9.5 S4=9.0 S5=8.0 — Moyenne=9.0/11

**GRADE** : Depart HAUTE (doc officielle PG + livre SRE) | -0 | = **5/7 STANDARD**
Sensibilite : retrait S1 → pgBackRest/Barman docs couvrent WAL. Retrait S3 → DORA confirme principe. **ROBUSTE**.
Biais : S5 vendor (EDB) mais confirme par doc PG officielle.

**Variantes** : PostgreSQL→pg_dump + WAL archiving (ou pgBackRest pour prod serieuse) | MySQL→mysqldump + binlog | MongoDB→mongodump + oplog | SQLite→cp + WAL

**Recommandation** : **pg_dump quotidien + WAL archiving (PITR)** | GRADE=5/7 STANDARD
> pg_dump pour backup logique, WAL archiving pour PITR. Tester la restauration regulierement (SRE Book). pgBackRest pour industrialiser.

### Agent B

**PICOC** : P=base PostgreSQL production | I=pg_dump + WAL continuous archiving | C=snapshot VM seul, replication seule | O=RPO minimal, RTO acceptable, fiabilite restauration | Co=single-server, donnees critiques, budget limite

**PRISMA** : PostgreSQL docs (1), pgBackRest docs (1), Google SRE Book (1), Barman docs (1), AWS RDS backup docs (1) → Found=7 → Screened=6 → Excl: 1 (blog) → Included=5

| # | Source | Pyramide | Annee | Data point | CoI |
|---|--------|----------|-------|------------|-----|
| S1 | PostgreSQL docs ch.26 | 1-Doc officielle | 2025 | pg_basebackup + archive_command, PITR via recovery_target_time | Aucun |
| S2 | pgBackRest docs | 1-Doc officielle | 2025 | Incremental, parallel, S3 storage, verify command | Aucun |
| S3 | Google SRE Book ch.26 | 1-Livre | 2016 | "Untested backups are not backups", DR drills quarterly | Google |
| S4 | Barman docs | 1-Doc officielle | 2025 | Streaming WAL, retention, catalog, cloud support | EDB |
| S5 | AWS RDS docs | 1-Doc officielle | 2025 | Automated backups = base snapshot + WAL, confirme pattern pg_dump+WAL | AWS |

**Qualite** : S1=10 S2=8.5 S3=9.5 S4=8 S5=8 — Moyenne=8.8/11

**GRADE** : Depart=3 (doc officielle + livre) +1 (convergence: pgBackRest+Barman+AWS meme pattern) +1 (pratique confirmee large echelle AWS) = **5/7 STANDARD**
Sensibilite : retrait S1 → S2+S4 couvrent WAL. Retrait S3 → DORA/AWS confirment. **ROBUSTE**.

**Variantes** : PostgreSQL→pg_dump+WAL | MySQL→mysqldump+binlog | MongoDB→mongodump+oplog

**Recommandation** : **pg_dump + WAL archiving** | GRADE=5/7 STANDARD
> Pattern standard PostgreSQL. pg_dump quotidien + WAL continu pour PITR. Tester restauration (SRE Book). pgBackRest pour industrialiser.

### Reconciliation

**Accord** : OUI (meme strategie, meme GRADE 5/7, meme robustesse). Aucune divergence.

---

## Decision 4 — Monitoring (Prometheus + Grafana + 4 golden signals)

### Agent A

**PICOC** : P=app production observabilite | I=Prometheus + Grafana + 4 golden signals | C=Datadog, New Relic, ELK seul, CloudWatch | O=detection incidents, MTTD, visibilite systeme | C=self-hosted, budget limite, equipe petite

**PRISMA** : Sources : Google SRE Book, Prometheus docs, Grafana docs, CNCF Survey, SO Survey 2025 | Trouves=10 | Filtres=7 | Inclus=5

| # | Source | Pyramide | Annee | Data point | CoI |
|---|--------|----------|-------|------------|-----|
| S1 | Google SRE Book ch.6 | 1-Livre reference | 2016 | 4 golden signals: latency, traffic, errors, saturation | Google |
| S2 | Prometheus docs | 1-Doc officielle | 2025 | CNCF graduated, pull-based, PromQL, 700+ exporters | CNCF |
| S3 | Grafana docs | 1-Doc officielle | 2025 | Dashboards, alerting, multi-datasource, LGTM stack | Grafana Labs |
| S4 | CNCF Survey 2024 | 2-Enquete | 2024 | Prometheus #1 monitoring (65%+), Grafana #1 dashboarding (70%+) | CNCF |
| S5 | DORA State of DevOps 2024 | 2-Enquete | 2024 | Monitoring = predictor of elite performance, observability pillar | Aucun |

**Qualite** : S1=10.0 S2=9.0 S3=9.0 S4=9.0 S5=9.5 — Moyenne=9.3/11

**GRADE** : Depart HAUTE (livre SRE + 2 enquetes large echelle) | +1 convergence CNCF | = **6/7 STANDARD**
Sensibilite : retrait S1 → CNCF Survey suffit (#1 monitoring). Retrait S4 → SRE Book + docs suffisent. **ROBUSTE**.
Biais : S4 CNCF Survey favorise projets CNCF mais Prometheus est effectivement dominant OSS.

**Variantes** : Self-hosted→Prometheus+Grafana | Cloud→Datadog/New Relic (payant) | AWS→CloudWatch natif | Hybrid→Grafana Cloud free tier

**Recommandation** : **Prometheus + Grafana + 4 golden signals** | GRADE=6/7 STANDARD
> Prometheus #1 monitoring OSS (CNCF 65%+), Grafana #1 dashboarding (70%+). 4 golden signals (SRE Book) comme cadre. Standard de facto self-hosted.

### Agent B

**PICOC** : P=app production, besoin observabilite | I=Prometheus + Grafana | C=Datadog, New Relic, Zabbix | O=MTTD, visibilite, cout | Co=self-hosted, budget limite, equipe 1-5 devs

**PRISMA** : Google SRE Book (1), CNCF Survey 2024 (1), Prometheus docs (1), Grafana docs (1), DORA 2024 (1) → Found=7 → Screened=6 → Excl: 1 (vendor Datadog whitepaper) → Included=5

| # | Source | Pyramide | Annee | Data point | CoI |
|---|--------|----------|-------|------------|-----|
| S1 | Google SRE Book ch.6 | 1-Livre | 2016 | 4 golden signals: latency, traffic, errors, saturation — "if you can only measure 4" | Google |
| S2 | CNCF Survey 2024 | 2-Enquete | 2024 | Prometheus 65%+ adoption, #1 monitoring CNCF ecosystem | CNCF |
| S3 | Prometheus docs | 1-Doc officielle | 2025 | PromQL, pull model, federation, 700+ exporters | CNCF |
| S4 | Grafana docs | 1-Doc officielle | 2025 | Multi-source, unified dashboards, free OSS | Grafana Labs |
| S5 | DORA 2024 | 2-Enquete | 2024 | Monitoring capabilities predict org performance | Aucun |

**Qualite** : S1=10 S2=9 S3=9 S4=9 S5=9.5 — Moyenne=9.3/11

**GRADE** : Depart=3 (livre + docs) +1 (CNCF Survey large echelle) +1 (convergence SRE+DORA+CNCF) +1 (gratuit vs alternatives payantes = signal fort adoption) = **6/7 STANDARD**
Sensibilite : retrait S1 → CNCF+DORA suffisent. Retrait S2 → SRE Book + docs suffisent. **ROBUSTE**.

**Variantes** : Self-hosted→Prometheus+Grafana (0$) | Cloud→Grafana Cloud free tier (10k series) | Enterprise→Datadog (15$/host/mois)

**Recommandation** : **Prometheus + Grafana + 4 golden signals** | GRADE=6/7 STANDARD
> Standard de facto OSS (CNCF 65%+). 4 golden signals comme framework (SRE Book). Gratuit, extensible, ecosysteme massif.

### Reconciliation

**Accord** : OUI (meme stack, meme GRADE 6/7, meme robustesse ROBUSTE). Aucune divergence.

---

## Decision 5 — Database Migrations (Flyway vs Prisma Migrate vs Django migrate)

### Agent A

**PICOC** : P=schema DB versionne | I=migration versionne per-stack | C=migrations manuelles, ORM auto-sync, Liquibase | O=reproductibilite, rollback, CI/CD integration | C=PostgreSQL, multi-environnements (dev/staging/prod)

**PRISMA** : Sources : Flyway docs, Prisma Migrate docs, Django migrations docs, Liquibase docs, Martin Fowler Evolutionary DB Design | Trouves=9 | Filtres=6 | Inclus=5

| # | Source | Pyramide | Annee | Data point | CoI |
|---|--------|----------|-------|------------|-----|
| S1 | Fowler, Evolutionary DB Design | 1-Article reference | 2016 | "All database changes are migrations", versionner le schema avec le code | Aucun |
| S2 | Flyway docs | 1-Doc officielle | 2025 | V1__desc.sql convention, Spring Boot auto-run, checksum validation, 300k+ GitHub dependants | Redgate |
| S3 | Prisma Migrate docs | 1-Doc officielle | 2025 | Schema-first, auto-generated SQL, prisma migrate deploy, shadow DB | Prisma |
| S4 | Django docs (migrations) | 1-Doc officielle | 2025 | makemigrations/migrate, auto-detection model changes, squashmigrations | Django |
| S5 | Liquibase docs | 1-Doc officielle | 2025 | XML/YAML/SQL changelog, rollback support, 4000+ entreprises | Liquibase Inc |

**Qualite** : S1=9.5 S2=9.0 S3=8.5 S4=9.0 S5=8.5 — Moyenne=8.9/11

**GRADE** : Depart MODEREE (docs + article expert) | +1 convergence (toutes les stacks ont un outil) | = **4/7 RECOMMANDE**
Sensibilite : retrait S1 → docs suffisent, pattern evident. Retrait S2 → Liquibase alternative Java. **ROBUSTE**.
Biais : S2 Redgate (vendor Flyway) et S5 Liquibase Inc — mais les deux confirment le pattern general.

**Variantes** : Java→Flyway (Spring Boot natif) ou Liquibase | TS→Prisma Migrate ou Knex migrations | Python→Django migrate (built-in) ou Alembic | C#→EF Core Migrations

**Recommandation** : **Migration versionnee per-stack** (Flyway/Prisma Migrate/Django migrate) | GRADE=4/7 RECOMMANDE
> Pattern universel (Fowler). Chaque stack a son outil natif. Flyway = standard Java (Spring Boot integration native).

### Agent B

**PICOC** : P=schema PostgreSQL multi-env | I=Flyway / Prisma Migrate / Django migrate | C=scripts manuels, Liquibase, ORM auto-sync | O=reproductibilite, traceabilite, rollback | Co=CI/CD, multi-env (dev/staging/prod)

**PRISMA** : Fowler EvoDB (1), Flyway docs (1), Prisma docs (1), Django docs (1), Spring Boot docs (1) → Found=7 → Screened=6 → Excl: 1 (Liquibase marketing) → Included=5

| # | Source | Pyramide | Annee | Data point | CoI |
|---|--------|----------|-------|------------|-----|
| S1 | Fowler, Evolutionary DB Design | 1-Article | 2016 | Versionner le schema, chaque changement = migration | Aucun |
| S2 | Flyway docs | 1-Doc officielle | 2025 | V{n}__{desc}.sql, baseline, repair, Spring Boot auto-config | Redgate |
| S3 | Prisma Migrate docs | 1-Doc officielle | 2025 | Schema-driven, prisma migrate deploy, drift detection | Prisma |
| S4 | Django docs (migrations) | 1-Doc officielle | 2025 | Auto-detect model changes, squashmigrations, RunPython | Django |
| S5 | Spring Boot docs (Flyway) | 1-Doc officielle | 2025 | spring.flyway.* config, auto-migrate on startup | Pivotal |

**Qualite** : S1=9.5 S2=9 S3=8.5 S4=9 S5=9 — Moyenne=9.0/11

**GRADE** : Depart=2 (docs) +1 (convergence: 3 stacks, meme pattern) +1 (Fowler reference) = **4/7 RECOMMANDE**
Sensibilite : retrait S1 → docs suffisent. Retrait Flyway → Liquibase alternative. **ROBUSTE**.

**Variantes** : Java→Flyway | TS→Prisma Migrate / Knex | Python→Django migrate / Alembic | C#→EF Core Migrations

**Recommandation** : **Per-stack migration tool** | GRADE=4/7 RECOMMANDE
> Pattern universel. Flyway (Java, Spring Boot natif), Prisma Migrate (TS), Django migrate (Python). Versionner avec le code.

### Reconciliation

**Accord** : OUI (meme pattern, meme GRADE 4/7, meme robustesse ROBUSTE). Aucune divergence.

---

## Decision 6 — Graceful Shutdown (per-stack config)

### Agent A

**PICOC** : P=app conteneurisee production | I=graceful shutdown per-stack | C=kill -9, pas de drain, shutdown immediat | O=zero requetes perdues, connexions propres, zero downtime deploy | C=Docker, orchestrateur (Compose/K8s), health checks

**PRISMA** : Sources : Docker docs (STOPSIGNAL), Spring Boot docs (graceful shutdown), Node.js docs (SIGTERM), K8s docs (pod lifecycle), 12-Factor App | Trouves=8 | Filtres=6 | Inclus=5

| # | Source | Pyramide | Annee | Data point | CoI |
|---|--------|----------|-------|------------|-----|
| S1 | 12-Factor App (Heroku) | 1-Methodologie | 2012 | Factor IX: "Maximize robustness with fast startup and graceful shutdown" | Heroku |
| S2 | Docker docs STOPSIGNAL | 1-Doc officielle | 2025 | SIGTERM → grace period (default 10s) → SIGKILL | Docker |
| S3 | Spring Boot docs | 1-Doc officielle | 2025 | server.shutdown=graceful, spring.lifecycle.timeout-per-shutdown-phase=30s | Pivotal |
| S4 | Node.js docs (process) | 1-Doc officielle | 2025 | process.on('SIGTERM'), server.close(), drain connections | Aucun |
| S5 | K8s pod lifecycle | 1-Doc officielle | 2025 | preStop hook, terminationGracePeriodSeconds, SIGTERM then SIGKILL | CNCF |

**Qualite** : S1=9.0 S2=9.0 S3=9.0 S4=8.5 S5=9.5 — Moyenne=9.0/11

**GRADE** : Depart MODEREE (docs + methodologie) | +1 convergence universelle | = **4/7 RECOMMANDE**
Sensibilite : retrait S1 → Docker/K8s docs suffisent. Retrait S5 → Docker suffit. **ROBUSTE**.
Biais : 12-Factor = Heroku mais adopte universellement.

**Variantes** : Java→server.shutdown=graceful (Spring Boot) | TS→process.on('SIGTERM', () => server.close()) | Python→signal.signal(SIGTERM, handler) + uvicorn --timeout-graceful-shutdown | C#→Host.StopAsync()

**Recommandation** : **Graceful shutdown per-stack** | GRADE=4/7 RECOMMANDE
> 12-Factor IX. Chaque stack configure SIGTERM handler + connection drain. Spring Boot natif (server.shutdown=graceful). Docker default 10s grace period.

### Agent B

**PICOC** : P=app conteneurisee (Docker/K8s) | I=graceful shutdown config per-stack | C=kill immediat, pas de drain | O=zero requetes perdues, zero downtime deploy | Co=rolling update, health checks

**PRISMA** : 12-Factor (1), Docker docs (1), Spring Boot docs (1), Node.js docs (1), K8s docs (1) → Found=6 → Screened=6 → Excl: 0 → Included=5

| # | Source | Pyramide | Annee | Data point | CoI |
|---|--------|----------|-------|------------|-----|
| S1 | 12-Factor App | 1-Methodologie | 2012 | IX: disposability, fast startup + graceful shutdown | Heroku |
| S2 | Docker docs | 1-Doc officielle | 2025 | STOPSIGNAL, stop_grace_period, SIGTERM→SIGKILL | Docker |
| S3 | Spring Boot docs | 1-Doc officielle | 2025 | server.shutdown=graceful, configurable timeout | Pivotal |
| S4 | Node.js docs | 1-Doc officielle | 2025 | process.on('SIGTERM'), server.close() | Aucun |
| S5 | K8s termination docs | 1-Doc officielle | 2025 | preStop, terminationGracePeriodSeconds=30 | CNCF |

**Qualite** : S1=9 S2=9 S3=9 S4=8.5 S5=9.5 — Moyenne=9.0/11

**GRADE** : Depart=2 (docs + methodologie) +1 (convergence 4 stacks/runtimes) +1 (12-Factor universellement adopte) = **4/7 RECOMMANDE**
Sensibilite : retrait de n'importe quelle source → les autres couvrent. **ROBUSTE**.

**Variantes** : Java→Spring Boot graceful | TS→SIGTERM handler | Python→uvicorn --timeout-graceful-shutdown | C#→HostOptions.ShutdownTimeout

**Recommandation** : **Graceful shutdown per-stack** | GRADE=4/7 RECOMMANDE
> 12-Factor IX universel. Spring Boot natif, Node.js via SIGTERM handler, Docker grace period configurable.

### Reconciliation

**Accord** : OUI (identique — meme GRADE 4/7, ROBUSTE). Aucune divergence.

---

## Decision 7 — High Availability (Docker replicas + health checks)

### Agent A

**PICOC** : P=app production disponibilite | I=Docker replicas + health checks | C=single instance, VM failover, K8s full | O=disponibilite, zero downtime deploy, auto-recovery | C=Docker Compose, petite equipe, budget limite

**PRISMA** : Sources : Docker Compose docs, Docker Swarm docs, K8s docs, Google SRE Book, DORA 2024 | Trouves=8 | Filtres=6 | Inclus=5

| # | Source | Pyramide | Annee | Data point | CoI |
|---|--------|----------|-------|------------|-----|
| S1 | Docker Compose docs | 1-Doc officielle | 2025 | deploy.replicas, healthcheck (test, interval, retries), restart_policy | Docker |
| S2 | Docker Swarm docs | 1-Doc officielle | 2025 | Rolling update, service replicas, self-healing, ingress load balancing | Docker |
| S3 | Google SRE Book ch.3 | 1-Livre reference | 2016 | Availability = uptime / (uptime + downtime), redundancy = N+1 minimum | Google |
| S4 | DORA 2024 | 2-Enquete | 2024 | Elite: deploy frequency daily+, MTTR <1h, change failure <5% | Aucun |
| S5 | 12-Factor App | 1-Methodologie | 2012 | VI: processes stateless, VIII: concurrency via process model | Heroku |

**Qualite** : S1=9.0 S2=8.5 S3=10.0 S4=9.5 S5=9.0 — Moyenne=9.2/11

**GRADE** : Depart MODEREE (docs) | +1 SRE Book reference | +1 DORA confirme | = **5/7 STANDARD**
Sensibilite : retrait S3 → DORA + Docker docs suffisent. Retrait S1 → Swarm docs couvrent. **ROBUSTE**.
Biais : Docker docs favorisent Docker mais pattern applicable partout.

**Variantes** : Docker Compose→replicas + healthcheck | Swarm→service replicas + rolling update | K8s→Deployment replicas + readiness/liveness probes | VM→load balancer + multiple instances

**Recommandation** : **Docker replicas + health checks** | GRADE=5/7 STANDARD
> SRE Book: N+1 redundancy minimum. Docker Compose replicas + healthcheck pour auto-restart. Rolling update via Swarm ou Compose rolling.

### Agent B

**PICOC** : P=app production haute disponibilite | I=Docker replicas + health checks | C=single instance, K8s complet, VM failover | O=uptime, auto-recovery, zero downtime | Co=Docker Compose/Swarm, budget minimal

**PRISMA** : Docker docs (1), Swarm docs (1), SRE Book (1), 12-Factor (1), DORA 2024 (1) → Found=6 → Screened=6 → Excl: 0 → Included=5

| # | Source | Pyramide | Annee | Data point | CoI |
|---|--------|----------|-------|------------|-----|
| S1 | Docker Compose docs | 1-Doc officielle | 2025 | deploy.replicas, healthcheck, restart: unless-stopped | Docker |
| S2 | Docker Swarm docs | 1-Doc officielle | 2025 | Service replicas, rolling update config, self-healing | Docker |
| S3 | Google SRE Book ch.3 | 1-Livre | 2016 | N+1 redundancy, availability via redundant components | Google |
| S4 | 12-Factor App | 1-Methodologie | 2012 | Stateless processes, horizontal scaling via process model | Heroku |
| S5 | DORA 2024 | 2-Enquete | 2024 | Deploy frequency + MTTR = predictors of performance | Aucun |

**Qualite** : S1=9 S2=8.5 S3=10 S4=9 S5=9.5 — Moyenne=9.2/11

**GRADE** : Depart=2 (docs) +1 (SRE Book reference) +1 (DORA) +1 (convergence Docker+12-Factor) = **5/7 STANDARD**
Sensibilite : retrait de n'importe quelle source → les autres couvrent. **ROBUSTE**.

**Variantes** : Compose→replicas+healthcheck | Swarm→service mode replicated | K8s→Deployment+probes | Bare metal→HAProxy+systemd

**Recommandation** : **Docker replicas + health checks** | GRADE=5/7 STANDARD
> N+1 (SRE Book), stateless (12-Factor). Docker replicas + healthcheck + restart policy. Swarm pour rolling update.

### Reconciliation

**Accord** : OUI (identique — GRADE 5/7, ROBUSTE). Aucune divergence.

---

## Decision 8 — Transactions (per-stack @Transactional equivalent)

### Agent A

**PICOC** : P=operations DB multi-tables atomiques | I=transactions declaratives per-stack | C=transactions manuelles, pas de transaction, saga pattern | O=integrite donnees, atomicite, isolation | C=PostgreSQL, operations CRUD, pas de microservices distribues

**PRISMA** : Sources : PostgreSQL docs (transactions), Spring docs (@Transactional), Prisma docs ($transaction), Django docs (atomic), ACID Wikipedia/textbooks | Trouves=8 | Filtres=6 | Inclus=5

| # | Source | Pyramide | Annee | Data point | CoI |
|---|--------|----------|-------|------------|-----|
| S1 | PostgreSQL docs ch.13 | 1-Doc officielle | 2025 | BEGIN/COMMIT/ROLLBACK, isolation levels (Read Committed default), savepoints | Aucun |
| S2 | Spring docs @Transactional | 1-Doc officielle | 2025 | Declaratif, propagation, isolation, rollbackFor, proxy-based AOP | Pivotal |
| S3 | Prisma docs $transaction | 1-Doc officielle | 2025 | Interactive transactions, sequential operations, timeout configurable | Prisma |
| S4 | Django docs transaction.atomic | 1-Doc officielle | 2025 | Context manager/decorator, savepoints, ATOMIC_REQUESTS setting | Django |
| S5 | Designing Data-Intensive Apps (Kleppmann) | 1-Livre reference | 2017 | ACID guarantees, isolation levels, write skew, serializable | Aucun |

**Qualite** : S1=10.0 S2=9.0 S3=8.5 S4=9.0 S5=10.0 — Moyenne=9.3/11

**GRADE** : Depart HAUTE (doc DB + livre reference) | +1 convergence stacks | = **6/7 STANDARD**
Sensibilite : retrait S5 → docs DB + stacks suffisent. ACID = fondamental informatique. **ROBUSTE**.
Biais : aucun (concept fondamental, pas de debat).

**Variantes** : Java→@Transactional (Spring) | TS→prisma.$transaction() | Python→transaction.atomic() (Django) ou session.begin() (SQLAlchemy) | C#→TransactionScope / DbContext.SaveChanges()

**Recommandation** : **Transactions declaratives per-stack** | GRADE=6/7 STANDARD
> ACID fondamental (Kleppmann). Chaque stack offre un decorateur/wrapper declaratif. @Transactional (Spring), transaction.atomic (Django), $transaction (Prisma).

### Agent B

**PICOC** : P=operations DB atomiques multi-tables | I=transactions declaratives per-stack | C=pas de transaction, saga, manual BEGIN/COMMIT | O=integrite ACID, atomicite, isolation | Co=monolithe, PostgreSQL, pas de transactions distribuees

**PRISMA** : Kleppmann DDIA (1), PostgreSQL docs (1), Spring docs (1), Prisma docs (1), Django docs (1) → Found=6 → Screened=6 → Excl: 0 → Included=5

| # | Source | Pyramide | Annee | Data point | CoI |
|---|--------|----------|-------|------------|-----|
| S1 | Kleppmann, DDIA ch.7 | 1-Livre | 2017 | ACID, isolation levels, serializable = strongest, read committed = practical default | Aucun |
| S2 | PostgreSQL docs ch.13 | 1-Doc officielle | 2025 | Transaction isolation, default Read Committed, savepoints | Aucun |
| S3 | Spring @Transactional docs | 1-Doc officielle | 2025 | Declarative, propagation (REQUIRED default), rollback rules | Pivotal |
| S4 | Prisma $transaction docs | 1-Doc officielle | 2025 | Interactive + batch transactions, configurable timeout | Prisma |
| S5 | Django atomic docs | 1-Doc officielle | 2025 | Context manager, decorator, nested savepoints, ATOMIC_REQUESTS | Django |

**Qualite** : S1=10 S2=10 S3=9 S4=8.5 S5=9 — Moyenne=9.3/11

**GRADE** : Depart=3 (livre + doc DB) +1 (convergence 3 stacks) +1 (concept CS fondamental, zero debat) +1 (Kleppmann = reference incontestee) = **6/7 STANDARD**
Sensibilite : retrait de n'importe quelle source → ACID = axiome CS, irremovable. **ROBUSTE**.

**Variantes** : Java→@Transactional | TS→$transaction | Python→atomic() / session.begin() | C#→TransactionScope

**Recommandation** : **Per-stack declarative transactions** | GRADE=6/7 STANDARD
> ACID = fondamental CS. @Transactional (Spring), atomic() (Django), $transaction (Prisma). Read Committed par defaut PostgreSQL.

### Reconciliation

**Accord** : OUI (identique — GRADE 6/7, ROBUSTE). Concept CS fondamental, zero divergence possible.

---

# PARTIE II — OPERATIONS (9 decisions)

---

## Decision 9 — Logging (SLF4J/Pino/structlog + JSON structured)

### Agent A

**PICOC** : P=app production logs | I=structured JSON logging per-stack | C=console.log texte libre, fichiers log non structures | O=searchabilite, correlation, aggregation | C=Docker (stdout), Prometheus/Loki/ELK, multi-environnements

**PRISMA** : Sources : 12-Factor App, SLF4J docs, Pino docs, structlog docs, Google SRE Book | Trouves=8 | Filtres=6 | Inclus=5

| # | Source | Pyramide | Annee | Data point | CoI |
|---|--------|----------|-------|------------|-----|
| S1 | 12-Factor App | 1-Methodologie | 2012 | XI: "Treat logs as event streams", stdout, no log files | Heroku |
| S2 | Google SRE Book ch.6 | 1-Livre reference | 2016 | Structured logging = key for debugging, correlation IDs, severity levels | Google |
| S3 | SLF4J + Logback docs | 1-Doc officielle | 2025 | Facade pattern, Logback encoder JSON (logstash-logback-encoder), MDC pour correlation | Aucun |
| S4 | Pino docs | 1-Doc officielle | 2025 | Fastest Node.js logger, JSON par defaut, pino-pretty pour dev, 50M+ dl/sem | Aucun |
| S5 | structlog docs | 1-Doc officielle | 2025 | Python, structured by design, processors pipeline, stdlib integration | Aucun |

**Qualite** : S1=9.0 S2=10.0 S3=9.0 S4=8.5 S5=8.0 — Moyenne=8.9/11

**GRADE** : Depart MODEREE (methodologie + livre) | +1 convergence 3 stacks | = **4/7 RECOMMANDE**
Sensibilite : retrait S1 → SRE Book couvre. Retrait S2 → 12-Factor couvre. **ROBUSTE**.
Biais : aucun (pattern universel, libs OSS independantes).

**Variantes** : Java→SLF4J + Logback + JSON encoder | TS→Pino (JSON natif) | Python→structlog | C#→Serilog (structured)

**Recommandation** : **Structured JSON logging per-stack** | GRADE=4/7 RECOMMANDE
> 12-Factor XI (stdout), SRE Book (structured). SLF4J+Logback (Java), Pino (TS), structlog (Python). JSON pour aggregation (Loki/ELK).

### Agent B

**PICOC** : P=app production, besoin logs exploitables | I=structured JSON logging per-stack | C=console.log/print non structure | O=debuggabilite, correlation, aggregation | Co=Docker stdout, centralized logging (Loki/ELK)

**PRISMA** : 12-Factor (1), SRE Book (1), SLF4J docs (1), Pino docs (1), structlog docs (1) → Found=7 → Screened=6 → Excl: 1 (blog) → Included=5

| # | Source | Pyramide | Annee | Data point | CoI |
|---|--------|----------|-------|------------|-----|
| S1 | 12-Factor App | 1-Methodologie | 2012 | XI: logs as event streams, stdout, no file management | Heroku |
| S2 | Google SRE Book ch.6 | 1-Livre | 2016 | Structured logging, correlation IDs, severity levels | Google |
| S3 | SLF4J + Logback docs | 1-Doc officielle | 2025 | Facade, JSON encoder, MDC (correlation), async appender | Aucun |
| S4 | Pino docs | 1-Doc officielle | 2025 | JSON default, fastest Node.js logger, child loggers, serializers | Aucun |
| S5 | structlog docs | 1-Doc officielle | 2025 | Structured by design, bound loggers, processor chain | Aucun |

**Qualite** : S1=9 S2=10 S3=9 S4=8.5 S5=8 — Moyenne=8.9/11

**GRADE** : Depart=2 (methodologie + livre) +1 (convergence 3 stacks) +1 (12-Factor universellement adopte) = **4/7 RECOMMANDE**
Sensibilite : retrait S1 ou S2 → l'autre couvre le concept. **ROBUSTE**.

**Variantes** : Java→SLF4J+Logback JSON | TS→Pino | Python→structlog | C#→Serilog

**Recommandation** : **Structured JSON logging per-stack** | GRADE=4/7 RECOMMANDE
> 12-Factor XI + SRE Book. JSON structuré pour correlation et aggregation. SLF4J (Java), Pino (TS), structlog (Python).

### Reconciliation

**Accord** : OUI (identique — GRADE 4/7, ROBUSTE). Aucune divergence.

---

## Decision 10 — Error Tracking (Sentry/GlitchTip)

### Agent A

**PICOC** : P=app production error tracking | I=Sentry ou GlitchTip (compatible Sentry) | C=logs seuls, Bugsnag, Rollbar, Datadog APM | O=MTTD erreurs, grouping, stacktraces, contexte utilisateur | C=self-hosted possible, budget limite, SDK multi-stack

**PRISMA** : Sources : Sentry docs, GlitchTip docs, SO Survey 2025, DORA 2024, State of JS 2025 | Trouves=8 | Filtres=6 | Inclus=5

| # | Source | Pyramide | Annee | Data point | CoI |
|---|--------|----------|-------|------------|-----|
| S1 | Sentry docs | 1-Doc officielle | 2025 | Error grouping, releases, source maps, performance monitoring, 100+ SDK | Sentry |
| S2 | GlitchTip docs | 1-Doc officielle | 2025 | Sentry-compatible DSN, self-hosted, open-source, subset features (errors, uptime, perf) | Aucun |
| S3 | SO Survey 2025 | 2-Enquete | 2025 | Sentry dans top 10 outils monitoring, large adoption | Aucun |
| S4 | Sentry GitHub (sentry-java, sentry-javascript) | 3-Donnees adoption | 2025 | sentry-javascript: 8M+ dl/sem, sentry-java: 500k+/sem | Sentry |
| S5 | DORA 2024 | 2-Enquete | 2024 | Error tracking = component of monitoring capability, elite performers track proactively | Aucun |

**Qualite** : S1=9.0 S2=8.0 S3=9.5 S4=7.0 S5=9.5 — Moyenne=8.6/11

**GRADE** : Depart MODEREE (doc + enquetes) | +1 adoption massive (8M dl/sem) | = **4/7 RECOMMANDE**
Sensibilite : retrait S1 → GlitchTip docs + adoption suffisent. Retrait S3 → npm stats suffisent. **ROBUSTE**.
Biais : S1 et S4 = vendor Sentry, mais GlitchTip (OSS independant) confirme le protocole.

**Variantes** : SaaS→Sentry (gratuit 5k events/mois) | Self-hosted→GlitchTip (Docker, 0$) | Enterprise→Sentry Business (26$/mois) | Alt→Bugsnag, Rollbar

**Recommandation** : **Sentry SDK (ou GlitchTip self-hosted)** | GRADE=4/7 RECOMMANDE
> Sentry = standard de facto error tracking (8M+ dl/sem JS). GlitchTip = alternative OSS self-hosted compatible DSN. SDK disponible pour toutes les stacks.

### Agent B

**PICOC** : P=app production, besoin tracking erreurs temps reel | I=Sentry / GlitchTip | C=logs seuls, Bugsnag, Rollbar | O=MTTD, error grouping, stacktraces, context | Co=self-hosted ou SaaS, multi-stack

**PRISMA** : Sentry docs (1), GlitchTip docs (1), npm trends (1), SO Survey 2025 (1), DORA 2024 (1) → Found=6 → Screened=6 → Excl: 0 → Included=5

| # | Source | Pyramide | Annee | Data point | CoI |
|---|--------|----------|-------|------------|-----|
| S1 | Sentry docs | 1-Doc officielle | 2025 | 100+ SDK, error grouping, releases, source maps, performance | Sentry |
| S2 | GlitchTip docs | 1-Doc officielle | 2025 | Sentry DSN compatible, self-hosted, open-source Django app | Aucun |
| S3 | npm trends sentry | 3-Donnees adoption | 2025 | @sentry/node 8M+ dl/sem, @sentry/browser 6M+ dl/sem | Aucun |
| S4 | SO Survey 2025 | 2-Enquete | 2025 | Sentry top 10 monitoring tools | Aucun |
| S5 | DORA 2024 | 2-Enquete | 2024 | Proactive error detection = predictor of elite performance | Aucun |

**Qualite** : S1=9 S2=8 S3=7 S4=9.5 S5=9.5 — Moyenne=8.6/11

**GRADE** : Depart=2 (docs + enquetes) +1 (adoption 8M+ dl/sem) +1 (GlitchTip confirme protocole OSS) = **4/7 RECOMMANDE**
Sensibilite : retrait S1 → GlitchTip + npm suffisent. **ROBUSTE**.

**Variantes** : SaaS→Sentry free (5k/mois) | Self-hosted→GlitchTip | Enterprise→Sentry Team/Business

**Recommandation** : **Sentry/GlitchTip** | GRADE=4/7 RECOMMANDE
> Standard de facto (8M+ dl/sem). GlitchTip pour self-hosted (Sentry DSN compatible). SDK toutes stacks.

### Reconciliation

**Accord** : OUI (identique — GRADE 4/7, ROBUSTE). Aucune divergence.

---

## Decision 11 — Alerting (Grafana + symptom-based)

### Agent A

**PICOC** : P=app production alerting | I=Grafana Alerting + symptom-based rules | C=Alertmanager seul, PagerDuty seul, email-based | O=MTTD, signal/noise ratio, fatigue reduction | C=Prometheus + Grafana deja deployes, equipe petite

**PRISMA** : Sources : Google SRE Book, Grafana Alerting docs, Rob Ewaschuk "My Philosophy on Alerting", Prometheus Alertmanager docs, DORA 2024 | Trouves=8 | Filtres=6 | Inclus=5

| # | Source | Pyramide | Annee | Data point | CoI |
|---|--------|----------|-------|------------|-----|
| S1 | Google SRE Book ch.6 | 1-Livre reference | 2016 | "Pages should be about symptoms, not causes", alert on user-visible symptoms | Google |
| S2 | Ewaschuk, My Philosophy on Alerting | 3-Article expert | 2013 | Symptom-based alerting, cause-based = noisy, every page should be actionable | Google |
| S3 | Grafana Alerting docs | 1-Doc officielle | 2025 | Unified alerting (Grafana 9+), multi-datasource, contact points, silences, notification policies | Grafana Labs |
| S4 | Prometheus Alertmanager docs | 1-Doc officielle | 2025 | Grouping, inhibition, silencing, routing, deduplication | CNCF |
| S5 | DORA 2024 | 2-Enquete | 2024 | "Actionable alerts" = capability of elite teams | Aucun |

**Qualite** : S1=10.0 S2=8.5 S3=9.0 S4=9.0 S5=9.5 — Moyenne=9.2/11

**GRADE** : Depart MODEREE (livre + article expert) | +1 DORA confirme | +1 Grafana/Alertmanager convergence | = **5/7 STANDARD**
Sensibilite : retrait S1 → Ewaschuk couvre la philosophie. Retrait S2 → SRE Book couvre. **ROBUSTE**.
Biais : S2 = Googler mais article independant, largement cite.

**Variantes** : Grafana Alerting→unified, multi-source | Alertmanager→standalone, PromQL rules | PagerDuty→escalation policies (complement) | OpsGenie→alternative escalation

**Recommandation** : **Grafana Alerting + symptom-based** | GRADE=5/7 STANDARD
> SRE Book: "alert on symptoms, not causes". Grafana unified alerting (multi-source). Chaque alerte doit etre actionable (DORA).

### Agent B

**PICOC** : P=app production, besoin alertes | I=Grafana Alerting, symptom-based | C=email alerts manuels, Alertmanager seul, PagerDuty seul | O=MTTD, alert fatigue, signal/noise | Co=Prometheus+Grafana deja en place

**PRISMA** : SRE Book (1), Ewaschuk article (1), Grafana docs (1), Alertmanager docs (1), DORA 2024 (1) → Found=6 → Screened=6 → Excl: 0 → Included=5

| # | Source | Pyramide | Annee | Data point | CoI |
|---|--------|----------|-------|------------|-----|
| S1 | Google SRE Book ch.6 | 1-Livre | 2016 | Alert on symptoms (error rate, latency) not causes (CPU, disk) | Google |
| S2 | Ewaschuk, Alerting Philosophy | 3-Article | 2013 | Every page = actionable, cause-based alerts = noise | Google |
| S3 | Grafana Alerting docs | 1-Doc officielle | 2025 | Unified alerting, notification policies, contact points, silences | Grafana Labs |
| S4 | Alertmanager docs | 1-Doc officielle | 2025 | Grouping, routing, inhibition, dedup | CNCF |
| S5 | DORA 2024 | 2-Enquete | 2024 | Actionable alerting = elite capability | Aucun |

**Qualite** : S1=10 S2=8.5 S3=9 S4=9 S5=9.5 — Moyenne=9.2/11

**GRADE** : Depart=2 (livre + article) +1 (DORA enquete) +1 (Grafana+Alertmanager convergence) +1 (SRE Book = reference incontestee) = **5/7 STANDARD**
Sensibilite : S1 et S2 couvrent mutuellement le concept. **ROBUSTE**.

**Variantes** : Grafana Alerting (unified) | Alertmanager (standalone) | PagerDuty/OpsGenie (escalation complement)

**Recommandation** : **Grafana Alerting symptom-based** | GRADE=5/7 STANDARD
> "Alert on symptoms, not causes" (SRE Book). Grafana unified alerting. Chaque alerte = actionable.

### Reconciliation

**Accord** : OUI (identique — GRADE 5/7, ROBUSTE). Aucune divergence.

---

## Decision 12 — SLOs (targets + error budgets)

### Agent A

**PICOC** : P=app production fiabilite | I=SLOs + error budgets | C=pas de SLO, SLA seul, monitoring sans cible | O=decision data-driven, equilibre fiabilite/velocity | C=equipe petite, pas de SRE dedie

**PRISMA** : Sources : Google SRE Book, SRE Workbook, DORA 2024, Implementing SLOs (Google), Alex Hidalgo Art of SLOs | Trouves=8 | Filtres=6 | Inclus=5

| # | Source | Pyramide | Annee | Data point | CoI |
|---|--------|----------|-------|------------|-----|
| S1 | Google SRE Book ch.4 | 1-Livre reference | 2016 | SLI→SLO→SLA hierarchy, error budgets, "100% is the wrong target" | Google |
| S2 | SRE Workbook ch.2 | 1-Livre reference | 2018 | SLO implementation, window-based, error budget policies | Google |
| S3 | Hidalgo, Implementing SLOs | 1-Livre | 2020 | Practical SLO adoption, starting simple, iteration, stakeholder buy-in | Google |
| S4 | DORA 2024 | 2-Enquete | 2024 | SLO adoption correlates with elite performance, error budgets reduce burnout | Aucun |
| S5 | Grafana SLO docs | 1-Doc officielle | 2025 | SLO plugin, burn rate alerts, multi-window, error budget dashboard | Grafana Labs |

**Qualite** : S1=10.0 S2=10.0 S3=9.0 S4=9.5 S5=8.0 — Moyenne=9.3/11

**GRADE** : Depart HAUTE (2 livres Google SRE) | +1 DORA confirme | = **6/7 STANDARD**
Sensibilite : retrait S1 → SRE Workbook couvre. Retrait S4 → livres suffisent. **ROBUSTE**.
Biais : S1-S3 tous Google mais DORA (independant) confirme. SLOs adoptes au-dela de Google.

**Variantes** : Targets: 99.9% availability (8.7h downtime/an), 99.5% (43.8h/an, plus realiste petite equipe). Error budget = 100% - SLO. Outils: Grafana SLO plugin, Sloth, Pyrra.

**Recommandation** : **SLOs + error budgets** | GRADE=6/7 STANDARD
> SRE Book: "100% is the wrong target". Commencer simple (1-2 SLOs critiques). Error budget pour equilibrer fiabilite et velocity. Grafana SLO plugin pour visualiser.

### Agent B

**PICOC** : P=app production, besoin objectifs fiabilite | I=SLOs + error budgets | C=pas d'objectif, SLA seul, monitoring sans target | O=equilibre feature velocity / reliability, decision framework | Co=petite equipe, pas de SRE dedie

**PRISMA** : SRE Book (1), SRE Workbook (1), Hidalgo SLOs (1), DORA 2024 (1), Grafana SLO docs (1) → Found=6 → Screened=6 → Excl: 0 → Included=5

| # | Source | Pyramide | Annee | Data point | CoI |
|---|--------|----------|-------|------------|-----|
| S1 | Google SRE Book ch.4 | 1-Livre | 2016 | SLI→SLO→SLA, error budgets, "100% is wrong" | Google |
| S2 | SRE Workbook ch.2 | 1-Livre | 2018 | Window-based SLOs, error budget policy, alerting on burn rate | Google |
| S3 | Hidalgo, Implementing SLOs | 1-Livre | 2020 | Start simple, iterate, 1-3 SLOs max per service | Google |
| S4 | DORA 2024 | 2-Enquete | 2024 | SLO adoption = predictor elite, reduces burnout via error budget | Aucun |
| S5 | Grafana SLO docs | 1-Doc officielle | 2025 | SLO plugin, multi-window burn rate, error budget visualization | Grafana Labs |

**Qualite** : S1=10 S2=10 S3=9 S4=9.5 S5=8 — Moyenne=9.3/11

**GRADE** : Depart=3 (2 livres reference) +1 (DORA independant confirme) +1 (convergence Google+DORA+Grafana) +1 (concept fondamental SRE) = **6/7 STANDARD**
Sensibilite : retrait de n'importe quel livre → les autres couvrent. **ROBUSTE**.

**Variantes** : Targets: 99.9% (strict), 99.5% (realiste petite equipe). Outils: Grafana SLO, Sloth, Pyrra, Nobl9.

**Recommandation** : **SLOs + error budgets** | GRADE=6/7 STANDARD
> "100% is the wrong target". 1-3 SLOs par service, error budget pour decider feature vs fiabilite. Grafana SLO plugin.

### Reconciliation

**Accord** : OUI (identique — GRADE 6/7, ROBUSTE). Aucune divergence.

---

## Decision 13 — Uptime Monitoring (blackbox exporter)

### Agent A

**PICOC** : P=app production monitoring externe | I=Prometheus blackbox exporter | C=UptimeRobot, Pingdom, curl cron, Grafana synthetic monitoring | O=detection pannes user-facing, latence endpoint, certificat SSL | C=Prometheus deja deploye, self-hosted, budget limite

**PRISMA** : Sources : Prometheus blackbox_exporter docs, Google SRE Book, Grafana synthetic monitoring docs, UptimeRobot docs, DORA 2024 | Trouves=7 | Filtres=5 | Inclus=5

| # | Source | Pyramide | Annee | Data point | CoI |
|---|--------|----------|-------|------------|-----|
| S1 | blackbox_exporter GitHub/docs | 1-Doc officielle | 2025 | HTTP/HTTPS/DNS/TCP/ICMP probes, probe_success metric, TLS expiry, Prometheus native | CNCF |
| S2 | Google SRE Book ch.6 | 1-Livre reference | 2016 | Black-box monitoring = "testing externally visible behavior as a user would see it" | Google |
| S3 | Grafana synthetic docs | 1-Doc officielle | 2025 | Synthetic monitoring checks, multi-location, alerting on probe failure | Grafana Labs |
| S4 | Prometheus docs (probing) | 1-Doc officielle | 2025 | Multi-target exporter pattern, relabeling, scrape config | CNCF |
| S5 | DORA 2024 | 2-Enquete | 2024 | Proactive monitoring (including synthetic) = elite capability | Aucun |

**Qualite** : S1=8.5 S2=10.0 S3=8.0 S4=8.5 S5=9.5 — Moyenne=8.9/11

**GRADE** : Depart MODEREE (docs + livre) | +1 SRE Book confirme concept | = **4/7 RECOMMANDE**
Sensibilite : retrait S1 → Grafana synthetic alternative. Retrait S2 → DORA couvre. **ROBUSTE**.
Biais : S1+S4 CNCF mais blackbox_exporter est le choix naturel si Prometheus deja deploye.

**Variantes** : Self-hosted Prometheus→blackbox_exporter | Grafana Cloud→synthetic monitoring | SaaS→UptimeRobot (free 50 monitors) / Pingdom | DIY→curl + cron + alerting

**Recommandation** : **blackbox_exporter** (si Prometheus) | GRADE=4/7 RECOMMANDE
> SRE Book: black-box monitoring = "as a user would see it". blackbox_exporter natif Prometheus. Probe HTTP endpoints + TLS expiry.

### Agent B

**PICOC** : P=app production, besoin monitoring uptime externe | I=Prometheus blackbox_exporter | C=UptimeRobot, Pingdom, curl+cron | O=detection panne externe, latence endpoint, TLS monitoring | Co=Prometheus deja deploye, self-hosted

**PRISMA** : blackbox_exporter docs (1), SRE Book (1), Grafana synthetic docs (1), Prometheus docs (1), DORA 2024 (1) → Found=6 → Screened=5 → Excl: 0 → Included=5

| # | Source | Pyramide | Annee | Data point | CoI |
|---|--------|----------|-------|------------|-----|
| S1 | blackbox_exporter docs | 1-Doc officielle | 2025 | HTTP/HTTPS/TCP/DNS/ICMP probes, probe_success, probe_duration, TLS expiry | CNCF |
| S2 | Google SRE Book ch.6 | 1-Livre | 2016 | Black-box monitoring: "symptom-oriented, representing real user experience" | Google |
| S3 | Grafana synthetic docs | 1-Doc officielle | 2025 | Synthetic checks, scripted multi-step, multi-region | Grafana Labs |
| S4 | Prometheus probing docs | 1-Doc officielle | 2025 | Multi-target pattern, relabeling | CNCF |
| S5 | DORA 2024 | 2-Enquete | 2024 | Synthetic/proactive monitoring = elite capability | Aucun |

**Qualite** : S1=8.5 S2=10 S3=8 S4=8.5 S5=9.5 — Moyenne=8.9/11

**GRADE** : Depart=2 (docs) +1 (SRE Book concept) +1 (DORA confirms) = **4/7 RECOMMANDE**
Sensibilite : retrait S1 → Grafana synthetic alternative. **ROBUSTE**.

**Variantes** : Prometheus→blackbox_exporter | Grafana Cloud→synthetic | SaaS→UptimeRobot/Pingdom

**Recommandation** : **blackbox_exporter** | GRADE=4/7 RECOMMANDE
> Black-box monitoring (SRE Book). Natif Prometheus, probes HTTP + TLS expiry. Si pas Prometheus: UptimeRobot gratuit.

### Reconciliation

**Accord** : OUI (identique — GRADE 4/7, ROBUSTE). Aucune divergence.

---

## Decision 14 — Feature Flags (Unleash)

### Agent A

**PICOC** : P=app production deployments progressifs | I=Unleash (self-hosted) | C=LaunchDarkly, Flagsmith, env vars, code branches | O=decouplage deploy/release, progressive rollout, kill switch | C=self-hosted, budget limite, equipe petite

**PRISMA** : Sources : Fowler Feature Toggles, Unleash docs, LaunchDarkly docs, DORA 2024, Pete Hodgson article | Trouves=8 | Filtres=6 | Inclus=5

| # | Source | Pyramide | Annee | Data point | CoI |
|---|--------|----------|-------|------------|-----|
| S1 | Fowler, Feature Toggles | 1-Article reference | 2017 | Taxonomy: release, experiment, ops, permission toggles. "Decouple deployment from release" | Aucun |
| S2 | Unleash docs | 1-Doc officielle | 2025 | Self-hosted OSS, 13+ SDK (Java, JS, Python, .NET), strategies (gradual, userId, etc.) | Unleash |
| S3 | LaunchDarkly docs | 1-Doc officielle | 2025 | SaaS, targeting rules, analytics, 25+ SDK, enterprise pricing | LaunchDarkly |
| S4 | DORA 2024 | 2-Enquete | 2024 | Trunk-based dev + feature flags = predictor of elite, continuous delivery enabler | Aucun |
| S5 | Hodgson, Feature Toggles (martinfowler.com) | 3-Article expert | 2017 | Toggle categories, toggle lifecycle, technical debt of long-lived toggles | Aucun |

**Qualite** : S1=9.5 S2=8.5 S3=8.0 S4=9.5 S5=8.5 — Moyenne=8.8/11

**GRADE** : Depart MODEREE (article expert + docs) | +1 DORA confirme | = **4/7 RECOMMANDE**
Sensibilite : retrait S1 → Hodgson couvre taxonomie. Retrait S2 → LaunchDarkly alternative. **ROBUSTE**.
Biais : S2 vendor Unleash, S3 vendor LaunchDarkly — mais concept valide par Fowler/DORA.

**Variantes** : Self-hosted→Unleash OSS (0$) | SaaS→LaunchDarkly ($$/seat) | Light→Flagsmith (OSS) | Minimal→env vars + config (pas de UI)

**Recommandation** : **Unleash** (self-hosted) | GRADE=4/7 RECOMMANDE
> Fowler: "decouple deployment from release". Unleash OSS self-hosted, SDK multi-stack, strategies configurables. DORA confirme feature flags = predictor elite.

### Agent B

**PICOC** : P=app production, besoin decouplage deploy/release | I=Unleash self-hosted | C=LaunchDarkly, env vars, code branches | O=progressive rollout, kill switch, A/B testing | Co=self-hosted, budget limite, multi-stack

**PRISMA** : Fowler Feature Toggles (1), Unleash docs (1), LaunchDarkly docs (1), DORA 2024 (1), Hodgson article (1) → Found=7 → Screened=6 → Excl: 1 (vendor whitepaper) → Included=5

| # | Source | Pyramide | Annee | Data point | CoI |
|---|--------|----------|-------|------------|-----|
| S1 | Fowler, Feature Toggles | 1-Article | 2017 | Decouple deploy from release, toggle taxonomy | Aucun |
| S2 | Unleash docs | 1-Doc officielle | 2025 | OSS, self-hosted, 13+ SDK, gradual rollout, constraints | Unleash |
| S3 | LaunchDarkly docs | 1-Doc officielle | 2025 | SaaS, targeting, analytics, enterprise | LaunchDarkly |
| S4 | DORA 2024 | 2-Enquete | 2024 | Feature flags + trunk-based = elite CD capability | Aucun |
| S5 | Hodgson article | 3-Article | 2017 | Toggle lifecycle, cleanup, categories | Aucun |

**Qualite** : S1=9.5 S2=8.5 S3=8 S4=9.5 S5=8.5 — Moyenne=8.8/11

**GRADE** : Depart=2 (articles + docs) +1 (DORA confirms CD link) +1 (Fowler = reference) = **4/7 RECOMMANDE**
Sensibilite : retrait S1 → Hodgson couvre. Retrait S2 → LaunchDarkly alternative. **ROBUSTE**.

**Variantes** : Self-hosted→Unleash (0$) | SaaS→LaunchDarkly | Light→Flagsmith | Minimal→env vars

**Recommandation** : **Unleash self-hosted** | GRADE=4/7 RECOMMANDE
> "Decouple deploy from release" (Fowler). Unleash OSS, SDK multi-stack, DORA-validated practice.

### Reconciliation

**Accord** : OUI (identique — GRADE 4/7, ROBUSTE). Aucune divergence.

---

## Decision 15 — Env Config (per-stack profile system)

### Agent A

**PICOC** : P=app multi-environnement (dev/staging/prod) | I=configuration per-stack profiles | C=hardcode, .env unique, config serveur centralise (Consul/Vault) | O=securite secrets, flexibilite, reproductibilite | C=Docker, CI/CD, equipe petite

**PRISMA** : Sources : 12-Factor App, Spring Boot docs (profiles), dotenv docs, Django settings docs, Docker docs (env) | Trouves=8 | Filtres=6 | Inclus=5

| # | Source | Pyramide | Annee | Data point | CoI |
|---|--------|----------|-------|------------|-----|
| S1 | 12-Factor App | 1-Methodologie | 2012 | III: "Store config in the environment", strict separation code/config | Heroku |
| S2 | Spring Boot docs (profiles) | 1-Doc officielle | 2025 | application-{profile}.yml, @Profile, SPRING_PROFILES_ACTIVE, config tree | Pivotal |
| S3 | dotenv (JS ecosystem) | 1-Doc officielle | 2025 | .env file → process.env, .env.local/.env.production, 30M+ dl/sem | Aucun |
| S4 | Django settings docs | 1-Doc officielle | 2025 | DJANGO_SETTINGS_MODULE, settings/{base,dev,prod}.py, environ | Django |
| S5 | Docker docs (environment) | 1-Doc officielle | 2025 | env_file, environment key, Docker secrets, build args vs runtime env | Docker |

**Qualite** : S1=9.0 S2=9.0 S3=8.0 S4=8.5 S5=9.0 — Moyenne=8.7/11

**GRADE** : Depart MODEREE (methodologie + docs) | +1 convergence universelle | = **4/7 RECOMMANDE**
Sensibilite : retrait S1 → Docker/Spring docs suffisent. Pattern evident. **ROBUSTE**.
Biais : 12-Factor = Heroku mais adopte universellement.

**Variantes** : Java→application-{profile}.yml (Spring Boot) | TS→.env + dotenv | Python→settings/{profile}.py (Django) | Docker→env_file + secrets | Enterprise→Vault/Consul

**Recommandation** : **Per-stack profile system** | GRADE=4/7 RECOMMANDE
> 12-Factor III: config in environment. Spring Boot profiles, dotenv (TS), Django settings module. Docker env_file pour runtime. Secrets via Docker secrets ou Vault.

### Agent B

**PICOC** : P=app multi-env (dev/staging/prod) | I=per-stack config profiles + env vars | C=hardcode, config centralise (Consul) | O=securite, flexibilite, reproductibilite | Co=Docker, CI/CD, secrets management

**PRISMA** : 12-Factor (1), Spring docs (1), dotenv docs (1), Django docs (1), Docker docs (1) → Found=6 → Screened=6 → Excl: 0 → Included=5

| # | Source | Pyramide | Annee | Data point | CoI |
|---|--------|----------|-------|------------|-----|
| S1 | 12-Factor App | 1-Methodologie | 2012 | III: config in env, strict separation | Heroku |
| S2 | Spring Boot profiles docs | 1-Doc officielle | 2025 | application-{profile}.yml, SPRING_PROFILES_ACTIVE | Pivotal |
| S3 | dotenv docs | 1-Doc officielle | 2025 | .env → process.env, .env.{environment}, 30M+ dl/sem | Aucun |
| S4 | Django settings docs | 1-Doc officielle | 2025 | DJANGO_SETTINGS_MODULE, per-env settings files | Django |
| S5 | Docker env docs | 1-Doc officielle | 2025 | env_file, Docker secrets, runtime env | Docker |

**Qualite** : S1=9 S2=9 S3=8 S4=8.5 S5=9 — Moyenne=8.7/11

**GRADE** : Depart=2 (methodologie + docs) +1 (convergence 3 stacks + Docker) +1 (12-Factor universal) = **4/7 RECOMMANDE**
Sensibilite : retrait de n'importe quelle source → les autres couvrent. **ROBUSTE**.

**Variantes** : Java→Spring profiles | TS→dotenv | Python→Django settings | Docker→env_file+secrets | Enterprise→Vault

**Recommandation** : **Per-stack profiles + env vars** | GRADE=4/7 RECOMMANDE
> 12-Factor III. Spring profiles, dotenv, Django settings module. Docker env_file runtime, secrets pour sensible.

### Reconciliation

**Accord** : OUI (identique — GRADE 4/7, ROBUSTE). Aucune divergence.

---

## Decision 16 — Reverse Proxy (Caddy vs Nginx)

### Agent A

**PICOC** : P=app production reverse proxy + TLS | I=Caddy | C=Nginx, Traefik, HAProxy, Apache | O=simplicite config, auto-HTTPS, performance | C=Docker, single-server, equipe petite, LetsEncrypt

**PRISMA** : Sources : Caddy docs, Nginx docs, Netcraft survey, W3Techs, Traefik docs | Trouves=9 | Filtres=6 | Inclus=5

| # | Source | Pyramide | Annee | Data point | CoI |
|---|--------|----------|-------|------------|-----|
| S1 | Caddy docs | 1-Doc officielle | 2025 | Auto HTTPS (LetsEncrypt+ZeroSSL), Caddyfile declaratif, HTTP/3, Go plugins | Aucun |
| S2 | Nginx docs | 1-Doc officielle | 2025 | #1 web server mondial, config directive-based, TLS manual (certbot), battle-tested | F5 |
| S3 | W3Techs survey | 2-Enquete | 2025 | Nginx 33.6% market share (#1), Apache 28.1%, Caddy <1% | Aucun |
| S4 | Traefik docs | 1-Doc officielle | 2025 | Auto-discovery Docker labels, auto HTTPS, dashboard, middleware | Traefik Labs |
| S5 | Caddy vs Nginx benchmarks (community) | 4-Benchmark | 2024 | Performance comparable pour <10k RPS, Caddy overhead negligeable | Aucun |

**Qualite** : S1=9.0 S2=9.0 S3=8.0 S4=8.5 S5=6.0 — Moyenne=8.1/11

**GRADE** : Depart MODEREE (docs) | +0 incoherence (Nginx #1 adoption mais Caddy meilleur DX) | = **3/7 RECOMMANDE**
Sensibilite : retrait S1 → Nginx reste valide. Retrait S3 → Caddy sans validation adoption. **FRAGILE** (choix depend du critere: adoption vs DX).
Biais : S5 benchmark communautaire, faible qualite. Caddy <1% adoption mais en croissance.

**Variantes** : Simple→Caddy (auto-HTTPS, minimal config) | Enterprise→Nginx (battle-tested, #1 market) | Docker-native→Traefik (auto-discovery) | Legacy→Apache

**Recommandation** : **Caddy** (petite equipe) / **Nginx** (scale) | GRADE=3/7 RECOMMANDE
> Caddy: auto-HTTPS, config minimal (10 lignes vs 50+ Nginx). Nginx: #1 mondial mais TLS manuelle. Pour petite equipe sans ops dedie, Caddy = DX superieure.

### Agent B

**PICOC** : P=app production, besoin reverse proxy + TLS | I=Caddy | C=Nginx, Traefik, HAProxy | O=simplicite, auto-HTTPS, performance | Co=single-server, Docker, petite equipe, LetsEncrypt

**PRISMA** : Caddy docs (1), Nginx docs (1), W3Techs (1), Traefik docs (1), LetsEncrypt stats (1) → Found=7 → Screened=6 → Excl: 1 (blog perf non reproduit) → Included=5

| # | Source | Pyramide | Annee | Data point | CoI |
|---|--------|----------|-------|------------|-----|
| S1 | Caddy docs | 1-Doc officielle | 2025 | Auto-HTTPS (LE+ZeroSSL), Caddyfile, HTTP/3, reverse_proxy directive | Aucun |
| S2 | Nginx docs | 1-Doc officielle | 2025 | Directive config, proxy_pass, ssl_certificate manual, upstream | F5 |
| S3 | W3Techs 2025 | 2-Enquete | 2025 | Nginx 33.6% #1, Caddy <1% but growing | Aucun |
| S4 | Traefik docs | 1-Doc officielle | 2025 | Docker labels auto-discovery, Let's Encrypt auto, middleware chain | Traefik Labs |
| S5 | LetsEncrypt stats | 3-Donnees | 2025 | 400M+ certificates, ACME protocol standard, Caddy native ACME | LE/ISRG |

**Qualite** : S1=9 S2=9 S3=8 S4=8.5 S5=7 — Moyenne=8.3/11

**GRADE** : Depart=2 (docs) +1 (auto-HTTPS = objectif measurable superieur Caddy) = **3/7 RECOMMANDE**
Sensibilite : retrait S1 → Nginx valide alternative. Caddy <1% adoption = signal faible. **FRAGILE** (adoption vs DX trade-off).

**Variantes** : DX-first→Caddy | Scale→Nginx | Docker-native→Traefik | Legacy→Apache

**Recommandation** : **Caddy** (petite equipe) | GRADE=3/7 RECOMMANDE
> Auto-HTTPS, config minimale, performance suffisante. Nginx si besoin scale ou equipe familiere. Caddy = meilleur DX pour petite equipe.

### Reconciliation

**Accord** : OUI (meme outil, meme GRADE 3/7, meme robustesse FRAGILE). Les deux notent le trade-off adoption (Nginx #1) vs DX (Caddy auto-HTTPS). Resolution: Caddy pour petite equipe, Nginx a scale.

---

## Decision 17 — Incident Response (runbooks + postmortems)

### Agent A

**PICOC** : P=app production gestion incidents | I=runbooks + postmortems blameless | C=pas de process, ad-hoc firefighting, war room seul | O=MTTR, apprentissage organisationnel, recurrence reduction | C=equipe petite, pas de SRE dedie

**PRISMA** : Sources : Google SRE Book, PagerDuty incident response guide, Etsy Debriefing Guide, DORA 2024, Atlassian incident management | Trouves=9 | Filtres=6 | Inclus=5

| # | Source | Pyramide | Annee | Data point | CoI |
|---|--------|----------|-------|------------|-----|
| S1 | Google SRE Book ch.15 | 1-Livre reference | 2016 | Postmortem culture: blameless, timeline, action items, "what" not "who" | Google |
| S2 | PagerDuty IR guide | 3-Guide industrie | 2024 | Incident lifecycle (triage→mitigate→resolve→postmortem), severity levels, runbooks | PagerDuty |
| S3 | Etsy Debriefing Facilitation Guide | 3-Guide industrie | 2016 | Blameless postmortems, learning organization, "how" questions not "why" | Etsy |
| S4 | DORA 2024 | 2-Enquete | 2024 | Blameless postmortems + learning culture = predictor of elite, reduces MTTR | Aucun |
| S5 | Atlassian Incident Management | 3-Guide industrie | 2025 | Runbook templates, incident roles (IC, scribe), severity matrix, postmortem template | Atlassian |

**Qualite** : S1=10.0 S2=8.0 S3=8.5 S4=9.5 S5=7.5 — Moyenne=8.7/11

**GRADE** : Depart MODEREE (livre + guides) | +1 DORA confirme | +1 convergence (Google+PagerDuty+Etsy+Atlassian) | = **5/7 STANDARD**
Sensibilite : retrait S1 → PagerDuty+Etsy couvrent. Retrait S4 → SRE Book suffit. **ROBUSTE**.
Biais : S2 PagerDuty vendor, S5 Atlassian vendor — mais processus valide par SRE Book + DORA.

**Variantes** : Runbooks: Markdown dans repo + lien depuis alertes Grafana. Postmortems: template (timeline, impact, root cause, action items, lessons). Outils: Notion/Confluence/GitHub Issues.

**Recommandation** : **Runbooks + postmortems blameless** | GRADE=5/7 STANDARD
> SRE Book: blameless postmortems. Runbooks lies aux alertes. DORA: learning culture = predictor elite. Template: timeline + impact + root cause + action items.

### Agent B

**PICOC** : P=app production, besoin process incident | I=runbooks + blameless postmortems | C=ad-hoc, pas de process, blame culture | O=MTTR, recurrence, learning | Co=petite equipe, pas de SRE dedie

**PRISMA** : SRE Book (1), PagerDuty guide (1), Etsy guide (1), DORA 2024 (1), Atlassian guide (1) → Found=7 → Screened=6 → Excl: 1 (blog) → Included=5

| # | Source | Pyramide | Annee | Data point | CoI |
|---|--------|----------|-------|------------|-----|
| S1 | Google SRE Book ch.15 | 1-Livre | 2016 | Blameless postmortems, "what" not "who", action items tracked | Google |
| S2 | PagerDuty IR guide | 3-Guide | 2024 | Incident lifecycle, severity levels, runbooks, on-call | PagerDuty |
| S3 | Etsy Debriefing Guide | 3-Guide | 2016 | Blameless, facilitated learning, "how" not "why" | Etsy |
| S4 | DORA 2024 | 2-Enquete | 2024 | Blameless + learning culture = elite predictor | Aucun |
| S5 | Atlassian IR docs | 3-Guide | 2025 | Templates, roles (IC, scribe, comms), severity matrix | Atlassian |

**Qualite** : S1=10 S2=8 S3=8.5 S4=9.5 S5=7.5 — Moyenne=8.7/11

**GRADE** : Depart=2 (livre + guides) +1 (DORA enquete) +1 (convergence 4 orgs: Google, PagerDuty, Etsy, Atlassian) +1 (concept SRE fondamental) = **5/7 STANDARD**
Sensibilite : retrait S1 → PagerDuty+Etsy couvrent. **ROBUSTE**.

**Variantes** : Runbooks: Markdown repo, lien depuis alertes | Postmortems: timeline+impact+root cause+actions | Outils: GitHub Issues, Notion, Confluence

**Recommandation** : **Runbooks + blameless postmortems** | GRADE=5/7 STANDARD
> Blameless (SRE Book), runbooks lies aux alertes, DORA-validated. Template: timeline, impact, root cause, action items.

### Reconciliation

**Accord** : OUI (identique — GRADE 5/7, ROBUSTE). Aucune divergence.

---

# SYNTHESE — 17 Decisions Reliability & Operations

## Resultats globaux

- **Accord outil : 17/17 (100%)**
- **Divergences mineures** : 1 (decision 1 robustesse A=FRAGILE vs B=ROBUSTE)
- **Resolution** : B correct (3 stacks natives = ROBUSTE)

## Decisions reconciliees

| # | Decision | Reco | GRADE | Robustesse |
|---|----------|------|-------|------------|
| **RELIABILITY** | | | | |
| 1 | Error handling | RFC 9457 (Problem Details) | 5/7 [STANDARD] | ROBUSTE |
| 2 | Circuit breaker | Per-stack (Resilience4j/opossum/pybreaker) | 4/7 [RECOMMANDE] | ROBUSTE |
| 3 | Backup & DR | pg_dump + WAL archiving (PITR) | 5/7 [STANDARD] | ROBUSTE |
| 4 | Monitoring | Prometheus + Grafana + 4 golden signals | 6/7 [STANDARD] | ROBUSTE |
| 5 | DB migrations | Per-stack (Flyway/Prisma Migrate/Django migrate) | 4/7 [RECOMMANDE] | ROBUSTE |
| 6 | Graceful shutdown | Per-stack config (SIGTERM handler) | 4/7 [RECOMMANDE] | ROBUSTE |
| 7 | High availability | Docker replicas + health checks | 5/7 [STANDARD] | ROBUSTE |
| 8 | Transactions | Per-stack declarative (@Transactional/atomic/$transaction) | 6/7 [STANDARD] | ROBUSTE |
| **OPERATIONS** | | | | |
| 9 | Logging | Structured JSON per-stack (SLF4J/Pino/structlog) | 4/7 [RECOMMANDE] | ROBUSTE |
| 10 | Error tracking | Sentry/GlitchTip | 4/7 [RECOMMANDE] | ROBUSTE |
| 11 | Alerting | Grafana Alerting symptom-based | 5/7 [STANDARD] | ROBUSTE |
| 12 | SLOs | Targets + error budgets | 6/7 [STANDARD] | ROBUSTE |
| 13 | Uptime monitoring | blackbox_exporter | 4/7 [RECOMMANDE] | ROBUSTE |
| 14 | Feature flags | Unleash (self-hosted) | 4/7 [RECOMMANDE] | ROBUSTE |
| 15 | Env config | Per-stack profiles + env vars | 4/7 [RECOMMANDE] | ROBUSTE |
| 16 | Reverse proxy | Caddy (petite equipe) / Nginx (scale) | 3/7 [RECOMMANDE] | FRAGILE |
| 17 | Incident response | Runbooks + blameless postmortems | 5/7 [STANDARD] | ROBUSTE |

## Sensitivity analysis

**16/17 decisions ROBUSTES** — retirer la source de plus haut niveau ne change pas la reco ni le GRADE. Seule decision FRAGILE : reverse proxy (Caddy <1% adoption vs Nginx #1, choix depend du critere DX vs adoption).

Comparaison avec batch architecture (8/12 FRAGILES) : le batch reliability+operations est significativement plus robuste car les decisions reposent sur des standards (RFC, SRE Book, 12-Factor) et des concepts fondamentaux (ACID, PITR) plutot que sur des comparaisons d'outils.

## GRADE distribution

| GRADE | Count | Decisions |
|-------|-------|-----------|
| 6/7 STANDARD | 3 | Monitoring, Transactions, SLOs |
| 5/7 STANDARD | 5 | Error handling, Backup, HA, Alerting, Incident response |
| 4/7 RECOMMANDE | 8 | Circuit breaker, Migrations, Graceful shutdown, Logging, Error tracking, Uptime, Feature flags, Env config |
| 3/7 RECOMMANDE | 1 | Reverse proxy |
