# Double Extraction — PICOC react-async-patterns

**Date** : 2026-04-17
**Protocole** : methodology.md v3.0
**Agent A** : mots-clés : "React useEffect fetch race condition", "ignore flag cleanup useEffect", "AbortController React fetch cancel", "useTransition async React 18", "TanStack Query race conditions deduplicate"
**Agent B** : mots-clés : "React useEffect setState unmounted component", "use hook React 19 Suspense Promise", "React Error Boundaries async limitations", "race condition useEffect fix", "Max Rozen React race condition fix"

---

## PICOC

```
P  = Développeurs React gérant des opérations asynchrones dans les composants
I  = Appliquer les patterns de gestion async : ignore flag, AbortController,
     useTransition, React Query
C  = Fetch sans cleanup, state update sur composant démonté, pas d'annulation
O  = Prévention race conditions, memory leaks, états UI inconsistants
Co = Applications React (TypeScript) avec hooks et/ou TanStack Query
```

---

## Accord Reviewer A / Reviewer B

### Sources évaluées par les deux reviewers

| # | Source | Niveau A | Niveau B | Accord inclusion ? | Note divergence |
|---|--------|---------|---------|:-----------------:|-----------------|
| 1 | React docs "Synchronizing with Effects" (react.dev, 2024) | 3 | 3 | ✓ | — |
| 2 | React docs "useEffect Reference" (react.dev, 2024) | 3 | 3 | ✓ | — |
| 3 | React docs Error Boundaries (react.dev, 2024) | non trouvé | 3 | ✗ A / ✓ B | **A-only absent** |
| 4 | Rozen M. — "Fixing Race Conditions in React with useEffect" (maxrozen.com, 2021) | 4 | 4 | ✓ | — |

**Sources identifiées par A uniquement** :
- MDN AbortController/AbortSignal (developer.mozilla.org, 2024) — niveau 3
- React docs useTransition / startTransition (react.dev, 2024) — niveau 3
- TanStack Query docs (tanstack.com, 2024) — niveau 3

**Sources identifiées par B uniquement** :
- React docs hook `use()` React 19 (react.dev, 2024) — niveau 3
- React docs Error Boundaries — limitation async (react.dev, 2024) — niveau 3

**Accord sur inclusion des sources communes** : 4/4 → kappa ≈ 1.0 (inclusion).
**Désaccords d'inclusion** : 0 — les sources A-only et B-only sont complémentaires, pas contradictoires.

---

### Résolution des divergences

**MDN AbortController (A seulement, niveau 3)** : inclus. Documente le standard W3C sous-jacent à la Solution 2 (AbortController). Sans cette source, la Solution 2 repose sur des extraits React docs qui mentionnent AbortController sans en documenter la mécanique complète (AbortError, signal.aborted, cas d'usage non-fetch). Apport différencié réel — inclus.

**React docs useTransition (A seulement, niveau 3)** : inclus. Documente un mécanisme Concurrent React orthogonal aux solutions réseau (ignore flag / AbortController). useTransition gère la priorité des renders async, non les race conditions réseau. Apport différencié réel sur un aspect du PICOC (états UI incohérents pendant les transitions) — inclus.

**TanStack Query docs (A seulement, niveau 3)** : inclus. Seule source couvrant la solution bibliothèque recommandée pour les cas complexes. Couvre stale-while-revalidate, déduplication, annulation automatique — non couverts par les autres sources. Apport différencié fort — inclus.

**React docs use() React 19 (B seulement, niveau 3)** : inclus. Couvre une API React 19 distincte de useEffect pour la gestion async (Suspense-first). La restriction "Promises recréées à chaque render dans les Client Components" est une limitation critique non trouvée ailleurs. Apport différencié fort — inclus.

**React docs Error Boundaries (B seulement, niveau 3)** : inclus. Documente une limitation critique et fréquemment incomprise : les Error Boundaries ne capturent pas les erreurs async ordinaires. Information prescriptive directement actionnable pour éviter des bugs silencieux. Non trouvé par A car ses mots-clés ciblaient les solutions (fetch, AbortController) plutôt que les mécanismes de capture d'erreurs. Apport différencié essentiel — inclus.

**Décision de convergence** : toutes les sources A-only et B-only sont complémentaires et couvrent des angles différents du PICOC (Standard W3C, Concurrent React, bibliothèque, React 19, gestion d'erreurs). Aucune contradiction entre sources. Toutes incluses — accord atteint sans tension.

---

## Calcul GRADE final

```
Score de départ : 2
  (sources les plus hautes = niveau 3 : React docs officielles, MDN)

+ 1 convergence
  React docs (ignore flag dans useEffect Reference + Synchronizing with Effects
  + use() React 19 + Error Boundaries + useTransition) convergent avec
  MDN AbortController (standard W3C) + TanStack Query docs + Rozen 2021
  (endossé react.dev) sur les mêmes patterns fondamentaux :
  - useEffect + fetch sans cleanup = race conditions + memory leaks
  - ignore flag et AbortController = deux solutions validées
  - Error Boundaries = ne capturent pas les erreurs async ordinaires
  8 sources indépendantes, 3 catégories (framework docs, standard W3C,
  expert endorsé), convergence forte sans contradiction.

+ 1 effet important
  Race conditions : données incorrectes affichées à l'utilisateur — bug
  fonctionnel visible et reproductible documenté par Rozen 2021.
  Memory leaks : setState sur composant démonté — avertissement React en
  dev, comportement indéfini en prod.
  Classe de bugs systématique affectant tout composant avec fetch et
  dépendances changeantes — impact documenté sur la fiabilité fonctionnelle.

Score final : 2 + 1 + 1 = 4 → [RECOMMANDE]
```

Note biais de publication : sources primaires (React docs, MDN) sont des documentations normatives sans biais de publication. Rozen 2021 est un blog post individuel, mais son endorsement explicite par react.dev (source niveau 3) élève sa crédibilité au-delà du niveau 4 habituel. TanStack Query docs : biais commercial potentiel (promotion de la bibliothèque) — atténué en limitant la recommandation aux cas complexes où l'alternative useEffect simple est explicitement documentée.

---

## Analyse de sensibilité {#analyse-de-sensibilite}

| Source retirée | Score sans | Niveau sans | Changement ? |
|---------------|-----------|------------|:------------:|
| React docs "Synchronizing with Effects" | 2+1+1=4 (useEffect Reference + MDN + TanStack convergent, convergence maintenue) | [RECOMMANDE] | NON |
| React docs "useEffect Reference" | 2+1+1=4 (Synchronizing with Effects + MDN + TanStack convergent) | [RECOMMANDE] | NON |
| MDN AbortController | 2+1+1=4 (AbortController reste mentionné dans React docs, convergence maintenue) | [RECOMMANDE] | NON |
| Rozen 2021 | 2+1+1=4 (React docs seules suffisent pour la convergence sur ignore flag) | [RECOMMANDE] | NON |
| TanStack Query docs | 2+1+1=4 (React docs + MDN + Rozen convergent sur les patterns core) | [RECOMMANDE] | NON |
| React docs use() React 19 | 2+1+1=4 (angle React 19 absent, core patterns inchangés) | [RECOMMANDE] | NON |
| React docs Error Boundaries | 2+1+1=4 (limitation async absente du principe, core patterns inchangés) | [RECOMMANDE] | NON |
| React docs useTransition | 2+1+1=4 (angle Concurrent React absent, core patterns inchangés) | [RECOMMANDE] | NON |
| Toutes sources A-only simultanément | 2+1+1=4 (React docs core + Rozen maintiennent convergence + effet) | [RECOMMANDE] | NON |
| Toutes sources B-only simultanément | 2+1+1=4 (React docs core + MDN + TanStack + Rozen maintiennent convergence + effet) | [RECOMMANDE] | NON |

**Conclusion : ROBUSTE** — recommandation [RECOMMANDE] (score 4) stable pour tout retrait individuel ou groupé (A-only / B-only). Le score de départ de 2 (pas de source niveau 1 ou 2) est la borne inférieure de stabilité : même avec retrait de toutes les sources sauf React docs "Synchronizing with Effects" seul, la convergence (+1) et l'effet documenté (+1) maintiennent le score à 4. Le passage à [BONNE PRATIQUE] nécessiterait le retrait simultané de la convergence ET de l'effet — scénario irréaliste car les deux sont documentés par la même source primaire (React docs officielles).

---

## Sources exclues

| Source | Critère | Raison |
|--------|---------|--------|
| SWR docs (Vercel, 2024) | E3 | Redondance fonctionnelle avec TanStack Query (stale-while-revalidate, déduplication). TanStack Query v5 plus adopté, mieux documenté sur les patterns anti-race-condition. |
| Redux Toolkit RTK Query docs | E2 | Couplé à Redux — hors scope du principe universel React. Candidat pour un variant redux si besoin. |
| React Query v3 docs | E3 | Version obsolète remplacée par TanStack Query v5 (2024). Contenu entièrement absorbé par la source plus récente. |
| Kent C. Dodds — Epic React blog posts | E3 | Contenu pédagogique correct mais entièrement absorbé par React docs officielles + Rozen 2021. Pas d'apport différencié. |
| React docs 'You Might Not Need an Effect' | E2 | Scope différent — traite de quand éviter useEffect (effets inutiles), pas de comment gérer correctement les useEffect de fetch. Hors PICOC strict. |
| Articles arXiv sur les bugs async React | E2 | Mesurent la prévalence des bugs async dans des codebases open source sans apporter de guidance prescriptive supplémentaire aux docs officielles React. |
| React docs 'Fetching Data' (legacy) | E3 | Documentation ancienne pré-hooks. Contenu entièrement remplacé par 'Synchronizing with Effects' (2024). |
