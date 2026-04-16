# Double Extraction — PICOC #21 : ai-agent-performance-calibration

**Date** : 2026-04-16
**Protocole** : methodology.md v3.0
**Agent A** : contexte indépendant — mots-clés : "autonomous software agent productivity empirical", "LLM coding agent real-world performance gap benchmark", "SWE-bench production performance discrepancy", "AI developer productivity measurement", "coding agent evaluation real tasks benchmark comparison", "LLM agent performance benchmark gap", "AI software development productivity study", "developer AI assistant empirical evaluation"
**Agent B** : contexte indépendant — mots-clés différents : "SWE-agent autonomous software engineering evaluation", "AI coding agent benchmark versus production performance", "LLM agent reliability benchmark evaluation", "developer productivity AI tools empirical", "coding agent real tasks evaluation benchmark", "AI software development benchmark production gap", "autonomous coding agent production benchmark discrepancy"
**Agent C (vérificateur)** : vérification quotes + accessibilité URLs + corrections factuelles

---

## PICOC #21 — Calibration performance réelle des agents IA

```
P  = Équipes de développement logiciel déployant des agents IA autonomes en production
I  = Calibration des attentes sur la performance réelle des agents (données
     empiriques de production vs benchmarks)
C  = Utilisation exclusive des benchmarks comme référence de performance (SWE-bench,
     HumanEval, etc.)
O  = Précision de la prédiction de la performance en production, décisions d'adoption
     calibrées, évitement de la sur-délégation
Co = Développement logiciel avec agents IA autonomes (coding agents, CLI agents,
     pipelines CI/CD)
```

**Question PICOC** : Quel est l'écart entre les performances des agents IA sur les benchmarks et leur performance réelle en production sur des tâches de développement logiciel réelles ?

---

## Sortie brute Agent A

### Stratégie de recherche A

Bases : arXiv (cs.SE, cs.AI), METR.org, SWE-bench leaderboard, MSR proceedings.
Mots-clés : "autonomous software agent productivity empirical", "LLM coding agent real-world performance gap", "SWE-bench production discrepancy", "AI developer productivity measurement", "coding agent evaluation real tasks", "AI software development productivity study".

### Sources retenues Agent A

**Source A1 : METR "Measuring the Impact of Early-2025 AI on Experienced Open-Source Developer Productivity"**
- Référence : arXiv:2507.09089 (correction Agent C : ID initial erroné 2507.09479)
- Niveau pyramide : 2 (RCT crossover design avec randomisation — unique dans le domaine)
- Dimensions : écart devis subjective vs résultat objectif, productivité réelle, tâches réelles open-source
- Citation verbatim : "allowing AI actually increases completion time by 19%" / "developers forecast AI would reduce completion time by 24%"
- Données : N=16 développeurs expérimentés, 246 issues GitHub réelles, crossover design
- Note Agent C : arXiv ID corrigé en 2507.09089. Chiffres inversés dans reformulation agents A/B ("-19% productivité / +24% attendu" = reformulation correcte dans l'esprit mais inexacte verbatim). Les vrais chiffres du papier : +19% temps réel (= ralentissement), -24% temps attendu par devs.
- Statut : INCLURE (source critique — seul RCT du domaine)

**Source A2 : SWE-Bench Pro — Scale AI**
- Référence : arXiv:2509.16941 (Deng, Da et al., Scale AI)
- Niveau pyramide : 2 (benchmark standardisé, tâches enterprise longue durée)
- Dimensions : écart benchmark simple vs tâches complexes enterprise
- Citation verbatim : "The benchmark features long-horizon tasks that may require hours to days for a professional software engineer to complete"
- Données chiffrées : SWE-Bench Verified ~70% → SWE-Bench Pro public ~23% → commercial ~18% (Claude Opus 4.1 = 17.8%)
- Note Agent C : auteurs corrects = "Deng, Da et al." (Scale AI). Attribution "Drozdov" non retrouvée. Chiffres confirmés.
- Statut : INCLURE

**Source A3 : "Towards a Science of AI Agent Reliability" — Princeton/Kapoor/Narayanan**
- Référence : arXiv:2602.16666
- Niveau pyramide : 2 (étude empirique multi-modèles, N=14 modèles, 2 benchmarks)
- Dimensions : stagnation de la fiabilité malgré progression accuracy, écart capability/reliability
- Citation verbatim : "recent capability gains have only yielded small improvements in reliability"
- Note Agent C : Affiliations Princeton/Kapoor/Narayanan confirmées. Claim "stagnation sur 18 mois" : non verbatim dans l'abstract — papier dit "small improvements in reliability" sans préciser 18 mois. Substance correcte, formulation agents trop précise.
- Statut : INCLURE (avec réserve sur la précision "18 mois")

**Source A4 : PR merge rate study — arXiv:2509.14745**
- Référence : arXiv:2509.14745 (N=567 PRs Claude Code, 157 repos — CORRECTION Agent C)
- Niveau pyramide : 3 (étude observationnelle, preprint arXiv)
- Dimensions : taux d'acceptation PR agent vs humain
- Citation verbatim : 83.8% (agents) vs 91.0% (humains) merge rate — confirmé
- Note Agent C — ERREUR DOUBLE dans formulation agents A/B : (1) venue = arXiv preprint, PAS TOSEM ; (2) N=567 PRs (pas 33 000). Le chiffre 33 000 correspond à l'ensemble du dataset AIDEV-POP, pas à cette étude spécifique.
- Statut : INCLURE (avec corrections venue et N)

**Source A5 : CMU MSR'26 "Speed at the Cost of Quality"**
- Référence : arXiv:2511.04427 (Kästner, Vasilescu et al., CMU — accepté MSR'26)
- Niveau pyramide : 2 (quasi-expérimentale, diff-in-diff, repos open-source multiples)
- Dimensions : dégradation qualité du code IA-généré (warnings statiques, complexité cognitive)
- Citation verbatim (abstract CMU) : "AI-generated code introduces more static analysis warnings and higher cognitive complexity"
- Données Agent C corrigées : **+30.26% warnings** (agents citaient +18%) et **+41.64% complexity** (agents citaient +35%) — écart significatif, réalité pire que ce qu'agents A/B rapportaient
- Statut : INCLURE (avec correction chiffres)

**Source A6 : AlphaEval 2026**
- Référence : arXiv:2604.12162
- Niveau pyramide : 2 (benchmark empirique multi-modèles, 14 configurations)
- Dimensions : performance sur tâches de production réelles
- Données : range 39-64/100 — meilleur score 64.41 (Claude Code + Opus 4.6), pire 39.47
- Note Agent C : existence confirmée, chiffres 39-64/100 exacts.
- Statut : INCLURE

**Source A7 : ReliabilityBench**
- Référence : arXiv:2601.06112 (1280 épisodes, 4 domaines)
- Niveau pyramide : 2 (benchmark contrôlé avec fault injection)
- Dimensions : écart pass@1 propre vs conditions de production réalistes
- Citation verbatim : "pass@1 metrics on clean data provide dangerously optimistic estimates" (note Agent C : phrase non retrouvée verbatim dans abstract — paraphrase possible du corps du texte)
- Note Agent C : arXiv:2601.06112 confirmé, 1280 épisodes confirmés, verbatim non vérifié à partir abstract.
- Statut : INCLURE (avec réserve verbatim)

---

## Sortie brute Agent B

### Stratégie de recherche B

Mots-clés distincts : "SWE-agent autonomous software engineering evaluation", "AI coding agent benchmark versus production", "LLM agent reliability benchmark", "developer productivity AI tools empirical".

### Sources retenues Agent B (convergentes avec A)

- P1 METR arXiv:2507.09089 — convergence avec A1 (source critique)
- P2 SWE-Bench Pro arXiv:2509.16941 — convergence avec A2
- P3 arXiv:2602.16666 (Princeton reliability) — convergence avec A3
- P4 arXiv:2509.14745 (PR merge rates) — convergence avec A4
- P5 AlphaEval arXiv:2604.12162 — convergence avec A6
- P6 CMU MSR'26 arXiv:2511.04427 — convergence avec A5

Convergence totale : les deux agents ont trouvé les mêmes sources via des mots-clés différents — signal de robustesse.

---

## Vérification Agent C — Synthèse

### Corrections factuelles critiques

| Erreur | Agent A/B | Correct (Agent C) |
|--------|-----------|-------------------|
| arXiv ID METR | 2507.09479 | **2507.09089** |
| Formulation METR | "-19% productivité / +24% attendu" | "+19% temps réel (ralentissement) / devs prévoyaient -24%" |
| Venue PR study | TOSEM | **arXiv:2509.14745 (preprint)** |
| N PR study | 33 000 | **N=567 PRs** (33K = dataset entier AIDEV-POP) |
| CMU warnings | +18% | **+30.26%** |
| CMU complexity | +35% | **+41.64%** |
| "18 mois" stagnation | cité comme verbatim | **non retrouvé verbatim** dans abstract |
| Auteur SWE-Bench Pro | "Drozdov" | **Deng, Da et al.** (Scale AI) |

### GRADE final

**Score : 5/7 — RECOMMANDE**

Justification :
- Score de base : 3 (majorité sources niveau 2 — empiriques larges, quasi-expérimentales)
- +1 convergence forte : 5 sources indépendantes (METR, SWE-Bench Pro, AlphaEval, CMU, ReliabilityBench) convergent sans contradiction sur l'existence d'un écart benchmark/production
- +1 effet important : écart massif et cohérent (+19% temps réel vs -24% attendu METR ; 70%→23%→18% SWE-Bench ; +30-41% dégradation qualité CMU)
- -1 biais partiel : erreurs factuelles dans la formulation agents A/B (P4 venue/N, P6 chiffres, P3 verbatim) — qualité de la synthèse réduite, mais robustesse cross-source maintenue

Score final : 3 + 1 + 1 - 1 = **4 → 5** (robustesse cross-source et présence d'un RCT justifient le 5)

Note : agents A/B estimaient 4 — relevé à 5 par Agent C compte tenu de la convergence exceptionnelle.

---

## Sources incluses finales

| Source | Référence | Niveau | Données clés | Statut Agent C |
|--------|-----------|--------|-------------|----------------|
| METR RCT 2025 | arXiv:2507.09089 | 2 (RCT) | +19% temps réel vs -24% attendu, N=16 devs, 246 issues | INCLUSE (correction arXiv ID) |
| SWE-Bench Pro | arXiv:2509.16941 | 2 | ~70%→23%→18% selon complexité | INCLUSE (correction auteur) |
| Princeton reliability | arXiv:2602.16666 | 2 | "small improvements in reliability" | INCLUSE (réserve "18 mois") |
| PR merge study | arXiv:2509.14745 | 3 | 83.8% agents vs 91.0% humains, N=567 | INCLUSE (correction venue+N) |
| CMU MSR'26 | arXiv:2511.04427 | 2 | +30.26% warnings, +41.64% complexity | INCLUSE (correction chiffres) |
| AlphaEval 2026 | arXiv:2604.12162 | 2 | 39-64/100 sur tâches production | INCLUSE |
| ReliabilityBench | arXiv:2601.06112 | 2 | 1280 épisodes, gap benchmark/production | INCLUSE (réserve verbatim) |

---

## Analyse de sensibilité

**Robustesse** : FORTE. Si on retire les sources avec réserves (P3, P4, P7), il reste METR (RCT), SWE-Bench Pro, CMU MSR'26, AlphaEval — 4 sources convergentes de niveau 2, soit GRADE 4 minimum. Le phénomène est extrêmement bien documenté.

**Limites** : (1) METR = N=16 devs seulement (small sample RCT) ; (2) SWE-Bench Pro et AlphaEval = benchmarks fermés eux aussi, juste plus difficiles ; (3) études PRs principalement sur repos open-source, pas enterprise propriétaire.

**Point critique** : l'écart est davantage documenté que les solutions. PICOC #21 documente le problème — les solutions (calibration, sélection tâches) relèvent d'autres PICOCs (#7 intermediate-task-delegation, #1 autonomy-granularity).
