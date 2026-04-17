# PRISMA Flow — api-security

**Date de recherche** : 2026-04-17
**Agents** : Reviewer A (indépendant) + Reviewer B (indépendant) — contextes séparés
**Bases interrogées** : NIST CSRC (SP 800-204 series), IETF RFC database (RFC 6749/7519/8705/9068), OWASP Foundation, NestJS official docs, Istio/CNCF docs, Google Scholar, rapports industrie (Salt Security, FireTail/Equixly, Curity)
**Mots-clés Agent A** : "NestJS API-to-API authentication service-to-service JWT", "OAuth2 client credentials microservices security", "NIST microservices security strategies", "mTLS service mesh zero trust", "API authentication breach incidents 2024"
**Mots-clés Agent B** : "JWT RFC 9068 OAuth2 access token profile inter-service", "HMAC request signing vs JWT microservices", "Istio mTLS strict permissive NestJS", "OWASP API security broken authentication 2023", "NestJS guards passport JWT implementation"

---

## Flux PRISMA

```
IDENTIFICATION
  Sources identifiées par base :
    - Standards NIST (SP 800-204, 204A, 204B)                 : 3 références
    - RFC IETF (6749, 7519, 8705, 9068)                       : 4 références
    - Guidelines OWASP (API Top 10 2023, Microservices
      Security Cheat Sheet 2024)                               : 2 références
    - Documentation officielle frameworks (NestJS, Istio)     : 2 références
    - Rapports industrie (Salt Security, FireTail/Equixly,
      Curity, HMAC comparatifs)                               : 4 références
    - Vendor docs / blogs (Auth0, Kong, JWT.io, Medium/DEV)   : ~6 sources
    - Google Scholar / snowballing                             : ~5 additionnelles
  Total identifié : ~26
  Doublons retirés (sources communes A/B comptées une fois) : -2
  Total après déduplication : ~24

SCREENING (titre + résumé)
  Sources screenées : 24
  Sources exclues au screening : -9
    - E1 (> 5 ans ET non-standard/non-classique) : -1 (CVE DB)
    - E2 (blog individuel sans peer review)       : -2 (Medium/DEV + blogs)
    - E3 (documentation vendor commerciale)       : -4 (Kong, Auth0, JWT.io, SonarQube)
    - E5 (hors périmètre — réseau niveau 3
          sans lien auth applicative)              : -2 (Kubernetes NetworkPolicy,
                                                         articles TLS générique)

ÉLIGIBILITÉ (lecture complète)
  Sources évaluées en détail : 15
  Sources exclues après lecture : -1 (voir extraction file)
    - Medium/DEV NestJS gRPC (E2 confirmé après lecture)

INCLUSION
  Sources incluses dans la synthèse : 14
    - Niveau 1 (standards normatifs NIST + RFC IETF)           : 7
    - Niveau 2 (guidelines OWASP peer-reviewed communautaire)  : 2
    - Niveau 3 (documentation officielle frameworks + Curity)  : 3
    - Niveau 4 (rapports industrie — biais commercial noté)    : 2
```

---

## Documentation recherche (Table 2 Kitchenham)

| Base | Termes utilisés | Date | Retenus |
|------|----------------|------|---------|
| NIST CSRC | "microservices security", "SP 800-204", "workload identity", "mTLS service mesh" | 2026-04-17 | 3 (NIST SP 800-204/204A/204B) |
| IETF RFC database | "RFC 6749 client credentials", "RFC 7519 JWT", "RFC 8705 mTLS OAuth2", "RFC 9068 JWT profile" | 2026-04-17 | 4 |
| OWASP Foundation | "OWASP API Security Top 10 2023", "microservices security cheat sheet" | 2026-04-17 | 2 |
| NestJS / Istio official docs | "NestJS guards authentication", "NestJS passport JWT", "Istio PeerAuthentication mTLS" | 2026-04-17 | 2 |
| Curity / vendor guides | "zero trust API implementation JWT", "OAuth2 service-to-service authorization" | 2026-04-17 | 1 (Curity) |
| Rapports industrie | "API security breaches 2024", "Salt Security state API security", "HMAC vs JWT webhook signing" | 2026-04-17 | 3 (Salt Security, FireTail, HMAC comparatifs) |
| Google Scholar / snowballing | "API authentication empirical study microservices" | 2026-04-17 | 0 (exclus E1/E2 — pas d'études empiriques RCT trouvées) |
