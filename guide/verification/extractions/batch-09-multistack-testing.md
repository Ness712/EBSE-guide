# Double Extraction — Batch 9 : Variantes NestJS+Django Testing (7 decisions)

**Date** : 2026-04-14
**Agent A** : a3b8ef46c000340ee
**Agent B** : a6a6bdb634796a423

## Resultats

- **Accord outils : 14/14 (100%)** (7 decisions × 2 stacks)
- **Accord GRADE : 0/14 exact** — Agent B note systematiquement +1 vs Agent A
- **Resolution** : scores conservatifs (Agent A) retenus

| Decision | NestJS outil | GRADE | Django outil | GRADE |
|---|---|---|---|---|
| Unit test | Jest + @nestjs/testing | 6/7 | pytest + pytest-django | 6/7 |
| Integration | Testcontainers-node | 5/7 | Testcontainers-python | 5/7 |
| E2E | Playwright | 6/7 | Playwright | 6/7 |
| Contract | Pact (pact-js) | 4/7 | Pact (pact-python) | 4/7 |
| Mutation | Stryker | 5/7 | mutmut | 4/7 |
| Mocking | Jest mocks natifs | 6/7 | unittest.mock + pytest-mock | 6/7 |
| Test data | @faker-js/faker + fishery | 5/7 | factory_boy + Faker | 6/7 |
