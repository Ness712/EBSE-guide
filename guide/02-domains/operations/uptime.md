# Uptime monitoring

**[RECOMMANDE]** Monitoring externe + /actuator/health endpoint | Score GRADE : 4/7

Le monitoring interne ne suffit pas — si le serveur tombe, il ne peut pas reporter sa propre indisponibilite. Un check externe est indispensable.

```yaml
# Spring Boot — health endpoint (deja inclus avec Actuator)
management:
  endpoints:
    web:
      exposure:
        include: health
  endpoint:
    health:
      show-details: when_authorized
      probes:
        enabled: true  # /actuator/health/liveness + /readiness
```

```yaml
# Prometheus blackbox exporter — check externe
modules:
  http_2xx:
    prober: http
    timeout: 5s
    http:
      valid_http_versions: ["HTTP/1.1", "HTTP/2.0"]
      valid_status_codes: [200]
```

| Outil | Type | Forces |
|-------|------|--------|
| **UptimeRobot** (SaaS) | Externe | Gratuit 50 monitors, multi-region, simple |
| **Prometheus blackbox** | Externe (self-hosted) | Integration Grafana native, pas de SaaS |
| **/actuator/health** | Interne | Liveness + readiness, checks DB/Redis inclus |

| Regle | Pourquoi |
|-------|----------|
| Toujours un check externe | Le serveur ne peut pas reporter sa propre mort |
| Separer liveness et readiness | Kubernetes/Docker healthcheck en depend |
| Check toutes les 60s minimum | Detecter les pannes en < 2 min |

Sources : Spring Boot Actuator docs — health probes, liveness/readiness (niv. 3), Prometheus blackbox exporter docs (niv. 3), Google SRE Book — monitoring externe obligatoire (niv. 5), SWEBOK v4 — availability monitoring (niv. 1)
