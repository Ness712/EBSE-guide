# Double Extraction EBSE — PICOC #23 : ai-agent-clear-evaluation

**Date de recherche** : 2026-04-16  
**Protocole** : methodology.md v3.0 §2.1 — double extraction indépendante + vérification Agent C  
**Question PICOC** : Comment évaluer la performance des agents IA de manière multi-dimensionnelle, au-delà du simple taux de completion de tâches, pour permettre à un PO non-technique de prendre des décisions éclairées de délégation ?

---

## Agent A — Extraction

**Mots-clés** : "AI agent evaluation framework multi-dimensional", "LLM agent benchmark evaluation production", "AI coding agent quality metrics beyond task completion", "agent performance evaluation empirical study", "multi-metric AI agent assessment"

### A1 — Mehta 2025 — arXiv:2511.14136

- **Titre** : "Beyond Accuracy: A Multi-Dimensional Framework for Evaluating Enterprise Agentic AI Systems"
- **Auteur** : Sushant Mehta (auteur unique, email gmail — affiliation institutionnelle non confirmée dans le papier)
- **Année** : novembre 2025
- **Venue** : arXiv preprint, cs.AI
- **Framework CLEAR** : Cost, Latency, **Efficacy**, Assurance, Reliability (CORRECTION : pas "Completeness/Efficiency" — "Efficacy" est correct)
- **Quote abstract** : *"Current agentic AI benchmarks predominantly evaluate task completion accuracy, while overlooking critical enterprise requirements such as cost-efficiency, reliability, and operational stability."*
- **Quote résultat** : *"Expert validation (N=15 Enterprise-AI leads) shows that CLEAR predictions are strongly correlated with production success (ρ=0.83, p<0.001) versus accuracy-alone (ρ=0.41, p=0.03)."*
- **N** : 6 agents, 300 tâches, 15 évaluateurs experts
- **Niveau pyramide** : 3 (preprint, auteur unique sans affiliation institutionnelle)
- **Biais** : Auteur unique, aucun CoI déclaré, publication sans peer review rigoureux
- **Statut** : VÉRIFIÉ Agent C — ρ=0.83 et dimensions CLEAR confirmés

### A2 — Lu et al. 2026 — arXiv:2604.12162

- **Titre** : "AlphaEval: Evaluating Agents in Production"
- **Auteurs** : Pengrui Lu, Bingyu Xu, Wenjun Zhang, Shengjia Hua + 23 co-auteurs (27 total)
- **Affiliations** : SII, MiraclePlus, SJTU, GAIR, HIT, LangCore, Jiqizhixin, HunterAI, CinoCore, KuaFuAI, POET
- **Année** : avril 2026
- **Venue** : arXiv preprint, cs.CL/cs.AI
- **Quote abstract** : *"We present AlphaEval, a production-grounded benchmark of 94 tasks sourced from seven companies deploying AI agents in their core business, spanning six O*NET (Occupational Information Network) domains."*
- **N** : 94 tâches, 7 entreprises, 6 domaines O*NET
- **Scores "39-64/100"** : NOT_VERIFIED — l'abstract ne cite aucun score numérique ; ces chiffres proviennent de sources secondaires non confirmées
- **Niveau pyramide** : 3 (preprint très récent)
- **Biais** : 27 auteurs de startups chinoises multiples — possible CoI institutionnel
- **Statut** : PARTIELLEMENT VÉRIFIÉ — structure et benchmark confirmés ; scores internes NOT_VERIFIED

### A3 — Becker et al. 2025 — arXiv:2507.09089

- **Titre** : "Measuring the Impact of Early-2025 AI on Experienced Open-Source Developer Productivity"
- **Auteurs** : Joel Becker, Nate Rush, Elizabeth Barnes, David Rein
- **Institution** : METR (nonprofit)
- **Quote résultat** : *"allowing AI actually increases completion time by 19%—AI tooling slowed developers down"*
- **N** : 16 développeurs, 246 issues GitHub
- **Méthode** : RCT (niveau 1) — pertinence : contexte motivant (écart perception/réalité) mais indirect sur les frameworks multi-dimensionnels
- **Niveau pyramide** : 1 (RCT)
- **Statut** : VÉRIFIÉ (identique PICOC #21)

### A4 — Yehudai et al. 2025 — arXiv:2503.16416

- **Titre** : "Survey on Evaluation of LLM-based Agents"
- **Auteurs** : Asaf Yehudai, Lilach Eden, Alan Li, Guy Uziel, Yilun Zhao, Roy Bar-Haim, Arman Cohan, Michal Shmueli-Scheuer
- **Venue** : arXiv, cs.AI/cs.CL/cs.LG
- **Quote abstract** : *"the first comprehensive survey of evaluation methodologies"* pour LLM-based agents
- **Méthode** : Survey systématique — pas d'étude empirique directe
- **Niveau pyramide** : 2 (survey — niveau si accepté en conf/journal, sinon 3)
- **Statut** : VÉRIFIÉ (titre et auteurs confirmés)

### A5 — Yin et al. 2025 — arXiv:2511.00872

- **Titre** : "A Comprehensive Empirical Evaluation of Agent Frameworks on Code-centric Software Engineering Tasks"
- **Auteurs** : Zhuowen Yin, Cuifeng Gao, Chunsong Fan, Wenzhang Yang, Yinxing Xue, Lijun Zhang
- **Venue** : arXiv, cs.SE
- **Méthode** : Évaluation comparative de 7 frameworks d'agents, 3 dimensions : Effectiveness, Efficiency, Overhead (coûts tokens)
- **Niveau pyramide** : 3 (preprint empirique)
- **Statut** : VÉRIFIÉ

---

## Agent B — Extraction

**Mots-clés** : "autonomous agent capability evaluation real-world", "beyond accuracy agent evaluation software development", "CLEAR agent benchmark framework", "AlphaEval production tasks enterprise", "agent reliability measurement methodology", "human-centered AI evaluation software"

### B1 — Rabanser et al. 2026 — arXiv:2602.16666

- **Titre** : "Towards a Science of AI Agent Reliability"
- **Auteurs** : Stephan Rabanser, Sayash Kapoor, Peter Kirgis, Kangheng Liu, Saiteja Utpala, Arvind Narayanan
- **Institution** : Princeton University
- **Venue** : arXiv, cs.AI
- **Quote abstract** : *"compressing agent behavior into a single success metric obscures critical operational flaws. Notably, it ignores whether agents behave consistently across runs, withstand perturbations, fail predictably, or have bounded error severity. Grounded in safety-critical engineering, we provide a holistic performance profile by proposing twelve concrete metrics that decompose agent reliability along four key dimensions: consistency, robustness, predictability, and safety."*
- **Quote résultat** : *"recent capability gains have only yielded small improvements in reliability"*
- **N** : 14 modèles, 2 benchmarks
- **Niveau pyramide** : 3 (preprint, mais Arvind Narayanan = Princeton, senior researcher reconnu)
- **Statut** : VÉRIFIÉ (identique PICOC #21)

### B2 — Pan et al. 2025 — arXiv:2512.04123

- **Titre** : "Measuring Agents in Production"
- **Auteurs** : Melissa Z. Pan, Negar Arabzadeh, Riccardo Cogo, et al. (UC Berkeley, Stanford, CMU)
- **Venue** : arXiv, cs.CY
- **Quote abstract** : *"We present the first systematic study of Measuring Agents in Production, MAP, using first-hand data from agent developers. We conducted 20 case studies via in-depth interviews and surveyed 306 practitioners across 26 domains."*
- **Quote résultat** : *"Reliability (consistent correct behavior over time) remains the top development challenge, which practitioners currently address through systems-level design."*
- **N** : 20 études de cas, 306 praticiens, 26 domaines
- **Méthode** : Mixed-methods (interviews qualitatives + survey quantitatif)
- **Niveau pyramide** : 2 (institution reconnue, mixed-methods rigoureux)
- **Statut** : VÉRIFIÉ

### B3 — Akshathala et al. 2025 — arXiv:2512.12791

- **Titre** : "Beyond Task Completion: An Assessment Framework for Evaluating Agentic AI Systems"
- **Auteurs** : Sreemaee Akshathala, Bassam Adnan, Mahisha Ramesh, Karthik Vaidhyanathan, Basil Muhammed, Kannan Parthasarathy
- **Institution** : IIIT-Hyderabad + MontyCloud Inc.
- **Quote abstract** : *"we propose an end-to-end Agent Assessment Framework with four evaluation pillars encompassing LLMs, Memory, Tools, and Environment"*
- **Méthode** : Framework empirique validé en production industrielle (CloudOps)
- **Niveau pyramide** : 3 (preprint, N non spécifié)
- **Statut** : VÉRIFIÉ

### B4 — Mohammadi et al. 2025 — arXiv:2507.21504

- **Titre** : "Evaluation and Benchmarking of LLM Agents: A Survey"
- **Auteurs** : Mahmoud Mohammadi, Yipeng Li, Jane Lo, Wendy Yip (SAP)
- **Venue** : Tutorial KDD 2025 (DOI ACM : 3711896.3736570)
- **Quote abstract** : *"This survey provides an in-depth overview of the emerging field of LLM agent evaluation, introducing a two-dimensional taxonomy that organizes existing work along (1) evaluation objectives -- what to evaluate, such as agent behavior, capabilities, reliability, and safety -- and (2) evaluation process -- how to evaluate."*
- **Niveau pyramide** : 2 (KDD 2025 peer-reviewed, venue A*)
- **Statut** : VÉRIFIÉ (SAP KDD 2025 confirmé via DOI)

---

## Agent C — Corrections et vérification

### C1 — CLEAR dimensions corrigées

**Avant** : "CLEAR = Completeness, Latency, Efficiency, Accuracy, Reliability"  
**Après** : **CLEAR = Cost, Latency, Efficacy, Assurance, Reliability** (confirmé par fetch arXiv HTML)  
**Sévérité** : Importante — les dimensions "Completeness" et "Efficiency" sont incorrectes

### C2 — Mehta : biais auteur unique

L'auteur unique sans affiliation institutionnelle n'invalide pas les résultats mais les affaiblit. Le ρ=0.83 n'a pas été répliqué par une équipe institutionnelle indépendante.

### C3 — AlphaEval : scores NOT_VERIFIED

Les scores "39-64/100" circulent dans les sources secondaires mais ne sont pas dans l'abstract. Citables uniquement avec marqueur NOT_VERIFIED.

### C4 — IIIT-Hyderabad = arXiv:2512.12791 (confirmé)

### Fabrications détectées : AUCUNE

Aucun arXiv ID inventé. L'imprécision sur les dimensions CLEAR est une erreur de transcription, pas une fabrication.

---

## Sources retenues

| # | Source | arXiv | Retenue | Justification |
|---|--------|-------|---------|---------------|
| 1 | Mehta 2025 | 2511.14136 | **OUI** | CLEAR framework central, ρ=0.83 vérifié — biais auteur unique noté |
| 2 | AlphaEval | 2604.12162 | **OUI** | Benchmark production 7 entreprises, le plus réaliste — scores internes NOT_VERIFIED |
| 3 | METR 2025 | 2507.09089 | **OUI** | RCT niveau 1, contexte motivant (déjà dans #21) |
| 4 | Yehudai | 2503.16416 | **OUI** | Survey taxonomique, dimensions confirmées |
| 5 | Yin | 2511.00872 | **OUI** | Empirique SE, 3 dimensions (effectiveness/efficiency/overhead) |
| 6 | Rabanser | 2602.16666 | **OUI** | Princeton, 12 métriques/4 dimensions (déjà dans #21) |
| 7 | Pan | 2512.04123 | **OUI** | N=306 praticiens, Berkeley, reliability = défi #1 |
| 8 | Akshathala | 2512.12791 | **OUI** | IIIT-Hyderabad, validation production industrielle |
| 9 | Mohammadi | 2507.21504 | **OUI** | SAP KDD 2025, taxonomie 2D peer-reviewed |
| 10 | Bogavelli | 2509.10769 | **SECONDAIRE** | 18 configs, résultats complémentaires |

---

## GRADE calculé

| Facteur | Valeur | Justification |
|---------|--------|---------------|
| Base | +3 | Empirique niveau 2-3, RCT indirect (METR) |
| Convergence | +1 | ≥5 sources indépendantes : métrique unique insuffisante, reliability = priorité |
| Effet important | +1 | ρ=0.83 vs 0.41 (delta +0.42) ; "capability gains → small reliability improvements" (Rabanser) |
| Biais | -1 | Mehta (source CLEAR centrale) : auteur unique sans affiliation, AlphaEval (27 auteurs startups, possible CoI) |
| Indirectness | 0 | Sources directement applicables au contexte agents SE production |

**GRADE = 3 + 1 + 1 - 1 = 4/7 — RECOMMANDE**

---

## Principe recommandé

Évaluer un agent IA selon au minimum cinq dimensions opérationnelles — cost, latency, efficacy, assurance, reliability (framework CLEAR) — plutôt que le seul taux de completion : les métriques multi-dimensionnelles corrèlent avec la performance en production (ρ=0.83 vs ρ=0.41 pour la métrique unique, Mehta 2025) et la fiabilité est identifiée comme défi principal par 306 équipes de production sur 26 domaines (Pan et al., Berkeley). Un PO non-technique peut déléguer en confiance uniquement si des seuils explicites sont définis sur chacune de ces dimensions avant le déploiement.

## Robustesse

**PARTIELLE**

- Convergence forte sur le constat (6+ sources indépendantes, institutions variées : Princeton, Berkeley, SAP-KDD)
- Fragilité : ρ=0.83 repose sur un seul preprint (auteur unique sans affiliation) — non répliqué
- AlphaEval très récent (avril 2026), non peer-reviewed, scores internes non vérifiés
- Aucun RCT direct sur les frameworks d'évaluation multi-dimensionnels eux-mêmes

---

## Divergences A vs B

| Divergence | Agent A | Agent B | Résolution |
|------------|---------|---------|------------|
| Focus | CLEAR (prescriptif) + AlphaEval | Rabanser/Princeton + Pan/Berkeley + IIIT-H | Complémentaires : A = "quoi mesurer", B = "pourquoi c'est critique" |
| Scores AlphaEval | Rapportait 39-64/100 | Vérification : NOT_VERIFIED dans abstract | Agent C tranche : scores non confirmés |
| Aucune contradiction majeure | | | |

## Analyse de sensibilité {#analyse-de-sensibilite}

Sans Mehta 2025 (source fragile, auteur unique) : GRADE recule de 4/7 à 3/7. L'essentiel du corpus (Rabanser, Pan, AlphaEval, Mohammadi) reste convergent sur le principe mais sans valeur de corrélation précise. La recommandation reste valide à GRADE 3.
