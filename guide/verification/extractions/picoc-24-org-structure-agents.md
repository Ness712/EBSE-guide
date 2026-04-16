# Double Extraction EBSE — PICOC #24 : ai-agent-org-structure

**Date de recherche** : 2026-04-16  
**Protocole** : methodology.md v3.0 §2.1 — double extraction indépendante + vérification Agent C  
**Question PICOC** : Quelle structure organisationnelle d'équipe d'agents IA (rôles, topologie, hiérarchie) maximise la performance sur des tâches de développement logiciel complexes ?

---

## Agent A — Extraction

**Mots-clés** : "multi-agent software engineering LLM roles", "MetaGPT autonomous agent team structure", "AI agent team organization performance", "multi-agent LLM development team hierarchy", "agent role specialization software development", "collaborative AI agents code generation"

### A1 — MetaGPT (Hong et al.)

- **arXiv** : 2308.00352 (ICLR 2024)
- **Auteurs** : Sirui Hong, Mingchen Zhuge, Jiaqi Chen et al. (15 auteurs)
- **Benchmark** : HumanEval (164 tâches) + MBPP (427 tâches) + SoftwareDev (70 custom)
- **Score** : Pass@1 = 85.9% HumanEval, 87.7% MBPP
- **Méthode** : Rôles standardisés (PM, architecte, dev, QA) encodés en SOPs dans des prompt sequences ; paradigme "assembly line"
- **Quote abstract** : *"Remarkable progress has been made on automated problem solving through societies of agents based on large language models (LLMs). Existing LLM-based multi-agent systems can already solve simple dialogue tasks. Solutions to more complex tasks, however, are complicated through logic inconsistencies due to cascading hallucinations caused by naively chaining LLMs."*
- **Niveau pyramide** : 3 (empirique, ICLR 2024)
- **Biais** : Auteurs = développeurs du système (vendor bias fort)
- **Statut** : VÉRIFIÉ Agent C

### A2 — Agyn (Benkovich & Valkov)

- **arXiv** : 2602.01465 (février 2026)
- **Auteurs** : Nikita Benkovich, Vitalii Valkov
- **Benchmark** : SWE-bench (500 tâches)
- **Score** : 72.2% taux de résolution
- **Méthode** : Rôles spécialisés (coordination, recherche, implémentation, review) + sandboxes isolés + protocoles de communication structurés
- **Quote abstract** : *"real-world software development is organized as a collaborative activity carried out by teams following shared methodologies, with clear role separation, communication, and review"*
- **Niveau pyramide** : 3 (preprint)
- **Biais** : Auteurs = développeurs du système, pas d'ablation des rôles publiée
- **Statut** : VÉRIFIÉ Agent C

### A3 — Drop the Hierarchy (Dochkina)

- **arXiv** : 2603.28990 (mars 2026)
- **Auteur** : Victoria Dochkina (solo)
- **N** : 25 000+ runs, 20 810 configurations uniques, 8 modèles, 4-256 agents, 8 protocoles
- **Quote abstract** : *"We present a 25,000-task computational experiment comparing coordination architectures in multi-agent LLM systems across 8 models, 4–256 agents, and 8 protocols. Our key finding is the endogeneity paradox: a hybrid protocol (Sequential) where agent ordering is fixed but role selection is autonomous outperforms both centralized coordination (+14%, p<0.001) and fully autonomous protocols (+44%, Cohen's d=1.86, p<0.0001)."*
- **Scores** : Sequential Q=0.724 vs Coordinator Q=0.640 (+14%, p<0.001) vs Shared/full autonomy Q=0.503 (+44%, Cohen's d=1.86, p<0.0001)
- **Niveau pyramide** : 3 (preprint, solo-author, pas encore peer-reviewed)
- **Biais** : Solo-author, pas de réplication indépendante
- **Statut** : VÉRIFIÉ Agent C — chiffres +14%/+44% confirmés

### A4 — Ashrafi et al. (feedback loop)

- **arXiv** : 2505.02133 (mai 2025)
- **Auteurs** : Nazmus Ashrafi, Salah Bouktif, Mohammed Mediani
- **Benchmark** : HumanEval (19 LLMs)
- **Scores** : Basic (1 agent) = 54.09% ; AC (Analyst-Coder, 2 agents) = 53.34% (-0.75%) ; ACT (3 agents) = 54.04% — SANS runtime debugging. AVEC debugging runtime : gains significatifs.
- **Finding** : Sans boucle de feedback d'exécution, ajouter des agents n'améliore pas la précision et dégrade légèrement la robustesse
- **Niveau pyramide** : 3 (empirique, preprint)
- **Statut** : VÉRIFIÉ Agent C

---

## Agent B — Extraction

**Mots-clés** : "autonomous agent organizational structure software", "LLM agent team topology ablation", "multi-agent hierarchy vs flat organization empirical", "drop the hierarchy agents autonomous", "agent collaboration protocol software engineering", "Agyn adaptive agent structure"

### B1 — ALMAS (Tawosi et al.)

- **arXiv** : 2510.03463 (Workshop MAS-GAIN @ ASE 2025)
- **Auteurs** : Vali Tawosi, Keshav Ramani, Salwa Alamir, Xiaomo Liu
- **Benchmark** : Aucun benchmark numérique — démonstration qualitative end-to-end
- **Méthode** : Rôles agile (PM, sprint planner, dev, testeur, reviewer) ; Supervisor Agent ; approche "3C" (Context-aware, Collaborative, Cost-effective)
- **Niveau pyramide** : 4 (workshop paper sans résultats quantitatifs)
- **EXCLU** : Insuffisant pour GRADE — aucun benchmark numérique publié

### B2 — ChatCollab (Klieger et al., Stanford)

- **arXiv** : 2412.01992 (décembre 2024)
- **Auteurs** : Benjamin Klieger, Charis Charitsis, Miroslav Suzara, Sierra Wang, Nick Haber, John C. Mitchell
- **Quote abstract** : *"We explore the potential for productive team-based collaboration between humans and Artificial Intelligence (AI) by presenting and conducting initial tests with a general framework that enables multiple human and AI agents to work together as peers."*
- **Résultats** : "Comparable or better software" vs 3 systèmes antérieurs — évaluation qualitative uniquement
- **Niveau pyramide** : 4 (étude qualitative, N non quantifié)
- **EXCLU** : Qualitatif, N non quantifié — pertinent pour contexte humain+IA mais insuffisant pour GRADE

### B3 — SE 3.0 / AIDev (Li, Zhang, Hassan)

- **arXiv** : 2507.15003 (2025)
- **Auteurs** : Hao Li, Haoxiang Zhang, Ahmed E. Hassan
- **N** : 456 000 PRs (CORRIGÉ Agent C — pas 456 535), 61 000 repos, 47 000 développeurs, 5 agents
- **Quote abstract** : *"The future of software engineering--SE 3.0--is unfolding with the rise of AI teammates: autonomous, goal-driven systems collaborating with human developers. Among these, autonomous coding agents are especially transformative, now actively initiating, reviewing, and evolving code at scale."*
- **Résultats** : Trust gap — agents plus rapides que humains mais PRs acceptées moins fréquemment ; code agents structurellement plus simple
- **Niveau pyramide** : 2 (empirique observationnel large-scale)
- **Statut** : VÉRIFIÉ Agent C

---

## Agent C — Corrections et vérification

### C1 — MetaGPT : score exact

**Avant** : "85% HumanEval"  
**Après** : 85.9% HumanEval (Pass@1), 87.7% MBPP. Benchmark correct = HumanEval+MBPP+SoftwareDev (pas SWE-bench). ICLR 2024 confirmé.  
**Sévérité** : Mineure

### C2 — Agyn : confirmé

72.2% sur SWE-bench 500. arXiv:2602.01465 exact. Pas de fabrication.

### C3 — Dochkina : nuance +44%

**Avant** : "+44% vs pleine autonomie"  
**Après** : +44% = **spread entre Sequential et Shared** (protocoles les moins structurés — Broadcast/Shared). C'est l'écart entre le meilleur et le pire protocole, pas seulement "hiérarchie vs autonomie". Sequential Q=0.724 vs Shared Q=0.503. Cohen's d=1.86.  
**Nuance critique** : Le +14% (Sequential vs Coordinator) est conditionnel au niveau de capacité du modèle. En dessous d'un seuil de capacité, la hiérarchie rigide reste supérieure.  
**Sévérité** : Importante (nuance nécessaire)

### C4 — SE 3.0/AIDev : N exact

**Avant** : "N=456 535 PRs"  
**Après** : N = **456 000 PRs** (pas 456 535). Écart probablement dû à un arrondi dans les sources secondaires.  
**Sévérité** : Mineure

### C5 — Ashrafi : dégradation nuancée

**Avant** : "ajouter des agents sans feedback loop d'exécution dégrade la précision"  
**Après** : La dégradation est réelle mais **modeste en accuracy** (-0.75% : 54.09% → 53.34%) et **plus visible en robustesse** (129.27 baseline). Avec runtime debugging, les gains sont significatifs. Ce n'est pas une dégradation catastrophique — c'est une absence de gain + légère dégradation sans feedback.  
**Sévérité** : Nuance importante

### Fabrications détectées : AUCUNE

Aucun arXiv ID inventé. L'écart N=456 535 vs 456 000 est une imprécision, pas une fabrication.

---

## Sources retenues après déduplication

| # | Source | arXiv | Décision | Raison |
|---|--------|-------|----------|--------|
| 1 | MetaGPT | 2308.00352 | **RETENU** | ICLR 2024, N>500, rôles explicites, résultats quantitatifs |
| 2 | Agyn | 2602.01465 | **RETENU** | SWE-bench 500, 72.2%, rôles équipe, 2026 |
| 3 | Dochkina | 2603.28990 | **RETENU** | N=25 000, 8 protocoles, statistiques robustes, résultat central |
| 4 | Ashrafi | 2505.02133 | **RETENU** | 19 LLMs, finding feedback loop, corrobore contre-intuitif |
| 5 | AIDev/SE 3.0 | 2507.15003 | **RETENU** | N=456 000 PRs, in-the-wild, trust gap production |
| 6 | ALMAS | 2510.03463 | **EXCLU** | Workshop paper, aucun benchmark quantitatif |
| 7 | ChatCollab | 2412.01992 | **EXCLU** | Qualitatif, N non quantifié — utile pour contexte uniquement |

---

## GRADE calculé

| Facteur | Valeur | Justification |
|---------|--------|---------------|
| Base | 3 | Dominé par preprints + 1 ICLR peer-reviewed (niveau 2-3) |
| +convergence | +1 | 4 sources indépendantes convergent sur valeur structure + feedback |
| +effet important | +1 | Cohen's d=1.86 (Dochkina) — effet très large ; statistiquement robuste |
| -biais vendor | -1 | MetaGPT et Agyn : auteurs = développeurs des systèmes évalués |
| -indirectness | -1 | HumanEval/SWE-bench ≠ projets production réels ; seul AIDev est in-the-wild |

**GRADE final : 3/7 — RECOMMANDE FRAGILE**

Niveau de confiance : Robuste sur le principe (structure + feedback = nécessaire) mais nuancé sur l'architecture optimale (hybride de Dochkina non répliqué indépendamment).

---

## Principe recommandé

Adopter une structure hybride : séquentialité d'exécution fixe (pipeline défini : PM → architecte → dev → reviewer) avec sélection autonome des rôles par les agents — ce protocole surpasse à la fois la hiérarchie rigide (+14%, p<0.001) et la pleine autonomie (+44%, Cohen's d=1.86, p<0.0001), à condition que le système atteigne un seuil minimal de capacité du modèle. **La condition sine qua non de tout gain multi-agent est une boucle de feedback d'exécution runtime** : sans retour d'exécution (compilation, tests, erreurs runtime), ajouter des agents n'améliore pas la précision et dégrade la robustesse.

## Robustesse

**PARTIELLE**

- Points forts : convergence entre 4 sources indépendantes ; Dochkina N=25 000 statistiquement puissant (d=1.86) ; Ashrafi reproduit le finding feedback sur 19 LLMs ; AIDev in-the-wild 456 000 PRs
- Points faibles : vendor bias MetaGPT/Agyn ; Dochkina solo-author non répliqué ; benchmarks ≠ production (sauf AIDev) ; finding hybride conditionnel au niveau de capacité du modèle

---

## Divergences A vs B

| Divergence | Agent A | Agent B | Résolution |
|-----------|---------|---------|------------|
| ALMAS inclus | Non trouvé | Trouvé | **Exclu** — workshop, pas de benchmark quantitatif |
| ChatCollab inclus | Non trouvé | Trouvé | **Exclu** pour GRADE — qualitatif |
| Focus | Métriques quantitatives | Diversité architectures | Complémentaires — A pour GRADE, B pour contexte |
| Dochkina | Identifiée par A | Identifiée par B | Doublon résolu — source unique |
| Aucune contradiction majeure entre A et B | | | |
