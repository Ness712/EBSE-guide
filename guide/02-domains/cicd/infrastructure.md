# Infrastructure as Code

**[RECOMMANDE]** Docker Compose pour petites equipes, Terraform pour cloud multi-services | Score GRADE : 4/7

L'infrastructure doit etre declarative, versionnee, et reproductible. Docker Compose suffit pour les projets mono-serveur ; Terraform s'impose quand l'infra cloud grandit.

```yaml
# Docker Compose — IaC pour petites equipes (mono-serveur)
services:
  app:
    image: ghcr.io/org/app:${TAG}
    ports: ["8080:8080"]
    environment:
      SPRING_PROFILES_ACTIVE: prod
    depends_on:
      db: { condition: service_healthy }
  db:
    image: postgres:17
    volumes: ["pgdata:/var/lib/postgresql/data"]
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U app"]
volumes:
  pgdata:
```

| Outil | Use case | Quand passer au suivant |
|-------|----------|------------------------|
| **Docker Compose** | 1 serveur, < 5 services | Besoin multi-serveur ou cloud managed |
| **Terraform** | Cloud multi-services (DNS, CDN, DB managed) | Deja la bonne echelle pour la plupart |
| **Ansible** | Configuration de serveurs existants | Complement a Terraform, pas remplacement |

| Principe | Source |
|----------|--------|
| Infra declarative et versionnee | SWEBOK v4 s2.2 |
| Environnements identiques (dev/staging/prod) | Twelve-Factor Factor X |
| Jamais de config manuelle en prod | DORA — "manual changes = #1 cause of incidents" |

Sources : SWEBOK v4 s2.2 — infrastructure as code (niv. 1), Twelve-Factor Factor X — dev/prod parity (niv. 5), DORA 2024 — IaC correle avec deployment frequency (niv. 4), Docker Compose docs (niv. 3)
