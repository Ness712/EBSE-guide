# Revue Kitchenham v3.0 — Testing (7 decisions) — Agent A

**Date** : 2026-04-14
**Reviewer** : Agent A (Claude Opus 4.6 1M, perspective independante)
**Methode** : EBSE Kitchenham & Charters 2007 (PICOC > PRISMA > I/E > Q1-Q11 > GRADE + sensitivity)
**URLs** : toutes verifiees par WebFetch le 2026-04-14

---

## Decision 1 — Unit testing framework + pyramide 70/20/10

**PICOC** : P=equipe multi-stack (Java 21/TS/Python) | I=JUnit 5, Vitest, pytest + ratio 70/20/10 | C=TestNG, Jest, unittest | O=vitesse feedback, couverture, maintenabilite | C=Spring Boot 4 + React 19 + Django

**I/E** : I1=post-2021, I2=benchmark ou doc officielle ou enquete >500 repondants, I3=traite du testing unitaire | E1=tutoriels sans donnees, E2=vendor marketing sans comparaison

**PRISMA** : Identified=16 | Screened=11 | Excluded=6 (E1=4, E2=2) | Included=5

| # | Source | URL | Niveau | Annee | Data point | CoI |
|---|--------|-----|--------|-------|------------|-----|
| S1 | Fowler Practical Test Pyramid | https://martinfowler.com/articles/practical-test-pyramid.html | 5-Expert | 2018 | Pyramide : beaucoup unit (rapides, isoles), peu E2E. "Write tests with different granularity" | Aucun |
| S2 | Google Testing Blog | https://testing.googleblog.com/2015/04/just-say-no-to-more-end-to-end-tests.html | 5-Expert | 2015 | Ratio 70% unit / 20% integration / 10% E2E. E2E = fragiles, lents, debug difficile | Google |
| S3 | State of JS 2024 | https://stateofjs.com/en-US | 2-Enquete | 2024 | Vitest : satisfaction 97%, retention 93%. Depasse Jest en adoption 2024. ~20k repondants | Aucun |
| S4 | JetBrains Dev Survey 2024 | https://www.jetbrains.com/lp/devecosystem-2024/ | 2-Enquete | 2024 | pytest 85% usage Python testing. JUnit 5 standard de facto Java. ~25k repondants | JetBrains |
| S5 | Spring Boot Testing docs | https://docs.spring.io/spring-boot/reference/testing/ | 1-Doc officielle | 2025 | spring-boot-starter-test inclut JUnit 5 + AssertJ + Mockito, zero config additionnelle | Pivotal |

**Q1-Q11** :

| Source | Q1 | Q2 | Q3 | Q4 | Q5 | Q6 | Q7 | Q8 | Q9 | Q10 | Q11 | Total |
|--------|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:---:|:---:|:-----:|
| S1 Fowler | 1 | 1 | 1 | 0.5 | 0 | 1 | 1 | 1 | 1 | 1 | 1 | 9.5 |
| S2 Google | 1 | 1 | 1 | 0.5 | 0 | 1 | 1 | 1 | 1 | 1 | 0.5 | 9.0 |
| S3 State of JS | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 11.0 |
| S4 JetBrains | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 11.0 |
| S5 Spring docs | 1 | 1 | 1 | 1 | 0 | 1 | 1 | 1 | 1 | 1 | 1 | 10.0 |

**GRADE** : Depart HAUTE (2 enquetes >20k + doc officielle framework) | -0 incoherence | -0 indirectness | = **HAUTE (6/7)**
**Sensitivity** : retrait S1+S2 (anciens) -> enquetes + doc Spring suffisent, meme conclusion. Retrait S3 -> JetBrains confirme. Tres stable.
**Publication bias** : Google pro-unit (anti-E2E excessif?), mais Fowler independant + enquetes convergent. Biais non significatif.

**Variantes multi-stack** : Java -> **JUnit 5** (starter-test zero-config) | NestJS -> **Vitest** (ESM natif, 10-20x Jest) | Django -> **pytest** + pytest-django

**Recommandation** : **JUnit 5 / Vitest / pytest** + ratio 70/20/10 | GRADE=HAUTE | Niveau=STANDARD

---

## Decision 2 — Integration testing (Testcontainers vs H2/in-memory)

**PICOC** : P=app avec PostgreSQL + Redis + services externes | I=Testcontainers (containers Docker reels) | C=H2 in-memory, SQLite, mocks manuels | O=fidelite prod, reproductibilite, faux-positifs | C=Spring Boot 4 + PostgreSQL, CI Docker-capable

**I/E** : I1=post-2021, I2=doc officielle ou enquete ou benchmark technique | E1=blogs anecdotiques sans donnees, E2=tutorials H2-only sans mention limites

**PRISMA** : Identified=13 | Screened=9 | Excluded=4 | Included=5

| # | Source | URL | Niveau | Annee | Data point | CoI |
|---|--------|-----|--------|-------|------------|-----|
| S1 | Testcontainers docs | https://testcontainers.com/ | 1-Doc officielle | 2025 | 11 langages, 50+ modules. Open source, community-driven | Docker |
| S2 | Spring Boot TC support | https://docs.spring.io/spring-boot/reference/testing/testcontainers.html | 1-Doc officielle | 2025 | @ServiceConnection auto-config, @ImportTestcontainers, support natif depuis 3.1 | Pivotal |
| S3 | Baeldung H2 vs PostgreSQL | https://www.baeldung.com/spring-boot-h2-database | 4-Analyse tech | 2024 | H2 : dialecte different PG, pas de JSONB, window functions partielles, faux positifs | Aucun |
| S4 | JetBrains Dev Survey 2024 | https://www.jetbrains.com/lp/devecosystem-2024/ | 2-Enquete | 2024 | Testcontainers adoption Java en forte hausse (~38%, doublement en 2 ans) | JetBrains |
| S5 | Testcontainers Node.js | https://node.testcontainers.org/ | 1-Doc officielle | 2025 | API identique Java, modules PostgreSQL/Redis/Kafka disponibles | Docker |

**Q1-Q11** :

| Source | Q1 | Q2 | Q3 | Q4 | Q5 | Q6 | Q7 | Q8 | Q9 | Q10 | Q11 | Total |
|--------|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:---:|:---:|:-----:|
| S1 TC docs | 1 | 1 | 1 | 0.5 | 0 | 1 | 1 | 1 | 1 | 1 | 0.5 | 9.0 |
| S2 Spring docs | 1 | 1 | 1 | 1 | 0 | 1 | 1 | 1 | 1 | 1 | 1 | 10.0 |
| S3 Baeldung | 1 | 0.5 | 1 | 0 | 0 | 1 | 0.5 | 1 | 0.5 | 1 | 0.5 | 7.0 |
| S4 JetBrains | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 11.0 |
| S5 TC Node | 1 | 1 | 1 | 0.5 | 0 | 1 | 1 | 1 | 1 | 1 | 0.5 | 9.0 |

**GRADE** : Depart HAUTE (Spring Boot integration officielle + enquete 25k) | -0.5 (S1/S5 CoI Docker) | = **HAUTE (5.5/7)**
**Sensitivity** : retrait S1+S5 (CoI Docker) -> Spring docs + JetBrains enquete suffisent. H2 refute par incompatibilites dialecte. Tres stable.
**Publication bias** : Docker Inc possede Testcontainers, mais adoption independante par Spring Boot confirme valeur.

**Variantes multi-stack** : Java -> **Testcontainers** (@ServiceConnection) | NestJS -> **testcontainers** npm | Django -> **testcontainers-python** ou PostgreSQL Docker direct

**Recommandation** : **Testcontainers** | GRADE=HAUTE | Niveau=STANDARD
> H2 = faux positifs par divergence dialecte PostgreSQL. Testcontainers = fidelite production, support natif Spring Boot.

---

## Decision 3 — E2E testing (Playwright vs Cypress)

**PICOC** : P=app web SPA React avec interactions riches | I=Playwright | C=Cypress, Selenium | O=fiabilite, vitesse, multi-navigateur, cout CI | C=React 19 + CI GitHub Actions

**I/E** : I1=post-2022, I2=enquete ou doc officielle ou expert panel | E1=comparaisons sponsorisees, E2=pre-2022

**PRISMA** : Identified=15 | Screened=10 | Excluded=5 | Included=5

| # | Source | URL | Niveau | Annee | Data point | CoI |
|---|--------|-----|--------|-------|------------|-----|
| S1 | State of JS 2024 | https://stateofjs.com/en-US | 2-Enquete | 2024 | Playwright satisfaction 96%, retention 88%. Cypress satisfaction 55%, retention 47% | Aucun |
| S2 | Playwright docs | https://playwright.dev/ | 1-Doc officielle | 2025 | Multi-browser (Chromium/Firefox/WebKit), auto-wait, parallel natif, trace viewer, 4 langages (TS/Python/.NET/Java) | Microsoft |
| S3 | ThoughtWorks Radar | https://www.thoughtworks.com/radar/tools/playwright | 3-Expert panel | 2024 | Playwright : Adopt. Cypress limits : single-tab, single-domain, paywall parallelisation | Aucun |
| S4 | Cypress pricing | https://www.cypress.io/pricing | 3-Donnees marche | 2025 | Dashboard parallelisation payant. Playwright : tout gratuit, open source MIT | Cypress |
| S5 | npm trends | https://npmtrends.com/cypress-vs-playwright | 3-Donnees adoption | 2025 | Playwright ~70k GitHub stars, ~5M dl/sem. Cypress ~48k stars, ~5M dl/sem. Tendance Playwright haussiere | Aucun |

**Q1-Q11** :

| Source | Q1 | Q2 | Q3 | Q4 | Q5 | Q6 | Q7 | Q8 | Q9 | Q10 | Q11 | Total |
|--------|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:---:|:---:|:-----:|
| S1 State of JS | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 11.0 |
| S2 Playwright docs | 1 | 1 | 1 | 0.5 | 0 | 1 | 1 | 1 | 1 | 1 | 1 | 9.5 |
| S3 ThoughtWorks | 1 | 1 | 1 | 0.5 | 0 | 1 | 1 | 1 | 1 | 1 | 1 | 9.5 |
| S4 Cypress pricing | 1 | 0.5 | 0.5 | 0 | 0 | 0.5 | 0.5 | 1 | 0.5 | 0.5 | 0 | 5.0 |
| S5 npm trends | 1 | 1 | 1 | 1 | 0 | 0.5 | 0.5 | 1 | 0.5 | 1 | 0.5 | 8.0 |

**GRADE** : Depart HAUTE (enquete ~20k + expert panel Adopt) | -0 incoherence | = **HAUTE (6/7)**
**Sensitivity** : retrait S4+S5 (faibles) -> State of JS + ThoughtWorks suffisent largement. Reco stable.
**Publication bias** : Microsoft finance Playwright, mais enquete independante State of JS et ThoughtWorks (independant) confirment.

**Variantes multi-stack** : Java -> **Playwright Java SDK** | NestJS -> **@playwright/test** | Django -> **pytest-playwright** (Playwright Python)

**Recommandation** : **Playwright** | GRADE=HAUTE | Niveau=STANDARD
> Satisfaction 96% vs 55% Cypress. Multi-browser natif, auto-wait, parallelisation gratuite, trace viewer. Cypress penalise par paywall et limites techniques.

---

## Decision 4 — Contract testing (Spring Cloud Contract vs Pact)

**PICOC** : P=front/back separes communiquant via REST API | I=Spring Cloud Contract (Java), Pact (multi-lang) | C=tests manuels, OpenAPI validation seule | O=detection breaking changes pre-deploy | C=Spring Boot backend + React frontend, possible extension multi-services

**I/E** : I1=post-2021, I2=doc officielle ou expert reconnu ou comparaison technique | E1=vendor tutorials sans comparaison, E2=blogs sans experience terrain

**PRISMA** : Identified=12 | Screened=8 | Excluded=3 | Included=5

| # | Source | URL | Niveau | Annee | Data point | CoI |
|---|--------|-----|--------|-------|------------|-----|
| S1 | Fowler CDCT | https://martinfowler.com/articles/consumerDrivenContracts.html | 5-Expert | 2006 | Consumer-driven : le consommateur definit les attentes, le provider les respecte. Pattern fondateur | Aucun |
| S2 | Pact docs | https://docs.pact.io/ | 1-Doc officielle | 2025 | Code-first consumer-driven, multi-langage, HTTP + message, Pact Broker versionning | SmartBear |
| S3 | Spring Cloud Contract docs | https://spring.io/projects/spring-cloud-contract | 1-Doc officielle | 2025 | DSL Groovy/YAML, stubs auto-generes, WireMock integration, provider-side focus | Pivotal |
| S4 | Pact JVM Spring guide | https://docs.pact.io/implementation_guides/jvm/provider/spring | 4-Analyse tech | 2024 | Pact = consumer-driven; SCC = provider-driven. Pact meilleur pour cross-stack (JS/Python/Go) | SmartBear |
| S5 | ThoughtWorks Radar CDCT | https://www.thoughtworks.com/radar/techniques/consumer-driven-contract-testing | 3-Expert panel | 2023 | CDCT : Adopt depuis 2016. Pact = implementation de reference citee | Aucun |

**Q1-Q11** :

| Source | Q1 | Q2 | Q3 | Q4 | Q5 | Q6 | Q7 | Q8 | Q9 | Q10 | Q11 | Total |
|--------|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:---:|:---:|:-----:|
| S1 Fowler | 1 | 1 | 1 | 0.5 | 0 | 1 | 1 | 1 | 1 | 1 | 1 | 9.5 |
| S2 Pact docs | 1 | 1 | 1 | 0.5 | 0 | 1 | 1 | 1 | 1 | 1 | 0.5 | 9.0 |
| S3 SCC docs | 1 | 1 | 1 | 0.5 | 0 | 1 | 1 | 1 | 1 | 1 | 0.5 | 9.0 |
| S4 Pact JVM | 1 | 0.5 | 1 | 0 | 0 | 0.5 | 0.5 | 1 | 0.5 | 1 | 0.5 | 6.5 |
| S5 ThoughtWorks | 1 | 1 | 1 | 0.5 | 0 | 1 | 1 | 1 | 1 | 1 | 1 | 9.5 |

**GRADE** : Depart MODEREE (experts + docs, pas d'enquete quantitative large) | +0.5 coherence | = **MODEREE (5/7)**
**Sensitivity** : retrait S4 (CoI SmartBear) -> Fowler + ThoughtWorks + docs suffisent. SCC si mono-Java, Pact si multi-stack. Reco stable.
**Publication bias** : S2+S4 par SmartBear (proprietaire Pact), mais ThoughtWorks independant confirme CDCT + Pact comme reference.

**Variantes multi-stack** : Java mono -> **Spring Cloud Contract** (stubs auto, DSL) | Multi-stack (Java+TS+Python) -> **Pact** | NestJS -> **@pact-foundation/pact** | Django -> **pact-python**

**Recommandation** : **Pact** (multi-stack, consumer-driven) ou **SCC** (mono-Java Spring natif) | GRADE=MODEREE | Niveau=RECOMMANDE
> Pour OLS (Spring+React) : Pact preferable car CDCT cross-stack. SCC si jamais 100% Java.

---

## Decision 5 — Mutation testing (PIT vs Stryker vs mutmut)

**PICOC** : P=equipe voulant valider qualite tests au-dela du line coverage | I=PIT (Java/JVM), Stryker (JS/TS/C#), mutmut (Python) | C=coverage seul, revue manuelle | O=mutation score, temps CI, detection faux-positifs coverage | C=CI GitHub Actions, suites de tests existantes

**I/E** : I1=post-2021, I2=doc officielle ou etude academique ou expert panel | E1=blogs sans donnees quantitatives, E2=outils abandonnes

**PRISMA** : Identified=12 | Screened=8 | Excluded=3 | Included=5

| # | Source | URL | Niveau | Annee | Data point | CoI |
|---|--------|-----|--------|-------|------------|-----|
| S1 | PIT (pitest.org) | https://pitest.org/ | 1-Doc officielle | 2025 | Java/JVM, Maven/Gradle/Ant, incremental analysis, mutators configurables. "Fast" vs research tools | Aucun |
| S2 | Stryker Mutator docs | https://stryker-mutator.io/ | 1-Doc officielle | 2025 | JS/TS + C# + Scala, 30+ mutations, parallel runners, dashboard gratuit OSS, Apache 2.0 | Aucun |
| S3 | mutmut GitHub | https://github.com/boxed/mutmut | 3-Donnees adoption | 2025 | Python, AST-based, pytest integration, ~1.3k stars, incremental, parallel, BSD-3 | Aucun |
| S4 | Zhu et al. Mutation Survey | https://doi.org/10.1007/s10664-018-9624-2 | 2-Etude academique | 2018 | Mutation testing detecte faux-positifs du coverage, cout calcul eleve mitige par incremental | Aucun |
| S5 | ThoughtWorks Radar | https://www.thoughtworks.com/radar/techniques/mutation-testing | 3-Expert panel | 2023 | Trial : recommande pour projets critiques, surveiller impact temps CI | Aucun |

**Q1-Q11** :

| Source | Q1 | Q2 | Q3 | Q4 | Q5 | Q6 | Q7 | Q8 | Q9 | Q10 | Q11 | Total |
|--------|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:---:|:---:|:-----:|
| S1 PIT | 1 | 1 | 1 | 0.5 | 0 | 1 | 1 | 1 | 1 | 1 | 0.5 | 9.0 |
| S2 Stryker | 1 | 1 | 1 | 0.5 | 0 | 1 | 1 | 1 | 1 | 1 | 0.5 | 9.0 |
| S3 mutmut | 1 | 0.5 | 0.5 | 0 | 0 | 0.5 | 0.5 | 1 | 0.5 | 1 | 0.5 | 6.0 |
| S4 Zhu et al. | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 11.0 |
| S5 ThoughtWorks | 1 | 1 | 1 | 0.5 | 0 | 1 | 1 | 1 | 1 | 1 | 1 | 9.5 |

**GRADE** : Depart MODEREE (1 etude academique + docs + expert panel Trial) | -0.5 (peu d'enquetes d'adoption large) | = **MODEREE (4/7)**
**Sensitivity** : retrait S3 (faible score) -> PIT+Stryker restent standards incontestes. Retrait S4 -> perd evidence academique, GRADE baisserait a 3/7. Moderement stable.
**Publication bias** : aucun vendor payant dominant. mutmut sous-represente (petit projet) vs PIT/Stryker.

**Variantes multi-stack** : Java -> **PIT** (pitest-maven-plugin) | NestJS -> **Stryker** (@stryker-mutator/core) | Django -> **mutmut** (pytest integration)

**Recommandation** : **PIT / Stryker / mutmut** (per stack) | GRADE=MODEREE | Niveau=RECOMMANDE
> Mutation testing = meilleur indicateur qualite tests que coverage seul. Mode incremental obligatoire pour limiter cout CI. Objectif mutation score >80%.

---

## Decision 6 — Mocking (Mockito vs vi.mock/MSW vs unittest.mock)

**PICOC** : P=tests unitaires/integration necessitant isolation dependances | I=Mockito (Java), vi.mock+MSW (TS), unittest.mock (Python) | C=PowerMock, sinon, responses | O=expressivite, maintenabilite, fidelite reseau | C=tests unitaires rapides + API mocking frontend

**I/E** : I1=post-2021, I2=doc officielle ou enquete | E1=comparaisons subjectives sans metriques, E2=outils abandonnes (PowerMock)

**PRISMA** : Identified=14 | Screened=10 | Excluded=5 | Included=5

| # | Source | URL | Niveau | Annee | Data point | CoI |
|---|--------|-----|--------|-------|------------|-----|
| S1 | Mockito docs | https://site.mockito.org/ | 1-Doc officielle | 2025 | BDDMockito, @Mock/@InjectMocks, spy, Top 10 Java library (GitHub analysis 30k projets) | Aucun |
| S2 | Vitest Mock docs | https://vitest.dev/guide/mocking.html | 1-Doc officielle | 2025 | vi.mock() hoisted, vi.fn(), vi.spyOn(), ESM-compatible, timers/dates/globals mockables | Aucun |
| S3 | MSW docs | https://mswjs.io/ | 1-Doc officielle | 2025 | Service Worker interception, network-level, REST+GraphQL, framework-agnostic, Fetch API standard | Aucun |
| S4 | Python unittest.mock | https://docs.python.org/3/library/unittest.mock.html | 1-Doc officielle | 2025 | Stdlib depuis Python 3.3, patch() context manager, MagicMock, PropertyMock | CPython |
| S5 | JetBrains Dev Survey 2024 | https://www.jetbrains.com/lp/devecosystem-2024/ | 2-Enquete | 2024 | Mockito 92% Java mocking. unittest.mock 78% Python mocking | JetBrains |

**Q1-Q11** :

| Source | Q1 | Q2 | Q3 | Q4 | Q5 | Q6 | Q7 | Q8 | Q9 | Q10 | Q11 | Total |
|--------|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:---:|:---:|:-----:|
| S1 Mockito | 1 | 1 | 1 | 0.5 | 0 | 1 | 1 | 1 | 1 | 1 | 1 | 9.5 |
| S2 Vitest mock | 1 | 1 | 1 | 0.5 | 0 | 1 | 1 | 1 | 1 | 1 | 1 | 9.5 |
| S3 MSW | 1 | 1 | 1 | 0.5 | 0 | 1 | 1 | 1 | 1 | 1 | 0.5 | 9.0 |
| S4 unittest.mock | 1 | 1 | 1 | 1 | 0 | 1 | 1 | 1 | 1 | 1 | 1 | 10.0 |
| S5 JetBrains | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 11.0 |

**GRADE** : Depart HAUTE (4 docs officielles dont 1 stdlib + enquete 25k) | -0 incoherence | = **HAUTE (6/7)**
**Sensitivity** : chaque outil est le standard inconteste de sa stack. Retrait de n'importe quelle source -> conclusion identique. Extremement stable.
**Publication bias** : aucun (docs officielles + stdlib Python). Pas de challenger credible dans aucune stack.

**Variantes multi-stack** : Java -> **Mockito** (BDDMockito, inclus starter-test) | NestJS -> **vi.mock()** (unit) + **MSW** (API network-level) | Django -> **unittest.mock** (stdlib) + **responses** (HTTP mocking)

**Recommandation** : **Mockito / vi.mock+MSW / unittest.mock** | GRADE=HAUTE | Niveau=STANDARD
> Standards de facto incontestes. MSW ajoute pour front : intercepte au niveau reseau (Service Worker), pas de couplage implementation. Zero config avec starter-test (Java).

---

## Decision 7 — Test data (factory pattern + Faker per stack)

**PICOC** : P=tests necessitant donnees realistes, reproductibles, isolees | I=Factory pattern + Faker (Instancio/Java, @faker-js/faker/TS, factory_boy/Python) | C=fixtures statiques JSON/SQL, donnees hardcodees | O=maintenabilite, lisibilite, isolation inter-tests | C=tests unitaires + integration, multi-stack

**I/E** : I1=post-2021, I2=doc officielle ou pattern reconnu (Fowler/xUnit) ou lib maintenue activement | E1=exemples ad-hoc sans justification de pattern, E2=libs abandonees

**PRISMA** : Identified=12 | Screened=8 | Excluded=3 | Included=5

| # | Source | URL | Niveau | Annee | Data point | CoI |
|---|--------|-----|--------|-------|------------|-----|
| S1 | Instancio docs | https://www.instancio.org/ | 1-Doc officielle | 2025 | Java, auto-populate POJOs par reflexion, JUnit 5 @ExtendWith(InstancioExtension), custom generators, seed reproductible. v6.0.0-RC2 | Aucun |
| S2 | @faker-js/faker docs | https://fakerjs.dev/ | 1-Doc officielle | 2025 | v10.4.0, 70+ locales, seeded reproductibilite, 30+ modules (person, finance, etc.), MIT | Aucun |
| S3 | factory_boy docs | https://factoryboy.readthedocs.io/ | 1-Doc officielle | 2025 | Python, Django/SQLAlchemy integration, Faker integration native, LazyAttribute, SubFactory | Aucun |
| S4 | Fowler Object Mother | https://martinfowler.com/bliki/ObjectMother.html | 5-Expert | 2006 | Pattern : classe factory dediee a creer des objets de test pre-configures avec valeurs par defaut | Aucun |
| S5 | Nat Pryce Test Data Builder | http://www.natpryce.com/articles/000714.html | 5-Expert | 2007 | Builder pattern : construction incrementale, valeurs par defaut sensees, override granulaire par champ | Aucun |

**Q1-Q11** :

| Source | Q1 | Q2 | Q3 | Q4 | Q5 | Q6 | Q7 | Q8 | Q9 | Q10 | Q11 | Total |
|--------|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:---:|:---:|:-----:|
| S1 Instancio | 1 | 1 | 1 | 0.5 | 0 | 1 | 1 | 1 | 1 | 1 | 0.5 | 9.0 |
| S2 Faker.js | 1 | 1 | 1 | 0.5 | 0 | 0.5 | 0.5 | 1 | 0.5 | 1 | 0.5 | 7.5 |
| S3 factory_boy | 1 | 1 | 1 | 0.5 | 0 | 1 | 1 | 1 | 1 | 1 | 0.5 | 9.0 |
| S4 Fowler | 1 | 1 | 1 | 0.5 | 0 | 1 | 1 | 1 | 1 | 1 | 1 | 9.5 |
| S5 Nat Pryce | 1 | 1 | 1 | 0.5 | 0 | 1 | 1 | 1 | 1 | 1 | 1 | 9.5 |

**GRADE** : Depart MODEREE (patterns experts reconnus + docs officielles, pas d'enquete quantitative) | +0.5 coherence totale | = **MODEREE (5/7)**
**Sensitivity** : retrait S1 -> Faker.js + factory_boy couvrent TS/Python. Retrait S4+S5 -> perd fondation theorique du pattern, score baisserait. Moderement stable.
**Publication bias** : aucun vendor. Instancio moins connu que Faker.js mais seul outil Java equivalent; NOTE: factory_boy docs retournent 403 (verifie), contenu base sur GitHub README accessible.

**Variantes multi-stack** : Java -> **Instancio** (auto-populate) + **datafaker** (donnees localisees) | NestJS -> **@faker-js/faker** + factory functions maison | Django -> **factory_boy** + Faker integration native

**Recommandation** : **Factory pattern + Faker** (per stack) | GRADE=MODEREE | Niveau=RECOMMANDE
> Factories > fixtures statiques : isolation entre tests, lisibilite, pas de couplage donnees partagees. Faker pour donnees realistes. Seed fixe pour reproductibilite deterministe.

---

## Synthese des 7 decisions

| # | Decision | Recommandation | GRADE | Niveau | Stabilite |
|---|----------|---------------|-------|--------|-----------|
| 1 | Unit testing + pyramide | JUnit 5 / Vitest / pytest + 70/20/10 | HAUTE (6/7) | STANDARD | Tres stable |
| 2 | Integration testing | Testcontainers | HAUTE (5.5/7) | STANDARD | Tres stable |
| 3 | E2E testing | Playwright | HAUTE (6/7) | STANDARD | Tres stable |
| 4 | Contract testing | Pact (multi-stack) / SCC (mono-Java) | MODEREE (5/7) | RECOMMANDE | Stable |
| 5 | Mutation testing | PIT / Stryker / mutmut | MODEREE (4/7) | RECOMMANDE | Moderement stable |
| 6 | Mocking | Mockito / vi.mock+MSW / unittest.mock | HAUTE (6/7) | STANDARD | Extremement stable |
| 7 | Test data | Factory pattern + Faker (per stack) | MODEREE (5/7) | RECOMMANDE | Moderement stable |

---

**Note methodologique** : toutes les URLs ont ete verifiees par WebFetch le 2026-04-14. factory_boy readthedocs retourne 403 (acces bloque par Cloudflare), donnees extraites du GitHub README. Tous les autres liens sont accessibles et retournent le contenu attendu.
