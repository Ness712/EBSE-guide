# PRISMA Flow — PICOC chaos-engineering

**Date de recherche** : 2026-04-17
**Bases interrogées** : principlesofchaos.org, CNCF blog, AWS Well-Architected Framework, DORA/Google, Google SRE Book, Netflix Tech Blog, LitmusChaos documentation, Chaos Mesh documentation, WebSearch général
**Mots-clés Agent A** : "chaos engineering methodology steady state hypothesis", "chaos engineering Kubernetes LitmusChaos CI/CD", "AWS fault injection simulator resilience testing", "SRE chaos testing distributed systems production", "DORA elite performers resilience proactive testing"
**Mots-clés Agent B** : "chaos engineering principles Netflix distributed system", "blast radius minimal staging chaos experiment", "chaos mesh litmus CNCF Kubernetes fault injection", "chaos engineering observability metrics traces dependency", "fault tolerance circuit breaker chaos validation prerequisite"
**Protocole** : methodology.md v3.0 §2.1 — double extraction indépendante (Agents A + B, mots-clés différents) + synthèse Agent C

---

## Flux

```
IDENTIFICATION
  Sources identifiées par base (Agent A + Agent B combinés, avant déduplication) :
    - Documents fondateurs / références communauté (principlesofchaos.org, Netflix blog) : 3 résultats candidats
    - Frameworks officiels cloud (AWS Well-Architected, GCP Architecture Framework) : ~5 résultats candidats
    - CNCF (LitmusChaos, Chaos Mesh, blog CNCF) : ~6 résultats candidats
    - Études empiriques / rapports (DORA, Gartner) : ~4 résultats candidats
    - Documentation outils (Gremlin, AWS FIS, Chaos Monkey) : ~8 résultats candidats
    - Articles académiques / surveys sur la résilience : ~6 résultats candidats
    - Livres de référence SRE (Google SRE Book, Betsy Beyer et al.) : ~3 résultats candidats
    - Snowballing backward (références citées par sources principales) : ~4 sources
  Total identifié (brut, combiné A+B) : ~39
  Doublons retirés (même source identifiée par A et B) : 4 (principlesofchaos.org, CNCF LitmusChaos, AWS Well-Architected REL12-BP04, DORA 2023)
  Total après déduplication : ~35

SCREENING (titre + résumé)
  Sources screenées : ~35
  Sources exclues au screening : ~22
    - E1 (blog opinion sans données ou méthodologie formelle) : ~9
    - E2 (hors scope PICOC — chaos engineering général, pas systèmes distribués / résilience mesurable) : ~5
    - E3 (doublons partiels — couverts par sources primaires déjà incluses) : ~5
    - E4 (vendeur / marketing sans substance technique : Gremlin marketing pages) : ~3

ELIGIBILITÉ (lecture complète)
  Sources évaluées en détail : ~13
  Sources exclues après lecture complète : ~9
    - Hors scope PICOC strict (chaos engineering pour infrastructure seule, sans composante systèmes distribués) : 2
    - Niveau de preuve insuffisant (témoignage individuel, pas de methodology ou données généralisables) : 3
    - Redondance forte avec principlesofchaos.org ou CNCF sans apport supplémentaire : 2
    - Documentation outil uniquement sans guidance méthodologique (Chaos Monkey Netflix sans contenu principlesofchaos.org) : 2

INCLUSION
  Sources incluses dans la synthèse : 4
    - Niveau 2 : 2 (CNCF LitmusChaos blog, AWS Well-Architected REL12-BP04)
    - Niveau 3 : 1 (principlesofchaos.org — Rosenthal, Jones et al., Netflix)
    - Niveau 4 : 1 (DORA Accelerate State of DevOps 2023)

  Sources exclues avec raison documentée : 9
    - Google SRE Book (Betsy Beyer et al., 2016) : traite la résilience et les SLO mais ne couvre pas le chaos engineering comme discipline formelle — couvert et dépassé par principlesofchaos.org
    - GCP Architecture Framework — Reliability : convergent avec AWS Well-Architected sur les mêmes points, redondant sans apport différencié
    - Netflix Tech Blog — Chaos Monkey original : couvert par principlesofchaos.org (version canonique de la méthodologie)
    - LitmusChaos documentation officielle (technique) : couvert par CNCF blog qui présente la guidance de haut niveau ; la doc technique est un variant implémentation
    - Chaos Mesh documentation : hors scope du principe universel — candidat pour variant kubernetes
    - Gremlin documentation : hors scope du principe universel — candidat pour variant non-kubernetes
    - Articles académiques sur la résilience des systèmes distribués (3 papiers) : indirects — mesurent des propriétés formelles de résilience sans guidance prescriptive sur la pratique chaos engineering
    - Gartner report on chaos engineering adoption : niveau 4 redondant avec DORA, moins centré sur les pratiques techniques
    - AWS FIS documentation : variant AWS — hors scope du principe universel
```

---

## Documentation recherche (Table 2 Kitchenham)

### Agent A — bases interrogées

| Élément | Valeur |
|---------|--------|
| Bases | principlesofchaos.org, CNCF blog, AWS Well-Architected, DORA/Google, Netflix Tech Blog, WebSearch général |
| Mots-clés | "chaos engineering methodology steady state hypothesis", "chaos engineering Kubernetes LitmusChaos CI/CD", "AWS fault injection simulator resilience testing", "SRE chaos testing distributed systems production", "DORA elite performers resilience proactive testing" |
| Période couverte | 2016-2024 |
| Sources identifiées | ~20 |
| Sources retenues | 4 |
| Date d'extraction | 2026-04-17 |

### Agent B — bases interrogées

| Élément | Valeur |
|---------|--------|
| Bases | principlesofchaos.org, CNCF, AWS, DORA/Google, LitmusChaos docs, Chaos Mesh, WebSearch |
| Mots-clés | "chaos engineering principles Netflix distributed system", "blast radius minimal staging chaos experiment", "chaos mesh litmus CNCF Kubernetes fault injection", "chaos engineering observability metrics traces dependency", "fault tolerance circuit breaker chaos validation prerequisite" |
| Période couverte | 2016-2024 |
| Sources identifiées | ~19 |
| Sources retenues | 4 (convergence totale avec A) |
| Date d'extraction | 2026-04-17 |

---

## Sources exclues — raisons documentées

| Source | Raison exclusion |
|--------|-----------------|
| Google SRE Book (Beyer et al., 2016) | Couvert et dépassé par principlesofchaos.org pour la méthodologie chaos engineering formelle — SRE Book traite les SLO/SLI, pas le chaos engineering comme discipline structurée |
| GCP Architecture Framework — Reliability | Redondance — convergent avec AWS Well-Architected REL12-BP04 sans apport différencié ; un seul framework cloud suffit comme représentant de cette catégorie |
| Netflix Tech Blog — Chaos Monkey original | Couvert par principlesofchaos.org (version canonique) — le blog original Netflix est l'ancêtre mais principlesofchaos.org est la formalisation reconnue |
| LitmusChaos documentation technique (litmus.io) | Hors scope du principe universel — implémentation spécifique ; couvert au niveau guidance par CNCF blog ; candidat pour variant kubernetes |
| Chaos Mesh documentation (chaos-mesh.org) | Hors scope du principe universel — outil Kubernetes spécifique ; candidat pour variant kubernetes |
| Gremlin documentation (gremlin.com) | Hors scope du principe universel — outil SaaS commercial ; candidat pour variant non-kubernetes |
| AWS FIS documentation (docs.aws.amazon.com) | Hors scope du principe universel — implémentation AWS spécifique ; candidat pour variant aws |
| Articles académiques résilience systèmes distribués (3 papiers arXiv/IEEE) | Indirects — mesurent des propriétés formelles (MTTR, disponibilité) sans guidance prescriptive sur la pratique chaos engineering ; absorbés par DORA 2023 pour la dimension empirique |
| Gartner report on chaos engineering adoption | Niveau 4 redondant avec DORA Report 2023 (plus centré pratiques techniques), moins actionnable pour la guidance |
