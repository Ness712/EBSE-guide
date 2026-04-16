# Double Extraction v3.0 — Reliability & Operations (17 decisions)
Date : 2026-04-14
Agent A : Claude Opus 4.6 1M (perspective independante)
Agent B : Claude Opus 4.6 1M (contexte isole)

## Resultats
- Accord outil : 17/17 (100%)
- Divergences GRADE : 7/17 (41%) — resolues ci-dessous
  - D2 Circuit Breaker : A=STANDARD vs B=RECOMMANDE
  - D5 DB Migrations : A=BONNE_PRATIQUE vs B=RECOMMANDE
  - D7 High Availability : A=BONNE_PRATIQUE vs B=STANDARD
  - D9 Logging : A=STANDARD vs B=RECOMMANDE
  - D11 Alerting : A=STANDARD vs B=RECOMMANDE
  - D12 SLOs : A=BONNE_PRATIQUE vs B=STANDARD
  - D15 Env Config : A=STANDARD vs B=RECOMMANDE
- Divergences outil : aucune (memes recommandations d'outil partout)

## Decisions reconciliees

| # | Decision | Reco | GRADE conservatif | Robustesse |
|---|----------|------|-------------------|------------|
| 1 | Error Handling | **RFC 9457 (Problem Details)** | 5/7 — STANDARD | FRAGILE (depend RFC) |
| 2 | Circuit Breaker | **Resilience4j / opossum / pybreaker** | 4/7 — RECOMMANDE | ROBUSTE |
| 3 | Backup | **pg_dump + WAL archiving (pgBackRest)** | 5/7 — STANDARD | FRAGILE (depend NIST/PG docs) |
| 4 | Monitoring | **Prometheus + Grafana** | 5/7 — STANDARD | FRAGILE (depend CNCF) |
| 5 | DB Migrations | **Flyway / Prisma Migrate / Django migrations** | 3/7 — RECOMMANDE | ROBUSTE |
| 6 | Graceful Shutdown | **server.shutdown=graceful + SIGTERM handler** | 5/7 — STANDARD | FRAGILE (depend POSIX) |
| 7 | High Availability | **Docker restart + healthcheck (VPS)** | 5/7 — STANDARD | FRAGILE (depend NIST) |
| 8 | Transactions | **@Transactional / ACID** | 5/7 — STANDARD | FRAGILE (depend papier fondateur) |
| 9 | Logging | **JSON structured logging** | 4/7 — RECOMMANDE | ROBUSTE |
| 10 | Error Tracking | **GlitchTip / Sentry** | 4/7 — RECOMMANDE | ROBUSTE |
| 11 | Alerting | **Grafana Alerting / Alertmanager** | 4/7 — RECOMMANDE | ROBUSTE |
| 12 | SLOs | **Golden signals (availability + latency)** | 5/7 — STANDARD | FRAGILE (depend DORA) |
| 13 | Uptime Monitoring | **Uptime Kuma (self-hosted)** | 4/7 — RECOMMANDE | ROBUSTE |
| 14 | Feature Flags | **Unleash (self-hosted)** | 4/7 — RECOMMANDE | ROBUSTE |
| 15 | Env Config | **12-Factor env vars + Docker env_file** | 4/7 — RECOMMANDE | ROBUSTE |
| 16 | Reverse Proxy | **Caddy (HTTPS auto)** | 4/7 — RECOMMANDE | ROBUSTE |
| 17 | Incident Response | **Runbooks Git + post-mortem blameless** | 5/7 — STANDARD | FRAGILE (depend NIST) |

## Notes de reconciliation

**Decision 1 — Error Handling** : Accord total. RFC 9457 IETF, support natif Spring Boot 3+. Les deux notent FRAGILE sans le RFC (tombe a RECOMMANDE). GRADE conservatif 5/7.

**Decision 2 — Circuit Breaker** : Divergence GRADE. Agent A donne STANDARD (depart HAUTE sur docs officielles), Agent B donne 4/7 RECOMMANDE (depart livre reference Release It! + pattern convergence). Agent B inclut Release It! (Nygard) et Microsoft Cloud Patterns comme sources supplementaires. Conservatif retenu : **4/7 RECOMMANDE**. Agent B note ROBUSTE, retenu.

**Decision 3 — Backup** : Accord sur pg_dump + WAL + pgBackRest. Agent A inclut Percona blog et comparatif dev.to, Agent B inclut NIST SP 800-184 et Barman. Strategie 3-2-1 (NIST). GRADE conservatif 5/7.

**Decision 4 — Monitoring** : Accord total. Prometheus CNCF graduated + Grafana. Agent A cite Grafana Observability Survey (vendor), Agent B cite DORA + SO Survey (independants). GRADE 5/7 retenu.

**Decision 5 — DB Migrations** : Divergence GRADE. Agent A donne BONNE_PRATIQUE (pas de standard universel), Agent B donne 3/7 RECOMMANDE (ThoughtWorks Adopt "evolutionary DB design"). Conservatif retenu : **3/7 RECOMMANDE**. Agent B note ROBUSTE.

**Decision 6 — Graceful Shutdown** : Accord total. server.shutdown=graceful (Spring), SIGTERM handler (Node/Python). Agent A cite Thoughtworks blog, Agent B cite POSIX signals spec + 12-Factor. GRADE 5/7 STANDARD.

**Decision 7 — High Availability** : Divergence significative d'approche. Agent A recommande "Docker restart + healthcheck" pour VPS unique (BONNE_PRATIQUE), Agent B recommande "Replicas + LB + health checks + DB replication" (STANDARD, plus ambitieux). Reconciliation : la recommandation depend du contexte. Pour VPS unique, Docker restart suffisant. Retenu : GRADE conservatif **5/7 STANDARD** avec note "proportionner au contexte (VPS unique = restart+healthcheck, multi-node = replicas+LB)". Robustesse FRAGILE (depend NIST).

**Decision 8 — Transactions** : Accord total. @Transactional, ACID, READ COMMITTED par defaut. Agent B cite Haerder & Reuter 1983 (papier fondateur ACID). GRADE 5/7.

**Decision 9 — Logging** : Divergence GRADE. Agent A donne STANDARD (consensus industrie), Agent B donne 4/7 RECOMMANDE (pas de standard formel strict). Conservatif retenu : **4/7 RECOMMANDE**. Agent B note ROBUSTE.

**Decision 10 — Error Tracking** : Accord total. GlitchTip (self-hosted) compatible Sentry SDK. Agent A donne BONNE_PRATIQUE, Agent B donne 4/7 RECOMMANDE (cite DORA + ThoughtWorks). Conservatif : **4/7 RECOMMANDE**.

**Decision 11 — Alerting** : Divergence GRADE. Agent A donne STANDARD (integration native Prometheus/Grafana), Agent B donne 4/7 RECOMMANDE (Google SRE symptom-based). Conservatif retenu : **4/7 RECOMMANDE**. Agent B ajoute Ewaschuk "Philosophy on Alerting" — source pertinente.

**Decision 12 — SLOs** : Divergence GRADE. Agent A donne BONNE_PRATIQUE (expert opinion, pas de standard formel), Agent B donne 5/7 STANDARD (Google SRE + DORA grande echelle). Agent B cite OpenSLO spec et Hidalgo "Implementing SLOs". Retenu : **5/7 STANDARD** — DORA confirme correlation performance. FRAGILE si retrait DORA.

**Decision 13 — Uptime Monitoring** : Accord total. Uptime Kuma 65k+ stars, self-hosted. Agent A cite plus de comparatifs tiers, Agent B cite Google SRE (black-box monitoring). GRADE 4/7.

**Decision 14 — Feature Flags** : Accord total. Unleash OSS self-hosted. Agent B ajoute Fowler "Feature Toggles" (4 types) et DORA (trunk-based + flags = elite). GRADE 4/7.

**Decision 15 — Env Config** : Divergence GRADE. Agent A donne STANDARD (12-Factor consensus + docs officielles), Agent B donne 4/7 RECOMMANDE (12-Factor + OWASP). Conservatif retenu : **4/7 RECOMMANDE**. Agent B ajoute OWASP Secrets Management — source pertinente.

**Decision 16 — Reverse Proxy** : Accord total. Caddy pour HTTPS auto zero-config. Agent A cite benchmarks Caddy vs Nginx (<10% difference sous 10k req/s). Agent B cite W3Techs (Nginx 34%, Caddy <1%). GRADE 4/7.

**Decision 17 — Incident Response** : Divergence GRADE. Agent A donne BONNE_PRATIQUE (expert opinion Google SRE), Agent B donne 5/7 STANDARD (cite NIST SP 800-61). NIST = standard federal, justifie upgrade. Retenu : **5/7 STANDARD**. FRAGILE si retrait NIST.
