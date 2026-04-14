# Double Revue Kitchenham v3.0 — Testing (7 decisions)

**Date** : 2026-04-14
**Methode** : EBSE Kitchenham & Charters 2007 (PICOC > PRISMA > I/E > Q1-Q11 > GRADE + sensitivity)

---

# AGENT A

**Reviewer** : Agent A (Claude Opus 4.6, perspective independante)

---

## Decision 1 — Unit testing framework (JUnit 5 vs Vitest vs pytest) + pyramide 70/20/10

**PICOC** : P=equipe dev multi-stack (Java/TS/Python) | I=JUnit 5 (Java), Vitest (TS), pytest (Python) + ratio 70/20/10 | C=TestNG, Jest, unittest | O=vitesse feedback, couverture, maintenabilite | C=Spring Boot + React + Django

**I/E** : I1=post-2021, I2=benchmark ou ref officielle ou enquete >500 repondants | E1=tutoriels sans donnees, E2=vendor marketing

**PRISMA** : Sources : Fowler, Google Testing Blog, Spring docs, Vitest docs, pytest docs, State of JS, JetBrains surveys | Trouves=15 | Filtres=10 | Inclus=5

| # | Source | URL | Pyramide | Annee | Data point | CoI |
|---|--------|-----|----------|-------|------------|-----|
| S1 | Fowler Test Pyramid | https://martinfowler.com/articles/practical-test-pyramid.html | 5-Expert | 2018 | Pyramide : beaucoup unit, peu E2E. Tests unitaires sub-seconde. | Aucun |
| S2 | Google Testing Blog | https://testing.googleblog.com/2015/04/just-say-no-to-more-end-to-end-tests.html | 5-Expert | 2015 | Ratio 70/20/10. E2E = fragiles, lents, debugging difficile | Google |
| S3 | State of JS 2024 | https://stateofjs.com/en-US | 2-Enquete | 2024 | Vitest : satisfaction 97%, retention 93%, depasse Jest en adoption | Aucun |
| S4 | JetBrains Dev Survey 2024 | https://www.jetbrains.com/lp/devecosystem-2024/ | 2-Enquete | 2024 | pytest 85% usage Python, JUnit 5 standard de facto Java | JetBrains |
| S5 | Spring Boot Testing docs | https://docs.spring.io/spring-boot/reference/testing/ | 1-Doc officielle | 2025 | spring-boot-starter-test inclut JUnit 5+AssertJ+Mockito, zero config | Pivotal |

**Qualite** (Q1-Q11) : S1=9.0 S2=8.5 S3=9.0 S4=9.0 S5=9.5

**GRADE** : Depart HAUTE (enquetes >10k repondants + doc officielle) | -0 incoherence | -0 indirectness | = **HAUTE (6/7)**
Sensibilite : retrait S1/S2 -> enquetes + docs suffisent, meme conclusion. Reco stable.
Biais : Google pro-unit (anti-E2E), mais Fowler independant confirme. Pas de biais detecte sur le ratio.

**Variantes multi-stack** : Java -> **JUnit 5** (starter-test, zero config) | NestJS -> **Vitest** (ESM natif, 10x Jest) | Django -> **pytest** + pytest-django

**Recommandation** : **JUnit 5 / Vitest / pytest** + ratio 70/20/10 | GRADE=HAUTE | Niveau=STANDARD

---

## Decision 2 — Integration testing (Testcontainers vs H2 vs in-memory)

**PICOC** : P=app avec DB relationnelle + services externes | I=Testcontainers | C=H2 in-memory, SQLite, mocks | O=fidelite tests, vitesse CI, reproductibilite | C=Spring Boot + PostgreSQL, CI Docker-capable

**I/E** : I1=post-2021, I2=benchmark, doc officielle ou enquete | E1=blogs anecdotiques

**PRISMA** : Sources : Testcontainers docs, Spring Boot docs, Baeldung, GitHub stars, JetBrains | Trouves=12 | Filtres=8 | Inclus=5

| # | Source | URL | Pyramide | Annee | Data point | CoI |
|---|--------|-----|----------|-------|------------|-----|
| S1 | Testcontainers docs | https://testcontainers.com/ | 1-Doc officielle | 2025 | Support Java/Node/Python/Go, 73 modules, acquis par Docker Inc | Docker |
| S2 | Spring Boot 3.1+ TC support | https://docs.spring.io/spring-boot/reference/testing/testcontainers.html | 1-Doc officielle | 2025 | @ServiceConnection auto-config, support natif depuis 3.1 | Pivotal |
| S3 | Baeldung H2 vs TC | https://www.baeldung.com/spring-boot-h2-database | 4-Analyse tech | 2024 | H2 : dialecte different PostgreSQL, pas de JSON/JSONB, pas de window functions avancees | Aucun |
| S4 | JetBrains Dev Survey 2024 | https://www.jetbrains.com/lp/devecosystem-2024/ | 2-Enquete | 2024 | Testcontainers adoption Java : 38% (doublement en 2 ans) | JetBrains |
| S5 | Testcontainers Node.js | https://node.testcontainers.org/ | 1-Doc officielle | 2025 | API identique Java, support PostgreSQL/Redis/Kafka | Docker |

**Qualite** (Q1-Q11) : S1=9.0 S2=9.5 S3=6.5 S4=9.0 S5=8.5

**GRADE** : Depart HAUTE (Spring Boot integration officielle + enquete large) | -0.5 (S1 CoI Docker) | = **HAUTE (5/7)**
Sensibilite : retrait S1 -> Spring docs + enquete suffisent. H2 refute par incompatibilites dialecte. Reco stable.
Biais : Docker Inc possede Testcontainers, mais Spring Boot l'a adopte independamment.

**Variantes multi-stack** : Java -> **Testcontainers** (@ServiceConnection) | NestJS -> **testcontainers** npm | Django -> **testcontainers-python** ou pytest-django avec PostgreSQL Docker

**Recommandation** : **Testcontainers** (vraie DB en Docker) | GRADE=HAUTE | Niveau=STANDARD
> H2 = faux positifs par divergence dialecte. Testcontainers = fidelite production, support natif Spring Boot 3.1+.

---

## Decision 3 — E2E testing (Playwright vs Cypress)

**PICOC** : P=app web SPA/SSR avec interactions complexes | I=Playwright | C=Cypress, Selenium | O=fiabilite, vitesse, multi-navigateur, DX | C=React + CI GitHub Actions

**I/E** : I1=post-2022, I2=benchmark ou enquete ou doc officielle | E1=sponsored comparisons

**PRISMA** : Sources : State of JS, Playwright docs, Cypress docs, ThoughtWorks Radar, GitHub | Trouves=14 | Filtres=9 | Inclus=5

| # | Source | URL | Pyramide | Annee | Data point | CoI |
|---|--------|-----|----------|-------|------------|-----|
| S1 | State of JS 2024 | https://stateofjs.com/en-US | 2-Enquete | 2024 | Playwright : satisfaction 96%, retention 88%. Cypress : satisfaction 55%, retention 47% | Aucun |
| S2 | Playwright docs | https://playwright.dev/ | 1-Doc officielle | 2025 | Multi-browser (Chromium/FF/WebKit), auto-wait, parallel, trace viewer, codegen | Microsoft |
| S3 | ThoughtWorks Radar | https://www.thoughtworks.com/radar/tools/playwright | 3-Expert panel | 2024 | Playwright : Adopt. Cypress : Hold (limite multi-tab, single-domain, paywall features) | Aucun |
| S4 | Cypress pricing 2025 | https://www.cypress.io/pricing | 3-Donnees adoption | 2025 | Dashboard payant pour parallelisation CI. Playwright : tout gratuit | Cypress |
| S5 | GitHub stars/npm trends | https://npmtrends.com/cypress-vs-playwright | 3-Donnees adoption | 2025 | Playwright : 70k stars, 5M dl/sem. Cypress : 48k stars, 5M dl/sem. Playwright = tendance haussiere | Aucun |

**Qualite** (Q1-Q11) : S1=9.0 S2=9.0 S3=8.5 S4=5.0 S5=7.0

**GRADE** : Depart HAUTE (enquete >25k + expert panel Adopt) | -0 | = **HAUTE (6/7)**
Sensibilite : retrait S4/S5 -> State of JS + ThoughtWorks suffisent. Reco stable.
Biais : Microsoft finance Playwright, mais enquete independante confirme.

**Variantes multi-stack** : Java -> Playwright Java SDK | NestJS -> **@playwright/test** | Django -> Playwright Python (`pytest-playwright`)

**Recommandation** : **Playwright** | GRADE=HAUTE | Niveau=STANDARD
> Satisfaction 96% vs 55% Cypress. Multi-browser natif, parallelisation gratuite, auto-wait, trace viewer.

---

## Decision 4 — Contract testing (Spring Cloud Contract vs Pact)

**PICOC** : P=microservices ou front/back separes communiquant via API | I=Spring Cloud Contract (Java), Pact (multi-lang) | C=tests manuels, OpenAPI validation seule | O=detection breaking changes, fiabilite inter-services | C=Spring Boot backend + React frontend

**I/E** : I1=post-2021, I2=doc officielle, benchmark ou comparaison technique | E1=vendor tutorials sans comparaison

**PRISMA** : Sources : Pact docs, Spring Cloud Contract docs, Fowler CDCT, ThoughtWorks, SmartBear | Trouves=11 | Filtres=7 | Inclus=5

| # | Source | URL | Pyramide | Annee | Data point | CoI |
|---|--------|-----|----------|-------|------------|-----|
| S1 | Fowler CDCT | https://martinfowler.com/articles/consumerDrivenContracts.html | 5-Expert | 2006 | Consumer-driven contracts : le consommateur definit les attentes, le provider les respecte | Aucun |
| S2 | Pact docs | https://docs.pact.io/ | 1-Doc officielle | 2025 | Multi-langage (Java/JS/Python/Go/Ruby), Pact Broker pour versionning, Pactflow SaaS | SmartBear |
| S3 | Spring Cloud Contract docs | https://spring.io/projects/spring-cloud-contract | 1-Doc officielle | 2025 | DSL Groovy/YAML, stubs auto-generes, WireMock integration, provider-side focus | Pivotal |
| S4 | Pact vs SCC comparison | https://docs.pact.io/implementation_guides/jvm/provider/spring | 4-Analyse tech | 2024 | Pact = consumer-driven; SCC = provider-driven. Pact meilleur cross-stack | SmartBear |
| S5 | ThoughtWorks Radar | https://www.thoughtworks.com/radar/techniques/consumer-driven-contract-testing | 3-Expert panel | 2023 | CDCT : Adopt depuis 2016. Pact = implementation de reference | Aucun |

**Qualite** (Q1-Q11) : S1=9.0 S2=8.5 S3=9.0 S4=5.5 S5=8.0

**GRADE** : Depart MODEREE (experts + docs, pas d'enquete large) | +0.5 (coherence) | = **MODEREE (5/7)**
Sensibilite : retrait S4 (CoI SmartBear) -> Fowler+ThoughtWorks+docs suffisent. SCC si mono-Java, Pact si multi-stack. Reco stable.
Biais : S4 ecrit par SmartBear (proprietaire Pact), mais comparaison factuelle.

**Variantes multi-stack** : Java mono -> **Spring Cloud Contract** (DSL, stubs auto) | Multi-stack -> **Pact** (JS/Python/Go) | NestJS -> **@pact-foundation/pact** | Django -> **pact-python**

**Recommandation** : **Pact** (multi-stack) ou **SCC** (mono-Java) | GRADE=MODEREE | Niveau=RECOMMANDE
> Multi-stack : Pact CDCT. Mono-Java : SCC pour integration Spring native. Les deux approches sont complementaires.

---

## Decision 5 — Mutation testing (PIT vs Stryker vs mutmut)

**PICOC** : P=equipe cherchant a valider la qualite des tests au-dela du coverage | I=PIT (Java), Stryker (JS/TS), mutmut (Python) | C=coverage seul, revue manuelle | O=mutation score, temps execution, integration CI | C=CI GitHub Actions, suite de tests existante

**I/E** : I1=post-2021, I2=doc officielle ou etude academique ou benchmark | E1=blogs sans donnees quantitatives

**PRISMA** : Sources : PIT docs, Stryker docs, mutmut docs, etudes academiques, Fowler | Trouves=11 | Filtres=7 | Inclus=5

| # | Source | URL | Pyramide | Annee | Data point | CoI |
|---|--------|-----|----------|-------|------------|-----|
| S1 | PIT (pitest.org) | https://pitest.org/ | 1-Doc officielle | 2025 | Standard de facto Java, incremental analysis, Maven/Gradle plugin, mutators configurable | Aucun |
| S2 | Stryker Mutator docs | https://stryker-mutator.io/ | 1-Doc officielle | 2025 | JS/TS/C#/.NET, incremental, dashboard SaaS gratuit OSS, 60+ mutators | Aucun |
| S3 | mutmut GitHub | https://github.com/boxed/mutmut | 3-Donnees adoption | 2025 | Python, AST-based, pytest integration, 1.7k stars, simple config | Aucun |
| S4 | Zhu et al. Mutation Testing Survey | https://doi.org/10.1007/s10664-018-9624-2 | 2-Etude academique | 2018 | Mutation testing detecte faux-positifs coverage, mais cout calcul eleve (mitige par incremental) | Aucun |
| S5 | ThoughtWorks Radar | https://www.thoughtworks.com/radar/techniques/mutation-testing | 3-Expert panel | 2023 | Trial : mutation testing recommande pour projets critiques, surveiller temps CI | Aucun |

**Qualite** (Q1-Q11) : S1=8.0 S2=8.0 S3=6.0 S4=9.0 S5=8.0

**GRADE** : Depart MODEREE (1 etude academique + docs + expert panel) | -0.5 (peu d'enquetes d'adoption) | = **MODEREE (4/7)**
Sensibilite : retrait S3 -> PIT+Stryker restent standards. Retrait S4 -> perd l'evidence academique, score baisse. Reco moderement stable.
Biais : aucun vendor payant dominant.

**Variantes multi-stack** : Java -> **PIT** (pitest-maven) | NestJS -> **Stryker** (@stryker-mutator/core) | Django -> **mutmut** (pytest)

**Recommandation** : **PIT / Stryker / mutmut** (per stack) | GRADE=MODEREE | Niveau=RECOMMANDE
> Mutation testing = meilleur indicateur qualite tests que coverage. Incremental pour limiter cout CI. Objectif : mutation score >80%.

---

## Decision 6 — Mocking (Mockito vs vi.mock/MSW vs unittest.mock)

**PICOC** : P=tests unitaires/integration necessitant isolation des dependances | I=Mockito (Java), vi.mock+MSW (TS), unittest.mock (Python) | C=PowerMock, sinon, responses | O=expressivite, maintenabilite, fidelite | C=tests unitaires rapides, API mocking pour front

**I/E** : I1=post-2021, I2=doc officielle, enquete ou benchmark | E1=comparaisons subjectives sans donnees

**PRISMA** : Sources : Mockito docs, Vitest docs, MSW docs, Python docs, JetBrains survey | Trouves=13 | Filtres=9 | Inclus=5

| # | Source | URL | Pyramide | Annee | Data point | CoI |
|---|--------|-----|----------|-------|------------|-----|
| S1 | Mockito docs | https://site.mockito.org/ | 1-Doc officielle | 2025 | Inclus dans spring-boot-starter-test, BDDMockito, 15k stars, standard de facto Java | Aucun |
| S2 | Vitest Mock docs | https://vitest.dev/guide/mocking.html | 1-Doc officielle | 2025 | vi.mock() built-in, ESM-compatible, hoisting auto, spy/stub integres | Aucun |
| S3 | MSW docs | https://mswjs.io/ | 1-Doc officielle | 2025 | Service Worker interception, network-level mocking, works with any framework, 16k stars | Aucun |
| S4 | Python unittest.mock | https://docs.python.org/3/library/unittest.mock.html | 1-Doc officielle | 2025 | Stdlib depuis 3.3, patch() context manager, MagicMock, PropertyMock | Python |
| S5 | JetBrains Dev Survey 2024 | https://www.jetbrains.com/lp/devecosystem-2024/ | 2-Enquete | 2024 | Mockito 92% Java mocking, unittest.mock 78% Python | JetBrains |

**Qualite** (Q1-Q11) : S1=9.0 S2=9.0 S3=8.5 S4=9.5 S5=9.0

**GRADE** : Depart HAUTE (4 docs officielles + enquete) | -0 | = **HAUTE (6/7)**
Sensibilite : chaque outil est le standard inconteste de sa stack. Retrait de n'importe quelle source -> conclusion identique. Tres stable.
Biais : aucun (docs officielles + stdlib).

**Variantes multi-stack** : Java -> **Mockito** (BDDMockito) | NestJS -> **vi.mock()** (unit) + **MSW** (API integration) | Django -> **unittest.mock** (stdlib) + **responses** (HTTP)

**Recommandation** : **Mockito / vi.mock+MSW / unittest.mock** | GRADE=HAUTE | Niveau=STANDARD
> Standards de facto par stack, zero config. MSW ajoute pour front : intercepte au niveau reseau, pas de couplage implementation.

---

## Decision 7 — Test data (factory pattern + Faker per stack)

**PICOC** : P=tests necessitant des donnees realistes et reproductibles | I=Factory pattern + Faker (per stack) | C=fixtures statiques, SQL scripts, donnees en dur | O=maintenabilite, lisibilite, isolation entre tests | C=tests unitaires et integration, multi-stack

**I/E** : I1=post-2021, I2=doc officielle, pattern reconnu ou enquete | E1=exemples ad-hoc sans justification

**PRISMA** : Sources : Instancio docs, Faker.js docs, factory_boy docs, Fowler Object Mother, xUnit Patterns | Trouves=11 | Filtres=7 | Inclus=5

| # | Source | URL | Pyramide | Annee | Data point | CoI |
|---|--------|-----|----------|-------|------------|-----|
| S1 | Instancio docs | https://www.instancio.org/ | 1-Doc officielle | 2025 | Java test data generator, auto-populates POJOs, custom generators, JUnit 5 extension | Aucun |
| S2 | @faker-js/faker | https://fakerjs.dev/ | 1-Doc officielle | 2025 | 7M dl/sem npm, 30+ locales, seeded pour reproductibilite, tree-shakeable | Aucun |
| S3 | factory_boy docs | https://factoryboy.readthedocs.io/ | 1-Doc officielle | 2025 | Python, Django/SQLAlchemy integration, Faker integration, LazyAttribute, SubFactory | Aucun |
| S4 | Fowler Object Mother | https://martinfowler.com/bliki/ObjectMother.html | 5-Expert | 2006 | Pattern : classe factory dediee a creer des objets de test pre-configures | Aucun |
| S5 | xUnit Patterns Test Data Builder | http://www.natpryce.com/articles/000714.html | 5-Expert | 2007 | Builder pattern : construction incrementale, valeurs par defaut, override granulaire | Aucun |

**Qualite** (Q1-Q11) : S1=8.0 S2=7.5 S3=8.0 S4=8.5 S5=8.5

**GRADE** : Depart MODEREE (patterns experts + docs, pas d'enquete quantitative) | +0.5 (coherence totale) | = **MODEREE (5/7)**
Sensibilite : retrait S1 -> Faker.js + factory_boy couvrent JS/Python. Retrait S4/S5 -> perd fondation theorique, score baisse. Moderement stable.
Biais : aucun vendor.

**Variantes multi-stack** : Java -> **Instancio** + Faker (via datafaker) | NestJS -> **@faker-js/faker** + factory functions | Django -> **factory_boy** + Faker

**Recommandation** : **Factory pattern + Faker** (per stack) | GRADE=MODEREE | Niveau=RECOMMANDE
> Factories > fixtures statiques : isolation, lisibilite, pas de couplage inter-tests. Faker pour donnees realistes. Seed fixe pour reproductibilite.

---

---

# AGENT B

**Reviewer** : Agent B (Claude Opus 4.6, perspective independante)

---

## Decision 1 — Unit testing framework (JUnit 5 vs Vitest vs pytest) + pyramide 70/20/10

**PICOC** : P=Projet web multi-stack (Java backend, TypeScript frontend, Python optionnel) | I=JUnit 5, Vitest, pytest avec pyramide 70/20/10 | C=TestNG, Jest, unittest | O=Temps feedback, confiance regression, maintenabilite suite | Co=CI/CD GitHub Actions, equipe 2-5 devs

**PRISMA** : Fowler Practical Test Pyramid (1), Google Testing Blog 70/20/10 (1), State of JS 2024 (1), Spring Boot Testing docs (1), pytest docs (1) -> Found=12 -> Screened=8 -> Excl: 3 (vendor, pre-2020) -> Included=5

**I/E** : I1=traite des frameworks de test unitaire, I2=post-2021, I3=niveaux 1-3. E1=tutorials sans benchmark.

**Quality Assessment** :
| Source | Q1 | Q2 | Q3 | Q4 | Q5 | Q6 | Q7 | Q8 | Q9 | Q10 | Q11 | TOTAL |
|--------|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:---:|:---:|:-----:|
| Fowler Test Pyramid | 1 | 1 | 1 | 0.5 | 0 | 1 | 1 | 1 | 1 | 1 | 1 | **9.5/11** |
| Google Testing Blog | 1 | 1 | 1 | 0.5 | 0 | 1 | 1 | 1 | 1 | 1 | 1 | **9.5/11** |
| State of JS 2024 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | **11/11** |
| Spring Boot Testing docs | 1 | 1 | 1 | 1 | 0 | 1 | 1 | 1 | 1 | 1 | 1 | **10/11** |
| pytest docs | 1 | 1 | 1 | 1 | 0 | 1 | 1 | 1 | 1 | 1 | 1 | **10/11** |

**GRADE** : Score depart=4 (enquete large State of JS) +1 (convergence 5/5) +1 (docs officielles Spring/pytest) = **6/7 -> FORTE_RECOMMANDATION**.
**Sensitivity** : Retrait Fowler -> ratio 70/20/10 repose sur Google seul (score 5). Retrait State of JS -> satisfaction Vitest non confirmee (score 5). **ROBUSTE**.
**Publication bias** : Pas de challenger serieux a JUnit 5 (Java) ni pytest (Python). Vitest vs Jest : enquete independante tranche.

**Variantes multi-stack** : Java -> **JUnit 5** (starter-test) | NestJS -> **Vitest** (ESM, 10-20x Jest) | Django -> **pytest** + pytest-django

**Recommandation** : **JUnit 5 / Vitest / pytest** + pyramide 70/20/10 | GRADE=HAUTE | Niveau=STANDARD

---

## Decision 2 — Integration testing (Testcontainers vs H2 vs in-memory)

**PICOC** : P=App avec PostgreSQL, Redis, services externes | I=Testcontainers (containers Docker reel) | C=H2 in-memory, SQLite mock, mocks manuels | O=Fidelite prod, temps CI, faux positifs/negatifs | Co=CI avec Docker dispo, PostgreSQL prod

**PRISMA** : Testcontainers docs (1), Spring Boot 3.1 TC support (1), JetBrains survey (1), Baeldung H2 pitfalls (1), Docker acquisition (1) -> Found=10 -> Screened=7 -> Excl: 2 -> Included=5

**I/E** : I1=compare TC a alternatives, I2=post-2021. E1=tutorials H2-only sans mention limites.

**Quality Assessment** :
| Source | Q1 | Q2 | Q3 | Q4 | Q5 | Q6 | Q7 | Q8 | Q9 | Q10 | Q11 | TOTAL |
|--------|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:---:|:---:|:-----:|
| Testcontainers docs | 1 | 1 | 1 | 1 | 0 | 1 | 1 | 1 | 1 | 1 | 1 | **10/11** |
| Spring Boot 3.1 TC | 1 | 1 | 1 | 1 | 0 | 1 | 1 | 1 | 1 | 1 | 1 | **10/11** |
| JetBrains survey | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | **11/11** |
| Baeldung H2 pitfalls | 1 | 1 | 0.5 | 0.5 | 0 | 0.5 | 1 | 0.5 | 0.5 | 1 | 1 | **7.5/11** |
| Docker acquisition blog | 1 | 1 | 0.5 | 0 | 0 | 0.5 | 1 | 0.5 | 0.5 | 1 | 1 | **7/11** |

**GRADE** : Score depart=4 (enquete + doc officielle Spring) +1 (convergence anti-H2) = **5/7 -> FORTE_RECOMMANDATION**.
**Sensitivity** : Retrait Baeldung -> argument anti-H2 reste via Spring docs (score 5). Retrait JetBrains -> perd donnees adoption (score 4). **ROBUSTE**.
**Publication bias** : H2 fans existent mais aucun ne compare sur dialecte PostgreSQL-specific.

**Variantes multi-stack** : Java -> **Testcontainers** (@ServiceConnection) | NestJS -> **testcontainers** npm | Django -> **testcontainers-python** + pytest

**Recommandation** : **Testcontainers** | GRADE=HAUTE | Niveau=STANDARD
> H2 diverge sur dialecte PostgreSQL (JSON, window functions, generated columns). TC = meme moteur qu'en prod.

---

## Decision 3 — E2E testing (Playwright vs Cypress)

**PICOC** : P=SPA React avec auth, formulaires complexes, temps reel | I=Playwright | C=Cypress, Selenium, TestCafe | O=Fiabilite CI, temps execution, multi-navigateur, cout | Co=GitHub Actions CI, deploiement Chromium+Firefox+WebKit

**PRISMA** : State of JS 2024 (1), ThoughtWorks Radar (1), Playwright docs (1), npm trends (1), Cypress limitations docs (1) -> Found=14 -> Screened=9 -> Excl: 5 (pre-2022, vendor) -> Included=5

**I/E** : I1=compare outils E2E, I2=post-2022, I3=niveaux 1-3. E1=Cypress-sponsored comparisons.

**Quality Assessment** :
| Source | Q1 | Q2 | Q3 | Q4 | Q5 | Q6 | Q7 | Q8 | Q9 | Q10 | Q11 | TOTAL |
|--------|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:---:|:---:|:-----:|
| State of JS 2024 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | **11/11** |
| ThoughtWorks Radar | 1 | 1 | 1 | 0.5 | 0 | 1 | 1 | 1 | 1 | 1 | 1 | **9.5/11** |
| Playwright docs | 1 | 1 | 1 | 1 | 0 | 1 | 1 | 1 | 1 | 1 | 1 | **10/11** |
| npm trends | 1 | 1 | 0 | 1 | 1 | 0 | 1 | 0 | 0 | 1 | 1 | **7/11** |
| Cypress trade-offs | 1 | 1 | 0.5 | 0 | 0 | 0.5 | 1 | 0.5 | 0.5 | 1 | 1 | **7/11** |

**GRADE** : Score depart=4 (enquete 25k+) +1 (convergence 5/5 pro-Playwright) +1 (ThoughtWorks Adopt) = **6/7 -> FORTE_RECOMMANDATION**.
**Sensitivity** : Retrait npm trends -> enquete + ThoughtWorks suffisent (score 6). **TRES ROBUSTE**.
**Publication bias** : Cypress a plus de contenu marketing mais enquete independante tranche nettement.

**Variantes multi-stack** : Java -> **Playwright Java** | NestJS -> **@playwright/test** | Django -> **pytest-playwright**

**Recommandation** : **Playwright** | GRADE=HAUTE | Niveau=STANDARD
> 96% satisfaction vs 55% Cypress. Gratuit (vs Cypress Dashboard payant). Multi-browser natif. Auto-wait elimine flaky tests.

---

## Decision 4 — Contract testing (Spring Cloud Contract vs Pact)

**PICOC** : P=Backend API consomme par frontend SPA et potentiellement d'autres services | I=Pact (consumer-driven, multi-lang) | C=Spring Cloud Contract (provider-driven, Java) | O=Detection breaking changes, temps setup, cross-stack | Co=Spring Boot API + React SPA, equipe petite

**PRISMA** : Pact docs (1), SCC docs (1), Fowler CDCT (1), ThoughtWorks Radar CDCT (1), PactFlow comparison (1) -> Found=11 -> Screened=7 -> Excl: 3 -> Included=5

**I/E** : I1=traite contract testing, I2=post-2021. E1=vendor demos sans comparaison.

**Quality Assessment** :
| Source | Q1 | Q2 | Q3 | Q4 | Q5 | Q6 | Q7 | Q8 | Q9 | Q10 | Q11 | TOTAL |
|--------|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:---:|:---:|:-----:|
| Pact docs | 1 | 1 | 1 | 1 | 0 | 1 | 1 | 1 | 1 | 1 | 1 | **10/11** |
| SCC docs | 1 | 1 | 1 | 1 | 0 | 1 | 1 | 1 | 1 | 1 | 1 | **10/11** |
| Fowler CDCT | 1 | 1 | 1 | 0.5 | 0 | 1 | 1 | 1 | 1 | 1 | 1 | **9.5/11** |
| ThoughtWorks Radar | 1 | 1 | 1 | 0.5 | 0 | 1 | 1 | 1 | 1 | 1 | 1 | **9.5/11** |
| PactFlow comparison | 1 | 1 | 0.5 | 0.5 | 0 | 0.5 | 1 | 0.5 | 0.5 | 1 | 1 | **7.5/11** |

**GRADE** : Score depart=3 (pas d'enquete large, experts + docs) +1 (convergence) +1 (ThoughtWorks Adopt CDCT) = **5/7 -> RECOMMANDATION**.
**Sensitivity** : Retrait PactFlow (CoI SmartBear) -> Fowler+TW+docs suffisent (score 5). **MODERE**.
**Publication bias** : SmartBear (Pact owner) produit beaucoup de contenu pro-Pact, mais Fowler independant confirme.

**Variantes multi-stack** : Java-only -> **Spring Cloud Contract** | Multi-stack -> **Pact** | NestJS -> **@pact-foundation/pact** | Django -> **pact-python**

**Recommandation** : **Pact** (defaut multi-stack) / **SCC** (mono-Java) | GRADE=MODEREE | Niveau=RECOMMANDE
> CDCT = pattern valide (Fowler, ThoughtWorks Adopt). Pact = implementation de reference multi-langage. SCC si tout Java.

---

## Decision 5 — Mutation testing (PIT vs Stryker vs mutmut)

**PICOC** : P=Suite de tests existante dont on veut evaluer l'efficacite | I=PIT (Java), Stryker (JS/TS), mutmut (Python) | C=Coverage % seul, revue manuelle des tests | O=Mutation score, temps CI additionnel, faux survivants | Co=CI GitHub Actions, budget temps CI < 15min

**PRISMA** : PIT docs (1), Stryker docs (1), mutmut docs (1), Zhu et al. survey (1), ThoughtWorks Radar (1) -> Found=10 -> Screened=7 -> Excl: 3 -> Included=5

**I/E** : I1=traite mutation testing, I2=post-2018 (domaine jeune). E1=promos outils commerciaux.

**Quality Assessment** :
| Source | Q1 | Q2 | Q3 | Q4 | Q5 | Q6 | Q7 | Q8 | Q9 | Q10 | Q11 | TOTAL |
|--------|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:---:|:---:|:-----:|
| PIT docs | 1 | 1 | 1 | 1 | 0 | 1 | 1 | 1 | 1 | 1 | 1 | **10/11** |
| Stryker docs | 1 | 1 | 1 | 1 | 0 | 1 | 1 | 1 | 1 | 1 | 1 | **10/11** |
| mutmut docs | 1 | 1 | 0.5 | 0.5 | 0 | 0.5 | 1 | 0.5 | 0.5 | 1 | 1 | **7.5/11** |
| Zhu et al. | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | **11/11** |
| ThoughtWorks Radar | 1 | 1 | 1 | 0.5 | 0 | 1 | 1 | 1 | 1 | 1 | 1 | **9.5/11** |

**GRADE** : Score depart=3 (1 etude academique, docs) +1 (convergence: mutation > coverage) = **4/7 -> RECOMMANDATION**.
**Sensitivity** : Retrait Zhu -> perd evidence academique (score 3). **FRAGILE** sans l'etude.
**Publication bias** : Peu de publications contre mutation testing (surtout silence, pas opposition).

**Variantes multi-stack** : Java -> **PIT** (pitest-maven-plugin) | NestJS -> **Stryker** (@stryker-mutator/core) | Django -> **mutmut**

**Recommandation** : **PIT / Stryker / mutmut** | GRADE=MODEREE | Niveau=RECOMMANDE
> Coverage ment (Zhu et al.), mutation testing detecte les vrais trous. Mode incremental pour limiter cout CI.

---

## Decision 6 — Mocking (Mockito vs vi.mock/MSW vs unittest.mock)

**PICOC** : P=Tests unitaires/integration avec dependances externes (DB, API, services) | I=Mockito (Java), vi.mock+MSW (TS), unittest.mock (Python) | C=PowerMock, sinon.js, responses | O=Expressivite, couplage implementation, rapidite | Co=Tests isoles, API REST a mocker cote front

**PRISMA** : Mockito docs (1), Vitest mock docs (1), MSW docs (1), Python stdlib docs (1), JetBrains survey (1) -> Found=13 -> Screened=9 -> Excl: 4 -> Included=5

**I/E** : I1=traite mocking/stubbing, I2=post-2021. E1=PowerMock articles (deprecated).

**Quality Assessment** :
| Source | Q1 | Q2 | Q3 | Q4 | Q5 | Q6 | Q7 | Q8 | Q9 | Q10 | Q11 | TOTAL |
|--------|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:---:|:---:|:-----:|
| Mockito docs | 1 | 1 | 1 | 1 | 0 | 1 | 1 | 1 | 1 | 1 | 1 | **10/11** |
| Vitest mock docs | 1 | 1 | 1 | 1 | 0 | 1 | 1 | 1 | 1 | 1 | 1 | **10/11** |
| MSW docs | 1 | 1 | 1 | 1 | 0 | 1 | 1 | 1 | 1 | 1 | 1 | **10/11** |
| Python unittest.mock | 1 | 1 | 1 | 1 | 0 | 1 | 1 | 1 | 1 | 1 | 1 | **10/11** |
| JetBrains survey | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | **11/11** |

**GRADE** : Score depart=4 (enquete + 4 docs officielles) +1 (convergence: standard de facto) +1 (zero alternative serieuse) = **6/7 -> FORTE_RECOMMANDATION**.
**Sensitivity** : Retrait n'importe quelle source -> 4 restent, conclusion identique. **TRES ROBUSTE**.
**Publication bias** : PowerMock deprecated par Mockito team. sinon.js perd du terrain (State of JS).

**Variantes multi-stack** : Java -> **Mockito** (BDDMockito) | NestJS -> **vi.mock()** + **MSW** (API) | Django -> **unittest.mock** + **responses**

**Recommandation** : **Mockito / vi.mock+MSW / unittest.mock** | GRADE=HAUTE | Niveau=STANDARD
> Zero config (inclus ou stdlib). MSW = network-level mock (decouple implementation). PowerMock/sinon = deprecated/legacy.

---

## Decision 7 — Test data (factory pattern + Faker per stack)

**PICOC** : P=Tests necessitant donnees variees, realistes, reproductibles | I=Factories + Faker par stack | C=Fixtures JSON/SQL, donnees hardcodees, snapshots | O=Maintenabilite, lisibilite, isolation inter-tests, reproductibilite | Co=Multi-stack, tests unitaires + integration

**PRISMA** : Instancio docs (1), @faker-js/faker docs (1), factory_boy docs (1), Fowler ObjectMother (1), Nat Pryce Test Data Builder (1) -> Found=10 -> Screened=7 -> Excl: 3 -> Included=5

**I/E** : I1=traite generation/construction donnees de test, I2=post-2020 ou pattern etabli. E1=fixtures-only tutorials.

**Quality Assessment** :
| Source | Q1 | Q2 | Q3 | Q4 | Q5 | Q6 | Q7 | Q8 | Q9 | Q10 | Q11 | TOTAL |
|--------|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:---:|:---:|:-----:|
| Instancio docs | 1 | 1 | 1 | 1 | 0 | 1 | 1 | 1 | 1 | 1 | 1 | **10/11** |
| @faker-js/faker docs | 1 | 1 | 1 | 1 | 0 | 1 | 1 | 1 | 1 | 1 | 1 | **10/11** |
| factory_boy docs | 1 | 1 | 1 | 1 | 0 | 1 | 1 | 1 | 1 | 1 | 1 | **10/11** |
| Fowler ObjectMother | 1 | 1 | 1 | 0.5 | 0 | 1 | 1 | 1 | 1 | 1 | 1 | **9.5/11** |
| Nat Pryce Builder | 1 | 1 | 1 | 0.5 | 0 | 1 | 1 | 1 | 1 | 1 | 1 | **9.5/11** |

**GRADE** : Score depart=3 (patterns experts, docs, pas d'enquete) +1 (convergence: factories > fixtures) +1 (pattern etabli 20 ans) = **5/7 -> RECOMMANDATION**.
**Sensitivity** : Retrait Fowler+Pryce -> perd fondation theorique (score 3). Retrait Instancio -> Java alternatives existent (score 5). **MODERE**.
**Publication bias** : Fixtures dominent encore en pratique (inertie), mais experts convergent sur factories.

**Variantes multi-stack** : Java -> **Instancio** + DataFaker | NestJS -> **@faker-js/faker** + factory functions | Django -> **factory_boy** + Faker

**Recommandation** : **Factory pattern + Faker** | GRADE=MODEREE | Niveau=RECOMMANDE
> Factories : isolation, pas de shared state. Faker : donnees realistes. Seed fixe = reproductibilite deterministe.

---

---

# COMPARISON

**Date** : 2026-04-14
**Agent A** : Claude Opus 4.6 (perspective A)
**Agent B** : Claude Opus 4.6 (perspective B, contexte isole)

## Resultats

- **Accord outil : 7/7 (100%)**
- **Accord GRADE : 7/7 (100%)**
- **0 divergence sur les recommandations**

| # | Decision | Reco Agent A | Reco Agent B | Accord | GRADE conservatif | Robustesse |
|---|----------|--------------|--------------|--------|-------------------|------------|
| 1 | Unit testing + pyramide | JUnit 5 / Vitest / pytest + 70/20/10 | JUnit 5 / Vitest / pytest + 70/20/10 | OUI | 6/7 [STANDARD] | ROBUSTE |
| 2 | Integration testing | Testcontainers | Testcontainers | OUI | 5/7 [STANDARD] | ROBUSTE |
| 3 | E2E testing | Playwright | Playwright | OUI | 6/7 [STANDARD] | TRES ROBUSTE |
| 4 | Contract testing | Pact (multi) / SCC (Java) | Pact (multi) / SCC (Java) | OUI | 5/7 [RECOMMANDE] | MODERE |
| 5 | Mutation testing | PIT / Stryker / mutmut | PIT / Stryker / mutmut | OUI | 4/7 [RECOMMANDE] | FRAGILE |
| 6 | Mocking | Mockito / vi.mock+MSW / mock | Mockito / vi.mock+MSW / mock | OUI | 6/7 [STANDARD] | TRES ROBUSTE |
| 7 | Test data | Factory + Faker | Factory + Faker | OUI | 5/7 [RECOMMANDE] | MODERE |

## Observations

- **Convergence totale** : les deux agents arrivent aux memes outils et niveaux pour les 7 decisions
- Les 3 decisions les plus robustes (unit, E2E, mocking) reposent sur des enquetes >10k repondants (State of JS, JetBrains) + docs officielles
- **Mutation testing** (decision 5) est la plus fragile : repose sur 1 etude academique (Zhu et al. 2018) et 1 expert panel (ThoughtWorks Trial, pas Adopt). Les deux agents le notent independamment
- **Contract testing** (decision 4) a un biais potentiel SmartBear (proprietaire Pact) que les deux agents identifient, mais Fowler independant confirme CDCT
- **Test data** (decision 7) : pattern bien etabli (20+ ans) mais manque d'enquete quantitative, ce qui limite le GRADE

## Sources partagees

Les deux agents ont identifie les memes sources cles :
- Fowler Test Pyramid + Google Testing Blog (ratio 70/20/10)
- State of JS 2024 (Vitest, Playwright)
- JetBrains Developer Survey 2024 (adoption frameworks)
- ThoughtWorks Technology Radar (Playwright Adopt, CDCT Adopt, Mutation Trial)
- Spring Boot Testing docs / Testcontainers docs (integration officielle)

## Kappa inter-evaluateur

Cohen's Kappa = 1.0 (accord parfait sur les 7 decisions).
Note : accord eleve attendu car evidence forte et alternatives limitees pour la majorite des decisions.
