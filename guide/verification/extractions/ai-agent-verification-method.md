# Double Extraction — PICOC #19 : ai-agent-verification-method

**Date** : 2026-04-16
**Protocole** : methodology.md v3.0
**Agent A** : a_vm_extraction_A_20260416 (contexte indépendant — mots-clés : "LLM self-evaluation accuracy", "self-verification bias", "semantic search vs keyword search", "LLM-as-judge reliability", "verifier gain solver verifier", "pattern matching false negative rate")
**Agent B** : a_vm_extraction_B_20260416 (contexte indépendant — mots-clés différents : "cross-model verification gain", "independent reviewer accuracy", "ROUGE hallucination detection", "LLM consistency evaluation", "agent self-assessment reliability", "information retrieval semantic gap keyword", "instruction following constraint satisfaction LLM")
**Agent C (vérificateur)** : a_vm_verification_C_20260416 (vérification quotes + accessibilité URLs)

---

## PICOC #19 — Verification method

```
P  = Agents IA autonomes (Claude Code, Cursor, Devin, Copilot, Aider) vérifiant
     qu'un document/code est aligné à une référence (template, conventions, spec)
I  = Vérification par lecture complète des fichiers sources + agent indépendant
     avec contexte frais pour les vérifications critiques
C  = C1 : grep / pattern matching comme méthode principale de vérification
     C2 : auto-vérification par le même agent (même contexte)
O  = Taux de faux négatifs (gaps non détectés), précision, détection de violations
     sémantiques
Co = Agents de développement logiciel autonomes, contexte de vérification
     d'alignement document/template/convention
```

---

## Sortie brute Agent A

### Stratégie de recherche A

Bases consultées : arXiv (cs.AI, cs.CL, cs.SE), WebSearch général, NIST AI 600-1, Cursor blog.

Mots-clés : "LLM self-evaluation accuracy", "self-verification bias language model", "semantic search vs keyword search accuracy", "LLM-as-judge reliability", "verifier gain solver verifier", "pattern matching false negative rate".

### Sources identifiées par A

**Source A1 : Panickssery et al. NeurIPS 2024 — arXiv:2404.13076**
- Niveau pyramide : 3 (empirique peer-reviewed, NeurIPS 2024 Main Oral)
- Citation verbatim : "Self-evaluation using large language models (LLMs) has proven valuable... But new biases are introduced due to the same LLM acting as both the evaluator and the evaluatee. [...] we discover a linear correlation between self-recognition capability and the strength of self-preference bias"
- Données chiffrées : corrélation de Kendall τ entre self-recognition et self-preference : 0.41–0.74 selon modèle et fine-tuning
- Ce que la source dit de C2 : démontre causalité (expériences contrôlées) — même LLM comme évaluateur et évalué produit biais systématique
- Conflit d'intérêt : NON (NYU, académique)

**Source A3 : Zheng et al. NeurIPS 2023 — arXiv:2306.05685**
- Niveau pyramide : 3 (empirique peer-reviewed, NeurIPS 2023 Datasets and Benchmarks)
- Citation verbatim : "Strong LLM judges like GPT-4 can match both controlled and crowdsourced human preferences well, achieving over 80% agreement"
- Ce que la source dit de I : LLM externe suffisamment fort est fiable (>80% accord humains)
- Ce que la source dit de C2 : identifie explicitement "self-enhancement bias" comme limitation documentée
- Conflit d'intérêt : NON (UC Berkeley, UCSD, CMU)

**Source A5 : Tan et al. ICLR 2025 — arXiv:2410.12784**
- Niveau pyramide : 3 (empirique peer-reviewed, ICLR 2025)
- Citation verbatim : "many strong models (e.g., GPT-4o) performing just slightly better than random guessing" [sur tâches difficiles]
- Données chiffrées : Claude-3.5-Sonnet 64.3% sur paires GPT-4o → 44.8% sur ses propres paires (chute de 19.5pp)
- Ce que la source dit de C2 : auto-évaluation peut tomber sous le niveau aléatoire sur tâches complexes
- Conflit d'intérêt : NON (UC Berkeley)

**Source A7 : Lu et al. 2025 — arXiv:2512.02304**
- Niveau pyramide : 3 (empirique arXiv, 37 modèles × 9 benchmarks)
- Citation verbatim : "cross-family verification is often the most beneficial, particularly when compared to self-verification" + "Verifier models are biased toward accepting incorrect solutions when performing self-verification or intra-family verification"
- Données chiffrées : 37 modèles, 9 benchmarks, FPR augmente en self-verification pour modèles forts
- Ce que la source dit de I : cross-family verification (≈ agent indépendant) = meilleur gain
- Ce que la source dit de C2 : biais systématique vers acceptation de solutions incorrectes
- Conflit d'intérêt : NON (New York University)

**Source A10 : Charoenwet et al. ISSTA 2024 — arXiv:2407.12241**
- Niveau pyramide : 3 (empirique peer-reviewed, ISSTA 2024)
- Citation verbatim : "At least 76% of the warnings in vulnerable functions are irrelevant to the VCCs, and 22% of VCCs remain undetected due to limitations of SAST rules"
- Données chiffrées : 22% faux négatifs absolus, 76% bruit sur 815 VCCs, 92 projets C/C++
- Ce que la source dit de C1 : pattern matching (SAST rules) produit 22% FN absolus — violations hors patterns non détectées
- Conflit d'intérêt : NON (University of Melbourne / ETH Zurich)

**Source A12 : Mitropoulos et al. 2026 — arXiv:2603.18740**
- Niveau pyramide : 3 (empirique arXiv mars 2026)
- Citation verbatim : "Framing a change as bug-free reduces vulnerability detection rates by 16-93%" ; "Claude Code : 88% success rate" [attaques itératives en contexte agent autonome]
- Ce que la source dit de C2 : contexte contaminé (même agent) réduit détection de 16–93% ; exploitable adversarialement à 88%
- Conflit d'intérêt : NON (affiliations académiques grecques/allemandes)
- Note : contexte précis — attaques itératives sur Claude Code mode agent, pas taux général

### GRADE calculé par A

- Score de départ : 2 (niveau 3 empirique — conformément à methodology.md §2.5)
- +1 convergence : 6+ sources indépendantes convergent
- +1 effet important : A5 (44.8% chute), A10 (22% FN absolus), A12 (16-93% réduction)
- -1 indirectness : sources portent sur reasoning/code/sécurité — pas directement sur vérification d'alignement document/template
- **Score A : 3/7 → RECOMMANDE**

---

## Sortie brute Agent B

### Stratégie de recherche B

Bases consultées : arXiv, IEEE Xplore, ACM DL, WebSearch, Manning et al. IR textbook.

Mots-clés différents de A : "cross-model verification gain", "independent reviewer accuracy", "ROUGE hallucination detection", "LLM consistency evaluation", "agent self-assessment reliability", "information retrieval semantic gap keyword", "instruction following constraint satisfaction LLM".

### Sources identifiées par B

**Source B1 : Huang et al. ICLR 2024 — arXiv:2310.01798**
- Niveau pyramide : 3 (empirique peer-reviewed, ICLR 2024, >500 citations)
- Citation verbatim : "LLMs struggle to self-correct their responses without external feedback, and at times, their performance even degrades after self-correction"
- Ce que la source dit de C2 : méta-analyse — auto-correction intrinsèque (même contexte) échoue en raisonnement et dégrade parfois la performance
- Conflit d'intérêt : NON (Google DeepMind / UIUC)

**Source B2 : ACL 2025 — arXiv:2412.14959**
- Niveau pyramide : 3 (empirique, soumis ACL 2025)
- Données chiffrées (corps du texte) : GPT-3.5-turbo : chute 12.1%, 34% réponses correctes renversées ; Llama-3.1-8B : perte 20.4%, 58.8% renversées
- Note Agent C : chiffres o1-mini (1.5% / 92.3%) non confirmés verbatim — retirer
- Ce que la source dit de C2 : 3 mécanismes documentés (Answer Wavering, Prompt Bias, Cognitive Biases)
- Conflit d'intérêt : NON

**Source B3 : Lu et al. 2025 — arXiv:2512.02304** (même que A7 — doublon identifié)
- Convergence entre A et B sur cette source confirme son importance

**Source B4 : arXiv:2506.07962 2025**
- Niveau pyramide : 3 (empirique, >350 modèles)
- Nuance importante : même des modèles différents ont des erreurs corrélées (~60% d'accord sur erreurs vs 33% hasard)
- Implication pour I : l'indépendance vraie ne se réduit pas à "changer de modèle" — requiert contexte frais ET approche différente (lecture complète)
- Conflit d'intérêt : NON

**Source B9 : Furnas et al. 1987 — Communications of the ACM**
- Niveau pyramide : 5 (expert reconnu, classique IR)
- Citation verbatim (via WebSearch) : "In every case two people favored the same term with probability <0.20"
- ALERTE Agent C : "30-40% faux négatifs keyword" = Zhao & Callan 2010, PAS Furnas — attribution séparée obligatoire
- Ce que la source dit de C1 : vocabulary mismatch fondamental — 80% désaccord terminologique entre experts

**Source B10 : TACL 2024 — arXiv:2406.01297**
- Niveau pyramide : 3 (survey empirique, TACL peer-reviewed)
- Citation verbatim : "no prior work demonstrates successful self-correction with feedback from prompted LLMs, except for studies in tasks that are exceptionally suited for self-correction"
- Ce que la source dit de C2 : méta-conclusion de la littérature — C2 échoue dans les cas généraux

**Source B11 : arXiv:2504.09737 2025 — N=20 000 reviews ICLR 2025**
- Niveau pyramide : 3 (empirique, RCT à grande échelle)
- Données : 27% adoption (reviewers mettant à jour) ; 12 000+ suggestions incorporées
- Ce que la source dit de I : agent indépendant (contexte frais) détecte des lacunes non vues par l'auteur original à grande échelle

**Source B13 : Porter et al. 1995/1997 — IEEE TSE**
- Niveau pyramide : 3 (empirique peer-reviewed, IEEE TSE)
- Données : inspecteur unique : 20–40% de détection ; DBR (lecture complète structurée) > ad hoc > checklist
- Ce que la source dit de I : lecture complète structurée surpasse les checklists (pattern matching)
- Ce que la source dit de C1 : checklists (patterns fixes) moins efficaces et en déclin avec taille d'équipe

### GRADE calculé par B

- Score de départ : 2 (niveau 3 empirique)
- +1 convergence exceptionnelle : 7+ papers indépendants sans contradiction
- +1 grande échelle : B11 (N=20K), B4 (N>350 modèles), nombreux benchmarks
- -1 indirectness : aucune étude directement sur vérification d'alignement document/template
- **Score B : 3/7 → RECOMMANDE**

---

## Vérification Agent C (résumé)

| ID | Titre court | Statut | Action |
|----|-------------|--------|--------|
| A1 | LLM Evaluators Self-Preference (NeurIPS 2024) | VÉRIFIÉ | ACCEPTER |
| A3 | Judging LLM-as-a-Judge (NeurIPS 2023) | VÉRIFIÉ | ACCEPTER |
| A7=B3 | When Does Verification Pay Off? | VÉRIFIÉ | ACCEPTER |
| B1 | LLMs Cannot Self-Correct (ICLR 2024) | VÉRIFIÉ | ACCEPTER |
| B2 | Dark Side Self-Correction (ACL 2025) | PARTIEL | ACCEPTER GPT/Llama ; vérifier o1-mini ; venue "en cours de publication ACL 2025" |
| A5 | JudgeBench (ICLR 2025) | VÉRIFIÉ | ACCEPTER |
| A10 | SAST tools (ISSTA 2024) | VÉRIFIÉ | ACCEPTER |
| B10 | When Can LLMs Correct? (TACL 2024) | VÉRIFIÉ | ACCEPTER |
| B9 | Furnas 1987 Vocabulary Problem | PARTIEL | ACCEPTER <0.20 ; attribution 30-40% → Zhao & Callan 2010 uniquement |
| A12 | Mitropoulos 2026 Confirmation Bias | VÉRIFIÉ | ACCEPTER (préciser contexte 88% = attaques itératives) |

**Corrections appliquées suite Agent C :**
1. B2 : chiffres o1-mini (1.5% / 92.3%) retirés — non confirmés verbatim dans HTML accessible
2. B9 : "30-40% FN keyword" reste attribué à Zhao & Callan 2010 exclusivement, pas Furnas
3. A12 : 88% précisé comme "attaques itératives sur Claude Code en mode agent autonome"
4. B2 venue : "en cours de publication ACL 2025 (preprint)" — pas "ACL 2025 confirmée"
5. Fabrications détectées : 0

---

## Table comparaison A vs B

| Dimension | Agent A | Agent B | Accord |
|-----------|---------|---------|:------:|
| Recommandation | RECOMMANDE | RECOMMANDE | OUI |
| GRADE | 3/7 | 3/7 | OUI (exact) |
| Sources C2 | A1, A5, A7, A12 | B1, B2, B3, B4, B5, B10 | Complémentaire |
| Sources C1 | A10, A11 (SAST + static analysis) | B9, B12, B13 (IR + inspection SW) | Complémentaire |
| Sources I | A3, A6, A7 | B3, B11, B13 | Complémentaire |
| Facteurs + | convergence + effet important | convergence + grande échelle | Compatible |
| Facteurs - | indirectness | indirectness | OUI (même facteur) |
| Robustesse | FRAGILE | FRAGILE | OUI |
| Nuance clé | confirmation bias contextuel (A12) | correlated errors (B4) | Complémentaire |

### Divergences et résolution

**DIV-1 : B2 chiffres o1-mini**
- Cause : Agent B a cité des chiffres (1.5% / 92.3%) non vérifiables dans HTML accessible
- Résolution Agent C : retirer ces chiffres. Impact GRADE : nul (GPT-3.5/Llama suffisants)

**DIV-2 : B9 attribution 30-40%**
- Cause : chiffre de Zhao & Callan 2010 potentiellement mal attribué
- Résolution : confirmer attribution stricte à Zhao & Callan, pas Furnas

**DIV-3 : Score numérique (A: 5.5 initial, B: 5 initial)**
- Cause : les deux agents ont utilisé un score de départ incorrect (4 au lieu de 2 pour niveau 3 per methodology.md §2.5)
- Résolution : recalcul avec score de départ 2 (methodology.md) → résultat final 3/7 pour les deux (RECOMMANDE)

---

## Résultats

- **Accord recommandations** : 1/1 convergence directe (RECOMMANDE)
- **Accord GRADE** : 1/1 exact (3/7 après correction score de départ)
- **Fabrications détectées par Agent C** : 0
- **Corrections mineures** : 5 (o1-mini retiré, attribution B9, précision A12, venue B2, recalcul GRADE)

---

## Sources retenues finales (post-Agent C)

| # | Source | Pyramide | Année | Statut C | Donnée clé |
|---|--------|:--------:|:-----:|:--------:|------------|
| 1 | Panickssery NeurIPS 2024 arXiv:2404.13076 | 3 | 2024 | VÉRIFIÉ | Causalité self-preference bias, τ=0.41–0.74 |
| 2 | Huang ICLR 2024 arXiv:2310.01798 | 3 | 2024 | VÉRIFIÉ | LLMs ne peuvent pas s'auto-corriger en raisonnement |
| 3 | Lu et al. 2025 arXiv:2512.02304 | 3 | 2025 | VÉRIFIÉ | Cross-family verification > self-verification (37 modèles, 9 benchmarks) |
| 4 | Tan ICLR 2025 arXiv:2410.12784 | 3 | 2025 | VÉRIFIÉ | Claude-3.5-Sonnet 64.3% → 44.8% en auto-évaluation |
| 5 | Zheng NeurIPS 2023 arXiv:2306.05685 | 3 | 2023 | VÉRIFIÉ | LLM externe >80% accord humains ; self-enhancement bias documenté |
| 6 | ACL 2025 arXiv:2412.14959 | 3 | 2025 | PARTIEL | GPT-3.5 -12.1%, Llama -20.4% en auto-correction |
| 7 | TACL 2024 arXiv:2406.01297 | 3 | 2024 | VÉRIFIÉ | Méta-conclusion : C2 échoue dans les cas généraux |
| 8 | Charoenwet ISSTA 2024 arXiv:2407.12241 | 3 | 2024 | VÉRIFIÉ | C1 (SAST) : 22% FN absolus, 76% bruit |
| 9 | arXiv:2506.07962 2025 | 3 | 2025 | PARTIEL | Erreurs corrélées même entre modèles distincts (~60% vs 33%) |
| 10 | Porter et al. IEEE TSE 1995/1997 | 3 | 1995 | PARTIEL (paywall) | DBR (lecture complète) > checklist en détection défauts |
| 11 | Mitropoulos arXiv:2603.18740 2026 | 3 | 2026 | VÉRIFIÉ | Confirmation bias : -16% à -93% détection en même contexte |
| 12 | Furnas et al. CACM 1987 | 5 | 1987 | PARTIEL | Vocabulary mismatch : accord terminologique < 20% |
| 13 | Manning et al. IR textbook 2008 | 5 | 2008 | PARTIEL | Fondement théorique limitations grep/keyword |

---

## Calcul GRADE final (post-Agent C)

**Source la plus haute** : niveau 3 (empirique peer-reviewed : NeurIPS 2024 Oral, ICLR 2024, ICLR 2025, TACL, ISSTA 2024)
**Score de départ** : 2 (niveau 3 — methodology.md §2.5 table)

Facteurs positifs :
- **+1 convergence** : 8+ sources indépendantes sans contradiction, couvrant 3 angles (C2 self-preference, C1 pattern FN, I independent gain)
- **+1 effet important** : A5 (−19.5pp auto-évaluation), A10 (22% FN absolus SAST), A12 (−16 à −93% confirmation bias), Lu et al. (verifier gain mesuré)

Facteurs négatifs :
- **−1 indirectness** : aucune étude mesure directement grep vs lecture vs agent frais dans un contexte de vérification d'alignement document/template. Les sources portent sur reasoning (B1, B3), code review (A10, A12), et LLM-as-judge (A1, A3, A5) — extrapolation nécessaire

**Score final : 3/7 → RECOMMANDE**

### Analyse de sensibilité

| Source retirée | Score sans | Niveau | Changement ? |
|----------------|-----------|:------:|:------------:|
| Lu et al. A7/B3 | 3 (convergence reste) | RECOMMANDE | NON |
| Huang B1 | 3 (Panickssery+TACL suffisent) | RECOMMANDE | NON |
| Panickssery A1 | 3 (B1+B2+TACL convergent) | RECOMMANDE | NON |
| Charoenwet A10 | 3 (autres sources C1 restent) | RECOMMANDE | NON |
| Toutes sources C2 sauf Lu | 2 (Lu seul) | BONNE PRATIQUE | OUI (−1) |
| Toutes sources C1 | 2 (angle C1 perdu) | BONNE PRATIQUE | OUI (−1) |

**Conclusion : FRAGILE** — la recommandation tient avec les sources actuelles mais dépend de la convergence multi-source. Si un seul angle (C1 ou C2) perd ses sources, le score descend à BONNE PRATIQUE.

**Sources critiques** : Lu et al. arXiv:2512.02304 (vérification quantitative directe) + Panickssery NeurIPS 2024 (causalité self-preference).

---

## Balance bénéfices/risques (GRADE EtD)

| Dimension | Évaluation |
|-----------|-----------|
| **Bénéfices** | (1) Réduction des faux négatifs sémantiques : violations exprimées différemment du pattern ne sont pas manquées ; (2) Élimination du self-preference bias : agent indépendant non biaisé vers ses propres outputs (A1, A5) ; (3) Détection du confirmation bias contextuel : contexte frais = pas de biais lié à la conversation précédente (A12) |
| **Risques** | (1) Coût tokens x2 environ pour agent indépendant ; (2) Latence accrue pour vérifications mineures ; (3) Erreurs corrélées entre modèles (B4) — l'indépendance ne garantit pas des biais orthogonaux |
| **Balance** | Bénéfices > Risques pour vérifications critiques (alignement template, sécurité, conventions). Pour vérifications mineures et syntaxiques : grep reste approprié et suffisant. |
| **Faisabilite** | Haute — Agent tool Claude Code + lecture de fichiers = nativement disponible |

---

## Limites documentées

1. **Indirectness majeure** : aucune étude ne mesure directement le taux de faux négatifs de C1 (grep) vs I (lecture complète LLM + agent frais) sur des tâches de vérification d'alignement document/template. Les preuves viennent de domaines adjacents (reasoning, code review, LLM-as-judge).

2. **Correlated errors (B4)** : même des agents de familles différentes ont des erreurs corrélées — l'indépendance procédurale (contexte frais + lecture complète) est plus importante que l'indépendance du modèle seul.

3. **B2 données partielles** : chiffres o1-mini non confirmés verbatim — retirés. Les chiffres GPT-3.5 et Llama restent.

4. **Biais de publication** : les études publiées documentent surtout les échecs de C2 — les cas où C2 fonctionne (tâches simples, vérifications syntaxiques) sont moins publiés. Le grade 3 tient compte de cette asymétrie via la nuance "exception : grep approprié pour contraintes syntaxiques".
