# Recherche full-text

**[BONNE PRATIQUE]** MeiliSearch (self-hosted, typo-tolerant, rapide) | Score GRADE : 3/7

Pour une recherche instantanee et tolerante aux fautes de frappe, MeiliSearch offre le meilleur rapport simplicite/performance en self-hosted.

```typescript
// MeiliSearch — indexation et recherche
import { MeiliSearch } from 'meilisearch';

const client = new MeiliSearch({ host: 'http://localhost:7700', apiKey: 'masterKey' });

// Indexer
await client.index('modules').addDocuments([
  { id: 1, title: 'Bacteriologie', description: 'Etude des bacteries' },
]);

// Rechercher (typo-tolerant par defaut)
const results = await client.index('modules').search('bacterologie'); // trouve "bacteriologie"
```

| Solution | Forces | Limites |
|----------|--------|---------|
| **MeiliSearch** | Self-hosted, typo-tolerant, < 50ms, simple | Pas de full-text analytics |
| **Algolia** (SaaS) | Meilleure UX search, analytics | Payant, donnees chez un tiers |
| **PostgreSQL full-text** | Zero infra supplementaire | Pas de typo-tolerance, config complexe |
| **Elasticsearch** | Standard enterprise, scalable | Lourd (JVM), complexe a operer |

Sources : MeiliSearch docs — benchmarks < 50ms sur 1M docs (niv. 5), DB-Engines ranking 2025 — search engines (niv. 4), PostgreSQL docs — full-text search (niv. 3)
