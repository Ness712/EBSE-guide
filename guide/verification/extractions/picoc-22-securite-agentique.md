# Double Extraction — PICOC #22 : ai-agent-agentic-security

**Date** : 2026-04-16
**Protocole** : methodology.md v3.0
**Agent A** : contexte indépendant — mots-clés : "AI agent security vulnerabilities prompt injection", "LLM agent security empirical study", "autonomous agent attack vectors", "prompt injection agentic systems", "AI agent security framework empirical", "LLM agent tool misuse security", "agentic AI security threats mitigation", "multi-agent security trust boundaries"
**Agent B** : contexte indépendant — mots-clés différents : "agentic AI security survey empirical", "LLM agent adversarial attack benchmark", "autonomous AI system security evaluation", "AI agent privilege escalation", "multi-agent trust exploitation security", "agentic workflow security measures", "AI coding agent security vulnerability"
**Agent C (vérificateur)** : vérification quotes + accessibilité URLs + corrections chiffres + distinction attaque/défense

---

## PICOC #22 — Sécurité agentique

```
P  = Systèmes d'agents IA autonomes utilisés pour le développement logiciel
I  = Mesures de sécurité spécifiques aux agents (input sanitization, least-privilege,
     isolation inter-agents, monitoring des tool calls, zero trust architecture)
C  = Sécurité générique LLM sans mesures spécifiques à l'agenticité (permissions
     larges, trust implicite entre agents, absence de sandboxing)
O  = Résistance aux attaques (prompt injection, tool misuse, inter-agent trust
     exploitation, memory poisoning), réduction du blast radius
Co = Agents IA autonomes avec accès à des outils (bash, fichiers, API, web),
     contexte de développement logiciel, pipelines multi-agents
```

**Question PICOC** : Quelles sont les vulnérabilités de sécurité spécifiques aux systèmes d'agents IA autonomes et quelles mesures de protection sont empiriquement validées ?

---

## Sortie brute Agent A

### Stratégie de recherche A

Bases : arXiv (cs.CR, cs.AI), NeurIPS/ICLR proceedings, ISACA.
Mots-clés : "AI agent security vulnerabilities prompt injection", "LLM agent security empirical", "autonomous agent attack vectors", "prompt injection agentic systems", "LLM agent tool misuse security", "multi-agent security trust boundaries".

### Sources retenues Agent A

**Source A1 : Lupinacci et al. 2025 — "The Dark Side of LLMs: Agent-based Attacks"**
- Référence : arXiv:2507.06850 (Univ. Calabria, 6 co-auteurs)
- Niveau pyramide : 3 (benchmark N=18 modèles)
- Dimensions : prompt injection direct, RAG backdoor, inter-agent trust exploitation
- Données CORRIGÉES par Agent C :
  * Direct Prompt Injection (DPI) : **94.4%** vulnérables (agents A/B citaient "94.1%" — correction mineure)
  * RAG Backdoor : **83.3%** vulnérables (agents A/B citaient "82.4%" — erreur)
  * Inter-Agent Trust : **100%** vulnérables (agents A/B citaient "82.4%" — erreur significative)
  * 1/18 modèles résiste à DPI ; 0/18 résiste à l'inter-agent trust exploitation
- Note Agent C : le claim "only 1 resistant" est trompeur — 1 résiste à DPI mais 0 résiste à inter-agent trust. La couche agent-to-agent est la plus critique et la moins protégée.
- Statut : INCLURE (avec corrections chiffres obligatoires)

**Source A2 : Fang et al. 2024 — "LLM Agents Can Autonomously Exploit One-Day Vulnerabilities"**
- Référence : arXiv:2404.08144
- Niveau pyramide : 3 (benchmark N=15 CVEs — N faible)
- Dimensions : exploitation autonome de CVEs, capacités offensives des LLMs
- Citation verbatim Agent C confirmée : "GPT-4 is capable of exploiting 87% of these vulnerabilities compared to 0% for every other model"
- Limitation critique : N=15 seulement ; sans description CVE fournie, performance s'effondre à 7% ; condition "avec description" est quasi-optimale pour l'attaquant
- Statut : INCLURE (avec note N=15 et conditions optimales)

**Source A3 : Datta (Chhabra), et al. 2025 — "Agentic AI Security: Threats, Defenses, Evaluation"**
- Référence : arXiv:2510.23883 (révisé v3 avril 2026, Chhabra, Datta, Nahin, Mohapatra)
- Niveau pyramide : 3 (survey/taxonomie — pas d'expérimentation originale)
- Dimensions : prompt injection, tool misuse, MCP/A2A vulnerabilities, memory poisoning
- Note Agent C : le chiffre "87% tool misuse" cité par Agent A n'est PAS dans l'abstract — provient probablement d'une source primaire citée dans le survey. À tracer.
- Statut : INCLURE (avec réserve sur "87%")

**Source A4 : ISACA Murali 2025**
- Référence : ISACA Industry News, 1er juillet 2025 (Anirudh Murali)
- Niveau pyramide : 4 (opinion experte praticien, non peer-reviewed)
- Dimensions : zero trust pour agents, IAM least-privilege, audit logging
- Statut : INCLURE (niveau 4, convergence pratiques)

---

## Sortie brute Agent B

### Stratégie de recherche B

Mots-clés distincts : "agentic AI security survey empirical", "LLM agent adversarial attack benchmark", "AI agent privilege escalation", "multi-agent trust exploitation", "agentic workflow security measures".

### Sources retenues Agent B

**Source B1 : AgentPoison — Chen et al. NeurIPS 2024**
- Référence : arXiv:2407.12784 (U. Chicago, UIUC, U. Wisconsin, UC Berkeley)
- Niveau pyramide : 2 (évaluation contrôlée, NeurIPS 2024 top-tier)
- Dimensions : empoisonnement de la mémoire agent (RAG/memory poisoning)
- Citation verbatim Agent C confirmée : "average ASR higher than 80% with poison rate <0.1%, benign impact <1%"
- Données : 3 types d'agents testés (driving, QA, healthcare)
- Note Agent C : source solide. Conditions lab, mais protocole rigoureux NeurIPS.
- Statut : INCLURE (source critique défense/attaque)

**Source B2 : Prompt Flow Integrity (PFI) — Kim et al.**
- Référence : arXiv:2503.15547 (Seoul National University, CompSec Lab)
- Niveau pyramide : 2 (évaluation contrôlée, 2 benchmarks)
- Dimensions : réduction ATR (attack transfer rate) par séparation agents + least-privilege
- Données Agent C confirmées : ATR baseline 57.99% (AgentDojo) et 97.37% (AgentBench OS) → **0.00%** avec PFI
- Note Agent C : résultat impressionnant en lab. Le 0% en benchmark fermé ne se traduit pas nécessairement en 0% en production. Adaptive attacks (Maloyan) suggèrent contournement possible.
- Statut : INCLURE (note lab-only obligatoire)

**Source B3 : LLMs as Hackers — Happe & Cito (Springer Empirical SE 2025)**
- Référence : arXiv:2310.11409 (peer-reviewed Springer)
- Niveau pyramide : 2 (étude empirique contrôlée, peer-reviewed)
- Dimensions : privilege escalation autonome, hackingBuddyGPT
- Données Agent C confirmées : GPT-4-Turbo 33% sans guidance → 66-83% avec guidance ; GPT-3.5 : 16-50% ; Llama3 : 0-33%
- Statut : INCLURE

**Source B4 : Maloyan & Namiot 2026 — "Prompt Injection Attacks on Agentic Coding Assistants"**
- Référence : arXiv:2601.17548 (SoK — systematic analysis, 78 études 2021-2026)
- Niveau pyramide : 2-3 (SoK/méta-analyse, pas d'expérimentation originale)
- Dimensions : attack success rate contre défenses actuelles, adaptive attacks
- Données Agent C partiellement confirmées : "attack success rates against state-of-the-art defenses exceed 85% when adaptive strategies are used"
- Note Agent C : le claim "84% exfiltration rate" cité par Agent A n'est PAS dans l'abstract. Ce chiffre spécifique est non confirmé — pourrait être dans le corps du papier ou être une confusion avec une autre étude.
- Statut : INCLURE (claim "85%+ ASR" confirmé ; "84% exfiltration" non confirmé — à supprimer ou signaler)

---

## Vérification Agent C — Synthèse

### Corrections critiques

| Erreur | Source | Correct (Agent C) |
|--------|--------|-------------------|
| "94.1% vulnérables" | A1 Lupinacci | **94.4%** DPI |
| "82.4% inter-agent" | A1 Lupinacci | **100%** inter-agent trust exploitation |
| "84% exfiltration" | B4 Maloyan | **Non confirmé** dans l'abstract |
| "87% tool misuse" | A3 Datta | **Non confirmé** dans l'abstract (source interne?) |

### GRADE — Asymétrie attaque/défense

**Côté attaque (existence des vulnérabilités) : 5/7 RECOMMANDE**
- Score de base : 3 (plusieurs évaluations empiriques contrôlées, NeurIPS 2024)
- +1 convergence : A1, B1, B2, B3 — sources indépendantes (Univ. Calabria, U. Chicago+Berkeley+UIUC, Seoul National, Springer) convergent sur taux d'exploitation élevés
- +1 effet important : 80-100% exploitation, reproductible dans conditions variées
- Score = 5

**Côté défenses (efficacité des mesures) : 3/7 RECOMMANDE FRAGILE**
- Score de base : 2 (PFI = étude contrôlée benchmarks ; LLMs as Hackers montre guidance aide les attaquants)
- +1 convergence conceptuelle : PFI, ISACA zero trust, least-privilege convergent
- -1 indirectness : toutes les défenses testées en lab uniquement. PFI ATR=0% jamais observé en production. Adaptive attacks (Maloyan >85%) contournent défenses connues.
- Score = 2

**GRADE global consolidé : 4/7 RECOMMANDE** (moyenne pondérée, avec mention obligatoire asymétrie)

---

## Sources incluses finales

| Source | Référence | Niveau | Données clés | Côté | Note Agent C |
|--------|-----------|--------|-------------|------|--------------|
| Lupinacci 2025 | arXiv:2507.06850 | 3 | DPI 94.4%, RAG 83.3%, inter-agent 100% | Attaque | Chiffres corrigés |
| AgentPoison NeurIPS 2024 | arXiv:2407.12784 | 2 | ≥80% ASR, <0.1% poison rate | Attaque | Confirmé |
| Fang et al. 2024 | arXiv:2404.08144 | 3 | GPT-4 87% CVEs (N=15, conditions optimales) | Attaque | Confirmé, N faible |
| Maloyan 2026 | arXiv:2601.17548 | 2-3 | >85% ASR contre défenses avec adaptive | Attaque | "84% exfiltration" non confirmé |
| PFI Kim 2025 | arXiv:2503.15547 | 2 | ATR 57.99%→0.00% (lab) | Défense | Lab uniquement |
| LLMs as Hackers | arXiv:2310.11409 | 2 | 33-83% privilege escalation | Attaque/Défense | Confirmé |
| Datta et al. 2025 | arXiv:2510.23883 | 3 | Taxonomie MCP/A2A vulnérabilités | Survey | "87%" non confirmé abstract |
| ISACA Murali 2025 | isaca.org, juil.2025 | 4 | Zero trust, least-privilege, IAM | Défense | Opinion praticien |

---

## Analyse de sensibilité

**Robustesse côté attaque** : FORTE. Retrait de Lupinacci (N=18) → reste AgentPoison (NeurIPS), LLMs as Hackers (Springer), Fang et al. Convergence maintenue. GRADE attaque ≥ 4 même sans Lupinacci.

**Fragilité côté défenses** : IMPORTANTE. PFI ATR=0% en lab n'est pas réplicable en production ouverte. Maloyan montre que adaptive attacks >85% contournent les défenses actuelles. La preuve d'efficacité en production reste manquante pour toutes les défenses proposées.

**Point critique praticien** : l'asymétrie attaque/défense est structurelle — la communauté documente les vulnérabilités beaucoup plus vite qu'elle ne valide les défenses. Recommandation : adopter least-privilege + input sanitization + monitoring (convergence normative forte) sans surestimer l'efficacité des défenses en conditions adversariales réelles.
