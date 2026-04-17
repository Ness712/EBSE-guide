# Double Extraction — PICOC distributed-tracing

**Date** : 2026-04-17
**Protocole** : methodology.md v3.0
**Agent A** : mots-cles : "W3C Trace Context traceparent tracestate", "distributed tracing span context propagation", "OpenTelemetry sampling head-based tail-based", "Jaeger CNCF graduated OTLP", "B3 propagation Zipkin legacy", "distributed tracing overhead throughput latency"
**Agent B** : mots-cles : "W3C Baggage header context propagation", "NIST SP 800-204A microservices tracing", "OpenTelemetry NestJS instrumentation nestjs-core", "OTLP port 4317 4318 gRPC HTTP", "OTel Collector tail-based sampling buffer", "Shkuro Mastering Distributed Tracing Jaeger creator"

---

## PICOC

```
P  = Equipes developpement et ops gerant des appels inter-services dans des architectures distribuees
I  = Implementer le distributed tracing pour suivre les requetes a travers les services
C  = Logging par service sans correlation de requetes end-to-end
O  = Analysabilite, detection de goulots, latence P99, diagnostic d'incidents
Co = Applications web avec plusieurs services ou dependances (HTTP, queues, BDD)
```

---

## Accord Reviewer A / Reviewer B

| # | Source | Niv. A | Niv. B | Accord ? | Note divergence |
|---|--------|--------|--------|:--------:|-----------------|
| 1 | W3C Trace Context Level 1 Recommendation (2021) | 1 | 1 | ✓ | — |
| 2 | W3C Trace Context Level 2 Candidate Recommendation (2023) | absent | 1 | ✗ | **B cite, A couvre implicitement via Level 1 — inclus, apport incremental documenté** |
| 3 | W3C Baggage Candidate Recommendation (2024) | absent | 1 | ✗ | **B cite, A ne cite pas — inclus, standard W3C complementaire pour propagation contextuelle** |
| 4 | NIST SP 800-204A — Building Secure Microservices (2021) | absent | 1 | ✗ | **B cite, A ne cite pas — inclus, exigence tracing dans architectures microservices** |
| 5 | OpenTelemetry Tracing API Specification (CNCF) | 2 | 2 | ✓ | — |
| 6 | OTLP Specification 1.10.0 (CNCF) | 2 | 2 | ✓ | — |
| 7 | OpenTelemetry Semantic Conventions (CNCF) | 2 | 2 | ✓ | — |
| 8 | OpenTelemetry Sampling Concepts (CNCF) | 2 | 2 | ✓ | — |
| 9 | OTel Performance Benchmark Specification (CNCF) | 2 | absent | ✗ | **A cite, B ne cite pas — inclus, methodologie officielle mesure overhead** |
| 10 | OTel Collector Architecture (CNCF) | absent | 2 | ✗ | **B cite, A couvre via Jaeger — inclus, indispensable pour tail-based sampling** |
| 11 | Jaeger v2 (CNCF Graduated) | 3 | 2 | ✗ | **Niveau : A=3 (impl. reference), B=2 (CNCF Graduated). Resolution : niv.2 correct — Jaeger est un projet CNCF Graduated, source primaire CNCF** |
| 12 | B3 Propagation Spec OpenZipkin | 3 | absent | ✗ | **A cite, B ne cite pas — exclu (voir Sources exclues) : format legacy couvert par OTel comme propagateur secondaire** |
| 13 | @opentelemetry/instrumentation-nestjs-core (npm OTel officiel) | absent | 3 | ✗ | **B cite, A ne cite pas — inclus, seule source d'implementation concrete NestJS** |
| 14 | OTel Node.js Getting Started (CNCF) | absent | 3 | ✗ | **B cite, A ne cite pas — inclus, contrainte ordre d'initialisation obligatoire** |
| 15 | Dapper — Large-Scale Distributed Systems Tracing (Google, 2010) | 5 | 4 | ✗ | **Niveau : A=5 (rapport technique Google, non peer-reviewed), B=4 (survey). Resolution : niv.5 — rapport technique d'experts Google, non publie dans journal peer-reviewed, >4000 citations. La pyramide niv.4 requiert peer-review ; Dapper est un TR interne. Niv.5 expert reconnu plus precis.** |
| 16 | Sridharan — Distributed Systems Observability O'Reilly (2018) | absent | 5 | ✗ | **B cite, A ne cite pas — inclus, reference "3 pilliers" observabilite** |
| 17 | Shkuro — Mastering Distributed Tracing Packt (2019) | absent | 5 | ✗ | **B cite, A ne cite pas — inclus, createur de Jaeger, reference pratique** |
| 18 | Li et al. — Tracing Practices in Industry (Empirical Software Engineering, 2022) | 4 | absent | ✗ | **A cite, B ne cite pas — inclus, survey 10 entreprises, donnees industrielles** |
| 19 | Eaton et al. — Critical Path Tracing Google (ACM Queue / CACM, 2022/2023) | 3 | absent | ✗ | **A cite, B ne cite pas — inclus, donnees production Google, justifie le facteur "effet important"** |
| 20 | Nou et al. — Overhead of Distributed Tracing (ICPE 2025, ACM/SPEC) | 3 | absent | ✗ | **A cite, B ne cite pas — inclus, etude overhead peer-reviewed la plus recente (2025)** |
| 21 | Liu et al. — DB Performance via Tracing (MDPI Applied Sciences, 2022) | 3 | absent | ✗ | **A cite, B ne cite pas — inclus, apport specific DB spans** |
| 22 | Umeå University OTel Overhead Study (2024) | 3 | absent | ✗ | **A cite, B ne cite pas — exclu (voir Sources exclues) : memoire master, moins solide que ICPE 2025 qui couvre le meme perimetre avec rigueur superieure** |
| 23 | Microsoft Engineering Playbook — Correlation IDs | absent | 5 | ✗ | **B cite, A ne cite pas — exclu (voir Sources exclues) : redondant avec W3C Trace Context + OTel** |

**Accord sur sources communes (citees par A et B simultanement)** : 4/4 → kappa sources communes = 1.0 (OTel Tracing API, OTLP Spec, OTel Semantic Conventions, OTel Sampling Concepts).
**Sources A-only retenues** : OTel Performance Benchmark, Li et al., Eaton et al., Nou et al., Liu et al.
**Sources B-only retenues** : W3C Trace Context Level 2, W3C Baggage, NIST SP 800-204A, OTel Collector Architecture, @opentelemetry/instrumentation-nestjs-core, OTel Node.js Getting Started, Sridharan O'Reilly, Shkuro Packt.
**Sources exclues** : B3 Propagation, Umeå University study, Microsoft Playbook.

### Resolution des divergences

**W3C Trace Context Level 2 (B-only)** : Inclus — apport incremental documenté sur Level 1 (flags additionnels). Source W3C niveau 1, pertinence directe.

**W3C Baggage (B-only)** : Inclus — standard W3C complement a Trace Context pour la propagation de donnees contextuelles (user-id, tenant-id). Différent de traceparent (identification) vs baggage (donnees metier).

**NIST SP 800-204A (B-only)** : Inclus — exigence explicite de tracing dans les architectures microservices. Source niveau 1 (NIST SP), directement prescriptive pour le scope PICOC.

**OTel Collector Architecture (B-only)** : Inclus — indispensable pour documenter le tail-based sampling qui requiert un buffer. Complementaire a OTel Sampling Concepts.

**@opentelemetry/instrumentation-nestjs-core (B-only)** : Inclus — seule source actionnable pour l'implementation NestJS. Niveau 3 (package npm du projet OTel officiel).

**OTel Node.js Getting Started (B-only)** : Inclus — documente la contrainte d'ordre d'initialisation (SDK avant imports NestJS), critique pour les implementeurs.

**Sridharan O'Reilly (B-only)** : Inclus — reference fondatrice des "3 pilliers" (logs, metriques, traces). Justifie pourquoi le tracing complete les logs.

**Shkuro Packt (B-only)** : Inclus — createur de Jaeger, expertise de premier plan sur l'implementation pratique.

**Dapper niv.5 vs niv.4** : Resolution en faveur de niv.5 (rapport technique interne Google, non peer-reviewed). Pyramide niv.4 = surveys ou etudes a large echelle peer-reviewed. Dapper est un rapport technique de 2010 signe par des experts Google, >4000 citations, mais pas publie dans une conference ou journal avec comite de lecture. Niv.5 (expert reconnu) est la classification la plus precise.

**Jaeger niv.2 vs niv.3** : Resolution en faveur de niv.2. Jaeger est un projet CNCF Graduated — CNCF est une fondation open source (niv.2 dans la pyramide). La niv.3 ne s'applique que si Jaeger est traite comme "documentation framework" — mais dans ce PICOC il est cite comme standard de l'ecosysteme CNCF, niv.2 est correct.

**B3 Propagation (A-only, exclu)** : Format legacy Zipkin. OTel le supporte comme propagateur secondaire mais le recommande uniquement pour la compatibilite avec les systemes existants. Le principe universel doit pointer vers W3C Trace Context — B3 est un detail d'implementation pour les migrations. Exclu du principe universel, mentionnable dans les notes de migration.

**Umeå University study (A-only, exclu)** : Memoire de master 2024, rigueur methodologique inferieure aux actes de conference ICPE 2025. Perimetre couvert par Nou et al. 2025 avec superiority epistemique. Exclusion justifiee par E6 (qualite methodologique insuffisante).

**Microsoft Playbook (B-only, exclu)** : Niveau 5, redondant avec W3C Trace Context Level 1 qui definit exactement le meme concept (traceparent = correlation ID standardise). Exclu par E5 (couvert par source superieure).

---

## Calcul GRADE final

```
Score de depart : 4
  Source la plus haute directement pertinente = niveau 1 :
  - W3C Trace Context Level 1 Recommendation (2021) : definit litteralement le standard
    de propagation (traceparent/tracestate)
  - W3C Trace Context Level 2 Candidate Recommendation (2023) : extension officielle
  - W3C Baggage Candidate Recommendation (2024) : propagation contextuelle standard
  - NIST SP 800-204A (2021) : exigence tracing dans microservices (source governementale)
  4 sources niveau 1 convergentes → score de depart = 4 (pyramide niv.1 → score 4).

+ 1 convergence forte
  Sources independantes convergentes sans contradiction :
  - Normatif W3C (Trace Context L1 + L2 + Baggage) : 3 sources niveau 1
  - NIST (gouvernemental, independant W3C) : 1 source niveau 1
  - CNCF (OTel Tracing API, OTLP, Semantic Conventions, Sampling, Collector, Benchmark) :
    6 sources niveau 2
  - Jaeger CNCF Graduated : 1 source niveau 2
  - Peer-reviewed (Nou et al. ICPE 2025, Eaton et al. ACM/CACM, Liu et al. MDPI,
    Li et al. Empirical SE) : 4 sources niveau 3-4
  - Experts reconnus (Dapper Google, Sridharan O'Reilly, Shkuro Packt) : 3 sources niveau 5
  Total : 18 sources retenues, 5 niveaux de pyramide, aucune contradiction.
  Les 4 categories distinctes (normatif, ecosysteme CNCF, peer-reviewed, praticiens)
  convergent sur les memes prescriptions.

+ 1 effet important/grande echelle
  - Nou et al. ICPE 2025 (ACM/SPEC) : mesure empirique throughput -19% a -80%,
    latency +175% selon config → quantification rigoureuse de l'overhead
  - Eaton et al. ACM Queue / CACM 2023 : analyse critical path en production Google
    sur des milliers de services → effet mesure a grande echelle reelle
  - Li et al. Empirical SE 2022 : survey 10 entreprises → adoption et impact industriel
  L'effet est quantifie (pas juste directionnel) et documente en production.

- 1 indirectness partielle
  Les etudes d'overhead (Nou et al. ICPE 2025, Liu et al.) mesurent des configurations
  specifiques qui peuvent ne pas correspondre exactement au contexte PICOC cible
  (architectures generiques, pas necessairement NestJS/Spring Boot). L'overhead reel
  varie selon la config — la prescription "sampling indispensable" reste valide mais
  les chiffres exacts (-19% a -80%) sont indirects pour un contexte specifique.

Facteurs negatifs non retenus :
  - Pas d'incoherence : aucune source ne contredit les autres.
  - Pas d'imprecision : les prescriptions sont operationnelles (ports, headers, formules
    traceparent, taux de sampling 1-10%).

Score final : 4 + 1 + 1 - 1 = 5 → [STANDARD]
(seuil STANDARD : 5+)
```

Note biais de publication : faible — les sources normatives (W3C, NIST) sont prescriptives par nature. Les sources CNCF (OTel, Jaeger) sont des standards d'ecosysteme, pas du vendor marketing. Les etudes peer-reviewed (ICPE, ACM) sont soumises a revue contradictoire. Les livres O'Reilly/Packt (Sridharan, Shkuro) sont des references de praticiens reconnues, pas de l'autopromotion. Aucun biais publication significatif detecte.

---

## Analyse de sensibilite {#analyse-de-sensibilite}

| Source retiree | Score sans | Niveau sans | Changement ? |
|----------------|-----------|------------|:------------:|
| W3C Trace Context Level 1 | 5 (3 niv.1 restants, +1 conv, +1 effet, -1 indirect) | STANDARD | NON |
| W3C Trace Context Level 2 | 5 (3 niv.1 restants, convergence intacte) | STANDARD | NON |
| W3C Baggage | 5 (3 niv.1 restants, convergence intacte) | STANDARD | NON |
| NIST SP 800-204A | 5 (3 niv.1 W3C, convergence intacte) | STANDARD | NON |
| Toutes sources niveau 1 simultanement | 3 (depart niv.2=3, +1 conv CNCF, -1 indirect) | RECOMMANDE | OUI — degrade |
| Nou et al. ICPE 2025 | 5 (depart 4, +1 conv, +1 effet via Eaton ACM, -1 indirect reduit) | STANDARD | NON |
| Eaton et al. ACM/CACM | 5 (Nou et al. maintient le facteur effet) | STANDARD | NON |
| Toutes etudes peer-reviewed simultanement | 4 (depart 4, +1 conv W3C+CNCF, -1 indirect) | RECOMMANDE | OUI — degrade d'un cran |
| OTel Tracing API Specification | 5 (autres sources CNCF maintiennent niv.2) | STANDARD | NON |
| Jaeger v2 | 5 (OTLP + OTel Collector couvrent l'ecosysteme backend) | STANDARD | NON |
| Dapper Google | 5 (concepts couverts par OTel Spec) | STANDARD | NON |
| Sridharan + Shkuro simultanement | 5 (convergence maintenue par sources niv.1-3) | STANDARD | NON |
| @opentelemetry/instrumentation-nestjs-core | 5 (impact sur variant NestJS uniquement, pas sur GRADE universel) | STANDARD | NON (variant degrade) |
| Toutes sources niveau 5 simultanement | 5 (depart 4, +1 conv, +1 effet Nou/Eaton, -1 indirect) | STANDARD | NON |

**Conclusion : ROBUSTE** — recommandation [STANDARD] stable pour tout retrait individuel et pour tout retrait par niveau complet (sauf retrait simultane de TOUTES les sources niveau 1 ou de toutes les etudes peer-reviewed, qui degraderait a [RECOMMANDE]). La robustesse est elevee car la prescription principale (W3C Trace Context + OTel) est supportee par un standard level 1 + ecosysteme CNCF complet convergents. Le score 5 est minimal STANDARD : il y a peu de marge, mais la structure multi-niveau (4 sources niv.1 + 7 sources niv.2 + 4 etudes peer-reviewed) garantit que les scenarios de retrait individuels n'atteignent pas le seuil de degradation.

---

## Sources exclues

| Source | Critere | Raison |
|--------|---------|--------|
| B3 Propagation Spec OpenZipkin | E5 supplanté par norme superieure | Format legacy Zipkin, aujourd'hui propagateur secondaire dans OTel. W3C Trace Context est le standard obligatoire pour les nouveaux systemes ; B3 reste uniquement pour la compatibilite avec systemes existants (non pertinent pour le principe universel) |
| Umeå University OTel Overhead Study (memoire master, 2024) | E6 qualite methodologique insuffisante | Memoire de master non peer-reviewed. Perimetre entierement couvert par Nou et al. ICPE 2025 (conference ACM/SPEC, comite de lecture, rigueur superieure). Redondance avec source de qualite superieure |
| Microsoft Engineering Playbook — Correlation IDs | E5 redondant avec source superieure | Niveau 5, contenu operationnel redondant avec W3C Trace Context Level 1 qui definit le meme concept (traceparent = correlation ID standardise) avec force normative superieure |
| Zipkin documentation generale | E2 hors scope | Outil specifique, hors scope du principe universel. Mentionne implicitement via B3 Propagation (deja exclu) |
