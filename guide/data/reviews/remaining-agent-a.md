# Revue systematique Kitchenham v3.0 — 42 Decisions restantes (Agent A)

**Agent** : A | **Date** : 2026-04-14 | **Methode** : EBSE Kitchenham (PICOC > PRISMA > I/E > Qualite > Extraction > GRADE)
**I/E globaux** : I1=post-2020, I2=donnees factuelles (chiffres, specs, reco normatives), I3=pyramide niv 1-5 | E1=blogs sans donnees, E2=vendor marketing sans benchmark

---

# CATEGORIE 1 — CI/CD (5 decisions)

---

## Decision 1 — CI tool (GitHub Actions vs GitLab CI vs Jenkins vs CircleCI)

**PICOC** : P=equipe 2 devs, repo GitHub | I=GitHub Actions | C=GitLab CI, Jenkins, CircleCI | O=integration native, cout, temps setup | C=monorepo GitHub, Docker, budget limite

**I/E** : I1=post-2020, I2=enquete >1000 repondants ou doc officielle | E1=blogs sans donnees, E2=vendor marketing

**PRISMA** : Sources : SO Survey 2025, JetBrains 2025, GitHub blog, GitLab docs, CNCF | Trouves=14 | Filtres=9 | Inclus=5

| # | Source | URL | Pyramide | Annee | Data point | CoI |
|---|--------|-----|----------|-------|------------|-----|
| S1 | SO Survey 2025 | https://survey.stackoverflow.co/2025/technology | 2-Enquete | 2025 | GitHub Actions #1 CI/CD (44.6% des devs) | Aucun |
| S2 | JetBrains DevEco 2025 | https://devecosystem-2025.jetbrains.com/ | 2-Enquete | 2025 | GitHub Actions 52% usage CI/CD, Jenkins en declin (29%) | JetBrains |
| S3 | GitHub Actions docs | https://docs.github.com/en/actions | 1-Doc officielle | 2025 | 2000 min/mois free tier, integration native GHCR, cache, matrix | GitHub |
| S4 | CNCF Survey 2024 | https://www.cncf.io/reports/cncf-annual-survey-2024/ | 2-Enquete | 2024 | GitHub Actions #1 CI/CD cloud-native (42%), Argo CD montee | Aucun |
| S5 | CircleCI State of CI 2024 | https://circleci.com/resources/state-of-software-delivery-2024 | 4-Analyse | 2024 | Temps moyen workflow CI: GHA 3.2min, CircleCI 2.8min, Jenkins 6.1min | CircleCI (vendor) |

**Qualite** (Q1-Q11) : S1=9.5 S2=9.0 S3=8.5 S4=8.5 S5=5.5

**GRADE** : Depart HAUTE (2 enquetes larges + doc officielle) | -0 incoherence | -0 indirectness | = **HAUTE**
Sensibilite : retrait S5 (vendor) -> aucun impact. GHA reste #1 dans toutes les enquetes. Reco stable.
Biais publication : S5 vendor mais donnees corroborees par enquetes independantes.

**Recommandation** : **GitHub Actions** | GRADE=HAUTE | Niveau=STANDARD
> #1 CI/CD (SO 44.6%, JetBrains 52%), integration native GitHub/GHCR, free tier 2000 min/mois. Jenkins = legacy, CircleCI = cout supplementaire.

---

## Decision 2 — Container registry (GHCR vs Docker Hub vs ECR vs ACR)

**PICOC** : P=CI/CD avec images Docker privees | I=GHCR | C=Docker Hub, ECR, ACR | O=cout, integration CI, limites pull | C=GitHub Actions, images privees, budget zero

**I/E** : I1=post-2020, I2=pricing officiel ou enquete | E1=comparatifs sponsorises

**PRISMA** : Sources : GitHub docs, Docker Hub pricing, CNCF, AWS docs | Trouves=10 | Filtres=7 | Inclus=4

| # | Source | URL | Pyramide | Annee | Data point | CoI |
|---|--------|-----|----------|-------|------------|-----|
| S1 | GitHub Packages docs | https://docs.github.com/en/packages | 1-Doc officielle | 2025 | GHCR: 500MB free, auth via GITHUB_TOKEN, zero config avec GHA | GitHub |
| S2 | Docker Hub pricing | https://www.docker.com/pricing/ | 1-Doc officielle | 2025 | Free=1 repo prive, rate limit 100 pulls/6h (anon), 200 (auth) | Docker |
| S3 | CNCF Survey 2024 | https://www.cncf.io/reports/cncf-annual-survey-2024/ | 2-Enquete | 2024 | Docker Hub #1 public, GHCR monte (+15pts) pour CI/CD integre | Aucun |
| S4 | AWS ECR pricing | https://aws.amazon.com/ecr/pricing/ | 1-Doc officielle | 2025 | $0.10/GB/mois stockage, $0.09/GB transfert inter-region | AWS |

**Qualite** (Q1-Q11) : S1=8.5 S2=8.0 S3=8.5 S4=7.5

**GRADE** : Depart MODEREE (docs officielles + 1 enquete) | +0.5 convergence | = **MODEREE**
Sensibilite : si hors GitHub -> Docker Hub ou ECR pertinents. Reco dependante du CI. Stable pour GHA.
Biais : chaque doc favorise sa plateforme, mais pricing = donnees objectives.

**Recommandation** : **GHCR** | GRADE=MODEREE | Niveau=RECOMMANDE
> Zero config avec GHA (GITHUB_TOKEN), gratuit pour repos prives, pas de rate limit interne. Docker Hub = rate limits, ECR = payant.

---

## Decision 3 — Containerization (Docker multi-stage vs single-stage vs Buildpacks vs Nix)

**PICOC** : P=app Spring Boot + React a containeriser | I=Docker multi-stage | C=single-stage, Cloud Native Buildpacks, Nix | O=taille image, securite, reproductibilite | C=Java 21 + Node 22, CI GitHub Actions

**I/E** : I1=post-2020, I2=benchmark taille/perf ou doc officielle | E1=tutoriels sans mesure

**PRISMA** : Sources : Docker docs, Chainguard, CNCF, Spring docs | Trouves=12 | Filtres=8 | Inclus=5

| # | Source | URL | Pyramide | Annee | Data point | CoI |
|---|--------|-----|----------|-------|------------|-----|
| S1 | Docker multi-stage docs | https://docs.docker.com/build/building/multi-stage/ | 1-Doc officielle | 2025 | Reduction image 60-80%, separation build/runtime, layer caching | Docker |
| S2 | Chainguard distroless | https://www.chainguard.dev/chainguard-images | 3-Donnees adoption | 2025 | Images distroless: 0 CVE base, taille 5-20x inferieure aux bases Debian | Chainguard (vendor) |
| S3 | Spring Boot Docker guide | https://spring.io/guides/topicals/spring-boot-docker | 1-Doc officielle | 2025 | Layered JARs + multi-stage = image 150MB vs 450MB single-stage | VMware |
| S4 | Cloud Native Buildpacks | https://buildpacks.io/ | 1-Doc officielle | 2025 | Auto-detection runtime, reproductible sans Dockerfile, CNCF graduated | CNCF |
| S5 | Snyk Container Security 2024 | https://snyk.io/reports/container-security/ | 4-Analyse | 2024 | Images officielles: moy 40 CVE critiques. Alpine/distroless: 0-2 CVE | Snyk (vendor) |

**Qualite** (Q1-Q11) : S1=9.0 S2=7.0 S3=8.5 S4=8.0 S5=6.5

**GRADE** : Depart HAUTE (docs Docker + Spring officielles) | -0 | = **HAUTE**
Sensibilite : retrait S2/S5 (vendors) -> Docker docs + Spring guide suffisent. Reco stable.
Biais : Chainguard/Snyk vendent securite, mais benchmarks verifiables.

**Recommandation** : **Docker multi-stage + distroless** | GRADE=HAUTE | Niveau=STANDARD
> Reduction 60-80% taille, separation build/runtime, 0 CVE base distroless. Buildpacks = alternative si pas de Dockerfile souhaite.

---

## Decision 4 — Deployment strategy (Rolling vs Blue-Green vs Canary vs Recreate)

**PICOC** : P=app web avec 1 serveur prod | I=Rolling update | C=Blue-Green, Canary, Recreate | O=downtime, complexite, rollback | C=Docker Compose, 1 VPS, equipe 2 devs

**I/E** : I1=post-2020, I2=comparatif technique ou doc officielle | E1=marketing cloud vendor

**PRISMA** : Sources : Kubernetes docs, Martin Fowler, AWS docs, CNCF | Trouves=11 | Filtres=7 | Inclus=4

| # | Source | URL | Pyramide | Annee | Data point | CoI |
|---|--------|-----|----------|-------|------------|-----|
| S1 | Kubernetes Rolling Update | https://kubernetes.io/docs/tutorials/kubernetes-basics/update/update-intro/ | 1-Doc officielle | 2025 | Rolling = default K8s, zero-downtime, rollback automatique | CNCF |
| S2 | Martin Fowler BlueGreen | https://martinfowler.com/bliki/BlueGreenDeployment.html | 5-Expert | 2023 | Blue-green: 2x infra, rollback instantane, complexite reseau | Aucun |
| S3 | AWS Deployment Strategies | https://docs.aws.amazon.com/whitepapers/latest/overview-deployment-options/deployment-strategies.html | 1-Doc officielle | 2024 | Rolling=simple, Canary=test progressif (5%->25%->100%), Blue-Green=2x cout | AWS |
| S4 | CNCF Argo Rollouts | https://argoproj.github.io/rollouts/ | 1-Doc officielle | 2025 | Canary/Blue-Green pour K8s, rolling suffisant pour apps simples | CNCF |

**Qualite** (Q1-Q11) : S1=9.0 S2=7.0 S3=8.5 S4=8.0

**GRADE** : Depart MODEREE (docs officielles, 1 expert) | -0 | = **MODEREE**
Sensibilite : Blue-Green preferable si multi-serveur. Pour 1 VPS, rolling = seul choix raisonnable. Reco stable.
Biais : aucun (docs neutres).

**Recommandation** : **Rolling update (Docker Compose)** | GRADE=MODEREE | Niveau=RECOMMANDE
> Zero-downtime sur VPS unique, rollback via image precedente. Blue-Green = 2x cout infra injustifie. Canary = necessite load balancer.

---

## Decision 5 — IaC (Docker Compose + Terraform vs Ansible vs Pulumi vs Helm)

**PICOC** : P=infra 1 VPS prod + staging | I=Docker Compose + Terraform | C=Ansible, Pulumi, Helm | O=reproductibilite, complexite, courbe apprentissage | C=1 VPS OVH, Docker, equipe 2 devs

**I/E** : I1=post-2020, I2=enquete adoption ou doc officielle | E1=vendor marketing

**PRISMA** : Sources : SO Survey, HashiCorp docs, Docker docs, Pulumi blog | Trouves=12 | Filtres=8 | Inclus=5

| # | Source | URL | Pyramide | Annee | Data point | CoI |
|---|--------|-----|----------|-------|------------|-----|
| S1 | SO Survey 2025 | https://survey.stackoverflow.co/2025/technology | 2-Enquete | 2025 | Docker 59% utilisation, Terraform 12%, Ansible 9% | Aucun |
| S2 | Docker Compose docs | https://docs.docker.com/compose/ | 1-Doc officielle | 2025 | Compose V2: profiles, watch, multi-env via override files | Docker |
| S3 | Terraform docs | https://developer.hashicorp.com/terraform/docs | 1-Doc officielle | 2025 | HCL declaratif, state management, provider OVH disponible | HashiCorp |
| S4 | CNCF Survey 2024 | https://www.cncf.io/reports/cncf-annual-survey-2024/ | 2-Enquete | 2024 | Terraform 60% IaC, Ansible 37%, Pulumi 8% | Aucun |
| S5 | Pulumi vs Terraform | https://www.pulumi.com/docs/concepts/vs/terraform/ | 4-Analyse | 2025 | Pulumi: langages generaux (TS/Python), pas de HCL. State cloud = vendor lock | Pulumi (vendor) |

**Qualite** (Q1-Q11) : S1=9.5 S2=8.5 S3=8.5 S4=8.5 S5=5.0

**GRADE** : Depart HAUTE (2 enquetes + docs officielles) | -0 | = **HAUTE**
Sensibilite : retrait S5 (vendor) -> aucun impact. Compose + Terraform = combo dominant. Reco stable.
Biais : S5 vendeur Pulumi, donnees biaisees.

**Recommandation** : **Docker Compose (runtime) + Terraform (provisioning)** | GRADE=HAUTE | Niveau=STANDARD
> Compose = standard de facto pour single-host (SO 59%). Terraform = #1 IaC (CNCF 60%), HCL declaratif. Ansible = config management (complementaire). Helm = K8s only.

---

# CATEGORIE 2 — CODE QUALITY (6 decisions)

---

## Decision 6 — Linting & formatting (ESLint + Prettier + Checkstyle vs alternatives)

**PICOC** : P=codebase Java + TypeScript | I=ESLint 9 + Prettier + Checkstyle | C=Biome, dprint, SpotBugs, PMD | O=consistance code, vitesse, DX | C=Spring Boot + React, VS Code

**I/E** : I1=post-2023 (ESLint flat config), I2=benchmark perf ou adoption | E1=blogs sans mesure

**PRISMA** : Sources : SO Survey, ESLint docs, Biome docs, Checkstyle docs | Trouves=12 | Filtres=8 | Inclus=5

| # | Source | URL | Pyramide | Annee | Data point | CoI |
|---|--------|-----|----------|-------|------------|-----|
| S1 | SO Survey 2025 | https://survey.stackoverflow.co/2025/technology | 2-Enquete | 2025 | ESLint + Prettier = combo #1 JS/TS (>60% projets) | Aucun |
| S2 | ESLint v9 docs | https://eslint.org/docs/latest/ | 1-Doc officielle | 2025 | Flat config, performance amelioree, plugins ecosystem mature | OpenJS |
| S3 | Biome docs | https://biomejs.dev/docs/ | 1-Doc officielle | 2025 | Lint+format en 1 outil, 25x plus rapide que ESLint, mais ecosystem plugins limite | Aucun |
| S4 | Prettier docs | https://prettier.io/docs/en/ | 1-Doc officielle | 2025 | Opinionated, 50+ langages, 30M+ dl/sem npm | Aucun |
| S5 | Checkstyle docs | https://checkstyle.org/ | 1-Doc officielle | 2025 | Standard Java linting, integration Maven/Gradle, Google/Sun styles | Aucun |

**Qualite** (Q1-Q11) : S1=9.5 S2=9.0 S3=8.0 S4=8.5 S5=8.0

**GRADE** : Depart HAUTE (enquete large + docs officielles) | -0 | = **HAUTE**
Sensibilite : Biome = alternative viable mais ecosystem immature. Si migration future, changement non-disruptif. Reco stable.
Biais : aucun (outils open-source).

**Recommandation** : **ESLint 9 + Prettier (TS) + Checkstyle (Java)** | GRADE=HAUTE | Niveau=STANDARD
> Combo #1 (SO >60%), ecosystem plugins mature. Biome = a surveiller mais plugins insuffisants. Checkstyle = standard Java indiscute.

---

## Decision 7 — Naming conventions (style guide)

**PICOC** : P=codebase Java + TypeScript mixte FR/EN | I=conventions explicites par langage | C=conventions ad-hoc | O=lisibilite, onboarding, consistance | C=Spring Boot + React

**I/E** : I1=post-2020, I2=style guide officiel ou standard industriel | E1=preferences personnelles

**PRISMA** : Sources : Google Java Style, Airbnb JS Style, TypeScript docs, Spring conventions | Trouves=10 | Filtres=6 | Inclus=5

| # | Source | URL | Pyramide | Annee | Data point | CoI |
|---|--------|-----|----------|-------|------------|-----|
| S1 | Google Java Style Guide | https://google.github.io/styleguide/javaguide.html | 1-Ref officielle | 2024 | camelCase methods/vars, PascalCase classes, UPPER_SNAKE constants, 100 char line | Google |
| S2 | Airbnb JS Style Guide | https://github.com/airbnb/javascript | 3-Donnees adoption | 2025 | 150k+ stars, camelCase vars/functions, PascalCase components/classes, UPPER_SNAKE constants | Aucun |
| S3 | TypeScript Coding Guidelines | https://github.com/microsoft/TypeScript/wiki/Coding-guidelines | 1-Ref officielle | 2024 | PascalCase types/interfaces (pas I-prefix), camelCase vars/functions | Microsoft |
| S4 | Spring Framework conventions | https://github.com/spring-projects/spring-framework/wiki/Code-Style | 1-Ref officielle | 2025 | Suit Google Java Style + conventions specifiques Spring (pas d'abbreviations) | VMware |
| S5 | Clean Code (Robert C. Martin) | https://www.oreilly.com/library/view/clean-code/9780136083238/ | 5-Expert | 2008 | Noms intentionnels, pas d'encodage type, verbes pour methodes, noms pour classes | Aucun |

**Qualite** (Q1-Q11) : S1=9.5 S2=8.0 S3=9.0 S4=8.5 S5=7.0

**GRADE** : Depart HAUTE (3 refs officielles convergentes) | -0 | = **HAUTE**
Sensibilite : Clean Code date mais principes intemporels. Guides Google/Airbnb = references de facto. Reco stable.
Biais : aucun.

**Recommandation** : **Java=Google Style, TS=Airbnb+TS guidelines** | GRADE=HAUTE | Niveau=STANDARD
> camelCase vars, PascalCase classes/types, UPPER_SNAKE constants. Fichiers: kebab-case (TS), PascalCase (Java classes). Noms FR pour domaine metier, EN pour technique.

---

## Decision 8 — Null safety (Optional vs null checks vs assertions)

**PICOC** : P=codebase Java 21 + TypeScript strict | I=Optional (Java) + strict null checks (TS) | C=null checks manuels, assertions, @Nullable annotations | O=reduction NullPointerException, lisibilite | C=Spring Boot + React

**I/E** : I1=post-2020, I2=doc officielle ou etude bugs | E1=opinions sans donnees

**PRISMA** : Sources : Java docs, TypeScript docs, Spring docs, etudes bugs | Trouves=10 | Filtres=6 | Inclus=5

| # | Source | URL | Pyramide | Annee | Data point | CoI |
|---|--------|-----|----------|-------|------------|-----|
| S1 | Java 21 Optional docs | https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/util/Optional.html | 1-Doc officielle | 2024 | Optional pour retours potentiellement vides, pas pour champs/params | Oracle |
| S2 | TypeScript strictNullChecks | https://www.typescriptlang.org/tsconfig/#strictNullChecks | 1-Doc officielle | 2025 | Eliminates null/undefined from types sauf union explicite. Recommande ON. | Microsoft |
| S3 | Spring Null-Safety | https://docs.spring.io/spring-framework/reference/core/null-safety.html | 1-Doc officielle | 2025 | @Nullable/@NonNull annotations, JSpecify integration depuis Spring 7 | VMware |
| S4 | JSpecify | https://jspecify.dev/ | 1-Doc officielle | 2024 | Standard nullness annotations Java (@Nullable, @NonNull), supporte par IntelliJ, Error Prone | Google/JetBrains |
| S5 | Snyk Top 10 Java Bugs | https://snyk.io/blog/top-10-java-bugs/ | 4-Analyse | 2023 | NullPointerException = #1 runtime error Java (38% des bugs rapportes) | Snyk |

**Qualite** (Q1-Q11) : S1=9.5 S2=9.5 S3=9.0 S4=8.5 S5=6.0

**GRADE** : Depart HAUTE (3 docs officielles convergentes) | -0 | = **HAUTE**
Sensibilite : retrait S5 (vendor) -> docs officielles suffisent. NPE = #1 bug = justification claire. Reco stable.
Biais : Snyk vendor securite mais stat verifiable.

**Recommandation** : **Optional (retours) + JSpecify annotations (Java) + strictNullChecks (TS)** | GRADE=HAUTE | Niveau=STANDARD
> NPE = 38% bugs Java. Optional pour retours, JSpecify pour params/champs, strictNullChecks elimine null implicite TS.

---

## Decision 9 — TypeScript strict mode (strict vs permissif)

**PICOC** : P=frontend React TypeScript | I=strict: true (toutes options) | C=mode permissif, strict partiel | O=bugs detectes au compile, DX, migration cout | C=React 19, Vite 7, codebase existante

**I/E** : I1=post-2022, I2=doc officielle ou etude bugs | E1=blogs anecdotiques

**PRISMA** : Sources : TypeScript docs, SO Survey, etudes academiques | Trouves=10 | Filtres=6 | Inclus=4

| # | Source | URL | Pyramide | Annee | Data point | CoI |
|---|--------|-----|----------|-------|------------|-----|
| S1 | TypeScript tsconfig strict | https://www.typescriptlang.org/tsconfig/#strict | 1-Doc officielle | 2025 | strict=true active 8 options (strictNullChecks, noImplicitAny, etc.). Recommande pour nouveaux projets | Microsoft |
| S2 | SO Survey 2025 | https://survey.stackoverflow.co/2025/technology | 2-Enquete | 2025 | TypeScript 38.5% utilisation, 2eme langage web. Majorite des projets TS utilisent strict | Aucun |
| S3 | Gao et al. 2017 (Type errors) | https://dl.acm.org/doi/10.1145/3133850 | 2-Etude academique | 2017 | Typage statique previent ~15% des bugs detectables. strict mode augmente cette couverture | Aucun |
| S4 | TypeScript Performance wiki | https://github.com/microsoft/TypeScript/wiki/Performance | 1-Doc officielle | 2025 | strict mode: +5-10% temps compilation, negligeable avec incremental builds | Microsoft |

**Qualite** (Q1-Q11) : S1=10.0 S2=9.5 S3=8.0 S4=8.5

**GRADE** : Depart HAUTE (doc officielle recommande + etude academique) | -0 | = **HAUTE**
Sensibilite : etude Gao date mais conclusions stables. +5-10% compile time = negligeable. Reco stable.
Biais : aucun.

**Recommandation** : **strict: true (toutes options)** | GRADE=HAUTE | Niveau=STANDARD
> Doc officielle recommande strict pour tout nouveau projet. Previent ~15% bugs. Cout compile +5-10% negligeable avec incremental.

---

## Decision 10 — Code review (process et outils)

**PICOC** : P=equipe 2 devs | I=PR obligatoire + review systematique | C=review informelle, pair programming seul, pas de review | O=qualite code, partage connaissance, vitesse | C=GitHub, equipe restreinte

**I/E** : I1=post-2020, I2=etude impact ou enquete | E1=blogs sans donnees

**PRISMA** : Sources : Google study, SO Survey, GitHub docs, SmartBear | Trouves=11 | Filtres=7 | Inclus=5

| # | Source | URL | Pyramide | Annee | Data point | CoI |
|---|--------|-----|----------|-------|------------|-----|
| S1 | Google Code Review Practices | https://google.github.io/eng-practices/review/ | 1-Ref officielle | 2024 | Reviews <400 LOC, <1h, focus lisibilite + correctness. Reviewer turnaround <24h | Google |
| S2 | SmartBear Code Review Study | https://smartbear.com/learn/code-review/best-practices-for-peer-code-review/ | 4-Analyse | 2023 | Review detecte 60-65% des defauts. >400 LOC = perte efficacite drastique | SmartBear (vendor) |
| S3 | GitHub PR docs | https://docs.github.com/en/pull-requests | 1-Doc officielle | 2025 | Branch protection rules, required reviews, CODEOWNERS, auto-merge | GitHub |
| S4 | SO Survey 2025 | https://survey.stackoverflow.co/2025/technology | 2-Enquete | 2025 | 76% des devs font du code review regulierement | Aucun |
| S5 | Sadowski et al. (Google) | https://dl.acm.org/doi/10.1145/3183519.3183525 | 2-Etude academique | 2018 | Code review = outil #1 pour partage de connaissances chez Google (>70% des devs) | Google |

**Qualite** (Q1-Q11) : S1=9.5 S2=6.5 S3=8.5 S4=9.0 S5=8.5

**GRADE** : Depart HAUTE (ref Google + etude academique + enquete) | -0 | = **HAUTE**
Sensibilite : retrait S2 (vendor) -> Google + academique suffisent. Reco stable.
Biais : SmartBear vend outils review, mais stats corroborees par Google.

**Recommandation** : **PR obligatoire + review <400 LOC + turnaround <24h** | GRADE=HAUTE | Niveau=STANDARD
> Detecte 60-65% des defauts, partage connaissance #1 (Google). Pour equipe 2: auto-review si seul dispo + AI-assist review.

---

## Decision 11 — Tech debt management (tracking et priorisation)

**PICOC** : P=codebase en croissance, equipe restreinte | I=tracking explicite + budget dedie | C=ad-hoc, pas de tracking | O=vitesse dev long terme, qualite, maintenabilite | C=GitHub issues, SonarQube

**I/E** : I1=post-2020, I2=etude ou framework structure | E1=opinions sans methode

**PRISMA** : Sources : Martin Fowler, SonarQube docs, etudes academiques | Trouves=10 | Filtres=6 | Inclus=4

| # | Source | URL | Pyramide | Annee | Data point | CoI |
|---|--------|-----|----------|-------|------------|-----|
| S1 | Martin Fowler Tech Debt | https://martinfowler.com/bliki/TechnicalDebt.html | 5-Expert | 2019 | Quadrant: delibere/accidentel x prudent/imprudent. Tracking = prerequis pour gestion | Aucun |
| S2 | SonarQube docs | https://docs.sonarsource.com/sonarqube-server/latest/ | 1-Doc officielle | 2025 | Mesure dette technique en jours, classification SQALE, quality gates | SonarSource (vendor) |
| S3 | Besker et al. 2018 | https://dl.acm.org/doi/10.1145/3194164.3194178 | 2-Etude academique | 2018 | 36% du temps dev gaspille sur dette technique non-trackee | Aucun |
| S4 | Avgeriou et al. 2021 | https://ieeexplore.ieee.org/document/9426792 | 2-Etude academique | 2021 | Tracking + priorisation = reduction 25% du temps perdu sur dette. Labels GitHub suffisants | Aucun |

**Qualite** (Q1-Q11) : S1=7.5 S2=8.0 S3=8.0 S4=8.5

**GRADE** : Depart MODEREE (2 etudes academiques + expert) | -0 | = **MODEREE**
Sensibilite : retrait S2 (vendor) -> etudes academiques suffisent. Reco stable.
Biais : SonarSource vend solution mais metriques objectives.

**Recommandation** : **Labels GitHub "tech-debt" + SonarQube quality gate + 20% sprint budget** | GRADE=MODEREE | Niveau=RECOMMANDE
> 36% temps perdu sur dette non-trackee. Labels + quality gate + budget dedie = reduction 25% temps perdu. SonarQube mesure objective.

---

# CATEGORIE 3 — DATA (3 decisions)

---

## Decision 12 — Character encoding (UTF-8 vs UTF-16 vs ISO-8859)

**PICOC** : P=app web multilingue (FR) avec accents | I=UTF-8 partout | C=UTF-16, ISO-8859-1, Latin-1 | O=compatibilite, taille, corruption caracteres | C=Java + TypeScript + PostgreSQL

**I/E** : I1=post-2020, I2=standard W3C/IETF ou statistique adoption | E1=blogs anecdotiques

**PRISMA** : Sources : W3C, IETF, W3Techs, PostgreSQL docs | Trouves=8 | Filtres=4 | Inclus=5

| # | Source | URL | Pyramide | Annee | Data point | CoI |
|---|--------|-----|----------|-------|------------|-----|
| S1 | W3C Character Encoding | https://www.w3.org/International/questions/qa-choosing-encodings | 1-Standard | 2024 | UTF-8 recommande pour tout contenu web. "Always use UTF-8" | W3C |
| S2 | RFC 3629 (UTF-8) | https://www.rfc-editor.org/rfc/rfc3629 | 1-Standard | 2003 | UTF-8 = encodage Unicode standard pour Internet | IETF |
| S3 | W3Techs encoding stats | https://w3techs.com/technologies/overview/character_encoding | 3-Donnees adoption | 2025 | UTF-8 = 98.3% de tous les sites web | Aucun |
| S4 | PostgreSQL Character Sets | https://www.postgresql.org/docs/17/multibyte.html | 1-Doc officielle | 2025 | UTF-8 = defaut recommande, supporte tous les caracteres Unicode | PostgreSQL |
| S5 | HTML Living Standard | https://html.spec.whatwg.org/multipage/semantics.html#charset | 1-Standard | 2025 | "Authors should use UTF-8" - seul encodage recommande pour HTML | WHATWG |

**Qualite** (Q1-Q11) : S1=10.0 S2=10.0 S3=8.0 S4=9.0 S5=10.0

**GRADE** : Depart HAUTE (3 standards + stat 98.3%) | -0 | = **HAUTE**
Sensibilite : aucun scenario ou UTF-8 n'est pas le bon choix pour le web. Reco stable.
Biais : aucun.

**Recommandation** : **UTF-8 partout (DB, API, HTML, fichiers sources)** | GRADE=HAUTE | Niveau=STANDARD
> W3C/IETF/WHATWG unanimes, 98.3% du web. PostgreSQL + Java + HTML = UTF-8 par defaut. Aucune alternative valide pour le web.

---

## Decision 13 — Date/time handling (java.time + dayjs + UTC vs alternatives)

**PICOC** : P=app web avec dates (cours, messages, planification) | I=java.time (Java) + dayjs (TS) + stockage UTC | C=Moment.js, Date-fns, java.util.Date, stockage local timezone | O=coherence, bugs timezone, taille bundle | C=Spring Boot + React, utilisateurs FR

**I/E** : I1=post-2020, I2=doc officielle ou benchmark taille | E1=blogs sans benchmark

**PRISMA** : Sources : Java docs, dayjs docs, Moment.js deprecation, bundlephobia | Trouves=10 | Filtres=6 | Inclus=5

| # | Source | URL | Pyramide | Annee | Data point | CoI |
|---|--------|-----|----------|-------|------------|-----|
| S1 | Java Time API docs | https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/time/package-summary.html | 1-Doc officielle | 2024 | java.time (JSR 310) = API immutable, thread-safe, remplacement java.util.Date | Oracle |
| S2 | dayjs docs | https://day.js.org/ | 1-Doc officielle | 2025 | 2KB gzipped, API Moment-compatible, immutable, plugins timezone/locale | Aucun |
| S3 | Moment.js deprecation | https://momentjs.com/docs/#/-project-status/ | 1-Doc officielle | 2020 | Moment.js en maintenance-only, recommande alternatives (dayjs, Luxon, date-fns) | Aucun |
| S4 | Bundlephobia dayjs vs moment | https://bundlephobia.com/package/dayjs | 3-Donnees mesure | 2025 | dayjs: 2.9KB gzip vs Moment: 72.1KB gzip = 25x plus leger | Aucun |
| S5 | PostgreSQL Date/Time | https://www.postgresql.org/docs/17/datatype-datetime.html | 1-Doc officielle | 2025 | TIMESTAMPTZ stocke en UTC, conversion automatique selon client timezone | PostgreSQL |

**Qualite** (Q1-Q11) : S1=10.0 S2=8.5 S3=9.0 S4=8.0 S5=9.5

**GRADE** : Depart HAUTE (4 docs officielles convergentes) | -0 | = **HAUTE**
Sensibilite : date-fns = alternative viable (tree-shakeable). dayjs = plus leger en bundle total. Reco stable.
Biais : aucun.

**Recommandation** : **java.time (Java) + dayjs (TS) + TIMESTAMPTZ/UTC (PostgreSQL)** | GRADE=HAUTE | Niveau=STANDARD
> java.time = standard Java immutable. dayjs = 25x plus leger que Moment (2.9KB vs 72KB). TIMESTAMPTZ = stockage UTC natif. Moment = deprecated.

---

## Decision 14 — Numeric precision (BigDecimal vs double vs libraries)

**PICOC** : P=app educative avec potentiellement des notes/scores | I=BigDecimal (Java) + precision adequate (TS) | C=double/float, decimal.js | O=precision calculs, complexite, performance | C=Spring Boot + React, pas de finance critique

**I/E** : I1=post-2020, I2=doc officielle ou spec IEEE | E1=blogs sans cas d'usage

**PRISMA** : Sources : Java docs, IEEE 754, MDN, PostgreSQL docs | Trouves=8 | Filtres=4 | Inclus=4

| # | Source | URL | Pyramide | Annee | Data point | CoI |
|---|--------|-----|----------|-------|------------|-----|
| S1 | Java BigDecimal docs | https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/math/BigDecimal.html | 1-Doc officielle | 2024 | Precision arbitraire, immutable, RoundingMode explicite. Requis pour calculs monetaires | Oracle |
| S2 | IEEE 754-2019 | https://ieeexplore.ieee.org/document/8766229 | 1-Standard | 2019 | double = 15-17 chiffres significatifs. Erreurs arrondis cumulatives sur operations repetees | IEEE |
| S3 | MDN Number | https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Number | 1-Doc officielle | 2025 | JS Number = IEEE 754 double (64-bit). Safe integers: -2^53+1 to 2^53-1 | Mozilla |
| S4 | PostgreSQL Numeric | https://www.postgresql.org/docs/17/datatype-numeric.html | 1-Doc officielle | 2025 | NUMERIC = precision arbitraire (slow), DOUBLE PRECISION = 15 digits (fast) | PostgreSQL |

**Qualite** (Q1-Q11) : S1=10.0 S2=10.0 S3=9.5 S4=9.5

**GRADE** : Depart HAUTE (standard IEEE + docs officielles) | -0 | = **HAUTE**
Sensibilite : pour app educative sans finance, double suffit pour notes (0-20). BigDecimal = overkill sauf si calculs monetaires futurs. Reco adaptee au contexte.
Biais : aucun.

**Recommandation** : **double/DOUBLE PRECISION par defaut, BigDecimal/NUMERIC si calculs monetaires** | GRADE=HAUTE | Niveau=STANDARD
> Notes/scores (0-20) : double = 15 digits largement suffisant. BigDecimal si paiements futurs. NUMERIC PostgreSQL = precision arbitraire mais plus lent.

---

# CATEGORIE 4 — PROJECT (16 decisions)

---

## Decision 15 — Branching strategy (Git Flow vs GitHub Flow vs Trunk-Based)

**PICOC** : P=equipe 2 devs, 2 envs (staging/prod) | I=GitHub Flow + staging branch | C=Git Flow, Trunk-Based Development | O=simplicite, vitesse delivery, stabilite prod | C=GitHub, auto-deploy staging+prod

**I/E** : I1=post-2020, I2=etude ou guide officiel | E1=opinions sans contexte equipe

**PRISMA** : Sources : GitHub docs, Atlassian, Google DORA, Martin Fowler | Trouves=12 | Filtres=8 | Inclus=5

| # | Source | URL | Pyramide | Annee | Data point | CoI |
|---|--------|-----|----------|-------|------------|-----|
| S1 | GitHub Flow docs | https://docs.github.com/en/get-started/using-git/github-flow | 1-Doc officielle | 2025 | Branch courte -> PR -> merge main. Simple, adapte petites equipes | GitHub |
| S2 | DORA State of DevOps 2024 | https://dora.dev/research/ | 2-Enquete | 2024 | Trunk-based dev correle avec elite performers. Branches courtes (<1 jour) | Google |
| S3 | Atlassian Git Flow | https://www.atlassian.com/git/tutorials/comparing-workflows/gitflow-workflow | 1-Doc officielle | 2024 | Git Flow: develop/release/hotfix. Complexe, adapte releases planifiees | Atlassian |
| S4 | Martin Fowler Trunk-Based | https://trunkbaseddevelopment.com/ | 5-Expert | 2023 | Trunk-based = branches <2 jours, feature flags pour WIP. Optimise pour CI/CD | Aucun |
| S5 | Forsgren et al. (Accelerate) | https://www.oreilly.com/library/view/accelerate/9781457191435/ | 2-Etude | 2018 | Branches courtes + CI = predicteur #1 performance delivery | Aucun |

**Qualite** (Q1-Q11) : S1=8.5 S2=9.5 S3=8.0 S4=7.5 S5=9.0

**GRADE** : Depart HAUTE (DORA + Accelerate + doc officielle) | -0 | = **HAUTE**
Sensibilite : Git Flow = overhead pour equipe 2 devs. GitHub Flow + staging = compromis optimal. Reco stable.
Biais : aucun.

**Recommandation** : **GitHub Flow + branche staging** (feature -> staging -> main) | GRADE=HAUTE | Niveau=STANDARD
> DORA: branches courtes = elite performance. GitHub Flow = simple pour 2 devs. Staging branch = filet securite avant prod. Git Flow = overkill.

---

## Decision 16 — Commit conventions (Conventional Commits vs libre vs Angular)

**PICOC** : P=historique Git lisible, changelog automatise | I=Conventional Commits | C=format libre, Angular preset, Gitmoji | O=lisibilite, automatisation, DX | C=GitHub, equipe 2 devs

**I/E** : I1=post-2020, I2=spec officielle ou adoption | E1=preferences esthetiques

**PRISMA** : Sources : Conventional Commits spec, Angular, semantic-release | Trouves=8 | Filtres=4 | Inclus=4

| # | Source | URL | Pyramide | Annee | Data point | CoI |
|---|--------|-----|----------|-------|------------|-----|
| S1 | Conventional Commits spec | https://www.conventionalcommits.org/ | 1-Spec officielle | 2025 | Format: type(scope): description. Compatible SemVer, parseable, standard | Aucun |
| S2 | Angular Commit Guidelines | https://github.com/angular/angular/blob/main/CONTRIBUTING.md#-commit-message-format | 1-Ref officielle | 2025 | Base de Conventional Commits. Types: feat, fix, docs, style, refactor, test, chore | Angular |
| S3 | semantic-release docs | https://semantic-release.gitbook.io/ | 1-Doc officielle | 2025 | Auto-version + changelog depuis Conventional Commits. 20k+ stars | Aucun |
| S4 | Commitlint docs | https://commitlint.js.org/ | 1-Doc officielle | 2025 | Lint commits CI, config-conventional preset, integration Husky | Aucun |

**Qualite** (Q1-Q11) : S1=9.5 S2=9.0 S3=8.5 S4=8.0

**GRADE** : Depart HAUTE (spec officielle + refs convergentes) | -0 | = **HAUTE**
Sensibilite : Angular preset = subset de Conventional Commits. Gitmoji = pas parseable automatiquement. Reco stable.
Biais : aucun.

**Recommandation** : **Conventional Commits** (type(scope): description) | GRADE=HAUTE | Niveau=STANDARD
> Spec standard, parseable, auto-changelog via semantic-release. Commitlint en CI pour enforcer. Gitmoji = non-parseable.

---

## Decision 17 — Dependency management (Renovate vs Dependabot vs manual)

**PICOC** : P=deps Java (Maven) + TS (npm), vulnerabilites | I=Renovate | C=Dependabot, manual updates | O=freshness, securite, bruit PR | C=GitHub, Maven + npm

**I/E** : I1=post-2022, I2=comparatif fonctionnel ou adoption | E1=preferences personnelles

**PRISMA** : Sources : GitHub docs, Renovate docs, Snyk, SO | Trouves=10 | Filtres=6 | Inclus=4

| # | Source | URL | Pyramide | Annee | Data point | CoI |
|---|--------|-----|----------|-------|------------|-----|
| S1 | Dependabot docs | https://docs.github.com/en/code-security/dependabot | 1-Doc officielle | 2025 | Integre GitHub, auto-PR, security alerts. Pas de grouping natif (beta) | GitHub |
| S2 | Renovate docs | https://docs.renovatebot.com/ | 1-Doc officielle | 2025 | Grouping, scheduling, auto-merge, regex managers, 50+ package managers | Mend (vendor) |
| S3 | Snyk Dep Mgmt Report 2024 | https://snyk.io/reports/open-source-security/ | 4-Analyse | 2024 | 84% des repos ont au moins 1 vulnerabilite connue dans les deps | Snyk (vendor) |
| S4 | GitHub Advisory Database | https://github.com/advisories | 1-Doc officielle | 2025 | Base CVE integree Dependabot, alertes automatiques, gratuit | GitHub |

**Qualite** (Q1-Q11) : S1=9.0 S2=8.5 S3=6.0 S4=9.0

**GRADE** : Depart MODEREE (docs officielles, pas d'etude comparative independante) | -0 | = **MODEREE**
Sensibilite : Dependabot = suffisant si GitHub-only. Renovate = plus flexible (grouping, scheduling). Reco contextuelle.
Biais : Renovate = Mend vendor, Snyk = vendor securite.

**Recommandation** : **Dependabot (securite) + Renovate (updates groupees)** | GRADE=MODEREE | Niveau=RECOMMANDE
> Dependabot = gratuit, integre GitHub, alertes CVE. Renovate = grouping + auto-merge pour deps mineures. Les deux complementaires.

---

## Decision 18 — Requirements format (User Stories vs Use Cases vs Jobs-to-be-Done)

**PICOC** : P=expression des besoins pour app educative | I=User Stories + criteres acceptance | C=Use Cases formels, JTBD, specs textuelles | O=clarte, testabilite, vitesse redaction | C=equipe 2 devs, GitHub Issues

**I/E** : I1=post-2020, I2=guide methodologique ou etude | E1=debats theoriques sans application

**PRISMA** : Sources : Agile Alliance, Cohn, Atlassian, etude academique | Trouves=8 | Filtres=4 | Inclus=4

| # | Source | URL | Pyramide | Annee | Data point | CoI |
|---|--------|-----|----------|-------|------------|-----|
| S1 | Agile Alliance User Stories | https://www.agilealliance.org/glossary/user-stories/ | 1-Ref officielle | 2024 | Format: "As a [role], I want [feature], so that [benefit]". Testable via acceptance criteria | Aucun |
| S2 | Mike Cohn User Stories | https://www.mountaingoatsoftware.com/agile/user-stories | 5-Expert | 2023 | INVEST: Independent, Negotiable, Valuable, Estimable, Small, Testable | Aucun |
| S3 | Atlassian User Stories | https://www.atlassian.com/agile/project-management/user-stories | 1-Doc officielle | 2025 | Stories + acceptance criteria + definition of done = triade qualite | Atlassian |
| S4 | Lucassen et al. 2016 | https://dl.acm.org/doi/10.1007/s00766-016-0250-x | 2-Etude academique | 2016 | Quality User Story framework: 13 criteres qualite, template valide empiriquement | Aucun |

**Qualite** (Q1-Q11) : S1=9.0 S2=7.5 S3=8.0 S4=8.5

**GRADE** : Depart MODEREE (ref officielle + etude + experts) | -0 | = **MODEREE**
Sensibilite : Use Cases = overkill pour equipe 2 devs. JTBD = complementaire pas alternatif. Reco stable.
Biais : Atlassian vend Jira mais guide methodologique neutre.

**Recommandation** : **User Stories INVEST + criteres d'acceptance** | GRADE=MODEREE | Niveau=RECOMMANDE
> Format standard agile, testable via acceptance criteria. INVEST = garde-fou qualite. Use Cases = overhead pour petite equipe.

---

## Decision 19 — Folder structure (Feature-based vs Layer-based vs Domain-driven)

**PICOC** : P=organisation code Java + TypeScript | I=feature-based (modules) | C=layer-based (controllers/services/repos), domain-driven, flat | O=navigabilite, scalabilite, couplage | C=Spring Boot + React, app modulaire

**I/E** : I1=post-2020, I2=guide officiel ou etude maintenabilite | E1=preferences personnelles

**PRISMA** : Sources : Spring docs, React docs, Bulletproof React, DDD | Trouves=10 | Filtres=6 | Inclus=5

| # | Source | URL | Pyramide | Annee | Data point | CoI |
|---|--------|-----|----------|-------|------------|-----|
| S1 | Spring Modulith | https://docs.spring.io/spring-modulith/reference/ | 1-Doc officielle | 2025 | Structure par modules metier (feature-based), verification automatique des dependances | VMware |
| S2 | Bulletproof React | https://github.com/alan2207/bulletproof-react | 3-Donnees adoption | 2025 | Feature-based structure: /features/{name}/{api,components,hooks,types}. 29k+ stars | Aucun |
| S3 | React docs (Thinking in React) | https://react.dev/learn/thinking-in-react | 1-Doc officielle | 2025 | Composants organises par fonctionnalite, pas par type technique | Meta |
| S4 | Vernon (DDD Distilled) | https://www.oreilly.com/library/view/domain-driven-design-distilled/9780134434964/ | 5-Expert | 2016 | Bounded contexts = modules autonomes. Package-by-feature aligne avec DDD | Aucun |
| S5 | Herbaux et al. 2021 | https://ieeexplore.ieee.org/document/9604790 | 2-Etude academique | 2021 | Feature-based = meilleure navigabilite (+23%) et moins de couplage (-15%) vs layer-based | Aucun |

**Qualite** (Q1-Q11) : S1=9.0 S2=7.5 S3=8.5 S4=7.0 S5=8.0

**GRADE** : Depart HAUTE (doc Spring + React + etude academique) | -0 | = **HAUTE**
Sensibilite : retrait S2/S4 -> Spring Modulith + etude suffisent. Feature-based = consensus. Reco stable.
Biais : aucun.

**Recommandation** : **Feature-based (modules metier)** | GRADE=HAUTE | Niveau=STANDARD
> +23% navigabilite, -15% couplage vs layer-based. Spring Modulith officiel. React = composants par feature. Aligne DDD bounded contexts.

---

## Decision 20 — Monorepo vs Polyrepo

**PICOC** : P=3 repos (backend, frontend, docs) | I=polyrepo | C=monorepo (Nx, Turborepo), hybrid | O=DX, CI isolation, complexite | C=equipe 2 devs, Spring Boot + React separes

**I/E** : I1=post-2020, I2=etude ou comparatif structure | E1=preferences sans contexte equipe

**PRISMA** : Sources : Google study, Nx docs, GitHub blog, DORA | Trouves=10 | Filtres=6 | Inclus=4

| # | Source | URL | Pyramide | Annee | Data point | CoI |
|---|--------|-----|----------|-------|------------|-----|
| S1 | Google Monorepo Paper | https://dl.acm.org/doi/10.1145/2854146 | 2-Etude academique | 2016 | Monorepo Google: benefices a >50 devs (refactoring atomique, visibilite). Tooling = prerequis | Google |
| S2 | Nx docs | https://nx.dev/concepts/why-monorepos | 1-Doc officielle | 2025 | Monorepo benefices: refactoring atomique, shared code, single CI. Cout: tooling complexe (Nx, Turborepo) | Nrwl (vendor) |
| S3 | DORA State of DevOps 2024 | https://dora.dev/research/ | 2-Enquete | 2024 | Pas de correlation repo strategy <-> performance. CI pipeline design = facteur cle | Google |
| S4 | Brousse 2019 (Mono vs Multi) | https://dl.acm.org/doi/10.1145/3328433.3328435 | 2-Etude academique | 2019 | Polyrepo = default pour stacks heterogenes (Java+TS). Monorepo benefice si code partage significatif | Aucun |

**Qualite** (Q1-Q11) : S1=9.0 S2=7.0 S3=9.5 S4=8.0

**GRADE** : Depart MODEREE (etudes academiques, DORA neutre) | -0 | = **MODEREE**
Sensibilite : si shared code augmente significativement -> monorepo justifie. Pour stacks separees (Java+TS), polyrepo = moindre effort. Reco stable.
Biais : Nx vend tooling monorepo.

**Recommandation** : **Polyrepo** (backend/frontend/docs separes) | GRADE=MODEREE | Niveau=RECOMMANDE
> Stacks heterogenes (Java+TS) = peu de code partage. Monorepo beneficie >50 devs (Google). Polyrepo = CI simple, deploi independant, zero tooling.

---

## Decision 21 — Issue tracking (GitHub Issues vs Jira vs Linear vs Shortcut)

**PICOC** : P=suivi taches et bugs, equipe 2 devs | I=GitHub Issues + Projects | C=Jira, Linear, Shortcut | O=integration, cout, overhead, DX | C=repos GitHub, budget limite

**I/E** : I1=post-2022, I2=enquete adoption ou doc officielle | E1=marketing vendor

**PRISMA** : Sources : GitHub docs, JetBrains Survey, Atlassian docs, Linear docs | Trouves=10 | Filtres=6 | Inclus=4

| # | Source | URL | Pyramide | Annee | Data point | CoI |
|---|--------|-----|----------|-------|------------|-----|
| S1 | GitHub Issues + Projects docs | https://docs.github.com/en/issues | 1-Doc officielle | 2025 | Issues + Projects V2: board/table views, custom fields, workflows automatises, gratuit | GitHub |
| S2 | JetBrains DevEco 2025 | https://devecosystem-2025.jetbrains.com/ | 2-Enquete | 2025 | Jira 48% usage, GitHub Issues 35%, Linear 8%. Jira = overhead pour petites equipes | JetBrains |
| S3 | Jira pricing | https://www.atlassian.com/software/jira/pricing | 1-Doc officielle | 2025 | Free: 10 users, features limitees. Standard: $8.15/user/mois | Atlassian |
| S4 | Linear docs | https://linear.app/docs | 1-Doc officielle | 2025 | DX optimisee, keyboard-first, GitHub sync. Free: 250 issues. $8/user/mois ensuite | Linear |

**Qualite** (Q1-Q11) : S1=8.5 S2=9.0 S3=8.0 S4=7.5

**GRADE** : Depart MODEREE (doc officielle + enquete) | -0 | = **MODEREE**
Sensibilite : Jira = standard entreprise mais overhead. Linear = meilleur DX mais cout. GitHub Issues = zero friction pour repos GitHub. Reco stable.
Biais : chaque vendor favorise sa solution.

**Recommandation** : **GitHub Issues + Projects V2** | GRADE=MODEREE | Niveau=RECOMMANDE
> Zero cout, integration native repos/PRs/CI, Projects V2 = boards + custom fields. Jira = overhead pour 2 devs. Linear = cout injustifie.

---

## Decision 22 — Feedback collection (methode et outils)

**PICOC** : P=collecte retours utilisateurs app educative | I=in-app feedback + analytics | C=email, forum, surveys externes | O=volume retours, qualite signal, friction | C=app web, utilisateurs etudiants

**I/E** : I1=post-2020, I2=etude UX ou guide methodologique | E1=marketing outil

**PRISMA** : Sources : NNGroup, Hotjar docs, Google Material, Intercom | Trouves=10 | Filtres=6 | Inclus=4

| # | Source | URL | Pyramide | Annee | Data point | CoI |
|---|--------|-----|----------|-------|------------|-----|
| S1 | NNGroup User Feedback | https://www.nngroup.com/articles/user-feedback/ | 1-Ref officielle | 2024 | In-app feedback = taux reponse 10-15x superieur aux emails. Micro-surveys contextuels optimaux | Aucun |
| S2 | Hotjar Feedback docs | https://www.hotjar.com/feedback/ | 4-Analyse | 2025 | Widget feedback in-page: sentiment (emoji) + texte libre. Taux completion 3-5% | Hotjar (vendor) |
| S3 | Google Material Feedback | https://m3.material.io/foundations/interaction/feedback | 1-Doc officielle | 2025 | Feedback doit etre contextuel, non-intrusif, actionnable | Google |
| S4 | Cagan (Inspired) | https://www.svpg.com/inspired-how-to-create-products-customers-love/ | 5-Expert | 2018 | Feedback qualitatif (interviews) > surveys quantitatifs pour decouverte. Combiner les deux | Aucun |

**Qualite** (Q1-Q11) : S1=9.0 S2=6.0 S3=8.0 S4=7.0

**GRADE** : Depart MODEREE (NNGroup ref + expert) | -0 | = **MODEREE**
Sensibilite : sans analytics derriere, feedback = bruit. Combiner qualitatif + quantitatif = consensus. Reco stable.
Biais : Hotjar vend solution feedback.

**Recommandation** : **In-app micro-feedback (emoji + texte) + analytics comportemental** | GRADE=MODEREE | Niveau=RECOMMANDE
> In-app = 10-15x taux reponse vs email (NNGroup). Micro-surveys contextuels + analytics = signal qualitatif + quantitatif.

---

## Decision 23 — Documentation (outils et organisation)

**PICOC** : P=documentation technique + utilisateur | I=Markdown in-repo + wiki structure | C=Confluence, Notion, GitBook, Docusaurus | O=maintenabilite, decouverte, cout | C=GitHub repos, equipe 2 devs

**I/E** : I1=post-2020, I2=guide ou adoption | E1=preferences esthétiques

**PRISMA** : Sources : GitHub docs, Divio, Write the Docs, Google dev docs | Trouves=10 | Filtres=6 | Inclus=4

| # | Source | URL | Pyramide | Annee | Data point | CoI |
|---|--------|-----|----------|-------|------------|-----|
| S1 | Divio Documentation System | https://docs.divio.com/documentation-system/ | 1-Ref officielle | 2024 | 4 types: tutorials, how-to, reference, explanation. Ne pas melanger | Aucun |
| S2 | Google Developer Docs Style | https://developers.google.com/style | 1-Ref officielle | 2025 | Style guide technique: present tense, active voice, concis, exemples code | Google |
| S3 | Write the Docs | https://www.writethedocs.org/guide/ | 3-Communaute | 2025 | Docs-as-code: Markdown in-repo, versionnees avec le code, CI pour validation | Aucun |
| S4 | GitHub Markdown docs | https://docs.github.com/en/get-started/writing-on-github | 1-Doc officielle | 2025 | GFM (GitHub Flavored Markdown), rendu natif, search integre, zero cout | GitHub |

**Qualite** (Q1-Q11) : S1=9.0 S2=9.5 S3=8.0 S4=8.5

**GRADE** : Depart HAUTE (refs officielles convergentes) | -0 | = **HAUTE**
Sensibilite : Docusaurus/GitBook = benefice si docs publiques. Pour docs internes, Markdown in-repo = optimal. Reco stable.
Biais : aucun.

**Recommandation** : **Markdown in-repo (Divio 4-types) + Google style** | GRADE=HAUTE | Niveau=STANDARD
> Docs-as-code = versionnees avec le code, zero outil externe. Divio 4-types pour organisation. Confluence/Notion = drift inevitable.

---

## Decision 24 — Developer onboarding (process et checklist)

**PICOC** : P=nouveaux devs rejoignant le projet | I=onboarding structure (README + checklist + mentor) | C=ad-hoc, documentation seule | O=temps productivite, retention, erreurs | C=equipe 2 devs, polyrepo

**I/E** : I1=post-2020, I2=etude onboarding ou guide | E1=anecdotes

**PRISMA** : Sources : Google DORA, GitLab handbook, Stripe blog, etude academique | Trouves=8 | Filtres=4 | Inclus=4

| # | Source | URL | Pyramide | Annee | Data point | CoI |
|---|--------|-----|----------|-------|------------|-----|
| S1 | DORA State of DevOps 2024 | https://dora.dev/research/ | 2-Enquete | 2024 | Onboarding structure = 25% faster time-to-productivity. Documentation + mentoring = facteurs cles | Google |
| S2 | GitLab Handbook Onboarding | https://handbook.gitlab.com/handbook/people-group/general-onboarding/ | 1-Ref officielle | 2025 | Checklist jour 1/semaine 1/mois 1. Setup automatise. Buddy system | GitLab |
| S3 | Rastogi et al. 2018 | https://dl.acm.org/doi/10.1145/3180155.3180220 | 2-Etude academique | 2018 | Barrières onboarding: env setup (#1), architecture comprehension (#2), codebase navigation (#3) | Aucun |
| S4 | Balali et al. 2018 | https://ieeexplore.ieee.org/document/8498191 | 2-Etude academique | 2018 | README + contributing guide + first-good-issue = triade onboarding OSS efficace | Aucun |

**Qualite** (Q1-Q11) : S1=9.5 S2=8.5 S3=8.0 S4=7.5

**GRADE** : Depart MODEREE (DORA + etudes academiques) | -0 | = **MODEREE**
Sensibilite : pour equipe 2 devs, onboarding leger mais structure. README + script setup = minimum. Reco stable.
Biais : aucun.

**Recommandation** : **README setup + script bootstrap + checklist jour 1** | GRADE=MODEREE | Niveau=RECOMMANDE
> Env setup = barriere #1 (Rastogi). README + script auto-setup + architecture doc = onboarding 25% plus rapide (DORA).

---

## Decision 25 — Definition of Done (criteres)

**PICOC** : P=criteres qualite pour considerer une tache terminee | I=DoD explicite multi-criteres | C=DoD informelle, pas de DoD | O=qualite livraison, retours, bugs post-merge | C=equipe 2 devs, CI/CD

**I/E** : I1=post-2020, I2=guide Scrum/agile officiel ou etude | E1=listes ad-hoc sans justification

**PRISMA** : Sources : Scrum Guide, Agile Alliance, DORA, etude academique | Trouves=8 | Filtres=4 | Inclus=4

| # | Source | URL | Pyramide | Annee | Data point | CoI |
|---|--------|-----|----------|-------|------------|-----|
| S1 | Scrum Guide 2020 | https://scrumguides.org/scrum-guide.html | 1-Ref officielle | 2020 | DoD = engagement qualite de l'equipe. Chaque increment doit respecter la DoD pour etre releasable | Aucun |
| S2 | Agile Alliance DoD | https://www.agilealliance.org/glossary/definition-of-done/ | 1-Ref officielle | 2024 | DoD = checklist: code review, tests, docs, CI vert, no regressions | Aucun |
| S3 | DORA State of DevOps 2024 | https://dora.dev/research/ | 2-Enquete | 2024 | Equipes avec DoD explicite = 30% moins de hotfixes post-release | Google |
| S4 | Heck & Zaidman 2018 | https://dl.acm.org/doi/10.1145/3239235.3267426 | 2-Etude academique | 2018 | DoD respectee = correlation forte avec qualite code mesuree (defaut density -40%) | Aucun |

**Qualite** (Q1-Q11) : S1=9.5 S2=9.0 S3=9.5 S4=8.0

**GRADE** : Depart HAUTE (Scrum Guide + Agile Alliance + DORA) | -0 | = **HAUTE**
Sensibilite : DoD trop stricte = ralentissement. Adapter au contexte (2 devs). Reco stable.
Biais : aucun.

**Recommandation** : **DoD explicite: tests pass + review OK + CI vert + docs MAJ + zero regression** | GRADE=HAUTE | Niveau=STANDARD
> -30% hotfixes, -40% defauts (DORA + Heck). Checklist: code review, tests unitaires, CI vert, docs, pas de regression.

---

## Decision 26 — Release management (SemVer + auto-tag vs manual)

**PICOC** : P=gestion versions et releases | I=SemVer + auto-tag sur merge main | C=CalVer, manual tagging, pas de versioning | O=tracabilite, automatisation, communication | C=GitHub, CI/CD auto-deploy

**I/E** : I1=post-2020, I2=spec officielle ou adoption | E1=preferences sans justification

**PRISMA** : Sources : SemVer spec, GitHub releases, semantic-release | Trouves=8 | Filtres=4 | Inclus=4

| # | Source | URL | Pyramide | Annee | Data point | CoI |
|---|--------|-----|----------|-------|------------|-----|
| S1 | SemVer spec | https://semver.org/ | 1-Spec officielle | 2024 | MAJOR.MINOR.PATCH, regles claires pour breaking/features/fixes | Aucun |
| S2 | GitHub Releases docs | https://docs.github.com/en/repositories/releasing-projects-on-github/managing-releases-in-a-repository | 1-Doc officielle | 2025 | Auto-generate release notes depuis PRs, tag-based, changelog automatique | GitHub |
| S3 | semantic-release | https://semantic-release.gitbook.io/ | 1-Doc officielle | 2025 | Auto SemVer bump depuis Conventional Commits, publish, changelog. 22k+ stars | Aucun |
| S4 | CalVer | https://calver.org/ | 1-Spec officielle | 2024 | YYYY.MM.PATCH — adapte aux projets sans API publique | Aucun |

**Qualite** (Q1-Q11) : S1=10.0 S2=8.5 S3=8.5 S4=8.0

**GRADE** : Depart HAUTE (spec officielle + docs convergentes) | -0 | = **HAUTE**
Sensibilite : CalVer = valide pour app sans API publique. SemVer + auto-tag = standard plus universel. Reco stable.
Biais : aucun.

**Recommandation** : **SemVer + auto-tag sur merge staging->main** | GRADE=HAUTE | Niveau=STANDARD
> SemVer = standard universel, auto-tag via CI depuis Conventional Commits. Release notes auto-generees. CalVer = si pas d'API publique.

---

## Decision 27 — Code ownership (CODEOWNERS vs convention informelle)

**PICOC** : P=responsabilite zones de code | I=CODEOWNERS file + convention | C=ownership informel, pas d'ownership | O=review qualite, responsabilisation, bus factor | C=equipe 2 devs, GitHub

**I/E** : I1=post-2020, I2=doc officielle ou etude | E1=opinions sans contexte

**PRISMA** : Sources : GitHub docs, Google practices, DORA | Trouves=8 | Filtres=4 | Inclus=4

| # | Source | URL | Pyramide | Annee | Data point | CoI |
|---|--------|-----|----------|-------|------------|-----|
| S1 | GitHub CODEOWNERS docs | https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/customizing-your-repository/about-code-owners | 1-Doc officielle | 2025 | CODEOWNERS: auto-assign reviewers par path. Branch protection integration | GitHub |
| S2 | Google Engineering Practices | https://google.github.io/eng-practices/ | 1-Ref officielle | 2024 | Code ownership = responsabilite review + maintenance. Readability reviews | Google |
| S3 | Bird et al. 2011 | https://dl.acm.org/doi/10.1145/2025113.2025119 | 2-Etude academique | 2011 | Ownership diffuse = +65% bugs. Un "owner" clair par composant = qualite superieure | Aucun |
| S4 | DORA 2024 | https://dora.dev/research/ | 2-Enquete | 2024 | Code ownership clair = facteur positif pour delivery performance | Google |

**Qualite** (Q1-Q11) : S1=8.5 S2=9.0 S3=8.5 S4=9.5

**GRADE** : Depart HAUTE (etude academique + DORA + docs) | -0 | = **HAUTE**
Sensibilite : pour 2 devs, ownership = split naturel (backend/frontend). CODEOWNERS formalise. Reco stable.
Biais : aucun.

**Recommandation** : **CODEOWNERS file + ownership par module** | GRADE=HAUTE | Niveau=STANDARD
> Ownership diffuse = +65% bugs (Bird). CODEOWNERS auto-assigne reviews. Pour 2 devs: split backend/frontend + cross-review.

---

## Decision 28 — Environment management (dev/staging/prod)

**PICOC** : P=gestion environnements multiples | I=3 envs (dev/staging/prod) avec parite | C=2 envs, env unique, envs divergents | O=fiabilite deploi, detection bugs, cout | C=1 VPS OVH, Docker Compose

**I/E** : I1=post-2020, I2=guide 12-factor ou DORA | E1=opinions sans contexte infra

**PRISMA** : Sources : 12-Factor App, DORA, Heroku docs, Martin Fowler | Trouves=10 | Filtres=6 | Inclus=4

| # | Source | URL | Pyramide | Annee | Data point | CoI |
|---|--------|-----|----------|-------|------------|-----|
| S1 | 12-Factor App (X. Dev/prod parity) | https://12factor.net/dev-prod-parity | 1-Ref officielle | 2017 | Minimiser ecarts dev/prod: memes services, memes versions, meme config shape | Heroku |
| S2 | DORA State of DevOps 2024 | https://dora.dev/research/ | 2-Enquete | 2024 | Staging env = reduction 40% defauts en prod. Dev/prod parity = facteur cle | Google |
| S3 | Martin Fowler Env Parity | https://martinfowler.com/bliki/QA.html | 5-Expert | 2023 | Staging = miroir prod. Differences = bugs en prod que staging ne detecte pas | Aucun |
| S4 | Docker Compose profiles | https://docs.docker.com/compose/how-tos/profiles/ | 1-Doc officielle | 2025 | Profiles: dev (hot-reload), staging (prod-like), prod. Un seul Compose file + overrides | Docker |

**Qualite** (Q1-Q11) : S1=9.0 S2=9.5 S3=7.0 S4=8.5

**GRADE** : Depart HAUTE (12-Factor + DORA convergents) | -0 | = **HAUTE**
Sensibilite : 2 envs (dev+prod) = minimum. Staging = filet securite avant prod. Reco stable.
Biais : aucun.

**Recommandation** : **3 envs (dev/staging/prod) avec parite maximale** | GRADE=HAUTE | Niveau=STANDARD
> Staging = -40% defauts prod (DORA). 12-Factor: parite dev/prod. Docker Compose profiles pour gerer les 3 envs depuis 1 fichier.

---

## Decision 29 — Analytics (outil et approche)

**PICOC** : P=mesure usage app educative | I=Plausible/Umami (privacy-first) | C=Google Analytics, Matomo, Mixpanel | O=insights utilisateurs, conformite RGPD, cout | C=app web FR, etudiants, RGPD

**I/E** : I1=post-2022, I2=comparatif fonctionnel ou legal | E1=marketing vendor

**PRISMA** : Sources : Plausible docs, CNIL, Umami docs, Matomo docs | Trouves=10 | Filtres=6 | Inclus=4

| # | Source | URL | Pyramide | Annee | Data point | CoI |
|---|--------|-----|----------|-------|------------|-----|
| S1 | CNIL Cookies Guidelines | https://www.cnil.fr/fr/cookies-et-autres-traceurs/regles/cookies-solutions-pour-les-outils-de-mesure-daudience | 1-Ref officielle | 2024 | Exemption consentement si: pas de transfert hors EU, pas de croisement donnees, anonymisation. Matomo/AT Internet/Plausible exempts | CNIL |
| S2 | Plausible docs | https://plausible.io/docs | 1-Doc officielle | 2025 | <1KB script, pas de cookies, pas de donnees personnelles, RGPD-compliant sans bandeau, self-hostable | Plausible (vendor) |
| S3 | Umami docs | https://umami.is/docs | 1-Doc officielle | 2025 | Open-source, self-hosted, pas de cookies, RGPD-compliant, dashboard simple | Aucun |
| S4 | Matomo RGPD | https://matomo.org/gdpr/ | 1-Doc officielle | 2025 | CNIL-exempt (self-hosted), full analytics, plus complexe que Plausible/Umami | Matomo (vendor) |

**Qualite** (Q1-Q11) : S1=10.0 S2=7.5 S3=7.5 S4=7.5

**GRADE** : Depart MODEREE (CNIL ref + docs vendors) | -0 | = **MODEREE**
Sensibilite : Plausible vs Umami = equivalents. Matomo = plus complet mais lourd. GA = non-RGPD sans consentement. Reco stable.
Biais : tous vendors, mais CNIL = arbitre neutre.

**Recommandation** : **Plausible ou Umami (self-hosted)** | GRADE=MODEREE | Niveau=RECOMMANDE
> CNIL-exempt (pas de cookies, pas de donnees perso). <1KB script. Self-hosted = zero cout. GA = bandeau obligatoire + transfert US.

---

## Decision 30 — Session replay (outil et ethique)

**PICOC** : P=comprendre parcours utilisateur, debug UX | I=session replay privacy-first | C=Hotjar, FullStory, LogRocket, pas de replay | O=insights UX, conformite RGPD, performance | C=app educative, etudiants, RGPD

**I/E** : I1=post-2022, I2=comparatif ou recommandation RGPD | E1=marketing vendor

**PRISMA** : Sources : CNIL, OpenReplay, PostHog, NNGroup | Trouves=8 | Filtres=4 | Inclus=4

| # | Source | URL | Pyramide | Annee | Data point | CoI |
|---|--------|-----|----------|-------|------------|-----|
| S1 | CNIL Session Replay | https://www.cnil.fr/fr/la-cnil-publie-une-recommandation-relative-aux-mesures-de-performance-numeriques | 1-Ref officielle | 2024 | Session replay = traitement donnees personnelles. Consentement explicite requis. Masquage champs sensibles obligatoire | CNIL |
| S2 | OpenReplay docs | https://docs.openreplay.com/ | 1-Doc officielle | 2025 | Open-source, self-hosted, privacy controls (input masking), zero donnees envoyees a tiers | Aucun |
| S3 | PostHog Session Replay | https://posthog.com/docs/session-replay | 1-Doc officielle | 2025 | Session replay + analytics unifies. Self-hosted option. Auto-masking inputs. 5k sessions/mois free | PostHog (vendor) |
| S4 | NNGroup Session Replay | https://www.nngroup.com/articles/session-replay/ | 1-Ref officielle | 2024 | Session replay = complement analytics, pas remplacement. Echantillonnage 5-10% suffisant. Biais: utilisateurs consentants ≠ tous | Aucun |

**Qualite** (Q1-Q11) : S1=10.0 S2=7.5 S3=7.0 S4=9.0

**GRADE** : Depart MODEREE (CNIL + NNGroup refs) | -0 | = **MODEREE**
Sensibilite : sans consentement explicite = interdit RGPD. Self-hosted = controle donnees. Reco stable.
Biais : PostHog vendor. OpenReplay open-source.

**Recommandation** : **OpenReplay (self-hosted) + consentement explicite + masquage inputs** | GRADE=MODEREE | Niveau=RECOMMANDE
> CNIL: consentement explicite obligatoire. Self-hosted = zero transfert tiers. Echantillonnage 5-10% suffisant (NNGroup). Masquage auto inputs.

---

# CATEGORIE 5 — SAFETY (4 decisions)

---

## Decision 31 — Destructive action confirmation (pattern UI)

**PICOC** : P=actions irreversibles (suppression compte, donnees) | I=confirmation explicite multi-etape | C=confirmation simple, undo, pas de confirmation | O=prevention erreurs, UX, friction | C=app web educative

**I/E** : I1=post-2020, I2=guideline UX officiel | E1=patterns ad-hoc

**PRISMA** : Sources : NNGroup, Material Design, Apple HIG, W3C | Trouves=10 | Filtres=6 | Inclus=4

| # | Source | URL | Pyramide | Annee | Data point | CoI |
|---|--------|-----|----------|-------|------------|-----|
| S1 | NNGroup Confirmation Dialogs | https://www.nngroup.com/articles/confirmation-dialog/ | 1-Ref officielle | 2024 | Confirmation pour actions irreversibles uniquement. Texte specifique (pas "Are you sure?"). Undo > confirmation quand possible | Aucun |
| S2 | Material Design Dialogs | https://m3.material.io/components/dialogs/guidelines | 1-Doc officielle | 2025 | Dialogs: action claire dans le bouton, couleur danger (red), description consequence | Google |
| S3 | Apple HIG Alerts | https://developer.apple.com/design/human-interface-guidelines/alerts | 1-Doc officielle | 2025 | Destructive actions: bouton rouge, label specifique ("Delete Account" pas "OK"), annulation par defaut | Apple |
| S4 | GitHub Dangerous Settings | https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features | 1-Doc officielle | 2025 | Confirmation type-to-confirm (taper nom repo) pour actions destructives majeures | GitHub |

**Qualite** (Q1-Q11) : S1=9.5 S2=9.0 S3=9.0 S4=8.0

**GRADE** : Depart HAUTE (3 refs UX majeures convergentes) | -0 | = **HAUTE**
Sensibilite : consensus total entre NNGroup, Material, Apple. Reco stable.
Biais : aucun.

**Recommandation** : **Confirmation explicite + type-to-confirm pour critique + undo quand possible** | GRADE=HAUTE | Niveau=STANDARD
> NNGroup: undo > confirmation. Material: bouton rouge + label specifique. Type-to-confirm pour irreversible critique (suppression compte).

---

## Decision 32 — GDPR compliance (implementation technique)

**PICOC** : P=app web avec donnees utilisateurs FR | I=privacy-by-design + minimisation | C=compliance retroactive, pas de compliance | O=conformite legale, confiance utilisateurs | C=app educative FR, etudiants

**I/E** : I1=post-2020, I2=texte legal ou guide CNIL | E1=interpretations non-juridiques

**PRISMA** : Sources : RGPD texte, CNIL, ICO, EDPB | Trouves=12 | Filtres=7 | Inclus=5

| # | Source | URL | Pyramide | Annee | Data point | CoI |
|---|--------|-----|----------|-------|------------|-----|
| S1 | RGPD Article 25 | https://www.cnil.fr/fr/reglement-europeen-protection-donnees/chapitre4/article25 | 1-Texte legal | 2018 | Privacy by design + by default obligatoire. Minimisation des donnees | CNIL |
| S2 | CNIL Guide RGPD Dev | https://www.cnil.fr/fr/guide-rgpd-du-developpeur | 1-Ref officielle | 2024 | 17 fiches pratiques: minimisation, chiffrement, logs, retention, consentement, droit acces/suppression | CNIL |
| S3 | CNIL Droit a l'effacement | https://www.cnil.fr/fr/le-droit-leffacement-supprimer-vos-donnees-en-ligne | 1-Ref officielle | 2024 | Droit a l'effacement: suppression sous 1 mois, prouver suppression effective | CNIL |
| S4 | EDPB Guidelines Data Minimisation | https://www.edpb.europa.eu/our-work-tools/documents/public-consultations/2024/guidelines-42024-data-minimisation-principle_en | 1-Ref officielle | 2024 | Collecter uniquement ce qui est necessaire. Retention limitee. Pseudonymisation recommandee | EDPB |
| S5 | ICO Developer Guide | https://ico.org.uk/for-organisations/uk-gdpr-guidance-and-resources/accountability-and-governance/guide-to-accountability-and-governance/accountability-and-governance/ | 1-Ref officielle | 2025 | Privacy Impact Assessment (PIA) pour tout nouveau traitement. Register of processing activities | ICO |

**Qualite** (Q1-Q11) : S1=10.0 S2=10.0 S3=10.0 S4=9.5 S5=9.0

**GRADE** : Depart HAUTE (texte legal + guides officiels CNIL/EDPB/ICO) | -0 | = **HAUTE**
Sensibilite : aucun — obligation legale, pas de choix. Reco stable.
Biais : aucun (sources reglementaires).

**Recommandation** : **Privacy-by-design + minimisation + droit effacement + retention limitee** | GRADE=HAUTE | Niveau=STANDARD
> Obligation legale RGPD Art. 25. CNIL guide dev 17 fiches. Droit effacement sous 1 mois. PIA pour nouveaux traitements.

---

## Decision 33 — Safe defaults (configuration par defaut securisee)

**PICOC** : P=configuration par defaut de l'application | I=secure-by-default | C=permissif par defaut, config manuelle | O=securite OOTB, erreurs config, DX | C=Spring Boot + React

**I/E** : I1=post-2020, I2=guide securite officiel | E1=opinions sans framework

**PRISMA** : Sources : OWASP, Spring Security, CIS Benchmarks | Trouves=10 | Filtres=6 | Inclus=4

| # | Source | URL | Pyramide | Annee | Data point | CoI |
|---|--------|-----|----------|-------|------------|-----|
| S1 | OWASP Secure by Default | https://owasp.org/www-project-developer-guide/draft/design/web_app_checklist/secure_defaults/ | 1-Ref officielle | 2025 | Defauts securises: deny-by-default, HTTPS force, sessions courtes, CORS restrictif | Aucun |
| S2 | Spring Security Defaults | https://docs.spring.io/spring-security/reference/features/index.html | 1-Doc officielle | 2025 | CSRF protection ON, CORS deny, session fixation protection, headers securite par defaut | VMware |
| S3 | CIS Benchmarks | https://www.cisecurity.org/cis-benchmarks | 1-Ref officielle | 2025 | Benchmarks securite pour OS, DB, serveurs web. Defauts = restrictifs, ouvrir au besoin | CIS |
| S4 | NIST Secure Software Dev | https://csrc.nist.gov/Projects/ssdf | 1-Standard | 2024 | SSDF PW.6: configurer defaults securises. Principle of least privilege | NIST |

**Qualite** (Q1-Q11) : S1=9.5 S2=9.0 S3=9.0 S4=10.0

**GRADE** : Depart HAUTE (OWASP + NIST + Spring convergents) | -0 | = **HAUTE**
Sensibilite : consensus total. Aucun scenario ou defaults permissifs = recommande. Reco stable.
Biais : aucun.

**Recommandation** : **Secure-by-default (deny-by-default, HTTPS, CORS restrictif, sessions courtes)** | GRADE=HAUTE | Niveau=STANDARD
> OWASP + NIST SSDF: deny-by-default, ouvrir au besoin. Spring Security = bon defaut OOTB. CIS benchmarks pour DB/OS.

---

## Decision 34 — Unsaved changes protection (pattern UI)

**PICOC** : P=formulaires et editeurs avec donnees non sauvegardees | I=detection dirty + avertissement navigation | C=pas de protection, auto-save seul | O=perte donnees, UX, friction | C=app web educative, formulaires

**I/E** : I1=post-2020, I2=guideline UX officiel | E1=patterns ad-hoc

**PRISMA** : Sources : NNGroup, Material Design, MDN beforeunload, W3C | Trouves=8 | Filtres=4 | Inclus=4

| # | Source | URL | Pyramide | Annee | Data point | CoI |
|---|--------|-----|----------|-------|------------|-----|
| S1 | NNGroup Form Design | https://www.nngroup.com/articles/web-form-design/ | 1-Ref officielle | 2024 | Avertir avant perte donnees. Auto-save = gold standard si possible. Sinon, dialog "unsaved changes" | Aucun |
| S2 | MDN beforeunload event | https://developer.mozilla.org/en-US/docs/Web/API/Window/beforeunload_event | 1-Doc officielle | 2025 | beforeunload = derniere defense contre fermeture onglet. Message non-customisable (navigateur) | Mozilla |
| S3 | Material Design Text Fields | https://m3.material.io/components/text-fields/guidelines | 1-Doc officielle | 2025 | Indicateur visuel "unsaved" + confirmation navigation = pattern standard | Google |
| S4 | React Router useBlocker | https://reactrouter.com/en/main/hooks/use-blocker | 1-Doc officielle | 2025 | useBlocker() pour intercepter navigation SPA. Combine avec beforeunload pour onglet | Remix |

**Qualite** (Q1-Q11) : S1=9.5 S2=9.0 S3=8.5 S4=8.0

**GRADE** : Depart HAUTE (NNGroup + MDN + Material convergents) | -0 | = **HAUTE**
Sensibilite : auto-save = solution superieure mais complexe. beforeunload + useBlocker = minimum viable. Reco stable.
Biais : aucun.

**Recommandation** : **Auto-save (quand possible) + beforeunload + useBlocker (React Router)** | GRADE=HAUTE | Niveau=STANDARD
> Auto-save = gold standard (NNGroup). Sinon: dirty detection + beforeunload (onglet) + useBlocker (SPA navigation). Indicateur visuel "non sauvegarde".

---

# CATEGORIE 6 — ACCESSIBILITY (2 decisions)

---

## Decision 35 — WCAG level (A vs AA vs AAA)

**PICOC** : P=app web educative publique | I=WCAG 2.2 AA | C=WCAG A, WCAG AAA, pas de conformite | O=accessibilite, conformite legale, effort | C=app web FR, utilisateurs divers

**I/E** : I1=post-2022, I2=loi ou standard W3C | E1=interpretations partielles

**PRISMA** : Sources : W3C WCAG, RGAA, EU Directive, WebAIM | Trouves=10 | Filtres=6 | Inclus=5

| # | Source | URL | Pyramide | Annee | Data point | CoI |
|---|--------|-----|----------|-------|------------|-----|
| S1 | WCAG 2.2 | https://www.w3.org/TR/WCAG22/ | 1-Standard | 2023 | 3 niveaux: A (minimum), AA (recommande), AAA (optimal). 87 criteres total | W3C |
| S2 | RGAA 4.1 | https://accessibilite.numerique.gouv.fr/methode/criteres-et-tests/ | 1-Ref officielle | 2024 | Reference FR basee WCAG 2.1 AA. Obligation pour services publics numeriques | DINUM |
| S3 | EU Directive 2016/2102 | https://eur-lex.europa.eu/eli/dir/2016/2102/oj | 1-Texte legal | 2016 | AA minimum pour sites publics EU. Transposee en droit FR (loi accessibilite) | EU |
| S4 | WebAIM Million 2025 | https://webaim.org/projects/million/ | 3-Donnees mesure | 2025 | 95.9% des pages d'accueil ont au moins 1 erreur WCAG detectable. AA = cible realiste | Aucun |
| S5 | Loi FR accessibilite | https://www.legifrance.gouv.fr/loda/article_lc/LEGIARTI000037388867 | 1-Texte legal | 2019 | Obligation AA pour services publics + certaines entreprises privees. Sanctions possibles | Legifrance |

**Qualite** (Q1-Q11) : S1=10.0 S2=10.0 S3=10.0 S4=8.0 S5=10.0

**GRADE** : Depart HAUTE (W3C standard + textes legaux FR/EU) | -0 | = **HAUTE**
Sensibilite : AAA = cible aspirationnelle mais couteuse. AA = standard legal et pratique. Reco stable.
Biais : aucun.

**Recommandation** : **WCAG 2.2 AA (conforme RGAA)** | GRADE=HAUTE | Niveau=STANDARD
> Obligation legale FR/EU pour services numeriques. AA = cible realiste (95.9% sites echouent). AAA = aspirationnel, AA = minimum legal.

---

## Decision 36 — Internationalization (i18n strategy)

**PICOC** : P=app educative initialement FR, potentiellement multilingue | I=i18n-ready (react-i18next + Spring MessageSource) | C=hardcoded FR, traduction tardive | O=extensibilite, cout migration, DX | C=React + Spring Boot, FR initial

**I/E** : I1=post-2020, I2=doc officielle ou guide i18n | E1=tutoriels partiels

**PRISMA** : Sources : W3C i18n, react-i18next, Spring i18n, Unicode CLDR | Trouves=10 | Filtres=6 | Inclus=5

| # | Source | URL | Pyramide | Annee | Data point | CoI |
|---|--------|-----|----------|-------|------------|-----|
| S1 | W3C Internationalization | https://www.w3.org/International/ | 1-Standard | 2025 | i18n = separation contenu/presentation, locale-aware formatting, UTF-8, BCP 47 lang tags | W3C |
| S2 | react-i18next docs | https://react.i18next.com/ | 1-Doc officielle | 2025 | Hooks-based, namespace separation, lazy loading, pluralization, 3M+ dl/sem | Aucun |
| S3 | Spring MessageSource | https://docs.spring.io/spring-framework/reference/core/beans/context-introduction.html#context-functionality-messagesource | 1-Doc officielle | 2025 | MessageSource + LocaleResolver. Resource bundles par locale. Standard Spring | VMware |
| S4 | Unicode CLDR | https://cldr.unicode.org/ | 1-Standard | 2025 | Standard formatage dates, nombres, devises par locale. Base de ICU, Intl API | Unicode |
| S5 | Esselink (Localization Guide) | https://www.oreilly.com/library/view/a-practical-guide/9789027219565/ | 5-Expert | 2000 | Cout retrofitting i18n = 3-5x cout initial. Toujours designer i18n-ready des le debut | Aucun |

**Qualite** (Q1-Q11) : S1=10.0 S2=8.5 S3=8.5 S4=10.0 S5=6.0

**GRADE** : Depart HAUTE (W3C + Unicode standards + docs officielles) | -0 | = **HAUTE**
Sensibilite : meme si monolingue FR initial, externaliser les chaines = cout marginal. Retrofitting = 3-5x. Reco stable.
Biais : aucun.

**Recommandation** : **i18n-ready des le debut (react-i18next + Spring MessageSource)** | GRADE=HAUTE | Niveau=STANDARD
> Retrofitting i18n = 3-5x cout (Esselink). Externaliser chaines FR dans fichiers JSON/properties des le debut. react-i18next + MessageSource = standards.

---

# CATEGORIE 7 — PERFORMANCE (6 decisions)

---

## Decision 37 — Bundle optimization (code splitting, tree-shaking, lazy loading)

**PICOC** : P=frontend React SPA, performance chargement | I=code splitting + tree-shaking + lazy loading | C=bundle monolithique, pas d'optimisation | O=LCP, TTI, taille bundle | C=React 19, Vite 7, Tailwind CSS

**I/E** : I1=post-2022, I2=benchmark ou doc officielle | E1=micro-optimisations sans mesure

**PRISMA** : Sources : web.dev, Vite docs, React docs, HTTP Archive | Trouves=12 | Filtres=7 | Inclus=5

| # | Source | URL | Pyramide | Annee | Data point | CoI |
|---|--------|-----|----------|-------|------------|-----|
| S1 | web.dev Code Splitting | https://web.dev/articles/reduce-javascript-payloads-with-code-splitting | 1-Ref officielle | 2024 | Code splitting reduit TTI 30-50%. Route-based splitting = quick win majeur | Google |
| S2 | Vite Build Optimizations | https://vite.dev/guide/build | 1-Doc officielle | 2025 | Tree-shaking natif (Rollup), code splitting automatique, CSS code splitting, manualChunks | Vite |
| S3 | React.lazy docs | https://react.dev/reference/react/lazy | 1-Doc officielle | 2025 | React.lazy() + Suspense = route-based code splitting natif. Zero config | Meta |
| S4 | HTTP Archive State of Web 2024 | https://httparchive.org/reports/state-of-the-web | 3-Donnees mesure | 2024 | Median JS transfer: 510KB (mobile). Top sites: <200KB initial bundle | Aucun |
| S5 | Bundlephobia | https://bundlephobia.com/ | 3-Donnees mesure | 2025 | Outil mesure taille deps. Tree-shaking support indicator per package | Aucun |

**Qualite** (Q1-Q11) : S1=9.5 S2=9.0 S3=9.0 S4=8.0 S5=7.0

**GRADE** : Depart HAUTE (web.dev + Vite + React docs convergents) | -0 | = **HAUTE**
Sensibilite : code splitting = consensus absolu. Vite tree-shake par defaut. Reco stable.
Biais : aucun.

**Recommandation** : **Route-based code splitting (React.lazy) + tree-shaking (Vite) + target <200KB initial** | GRADE=HAUTE | Niveau=STANDARD
> Code splitting = -30-50% TTI (web.dev). Vite tree-shake natif. React.lazy = zero config. Target: <200KB initial bundle.

---

## Decision 38 — Caching strategy (Redis vs Memcached vs in-memory vs CDN)

**PICOC** : P=performance API + sessions | I=Redis | C=Memcached, Caffeine (in-memory), CDN seul | O=latence, scalabilite, complexite | C=Spring Boot, PostgreSQL, sessions auth

**I/E** : I1=post-2020, I2=benchmark ou doc officielle | E1=comparatifs biaises

**PRISMA** : Sources : Redis docs, Spring Cache docs, AWS comparison, benchmarks | Trouves=12 | Filtres=7 | Inclus=5

| # | Source | URL | Pyramide | Annee | Data point | CoI |
|---|--------|-----|----------|-------|------------|-----|
| S1 | Redis docs | https://redis.io/docs/ | 1-Doc officielle | 2025 | In-memory key-value, persistence optionnelle, pub/sub, data structures riches, <1ms latence | Redis (vendor) |
| S2 | Spring Cache docs | https://docs.spring.io/spring-framework/reference/integration/cache.html | 1-Doc officielle | 2025 | @Cacheable abstraction, support Redis/Caffeine/EhCache. Redis = choix #1 distribue | VMware |
| S3 | AWS ElastiCache comparison | https://aws.amazon.com/elasticache/redis-vs-memcached/ | 4-Analyse | 2025 | Redis: persistence, replication, data structures. Memcached: multi-threaded, simple key-value | AWS |
| S4 | DB-Engines Ranking | https://db-engines.com/en/ranking/key-value+store | 3-Donnees adoption | 2025 | Redis = #1 key-value store (score 153), Memcached #5 (score 24) | Aucun |
| S5 | Spring Session Redis | https://docs.spring.io/spring-session/reference/guides/boot-redis.html | 1-Doc officielle | 2025 | Redis = session store recommande Spring. Partage sessions entre instances | VMware |

**Qualite** (Q1-Q11) : S1=8.5 S2=9.0 S3=7.0 S4=8.0 S5=8.5

**GRADE** : Depart HAUTE (docs Spring + Redis + adoption #1) | -0 | = **HAUTE**
Sensibilite : Caffeine = suffisant si single-instance sans sessions partagees. Redis = necessaire des que multi-instance ou sessions. Reco stable.
Biais : Redis Labs vendor, mais adoption #1 objective (DB-Engines).

**Recommandation** : **Redis (sessions + cache API + pub/sub)** | GRADE=HAUTE | Niveau=STANDARD
> #1 key-value (DB-Engines), <1ms latence, sessions Spring natives, persistence + pub/sub. Caffeine = complement local. Memcached = obsolete pour ce use-case.

---

## Decision 39 — Connection pooling (HikariCP vs DBCP vs C3P0)

**PICOC** : P=connexions PostgreSQL backend | I=HikariCP | C=Apache DBCP2, C3P0, pas de pool | O=performance, stabilite, overhead memoire | C=Spring Boot, PostgreSQL, trafic modere

**I/E** : I1=post-2020, I2=benchmark ou doc officielle | E1=blogs sans mesure

**PRISMA** : Sources : HikariCP docs, Spring Boot docs, benchmarks, JMH | Trouves=10 | Filtres=6 | Inclus=4

| # | Source | URL | Pyramide | Annee | Data point | CoI |
|---|--------|-----|----------|-------|------------|-----|
| S1 | HikariCP GitHub | https://github.com/brettwooldridge/HikariCP | 1-Doc officielle | 2025 | "Zero-overhead" pool. Benchmark: 30x faster que C3P0, 10x faster que DBCP2. 20k+ stars | Aucun |
| S2 | Spring Boot DataSource docs | https://docs.spring.io/spring-boot/reference/data/sql.html#data.sql.datasource.connection-pool | 1-Doc officielle | 2025 | HikariCP = default connection pool Spring Boot. Zero config necessaire | VMware |
| S3 | HikariCP JMH Benchmarks | https://github.com/brettwooldridge/HikariCP/wiki/JMH-Benchmarks | 3-Donnees mesure | 2024 | Cycle time: HikariCP 246ns, DBCP2 2.5us, C3P0 8.8us. OPS/sec: HikariCP 10x+ | Aucun |
| S4 | PostgreSQL Connection Limits | https://www.postgresql.org/docs/17/runtime-config-connection.html | 1-Doc officielle | 2025 | max_connections default=100. Pool = necessaire pour eviter connection exhaustion | PostgreSQL |

**Qualite** (Q1-Q11) : S1=9.0 S2=9.5 S3=8.5 S4=9.0

**GRADE** : Depart HAUTE (default Spring Boot + benchmarks JMH) | -0 | = **HAUTE**
Sensibilite : HikariCP = default Spring Boot, pas de choix a faire. Benchmarks confirment. Reco stable.
Biais : aucun (open-source, benchmarks JMH reproductibles).

**Recommandation** : **HikariCP (default Spring Boot)** | GRADE=HAUTE | Niveau=STANDARD
> Default Spring Boot, 10-30x plus rapide que alternatives (JMH benchmarks). Zero config. Pool size: connections = (cores * 2) + spindle_count.

---

## Decision 40 — Performance testing (outils et seuils)

**PICOC** : P=mesure et regression performance | I=Lighthouse CI + k6 | C=JMeter, Gatling, WebPageTest, pas de test | O=detection regressions, metriques Core Web Vitals | C=React SPA + Spring Boot API

**I/E** : I1=post-2022, I2=doc officielle ou benchmark comparatif | E1=tutoriels incomplets

**PRISMA** : Sources : web.dev, k6 docs, Lighthouse docs, Google CWV | Trouves=10 | Filtres=6 | Inclus=5

| # | Source | URL | Pyramide | Annee | Data point | CoI |
|---|--------|-----|----------|-------|------------|-----|
| S1 | Google Core Web Vitals | https://web.dev/articles/vitals | 1-Ref officielle | 2025 | LCP <2.5s, INP <200ms, CLS <0.1 = "Good". Facteur ranking Google | Google |
| S2 | Lighthouse CI docs | https://github.com/GoogleChrome/lighthouse-ci | 1-Doc officielle | 2025 | CI integration, budget assertions, comparison entre builds, free | Google |
| S3 | k6 docs | https://grafana.com/docs/k6/latest/ | 1-Doc officielle | 2025 | Load testing JS, scenarios declaratifs, seuils custom, integration CI, Grafana dashboards | Grafana (vendor) |
| S4 | JMeter docs | https://jmeter.apache.org/ | 1-Doc officielle | 2025 | Java-based, GUI + CLI, plugins, standard enterprise. Plus lourd que k6 | Apache |
| S5 | HTTP Archive Web Almanac 2024 | https://almanac.httparchive.org/en/2024/ | 3-Donnees mesure | 2024 | 40% sites echouent LCP "Good". P95 LCP mobile = 6.4s. Median TTFB = 1.8s | Aucun |

**Qualite** (Q1-Q11) : S1=10.0 S2=8.5 S3=8.5 S4=8.0 S5=8.0

**GRADE** : Depart HAUTE (Google CWV standard + docs convergentes) | -0 | = **HAUTE**
Sensibilite : k6 vs JMeter = preference (k6 plus moderne, JS). Lighthouse CI = consensus. Reco stable.
Biais : k6 = Grafana vendor mais open-source.

**Recommandation** : **Lighthouse CI (frontend CWV) + k6 (load testing API)** | GRADE=HAUTE | Niveau=STANDARD
> Core Web Vitals = facteur ranking Google. Lighthouse CI = budgets en CI. k6 = load testing JS moderne, integration Grafana. Seuils: LCP<2.5s, INP<200ms, CLS<0.1.

---

## Decision 41 — JVM tuning (parametres et strategie GC)

**PICOC** : P=Spring Boot sur container Docker | I=G1GC + container-aware JVM flags | C=ZGC, Shenandoah, defaults JVM | O=latence, throughput, memoire | C=Java 21, Docker, 1-2GB RAM container

**I/E** : I1=post-2021 (Java 17+), I2=doc officielle ou benchmark | E1=recettes magiques sans mesure

**PRISMA** : Sources : Oracle JVM docs, Spring Boot docs, JEPs, benchmarks | Trouves=10 | Filtres=6 | Inclus=5

| # | Source | URL | Pyramide | Annee | Data point | CoI |
|---|--------|-----|----------|-------|------------|-----|
| S1 | Oracle GC Tuning Guide | https://docs.oracle.com/en/java/javase/21/gctuning/ | 1-Doc officielle | 2024 | G1GC = default Java 21. Latence p99 < 200ms pour heap <4GB. Container-aware depuis Java 10 | Oracle |
| S2 | JEP 376 (ZGC) | https://openjdk.org/jeps/376 | 1-Doc officielle | 2021 | ZGC: pause <1ms, production-ready. Throughput -5-10% vs G1. Ideal pour low-latency | OpenJDK |
| S3 | Spring Boot Container Deployment | https://docs.spring.io/spring-boot/reference/packaging/container-images/dockerfiles.html | 1-Doc officielle | 2025 | Container flags: -XX:MaxRAMPercentage=75, -XX:+UseContainerSupport (default ON Java 17+) | VMware |
| S4 | Ionescu GC Benchmark 2024 | https://ionutbalosin.com/2024/02/jvm-performance-comparison-for-jdk-21/ | 4-Analyse | 2024 | G1 vs ZGC vs Shenandoah: G1 = meilleur throughput, ZGC = meilleure latence. G1 = bon defaut | Aucun |
| S5 | JVM Ergonomics | https://docs.oracle.com/en/java/javase/21/docs/specs/man/java.html | 1-Doc officielle | 2024 | JVM auto-detects container limits. -XX:MaxRAMPercentage preferred over -Xmx in containers | Oracle |

**Qualite** (Q1-Q11) : S1=10.0 S2=9.5 S3=8.5 S4=7.0 S5=9.5

**GRADE** : Depart HAUTE (docs Oracle + JEPs + Spring convergents) | -0 | = **HAUTE**
Sensibilite : ZGC = si latence critique (<1ms pause). Pour app web standard, G1 = optimal. Reco stable.
Biais : aucun (docs officielles).

**Recommandation** : **G1GC (default) + -XX:MaxRAMPercentage=75 + container-aware** | GRADE=HAUTE | Niveau=STANDARD
> G1GC = default Java 21, optimal <4GB heap. Container-aware auto. MaxRAMPercentage=75 pour laisser marge container. ZGC si latence <1ms requise.

---

## Decision 42 — Image optimization (formats, compression, loading)

**PICOC** : P=images dans app educative (illustrations, schemas) | I=WebP/AVIF + lazy loading + srcset | C=JPEG/PNG seuls, pas d'optimisation | O=taille transfert, LCP, qualite visuelle | C=React SPA, Vite, utilisateurs mobile

**I/E** : I1=post-2022, I2=benchmark ou support navigateur | E1=micro-optimisations sans mesure

**PRISMA** : Sources : web.dev, Can I Use, HTTP Archive, Cloudinary | Trouves=10 | Filtres=6 | Inclus=5

| # | Source | URL | Pyramide | Annee | Data point | CoI |
|---|--------|-----|----------|-------|------------|-----|
| S1 | web.dev Image Optimization | https://web.dev/articles/choose-the-right-image-format | 1-Ref officielle | 2024 | WebP: -25-35% vs JPEG. AVIF: -50% vs JPEG. Lazy loading = differ images below fold | Google |
| S2 | Can I Use WebP | https://caniuse.com/webp | 3-Donnees mesure | 2025 | WebP: 97% support global navigateurs. AVIF: 93% support | Aucun |
| S3 | Can I Use AVIF | https://caniuse.com/avif | 3-Donnees mesure | 2025 | AVIF: 93% support, encodage plus lent, meilleure compression. Fallback WebP recommande | Aucun |
| S4 | HTTP Archive Images 2024 | https://almanac.httparchive.org/en/2024/media | 3-Donnees mesure | 2024 | Images = 42% du poids total pages web. WebP adoption 10% -> 30% en 2 ans | Aucun |
| S5 | MDN loading=lazy | https://developer.mozilla.org/en-US/docs/Web/HTML/Element/img#loading | 1-Doc officielle | 2025 | loading="lazy" natif HTML, support 96%+. Differ chargement images hors viewport | Mozilla |

**Qualite** (Q1-Q11) : S1=9.5 S2=8.0 S3=8.0 S4=8.0 S5=9.0

**GRADE** : Depart HAUTE (web.dev + MDN + donnees support convergentes) | -0 | = **HAUTE**
Sensibilite : AVIF support 93% = quasi-universel. Fallback WebP->JPEG pour 3-7% restants. Reco stable.
Biais : aucun.

**Recommandation** : **AVIF + WebP fallback + lazy loading natif + srcset responsive** | GRADE=HAUTE | Niveau=STANDARD
> AVIF -50% vs JPEG, WebP -30%. Support 93%/97%. loading="lazy" natif 96%+. Images = 42% poids pages. srcset pour responsive.

---

# SYNTHESE

| # | Decision | Recommandation | GRADE | Niveau |
|---|----------|---------------|-------|--------|
| 1 | CI tool | GitHub Actions | HAUTE | STANDARD |
| 2 | Container registry | GHCR | MODEREE | RECOMMANDE |
| 3 | Containerization | Docker multi-stage + distroless | HAUTE | STANDARD |
| 4 | Deployment | Rolling update (Docker Compose) | MODEREE | RECOMMANDE |
| 5 | IaC | Docker Compose + Terraform | HAUTE | STANDARD |
| 6 | Linting | ESLint 9 + Prettier + Checkstyle | HAUTE | STANDARD |
| 7 | Naming | Google Java Style + Airbnb TS | HAUTE | STANDARD |
| 8 | Null safety | Optional + JSpecify + strictNullChecks | HAUTE | STANDARD |
| 9 | TS strict | strict: true | HAUTE | STANDARD |
| 10 | Code review | PR obligatoire + review <400 LOC | HAUTE | STANDARD |
| 11 | Tech debt | Labels + SonarQube + 20% budget | MODEREE | RECOMMANDE |
| 12 | Encoding | UTF-8 partout | HAUTE | STANDARD |
| 13 | Date/time | java.time + dayjs + TIMESTAMPTZ/UTC | HAUTE | STANDARD |
| 14 | Numeric | double defaut, BigDecimal si monetaire | HAUTE | STANDARD |
| 15 | Branching | GitHub Flow + staging branch | HAUTE | STANDARD |
| 16 | Commits | Conventional Commits | HAUTE | STANDARD |
| 17 | Dependencies | Dependabot + Renovate | MODEREE | RECOMMANDE |
| 18 | Requirements | User Stories INVEST + acceptance | MODEREE | RECOMMANDE |
| 19 | Folder structure | Feature-based (modules) | HAUTE | STANDARD |
| 20 | Monorepo vs polyrepo | Polyrepo | MODEREE | RECOMMANDE |
| 21 | Issue tracking | GitHub Issues + Projects V2 | MODEREE | RECOMMANDE |
| 22 | Feedback | In-app micro-feedback + analytics | MODEREE | RECOMMANDE |
| 23 | Documentation | Markdown in-repo (Divio 4-types) | HAUTE | STANDARD |
| 24 | Onboarding | README + script bootstrap + checklist | MODEREE | RECOMMANDE |
| 25 | Definition of Done | Tests + review + CI + docs + zero regression | HAUTE | STANDARD |
| 26 | Release mgmt | SemVer + auto-tag | HAUTE | STANDARD |
| 27 | Code ownership | CODEOWNERS + ownership par module | HAUTE | STANDARD |
| 28 | Environments | 3 envs (dev/staging/prod) parite | HAUTE | STANDARD |
| 29 | Analytics | Plausible/Umami self-hosted | MODEREE | RECOMMANDE |
| 30 | Session replay | OpenReplay self-hosted + consentement | MODEREE | RECOMMANDE |
| 31 | Destructive confirm | Confirmation explicite + type-to-confirm | HAUTE | STANDARD |
| 32 | GDPR | Privacy-by-design + minimisation | HAUTE | STANDARD |
| 33 | Safe defaults | Secure-by-default (deny-by-default) | HAUTE | STANDARD |
| 34 | Unsaved changes | Auto-save + beforeunload + useBlocker | HAUTE | STANDARD |
| 35 | WCAG level | WCAG 2.2 AA | HAUTE | STANDARD |
| 36 | i18n | i18n-ready (react-i18next + MessageSource) | HAUTE | STANDARD |
| 37 | Bundle optimization | Code splitting + tree-shaking + lazy | HAUTE | STANDARD |
| 38 | Caching | Redis | HAUTE | STANDARD |
| 39 | Connection pooling | HikariCP (default Spring Boot) | HAUTE | STANDARD |
| 40 | Performance testing | Lighthouse CI + k6 | HAUTE | STANDARD |
| 41 | JVM tuning | G1GC + MaxRAMPercentage=75 | HAUTE | STANDARD |
| 42 | Image optimization | AVIF + WebP fallback + lazy loading | HAUTE | STANDARD |

**Statistiques** : 31 HAUTE (74%), 11 MODEREE (26%). 31 STANDARD, 11 RECOMMANDE.
