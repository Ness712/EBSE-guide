# Strategie de deploiement

**[RECOMMANDE]** Rolling update avec health checks pour zero-downtime | Score GRADE : 4/7

## Comparatif des strategies

| Strategie | Downtime | Rollback | Complexite | Cas d'usage |
|-----------|----------|----------|------------|-------------|
| **Rolling update** | Zero | Redeploy version N-1 | Faible | Defaut pour la plupart des apps |
| Blue-green | Zero | Switch instantane | Moyenne | Apps stateful, migrations complexes |
| Canary | Zero | Redirect 100% vers stable | Haute | Gros trafic, validation progressive |
| Recreate | Oui | Redeploy | Nulle | Dev/staging uniquement |

## Rolling update Docker Compose

```yaml
services:
  backend:
    image: ghcr.io/org/backend:${TAG}
    deploy:
      replicas: 2
      update_config:
        parallelism: 1
        delay: 30s
        order: start-first
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:8080/actuator/health"]
      interval: 10s
      timeout: 5s
      retries: 3
      start_period: 40s
```

## Regles pour zero-downtime

| Regle | Raison |
|-------|--------|
| Health check obligatoire | Le load balancer ne route que vers les instances saines |
| Migrations backward-compatible | Version N-1 et N coexistent pendant le rolling update |
| Graceful shutdown | Finir les requetes en cours avant arret (Spring `server.shutdown=graceful`) |
| Start-first ordering | La nouvelle instance demarre avant que l'ancienne s'arrete |

## Sources

- [niv. 4] DORA State of DevOps — zero-downtime deployments = predictor of elite performance
- [niv. 5] Twelve-Factor App Factor IX — disposability, fast startup, graceful shutdown
- [niv. 3] Docker Compose docs — deploy.update_config, healthcheck configuration
- [niv. 3] Spring Boot docs — graceful shutdown, actuator health endpoint
