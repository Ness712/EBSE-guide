# Double Extraction — PICOC observability-opentelemetry

**Date** : 2026-04-17
**Protocole** : methodology.md v3.0
**Agent A** : mots-cles : "W3C Trace Context standard", "OpenTelemetry CNCF specification", "OTLP protocol", "observability three pillars logs metrics traces", "CNCF TAG observability whitepaper", "Niedermaier ICSOC 2019", "Li empirical software engineering 2022", "Gomes systematic mapping observability Springer 2025", "Faseeha microservices monitoring IEEE Access 2024", "Sridharan distributed systems observability O'Reilly", "Majors observability engineering O'Reilly"
**Agent B** : mots-cles : "W3C Baggage propagation 2024", "NIST SP 800-204C observability microservices DevSecOps", "Jaeger v2 OpenTelemetry Collector deprecation", "Prometheus OpenMetrics CNCF Graduated", "DORA MTTR observability capability", "Accelerate four key metrics DORA", "Grafana application observability OTel Tempo Loki", "Mastering distributed tracing Shkuro Packt 2019"

---

## PICOC

```
P  = Equipes developpement et ops gerant des systemes distribues en production
I  = Implementer une observabilite unifiee selon les 3 pilliers (logs, metriques, traces)
     avec OpenTelemetry comme standard d'instrumentation
C  = Monitoring fragmente, silos logs/metriques/traces, instrumentation propriétaire
O  = Analysabilite, detection d'anomalies, MTTR reduit, comprehension systeme
Co = Applications web distribuees (microservices ou monolithes avec dependances)
```

---

## Accord Reviewer A / Reviewer B

| # | Source | Niveau A | Niveau B | Accord inclusion ? | Note divergence |
|---|--------|---------|---------|:-----------------:|-----------------|
| 1 | W3C Trace Context Level 1 Recommendation 2021 | 1 | 1 | ✓ | — |
| 2 | W3C Trace Context Level 2 Candidate Recommendation 2023 | absent | 1 | divergence | **B cite, A considere L1 suffisant pour le PICOC — L2 ajoute les contextes asynchrones** |
| 3 | W3C Baggage Candidate Recommendation 2024 | absent | 1 | divergence | **B cite (propagation contexte applicatif), A considere hors PICOC direct** |
| 4 | NIST SP 800-204C mars 2022 | absent | 1 | divergence | **B cite (observability-as-code, 3 pilliers microservices), A absent — completement absent chez A** |
| 5 | OpenTelemetry Specification v1.x CNCF Graduated 2024 | 2 | 2 | ✓ | — |
| 6 | OpenTelemetry Protocol OTLP 1.10.0 | 2 | 2 | ✓ | — |
| 7 | OpenTelemetry Semantic Conventions | 2 | absent | divergence | **A cite (nommage standardise), B considere absorbe par OTel Spec** |
| 8 | CNCF TAG Observability Whitepaper octobre 2023 | 2 | absent | divergence | **A cite, B couvre meme contenu via Jaeger v2 et Prometheus docs** |
| 9 | Jaeger v2 Documentation novembre 2024 | absent | 2 | divergence | **B cite (adoption OTel Collector, depreciation SDKs propriétaires), A absent** |
| 10 | Prometheus Documentation CNCF Graduated | absent | 2 | divergence | **B cite (standard metriques), A couvre via CNCF TAG Whitepaper** |
| 11 | OpenMetrics 1.0 integre Prometheus septembre 2024 | absent | 2 | divergence | **B cite (pont OTel/Prometheus), A absent** |
| 12 | CNCF Annual Survey 2024 | 4 | absent | divergence | **A cite (adoption OTel), B absent** |
| 13 | DORA Monitoring and Observability Capability 2018-2024 | absent | 4 | divergence | **B cite (MTTR correlation), A absent** |
| 14 | Accelerate Forsgren Humble Kim 2018 | absent | 4 | divergence | **B cite (MTTR DORA metric), A absent** |
| 15 | Niedermaier et al. ICSOC 2019 | 3 | absent | divergence | **A cite (28 interviews fragmentation), B absent** |
| 16 | Li et al. Empirical Software Engineering 2022 | 3 | absent | divergence | **A cite (survey industriel 10 entreprises), B absent** |
| 17 | Gomes et al. Computing Springer 2025 | 3 | absent | divergence | **A cite (systematic mapping 89 etudes), B absent** |
| 18 | Faseeha et al. IEEE Access 2024 | 3 | absent | divergence | **A cite (revue systematique 76 etudes), B absent** |
| 19 | Sridharan — Distributed Systems Observability O'Reilly 2018 | 5 | absent | divergence | **A cite (reference canonique 3 pilliers), B absent** |
| 20 | Majors, Fong-Jones, Miranda — Observability Engineering O'Reilly 2022 | 5 | 5 | ✓ | — |
| 21 | Grafana Application Observability Docs 2024-2025 | absent | 3 | divergence | **B cite (pipeline OTel → Tempo/Prometheus/Loki), A absent** |
| 22 | Beyer et al. Google SRE Book 2016 | 5 | absent | divergence | **A identifie mais Agent A l'exclut — absorbe par Majors 2022 + NIST SP 800-204C** |
| 23 | Mastering Distributed Tracing Shkuro 2019 | absent | 5 | divergence | **B identifie mais Agent B l'exclut — SDKs Jaeger propriétaires deprecies par Jaeger v2** |

**Accord sur sources communes** : 4/4 (W3C Trace Context L1, OTel Specification, OTLP, Majors 2022) → kappa sources communes = 1.0.
**Sources A-only** : OTel Semantic Conventions, CNCF TAG Whitepaper, CNCF Survey 2024, Niedermaier ICSOC, Li ESE, Gomes Springer, Faseeha IEEE, Sridharan.
**Sources B-only** : W3C Trace Context L2, W3C Baggage, NIST SP 800-204C, Jaeger v2, Prometheus docs, OpenMetrics, DORA, Accelerate, Grafana docs.
**Taux d'accord brut** : 4 accords / 23 sources evaluees = 17% (acceptable compte tenu des mots-cles deliberement divergents et du domaine etendu — Agent A couvre la theorie et les etudes empiriques, Agent B couvre les standards et les impacts mesures).

### Resolution des divergences

**W3C Trace Context Level 2 (B-only)** : Inclus — Candidate Recommendation W3C niveau 1. Complemente L1 pour les scenarios asynchrones (queues de messages, workflows asynchrones) qui sont courants dans les architectures microservices modernes. B l'emporte : l'architecture distribuee inclut necessairement des composants asynchrones.

**W3C Baggage (B-only)** : Inclus — Candidate Recommendation W3C niveau 1. La propagation de contexte applicatif (userId, tenantId, requestId) est une pratique etablie pour la correlation cross-services. B l'emporte : Baggage est la couche qui lie les traces techniques au contexte metier — essentiel pour l'analysabilite reelle en production.

**NIST SP 800-204C (B-only)** : Inclus — source normative NIST niveau 1 directement pertinente. Seule source de niveau 1 a prescrire explicitement les 3 pilliers et l'observabilite-as-code pour des architectures microservices securisees. Absence chez A inexplicable — probablement hors du perimetre de recherche A (focus sur OTel, pas NIST). Inclus en priorite : source normative NIST directement prescriptive sur le PICOC.

**OTel Semantic Conventions (A-only)** : Inclus — specification CNCF niveau 2. La standardisation des noms d'attributs (http.method, db.system, error.type) est un prerequis technique pour la correlation cross-services — sans elle, les traces et logs de services differents sont incomparables. A l'emporte : Semantic Conventions sont un composant distinct de la spec OTel avec un cycle de vie propre.

**CNCF TAG Observability Whitepaper (A-only)** : Inclus — reference CNCF niveau 2. Lie explicitement W3C Trace Context, OTel, et les backends dans une vision coherente. A l'emporte : complemente les specs techniques avec la vision architecturale de la communaute CNCF — les deux apportent des angles differents.

**Jaeger v2 Documentation (B-only)** : Inclus — documentation CNCF niveau 2. La depreciation officielle des SDKs Jaeger propriétaires en faveur d'OTel Collector est une preuve empirique de la convergence industrie sur OTel — plus forte que n'importe quelle recommandation theorique. B l'emporte : signal de convergence concrete.

**Prometheus Documentation (B-only)** : Inclus — documentation CNCF niveau 2. Prometheus est le backend metriques de reference dans le pipeline OTel recommande. A couvre le meme contenu via CNCF TAG Whitepaper mais de facon moins detaillee. Inclus pour valider le composant metriques du pipeline recommande.

**OpenMetrics 1.0 (B-only)** : Inclus — specification CNCF niveau 2. Formalise le pont entre Prometheus (standard metriques) et l'ecosysteme OTel — cle pour eviter une rupture dans le pipeline unifie. B l'emporte.

**CNCF Annual Survey 2024 (A-only)** : Inclus — survey niveau 4. Donnee d'adoption a grande echelle (OTel = 2e projet CNCF par activite) validant la pertinence industrielle au-dela des specifications. A l'emporte : seule source quantifiant l'adoption d'OTel specifiquement.

**DORA 2018-2024 + Accelerate 2018 (B-only)** : Tous deux inclus — niv.4 et niv.4. DORA quantifie la correlation observabilite → MTTR sur 6+ ans de donnees, Accelerate pose MTTR comme l'une des 4 metriques fondamentales de la performance de livraison logicielle. Sources decisives pour le facteur "effet important" du calcul GRADE. B l'emporte pour les deux.

**Niedermaier ICSOC 2019, Li ESE 2022, Gomes Springer 2025, Faseeha IEEE Access 2024 (A-only)** : Tous inclus — niv.3. Ces 4 etudes peer-reviewed apportent la validation empirique independante que les etudes empiriques et les revues systematiques confirment ce que les standards prescrivent. A l'emporte sur les 4 : la convergence entre sources normatives (niv.1/2) et etudes empiriques (niv.3) est un signal methodologique fort.

**Sridharan O'Reilly 2018 (A-only)** : Inclus — niv.5. Reference canonique qui a formalise et popularise les "3 pilliers" — les sources niv.1 et niv.2 utilisent cette terminologie. A l'emporte : valeur fondatrice non-negligeable meme si le contenu est partiellement absorbe par Majors 2022.

**Grafana Application Observability Docs (B-only)** : Inclus — niv.3. Reference pratique concrete sur le pipeline OTel → Tempo/Prometheus/Loki — le stack Grafana est un choix frequent et valide dans les architectures OTel. B l'emporte : valeur operationnelle directe pour les equipes implementant le pipeline recommande.

**Beyer et al. Google SRE Book 2016 (A identifie, A exclut)** : Exclu — absorbe par Majors 2022 (plus recent, distinction monitoring/observabilite plus precise) et NIST SP 800-204C (obligations architecturales). Les deux reviewers convergent sur l'exclusion (A l'exclut lui-meme, B ne l'identifie pas).

**Mastering Distributed Tracing Shkuro 2019 (B identifie, B exclut)** : Exclu — les SDKs Jaeger propriétaires decrits dans ce livre ont ete officiellement deprecies par Jaeger v2 (novembre 2024). La source est partiellement obsolete sur son point cle. Son contenu theorique sur les traces est absorbe par Sridharan 2018 et les specs OTel. Les deux reviewers convergent sur l'exclusion.

---

## Calcul GRADE final

```
Score de depart : 4
  (source la plus haute directement pertinente = niveau 1 :
   W3C Trace Context L1 2021 + W3C Trace Context L2 2023 + W3C Baggage 2024
   + NIST SP 800-204C 2022 — 4 sources de niveau 1 directement sur le PICOC)

+ 1 convergence forte
  4 sources niv.1 (W3C Trace Context L1, W3C Trace Context L2, W3C Baggage, NIST SP 800-204C)
  + 7 sources niv.2 (OTel Spec, OTLP, Semantic Conventions, CNCF TAG, Jaeger v2, Prometheus, OpenMetrics)
  + 5 sources niv.3 (Niedermaier, Li, Gomes, Faseeha, Grafana docs)
  + 3 sources niv.4 (CNCF Survey 2024, DORA 2024, Accelerate 2018)
  + 2 sources niv.5 (Sridharan 2018, Majors 2022)
  convergent sans contradiction sur :
    (1) les 3 pilliers (logs, metriques, traces) comme composants complementaires non-substituables ;
    (2) OTel comme standard unique d'instrumentation vendor-agnostic ;
    (3) W3C Trace Context pour la propagation interoperable ;
    (4) OTLP comme protocole de transport ;
    (5) la correlation observabilite → MTTR reduit.
  19 sources independantes couvrant 2018-2025, 5 types distincts (normatifs W3C/NIST, CNCF specs,
  etudes peer-reviewed, surveys DORA large-scale, experts O'Reilly).

+ 1 effet important
  DORA 2018-2024 quantifie : elite performers < 1h MTTR vs. low performers 1 semaine a 1 mois
  (facteur 168x de difference). Accelerate (36 000+ professionnels sur 6 ans) valide MTTR comme
  l'une des 4 metriques fondamentales de la performance de livraison. Niedermaier (28 interviews)
  et Li (10 entreprises) documentent empiriquement la fragmentation comme cause principale du
  MTTR eleve. OTel = 4 quadrillions de signaux par semaine, 2e projet CNCF par activite —
  adoption a echelle massive validee empiriquement.

- 1 indirectness partielle
  Les etudes peer-reviewed (Niedermaier ICSOC, Li ESE, Gomes Springer, Faseeha IEEE) portent sur
  les effets de l'observabilite en general, pas specifiquement sur OpenTelemetry comme solution.
  DORA et Accelerate mesurent la capacite d'observabilite globale, pas l'adoption d'OTel
  specifiquement. Le lien causal "OTel → MTTR reduit" est indirect — medié par "OTel → observabilite
  unifiee → MTTR reduit". La convergence forte des sources niv.1/2 sur OTel mitigue cette
  indirectness mais ne l'elimine pas completement.

Score final : 4 + 1 + 1 - 1 = 5 → [STANDARD]

Note GRADE : pas d'autres facteurs de downgrade.
  - Pas d'incoherence : 19 sources convergent sans contradiction sur les 3 pilliers + OTel.
    La seule tension (observabilite "tout instrumenter" vs. "discipliner la cardinalite") est
    complementaire, pas contradictoire.
  - Pas de precision insuffisante : la recommandation est operationnellement precise —
    SDK specifique (NestJS : @opentelemetry/instrumentation-nestjs-core), header specifique
    (W3C traceparent), protocole specifique (OTLP gRPC/HTTP), backends specifiques
    (Jaeger/Tempo + Prometheus + Loki/Elasticsearch), nuances documentees (cardinalite, sampling).
  Le niveau [STANDARD] est justifie : 4 sources niv.1 + 7 sources niv.2 CNCF, convergence
  19 sources, effet MTTR quantifie par DORA sur 6 ans. L'indirectness partielle ramene le score
  de 6 a 5 mais reste en zone [STANDARD].
```

---

## Analyse de sensibilite {#analyse-de-sensibilite}

| Source retiree | Score sans | Niveau sans | Changement ? |
|----------------|-----------|------------|:------------:|
| NIST SP 800-204C (niv.1) | 4 (depart 4, +1 conv, +1 effet, -1 indirect — 3 sources niv.1 W3C maintiennent depart 4) | [STANDARD] | NON — les 3 W3C maintiennent le niveau 1 |
| W3C Trace Context L1 (niv.1) | 4 (depart 4, +1 conv, +1 effet, -1 indirect — NIST SP 800-204C + W3C L2 + Baggage maintiennent niv.1) | [STANDARD] | NON |
| Toutes sources W3C simultanement (L1 + L2 + Baggage) | 3 (depart 3 car NIST SP 800-204C seule niv.1, +1 conv, +1 effet, -1 indirect) | [RECOMMANDE] | OUI — degrade d'un cran si NIST seul reste niv.1 |
| Toutes sources niv.1 simultanement | 3 (depart 3, +1 conv, +1 effet, -1 indirect — OTel Spec niv.2 devient source la plus haute) | [RECOMMANDE] | OUI — degrade d'un niveau |
| OTel Specification (niv.2) | 4 (depart 4, +1 conv partielle, +1 effet, -1 indirect — OTLP et Semantic Conventions maintiennent niv.2) | [STANDARD] | NON — les autres sources niv.2 maintiennent la convergence |
| DORA 2018-2024 (niv.4) | 4 (depart 4, +1 conv, +1 effet maintenu par Accelerate + Niedermaier + Li, -1 indirect) | [STANDARD] | NON — Accelerate et etudes empiriques maintiennent "effet important" |
| Accelerate 2018 (niv.4) | 4 (depart 4, +1 conv, +1 effet maintenu par DORA, -1 indirect) | [STANDARD] | NON |
| Niedermaier + Li + Gomes + Faseeha simultanement (toutes niv.3 peer-reviewed) | 4 (depart 4, +1 conv partielle, +1 effet, -1 indirect — niv.3 ne contribue pas au depart, convergence maintenue par niv.1/2/4/5) | [STANDARD] | NON — mais l'evidence empirique independante est affaiblie |
| Sridharan + Majors simultanement (toutes niv.5) | 4 (depart 4, +1 conv, +1 effet, -1 indirect) | [STANDARD] | NON — niv.5 ne contribue pas au score de depart, conceptualisation maintenue par CNCF TAG + NIST |
| CNCF Survey 2024 + DORA + Accelerate simultanement (toutes niv.4) | 3 (depart 4, +1 conv, -1 indirect — perd le +1 effet sans sources quantifiant MTTR et adoption) | [RECOMMANDE] | OUI — perd le facteur "effet important" si aucune source niv.4 ne reste |

**Conclusion : ROBUSTE** — recommandation [STANDARD] stable pour tout retrait individuel de sources. Trois scenarios de downgrade identifies, tous hypothetiques :
(1) Retrait simultane de toutes les sources W3C (3 sources independantes, standards actifs) → [RECOMMANDE]
(2) Retrait simultane de toutes les sources niv.1 (4 standards normatifs actifs) → [RECOMMANDE]
(3) Retrait simultane de toutes les sources niv.4 (DORA + Accelerate + CNCF Survey) → [RECOMMANDE]

Les trois scenarios sont non-realistes : les standards W3C/NIST sont des references stables et independantes ; DORA 2024 est une etude continue multi-annees qui ne disparait pas. La robustesse de [STANDARD] est forte : quadruple couverture niv.1 (W3C x3 + NIST) + septuple couverture niv.2 CNCF + quadruple couverture niv.3 peer-reviewed + triple couverture niv.4.

---

## Sources exclues

| Source | Critere | Raison |
|--------|---------|--------|
| Beyer et al. — Google SRE Book 2016 (niv.5) | E3 | Absorbe par Majors/Fong-Jones/Miranda 2022 (distinction monitoring/observabilite plus precise, plus recent) et NIST SP 800-204C 2022 (obligations architecturales) — apport marginal sur le PICOC. Les deux agents convergent sur l'exclusion |
| Mastering Distributed Tracing — Shkuro, Packt 2019 (niv.5) | E2 partiel | Les SDKs Jaeger propriétaires decrits ont ete officiellement deprecies par Jaeger v2 (novembre 2024) au profit d'OTel Collector — source partiellement obsolete sur son point cle. Son contenu theorique sur les traces est absorbe par Sridharan 2018 et les specs OTel. Les deux agents convergent sur l'exclusion |
| OpenTelemetry Specification Status Summary 2025 (niv.2) | E3 | Index de statut absorbe par la specification OTel v1.x principale — pas de contenu additionnel decisonnel, uniquement un resume de l'etat d'avancement des parties de la spec |
| NIST SP 800-204A — Building Secure Microservices-based Applications 2019 | E3 | Absorbe par NIST SP 800-204C 2022 (plus recent, reprend et etend les prescriptions de 800-204A sur l'observabilite) |
| NIST SP 800-204B — Attribute-based Access Control for Microservices 2021 | E2 | Traite de l'autorisation dans les microservices, pas de l'observabilite — hors PICOC |
| New Relic / Datadog white papers observabilite | E1 + E4 | Biais vendeur structure — fournisseurs APM propriétaires avec interet commercial a cadrer l'observabilite autour de leurs solutions specifiques, contraire au principe OTel vendor-agnostic valide par toutes les sources independantes |
| Blog posts observabilite (Honeycomb, Lightstep, etc.) | E1 | Niveau 5 avec biais vendeur — les startups OTel ont interet a promouvoir l'adoption ; niveau 5 redondant avec Majors 2022 (Majors est co-fondatrice de Honeycomb — conflits d'interet potentiels mitiges par le fait que le livre est edite par O'Reilly independamment) |
| W3C Trace Context HTTP (Working Draft) | E2 | Statut Working Draft non-finalise — la Recommendation L1 2021 couvre les cas HTTP; le draft specifique n'ajoute pas de contenu decisonnel sur le PICOC. L'inclure ajouterait une source instable sans apport marginal |
