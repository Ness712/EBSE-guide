# Safe defaults (deny-by-default)

**[STANDARD]** Tout est interdit par defaut — autoriser explicitement | Score GRADE : 5/7

Le principe de deny-by-default garantit qu'un oubli de configuration ne cree pas une faille. Si rien n'est configure, rien n'est accessible.

```java
// Spring Security — deny all, puis autoriser explicitement
@Bean
public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
    return http
        .authorizeHttpRequests(auth -> auth
            .requestMatchers("/api/public/**").permitAll()
            .requestMatchers("/actuator/health").permitAll()
            .anyRequest().authenticated()  // DENY par defaut
        )
        .build();
}
```

| Principe | Implementation | Source |
|----------|---------------|--------|
| Deny-by-default (authz) | `.anyRequest().authenticated()` | OWASP, Spring Security |
| Whitelist > blacklist | Autoriser les routes connues, refuser le reste | OWASP A01:2021 |
| CORS restrictif par defaut | `allowedOrigins` explicite, jamais `*` en prod | OWASP |
| Circuit breaker ferme par defaut | Ouvert seulement apres N erreurs | Resilience4j, Fowler |
| Feature flags off par defaut | Activer explicitement en prod | Convention industrielle |

Sources : OWASP A01:2021 — Broken Access Control, deny by default (niv. 2), SWEBOK v4 — security principles, least privilege (niv. 1), Spring Security docs — authorize requests (niv. 3), CWE-276 — Incorrect Default Permissions (niv. 2)
