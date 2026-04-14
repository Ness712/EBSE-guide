# Migrations de base de donnees

**[RECOMMANDE]** **Flyway** pour les migrations versionnees et reproductibles | Score GRADE : 5/7

Les migrations manuelles (scripts ad-hoc, modifications en prod) sont la premiere source de drift entre environnements. Flyway versionne chaque changement de schema.

## Convention de nommage

```
V1__create_users_table.sql
V2__add_email_column.sql
V3__create_messages_table.sql
R__refresh_stats_view.sql     (repeatable migration)
```

| Prefix | Usage |
|--------|-------|
| `V{n}__` | Migration versionnee (executee une seule fois, dans l'ordre) |
| `R__` | Migration repeatable (re-executee si le checksum change) |

## Configuration Spring Boot

```properties
# application.properties — Flyway auto-configure par Spring Boot
spring.flyway.enabled=true
spring.flyway.locations=classpath:db/migration
spring.flyway.baseline-on-migrate=true
```

Aucune dependance supplementaire si `flyway-core` est dans le classpath — Spring Boot l'auto-configure.

## Regles pour zero-downtime

| Regle | Exemple |
|-------|---------|
| Additive only (pas de DROP/RENAME direct) | Ajouter colonne, puis migrer les donnees, puis supprimer l'ancienne |
| Colonne nullable d'abord | `ALTER TABLE users ADD COLUMN email VARCHAR(255)` (sans NOT NULL) |
| Backfill en migration separee | V3 ajoute la colonne, V4 remplit les donnees, V5 ajoute la contrainte |
| Jamais modifier une migration deja appliquee | Flyway verifie les checksums, une modification = echec |

## Pourquoi pas les autres ?

| Alternative | Verdict |
|-------------|---------|
| Liquibase | Plus verbeux (XML/YAML), adoption inferieure en Spring Boot |
| JPA auto-ddl | **JAMAIS en prod** — non reproductible, pas de versioning |

## Sources

- [niv. 3] Spring Boot docs — Flyway auto-configuration, migration best practices
- [niv. 3] Flyway docs — naming conventions, repeatable migrations, checksum validation
- [niv. 5] Fowler — Evolutionary Database Design, versioned migrations
