# PRISMA Flow — PICOC session-management

**Date de recherche** : 2026-04-17
**Bases interrogées** : IETF Datatracker (RFCs), NIST CSRC, OWASP CheatSheetSeries, OWASP WSTG, OWASP ASVS, WebSearch général (implémentations, librairies)
**Mots-clés Agent A** : "session management security JWT stateless", "JWT blacklist token revocation Redis", "session fixation attack prevention", "OAuth 2.0 token revocation RFC", "HttpOnly Secure SameSite cookie security", "JWT refresh token rotation security"
**Mots-clés Agent B** : "OAuth 2.0 security best current practice RFC", "OWASP ASVS session management requirements", "cookie security attributes testing WSTG", "NIST SP 800-63B session timeout requirements", "session hijacking prevention web application", "refresh token rotation invalidation pattern"
**Protocole** : methodology.md v3.0 §2.1 — double extraction indépendante (Agents A + B, mots-clés différents) + synthèse Agent C

---

## Flux

```
IDENTIFICATION
  Sources identifiées par base (Agent A + Agent B combinés, avant déduplication) :
    - IETF Datatracker (RFCs) : ~12 résultats candidats
    - NIST CSRC : 3 sources candidates
    - OWASP CheatSheetSeries, ASVS, WSTG : ~14 sources candidates
    - WebSearch général (implémentations, librairies, blog experts) : ~22 résultats candidats
    - Snowballing backward (références citées par les RFCs et OWASP) : ~8 sources
  Total identifié (brut, combiné A+B) : ~59
  Doublons retirés (même source identifiée par A et B) : 4
    (NIST SP 800-63B-4, RFC 7009, OWASP Session Mgmt Cheat Sheet, OWASP ASVS V3)
  Total après déduplication : ~55

SCREENING (titre + résumé)
  Sources screenées : ~55
  Sources exclues au screening : ~40
    - E1 (niveau 5 / blog opinion sans données, non-expert reconnu) : ~16
    - E2 (hors scope PICOC — gestion identité fédérée, MFA, pas gestion de session) : ~12
    - E3 (doublons partiels — même contenu que source déjà retenue) : ~7
    - E4 (vendeur sans méthodologie transparente ou conflit d'intérêt non déclaré) : ~5

ELIGIBILITÉ (lecture complète)
  Sources évaluées en détail : ~15
  Sources exclues après lecture complète : ~6
    - Hors scope PICOC strict (JWT validation claims — couvert par authentication.json) : 2
    - Vendor bias disqualifiant (Auth0 blog sur refresh tokens — auto-promotion) : 1
    - Niveau de preuve insuffisant (articles de blog sans références normatives) : 2
    - Redondant sans apport marginal (RFC 6749 OAuth2 core — couvert par RFC 9700 BCP) : 1

INCLUSION
  Sources incluses dans la synthèse : 9
    - Niveau 1 : 4
        RFC 9700 — Best Current Practice for OAuth 2.0 Security (IETF BCP, 2025)
        RFC 7009 — OAuth 2.0 Token Revocation (IETF, 2013)
        RFC 9068 — JWT Profile for OAuth 2.0 Access Tokens (IETF, 2021)
        NIST SP 800-63B-4 — Digital Identity Guidelines (NIST, 2024)
    - Niveau 2 : 4
        OWASP ASVS V3 — Session Management (OWASP, 2021)
        OWASP Session Management Cheat Sheet (OWASP, 2024)
        OWASP WSTG SESS-06 — Testing for Cookie Attributes (OWASP, 2023)
        OWASP Session Fixation Documentation + Protection Patterns (OWASP, 2023) [fusionné]
    - Niveau 5 : 1
        SuperTokens — JWT Blacklist Implementation Guide (2023)

  Sources exclues avec raison documentée :
    - Auth0 blog "Understanding Refresh Token Rotation" : vendor bias, auto-promotion
    - RFC 6749 OAuth 2.0 Core : couvert et supplanté par RFC 9700 BCP
    - RFC 6265 HTTP Cookies (IETF) : couvert opérationnellement par OWASP WSTG SESS-06
    - OWASP JWT Cheat Sheet : couvert par authentication.json (scope plus large que session)
    - RFC 7515/7516/7517 (JWS/JWE/JWK) : hors scope session management (cryptographie JWT)
    - Portswigger Web Security Academy (sessions) : niveau 5, redondant avec OWASP WSTG
```

---

## Documentation recherche (Table 2 Kitchenham)

### Agent A — bases interrogées

| Élément | Valeur |
|---------|--------|
| Bases | IETF Datatracker, OWASP CheatSheetSeries, OWASP ASVS, NIST CSRC, WebSearch général |
| Mots-clés | "session management security JWT stateless", "JWT blacklist token revocation Redis", "session fixation attack prevention", "OAuth 2.0 token revocation RFC", "HttpOnly Secure SameSite cookie security", "JWT refresh token rotation security" |
| Période couverte | 2013-2025 (RFCs depuis RFC 7009 jusqu'à RFC 9700) |
| Sources identifiées | ~32 |
| Sources retenues | 7 |
| Date d'extraction | 2026-04-17 |

### Agent B — bases interrogées

| Élément | Valeur |
|---------|--------|
| Bases | IETF Datatracker, NIST CSRC, OWASP WSTG, OWASP ASVS, WebSearch général |
| Mots-clés | "OAuth 2.0 security best current practice RFC", "OWASP ASVS session management requirements", "cookie security attributes testing WSTG", "NIST SP 800-63B session timeout requirements", "session hijacking prevention web application", "refresh token rotation invalidation pattern" |
| Période couverte | 2013-2025 |
| Sources identifiées | ~27 |
| Sources retenues | 6 (convergence élevée avec A sur 4 sources) |
| Date d'extraction | 2026-04-17 |

---

## Sources exclues — raisons documentées

| Source | Raison exclusion |
|--------|-----------------|
| Auth0 blog — "Understanding Refresh Token Rotation" | Vendor bias — Auth0 (Okta) promeut sa propre implémentation, pas de validation indépendante |
| RFC 6749 — OAuth 2.0 Core | Supplanté par RFC 9700 BCP qui le reference et le complète sur les exigences de sécurité |
| RFC 6265 — HTTP State Management Mechanism | Couvert opérationnellement par OWASP WSTG SESS-06 et OWASP ASVS V3.4 |
| OWASP JWT Cheat Sheet | Scope plus large (validation JWT globale) — couvert dans authentication.json ; duplication non justifiée |
| RFC 7515/7516/7517 (JWS/JWE/JWK) | Cryptographie JWT — hors scope session management (concerne authentication.json) |
| Portswigger Web Security Academy (session hijacking) | Niveau 5, contenu didactique — redondant avec OWASP WSTG qui est la source primaire |
| OWASP Testing Guide SESS-07 à SESS-09 | Hors scope PICOC direct (timeout testing, logout testing) — couvert par NIST SP 800-63B-4 pour les exigences |
