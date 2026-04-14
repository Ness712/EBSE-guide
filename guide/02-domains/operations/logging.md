# Logging

## Format

**[STANDARD]** Utiliser du **JSON structure** | Score GRADE : 6/7

Pas de logs texte non structure. Chaque ligne de log = un objet JSON avec des champs standardises.

```
// BON
{"timestamp":"2026-04-14T10:30:00Z","level":"INFO","service":"ols-backend","traceId":"abc123","userId":"42","event":"AUTHN_LOGIN_SUCCESS","message":"User logged in"}

// MAUVAIS
2026-04-14 10:30:00 INFO - User 42 logged in
```

### Champs obligatoires

| Champ | Source | Exemple |
|-------|--------|---------|
| timestamp (ISO 8601 UTC) | ISO 27002, OWASP, OpenTelemetry | `2026-04-14T10:30:00.000Z` |
| level / severity | CNCF TAG, OpenTelemetry | `INFO`, `ERROR`, `WARN`, `DEBUG` |
| service / appid | OWASP Vocabulary | `ols-backend` |
| traceId / spanId | OpenTelemetry | `abc123def456` |
| userId | ISO 27002, OWASP | `42` |
| event | OWASP Vocabulary | `AUTHN_LOGIN_SUCCESS` |
| message | Tous | Description humaine |

### Evenements de securite a logger (OWASP)

| Categorie | Exemples |
|-----------|----------|
| AUTHN | Login success/failure, logout, password change |
| AUTHZ | Access denied, privilege escalation |
| INPUT | Validation failure, encoding violation |
| DATA | Create/update/delete on sensitive data |
| SYS | Startup, shutdown, config change |

### Ne JAMAIS logger

- Mots de passe, tokens, cles de chiffrement
- Donnees bancaires ou cartes de paiement
- PII non necessaire (RGPD)
- Session IDs, connection strings
- Code source

Sources : OWASP Logging Cheat Sheet, ISO 27002:2022 Control 8.15, CNCF TAG

---

## Librairie — Java (Spring Boot)

**[RECOMMANDE]** **SLF4J + Logback** (defaut Spring Boot) | Score GRADE : 5/7

```properties
# application.properties — activer le JSON structure
logging.structured.format.console=ecs
```

Formats JSON supportes nativement (Spring Boot 3.4+) :
- `ecs` — Elastic Common Schema (compatible ELK + OpenTelemetry)
- `logstash` — Logstash JSON format
- `gelf` — Graylog Extended Log Format

### Pourquoi pas Log4j2 ?

| Critere | Logback | Log4j2 |
|---------|---------|--------|
| Defaut Spring Boot | Oui | Non (swap necessaire) |
| Performance sync | 2 140 ops/ms | 884 ops/ms |
| JSON natif (Spring) | Oui (3.4+) | Oui (config) |
| Securite | Propre | Log4Shell CVE-2021-44228 (CVSS 10.0) |
| Bridge OpenTelemetry | Oui | Oui |

Sources : Spring Boot docs, Logback benchmarks, NIST NVD (CVE-2021-44228)

---

## Librairie — Node.js

**[RECOMMANDE]** **Pino** | Score GRADE : 3/7

```javascript
import pino from 'pino';
const logger = pino({ level: 'info' });
logger.info({ userId: 42, event: 'AUTHN_LOGIN_SUCCESS' }, 'User logged in');
```

| Critere | Pino | Winston |
|---------|------|---------|
| Performance | 50 000 logs/sec | 10 000 logs/sec |
| Format defaut | JSON natif | Texte (JSON en option) |
| Downloads npm | ~21.5M/sem | ~18.8M/sem |
| Twelve-Factor | stdout par defaut | Config necessaire |

Sources : npm trends, Better Stack benchmarks, Twelve-Factor App

---

## Routing

**[STANDARD]** Ecrire sur **stdout**, l'environnement route | Score GRADE : 5/7

L'application n'ecrit jamais dans des fichiers de log. Elle ecrit sur stdout. L'environnement (Docker, K8s, systemd) capture et route vers le systeme d'aggregation (Loki, ELK, etc.).

Source : Twelve-Factor App Factor XI, CNCF TAG, Spring Boot docs

---

## Protection des logs

**[STANDARD]** Logs proteges contre la falsification | Score GRADE : 6/7

| Pratique | Source |
|----------|--------|
| Stockage append-only (WORM) | ISO 27002 Control 8.15 |
| Separation des droits (admins ne peuvent pas modifier les logs) | ISO 27002 Control 8.15 |
| Retention >= 1 an | ISO 27002 Control 8.15 |
| Chiffrement au repos et en transit | CNCF TAG |
| Sanitization des inputs contre log injection | OWASP Logging Cheat Sheet |

---

## Sources

- [niv. 1] ISO/IEC 27002:2022 Control 8.15 — audit logs obligatoires, 5 champs, protection, 1 an retention
- [niv. 1] SWEBOK v4 — "logging must be collected and analyzed" at application level
- [niv. 2] OWASP Logging Cheat Sheet — format, evenements, never log PII
- [niv. 2] OWASP Logging Vocabulary — JSON format, event categories (AUTHN, AUTHZ, etc.)
- [niv. 2] OWASP Top 10:2025 A09 — logging failures = 9e risque web
- [niv. 2] OpenTelemetry Logs Spec — "structured logs are preferred in production"
- [niv. 2] Twelve-Factor App XI — "treat logs as event streams", write to stdout
- [niv. 2] CNCF TAG Observability — encrypt logs, no PII, use ERROR/WARN/INFO/DEBUG
- [niv. 3] Spring Boot docs — Logback default, structured JSON since 3.4 (ECS/GELF/Logstash)
- [niv. 3] Logback benchmarks — 2 140 ops/ms vs Log4j2 884 ops/ms
- [niv. 3] Pino benchmarks — 50k vs Winston 10k logs/sec
- [niv. 4] npm trends — Pino ~21.5M/sem, Winston ~18.8M/sem
- [niv. 4] New Relic Java Ecosystem — SLF4J 83% adoption, Logback 52%
- [niv. 5] Google SRE Book — structured logs for root cause, metrics for alerting

> Justification complete avec formulaires d'extraction : a venir (cases/P1-1-logging.md)
