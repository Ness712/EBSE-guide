# Tests unitaires

## Strategie

**[STANDARD]** Suivre la **pyramide de tests** : beaucoup de tests unitaires, quelques tests d'integration, peu de tests E2E | Score GRADE : 5/7

```
        /\
       /  \         Peu de tests E2E (Playwright)
      /----\
     /      \       Quelques tests d'integration
    /--------\      (Testcontainers, @WebMvcTest)
   /          \
  /____________\    Beaucoup de tests unitaires
                    (JUnit, Vitest)
```

Ratio recommande : **70% unit / 20% integration / 10% E2E** (Google Testing Blog)

| Principe | Source |
|----------|--------|
| "Write lots of small and fast unit tests" | Fowler, Practical Test Pyramid |
| "Push tests as far down the pyramid as you can" | Fowler |
| "Tests should minimize programmer waiting" — sub-seconde | Kent Beck |
| "Test for observable behaviour, not implementation details" | Fowler, Beck |
| "Before fixing a bug from a high-level test, replicate with a unit test" | Fowler |

Sources : SWEBOK v4 (niv. 1), ISTQB (niv. 2), Google Testing Blog (niv. 5), Fowler (niv. 5), Beck (niv. 5)

---

## Framework — Java (Spring Boot)

**[RECOMMANDE]** **JUnit 5** (Jupiter) | Score GRADE : 5/7

Defaut de Spring Boot. Inclus dans `spring-boot-starter-test`. Aucune configuration necessaire.

```xml
<!-- Deja inclus dans spring-boot-starter-test -->
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-test</artifactId>
    <scope>test</scope>
</dependency>
```

Ce que `spring-boot-starter-test` inclut :
- **JUnit 5** (Jupiter) — framework de test
- **AssertJ** — assertions fluides
- **Hamcrest** — matchers (legacy)
- **Mockito** — mocking
- **JSONassert** + **JsonPath** — assertions JSON

### Pourquoi pas les autres ?

| Alternative | Verdict |
|-------------|---------|
| TestNG | Pas mentionne dans les docs Spring Boot, 35% usage concentre en QA/Selenium enterprise |
| Spock | 0.27% market share (~55 entreprises), necessite Groovy |

Sources : Spring Boot docs (niv. 3), JetBrains survey — JUnit 5 dominant (niv. 4), Maven Central ~80% market share (niv. 4)

---

## Assertions — Java

**[RECOMMANDE]** **AssertJ** | Score GRADE : 5/7

Inclus dans `spring-boot-starter-test`. Utilise dans tous les exemples officiels Spring Boot.

```java
// AssertJ — fluide, lisible, erreurs claires
assertThat(user.getName()).isEqualTo("Gabriel");
assertThat(users).hasSize(3).extracting("email").contains("g@ols.fr");

// Hamcrest — moins lisible (legacy)
assertThat(user.getName(), is("Gabriel"));
```

Source : Spring Boot docs utilise AssertJ dans tous les exemples (niv. 3), etude academique confirme meilleure lisibilite (niv. 5)

---

## Framework — JavaScript/TypeScript (Vite + React)

**[RECOMMANDE]** **Vitest** | Score GRADE : 4/7

Le framework de test natif de l'ecosysteme Vite. Partage `vite.config.ts` — zero config supplementaire.

```typescript
// vitest.config.ts — partage automatiquement vite.config.ts
import { defineConfig } from 'vitest/config';

export default defineConfig({
  test: {
    environment: 'happy-dom',
    globals: true,
    coverage: {
      provider: 'v8',
      reporter: ['text', 'lcov'],
    },
  },
});
```

```typescript
// exemple de test
import { render, screen } from '@testing-library/react';
import { UserCard } from './UserCard';

test('affiche le nom utilisateur', () => {
  render(<UserCard name="Gabriel" />);
  expect(screen.getByText('Gabriel')).toBeInTheDocument();
});
```

### Pourquoi pas les autres ?

| Alternative | Verdict |
|-------------|---------|
| Jest | #1 en adoption (172M/mois) mais satisfaction en baisse, ESM experimental, ne partage pas vite.config |
| Mocha + Chai | En declin (53M/mois), necessite config separee pour assertions |
| node:test | Bon pour Node.js pur, pas d'integration Vite/React |

Sources : Vite utilise Vitest pour ses propres tests (niv. 3), State of JS 2024-2025 — Vitest #1 satisfaction 90%+ (niv. 4), npm 82M/mois et croissance 3.5x en 2 ans (niv. 4)

---

## Coverage

**[BONNE PRATIQUE]** **75% projet, 90% nouveau code** | Score GRADE : 2/7

| Seuil | Valeur | Source |
|-------|--------|--------|
| Projet entier — acceptable | 60% | Google Testing Blog |
| Projet entier — recommande | 75% | Google Testing Blog |
| Projet entier — exemplaire | 90% | Google Testing Blog |
| Nouveau code (par commit) | 90% minimum | Google Testing Blog |
| Rendements decroissants | au-dela de 80% | Google + Bullseye + Dodds |

```
"We should not be obsessing on how to get from 90% to 95%.
 The gains of increasing code coverage beyond a certain point
 are logarithmic." — Google Testing Blog
```

```
"Even 100% coverage is estimated to only expose about half
 the faults in a system." — Bullseye (avec citations empiriques)
```

**Outils** :
- Java : **JaCoCo** (standard industriel)
- JS/TS : **v8 coverage** (natif Vitest) ou Istanbul

**[CHOIX D'EQUIPE]** pour les seuils exacts — aucun standard international ne prescrit un chiffre.

Sources : Google Testing Blog (niv. 5), Bullseye avec citations empiriques (niv. 5), Kent C. Dodds ~70% (niv. 5). Aucun standard ISO/IEEE ne prescrit de seuil.

---

## Bonnes pratiques

| Pratique | Source |
|----------|--------|
| Tester le comportement observable, pas l'implementation | Fowler, Beck |
| Un test = une assertion logique | Convention industrielle |
| Noms de tests descriptifs (given/when/then ou should) | Convention industrielle |
| Tests sub-seconde | Beck : "minimize programmer waiting" |
| Supprimer les tests flaky | Beck : "run reliably"; Facebook : "simply deleting non-deterministic tests" |
| Le code de test a la meme qualite que le code de prod | Fowler : "give it the same level of care" |

---

## Sources

- [niv. 1] SWEBOK v4 Section 5.3 — unit testing prescribed, automated frameworks recommended
- [niv. 1] ISO 25010:2023 — Testability sub-characteristic of Maintainability
- [niv. 2] ISTQB CTFL v4.0 — component testing definition
- [niv. 3] Spring Boot docs — JUnit 5 + AssertJ + Mockito bundled by default
- [niv. 3] Vitest docs — Vite-native, Jest-compatible API, shared config
- [niv. 3] Vite blog — Vite itself migrated to Vitest
- [niv. 3] React Testing Library — supports Vitest with dedicated docs
- [niv. 4] State of JS 2024/2025 — Vitest #1 satisfaction, +14pp YoY growth
- [niv. 4] JetBrains 2024 — Jest 63%, Vitest 29% (growing), JUnit 5 dominant Java
- [niv. 4] npm trends — Jest 172M/mo, Vitest 82M/mo (3.5x growth in 2 years)
- [niv. 5] Google Testing Blog — 70/20/10 pyramid, 60/75/90% coverage tiers
- [niv. 5] Fowler — test pyramid, test observable behaviour
- [niv. 5] Kent Beck — 8 properties of good tests, sub-second, reliable
