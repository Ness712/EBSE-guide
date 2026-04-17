# PRISMA Flow — PICOC observability-opentelemetry

**Date de recherche** : 2026-04-17
**Bases interrogees** : W3C specs (w3.org), NIST CSRC (800-xxx), CNCF (cncf.io, opentelemetry.io), Jaeger docs, Prometheus docs, DORA Research, ACM/IEEE proceedings, Springer journals, O'Reilly books, WebSearch general
**Mots-cles Agent A** : "W3C Trace Context standard", "OpenTelemetry CNCF specification", "OTLP protocol observability", "observability three pillars logs metrics traces", "CNCF TAG observability whitepaper", "Niedermaier observability microservices ICSOC 2019", "Li distributed systems empirical 2022", "Gomes systematic mapping observability 2025", "Faseeha microservices monitoring systematic review IEEE", "Sridharan distributed systems observability O'Reilly", "Majors observability engineering O'Reilly"
**Mots-cles Agent B** : "W3C Baggage propagation 2024", "NIST SP 800-204C observability microservices", "Jaeger v2 OpenTelemetry Collector", "Prometheus OpenMetrics CNCF", "DORA monitoring observability MTTR", "Accelerate DORA four key metrics", "Grafana application observability OTel", "Mastering distributed tracing Shkuro", "OpenTelemetry instrumentation NestJS"
**Protocole** : methodology.md v3.0 §2.1 — double extraction independante (Agents A + B, mots-cles differents)

---

## Flux

```
IDENTIFICATION
  Sources identifiees par base (Agent A + Agent B combines, avant deduplication) :
    - W3C (w3.org) : 4 sources candidates (Trace Context L1, Trace Context L2, Baggage, Trace Context HTTP)
    - NIST CSRC (standards normatifs) : 3 sources candidates (SP 800-204C, SP 800-204A, SP 800-204B)
    - CNCF / OpenTelemetry (opentelemetry.io, cncf.io) : 6 sources candidates
      (OTel Spec, OTLP, Semantic Conventions, CNCF TAG Whitepaper, CNCF Survey 2024, OTel Status 2025)
    - Backend docs (Jaeger, Prometheus, OpenMetrics, Grafana) : 5 sources candidates
    - DORA Research + Accelerate : 3 sources candidates
    - Peer-reviewed (ACM, IEEE, Springer) : 6 sources candidates
    - O'Reilly books (experts reconnus) : 4 sources candidates
    - WebSearch general / surveys : 3 sources candidates
  Total identifie (brut, combine A+B) : ~34
  Doublons retires (meme source identifiee par A et B) : 5
    (OTel Specification, W3C Trace Context L1, Majors Observability Engineering, DORA, Accelerate)
  Total apres deduplication : ~29

SCREENING (titre + resume)
  Sources screenees : ~29
  Sources exclues au screening : ~11
    - E1 (opinion sans donnees, blog posts observabilite, vendor content) : 4
    - E2 (hors scope PICOC — APM proprietaire specifique, SaaS monitoring, performance seule sans observabilite) : 4
    - E3 (doublons partiels — NIST SP 800-204A et 204B absorbes par 800-204C plus recent) : 2
    - E4 (vendeur sans methodologie transparente — New Relic, Datadog white papers) : 1

ELIGIBILITE (lecture complete)
  Sources evaluees en detail : ~18
  Sources exclues apres lecture complete : 3
    - Beyer et al. Google SRE Book 2016 (niv.5) : absorbe par Majors 2022 (plus recent, meme niveau)
      et par NIST SP 800-204C pour les obligations architecturales — apport marginal
    - Mastering Distributed Tracing Shkuro 2019 (niv.5) : absorbe par Sridharan 2018 et OTel/Jaeger docs —
      Jaeger v2 a deprécie l'approche Shkuro (SDKs propriétaires) au profit d'OTel, rendant la reference partiellement obsolete
    - OpenTelemetry Specification Status Summary 2025 (niv.2) : absorbe par OTel Specification v1.x
      (meme source, version plus recente de l'index — le detail est dans la spec principale)

INCLUSION
  Sources incluses dans la synthese : 20
    - Niveau 1 : 4 (W3C Trace Context L1, W3C Trace Context L2, W3C Baggage, NIST SP 800-204C)
    - Niveau 2 : 7 (OTel Specification, OTLP 1.10.0, Semantic Conventions, CNCF TAG Whitepaper,
                    Jaeger v2, Prometheus docs, OpenMetrics 1.0)
    - Niveau 3 : 5 (Niedermaier ICSOC 2019, Li ESE 2022, Gomes Springer 2025,
                    Faseeha IEEE Access 2024, Grafana Application Observability Docs)
    - Niveau 4 : 3 (CNCF Annual Survey 2024, DORA 2018-2024, Accelerate 2018)
    - Niveau 5 : 2 (Sridharan 2018, Majors/Fong-Jones/Miranda 2022)

  Sources exclues avec raison documentee : 3 (voir section "Sources exclues" ci-dessous)
```

---

## Documentation recherche (Table 2 Kitchenham)

### Agent A — bases interrogees

| Element | Valeur |
|---------|--------|
| Bases | W3C (w3.org), CNCF/OpenTelemetry (opentelemetry.io), ACM Digital Library, IEEE Xplore, Springer, O'Reilly catalog, WebSearch general |
| Mots-cles | "W3C Trace Context standard", "OpenTelemetry CNCF specification", "OTLP protocol", "observability three pillars", "CNCF TAG observability", "Niedermaier ICSOC 2019", "Li empirical software engineering 2022", "Gomes systematic mapping observability", "Faseeha microservices monitoring IEEE", "Sridharan O'Reilly", "Majors observability engineering" |
| Periode couverte | 2016-2025 |
| Sources identifiees | ~19 |
| Sources retenues | 13 |
| Date d'extraction | 2026-04-17 |

### Agent B — bases interrogees

| Element | Valeur |
|---------|--------|
| Bases | W3C (w3.org), NIST CSRC, Jaeger docs (jaegertracing.io), Prometheus docs, DORA Research (dora.dev), Grafana Labs docs, O'Reilly catalog, Packt catalog |
| Mots-cles | "W3C Baggage propagation 2024", "NIST SP 800-204C microservices observability", "Jaeger v2 OTel Collector", "Prometheus OpenMetrics CNCF", "DORA MTTR observability", "Accelerate four key metrics DORA", "Grafana Tempo Loki OTel", "Mastering distributed tracing Shkuro Packt" |
| Periode couverte | 2018-2025 |
| Sources identifiees | ~18 |
| Sources retenues | 12 |
| Date d'extraction | 2026-04-17 |

---

## Sources exclues — raisons documentees

| Source | Critere | Raison |
|--------|---------|--------|
| Beyer et al. — Google SRE Book 2016 (niv.5) | E3 | Absorbe par Majors/Fong-Jones/Miranda 2022 (plus recent, meme niveau 5, distinction monitoring/observabilite plus precise) et par NIST SP 800-204C 2022 pour les obligations architecturales — apport marginal sur le PICOC specifique |
| Mastering Distributed Tracing — Shkuro, Packt 2019 (niv.5) | E2 partiel | Reference les SDKs Jaeger propriétaires que Jaeger v2 (novembre 2024) a officiellement deprecies en faveur d'OTel — la source est partiellement obsolete sur son point cle (instrumentation Jaeger directe). Son apport sur la theorie des traces est absorbe par Sridharan 2018 et les specs OTel |
| OpenTelemetry Specification Status Summary 2025 (niv.2) | E3 | Index de statut absorbe par la specification OTel v1.x principale — pas de contenu additionnel sur le fond du PICOC, uniquement un resume de l'etat d'avancement des differentes parties de la spec |
| NIST SP 800-204A — Building Secure Microservices-based Applications (2019) | E3 | Absorbe par NIST SP 800-204C (2022, plus recent) qui reprend et etend les prescriptions de 800-204A sur l'observabilite |
| NIST SP 800-204B — Attribute-based Access Control for Microservices (2021) | E2 | Traite de l'autorisation dans les microservices, pas de l'observabilite — hors PICOC direct |
| New Relic / Datadog white papers observabilite (niv.5/vendeur) | E1 + E4 | Biais vendeur structure — les deux fournisseurs APM propriétaires ont interet a cadrer l'observabilite autour de leurs solutions specifiques, ce qui est contraire au principe OTel vendor-agnostic que toutes les sources independantes valident |
| W3C Trace Context HTTP (niv.1, draft) | E2 | Draft non-finalise (statut Working Draft) — la Recommendation L1 2021 couvre les cas d'usage HTTP; le draft HTTP specifique n'ajoute pas de contenu decisonnel sur le PICOC |
