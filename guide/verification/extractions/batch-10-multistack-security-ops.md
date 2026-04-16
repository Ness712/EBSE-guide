# Double Extraction — Batch 10 : Variantes NestJS+Django Security+Ops (13 decisions)

**Date** : 2026-04-14
**Agent A** : a0cade6ba48b22b03
**Agent B** : a87e6928348e7e6fe

## Resultats

- **Accord outils : 25/26 (96%)** (13 decisions × 2 stacks)
- **1 divergence** : NestJS logging — Agent A recommande Pino (nestjs-pino), Agent B recommande Winston (nest-winston). Resolution : **Pino retenu** (coherent avec notre guide existant, plus performant).
- **Accord GRADE : ~70% exact** — divergences de ±1

| Decision | NestJS outil | GRADE | Django outil | GRADE |
|---|---|---|---|---|
| Logging | Pino (nestjs-pino) | 5/7 | python-json-logger | 5/7 |
| Error handling | ExceptionFilter | 5/7 | DRF exception handler | 5/7 |
| Authentication | @nestjs/passport + passport-jwt | 6/7 | simplejwt | 6/7 |
| Input validation | class-validator + ValidationPipe | 6/7 | DRF Serializers (built-in) | 7/7 |
| Rate limiting | @nestjs/throttler | 5/7 | DRF throttling (built-in) | 5/7 |
| HTTP headers | helmet | 5/7 | SecurityMiddleware (built-in) | 6/7 |
| Audit logging | Custom Interceptor | 4/7 | django-auditlog | 4/7 |
| Circuit breaker | opossum | 3/7 | pybreaker | 3/7 |
| Connection pooling | TypeORM/Prisma pool | 5/7 | CONN_MAX_AGE (built-in) | 5/7 |
| Graceful shutdown | enableShutdownHooks() | 5/7 | Gunicorn graceful-timeout | 5/7 |
| DB migrations | Prisma Migrate | 6/7 | built-in manage.py migrate | 7/7 |
| Env config | @nestjs/config | 6/7 | django-environ | 5/7 |
| Password hashing | argon2 npm | 6/7 | Argon2PasswordHasher (built-in) | 7/7 |

## Observation

Django a des GRADE plus hauts sur 4 decisions (validation, migrations, password hashing, headers) grace a son approche batteries-incluses. NestJS s'appuie davantage sur l'ecosysteme npm.
