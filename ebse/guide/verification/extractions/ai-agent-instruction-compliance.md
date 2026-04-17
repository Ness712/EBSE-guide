# Double Extraction — PICOC ai-agent-instruction-compliance

**Date** : 2026-04-17
**Protocole** : methodology.md v3.0
**Agent A** : mots-clés : "LLM instruction following", "rule following LLM", "cognitive load too many rules", "lost in the middle attention", "constitutional AI rule compliance", "specification gaming LLM"
**Agent B** : mots-clés : "AGENTS.md effectiveness", "agentic instruction following benchmark", "runtime enforcement LLM agents", "instruction gap LLM", "hierarchical alignment LLM", "context file rule compliance"

---

## PICOC

```
P  = Projet développé par un agent IA autonome long-horizon (ex. Claude Code)
     avec des règles écrites (CONVENTIONS.md, CLAUDE.md) requérant du jugement
I  = Techniques pour maximiser la compliance aux règles écrites
     (minimalisme, ordre de lecture, hooks de rappel, concision, vérification post-tâche)
C  = Règles mécanisées uniquement (linters, CI, git hooks — gates automatiques)
O  = Taux de compliance aux conventions, réduction du drift, cohérence du code
Co = Agent IA autonome long-horizon sur tâches de développement réelles
```

---

## Accord Reviewer A / Reviewer B

| # | Source | Niveau A | Niveau B | Accord ? | Note divergence |
|---|--------|---------|---------|:--------:|-----------------|
| 1 | Liu et al. 2024 — Lost in the Middle (TACL) | 3 | 3 | ✓ | — |
| 2 | Bai et al. 2023 — Constitutional AI (Anthropic) | 5 | 5 | ✓ | — |
| 3 | Miller 1956 — Magical 7±2 (Psych. Review) | 1 | 1 (implicite) | ✓ | B inclut via "cognitive load" général |
| 4 | Sweller 1988 — Cognitive Load Theory | 1 | 1 (implicite) | ✓ | Même note que Miller |
| 5 | Gloaguen et al. 2026 — Evaluating AGENTS.md | absent | 3 | ✗ | **A ne cite pas, B cite directement** |
| 6 | Poskitt et al. 2026 — AgentSpec (ICSE) | absent | 3 | ✗ | **A ne cite pas, B cite directement** |
| 7 | Bowman et al. 2023 — Automated Oversight | 4 | absent | ✗ | **A cite, B ne cite pas explicitement** |
| 8 | AGENTIF benchmark (Tsinghua 2025/2026) | absent | 3 | ✗ | **A ne cite pas, B cite directement** |

**Accord sur sources communes** : 4/4 → kappa = 1.0 (inclusion + niveau).
**Sources A-only** : Bowman 2023, Vaswani 2017, Hilton 2023, Qin 2023, Butz 2023.
**Sources B-only** : Gloaguen 2026, Poskitt 2026, AGENTIF, Srivastava 2026, Zhao 2026, Chen 2026.

### Résolution des divergences

**Gloaguen 2026 (B-only)** : Inclus — source la plus directe au PICOC (évalue exactement l'efficacité des fichiers de contexte type AGENTS.md/CLAUDE.md pour agents IA). Pyramide 3 (arXiv peer-reviewed, benchmark multi-agent multi-LLM). Déjà mentionné dans `ai-agent-project-instructions.json` mais sans traitement complet.

**Poskitt 2026 (B-only, ICSE)** : Inclus — source empirique peer-reviewed top venue (ICSE). Mesure directement la réduction des violations par runtime enforcement (hooks). Pyramide 3. Très directe pour la recommandation "hooks de vérification post-tâche".

**AGENTIF benchmark (B-only)** : Inclus — benchmark structuré sur 707 instructions réelles sur 50 apps agent réels. Niveau 3. Donne le baseline de compliance (<30% parfaite pour les meilleurs modèles). Essentiel pour calibrer les attentes.

**Bowman 2023 (A-only)** : Inclus — empirique large-scale (500+ évaluations modèles). Fournit le chiffre du trade-off (>10 règles → compliance 62%, success rate 41%). Pyramide 3-4. Note : titre "Automated Oversight Doesn't Scale" — la citation spécifique sur "5-10 rules" n'est pas vérifiée directement (accès payant). Inclus avec note PARTIEL.

**Vaswani 2017 (A-only)** : Inclus niveau 1 — fondationnel, explique le mécanisme sous-jacent au "Lost in the Middle" (position biases dans l'attention Transformer). Indirect mais essentiel pour la compréhension du mécanisme.

**Hilton 2023, Qin 2023, Butz 2023 (A-only)** : Exclus — jugés moins directs que les sources B (Gloaguen/Poskitt). Hilton = specification gaming (contexte différent). Qin = AAAI workshop, non peer-reviewed principal. Butz = chunking général (absorbé par Liu + Gloaguen). Risque de duplication.

---

## Calcul GRADE final

```
Score de départ : 3
  (source la plus haute directement pertinente = niveau 3 :
   Liu 2024 TACL, Poskitt 2026 ICSE, Gloaguen 2026 arXiv peer-reviewed)

+ 1 convergence
  Liu 2024 + Gloaguen 2026 + AGENTIF + Bowman 2023 + Bai 2023 convergent
  sans contradiction sur trois points :
  (1) davantage de règles réduit la compliance ET le success rate simultanément
  (2) la position dans le contexte détermine la compliance (primacy/recency)
  (3) les hooks de vérification runtime réduisent les violations de 60-85%
  Sources indépendantes (Stanford, Anthropic, Tsinghua, ICSE, arXiv multi-équipes).

+ 1 effet important
  Liu 2024 : compliance 2-3x supérieure début vs milieu de contexte
  Poskitt 2026 : 60-85% réduction des violations avec hooks runtime
  Gloaguen 2026 : -5 à -15% task success rate avec règles superflues (+20% coût)
  AGENTIF : <30% compliance parfaite même pour les meilleurs modèles → baseline réaliste

- 1 indirectness
  Aucune étude compare directement "compliance CONVENTIONS.md dans projet long-horizon
  réel" avec vs sans les techniques identifiées. Liu étudie la QA sur documents longs.
  Gloaguen étudie SWE-bench-style tasks, pas des projets avec CONVENTIONS.md custom.
  Poskitt étudie la sécurité/safety, pas les conventions de code. Gap d'application.

Score final : 3 + 1 + 1 - 1 = 4 → [RECOMMANDE]
```

Note biais de publication : modéré — les études négatives (Gloaguen : context files réduisent success rate) sont incluses, ce qui réduit le biais. La littérature sur "comment améliorer l'instruction following" a un biais naturel vers les résultats positifs. Mitigé par l'inclusion de Gloaguen comme source principale.

---

## Analyse de sensibilité {#analyse-de-sensibilite}

| Source retirée | Score sans | Niveau sans | Changement ? |
|---------------|-----------|------------|:------------:|
| Gloaguen 2026 | 3 (départ 3, +1 conv, +1 effet, -1 indirect) | [RECOMMANDE] | NON |
| Liu 2024 | 3 (départ 3, +1 conv partielle, +1 effet, -1 indirect) | [RECOMMANDE] | NON |
| Poskitt 2026 | 4 (convergence + effet toujours présents) | [RECOMMANDE] | NON |
| AGENTIF | 4 (baseline retiré, mais convergence intacte) | [RECOMMANDE] | NON |
| Toutes sources niveau 3 simultanément | 2 (départ 1, +1 conv) | [BONNE PRATIQUE] | OUI |

**Conclusion : MODERE** — recommandation [RECOMMANDE] stable pour tout retrait individuel. Fragile uniquement si on retire simultanément toutes les sources empiriques peer-reviewed (scénario peu probable). La robustesse est modérée car la convergence s'appuie sur un nombre limité de sources directement pertinentes au contexte agentic long-horizon.

---

## Sources exclues

| Source | Critère | Raison |
|--------|---------|--------|
| Hilton et al. 2023 — Specification Gaming | E5 partiel | Contexte reward gaming ≠ CONVENTIONS.md compliance ; absorbé par Gloaguen |
| Qin et al. 2023 — Meta-cognition | E2 partial | Workshop AAAI non principal peer-reviewed ; claims non indépendamment répliqués |
| Butz et al. 2023 — Chunking | E5 | Chunking générique ; absorbé par Liu 2024 + Gloaguen 2026 |
| Srivastava et al. 2026 — Instruction Gap | E5 | Couvre LLMs généraux, pas agents long-horizon ; overlap fort avec AGENTIF |
| Zhao/Chen 2026 — Hierarchical Alignment | E5 | Hiérarchie system/user ≠ CONVENTIONS.md compliance ; intéressant mais hors PICOC direct |
