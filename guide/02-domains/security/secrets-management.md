# Gestion des secrets

**[STANDARD]** Env vars + CI secrets + .gitignore strict + pre-commit scan | Score GRADE : 6/7

## Config externalisee (Twelve-Factor III)

```yaml
# application.yml — JAMAIS de valeurs reelles commitees
spring:
  datasource:
    url: ${DATABASE_URL}
    username: ${DATABASE_USERNAME}
    password: ${DATABASE_PASSWORD}
jwt:
  secret: ${JWT_SECRET}
```

## .gitignore strict

```gitignore
.env
.env.*
*.pem
*.key
application-local.yml
application-prod.yml
```

## CI secrets (GitHub Actions)

```yaml
env:
  DATABASE_URL: ${{ secrets.DATABASE_URL }}
  JWT_SECRET: ${{ secrets.JWT_SECRET }}
```

## Pre-commit scan (GitLeaks)

```yaml
# .pre-commit-config.yaml
repos:
  - repo: https://github.com/gitleaks/gitleaks
    rev: v8.18.0
    hooks:
      - id: gitleaks
```

Sources : Twelve-Factor III (niv. 2), OWASP ASVS V2.10/V6.4 (niv. 2), NIST SP 800-57 (niv. 1), Spring Boot Externalized Config docs (niv. 3), GitLeaks docs (niv. 3)
