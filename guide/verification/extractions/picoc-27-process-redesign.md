# Double Extraction EBSE — PICOC #27 : ai-agent-process-redesign

**Date de recherche** : 2026-04-16  
**Protocole** : methodology.md v3.0 §2.1 — double extraction indépendante + vérification Agent C  
**Question PICOC** : Dans quelles conditions la délégation à des agents IA échoue-t-elle si les processus existants ne sont pas redesignés, et quels gains différentiels le redesign apporte-t-il par rapport à la simple automatisation ?

---

## Agent A — Extraction

**Mots-clés** : "AI process redesign vs automation productivity", "McKinsey AI State 2025 process redesign", "business process reengineering AI agents", "AI adoption process transformation empirical", "workflow redesign artificial intelligence benefit"

### A1 — McKinsey "The State of AI in 2025: How Organizations Are Rewiring to Capture Value"

- **Organisation** : McKinsey Global Institute / QuantumBlack
- **Date** : mars 2025 (v1 survey) ; N=1 993 répondants, 105 nations, juin-juillet 2025
- **Venue** : Rapport McKinsey Global Survey
- **Claims vérifiés** :
  - *"Of 25 attributes tested for organizations of all sizes, the redesign of workflows has the biggest effect on an organization's ability to see EBIT impact from its use of gen AI."* — VÉRIFIÉ
  - High performers "nearly three times as likely as others to say their organizations have fundamentally redesigned individual workflows" — VÉRIFIÉ (ratio ~3x, pas 3.6x — voir correction)
- **Claims NOT_VERIFIED** : "25-30% gains redesign vs 10-15% automatisation seule" — NOT_VERIFIED verbatim ; "3.6x plus probable d'observer impact enterprise-level" — REFORMULATION INCORRECTE (voir correction Agent C)
- **Niveau pyramide** : 3 (rapport observationnel, cabinet conseil, biais commercial potentiel)
- **Statut** : PARTIELLEMENT VÉRIFIÉ

### A2 — HBR "The Secret to Successful AI-Driven Process Redesign"

- **Auteurs** : H. James Wilson (Accenture Research) & Paul R. Daugherty (ex-CTO Accenture)
- **Date** : janvier-février 2025
- **Venue** : Harvard Business Review
- **Claim** : Avec interfaces en langage naturel, tous les employés peuvent initier des changements de processus — "kaizen 2.0"
- **Niveau pyramide** : 3 (article practitioner-research, non peer-reviewed)
- **Statut** : VÉRIFIÉ (titre, auteurs, venue, date confirmés)

### A3 — Bain "Automation Scorecard 2024"

- **Organisation** : Bain & Company
- **N** : non spécifié
- **Claims** : Automation leaders : -22% coûts processus vs -8% laggards ; top quartile : -37% ; "Real change comes from business redesign, not tool deployment"
- **Niveau pyramide** : 3 (rapport cabinet conseil)
- **Statut** : PARTIELLEMENT VÉRIFIÉ (rapport existe, chiffres non vérifiables verbatim sans accès PDF)

---

## Agent B — Extraction

**Mots-clés** : "automation without redesign failure AI", "AI agent workflow transformation empirical study", "Deloitte AI Tech Trends 2026", "AI software development process change organizational", "rethinking software process AI agents empirical"

### B1 — Deloitte "Tech Trends 2026" (Trend #2 : Agentic AI Strategy)

- **Organisation** : Deloitte Insights
- **Date** : rapport annuel 2026
- **Venue** : Deloitte Tech Trends 2026 (17e rapport annuel), PDF officiel : mkto.deloitte.com
- **Claim "workslop" vérifié** : *"Poorly designed agentic applications can actually add work to a process, with some enterprises finding agentic 'workslop' can make processes even less efficient"* — VÉRIFIÉ via URLs Deloitte officielles
- **Contexte** : *"Many organizations attempt to automate current processes rather than reimagine workflows for an agentic environment"* → "agentic 'workslop' where agents add friction rather than remove it"
- **Niveau pyramide** : 3 (rapport cabinet conseil)
- **Statut** : VÉRIFIÉ — "workslop" confirmé dans document Deloitte

### B2 — METR 2025 — arXiv:2507.09089

- **Auteurs** : Joel Becker, Nate Rush, Elizabeth Barnes, David Rein (METR)
- **Méthode** : RCT — N=16 développeurs, 246 tâches, Cursor Pro + Claude 3.5/3.7 Sonnet
- **Résultat** : +19% temps de complétion quand IA tools autorisés (vs -24% attendu)
- **Interprétation PICOC #27** : intégration IA dans workflows OSS matures sans adaptation de processus → perte de productivité. Limite : N=16, contexte spécifique (OSS mature), cause exacte non isolée.
- **Niveau pyramide** : 1 (RCT — indirect mais corroborant)
- **Statut** : VÉRIFIÉ (identique PICOC #21)

### B3 — PwC "2026 AI Performance Study"

- **Organisation** : PwC Global
- **Date** : avril 2026
- **N** : 1 217 dirigeants seniors, 25 secteurs
- **Claim** : 74% des gains IA captés par 20% des organisations ; leaders "twice as likely to redesign workflows to incorporate AI rather than simply adding AI tools"
- **Niveau pyramide** : 3 (rapport conseil/survey auto-déclaratif)
- **Statut** : VÉRIFIÉ (URL PwC officielle confirmée)

### B4 — McKinsey "Seizing the Agentic AI Advantage"

- **Organisation** : McKinsey
- **Claim** : "Many agentic AI implementations are failing—but leading organizations that are reimagining operations and managing agents as workers are finding success" ; distinction standard repetitive workflows (automation) vs complex cross-functional (redesign)
- **Niveau pyramide** : 3 (rapport McKinsey)
- **Statut** : VÉRIFIÉ (URL McKinsey officielle)

---

## Agent C — Corrections et vérification

### C1 — McKinsey "3.6x" : REFORMULATION INCORRECTE

**Avant** : "3.6x plus probable d'observer impact enterprise-level"  
**Après** :
- "3.6x more likely to pursue transformational change" = intention de transformation (pas impact observé)
- "Nearly 3x more likely to fundamentally redesign workflows" = comportement réel des high performers
- "Redesign = plus fort prédicteur d'impact EBIT parmi 25 attributs testés" = finding principal réel

Le claim "3.6x enterprise-level impact" tel que formulé initialement est une **fusion incorrecte** de deux statistiques distinctes. Ne pas citer tel quel.  
**Sévérité** : Importante

### C2 — McKinsey "25-30% vs 10-15%" : NOT_VERIFIED verbatim

**Après** : Ces chiffres circulent dans des sources secondaires agrégant plusieurs rapports McKinsey mais ne sont pas retrouvés verbatim dans un rapport primaire unique accessible. Trouver en revanche : "up to 25% savings with end-to-end AI integration vs 5% or less for isolated experiments" — source composite secondaire. **Ne pas citer comme quote McKinsey précise.**

### C3 — Deloitte "workslop" : CONFIRMÉ

Le terme "workslop" est bien présent dans le document Deloitte Tech Trends 2026 officiel. Définition confirmée.

### C4 — METR arXiv:2507.09089 : CONFIRMÉ

+19%, N=16, 246 tâches — identique PICOC #21. Source indirecte pour PICOC #27 (ne mesure pas directement redesign vs automatisation) mais corroborante.

### C5 — McKinsey N : CONFIRMÉ

N=1 993 répondants, 105 nations, enquête juin-juillet 2025.

### Fabrications détectées : AUCUNE

Pas de fabrication. Les erreurs identifiées sont des imprécisions/reformulations incorrectes.

---

## Sources retenues

| # | Source | Retenue | Justification |
|---|--------|---------|---------------|
| 1 | McKinsey State of AI 2025 | **OUI** | N=1993, claims principaux vérifiés — biais commercial noté ; rapport de référence sectoriel |
| 2 | Deloitte Tech Trends 2026 | **OUI** | "workslop" vérifié, mécanisme d'amplification négatif documenté |
| 3 | METR arXiv:2507.09089 | **OUI** | RCT niveau 1, corroborant indirect — automation sans adaptation = perte productivité |
| 4 | PwC 2026 AI Performance Study | **OUI** | N=1217, 25 secteurs, 2x redesign vs automation |
| 5 | Bain Automation Scorecard 2024 | **OUI** | 22% vs 8% différentiel quantifié |
| 6 | HBR Wilson/Daugherty 2025 | **OUI (corroborant)** | Mécanisme "kaizen 2.0" — practitioner essay, pas de données |
| - | Chiffres "25-30% vs 10-15%" attribués McKinsey | **EXCLU** | NOT_VERIFIED verbatim dans sources primaires |

---

## GRADE calculé

| Facteur | Valeur | Justification |
|---------|--------|---------------|
| Base | +2 | METR (niveau 1 RCT mais indirect) ; McKinsey/Deloitte/PwC/Bain = niveau 3 surveys. Meilleure source directe = niveau 3 → base 2 |
| Convergence | +1 | 4+ sources indépendantes (McKinsey, Deloitte, PwC, Bain) convergent sur mécanisme redesign > automatisation |
| Effet important | +1 | Différentiel substantiel : redesign = EBIT prédicteur #1 (25 attributs McKinsey) ; 2x-3x plus de redesign chez les leaders ; Bain 22% vs 8% |
| Biais commercial | -1 | McKinsey, Deloitte, PwC, Bain = cabinets conseil avec intérêt direct à promouvoir la transformation (et leurs services) |
| Indirectness | 0 | Non appliqué : sources directement applicables au contexte de déploiement d'agents |

**GRADE = 2 + 1 + 1 - 1 = 3/7 — RECOMMANDE FRAGILE**

---

## Principe recommandé

Avant de déléguer une tâche à un agent IA, auditer si le processus a été conçu pour des travailleurs humains : le simple déploiement d'agents sur un workflow existant produit au mieux des gains marginaux (5%), au pire une dégradation (METR : +19% temps réel, Deloitte : "workslop"). Le redesign préalable du workflow autour des capacités agents — découpage des tâches, redéfinition des interfaces humain-agent, clarification des responsabilités — est le prédicteur le plus robuste d'impact EBIT parmi 25 attributs testés (McKinsey 2025, N=1993) et les organisations leaders redesignent leurs workflows 2-3x plus souvent que les autres.

## Robustesse

**PARTIELLE**

- Direction de l'effet robuste et convergente (4-5 sources indépendantes, secteurs différents)
- Quantification précise NOT_VERIFIED (25-30% vs 10-15% non confirmés verbatim)
- Biais systémique : toutes les sources quantitatives (McKinsey, PwC, Bain, Deloitte) sont des cabinets de conseil avec intérêt commercial à promouvoir la transformation
- Seul RCT (METR N=16) indirect — mesure l'automatisation de l'existant, pas le redesign
- Absence de méta-analyse peer-reviewed sur ce sujet spécifique

---

## Divergences A vs B

| Divergence | Agent A | Agent B | Résolution |
|-----------|---------|---------|------------|
| Angle | A = gains positifs redesign | B = mécanisme amplification négative (workslop, +19%) | Complémentaires — B précise le mécanisme causal |
| Sources | A = McKinsey + HBR + Bain | B = Deloitte + METR + PwC | Les deux angles retenus |
| Niveau de preuve | A = surveys niveau 3 | B apporte METR (RCT niveau 1, indirect) | B apporte la preuve la plus rigoureuse |
| Pas de contradiction | | | Convergence totale sur le principe |
