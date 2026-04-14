# Mutation Testing

**[BONNE PRATIQUE]** Valider la qualite des tests au-dela de la couverture | Score GRADE : 3/7

La couverture de code mesure si le code est **execute** par les tests, pas s'il est **verifie**. Le mutation testing injecte des bugs (mutants) dans le code et verifie que les tests les detectent.

## Principe

```
1. L'outil modifie le code source (ex: change > en >=, supprime un return)
2. Il relance les tests
3. Si un test echoue → mutant tue (test efficace)
4. Si aucun test n'echoue → mutant survit (test insuffisant)

Mutation score = mutants tues / mutants totaux
```

## Outils

| Outil | Langage | Integration |
|-------|---------|-------------|
| **PIT** (pitest) | Java | Maven/Gradle plugin, CI compatible |
| **Stryker** | JS/TS | npm, Vitest/Jest support |

## PIT — Java (Maven)

```xml
<plugin>
    <groupId>org.pitest</groupId>
    <artifactId>pitest-maven</artifactId>
    <version>1.17.4</version>
    <configuration>
        <targetClasses>
            <param>fr.ols.backend.service.*</param>
        </targetClasses>
        <mutationThreshold>70</mutationThreshold>
    </configuration>
</plugin>
```

```bash
mvn test-compile org.pitest:pitest-maven:mutationCoverage
```

## Stryker — TypeScript

```bash
npx stryker init   # configuration interactive
npx stryker run    # lance le mutation testing
```

## Interpretation

| Mutation score | Interpretation |
|----------------|---------------|
| > 80% | Tests solides |
| 60-80% | Acceptable, ameliorer les zones faibles |
| < 60% | Tests superficiels (couverture sans assertions) |

## Sources

- [niv. 1] SWEBOK v4 — mutation testing as test effectiveness measure
- [niv. 3] PIT docs — Java mutation testing, Maven integration
- [niv. 3] Stryker docs — JS/TS mutation testing, framework integrations
