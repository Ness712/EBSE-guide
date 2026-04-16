# Double Extraction v3.0 — Architecture (12 decisions)

**Date** : 2026-04-14
**Agent A** : a077f6f9b94d59019
**Agent B** : ab6164c6830b9f173
**Methode** : Kitchenham v3.0 complete (PICOC, PRISMA, I/E, Q1-Q11, GRADE, sensitivity, pub bias)

## Resultats

- **Accord outil : 11/12 (92%)**
- **1 divergence** : backend (A=Spring Boot STANDARD, B=CHOIX_EQUIPE par langage)
- **Resolution** : B est correct — batch 12+18 confirment CHOIX_EQUIPE

## Decisions reconciliees

| # | Decision | Reco | GRADE conservatif | Robustesse |
|---|----------|------|-------------------|------------|
| 1 | Backend | CHOIX_EQUIPE (par langage) | 2/7 | FRAGILE |
| 2 | Frontend | React | 4/7 [RECOMMANDE] | ROBUSTE |
| 3 | Database | PostgreSQL | 5/7 [STANDARD] | ROBUSTE |
| 4 | API protocol | REST | 5/7 [STANDARD] | ROBUSTE |
| 5 | API versioning | URL path /v1/ | 2/7 [BONNE_PRATIQUE] | FRAGILE |
| 6 | Module structure | Feature-based | 4/7 [RECOMMANDE] | FRAGILE |
| 7 | Rendering | CSR (Vite SPA) | 3/7 [RECOMMANDE] | FRAGILE |
| 8 | State management | Zustand | 4/7 [RECOMMANDE] | ROBUSTE |
| 9 | HTTP client | Per stack | 3/7 [RECOMMANDE] | FRAGILE |
| 10 | Scaling | Monolith-first | 6/7 [STANDARD] | ROBUSTE |
| 11 | OpenAPI | Per stack | 5/7 [STANDARD] | FRAGILE |
| 12 | Web mobile | PWA (+ Capacitor si store) | 4/7 [RECOMMANDE] | FRAGILE |

## Sensitivity analysis (Agent B finding)

8/12 decisions sont FRAGILES — retirer la source de plus haut niveau change la reco ou le GRADE. Seules 4 sont ROBUSTES (React, PostgreSQL, Zustand, monolith-first). C'est un signal important pour la fiabilite du guide.
