# Tests de performance

**[RECOMMANDE]** k6 (backend) + Lighthouse CI (frontend) avec budgets definis | Score GRADE : 4/7

Les problemes de performance se detectent en test, pas en production. Sans budget defini, la performance se degrade commit apres commit.

## Budgets de performance

| Metrique | Budget | Source |
|----------|--------|--------|
| LCP (Largest Contentful Paint) | < 2.5s | Core Web Vitals (Google) |
| INP (Interaction to Next Paint) | < 200ms | Core Web Vitals (Google) |
| CLS (Cumulative Layout Shift) | < 0.1 | Core Web Vitals (Google) |
| Bundle JS total | < 200 KB (gzipped) | web.dev budget recommendations |
| API P95 latence | < 500ms | SLO standard (Google SRE) |
| Time to first byte (TTFB) | < 800ms | web.dev |

## k6 — Load testing backend

```javascript
// load-test.js
import http from 'k6/http';
import { check, sleep } from 'k6';

export const options = {
  stages: [
    { duration: '1m', target: 50 },   // ramp up
    { duration: '3m', target: 50 },   // plateau
    { duration: '1m', target: 0 },    // ramp down
  ],
  thresholds: {
    http_req_duration: ['p(95)<500'],  // P95 < 500ms
    http_req_failed: ['rate<0.01'],    // < 1% erreurs
  },
};

export default function () {
  check(http.get('http://localhost:8080/api/v1/health'), {
    'status 200': (r) => r.status === 200,
  });
  sleep(1);
}
```

## Lighthouse CI — Frontend

```bash
# Integrer dans le CI
npx @lhci/cli autorun --config=lighthouserc.json
```

## Sources

- [niv. 3] web.dev Core Web Vitals — LCP, INP, CLS budgets et mesure
- [niv. 3] k6 docs — load testing, thresholds, CI integration
- [niv. 4] Google CrUX report — Core Web Vitals impact sur le ranking
- [niv. 5] Google SRE Book — latency SLOs, performance budgets
