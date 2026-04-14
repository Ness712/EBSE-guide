# HTTP Security Headers

**[STANDARD]** Suite complete de headers via Spring Security | Score GRADE : 6/7

```java
http.headers(headers -> headers
    .httpStrictTransportSecurity(hsts -> hsts.includeSubDomains(true).maxAgeInSeconds(31536000).preload(true))
    .contentTypeOptions(Customizer.withDefaults())       // X-Content-Type-Options: nosniff
    .frameOptions(frame -> frame.deny())                  // X-Frame-Options: DENY
    .referrerPolicy(ref -> ref.policy(ReferrerPolicy.STRICT_ORIGIN_WHEN_CROSS_ORIGIN))
    .permissionsPolicy(perm -> perm.policy("camera=(), microphone=(), geolocation=()"))
    .contentSecurityPolicy(csp -> csp.policyDirectives(
        "default-src 'self'; script-src 'self'; style-src 'self' 'unsafe-inline'; "
        + "img-src 'self' data:; connect-src 'self' wss:; frame-ancestors 'none'")));
```

Valider avec **securityheaders.com** et **Mozilla Observatory** — cible A+.

Sources : OWASP Secure Headers Project (niv. 2), OWASP ASVS V14.4 (niv. 2), Spring Security docs (niv. 3), Mozilla Observatory (niv. 5)
