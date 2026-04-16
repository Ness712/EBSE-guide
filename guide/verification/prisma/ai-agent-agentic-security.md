# PRISMA Flow — PICOC #22 : ai-agent-agentic-security

**Date de recherche** : 2026-04-16
**Bases interrogées** : arXiv (cs.CR, cs.AI), NeurIPS/ICLR/ISSTA proceedings, ISACA, Springer Empirical Software Engineering
**Mots-clés Agent A** : "AI agent security vulnerabilities prompt injection", "LLM agent security empirical study", "autonomous agent attack vectors", "prompt injection agentic systems", "LLM agent tool misuse security", "multi-agent security trust boundaries"
**Mots-clés Agent B** : "agentic AI security survey empirical", "LLM agent adversarial attack benchmark", "AI agent privilege escalation", "multi-agent trust exploitation security", "agentic workflow security measures", "AI coding agent security vulnerability"
**Protocole** : methodology.md v3.0 §2.1 — double extraction indépendante + vérification Agent C

---

## Flux

```
IDENTIFICATION
  Sources identifiées par base (Agent A + Agent B combinés, avant déduplication) :
    - arXiv (cs.CR, cs.AI) : ~35 résultats candidats
    - NeurIPS/ICLR/ISSTA/Springer proceedings (via WebSearch) : ~18 résultats
    - ISACA / organismes de sécurité : ~5 sources
    - Snowballing (références des surveys) : ~12 sources
  Total identifié (brut, combiné A+B) : ~70
  Doublons retirés (convergence A+B partielle) : 2 (Datta survey, ISACA)
  Total après déduplication : ~68

SCREENING (titre + résumé)
  Sources screenées : ~68
  Sources exclues au screening : ~50
    - E1 (sécurité LLM générique sans dimension agentique) : ~20
    - E2 (théoriques sans données empiriques) : ~12
    - E3 (hors scope PICOC — focus adversarial ML non-agentique) : ~10
    - E4 (présentation conférence sans paper complet) : ~8

ELIGIBILITÉ (lecture complète)
  Sources évaluées en détail : ~18
  Sources exclues après lecture complète : ~10
    - Pas de système agent (prompt-based uniquement) : 5
    - Données insuffisantes (N trop faible, pas de baseline) : 3
    - Doublon partiel : 2

INCLUSION
  Sources incluses dans la synthèse : 8
    - Niveau 1 : 0
    - Niveau 2 : 4 (AgentPoison NeurIPS 2024 ; PFI Kim 2025 ; LLMs as Hackers Springer 2025 ; Maloyan 2026 SoK)
    - Niveau 3 : 3 (Lupinacci 2025 N=18 modèles ; Fang 2024 N=15 CVEs ; Datta survey v3 2026)
    - Niveau 4 : 1 (ISACA Murali 2025 — opinion experte praticien)
    - Niveau 5 : 0

  Corrections factuelles Agent C obligatoires :
    - Lupinacci : 94.4% (pas 94.1%) ; inter-agent trust 100% (pas 82.4%)
    - Maloyan : "84% exfiltration" non confirmé → supprimer ou marquer non vérifié
    - Datta : "87% tool misuse" non confirmé dans l'abstract → à tracer dans le corps du texte

  Note méthodologique : distinction attaque/défense essentielle
    - Côté attaque (8 sources) : GRADE 5 (forte convergence, effets importants documentés)
    - Côté défenses (3 sources) : GRADE 3 (lab only, adaptive attacks contournent les défenses)
    - GRADE global consolidé : 4 (moyenne pondérée)
```

---

## Documentation recherche (Table 2 Kitchenham)

### Agent A — bases interrogées

| Élément | Valeur |
|---------|--------|
| Bases | arXiv (cs.CR, cs.AI), NeurIPS proceedings, ISACA |
| Mots-clés | "AI agent security vulnerabilities prompt injection", "multi-agent security trust boundaries" |
| Période couverte | 2024-2026 |
| Sources identifiées | ~36 |
| Sources retenues | 6 |
| Date d'extraction | 2026-04-16 |

### Agent B — bases interrogées

| Élément | Valeur |
|---------|--------|
| Bases | arXiv (cs.CR), NeurIPS/ICLR, Springer ESE |
| Mots-clés | "agentic AI security survey empirical", "LLM agent adversarial attack benchmark", "privilege escalation AI agent" |
| Période couverte | 2024-2026 |
| Sources identifiées | ~34 |
| Sources retenues | 5 |
| Date d'extraction | 2026-04-16 |

---

## Sources exclues — raisons documentées

| Source | Raison exclusion |
|--------|-----------------|
| Études adversarial ML non-agentiques | Hors scope — pas de system-level agent avec tool access |
| Prompt injection sur chatbots simples | Hors scope — pas de capacité d'exécution d'actions |
| Études vendor propriétaires sans méthodologie | Pas de reproductibilité, biais évident |
