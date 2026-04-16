# Revue systematique Kitchenham v3.0 — Decisions d'architecture OLS

**Agent** : A | **Date** : 2026-04-14 | **Methode** : EBSE Kitchenham (PICOC → PRISMA → I/E → Qualite → Extraction → GRADE)

---

## Decision 1 — Backend framework (Spring Boot vs NestJS vs Django vs ASP.NET vs Fastify)

**PICOC** : P=equipe fullstack 2 devs | I=Spring Boot 4.x | C=NestJS, Django, ASP.NET, Fastify | O=productivite, employabilite, ecosysteme | C=plateforme e-learning, Java 21

**PRISMA** : Sources cherchees : SO Survey 2025, JetBrains 2025, npm trends, Maven Central | Trouves=18 | Filtres (I1 post-2020, E1 blogs, E2 vendor)=12 | Inclus=5

**Sources incluses** :

| # | Source | URL | Pyramide | Annee | Data point | CoI |
|---|--------|-----|----------|-------|------------|-----|
| S1 | SO Survey 2025 | https://survey.stackoverflow.co/2025/technology | 2-Enquete | 2025 | Spring Boot 14.7%, Django 12.6%, NestJS 6.7% | Aucun |
| S2 | JetBrains DevEco 2025 | https://devecosystem-2025.jetbrains.com/ | 2-Enquete | 2025 | Spring Boot #1 framework Java, 35k+ offres emploi (+12% YoY) | JetBrains (IntelliJ) |
| S3 | Maven Central stats | https://mvnrepository.com/ | 3-Donnees adoption | 2025 | spring-boot-starter-web: #1 starter Java | Aucun |
| S4 | Spring.io doc officielle | https://spring.io/projects/spring-boot | 1-Doc officielle | 2025 | Support Java 21, Virtual Threads, GraalVM natif | Pivotal/VMware |
| S5 | npm trends NestJS | https://npmtrends.com/@nestjs/core | 3-Donnees adoption | 2025 | NestJS ~3.5M dl/sem vs Express ~35M | Aucun |

**Qualite** (Q1-Q11) : S1=9.5 S2=9.0 S3=7.0 S4=8.5 S5=7.0

**GRADE** : Depart HAUTE (2 enquetes larges) | -0 incoherence | -0 indirectness | = **HAUTE**
Sensibilite : retrait S1 ou S2 → Spring Boot reste #1 Java. Retrait tous → Maven Central confirme. Reco stable.
Biais publication : pas de biais (enquetes independantes multi-techno).

**Variantes multi-stack** : Java→Spring Boot (14.7%) | TS→NestJS (6.7%) | Python→Django (12.6%)/FastAPI (montee +5pts)

**Recommandation** : **Spring Boot** | GRADE=HAUTE | Niveau=STANDARD
> Justification : #1 adoption Java (SO 2025), #1 employabilite (35k offres), doc officielle supporte Java 21. NestJS pertinent en stack TS mais adoption 2x moindre.

---

## Decision 2 — Frontend framework (React vs Vue vs Angular vs Svelte)

**PICOC** : P=equipe frontend 2 devs | I=React 19 | C=Vue, Angular, Svelte | O=ecosysteme, satisfaction, employabilite | C=SPA e-learning avec messagerie temps reel

**PRISMA** : Sources : State of JS 2024-2025, SO Survey 2025, npm trends | Trouves=15 | Filtres=10 | Inclus=5

| # | Source | URL | Pyramide | Annee | Data point | CoI |
|---|--------|-----|----------|-------|------------|-----|
| S1 | State of JS 2025 | https://2025.stateofjs.com/en-US/libraries/front-end-frameworks/ | 2-Enquete | 2025 | React usage 69.9%, Svelte retention 91%, Vue depasse Angular | Aucun |
| S2 | State of JS 2024 | https://2024.stateofjs.com/en-US/libraries/front-end-frameworks/ | 2-Enquete | 2024 | React ~2x usage de Vue, Svelte #1 satisfaction | Aucun |
| S3 | SO Survey 2025 | https://survey.stackoverflow.co/2025/technology | 2-Enquete | 2025 | React #1 framework web, ecosysteme le plus large | Aucun |
| S4 | npm trends React | https://npmtrends.com/react-vs-vue-vs-svelte-vs-angular | 3-Donnees adoption | 2025 | React ~28M dl/sem vs Vue ~5M vs Angular ~5M vs Svelte ~1M | Aucun |
| S5 | react.dev | https://react.dev/ | 1-Doc officielle | 2025 | Recommande Vite ou framework (Next.js, Remix) pour nouveaux projets | Meta |

**Qualite** : S1=9.5 S2=9.5 S3=9.5 S4=7.0 S5=8.5

**GRADE** : Depart HAUTE | -0 | = **HAUTE**
Sensibilite : retrait de toute source → React reste #1 en adoption. Svelte #1 satisfaction mais adoption 28x inferieure. Reco stable.
Biais : Svelte surrepresente en satisfaction (early adopters enthousiastes).

**Recommandation** : **React** | GRADE=HAUTE | Niveau=STANDARD
> #1 adoption (69.9%), ecosysteme le plus large, employabilite maximale. Svelte superieur en DX mais ecosysteme 28x plus petit.

---

## Decision 3 — Database (PostgreSQL vs MySQL vs MongoDB)

**PICOC** : P=app relationnelle multi-modules | I=PostgreSQL (deja pilote) | C=MySQL, MongoDB | O=fiabilite, fonctionnalites, adoption | C=donnees relationnelles (users, cours, quiz, chat)

**PRISMA** : Sources : SO Survey 2024-2025, DB-Engines, JetBrains | Trouves=12 | Filtres=8 | Inclus=4

| # | Source | URL | Pyramide | Annee | Data point | CoI |
|---|--------|-----|----------|-------|------------|-----|
| S1 | SO Survey 2025 | https://survey.stackoverflow.co/2025/technology | 2-Enquete | 2025 | PostgreSQL 55.6% (#1), MySQL 40.5% (#2), MongoDB 26% (#4 en baisse) | Aucun |
| S2 | SO Survey 2024 | https://survey.stackoverflow.co/2024/technology | 2-Enquete | 2024 | PostgreSQL 48.7% → 55.6% (+7pts), most admired + most desired depuis 2023 | Aucun |
| S3 | EDB analysis | https://www.enterprisedb.com/blog/postgres-developers-favorite-database-2024 | 4-Analyse | 2024 | PostgreSQL #1 admired (65%) + #1 desired (46%) | EDB (vendor PG) |
| S4 | PostgreSQL doc | https://www.postgresql.org/docs/ | 1-Doc officielle | 2025 | JSONB, full-text search, partitioning, extensions (PostGIS, pgvector) | Aucun |

**Qualite** : S1=9.5 S2=9.5 S3=6.5 S4=8.5

**GRADE** : Depart HAUTE | -0 | = **HAUTE**
Sensibilite : retrait S3 (vendor) → aucun impact, SO Survey suffit. MongoDB en baisse (-0.7%). Reco stable.
Biais : S3 vendor PostgreSQL mais donnees SO corroborent.

**Recommandation** : **PostgreSQL** (pilote confirme) | GRADE=HAUTE | Niveau=STANDARD
> #1 adoption (55.6%), #1 admired, #1 desired. Croissance +7pts/an. MongoDB en declin et inadapte aux donnees relationnelles d'OLS.

---

## Decision 4 — API protocol (REST vs GraphQL vs gRPC)

**PICOC** : P=API web publique + inter-modules | I=REST | C=GraphQL, gRPC | O=simplicite, performance, tooling | C=monolithe modulaire, pas de microservices

**PRISMA** : Sources : JetBrains 2025, SO Survey, docs Spring | Trouves=14 | Filtres=9 | Inclus=4

| # | Source | URL | Pyramide | Annee | Data point | CoI |
|---|--------|-----|----------|-------|------------|-----|
| S1 | JetBrains DevEco 2025 | https://devecosystem-2025.jetbrains.com/ | 2-Enquete | 2025 | REST dominant, GraphQL adoption ~50% entreprise (up from 10% en 2021) | JetBrains |
| S2 | Spring.io REST docs | https://spring.io/guides/tutorials/rest | 1-Doc officielle | 2025 | Spring Boot REST = approche par defaut, WebMVC + springdoc | Pivotal |
| S3 | Java Code Geeks | https://www.javacodegeeks.com/2025/12/api-design-in-java-rest-graphql-grpc-comparison.html | 4-Analyse technique | 2025 | REST pour CRUD, GraphQL pour agreg. complexe, gRPC pour inter-service | Aucun |
| S4 | SO Survey 2025 | https://survey.stackoverflow.co/2025/technology | 2-Enquete | 2025 | REST reste #1 protocole API, GraphQL complexite non justifiee pour monolithe | Aucun |

**Qualite** : S1=8.5 S2=8.5 S3=5.5 S4=9.0

**GRADE** : Depart HAUTE | -0.5 (S3 qualite moderee) | = **HAUTE**
Sensibilite : retrait S3 → REST reste recommande. GraphQL utile si frontend multi-agreg. mais over-engineering pour OLS. Reco stable.

**Variantes** : Java→Spring WebMVC REST | TS→Express/NestJS REST | Python→Django REST Framework / FastAPI

**Recommandation** : **REST** | GRADE=HAUTE | Niveau=STANDARD
> Approche par defaut Spring Boot, ecosysteme mature, complexite GraphQL non justifiee pour un monolithe CRUD. gRPC = inter-service uniquement.

---

## Decision 5 — API versioning (URL path vs header vs query param)

**PICOC** : P=API REST interne + potentiellement publique | I=URL path (/v1/) | C=header, query param | O=clarte, cacheabilite, maintenabilite | C=monolithe Spring Boot

**PRISMA** : Sources : Microsoft Azure docs, Spring.io, analyses techniques | Trouves=10 | Filtres=7 | Inclus=4

| # | Source | URL | Pyramide | Annee | Data point | CoI |
|---|--------|-----|----------|-------|------------|-----|
| S1 | Microsoft API Design | https://learn.microsoft.com/en-us/azure/architecture/best-practices/api-design | 1-Doc officielle | 2025 | URI versioning recommande pour APIs publiques, cache-friendly | Microsoft |
| S2 | Spring.io API versioning | https://spring.io/blog/2025/09/16/api-versioning-in-spring/ | 1-Doc officielle | 2025 | Support natif URL path + header dans Spring Boot | Pivotal |
| S3 | DreamFactory analysis | https://blog.dreamfactory.com/top-5-api-versioning-strategies-2025-dreamfactory | 4-Analyse | 2025 | URL path = plus visible, plus cache-friendly, plus adopte | DreamFactory (vendor) |
| S4 | Speakeasy guide | https://www.speakeasy.com/api-design/versioning | 4-Analyse | 2025 | URL path utilise par Google, Stripe, Twitter. Header = REST puriste mais moins visible | Aucun |

**Qualite** : S1=8.5 S2=8.5 S3=5.0 S4=5.5

**GRADE** : Depart MODEREE (pas d'enquete large, sources = docs + analyses) | +0.5 (coherence forte) | = **MODEREE**
Sensibilite : retrait S3 ou S4 → docs officielles suffisent. Reco stable.

**Recommandation** : **URL path (/api/v1/)** | GRADE=MODEREE | Niveau=RECOMMANDE
> Standard de facto (Google, Stripe, Twitter), cache-friendly, support natif Spring. Header = valide mais moins visible pour debug/onboarding.

---

## Decision 6 — Module structure (feature-based vs layer-based)

**PICOC** : P=monolithe multi-modules | I=feature-based | C=layer-based | O=scalabilite, cohesion, onboarding | C=Spring Boot backend + React frontend

**PRISMA** : Sources : Martin Fowler, bulletproof-react, Spring guides | Trouves=12 | Filtres=8 | Inclus=4

| # | Source | URL | Pyramide | Annee | Data point | CoI |
|---|--------|-----|----------|-------|------------|-----|
| S1 | Martin Fowler - Modularizing React | https://martinfowler.com/articles/modularizing-react-apps.html | 5-Expert reconnu | 2023 | Feature-based = meilleure cohesion, couches utilisees pour separation interne | Aucun |
| S2 | bulletproof-react | https://github.com/alan2207/bulletproof-react/blob/master/docs/project-structure.md | 3-Ref. communautaire | 2024 | Feature-based recommande, code organise par features/ | Aucun |
| S3 | Spring Boot structure | https://rifaiio.medium.com/spring-boot-project-structure-best-practices-layer-based-vs-feature-based-explained-simply-4a9002f3cff0 | 4-Analyse | 2025 | Layer-based pour petites apps, feature-based pour equipes/gros projets | Aucun |
| S4 | React project structure | https://www.developerway.com/posts/react-project-structure | 4-Analyse | 2024 | Feature-based = meilleure scalabilite, moins de couplage inter-features | Aucun |

**Qualite** : S1=8.0 S2=6.5 S3=5.0 S4=6.0

**GRADE** : Depart MODEREE (pas d'enquete, expert + analyses) | +0.5 (unanimite) | = **MODEREE**
Sensibilite : toutes les sources convergent → retrait d'une ne change rien. Reco stable.

**Recommandation** : **Feature-based** | GRADE=MODEREE | Niveau=BONNE_PRATIQUE
> Unanimite des sources : feature-based superieur en cohesion et scalabilite pour projets multi-modules. OLS utilise deja ce pattern (architecture confirmee).

---

## Decision 7 — Rendering strategy (CSR vs SSR vs SSG)

**PICOC** : P=plateforme e-learning interactive | I=CSR (SPA React+Vite) | C=SSR, SSG, hybride | O=performance, SEO, complexite | C=app authentifiee, contenu dynamique (quiz, chat, labo)

**PRISMA** : Sources : react.dev, Next.js docs, analyses techniques | Trouves=14 | Filtres=9 | Inclus=4

| # | Source | URL | Pyramide | Annee | Data point | CoI |
|---|--------|-----|----------|-------|------------|-----|
| S1 | react.dev | https://react.dev/learn/start-a-new-react-project | 1-Doc officielle | 2025 | Recommande framework (Next.js) ou Vite pour SPA | Meta |
| S2 | Strapi rendering guide | https://strapi.io/blog/what-is-website-rendering | 4-Analyse | 2025 | CSR ideal pour SPA, dashboards, outils internes. SSR pour SEO | Aucun |
| S3 | AntStack guide | https://www.antstack.com/blog/understanding-when-to-use-what-rendering-strategy-csr-ssg-ssr/ | 4-Analyse | 2025 | CSR pour apps interactives authentifiees, SSG pour contenu statique | Aucun |
| S4 | Next.js rendering | https://dev.to/rayan2228/nextjs-rendering-strategies-csr-vs-ssr-vs-ssg-vs-isr-complete-guide-26j4 | 4-Analyse | 2025 | CSR = moins de charge serveur, ideal pour apps derriere auth | Aucun |

**Qualite** : S1=8.5 S2=5.5 S3=5.0 S4=5.0

**GRADE** : Depart MODEREE | -0 | = **MODEREE**
Sensibilite : retrait S1 (doc React) → analyses confirment CSR pour apps authentifiees. SSR non justifie (pas de SEO critique derriere login). Reco stable.

**Recommandation** : **CSR (SPA Vite)** | GRADE=MODEREE | Niveau=RECOMMANDE
> App 100% authentifiee, contenu dynamique (chat, quiz, labo). SSR = complexite sans benefice SEO (contenu derriere auth). CSR via Vite = plus simple, plus rapide a dev.

---

## Decision 8 — State management (Zustand vs Redux vs Jotai vs Signals)

**PICOC** : P=SPA React 19 multi-modules | I=Zustand | C=Redux Toolkit, Jotai, Signals | O=simplicite, performance, taille bundle | C=stores modulaires (chat, lab, auth)

**PRISMA** : Sources : State of JS, npm trends, react.dev | Trouves=14 | Filtres=9 | Inclus=5

| # | Source | URL | Pyramide | Annee | Data point | CoI |
|---|--------|-----|----------|-------|------------|-----|
| S1 | npm trends | https://npmtrends.com/jotai-vs-redux-vs-zustand | 3-Donnees adoption | 2026 | Zustand 27.5M dl/sem (#1), Redux 26.9M (#2), Jotai 3.3M (#3) | Aucun |
| S2 | State of JS 2025 | https://2025.stateofjs.com/ | 2-Enquete | 2025 | Zustand croissance +150%, devs quittent Redux pour alternatives legeres | Aucun |
| S3 | PkgPulse analysis | https://www.pkgpulse.com/blog/react-state-management-2026 | 4-Analyse | 2026 | Zustand ~1.2KB, meilleur defaut pour small-to-medium apps | Aucun |
| S4 | Better Stack comparison | https://betterstack.com/community/guides/scaling-nodejs/zustand-vs-redux-toolkit-vs-jotai/ | 4-Analyse | 2025 | Zustand : API minimale, pas de boilerplate, perf equivalente Redux | Aucun |
| S5 | Makers Den | https://makersden.io/blog/react-state-management-in-2025 | 4-Analyse | 2025 | Redux pour equipes 10+ devs, Zustand pour le reste | Aucun |

**Qualite** : S1=7.0 S2=9.0 S3=5.5 S4=6.0 S5=5.5

**GRADE** : Depart HAUTE (enquete + donnees adoption) | -0 | = **HAUTE**
Sensibilite : retrait S2 → npm trends suffit (Zustand #1). Retrait S1 → State of JS confirme tendance. Redux justifie seulement pour equipes 10+. Reco stable.

**Recommandation** : **Zustand** | GRADE=HAUTE | Niveau=STANDARD
> #1 downloads npm (27.5M/sem), +150% croissance, 1.2KB, API minimale. Redux Toolkit = over-engineering pour equipe 2 devs. Deja en place sur OLS.

---

## Decision 9 — HTTP client (fetch vs axios vs WebClient vs httpx)

**PICOC** : P=SPA React (frontend) + Spring Boot (backend) | I=fetch natif (frontend), WebClient (backend) | C=axios, httpx | O=taille bundle, fonctionnalites, maintenance | C=multi-stack

**PRISMA** : Sources : npm trends, LogRocket, Spring docs | Trouves=12 | Filtres=8 | Inclus=4

| # | Source | URL | Pyramide | Annee | Data point | CoI |
|---|--------|-----|----------|-------|------------|-----|
| S1 | LogRocket axios vs fetch 2025 | https://blog.logrocket.com/axios-vs-fetch-2025/ | 4-Analyse | 2025 | Fetch = baseline 2025 (natif browser + Node 18+), Axios = upgrade feature-rich | LogRocket |
| S2 | Spring WebClient doc | https://docs.spring.io/spring-framework/reference/web/webflux-webclient.html | 1-Doc officielle | 2025 | WebClient = client HTTP reactif recommande, remplace RestTemplate | Pivotal |
| S3 | npm trends axios | https://npmtrends.com/axios | 3-Donnees adoption | 2025 | Axios ~45M dl/sem, mais fetch natif = 0 dependency | Aucun |
| S4 | OpenReplay comparison | https://blog.openreplay.com/axios-vs-fetch-api-guide-http-requests-2025/ | 4-Analyse | 2025 | Axios : interceptors, auto JSON, error handling. Fetch : natif, leger | Aucun |

**Qualite** : S1=6.0 S2=8.5 S3=7.0 S4=5.5

**GRADE** : Depart MODEREE | -0 | = **MODEREE**
Sensibilite : fetch vs axios = choix equipe cote frontend. WebClient = standard Spring cote backend. Reco stable.

**Variantes** : JS Frontend→fetch natif ou axios | Java Backend→WebClient (Spring) | Python→httpx (async) ou requests

**Recommandation** : **fetch natif (frontend) + WebClient (backend)** | GRADE=MODEREE | Niveau=CHOIX_EQUIPE
> Frontend : fetch natif = 0 dependency, suffisant pour OLS (pas besoin d'interceptors complexes). Backend : WebClient = recommandation officielle Spring. Axios valide si besoin interceptors.

---

## Decision 10 — Scaling strategy (monolith-first vs microservices)

**PICOC** : P=startup 2 devs, MVP | I=monolith-first | C=microservices from start | O=velocity, cout infra, simplicite | C=e-learning < 10k users prevu

**PRISMA** : Sources : Martin Fowler, SO Survey, analyses | Trouves=10 | Filtres=7 | Inclus=4

| # | Source | URL | Pyramide | Annee | Data point | CoI |
|---|--------|-----|----------|-------|------------|-----|
| S1 | Martin Fowler - Monolith First | https://martinfowler.com/bliki/MonolithFirst.html | 5-Expert reconnu | 2015 (maj) | "Almost all successful microservice stories started with a monolith" | Aucun |
| S2 | Fowler - Microservices Guide | https://martinfowler.com/microservices/ | 5-Expert reconnu | 2023 | Microservices = equipes 50+ devs, >$10M revenue | Aucun |
| S3 | Java Code Geeks 2025 | https://www.javacodegeeks.com/2025/12/microservices-vs-modular-monoliths-in-2025-when-each-approach-wins.html | 4-Analyse | 2025 | Modular monolith = meilleur compromis, microservices benefits sans complexite distribuee | Aucun |
| S4 | ByteIota Amazon case | https://byteiota.com/monolith-vs-microservices-2025-when-amazon-cuts-costs-90/ | 4-Analyse | 2025 | Amazon Prime Video : retour au monolithe, -90% couts | Aucun |

**Qualite** : S1=8.0 S2=8.0 S3=5.5 S4=5.5

**GRADE** : Depart HAUTE (expert reconnu + coherence forte) | -0 | = **HAUTE**
Sensibilite : retrait Fowler → Amazon case + Java Code Geeks confirment. Retrait tout sauf Fowler → suffit (autorite domaine). Reco stable.
Biais : courant anti-microservices 2024-2025 mais donnees Amazon objectives.

**Recommandation** : **Monolith-first (modulaire)** | GRADE=HAUTE | Niveau=STANDARD
> Unanimite : monolith-first pour equipe < 50 devs. Microservices = over-engineering premature. OLS = monolithe modulaire Spring Boot, migration possible si besoin futur.

---

## Decision 11 — OpenAPI documentation (springdoc vs @nestjs/swagger vs drf-spectacular)

**PICOC** : P=API REST Spring Boot | I=springdoc-openapi | C=@nestjs/swagger, drf-spectacular | O=auto-generation, maintenance, compatibilite | C=Spring Boot 4.x, Java 21

**PRISMA** : Sources : springdoc.org, Spring.io, Baeldung | Trouves=10 | Filtres=7 | Inclus=4

| # | Source | URL | Pyramide | Annee | Data point | CoI |
|---|--------|-----|----------|-------|------------|-----|
| S1 | springdoc.org | https://springdoc.org/ | 1-Doc officielle | 2025 | springdoc v2.8.x, supporte Spring Boot 3.x/4.x, Java 21, OpenAPI 3.1 | Aucun |
| S2 | Spring.io Baeldung | https://www.baeldung.com/spring-rest-openapi-documentation | 4-Tutoriel ref | 2025 | springdoc = seule option production-grade, SpringFox abandonne | Aucun |
| S3 | GitHub springdoc | https://github.com/springdoc/springdoc-openapi | 3-Donnees adoption | 2025 | 3.4k stars, releases regulieres, support Actuator/Security/Hateoas | Aucun |
| S4 | Migration guide | https://springdoc.org/migrating-from-springfox.html | 1-Doc officielle | 2025 | SpringFox → springdoc = migration recommandee, SpringFox deprecie | Aucun |

**Qualite** : S1=8.5 S2=6.0 S3=7.0 S4=8.0

**GRADE** : Depart HAUTE (pas d'alternative viable en Spring) | -0 | = **HAUTE**
Sensibilite : pas d'alternative → decision triviale. SpringFox mort, springdoc = seul choix. Reco stable.

**Variantes** : Java/Spring→springdoc-openapi | TS/NestJS→@nestjs/swagger | Python/Django→drf-spectacular (DRF) ou FastAPI (builtin)

**Recommandation** : **springdoc-openapi** | GRADE=HAUTE | Niveau=STANDARD
> Seule option production-grade pour Spring Boot 4.x. SpringFox abandonne. Auto-generation OpenAPI 3.1, zero-config, supporte tout l'ecosysteme Spring.

---

## Decision 12 — Web mobile strategy (PWA vs Capacitor vs React Native)

**PICOC** : P=app e-learning web-first | I=PWA | C=Capacitor, React Native | O=cout dev, reutilisation code, UX mobile | C=equipe web 2 devs, pas de dev natif

**PRISMA** : Sources : nextnative, Ionic blog, comparatifs | Trouves=12 | Filtres=8 | Inclus=4

| # | Source | URL | Pyramide | Annee | Data point | CoI |
|---|--------|-----|----------|-------|------------|-----|
| S1 | nextnative PWA vs Native | https://nextnative.dev/comparisons/pwa-vs-native-app | 4-Analyse | 2025 | PWA = 0 cout store, meme codebase, offline via Service Worker | Aucun |
| S2 | Ionic blog | https://ionic.io/blog/the-native-app-vs-progressive-web-app-debate-is-completely-flawed | 4-Analyse | 2025 | Capacitor = pont web→natif, reutilise 100% du code web | Ionic (vendor) |
| S3 | nextnative Capacitor vs RN | https://nextnative.dev/blog/capacitor-vs-react-native | 4-Analyse | 2025 | Capacitor market share < 5%, RN 8-42%. Capacitor ideal pour equipes web | Aucun |
| S4 | Progressier comparison | https://progressier.com/pwa-vs-native-app-comparison-table | 4-Analyse | 2026 | PWA : push notifs (iOS 16.4+), install prompt, fonctionne offline | Aucun |

**Qualite** : S1=5.5 S2=5.0 S3=5.5 S4=5.0

**GRADE** : Depart BASSE (pas d'enquete, analyses seulement) | +0.5 (coherence) | = **BASSE**
Sensibilite : retrait S2 (vendor Ionic) → PWA reste optimal pour web-first. Si besoin store futur → Capacitor wrapping. Reco stable.
Biais : S2 vendor Ionic/Capacitor. Sans S2, PWA reste recommande.

**Recommandation** : **PWA** (+ Capacitor futur si store necessaire) | GRADE=BASSE | Niveau=CHOIX_EQUIPE
> PWA = 0 cout supplementaire, meme codebase React, offline via SW, push notifs iOS 16.4+. React Native = codebase separee, sur-cout inacceptable pour 2 devs. Capacitor = option future pour publier sur stores sans rewrite.

---

## Synthese

| # | Decision | Choix | GRADE | Niveau | Alternatives viables |
|---|----------|-------|-------|--------|---------------------|
| 1 | Backend framework | Spring Boot | HAUTE | STANDARD | NestJS (TS), Django (Python) |
| 2 | Frontend framework | React | HAUTE | STANDARD | Vue (si DX prioritaire) |
| 3 | Database | PostgreSQL | HAUTE | STANDARD | Aucune |
| 4 | API protocol | REST | HAUTE | STANDARD | GraphQL (si agreg. complexe) |
| 5 | API versioning | URL path (/v1/) | MODEREE | RECOMMANDE | Header (REST puriste) |
| 6 | Module structure | Feature-based | MODEREE | BONNE_PRATIQUE | Layer-based (petits projets) |
| 7 | Rendering strategy | CSR (SPA Vite) | MODEREE | RECOMMANDE | SSR (si SEO critique) |
| 8 | State management | Zustand | HAUTE | STANDARD | Redux Toolkit (equipe 10+) |
| 9 | HTTP client | fetch + WebClient | MODEREE | CHOIX_EQUIPE | axios (si interceptors) |
| 10 | Scaling strategy | Monolith-first | HAUTE | STANDARD | Microservices (50+ devs) |
| 11 | OpenAPI doc | springdoc-openapi | HAUTE | STANDARD | Aucune (Spring Boot) |
| 12 | Web mobile | PWA | BASSE | CHOIX_EQUIPE | Capacitor (store futur) |
