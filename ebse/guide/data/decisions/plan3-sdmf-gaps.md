# Plan 3 — SDMF sur EBSE : Domaines sans PICOC

**Date :** 2026-04-18
**Méthode :** SDMF appliqué aux décisions EBSE — FMEA + STRIDE sur l'architecture OLS vs 235 décisions existantes
**Objectif :** Identifier les domaines techniques OLS sans décision sourcée → nouveaux SLRs à lancer

---

## Couverture EBSE par domaine — Résumé

| Domaine | PICOC existant | Couvert ? |
|---------|---------------|-----------|
| Backend framework (NestJS) | backend-framework | ✅ |
| Authentification (JWT, OAuth) | authentication, mfa-strategy, password-hashing, session-management | ✅ |
| Realtime (WebSocket, STOMP) | realtime | ✅ |
| Base de données (PostgreSQL, Prisma) | database, database-migrations, transactions, connection-pooling | ✅ |
| Cache (Redis) | caching | ✅ |
| API design (REST, versioning) | api-protocol, api-versioning, api-security, openapi | ✅ |
| Error handling / tracking | error-handling, error-tracking | ✅ |
| Logging | logging, distributed-tracing | ✅ |
| Sécurité OWASP | owasp-top10, input-validation, encryption, zero-trust | ✅ |
| CI/CD | ci-pipeline, deployment-strategy, release-management | ✅ |
| Docker | containerization, container-registry | ✅ |
| Observabilité | monitoring, alerting, observability-opentelemetry | ✅ |
| Tests (unit, E2E, visual) | unit-tests, e2e-tests, visual-regression-testing, contract-tests | ✅ |
| Frontend (React, state, forms) | frontend-framework, state-management, forms | ✅ |
| Rate limiting | rate-limiting | ✅ |
| Health checks | monitoring, slos | ✅ |
| AI agent (34 décisions) | ai-agent-* | ✅ hypercouvert |
| **Object Storage (MinIO)** | — | ❌ **GAP** |
| **File upload security** | — | ❌ **GAP** |
| **STOMP channel authorization** | — | ❌ **GAP** |
| **Enterprise SSO (CAS, SAML)** | — | ❌ **GAP** |
| **Backup / DR (RPO/RTO)** | — | ❌ **GAP** |
| **Zero-downtime migrations** | — | ❌ **GAP** |
| **Email architecture** | — | ❌ **GAP** |
| **Encryption at-rest (PostgreSQL)** | — | ❌ **GAP** |
| **Frontend cache invalidation (TanStack)** | — | ❌ **PARTIEL** |
| **N+1 / Prisma query optimization** | — | ❌ **PARTIEL** |
| **GDPR student data retention** | gdpr (partiel) | ⚠️ PARTIEL |

---

## Gaps prioritaires — Nouveaux SLRs à lancer

| # | Domaine | Impact OLS | Probabilité SLR | Score | Tier |
|---|---------|-----------|----------------|-------|------|
| 1 | **File upload security & anti-virus scanning** | 8 | 8 | **64** | CRITIQUE |
| 2 | **Object storage architecture (MinIO/S3)** | 7 | 8 | **56** | CRITIQUE |
| 3 | **Database backup & DR (RPO/RTO)** | 8 | 7 | **56** | CRITIQUE |
| 4 | **Real-time channel authorization (STOMP ACLs)** | 7 | 7 | **49** | HIGH |
| 5 | **Enterprise SSO (CAS, SAML, OIDC federation)** | 8 | 6 | **48** | HIGH |
| 6 | **Email architecture & scalability** | 6 | 7 | **42** | HIGH |
| 7 | **Zero-downtime migrations (blue-green schema)** | 7 | 6 | **42** | HIGH |
| 8 | **Encryption at-rest (PostgreSQL TDE)** | 6 | 7 | **42** | HIGH |
| 9 | **Frontend cache invalidation (TanStack Query)** | 6 | 6 | **36** | MEDIUM |
| 10 | **Prisma N+1 prevention & query optimization** | 6 | 6 | **36** | MEDIUM |
| 11 | **SLI/SLO definition & error budgets** | 5 | 6 | **30** | MEDIUM |
| 12 | **GDPR student data retention / right-to-erasure** | 6 | 5 | **30** | MEDIUM |
| 13 | **Rate limiting granularity (per-IP vs per-user)** | 5 | 5 | **25** | LOW |
| 14 | **Graceful degradation / offline-first PWA** | 5 | 5 | **25** | LOW |
| 15 | **ORM selection validation (Prisma long-term)** | 5 | 5 | **25** | LOW |

---

## Analyse STRIDE architecture OLS — Gaps sécurité

| Composant | Catégorie STRIDE | PICOC existant | Gap critique |
|-----------|-----------------|---------------|-------------|
| NestJS Backend | Information Disclosure | encryption | ⚠️ File upload scanning, GDPR retention |
| React Frontend | DoS | rate-limiting | ❌ Pas de rate limit côté frontend |
| PostgreSQL | Information Disclosure | encryption | ❌ **Encryption at-rest non sourcée** |
| PostgreSQL | EoP | authorization-patterns | ⚠️ Database RBAC granulaire absent |
| Redis | Information Disclosure | caching | ❌ **Cache key governance / encryption sensible** |
| MinIO | Tampering | — | ❌ **Object versioning + lifecycle policy absent** |
| MinIO | Information Disclosure | — | ❌ **Encryption in-transit + at-rest non sourcée** |
| WebSocket/STOMP | Tampering | — | ❌ **STOMP message integrity absent** |
| WebSocket/STOMP | EoP | — | ❌ **Channel-scoped authorization absent** |
| WebSocket/STOMP | DoS | — | ❌ **Concurrent connection limits absent** |

---

## Choix techniques ols.json sans décision EBSE

| Choix OLS | Décision mappée | Gap |
|-----------|----------------|-----|
| MinIO S3-compatible | — | ❌ **Pas de object-storage.json** |
| Fastify vs Express (NestJS) | backend-framework (NestJS couvert, pas Fastify vs Express) | ⚠️ Implicite |
| STOMP patterns | realtime (choix couvert, patterns STOMP non) | ⚠️ Partiel |
| Prisma ORM | database (PostgreSQL couvert, ORM comparison absent) | ⚠️ Partiel |
| Zustand + TanStack Query | state-management (Zustand implicite, invalidation absente) | ⚠️ Partiel |
| CAS + Google OAuth | authentication (OAuth couvert, CAS/SAML federation absent) | ⚠️ Partiel |

---

## Plan d'exécution des SLRs

### Tier 1 — CRITIQUE (lancer en priorité)

**SLR-1 : `ai-ols-file-upload-security`**
- Question PICOC : "Pour une plateforme collaborative en ligne, quelles mesures de sécurité sont nécessaires pour les fichiers uploadés par les utilisateurs ?"
- Evidence attendue : OWASP File Upload Cheat Sheet, ClamAV patterns, MIME validation, sandboxed preview, ransomware protection
- Effort estimé : 20-30h

**SLR-2 : `ai-ols-object-storage-architecture`**
- Question PICOC : "Comment structurer la gestion d'un object storage compatible S3 (MinIO) pour une startup : buckets, lifecycle, backup, encryption ?"
- Evidence attendue : AWS S3 best practices, MinIO docs, OWASP storage patterns, disaster recovery benchmarks
- Effort estimé : 20-25h

**SLR-3 : `ai-ols-database-backup-dr`**
- Question PICOC : "Quelle stratégie de backup et disaster recovery (RPO/RTO) adopter pour PostgreSQL dans une startup en croissance ?"
- Evidence attendue : AWS RDS, PITR, Barman, pgBackRest, warm vs cold standby, RPO/RTO benchmarks
- Effort estimé : 20-25h

**SLR-4 : `ai-ols-realtime-channel-authorization`**
- Question PICOC : "Comment implémenter une autorisation granulaire (par channel/room) sur des connexions WebSocket avec STOMP ?"
- Evidence attendue : STOMP spec, JWT channel binding, OWASP WebSocket, message broker ACL patterns
- Effort estimé : 15-20h

**SLR-5 : `ai-ols-enterprise-sso`**
- Question PICOC : "Quand utiliser CAS vs SAML vs OpenID Connect pour intégrer des partenaires universitaires ?"
- Evidence attendue : CAS whitepaper, SAML 2.0, OIDC federation, university IT patterns
- Effort estimé : 20-30h

### Tier 2 — HIGH (après Tier 1)

- `ai-ols-email-architecture` : SMTP vs transactional provider, templates, retry
- `ai-ols-zero-downtime-migrations` : Blue-green schema changes, rollback guarantees
- `ai-ols-encryption-at-rest` : PostgreSQL TDE, filesystem encryption, key management

---

## Statistiques globales

- **Décisions EBSE existantes :** 235
- **Domaines techniques OLS couverts :** ~28/35 (80%)
- **Domaines avec gap critique :** 5 (Tier 1)
- **Domaines avec gap partiel :** 7 (Tier 2-3)
- **Nouveaux SLRs recommandés :** 15 (5 critiques, 3 high, 4 medium, 3 low)

*Rapport généré par analyse SDMF Plan 3 — 2026-04-18*
