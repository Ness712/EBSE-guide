# Mocking

**[RECOMMANDE]** Mockito (Java), vi.mock/MSW (TypeScript) — mocker aux frontieres, pas les details internes | Score GRADE : 4/7

Les mocks remplacent les dependances externes (DB, API, filesystem). Ne jamais mocker les details d'implementation internes — cela rend les tests fragiles.

```java
// Mockito — mocker le repository (frontiere), pas la logique metier
@ExtendWith(MockitoExtension.class)
class ModuleServiceTest {
    @Mock ModuleRepository repository;
    @InjectMocks ModuleService service;

    @Test
    void shouldReturnModule() {
        when(repository.findById(1L)).thenReturn(Optional.of(new Module("Bacterio")));
        assertThat(service.getModule(1L).getName()).isEqualTo("Bacterio");
    }
}
```

```typescript
// MSW — intercepter les appels reseau (frontiere HTTP)
import { http, HttpResponse } from 'msw';
const handlers = [
  http.get('/api/modules', () => HttpResponse.json([{ id: 1, name: 'Bacterio' }])),
];
```

| Regle | Pourquoi | Source |
|-------|----------|--------|
| Mocker aux frontieres (DB, HTTP, FS) | Tests stables, refactoring-safe | Fowler |
| Ne pas mocker ce qu'on possede | Tests couples a l'implementation | Fowler "Mocks Aren't Stubs" |
| Preferer les fakes aux mocks si possible | Plus realistes, moins fragiles | Beck, Fowler |

Sources : SWEBOK v4 — test doubles, stubs and mocks (niv. 1), Fowler "Mocks Aren't Stubs" (niv. 5), Spring Boot docs — Mockito inclus par defaut (niv. 3), MSW docs — network-level mocking (niv. 5)
