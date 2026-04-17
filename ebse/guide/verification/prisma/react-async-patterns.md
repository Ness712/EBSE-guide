# PRISMA Flow — PICOC react-async-patterns

**Date de recherche** : 2026-04-17
**Bases interrogées** : React docs (react.dev), MDN Web Docs, TanStack Query docs, maxrozen.com, WebSearch général
**Mots-clés Agent A** : "React useEffect fetch race condition", "ignore flag cleanup useEffect", "AbortController React fetch cancel", "useTransition async React 18", "TanStack Query race conditions deduplicate"
**Mots-clés Agent B** : "React useEffect setState unmounted component", "use hook React 19 Suspense Promise", "React Error Boundaries async limitations", "race condition useEffect fix", "Max Rozen React race condition fix"
**Protocole** : methodology.md v3.0 §2.1 — double extraction indépendante (Agents A + B, mots-clés différents) + synthèse Agent C

---

## Flux

```
IDENTIFICATION
  Sources identifiées par base (Agent A + Agent B combinés, avant déduplication) :
    - Documentation framework React officielle (react.dev) : ~10 résultats candidats
    - Documentation standard W3C/MDN (AbortController, Fetch) : ~4 résultats candidats
    - Documentation bibliothèques tierces (TanStack Query, SWR, Zustand) : ~8 résultats candidats
    - Articles experts et blogs (niveau 4-5) : ~15 résultats candidats
    - Recherche académique / empirique (études sur bugs async React) : ~3 résultats candidats
    - Snowballing backward (références citées par react.dev) : ~5 sources
  Total identifié (brut, combiné A+B) : ~45
  Doublons retirés (même source identifiée par A et B) : 3 (React useEffect docs, Rozen 2021, React Error Boundaries)
  Total après déduplication : ~42

SCREENING (titre + résumé)
  Sources screenées : ~42
  Sources exclues au screening : ~28
    - E1 (blogs sans méthodologie ni référence à la spec) : ~12
    - E2 (hors scope PICOC — async général JS, pas React spécifique) : ~7
    - E3 (doublons partiels — couverts par sources primaires déjà incluses) : ~5
    - E4 (vendeur / marketing bibliothèque sans substance technique) : ~4

ELIGIBILITÉ (lecture complète)
  Sources évaluées en détail : ~14
  Sources exclues après lecture complète : ~6
    - Hors scope PICOC strict (patterns async Node.js backend sans équivalent React) : 2
    - Niveau de preuve insuffisant (opinion non étayée sur AbortController vs ignore) : 2
    - Redondance forte avec React docs officielles sans apport différencié : 2

INCLUSION
  Sources incluses dans la synthèse : 8
    - Niveau 3 : 7 (React docs useEffect ×2, React docs useTransition, React docs use() React 19,
                     React docs Error Boundaries, MDN AbortController, TanStack Query docs)
    - Niveau 4 : 1 (Rozen M. maxrozen.com 2021 — endossé react.dev)

  Sources exclues avec raison documentée : 6
    - SWR docs (Vercel, 2024) : couvert fonctionnellement par TanStack Query, moins adopté, redondant
    - Redux Toolkit RTK Query docs : hors scope du principe (couplé à Redux, cas trop spécifique)
    - React Query v3 docs : version obsolète, remplacée par TanStack Query v5
    - Articles arXiv sur les bugs async React : indirects — mesurent prévalence sans guidance prescriptive
    - Kent C. Dodds — blog posts Epic React : pertinents mais contenu absorbé par React docs + Rozen 2021
    - React docs 'You Might Not Need an Effect' : pertinent mais scope différent (éviter useEffect inutile,
      pas gérer correctement les useEffect nécessaires)
```

---

## Documentation recherche (Table 2 Kitchenham)

### Agent A — bases interrogées

| Élément | Valeur |
|---------|--------|
| Bases | react.dev, MDN Web Docs, tanstack.com, WebSearch général |
| Mots-clés | "React useEffect fetch race condition", "ignore flag cleanup useEffect", "AbortController React fetch cancel", "useTransition async React 18", "TanStack Query race conditions deduplicate" |
| Période couverte | 2021-2024 |
| Sources identifiées | ~22 |
| Sources retenues | 5 (React useEffect ×2, MDN AbortController, useTransition, TanStack Query) |
| Date d'extraction | 2026-04-17 |

### Agent B — bases interrogées

| Élément | Valeur |
|---------|--------|
| Bases | react.dev, maxrozen.com, WebSearch général |
| Mots-clés | "React useEffect setState unmounted component", "use hook React 19 Suspense Promise", "React Error Boundaries async limitations", "race condition useEffect fix", "Max Rozen React race condition fix" |
| Période couverte | 2021-2024 |
| Sources identifiées | ~23 |
| Sources retenues | 5 (React useEffect docs, use() React 19, Error Boundaries, Rozen 2021, convergence useEffect docs) |
| Date d'extraction | 2026-04-17 |

---

## Sources exclues — raisons documentées

| Source | Raison exclusion |
|--------|-----------------|
| SWR docs (Vercel, 2024) | Redondance fonctionnelle avec TanStack Query (stale-while-revalidate, déduplication). TanStack Query plus adopté et mieux documenté pour les patterns anti-race-condition. |
| Redux Toolkit RTK Query docs | Couplé à Redux — cas d'usage trop spécifique pour un principe universel React. Candidat pour un variant redux si besoin. |
| React Query v3 docs | Version obsolète. Contenu remplacé et étendu par TanStack Query v5 (2024). |
| Articles arXiv sur les bugs async React | Mesurent la prévalence des bugs async dans les codebases open source mais n'apportent pas de guidance prescriptive au-delà de ce que couvrent les docs officielles. |
| Kent C. Dodds — Epic React blog posts | Contenu correct et pédagogique mais entièrement absorbé par React docs officielles + Rozen 2021 (directement endorsé react.dev). |
| React docs 'You Might Not Need an Effect' | Scope différent — traite de quand éviter useEffect plutôt que comment gérer correctement les useEffect nécessaires (fetch async). Hors PICOC strict. |
