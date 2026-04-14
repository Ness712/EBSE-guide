# Protocole d'API

**[RECOMMANDE]** **REST** comme protocole par defaut pour les web apps | Score GRADE : 4/7

## Comparatif

| Critere | REST | GraphQL | gRPC |
|---------|------|---------|------|
| Cas d'usage | Web apps generales | Donnees imbriquees complexes | Microservices internes |
| Format | JSON (texte) | JSON (texte) | Protobuf (binaire) |
| Contrat | OpenAPI/Swagger | Schema SDL | .proto |
| Caching | HTTP natif (CDN, ETag) | Complexe (pas de GET) | Non standard |
| Tooling navigateur | Natif (fetch) | Client necessaire (Apollo) | Pas supporte |
| Adoption | 90%+ des APIs web | ~14% (Postman 2024) | ~11% (Postman 2024) |
| Courbe apprentissage | Faible | Moyenne | Elevee |

## Quand utiliser quoi ?

| Situation | Choix |
|-----------|-------|
| API web standard (CRUD) | **REST** |
| Frontend avec donnees imbriquees variables | GraphQL |
| Communication inter-services haute performance | gRPC |
| API publique | REST (universel) |

## Implementation Spring Boot (REST)

```java
@RestController
@RequestMapping("/api/v1/users")
public class UserController {
    @GetMapping("/{id}")
    public ResponseEntity<UserResponse> getUser(@PathVariable Long id) {
        return ResponseEntity.ok(userService.findById(id));
    }

    @PostMapping
    public ResponseEntity<UserResponse> createUser(@Valid @RequestBody CreateUserRequest req) {
        UserResponse created = userService.create(req);
        return ResponseEntity.created(URI.create("/api/v1/users/" + created.id())).body(created);
    }
}
```

## Sources

- [niv. 3] Spring Boot docs — @RestController, ResponseEntity, content negotiation
- [niv. 4] Postman State of APIs 2024 — REST 90%+, GraphQL 14%, gRPC 11%
- [niv. 5] Fielding dissertation — REST architectural style, stateless, cacheable
