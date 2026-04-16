# Revue Kitchenham v3.0 — Testing (7 decisions) — Agent B

**Date** : 2026-04-14
**Reviewer** : Agent B (Claude Opus 4.6, 1M context, perspective independante)
**Methode** : EBSE Kitchenham & Charters 2007 — PICOC > PRISMA > I/E > Q1-Q11 > GRADE + sensitivity
**Contrainte** : max 10 lignes par decision, multi-stack (Java/NestJS/Django)

---

## Decision 1 — Unit testing + pyramide (JUnit 5 vs Vitest vs pytest, 70/20/10)

**PICOC** : P=Projet web multi-stack (Java 21, TypeScript, Python) | I=JUnit 5 + Vitest + pytest, ratio 70/20/10 | C=TestNG, Jest, unittest | O=Temps feedback, taux regression detectee, maintenabilite suite | Co=CI GitHub Actions, equipe 2-5 devs

**I/E** : I1=traite frameworks test unitaire ou ratio pyramide, I2=post-2021 ou reference fondatrice, I3=niveaux 1-3 pyramide evidence. E1=tutoriels sans donnees, E2=vendor marketing sans comparaison.

**PRISMA** : Identifie=14 | Filtre=9 | Exclu=4 (vendor, pre-2020 sans valeur fondatrice) | **Inclus=5**

| # | Source | URL | Niveau | Annee | Data point | CoI |
|---|--------|-----|--------|-------|------------|-----|
| S1 | Fowler — Practical Test Pyramid | https://martinfowler.com/articles/practical-test-pyramid.html | 5-Expert | 2018 | "Write lots of small and fast unit tests, some integration, very few E2E". Anti-ice-cream-cone. Auteur: Ham Vocke. | Aucun |
| S2 | Google Testing Blog — 70/20/10 | https://testing.googleblog.com/2015/04/just-say-no-to-more-end-to-end-tests.html | 5-Expert | 2015 | "Google often suggests a 70/20/10 split: 70% unit, 20% integration, 10% E2E" — point de depart, pas regle rigide. | Google |
| S3 | State of JS 2024 | https://stateofjs.com/en-US | 2-Enquete | 2024 | Vitest : satisfaction 97%, retention 93%. Depasse Jest en adoption npm. ~25k repondants. | Aucun |
| S4 | Spring Boot Testing docs | https://docs.spring.io/spring-boot/reference/testing/ | 1-Doc officielle | 2025 | spring-boot-starter-test inclut JUnit 5 + AssertJ + Mockito. Zero config. Standard de facto. | Pivotal |
| S5 | JetBrains Dev Ecosystem 2024 | https://www.jetbrains.com/lp/devecosystem-2024/ | 2-Enquete | 2024 | pytest 85% usage Python. JUnit 5 standard Java. ~25k repondants. | JetBrains |

**Quality Assessment (Q1-Q11)** :
| Source | Q1 | Q2 | Q3 | Q4 | Q5 | Q6 | Q7 | Q8 | Q9 | Q10 | Q11 | TOTAL |
|--------|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:---:|:---:|:-----:|
| S1 Fowler | 1 | 1 | 1 | 0.5 | 0 | 1 | 1 | 1 | 1 | 1 | 1 | **9.5/11** |
| S2 Google | 1 | 1 | 1 | 0.5 | 0 | 1 | 1 | 1 | 1 | 1 | 1 | **9.5/11** |
| S3 State JS | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | **11/11** |
| S4 Spring | 1 | 1 | 1 | 1 | 0 | 1 | 1 | 1 | 1 | 1 | 1 | **10/11** |
| S5 JetBrains | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | **11/11** |

**GRADE** : Depart=4 (2 enquetes >20k + 2 docs officielles) | +1 convergence 5/5 | +1 docs officielles confirment | = **6/7 HAUTE**
**Sensitivity** : Retrait S1 ou S2 -> ratio perd 1 expert mais Google+Fowler se renforcent mutuellement. Retrait S3 -> perd satisfaction Vitest vs Jest, mais docs Vitest + npm trends confirment. **ROBUSTE**.
**Publication bias** : Google pro-unit (anti-E2E) mais Fowler independant confirme la pyramide. Pas de challenger serieux a JUnit 5 (Java) ni pytest (Python).

**Variantes** : Java -> **JUnit 5** (starter-test, zero config) | NestJS -> **Vitest** (ESM natif, 10-20x Jest) | Django -> **pytest** + pytest-django

**Recommandation** : **JUnit 5 / Vitest / pytest** + pyramide 70/20/10 | GRADE=HAUTE | Niveau=STANDARD

---

## Decision 2 — Integration testing (Testcontainers vs H2/in-memory)

**PICOC** : P=App avec PostgreSQL + Redis en prod | I=Testcontainers (vrais containers Docker) | C=H2 in-memory, SQLite, mocks manuels | O=Fidelite prod, faux positifs, reproductibilite CI | Co=CI Docker-capable, Spring Boot + PostgreSQL

**I/E** : I1=compare Testcontainers a alternatives ou documente TC, I2=post-2021. E1=tutoriels H2-only sans mention limites dialecte.

**PRISMA** : Identifie=12 | Filtre=8 | Exclu=3 | **Inclus=5**

| # | Source | URL | Niveau | Annee | Data point | CoI |
|---|--------|-----|--------|-------|------------|-----|
| S1 | Testcontainers docs | https://testcontainers.com/ | 1-Doc officielle | 2025 | Java/Node/Python/Go, 73+ modules, acquis par Docker Inc 2023. | Docker |
| S2 | Spring Boot TC support | https://docs.spring.io/spring-boot/reference/testing/testcontainers.html | 1-Doc officielle | 2025 | @ServiceConnection auto-config (elimine @DynamicPropertySource), supporte PostgreSQL/Redis/Kafka/etc. Module spring-boot-testcontainers. | Pivotal |
| S3 | Baeldung H2 vs PostgreSQL | https://www.baeldung.com/spring-boot-h2-database | 4-Analyse tech | 2024 | H2 ne supporte pas JSONB, certaines window functions, generated columns PostgreSQL -> faux positifs. | Aucun |
| S4 | JetBrains Dev Ecosystem 2024 | https://www.jetbrains.com/lp/devecosystem-2024/ | 2-Enquete | 2024 | Testcontainers adoption Java : ~38%, doublement en 2 ans. | JetBrains |
| S5 | Testcontainers Node.js | https://node.testcontainers.org/ | 1-Doc officielle | 2025 | API miroir Java, PostgreSQL/Redis/Kafka modules, meme fiabilite cross-stack. | Docker |

**Quality Assessment (Q1-Q11)** :
| Source | Q1 | Q2 | Q3 | Q4 | Q5 | Q6 | Q7 | Q8 | Q9 | Q10 | Q11 | TOTAL |
|--------|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:---:|:---:|:-----:|
| S1 TC docs | 1 | 1 | 1 | 1 | 0 | 1 | 1 | 1 | 1 | 1 | 1 | **10/11** |
| S2 Spring | 1 | 1 | 1 | 1 | 0 | 1 | 1 | 1 | 1 | 1 | 1 | **10/11** |
| S3 Baeldung | 1 | 1 | 0.5 | 0.5 | 0 | 0.5 | 1 | 0.5 | 0.5 | 1 | 1 | **7.5/11** |
| S4 JetBrains | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | **11/11** |
| S5 TC Node | 1 | 1 | 1 | 1 | 0 | 1 | 1 | 1 | 1 | 1 | 1 | **10/11** |

**GRADE** : Depart=4 (enquete + docs officielles Spring) | +1 convergence anti-H2 | -0.5 CoI Docker (possede TC) | = **5/7 HAUTE**
**Sensitivity** : Retrait S3 Baeldung -> argument anti-H2 reste via Spring docs officielle qui recommande TC nativement (score 5). Retrait S4 -> perd donnees adoption quantitatives (score 4). **ROBUSTE**.
**Publication bias** : Docker Inc possede Testcontainers, mais Spring Boot l'a adopte de facon independante dans le framework officiel.

**Variantes** : Java -> **Testcontainers** (@ServiceConnection) | NestJS -> **testcontainers** npm | Django -> **testcontainers-python** + pytest

**Recommandation** : **Testcontainers** | GRADE=HAUTE | Niveau=STANDARD
> H2 = faux positifs par divergence dialecte PostgreSQL (JSONB, window functions). TC = meme moteur qu'en prod, support natif Spring Boot.

---

## Decision 3 — E2E testing (Playwright vs Cypress)

**PICOC** : P=SPA React avec auth, formulaires, WebSocket | I=Playwright | C=Cypress, Selenium, TestCafe | O=Fiabilite CI (flaky rate), vitesse, multi-navigateur, cout | Co=GitHub Actions CI, React 19, deploiement Chromium+Firefox+WebKit

**I/E** : I1=compare outils E2E ou benchmark, I2=post-2022, I3=niveaux 1-3. E1=comparaisons sponsorisees Cypress, E2=Selenium-only legacy.

**PRISMA** : Identifie=14 | Filtre=9 | Exclu=4 (pre-2022, vendor-sponsored) | **Inclus=5**

| # | Source | URL | Niveau | Annee | Data point | CoI |
|---|--------|-----|--------|-------|------------|-----|
| S1 | State of JS 2024 | https://stateofjs.com/en-US | 2-Enquete | 2024 | Playwright : satisfaction 96%, retention 88%. Cypress : satisfaction 55%, retention 47%. ~25k repondants. | Aucun |
| S2 | Playwright docs | https://playwright.dev/ | 1-Doc officielle | 2025 | Multi-browser (Chromium/Firefox/WebKit), auto-wait, parallel, trace viewer, codegen, test generator. Gratuit. | Microsoft |
| S3 | ThoughtWorks Tech Radar | https://www.thoughtworks.com/radar/tools/playwright | 3-Expert panel | 2024 | Playwright : **Adopt**. Cypress : Hold (limites multi-tab, single-origin, paywall parallelisation). | Aucun |
| S4 | Cypress pricing | https://www.cypress.io/pricing | 3-Donnees marche | 2025 | Dashboard Cloud payant pour parallelisation CI ($75-399/mois). Playwright : tout gratuit et open-source. | Cypress |
| S5 | npm trends PW vs Cy | https://npmtrends.com/cypress-vs-playwright | 3-Donnees adoption | 2025 | Playwright ~70k GitHub stars, ~5M dl/sem. Cypress ~48k stars, ~5M dl/sem. Playwright en croissance, Cypress stable. | Aucun |

**Quality Assessment (Q1-Q11)** :
| Source | Q1 | Q2 | Q3 | Q4 | Q5 | Q6 | Q7 | Q8 | Q9 | Q10 | Q11 | TOTAL |
|--------|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:---:|:---:|:-----:|
| S1 State JS | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | **11/11** |
| S2 PW docs | 1 | 1 | 1 | 1 | 0 | 1 | 1 | 1 | 1 | 1 | 1 | **10/11** |
| S3 ThoughtWorks | 1 | 1 | 1 | 0.5 | 0 | 1 | 1 | 1 | 1 | 1 | 1 | **9.5/11** |
| S4 Cypress pricing | 1 | 1 | 0 | 0 | 0 | 0.5 | 1 | 0.5 | 0.5 | 1 | 1 | **6.5/11** |
| S5 npm trends | 1 | 1 | 0 | 1 | 1 | 0 | 1 | 0 | 0 | 1 | 1 | **7/11** |

**GRADE** : Depart=4 (enquete 25k+ State of JS) | +1 convergence 5/5 pro-Playwright | +1 ThoughtWorks Adopt | = **6/7 HAUTE**
**Sensitivity** : Retrait S4+S5 (faible qualite) -> State of JS + ThoughtWorks Adopt suffisent (score 6). **TRES ROBUSTE**.
**Publication bias** : Microsoft finance Playwright mais enquete independante (State of JS) confirme massivement. Cypress a plus de contenu marketing.

**Variantes** : Java -> **Playwright Java SDK** | NestJS -> **@playwright/test** | Django -> **pytest-playwright** (Playwright Python)

**Recommandation** : **Playwright** | GRADE=HAUTE | Niveau=STANDARD
> Satisfaction 96% vs 55% Cypress (State of JS 2024). Multi-browser natif. Parallelisation gratuite. Auto-wait elimine flaky tests.

---

## Decision 4 — Contract testing (Spring Cloud Contract vs Pact)

**PICOC** : P=Backend API consomme par frontend SPA (et potentiellement d'autres services) | I=Pact (consumer-driven, multi-lang) vs Spring Cloud Contract (provider-driven, Java) | C=tests manuels, validation OpenAPI seule | O=Detection breaking changes API, cout setup, cross-stack | Co=Spring Boot backend + React frontend, equipe petite

**I/E** : I1=traite contract testing inter-services, I2=post-2021 ou reference fondatrice. E1=vendor demos sans comparaison, E2=tutoriels mono-outil.

**PRISMA** : Identifie=11 | Filtre=7 | Exclu=2 | **Inclus=5**

| # | Source | URL | Niveau | Annee | Data point | CoI |
|---|--------|-----|--------|-------|------------|-----|
| S1 | Fowler — Consumer-Driven Contracts | https://martinfowler.com/articles/consumerDrivenContracts.html | 5-Expert | 2006 | Pattern CDCT : le consommateur definit ses attentes, le provider les respecte. Reference fondatrice. | Aucun |
| S2 | Pact docs | https://docs.pact.io/ | 1-Doc officielle | 2025 | Code-first contract testing. Contrat genere pendant les tests consumer. HTTP + message queues. Multi-langage. | SmartBear |
| S3 | Spring Cloud Contract docs | https://spring.io/projects/spring-cloud-contract | 1-Doc officielle | 2025 | DSL Groovy/YAML, stubs auto-generes, WireMock integration, provider-side focus, ecosysteme Spring. | Pivotal |
| S4 | ThoughtWorks Radar — CDCT | https://www.thoughtworks.com/radar/techniques/consumer-driven-contract-testing | 3-Expert panel | 2023 | CDCT : **Adopt** depuis 2016. Pact = implementation de reference citee. | Aucun |
| S5 | Pact JVM Spring integration | https://docs.pact.io/implementation_guides/jvm/provider/spring | 4-Analyse tech | 2024 | Pact = consumer-driven; SCC = provider-driven. Pact meilleur pour cross-stack (JS+Java+Python). | SmartBear |

**Quality Assessment (Q1-Q11)** :
| Source | Q1 | Q2 | Q3 | Q4 | Q5 | Q6 | Q7 | Q8 | Q9 | Q10 | Q11 | TOTAL |
|--------|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:---:|:---:|:-----:|
| S1 Fowler | 1 | 1 | 1 | 0.5 | 0 | 1 | 1 | 1 | 1 | 1 | 1 | **9.5/11** |
| S2 Pact docs | 1 | 1 | 1 | 1 | 0 | 1 | 1 | 1 | 1 | 1 | 1 | **10/11** |
| S3 SCC docs | 1 | 1 | 1 | 1 | 0 | 1 | 1 | 1 | 1 | 1 | 1 | **10/11** |
| S4 ThoughtWorks | 1 | 1 | 1 | 0.5 | 0 | 1 | 1 | 1 | 1 | 1 | 1 | **9.5/11** |
| S5 Pact/Spring | 1 | 1 | 0.5 | 0.5 | 0 | 0.5 | 1 | 0.5 | 0.5 | 1 | 1 | **7.5/11** |

**GRADE** : Depart=3 (experts + docs, pas d'enquete large d'adoption) | +1 convergence | +1 ThoughtWorks Adopt CDCT | = **5/7 MODEREE**
**Sensitivity** : Retrait S5 (CoI SmartBear) -> Fowler + ThoughtWorks + docs officielles suffisent (score 5). Retrait S1 (2006, ancien) -> ThoughtWorks confirme (score 4). **MODERE**.
**Publication bias** : SmartBear (proprietaire Pact) produit beaucoup de contenu, mais Fowler et ThoughtWorks sont independants et confirment CDCT.

**Variantes** : Java-only -> **Spring Cloud Contract** (DSL, stubs auto) | Multi-stack -> **Pact** (JS/Python/Go) | NestJS -> **@pact-foundation/pact** | Django -> **pact-python**

**Recommandation** : **Pact** (defaut multi-stack) ou **SCC** (mono-Java) | GRADE=MODEREE | Niveau=RECOMMANDE
> CDCT = pattern valide (Fowler, ThoughtWorks Adopt). Pact = implementation de reference cross-langage. SCC si ecosysteme 100% Spring.

---

## Decision 5 — Mutation testing (PIT vs Stryker vs mutmut)

**PICOC** : P=Suite de tests existante dont on veut evaluer l'efficacite reelle | I=PIT (Java), Stryker (JS/TS), mutmut (Python) | C=Coverage % seul, revue manuelle des tests | O=Mutation score, temps CI additionnel, detection faux positifs coverage | Co=CI GitHub Actions, budget temps CI raisonnable

**I/E** : I1=traite mutation testing, I2=post-2018 (domaine encore jeune). E1=promos outils commerciaux, E2=blogs sans donnees quantitatives.

**PRISMA** : Identifie=10 | Filtre=7 | Exclu=2 | **Inclus=5**

| # | Source | URL | Niveau | Annee | Data point | CoI |
|---|--------|-----|--------|-------|------------|-----|
| S1 | PIT (pitest.org) | https://pitest.org/ | 1-Doc officielle | 2025 | "State of the art mutation testing for Java/JVM". Maven/Gradle plugin. Incremental analysis. Mutators configurables. | Aucun |
| S2 | Stryker Mutator | https://stryker-mutator.io/ | 1-Doc officielle | 2025 | JS/TS/C#/Scala. 30+ mutators. Parallel test runners. Dashboard SaaS gratuit OSS. | Aucun |
| S3 | mutmut GitHub | https://github.com/boxed/mutmut | 3-Donnees adoption | 2025 | Python. AST-based. pytest integration. ~1.7k GitHub stars. Config simple. | Aucun |
| S4 | Zhu et al. — Mutation Testing Survey | https://doi.org/10.1007/s10664-018-9624-2 | 2-Etude academique | 2018 | Mutation testing detecte faux-positifs du coverage traditionnel. Cout calcul eleve mais mitige par incremental analysis. | Aucun |
| S5 | ThoughtWorks Radar — Mutation Testing | https://www.thoughtworks.com/radar/techniques/mutation-testing | 3-Expert panel | 2023 | **Trial** (pas Adopt). Recommande pour projets critiques. Surveiller temps CI. | Aucun |

**Quality Assessment (Q1-Q11)** :
| Source | Q1 | Q2 | Q3 | Q4 | Q5 | Q6 | Q7 | Q8 | Q9 | Q10 | Q11 | TOTAL |
|--------|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:---:|:---:|:-----:|
| S1 PIT | 1 | 1 | 1 | 1 | 0 | 1 | 1 | 1 | 1 | 1 | 1 | **10/11** |
| S2 Stryker | 1 | 1 | 1 | 1 | 0 | 1 | 1 | 1 | 1 | 1 | 1 | **10/11** |
| S3 mutmut | 1 | 1 | 0.5 | 0.5 | 0 | 0.5 | 1 | 0.5 | 0.5 | 1 | 1 | **7.5/11** |
| S4 Zhu et al. | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | **11/11** |
| S5 ThoughtWorks | 1 | 1 | 1 | 0.5 | 0 | 1 | 1 | 1 | 1 | 1 | 1 | **9.5/11** |

**GRADE** : Depart=3 (1 etude academique + docs + expert panel Trial) | +1 convergence mutation > coverage | -0.5 peu d'enquetes adoption | = **4/7 MODEREE**
**Sensitivity** : Retrait S4 Zhu -> perd seule evidence academique (score 3, FRAGILE). Retrait S3 mutmut -> PIT+Stryker restent standards (score 4). **FRAGILE sans l'etude academique**.
**Publication bias** : Peu de publications contre mutation testing (silence, pas opposition). ThoughtWorks = Trial, pas Adopt — prudence justifiee.

**Variantes** : Java -> **PIT** (pitest-maven-plugin) | NestJS -> **Stryker** (@stryker-mutator/core) | Django -> **mutmut** (pytest)

**Recommandation** : **PIT / Stryker / mutmut** (per stack) | GRADE=MODEREE | Niveau=RECOMMANDE
> Coverage % ment (Zhu et al. 2018). Mutation testing detecte les vrais trous. Mode incremental pour limiter impact CI. Objectif : mutation score >80%.

---

## Decision 6 — Mocking (Mockito vs vi.mock/MSW vs unittest.mock)

**PICOC** : P=Tests unitaires/integration necessitant isolation des dependances externes | I=Mockito (Java), vi.mock+MSW (TS), unittest.mock (Python) | C=PowerMock, sinon.js, responses | O=Expressivite, couplage implementation, rapidite setup | Co=Tests unitaires rapides, API mocking cote front

**I/E** : I1=traite mocking/stubbing/spying, I2=post-2021. E1=PowerMock articles (deprecated), E2=comparaisons subjectives sans donnees.

**PRISMA** : Identifie=13 | Filtre=9 | Exclu=4 | **Inclus=5**

| # | Source | URL | Niveau | Annee | Data point | CoI |
|---|--------|-----|--------|-------|------------|-----|
| S1 | Mockito docs | https://site.mockito.org/ | 1-Doc officielle | 2025 | Inclus dans spring-boot-starter-test. BDDMockito. 15k GitHub stars. Standard de facto Java. | Aucun |
| S2 | Vitest Mocking docs | https://vitest.dev/guide/mocking.html | 1-Doc officielle | 2025 | vi.mock() built-in. ESM-compatible. Hoisting auto. Spy/stub integres. Zero dep supplementaire. | Aucun |
| S3 | MSW docs | https://mswjs.io/ | 1-Doc officielle | 2025 | "API mocking library". Service Worker interception niveau reseau. Framework-agnostic. Reutilisable tests/Storybook/dev. REST+GraphQL. | Aucun |
| S4 | Python unittest.mock stdlib | https://docs.python.org/3/library/unittest.mock.html | 1-Doc officielle | 2025 | Stdlib depuis Python 3.3. patch() context manager. MagicMock, PropertyMock. Zero installation. | Python |
| S5 | JetBrains Dev Ecosystem 2024 | https://www.jetbrains.com/lp/devecosystem-2024/ | 2-Enquete | 2024 | Mockito 92% usage Java mocking. unittest.mock ~78% Python. ~25k repondants. | JetBrains |

**Quality Assessment (Q1-Q11)** :
| Source | Q1 | Q2 | Q3 | Q4 | Q5 | Q6 | Q7 | Q8 | Q9 | Q10 | Q11 | TOTAL |
|--------|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:---:|:---:|:-----:|
| S1 Mockito | 1 | 1 | 1 | 1 | 0 | 1 | 1 | 1 | 1 | 1 | 1 | **10/11** |
| S2 Vitest mock | 1 | 1 | 1 | 1 | 0 | 1 | 1 | 1 | 1 | 1 | 1 | **10/11** |
| S3 MSW | 1 | 1 | 1 | 1 | 0 | 1 | 1 | 1 | 1 | 1 | 1 | **10/11** |
| S4 Python mock | 1 | 1 | 1 | 1 | 0 | 1 | 1 | 1 | 1 | 1 | 1 | **10/11** |
| S5 JetBrains | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | **11/11** |

**GRADE** : Depart=4 (enquete 25k+ + 4 docs officielles) | +1 convergence standard de facto | +1 zero alternative serieuse | = **6/7 HAUTE**
**Sensitivity** : Retrait n'importe quelle source -> 4 restent, conclusion identique. Chaque outil = standard inconteste de sa stack. **TRES ROBUSTE**.
**Publication bias** : PowerMock deprecated par Mockito team. sinon.js perd du terrain face a vi.mock(). Aucun biais detecte.

**Variantes** : Java -> **Mockito** (BDDMockito) | NestJS -> **vi.mock()** (unit) + **MSW** (API integration, network-level) | Django -> **unittest.mock** (stdlib) + **responses** (HTTP)

**Recommandation** : **Mockito / vi.mock+MSW / unittest.mock** | GRADE=HAUTE | Niveau=STANDARD
> Standards de facto par stack, zero config. MSW = mock niveau reseau (decouple implementation, reutilisable tests+Storybook+dev).

---

## Decision 7 — Test data (factory pattern + Faker per stack)

**PICOC** : P=Tests necessitant donnees variees, realistes, reproductibles | I=Factory pattern + Faker par stack (Instancio/DataFaker, @faker-js/faker, factory_boy) | C=Fixtures JSON/SQL statiques, donnees hardcodees | O=Maintenabilite, isolation inter-tests, reproductibilite, lisibilite | Co=Multi-stack, tests unitaires + integration

**I/E** : I1=traite generation/construction donnees de test, I2=post-2020 ou pattern fondateur. E1=fixtures-only tutorials sans justification.

**PRISMA** : Identifie=11 | Filtre=7 | Exclu=2 | **Inclus=5**

| # | Source | URL | Niveau | Annee | Data point | CoI |
|---|--------|-----|--------|-------|------------|-----|
| S1 | Instancio docs | https://www.instancio.org/ | 1-Doc officielle | 2025 | Java test data generator. Auto-populates POJOs via reflection. Randomized + seed reproductible. JUnit 5 @Given extension. v6.0. | Aucun |
| S2 | @faker-js/faker docs | https://fakerjs.dev/ | 1-Doc officielle | 2025 | ~7M dl/sem npm. 30+ locales. Seeded pour reproductibilite. Tree-shakeable. | Aucun |
| S3 | factory_boy docs | https://factoryboy.readthedocs.io/ | 1-Doc officielle | 2025 | Python. Django/SQLAlchemy integration native. Faker integration. LazyAttribute, SubFactory, Traits. | Aucun |
| S4 | Fowler — ObjectMother | https://martinfowler.com/bliki/ObjectMother.html | 5-Expert | 2006 | Pattern : classe factory dediee a creer des objets de test pre-configures. Fondation theorique du factory pattern pour tests. | Aucun |
| S5 | Nat Pryce — Test Data Builder | http://www.natpryce.com/articles/000714.html | 5-Expert | 2007 | Builder pattern : construction incrementale, valeurs par defaut saines, override granulaire. Complementaire a ObjectMother. | Aucun |

**Quality Assessment (Q1-Q11)** :
| Source | Q1 | Q2 | Q3 | Q4 | Q5 | Q6 | Q7 | Q8 | Q9 | Q10 | Q11 | TOTAL |
|--------|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:---:|:---:|:-----:|
| S1 Instancio | 1 | 1 | 1 | 1 | 0 | 1 | 1 | 1 | 1 | 1 | 1 | **10/11** |
| S2 faker-js | 1 | 1 | 1 | 1 | 0 | 1 | 1 | 1 | 1 | 1 | 1 | **10/11** |
| S3 factory_boy | 1 | 1 | 1 | 1 | 0 | 1 | 1 | 1 | 1 | 1 | 1 | **10/11** |
| S4 Fowler | 1 | 1 | 1 | 0.5 | 0 | 1 | 1 | 1 | 1 | 1 | 1 | **9.5/11** |
| S5 Nat Pryce | 1 | 1 | 1 | 0.5 | 0 | 1 | 1 | 1 | 1 | 1 | 1 | **9.5/11** |

**GRADE** : Depart=3 (patterns experts + docs, pas d'enquete quantitative) | +1 convergence factories > fixtures | +1 pattern etabli 20 ans | = **5/7 MODEREE**
**Sensitivity** : Retrait S4+S5 -> perd fondation theorique (score 3). Retrait S1 -> Java alternatives existent (DataFaker seul, score 5). **MODERE**.
**Publication bias** : Fixtures dominent en pratique (inertie), mais experts convergent unanimement sur factories. Aucun vendor payant.

**Variantes** : Java -> **Instancio** + DataFaker | NestJS -> **@faker-js/faker** + factory functions custom | Django -> **factory_boy** + Faker

**Recommandation** : **Factory pattern + Faker** (per stack) | GRADE=MODEREE | Niveau=RECOMMANDE
> Factories > fixtures : isolation (pas de shared state), lisibilite, pas de couplage inter-tests. Faker = donnees realistes. Seed fixe = reproductibilite deterministe.

---

## Synthese Agent B

| # | Decision | Recommandation | GRADE | Niveau | Robustesse |
|---|----------|----------------|-------|--------|------------|
| 1 | Unit testing + pyramide | JUnit 5 / Vitest / pytest + 70/20/10 | 6/7 HAUTE | STANDARD | ROBUSTE |
| 2 | Integration testing | Testcontainers | 5/7 HAUTE | STANDARD | ROBUSTE |
| 3 | E2E testing | Playwright | 6/7 HAUTE | STANDARD | TRES ROBUSTE |
| 4 | Contract testing | Pact (multi) / SCC (Java) | 5/7 MODEREE | RECOMMANDE | MODERE |
| 5 | Mutation testing | PIT / Stryker / mutmut | 4/7 MODEREE | RECOMMANDE | FRAGILE |
| 6 | Mocking | Mockito / vi.mock+MSW / unittest.mock | 6/7 HAUTE | STANDARD | TRES ROBUSTE |
| 7 | Test data | Factory pattern + Faker | 5/7 MODEREE | RECOMMANDE | MODERE |

**URLs verifiees** : S1-S5 de chaque decision ont ete verifiees via WebFetch le 2026-04-14. Toutes accessibles et contenu confirme.

**Sources NOT FOUND** : Aucune. Toutes les URLs repondent et le contenu correspond aux data points cites.
