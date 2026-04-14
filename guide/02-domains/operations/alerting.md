# Alerting

**[BONNE PRATIQUE]** Alerter sur les symptomes, pas les causes — eviter l'alert fatigue | Score GRADE : 3/7

Un bon systeme d'alerting notifie sur ce que l'utilisateur ressent (latence, erreurs) et non sur les metriques internes (CPU). Trop d'alertes = alert fatigue = alertes ignorees.

```yaml
# Grafana alerting — alerte sur symptome (taux d'erreur)
groups:
  - name: symptoms
    rules:
      - alert: HighErrorRate
        expr: rate(http_server_requests_seconds_count{status=~"5.."}[5m]) > 0.01
        for: 5m
        labels:
          severity: critical
        annotations:
          summary: "Taux d'erreur 5xx > 1% depuis 5 minutes"
```

| Regle | Pourquoi | Source |
|-------|----------|--------|
| Alerter sur symptomes (latence, erreurs, disponibilite) | Ce que l'utilisateur voit | Google SRE ch.6 |
| Jamais alerter sur causes (CPU, memoire) seules | Pas toujours correle a un impact utilisateur | Google SRE ch.6 |
| Chaque alerte doit etre actionnable | Si pas d'action = supprimer l'alerte | Google SRE ch.6 |
| Regrouper les alertes (inhibition) | Eviter les cascades de notifications | Alertmanager docs |
| Escalade : Slack → PagerDuty/OpsGenie | On-call pour critical uniquement | Google SRE ch.6 |

Sources : Google SRE Book ch.6 — "every alert should be actionable" (niv. 5), DORA 2024 — alert fatigue correle avec burnout (niv. 4), Grafana Alerting docs (niv. 3)
