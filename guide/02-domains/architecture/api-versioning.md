# Versioning d'API

**[BONNE PRATIQUE]** Versioning par URL path (`/api/v1/`) pour la simplicite | Score GRADE : 3/7

Le versioning permet de faire evoluer l'API sans casser les clients existants. La methode par URL path est la plus simple et la plus repandue.

## Comparatif des strategies

| Strategie | Exemple | Avantage | Inconvenient |
|-----------|---------|----------|-------------|
| **URL path** | `/api/v1/users` | Simple, visible, cacheable | "Pas RESTful" selon les puristes |
| Header | `Accept: application/vnd.api+json;v=2` | Propre semantiquement | Invisible, debug difficile |
| Query param | `/api/users?version=1` | Simple | Pollution de l'URL |

**Recommandation** : URL path versioning. C'est le standard de facto utilise par GitHub, Stripe, Google Cloud.

## Implementation Spring Boot

```java
// V1
@RestController
@RequestMapping("/api/v1/users")
public class UserControllerV1 {
    @GetMapping("/{id}")
    public ResponseEntity<UserResponseV1> getUser(@PathVariable Long id) {
        return ResponseEntity.ok(userService.findByIdV1(id));
    }
}

// V2 — nouveau format de reponse
@RestController
@RequestMapping("/api/v2/users")
public class UserControllerV2 {
    @GetMapping("/{id}")
    public ResponseEntity<UserResponseV2> getUser(@PathVariable Long id) {
        return ResponseEntity.ok(userService.findByIdV2(id));
    }
}
```

## Regles

| Regle | Raison |
|-------|--------|
| Incrementer la version pour les breaking changes uniquement | Ajout de champ = non-breaking, suppression = breaking |
| Supporter N-1 pendant au moins 6 mois | Laisser le temps aux clients de migrer |
| Deprecation header sur l'ancienne version | `Sunset: Sat, 01 Jan 2027 00:00:00 GMT` |

## Sources

- [niv. 3] GitHub API — URL path versioning (`/v3/`), reference industrielle
- [niv. 3] Spring Boot docs — @RequestMapping path-based versioning
- [niv. 5] Stripe API — URL versioning avec dates, backwards compatibility guarantee
