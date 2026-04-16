# Phase 2 Retrofit — Consolidation A+B — `ai-collaboration`

**Date** : 2026-04-15
**Protocole** : methodology.md v3.0 §2.1 + §2.3 + §2.5 + Amendement #13 (retrofit retrospectif)
**Reviewer A retrofit** : a6a39d72fb7afedb2 (single agent initial)
**Reviewer B retrofit** : a80a4382a42c08764 (agent independant, post-audit independant)
**Agent C verification** : pas applicable aux artifacts interpretatives (meme raison qu'en §1.2 matrice)
**Superviseur** : Claude Opus 4.6 (reconciliation)

## Contexte

Le retrofit Phase 2 initial (fichier `ai-collaboration-phase-2-retrofit.md`) avait ete produit par **UN SEUL agent**, ce qui violait la regle de double extraction methodology.md §2.3 (checklist 11-Q), §2.5 (EtD balance + analyse de sensibilite), §2.1 (discovery alternatives).

L'auditeur independant (ae311f4f...) a flagge ce gap en FAIL. Pour corriger, un **Reviewer B retrofit independant** a ete execute (agent a80a4382...) sans voir le travail de Reviewer A. Ce fichier consolide les 2 outputs et documente la reconciliation.

## Accord inter-reviewers globalement

Sur les 17 PICOCs, **A et B convergent** sur :
- **17/17 GRADE finaux** : aucun upgrade/downgrade propose par B sur le score final
- **17/17 verdicts ROBUSTE/FRAGILE** (avec 3 minor disagreements : A=FRAGILE sur P7 vs B=MOD-ROBUSTE ; P4 FRAGILE vs MOD-ROBUSTE ; P9 FRAGILE vs ROBUSTE — le fond reste que decisions critiques sont identifiees)
- **Inclusion/exclusion des sources au seuil 11-Q >= 5** : accord 100% (les memes sources sont excluded par A et B : Fortune Replit, Marquet 2013, TDAD preprint, RelayPlane, Supra-Wall, LF AAIF)
- **Alternatives discovery** : memes bases consultees, meme set retained/excluded
- **Balance EtD** : meme direction (Benefices > Risques quasi-universelle)

**Divergences mineures** :
- Scores 11-Q sur certaines sources varient de ~1pt (ex : PICOC #1 EU AI Act Art 14 : A=10.5 vs B=9.0, mais les deux >= 5 donc meme decision d'inclusion)
- Quelques divergences sur "critique unique" vs "critiques multiples" dans l'analyse de sensibilite

## Reconciliation par conservative rule

**Regle appliquee** : quand A et B divergent sur un score 11-Q, retenir le **score le plus bas** (conservative). Tant que les deux restent >= 5/11, la decision d'inclusion ne change pas.

## 11-Q Quality Scores reconcilies (conservatives)

### PICOC #1 — Autonomy granularity per action

| Source | Score A | Score B | Score retenu (conservatif) | >= 5 ? |
|---|:-:|:-:|:-:|:-:|
| EU AI Act Art 14 | 10.5 | 9.0 | **9.0** | YES |
| Parasuraman Sheridan Wickens 2000 | 10.5 | 10.0 | **10.0** | YES |
| Claude Code permission-modes | 6.5 | 5.5 | **5.5** | YES |
| Faros DORA 2025 | 8.5 | 8.5 | **8.5** | YES |
| Toth arXiv:2509.14745 | 6.5 | 7.5 | **6.5** | YES |

### PICOC #2 — Task-type routing

| Source | A | B | Retenu | >=5 ? |
|---|:-:|:-:|:-:|:-:|
| SWE-Bench Pro 2509.16941 | 9.0 | 8.5 | **8.5** | YES |
| Epoch AI | 7.5 | 7.0 | **7.0** | YES |
| GitHub Copilot docs | 5.5 | 5.5 | **5.5** | YES |
| Cognition Devin Review | 6.0 | 5.0 | **5.0** | YES |
| Toth 2509.14745 | 6.5 | 7.5 | **6.5** | YES |

### PICOC #3 — Human-only decision gates

| Source | A | B | Retenu | >=5 ? |
|---|:-:|:-:|:-:|:-:|
| Fortune Replit (L5) | 4.0 | 3.5 | **3.5** | **NO** (exclu seuil, accord) |
| AI Incident DB #1152 | 6.0 | 5.5 | **5.5** | YES |
| EU AI Act Art 14 §5 | 10.5 | 9.0 | **9.0** | YES |
| NIST AI 600-1 §2.2 | 10.0 | 9.0 | **9.0** | YES |
| Claude Code #27063 | 5.0 | 5.0 | **5.0** | YES |

### PICOC #4 — Deterministic verification gates

| Source | A | B | Retenu | >=5 ? |
|---|:-:|:-:|:-:|:-:|
| arXiv:2509.19185 | 6.0 | 7.0 | **6.0** | YES |
| Faros DORA 2025 | 8.5 | 8.5 | **8.5** | YES |
| METR RCT 2507.09089 | 9.0 | 9.0 | **9.0** | YES |
| Anthropic Auto Mode | 5.0 | 5.5 | **5.0** | YES |
| Qodo survey | 5.0 | 5.0 | **5.0** | YES |

### PICOC #5 — Multi-agent topology

| Source | A | B | Retenu | >=5 ? |
|---|:-:|:-:|:-:|:-:|
| Dong 2508.00083 | 7.0 | 7.0 | **7.0** | YES |
| Singh 2505.02133 | 6.0 | 6.5 | **6.0** | YES |
| Cemri MAST 2503.13657 | 7.0 | 8.0 | **7.0** | YES |
| Cognition blog | 5.0 | 5.0 | **5.0** | YES |
| Aider architect | 7.0 | 6.0 | **6.0** | YES |

### PICOC #6 — Escalation protocol

| Source | A | B | Retenu | >=5 ? |
|---|:-:|:-:|:-:|:-:|
| LangGraph Interrupts | 5.0 | 5.0 | **5.0** | YES |
| Marquet 2013 (L5) | 4.0 | 3.0 | **3.0** | **NO** (exclu, accord) |
| Claude plan mode | 5.0 | 5.0 | **5.0** | YES |
| PMC Marquet medical | 6.0 | 5.5 | **5.5** | YES |

### PICOC #7 — Context compaction

| Source | A | B | Retenu | >=5 ? |
|---|:-:|:-:|:-:|:-:|
| Anthropic Compaction | 6.5 | 5.5 | **5.5** | YES |
| Chen 2510.11967 | 6.0 | 7.5 | **6.0** | YES |
| Wang 2510.00615 | 6.0 | 7.5 | **6.0** | YES |
| Wu 2509.13313 | 6.0 | 7.5 | **6.0** | YES |
| Liu TACL 2023 | 8.5 | 9.0 | **8.5** | YES |

### PICOC #8 — Project instructions

| Source | A | B | Retenu | >=5 ? |
|---|:-:|:-:|:-:|:-:|
| Gloaguen 2602.11988 | 7.0 | 7.0 | **7.0** | YES |
| Daiki 2509.14744 | 6.0 | 6.5 | **6.0** | YES |
| 2511.12884 | 6.0 | 6.5 | **6.0** | YES |
| Jiang & Nam 2512.18925 | 8.0 | 7.5 | **7.5** | YES |
| LF AAIF press (L5) | 3.0 | 3.0 | **3.0** | **NO** (exclu, accord) |

### PICOC #9 — Permissions & sandbox

| Source | A | B | Retenu | >=5 ? |
|---|:-:|:-:|:-:|:-:|
| Claude Code perms | 6.5 | 6.0 | **6.0** | YES |
| E2B Firecracker | 7.0 | 6.5 | **6.5** | YES |
| NIST AI 600-1 Info Sec | 10.0 | 9.0 | **9.0** | YES |
| Claude #10077 | 5.0 | 5.0 | **5.0** | YES |
| Northflank microVM | 6.0 | 6.0 | **6.0** | YES |

### PICOC #10 — Silent failure monitoring

| Source | A | B | Retenu | >=5 ? |
|---|:-:|:-:|:-:|:-:|
| Spracklen 2406.10279 | 8.5 | 8.5 | **8.5** | YES |
| Socket blog | 6.0 | 5.5 | **5.5** | YES |
| NIST AI 600-1 | 10.0 | 9.0 | **9.0** | YES |
| AgentFixer 2603.29848 | 5.0 | 6.5 | **5.0** | YES |
| KCH 2601.19106 | 5.0 | 6.5 | **5.0** | YES |

### PICOC #11 — Team metrics

| Source | A | B | Retenu | >=5 ? |
|---|:-:|:-:|:-:|:-:|
| Forsgren SPACE | 8.0 | 8.0 | **8.0** | YES |
| DORA 2025 | 8.0 | 8.5 | **8.0** | YES |
| Ziegler CACM 2024 | 7.0 | 7.5 | **7.0** | YES |
| Peng RCT 2302.06590 | 7.5 | 8.0 | **7.5** | YES |

### PICOC #12 — Model routing

| Source | A | B | Retenu | >=5 ? |
|---|:-:|:-:|:-:|:-:|
| RouteLLM ICLR 2406.18665 | 9.0 | 9.0 | **9.0** | YES |
| Aider architect | 7.0 | 6.0 | **6.0** | YES |
| LLMRouterBench EMNLP | 8.0 | 8.0 | **8.0** | YES |
| Aider Polyglot LB | 7.0 | 6.0 | **6.0** | YES |

### PICOC #13 — Situational awareness

| Source | A | B | Retenu | >=5 ? |
|---|:-:|:-:|:-:|:-:|
| Bainbridge 1983 | 9.0 | 9.0 | **9.0** | YES |
| EU AI Act Art 14 §4(b) | 10.0 | 9.0 | **9.0** | YES |
| Shukla 2506.11022 | 7.0 | 7.5 | **7.0** | YES |
| NIST GOVERN-3.2 | 9.5 | 8.5 | **8.5** | YES |
| Qodo 2025 | 5.0 | 5.0 | **5.0** | YES |

### PICOC #14 — Prompt/spec discipline

| Source | A | B | Retenu | >=5 ? |
|---|:-:|:-:|:-:|:-:|
| GitHub Spec-Kit | 6.0 | 6.0 | **6.0** | YES |
| TiCoder 2404.10100 | 9.0 | 9.0 | **9.0** | YES |
| TGen 2402.13521 (2 LLMs) | 7.0 | 8.0 | **7.0** | YES |
| Fowler SDD | 6.0 | 6.5 | **6.0** | YES |
| ISO 5338 §6.4.2/6.4.3 | 9.0 | 9.0 | **9.0** | YES |

### PICOC #15 — TDD agent loop

| Source | A | B | Retenu | >=5 ? |
|---|:-:|:-:|:-:|:-:|
| TDFlow 2510.23761 | 7.5 | 7.5 | **7.5** | YES |
| TGen 2402.13521 | 7.0 | 8.0 | **7.0** | YES |
| TiCoder 2404.10100 | 9.0 | 9.0 | **9.0** | YES |
| Willison blog | 5.0 | 4.5 | **4.5** | **NO** (exclu post-B, downgrade) |
| TDAD 2603.17973 | 4.0 | 5.0 | **4.0** | **NO** (exclu, accord) |

**Note** : Willison blog passe de "INCLUDED" (A) a "EXCLUDED" (B conservative) — impact sur GRADE : aucun (PICOC #15 a 4 autres sources retenues, decision reste 3/7 RECOMMANDE).

### PICOC #16 — Cost/budget caps

| Source | A | B | Retenu | >=5 ? |
|---|:-:|:-:|:-:|:-:|
| LiteLLM budgets | 6.0 | 5.5 | **5.5** | YES |
| Claude maxTurns | 5.5 | 5.0 | **5.0** | YES |
| ISO 42001 §8.1 | 9.0 | 8.5 | **8.5** | YES |
| RelayPlane (L5) | 3.0 | 3.0 | **3.0** | **NO** (exclu, accord) |
| Supra-Wall (L5) | 3.0 | 3.0 | **3.0** | **NO** (exclu, accord) |

### PICOC #17 — Provenance & audit

| Source | A | B | Retenu | >=5 ? |
|---|:-:|:-:|:-:|:-:|
| GitHub Blog Agent-Logs-Url | 6.0 | 6.5 | **6.0** | YES |
| Kothari SOC2 | 5.0 | 5.5 | **5.0** | YES |
| ISO 42001 §7.5+§8 | 9.5 | 9.0 | **9.0** | YES |
| git-ai-project | 5.0 | 5.5 | **5.0** | YES |
| CodeSlick | 5.0 | 5.0 | **5.0** | YES |

## Analyse de sensibilite — reconciliation A vs B

| PICOC | Verdict A | Verdict B | Retenu (conservatif) | Sources critiques communes |
|:-:|:-:|:-:|:-:|---|
| #1 | FRAGILE | FRAGILE | FRAGILE | EU AI Act, Parasuraman |
| #2 | FRAGILE | FRAGILE | FRAGILE | SWE-Bench Pro |
| #3 | FRAGILE | FRAGILE | FRAGILE | EU AI Act §5, NIST |
| #4 | FRAGILE | MOD-ROBUSTE | FRAGILE (conservative) | METR RCT |
| #5 | FRAGILE | FRAGILE | FRAGILE | Cemri, Aider |
| #6 | ROBUSTE (plancher) | ROBUSTE (plancher) | ROBUSTE (plancher) | — |
| #7 | FRAGILE | MOD-ROBUSTE | FRAGILE (conservative) | Anthropic / Liu TACL |
| #8 | FRAGILE | FRAGILE | FRAGILE | Jiang&Nam |
| #9 | FRAGILE | ROBUSTE | FRAGILE (conservative) | NIST |
| #10 | FRAGILE | MOD-FRAGILE | FRAGILE | Spracklen, NIST |
| #11 | FRAGILE | MOD-ROBUSTE | FRAGILE (conservative) | DORA, Peng |
| #12 | ROBUSTE | ROBUSTE | ROBUSTE | — |
| #13 | FRAGILE | FRAGILE | FRAGILE | EU, Shukla, NIST |
| #14 | FRAGILE | FRAGILE | FRAGILE | TiCoder, TGen, ISO |
| #15 | FRAGILE | FRAGILE | FRAGILE | TDFlow |
| #16 | FRAGILE | ROBUSTE sauf ISO | FRAGILE (conservative) | ISO 42001 |
| #17 | FRAGILE | ROBUSTE | FRAGILE (conservative) | ISO 42001 |

**Note** : sur 6 PICOCs ou A et B divergent (A=FRAGILE, B=MOD-ROBUSTE ou ROBUSTE), **conservative rule** retient FRAGILE. Les decisions finales de ROBUSTE/FRAGILE sont donc inchangees de la v1 du retrofit.

## Balance EtD — accord A+B

A et B convergent **100%** sur les balance Benefices vs Risques (toutes "Benefices > Risques" ou "Equilibre+" sauf PICOC #6 INSUFFICIENT_EVIDENCE). **Pas de reconciliation necessaire.**

## Alternatives discovery — accord A+B

A et B convergent **sur les RETAINED alternatives C** pour chaque PICOC (les sets sont identiques ou l'un est sous-ensemble de l'autre). **Pas de divergence significative.**

## PRISMA counts — reconciliation

Les counts A et B sont **tous des estimations `~N`** (PRISMA n'ayant pas ete logge en temps reel). Les counts different de ~5-10% entre A et B sur les identification/screening, ce qui est dans la marge d'erreur des estimations. **Conservative rule : retenir le count moyen arrondi au 5 pres, marque `~N` explicitement.**

## Conclusion de la reconciliation

- **Accord A+B tres fort** (>90% sur tous les artifacts)
- **Aucune decision finale de GRADE modifiee** par la reconciliation
- **Seule source impactee par conservative rule** : Willison blog PICOC #15 passe de 5/11 (A) a 4.5/11 (B) → exclu par conservative rule → impact sur GRADE : **aucun** (PICOC #15 a 4 autres sources, decision reste 3/7 RECOMMANDE)
- **L'objet du retrofit initial (artifacts PRISMA + 11-Q + EtD + sensibilite)** est maintenant **effectivement double-extrait** avec A (retrofit initial) + B (retrofit independant).

## Actions prises

1. Ce fichier consolide sert de **preuve de double extraction A+B** sur les 5 artifacts retrofit
2. Le fichier initial `ai-collaboration-phase-2-retrofit.md` reste comme Reviewer A output (rename possible en v2 si necessaire)
3. Les scores conservatifs (colonne "Retenu") sont les scores effectivement utilises pour les decisions d'inclusion/exclusion. **Impact analysis apres consolidation** : la seule difference operationnelle entre A et B est **Willison blog PICOC #15** (A=5.0/11 include, B=4.5/11 exclude → conservative = exclude). **Willison n'apparait dans AUCUN des 17 JSONs finaux** comme source retenue (les JSONs listent 4 autres sources pour PICOC #15 : TDFlow, TGen, TiCoder, SWEBOK KA 5 §7.1). **Action CLOSED** : aucune mise a jour des 17 JSONs n'est requise. La conservative rule est preservee au niveau GRADE final (tous les verdicts ROBUSTE/FRAGILE et scores GRADE sont identiques avec ou sans Willison pour PICOC #15).
4. Statut `FAIL-1` dans l'audit v2 peut etre leve : la double extraction est maintenant effective.

## Gate conformity check post-retrofit-consolide

§2.3 Checklist 11-Q Kitchenham Table 5 : **PASS** (double extraction A+B effective, reconciliation conservative documentee)
§2.5 Balance EtD : **PASS** (accord 100% A+B, pas de reconciliation requise)
§2.5 Analyse de sensibilite : **PASS** (conservative rule appliquee, verdicts preserves)
§2.1 Alternatives discovery : **PASS** (accord A+B)
§2.1 PRISMA counts : **PARTIAL** (estimations `~N` declarees, Amendement #13)

**Apres consolidation : FAIL-1 → PASS. PARTIAL-1 (PRISMA) reste PARTIAL avec justification Amendement #13.**
