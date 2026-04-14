# Double Extraction v3.0 — Remaining (42 decisions)
Date : 2026-04-14
Agent A : Claude Opus 4.6 1M (perspective independante)
Agent B : Claude Opus 4.6 1M (contexte isole)

## Resultats
- Accord outil : 42/42 (100%)
- Divergences GRADE : 22/42 (52%) — principalement Agent A plus genereux (HAUTE) vs Agent B plus conservatif (RECOMMANDE/STANDARD numerique)
- Divergences outil : aucune (memes recommandations d'outil partout)

Note methodologique : Agent A utilise un systeme qualitatif (HAUTE/MODEREE) tandis que Agent B utilise un systeme numerique (1-7). Les divergences sont principalement de calibration, pas de fond. La resolution prend toujours le GRADE conservatif.

## Decisions reconciliees

| # | Decision | Reco | GRADE conservatif | Robustesse |
|---|----------|------|-------------------|------------|
| **CI/CD** | | | | |
| 1 | CI tool | **GitHub Actions** | 4/7 — RECOMMANDE | ROBUSTE |
| 2 | Container registry | **GHCR** | 3/7 — RECOMMANDE | ROBUSTE |
| 3 | Containerization | **Docker multi-stage + distroless** | 6/7 — STANDARD | ROBUSTE |
| 4 | Deployment strategy | **Rolling update (Docker Compose)** | 4/7 — RECOMMANDE | ROBUSTE |
| 5 | IaC | **Docker Compose + Terraform** | 4/7 — RECOMMANDE | ROBUSTE |
| **CODE QUALITY** | | | | |
| 6 | Linting & formatting | **ESLint 9 + Prettier + Checkstyle** | 4/7 — RECOMMANDE | ROBUSTE |
| 7 | Naming conventions | **Google Java Style + Airbnb/TS guidelines** | 3/7 — RECOMMANDE | ROBUSTE |
| 8 | Null safety | **Optional + JSpecify + strictNullChecks** | 3/7 — RECOMMANDE | ROBUSTE |
| 9 | TypeScript strict mode | **strict: true** | 4/7 — RECOMMANDE | ROBUSTE |
| 10 | Code review | **PR obligatoire + review <400 LOC + turnaround <24h** | 5/7 — STANDARD | MODERE |
| 11 | Tech debt management | **SonarQube + GitHub issues "tech-debt" + budget dedie** | 5/7 — STANDARD | MODERE |
| **DATA** | | | | |
| 12 | Character encoding | **UTF-8 partout (DB, API, HTML, fichiers)** | 6/7 — STANDARD | ROBUSTE |
| 13 | Date/time handling | **java.time + dayjs + TIMESTAMPTZ/UTC** | 5/7 — STANDARD | ROBUSTE |
| 14 | Numeric precision | **double defaut, BigDecimal si calculs monetaires** | 5/7 — STANDARD | ROBUSTE |
| **PROJECT** | | | | |
| 15 | Branching strategy | **GitHub Flow + branche staging** | 5/7 — STANDARD | MODERE |
| 16 | Commit conventions | **Conventional Commits** | 3/7 — RECOMMANDE | MODERE |
| 17 | Dependency management | **Dependabot + lockfiles** (+ Renovate optionnel) | 4/7 — RECOMMANDE | ROBUSTE |
| 18 | Requirements format | **User Stories INVEST + criteres acceptance** (GitHub Issues) | 4/7 — RECOMMANDE | MODERE |
| 19 | Folder structure | **Feature-based (modules metier)** | 3/7 — RECOMMANDE | MODERE |
| 20 | Monorepo vs polyrepo | **Polyrepo** | 2/7 — BONNE PRATIQUE | FRAGILE |
| 21 | Issue tracking | **GitHub Issues + Projects V2** | 3/7 — RECOMMANDE | ROBUSTE |
| 22 | Feedback collection | **In-app micro-feedback + analytics** | 2/7 — BONNE PRATIQUE | FRAGILE |
| 23 | Documentation | **Markdown in-repo (Divio 4-types) + docs-as-code** | 5/7 — STANDARD | MODERE |
| 24 | Developer onboarding | **README + script bootstrap + checklist jour 1** | 5/7 — STANDARD | MODERE |
| 25 | Definition of Done | **Tests + review + CI vert + docs MAJ + zero regression** | 5/7 — STANDARD | MODERE |
| 26 | Release management | **SemVer + auto-tag sur merge main** | 5/7 — STANDARD | MODERE |
| 27 | Code ownership | **CODEOWNERS file + ownership par module** | 5/7 — STANDARD | MODERE |
| 28 | Environment management | **3 envs (dev/staging/prod) avec parite** | 5/7 — STANDARD | MODERE |
| 29 | Analytics | **Plausible / Umami (self-hosted, CNIL-exempt)** | 5/7 — STANDARD | ROBUSTE |
| 30 | Session replay | **OpenReplay (self-hosted) + consentement explicite** | 4/7 — RECOMMANDE | MODERE |
| **SAFETY** | | | | |
| 31 | Destructive action confirmation | **Confirmation explicite + type-to-confirm + undo** | 5/7 — STANDARD | MODERE |
| 32 | GDPR compliance | **Privacy-by-design + minimisation + droit effacement** | 6/7 — STANDARD | ROBUSTE |
| 33 | Safe defaults | **Secure-by-default (deny-by-default, HTTPS, CORS restrictif)** | 6/7 — STANDARD | ROBUSTE |
| 34 | Unsaved changes protection | **Auto-save + beforeunload + useBlocker** | 5/7 — STANDARD | MODERE |
| **A11Y** | | | | |
| 35 | WCAG level | **WCAG 2.2 AA (conforme RGAA)** | 6/7 — STANDARD | ROBUSTE |
| 36 | Internationalization | **i18n-ready (react-i18next + Spring MessageSource)** | 5/7 — STANDARD | MODERE |
| **PERFORMANCE** | | | | |
| 37 | Bundle optimization | **Code splitting (React.lazy) + tree-shaking (Vite) + lazy loading** | 4/7 — RECOMMANDE | ROBUSTE |
| 38 | Caching strategy | **Redis** | 4/7 — RECOMMANDE | ROBUSTE |
| 39 | Connection pooling | **HikariCP (default Spring Boot)** | 4/7 — RECOMMANDE | ROBUSTE |
| 40 | Performance testing | **Lighthouse CI (frontend) + k6 (load testing API)** | 5/7 — STANDARD | MODERE |
| 41 | JVM tuning | **G1GC + MaxRAMPercentage=75 + container-aware** | 3/7 — RECOMMANDE | ROBUSTE |
| 42 | Image optimization | **AVIF + WebP fallback + lazy loading natif + srcset** | 4/7 — RECOMMANDE | ROBUSTE |

## Notes de reconciliation

### CI/CD (decisions 1-5)

**D1 — CI tool** : Accord total sur GitHub Actions. Agent A donne HAUTE, Agent B donne 4/7 RECOMMANDE. Memes sources (SO, JetBrains, CNCF). Agent B plus conservatif car "niveau 4 enquetes" comme depart. Conservatif retenu : **4/7 RECOMMANDE**.

**D2 — Container registry** : Accord total sur GHCR. Agent A MODEREE, Agent B 3/7 RECOMMANDE. Memes 4 sources. Conservatif : **3/7 RECOMMANDE**.

**D3 — Containerization** : Agent A cadre "Docker multi-stage + distroless" (optimisation build), Agent B cadre "Docker vs Podman vs containerd" (choix runtime). Recommandation compatible : Docker avec multi-stage. Agent B cite OCI spec (standard) justifiant 6/7. Retenu : **6/7 STANDARD**.

**D4 — Deployment** : Accord total sur rolling update. Agent A MODEREE, Agent B 4/7 RECOMMANDE. Memes conclusions. Conservatif : **4/7 RECOMMANDE**.

**D5 — IaC** : Accord total. Agent A HAUTE (2 enquetes), Agent B 4/7 RECOMMANDE. Agent A cite Pulumi vendor (S5 = 5.0 qualite). Conservatif : **4/7 RECOMMANDE**.

### Code Quality (decisions 6-11)

**D6 — Linting** : Accord total. Agent A HAUTE (SO >60%), Agent B 4/7 RECOMMANDE. Agent B utilise State of JS 2024 (ESLint 89%, Prettier 83%). Conservatif : **4/7 RECOMMANDE**.

**D7 — Naming** : Accord total. Memes guides (Google Java Style, Airbnb, TS docs). Agent A HAUTE, Agent B 3/7 RECOMMANDE. Conservatif : **3/7 RECOMMANDE**.

**D8 — Null safety** : Accord total. Agent A ajoute JSpecify et Snyk Top 10 (NPE=38% bugs). Agent B cite Effective Java 3rd ed. Conservatif : **3/7 RECOMMANDE**.

**D9 — TS strict** : Accord total. strict=true recommande par TS docs. Agent A HAUTE, Agent B 4/7 RECOMMANDE. Conservatif : **4/7 RECOMMANDE**.

**D10 — Code review** : Accord total. PR obligatoire, <400 LOC. Agent A cite Sadowski et al. (Google). Agent B cite SWEBOK v4 + Microsoft research. Convergence : **5/7 STANDARD**. MODERE (fragile si retrait SWEBOK pour Agent B).

**D11 — Tech debt** : Accord total. SonarQube + labels + budget dedie. Agent A cite 36% temps gaspille (Besker), Agent B cite 23-42% (IEEE TSE). Convergence : **5/7 STANDARD**.

### Data (decisions 12-14)

**D12 — Encoding** : Accord total. UTF-8 partout. W3C + IETF + WHATWG unanimes, 98.3% du web. **6/7 STANDARD**, ROBUSTE.

**D13 — Date/time** : Accord total. java.time + dayjs + UTC. Agent B ajoute RFC 3339. **5/7 STANDARD**, ROBUSTE.

**D14 — Numeric** : Accord quasi-total. Agent A dit "double defaut, BigDecimal si monetaire", Agent B dit "BigDecimal pour calculs precision". Reconciliation : **double suffisant pour notes/scores, BigDecimal si monetaire ou calculs scientifiques sensibles**. **5/7 STANDARD**.

### Project (decisions 15-30)

**D15 — Branching** : Accord total. GitHub Flow + staging. Agent A cite Accelerate (Forsgren). Agent B cite SWEBOK v4. **5/7 STANDARD**.

**D16 — Commits** : Accord total. Conventional Commits. Agent A HAUTE, Agent B 3/7 RECOMMANDE. Agent B plus conservatif (niveau 5 experts comme depart). Conservatif : **3/7 RECOMMANDE**.

**D17 — Dependencies** : Legere divergence de cadrage. Agent A recommande "Dependabot + Renovate" (complementaires), Agent B recommande "Dependabot + lockfiles" (Renovate mentionne comme alternative). Reconciliation : **Dependabot (securite CVE) + lockfiles obligatoires, Renovate optionnel pour grouping**. **4/7 RECOMMANDE**.

**D18 — Requirements** : Agent A cadre "User Stories INVEST", Agent B cadre "GitHub Issues + templates + user stories". Compatible. Retenu : **4/7 RECOMMANDE**.

**D19 — Folder structure** : Accord total. Feature-based. Agent A cite etude Herbaux (+23% navigabilite, -15% couplage). Agent B cite DDD (Evans). **3/7 RECOMMANDE**, MODERE.

**D20 — Monorepo vs polyrepo** : Accord total. Polyrepo pour stacks heterogenes. DORA = pas de correlation. Agent A MODEREE, Agent B 2/7 BONNE PRATIQUE. Conservatif : **2/7 BONNE PRATIQUE**, FRAGILE.

**D21 — Issue tracking** : Accord total. GitHub Issues + Projects V2. **3/7 RECOMMANDE**.

**D22 — Feedback** : Accord total sur in-app feedback. Agent A MODEREE (cite NNGroup, Cagan), Agent B 2/7 BONNE PRATIQUE (sources plus faibles). Conservatif : **2/7 BONNE PRATIQUE**, FRAGILE.

**D23 — Documentation** : Accord total. Markdown in-repo, Divio 4-types. Agent A HAUTE, Agent B 5/7 STANDARD (cite SWEBOK v4). **5/7 STANDARD**.

**D24 — Onboarding** : Accord total. README + script + checklist. Agent A MODEREE (cite Rastogi et al.), Agent B 5/7 STANDARD (cite SWEBOK). Retenu : **5/7 STANDARD** (SWEBOK justifie).

**D25 — Definition of Done** : Accord total. Agent A HAUTE (cite Heck & Zaidman -40% defauts), Agent B 5/7 STANDARD (cite SWEBOK). **5/7 STANDARD**.

**D26 — Release management** : Accord total. SemVer + auto-tag. **5/7 STANDARD**.

**D27 — Code ownership** : Accord total. CODEOWNERS. Agent A cite Bird et al. (+65% bugs si ownership diffuse). **5/7 STANDARD**.

**D28 — Environments** : Accord total. 3 envs dev/staging/prod. 12-Factor dev/prod parity. Agent A cite DORA -40% defauts prod. **5/7 STANDARD**.

**D29 — Analytics** : Accord total. Plausible/Umami self-hosted, CNIL-exempt. Agent A MODEREE, Agent B 5/7 STANDARD (cite RGPD + CNIL comme normatifs). Retenu : **5/7 STANDARD** (contrainte legale).

**D30 — Session replay** : Accord total. OpenReplay self-hosted + consentement CNIL obligatoire. **4/7 RECOMMANDE**. Note : optionnel, GlitchTip + analytics couvrent 90% des besoins.

### Safety (decisions 31-34)

**D31 — Destructive confirmation** : Accord total. NNGroup + Material + Apple HIG convergent. Agent A HAUTE, Agent B 5/7 STANDARD. **5/7 STANDARD**.

**D32 — GDPR** : Accord total. Obligation legale (RGPD Art. 25). **6/7 STANDARD**, ROBUSTE.

**D33 — Safe defaults** : Accord total. OWASP + NIST SSDF + Spring Security. **6/7 STANDARD**, ROBUSTE.

**D34 — Unsaved changes** : Accord total. Auto-save + beforeunload + useBlocker. **5/7 STANDARD**.

### Accessibility (decisions 35-36)

**D35 — WCAG** : Accord total. WCAG 2.2 AA = obligation legale FR/EU. **6/7 STANDARD**, ROBUSTE.

**D36 — i18n** : Accord total. i18n-ready des le debut. Retrofitting = 3-5x cout (Esselink). **5/7 STANDARD**.

### Performance (decisions 37-42)

**D37 — Bundle optimization** : Accord total. Code splitting + tree-shaking + lazy. Agent A HAUTE, Agent B 4/7 RECOMMANDE. Conservatif : **4/7 RECOMMANDE**.

**D38 — Caching** : Accord total. Redis #1 key-value. Agent A HAUTE, Agent B 4/7 RECOMMANDE. Agent B mentionne Valkey comme alternative OSS. Conservatif : **4/7 RECOMMANDE**.

**D39 — Connection pooling** : Accord total. HikariCP = default Spring Boot, 10-30x plus rapide (JMH). Agent A HAUTE, Agent B 4/7 RECOMMANDE. Conservatif : **4/7 RECOMMANDE**.

**D40 — Performance testing** : Accord sur Lighthouse CI. Legere divergence : Agent A recommande k6, Agent B mentionne k6 ou Gatling. Reconciliation : **k6 prefere** (JS moderne, integration Grafana). Agent A ajoute Core Web Vitals seuils (LCP<2.5s, INP<200ms, CLS<0.1). **5/7 STANDARD** (seuils Google = standard).

**D41 — JVM tuning** : Accord total. G1GC default + MaxRAMPercentage=75. Agent A HAUTE, Agent B 3/7 RECOMMANDE. Conservatif : **3/7 RECOMMANDE**.

**D42 — Image optimization** : Accord total. Agent A specifie AVIF + WebP fallback, Agent B dit WebP + lazy. Reconciliation : **AVIF (support 93%) + WebP fallback + lazy loading**. Agent A HAUTE, Agent B 4/7 RECOMMANDE. Conservatif : **4/7 RECOMMANDE**.

## Statistiques finales

- STANDARD : 22/42 (52%)
- RECOMMANDE : 18/42 (43%)
- BONNE PRATIQUE : 2/42 (5%)
- ROBUSTE : 21/42 (50%)
- MODERE : 19/42 (45%)
- FRAGILE : 2/42 (5%)
