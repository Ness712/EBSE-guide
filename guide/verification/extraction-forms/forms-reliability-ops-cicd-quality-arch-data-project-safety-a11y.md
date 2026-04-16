# Formulaires d'extraction — Reliability, Operations, CI/CD, Code Quality, Architecture, Data, Project, Safety, Accessibility

---

## RELIABILITY

---

### error-handling.md

SOURCE 1:
  Nom: RFC 9457 — Problem Details for HTTP APIs
  URL: https://www.rfc-editor.org/rfc/rfc9457
  Niveau pyramide: 1
  Date: 2023
  Citation: Standard IETF pour le format de reponse d'erreur HTTP (ProblemDetail). Utilise comme contrat front-back.
  Conflit d'interet: non — standard ouvert IETF

SOURCE 2:
  Nom: RFC 9110 — HTTP Semantics, Section 15
  URL: https://www.rfc-editor.org/rfc/rfc9110#section-15
  Niveau pyramide: 1
  Date: 2022
  Citation: Definition des status codes HTTP et leur semantique (4xx = erreur client, 5xx = erreur serveur).
  Conflit d'interet: non — standard ouvert IETF

SOURCE 3:
  Nom: SWEBOK v4 — Construction Quality
  URL: voir docs officielles
  Niveau pyramide: 1
  Date: 2024
  Citation: "Error handling should be planned as an architectural concern, not left to individual developers' judgment at each call site." Error handling represents 30-50% of production code.
  Conflit d'interet: non — standard IEEE

SOURCE 4:
  Nom: OWASP Error Handling Cheat Sheet
  URL: https://cheatsheetseries.owasp.org/cheatsheets/Error_Handling_Cheat_Sheet.html
  Niveau pyramide: 2
  Date: ongoing
  Citation: Centraliser le traitement des erreurs, ne jamais exposer de details internes, ne jamais afficher de detail technique cote client.
  Conflit d'interet: non — organisation a but non lucratif

SOURCE 5:
  Nom: OWASP Top 10 A05 — Security Misconfiguration
  URL: https://owasp.org/Top10/A05_2021-Security_Misconfiguration/
  Niveau pyramide: 2
  Date: 2021
  Citation: "Error handling reveals stack traces or other overly informative error messages to users." 208 387 occurrences, 90% des apps testees.
  Conflit d'interet: non — organisation a but non lucratif

SOURCE 6:
  Nom: CWE-209 — Generation of Error Message Containing Sensitive Information
  URL: https://cwe.mitre.org/data/definitions/209.html
  Niveau pyramide: 2
  Date: ongoing
  Citation: Messages d'erreur contenant des infos sensibles. Likelihood of Exploit = HIGH.
  Conflit d'interet: non — MITRE, organisme independant

SOURCE 7:
  Nom: Spring Boot docs — RFC 9457 / @ControllerAdvice
  URL: https://docs.spring.io/spring-boot/
  Niveau pyramide: 3
  Date: ongoing
  Citation: RFC 9457 natif depuis Spring 6.0. @ControllerAdvice pour centraliser le traitement des erreurs.
  Conflit d'interet: oui potentiel — documentation du vendeur (VMware/Broadcom)

SOURCE 8:
  Nom: React docs — Error Boundaries
  URL: https://react.dev/
  Niveau pyramide: 3
  Date: ongoing
  Citation: Error Boundaries par section fonctionnelle, fallback UI pour les erreurs de rendu.
  Conflit d'interet: oui potentiel — documentation du vendeur (Meta)

SOURCE 9:
  Nom: McConnell — Code Complete
  URL: voir docs officielles
  Niveau pyramide: 5
  Date: 2004
  Citation: "The worst thing is to ignore an error." Ne jamais avaler une exception silencieusement.
  Conflit d'interet: non — auteur independant

SOURCE 10:
  Nom: Nygard — Release It!
  URL: voir docs officielles
  Niveau pyramide: 5
  Date: 2018
  Citation: Unhandled exceptions = #1 cause of cascading failures.
  Conflit d'interet: non — auteur independant

---

### circuit-breaker.md

SOURCE 1:
  Nom: Resilience4j docs
  URL: https://resilience4j.readme.io/
  Niveau pyramide: 3
  Date: ongoing
  Citation: Successeur de Netflix Hystrix (deprecie 2018). Librairie Java pour circuit breaker, retry, etc.
  Conflit d'interet: non — projet open source

SOURCE 2:
  Nom: Spring Cloud Circuit Breaker
  URL: https://spring.io/projects/spring-cloud-circuitbreaker
  Niveau pyramide: 3
  Date: ongoing
  Citation: Integration Spring Cloud pour Resilience4j.
  Conflit d'interet: oui potentiel — documentation du vendeur (VMware/Broadcom)

SOURCE 3:
  Nom: Nygard — Release It!
  URL: voir docs officielles
  Niveau pyramide: 5
  Date: 2018
  Citation: Circuit breaker = #1 stability pattern.
  Conflit d'interet: non — auteur independant

SOURCE 4:
  Nom: Netflix Hystrix deprecation → Resilience4j
  URL: voir docs officielles
  Niveau pyramide: 3
  Date: 2018
  Citation: Hystrix deprecie en 2018, Resilience4j est le successeur recommande.
  Conflit d'interet: non — transition open source

---

### backup-recovery.md

SOURCE 1:
  Nom: PostgreSQL docs Ch. 26 — Continuous Archiving and PITR
  URL: https://www.postgresql.org/docs/current/continuous-archiving.html
  Niveau pyramide: 3
  Date: ongoing
  Citation: WAL archiving pour point-in-time recovery, pg_dump pour backup logique.
  Conflit d'interet: non — documentation open source

SOURCE 2:
  Nom: ISO 27001 A.8.13 — Information backup
  URL: voir docs officielles
  Niveau pyramide: 1
  Date: 2022
  Citation: Exigences de backup des donnees, RPO/RTO definis.
  Conflit d'interet: non — standard international ISO

SOURCE 3:
  Nom: SWEBOK v4 Ch.12 — Software Maintenance
  URL: voir docs officielles
  Niveau pyramide: 1
  Date: 2024
  Citation: Maintenance inclut la sauvegarde et la reprise apres sinistre.
  Conflit d'interet: non — standard IEEE

SOURCE 4:
  Nom: Google SRE Book — Data integrity
  URL: https://sre.google/sre-book/
  Niveau pyramide: 5
  Date: 2016
  Citation: Strategies de protection de l'integrite des donnees. Un backup non teste n'est pas un backup.
  Conflit d'interet: oui potentiel — publie par Google, promoteur de ses propres pratiques

---

### monitoring.md

SOURCE 1:
  Nom: SWEBOK v4 chap. 6
  URL: voir docs officielles
  Niveau pyramide: 1
  Date: 2024
  Citation: Monitoring multi-couche obligatoire au niveau application.
  Conflit d'interet: non — standard IEEE

SOURCE 2:
  Nom: OWASP A09:2021 — Security Logging and Monitoring Failures
  URL: https://owasp.org/Top10/A09_2021-Security_Logging_and_Monitoring_Failures/
  Niveau pyramide: 2
  Date: 2021
  Citation: Logging des evenements de securite obligatoire.
  Conflit d'interet: non — organisation a but non lucratif

SOURCE 3:
  Nom: Google SRE Book chap. 6 — Four Golden Signals
  URL: https://sre.google/sre-book/monitoring-distributed-systems/
  Niveau pyramide: 5
  Date: 2016
  Citation: Latency, Traffic, Errors, Saturation = 4 golden signals a monitorer.
  Conflit d'interet: oui potentiel — publie par Google

SOURCE 4:
  Nom: CNCF — Prometheus et OpenTelemetry projets gradues
  URL: https://www.cncf.io/projects/
  Niveau pyramide: 2
  Date: ongoing
  Citation: Prometheus et OpenTelemetry sont des projets gradues CNCF, standard vendor-agnostic. Prometheus 67% adoption open source.
  Conflit d'interet: non — fondation neutre (Linux Foundation)

SOURCE 5:
  Nom: SO Survey 2025 — Prometheus+Grafana 43%, Sentry 32%
  URL: https://survey.stackoverflow.co/
  Niveau pyramide: 4
  Date: 2025
  Citation: Prometheus+Grafana 43% adoption, Sentry 32% adoption parmi les outils d'observabilite.
  Conflit d'interet: non — enquete communautaire

SOURCE 6:
  Nom: Twelve-Factor App — Logs as event streams
  URL: https://12factor.net/logs
  Niveau pyramide: 5
  Date: 2012
  Citation: Traiter les logs comme des flux d'evenements.
  Conflit d'interet: oui potentiel — cree par Heroku (Salesforce)

---

### database-migrations.md

SOURCE 1:
  Nom: Spring Boot docs — Flyway auto-configuration
  URL: https://docs.spring.io/spring-boot/
  Niveau pyramide: 3
  Date: ongoing
  Citation: Flyway auto-configure par Spring Boot, migration best practices. Aucune dependance supplementaire si flyway-core dans le classpath.
  Conflit d'interet: oui potentiel — documentation du vendeur

SOURCE 2:
  Nom: Flyway docs — naming conventions, repeatable migrations
  URL: https://documentation.red-gate.com/flyway
  Niveau pyramide: 3
  Date: ongoing
  Citation: Conventions de nommage V{n}__ et R__, checksum validation, migrations versionnees.
  Conflit d'interet: oui — Redgate (vendeur commercial de Flyway)

SOURCE 3:
  Nom: Fowler — Evolutionary Database Design
  URL: https://martinfowler.com/articles/evodb.html
  Niveau pyramide: 5
  Date: 2016
  Citation: Versioned migrations, approche evolutive du schema de base de donnees.
  Conflit d'interet: non — auteur independant (mais employe ThoughtWorks)

---

### graceful-shutdown.md

SOURCE 1:
  Nom: Spring Boot docs — Graceful shutdown
  URL: https://docs.spring.io/spring-boot/
  Niveau pyramide: 3
  Date: ongoing
  Citation: server.shutdown=graceful active le drain de connexions. timeout-per-shutdown-phase pour le delai.
  Conflit d'interet: oui potentiel — documentation du vendeur

SOURCE 2:
  Nom: Docker docs — SIGTERM/SIGKILL lifecycle
  URL: https://docs.docker.com/
  Niveau pyramide: 3
  Date: ongoing
  Citation: Docker envoie SIGTERM puis SIGKILL apres stop_grace_period. Lifecycle des conteneurs.
  Conflit d'interet: oui potentiel — documentation du vendeur

SOURCE 3:
  Nom: Twelve-Factor Factor IX — Disposability
  URL: https://12factor.net/disposability
  Niveau pyramide: 5
  Date: 2012
  Citation: Fast shutdown, graceful shutdown, disposability des processus.
  Conflit d'interet: oui potentiel — cree par Heroku (Salesforce)

SOURCE 4:
  Nom: SWEBOK v4 — Reliability, fault tolerance
  URL: voir docs officielles
  Niveau pyramide: 1
  Date: 2024
  Citation: Fiabilite et tolerance aux pannes comme exigences de qualite.
  Conflit d'interet: non — standard IEEE

---

## OPERATIONS

---

### logging.md

SOURCE 1:
  Nom: ISO/IEC 27002:2022 Control 8.15
  URL: voir docs officielles
  Niveau pyramide: 1
  Date: 2022
  Citation: Audit logs obligatoires avec 5 champs, protection append-only, separation des droits, retention >= 1 an, chiffrement.
  Conflit d'interet: non — standard international ISO

SOURCE 2:
  Nom: SWEBOK v4 — logging at application level
  URL: voir docs officielles
  Niveau pyramide: 1
  Date: 2024
  Citation: "Logging must be collected and analyzed" at application level.
  Conflit d'interet: non — standard IEEE

SOURCE 3:
  Nom: OWASP Logging Cheat Sheet
  URL: https://cheatsheetseries.owasp.org/cheatsheets/Logging_Cheat_Sheet.html
  Niveau pyramide: 2
  Date: ongoing
  Citation: Format structure, evenements a logger, never log PII. Sanitization des inputs contre log injection.
  Conflit d'interet: non — organisation a but non lucratif

SOURCE 4:
  Nom: OWASP Logging Vocabulary
  URL: https://owasp.org/www-project-logging-vocabulary/
  Niveau pyramide: 2
  Date: ongoing
  Citation: JSON format, event categories (AUTHN, AUTHZ, INPUT, DATA, SYS).
  Conflit d'interet: non — organisation a but non lucratif

SOURCE 5:
  Nom: OWASP Top 10:2025 A09 — Security Logging and Monitoring Failures
  URL: https://owasp.org/Top10/
  Niveau pyramide: 2
  Date: 2025
  Citation: Logging failures = 9e risque web.
  Conflit d'interet: non — organisation a but non lucratif

SOURCE 6:
  Nom: OpenTelemetry Logs Spec
  URL: https://opentelemetry.io/docs/specs/otel/logs/
  Niveau pyramide: 2
  Date: ongoing
  Citation: "Structured logs are preferred in production." TraceId/spanId pour correlation.
  Conflit d'interet: non — projet CNCF (fondation neutre)

SOURCE 7:
  Nom: Twelve-Factor App XI — Logs
  URL: https://12factor.net/logs
  Niveau pyramide: 2
  Date: 2012
  Citation: "Treat logs as event streams", write to stdout. L'application n'ecrit jamais dans des fichiers.
  Conflit d'interet: oui potentiel — cree par Heroku (Salesforce)

SOURCE 8:
  Nom: CNCF TAG Observability
  URL: https://tag-observability.cncf.io/
  Niveau pyramide: 2
  Date: ongoing
  Citation: Encrypt logs, no PII, use ERROR/WARN/INFO/DEBUG severity levels.
  Conflit d'interet: non — fondation neutre (Linux Foundation)

SOURCE 9:
  Nom: Spring Boot docs — Logback structured JSON
  URL: https://docs.spring.io/spring-boot/
  Niveau pyramide: 3
  Date: ongoing
  Citation: Logback defaut Spring Boot, structured JSON since 3.4 (ECS/GELF/Logstash).
  Conflit d'interet: oui potentiel — documentation du vendeur

SOURCE 10:
  Nom: Logback benchmarks
  URL: voir docs officielles
  Niveau pyramide: 3
  Date: ongoing
  Citation: 2 140 ops/ms vs Log4j2 884 ops/ms en mode synchrone.
  Conflit d'interet: non — benchmark independant

SOURCE 11:
  Nom: Pino benchmarks
  URL: voir docs officielles
  Niveau pyramide: 3
  Date: ongoing
  Citation: 50k logs/sec vs Winston 10k logs/sec. JSON natif par defaut.
  Conflit d'interet: oui potentiel — benchmark par les auteurs de Pino

SOURCE 12:
  Nom: npm trends — Pino vs Winston
  URL: https://npmtrends.com/pino-vs-winston
  Niveau pyramide: 4
  Date: ongoing
  Citation: Pino ~21.5M/sem, Winston ~18.8M/sem.
  Conflit d'interet: non — donnees publiques de registre

SOURCE 13:
  Nom: New Relic Java Ecosystem
  URL: voir docs officielles
  Niveau pyramide: 4
  Date: ongoing
  Citation: SLF4J 83% adoption, Logback 52% parmi les projets Java.
  Conflit d'interet: oui potentiel — rapport par vendeur APM (New Relic)

SOURCE 14:
  Nom: Google SRE Book — structured logs
  URL: https://sre.google/sre-book/
  Niveau pyramide: 5
  Date: 2016
  Citation: Structured logs for root cause analysis, metrics for alerting.
  Conflit d'interet: oui potentiel — publie par Google

SOURCE 15:
  Nom: NIST NVD — CVE-2021-44228 (Log4Shell)
  URL: https://nvd.nist.gov/vuln/detail/CVE-2021-44228
  Niveau pyramide: 3
  Date: 2021
  Citation: Log4j2 CVE-2021-44228 CVSS 10.0. Argument securite en faveur de Logback.
  Conflit d'interet: non — base de donnees publique NIST

---

### feature-flags.md

SOURCE 1:
  Nom: CNCF Landscape — Unleash
  URL: https://landscape.cncf.io/
  Niveau pyramide: 5
  Date: ongoing
  Citation: Unleash = incubating project dans le paysage CNCF.
  Conflit d'interet: non — fondation neutre, mais Unleash est un vendeur commercial

SOURCE 2:
  Nom: Twelve-Factor App — build/run separation, config externe
  URL: https://12factor.net/
  Niveau pyramide: 3
  Date: 2012
  Citation: Separation build/run, configuration externe au code.
  Conflit d'interet: oui potentiel — cree par Heroku (Salesforce)

SOURCE 3:
  Nom: Fowler — Feature Toggles
  URL: https://martinfowler.com/articles/feature-toggles.html
  Niveau pyramide: 3
  Date: 2016
  Citation: Patterns de feature toggles (release, experiment, ops, permission).
  Conflit d'interet: non — auteur independant (mais employe ThoughtWorks)

---

### env-config.md

SOURCE 1:
  Nom: Twelve-Factor App III — Store config in the environment
  URL: https://12factor.net/config
  Niveau pyramide: 3
  Date: 2012
  Citation: Config dans l'environnement, pas dans le code. La configuration varie entre les environnements, le code non.
  Conflit d'interet: oui potentiel — cree par Heroku (Salesforce)

SOURCE 2:
  Nom: Spring Boot docs — Externalized Configuration
  URL: https://docs.spring.io/spring-boot/
  Niveau pyramide: 5
  Date: ongoing
  Citation: application-{profile}.yml par environnement, @ConfigurationProperties + @Validated.
  Conflit d'interet: oui potentiel — documentation du vendeur

SOURCE 3:
  Nom: OWASP — ne jamais commiter de secrets
  URL: voir docs officielles
  Niveau pyramide: 3
  Date: ongoing
  Citation: Secrets via variables d'environnement, jamais dans Git.
  Conflit d'interet: non — organisation a but non lucratif

---

### slos.md

SOURCE 1:
  Nom: ISO/IEC 25023 — Mesures de qualite des systemes
  URL: voir docs officielles
  Niveau pyramide: 1
  Date: 2016
  Citation: Mesures de qualite des systemes (disponibilite, performance).
  Conflit d'interet: non — standard international ISO

SOURCE 2:
  Nom: Google SRE Book Ch. 4 — Service Level Objectives
  URL: https://sre.google/sre-book/service-level-objectives/
  Niveau pyramide: 5
  Date: 2016
  Citation: SLOs, error budgets, SLI definitions. Si le budget est consume, gel des features.
  Conflit d'interet: oui potentiel — publie par Google

SOURCE 3:
  Nom: Google SRE Workbook Ch. 2 — Implementing SLOs
  URL: https://sre.google/workbook/implementing-slos/
  Niveau pyramide: 5
  Date: 2018
  Citation: Implementing SLOs in practice.
  Conflit d'interet: oui potentiel — publie par Google

---

### alerting.md

SOURCE 1:
  Nom: Google SRE Book ch. 6 — Monitoring Distributed Systems
  URL: https://sre.google/sre-book/monitoring-distributed-systems/
  Niveau pyramide: 5
  Date: 2016
  Citation: "Every alert should be actionable." Alerter sur symptomes (latence, erreurs), pas causes (CPU). Regrouper les alertes, escalade on-call pour critical.
  Conflit d'interet: oui potentiel — publie par Google

SOURCE 2:
  Nom: DORA 2024 — Alert fatigue
  URL: voir docs officielles
  Niveau pyramide: 4
  Date: 2024
  Citation: Alert fatigue correle avec burnout des equipes.
  Conflit d'interet: oui potentiel — DORA est un programme Google Cloud

SOURCE 3:
  Nom: Grafana Alerting docs
  URL: https://grafana.com/docs/grafana/latest/alerting/
  Niveau pyramide: 3
  Date: ongoing
  Citation: Configuration d'alertes Grafana, regles sur les symptomes.
  Conflit d'interet: oui potentiel — documentation du vendeur (Grafana Labs)

---

### uptime.md

SOURCE 1:
  Nom: Spring Boot Actuator docs — Health probes
  URL: https://docs.spring.io/spring-boot/
  Niveau pyramide: 3
  Date: ongoing
  Citation: /actuator/health, liveness/readiness probes, checks DB/Redis inclus.
  Conflit d'interet: oui potentiel — documentation du vendeur

SOURCE 2:
  Nom: Prometheus blackbox exporter docs
  URL: https://github.com/prometheus/blackbox_exporter
  Niveau pyramide: 3
  Date: ongoing
  Citation: Check externe HTTP avec integration Grafana native.
  Conflit d'interet: non — projet open source CNCF

SOURCE 3:
  Nom: Google SRE Book — Monitoring externe obligatoire
  URL: https://sre.google/sre-book/
  Niveau pyramide: 5
  Date: 2016
  Citation: Le serveur ne peut pas reporter sa propre indisponibilite. Un check externe est indispensable.
  Conflit d'interet: oui potentiel — publie par Google

SOURCE 4:
  Nom: SWEBOK v4 — Availability monitoring
  URL: voir docs officielles
  Niveau pyramide: 1
  Date: 2024
  Citation: Monitoring de la disponibilite au niveau systeme.
  Conflit d'interet: non — standard IEEE

---

### error-tracking.md

SOURCE 1:
  Nom: Stack Overflow Survey 2024 — Sentry adoption
  URL: https://survey.stackoverflow.co/2024
  Niveau pyramide: 4
  Date: 2024
  Citation: Sentry 32% adoption parmi les outils d'observabilite.
  Conflit d'interet: non — enquete communautaire

SOURCE 2:
  Nom: Sentry docs — Spring Boot integration
  URL: https://docs.sentry.io/
  Niveau pyramide: 3
  Date: ongoing
  Citation: Integration Spring Boot, source maps JS, alerting, fingerprinting avance.
  Conflit d'interet: oui — documentation du vendeur commercial (Sentry/Functional Software)

SOURCE 3:
  Nom: GlitchTip docs
  URL: https://glitchtip.com/documentation
  Niveau pyramide: 3
  Date: ongoing
  Citation: Sentry SDK compatible, lightweight self-hosted (1 container vs 30+ pour Sentry self-hosted).
  Conflit d'interet: oui potentiel — documentation du vendeur

---

## CI/CD

---

### ci-pipeline.md

SOURCE 1:
  Nom: SWEBOK v4 — CI/CD, automated build pipeline
  URL: voir docs officielles
  Niveau pyramide: 1
  Date: 2024
  Citation: "Automated build should include compilation, testing, static analysis, packaging." Regression testing in CI.
  Conflit d'interet: non — standard IEEE

SOURCE 2:
  Nom: DORA/Accelerate (30k+ devs)
  URL: voir docs officielles
  Niveau pyramide: 4
  Date: 2018-2024
  Citation: 4 metrics (deployment frequency, lead time, change failure rate, MTTR). "Quality gates at PR level = strongest predictor of low change failure rate." Build < 10 min = 4x deployment frequency. Trunk-based dev = -50% change failure rate.
  Conflit d'interet: oui potentiel — DORA est un programme Google Cloud

SOURCE 3:
  Nom: DORA State of DevOps 2023-2024
  URL: https://dora.dev/research/
  Niveau pyramide: 4
  Date: 2023-2024
  Citation: "Teams that can onboard a new developer to the pipeline in under 1 day deploy 3x more frequently." Pipeline optimization, trunk-based dev.
  Conflit d'interet: oui potentiel — DORA est un programme Google Cloud

SOURCE 4:
  Nom: SO Survey 2024 — CI tools
  URL: https://survey.stackoverflow.co/2024
  Niveau pyramide: 4
  Date: 2024
  Citation: GitHub Actions 53%, Jenkins 32%.
  Conflit d'interet: non — enquete communautaire

SOURCE 5:
  Nom: JetBrains Developer Ecosystem 2024
  URL: https://www.jetbrains.com/lp/devecosystem-2024/
  Niveau pyramide: 4
  Date: 2024
  Citation: GitHub Actions 52%, 61% dans les equipes de 2-10 devs.
  Conflit d'interet: oui potentiel — rapport par vendeur IDE (JetBrains)

SOURCE 6:
  Nom: Twelve-Factor Factor V — Build, release, run
  URL: https://12factor.net/build-release-run
  Niveau pyramide: 5
  Date: 2012
  Citation: Separation build/release/run.
  Conflit d'interet: oui potentiel — cree par Heroku (Salesforce)

SOURCE 7:
  Nom: SonarQube docs — Sonar way defaults
  URL: https://docs.sonarsource.com/sonarqube/
  Niveau pyramide: 3
  Date: ongoing
  Citation: Quality gate "Sonar way" : Coverage >= 80% new code, 0 new bugs, duplication <= 3%.
  Conflit d'interet: oui — documentation du vendeur commercial (SonarSource)

---

### containerization.md

SOURCE 1:
  Nom: SWEBOK v4 s6.1 — Containers for standardized deployment
  URL: voir docs officielles
  Niveau pyramide: 1
  Date: 2024
  Citation: "Container technologies to standardize deployment." s2.2 — Infrastructure as Code. "Orchestrators to improve scalability."
  Conflit d'interet: non — standard IEEE

SOURCE 2:
  Nom: OCI — Open Container Initiative
  URL: https://opencontainers.org/
  Niveau pyramide: 2
  Date: ongoing
  Citation: Standard ouvert pour les formats et runtimes de conteneurs. Interchangeable.
  Conflit d'interet: non — fondation neutre (Linux Foundation)

SOURCE 3:
  Nom: CNCF — containerd projet gradue
  URL: https://www.cncf.io/projects/containerd/
  Niveau pyramide: 2
  Date: ongoing
  Citation: containerd est le runtime Docker, projet gradue CNCF.
  Conflit d'interet: non — fondation neutre (Linux Foundation)

SOURCE 4:
  Nom: Docker docs — multi-stage builds, best practices
  URL: https://docs.docker.com/build/building/multi-stage/
  Niveau pyramide: 3
  Date: ongoing
  Citation: Multi-stage builds, non-root USER, .dockerignore, combiner RUN, base minimale.
  Conflit d'interet: oui potentiel — documentation du vendeur (Docker Inc.)

SOURCE 5:
  Nom: Spring Boot docs — Container Images, layered JARs
  URL: https://docs.spring.io/spring-boot/
  Niveau pyramide: 3
  Date: ongoing
  Citation: Layered JARs pour cache Docker par couche. Buildpacks support natif.
  Conflit d'interet: oui potentiel — documentation du vendeur

SOURCE 6:
  Nom: SO Survey 2025 — Docker adoption
  URL: https://survey.stackoverflow.co/2025
  Niveau pyramide: 4
  Date: 2025
  Citation: Docker 73.8% (+17pts jump), K8s 30%. "Docker has moved from a popular tool to a near-universal one."
  Conflit d'interet: non — enquete communautaire

SOURCE 7:
  Nom: Twelve-Factor Factor X — Dev/prod parity
  URL: https://12factor.net/dev-prod-parity
  Niveau pyramide: 5
  Date: 2012
  Citation: Parite dev/prod. Factor VI — stateless processes.
  Conflit d'interet: oui potentiel — cree par Heroku (Salesforce)

---

### deployment-strategy.md

SOURCE 1:
  Nom: DORA State of DevOps — Zero-downtime deployments
  URL: https://dora.dev/research/
  Niveau pyramide: 4
  Date: 2024
  Citation: Zero-downtime deployments = predictor of elite performance.
  Conflit d'interet: oui potentiel — DORA est un programme Google Cloud

SOURCE 2:
  Nom: Twelve-Factor App Factor IX — Disposability
  URL: https://12factor.net/disposability
  Niveau pyramide: 5
  Date: 2012
  Citation: Fast startup, graceful shutdown, disposability.
  Conflit d'interet: oui potentiel — cree par Heroku (Salesforce)

SOURCE 3:
  Nom: Docker Compose docs — deploy.update_config, healthcheck
  URL: https://docs.docker.com/compose/
  Niveau pyramide: 3
  Date: ongoing
  Citation: Configuration rolling update : parallelism, delay, order start-first. Healthcheck configuration.
  Conflit d'interet: oui potentiel — documentation du vendeur (Docker Inc.)

SOURCE 4:
  Nom: Spring Boot docs — Graceful shutdown, actuator health
  URL: https://docs.spring.io/spring-boot/
  Niveau pyramide: 3
  Date: ongoing
  Citation: server.shutdown=graceful, actuator health endpoint pour les health checks.
  Conflit d'interet: oui potentiel — documentation du vendeur

---

### container-registry.md

SOURCE 1:
  Nom: GitHub docs — GHCR integration
  URL: https://docs.github.com/en/packages/working-with-a-github-packages-registry/working-with-the-container-registry
  Niveau pyramide: 3
  Date: ongoing
  Citation: GHCR integration native avec Actions et permissions du repo. GITHUB_TOKEN pour auth.
  Conflit d'interet: oui potentiel — documentation du vendeur (GitHub/Microsoft)

SOURCE 2:
  Nom: CNCF Survey 2024 — Container registry adoption
  URL: voir docs officielles
  Niveau pyramide: 4
  Date: 2024
  Citation: Donnees d'adoption des container registries.
  Conflit d'interet: non — fondation neutre

SOURCE 3:
  Nom: Twelve-Factor Factor V — Build artifacts immutables
  URL: https://12factor.net/build-release-run
  Niveau pyramide: 5
  Date: 2012
  Citation: Artefacts de build immutables.
  Conflit d'interet: oui potentiel — cree par Heroku (Salesforce)

---

### infrastructure.md

SOURCE 1:
  Nom: SWEBOK v4 s2.2 — Infrastructure as Code
  URL: voir docs officielles
  Niveau pyramide: 1
  Date: 2024
  Citation: Infrastructure declarative, versionnee, reproductible.
  Conflit d'interet: non — standard IEEE

SOURCE 2:
  Nom: Twelve-Factor Factor X — Dev/prod parity
  URL: https://12factor.net/dev-prod-parity
  Niveau pyramide: 5
  Date: 2012
  Citation: Environnements identiques (dev/staging/prod).
  Conflit d'interet: oui potentiel — cree par Heroku (Salesforce)

SOURCE 3:
  Nom: DORA 2024 — IaC
  URL: https://dora.dev/research/
  Niveau pyramide: 4
  Date: 2024
  Citation: IaC correle avec deployment frequency. "Manual changes = #1 cause of incidents."
  Conflit d'interet: oui potentiel — DORA est un programme Google Cloud

SOURCE 4:
  Nom: Docker Compose docs
  URL: https://docs.docker.com/compose/
  Niveau pyramide: 3
  Date: ongoing
  Citation: IaC pour petites equipes mono-serveur.
  Conflit d'interet: oui potentiel — documentation du vendeur (Docker Inc.)

---

## CODE QUALITY

---

### linting.md

SOURCE 1:
  Nom: SWEBOK v4 Sections 1.3, 1.5, 3.4.1, 3.6
  URL: voir docs officielles
  Niveau pyramide: 1
  Date: 2024
  Citation: "Numerous techniques exist to ensure the quality of code as it is constructed. The primary techniques used to ensure construction quality are: [...] Static analysis." "Use tools and periodic reviews to ensure adopted standards and guidelines are followed."
  Conflit d'interet: non — standard IEEE

SOURCE 2:
  Nom: SWEBOK v4 Computing Foundations — Style clashes
  URL: voir docs officielles
  Niveau pyramide: 1
  Date: 2024
  Citation: "An estimated 82% of vulnerabilities are caused by clashes between programming styles." (citant ptsecurity.com)
  Conflit d'interet: non — standard IEEE (la stat originale vient de ptsecurity.com, un vendeur secu)

SOURCE 3:
  Nom: OWASP SAST Tools
  URL: https://owasp.org/www-community/Source_Code_Analysis_Tools
  Niveau pyramide: 2
  Date: ongoing
  Citation: SonarQube liste pour Java et JS/TS.
  Conflit d'interet: non — organisation a but non lucratif

SOURCE 4:
  Nom: React docs — ESLint "essential"
  URL: https://react.dev/
  Niveau pyramide: 3
  Date: ongoing
  Citation: React recommande officiellement ESLint, qualifie eslint-plugin-react-hooks d'"essentiel". Recommande Prettier + eslint-config-prettier pour separer les roles.
  Conflit d'interet: oui potentiel — documentation du vendeur (Meta)

SOURCE 5:
  Nom: Google Java Style Guide
  URL: https://google.github.io/styleguide/javaguide.html
  Niveau pyramide: 3
  Date: ongoing
  Citation: Reference google-java-format comme implementation. Conventions camelCase/PascalCase.
  Conflit d'interet: oui potentiel — publie par Google

SOURCE 6:
  Nom: Checkstyle docs — google_checks.xml
  URL: https://checkstyle.org/
  Niveau pyramide: 3
  Date: ongoing
  Citation: Config google_checks.xml built-in. Spring Boot utilise Checkstyle en interne.
  Conflit d'interet: non — projet open source

SOURCE 7:
  Nom: SonarQube docs — Quality gate "Sonar way"
  URL: https://docs.sonarsource.com/sonarqube/
  Niveau pyramide: 3
  Date: ongoing
  Citation: Quality gate : 80% coverage nouveau code, 3% duplication max, 0 issues. Approche "Clean as You Code".
  Conflit d'interet: oui — documentation du vendeur commercial (SonarSource)

SOURCE 8:
  Nom: Biome docs
  URL: https://biomejs.dev/
  Niveau pyramide: 3
  Date: ongoing
  Citation: 35x plus rapide qu'ESLint, 97% Prettier-compatible, 479 regles.
  Conflit d'interet: oui potentiel — documentation du vendeur/projet

SOURCE 9:
  Nom: google-java-format docs
  URL: https://github.com/google/google-java-format
  Niveau pyramide: 3
  Date: ongoing
  Citation: "There is no configurability as to the formatter's algorithm for formatting. This is a deliberate design decision to unify our code formatting on a single format."
  Conflit d'interet: oui potentiel — projet Google

SOURCE 10:
  Nom: State of Frontend 2024
  URL: voir docs officielles
  Niveau pyramide: 4
  Date: 2024
  Citation: ESLint 89.3% adoption, Prettier 87.5% adoption.
  Conflit d'interet: non — enquete communautaire

SOURCE 11:
  Nom: npm trends — ESLint vs Biome vs oxlint
  URL: https://npmtrends.com/
  Niveau pyramide: 4
  Date: ongoing
  Citation: ESLint 115M/sem, Biome 7M, oxlint 4.5M.
  Conflit d'interet: non — donnees publiques de registre

SOURCE 12:
  Nom: Capers Jones (13 000+ projets)
  URL: voir docs officielles
  Niveau pyramide: 5
  Date: various
  Citation: Static analysis alone detects 55-65% of defects (DRE). Combined with tests + reviews : >97%.
  Conflit d'interet: non — recherche independante

SOURCE 13:
  Nom: Yeboah & Popoola 2024 — SonarQube study
  URL: voir docs officielles
  Niveau pyramide: 5
  Date: 2024
  Citation: "SonarQube performs considerably well than all other tools in terms of defect detection across Java, C++, Python."
  Conflit d'interet: non — etude academique independante

SOURCE 14:
  Nom: Empirical studies — static analysis limitations
  URL: voir docs officielles (Springer, ScienceDirect)
  Niveau pyramide: 5
  Date: 2022-2024
  Citation: "Top-performing static analyzers fail to detect between 47% to 80% of vulnerabilities depending on evaluation scenarios."
  Conflit d'interet: non — recherche academique

---

### null-safety.md

SOURCE 1:
  Nom: Java 17+ docs — Optional API
  URL: https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/Optional.html
  Niveau pyramide: 3
  Date: ongoing
  Citation: "Primarily intended for method return types." Ne jamais passer Optional en parametre.
  Conflit d'interet: oui potentiel — documentation du vendeur (Oracle)

SOURCE 2:
  Nom: TypeScript docs — strictNullChecks
  URL: https://www.typescriptlang.org/docs/
  Niveau pyramide: 3
  Date: ongoing
  Citation: strictNullChecks, nullish coalescing operator (??), optional chaining (?.).
  Conflit d'interet: oui potentiel — documentation du vendeur (Microsoft)

SOURCE 3:
  Nom: Effective Java (Bloch) Item 55
  URL: voir docs officielles
  Niveau pyramide: 5
  Date: 2018
  Citation: "Return Optional instead of null."
  Conflit d'interet: non — auteur independant (mais employe Google)

---

### code-review.md

SOURCE 1:
  Nom: SWEBOK v4 — Code inspection as verification technique
  URL: voir docs officielles
  Niveau pyramide: 1
  Date: 2024
  Citation: Code inspection comme technique de verification.
  Conflit d'interet: non — standard IEEE

SOURCE 2:
  Nom: SmartBear study — Code review effectiveness
  URL: voir docs officielles
  Niveau pyramide: 4
  Date: various
  Citation: 400 LOC max per review. 60-70% defect detection rate pour la code review.
  Conflit d'interet: oui potentiel — SmartBear vend des outils de code review (Collaborator)

SOURCE 3:
  Nom: Google Engineering Practices — Code review guidelines
  URL: https://google.github.io/eng-practices/review/
  Niveau pyramide: 5
  Date: ongoing
  Citation: Code review guidelines, reviewer responsibilities.
  Conflit d'interet: oui potentiel — publie par Google

---

### naming.md

SOURCE 1:
  Nom: Google Java Style Guide — naming conventions
  URL: https://google.github.io/styleguide/javaguide.html
  Niveau pyramide: 3
  Date: ongoing
  Citation: camelCase methods, PascalCase classes.
  Conflit d'interet: oui potentiel — publie par Google

SOURCE 2:
  Nom: Spring Boot conventions
  URL: https://docs.spring.io/spring-boot/
  Niveau pyramide: 3
  Date: ongoing
  Citation: Conventions de nommage Repository, Service, Controller.
  Conflit d'interet: oui potentiel — documentation du vendeur

SOURCE 3:
  Nom: Clean Code (Martin) — Meaningful names
  URL: voir docs officielles
  Niveau pyramide: 5
  Date: 2008
  Citation: Meaningful names, intention-revealing names, noms descriptifs sans abreviations.
  Conflit d'interet: non — auteur independant

---

### typescript-strict.md

SOURCE 1:
  Nom: TypeScript docs — Strict compiler options
  URL: https://www.typescriptlang.org/docs/
  Niveau pyramide: 3
  Date: ongoing
  Citation: strict: true active strictNullChecks, noImplicitAny, strictFunctionTypes, etc. Migration guide.
  Conflit d'interet: oui potentiel — documentation du vendeur (Microsoft)

SOURCE 2:
  Nom: State of JS 2024 — TypeScript satisfaction
  URL: https://stateofjs.com/
  Niveau pyramide: 4
  Date: 2024
  Citation: TypeScript 89%+ satisfaction, strict mode recommande.
  Conflit d'interet: non — enquete communautaire

SOURCE 3:
  Nom: Google TypeScript Style Guide
  URL: https://google.github.io/styleguide/tsguide.html
  Niveau pyramide: 5
  Date: ongoing
  Citation: "Always use strict."
  Conflit d'interet: oui potentiel — publie par Google

---

## ARCHITECTURE

---

### module-structure.md

SOURCE 1:
  Nom: ISO 25010:2023 — Modularity
  URL: voir docs officielles
  Niveau pyramide: 1
  Date: 2023
  Citation: "Modularity: degree to which a system is composed of discrete components such that a change to one component has minimal impact on other components." Sub-characteristic of Maintainability.
  Conflit d'interet: non — standard international ISO

SOURCE 2:
  Nom: SWEBOK v4 — Cohesion/coupling
  URL: voir docs officielles
  Niveau pyramide: 1
  Date: 2024
  Citation: High cohesion, low coupling, modules comme principes de construction.
  Conflit d'interet: non — standard IEEE

SOURCE 3:
  Nom: Spring Modulith docs
  URL: https://spring.io/projects/spring-modulith
  Niveau pyramide: 3
  Date: ongoing
  Citation: Modular monolith verification. ApplicationModules.verify() verifie automatiquement que les modules forment un DAG.
  Conflit d'interet: oui potentiel — documentation du vendeur (VMware/Broadcom)

SOURCE 4:
  Nom: ArchUnit docs
  URL: https://www.archunit.org/
  Niveau pyramide: 3
  Date: ongoing
  Citation: Architecture testing, boundary enforcement dans la CI. ING a detecte ~200 violations par cycle de build.
  Conflit d'interet: non — projet open source

SOURCE 5:
  Nom: eslint-plugin-boundaries docs
  URL: https://www.npmjs.com/package/eslint-plugin-boundaries
  Niveau pyramide: 3
  Date: ongoing
  Citation: Frontend boundary enforcement, regles de dependance entre features.
  Conflit d'interet: non — projet open source

SOURCE 6:
  Nom: Spring Boot docs — package-by-feature
  URL: https://docs.spring.io/spring-boot/
  Niveau pyramide: 3
  Date: ongoing
  Citation: Les samples Spring Boot utilisent package-by-feature.
  Conflit d'interet: oui potentiel — documentation du vendeur

SOURCE 7:
  Nom: Baxter et al. 2006 — Feature-based vs layer-based
  URL: voir docs officielles
  Niveau pyramide: 4
  Date: 2006
  Citation: 40% fewer inter-package dependencies with feature-based vs layer-based (56 Java projects).
  Conflit d'interet: non — recherche academique

SOURCE 8:
  Nom: Santos et al. 2019 — Feature-based defect reduction
  URL: voir docs officielles
  Niveau pyramide: 4
  Date: 2019
  Citation: 25-30% defect reduction with feature-based (12 projects).
  Conflit d'interet: non — recherche academique

SOURCE 9:
  Nom: Koziolek et al. 2013 — Maintenance effort
  URL: voir docs officielles
  Niveau pyramide: 4
  Date: 2013
  Citation: 30-50% maintenance effort reduction (systematic review).
  Conflit d'interet: non — recherche academique

SOURCE 10:
  Nom: Abdeen et al. 2013 — Package coupling defects
  URL: voir docs officielles
  Niveau pyramide: 4
  Date: 2013
  Citation: 2-3x more modifications in coupled packages, +40% defects.
  Conflit d'interet: non — recherche academique

SOURCE 11:
  Nom: Bulletproof React
  URL: https://github.com/alan2207/bulletproof-react
  Niveau pyramide: 4
  Date: ongoing
  Citation: Feature-based React reference architecture (14k+ stars).
  Conflit d'interet: non — projet communautaire open source

SOURCE 12:
  Nom: React docs — feature grouping
  URL: https://react.dev/
  Niveau pyramide: 3
  Date: ongoing
  Citation: "No opinion but feature grouping popular."
  Conflit d'interet: oui potentiel — documentation du vendeur (Meta)

SOURCE 13:
  Nom: Clean Architecture (Martin) — Screaming Architecture
  URL: voir docs officielles
  Niveau pyramide: 5
  Date: 2017
  Citation: "The architecture should scream the use cases of the system, not the framework." Dependency rule.
  Conflit d'interet: non — auteur independant

SOURCE 14:
  Nom: DDD (Evans) — Modules, Bounded Contexts
  URL: voir docs officielles
  Niveau pyramide: 5
  Date: 2003
  Citation: Modules = domain concepts, bounded contexts.
  Conflit d'interet: non — auteur independant

SOURCE 15:
  Nom: Hexagonal Architecture (Cockburn)
  URL: voir docs officielles
  Niveau pyramide: 5
  Date: 2005
  Citation: Ports and adapters. Dependencies point inward. Convergence avec Clean Architecture et DDD.
  Conflit d'interet: non — auteur independant

---

### database.md

SOURCE 1:
  Nom: SWEBOK v4 — Computing Foundations s12
  URL: voir docs officielles
  Niveau pyramide: 1
  Date: 2024
  Citation: "Database Basics and Data Management." Fondamentaux des bases de donnees.
  Conflit d'interet: non — standard IEEE

SOURCE 2:
  Nom: CNCF — CloudNativePG
  URL: https://www.cncf.io/projects/cloudnativepg/
  Niveau pyramide: 2
  Date: ongoing
  Citation: CloudNativePG = seul operateur SGBD cloud-native (PostgreSQL). Aucun projet equivalent pour MySQL.
  Conflit d'interet: non — fondation neutre (Linux Foundation)

SOURCE 3:
  Nom: Spring Boot docs — PostgreSQL/MySQL support
  URL: https://docs.spring.io/spring-boot/
  Niveau pyramide: 3
  Date: ongoing
  Citation: Support egal PostgreSQL/MySQL, H2 pour dev, HikariCP par defaut. "You need not provide any connection URLs" (H2 auto-configure).
  Conflit d'interet: oui potentiel — documentation du vendeur

SOURCE 4:
  Nom: PostgreSQL docs
  URL: https://www.postgresql.org/docs/
  Niveau pyramide: 3
  Date: ongoing
  Citation: "ACID-compliant since 2001, highly scalable."
  Conflit d'interet: oui potentiel — documentation du projet lui-meme

SOURCE 5:
  Nom: SO Survey 2024 — PostgreSQL adoption
  URL: https://survey.stackoverflow.co/2024
  Niveau pyramide: 4
  Date: 2024
  Citation: PostgreSQL 48.7% popular, 74.5% admired (#1 les deux).
  Conflit d'interet: non — enquete communautaire

SOURCE 6:
  Nom: SO Survey 2025 — PostgreSQL adoption
  URL: https://survey.stackoverflow.co/2025
  Niveau pyramide: 4
  Date: 2025
  Citation: PostgreSQL 55.6% popular (#1), +15pts vs MySQL 40.5%. Admiration 65.5% (#1).
  Conflit d'interet: non — enquete communautaire

SOURCE 7:
  Nom: JetBrains Developer Ecosystem 2025
  URL: https://www.jetbrains.com/lp/devecosystem-2025/
  Niveau pyramide: 4
  Date: 2025
  Citation: "PostgreSQL edges MySQL out as the most popular database." PostgreSQL depasse MySQL pour la premiere fois.
  Conflit d'interet: oui potentiel — rapport par vendeur IDE (JetBrains)

SOURCE 8:
  Nom: JetBrains Developer Ecosystem 2024
  URL: https://www.jetbrains.com/lp/devecosystem-2024/
  Niveau pyramide: 4
  Date: 2024
  Citation: PostgreSQL 45% (hausse), MySQL 52% (baisse). Convergence.
  Conflit d'interet: oui potentiel — rapport par vendeur IDE (JetBrains)

SOURCE 9:
  Nom: DB-Engines 2026
  URL: https://db-engines.com/
  Niveau pyramide: 4
  Date: 2026
  Citation: PostgreSQL #4, DBMS of the Year 2023, croissance forte. MySQL #2 stable.
  Conflit d'interet: non — ranking independant

SOURCE 10:
  Nom: MDPI 2024 — PostgreSQL vs MySQL benchmark
  URL: voir docs officielles
  Niveau pyramide: 4
  Date: 2024
  Citation: SELECT 1M records : PostgreSQL 13x plus rapide que MySQL. Charge concurrente : PostgreSQL stable, MySQL degrade. Peer-reviewed.
  Conflit d'interet: non — recherche academique peer-reviewed

SOURCE 11:
  Nom: Twelve-Factor IV — Backing services
  URL: https://12factor.net/backing-services
  Niveau pyramide: 5
  Date: 2012
  Citation: SGBD = attached resource interchangeable. Config 100% externalisee via variables d'environnement.
  Conflit d'interet: oui potentiel — cree par Heroku (Salesforce)

---

### openapi.md

SOURCE 1:
  Nom: OpenAPI Specification 3.1 — Standard IETF
  URL: https://spec.openapis.org/oas/v3.1.0
  Niveau pyramide: 1
  Date: 2021
  Citation: Standard IETF pour la documentation d'API. Chaque endpoint documente avec types request/response et codes d'erreur.
  Conflit d'interet: non — standard ouvert

SOURCE 2:
  Nom: Spring Boot docs — springdoc-openapi
  URL: https://docs.spring.io/spring-boot/
  Niveau pyramide: 5
  Date: ongoing
  Citation: Integration native springdoc-openapi. Accessible sur /swagger-ui.html et /v3/api-docs.
  Conflit d'interet: oui potentiel — documentation du vendeur

SOURCE 3:
  Nom: SmartBear 2023 API Survey
  URL: voir docs officielles
  Niveau pyramide: 4
  Date: 2023
  Citation: 89% des equipes utilisent OpenAPI.
  Conflit d'interet: oui — SmartBear est le createur/mainteneur de Swagger et proprietaire de SwaggerHub

---

### api-protocol.md

SOURCE 1:
  Nom: Spring Boot docs — @RestController, ResponseEntity
  URL: https://docs.spring.io/spring-boot/
  Niveau pyramide: 3
  Date: ongoing
  Citation: @RestController, ResponseEntity, content negotiation pour REST.
  Conflit d'interet: oui potentiel — documentation du vendeur

SOURCE 2:
  Nom: Postman State of APIs 2024
  URL: https://www.postman.com/state-of-api/
  Niveau pyramide: 4
  Date: 2024
  Citation: REST 90%+, GraphQL 14%, gRPC 11%.
  Conflit d'interet: oui potentiel — rapport par vendeur d'outil API (Postman)

SOURCE 3:
  Nom: Fielding dissertation — REST
  URL: https://www.ics.uci.edu/~fielding/pubs/dissertation/top.htm
  Niveau pyramide: 5
  Date: 2000
  Citation: REST architectural style : stateless, cacheable, uniform interface.
  Conflit d'interet: non — these academique

---

### api-versioning.md

SOURCE 1:
  Nom: GitHub API — URL path versioning
  URL: https://docs.github.com/en/rest
  Niveau pyramide: 3
  Date: ongoing
  Citation: URL path versioning (/v3/), reference industrielle.
  Conflit d'interet: oui potentiel — documentation du vendeur (GitHub/Microsoft)

SOURCE 2:
  Nom: Spring Boot docs — @RequestMapping path-based versioning
  URL: https://docs.spring.io/spring-boot/
  Niveau pyramide: 3
  Date: ongoing
  Citation: @RequestMapping pour le versioning par URL path.
  Conflit d'interet: oui potentiel — documentation du vendeur

SOURCE 3:
  Nom: Stripe API — URL versioning
  URL: https://docs.stripe.com/api
  Niveau pyramide: 5
  Date: ongoing
  Citation: URL versioning avec dates, backwards compatibility guarantee. Reference industrielle.
  Conflit d'interet: oui potentiel — documentation du vendeur (Stripe)

---

## DATA

---

### encoding.md

SOURCE 1:
  Nom: IETF RFC 3629 — UTF-8
  URL: https://www.rfc-editor.org/rfc/rfc3629
  Niveau pyramide: 1
  Date: 2003
  Citation: Standard UTF-8, le seul encodage acceptable.
  Conflit d'interet: non — standard ouvert IETF

SOURCE 2:
  Nom: W3C — UTF-8 obligatoire pour HTML5
  URL: https://www.w3.org/International/questions/qa-choosing-encodings
  Niveau pyramide: 1
  Date: ongoing
  Citation: UTF-8 obligatoire pour HTML5.
  Conflit d'interet: non — organisme de standardisation

SOURCE 3:
  Nom: Web Almanac 2024
  URL: https://almanac.httparchive.org/
  Niveau pyramide: 4
  Date: 2024
  Citation: 98.2% du web en UTF-8.
  Conflit d'interet: non — rapport communautaire HTTP Archive

---

### date-time.md

SOURCE 1:
  Nom: ISO 8601 — Format date/heure international
  URL: voir docs officielles
  Niveau pyramide: 1
  Date: 2019 (derniere revision)
  Citation: Format date/heure international : 2026-04-14T10:30:00Z. Standard pour les API JSON.
  Conflit d'interet: non — standard international ISO

SOURCE 2:
  Nom: Java 21 docs — java.time API
  URL: https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/time/package-summary.html
  Niveau pyramide: 5
  Date: ongoing
  Citation: Utiliser Instant, ZonedDateTime. Stocker en UTC, convertir en local a l'affichage.
  Conflit d'interet: oui potentiel — documentation du vendeur (Oracle)

SOURCE 3:
  Nom: OWASP — Time zone confusion vulnerabilities
  URL: voir docs officielles
  Niveau pyramide: 3
  Date: ongoing
  Citation: Vulnerabilites liees a la confusion de fuseaux horaires.
  Conflit d'interet: non — organisation a but non lucratif

---

### numeric-precision.md

SOURCE 1:
  Nom: IEEE 754 — Floating-point arithmetic
  URL: voir docs officielles
  Niveau pyramide: 1
  Date: 2019
  Citation: Limitations documentees des flottants. 0.1 + 0.2 = 0.30000000000000004.
  Conflit d'interet: non — standard IEEE

SOURCE 2:
  Nom: Java docs — BigDecimal
  URL: https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/math/BigDecimal.html
  Niveau pyramide: 5
  Date: ongoing
  Citation: BigDecimal pour les calculs financiers, precision arbitraire.
  Conflit d'interet: oui potentiel — documentation du vendeur (Oracle)

SOURCE 3:
  Nom: OWASP — Rounding errors in payments
  URL: voir docs officielles
  Niveau pyramide: 3
  Date: ongoing
  Citation: Erreurs d'arrondi dans les paiements, risque financier.
  Conflit d'interet: non — organisation a but non lucratif

---

## PROJECT

---

### branching.md

SOURCE 1:
  Nom: DORA/Accelerate (30k+ devs)
  URL: voir docs officielles
  Niveau pyramide: 4
  Date: 2018
  Citation: Trunk-based development = predictor of elite performance. Branches < 2 jours. Long-lived branches correlent avec +50% change failure rate.
  Conflit d'interet: oui potentiel — DORA est un programme Google Cloud

SOURCE 2:
  Nom: DORA State of DevOps 2019-2024
  URL: https://dora.dev/research/
  Niveau pyramide: 4
  Date: 2019-2024
  Citation: "Trunk-based development combined with automated testing in CI reduces change failure rate by 50% compared to long-lived branches."
  Conflit d'interet: oui potentiel — DORA est un programme Google Cloud

SOURCE 3:
  Nom: trunkbaseddevelopment.com
  URL: https://trunkbaseddevelopment.com/
  Niveau pyramide: 5
  Date: ongoing
  Citation: Reference pour les pratiques trunk-based development.
  Conflit d'interet: non — site communautaire

SOURCE 4:
  Nom: GitHub Flow docs
  URL: https://docs.github.com/en/get-started/using-github/github-flow
  Niveau pyramide: 3
  Date: ongoing
  Citation: Workflow simplifie feature → main.
  Conflit d'interet: oui potentiel — documentation du vendeur (GitHub/Microsoft)

---

### commit-conventions.md

SOURCE 1:
  Nom: conventionalcommits.org v1.0.0
  URL: https://www.conventionalcommits.org/en/v1.0.0/
  Niveau pyramide: 5
  Date: 2019
  Citation: Specification Conventional Commits : type(scope): description. Types feat, fix, refactor, docs, test, chore.
  Conflit d'interet: non — specification communautaire open source

SOURCE 2:
  Nom: Angular commit guidelines
  URL: https://github.com/angular/angular/blob/main/CONTRIBUTING.md
  Niveau pyramide: 3
  Date: ongoing
  Citation: Guidelines de commit Angular, source originale de Conventional Commits.
  Conflit d'interet: oui potentiel — projet Google (Angular)

SOURCE 3:
  Nom: semantic-release docs
  URL: https://github.com/semantic-release/semantic-release
  Niveau pyramide: 3
  Date: ongoing
  Citation: Version automatisee basee sur les types de commit (feat → minor, fix → patch, BREAKING CHANGE → major).
  Conflit d'interet: non — projet open source

SOURCE 4:
  Nom: DORA — Commit discipline
  URL: https://dora.dev/research/
  Niveau pyramide: 4
  Date: ongoing
  Citation: Commit discipline correle avec deployment frequency.
  Conflit d'interet: oui potentiel — DORA est un programme Google Cloud

---

### dependencies.md

SOURCE 1:
  Nom: Twelve-Factor Factor II — Declare dependencies explicitly
  URL: https://12factor.net/dependencies
  Niveau pyramide: 5
  Date: 2012
  Citation: Dependances explicitement declarees. Build reproductible via lockfile.
  Conflit d'interet: oui potentiel — cree par Heroku (Salesforce)

SOURCE 2:
  Nom: OWASP A06:2021 — Vulnerable and Outdated Components
  URL: https://owasp.org/Top10/A06_2021-Vulnerable_and_Outdated_Components/
  Niveau pyramide: 2
  Date: 2021
  Citation: Scan automatique des CVE. Dependances non mises a jour = premiere source de vulnerabilites.
  Conflit d'interet: non — organisation a but non lucratif

SOURCE 3:
  Nom: SWEBOK v4 — Dependency management, supply chain
  URL: voir docs officielles
  Niveau pyramide: 1
  Date: 2024
  Citation: Gestion des dependances et chaine d'approvisionnement logicielle.
  Conflit d'interet: non — standard IEEE

SOURCE 4:
  Nom: GitHub Dependabot docs
  URL: https://docs.github.com/en/code-security/dependabot
  Niveau pyramide: 3
  Date: ongoing
  Citation: Scan hebdomadaire automatique, PRs de mise a jour, detection des CVE.
  Conflit d'interet: oui potentiel — documentation du vendeur (GitHub/Microsoft)

---

## SAFETY

---

### destructive-confirmation.md

SOURCE 1:
  Nom: Apple HIG — Confirmation pour actions destructives
  URL: https://developer.apple.com/design/human-interface-guidelines/
  Niveau pyramide: 5
  Date: ongoing
  Citation: Confirmation obligatoire pour toute action destructive.
  Conflit d'interet: oui potentiel — publie par Apple pour son ecosysteme

SOURCE 2:
  Nom: Material Design 3 — Dialogs de confirmation
  URL: https://m3.material.io/
  Niveau pyramide: 5
  Date: ongoing
  Citation: Dialogs de confirmation pour les actions irreversibles.
  Conflit d'interet: oui potentiel — publie par Google pour son ecosysteme

SOURCE 3:
  Nom: WCAG 2.2 SC 3.3.4 — Error Prevention
  URL: https://www.w3.org/TR/WCAG22/#error-prevention-legal-financial-data
  Niveau pyramide: 1
  Date: 2023
  Citation: Prevention des erreurs, reversibilite. Actions irreversibles doivent etre confirmables.
  Conflit d'interet: non — standard W3C

---

### gdpr.md

SOURCE 1:
  Nom: Reglement UE 2016/679 (RGPD)
  URL: https://eur-lex.europa.eu/eli/reg/2016/679/oj
  Niveau pyramide: 1
  Date: 2016 (applicable 2018)
  Citation: Art. 5 (principes), Art. 6-7 (consentement), Art. 15 (droit d'acces), Art. 17 (droit a l'effacement), Art. 20 (portabilite), Art. 25 (privacy by design), Art. 30 (registre). Non-conformite = amende jusqu'a 4% du CA mondial.
  Conflit d'interet: non — legislation europeenne

SOURCE 2:
  Nom: CNIL — Guidelines
  URL: https://www.cnil.fr/
  Niveau pyramide: 1
  Date: ongoing
  Citation: Guidelines consentement, droit a l'effacement, privacy by design.
  Conflit d'interet: non — autorite administrative independante

SOURCE 3:
  Nom: OWASP Top 10 Privacy Risks
  URL: https://owasp.org/www-project-top-10-privacy-risks/
  Niveau pyramide: 2
  Date: ongoing
  Citation: Data minimization, consent management.
  Conflit d'interet: non — organisation a but non lucratif

---

### unsaved-changes.md

SOURCE 1:
  Nom: Apple HIG — "Hazard warning" avant perte de donnees
  URL: https://developer.apple.com/design/human-interface-guidelines/
  Niveau pyramide: 5
  Date: ongoing
  Citation: Avertissement obligatoire avant perte de donnees saisies.
  Conflit d'interet: oui potentiel — publie par Apple pour son ecosysteme

SOURCE 2:
  Nom: MDN — beforeunload event
  URL: https://developer.mozilla.org/en-US/docs/Web/API/Window/beforeunload_event
  Niveau pyramide: 3
  Date: ongoing
  Citation: API beforeunload pour proteger contre la fermeture d'onglet / refresh.
  Conflit d'interet: non — documentation communautaire (Mozilla)

SOURCE 3:
  Nom: React Router docs — useBlocker
  URL: https://reactrouter.com/
  Niveau pyramide: 3
  Date: ongoing
  Citation: useBlocker pour proteger la navigation SPA.
  Conflit d'interet: oui potentiel — documentation du vendeur (Remix/Shopify)

SOURCE 4:
  Nom: Nielsen — Prevention des erreurs, heuristique #5
  URL: https://www.nngroup.com/articles/ten-usability-heuristics/
  Niveau pyramide: 3
  Date: 1994 (mise a jour ongoing)
  Citation: Prevention des erreurs = 5e heuristique d'utilisabilite de Nielsen.
  Conflit d'interet: non — recherche UX independante (mais NN/g vend du consulting)

---

### safe-defaults.md

SOURCE 1:
  Nom: OWASP A01:2021 — Broken Access Control
  URL: https://owasp.org/Top10/A01_2021-Broken_Access_Control/
  Niveau pyramide: 2
  Date: 2021
  Citation: Deny by default. Whitelist > blacklist. CORS restrictif.
  Conflit d'interet: non — organisation a but non lucratif

SOURCE 2:
  Nom: SWEBOK v4 — Security principles, least privilege
  URL: voir docs officielles
  Niveau pyramide: 1
  Date: 2024
  Citation: Principes de securite, moindre privilege.
  Conflit d'interet: non — standard IEEE

SOURCE 3:
  Nom: Spring Security docs — Authorize requests
  URL: https://docs.spring.io/spring-security/reference/
  Niveau pyramide: 3
  Date: ongoing
  Citation: .anyRequest().authenticated() = deny by default. Configuration explicite des routes autorisees.
  Conflit d'interet: oui potentiel — documentation du vendeur (VMware/Broadcom)

SOURCE 4:
  Nom: CWE-276 — Incorrect Default Permissions
  URL: https://cwe.mitre.org/data/definitions/276.html
  Niveau pyramide: 2
  Date: ongoing
  Citation: Permissions par defaut incorrectes = vulnerabilite commune.
  Conflit d'interet: non — MITRE, organisme independant

---

## ACCESSIBILITY

---

### wcag-level.md

SOURCE 1:
  Nom: WCAG 2.2 W3C Recommendation
  URL: https://www.w3.org/TR/WCAG22/
  Niveau pyramide: 1
  Date: 2023
  Citation: Standard WCAG 2.2 Level AA. Criteres 1.1.1, 1.3.1, 1.4.3, 1.4.11, 2.1.1, 2.4.7, 2.4.11, 2.5.8, 3.3.8, 4.1.2.
  Conflit d'interet: non — standard W3C

SOURCE 2:
  Nom: EU Web Accessibility Directive 2016/2102
  URL: https://eur-lex.europa.eu/eli/dir/2016/2102/oj
  Niveau pyramide: 1
  Date: 2016
  Citation: WCAG AA obligatoire pour les services publics dans l'UE.
  Conflit d'interet: non — legislation europeenne

SOURCE 3:
  Nom: ADA / Section 508
  URL: voir docs officielles
  Niveau pyramide: 1
  Date: ongoing
  Citation: WCAG AA obligatoire aux Etats-Unis (accessibilite federale).
  Conflit d'interet: non — legislation americaine

SOURCE 4:
  Nom: ISO 9241-171 — Ergonomics, accessibility
  URL: voir docs officielles
  Niveau pyramide: 1
  Date: 2008
  Citation: Standard international d'ergonomie et d'accessibilite.
  Conflit d'interet: non — standard international ISO

SOURCE 5:
  Nom: WebAIM Million 2024
  URL: https://webaim.org/projects/million/
  Niveau pyramide: 4
  Date: 2024
  Citation: 95.9% des sites web echouent au niveau AA.
  Conflit d'interet: non — etude independante (WebAIM, Utah State University)

SOURCE 6:
  Nom: axe-core (Deque)
  URL: https://github.com/dequelabs/axe-core
  Niveau pyramide: 3
  Date: ongoing
  Citation: 30-40% des issues d'accessibilite detectees automatiquement. Le reste necessite des tests manuels.
  Conflit d'interet: oui potentiel — Deque vend des services d'accessibilite, axe-core est l'outil gratuit

---

### i18n.md

SOURCE 1:
  Nom: npm trends — react-i18next
  URL: https://npmtrends.com/react-i18next-vs-react-intl
  Niveau pyramide: 4
  Date: ongoing
  Citation: react-i18next 4M/sem #1 vs FormatJS/react-intl 1.5M/sem.
  Conflit d'interet: non — donnees publiques de registre

SOURCE 2:
  Nom: State of JS 2024 — i18next
  URL: https://stateofjs.com/
  Niveau pyramide: 4
  Date: 2024
  Citation: i18next #1 awareness parmi les solutions d'internationalisation.
  Conflit d'interet: non — enquete communautaire

SOURCE 3:
  Nom: i18next docs
  URL: https://www.i18next.com/
  Niveau pyramide: 3
  Date: ongoing
  Citation: Framework d'internationalisation, integration React via react-i18next.
  Conflit d'interet: oui potentiel — documentation du projet lui-meme (mais open source, pas de modele commercial direct)
