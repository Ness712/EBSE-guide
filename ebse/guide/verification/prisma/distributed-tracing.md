# PRISMA Flow — PICOC distributed-tracing

**Date de recherche** : 2026-04-17
**Bases interrogees** : W3C standards, NIST, CNCF (OpenTelemetry, Jaeger), npm registry, ACM Digital Library, IEEE Xplore, MDPI Applied Sciences, O'Reilly/Packt books, WebSearch general
**Mots-cles Agent A** : "W3C Trace Context traceparent tracestate", "distributed tracing span context propagation", "OpenTelemetry sampling head-based tail-based", "Jaeger CNCF graduated OTLP", "B3 propagation Zipkin legacy", "distributed tracing overhead throughput latency", "critical path analysis microservices"
**Mots-cles Agent B** : "W3C Baggage header context propagation", "NIST SP 800-204A microservices tracing", "OpenTelemetry NestJS instrumentation nestjs-core", "OTLP port 4317 4318 gRPC HTTP", "OTel Collector tail-based sampling buffer", "Shkuro Mastering Distributed Tracing Jaeger creator", "distributed systems observability three pillars"
**Protocole** : methodology.md v3.0 §2.1 — double extraction independante (Agents A + B, mots-cles differents) + synthese Agent C

---

## Flux

```
IDENTIFICATION
  Sources identifiees par base (Agent A + Agent B combines, avant deduplication) :
    - Standards normatifs (W3C, NIST, IETF) : 5 resultats candidats
    - CNCF (OpenTelemetry specs, Jaeger, OTel Collector) : ~10 resultats candidats
    - Documentation framework/outils (NestJS, Spring Boot, npm packages) : ~6 resultats candidats
    - Articles academiques / peer-reviewed (ACM, IEEE, MDPI, Springer) : ~10 resultats candidats
    - Livres de reference (O'Reilly, Packt) : ~4 resultats candidats
    - Rapports techniques (Google Dapper, Google Critical Path) : ~3 resultats candidats
    - Surveys industriels (Empirical Software Engineering) : ~3 resultats candidats
    - Etudes overhead (universite, SPEC/ACM) : ~4 resultats candidats
    - Blog posts / guides operationnels : ~10 resultats candidats
    - Snowballing backward (references citees par Dapper, Sridharan, Shkuro) : ~5 sources
  Total identifie (brut, combine A+B) : ~60
  Doublons retires (meme source identifiee par A et B) : 6 (OTel Tracing API, OTLP Spec,
    OTel Semantic Conventions, OTel Sampling Concepts, Jaeger v2, W3C Trace Context Level 1)
  Total apres deduplication : ~54

SCREENING (titre + resume)
  Sources screeness : ~54
  Sources exclues au screening : ~30
    - E1 (blog opinion sans donnees ou methodologie) : ~10
    - E2 (hors scope PICOC — tracing cote client/browser, APM commercial uniquement) : ~7
    - E3 (doublons partiels — couverts par sources primaires deja incluses) : ~6
    - E4 (vendeur / marketing sans substance technique) : ~7

ELIGIBILITE (lecture complete)
  Sources evaluees en detail : ~24
  Sources exclues apres lecture complete : ~5
    - Hors scope PICOC strict (overhead JVM specifique irrelevant pour principe universel) : 1
    - Niveau de preuve insuffisant (memoire master, methodo insuffisante vs ICPE 2025) : 1
    - Redondance forte avec source superieure (Microsoft Playbook < W3C Trace Context) : 1
    - Format legacy sans apport pour nouveaux systemes (B3 Propagation — W3C est suffisant) : 1
    - Hors periode pertinente (pre-OTel, concepts remplaces) : 1

INCLUSION
  Sources incluses dans la synthese : 19
    - Niveau 1 : 4 (W3C Trace Context L1, W3C Trace Context L2, W3C Baggage, NIST SP 800-204A)
    - Niveau 2 : 7 (OTel Tracing API, OTLP Spec, OTel Semantic Conventions, OTel Sampling,
                    OTel Performance Benchmark, OTel Collector Architecture, Jaeger v2)
    - Niveau 3 : 5 (@opentelemetry/instrumentation-nestjs-core, OTel Node.js Getting Started,
                    Nou et al. ICPE 2025, Eaton et al. ACM/CACM, Liu et al. MDPI)
    - Niveau 4 : 1 (Li et al. Empirical Software Engineering 2022)
    - Niveau 5 : 3 (Dapper Google TR, Sridharan O'Reilly, Shkuro Packt)

  Sources exclues avec raison documentee : 4
    - B3 Propagation Spec OpenZipkin : format legacy, standard W3C Trace Context couvre le besoin
    - Umeå University OTel Overhead Study 2024 : memoire master, Nou et al. ICPE 2025 superieur
    - Microsoft Engineering Playbook — Correlation IDs : redondant avec W3C Trace Context
    - Zipkin documentation generale : hors scope principe universel
```

---

## Documentation recherche (Table 2 Kitchenham)

### Agent A — bases interrogees

| Element | Valeur |
|---------|--------|
| Bases | W3C, CNCF, ACM Digital Library, IEEE Xplore, MDPI, WebSearch general |
| Mots-cles | "W3C Trace Context traceparent", "distributed tracing span context propagation", "OpenTelemetry sampling head-based tail-based", "Jaeger CNCF graduated OTLP", "B3 propagation Zipkin legacy", "distributed tracing overhead throughput latency", "critical path analysis microservices" |
| Periode couverte | 2010-2025 |
| Sources identifiees | ~30 |
| Sources retenues | 11 |
| Date d'extraction | 2026-04-17 |

### Agent B — bases interrogees

| Element | Valeur |
|---------|--------|
| Bases | W3C, NIST, CNCF, npm registry, O'Reilly/Packt catalogs, WebSearch general |
| Mots-cles | "W3C Baggage header context propagation", "NIST SP 800-204A microservices tracing", "OpenTelemetry NestJS instrumentation nestjs-core", "OTLP port 4317 4318 gRPC HTTP", "OTel Collector tail-based sampling buffer", "Shkuro Mastering Distributed Tracing", "distributed systems observability three pillars" |
| Periode couverte | 2010-2024 |
| Sources identifiees | ~24 |
| Sources retenues | 15 (convergence moderee avec A + sources B-only significatives) |
| Date d'extraction | 2026-04-17 |

---

## Sources exclues — raisons documentees

| Source | Raison exclusion |
|--------|-----------------|
| B3 Propagation Spec OpenZipkin | Format legacy — W3C Trace Context (niv.1) est le standard interoperable pour les nouvelles implementations. B3 reste pertinent uniquement pour la compatibilite avec systemes Zipkin existants (detail d'implementation, pas principe universel) |
| Umeå University — OTel Overhead Study (memoire master, 2024) | Niveau de preuve insuffisant — memoire de master non peer-reviewed. Perimetre entierement couvert par Nou et al. ICPE 2025 (conference ACM/SPEC avec comite de lecture) avec rigueur methodologique superieure |
| Microsoft Engineering Playbook — Correlation IDs | Redondance avec source superieure — niveau 5, contenu couvert par W3C Trace Context Level 1 (niv.1) qui definit le header traceparent comme correlation ID standardise. Aucun apport differentiel |
| Zipkin documentation generale | Hors scope principe universel — outil specifique, remplace par ecosysteme OTel + OTLP pour les nouvelles implementations. Non pertinent pour la decision PICOC |
