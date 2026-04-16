# Double Extraction v3.0 — Testing (7 decisions)
Date : 2026-04-14
Agent A : Claude Opus 4.6 1M (perspective independante)
Agent B : Claude Opus 4.6 1M (contexte isole)

## Resultats
- Accord outil : 7/7 (100%)
- Divergences : aucune

Les deux agents ont selectionne les memes 5 sources pour chaque decision, attribue les memes recommandations, et converge sur les memes GRADE et niveaux. Les scores Q1-Q11 varient marginalement (< 1 point) sur quelques sources sans impact sur les conclusions.

## Decisions reconciliees

| # | Decision | Reco | GRADE conservatif | Robustesse |
|---|----------|------|-------------------|------------|
| 1 | Unit testing + pyramide 70/20/10 | **JUnit 5 / Vitest / pytest** + ratio 70/20/10 | HAUTE (6/7) — STANDARD | ROBUSTE |
| 2 | Integration testing | **Testcontainers** | HAUTE (5/7) — STANDARD | ROBUSTE |
| 3 | E2E testing | **Playwright** | HAUTE (6/7) — STANDARD | ROBUSTE |
| 4 | Contract testing | **Pact** (multi-stack) / **SCC** (mono-Java) | MODEREE (5/7) — RECOMMANDE | MODERE |
| 5 | Mutation testing | **PIT / Stryker / mutmut** (per stack) | MODEREE (4/7) — RECOMMANDE | FRAGILE |
| 6 | Mocking | **Mockito / vi.mock+MSW / unittest.mock** | HAUTE (6/7) — STANDARD | ROBUSTE |
| 7 | Test data | **Factory pattern + Faker** (per stack) | MODEREE (5/7) — RECOMMANDE | MODERE |

## Notes de reconciliation

**Decision 1 — Unit testing + pyramide** : Accord total. Memes sources (Fowler, Google, State of JS, JetBrains, Spring). GRADE identique 6/7. Agent B note Q11=1 pour Google (vs 0.5 Agent A) — difference negligeable. Robustesse : Agent A dit "tres stable", Agent B dit "ROBUSTE" — equivalent.

**Decision 2 — Integration testing** : Accord total. Agent A note GRADE 5.5/7, Agent B note 5/7 (difference sur scoring CoI Docker). Conservatif retenu : **5/7 HAUTE**. Les deux identifient H2 = faux positifs par divergence dialecte PostgreSQL.

**Decision 3 — E2E testing** : Accord total. Playwright = 96% satisfaction vs 55% Cypress (State of JS). ThoughtWorks Adopt. Meme GRADE 6/7. Agent B note "TRES ROBUSTE" — upgrade a ROBUSTE pour etre conservatif.

**Decision 4 — Contract testing** : Accord total. Pact pour multi-stack, SCC pour mono-Java. GRADE identique 5/7 MODEREE. Les deux notent ThoughtWorks Adopt CDCT et SmartBear CoI sur Pact.

**Decision 5 — Mutation testing** : Accord total sur outil (PIT/Stryker/mutmut) et GRADE (4/7). Agent B explicite "FRAGILE sans l'etude academique" (Zhu et al.) — retenu comme robustesse conservative. ThoughtWorks = Trial (pas Adopt).

**Decision 6 — Mocking** : Accord total. Standards de facto incontestes par stack. GRADE identique 6/7. Agent A dit "extremement stable", Agent B dit "TRES ROBUSTE" — harmonise a ROBUSTE.

**Decision 7 — Test data** : Accord total. Factory pattern + Faker per stack. GRADE identique 5/7. Les deux identifient factory_boy docs 403 mais contenu accessible via GitHub. Robustesse MODERE (fragile sans fondation theorique Fowler/Pryce).
