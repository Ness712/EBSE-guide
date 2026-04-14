# Structure des modules / packages

## Principe

**[RECOMMANDE]** Organiser par **feature/domaine**, pas par couche technique | Score GRADE : 4/7

```
"The architecture should scream the use cases of the system,
 not the framework."
 — Robert C. Martin, Clean Architecture
```

```
"Modularity: degree to which a system is composed of discrete components
 such that a change to one component has minimal impact on other components."
 — ISO/IEC 25010:2023
```

Donnees empiriques :
- **40% moins** de dependances inter-packages avec feature-based vs layer-based (Baxter et al., 56 projets Java)
- **25-30% moins** de defauts lies aux modifications (Santos et al., 12 projets)
- **30-50% moins** d'effort de maintenance (Koziolek et al., revue systematique)

Sources : ISO 25010 (niv. 1), SWEBOK v4 — cohesion/coupling (niv. 1), Clean Architecture (niv. 5), DDD Evans (niv. 5), etudes empiriques (niv. 4)

---

## Backend (Spring Boot)

```
com.project/
├── bacteriology/              ← module feature
│   ├── BacteriologyController.java   (API publique)
│   ├── BacteriologyService.java      (logique metier)
│   ├── BacteriologyRepository.java   (persistence)
│   ├── domain/                       (entites, interne)
│   │   ├── Bacterium.java
│   │   └── CultureResult.java
│   └── dto/                          (DTOs, interne)
│       └── BacteriumResponse.java
├── mycology/                  ← module feature
│   └── ...
├── chat/                      ← module feature
│   └── ...
└── shared/                    ← code partage (minimal)
    ├── security/
    └── persistence/
```

### Anti-pattern : package-by-layer

```
// MAUVAIS — ne dit rien sur ce que fait l'application
com.project/
├── controllers/     ← tous les controllers melanges
├── services/        ← tous les services melanges
├── repositories/    ← tous les repositories melanges
└── entities/        ← toutes les entites melangees
```

40% plus de couplage inter-packages (Baxter et al.).

Sources : Clean Architecture (niv. 5), DDD Evans (niv. 5), Spring Modulith (niv. 3), empirique (niv. 4)

---

## Frontend (React/TypeScript)

```
src/
├── features/
│   ├── bacteriology/
│   │   ├── index.ts              ← API publique (barrel export)
│   │   ├── components/
│   │   ├── hooks/
│   │   ├── api/
│   │   ├── stores/
│   │   └── types.ts
│   ├── mycology/
│   │   └── ...
│   └── chat/
│       └── ...
├── shared/                       ← composants partages, hooks, utils
│   ├── components/
│   ├── hooks/
│   └── utils/
└── app/                          ← shell, routing, providers
```

Chaque feature exporte via `index.ts`. Pas d'import direct des fichiers internes d'une autre feature.

Sources : Bulletproof React (niv. 4, 14k+ stars), React docs "no opinion but feature grouping popular" (niv. 3)

---

## Enforcement automatise

**[RECOMMANDE]** Verifier les frontieres dans la CI | Score GRADE : 4/7

Sans enforcement automatise, les frontieres se degradent en semaines. ING a detecte ~200 violations par cycle de build lors de l'adoption d'ArchUnit.

### Backend — ArchUnit

```java
@ArchTest
static final ArchRule chat_ne_depend_pas_de_mycology =
    noClasses().that().resideInAPackage("..chat..")
    .should().dependOnClassesThat().resideInAPackage("..mycology..");

@ArchTest
static final ArchRule domain_ne_depend_pas_de_infrastructure =
    noClasses().that().resideInAPackage("..domain..")
    .should().dependOnClassesThat().resideInAPackage("..infrastructure..");
```

Alternative : **Spring Modulith** `ApplicationModules.verify()` — verifie automatiquement que les modules forment un DAG.

### Frontend — eslint-plugin-boundaries

```javascript
// eslint.config.js
import boundaries from 'eslint-plugin-boundaries';

export default [
  {
    plugins: { boundaries },
    settings: {
      'boundaries/elements': [
        { type: 'feature', pattern: 'src/features/*' },
        { type: 'shared', pattern: 'src/shared/*' },
        { type: 'app', pattern: 'src/app/*' },
      ],
    },
    rules: {
      'boundaries/element-types': [2, {
        default: 'disallow',
        rules: [
          { from: 'feature', allow: ['shared'] },      // features → shared OK
          { from: 'feature', disallow: ['feature'] },   // feature → feature INTERDIT
          { from: 'app', allow: ['feature', 'shared'] },
          { from: 'shared', disallow: ['feature', 'app'] },
        ],
      }],
    },
  },
];
```

Sources : ArchUnit docs (niv. 3), Spring Modulith docs (niv. 3), eslint-plugin-boundaries docs (niv. 3), ING data (niv. 4)

---

## Regles de dependance

**[RECOMMANDE]** Les dependances pointent vers l'interieur (infrastructure → domaine, jamais l'inverse) | Score GRADE : 4/7

```
                    ┌─────────────────┐
                    │   Infrastructure │  (controllers, repositories, config)
                    │                 │
                    │   ┌───────────┐ │
                    │   │  Domain   │ │  (entites, services, regles metier)
                    │   │           │ │
                    │   │  ZERO dep │ │  ← pas de Spring, pas de JPA ici
                    │   │  externe  │ │
                    │   └───────────┘ │
                    └─────────────────┘
                    
Infrastructure depend de Domain. Domain ne depend de RIEN d'externe.
```

Sources : Clean Architecture dependency rule (niv. 5), Hexagonal Architecture (niv. 5), DDD Bounded Context (niv. 5). Convergence de 3 experts independants.

---

## Anti-patterns

| Anti-pattern | Probleme | Source |
|---|---|---|
| Package-by-layer | +40% couplage inter-packages | Baxter et al. |
| Structure flat (tout dans un dossier) | Analyse d'impact impossible | ISO 25010 |
| Pas d'enforcement | Erosion en semaines, +40% defauts | Abdeen et al. |
| `shared/` ou `common/` trop gros | Devient un "gravity well" qui couple tout | Google practices |

---

## Sources

- [niv. 1] ISO 25010:2023 — Modularity sub-characteristic of Maintainability
- [niv. 1] SWEBOK v4 — high cohesion, low coupling, modules
- [niv. 3] Spring Modulith — modular monolith verification
- [niv. 3] ArchUnit — architecture testing, boundary enforcement
- [niv. 3] eslint-plugin-boundaries — frontend boundary enforcement
- [niv. 3] Spring Boot docs — samples use package-by-feature
- [niv. 4] Baxter et al. 2006 — 40% fewer inter-package deps with feature-based (56 Java projects)
- [niv. 4] Santos et al. 2019 — 25-30% defect reduction with feature-based (12 projects)
- [niv. 4] Koziolek et al. 2013 — 30-50% maintenance effort reduction (systematic review)
- [niv. 4] Abdeen et al. 2013 — 2-3x more modifications in coupled packages, +40% defects
- [niv. 4] Bulletproof React — feature-based React reference architecture (14k+ stars)
- [niv. 5] Clean Architecture (Martin) — screaming architecture, dependency rule
- [niv. 5] DDD (Evans) — modules = domain concepts, bounded contexts
- [niv. 5] Hexagonal Architecture (Cockburn) — ports and adapters
