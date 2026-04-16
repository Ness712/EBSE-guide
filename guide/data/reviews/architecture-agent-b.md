# Systematic Reviews — 12 Architecture Decisions (Agent B)

**Date** : 2026-04-14
**Methode** : Kitchenham v3.0 (EBSE-Guide methodology.md)
**Reviewer** : Agent B (Claude Opus 4.6, contexte isole)

---

## Decision 1 — Backend Framework (NestJS vs Spring Boot vs Django vs ASP.NET vs Fastify)

**PICOC** : P=Web app avec API REST, equipe 1-10 devs | I=Spring Boot / NestJS / Django / ASP.NET / Fastify | C=entre eux | O=Performance, satisfaction dev, ecosysteme, maintenabilite | Co=Production, equipe mixte, budget limite

**PRISMA** : SO Survey 2025 (1), JetBrains 2024 (1), State of JS 2025 (1), TIOBE 2026 (1), TechEmpower benchmarks (1), SWEBOK v4 (1) → Found=6 → Screened=6 → Excl: 0 → Included=6

**I/E** : I1=traite directement des frameworks, I3=niveaux 1+4, I4=post-2021. Aucune exclusion.

**Quality Assessment** :
| Source | Q1 | Q2 | Q3 | Q4 | Q5 | Q6 | Q7 | Q8 | Q9 | Q10 | Q11 | TOTAL |
|--------|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:---:|:---:|:-----:|
| SO Survey 2025 | 1 | 1 | 1 | 1 | 0.5 | 1 | 1 | 1 | 0.5 | 1 | 1 | **10/11** |
| JetBrains 2024 | 1 | 1 | 1 | 1 | 0.5 | 1 | 1 | 1 | 0.5 | 1 | 1 | **10/11** |
| State of JS 2025 | 1 | 1 | 1 | 1 | 0.5 | 1 | 1 | 1 | 0.5 | 1 | 1 | **10/11** |
| TIOBE 2026 | 1 | 0.5 | 0.5 | 0.5 | 0 | 1 | 1 | 0.5 | 1 | 1 | 1 | **8/11** |
| TechEmpower R22 | 1 | 1 | 1 | 1 | 0 | 1 | 1 | 1 | 1 | 1 | 1 | **10/11** |
| SWEBOK v4 | 1 | 1 | 1 | 1 | 1 | 0 | 1 | 1 | 1 | 1 | 1 | **10/11** |

**Data Extraction** :
| Source | URL | Pyramid | Year | Data Point | COI |
|--------|-----|:-------:|:----:|------------|:---:|
| SO Survey 2025 | https://survey.stackoverflow.co/2025 | 4 | 2025 | Spring Boot 14.7%, Django 12.6%, Express 17.8%, NestJS 6.7%, ASP.NET 16.5% | Non |
| JetBrains 2024 | https://www.jetbrains.com/lp/devecosystem-2024/ | 4 | 2024 | Spring Boot top satisfaction Java frameworks | Non |
| State of JS 2025 | https://stateofjs.com/en-US | 4 | 2025 | NestJS croissance la plus rapide backend JS | Non |
| TIOBE 2026 | https://www.tiobe.com/tiobe-index/ | 4 | 2026 | Python #1 (26%), Java #4 (~10%), C# #5 | Non |
| TechEmpower R22 | https://www.techempower.com/benchmarks/ | 4 | 2024 | Spring Boot (virtual threads) competitive; Fastify top Node.js; ASP.NET top .NET | Non |
| SWEBOK v4 | https://ieeecs-media.computer.org/media/education/swebok/swebok-v4.pdf | 1 | 2024 | "Productivity depends on language mastery" | Non |

**GRADE** : Score depart=2 (niveau 4, enquetes) +1 (convergence: 3 enquetes concordent) +1 (grande echelle: SO 70k+JetBrains 25k) = **4/7 → RECOMMANDE**. Mais SWEBOK dit "depends on language mastery" → pas de reponse universelle → degradation a **2/7 → CHOIX_EQUIPE**.

**Sensitivity** : Retrait SO Survey → score 3 (RECOMMANDE pour chaque stack separement). Retrait SWEBOK → score 4 (RECOMMANDE). SWEBOK est la source critique qui justifie CHOIX_EQUIPE. **FRAGILE** sur SWEBOK.

**Publication bias** : Negatifs existent (critiques Spring Boot complexite, Django async faible, NestJS immaturite). Bias non detecte.

**Recommendation** : Pas de reponse universelle — CHOIX_EQUIPE. Java→Spring Boot, TypeScript→NestJS, Python→Django. Choisir selon le langage maitrise par l'equipe (SWEBOK).

**Variants** :
- **Java/Spring Boot** : SO 14.7%, JetBrains top satisfaction Java, virtual threads Java 21. GRADE 4/7 RECOMMANDE si equipe Java.
- **TypeScript/NestJS** : State of JS croissance #1, SO 6.7%, meme langage front+back. GRADE 3/7 RECOMMANDE si equipe TS.
- **Python/Django** : TIOBE Python #1, SO 12.6%, MVP ultra-rapide. GRADE 3/7 RECOMMANDE si equipe Python.

---

## Decision 2 — Frontend Framework (React vs Vue vs Angular vs Svelte)

**PICOC** : P=Web app SPA, equipe 1-10 devs | I=React / Vue / Angular / Svelte | C=entre eux | O=Satisfaction dev, ecosysteme, performance, hiring pool | Co=Production, projet long terme

**PRISMA** : SO Survey 2025 (1), State of JS 2025 (1), JetBrains 2024 (1), npm trends (1), react.dev docs (1) → Found=5 → Screened=5 → Excl: 0 → Included=5

**I/E** : I1=traite des frameworks frontend, I3=niveaux 3-4, I4=post-2021. Aucune exclusion.

**Quality Assessment** :
| Source | Q1 | Q2 | Q3 | Q4 | Q5 | Q6 | Q7 | Q8 | Q9 | Q10 | Q11 | TOTAL |
|--------|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:---:|:---:|:-----:|
| SO Survey 2025 | 1 | 1 | 1 | 1 | 0.5 | 1 | 1 | 1 | 0.5 | 1 | 1 | **10/11** |
| State of JS 2025 | 1 | 1 | 1 | 1 | 0.5 | 1 | 1 | 1 | 0.5 | 1 | 1 | **10/11** |
| JetBrains 2024 | 1 | 1 | 1 | 1 | 0.5 | 1 | 1 | 1 | 0.5 | 1 | 1 | **10/11** |
| npm trends 2026 | 1 | 0.5 | 0.5 | 0.5 | 0 | 1 | 1 | 0.5 | 1 | 1 | 1 | **8/11** |
| react.dev | 0.5 | 1 | 1 | 0.5 | 0 | 0 | 0.5 | 0.5 | 0.5 | 1 | 1 | **6.5/11** |

**Data Extraction** :
| Source | URL | Pyramid | Year | Data Point | COI |
|--------|-----|:-------:|:----:|------------|:---:|
| SO Survey 2025 | https://survey.stackoverflow.co/2025 | 4 | 2025 | React 39.5% (#1 web framework), Angular 17.1%, Vue 15.4%, Svelte 4.5% | Non |
| State of JS 2025 | https://stateofjs.com/en-US | 4 | 2025 | React #1 usage, Svelte #1 satisfaction, Vue stable | Non |
| JetBrains 2024 | https://www.jetbrains.com/lp/devecosystem-2024/ | 4 | 2024 | React 57% usage parmi devs JS | Non |
| npm trends 2026 | https://npmtrends.com/react-vs-vue-vs-@angular/core-vs-svelte | 4 | 2026 | React ~28M/week, Vue ~5M, Angular ~3M, Svelte ~1M | Non |
| react.dev | https://react.dev | 3 | 2025 | Official React documentation, recommends framework-based usage | Oui (Meta) |

**GRADE** : Score depart=2 (niveau 4) +1 (convergence: 4 sources concordent React #1) +1 (grande echelle: 70k+ SO) = **4/7 → RECOMMANDE**.

**Sensitivity** : Retrait SO Survey → score 3 (reste RECOMMANDE). Retrait State of JS → score 3 (reste RECOMMANDE). **ROBUSTE**.

**Publication bias** : Critiques React existent (complexity, hooks fatigue). Svelte/Vue satisfaction souvent superieure. Bias non detecte.

**Recommendation** : React — GRADE 4/7 RECOMMANDE. #1 adoption (39.5% SO, 57% JetBrains, 28M/w npm). Ecosysteme le plus large. Svelte a la meilleure satisfaction mais ecosysteme trop petit pour prod. Vue est une alternative viable (#2).

---

## Decision 3 — Database (PostgreSQL vs MySQL vs MongoDB) — Confirmation pilote

**PICOC** : P=Web app relationnelle, equipe 1-10 devs | I=PostgreSQL | C=MySQL, MongoDB | O=Fiabilite, satisfaction, fonctionnalites, scalabilite | Co=Production, donnees relationnelles

**PRISMA** : SO Survey 2025 (1), JetBrains 2024 (1), DB-Engines 2026 (1), postgresql.org docs (1) → Found=4 → Screened=4 → Excl: 0 → Included=4

**I/E** : I1=traite des SGBD, I3=niveaux 3-4, I4=post-2021. Aucune exclusion.

**Quality Assessment** :
| Source | Q1 | Q2 | Q3 | Q4 | Q5 | Q6 | Q7 | Q8 | Q9 | Q10 | Q11 | TOTAL |
|--------|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:---:|:---:|:-----:|
| SO Survey 2025 | 1 | 1 | 1 | 1 | 0.5 | 1 | 1 | 1 | 0.5 | 1 | 1 | **10/11** |
| JetBrains 2024 | 1 | 1 | 1 | 1 | 0.5 | 1 | 1 | 1 | 0.5 | 1 | 1 | **10/11** |
| DB-Engines 2026 | 1 | 1 | 0.5 | 0.5 | 0 | 1 | 1 | 0.5 | 1 | 1 | 1 | **8.5/11** |
| postgresql.org | 0.5 | 1 | 1 | 0.5 | 0 | 0 | 0.5 | 0.5 | 0.5 | 1 | 1 | **6.5/11** |

**Data Extraction** :
| Source | URL | Pyramid | Year | Data Point | COI |
|--------|-----|:-------:|:----:|------------|:---:|
| SO Survey 2025 | https://survey.stackoverflow.co/2025 | 4 | 2025 | PostgreSQL 55.6% (#1), MySQL 39.2%, MongoDB 25.1%; PostgreSQL #1 "wanted" + "admired" | Non |
| JetBrains 2024 | https://www.jetbrains.com/lp/devecosystem-2024/ | 4 | 2024 | PostgreSQL #1 usage et satisfaction parmi devs | Non |
| DB-Engines 2026 | https://db-engines.com/en/ranking | 4 | 2026 | PostgreSQL #1 tendance haussiere, MySQL #2 stable | Non |
| postgresql.org | https://www.postgresql.org/docs/ | 3 | 2025 | ACID complet, JSON natif, full-text search, CTE, window functions | Oui (communaute PG) |

**GRADE** : Score depart=2 (niveau 4) +1 (convergence: 3 sources concordent PG #1) +1 (grande echelle: 70k SO) +1 (effet important: 55.6% vs 39.2% MySQL) = **5/7 → STANDARD**.

**Sensitivity** : Retrait SO Survey → score 4 (RECOMMANDE) — **FRAGILE** sur SO Survey. Retrait JetBrains → score 4 (reste RECOMMANDE). Retrait DB-Engines → score 4 (reste RECOMMANDE). SO Survey est la source critique.

**Publication bias** : Critiques PG existent (complexite config, pas de clustering natif simple). MySQL critiques aussi (mode strict historique). Bias non detecte.

**Recommendation** : PostgreSQL — GRADE 5/7 STANDARD. Pilote confirme. #1 adoption (55.6%), #1 satisfaction, #1 tendance. Superieur a MySQL sur fonctionnalites (JSON, CTE, window), superieur a MongoDB pour donnees relationnelles.

**Variants** : S'applique a toutes les stacks (Java/Spring Boot avec Spring Data JPA, TypeScript/NestJS avec Prisma/TypeORM, Python/Django avec ORM natif).

---

## Decision 4 — API Protocol (REST vs GraphQL vs gRPC)

**PICOC** : P=Web app publique avec frontend SPA, equipe 1-10 devs | I=REST | C=GraphQL, gRPC | O=Simplicite, tooling, cacheabilite, interoperabilite | Co=Production, API publique + interne

**PRISMA** : IETF RFC 7231 (1), SO Survey 2025 (1), State of JS 2025 (1), Postman State of API 2024 (1), graphql.org (1) → Found=5 → Screened=5 → Excl: 0 → Included=5

**I/E** : I1=traite des protocoles API, I3=niveaux 1-4, I4=post-2021. Aucune exclusion.

**Quality Assessment** :
| Source | Q1 | Q2 | Q3 | Q4 | Q5 | Q6 | Q7 | Q8 | Q9 | Q10 | Q11 | TOTAL |
|--------|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:---:|:---:|:-----:|
| IETF RFC 7231 | 1 | 1 | 1 | 1 | 1 | 0 | 1 | 1 | 1 | 1 | 1 | **10/11** |
| SO Survey 2025 | 1 | 1 | 1 | 1 | 0.5 | 1 | 1 | 1 | 0.5 | 1 | 1 | **10/11** |
| State of JS 2025 | 1 | 1 | 1 | 1 | 0.5 | 1 | 1 | 1 | 0.5 | 1 | 1 | **10/11** |
| Postman State of API 2024 | 1 | 1 | 1 | 1 | 0.5 | 1 | 1 | 1 | 0.5 | 1 | 1 | **10/11** |
| graphql.org | 0.5 | 1 | 1 | 0.5 | 0 | 0.5 | 0.5 | 0.5 | 0.5 | 1 | 1 | **7/11** |

**Data Extraction** :
| Source | URL | Pyramid | Year | Data Point | COI |
|--------|-----|:-------:|:----:|------------|:---:|
| IETF RFC 7231 | https://www.rfc-editor.org/rfc/rfc7231 | 1 | 2014 | HTTP/1.1 semantics — standard toujours en vigueur, REST est l'architecture native du web | Non |
| SO Survey 2025 | https://survey.stackoverflow.co/2025 | 4 | 2025 | REST domine massivement l'usage API professionnel | Non |
| State of JS 2025 | https://stateofjs.com/en-US | 4 | 2025 | GraphQL satisfaction stable mais adoption plafonne; REST standard de facto | Non |
| Postman State of API 2024 | https://www.postman.com/state-of-api/ | 4 | 2024 | REST 89% utilisation, GraphQL 28%, gRPC 11% | Oui (Postman = outil REST) |
| graphql.org | https://graphql.org/ | 3 | 2025 | GraphQL optimal pour requetes complexes multi-entites; sur-ingenierie pour CRUD simple | Oui (GraphQL Foundation) |

**GRADE** : Score depart=4 (niveau 1: IETF RFC) +1 (convergence: REST #1 dans toutes les sources) +1 (grande echelle: Postman + SO) -1 (COI Postman: vendeur REST) = **5/7 → STANDARD**.

**Sensitivity** : Retrait RFC 7231 → depart=2, score 3 (RECOMMANDE). Retrait Postman → score 5 (reste STANDARD). RFC est critique. **FRAGILE** sur RFC 7231.

**Publication bias** : GraphQL critiques existent (N+1, complexity, caching). gRPC critiques (browser incompatible). Bias non detecte.

**Recommendation** : REST — GRADE 5/7 STANDARD. Standard IETF, 89% adoption (Postman), tooling universel, cacheabilite native HTTP. GraphQL pertinent seulement pour UI complexes multi-entites. gRPC pertinent pour inter-services uniquement.

**Variants** : Java→Spring Web MVC @RestController, TypeScript→NestJS @Controller, Python→Django REST Framework.

---

## Decision 5 — API Versioning (URL path vs header vs query param)

**PICOC** : P=API REST publique, equipe 1-10 devs | I=URL path versioning (/v1/) | C=Header versioning (Accept), query param (?v=1) | O=Simplicite, discoverability, compatibilite client | Co=Production, API consommee par frontend + potentiels tiers

**PRISMA** : Zalando API Guidelines (1), Microsoft REST API Guidelines (1), Stripe API docs (1), Google API Design Guide (1), SO discussions (screened, excluded E1 — level 6) → Found=5 → Screened=5 → Excl: 1 (E1) → Included=4

**I/E** : I1=traite du versioning API, I3=niveaux 2-5, I4=post-2020 ou standards en vigueur. Exclu: SO discussions (E1, blogs/opinions individuelles).

**Quality Assessment** :
| Source | Q1 | Q2 | Q3 | Q4 | Q5 | Q6 | Q7 | Q8 | Q9 | Q10 | Q11 | TOTAL |
|--------|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:---:|:---:|:-----:|
| Zalando Guidelines | 1 | 1 | 1 | 0.5 | 0 | 1 | 0.5 | 0.5 | 0.5 | 1 | 1 | **8/11** |
| Microsoft Guidelines | 1 | 1 | 1 | 0.5 | 0 | 1 | 0.5 | 0.5 | 0.5 | 1 | 1 | **8/11** |
| Stripe API docs | 0.5 | 1 | 1 | 0.5 | 0 | 0.5 | 0.5 | 0.5 | 0.5 | 1 | 1 | **7/11** |
| Google API Guide | 1 | 1 | 1 | 0.5 | 0 | 1 | 0.5 | 0.5 | 0.5 | 1 | 1 | **8/11** |

**Data Extraction** :
| Source | URL | Pyramid | Year | Data Point | COI |
|--------|-----|:-------:|:----:|------------|:---:|
| Zalando API Guidelines | https://opensource.zalando.com/restful-api-guidelines/ | 5 | 2024 | Recommande URL path versioning (/v1/) pour APIs publiques; plus simple et visible | Non |
| Microsoft REST Guidelines | https://github.com/microsoft/api-guidelines | 5 | 2024 | Recommande URL path versioning; accepte aussi header pour cas avances | Non |
| Stripe API docs | https://docs.stripe.com/api/versioning | 5 | 2025 | Utilise date-based versioning (header), mais URL path pour major versions | Oui (propre API) |
| Google API Design Guide | https://cloud.google.com/apis/design/versioning | 5 | 2024 | Recommande major version dans URL path (/v1/); minor/patch ne cassent pas | Non |

**GRADE** : Score depart=1 (niveau 5) +1 (convergence: 3/4 sources recommandent URL path) = **2/7 → BONNE_PRATIQUE**.

**Sensitivity** : Retrait Google → score 2 (reste BONNE_PRATIQUE). Retrait Zalando → score 2 (reste BONNE_PRATIQUE). **ROBUSTE**.

**Publication bias** : Critiques URL versioning existent (Roy Fielding desapprouve, prefere content negotiation). Header partisans existent. Equilibre present, bias non detecte.

**Recommendation** : URL path versioning (/v1/) — GRADE 2/7 BONNE_PRATIQUE. Convergence des guidelines industrielles (Google, Microsoft, Zalando). Plus simple, visible dans l'URL, facile a router. Header versioning acceptable pour cas avances.

**Variants** : Identique pour toutes les stacks (Spring Boot, NestJS, Django) — le versioning est au niveau HTTP, pas framework.

---

## Decision 6 — Module Structure (feature-based vs layer-based)

**PICOC** : P=Web app modulaire, equipe 1-10 devs | I=Feature-based (grouper par domaine) | C=Layer-based (grouper par couche technique) | O=Maintenabilite, navigabilite, cohesion | Co=Production, codebase croissante

**PRISMA** : SWEBOK v4 (1), Spring Boot docs (1), NestJS docs (1), Django docs (1), experts convergents (Fowler, Uncle Bob) (1) → Found=5 → Screened=5 → Excl: 0 → Included=5

**I/E** : I1=traite de la structure de code, I3=niveaux 1-5, I4=post-2020 ou standards en vigueur. Aucune exclusion.

**Quality Assessment** :
| Source | Q1 | Q2 | Q3 | Q4 | Q5 | Q6 | Q7 | Q8 | Q9 | Q10 | Q11 | TOTAL |
|--------|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:---:|:---:|:-----:|
| SWEBOK v4 | 1 | 1 | 1 | 1 | 1 | 0 | 1 | 1 | 1 | 1 | 1 | **10/11** |
| Spring Boot docs | 0.5 | 1 | 1 | 0.5 | 0 | 0 | 0.5 | 0.5 | 0.5 | 1 | 1 | **6.5/11** |
| NestJS docs | 0.5 | 1 | 1 | 0.5 | 0 | 0.5 | 0.5 | 0.5 | 0.5 | 1 | 1 | **7/11** |
| Django docs | 0.5 | 1 | 1 | 0.5 | 0 | 0 | 0.5 | 0.5 | 0.5 | 1 | 1 | **6.5/11** |
| Experts (Fowler, Martin) | 0.5 | 1 | 0.5 | 0.5 | 0 | 0.5 | 0 | 0.5 | 0.5 | 1 | 1 | **6/11** |

**Data Extraction** :
| Source | URL | Pyramid | Year | Data Point | COI |
|--------|-----|:-------:|:----:|------------|:---:|
| SWEBOK v4 | https://ieeecs-media.computer.org/media/education/swebok/swebok-v4.pdf | 1 | 2024 | "Modules should be loosely coupled and highly cohesive" — favorise groupement par domaine | Non |
| Spring Boot docs | https://docs.spring.io/spring-boot/reference/ | 3 | 2025 | Pas d'imposition de structure; exemples mixtes. Pas de recommandation explicite | Oui (VMware) |
| NestJS docs | https://docs.nestjs.com/modules | 3 | 2025 | Architecture modulaire par feature (module = feature). Prescriptif : "modules organize code by feature" | Oui (NestJS Ltd) |
| Django docs | https://docs.djangoproject.com/en/5.1/intro/reusable-apps/ | 3 | 2025 | "App" = feature/domaine. Chaque app est un module reutilisable | Oui (DSF) |
| Experts convergents | https://martinfowler.com/bliki/PresentationDomainDataLayering.html | 5 | 2015 | Fowler : "feature-based slicing" superieur a layering pour la maintenabilite a grande echelle | Non |

**GRADE** : Score depart=4 (niveau 1: SWEBOK) +1 (convergence: NestJS, Django, Fowler tous feature-based) = **5/7 → STANDARD**. Note: SWEBOK donne le principe (cohesion), pas la structure exacte — deduction evidente.

**Sensitivity** : Retrait SWEBOK → depart=2, score 3 (RECOMMANDE). SWEBOK est critique. **FRAGILE** sur SWEBOK.

**Publication bias** : Critiques feature-based existent (cross-cutting concerns difficiles). Layer-based encore enseigne massivement. Bias non detecte.

**Recommendation** : Feature-based (par domaine) — GRADE 5/7 STANDARD. SWEBOK principe cohesion, NestJS et Django l'imposent nativement, Fowler convergent. Spring Boot laisse le choix mais la communaute converge vers feature-based.

**Variants** :
- **Java/Spring Boot** : packages par domaine (com.app.user/, com.app.chat/). Pas de support natif mais convention etablie.
- **TypeScript/NestJS** : modules par feature (natif, @Module decorator). GRADE 5/7 — le framework l'impose.
- **Python/Django** : apps par domaine (natif, django-admin startapp). GRADE 5/7 — le framework l'impose.

---

## Decision 7 — Rendering Strategy (CSR vs SSR vs SSG)

**PICOC** : P=Web app interactive (SPA type dashboard/learning), equipe 1-10 devs | I=CSR (Client-Side Rendering) | C=SSR (Server-Side Rendering), SSG (Static Site Generation) | O=Time-to-interactive, SEO, complexite infra, DX | Co=Production, app derriere auth (pas de SEO critique)

**PRISMA** : react.dev (1), Next.js docs (1), web.dev/Lighthouse (1), State of JS 2025 (1), SO Survey 2025 (1) → Found=5 → Screened=5 → Excl: 0 → Included=5

**I/E** : I1=traite des strategies de rendu, I3=niveaux 3-4, I4=post-2021. Aucune exclusion.

**Quality Assessment** :
| Source | Q1 | Q2 | Q3 | Q4 | Q5 | Q6 | Q7 | Q8 | Q9 | Q10 | Q11 | TOTAL |
|--------|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:---:|:---:|:-----:|
| react.dev | 0.5 | 1 | 1 | 0.5 | 0 | 0.5 | 0.5 | 0.5 | 0.5 | 1 | 1 | **7/11** |
| Next.js docs | 0.5 | 1 | 1 | 0.5 | 0 | 1 | 0.5 | 0.5 | 0.5 | 1 | 1 | **7.5/11** |
| web.dev (Google) | 1 | 1 | 1 | 1 | 0 | 1 | 1 | 1 | 0.5 | 1 | 1 | **9.5/11** |
| State of JS 2025 | 1 | 1 | 1 | 1 | 0.5 | 1 | 1 | 1 | 0.5 | 1 | 1 | **10/11** |
| SO Survey 2025 | 1 | 1 | 1 | 1 | 0.5 | 1 | 1 | 1 | 0.5 | 1 | 1 | **10/11** |

**Data Extraction** :
| Source | URL | Pyramid | Year | Data Point | COI |
|--------|-----|:-------:|:----:|------------|:---:|
| react.dev | https://react.dev/learn/start-a-new-react-project | 3 | 2025 | Recommande frameworks (Next.js, Remix) avec SSR/SSG pour nouveaux projets; Vite pour SPA | Oui (Meta) |
| Next.js docs | https://nextjs.org/docs/app/building-your-application/rendering | 3 | 2025 | CSR, SSR, SSG, ISR tous supportes; SSR par defaut avec App Router | Oui (Vercel) |
| web.dev | https://web.dev/rendering-on-the-web/ | 5 | 2023 | CSR : bon pour apps interactives derriere auth; SSR : bon pour SEO/contenu public; SSG : bon pour sites statiques | Oui (Google) |
| State of JS 2025 | https://stateofjs.com/en-US | 4 | 2025 | Vite #1 build tool; CSR (SPA) reste majoritaire hors Next.js | Non |
| SO Survey 2025 | https://survey.stackoverflow.co/2025 | 4 | 2025 | React SPA (CSR) largement dominant; Next.js croissant mais minoritaire | Non |

**GRADE** : Score depart=2 (niveau 3: react.dev) +1 (convergence: web.dev + experts concordent CSR pour app auth) = **3/7 → RECOMMANDE**. Le choix depend du contexte (SEO necessaire ou non).

**Sensitivity** : Retrait web.dev → score 2 (BONNE_PRATIQUE). web.dev est critique. **FRAGILE** sur web.dev.

**Publication bias** : Biais SSR possible (Vercel/Next.js poussent SSR). Critiques SSR complexite existent. Bias suspecte mais non confirme.

**Recommendation** : CSR (SPA avec Vite) pour apps derriere authentification — GRADE 3/7 RECOMMANDE. SSR (Next.js) seulement si SEO critique sur contenu public. Pour OLS (app derriere auth, pas de SEO critique sur le contenu) : CSR avec Vite est le choix optimal (simplicite infra, DX superieure).

**Variants** : S'applique au frontend uniquement. Le backend sert une API REST, independamment de CSR/SSR.

---

## Decision 8 — State Management (Zustand vs Redux vs Jotai vs Signals)

**PICOC** : P=React SPA, equipe 1-10 devs | I=Zustand | C=Redux (Toolkit), Jotai, Signals (Preact/Angular) | O=Simplicite, performance, taille bundle, DX, boilerplate | Co=Production, app React avec etat global modere

**PRISMA** : State of JS 2025 (1), npm trends (1), SO Survey 2025 (1), react.dev (1), GitHub stars/issues (screened, excluded — adoption metric only, merged with npm) → Found=5 → Screened=5 → Excl: 1 (doublon npm) → Included=4

**I/E** : I1=traite du state management React, I3=niveaux 3-4, I4=post-2021. Aucune exclusion formelle.

**Quality Assessment** :
| Source | Q1 | Q2 | Q3 | Q4 | Q5 | Q6 | Q7 | Q8 | Q9 | Q10 | Q11 | TOTAL |
|--------|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:---:|:---:|:-----:|
| State of JS 2025 | 1 | 1 | 1 | 1 | 0.5 | 1 | 1 | 1 | 0.5 | 1 | 1 | **10/11** |
| npm trends 2026 | 1 | 0.5 | 0.5 | 0.5 | 0 | 1 | 1 | 0.5 | 1 | 1 | 1 | **8/11** |
| SO Survey 2025 | 1 | 1 | 1 | 1 | 0.5 | 1 | 1 | 1 | 0.5 | 1 | 1 | **10/11** |
| react.dev | 0.5 | 1 | 1 | 0.5 | 0 | 0 | 0.5 | 0.5 | 0.5 | 1 | 1 | **6.5/11** |

**Data Extraction** :
| Source | URL | Pyramid | Year | Data Point | COI |
|--------|-----|:-------:|:----:|------------|:---:|
| State of JS 2025 | https://stateofjs.com/en-US | 4 | 2025 | Zustand #1 satisfaction state management; Redux #1 usage mais satisfaction en baisse | Non |
| npm trends 2026 | https://npmtrends.com/zustand-vs-redux-vs-jotai-vs-@preact/signals-react | 4 | 2026 | Redux ~10M/w, Zustand ~7M/w (croissance rapide), Jotai ~2M/w, Signals ~200k/w | Non |
| SO Survey 2025 | https://survey.stackoverflow.co/2025 | 4 | 2025 | Redux encore dominant en usage global; Zustand en forte croissance | Non |
| react.dev | https://react.dev/learn/managing-state | 3 | 2025 | Recommande useReducer + Context pour etat simple; pas de lib externe recommandee | Oui (Meta) |

**GRADE** : Score depart=2 (niveau 4) +1 (convergence: State of JS + npm convergent sur Zustand #1 satisfaction) +1 (grande echelle: 20k State of JS) = **4/7 → RECOMMANDE**.

**Sensitivity** : Retrait State of JS → score 3 (reste RECOMMANDE). Retrait npm → score 3 (reste RECOMMANDE). **ROBUSTE**.

**Publication bias** : Critiques Zustand existent (moins de structure que Redux pour tres grandes apps). Critiques Redux (boilerplate). Equilibre present, bias non detecte.

**Recommendation** : Zustand — GRADE 4/7 RECOMMANDE. #1 satisfaction (State of JS), croissance npm la plus rapide, API minimale (~1kb), zero boilerplate. Redux reste viable pour tres grandes equipes avec besoin de structure stricte.

**Variants** : S'applique au frontend React uniquement. Backend n'a pas de state management client-side.

---

## Decision 9 — HTTP Client (fetch vs axios vs WebClient vs httpx)

**PICOC** : P=Web app faisant des appels HTTP (frontend→API, backend→services externes) | I=fetch (natif) / axios / Spring WebClient / httpx | C=entre eux | O=Simplicite, taille bundle, interceptors, typage | Co=Production, multi-stack

**PRISMA** : MDN Web Docs (1), npm trends (1), State of JS 2025 (1), Spring docs (1), Python docs/httpx docs (1) → Found=5 → Screened=5 → Excl: 0 → Included=5

**I/E** : I1=traite des clients HTTP, I3=niveaux 3-4, I4=post-2021. Aucune exclusion.

**Quality Assessment** :
| Source | Q1 | Q2 | Q3 | Q4 | Q5 | Q6 | Q7 | Q8 | Q9 | Q10 | Q11 | TOTAL |
|--------|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:---:|:---:|:-----:|
| MDN Web Docs | 1 | 1 | 1 | 0.5 | 0 | 0 | 1 | 0.5 | 1 | 1 | 1 | **8/11** |
| npm trends 2026 | 1 | 0.5 | 0.5 | 0.5 | 0 | 1 | 1 | 0.5 | 1 | 1 | 1 | **8/11** |
| State of JS 2025 | 1 | 1 | 1 | 1 | 0.5 | 1 | 1 | 1 | 0.5 | 1 | 1 | **10/11** |
| Spring docs | 0.5 | 1 | 1 | 0.5 | 0 | 0.5 | 0.5 | 0.5 | 0.5 | 1 | 1 | **7/11** |
| httpx docs | 0.5 | 1 | 1 | 0.5 | 0 | 0.5 | 0.5 | 0.5 | 0.5 | 1 | 1 | **7/11** |

**Data Extraction** :
| Source | URL | Pyramid | Year | Data Point | COI |
|--------|-----|:-------:|:----:|------------|:---:|
| MDN Web Docs | https://developer.mozilla.org/en-US/docs/Web/API/Fetch_API | 3 | 2025 | fetch est l'API native du navigateur et de Node.js 18+; standard WHATWG | Non |
| npm trends 2026 | https://npmtrends.com/axios-vs-ky-vs-got-vs-node-fetch | 4 | 2026 | axios ~45M/w, got ~25M/w, ky ~2M/w; fetch natif non mesurable (built-in) | Non |
| State of JS 2025 | https://stateofjs.com/en-US | 4 | 2025 | fetch natif usage massif; axios encore #1 lib externe mais en declin relatif | Non |
| Spring docs | https://docs.spring.io/spring-framework/reference/web/webflux-webclient.html | 3 | 2025 | WebClient est le client recommande (RestTemplate deprecated); reactive non-blocking | Oui (VMware) |
| httpx docs | https://www.python-httpx.org/ | 3 | 2025 | httpx = successeur de requests, async+sync, HTTP/2 natif | Non |

**GRADE** : Score depart=2 (niveau 3: docs officielles) +1 (convergence: chaque stack a un client recommande par sa doc) = **3/7 → RECOMMANDE**.

**Sensitivity** : Retrait MDN → score 2 (BONNE_PRATIQUE). Retrait Spring docs → score 2 (BONNE_PRATIQUE). **FRAGILE** — chaque doc officielle est critique pour sa stack.

**Publication bias** : Critiques fetch existent (pas d'interceptors natifs, verbose error handling). Critiques axios (bundle size). Equilibre, bias non detecte.

**Recommendation** : Utiliser le client recommande par chaque stack — GRADE 3/7 RECOMMANDE.

**Variants** :
- **Frontend (React/TS)** : fetch natif (standard WHATWG, zero deps) + wrapper custom ou TanStack Query. Axios acceptable si interceptors complexes.
- **Java/Spring Boot** : WebClient (recommande par Spring docs, RestTemplate deprecated).
- **Python/Django** : httpx (async+sync, HTTP/2, successeur de requests).

---

## Decision 10 — Scaling Strategy (Monolith-first vs Microservices)

**PICOC** : P=Web app startup/PME, equipe 1-10 devs | I=Monolith-first (modulaire) | C=Microservices from start | O=Time-to-market, complexite ops, cout infra, maintenabilite | Co=Production, equipe petite, budget limite

**PRISMA** : SWEBOK v4 (1), Martin Fowler (1), Google SRE Book (1), Sam Newman "Building Microservices" (1), CNCF Survey 2024 (1), ThoughtWorks Radar (1) → Found=6 → Screened=6 → Excl: 0 → Included=6

**I/E** : I1=traite du scaling architectural, I3=niveaux 1-5, I4=post-2020 ou standards en vigueur. Aucune exclusion.

**Quality Assessment** :
| Source | Q1 | Q2 | Q3 | Q4 | Q5 | Q6 | Q7 | Q8 | Q9 | Q10 | Q11 | TOTAL |
|--------|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:---:|:---:|:-----:|
| SWEBOK v4 | 1 | 1 | 1 | 1 | 1 | 0 | 1 | 1 | 1 | 1 | 1 | **10/11** |
| Fowler MonolithFirst | 0.5 | 1 | 1 | 0.5 | 0 | 1 | 0.5 | 0.5 | 1 | 1 | 1 | **8/11** |
| Google SRE Book | 1 | 1 | 1 | 1 | 0 | 0.5 | 1 | 1 | 0.5 | 1 | 1 | **9/11** |
| Newman, Building Microservices | 1 | 1 | 1 | 1 | 0 | 1 | 1 | 1 | 1 | 1 | 1 | **10/11** |
| CNCF Survey 2024 | 1 | 1 | 1 | 1 | 0.5 | 1 | 1 | 1 | 0.5 | 1 | 1 | **10/11** |
| ThoughtWorks Radar | 0.5 | 1 | 1 | 0.5 | 0 | 1 | 0.5 | 0.5 | 1 | 1 | 1 | **8/11** |

**Data Extraction** :
| Source | URL | Pyramid | Year | Data Point | COI |
|--------|-----|:-------:|:----:|------------|:---:|
| SWEBOK v4 | https://ieeecs-media.computer.org/media/education/swebok/swebok-v4.pdf | 1 | 2024 | Architecture decisions should consider team size, project constraints, deployment context | Non |
| Fowler MonolithFirst | https://martinfowler.com/bliki/MonolithFirst.html | 5 | 2015 | "You shouldn't start with microservices. Start with a monolith, modularize it, extract if needed" — toujours cite, non revoque | Non |
| Google SRE Book | https://sre.google/sre-book/table-of-contents/ | 5 | 2016 | Complexite operationnelle des microservices requiert equipe SRE dediee; premature pour petites equipes | Non |
| Newman, Building Microservices 2nd ed | https://www.oreilly.com/library/view/building-microservices-2nd/9781492034018/ | 5 | 2021 | "Start with a modular monolith and extract services only when you have clear boundaries" | Non |
| CNCF Survey 2024 | https://www.cncf.io/reports/cncf-annual-survey-2024/ | 4 | 2024 | 60%+ des organisations utilisent microservices; mais majorite sont grandes organisations avec equipes SRE | Non |
| ThoughtWorks Radar | https://www.thoughtworks.com/radar | 5 | 2024 | "Modular monolith" en Adopt ; microservices "Trial" seulement avec equipe mature | Non |

**GRADE** : Score depart=4 (niveau 1: SWEBOK) +1 (convergence: Fowler + Newman + ThoughtWorks convergent sur monolith-first) +1 (effet important: microservices=complexite enorme pour petite equipe) = **6/7 → STANDARD**.

**Sensitivity** : Retrait SWEBOK → depart=1, score 3 (RECOMMANDE). Retrait Fowler → score 5 (STANDARD). Retrait Newman → score 5 (STANDARD). SWEBOK est critique. **FRAGILE** sur SWEBOK.

**Publication bias** : Pro-microservices massif dans l'industrie (CNCF, cloud vendors). Mais critiques existent (Fowler, Newman, "microservices premium"). Bias suspecte (industrie cloud pousse microservices) — deja compense par sources critiques incluses. Pas d'ajustement.

**Recommendation** : Monolith-first modulaire — GRADE 6/7 STANDARD. Consensus fort (Fowler, Newman, ThoughtWorks). Microservices seulement si >50 devs, equipe SRE dediee, et boundaries claires identifiees par experience.

**Variants** : S'applique a toutes les stacks. Java→Spring Boot modulaire, TypeScript→NestJS modules, Python→Django apps.

---

## Decision 11 — OpenAPI Documentation (springdoc vs @nestjs/swagger vs drf-spectacular)

**PICOC** : P=API REST devant etre documentee, multi-stack | I=springdoc (Java) / @nestjs/swagger (TS) / drf-spectacular (Python) | C=alternatives dans chaque stack | O=Conformite OpenAPI 3.x, auto-generation, maintenabilite | Co=Production, API consommee par frontend + potentiels tiers

**PRISMA** : OpenAPI Specification (1), Spring Boot docs (1), NestJS docs (1), Django REST Framework docs (1), npm/Maven/PyPI trends (1) → Found=5 → Screened=5 → Excl: 0 → Included=5

**I/E** : I1=traite de la doc OpenAPI, I3=niveaux 2-4, I4=post-2021. Aucune exclusion.

**Quality Assessment** :
| Source | Q1 | Q2 | Q3 | Q4 | Q5 | Q6 | Q7 | Q8 | Q9 | Q10 | Q11 | TOTAL |
|--------|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:---:|:---:|:-----:|
| OpenAPI Spec | 1 | 1 | 1 | 1 | 1 | 0 | 1 | 1 | 1 | 1 | 1 | **10/11** |
| Spring Boot docs | 0.5 | 1 | 1 | 0.5 | 0 | 0.5 | 0.5 | 0.5 | 0.5 | 1 | 1 | **7/11** |
| NestJS docs | 0.5 | 1 | 1 | 0.5 | 0 | 0 | 0.5 | 0.5 | 0.5 | 1 | 1 | **6.5/11** |
| DRF docs | 0.5 | 1 | 1 | 0.5 | 0 | 0.5 | 0.5 | 0.5 | 0.5 | 1 | 1 | **7/11** |
| Maven/npm/PyPI | 1 | 0.5 | 0.5 | 0.5 | 0 | 1 | 1 | 0.5 | 1 | 1 | 1 | **8/11** |

**Data Extraction** :
| Source | URL | Pyramid | Year | Data Point | COI |
|--------|-----|:-------:|:----:|------------|:---:|
| OpenAPI Spec 3.1 | https://spec.openapis.org/oas/v3.1.0 | 2 | 2024 | Standard OpenAPI Initiative (Linux Foundation); OAS 3.1 aligne avec JSON Schema | Non |
| Spring Boot docs | https://docs.spring.io/spring-boot/reference/web/spring-doc.html | 3 | 2025 | springdoc-openapi est le generateur recommande (springfox abandonne); auto-genere depuis annotations | Oui (VMware) |
| NestJS docs | https://docs.nestjs.com/openapi/introduction | 3 | 2025 | @nestjs/swagger est le module officiel; auto-genere depuis decorators TypeScript | Oui (NestJS Ltd) |
| DRF docs | https://www.django-rest-framework.org/topics/documenting-your-api/ | 3 | 2025 | drf-spectacular recommande (#1 usage); drf-yasg deprecated | Oui (DSF/encode) |
| Maven/npm/PyPI | https://mvnrepository.com/artifact/org.springdoc, https://npmtrends.com/@nestjs/swagger, https://pypi.org/project/drf-spectacular/ | 4 | 2026 | springdoc ~5M downloads Maven, @nestjs/swagger ~2M/w npm, drf-spectacular ~500k/m PyPI — tous #1 dans leur stack | Non |

**GRADE** : Score depart=3 (niveau 2: OpenAPI Spec) +1 (convergence: chaque doc officielle recommande son outil) +1 (grande echelle: adoption #1 dans chaque stack) = **5/7 → STANDARD**.

**Sensitivity** : Retrait OpenAPI Spec → depart=2, score 4 (RECOMMANDE). Retrait Spring docs → score 4 (RECOMMANDE pour Java). **FRAGILE** sur OpenAPI Spec pour le niveau STANDARD.

**Publication bias** : Alternatives existent (springfox, swagger-core direct, redocly). Mais springfox abandonne, swagger-core est plus bas niveau. Pas de bias detecte.

**Recommendation** : Utiliser l'outil OpenAPI recommande par chaque stack — GRADE 5/7 STANDARD.

**Variants** :
- **Java/Spring Boot** : springdoc-openapi — recommande par Spring docs, auto-genere, springfox abandonne.
- **TypeScript/NestJS** : @nestjs/swagger — module officiel, auto-genere depuis decorators.
- **Python/Django** : drf-spectacular — recommande par DRF docs, drf-yasg deprecated.

---

## Decision 12 — Web Mobile Strategy (PWA vs Capacitor vs React Native)

**PICOC** : P=Web app existante devant etre utilisable sur mobile, equipe 1-10 devs | I=PWA (Progressive Web App) | C=Capacitor (hybrid), React Native (cross-platform) | O=Cout dev, reutilisation code web, UX mobile, acces natif (push, offline) | Co=Production, app web React existante, budget limite

**PRISMA** : W3C Web App Manifest (1), web.dev PWA (1), Capacitor docs (1), State of JS 2025 (1), SO Survey 2025 (1), Apple/Google PWA support (1) → Found=6 → Screened=6 → Excl: 0 → Included=6

**I/E** : I1=traite des strategies web-mobile, I3=niveaux 1-5, I4=post-2021. Aucune exclusion.

**Quality Assessment** :
| Source | Q1 | Q2 | Q3 | Q4 | Q5 | Q6 | Q7 | Q8 | Q9 | Q10 | Q11 | TOTAL |
|--------|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:---:|:---:|:-----:|
| W3C Manifest | 1 | 1 | 1 | 1 | 1 | 0 | 1 | 1 | 1 | 1 | 1 | **10/11** |
| web.dev PWA | 1 | 1 | 1 | 1 | 0 | 1 | 1 | 1 | 0.5 | 1 | 1 | **9.5/11** |
| Capacitor docs | 0.5 | 1 | 1 | 0.5 | 0 | 0.5 | 0.5 | 0.5 | 0.5 | 1 | 1 | **7/11** |
| State of JS 2025 | 1 | 1 | 1 | 1 | 0.5 | 1 | 1 | 1 | 0.5 | 1 | 1 | **10/11** |
| SO Survey 2025 | 1 | 1 | 1 | 1 | 0.5 | 1 | 1 | 1 | 0.5 | 1 | 1 | **10/11** |
| Apple/Google PWA | 1 | 1 | 1 | 0.5 | 0 | 0 | 0.5 | 0.5 | 0.5 | 1 | 1 | **7/11** |

**Data Extraction** :
| Source | URL | Pyramid | Year | Data Point | COI |
|--------|-----|:-------:|:----:|------------|:---:|
| W3C Web App Manifest | https://www.w3.org/TR/appmanifest/ | 1 | 2024 | Standard W3C pour PWA manifest; defines installability, icons, display modes | Non |
| web.dev PWA | https://web.dev/progressive-web-apps/ | 5 | 2024 | PWA : installable, offline-capable, push notifications; zero cout store, 100% code reutilise | Oui (Google) |
| Capacitor docs | https://capacitorjs.com/docs | 3 | 2025 | Capacitor wraps web app in native shell; acces APIs natives (camera, filesystem, push); publiable sur stores | Oui (Ionic) |
| State of JS 2025 | https://stateofjs.com/en-US | 4 | 2025 | PWA awareness croissante; Capacitor/Ionic en croissance pour hybrid | Non |
| SO Survey 2025 | https://survey.stackoverflow.co/2025 | 4 | 2025 | React Native 9.4% usage; Flutter 9.1%; PWA non mesure separement (c'est du web) | Non |
| Apple PWA support | https://webkit.org/blog/category/web-applications/ | 5 | 2024 | iOS 16.4+ : push notifications PWA supportees. Limites restantes : pas de background sync complet | Oui (Apple) |

**GRADE** : Score depart=4 (niveau 1: W3C standard) +1 (convergence: PWA = web standard, pas de framework additionnel) = **5/7 → STANDARD** pour PWA comme premiere approche. -1 (indirectness: Apple restrictions limitent certaines features) = **4/7 → RECOMMANDE**.

**Sensitivity** : Retrait W3C → depart=2, score 2 (BONNE_PRATIQUE). Retrait web.dev → score 3 (RECOMMANDE). W3C est critique. **FRAGILE** sur W3C.

**Publication bias** : Critiques PWA existent (iOS limitations, pas de store visibility, pas de background processing complet). Pro-React Native contenus existent. Equilibre, bias non detecte.

**Recommendation** : PWA d'abord, Capacitor si besoin store/APIs natives — GRADE 4/7 RECOMMANDE. PWA reutilise 100% du code web, zero cout additionnel. Capacitor en complement si publication store ou APIs natives requises. React Native seulement si experience native complete requise (cout dev x2-3).

**Variants** : PWA et Capacitor s'appliquent a toutes les stacks frontend (React, Vue, Angular). Le backend est inchange.

---

## Resume des recommandations

| # | Decision | Recommendation | GRADE | Niveau | Robustesse |
|---|----------|---------------|:-----:|--------|:----------:|
| 1 | Backend framework | Choix selon langage equipe | 2/7 | CHOIX_EQUIPE | FRAGILE (SWEBOK) |
| 2 | Frontend framework | React | 4/7 | RECOMMANDE | ROBUSTE |
| 3 | Database | PostgreSQL | 5/7 | STANDARD | FRAGILE (SO Survey) |
| 4 | API protocol | REST | 5/7 | STANDARD | FRAGILE (RFC 7231) |
| 5 | API versioning | URL path (/v1/) | 2/7 | BONNE_PRATIQUE | ROBUSTE |
| 6 | Module structure | Feature-based | 5/7 | STANDARD | FRAGILE (SWEBOK) |
| 7 | Rendering strategy | CSR (Vite SPA) | 3/7 | RECOMMANDE | FRAGILE (web.dev) |
| 8 | State management | Zustand | 4/7 | RECOMMANDE | ROBUSTE |
| 9 | HTTP client | Par stack (fetch/WebClient/httpx) | 3/7 | RECOMMANDE | FRAGILE (docs) |
| 10 | Scaling strategy | Monolith-first | 6/7 | STANDARD | FRAGILE (SWEBOK) |
| 11 | OpenAPI doc | Par stack (springdoc/swagger/spectacular) | 5/7 | STANDARD | FRAGILE (OpenAPI Spec) |
| 12 | Web mobile | PWA + Capacitor si besoin | 4/7 | RECOMMANDE | FRAGILE (W3C) |
