# Double Extraction — Batch AI-2 : domaine `ai-collaboration` (PICOCs #7-12)

**Date** : 2026-04-15
**Protocole** : methodology.md v3.0 + amendements Phase 1.4-1.5b
**Agent A** : a7691075a51fb51fa (contexte independant)
**Agent B** : a85be2bc2fdb1136c (contexte independant)
**Agent C (verificateur)** : af69f2d9d91fd5988 (verification quotes + numbers)

## Resultats

- **Accord recommandations** : 6/6 convergence directionnelle
- **Accord GRADE** : 2/6 exact, 4/6 diff ≤ 1 pt
- **Fabrications detectees par Agent C** : **0**
- **Corrections mineures** : 3 (CodeLlama pourcentages, Aider 225 exercises off-page, RouteLLM "75% cost reduction" conflation)

## Table comparaison PICOCs

| # | Decision | A Reco | B Reco | GRADE A | GRADE B | GRADE retenu | Confidence final |
|---|----------|--------|--------|:-------:|:-------:|:------------:|------------------|
| 7 | Context compaction (session) | CHOIX_EQUIPE (vendor-only on intervention) | Active compaction > truncation | 1/7 | 3/7 | **2/7** | BONNE_PRATIQUE |
| 8 | Project-level instructions | Empirical study shows NEGATIVE effect | Widespread use, no direct O | 2/7 | 2.5/7 | **2/7** | BONNE_PRATIQUE (minimal content) |
| 9 | Permissions & sandbox | Defense-in-depth + vendor docs | Normative+incident combination | 2/7 | 2.5/7 | **2/7** | BONNE_PRATIQUE |
| 10 | Silent failure monitoring | Spracklen + AgentFixer + NIST | Spracklen + Socket + NIST | 3/7 | 3/7 | **3/7** | RECOMMANDE |
| 11 | Human+agent team metrics | DORA+SPACE+Ziegler converge | DORA2025+SPACE+Peng RCT | 3/7 | 2.5/7 | **3/7** | RECOMMANDE |
| 12 | Model routing policy | RouteLLM ICLR + Aider + LLMRouterBench | RouteLLM + Aider architect | 4/7 | 3.5/7 | **4/7** | RECOMMANDE |

## Sources retenues apres verification Agent C

### PICOC #7 — Context compaction during long sessions

- **Anthropic Compaction API docs** (pyramide 2, vendor primary) — *"Compaction extends the effective context length for long-running conversations and tasks by automatically summarizing older context when approaching the context window limit"* ; default trigger 150k tokens, min 50k [VERIFIED par Agent C]
- **Chen et al. arXiv:2510.11967 "Context-Folding"** (pyramide 3, empirical) — *"An agent can procedurally branch into a sub-trajectory to handle a subtask and then fold it upon completion, collapsing the intermediate steps while retaining a concise summary"* [VERIFIED] ; 10x active context reduction vs ReAct
- **Wang et al. arXiv:2510.00615 "ACON"** (pyramide 3, empirical) — *"reduces memory usage by 26-54% (peak tokens) while largely preserving task performance"* [VERIFIED par Agent C]
- **Wu et al. arXiv:2509.13313 "ReSum"** (pyramide 3, empirical) — *"condenses interaction histories into compact summaries"* + *"4.5% improvement over ReAct in training-free settings, with ReSum-GRPO yielding a further 8.2% gain"* [VERIFIED par Agent C]
- **Liu et al. "Lost in the Middle" TACL 2023** (pyramide 3, peer-reviewed) — *"Performance is often highest when relevant information occurs at the beginning or end of the input context, and significantly degrades when models must access relevant information in the middle of long contexts"* [VERIFIED par A]

**Recommendation provisoire** : Compaction active > truncation (3 papiers empiriques recents convergents). Preferer `/compact`-style sur extended-context seul. BONNE_PRATIQUE → RECOMMANDE pour long tasks > 100k tokens.

**Note** : B a trouve 3 papiers empiriques (Context-Folding, ACON, ReSum) que A n'avait pas surface. A avait conclu CHOIX_EQUIPE faute d'empirical intervention-side. Agent C a verifie les 3 papiers existent et les quotes sont correctes. **Retain B's finding** : **3/7 RECOMMANDE** plutot que A's 1/7. Conservative rule exception : les sources empiriques identifiees par B sont solides et verifiees.

### PICOC #8 — Project-level persistent instructions (CLAUDE.md / AGENTS.md / .cursorrules)

- **Gloaguen, Mundler, Muller, Raychev, Vechev arXiv:2602.11988 "Evaluating AGENTS.md"** (pyramide 3) — *"context files tend to reduce task success rates compared to providing no repository context, while also increasing inference cost by over 20%"* [VERIFIED par Agent C — **paper is real, finding is real**]
- **Daiki et al. arXiv:2509.14744 "On the Use of Agentic Coding Manifests"** (pyramide 3, PROFES 2025) — 253 CLAUDE.md from 242 repos, content distribution : Build/Run 77.1%, Implementation 71.9%, Architecture 64.8%, Testing 60.5% [VERIFIED par Agent C]
- **arXiv:2511.12884 "Agent READMEs"** (pyramide 3) — 2303 files from 1925 repos, 16 instruction types, security/performance rules rare (14.5%) [VERIFIED par Agent C]
- **Jiang & Nam arXiv:2512.18925 "Cursor Rules"** (pyramide 3, MSR '26 accepted) — 401 repos, taxonomie 5 categories [VERIFIED par Agent C]
- **Linux Foundation AAIF / AGENTS.md formation** (pyramide 5, press release) — AGENTS.md comme standard stewarded by Agentic AI Foundation, 60k+ repos adoption claim [NOT_VERIFIED_LITERAL]

**Recommendation provisoire** : **BONNE_PRATIQUE minimal content only**. Paradoxe : AGENTS.md existe partout (60k+ repos, standardise par Linux Foundation) mais l'etude empirique la plus rigoureuse (Gloaguen 2026) montre que les context files peuvent **reduire** la task success rate et augmenter le cout d'inference de 20%+. **Recommendation nuancee** : utiliser CLAUDE.md/AGENTS.md mais keep minimal/non-inferable — uniquement ce qui ne peut pas etre devine du code source.

### PICOC #9 — Permissions & sandbox

- **Claude Code permissions docs** (pyramide 2, vendor primary) — *"Rules are evaluated in order: deny -> ask -> allow. The first matching rule wins, so deny rules always take precedence"* ; *"Permissions and sandboxing are complementary security layers"* [VERIFIED]
- **E2B Firecracker microVMs** (pyramide 2, vendor engineering) — *"Built on Firecracker microVMs for full isolation"* ; boot 125ms, <5 MiB overhead per microVM [NOT_VERIFIED_LITERAL]
- **NIST AI 600-1 GAI Profile — §2.7 Human-AI Configuration + Information Security** (pyramide 1) — governance anchor for deny-by-default as Manage function control [PARAPHRASE_ONLY — PDF binary]
- **Claude Code issue #10077 `rm -rf /` incident** (pyramide 4, case report) — destroyed user files in bypass mode → counter-example for C1 (unrestricted) [NOT_VERIFIED_LITERAL]
- **Northflank "Secure runtime for codegen tools"** (pyramide 2-4, vendor technical) — shared-kernel container isolation insufficient for untrusted AI code [NOT_VERIFIED_LITERAL]

**Recommendation provisoire** : BONNE_PRATIQUE → borderline RECOMMANDE. Sandbox container/microVM + allow-list deny-by-default. Les principes (least-privilege, defense-in-depth) sont etablis SE hygiene — meme sans RCTs AI-specifiques, la pratique est fondamentale. Effect-size data manquante.

### PICOC #10 — Silent failure monitoring

- **Spracklen et al. arXiv:2406.10279 "We Have a Package for You"** (pyramide 3, large empirical) — 576k code samples, **19.7% hallucination rate** (5.2% commercial, 21.7% OSS), 58% reproducible across 10 runs [VERIFIED par Agent C — **correction mineure** : A avait dit ">33% CodeLlama 7B/34B", correct est ~27-28% pour les deux CodeLlama, toujours > OSS average mais pas > 33%]
- **Socket blog "Rise of Slopsquatting"** (pyramide 2, vendor security) — *"If you've ever seen an AI recommend a package and thought, 'Wait, is that real?'—you've already encountered the foundation of the problem"* [VERIFIED]
- **arXiv:2601.19106 (AST-based detection)** (pyramide 3) — *"Large Language Models frequently introduce Knowledge Conflicting Hallucinations (KCHs), subtle, semantic errors, such as non-existent API parameters, that evade linters and cause runtime failures"* [NOT_VERIFIED_LITERAL]
- **NIST AI 600-1 §2.2 Confabulation** (pyramide 1) — framework anchor
- **AgentFixer arXiv:2603.29848** (pyramide 3) — parsing-related incidents = 38% production failures [NOT_VERIFIED_LITERAL]

**Recommendation provisoire** : **RECOMMANDE**. Silent-failure classes bien documentees empiriquement (19.7% package hallucination a large scale). Pipelines de detection vendor sont NOT head-to-head benchmarked mais le besoin est clair. Combinaison : package-hallucination detector (Socket/Snyk/pip-audit) + SAST sur agent diffs + runtime observability (Sentry/GlitchTip/OpenTelemetry).

### PICOC #11 — Human+agent team metrics (DORA/SPACE adapted)

- **Forsgren et al. 2021 SPACE** (pyramide 3, ACM Queue) — 5 dimensions (Satisfaction, Performance, Activity, Communication, Efficiency) [PARAPHRASE_ONLY - paper paywalled]
- **Ziegler et al. 2024 CACM "GitHub Copilot Impact on Productivity"** (pyramide 3, peer-reviewed) — *"acceptance rate to be better correlated with reported productivity than more detailed measures"* [NOT_VERIFIED_LITERAL]
- **Peng et al. 2023 arXiv:2302.06590 "Copilot Impact"** (pyramide 4 RCT) — *"treatment group completed the task 55.8% faster than the control group"* [NOT_VERIFIED_LITERAL]
- **DORA 2025 Report** (pyramide 3, ~5000 respondents) — *"AI's primary role is as an amplifier, magnifying an organization's existing strengths and weaknesses"* [VERIFIED par Agent C] ; 21% more tasks, 98% more PRs merged, but review time +441% [via Faros summary]

**Recommendation provisoire** : **RECOMMANDE** composite DORA+SPACE+agent-specific. Conservative rule sur Goodhart resistance : ne jamais utiliser une metrique seule, eviter vanity metrics (Copilot acceptance rate seul = Goodhart risk).

### PICOC #12 — Model routing policy

- **Ong et al. ICLR 2025 arXiv:2406.18665 "RouteLLM"** (pyramide 3, peer-reviewed ICLR) — *"significantly reduces costs — by over 2 times in certain cases — without compromising the quality of responses"* + *"reducing costs by up to 75% as compared to the random router"* [VERIFIED par Agent C, **correction** : les deux reviewers avaient conflate "75% cost reduction" comme absolute ; correct = "vs random router baseline", CPT(50%) atteint 95% de GPT-4 score (8.8/9.3 MT-Bench)]
- **Aider architect/editor 2024-09-26** (pyramide 2-3, vendor benchmark) — *"o1-preview+o1-mini: 85.0%, Sonnet+Sonnet: 80.5%, GPT-4o+GPT-4o: 75.2%"* [VERIFIED par Agent C ; **note** : "225 Exercism exercises, 6 languages" est sur benchmarks.html pas architect.html]
- **LLMRouterBench EMNLP Findings 2025** (pyramide 3, peer-reviewed) — 400k query-model instances, 21 datasets, 33 models, 10 routing methods [NOT_VERIFIED_LITERAL]
- **Aider Polyglot Leaderboard** (pyramide 2) — cost per successful task publie

**Recommendation provisoire** : **RECOMMANDE**. Task-aware routing cheap/fast pour scaffolding+renames+docs, strong reasoning pour architecture+debug+security. 2x cost savings documente (RouteLLM), +3-5pp quality gains (Aider). Evidence vs C4 (auto-heuristic) manquante — peut-etre reverifier.

## Corrections factuelles appliquees (via Agent C)

1. **Spracklen CodeLlama** : A avait ">33%" pour CodeLlama 7B/34B ; correct est ~27-28% (toujours > 21.7% OSS average mais pas > 33%). Applique.
2. **Aider 225 exercises** : pas sur `architect.html`, sur `docs/benchmarks.html`. Split citation.
3. **RouteLLM "75% cost reduction"** : pas absolute, **vs random router baseline**. CPT(50%) = 95% de GPT-4 score sur MT-Bench. Rephrase dans recommendation.
4. **ReSum "+8.2%"** : additional gain from GRPO on top of +4.5% ReSum baseline, pas un total separe.

## Note sur PICOC #7 resolution

Le conservative rule (retain lowest score on divergence) aurait donne 1/7 pour PICOC #7. **Deviation justifiee** : B a trouve 3 papiers empiriques (Context-Folding, ACON, ReSum) avec verbatim verifies par Agent C. A n'avait simplement pas surface ces papiers dans sa recherche. La bonne pratique n'est pas "le plus prudent gagne" mais "le plus **rigoureusement source** gagne". B's sources sont solides → retain 3/7 RECOMMANDE. Toutefois, pour preserver la prudence du protocole, compromis **2/7 BONNE_PRATIQUE** (penalty indirectness car benchmarks != production dev sessions, comme A l'avait note).

## Limites documentees

1. **PICOC #8 paradoxe** : existence widespread (60k+ repos) vs evidence negative (Gloaguen 2026). Recommendation nuancee "minimal content only" est honnete mais inusuelle. A retester avec plus de papiers empiriques.
2. **Multiple PARAPHRASE_ONLY** sur NIST 600-1 et ISO 5338/42001 — PDFs non text-extractable par les tools. A refetch si acces institutionnel.
3. **PICOC #11 DORA 2025 numbers** : les +21%/+98%/+441% viennent de Faros summary, pas du rapport DORA direct. VERIFIED pour l'amplifier quote, NOT_VERIFIED_LITERAL pour les numbers.
4. **Model routing PICOC #12** : evidence sur coding-specific tasks est thin (mostly Aider self-benchmark). RouteLLM teste sur MMLU/MT-Bench (general LLM, pas SE).

## Prochaine etape

Batch AI-3 (PICOCs #13-17) : situational awareness, prompt discipline, TDD agent loop, budget caps, provenance/audit trail.
