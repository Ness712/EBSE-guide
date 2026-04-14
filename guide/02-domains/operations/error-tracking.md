# Error Tracking

**[RECOMMANDE]** Outil de suivi d'erreurs avec grouping, source maps et alerting | Score GRADE : 3/7

Les erreurs en production doivent etre capturees automatiquement, groupees et notifiees. Les logs seuls ne suffisent pas.

## Comparatif

| Critere | Sentry | GlitchTip |
|---------|--------|-----------|
| Adoption | 32% (SO Survey) | Niche (self-hosted) |
| Grouping automatique | Oui (fingerprinting avance) | Oui (basique) |
| Source maps (JS) | Oui | Oui |
| Alerting | Email, Slack, PagerDuty | Email, webhooks |
| Self-hosted | Oui (lourd, 30+ containers) | Oui (leger, 1 container) |
| SaaS gratuit | 5k events/mois | Non |
| Prix | $26/dev/mois (Team) | Gratuit (self-hosted) |

**Recommandation** : Sentry SaaS pour les equipes sans infra. GlitchTip self-hosted si budget zero et infra existante.

## Configuration Spring Boot (Sentry)

```properties
# application.properties
sentry.dsn=https://examplePublicKey@o0.ingest.sentry.io/0
sentry.traces-sample-rate=0.2
sentry.environment=${SPRING_PROFILES_ACTIVE}
```

## Configuration React (Sentry)

```typescript
import * as Sentry from '@sentry/react';

Sentry.init({
  dsn: import.meta.env.VITE_SENTRY_DSN,
  environment: import.meta.env.MODE,
  integrations: [Sentry.browserTracingIntegration()],
  tracesSampleRate: 0.2,
});
```

## Sources

- [niv. 4] Stack Overflow Survey 2024 — Sentry 32% adoption parmi les outils d'observabilite
- [niv. 3] Sentry docs — Spring Boot integration, source maps, alerting
- [niv. 3] GlitchTip docs — Sentry SDK compatible, lightweight self-hosted
