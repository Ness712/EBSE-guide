# Tests de contrat

**[BONNE PRATIQUE]** Consumer-driven contract tests entre services | Score GRADE : 3/7

Les tests de contrat verifient que le **producteur** (API) respecte le contrat attendu par le **consommateur** (client). Ils comblent le gap entre tests unitaires et tests E2E.

## Quand les utiliser ?

| Situation | Tests de contrat utiles ? |
|-----------|--------------------------|
| Frontend qui consomme une API backend | Oui — verifie que le backend ne casse pas le frontend |
| Microservices qui communiquent | Oui — chaque service teste son contrat |
| Monolithe avec une seule API | Non — tests d'integration suffisent |

## Spring Cloud Contract (Java)

```java
// Contrat (Groovy DSL) — src/test/resources/contracts/shouldReturnUser.groovy
Contract.make {
    request {
        method GET()
        url "/api/v1/users/1"
    }
    response {
        status OK()
        headers { contentType applicationJson() }
        body(id: 1, name: "Gabriel", email: "g@ols.fr")
    }
}
```

Spring Cloud Contract genere automatiquement :
- **Cote producteur** : test JUnit verifiant que le controller respecte le contrat
- **Cote consommateur** : stub WireMock pour tester le client sans le vrai serveur

## Pact (polyglot)

```typescript
// Consumer test (TypeScript + Pact)
const interaction = {
  state: 'user 1 exists',
  uponReceiving: 'a request for user 1',
  withRequest: { method: 'GET', path: '/api/v1/users/1' },
  willRespondWith: {
    status: 200,
    body: { id: like(1), name: like('Gabriel') },
  },
};
```

**Pact** est prefere quand producteur et consommateur sont dans des langages differents (Pact Broker partage les contrats).

## Sources

- [niv. 3] Spring Cloud Contract docs — Groovy DSL, auto-generated tests + stubs
- [niv. 3] Pact docs — consumer-driven contracts, Pact Broker
- [niv. 5] Sam Newman (Building Microservices) — contract tests between services
