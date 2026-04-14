# Null Safety

**[RECOMMANDE]** Eliminer les null non controles avec Optional (Java) et strict null checks (TS) | Score GRADE : 5/7

`NullPointerException` est la premiere cause de bugs en Java. `TypeError: Cannot read properties of undefined` est l'erreur #1 en JavaScript.

## Java : Optional

```java
// BON — intention claire, force le traitement du cas absent
public Optional<User> findByEmail(String email) {
    return userRepository.findByEmail(email);
}

// Utilisation
User user = userService.findByEmail(email)
    .orElseThrow(() -> new NotFoundException("User not found"));

// MAUVAIS — null implicite, NPE garanti tot ou tard
public User findByEmail(String email) {
    return userRepository.findByEmail(email); // peut retourner null
}
```

| Regle | Raison |
|-------|--------|
| Retourner `Optional` pour les valeurs potentiellement absentes | Rend l'absence explicite |
| Ne jamais passer `Optional` en parametre | Anti-pattern (Java docs) |
| Ne jamais appeler `.get()` sans `.isPresent()` | Equivalent d'un NPE |

## TypeScript : strictNullChecks + nullish coalescing

```typescript
// tsconfig.json : "strictNullChecks": true (inclus dans "strict": true)

// Nullish coalescing — valeur par defaut
const name = user.displayName ?? 'Anonyme';

// Optional chaining — acces securise
const city = user.address?.city;

// MAUVAIS — || traite 0 et "" comme falsy
const count = response.count || 10; // bug si count === 0
```

## Sources

- [niv. 3] Java 17+ docs — Optional API, "primarily intended for method return types"
- [niv. 3] TypeScript docs — strictNullChecks, nullish coalescing operator
- [niv. 5] Effective Java (Bloch) Item 55 — "return Optional instead of null"
