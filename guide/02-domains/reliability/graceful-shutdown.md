# Graceful shutdown

**[RECOMMANDE]** Drainer les connexions avant l'arret — zero requetes perdues en deploiement | Score GRADE : 5/7

Un arret brutal (SIGKILL) perd les requetes en cours. Le graceful shutdown laisse les requetes actives se terminer avant de couper le processus.

```yaml
# Spring Boot — graceful shutdown (application.yml)
server:
  shutdown: graceful
spring:
  lifecycle:
    timeout-per-shutdown-phase: 30s
```

```yaml
# Docker Compose — laisser le temps au graceful shutdown
services:
  app:
    image: ghcr.io/org/app:latest
    stop_grace_period: 35s  # > timeout-per-shutdown-phase
```

| Etape | Ce qui se passe |
|-------|----------------|
| 1. SIGTERM recu | Spring arrete d'accepter de nouvelles connexions |
| 2. Drain | Les requetes en cours continuent jusqu'a completion |
| 3. Timeout (30s) | Si des requetes trainent, arret force |
| 4. SIGKILL | Docker envoie SIGKILL apres stop_grace_period |

| Regle | Pourquoi |
|-------|----------|
| `server.shutdown=graceful` | Active le drain de connexions |
| `stop_grace_period` > `timeout-per-shutdown-phase` | Evite le SIGKILL avant la fin du drain |
| Jamais de `kill -9` en prod | Perte de donnees, connexions DB orphelines |

Sources : Spring Boot docs — graceful shutdown (niv. 3), Docker docs — SIGTERM/SIGKILL lifecycle (niv. 3), Twelve-Factor Factor IX — disposability, fast shutdown (niv. 5), SWEBOK v4 — reliability, fault tolerance (niv. 1)
