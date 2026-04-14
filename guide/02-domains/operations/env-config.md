# Configuration par environnement

**[STANDARD]** `application-{profile}.yml` par environnement, secrets via variables d'env | Score GRADE : 6/7

La configuration varie entre les environnements, le code non. Jamais de secrets dans les fichiers versiones.

```yaml
# application.yml — valeurs par defaut communes
spring:
  profiles:
    active: ${SPRING_PROFILES_ACTIVE:dev}

# application-dev.yml — developpement local
# application-staging.yml — pre-production
# application-prod.yml — production (secrets via env vars)
spring:
  datasource:
    url: ${DATABASE_URL}
    username: ${DATABASE_USERNAME}
    password: ${DATABASE_PASSWORD}
```

| Regle | Implementation |
|-------|---------------|
| Config par env | `application-{profile}.yml` |
| Secrets | Variables d'environnement, jamais dans Git |
| Activation | `SPRING_PROFILES_ACTIVE=prod` |
| Validation | `@ConfigurationProperties` + `@Validated` |

Sources : Twelve-Factor App III — config dans l'environnement (niv. 3), Spring Boot docs — Externalized Configuration (niv. 5), OWASP — ne jamais commiter de secrets (niv. 3)
