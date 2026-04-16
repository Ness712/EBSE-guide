# Double Extraction v3.0 — Remaining Patterns (8 decisions)

**Date** : 2026-04-15
**Agent A** : ab28de4a3f4aaddb5
**Agent B** : a75a4ddeaec57e5a5

## Resultats

- **Accord outil : 8/8 (100%)**
- **0 divergence sur les recommandations**
- **GRADE : ±1-2 entre agents sur 4 decisions, identique sur 4**

| # | Decision | Reco | GRADE conservatif | Robustesse |
|---|----------|------|-------------------|------------|
| 1 | Soft delete | deletedAt pour owned restaurables, hard delete pour technique | 5/7 [STANDARD] | ROBUSTE |
| 2 | Scheduled tasks | @Scheduled natif + registre monitoring, pas Quartz | 5/7 [STANDARD] | ROBUSTE |
| 3 | JPA EntityListener | EntityListener pour lifecycle entite, AOP pour services | 5/7 [STANDARD] | ROBUSTE |
| 4 | DTO projection | DTO explicite toujours, jamais entite directe (OWASP API3:2023) | 5/7 [STANDARD] | ROBUSTE |
| 5 | API manual testing | Fichiers .http versionnes + Swagger UI | 4/7 [RECOMMANDE] | FRAGILE |
| 6 | Inline auto-save | Auto-save on blur pour edition, bouton save pour creation | 3/7 [BONNE_PRATIQUE] | FRAGILE |
| 7 | Drill-down navigation | Routes imbriquees + breadcrumbs, jamais de modals | 4/7 [RECOMMANDE] | ROBUSTE |
| 8 | Form spell checking | Spellcheck natif par defaut, desactiver sur champs techniques | 3/7 [BONNE_PRATIQUE] | FRAGILE |

## Notes
- Les 4 decisions backend (soft delete, scheduled tasks, entity listener, DTO projection) sont toutes ROBUSTES avec GRADE 5/7 — basees sur specs JPA, docs Spring, et OWASP
- Inline auto-save a la plus grande divergence de GRADE (Agent A: 5/7 vs Agent B: 3/7) — Agent A a cite plus de sources convergentes, Agent B a note le manque d'etudes empiriques. Conservatif: 3/7
- OLS applique deja correctement les 8 patterns selon les deux agents
