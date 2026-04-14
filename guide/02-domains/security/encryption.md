# Encryption (TLS, at-rest)

**[STANDARD]** TLS 1.3 + HTTPS everywhere + AES-256-GCM at-rest | Score GRADE : 6/7

## In-transit (TLS)

```java
// Spring Security — HSTS + HTTPS redirect
http.requiresChannel(channel -> channel.anyRequest().requiresSecure())
    .headers(headers -> headers
        .httpStrictTransportSecurity(hsts -> hsts
            .includeSubDomains(true)
            .maxAgeInSeconds(31536000)
            .preload(true)));
```

- TLS 1.3 obligatoire (NIST SP 800-52 Rev. 2)
- Let's Encrypt pour les certificats (gratuit, automatise, 90 jours)
- Tester avec SSL Labs — cible grade A+

## At-rest

- PostgreSQL : disk-level encryption (LUKS ou cloud provider) pour la plupart des cas
- Application-level (AES-256-GCM) pour champs sensibles specifiques (tokens, PII)

Sources : NIST SP 800-52 (niv. 1), NIST SP 800-175B (niv. 1), OWASP ASVS V6 (niv. 2), Mozilla TLS Guidelines (niv. 5), Let's Encrypt docs (niv. 3)
