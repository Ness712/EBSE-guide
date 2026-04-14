# Donnees de test

**[BONNE PRATIQUE]** Factory pattern + Faker — jamais d'etat mutable partage entre tests | Score GRADE : 3/7

Chaque test doit creer ses propres donnees via des factories. Le partage d'etat mutable entre tests cause des tests flaky et des dependances d'ordre.

```java
// Java — builder pattern pour les donnees de test
public class UserFactory {
    public static User.UserBuilder aUser() {
        return User.builder()
            .name("Gabriel")
            .email("gabriel@test.fr")
            .role(Role.STUDENT);
    }
}
// Usage : UserFactory.aUser().name("Alice").build()
```

```typescript
// TypeScript — factory function + faker
import { faker } from '@faker-js/faker/locale/fr';

function createUser(overrides: Partial<User> = {}): User {
  return {
    id: faker.string.uuid(),
    name: faker.person.fullName(),
    email: faker.internet.email(),
    ...overrides,
  };
}
```

| Regle | Pourquoi | Source |
|-------|----------|--------|
| Un test = ses propres donnees | Pas de couplage, pas de flaky | Beck |
| Factory avec defaults + overrides | DRY, lisible, flexible | Convention industrielle |
| Faker pour donnees realistes | Detecte les bugs de format/encoding | faker-js docs |
| Jamais d'etat mutable partage | Independance des tests, parallelisable | Beck "isolated tests" |

Sources : Kent Beck — tests independants, etat isole (niv. 5), Fowler — Object Mother / Test Data Builder (niv. 5), faker-js docs — 47M/mois npm (niv. 4)
