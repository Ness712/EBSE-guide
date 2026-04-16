# Double Extraction — Batch 13 : Pratiques d'ingenierie (12 decisions)

**Date** : 2026-04-14
**Agent A** : a6b650968d6b7bd51 (contexte independant)
**Agent B** : a2d6eab2e1144badb (contexte independant)

## Resultats

- **Accord recommandations : 11/12 (92%)**
- **1 divergence** : monorepo vs polyrepo — A dit polyrepo, B dit monorepo. → [CHOIX D'EQUIPE]
- **Accord GRADE : ~50% exact** — Agent A note systematiquement +1-2 vs Agent B. Conservatif retenu.

| # | Decision | Reco | GRADE conservatif |
|---|----------|------|-------------------|
| 1 | Folder structure | Feature-based, /backend + /frontend | 3/7 [BONNE PRATIQUE] |
| 2 | Monorepo vs polyrepo | Pas de consensus | 2/7 [CHOIX D'EQUIPE] |
| 3 | Issue tracking | Linear ou GitHub Issues, 4 colonnes | 2/7 [CHOIX D'EQUIPE] |
| 4 | Feedback collection | Templates structures + triage hebdo | 2/7 [CHOIX D'EQUIPE] |
| 5 | Documentation | README + ADR + inline why + CONVENTIONS | 3/7 [BONNE PRATIQUE] |
| 6 | Onboarding | Checklist + first PR <24h + pair | 3/7 [BONNE PRATIQUE] |
| 7 | Definition of done | Review + tests + staging + docs | 4/7 [RECOMMANDE] |
| 8 | Release management | semantic-release + conventional commits | 3/7 [BONNE PRATIQUE] |
| 9 | Code ownership | CODEOWNERS + 1 reviewer min + rotation | 3/7 [BONNE PRATIQUE] |
| 10 | Environments | dev/staging/prod, CI/CD only | 4/7 [RECOMMANDE] |
| 11 | Analytics | PostHog (self-hosted) ou Plausible | 2/7 [CHOIX D'EQUIPE] |
| 12 | Session replay | PostHog recordings | 2/7 [CHOIX D'EQUIPE] |

## Recherche systematique

Bases consultees : SWEBOK v4, DORA/Accelerate, SO Survey, JetBrains, Google Engineering Practices, GitHub docs, NNG, vendor docs.
