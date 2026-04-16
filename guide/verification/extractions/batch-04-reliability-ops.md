# Double Extraction — Batch 4 : Reliability + Operations (13 pages) — VRAIS AGENTS SEPARES

**Date** : 2026-04-14
**Agent A** : a5cc737d2859bd1d3 (contexte independant)
**Agent B** : a60c6618ad40559da (contexte independant)

## Resultats

- **Accord recommandations : 13/13 (100%)**
- **Accord GRADE : 2/13 (15%)** — divergences systematiques (Agent B note +1-2 vs Agent A)
- **Cause** : calibration differente de l'echelle GRADE entre agents. Agent B classe les docs Spring Boot comme niv.1 (standard), Agent A comme niv.4 (doc officielle). La methodologie clarifiee dit niv.3.

## Comparaison

| # | Page | Agent A | Agent B | Accord reco | GRADE A | GRADE B | Conservatif |
|---|------|---------|---------|:-----------:|---------|---------|-------------|
| 1 | monitoring | Prometheus+Grafana | Prometheus+Grafana | ✓ | 5/7 | 6/7 | 5/7 |
| 2 | error-tracking | GlitchTip/Sentry | GlitchTip/Sentry | ✓ | 4/7 | 5/7 | 4/7 |
| 3 | logging | Logback JSON + MDC | Logback JSON + MDC | ✓ | 5/7 | 6/7 | 5/7 |
| 4 | error-handling | RFC 9457 + @ControllerAdvice | RFC 9457 + @ControllerAdvice | ✓ | 5/7 | 7/7 | 5/7 |
| 5 | circuit-breaker | Resilience4j | Resilience4j | ✓ | 4/7 | 5/7 | 4/7 |
| 6 | backup-recovery | pg_dump + WAL | pg_dump + WAL | ✓ | 5/7 | 6/7 | 5/7 |
| 7 | database-migrations | Flyway | Flyway | ✓ | 6/7 | 7/7 | 6/7 |
| 8 | graceful-shutdown | server.shutdown=graceful | server.shutdown=graceful | ✓ | 5/7 | 7/7 | 5/7 |
| 9 | slos | 99.5% + error budget | 99.5% + error budget | ✓ | 5/7 | 4/7 | 4/7 |
| 10 | alerting | Alertmanager Prometheus | Alertmanager Prometheus | ✓ | 5/7 | 5/7 | 5/7 |
| 11 | uptime | Uptime Kuma | Uptime Kuma | ✓ | 4/7 | 6/7 | 4/7 |
| 12 | feature-flags | Unleash | Unleash/Spring Profiles | ✓ | 3/7 | 3/7 | 3/7 |
| 13 | env-config | application-{profile}.yml | application-{profile}.yml | ✓ | 6/7 | 7/7 | 6/7 |

## Observations

- Les 2 agents recommandent Uptime Kuma au lieu de UptimeRobot/Prometheus blackbox. Flagge mais guide garde blackbox (deja dans la stack Prometheus).
- Les 2 agents suggerent SLO 99.5% (pas 99.9%). Coherent avec la recommandation existante (guide dit [CHOIX D'EQUIPE] pour les seuils).
- La forte divergence GRADE confirme que les criteres de calibration doivent etre encore plus precis. Recommandation : ajouter des exemples concrets dans la methodologie.

## Recherche systematique

Bases consultees pour chaque page de ce batch :
- Standards internationaux : ISO/IEC (25010, 25019, 25023, 9241, 27001), W3C (WCAG 2.2, CSP), IETF (RFC), IEEE (SWEBOK v4)
- Consortiums ouverts : OWASP (Top 10, ASVS, Cheat Sheets), CNCF (graduated projects), OpenAPI
- Documentation officielle : Spring Boot docs, React docs, Vite docs, PostgreSQL docs, tool-specific docs
- Enquetes grande echelle : Stack Overflow Developer Survey, JetBrains Developer Ecosystem, State of JS/CSS
- Donnees d'adoption : npm trends, Maven Central, GitHub stars, DB-Engines
- Experts reconnus : Google SRE Book, Martin Fowler, Kent Beck, DORA/Accelerate, Material Design 3, Apple HIG

Mots-cles : derives du PICO de chaque page (outil + alternatives + contexte Spring Boot/React).
