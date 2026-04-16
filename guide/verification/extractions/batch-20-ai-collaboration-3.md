# Double Extraction — Batch AI-3 : domaine `ai-collaboration` (PICOCs #13-17)

**Date** : 2026-04-15
**Protocole** : methodology.md v3.0 + amendements Phase 1.4-1.5b
**Agent A** : a5f6a1176f96cf2b3 (contexte independant)
**Agent B** : abdd30f1ce6555f42 (contexte independant)
**Agent C (verificateur)** : a7bc11ec80320a737 (verification quotes + numbers)

## Resultats

- **Accord recommandations** : 5/5 convergence directionnelle
- **Accord GRADE** : 2/5 exact, 3/5 diff ≤ 2 pts
- **Fabrications detectees par Agent C** : **2 chez A** (DataCamp benchmark entierement hallucine, TGen "18 LLMs" fabrique au lieu de 2)
- **Misquote A** : Bainbridge opening thesis incorrectly assigned
- **Refutation technique** : **LiteLLM wall-clock cap N'EXISTE PAS** — triple cap framing invalide
- **Conservative rule + fabrication removal** appliquees

## Table comparaison PICOCs

| # | Decision | A Reco | B Reco | GRADE A | GRADE B | GRADE retenu post-C | Confidence final |
|---|----------|--------|--------|:-------:|:-------:|:-------------------:|------------------|
| 13 | Human situational awareness | SA practices on critical paths | Same + vulns iteration data | 3/7 | 3/7 | **3/7** | RECOMMANDE |
| 14 | Prompt/spec discipline | **STANDARD** (inflated par fabrications) | BONNE_PRATIQUE | 5/7 | 2/7 | **3/7** (A's score corrected) | RECOMMANDE |
| 15 | TDD agent loop | RECOMMANDE 4/7 | RECOMMANDE 3/7 | 4/7 | 3/7 | **3/7** | RECOMMANDE |
| 16 | Cost/budget caps (triple) | RECOMMANDE 3/7 (triple-cap) | BONNE_PRATIQUE 2/7 | 3/7 | 2/7 | **2/7** (triple invalid) | BONNE_PRATIQUE |
| 17 | Provenance & audit trail | RECOMMANDE 3/7 | RECOMMANDE 3/7 | 3/7 | 3/7 | **3/7** | RECOMMANDE |

## Sources retenues apres verification Agent C

### PICOC #13 — Human situational awareness on critical paths

- **EU AI Act Article 14 §4(a)(b)(e)** (pyramide 1) — *"to properly understand the relevant capacities and limitations of the high-risk AI system"* ; *"to remain aware of the possible tendency of automatically relying or over-relying on the output produced by a high-risk AI system (automation bias)"* ; *"to intervene in the operation of the high-risk AI system or interrupt the system through a 'stop' button"* [VERIFIED verbatim par Agent C]
- **Bainbridge 1983 "Ironies of Automation"** (pyramide 2) — opening thesis **verbatim** : *"the more advanced a control system is, so the more crucial may be the contribution of the human operator"* [VERIFIED par Agent C — **correction** : c'est la quote correcte de B, pas celle de A]
- **Shukla, Joshi, Syed arXiv:2506.11022 "Security Degradation in Iterative AI Code Generation"** (pyramide 3, IEEE-ISTAS 2025) — *"37.6% increase in critical vulnerabilities after just five iterations"* ; 400 samples (10 baseline × 4 prompts × 10 iterations) ; first iterations 2.1 vulns/sample, iterations 8-10 = 6.2/sample [VERIFIED par Agent C]
- **NIST AI RMF Playbook GOVERN 3.2** (pyramide 1) — differentiated training competencies for AI actor sub-groups [NOT_VERIFIED_LITERAL]
- **Qodo "State of AI code quality 2025"** (pyramide 4, vendor survey) — 65% dev report AI assistant "misses relevant context" [NOT_VERIFIED_LITERAL]

**Recommendation provisoire** : **RECOMMANDE**. SA-maintenance sur critical paths (auth, payment, data deletion) : mandatory line-by-line read-through, rotation hands-on days, agent-generated explanations. Le seuil ">=30% human-written" reste CHOIX_EQUIPE (pas de donnees empiriques sur ce threshold specifique). Convergence : EU regulation + Bainbridge theorique + Shukla empirical (37.6% vuln increase) + practitioner lit.

### PICOC #14 — Prompt/spec discipline

**CORRECTIONS FABRICATIONS A** :
- **DataCamp "12/30 40% vs 23/30 77%"** → **HALLUCINATION TOTALE**. Aucun benchmark de ce type n'existe dans l'article DataCamp cite. **Source ecartee entierement**.
- **TGen "18 LLMs"** → **FABRICATION**. Le papier teste 2 LLMs (GPT-4 Turbo v1106 + Meta Llama 3). Corrige.

**Sources retenues apres corrections** :

- **GitHub Spec-Kit `spec-driven.md`** (pyramide 3, vendor primary) — *"Specifications don't serve code—code serves specifications"* [VERIFIED par Agent C] ; Article III Test-First Imperative : *"No implementation code shall be written before: 1. Unit tests are written 2. Tests are validated and approved by the user"* [VERIFIED par Agent C — note : un 3e item "Tests are confirmed to FAIL" existe aussi]
- **Fowler/Bird "Understanding SDD: Kiro, spec-kit, Tessl"** (pyramide 3, expert critical review) — observations qualitatives, pas de numerical claims [NOT_VERIFIED_LITERAL]
- **Naik et al. TiCoder arXiv 2404.10100** (pyramide 2, peer-reviewed TSE 2024) — *"average absolute improvement of 45.97% in the pass@1 code generation accuracy for both datasets and across all LLMs within 5 user interactions"* [VERIFIED par Agent C] ; 4 LLMs sur MBPP + HumanEval
- **Mathews & Nadi TGen arXiv:2402.13521** (pyramide 2) — MBPP +12.0%, HumanEval +8.5%, Llama 3 +29.57% MBPP / +13.41% HumanEval [VERIFIED par Agent C] ; **2 LLMs** (GPT-4 Turbo + Llama 3), pas 18

**GRADE recalcule post-corrections** :
- Starting : 3 (TiCoder + TGen empirical peer-reviewed)
- +convergence (Spec-Kit + TiCoder + TGen pointent same direction) : +1 → 4
- +important-effect (TiCoder +45.97% est significatif) : +1 → 5
- -indirectness (MBPP/HumanEval = short synthetic tasks, pas real-world features) : -1 → 4
- -imprecision (TGen 2 LLMs seulement, TiCoder 4 LLMs, petit N pour strong claims) : -1 → **3/7**
- **Retain : 3/7 RECOMMANDE** (A's inflated 5/7 corrected down, B's 2/7 corrected up)

**Recommendation provisoire** : **RECOMMANDE**. Spec-first workflow : plan-then-code (Claude Code plan mode, Aider `/architect`), acceptance criteria explicites, spec-driven development (GitHub Spec-Kit, Amazon Kiro). Preuves empiriques existent (TiCoder +46pp, TGen +12-30pp) mais sur benchmarks synthetiques courts — indirectness a considerer.

### PICOC #15 — TDD agent loop

- **Mathews & Nadi TGen arXiv 2402.13521** (pyramide 2) — additional remediation loop gain : MBPP +2.8%, HumanEval +3.0% [VERIFIED]
- **Naik et al. TiCoder arXiv 2404.10100** (pyramide 2) — interactive test-clarification loop, +45.97% pass@1 ≤5 interactions [VERIFIED]
- **Han et al. TDFlow arXiv:2510.23761** (pyramide 3, arXiv preprint) — **88.8% pass rate on SWE-Bench Lite** (27.8% absolute improvement over next best **baseline**) ; **94.3% on SWE-Bench Verified** ; 69.8% when agent generates own tests ; *"modern LLMs, when embedded in a narrowly engineered, test-driven workflow, already achieve human-level test resolution"* [VERIFIED par Agent C — **correction mineure** : "next best baseline" pas "next best system"]
- **Willison "Red/green TDD — Agentic Engineering Patterns"** (pyramide 4) — expert practitioner endorsement [NOT_VERIFIED_LITERAL]
- **arXiv:2603.17973 TDAD "Test-Driven Agentic Development"** (pyramide 3 preprint) — graph-based impact analysis for regression awareness [NOT_VERIFIED_LITERAL]

**Recommendation provisoire** : **RECOMMANDE** (3/7). TDD agent loop (human writes failing test, agent iterates) a des preuves empiriques solides via TDFlow (88.8% SWE-Bench Lite, 94.3% Verified). Le sous-clause "no human review per iteration" est valide sur benchmarks mais a qualifier : maintenir final human read of the diff before merge (bridge avec PICOC #13 discipline sur critical paths).

### PICOC #16 — Cost/budget caps per task

**REFUTATION TECHNIQUE MAJEURE** : **LiteLLM ne supporte PAS de wall-clock cap**. Agent C confirme verbatim que LiteLLM supporte **seulement** `max_iterations` et `max_budget_per_session` (dual cap). La "triple cap" framing de l'I est **invalide** pour LiteLLM natif — wall-clock doit etre implemente au niveau orchestrator (timeout wrappers, systemd timers, custom agent code).

**Sources retenues** :

- **LiteLLM Agent Iteration Budgets doc** (pyramide 3) — *"Max Iterations: Hard cap on the number of LLM calls per session"* ; *"Max Budget Per Session: Dollar cap per session"* ; *"receives a 429 Too Many Requests"* [VERIFIED par Agent C — dual cap only, pas triple]
- **Anthropic Claude Code "Models, usage, and limits"** (pyramide 3) — maxTurns cap en headless/non-interactive ; interactive utilise soft guardrails [NOT_VERIFIED_LITERAL]
- **ISO/IEC 42001:2023 §8.1 Operational planning** (pyramide 1) — mandates operational controls for AI systems including resource planning [PARAPHRASE_ONLY paywall]
- **RelayPlane "Agent Runaway Costs 2026"** (pyramide 5, grey lit) — quantifies runaway loops ($0.90 session normale → $9+ en loop 10x) [NOT_VERIFIED_LITERAL]
- **Supra-Wall "Hard Budget Caps"** (pyramide 5) — 4 root causes : infinite tool loops, recursive spawning, context inflation, hallucinated repetition [NOT_VERIFIED_LITERAL]

**GRADE recalcule apres refutation LiteLLM wall-clock** :
- Starting : 3 (ISO 42001 §8.1 + LiteLLM doc)
- +convergence (LiteLLM + grey lit + standard) : +1 → 4
- +important-effect (RelayPlane 10x cost blowup quantifie) : +1 → 5
- -CoI (dominant evidence vendor/consultancy) : -1 → 4
- -indirectness (pas de RCT triple-cap vs partial caps) : -1 → 3
- -imprecision (triple cap technique n'est PAS supporte natively par LiteLLM ; wall-clock requires custom code) : -1 → **2/7**
- **Retain : 2/7 BONNE_PRATIQUE**

**Recommendation provisoire mise a jour** : **BONNE_PRATIQUE** avec clarification technique. **Dual cap (iterations + dollar budget)** est natively supporte par LiteLLM et recommande. **Wall-clock cap** est un complement souhaitable mais doit etre implemente au niveau orchestrator custom — a traiter comme CHOIX_EQUIPE pour le moment. La "triple cap" complete reste un ideal mais n'est pas operationnellement prete.

### PICOC #17 — Provenance & audit trail of agent-generated code

- **GitHub Blog "Trace Copilot agent commits to session logs" 2026-03-20** (pyramide 3, vendor primary) — *"the agent's commits link back to the agent session logs by including an Agent-Logs-Url trailer in the commit message"* [VERIFIED par Agent C] ; commits *"authored by Copilot, with the human who gave Copilot the task marked as the co-author"*
- **Kothari "Claude Code SOC 2 compliance"** (pyramide 4, practitioner) — *"auditors need actual, queryable, timestamped logs..."* ; *"The default 'Co-Authored-By: Claude' trailer is a commit message convention, not an enforced technical control, with no cryptographic signature, watermark, or immutable audit log"* [NOT_VERIFIED_LITERAL]
- **ISO/IEC 42001:2023 §7.5 Documented information + §8 Operation** (pyramide 1) — mandates lifecycle documentation [PARAPHRASE_ONLY paywall]
- **git-ai-project/git-ai** (pyramide 3, OSS tool) — Git extension tracking AI-generated code, Authorship Log linking line ranges to agent sessions via Git Notes [NOT_VERIFIED_LITERAL]
- **CodeSlick "EU AI Act audit trail"** (pyramide 4, vendor) — *"a per-file, per-commit record of AI-generated code in your repository"* [VERIFIED par Agent C]
- **Cline issue #9952** "Audit trails for autonomous code changes (EU AI Act compliance)" (pyramide 4) — user demand [NOT_VERIFIED_LITERAL]

**Recommendation provisoire** : **RECOMMANDE**. Structured audit trail per agent session (model + version + prompt + tool calls + cost + final diff) linked to git commit via trailer (ex: Agent-Logs-Url style GitHub Copilot). Pour contextes regles (SOC2/ISO27001/HIPAA/ISO 42001), **escalate to STANDARD** car compliance requirement. Full session replay = CHOIX_EQUIPE (storage cost tradeoff).

## Divergences et resolution

### DIV-AI3-1 — PICOC #14 : A=5/7 STANDARD vs B=2/7 BONNE_PRATIQUE

- **Cause** : A avait inflate son score avec **2 sources fabriquees** (DataCamp benchmark hallucine + TGen "18 LLMs" fabrique).
- **Resolution** : Agent C a detecte les 2 fabrications. **Retrait** de DataCamp comme source, **correction** TGen a 2 LLMs, **recalcul GRADE** : A's 5/7 → 3/7. B's 2/7 → 3/7 aussi (apres reintegration des peer-reviewed sources TiCoder/TGen que B avait aussi). **Convergence a 3/7 RECOMMANDE**.

### DIV-AI3-2 — PICOC #16 : A=3/7 vs B=2/7

- **Cause** : A retenait le triple cap comme supporte par LiteLLM ; B plus prudent sur triple vs dual.
- **Resolution** : Agent C verifie que **LiteLLM ne supporte PAS le wall-clock cap natively** → refutation technique. Triple cap n'est pas operationnel via LiteLLM. **Retain B's conservative 2/7 BONNE_PRATIQUE**. Dual cap (iterations + budget) reste le recommandable ; wall-clock = choix d'equipe a implementer separement.

### DIV-AI3-3 — PICOC #15 : A=4/7 vs B=3/7

- **Cause** : A plus generous sur convergence gain ; B prudent sur indirectness (SWE-Bench ≠ production).
- **Resolution** : Conservative rule → **3/7 RECOMMANDE**. TDFlow empirical est solide mais benchmark, pas production.

## Corrections factuelles appliquees (via Agent C)

1. **A / Bainbridge opening thesis** : A avait cite un passage de §3 comme "opening thesis" ; la vraie opening thesis est la quote de B (*"the more advanced a control system is..."*). Quote A est aussi legerement alteree (*"his task"* → *"the human operator's task"*). Correction appliquee.

2. **A / TGen "18 LLMs"** : **FABRICATION**. Papier teste **2 LLMs** (GPT-4 Turbo v1106 + Meta Llama 3). Correction : "18 LLMs" supprime, remplace par "2 LLMs".

3. **A / DataCamp plan mode benchmark** : **HALLUCINATION TOTALE**. Aucun benchmark "12/30 vs 23/30" n'existe dans l'article DataCamp. Source **ecartee entierement** du PICOC #14 evidence.

4. **A & B / LiteLLM triple cap** : **REFUTATION TECHNIQUE**. LiteLLM supporte seulement dual cap (iterations + dollars), pas wall-clock. Triple cap framing invalide. PICOC #16 recommendation mise a jour : dual cap BONNE_PRATIQUE + wall-clock CHOIX_EQUIPE (custom implementation requise).

5. **B / TDFlow "next best system"** : correct est *"next best **baseline**"*. Minor wording correction.

## Limites documentees

1. **Fabrications de A en AI-3** : 2 fabrications detectees (DataCamp benchmark entier + TGen count). Ce pattern (A fabrique, Agent C detecte) est coherent avec Phases 1.1 et 1.3 ou A avait deja fabrique. **Le mecanisme double extraction + Agent C reste robuste**, meme si certain reviewers ont tendance a hallucinate. Recommendation : **renforcer les instructions "no invention"** dans les prompts A pour Phase 2 continuation si applicable.

2. **PICOC #16 triple cap** : le framing "triple cap" etait trop optimiste. La realite technique : dual cap standard, wall-clock cap custom. **Amendment #11 methodology.md proposait "floor rule" ; ce cas suggere un nouvel amendment** : *"verify technical feasibility of proposed I before scoring ; I must not assume features not yet implemented"*.

3. **Bainbridge 1983 PDF** non fetche directement (binary) — citation finale reste NOT_VERIFIED_LITERAL pour les passages au-dela de l'opening thesis.

4. **Agent A reliability** : sur 3 batches (AI-1, AI-2, AI-3), Agent A a produit **au total 7 fabrications detectees** vs **0 chez B** en Batch AI-3 (B a aussi fait quelques NOT_VERIFIED_LITERAL mais sans fabrication). Pattern a documenter : **B est plus fiable sur verbatim fidelity**, **A est plus expansive mais prone to hallucination**.

## Prochaine etape

**Phase 3** — Reporting : conversion des 17 PICOCs en JSON decisions au format methodology.md, creation des pages markdown du guide, integration dans `data/decisions/` et `data/decision-tree.json`.
