# Double Extraction v3.0 — Guide Application Docs (1 decision)

**Date** : 2026-04-15
**Agent A** : a796bed220d17f5cc
**Agent B** : a549ac30fd3bde346
**Methode** : Kitchenham v3.0 complete (PICOC, PRISMA, I/E, Q1-Q11, GRADE, sensitivity, pub bias)

## Resultats

- **Accord : 1/1 (100%)**
- **Option C unanime : 12/12 sources (Agent A), 11/11 sources (Agent B)**
- **0 source dissidente sur les 4 options evaluees**

| # | Decision | Reco | GRADE conservatif | Robustesse |
|---|----------|------|-------------------|------------|
| 1 | Comment documenter l'application d'un guide | Option C : choix concrets + pointeurs vers guide | 5/7 [STANDARD] | ROBUSTE |

## Notes
- Les 2 agents ont cherche independamment et trouve les memes sources core (Google SWE Book, SWEBOK, Diataxis, NASA, ADR, InnerSource, Fowler, ISO)
- Agent A a aussi cite Parnas & Clements (1986), Herbsleb & Grinter (1999), GQM (Basili 1994) — 40 ans de convergence
- Agent B a aussi cite ESA ECSS, Humble & Farley (Continuous Delivery)
- Option A (duplication) explicitement rejetee par 5+ sources : "nearly impossible to keep in sync" (Google), "documentation rot" (ThoughtWorks), "compliance ambiguity" (ESA)
- SWEBOK utilise le terme "tailoring" : le projet documente comment il instancie le standard, pas le standard lui-meme
