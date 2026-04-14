# Date et heure

**[STANDARD]** `java.time` (backend) + `dayjs` (frontend), toujours UTC cote serveur | Score GRADE : 6/7

Stocker et transmettre en UTC. Convertir en local uniquement a l'affichage cote client.

```java
// Backend — toujours UTC
Instant now = Instant.now();                    // stockage et API
ZonedDateTime paris = now.atZone(ZoneId.of("Europe/Paris")); // affichage seulement

// DTO — format ISO 8601
@JsonFormat(pattern = "yyyy-MM-dd'T'HH:mm:ss'Z'", timezone = "UTC")
private Instant createdAt;
```

```typescript
// Frontend — dayjs avec plugin UTC + timezone
import dayjs from 'dayjs';
import utc from 'dayjs/plugin/utc';
import tz from 'dayjs/plugin/timezone';
dayjs.extend(utc); dayjs.extend(tz);
const local = dayjs.utc(apiDate).tz('Europe/Paris').format('DD/MM/YYYY HH:mm');
```

| Regle | Implementation |
|-------|---------------|
| Stockage DB | `TIMESTAMP WITH TIME ZONE` (PostgreSQL) |
| API JSON | ISO 8601 : `2026-04-14T10:30:00Z` |
| Jamais | `java.util.Date`, `moment.js` (deprecie) |

Sources : ISO 8601 — format date/heure international (niv. 1), Java 21 docs — java.time API (niv. 5), OWASP — time zone confusion vulnerabilities (niv. 3)
