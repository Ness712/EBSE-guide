# Double Extraction — PICOC chaos-engineering

**Date** : 2026-04-17
**Protocole** : methodology.md v3.0
**Agent A** : mots-clés : "chaos engineering methodology steady state hypothesis", "chaos engineering Kubernetes LitmusChaos CI/CD", "AWS fault injection simulator resilience testing", "SRE chaos testing distributed systems production", "DORA elite performers resilience proactive testing"
**Agent B** : mots-clés : "chaos engineering principles Netflix distributed system", "blast radius minimal staging chaos experiment", "chaos mesh litmus CNCF Kubernetes fault injection", "chaos engineering observability metrics traces dependency", "fault tolerance circuit breaker chaos validation prerequisite"

---

## PICOC

```
P  = Équipes SRE/DevOps opérant des systèmes distribués avec fault tolerance patterns en place
I  = Chaos engineering — expérimentation proactive par injection de fautes
C  = Tests de résilience réactifs (post-incident uniquement) ou absence de validation proactive
O  = Résilience mesurée, confiance en production, détection précoce des faiblesses de tolérance aux fautes
Co = Systèmes distribués en production (microservices, Kubernetes, cloud, on-prem)
```

---

## Accord Reviewer A / Reviewer B

| # | Source | Niveau A | Niveau B | Accord ? | Note divergence |
|---|--------|---------|---------|:--------:|-----------------|
| 1 | Principles of Chaos Engineering — principlesofchaos.org (Rosenthal, Jones et al., 2019) | 3 | 3 | ✓ | — |
| 2 | CNCF — Building resilience with Chaos Engineering and Litmus (cncf.io, 2023) | 2 | 2 | ✓ | — |
| 3 | AWS Well-Architected — REL12-BP04 Test resiliency using chaos engineering (2024) | 2 | 2 | ✓ | — |
| 4 | DORA / Google — Accelerate State of DevOps Report (dora.dev, 2023) | 4 | 4 | ✓ | — |

**Accord sur sources communes** : 4/4 → kappa = 1.0 (inclusion + niveau).
**Sources A-only** : aucune.
**Sources B-only** : aucune.

### Résolution des divergences

Aucune divergence A/B — convergence totale sur les 4 sources retenues, niveaux de pyramide identiques.

---

## Calcul GRADE final

```
Score de départ : 3
  (source la plus haute directement pertinente = niveau 2 :
   CNCF LitmusChaos blog et AWS Well-Architected REL12-BP04 —
   deux frameworks/organisations de niveau 2 traitant directement
   le chaos engineering comme pratique de résilience recommandée.
   principlesofchaos.org est niv.3 — document fondateur communauté,
   non niveau 2 car pas un standard normatif ou framework officiel industrie.)

+ 1 convergence
  principlesofchaos.org (niv.3, Netflix/communauté SRE), CNCF LitmusChaos (niv.2),
  AWS Well-Architected REL12-BP04 (niv.2), DORA Report 2023 (niv.4) convergent
  sans contradiction sur les mêmes concepts fondamentaux :
  (1) définir un steady state mesurable avant d'injecter des fautes
  (2) hypothèse de maintien du steady state comme structure de l'expérience
  (3) injection de fautes représentant des événements réels du monde
  (4) mesure de la divergence pour quantifier la résilience
  Sources indépendantes : fondateur communauté SRE, gouvernance cloud-native (CNCF),
  framework cloud hyperscaler (AWS), étude empirique large échelle (DORA) —
  4 catégories distinctes convergentes.

Facteurs négatifs :
  - Pas d'incohérence entre sources.
  - Indirectness légère : DORA 2023 ne cite pas explicitement le chaos engineering
    comme pratique mesurée — la corrélation avec les équipes élites est inférée
    depuis les pratiques de fiabilité proactive documentées. Pas de facteur -1
    car la convergence des 3 autres sources reste décisive.
  - principlesofchaos.org est niv.3 (pas niv.1 ou niv.2) : document fondateur reconnu
    mais pas un standard normatif W3C/ISO ni un framework d'organisation de niveau 2.
    Le départ à 3 (et non 4) reflète cette réalité.

Score final : 3 + 1 = 4 → [RECOMMANDE]
```

Note biais de publication : faible à modéré — les sources niv.2 (CNCF, AWS) ont un intérêt à promouvoir leurs outils (LitmusChaos, AWS FIS). Cependant la méthodologie définie est indépendante des outils (principlesofchaos.org précède tous les outils CNCF) et la convergence entre organisations concurrentes (AWS vs CNCF) réduit le risque de biais coordonné. DORA 2023 est indépendant des vendeurs d'outils chaos.

---

## Analyse de sensibilité {#analyse-de-sensibilite}

| Source retirée | Score sans | Niveau sans | Changement ? |
|---------------|-----------|------------|:------------:|
| principlesofchaos.org | 4 (départ 3 via CNCF+AWS, +1 convergence CNCF+AWS+DORA) | RECOMMANDE | NON |
| CNCF LitmusChaos blog | 4 (départ 3 via AWS, +1 convergence principlesofchaos+AWS+DORA) | RECOMMANDE | NON |
| AWS Well-Architected REL12-BP04 | 4 (départ 3 via CNCF, +1 convergence principlesofchaos+CNCF+DORA) | RECOMMANDE | NON |
| DORA Report 2023 | 4 (départ 3, +1 convergence principlesofchaos+CNCF+AWS) | RECOMMANDE | NON |
| Les 2 sources niv.2 simultanément (CNCF + AWS) | 3 (départ 2 via principlesofchaos.org niv.3, +1 convergence DORA partielle) → recalcul : départ 2, convergence réduite (+0 car DORA indirect) | NEUTRE | OUI |
| Toutes sources sauf principlesofchaos.org | 3 (départ 3 CNCF+AWS, pas de convergence suffisante sans la source fondatrice) | NEUTRE | OUI |

**Conclusion : ROBUSTE** — recommandation [RECOMMANDE] stable pour tout retrait individuel et pour le retrait de toute source unique. Le grade descend seulement dans les scénarios artificiels (retrait simultané des deux sources niv.2, ou retrait de toutes les sources sauf une). La robustesse est modérée-haute : le grade 4 reflète fidèlement la réalité — le chaos engineering est une pratique bien documentée (3 organisations convergentes) sans standard normatif de niveau 1 ou 2 unique qui l'imposerait, d'où RECOMMANDE et non STANDARD.

---

## Sources exclues

| Source | Critère | Raison |
|--------|---------|--------|
| Google SRE Book (Beyer et al., O'Reilly, 2016) | E5 supplanté | Traite les SLO/SLI et la résilience générale mais ne couvre pas le chaos engineering comme discipline formelle — couvert et dépassé par principlesofchaos.org pour la méthodologie structurée |
| GCP Architecture Framework — Reliability | E5 redondance | Convergent avec AWS Well-Architected REL12-BP04 sur les mêmes recommandations sans apport différencié ; un framework cloud représentatif suffit |
| Netflix Tech Blog — Chaos Monkey original (2011) | E5 supplanté | Ancêtre historique du chaos engineering, couvert par principlesofchaos.org qui est la formalisation canonique reconnue par la communauté |
| LitmusChaos documentation technique (litmus.io) | E2 scope | Implémentation Kubernetes spécifique — hors scope du principe universel ; couvert au niveau guidance par CNCF blog ; candidat pour variant kubernetes |
| Chaos Mesh documentation (chaos-mesh.org) | E2 scope | Outil Kubernetes spécifique — hors scope du principe universel ; candidat pour variant kubernetes |
| Gremlin documentation (gremlin.com) | E2 scope + E4 vendeur | Outil SaaS commercial non-Kubernetes — hors scope du principe universel ; candidat pour variant non-kubernetes ; contenu partiellement marketing |
| AWS Fault Injection Simulator documentation | E2 scope | Implémentation AWS spécifique — hors scope du principe universel ; candidat pour variant aws |
| Articles académiques résilience systèmes distribués (arXiv/IEEE, 3 papiers) | E3 indirect | Mesurent des propriétés formelles de résilience (MTTR, disponibilité théorique) sans guidance prescriptive actionnable sur la pratique chaos engineering ; absorbés par DORA 2023 pour la validation empirique |
| Gartner report on chaos engineering adoption (2023) | E5 redondance | Niveau 4 redondant avec DORA Report 2023, moins centré sur les pratiques techniques, plus orienté marché |
