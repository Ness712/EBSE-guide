# Double Extraction — Batch 12 : Stack optimale sans contrainte

**Date** : 2026-04-14
**Agent A** : a930664663115dd6c (contexte independant)
**Agent B** : a7e441583b5db5566 (contexte independant)

## Resultats

- **Accord sur la stack : 10/10 (100%)**
- Les 2 agents arrivent INDEPENDAMMENT a la meme stack optimale

## Stack optimale (consensus 2 agents)

| Couche | Choix | Agent A GRADE | Agent B GRADE | Conservatif |
|--------|-------|-------------|-------------|-------------|
| Langage | TypeScript (full-stack) | HIGH | A | HIGH |
| Backend | NestJS (Fastify adapter) | MODERATE | B+ | MODERATE |
| Frontend | React 19 | HIGH | A | HIGH |
| BDD | PostgreSQL | HIGH | A | HIGH |
| ORM | Prisma | MODERATE | B | MODERATE |
| CSS | Tailwind CSS 4 | HIGH | A- | HIGH |
| Build | Vite 6+ | HIGH | A | HIGH |
| Test unit | Vitest | MODERATE | B+ | MODERATE |
| Test E2E | Playwright | HIGH | B+ | HIGH |
| Package mgr | pnpm | — | B | MODERATE |

## Argument decisif (les 2 agents convergent)

"TypeScript on both sides creates a type-safe pipeline from database to UI
that no polyglot stack can replicate without significant tooling overhead."

PostgreSQL schema → Prisma types → NestJS services → React components
Tout est TypeScript. Un changement de schema propage des erreurs de compilation.

## Ce que cette stack N'EST PAS optimale pour

- Raw computation / ML → Python
- Extreme low-latency (<1ms p99) → Go ou Rust
- Mobile natif → Kotlin/Swift

## Sources principales

- SO Survey 2024 (65k devs) — satisfaction + adoption
- State of JS 2024/2025 (20k devs) — retention + satisfaction
- JetBrains 2024 (25k devs) — trends
- npm trends — adoption velocity
- DB-Engines — database trends
- OWASP alignment — security

## Recherche systematique

Bases consultees : SO Survey, State of JS, JetBrains DevEcosystem, npm trends, TIOBE, DB-Engines, TechEmpower Benchmarks, OWASP Top 10, Core Web Vitals.
Mots-cles : "best web framework 2025", "developer satisfaction survey", "framework benchmark".
