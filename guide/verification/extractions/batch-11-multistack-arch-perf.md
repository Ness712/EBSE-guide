# Double Extraction — Batch 11 : Variantes NestJS+Django Architecture+Performance (6 decisions)

**Date** : 2026-04-14
**Agent A** : a3f434a6c5f921117
**Agent B** : a87473e54c355de51

## Resultats

- **Accord outils : 12/12 (100%)** (6 decisions × 2 stacks)
- **Accord GRADE : 10/12 (83%)** — 2 divergences ±1

| Decision | NestJS outil | GRADE | Django outil | GRADE |
|---|---|---|---|---|
| OpenAPI | @nestjs/swagger | 6/7 | drf-spectacular | 6/7 |
| HTTP client | @nestjs/axios | 6/7 | httpx | 6/7 |
| Caching | @nestjs/cache-manager + Redis | 6/7 | django-redis (built-in cache) | 6/7 |
| Transactions | TypeORM/Prisma $transaction | 5/7 | transaction.atomic (built-in) | 7/7 |
| Module enforcement | eslint-plugin-boundaries / dependency-cruiser | 4/7 | import-linter | 5/7 |
| ORM | TypeORM ou Prisma | 6/7 | Django ORM (built-in) | 7/7 |
