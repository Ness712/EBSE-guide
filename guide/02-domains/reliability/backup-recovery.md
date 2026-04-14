# Backup & Disaster Recovery

**[STANDARD]** pg_dump quotidien + WAL archiving + RPO/RTO definis | Score GRADE : 5/7

## Strategie 2 niveaux

| Niveau | Outil | RPO | Usage |
|--------|-------|-----|-------|
| Backup logique | pg_dump quotidien | 24h | Restauration complete, cross-version |
| WAL archiving | Continuous | < 1h | Point-in-time recovery (PITR) |

## pg_dump automatise (cron)

```bash
#!/bin/bash
# /opt/ols/scripts/backup-pg.sh — cron: 0 3 * * *
set -euo pipefail
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_DIR="/opt/ols/backups/postgres"

pg_dump -Fc -Z 9 -f "${BACKUP_DIR}/ols_${TIMESTAMP}.dump" ols_prod

# Offsite
rclone copy "${BACKUP_DIR}/ols_${TIMESTAMP}.dump" remote:ols-backups/daily/

# Retention 30 jours
find "${BACKUP_DIR}" -name "*.dump" -mtime +30 -delete
```

## WAL archiving (PITR)

```ini
# postgresql.conf
wal_level = replica
archive_mode = on
archive_command = 'test ! -f /opt/ols/backups/wal/%f && cp %p /opt/ols/backups/wal/%f'
```

## Cibles RPO/RTO

| Metrique | Cible | Justification |
|----------|-------|---------------|
| RPO (perte max) | <= 1h | WAL archiving continu |
| RTO (temps restauration) | <= 4h | pg_restore + WAL replay |

**Tester les restaurations regulierement** — un backup non teste n'est pas un backup.

Sources : PostgreSQL docs Ch. 26 PITR (niv. 3), ISO 27001 A.8.13 Information backup (niv. 1), SWEBOK v4 Ch.12 Maintenance (niv. 1), Google SRE Book data integrity (niv. 5)
