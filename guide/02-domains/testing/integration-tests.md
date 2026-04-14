# Tests d'integration

**[STANDARD]** **Testcontainers** + @SpringBootTest (vraie BDD, pas H2) | Score GRADE : 5/7

## Pourquoi pas H2

H2 masque les differences de dialecte SQL (jsonb, ON CONFLICT, window functions). Les bugs apparaissent uniquement en prod. Testcontainers lance un vrai PostgreSQL dans Docker pendant les tests.

## Setup

```java
@SpringBootTest(webEnvironment = RANDOM_PORT)
@Testcontainers
abstract class IntegrationTestBase {

    @Container
    @ServiceConnection
    static PostgreSQLContainer<?> pg =
        new PostgreSQLContainer<>("postgres:17-alpine");

    @Container
    @ServiceConnection
    static GenericContainer<?> redis =
        new GenericContainer<>("redis:7-alpine").withExposedPorts(6379);
}
```

```java
class ExerciceServiceIT extends IntegrationTestBase {
    @Autowired ExerciceService service;

    @Test
    void creerExercice_persisteEnBase() {
        var dto = new ExerciceCreationDto("Coloration Gram", Difficulte.MOYEN);
        var result = service.creer(dto);
        assertThat(result.id()).isNotNull();
        assertThat(result.titre()).isEqualTo("Coloration Gram");
    }
}
```

Sources : Spring Boot docs — @ServiceConnection depuis 3.1 (niv. 3), Testcontainers docs (niv. 3), Fowler "Integration Testing" (niv. 5), SWEBOK v4 Ch.5 (niv. 1)
