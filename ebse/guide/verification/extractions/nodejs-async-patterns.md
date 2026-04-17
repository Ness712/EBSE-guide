# Double Extraction — PICOC nodejs-async-patterns

**Date** : 2026-04-17
**Protocole** : methodology.md v3.0
**Agent A** : mots-cles : "nodejs event loop blocking async", "promise rejection unhandled nodejs", "AbortController signal fetch cancellation", "nodejs streams backpressure pipeline", "JavaScript Promises introduction patterns"
**Agent B** : mots-cles : "NestJS async providers lifecycle hooks", "Promise.allSettled vs Promise.all comparison", "nodejs memory leak AbortController race", "async iteration for-await-of generators nodejs", "nodebestpractices async error handling"

---

## PICOC

```
P  = Equipes developpant des applications Node.js/NestJS avec operations asynchrones
I  = Appliquer les patterns async appropries : Promise.all/allSettled/race,
     AbortController, event loop awareness, backpressure, async iteration
C  = Code synchrone bloquant, callbacks non-geres, rejection unhandled,
     race conditions, memory leaks sur operations annulables
O  = Fiabilite, faultlessness, absence de race conditions et memory leaks,
     event loop non-bloque
Co = Projets NestJS TypeScript avec operations I/O concurrentes
     (API calls, DB queries, fichiers)
```

---

## Accord Reviewer A / Reviewer B

### Sources evaluees par les deux reviewers

| # | Source | Niveau A | Niveau B | Accord inclusion ? | Note divergence |
|---|--------|---------|---------|:-----------------:|-----------------|
| 1 | Node.js Docs — The Node.js Event Loop (nodejs.org) | 3 | 3 | ✓ | — |
| 2 | Node.js Docs — async_hooks API (nodejs.org, v18+) | 3 | 3 | ✓ | — |
| 3 | MDN Web Docs — AbortController / AbortSignal | 3 | 3 | ✓ | — |
| 4 | Node.js Docs — Backpressuring in Streams | 3 | 3 | ✓ | — |
| 5 | MDN Web Docs — Promise.all / allSettled / race / any | 3 | 3 | ✓ | — |
| 6 | DZone — Handling Unhandled Promise Rejections in Node.js (2023) | 5 | non trouve | ✗ B / ✓ A | **Divergence inclusion** |
| 7 | Archibald J. — JavaScript Promises: an Introduction (web.dev, Google, 2021) | 5 | non trouve | ✗ B / ✓ A | **Divergence inclusion** |
| 8 | NestJS Docs — Async Providers (docs.nestjs.com, 2024) | non trouve | 3 | ✗ A / ✓ B | **Divergence inclusion** |
| 9 | NestJS Docs — Lifecycle Events (docs.nestjs.com, 2024) | non trouve | 3 | ✗ A / ✓ B | **Divergence inclusion** |
| 10 | Goldberg Y. — nodebestpractices (GitHub, 99k+ stars, 2024) | non trouve | 5 | ✗ A / ✓ B | **Divergence inclusion** |
| 11 | Node.js GitHub Issue #6673 — Memory leak Promise.race + AbortController | non trouve | 3 | ✗ A / ✓ B | **Divergence inclusion** |
| 12 | Rauschmayer A. — JavaScript for impatient programmers, ch. Async Iteration (2022) | non trouve | 5 | ✗ A / ✓ B | **Divergence inclusion** |

**Sources identifiees par A uniquement** : DZone 2023 (unhandledRejection), Archibald 2021 (web.dev Google)
**Sources identifiees par B uniquement** : NestJS Async Providers, NestJS Lifecycle Events, nodebestpractices, Node.js Issue #6673, Rauschmayer 2022

**Accord sur inclusion des sources communes** : 5/5 → kappa = 1.0 (sources communes)
**Desaccords d'inclusion** : 7/12 → toutes resolues en faveur de l'inclusion (voir resolution ci-dessous)

### Resolution des divergences

**DZone 2023 (A seulement, niveau 5)** : inclus. Blog expert couvrant un pattern critique (process.on('unhandledRejection')) qui n'est pas traite explicitement par les sources niveau 3 du corpus. Inclus comme support illustratif pour un comportement important du runtime. Non trouve par B car ses mots-cles etaient orientes NestJS/framework plutot que Node.js core runtime.

**Archibald 2021 (A seulement, niveau 5)** : inclus. Reference pedagogique de fait publiee sur web.dev (Google). Articule les pieges classiques des Promises (rejections silencieuses, chaining gotchas) qui sont des sources frequentes de bugs. Non trouve par B car ses mots-cles privilegiaient les sources framework et les comparaisons Promise.

**NestJS Async Providers (B seulement, niveau 3)** : inclus. Documentation officielle NestJS, directement pertinente pour le contexte du PICOC (NestJS TypeScript). Couvre useFactory async pour les initialisations differees. Non trouve par A car ses mots-cles etaient orientes Node.js core plutot que framework NestJS.

**NestJS Lifecycle Events (B seulement, niveau 3)** : inclus. Documentation officielle NestJS pour onModuleInit/onModuleDestroy. Fondamentale pour le cleanup des ressources asynchrones lors du shutdown graceful — directement actionnable dans le contexte NestJS. Non trouve par A pour la meme raison que NestJS Async Providers.

**nodebestpractices (B seulement, niveau 5)** : inclus. 99k+ stars GitHub, communautaire peer-reviewed. Converge avec les sources niveau 3 sur la gestion d'erreurs async et ajoute des regles pratiques concretes. Non trouve par A car ses mots-cles n'interrogeaient pas les ressources communautaires GitHub.

**Node.js GitHub Issue #6673 (B seulement, niveau 3)** : inclus. Issue officielle du repo Node.js documentant un piege concret de memory leak avec Promise.race + AbortController non annule. Apporte une preuve empirique d'un bug reel dans le runtime — pertinence directe pour la pratique documentee. Non trouve par A car ses mots-cles n'incluaient pas les issues GitHub du runtime.

**Rauschmayer 2022 (B seulement, niveau 5)** : inclus. Livre de reference sur JavaScript moderne (exploringjs.com). Couvre for-await-of et les async generators — pattern non couvert par les autres sources du corpus. Non trouve par A car ses mots-cles ne ciblaient pas l'async iteration specifiquement.

**Decision de convergence** : toutes les sources sont complementaires — elles couvrent des aspects distincts (event loop core, NestJS lifecycle, combinateurs Promise, memory leaks, streams, async iteration) sans redondance substantielle. Toutes incluses.

---

## Calcul GRADE final

```
Score de depart : 2
  (source la plus haute = niveau 3 : Node.js Official Documentation,
  NestJS Official Documentation, MDN / W3C, Node.js GitHub Issues)
  Note : il n'existe pas de norme ISO/RFC specifique aux patterns async
  Node.js. Le niveau 3 est le plafond realiste pour ce PICOC.

+ 1 convergence
  Node.js Event Loop docs + async_hooks + AbortController MDN +
  NestJS Lifecycle Events + MDN Promise methods + nodebestpractices +
  Rauschmayer + Archibald convergent sans contradiction sur les
  principes fondamentaux :
  - Ne jamais bloquer l'event loop (toutes sources Node.js)
  - Toujours gerer les rejections (Archibald, nodebestpractices, DZone)
  - AbortController pour l'annulation propre (MDN, Issue #6673)
  - allSettled > all pour operations independantes (MDN)
  - Backpressure via pipeline() (Node.js Streams docs)
  Sources independantes : runtime Node.js (mozilla.org/nodejs.org),
  framework NestJS (docs.nestjs.com), W3C (via MDN),
  communaute (nodebestpractices), experts independants.

+ 1 effet important (nuance : pas d'etude empirique RCT, mais
  documentation de bugs reels)
  Node.js Issue #6673 : memory leak documente et confirme dans le
  runtime officiel. nodebestpractices : blocage event loop = 100%
  throughput loss. Documentation de defauts reels (pas simulations).
  Magnitude importante mais sans mesure quantitative experimentale
  controlee — +1 justifie par la severite des consequences documentees.

- 1 indirectness
  Absence d'etudes empiriques peer-reviewed comparant systematiquement
  ces patterns sur des codebases NestJS en production. Pas de systematic
  review ni de RCT. La preuve est principalement documentaire et
  normative — forte pour les comportements du runtime, mais sans
  validation experimentale independante de l'impact sur des projets reels.

Score final : 2 + 1 + 1 - 1 = 3 → [RECOMMANDE], robustesse MODERE
```

Note biais de publication : documentation officielle (Node.js, NestJS, MDN) non soumise au biais de publication classique mais potentiellement biaisee vers la mise en valeur des fonctionnalites du runtime. nodebestpractices est communautaire avec processus de revue par les pairs (PR review sur GitHub). Blogs (DZone, Archibald web.dev) : biais possible vers le prescriptif — attenué par la confirmation des sources officielles. Issue #6673 : biais nul (rapport de bug factuel).

---

## Analyse de sensibilite {#analyse-de-sensibilite}

| Source retiree | Score sans | Niveau sans | Changement ? |
|---------------|-----------|------------|:------------:|
| Node.js Event Loop docs | 2 (autres sources niv.3 maintiennent le depart, +1 convergence, +1 effet, -1 indirect) | [RECOMMANDE] | NON — les autres sources niv.3 maintiennent le score |
| async_hooks docs | 3 (source de support, pas critique pour le calcul) | [RECOMMANDE] | NON |
| MDN AbortController | 2 (convergence partiellement reduite, Issue #6673 couvre le meme sujet) | [RECOMMANDE] | NON |
| Node.js Issue #6673 | 2+1+0-1=2 (perte du +1 effet si cette source est la seule preuve de bugs reels — mais nodebestpractices maintient partiellement le +1) | [BONNE PRATIQUE] | OUI — perte potentielle du +1 effet selon interpretation |
| NestJS Docs (Async Providers + Lifecycle) | 3 (convergence maintenue par autres sources, reduction de pertinence contexte NestJS) | [RECOMMANDE] | NON — mais perte de specifique NestJS |
| nodebestpractices | 3 (autres sources couvrent les memes pratiques) | [RECOMMANDE] | NON |
| Archibald 2021 | 3 (DZone 2023 couvre partiellement les memes pieges) | [RECOMMANDE] | NON |
| DZone 2023 | 3 (nodebestpractices couvre les memes pratiques error handling) | [RECOMMANDE] | NON |
| Rauschmayer 2022 | 3 (perte du pattern async iteration, mais reste dans le score) | [RECOMMANDE] | NON |
| Toutes sources niveau 5 simultanément | 2+1+1-1=3 (sources niv.3 maintiennent tout le calcul) | [RECOMMANDE] | NON |

**Conclusion : MODERE** — recommandation [RECOMMANDE] stable pour la quasi-totalite des retraits individuels. Le seul scenario de changement plausible est le retrait de Node.js Issue #6673 combine a une interpretation stricte du +1 effet (si nodebestpractices est juge insuffisant pour maintenir le +1). Ce scenario est improbable car nodebestpractices documente independamment l'impact du blocage d'event loop. La robustesse MODERE (plutot que ROBUSTE) reflete l'absence d'etudes empiriques peer-reviewed — la preuve repose sur la documentation officielle et l'expertise communautaire, ce qui est adapte a ce domaine mais reste une limitation structurelle du corpus.

---

## Sources exclues

| Source | Critere | Raison |
|--------|---------|--------|
| Medium — "Understanding Promises in JavaScript" (multiple auteurs, 2021-2023) | E2 | Blogs individuels sans peer review. Contenu absorbe par Archibald 2021 (web.dev Google, meme sujet, source plus authoritative) et MDN. |
| Bluebird Promise Library Documentation | E3 | Documentation d'une librairie tierce deprecant les Promises natives. Node.js 12+ rend Bluebird obsolete pour les cas d'usage couverts par ce PICOC. |
| Node.js Documentation — Worker Threads API | E5 partiel | Pertinent pour le principe "ne pas bloquer l'event loop" mais traite l'implementation (worker_threads) plutot que le pattern de decision. Principe couvert par Node.js Event Loop docs qui inclut la reference aux worker_threads comme solution. |
