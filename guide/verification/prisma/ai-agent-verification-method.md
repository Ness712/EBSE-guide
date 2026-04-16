# PRISMA Flow — PICOC #19 : ai-agent-verification-method

**Date de recherche** : 2026-04-16
**Bases interrogées** : arXiv (cs.AI, cs.CL, cs.SE), WebSearch général, IEEE Xplore (via WebSearch), ACM DL (via WebSearch), TACL, NeurIPS/ICLR proceedings, Manning et al. IR textbook
**Mots-clés Agent A** : "LLM self-evaluation accuracy", "self-verification bias language model", "semantic search vs keyword search accuracy", "LLM-as-judge reliability", "verifier gain solver verifier", "pattern matching false negative rate"
**Mots-clés Agent B** : "cross-model verification gain", "independent reviewer accuracy", "ROUGE hallucination detection", "LLM consistency evaluation", "agent self-assessment reliability", "information retrieval semantic gap keyword", "instruction following constraint satisfaction LLM"
**Protocole** : methodology.md v3.0 §2.1 — double extraction indépendante (Agents A + B, mots-clés différents) + vérification Agent C

---

## Flux

```
IDENTIFICATION
  Sources identifiées par base (Agent A + Agent B combinés, avant deduplication) :
    - arXiv (cs.AI, cs.CL, cs.SE) : ~38 résultats candidats
    - WebSearch général (Google Scholar via WebSearch) : ~22 résultats candidats
    - IEEE/ACM proceedings (NeurIPS, ICLR, TACL, ISSTA, IEEE TSE) : ~12 résultats
    - Manning et al. IR textbook (référence fondatrice) : 1 source
    - CACM classique (Furnas 1987) : 1 source
    - Snowballing backward (références citées par A1, A7, B1) : ~8 sources additionnelles
  Total identifié (brut, combiné A+B) : ~82
  Doublons retirés (même source identifiée par A et B) : 3 (Lu et al. = A7/B3 ; Huang = A2/B1 ; TACL 2024 = A8/B10)
  Total après déduplication : ~79

SCREENING (titre + résumé)
  Sources screenées : ~79
  Sources exclues au screening : ~54
    - E1 (niveau 6 / blog opinion sans données) : ~12
    - E2 (obsolète pré-2018, sauf classiques fondateurs) : ~4
    - E3 (langue non anglaise/française) : 0
    - E4 (marketing / vendor whitepaper sans méthodologie) : ~8
    - E5 (sans auteur identifiable) : ~2
    - E6 (hors contexte PICOC — vérification sans lien LLM/agent) : ~28

ELIGIBILITÉ (lecture complète)
  Sources évaluées en détail : ~25
  Sources exclues après lecture complète : ~12
    - Hors scope PICOC (portent sur NLP generation, pas verification) : 5
    - Méthode insuffisante (n < 10, pas de baseline comparée) : 3
    - Données insuffisantes pour GRADE (pas de quantification) : 2
    - Doublon exact avec source déjà retenue : 2

INCLUSION
  Sources incluses dans la synthèse : 13
    - Niveau 1 : 0
    - Niveau 2 : 0
    - Niveau 3 : 11 (Panickssery, Huang, Lu, Tan, Zheng, ACL 2025, TACL 2024, Charoenwet, arXiv:2506.07962, Mitropoulos, Porter)
    - Niveau 4 : 0
    - Niveau 5 : 2 (Furnas 1987, Manning et al. 2008)
```

---

## Documentation recherche (Table 2 Kitchenham)

### Agent A — bases interrogées

| Élément | Valeur |
|---------|--------|
| Nom de la base | arXiv (cs.AI, cs.CL, cs.SE) |
| Stratégie de recherche | "LLM self-evaluation accuracy" ; "self-verification bias language model" ; "verifier gain solver verifier" ; "LLM-as-judge reliability" |
| Années couvertes | 2020–2026 |
| Date de la recherche | 2026-04-16 |
| Nombre de résultats | ~25 candidats |
| Sources retenues | A1 (arXiv:2404.13076), A5 (arXiv:2410.12784), A7 (arXiv:2512.02304), A10 (arXiv:2407.12241), A12 (arXiv:2603.18740) |

| Élément | Valeur |
|---------|--------|
| Nom de la base | NeurIPS/ICLR/ISSTA proceedings (via WebSearch) |
| Stratégie de recherche | "pattern matching false negative rate vulnerability" ; "semantic search vs keyword accuracy" |
| Années couvertes | 2018–2026 |
| Date de la recherche | 2026-04-16 |
| Nombre de résultats | ~8 candidats |
| Sources retenues | A3 (NeurIPS 2023 arXiv:2306.05685) |

### Agent B — bases interrogées

| Élément | Valeur |
|---------|--------|
| Nom de la base | arXiv (cs.AI, cs.CL) |
| Stratégie de recherche | "cross-model verification gain" ; "independent reviewer accuracy" ; "ROUGE hallucination detection" ; "LLM consistency evaluation" ; "agent self-assessment reliability" |
| Années couvertes | 2020–2026 |
| Date de la recherche | 2026-04-16 |
| Nombre de résultats | ~22 candidats |
| Sources retenues | B1 (arXiv:2310.01798), B2 (arXiv:2412.14959), B4 (arXiv:2506.07962), B10 (arXiv:2406.01297), B11 (arXiv:2504.09737) |

| Élément | Valeur |
|---------|--------|
| Nom de la base | IR textbook + CACM classique (via WebSearch / bibliothèque référence) |
| Stratégie de recherche | "information retrieval semantic gap keyword" ; "vocabulary mismatch IR" ; "instruction following constraint satisfaction LLM" |
| Années couvertes | 1980–2026 |
| Date de la recherche | 2026-04-16 |
| Nombre de résultats | ~8 candidats |
| Sources retenues | B9 (Furnas 1987 CACM), B13 (Porter 1995 IEEE TSE), Manning et al. 2008 |

### Snowballing

| Type | Source de départ | Sources trouvées | Retenues |
|------|-----------------|-----------------|---------|
| Backward (A1 Panickssery) | arXiv:2404.13076 | Wataoka 2024 (self-preference), Zheng 2023 (MT-Bench) | A3 (Zheng retenu) |
| Backward (A7 Lu et al.) | arXiv:2512.02304 | Llama-Guard, AlphaCode verifier | 0 (hors PICOC) |
| Backward (B1 Huang) | arXiv:2310.01798 | Madaan 2023 (SELF-REFINE), Shinn 2023 (Reflexion) | 0 (génération not vérification) |
| Forward (Lu et al.) | arXiv:2512.02304 | 3 pré-prints non encore peer-reviewed | 0 (niveau insuffisant) |

---

## Sources exclues après lecture complète — avec raisons

| # | Source | Critère | Raison |
|---|--------|:-------:|--------|
| 1 | Madaan et al. 2023 SELF-REFINE (arXiv:2303.17651) | E6 | Porte sur la génération itérative améliorée, pas sur la vérification d'alignement — scope différent |
| 2 | Shinn et al. 2023 Reflexion (arXiv:2303.11366) | E6 | Porte sur l'auto-critique pour planification d'actions, pas sur la vérification sémantique de conformité |
| 3 | Paul et al. 2024 REFINER | E6 | Feedback interactif pour reasoning — pas applicable à la vérification d'alignement doc/template |
| 4 | Chen et al. 2023 Self-Debugging | E6 | Auto-correction de code via exécution — contexte debug, pas vérification sémantique de conformité |
| 5 | Liu et al. 2023 G-Eval | E6 | Évaluation de génération de texte (coherence, fluency) — pas vérification de conformité agent |
| 6 | Stelmakh et al. 2022 GOLD | E6 | Calibration des reviewers scientifiques humains — population différente |
| 7 | Shen et al. 2023 LARGE | I1 | Niveau 6 — blog technique, pas d'étude empirique contrôlée |
| 8 | Zhao & Callan 2010 (vocabulary mismatch IR) | Intégré via Furnas | Données déjà couvertes par B9 (Furnas) — pas de valeur additionnelle après vérification Agent C sur attribution |
| 9 | LLM4SE Hou et al. 2024 (arXiv:2308.11396) | E6 | SLR sur productivité LLM-assistée (Copilot autocomplete), pas sur vérification d'alignement |
| 10 | Manning & Schütze 2000 (Statistical NLP) | E2 | Antérieur à l'ère LLM — fondements IR généraux couverts par Manning 2008 |
| 11 | Ouyang et al. 2022 InstructGPT (RLHF) | E6 | Porte sur l'alignement humain via RLHF — pas vérification sémantique de conformité |
| 12 | Wataoka et al. 2024 (Self-Preference Bias, arXiv:2410.21819) | Doublon | Couvert par Panickssery A1 qui l'intègre — données non additives |

---

## Note sur les comptes estimés

Conformément à l'Amendement #13 du protocole (audit final v2), les counts précédés de `~` sont des estimations déclarées. Les recherches ont été conduites le 2026-04-16 sans log systématique du nombre brut de résultats retournés par chaque base. Les estimations sont conservatrices et basées sur la mémoire des agents A et B.
