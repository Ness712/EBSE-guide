# Feature flags

**[RECOMMANDE]** Unleash self-hosted pour activation progressive des fonctionnalites | Score GRADE : 3/7

Les feature flags permettent de deployer du code inactif, d'activer progressivement et de rollback instantanement sans redeploiement.

```java
// Spring Boot + Unleash SDK
@Bean
public Unleash unleash() {
    return new DefaultUnleash(UnleashConfig.builder()
        .appName("ols-backend")
        .unleashAPI("http://unleash:4242/api")
        .build());
}

// Usage dans un service
if (unleash.isEnabled("nouvelle-fonctionnalite")) {
    // nouveau code
}
```

| Strategie | Usage |
|-----------|-------|
| Standard (on/off) | Activation simple |
| Gradual rollout | Deploiement progressif (% users) |
| UserID | Beta-testeurs specifiques |
| Environment | Actif en staging, inactif en prod |

Sources : CNCF Landscape — Unleash incubating project (niv. 5), Twelve-Factor App — build/run separation, config externe (niv. 3), Fowler — Feature Toggles patterns (niv. 3)
