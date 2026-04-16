# Double Extraction — PICOC #20 : ai-agent-accountability

**Date** : 2026-04-16
**Protocole** : methodology.md v3.0
**Agent A** : contexte indépendant — mots-clés : "AI agent accountability framework", "autonomous agent responsibility chain governance", "LLM agent principal accountability chain", "agentic AI governance human oversight", "autonomous system accountability enterprise", "AI agent liability deployment"
**Agent B** : contexte indépendant — mots-clés différents : "responsible AI autonomous systems enterprise governance", "AI agent principal accountability chain deployment", "autonomous AI oversight regulatory compliance", "agentic AI governance framework enterprise", "AI system human accountability deployment"
**Agent C (vérificateur)** : vérification quotes + accessibilité URLs + réconciliation GRADE

---

## PICOC #20 — Accountability et gouvernance agentique

```
P  = Organisations déployant des agents IA autonomes pour le développement logiciel
I  = Mécanismes d'accountability explicites : désignation d'un humain responsable,
     registre des actions, interruptibilité, gouvernance progressive
C  = Absence de mécanismes d'accountability / gouvernance ad hoc / pleine autonomie
     sans responsable désigné
O  = Réduction des harms non compensés, traçabilité des actions, confiance calibrée,
     conformité réglementaire
Co = Développement logiciel avec agents autonomes (coding agents, CI/CD pipelines,
     déploiements automatisés)
```

**Question PICOC** : Quels mécanismes d'accountability et de gouvernance permettent de s'assurer qu'au moins un humain est responsable des actions d'un agent IA autonome dans un contexte de développement logiciel ?

---

## Sortie brute Agent A

### Stratégie de recherche A

Bases consultées : arXiv (cs.AI, cs.SE), WebSearch général, rapports institutionnels OpenAI/IMDA/MIT.
Mots-clés : "AI agent accountability framework", "autonomous agent responsibility chain governance", "LLM agent principal accountability", "agentic AI governance oversight", "autonomous system accountability enterprise", "AI agent liability deployment".

### Sources identifiées par A (12 sources, 5 retenues)

**Source A1 : EU AI Act Article 14 — Regulation (EU) 2024/1689**
- Niveau pyramide : 4 (norme légale institutionnelle, contraignante pour UE)
- Dimensions : human oversight obligatoire (systèmes haut-risque), mécanismes d'arrêt, formation des opérateurs
- Citation verbatim : "High-risk AI systems shall be designed and developed in such a way, including with appropriate human-machine interface tools, that they can be effectively overseen by natural persons during the period in which they are in use."
- Note Agent C : quote APPROXIMATIVE (version finale EUR-Lex utilise "they are in use" — variation mineure entre versions provisoire et consolidée). Substance confirmée.
- Statut : INCLURE

**Source A2 : AI Agent Index 2025 — Staufer et al. arXiv:2602.17753**
- Niveau pyramide : 3 (étude observationnelle, N=30 systèmes réels, 4 semaines review)
- Dimensions : transparence, safety disclosure, third-party testing, niveau d'autonomie réel
- Citation verbatim : "25/30 agents disclose no internal safety results, and 23/30 agents have no third-party testing."
- Note Agent C : APPROXIMATIVE — Agent A citait aussi "21/30 no documented disclosure" (chiffre contradictoire interne). Le chiffre 23/30 pour third-party testing est confirmé par les sources secondaires.
- Statut : INCLURE

**Source A3 : OpenAI Shavit et al. 2023 — "Practices for Governing Agentic AI Systems"**
- Niveau pyramide : 4-5 (position paper expert, framework fondateur, OpenAI)
- Dimensions : accountability chain, human-in-the-loop, scope des permissions, déploiement progressif
- Citation verbatim : "At least one human entity should be accountable for every uncompensated direct harm caused by an agentic AI system, creating incentives to reduce harm."
- Note Agent C : APPROXIMATIVE (variation "should be" vs "is" entre versions). PDF accessible sur cdn.openai.com. Substance confirmée par multiples sources secondaires.
- Statut : INCLURE

**Source A4 : IMDA Singapore Model AI Governance Framework for Agentic AI (janvier 2026)**
- Niveau pyramide : 4 (rapport gouvernemental, premier framework mondial dédié aux agents IA)
- Dimensions : déploiement responsable, mesures techniques et non-techniques, accountability humaine
- Citation verbatim (substance) : "humans are ultimately accountable" ; "recommending technical and non-technical measures to mitigate risks, while emphasising that humans are ultimately accountable"
- Note Agent C : substance confirmée (imda.gov.sg + presse). Framework lancé 22 jan. 2026 au WEF Davos.
- Statut : INCLURE

**Source A5 : Microsoft Agent Governance Toolkit (avril 2026)**
- Niveau pyramide : 5 (whitepaper vendor + benchmark propriétaire)
- Dimensions : enforcement runtime, détection violations politiques
- Citation verbatim : données 0% vs 26.67% violations en A/B test interne
- Note Agent C : BIAIS VENDOR fort — Microsoft évalue son propre outil. Pas de réplication indépendante.
- Statut : EXCLURE (vendor bias disqualifiant)

### Sources exclues par A (7 sources) :
- E1-E7 : blogs opinion sans données, doublons, hors scope PICOC

---

## Sortie brute Agent B

### Stratégie de recherche B

Mots-clés distincts : "responsible AI autonomous systems enterprise governance", "AI agent principal accountability chain", "autonomous AI oversight regulatory compliance", "agentic AI governance framework enterprise", "AI system human accountability".

### Sources identifiées par B (7 sources, 4 retenues)

**Source B1 : EU AI Act Article 14** (même que A1 — convergence)
- Niveau pyramide : 4 (norme légale)
- Note Agent B : classé à tort "Level 1" dans l'échelle EBSE, conduisant à GRADE surestimé (6/7). Correction Agent C : les normes légales ne prouvent pas l'efficacité empirique des mécanismes, seulement leur existence légale. Reclassé niveau 4.
- Statut : INCLURE

**Source B2 : BCG/MIT Sloan "The Emerging Agentic Enterprise" (nov. 2025, N=2102)**
- Niveau pyramide : 3 (enquête large, auto-déclaratif)
- Dimensions : perception des dirigeants sur la gouvernance, 58% anticipent changements governance en 3 ans
- Citation verbatim : "58% of executives expect significant changes to AI governance within 3 years"
- Note Agent C : titre exact confirmé. N=2102 confirmé. Biais consulting/vendor BCG. Mesure perception, pas efficacité causale.
- Mislabelling Agent B : intitulé "AI at Work 2024" — titre incorrect. Source correcte = "The Emerging Agentic Enterprise" (2025).
- Statut : INCLURE (avec correction titre)

**Source B3 : OpenAI Shavit et al. 2023** (même que A3 — convergence)
- Statut : INCLURE

**Source B4 : arXiv:2604.04604**
- Claim Agent B : "agents avec shell access activent system takeover"
- Note Agent C : ERREUR FACTUELLE. arXiv:2604.04604 = "AI Agents Under EU Law: A Compliance Architecture for AI Providers" — analyse juridique de conformité multi-régulations. Aucune mention de shell access ou system takeover.
- Statut : EXCLURE (claim incorrect)

**Source B5 : WEF AI Agents in Action / Capgemini 2025**
- Niveau pyramide : 5 (rapport think-tank industrie)
- Dimensions : gap expérimentation vs oversight mature, 82% executives planifient adoption agents 1-3 ans
- Statut : INCLURE comme signal convergence (niveau 5)

---

## Vérification Agent C — Synthèse

### Erreurs corrigées
1. **B4 exclue** : arXiv:2604.04604 est un papier de compliance juridique, pas un papier sur les risques de system takeover.
2. **B2 mislabelled** : titre corrigé en "The Emerging Agentic Enterprise" (BCG/MIT, nov. 2025).
3. **Quote EU AI Act** : approximation mineure sur pronom ("they" vs "the AI system"). Substance confirmée.
4. **GRADE Agent B surestimé** : classer EU AI Act comme "Level 1 empirique" est une erreur épistémologique. Les normes légales prescrivent, elles ne prouvent pas l'efficacité.

### Réconciliation GRADE

Agent A : ~3/7 (sources normatives/expert)
Agent B : 6/7 (erreur — EU AI Act mal classifié comme Level 1)
Agent C : **3/7 — RECOMMANDE FRAGILE**

Justification : convergence de 5 sources institutionnelles/normatives indépendantes (EU AI Act, OpenAI, IMDA Singapore, BCG/MIT N=2102, AI Agent Index N=30) sur le même constat — nécessité d'un humain responsable désigné pour les actions agentiques. Modificateur +1 convergence. Cependant : aucune des sources ne contient d'évaluation contrôlée de l'efficacité des mécanismes prescrits (aucun RCT ni quasi-expérimental sur "est-ce que la human oversight réduit les harms en développement logiciel ?"). Corpus majoritairement normatif/prescriptif. GRADE 3 reflète une recommandation solide sur ce qu'il faut faire, avec incertitude réelle sur ce qui fonctionne.

---

## Sources incluses — Tableau final

| Source | Référence | Niveau | Quote clé | Note Agent C |
|--------|-----------|--------|-----------|--------------|
| EU AI Act Art.14 | Regulation (EU) 2024/1689 | 4 | "High-risk AI systems shall be designed...to be effectively overseen by natural persons during the period in which they are in use." | APPROXIMATIVE (pronom) |
| AI Agent Index 2025 | Staufer et al. arXiv:2602.17753 | 3 | "25/30 agents disclose no internal safety results, and 23/30 agents have no third-party testing." | APPROXIMATIVE (chiffre interne A contradictoire) |
| OpenAI Shavit 2023 | cdn.openai.com/papers/ | 4 | "At least one human entity should be accountable for every uncompensated direct harm caused by an agentic AI system" | APPROXIMATIVE ("should be" vs "is") |
| IMDA Singapore jan.2026 | imda.gov.sg | 4 | "humans are ultimately accountable" | CONFIRMEE (substance) |
| BCG/MIT nov.2025 | "The Emerging Agentic Enterprise", N=2102 | 3 | 58% executives anticipent changements gouvernance IA en 3 ans | CONFIRMEE (titre corrigé) |

**Sources exclues** : Microsoft Toolkit (vendor bias), arXiv:2604.04604 (claim incorrect)

---

## Analyse de sensibilité

**Robustesse** : FRAGILE. Si on retire les sources normatives (EU AI Act, IMDA, OpenAI) pour ne garder que les sources empiriques, il ne reste que l'AI Agent Index (observationnel N=30) et BCG/MIT (enquête auto-déclarative). Le GRADE tomberait à 2/7 BONNE PRATIQUE FRAGILE.

**Gap empirique central** : Aucune étude ne mesure l'efficacité causale des mécanismes d'accountability sur la réduction des harms en contexte de développement logiciel. La recommandation repose sur la convergence normative + le bon sens, pas sur des données d'efficacité.

**Indirectness** : Les sources couvrent principalement les contextes enterprise généraux et la régulation. Le contexte spécifique "agent de développement logiciel" (coding agent, CI/CD, review PR) est très peu représenté.
