# PRISMA Flow — ai-agent-instruction-compliance

**Date de recherche** : 2026-04-17
**Agents** : Reviewer A (indépendant) + Reviewer B (indépendant) — contextes séparés
**Bases interrogées** : arXiv (cs.AI, cs.SE, cs.CL), ACL Anthology/TACL, ICSE, NeurIPS, Anthropic research, OpenAI research, cognitive psychology literature, agentic AI governance reports
**Mots-clés Agent A** : "LLM instruction following", "rule following LLM", "cognitive load too many rules", "lost in the middle attention", "constitutional AI rule compliance", "specification gaming LLM", "prompt engineering compliance"
**Mots-clés Agent B** : "AGENTS.md effectiveness", "agentic instruction following benchmark", "runtime enforcement LLM agents", "instruction gap LLM", "hierarchical alignment LLM", "context file rule compliance", "serial position effects LLM"

---

## Flux PRISMA

```
IDENTIFICATION
  Sources identifiées par base :
    - arXiv (cs.AI, cs.SE, cs.CL) 2023-2026 : ~18 sources candidates
    - ACL Anthology / TACL / ICSE            : ~5 sources
    - Anthropic / OpenAI research blogs      : ~4 sources
    - Cognitive psychology classique         : ~3 sources (Miller, Sweller, Vaswani)
    - Agentic AI governance (McKinsey, etc.) : ~3 sources
    - Snowballing                            : ~3 additionnelles
  Total identifié : ~36
  Doublons retirés : -8
  Total après déduplication : ~28

SCREENING (titre + résumé)
  Sources screenées : 28
  Sources exclues au screening : -14
    - E1 (> 5 ans ET non-classique) : -2
    - E2 (blog individuel)          : -5
    - E3 (marketing vendeur)        : -4
    - E5 (hors périmètre : génération image, traduction) : -3

ÉLIGIBILITÉ (lecture complète)
  Sources évaluées en détail : 14
  Sources exclues après lecture : -5 (voir extraction file)

INCLUSION
  Sources incluses dans la synthèse : 9
    - Niveau 1 (fondationnelles normatif cognitif) : 3
    - Niveau 2 (expert reconnu + pratique industrielle) : 1
    - Niveau 3 (peer-reviewed empirique top venue)  : 5
```

---

## Documentation recherche (Table 2 Kitchenham)

| Base | Termes utilisés | Date | Retenus |
|------|----------------|------|---------|
| arXiv cs.AI | "AGENTS.md context file effectiveness" | 2026-04-17 | 1 (Gloaguen 2026) |
| arXiv cs.CL | "lost in the middle long context" | 2026-04-17 | 1 (Liu 2024) |
| arXiv cs.CL | "instruction following benchmark agentic" | 2026-04-17 | 2 (AGENTIF, Srivastava) |
| ICSE 2026 | "runtime enforcement LLM agents" | 2026-04-17 | 1 (Poskitt 2026) |
| Anthropic research | "constitutional AI rule compliance" | 2026-04-17 | 1 (Bai 2023) |
| NeurIPS/IEEE | "specification gaming" | 2026-04-17 | 1 (Bowman 2023) |
| Cognitive psychology | "cognitive load working memory rules" | 2026-04-17 | 2 (Miller, Sweller) |
