# Catalogue des sources de vérité (Sources Catalog)

**Usage** : l'arbre de décisions filtre ce catalogue selon le profil projet pour produire la liste des sources applicables à un audit. Chaque source est la référence officielle — l'audit crée la matrice `[source × projet] → findings` en lisant directement ces documents.

**Mise à jour** : quand une nouvelle version majeure d'une norme ou d'un outil est publiée.

---

## Tier 1 — Normes universelles

| Nom | URL officielle | Version | Applicable si |
|-----|---------------|---------|--------------|
| OWASP ASVS | https://owasp.org/www-project-application-security-verification-standard/ | 4.0.3 | Tout projet web avec authentification utilisateur |
| OWASP Top 10 | https://owasp.org/www-project-top-ten/ | 2021 | Tout projet web (sensibilisation, pas checklist exhaustive) |
| OWASP API Security Top 10 | https://owasp.org/www-project-api-security/ | 2023 | Tout projet exposant une API REST ou GraphQL |
| WCAG | https://www.w3.org/TR/WCAG22/ | 2.2 AA | Tout projet avec interface utilisateur publique |
| RGAA | https://accessibilite.numerique.gouv.fr/methode/criteres-et-tests/ | 4.1 | Projet France : services publics ou volontaire |
| RGPD (texte) | https://eur-lex.europa.eu/legal-content/FR/TXT/?uri=CELEX:32016R0679 | 2016/679 | Tout projet EU traitant des données personnelles |
| Guide CNIL développeurs | https://www.cnil.fr/fr/guide-rgpd-du-developpeur | 2024 | Tout projet EU traitant des données personnelles |
| HDS | https://esante.gouv.fr/produits-services/hds | 2024 | Projet hébergeant des données de santé (Art. 9 RGPD) |
| ISO/IEC 27001 | https://www.iso.org/standard/82875.html | 2022 | Appels d'offres publics ou exigence contractuelle |
| SOC 2 Type II | https://www.aicpa-cima.com/resources/landing/soc-2 | 2017 | Clients B2B enterprise US exigeant rapport SOC 2 |
| PCI-DSS | https://www.pcisecuritystandards.org/document_library/ | 4.0 | Projet stockant ou traitant des données de carte bancaire |
| eIDAS | https://digital-strategy.ec.europa.eu/en/policies/eidas-regulation | 2 (2024) | Projet avec signature électronique qualifiée EU |
| NIS2 | https://eur-lex.europa.eu/legal-content/FR/TXT/?uri=CELEX:32022L2555 | 2022/2555 | Opérateurs de services essentiels ou importants EU |
| DORA | https://eur-lex.europa.eu/legal-content/FR/TXT/?uri=CELEX:32022R2554 | 2022/2554 | Entités du secteur financier EU |
| Loi LCEN | https://www.legifrance.gouv.fr/loda/id/JORFTEXT000000801164 | 2004 | Tout site web français (mentions légales éditeur/hébergeur) |

---

## Tier 2 — Documentation officielle des outils

### Langages & Compilation

| Nom | URL officielle | Version | Applicable si |
|-----|---------------|---------|--------------|
| TypeScript | https://www.typescriptlang.org/tsconfig | 5.x | Tout projet TypeScript (vérifier tsconfig.json) |
| Node.js | https://nodejs.org/en/docs/guides/ | LTS (22.x) | Tout projet Node.js backend |

### Frontend

| Nom | URL officielle | Version | Applicable si |
|-----|---------------|---------|--------------|
| React | https://react.dev/reference/react | 19 | Projet React |
| Vite | https://vite.dev/guide/ | 6.x | Projet utilisant Vite comme bundler |
| Tailwind CSS | https://tailwindcss.com/docs/ | 4.x | Projet Tailwind (vérifier content paths, purge) |
| shadcn/ui | https://ui.shadcn.com/docs | latest | Projet shadcn (composants, accessibilité par défaut) |

### Backend

| Nom | URL officielle | Version | Applicable si |
|-----|---------------|---------|--------------|
| NestJS | https://docs.nestjs.com/ | 10.x | Projet NestJS (security, guards, pipes, exception filters) |
| Prisma | https://www.prisma.io/docs/ | 5.x/6.x | Projet Prisma (schema, migrations, best practices) |
| Express | https://expressjs.com/en/guide/ | 4.x/5.x | Projet Express |

### Infrastructure & Conteneurisation

| Nom | URL officielle | Version | Applicable si |
|-----|---------------|---------|--------------|
| Docker Engine | https://docs.docker.com/engine/ | 26.x | Projet conteneurisé (Dockerfile best practices) |
| Docker Compose | https://docs.docker.com/compose/ | v2 | Projet avec docker-compose.yml |
| Caddy | https://caddyserver.com/docs/ | 2.x | Projet utilisant Caddy comme reverse proxy |

### Bases de données & Cache

| Nom | URL officielle | Version | Applicable si |
|-----|---------------|---------|--------------|
| PostgreSQL | https://www.postgresql.org/docs/ | 16.x | Projet PostgreSQL (config, pg_hba.conf, indexes) |
| Redis | https://redis.io/docs/ | 7.x | Projet Redis (maxmemory, eviction, requirepass, persistence) |
| MinIO | https://min.io/docs/minio/linux/index.html | AGPL-3.0 | Projet MinIO (bucket policies, accès anonyme, TLS) |

### CI/CD & Qualité

| Nom | URL officielle | Version | Applicable si |
|-----|---------------|---------|--------------|
| GitHub Actions | https://docs.github.com/en/actions | 2024 | Projet GitHub Actions (permissions, pinning, secrets) |
| GitHub Actions — Security Hardening | https://docs.github.com/en/actions/security-guides/security-hardening-for-github-actions | 2024 | Tout projet GitHub Actions |
| Dependabot | https://docs.github.com/en/code-security/dependabot | 2024 | Projet avec Dependabot configuré |
| CodeQL | https://codeql.github.com/docs/ | 2.x | Projet avec scan CodeQL |
| SonarQube | https://docs.sonarsource.com/sonarqube/ | 10.x | Projet avec SonarQube (quality gate, règles) |

### Package Managers

| Nom | URL officielle | Version | Applicable si |
|-----|---------------|---------|--------------|
| pnpm | https://pnpm.io/motivation | 9.x | Projet pnpm (lockfile, workspace, hoisting) |
| npm | https://docs.npmjs.com/ | 10.x | Projet npm |

### Linting & Formatting

| Nom | URL officielle | Version | Applicable si |
|-----|---------------|---------|--------------|
| ESLint | https://eslint.org/docs/latest/ | 9.x | Tout projet JS/TS (vérifier config, règles recommended) |
| Prettier | https://prettier.io/docs/en/ | 3.x | Projet avec Prettier |

### Tests

| Nom | URL officielle | Version | Applicable si |
|-----|---------------|---------|--------------|
| Vitest | https://vitest.dev/guide/ | 2.x | Projet Vitest |
| Jest | https://jestjs.io/docs/getting-started | 29.x | Projet Jest |
| Playwright | https://playwright.dev/docs/intro | 1.x | Projet tests E2E Playwright |

---

## Lecture du catalogue lors d'un audit

```
1. Lire le profil projet (ex: ols.json) et l'arbre de décisions
2. Filtrer Tier 1 : quelles normes s'appliquent selon le profil ?
3. Filtrer Tier 2 : quels outils sont utilisés dans le projet ?
4. Récupérer les sources Tier 3/4 depuis le manifest projet
   (ex: OLS-documentation/reference/audit-sources-manifest.md)
5. Construire la matrice [source × projet] → findings
```
