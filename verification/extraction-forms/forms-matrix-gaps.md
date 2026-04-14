# Fiches d'extraction -- 17 nouvelles pages de guide

Date d'extraction : 2026-04-14

---

## Architecture

### rendering-strategy.md

SOURCE 1:
  Nom: Vite docs — SPA mode par defaut
  URL: voir docs officielles (vitejs.dev)
  Niveau pyramide: 3 (documentation officielle)
  Date: 2025-2026
  Citation: Vite fonctionne en mode SPA par defaut, zero config SSR
  Conflit d'interet: non

SOURCE 2:
  Nom: web.dev Core Web Vitals — LCP/FCP metrics
  URL: voir docs officielles (web.dev)
  Niveau pyramide: 3 (documentation officielle / guide Google)
  Date: 2025-2026
  Citation: Metriques LCP/FCP pour comparer les strategies de rendu
  Conflit d'interet: oui — Google promeut ses propres metriques et frameworks (Next.js indirectement via Vercel/Chrome team)

SOURCE 3:
  Nom: Next.js docs — SSR/SSG tradeoffs
  URL: voir docs officielles (nextjs.org)
  Niveau pyramide: 3 (documentation officielle)
  Date: 2025-2026
  Citation: Comparaison SSR vs SSG et leurs compromis
  Conflit d'interet: oui — Vercel (editeur de Next.js) a interet a promouvoir SSR/SSG qui necessite leur plateforme

SOURCE 4:
  Nom: Google Search Central — SPA indexing
  URL: voir docs officielles (developers.google.com/search)
  Niveau pyramide: 3 (documentation officielle)
  Date: 2025-2026
  Citation: Les SPA ont un SEO faible comparees aux pages rendues cote serveur
  Conflit d'interet: non

---

### state-management.md

SOURCE 1:
  Nom: npm trends 2025-2026 — Zustand #1 croissance
  URL: voir npmtrends.com
  Niveau pyramide: 4 (donnees quantitatives agregees)
  Date: 2025-2026
  Citation: Zustand est la librairie de state management avec la plus forte croissance
  Conflit d'interet: non

SOURCE 2:
  Nom: State of JS 2024 — satisfaction Zustand 96%
  URL: voir stateofjs.com
  Niveau pyramide: 4 (enquete communautaire large)
  Date: 2024
  Citation: Zustand a un taux de satisfaction de 96%
  Conflit d'interet: non — enquete independante

SOURCE 3:
  Nom: Zustand docs — "no providers, no boilerplate"
  URL: voir docs officielles (github.com/pmndrs/zustand)
  Niveau pyramide: 3 (documentation officielle)
  Date: 2025-2026
  Citation: Zustand ne necessite pas de Provider wrapper et a un boilerplate minimal
  Conflit d'interet: oui — auto-promotion de la librairie

SOURCE 4:
  Nom: React docs — useState pour etat local
  URL: voir docs officielles (react.dev)
  Niveau pyramide: 3 (documentation officielle)
  Date: 2025-2026
  Citation: useState est suffisant pour l'etat local au composant
  Conflit d'interet: non

---

### http-client.md

SOURCE 1:
  Nom: Spring Boot 3.2+ docs — RestClient
  URL: voir docs officielles (docs.spring.io)
  Niveau pyramide: 3 (documentation officielle)
  Date: 2024-2026
  Citation: RestClient est le remplacement moderne de RestTemplate depuis Spring 6.1
  Conflit d'interet: oui — VMware/Broadcom (editeur Spring) promeut son propre ecosysteme

SOURCE 2:
  Nom: MDN fetch API
  URL: voir docs officielles (developer.mozilla.org)
  Niveau pyramide: 3 (documentation officielle)
  Date: 2025-2026
  Citation: fetch est l'API standard native du navigateur, zero dependance
  Conflit d'interet: non

SOURCE 3:
  Nom: Spring WebClient docs
  URL: voir docs officielles (docs.spring.io)
  Niveau pyramide: 3 (documentation officielle)
  Date: 2025-2026
  Citation: WebClient est recommande pour les appels HTTP reactifs (WebFlux)
  Conflit d'interet: oui — meme editeur que Spring Boot

SOURCE 4:
  Nom: Twelve-Factor IV — services externes = attached resources
  URL: voir 12factor.net
  Niveau pyramide: 5 (consensus d'experts / reference methodologique)
  Date: 2012 (intemporel)
  Citation: Les services externes doivent etre traites comme des ressources attachees
  Conflit d'interet: oui — ecrit par Heroku (Adam Wiggins), qui beneficie de l'adoption de ces principes cloud-native

---

### scaling.md

SOURCE 1:
  Nom: Fowler "MonolithFirst"
  URL: voir martinfowler.com
  Niveau pyramide: 5 (opinion d'expert reconnu)
  Date: 2015
  Citation: Commencer par un monolithe, les microservices sont rarement justifies au debut
  Conflit d'interet: oui — Fowler est consultant ThoughtWorks, qui vend des services de migration/architecture

SOURCE 2:
  Nom: Twelve-Factor VI — stateless processes
  URL: voir 12factor.net
  Niveau pyramide: 5 (consensus d'experts / reference methodologique)
  Date: 2012 (intemporel)
  Citation: Les processus doivent etre stateless pour permettre le scale horizontal
  Conflit d'interet: oui — ecrit par Heroku

SOURCE 3:
  Nom: Docker Compose deploy docs — replicas
  URL: voir docs officielles (docs.docker.com)
  Niveau pyramide: 3 (documentation officielle)
  Date: 2025-2026
  Citation: Docker Compose supporte la configuration de replicas pour le scale horizontal
  Conflit d'interet: oui — Docker Inc. promeut son ecosysteme

SOURCE 4:
  Nom: Spring Session Redis docs
  URL: voir docs officielles (docs.spring.io)
  Niveau pyramide: 3 (documentation officielle)
  Date: 2025-2026
  Citation: Spring Session avec Redis permet d'externaliser les sessions pour les apps stateless
  Conflit d'interet: oui — VMware/Broadcom promeut Spring

---

### backend-framework.md

SOURCE 1:
  Nom: SO Survey 2025 (49k devs)
  URL: voir survey.stackoverflow.co
  Niveau pyramide: 4 (enquete large echelle)
  Date: 2025
  Citation: Spring Boot 14.7% usage, NestJS 6.7%, Django 12.6%, ASP.NET Core 14.2%
  Conflit d'interet: non — Stack Overflow est independant des frameworks

SOURCE 2:
  Nom: JetBrains 2024 (23k devs)
  URL: voir jetbrains.com/lp/devecosystem
  Niveau pyramide: 4 (enquete large echelle)
  Date: 2024
  Citation: Donnees d'adoption et satisfaction des frameworks backend
  Conflit d'interet: oui — JetBrains vend des IDE (IntelliJ pour Java/Spring, PyCharm pour Django, etc.)

SOURCE 3:
  Nom: State of JS 2025
  URL: voir stateofjs.com
  Niveau pyramide: 4 (enquete communautaire)
  Date: 2025
  Citation: NestJS a la croissance la plus rapide parmi les frameworks JS
  Conflit d'interet: non

SOURCE 4:
  Nom: TIOBE 2026
  URL: voir tiobe.com/tiobe-index
  Niveau pyramide: 4 (index de popularite)
  Date: 2026
  Citation: Python #1 avec 26% de part
  Conflit d'interet: non

SOURCE 5:
  Nom: SWEBOK v4 "SE Economics — productivity depends on language mastery"
  URL: voir ieee.org / swebok.org
  Niveau pyramide: 1 (body of knowledge valide par consensus academique IEEE)
  Date: 2024
  Citation: La productivite depend de la maitrise du langage par l'equipe
  Conflit d'interet: non — IEEE est un organisme independant

---

### frontend-framework.md

SOURCE 1:
  Nom: SO Survey 2025 (49k devs)
  URL: voir survey.stackoverflow.co
  Niveau pyramide: 4 (enquete large echelle)
  Date: 2025
  Citation: React 44.7% usage (#1), Vue 17.6%, Svelte 7.2%
  Conflit d'interet: non

SOURCE 2:
  Nom: State of JS 2025 (20k devs)
  URL: voir stateofjs.com
  Niveau pyramide: 4 (enquete communautaire)
  Date: 2025
  Citation: React satisfaction 82.95%, Vue 77.32%, Svelte 89.62%
  Conflit d'interet: non

SOURCE 3:
  Nom: JetBrains 2024 (23k devs)
  URL: voir jetbrains.com/lp/devecosystem
  Niveau pyramide: 4 (enquete large echelle)
  Date: 2024
  Citation: Donnees d'adoption des frameworks frontend
  Conflit d'interet: oui — JetBrains vend WebStorm

SOURCE 4:
  Nom: npm trends
  URL: voir npmtrends.com
  Niveau pyramide: 4 (donnees quantitatives)
  Date: 2025-2026
  Citation: React 34M dl/semaine, Vue 4.3M, Svelte 1.4M
  Conflit d'interet: non

SOURCE 5:
  Nom: GitHub stars
  URL: voir github.com
  Niveau pyramide: 4 (donnees quantitatives)
  Date: 2025-2026
  Citation: React 266k stars, Vue 235k, Svelte 91k
  Conflit d'interet: non — indicateur de popularite brut (mais les stars ne mesurent pas la qualite)

---

## Operations

### reverse-proxy.md

SOURCE 1:
  Nom: Caddy docs — automatic HTTPS
  URL: voir docs officielles (caddyserver.com/docs)
  Niveau pyramide: 3 (documentation officielle)
  Date: 2025-2026
  Citation: Caddy provisionne automatiquement les certificats Let's Encrypt
  Conflit d'interet: oui — auto-promotion de Caddy

SOURCE 2:
  Nom: Let's Encrypt stats — 300M+ certificats actifs
  URL: voir letsencrypt.org/stats
  Niveau pyramide: 3 (donnees factuelles de l'organisme)
  Date: 2025-2026
  Citation: Let's Encrypt a emis plus de 300 millions de certificats actifs
  Conflit d'interet: non

SOURCE 3:
  Nom: Nginx docs
  URL: voir docs officielles (nginx.org/en/docs)
  Niveau pyramide: 3 (documentation officielle)
  Date: 2025-2026
  Citation: Nginx offre une performance legerement superieure a tres haute charge
  Conflit d'interet: oui — F5/Nginx Inc. promeut Nginx Plus (version payante)

SOURCE 4:
  Nom: OWASP TLS guidelines
  URL: voir owasp.org
  Niveau pyramide: 2 (guide de reference securite, consensus d'experts)
  Date: 2025-2026
  Citation: Bonnes pratiques TLS (HSTS, headers de securite)
  Conflit d'interet: non — OWASP est un organisme independant a but non lucratif

---

### incident-response.md

SOURCE 1:
  Nom: Google SRE Book ch.15 — postmortem culture
  URL: voir sre.google/sre-book/postmortem-culture
  Niveau pyramide: 5 (ouvrage de reference industrie, Google)
  Date: 2016 (reeditions)
  Citation: Culture postmortem blameless, documentation des incidents dans les 48h
  Conflit d'interet: oui — Google promeut ses pratiques et indirectement ses outils (GCP, etc.)

SOURCE 2:
  Nom: PagerDuty Incident Response guide
  URL: voir pagerduty.com/resources
  Niveau pyramide: 3 (guide d'un vendeur, mais bien documente)
  Date: 2024-2025
  Citation: Processus structure de reponse aux incidents (identifier, contenir, resoudre, communiquer)
  Conflit d'interet: oui — PagerDuty vend un produit d'incident management

SOURCE 3:
  Nom: Etsy "blameless postmortems"
  URL: voir codeascraft.com
  Niveau pyramide: 4 (retour d'experience d'une entreprise a grande echelle)
  Date: 2012-2016
  Citation: Les postmortems blameless ameliorent la culture d'equipe et la fiabilite
  Conflit d'interet: non — partage de pratiques internes, pas de produit vendu

---

## Performance

### jvm-tuning.md

SOURCE 1:
  Nom: Oracle JVM Tuning Guide Java 21
  URL: voir docs officielles (docs.oracle.com)
  Niveau pyramide: 3 (documentation officielle)
  Date: 2023-2026
  Citation: G1GC est le GC par defaut de Java 21, heap fixe recommande en prod
  Conflit d'interet: oui — Oracle est l'editeur de Java et vend des licences JDK commerciales

SOURCE 2:
  Nom: Spring Boot Docker docs — container-aware JVM
  URL: voir docs officielles (docs.spring.io)
  Niveau pyramide: 3 (documentation officielle)
  Date: 2025-2026
  Citation: La JVM est container-aware depuis Java 10, respecte les limites cgroups Docker
  Conflit d'interet: oui — VMware/Broadcom promeut Spring Boot

SOURCE 3:
  Nom: Eclipse Temurin — distribution recommandee
  URL: voir adoptium.net
  Niveau pyramide: 3 (documentation officielle)
  Date: 2025-2026
  Citation: Eclipse Temurin est la distribution JDK recommandee (open source, Adoptium)
  Conflit d'interet: non — Eclipse Foundation est a but non lucratif

SOURCE 4:
  Nom: Twelve-Factor V — build/release/run
  URL: voir 12factor.net
  Niveau pyramide: 5 (consensus d'experts / reference methodologique)
  Date: 2012 (intemporel)
  Citation: Separation stricte entre build, release et run
  Conflit d'interet: oui — ecrit par Heroku

---

### image-optimization.md

SOURCE 1:
  Nom: web.dev — image optimization guide
  URL: voir web.dev
  Niveau pyramide: 3 (guide Google / documentation)
  Date: 2025-2026
  Citation: Utiliser WebP/AVIF, lazy loading et responsive srcset pour optimiser les images
  Conflit d'interet: oui — Google promeut ses formats (WebP est cree par Google) et son ecosysteme (Chrome, Lighthouse)

SOURCE 2:
  Nom: HTTP Archive 2025 — images = 50% page weight
  URL: voir httparchive.org
  Niveau pyramide: 4 (donnees quantitatives a grande echelle)
  Date: 2025
  Citation: Les images representent environ 50% du poids des pages web
  Conflit d'interet: non — HTTP Archive est un projet open data independant

SOURCE 3:
  Nom: MDN — loading="lazy"
  URL: voir developer.mozilla.org
  Niveau pyramide: 3 (documentation officielle)
  Date: 2025-2026
  Citation: L'attribut loading="lazy" permet le chargement differe natif des images
  Conflit d'interet: non

SOURCE 4:
  Nom: Can I Use — WebP 97%, AVIF 92%
  URL: voir caniuse.com
  Niveau pyramide: 4 (donnees factuelles de compatibilite)
  Date: 2026
  Citation: Support navigateurs WebP a 97%+, AVIF a 92%+
  Conflit d'interet: non

---

## Design

### onboarding.md

SOURCE 1:
  Nom: Nielsen Norman Group — "recognition rather than recall" heuristic #6
  URL: voir nngroup.com
  Niveau pyramide: 5 (reference academique/industrie en UX, Jakob Nielsen)
  Date: 1994 (intemporel, revise regulierement)
  Citation: Heuristique #6 : privilegier la reconnaissance plutot que le rappel (labels visibles, pas d'icones seules)
  Conflit d'interet: non — NNG est un organisme de recherche UX independant

SOURCE 2:
  Nom: Shepherd.js docs
  URL: voir docs officielles (shepherdjs.dev)
  Niveau pyramide: 3 (documentation officielle)
  Date: 2025-2026
  Citation: Shepherd.js permet de creer des tours d'onboarding avec tooltips contextuels
  Conflit d'interet: oui — auto-promotion de la librairie

SOURCE 3:
  Nom: Baymard Institute — empty state onboarding
  URL: voir baymard.com
  Niveau pyramide: 4 (recherche UX basee sur des etudes utilisateurs)
  Date: 2024-2025
  Citation: Les empty states sont des opportunites d'onboarding
  Conflit d'interet: oui — Baymard vend des rapports de recherche UX

SOURCE 4:
  Nom: Pendo 2024 — 80% churn sans onboarding
  URL: voir pendo.io
  Niveau pyramide: 4 (donnees d'industrie)
  Date: 2024
  Citation: 80% des utilisateurs abandonnent une app apres la premiere utilisation si l'onboarding est absent ou confus
  Conflit d'interet: oui — Pendo vend un produit d'onboarding/product analytics, interet direct a gonfler le chiffre

---

### pagination.md

SOURCE 1:
  Nom: Spring Data docs — Pageable
  URL: voir docs officielles (docs.spring.io)
  Niveau pyramide: 3 (documentation officielle)
  Date: 2025-2026
  Citation: Spring Data fournit une abstraction Pageable pour la pagination offset
  Conflit d'interet: oui — VMware/Broadcom promeut Spring

SOURCE 2:
  Nom: Baymard Institute — pagination UX research
  URL: voir baymard.com
  Niveau pyramide: 4 (recherche UX basee sur des etudes utilisateurs)
  Date: 2024-2025
  Citation: Recherche sur les patterns UX de pagination (quand utiliser offset vs infinite scroll)
  Conflit d'interet: oui — Baymard vend des rapports de recherche UX

SOURCE 3:
  Nom: Slack Engineering — cursor pagination at scale
  URL: voir slack.engineering
  Niveau pyramide: 4 (retour d'experience d'une entreprise a grande echelle)
  Date: 2020-2023
  Citation: La pagination cursor-based est plus performante et stable a grande echelle
  Conflit d'interet: non — partage de pratiques internes

---

### meta-seo.md

SOURCE 1:
  Nom: Google Search Central — SEO starter guide
  URL: voir developers.google.com/search
  Niveau pyramide: 3 (documentation officielle)
  Date: 2025-2026
  Citation: Guide des bonnes pratiques SEO (meta tags, structure HTML, donnees structurees)
  Conflit d'interet: oui — Google definit les regles du SEO pour son propre moteur de recherche

SOURCE 2:
  Nom: schema.org — Course type
  URL: voir schema.org
  Niveau pyramide: 2 (standard web, consensus multi-acteurs : Google, Microsoft, Yahoo, Yandex)
  Date: 2025-2026
  Citation: Le type Course permet de structurer les donnees pour les plateformes d'apprentissage
  Conflit d'interet: non — consortium multi-acteurs

SOURCE 3:
  Nom: MDN — HTML semantics
  URL: voir developer.mozilla.org
  Niveau pyramide: 3 (documentation officielle)
  Date: 2025-2026
  Citation: Utiliser les elements semantiques HTML (header, main, article, section, footer) au lieu de divs
  Conflit d'interet: non

SOURCE 4:
  Nom: OpenGraph protocol — og:tags
  URL: voir ogp.me
  Niveau pyramide: 3 (specification de protocole)
  Date: 2010 (intemporel)
  Citation: Les meta tags OpenGraph permettent un affichage riche lors du partage sur les reseaux sociaux
  Conflit d'interet: oui — cree par Facebook/Meta pour son ecosysteme

---

## Reliability

### high-availability.md

SOURCE 1:
  Nom: Docker Compose deploy docs — replicas, healthcheck
  URL: voir docs officielles (docs.docker.com)
  Niveau pyramide: 3 (documentation officielle)
  Date: 2025-2026
  Citation: Docker Compose supporte les replicas et les healthchecks pour la haute disponibilite
  Conflit d'interet: oui — Docker Inc. promeut son ecosysteme

SOURCE 2:
  Nom: Spring Boot Actuator docs — health endpoint
  URL: voir docs officielles (docs.spring.io)
  Niveau pyramide: 3 (documentation officielle)
  Date: 2025-2026
  Citation: L'endpoint /actuator/health permet de verifier l'etat de l'application et de ses dependances
  Conflit d'interet: oui — VMware/Broadcom promeut Spring

SOURCE 3:
  Nom: PostgreSQL docs — streaming replication
  URL: voir docs officielles (postgresql.org/docs)
  Niveau pyramide: 3 (documentation officielle)
  Date: 2025-2026
  Citation: PostgreSQL supporte la replication en streaming pour la haute disponibilite
  Conflit d'interet: non — PostgreSQL est un projet open source communautaire

SOURCE 4:
  Nom: Google SRE Book ch.3 — embracing risk
  URL: voir sre.google/sre-book/embracing-risk
  Niveau pyramide: 5 (ouvrage de reference industrie)
  Date: 2016
  Citation: Accepter un niveau de risque calcule plutot que viser 100% de disponibilite
  Conflit d'interet: oui — Google promeut ses pratiques et indirectement GCP

---

### transactions.md

SOURCE 1:
  Nom: Spring @Transactional docs — propagation, isolation
  URL: voir docs officielles (docs.spring.io)
  Niveau pyramide: 3 (documentation officielle)
  Date: 2025-2026
  Citation: @Transactional au service layer, readOnly par defaut, rollbackFor pour les checked exceptions
  Conflit d'interet: oui — VMware/Broadcom promeut Spring

SOURCE 2:
  Nom: SWEBOK v4 — ACID properties
  URL: voir ieee.org / swebok.org
  Niveau pyramide: 1 (body of knowledge valide par consensus academique IEEE)
  Date: 2024
  Citation: Proprietes ACID (Atomicite, Coherence, Isolation, Durabilite) des transactions
  Conflit d'interet: non — IEEE est un organisme independant

SOURCE 3:
  Nom: IETF draft — Idempotency-Key header
  URL: voir datatracker.ietf.org
  Niveau pyramide: 2 (draft de standard IETF)
  Date: 2023-2024
  Citation: Header Idempotency-Key pour garantir l'idempotence des mutations API
  Conflit d'interet: non — IETF est un organisme de standardisation independant

SOURCE 4:
  Nom: Fowler — Saga pattern for distributed tx
  URL: voir martinfowler.com
  Niveau pyramide: 5 (opinion d'expert reconnu)
  Date: 2019
  Citation: Le pattern Saga pour les transactions distribuees (alternative aux 2PC)
  Conflit d'interet: oui — Fowler est consultant ThoughtWorks

---

## Project

### requirements-format.md

SOURCE 1:
  Nom: SWEBOK v4 — Software Requirements Knowledge Area
  URL: voir ieee.org / swebok.org
  Niveau pyramide: 1 (body of knowledge valide par consensus academique IEEE)
  Date: 2024
  Citation: Les exigences logicielles doivent etre structurees, testables et tracables
  Conflit d'interet: non — IEEE est un organisme independant

SOURCE 2:
  Nom: Cohn "User Stories Applied"
  URL: voir livre (Addison-Wesley, 2004)
  Niveau pyramide: 5 (ouvrage de reference agile)
  Date: 2004 (intemporel)
  Citation: Format user story : "En tant que [role], je veux [action], afin de [benefice]"
  Conflit d'interet: oui — Mike Cohn est consultant agile (Mountain Goat Software), interet a promouvoir les pratiques agiles

SOURCE 3:
  Nom: Cucumber — Gherkin syntax reference
  URL: voir docs officielles (cucumber.io/docs/gherkin)
  Niveau pyramide: 3 (documentation officielle)
  Date: 2025-2026
  Citation: Syntaxe Given/When/Then pour les criteres d'acceptation
  Conflit d'interet: oui — SmartBear (proprietaire de Cucumber) vend des outils de test

SOURCE 4:
  Nom: GitHub Issues docs
  URL: voir docs officielles (docs.github.com)
  Niveau pyramide: 3 (documentation officielle)
  Date: 2025-2026
  Citation: Utiliser les templates d'issues GitHub pour structurer les user stories
  Conflit d'interet: oui — GitHub/Microsoft promeut sa plateforme

---

## Code Quality

### tech-debt.md

SOURCE 1:
  Nom: Fowler "TechnicalDebt"
  URL: voir martinfowler.com/bliki/TechnicalDebt.html
  Niveau pyramide: 5 (opinion d'expert reconnu)
  Date: 2009 (revise)
  Citation: La dette technique est une metaphore pour les compromis de design qui creent un cout futur
  Conflit d'interet: oui — Fowler est consultant ThoughtWorks

SOURCE 2:
  Nom: SonarQube docs — technical debt metric
  URL: voir docs officielles (docs.sonarsource.com)
  Niveau pyramide: 3 (documentation officielle)
  Date: 2025-2026
  Citation: Ratio dette = temps de remediation / temps de dev, seuil recommande < 5%
  Conflit d'interet: oui — SonarSource vend SonarQube (versions payantes), interet a ce que le concept de dette technique soit mesure par leur outil

SOURCE 3:
  Nom: Martin "Clean Code" — boy scout rule
  URL: voir livre (Prentice Hall, 2008)
  Niveau pyramide: 5 (ouvrage de reference industrie)
  Date: 2008 (intemporel)
  Citation: "Laisser le code plus propre qu'on ne l'a trouve" (boy scout rule)
  Conflit d'interet: oui — Robert C. Martin est consultant (Uncle Bob Consulting), vend des formations clean code

SOURCE 4:
  Nom: SWEBOK v4 — Software Maintenance KA
  URL: voir ieee.org / swebok.org
  Niveau pyramide: 1 (body of knowledge valide par consensus academique IEEE)
  Date: 2024
  Citation: La maintenance logicielle inclut la gestion de la dette technique
  Conflit d'interet: non — IEEE est un organisme independant

---

# Matrice de synthese

## Repartition par niveau de pyramide

| Niveau | Description | Nombre de citations |
|--------|-------------|---------------------|
| 1 | Body of knowledge (IEEE SWEBOK) | 4 |
| 2 | Standards/guides normatifs (OWASP, IETF, schema.org) | 3 |
| 3 | Documentation officielle | 33 |
| 4 | Enquetes, donnees quantitatives, REX | 17 |
| 5 | Opinions d'experts, ouvrages de reference | 11 |

**Total : 68 sources extraites sur 17 pages.**

## Sources recurrentes (citees dans plusieurs pages)

| Source | Pages qui la citent | Niveau |
|--------|---------------------|--------|
| Twelve-Factor App | scaling, http-client, jvm-tuning | 5 |
| SWEBOK v4 | backend-framework, transactions, requirements-format, tech-debt | 1 |
| Google SRE Book | incident-response, high-availability | 5 |
| Spring docs (divers) | http-client, scaling, pagination, transactions, high-availability, jvm-tuning | 3 |
| Fowler (divers articles) | scaling, transactions, tech-debt | 5 |
| SO Survey 2025 | backend-framework, frontend-framework | 4 |
| JetBrains 2024 | backend-framework, frontend-framework | 4 |
| State of JS 2025 | backend-framework, frontend-framework | 4 |
| web.dev | rendering-strategy, image-optimization | 3 |
| Baymard Institute | onboarding, pagination | 4 |

## Conflits d'interet identifies

| Source | Conflit | Severite |
|--------|---------|----------|
| Pendo 2024 (80% churn) | Vend un produit d'onboarding, interet a gonfler le chiffre | HAUTE — chiffre potentiellement biaise, a verifier |
| SonarQube docs (dette tech) | Vend l'outil de mesure de dette | MOYENNE — metriques auto-referentielles |
| Google (web.dev, Search Central) | Definit les regles du SEO et promeut ses formats (WebP) | MOYENNE — position dominante |
| PagerDuty (incident response) | Vend un produit d'incident management | MOYENNE — guide oriente vers leur workflow |
| Vercel/Next.js docs | Promeut SSR/SSG qui necessite leur plateforme | MOYENNE |
| Fowler / ThoughtWorks | Consultant, vend des services d'architecture | FAIBLE — reconnu academiquement |
| Robert C. Martin (Clean Code) | Consultant, vend des formations | FAIBLE — ouvrage de reference |
| Cohn (User Stories Applied) | Consultant agile | FAIBLE — ouvrage de reference |
| SmartBear/Cucumber | Vend des outils de test | FAIBLE — syntaxe Gherkin est devenue un standard de facto |
| Oracle (JVM Tuning) | Editeur de Java, licences commerciales | FAIBLE — la doc technique est factuelle |

## Gaps identifies

### Pages sans source de niveau 1 ou 2 (pas de standard/body of knowledge)
- rendering-strategy.md (uniquement niv. 3)
- state-management.md (uniquement niv. 3-4)
- scaling.md (niv. 3 et 5, pas de standard formel)
- frontend-framework.md (uniquement niv. 4)
- incident-response.md (niv. 3-5, pas de standard ISO/IEEE)
- jvm-tuning.md (niv. 3 et 5)
- image-optimization.md (niv. 3-4)
- onboarding.md (niv. 3-5)
- pagination.md (niv. 3-4)
- high-availability.md (niv. 3 et 5)

### Sources potentiellement datees
- Twelve-Factor App (2012) — toujours pertinent mais pas revise
- Fowler "MonolithFirst" (2015) — le paysage microservices a evolue
- Cohn "User Stories Applied" (2004) — agile a beaucoup evolue depuis
- Martin "Clean Code" (2008) — certaines recommandations contestees recemment
- Nielsen heuristics (1994) — toujours valides mais exemples dates

### URLs manquantes
Toutes les sources sont citees par nom sans URL directe. A verifier systematiquement pour s'assurer que les pages existent toujours et que les claims sont fideles.

### Source a haute priorite de verification
- **Pendo 2024 "80% churn sans onboarding"** : chiffre tres specifique cite dans onboarding.md, provenant d'un vendeur d'onboarding. Risque de cherry-picking ou de methodologie faible. Priorite de verification : HAUTE.
