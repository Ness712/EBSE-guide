# PRISMA Flow — PICOC #20 : ai-agent-accountability

**Date de recherche** : 2026-04-16
**Bases interrogées** : arXiv (cs.AI, cs.SE), WebSearch général, EUR-Lex (EU AI Act), rapports institutionnels IMDA/OpenAI/BCG
**Mots-clés Agent A** : "AI agent accountability framework", "autonomous agent responsibility chain governance", "LLM agent principal accountability chain", "agentic AI governance human oversight", "autonomous system accountability enterprise", "AI agent liability deployment"
**Mots-clés Agent B** : "responsible AI autonomous systems enterprise governance", "AI agent principal accountability chain deployment", "autonomous AI oversight regulatory compliance", "agentic AI governance framework enterprise", "AI system human accountability deployment"
**Protocole** : methodology.md v3.0 §2.1 — double extraction indépendante (Agents A + B, mots-clés différents) + vérification Agent C

---

## Flux

```
IDENTIFICATION
  Sources identifiées par base (Agent A + Agent B combinés, avant déduplication) :
    - arXiv (cs.AI, cs.SE, cs.CY) : ~28 résultats candidats
    - WebSearch général (Google Scholar via WebSearch) : ~18 résultats candidats
    - EUR-Lex / documentation réglementaire : 2 sources
    - Rapports institutionnels (OpenAI, IMDA, BCG/MIT, WEF) : ~8 sources
    - Snowballing backward (références citées par sources principales) : ~6 sources
  Total identifié (brut, combiné A+B) : ~62
  Doublons retirés (même source identifiée par A et B) : 3 (EU AI Act, OpenAI Shavit, IMDA)
  Total après déduplication : ~59

SCREENING (titre + résumé)
  Sources screenées : ~59
  Sources exclues au screening : ~44
    - E1 (niveau 5 / blog opinion sans données) : ~14
    - E2 (hors scope PICOC — gouvernance générale IA, pas agentique) : ~18
    - E3 (doublons partiels) : ~6
    - E4 (vendeur sans méthodologie transparente) : ~6

ELIGIBILITÉ (lecture complète)
  Sources évaluées en détail : ~15
  Sources exclues après lecture complète : ~8
    - Erreur factuelle (arXiv:2604.04604 — claim Agent B incorrect) : 1
    - Vendor bias disqualifiant (Microsoft Toolkit — auto-évaluation sans réplication) : 1
    - Hors scope PICOC strict : 3
    - Niveau de preuve insuffisant (pure opinion sans données) : 3

INCLUSION
  Sources incluses dans la synthèse : 7 (dont 5 retenues pour GRADE principal)
    - Niveau 1 : 0
    - Niveau 2 : 0
    - Niveau 3 : 2 (AI Agent Index 2025 N=30 ; BCG/MIT enquête N=2102)
    - Niveau 4 : 4 (EU AI Act Art.14 ; OpenAI Shavit 2023 ; IMDA Singapore 2026 ; WEF/Capgemini 2025)
    - Niveau 5 : 1 (Microsoft Toolkit — exclue du GRADE principal, vendor bias)

  Sources exclues avec raison documentée : 2
    - arXiv:2604.04604 : claim "system takeover" non présent dans le papier (analyse légale EU)
    - Microsoft Agent Governance Toolkit : vendor bias fort, benchmark propriétaire sans réplication
```

---

## Documentation recherche (Table 2 Kitchenham)

### Agent A — bases interrogées

| Élément | Valeur |
|---------|--------|
| Bases | arXiv (cs.AI, cs.SE), WebSearch général, cdn.openai.com, imda.gov.sg |
| Mots-clés | "AI agent accountability framework", "autonomous agent responsibility chain", "agentic AI governance oversight" |
| Période couverte | 2023-2026 |
| Sources identifiées | ~34 |
| Sources retenues | 5 |
| Date d'extraction | 2026-04-16 |

### Agent B — bases interrogées

| Élément | Valeur |
|---------|--------|
| Bases | arXiv (cs.AI, cs.CY), WebSearch, EUR-Lex, rapports institutionnels |
| Mots-clés | "responsible AI autonomous systems governance", "AI agent principal accountability", "agentic AI governance framework enterprise" |
| Période couverte | 2023-2026 |
| Sources identifiées | ~28 |
| Sources retenues | 5 (convergence élevée avec A) |
| Date d'extraction | 2026-04-16 |

---

## Sources exclues — raisons documentées

| Source | Raison exclusion |
|--------|-----------------|
| arXiv:2604.04604 | Erreur factuelle Agent B — papier = analyse légale EU, pas sur system takeover |
| Microsoft Agent Governance Toolkit | Vendor bias fort — Microsoft auto-évalue son propre outil, aucune réplication indépendante |
| Blog posts Medium sur AI governance | Niveau 5 redondant avec frameworks institutionnels |
| Rapports sectoriels sans méthodologie | Pas de données primaires identifiables |
