# PRISMA Flow — PICOC #28 : ai-agent-framework-vs-prebuilt

**Date de recherche** : 2026-04-16  
**Bases interrogées** : arXiv (cs.SE, cs.AI), ACM DL, SWE-bench leaderboard, Stack Overflow, Google Scholar, blogs practitioner  
**Mots-clés Agent A** : "agentic framework comparison software development benchmark", "SWE-bench agent performance LangChain AutoGen", "Claude Code benchmark evaluation empirical", "coding agent framework vs integrated system"  
**Mots-clés Agent B** : "Claude Code vs framework autonomous agent real world", "agentic AI tool vs custom framework maintenance burden", "no-code PO AI delegation software development", "integrated coding agent vs framework productivity"  
**Protocole** : methodology.md v3.0 §2.1 — double extraction indépendante + vérification Agent C

---

## Flux

```
IDENTIFICATION
  Sources identifiées (Agent A + Agent B combinés, avant déduplication) :
    - arXiv (cs.SE, cs.AI) : ~25 résultats candidats
    - Conférences peer-reviewed (MSR, ICSE, FSE) : ~8 résultats
    - Leaderboards / benchmarks publics (SWE-bench) : ~5 résultats
    - Blogs practitioner / rapports institutionnels : ~20 résultats
    - Stack Overflow Survey, Anthropic Research : ~4 résultats
  Total identifié (brut) : ~62
  Doublons retirés : 3 (Wang et al., METR, SWE-Compass retrouvés par les deux agents)
  Total après déduplication : ~59

SCREENING (titre + résumé)
  Sources screenées : ~59
  Sources exclues au screening : ~38
    - E1 (comparaisons features sans données empiriques — blogs marketing) : ~18
    - E2 (frameworks hors périmètre — robotique, IA non-logicielle) : ~8
    - E3 (études d'adoption générale IA sans angle framework vs pré-construit) : ~7
    - E4 (études sur les modèles LLM sans comparaison d'outils) : ~5

ELIGIBILITÉ (lecture complète)
  Sources évaluées en détail : ~21
  Sources exclues après lecture complète : ~12
    - Comparaison framework custom vs pré-construit absente : 7
    - Données non quantifiées ou méthodologie insuffisante (blogs niveau 4) : 4
    - Biais commercial trop fort (Devin Annual Review, Anthropic communiqués) : 1

INCLUSION
  Sources incluses : 8
    - Niveau 1 : 1 (METR RCT — indirect)
    - Niveau 2 : 3 (Agarwal et al. MSR '26 ; Pinna et al. MSR '26 ; SWE-Compass)
    - Niveau 3 : 4 (Wang et al. arXiv:2512.01939 ; Anthropic autonomy study ; Stack Overflow 2025 ; Yin et al. arXiv:2511.00872)
    - Niveau 4 : 0 (exclus)

  Corrections Agent C :
    - Wang et al. : niveau 2 (Agent B) → niveau 3 (preprint arXiv, non peer-reviewed)
    - Agarwal et al. : niveau 2 retenu avec réserve (proceedings MSR '26 non encore publiés verbatim)
    - Claims Pinna et al. (92.3%, 72.6%) : NOT_VERIFIED_INDEPENDENTLY — une seule source
    - Blogs niveau 4 : tous exclus de la synthèse

  RÉSULTAT : PREUVE INSUFFISANTE — GRADE 1/7
  Comparaison directe "framework custom vs système pré-construit pour PO délégant tout" absente du corpus.
```

---

## Documentation recherche (Table 2 Kitchenham)

### Agent A — bases interrogées

| Élément | Valeur |
|---------|--------|
| Bases | arXiv (cs.SE), SWE-bench leaderboard, Google Scholar |
| Mots-clés | "SWE-bench agent performance LangChain AutoGen", "Claude Code benchmark evaluation empirical" |
| Période couverte | 2024-2026 |
| Sources identifiées | ~30 |
| Sources retenues | 5 (Yin, Wang, Agarwal, Martinez, Santos) |
| Date d'extraction | 2026-04-16 |

### Agent B — bases interrogées

| Élément | Valeur |
|---------|--------|
| Bases | arXiv (cs.AI), MSR proceedings, Stack Overflow, Anthropic Research |
| Mots-clés | "Claude Code vs framework autonomous agent real world", "agentic AI tool maintenance burden" |
| Période couverte | 2024-2026 |
| Sources identifiées | ~32 |
| Sources retenues | 6 (Wang, Pinna, SWE-Compass, Anthropic, METR, Stack Overflow) |
| Date d'extraction | 2026-04-16 |

---

## Note sur la nature du corpus

Ce PICOC est structurellement limité : la question "framework custom vs système pré-construit pour un PO délégant tout le dev" n'a jamais été étudiée empiriquement. Les raisons sont méthodologiques (populations différentes dans chaque étude) et temporelles (systèmes pré-construits de génération Claude Code trop récents — 2024-2025 — pour avoir une littérature peer-reviewed comparative). Le résultat "PREUVE INSUFFISANTE" est lui-même un finding EBSE valide et documenté, conforme au protocole Kitchenham 2007.

## Sources exclues — raisons documentées

| Source | Raison exclusion |
|--------|-----------------|
| Blogs comparaisons frameworks (instinctools, fungies, etc.) | Opinions sans données empiriques, chiffres non sourcés |
| Devin Annual Review 2025 | Marketing commercial, données non auditées |
| Blog Particula Tech "42%→78% scaffold" | Analyse secondaire non peer-reviewed, niveau 4 |
| DEV community CrewAI benchmark | Tâche unique, méthodologie insuffisante |
| Blog lowcode.agency "Claude Code vs SWE-Agent" | Comparaison qualitative explicitement sans métriques |
| Études adoption générale AI sans framework comparison | Hors périmètre PICOC |
