# Connection pooling

**[STANDARD]** HikariCP avec configuration par defaut Spring Boot | Score GRADE : 5/7

HikariCP est le pool par defaut de Spring Boot. La config par defaut (10 connexions) convient a la plupart des apps. Ne pas sur-dimensionner.

```yaml
# application.yml — ajuster seulement si necessaire
spring:
  datasource:
    hikari:
      maximum-pool-size: 10          # defaut, formule: (2 * CPU cores) + nb_disques
      minimum-idle: 10               # = maximum-pool-size (recommande HikariCP)
      connection-timeout: 30000      # 30s max pour obtenir une connexion
      idle-timeout: 600000           # 10min avant liberation idle
      max-lifetime: 1800000          # 30min, inferieur au timeout DB
```

| Regle | Valeur |
|-------|--------|
| Formule pool size | (2 * CPU cores) + nb disques SSD |
| minimum-idle | Egal a maximum-pool-size |
| max-lifetime | < timeout PostgreSQL (`idle_in_transaction_session_timeout`) |

Sources : Spring Boot docs — HikariCP auto-configuration (niv. 5), HikariCP wiki — About Pool Sizing, benchmarks (niv. 3), PostgreSQL docs — connection management (niv. 5)
