# SLOs (Service Level Objectives)

**[BONNE PRATIQUE]** Definir des SLOs mesurables avec error budgets | Score GRADE : 2/7

Les SLOs transforment la fiabilite en objectifs concrets et mesurables. Sans SLOs, on ne sait pas quand investir en fiabilite vs fonctionnalites.

## SLOs recommandes (web app standard)

| SLO | Cible | Mesure |
|-----|-------|--------|
| Disponibilite | >= 99.9% (8.7h downtime/an) | `(1 - erreurs_5xx / total_requetes) * 100` |
| Latence P95 | < 500ms | Percentile 95 du temps de reponse |
| Taux d'erreur | < 0.1% | `erreurs_5xx / total_requetes` |
| Freshness (donnees) | < 1 min de retard | Lag de replication / cache |

## Error budgets

```
Error budget = 1 - SLO target

Exemple : SLO 99.9% disponibilite
  → Error budget = 0.1% = 8.7h/an = 43.8min/mois

Si le budget est consume :
  → Gel des features, focus fiabilite
Si le budget est intact :
  → Deploiement de nouvelles fonctionnalites
```

## Implementation Prometheus

```yaml
# alerte Prometheus — SLO de latence
- alert: HighP95Latency
  expr: histogram_quantile(0.95, rate(http_request_duration_seconds_bucket[5m])) > 0.5
  for: 5m
  labels: { severity: warning }
  annotations: { summary: "P95 latence > 500ms depuis 5 minutes" }
```

## Sources

- [niv. 1] ISO/IEC 25023 — mesures de qualite des systemes (disponibilite, performance)
- [niv. 5] Google SRE Book Ch. 4 — SLOs, error budgets, SLI definitions
- [niv. 5] Google SRE Workbook Ch. 2 — implementing SLOs in practice
