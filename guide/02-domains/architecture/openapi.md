# OpenAPI / Swagger

**[STANDARD]** Documenter toutes les APIs avec OpenAPI 3.x via springdoc-openapi | Score GRADE : 5/7

Chaque endpoint doit etre documente avec ses types request/response, codes d'erreur et exemples. La doc est generee depuis le code.

```java
// pom.xml : springdoc-openapi-starter-webmvc-ui 2.8+
// Accessible sur /swagger-ui.html et /v3/api-docs

@Operation(summary = "Recuperer un module par ID")
@ApiResponse(responseCode = "200", description = "Module trouve")
@ApiResponse(responseCode = "404", description = "Module introuvable")
@GetMapping("/{id}")
public ResponseEntity<ModuleDto> getModule(@PathVariable Long id) {
    return ResponseEntity.ok(moduleService.findById(id));
}
```

- Generer le schema depuis le code (single source of truth)
- Versionner l'API dans l'URL (`/api/v1/`) ou via header
- Exporter le JSON OpenAPI dans le CI pour detecter les breaking changes

Sources : OpenAPI Specification 3.1 — standard IETF (niv. 1), Spring Boot docs — springdoc-openapi integration native (niv. 5), SmartBear 2023 API Survey — 89% des equipes utilisent OpenAPI (niv. 4)
