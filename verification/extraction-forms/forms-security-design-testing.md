# Fiches d'extraction des sources — Security, Design, Testing

> Genere le 2026-04-14. Chaque source citee dans chaque page a une fiche.

---

# SECURITY (10 pages)

---

## audit-logging.md

### SOURCE 1
- **Nom** : ISO/IEC 27002:2022 Control 8.15
- **URL** : voir docs officielles
- **Niveau pyramide** : 1
- **Date** : 2022
- **Citation** : audit logs obligatoires, retention >= 1 an
- **Conflit d'interet** : non

### SOURCE 2
- **Nom** : OWASP ASVS V7
- **URL** : https://owasp.org/www-project-application-security-verification-standard/
- **Niveau pyramide** : 2
- **Date** : 2023
- **Citation** : structured audit logging, non-repudiation
- **Conflit d'interet** : non

### SOURCE 3
- **Nom** : OWASP Logging Cheat Sheet
- **URL** : https://cheatsheetseries.owasp.org/cheatsheets/Logging_Cheat_Sheet.html
- **Niveau pyramide** : 2
- **Date** : 2023
- **Citation** : qui/quoi/quand/ou, protection contre falsification
- **Conflit d'interet** : non

### SOURCE 4
- **Nom** : Spring AOP + SLF4J MDC
- **URL** : https://docs.spring.io/spring-framework/reference/core/aop.html
- **Niveau pyramide** : 3
- **Date** : 2025
- **Citation** : implementation recommandee pour Spring Boot
- **Conflit d'interet** : non

---

## authentication.md

### SOURCE 1
- **Nom** : NIST SP 800-63B Rev. 4
- **URL** : https://pages.nist.gov/800-63-4/sp800-63b.html
- **Niveau pyramide** : 1
- **Date** : 2024
- **Citation** : AAL levels, password rules, session timeouts. 30 min idle timeout AAL2, 12h max absolu. Approuve les fonctions memory-hard. "Verifiers SHALL NOT impose composition rules for memorized secrets." "Verifiers SHALL NOT require memorized secrets to be changed arbitrarily." "Verifiers SHALL compare prospective secrets against a list of compromised values."
- **Conflit d'interet** : non

### SOURCE 2
- **Nom** : RFC 7519 (JWT)
- **URL** : https://www.rfc-editor.org/rfc/rfc7519
- **Niveau pyramide** : 1
- **Date** : 2015
- **Citation** : standard Internet JWT, validation signature + exp + iss + aud, rejet alg: none. Section 4.1.4 pour exp.
- **Conflit d'interet** : non

### SOURCE 3
- **Nom** : RFC 6749 (OAuth2)
- **URL** : https://www.rfc-editor.org/rfc/rfc6749
- **Niveau pyramide** : 1
- **Date** : 2012
- **Citation** : standard Internet OAuth2, grant types
- **Conflit d'interet** : non

### SOURCE 4
- **Nom** : RFC 7636 (PKCE)
- **URL** : https://www.rfc-editor.org/rfc/rfc7636
- **Niveau pyramide** : 1
- **Date** : 2015
- **Citation** : "PKCE is an extension to OAuth 2.0 that mitigates the authorization code interception attack for public clients." Seul grant autorise pour les SPA.
- **Conflit d'interet** : non

### SOURCE 5
- **Nom** : SWEBOK v4
- **URL** : voir docs officielles
- **Niveau pyramide** : 1
- **Date** : 2024
- **Citation** : "use well-tested frameworks, defense in depth"
- **Conflit d'interet** : non

### SOURCE 6
- **Nom** : OWASP ASVS V2 (auth) + V3 (session)
- **URL** : https://owasp.org/www-project-application-security-verification-standard/
- **Niveau pyramide** : 2
- **Date** : 2023
- **Citation** : ~80 requirements. V3.4.1-V3.4.3 sur token storage.
- **Conflit d'interet** : non

### SOURCE 7
- **Nom** : OWASP Authentication Cheat Sheet
- **URL** : https://cheatsheetseries.owasp.org/cheatsheets/Authentication_Cheat_Sheet.html
- **Niveau pyramide** : 2
- **Date** : 2023
- **Citation** : best practices, ne pas reveler username/password dans les messages d'erreur
- **Conflit d'interet** : non

### SOURCE 8
- **Nom** : OWASP JWT Cheat Sheet
- **URL** : https://cheatsheetseries.owasp.org/cheatsheets/JSON_Web_Token_for_Java_Cheat_Sheet.html
- **Niveau pyramide** : 2
- **Date** : 2023
- **Citation** : "Store tokens in HttpOnly, Secure, SameSite cookies -- not in localStorage or sessionStorage, which are vulnerable to XSS." Access token lifetime 5-15 min max. Implement refresh token rotation. Token validation, rotation.
- **Conflit d'interet** : non

### SOURCE 9
- **Nom** : OWASP Session Management Cheat Sheet
- **URL** : https://cheatsheetseries.owasp.org/cheatsheets/Session_Management_Cheat_Sheet.html
- **Niveau pyramide** : 2
- **Date** : 2023
- **Citation** : timeouts, cookie attributes
- **Conflit d'interet** : non

### SOURCE 10
- **Nom** : Spring Security docs
- **URL** : https://docs.spring.io/spring-security/reference/
- **Niveau pyramide** : 3
- **Date** : 2025
- **Citation** : architecture, JWT resource server, OAuth2, PKCE natif via oauth2Login()
- **Conflit d'interet** : non — documentation officielle du framework

### SOURCE 11
- **Nom** : JetBrains Developer Survey 2024
- **URL** : https://www.jetbrains.com/lp/devecosystem-2024/
- **Niveau pyramide** : 4
- **Date** : 2024
- **Citation** : JWT 52% adoption, OAuth2 49%, Spring Security 68-80% adoption Java
- **Conflit d'interet** : oui — JetBrains vend des IDE Java, mais survey considere comme objectif (industrie)

---

## dependency-scanning.md

### SOURCE 1
- **Nom** : OWASP Top 10 A06 (Vulnerable and Outdated Components)
- **URL** : https://owasp.org/Top10/A06_2021-Vulnerable_and_Outdated_Components/
- **Niveau pyramide** : 2
- **Date** : 2021
- **Citation** : composants vulnerables dans le Top 10
- **Conflit d'interet** : non

### SOURCE 2
- **Nom** : OWASP ASVS V14.2
- **URL** : https://owasp.org/www-project-application-security-verification-standard/
- **Niveau pyramide** : 2
- **Date** : 2023
- **Citation** : requirements sur la gestion des dependances
- **Conflit d'interet** : non

### SOURCE 3
- **Nom** : NIST NVD (National Vulnerability Database)
- **URL** : https://nvd.nist.gov/
- **Niveau pyramide** : 1
- **Date** : continu
- **Citation** : base de donnees de reference pour les CVE
- **Conflit d'interet** : non

### SOURCE 4
- **Nom** : Dependabot docs
- **URL** : https://docs.github.com/en/code-security/dependabot
- **Niveau pyramide** : 3
- **Date** : 2025
- **Citation** : PRs weekly automatiques, configuration par ecosysteme
- **Conflit d'interet** : oui — produit GitHub/Microsoft, mais outil gratuit et open-source

---

## encryption.md

### SOURCE 1
- **Nom** : NIST SP 800-52 Rev. 2
- **URL** : https://csrc.nist.gov/publications/detail/sp/800-52/rev-2/final
- **Niveau pyramide** : 1
- **Date** : 2019
- **Citation** : TLS 1.3 obligatoire
- **Conflit d'interet** : non

### SOURCE 2
- **Nom** : NIST SP 800-175B
- **URL** : https://csrc.nist.gov/publications/detail/sp/800-175b/rev-1/final
- **Niveau pyramide** : 1
- **Date** : 2020
- **Citation** : guidelines pour le chiffrement, AES-256-GCM
- **Conflit d'interet** : non

### SOURCE 3
- **Nom** : OWASP ASVS V6
- **URL** : https://owasp.org/www-project-application-security-verification-standard/
- **Niveau pyramide** : 2
- **Date** : 2023
- **Citation** : requirements sur le chiffrement en transit et au repos
- **Conflit d'interet** : non

### SOURCE 4
- **Nom** : Mozilla TLS Guidelines
- **URL** : https://wiki.mozilla.org/Security/Server_Side_TLS
- **Niveau pyramide** : 5
- **Date** : 2024
- **Citation** : configuration TLS recommandee
- **Conflit d'interet** : non

### SOURCE 5
- **Nom** : Let's Encrypt docs
- **URL** : https://letsencrypt.org/docs/
- **Niveau pyramide** : 3
- **Date** : 2025
- **Citation** : certificats gratuits, automatises, 90 jours
- **Conflit d'interet** : non

---

## http-headers.md

### SOURCE 1
- **Nom** : OWASP Secure Headers Project
- **URL** : https://owasp.org/www-project-secure-headers/
- **Niveau pyramide** : 2
- **Date** : 2023
- **Citation** : suite complete de headers de securite
- **Conflit d'interet** : non

### SOURCE 2
- **Nom** : OWASP ASVS V14.4
- **URL** : https://owasp.org/www-project-application-security-verification-standard/
- **Niveau pyramide** : 2
- **Date** : 2023
- **Citation** : requirements sur les HTTP headers de securite
- **Conflit d'interet** : non

### SOURCE 3
- **Nom** : Spring Security docs
- **URL** : https://docs.spring.io/spring-security/reference/
- **Niveau pyramide** : 3
- **Date** : 2025
- **Citation** : configuration headers via API fluide (HSTS, CSP, X-Content-Type-Options, X-Frame-Options, Referrer-Policy, Permissions-Policy)
- **Conflit d'interet** : non

### SOURCE 4
- **Nom** : Mozilla Observatory
- **URL** : https://observatory.mozilla.org/
- **Niveau pyramide** : 5
- **Date** : 2025
- **Citation** : outil de validation des headers, cible A+
- **Conflit d'interet** : non

---

## input-validation.md

### SOURCE 1
- **Nom** : SWEBOK v4 Section 3.5
- **URL** : voir docs officielles
- **Niveau pyramide** : 1
- **Date** : 2024
- **Citation** : "Validate input" #1 CERT/CC, parameterized queries, output encoding. "Practice defense in depth." CERT/CC Top 10.
- **Conflit d'interet** : non

### SOURCE 2
- **Nom** : NIST SP 800-53 SI-10
- **URL** : https://csrc.nist.gov/publications/detail/sp/800-53/rev-5/final
- **Niveau pyramide** : 1
- **Date** : 2020
- **Citation** : input validation mandatory for moderate-impact systems
- **Conflit d'interet** : non

### SOURCE 3
- **Nom** : W3C CSP Level 3
- **URL** : https://www.w3.org/TR/CSP3/
- **Niveau pyramide** : 1
- **Date** : 2023
- **Citation** : Content Security Policy standard
- **Conflit d'interet** : non

### SOURCE 4
- **Nom** : OWASP Top 10 A03 (Injection)
- **URL** : https://owasp.org/Top10/A03_2021-Injection/
- **Niveau pyramide** : 2
- **Date** : 2021
- **Citation** : Injection, 274k occurrences, 94% apps testees. "The preferred option is to use a safe API, which avoids using the interpreter entirely, provides a parameterized interface, or migrates to ORMs."
- **Conflit d'interet** : non

### SOURCE 5
- **Nom** : OWASP ASVS V5
- **URL** : https://owasp.org/www-project-application-security-verification-standard/
- **Niveau pyramide** : 2
- **Date** : 2023
- **Citation** : 36 requirements, >90% injections eliminated by allow-list. V5.3.4 sur les requetes parametrees. "Properly implemented input validation controls, using positive allow lists and strong data typing, can eliminate more than 90% of all injection attacks."
- **Conflit d'interet** : non

### SOURCE 6
- **Nom** : OWASP Cheat Sheets (Input Validation, SQLi, XSS, CSRF Prevention)
- **URL** : https://cheatsheetseries.owasp.org/
- **Niveau pyramide** : 2
- **Date** : 2023
- **Citation** : Input Validation CS: "Input validation must be implemented on the server-side before any data is processed. Client-side validation can be used for UX but must never be trusted for security." XSS CS: "CSP is a defense-in-depth mitigation against XSS. It is not a replacement for secure coding practices." "No single technique will solve XSS."
- **Conflit d'interet** : non

### SOURCE 7
- **Nom** : CWE Top 25 2025
- **URL** : https://cwe.mitre.org/top25/archive/2025/2025_cwe_top25.html
- **Niveau pyramide** : 2
- **Date** : 2025
- **Citation** : XSS (CWE-79) #1 score 60.38, SQLi (CWE-89) #2 score 28.72, CSRF (CWE-352) #3 score 13.64
- **Conflit d'interet** : non

### SOURCE 8
- **Nom** : Spring Security docs
- **URL** : https://docs.spring.io/spring-security/reference/
- **Niveau pyramide** : 3
- **Date** : 2025
- **Citation** : CSRF default protection, CSP config, security headers. "Spring Security provides CSRF protection by default for unsafe HTTP methods, such as a POST request, so no additional code is needed."
- **Conflit d'interet** : non

### SOURCE 9
- **Nom** : Spring Boot docs
- **URL** : https://docs.spring.io/spring-boot/reference/
- **Niveau pyramide** : 3
- **Date** : 2025
- **Citation** : Bean Validation auto-configured
- **Conflit d'interet** : non

### SOURCE 10
- **Nom** : React docs
- **URL** : https://react.dev/
- **Niveau pyramide** : 3
- **Date** : 2025
- **Citation** : "By default, React DOM escapes any values embedded in JSX before rendering them. Everything is converted to a string before being rendered. This helps prevent XSS attacks."
- **Conflit d'interet** : non

### SOURCE 11
- **Nom** : Zod docs
- **URL** : https://zod.dev/
- **Niveau pyramide** : 3
- **Date** : 2025
- **Citation** : TypeScript-first, 2kb, zero dependencies
- **Conflit d'interet** : non

### SOURCE 12
- **Nom** : Veracode State of Software Security 2024
- **URL** : https://www.veracode.com/state-of-software-security-report
- **Niveau pyramide** : 4
- **Date** : 2024
- **Citation** : XSS in 49% apps, SQLi in 28%
- **Conflit d'interet** : oui — Veracode vend des solutions de securite applicative, mais rapport considere comme reference industrielle

### SOURCE 13
- **Nom** : npm trends — Zod
- **URL** : https://npmtrends.com/zod
- **Niveau pyramide** : 4
- **Date** : 2025
- **Citation** : Zod #1 en stars (42k)
- **Conflit d'interet** : non

### SOURCE 14
- **Nom** : Recherche academique (parametrees queries)
- **URL** : voir docs officielles
- **Niveau pyramide** : 5
- **Date** : non precise
- **Citation** : parameterized queries >99% effective contre SQL injection
- **Conflit d'interet** : non

---

## password-hashing.md

### SOURCE 1
- **Nom** : OWASP Password Storage Cheat Sheet
- **URL** : https://cheatsheetseries.owasp.org/cheatsheets/Password_Storage_Cheat_Sheet.html
- **Niveau pyramide** : 2
- **Date** : 2023
- **Citation** : Argon2id en 1ere position
- **Conflit d'interet** : non

### SOURCE 2
- **Nom** : NIST SP 800-63B
- **URL** : https://pages.nist.gov/800-63-4/sp800-63b.html
- **Niveau pyramide** : 1
- **Date** : 2024
- **Citation** : approuve les fonctions memory-hard
- **Conflit d'interet** : non

### SOURCE 3
- **Nom** : Password Hashing Competition
- **URL** : https://www.password-hashing.net/
- **Niveau pyramide** : 2
- **Date** : 2015
- **Citation** : Argon2 vainqueur (24 soumissions)
- **Conflit d'interet** : non

### SOURCE 4
- **Nom** : Spring Security (Argon2PasswordEncoder)
- **URL** : https://docs.spring.io/spring-security/reference/
- **Niveau pyramide** : 3
- **Date** : 2025
- **Citation** : Argon2PasswordEncoder disponible nativement, defaultsForSpringSecurity_v5_8()
- **Conflit d'interet** : non

---

## rate-limiting.md

### SOURCE 1
- **Nom** : OWASP ASVS V11.1
- **URL** : https://owasp.org/www-project-application-security-verification-standard/
- **Niveau pyramide** : 2
- **Date** : 2023
- **Citation** : requirements sur le rate limiting et la protection DDoS
- **Conflit d'interet** : non

### SOURCE 2
- **Nom** : Bucket4j docs
- **URL** : https://github.com/bucket4j/bucket4j
- **Niveau pyramide** : 3
- **Date** : 2025
- **Citation** : implementation app-level de rate limiting pour Java
- **Conflit d'interet** : non

### SOURCE 3
- **Nom** : Resilience4j RateLimiter
- **URL** : https://resilience4j.readme.io/docs/ratelimiter
- **Niveau pyramide** : 3
- **Date** : 2025
- **Citation** : alternative pour le rate limiting applicatif
- **Conflit d'interet** : non

---

## secrets-management.md

### SOURCE 1
- **Nom** : Twelve-Factor App Factor III (Config)
- **URL** : https://12factor.net/config
- **Niveau pyramide** : 2
- **Date** : 2012
- **Citation** : configuration externalisee via variables d'environnement
- **Conflit d'interet** : non

### SOURCE 2
- **Nom** : OWASP ASVS V2.10 / V6.4
- **URL** : https://owasp.org/www-project-application-security-verification-standard/
- **Niveau pyramide** : 2
- **Date** : 2023
- **Citation** : requirements sur la gestion des secrets et credentials
- **Conflit d'interet** : non

### SOURCE 3
- **Nom** : NIST SP 800-57
- **URL** : https://csrc.nist.gov/publications/detail/sp/800-57-part-1/rev-5/final
- **Niveau pyramide** : 1
- **Date** : 2020
- **Citation** : gestion des cles cryptographiques
- **Conflit d'interet** : non

### SOURCE 4
- **Nom** : Spring Boot Externalized Config docs
- **URL** : https://docs.spring.io/spring-boot/reference/features/external-config.html
- **Niveau pyramide** : 3
- **Date** : 2025
- **Citation** : mecanismes ${ENV_VAR} dans application.yml
- **Conflit d'interet** : non

### SOURCE 5
- **Nom** : GitLeaks docs
- **URL** : https://github.com/gitleaks/gitleaks
- **Niveau pyramide** : 3
- **Date** : 2025
- **Citation** : pre-commit scan pour detecter les secrets dans le code
- **Conflit d'interet** : non

---

## threat-modeling.md

### SOURCE 1
- **Nom** : SWEBOK v4 Security Knowledge Area
- **URL** : voir docs officielles
- **Niveau pyramide** : 1
- **Date** : 2024
- **Citation** : threat modeling in design phase
- **Conflit d'interet** : non

### SOURCE 2
- **Nom** : OWASP Threat Modeling Cheat Sheet
- **URL** : https://cheatsheetseries.owasp.org/cheatsheets/Threat_Modeling_Cheat_Sheet.html
- **Niveau pyramide** : 2
- **Date** : 2023
- **Citation** : STRIDE methodology, DFD-based approach
- **Conflit d'interet** : non

### SOURCE 3
- **Nom** : Microsoft SDL (Security Development Lifecycle)
- **URL** : https://www.microsoft.com/en-us/securityengineering/sdl
- **Niveau pyramide** : 5
- **Date** : 2004+
- **Citation** : STRIDE originator, threat modeling mandatory in design
- **Conflit d'interet** : oui — Microsoft est a l'origine de STRIDE, mais la methodologie est devenue un standard ouvert largement adopte

---

# DESIGN (16 pages)

---

## animations.md

### SOURCE 1
- **Nom** : Material Design 3 Motion
- **URL** : https://m3.material.io/styles/motion/overview
- **Niveau pyramide** : 5
- **Date** : 2023
- **Citation** : 200-500ms selon complexite
- **Conflit d'interet** : oui — Google (proprietaire de Material Design), mais design system ouvert et largement adopte

### SOURCE 2
- **Nom** : Apple Human Interface Guidelines (HIG)
- **URL** : https://developer.apple.com/design/human-interface-guidelines/
- **Niveau pyramide** : 5
- **Date** : 2025
- **Citation** : 250ms standard
- **Conflit d'interet** : oui — Apple (proprietaire), mais reference industrielle incontournable

### SOURCE 3
- **Nom** : WCAG 2.2 SC 2.3.3
- **URL** : https://www.w3.org/TR/WCAG22/
- **Niveau pyramide** : 1
- **Date** : 2023
- **Citation** : reduced motion obligatoire
- **Conflit d'interet** : non

### SOURCE 4
- **Nom** : Nielsen Norman Group
- **URL** : https://www.nngroup.com/
- **Niveau pyramide** : 3
- **Date** : non precise
- **Citation** : reduced motion obligatoire (consensus avec WCAG)
- **Conflit d'interet** : non

---

## charts.md

### SOURCE 1
- **Nom** : npm trends 2025-2026
- **URL** : https://npmtrends.com/
- **Niveau pyramide** : 4
- **Date** : 2025-2026
- **Citation** : Recharts et Chart.js co-leaders en telechargements (14M/mois chacun)
- **Conflit d'interet** : non

### SOURCE 2
- **Nom** : State of JS 2024
- **URL** : https://stateofjs.com/
- **Niveau pyramide** : 4
- **Date** : 2024
- **Citation** : Recharts #1 satisfaction React charting
- **Conflit d'interet** : non

### SOURCE 3
- **Nom** : Recharts docs
- **URL** : https://recharts.org/
- **Niveau pyramide** : 5
- **Date** : 2025
- **Citation** : built on React + D3
- **Conflit d'interet** : oui — documentation du produit lui-meme

---

## colors.md

### SOURCE 1
- **Nom** : WCAG 2.2 SC 1.4.3
- **URL** : https://www.w3.org/TR/WCAG22/
- **Niveau pyramide** : 1
- **Date** : 2023
- **Citation** : contraste 4.5:1 texte normal (AA), 3:1 texte large, 3:1 composants UI (SC 1.4.11), 3:1 indicateurs focus (SC 2.4.11). Ne jamais utiliser la couleur seule pour transmettre une information (1.4.1).
- **Conflit d'interet** : non

### SOURCE 2
- **Nom** : ISO 9241-125
- **URL** : voir docs officielles
- **Niveau pyramide** : 1
- **Date** : 2017
- **Citation** : maximum 5 +/- 2 familles de teintes (loi de Miller)
- **Conflit d'interet** : non

### SOURCE 3
- **Nom** : Material Design 3 Color System
- **URL** : https://m3.material.io/styles/color/overview
- **Niveau pyramide** : 5
- **Date** : 2023
- **Citation** : systeme de couleurs, teintes semantiques
- **Conflit d'interet** : oui — Google, mais design system ouvert

### SOURCE 4
- **Nom** : WebAIM Million 2024
- **URL** : https://webaim.org/projects/million/
- **Niveau pyramide** : 4
- **Date** : 2024
- **Citation** : 95.9% des pages web echouent au contraste AA
- **Conflit d'interet** : non

---

## component-library.md

### SOURCE 1
- **Nom** : State of JS 2024
- **URL** : https://stateofjs.com/
- **Niveau pyramide** : 4
- **Date** : 2024
- **Citation** : shadcn/ui #1 satisfaction
- **Conflit d'interet** : non

### SOURCE 2
- **Nom** : npm trends
- **URL** : https://npmtrends.com/
- **Niveau pyramide** : 4
- **Date** : 2025
- **Citation** : croissance la plus rapide (shadcn/ui)
- **Conflit d'interet** : non

### SOURCE 3
- **Nom** : Radix UI (accessibilite WAI-ARIA 1.2)
- **URL** : https://www.radix-ui.com/
- **Niveau pyramide** : 3
- **Date** : 2025
- **Citation** : accessibilite WAI-ARIA 1.2 (base de shadcn/ui)
- **Conflit d'interet** : non

### SOURCE 4
- **Nom** : GitHub stars (shadcn/ui)
- **URL** : https://github.com/shadcn-ui/ui
- **Niveau pyramide** : 4
- **Date** : 2025
- **Citation** : 80k+ GitHub stars
- **Conflit d'interet** : non

---

## empty-states.md

### SOURCE 1
- **Nom** : Nielsen Norman Group — heuristique #1
- **URL** : https://www.nngroup.com/articles/ten-usability-heuristics/
- **Niveau pyramide** : 3
- **Date** : 1994 (revisee)
- **Citation** : heuristique #1 visibilite de l'etat du systeme. Un ecran vide sans guidance viole cette heuristique.
- **Conflit d'interet** : non

### SOURCE 2
- **Nom** : Material Design 3 — empty states guidelines
- **URL** : https://m3.material.io/
- **Niveau pyramide** : 5
- **Date** : 2023
- **Citation** : empty states guidelines
- **Conflit d'interet** : oui — Google, mais design system ouvert

### SOURCE 3
- **Nom** : Luke Wroblewski — mobile empty states patterns
- **URL** : voir docs officielles
- **Niveau pyramide** : 5
- **Date** : non precise
- **Citation** : mobile empty states patterns
- **Conflit d'interet** : non

---

## forms.md

### SOURCE 1
- **Nom** : Baymard Institute
- **URL** : https://baymard.com/
- **Niveau pyramide** : 3
- **Date** : non precise
- **Citation** : inline validation +22% completion. 2 colonnes augmentent le taux d'erreur.
- **Conflit d'interet** : non — recherche UX independante

### SOURCE 2
- **Nom** : React Hook Form docs
- **URL** : https://react-hook-form.com/
- **Niveau pyramide** : 5
- **Date** : 2025
- **Citation** : performance re-render minimal
- **Conflit d'interet** : oui — documentation du produit lui-meme

### SOURCE 3
- **Nom** : WCAG 2.2 SC 3.3.1 / 3.3.2
- **URL** : https://www.w3.org/TR/WCAG22/
- **Niveau pyramide** : 1
- **Date** : 2023
- **Citation** : identification et labels d'erreur. Labels toujours visibles, jamais placeholder seul.
- **Conflit d'interet** : non

---

## loading-states.md

### SOURCE 1
- **Nom** : Baymard Institute
- **URL** : https://baymard.com/
- **Niveau pyramide** : 3
- **Date** : non precise
- **Citation** : skeleton reduit abandon de 10-20%. Skeleton screens reduisent la perception du temps d'attente de ~35% vs spinners.
- **Conflit d'interet** : non

### SOURCE 2
- **Nom** : Nielsen Norman Group
- **URL** : https://www.nngroup.com/
- **Niveau pyramide** : 3
- **Date** : non precise
- **Citation** : seuils perception 0.1/1/10s
- **Conflit d'interet** : non

### SOURCE 3
- **Nom** : Material Design 3 Progress Indicators
- **URL** : https://m3.material.io/
- **Niveau pyramide** : 5
- **Date** : 2023
- **Citation** : guidelines pour les indicateurs de progression
- **Conflit d'interet** : oui — Google, mais design system ouvert

---

## navigation.md

### SOURCE 1
- **Nom** : Nielsen Norman Group — F-pattern eye-tracking
- **URL** : https://www.nngroup.com/
- **Niveau pyramide** : 3
- **Date** : non precise
- **Citation** : F-pattern eye-tracking, sidebar superieur pour apps
- **Conflit d'interet** : non

### SOURCE 2
- **Nom** : Material Design 3 Navigation
- **URL** : https://m3.material.io/components/navigation-drawer/overview
- **Niveau pyramide** : 5
- **Date** : 2023
- **Citation** : patterns de navigation (drawer, rail, bar)
- **Conflit d'interet** : oui — Google, mais design system ouvert

### SOURCE 3
- **Nom** : Apple HIG — Tab bars mobile, sidebar desktop
- **URL** : https://developer.apple.com/design/human-interface-guidelines/
- **Niveau pyramide** : 5
- **Date** : 2025
- **Citation** : Tab bars pour mobile, sidebar pour desktop
- **Conflit d'interet** : oui — Apple, mais reference industrielle

---

## realtime.md

### SOURCE 1
- **Nom** : Spring WebSocket docs
- **URL** : https://docs.spring.io/spring-framework/reference/web/websocket.html
- **Niveau pyramide** : 3
- **Date** : 2025
- **Citation** : WebSocket + STOMP reference implementation
- **Conflit d'interet** : non

### SOURCE 2
- **Nom** : IETF RFC 6455 (WebSocket)
- **URL** : https://www.rfc-editor.org/rfc/rfc6455
- **Niveau pyramide** : 1
- **Date** : 2011
- **Citation** : WebSocket protocol standard
- **Conflit d'interet** : non

### SOURCE 3
- **Nom** : MDN — Server-Sent Events specification
- **URL** : https://developer.mozilla.org/en-US/docs/Web/API/Server-sent_events
- **Niveau pyramide** : 3
- **Date** : 2025
- **Citation** : specification SSE, reconnexion auto, HTTP standard
- **Conflit d'interet** : non

### SOURCE 4
- **Nom** : SWEBOK v4
- **URL** : voir docs officielles
- **Niveau pyramide** : 1
- **Date** : 2024
- **Citation** : event-driven architecture patterns
- **Conflit d'interet** : non

---

## responsive.md

### SOURCE 1
- **Nom** : WCAG 2.2 SC 2.5.8
- **URL** : https://www.w3.org/TR/WCAG22/
- **Niveau pyramide** : 1
- **Date** : 2023
- **Citation** : target size 24px minimum, 44px recommande (AA)
- **Conflit d'interet** : non

### SOURCE 2
- **Nom** : Material Design 3 — 48dp touch targets
- **URL** : https://m3.material.io/
- **Niveau pyramide** : 5
- **Date** : 2023
- **Citation** : 48dp touch targets
- **Conflit d'interet** : oui — Google, mais design system ouvert

### SOURCE 3
- **Nom** : Apple HIG — 44pt minimum tap targets
- **URL** : https://developer.apple.com/design/human-interface-guidelines/
- **Niveau pyramide** : 5
- **Date** : 2025
- **Citation** : 44pt minimum tap targets
- **Conflit d'interet** : oui — Apple, mais reference industrielle

---

## search.md

### SOURCE 1
- **Nom** : MeiliSearch docs
- **URL** : https://www.meilisearch.com/docs
- **Niveau pyramide** : 5
- **Date** : 2025
- **Citation** : benchmarks < 50ms sur 1M docs
- **Conflit d'interet** : oui — documentation du produit lui-meme

### SOURCE 2
- **Nom** : DB-Engines ranking 2025
- **URL** : https://db-engines.com/en/ranking/search+engine
- **Niveau pyramide** : 4
- **Date** : 2025
- **Citation** : ranking des search engines
- **Conflit d'interet** : non

### SOURCE 3
- **Nom** : PostgreSQL docs — full-text search
- **URL** : https://www.postgresql.org/docs/current/textsearch.html
- **Niveau pyramide** : 3
- **Date** : 2025
- **Citation** : full-text search natif PostgreSQL
- **Conflit d'interet** : non

---

## shadows.md

### SOURCE 1
- **Nom** : Material Design 3 Elevation
- **URL** : https://m3.material.io/styles/elevation/overview
- **Niveau pyramide** : 5
- **Date** : 2023
- **Citation** : systeme d'elevation par niveaux
- **Conflit d'interet** : oui — Google, mais design system ouvert

### SOURCE 2
- **Nom** : Apple HIG — Depth
- **URL** : https://developer.apple.com/design/human-interface-guidelines/
- **Niveau pyramide** : 5
- **Date** : 2025
- **Citation** : guidelines sur la profondeur et les ombres
- **Conflit d'interet** : oui — Apple, mais reference industrielle

### SOURCE 3
- **Nom** : Web Almanac 2024
- **URL** : https://almanac.httparchive.org/
- **Niveau pyramide** : 4
- **Date** : 2024
- **Citation** : 93% des sites utilisent box-shadow
- **Conflit d'interet** : non

---

## spacing.md

### SOURCE 1
- **Nom** : Material Design 3 — grille 8dp
- **URL** : https://m3.material.io/foundations/layout/understanding-layout/spacing
- **Niveau pyramide** : 5
- **Date** : 2023
- **Citation** : grille de base 8dp
- **Conflit d'interet** : oui — Google, mais design system ouvert

### SOURCE 2
- **Nom** : Apple HIG — espacement 8pt systematique
- **URL** : https://developer.apple.com/design/human-interface-guidelines/
- **Niveau pyramide** : 5
- **Date** : 2025
- **Citation** : espacement 8pt systematique
- **Conflit d'interet** : oui — Apple, mais reference industrielle

### SOURCE 3
- **Nom** : ISO 9241-112:2017
- **URL** : voir docs officielles
- **Niveau pyramide** : 1
- **Date** : 2017
- **Citation** : espacement regulier pour lisibilite
- **Conflit d'interet** : non

---

## typography.md

### SOURCE 1
- **Nom** : ISO 9241-125:2017
- **URL** : voir docs officielles
- **Niveau pyramide** : 1
- **Date** : 2017
- **Citation** : taille minimum, line-height, longueur de ligne
- **Conflit d'interet** : non

### SOURCE 2
- **Nom** : WCAG 2.2 criterion 1.4.8 (AAA)
- **URL** : https://www.w3.org/TR/WCAG22/
- **Niveau pyramide** : 1
- **Date** : 2023
- **Citation** : line-height >= 1.5, max 80 chars
- **Conflit d'interet** : non

### SOURCE 3
- **Nom** : Material Design 3
- **URL** : https://m3.material.io/styles/typography/overview
- **Niveau pyramide** : 5
- **Date** : 2023
- **Citation** : Body Large 16sp, line-height 1.5
- **Conflit d'interet** : oui — Google, mais design system ouvert

### SOURCE 4
- **Nom** : Apple HIG
- **URL** : https://developer.apple.com/design/human-interface-guidelines/
- **Niveau pyramide** : 5
- **Date** : 2025
- **Citation** : Body 17pt
- **Conflit d'interet** : oui — Apple, mais reference industrielle

### SOURCE 5
- **Nom** : Web Almanac 2024
- **URL** : https://almanac.httparchive.org/
- **Niveau pyramide** : 4
- **Date** : 2024
- **Citation** : median 16px, line-height 1.5 (8M sites)
- **Conflit d'interet** : non

### SOURCE 6
- **Nom** : Nielsen Norman Group
- **URL** : https://www.nngroup.com/
- **Niveau pyramide** : 3
- **Date** : non precise
- **Citation** : line-height 1.4-1.65
- **Conflit d'interet** : non

### SOURCE 7
- **Nom** : Ling & Van Schaik 2006
- **URL** : voir docs officielles (peer-reviewed)
- **Niveau pyramide** : 5
- **Date** : 2006
- **Citation** : 50-75 chars optimal (peer-reviewed)
- **Conflit d'interet** : non

---

## user-effectiveness.md

### SOURCE 1
- **Nom** : ISO 25019:2023
- **URL** : voir docs officielles
- **Niveau pyramide** : 1
- **Date** : 2023
- **Citation** : "Effectiveness: degree to which users achieve specified goals with accuracy and completeness." Qualite d'usage : Effectiveness, Efficiency, Satisfaction.
- **Conflit d'interet** : non

### SOURCE 2
- **Nom** : Nielsen Norman Group — 5 users / 85% issues
- **URL** : https://www.nngroup.com/
- **Niveau pyramide** : 5
- **Date** : non precise
- **Citation** : 5 utilisateurs trouvent 85% des problemes. Base sur Nielsen & Landauer 1993 (p=0.31). Conteste par Spool 2001. Utile comme heuristique, pas comme loi universelle.
- **Conflit d'interet** : non

### SOURCE 3
- **Nom** : SUS — System Usability Scale (Brooke 1996)
- **URL** : voir docs officielles
- **Niveau pyramide** : 5
- **Date** : 1996
- **Citation** : standard industriel pour mesurer la satisfaction d'utilisation. Score > 68 = acceptable.
- **Conflit d'interet** : non

### SOURCE 4
- **Nom** : PostHog / Mixpanel docs
- **URL** : https://posthog.com/docs / https://docs.mixpanel.com/
- **Niveau pyramide** : 3
- **Date** : 2025
- **Citation** : funnel analysis, session recording
- **Conflit d'interet** : oui — documentation de produits commerciaux

---

## visual-trends.md

### SOURCE 1
- **Nom** : Material Design 3 — tonal elevation, shape system
- **URL** : https://m3.material.io/
- **Niveau pyramide** : 5
- **Date** : 2023
- **Citation** : tonal elevation (surface teintee remplace les drop shadows), shape system (coins arrondis 12px defaut)
- **Conflit d'interet** : oui — Google, mais design system ouvert

### SOURCE 2
- **Nom** : Apple HIG 2025 — materials, vibrancy, corner radius
- **URL** : https://developer.apple.com/design/human-interface-guidelines/
- **Niveau pyramide** : 5
- **Date** : 2025
- **Citation** : materials, vibrancy, corner radius (10-13px). Glassmorphism subtil (visionOS). Subtle borders.
- **Conflit d'interet** : oui — Apple, mais reference industrielle

### SOURCE 3
- **Nom** : Dribbble/Behance trends 2025-2026
- **URL** : https://dribbble.com/ / https://www.behance.net/
- **Niveau pyramide** : 6
- **Date** : 2025-2026
- **Citation** : observation empirique des tendances visuelles
- **Conflit d'interet** : non — observation communautaire, mais pas de methodologie rigoureuse

---

# TESTING (7 pages)

---

## contract-tests.md

### SOURCE 1
- **Nom** : Spring Cloud Contract docs
- **URL** : https://spring.io/projects/spring-cloud-contract
- **Niveau pyramide** : 3
- **Date** : 2025
- **Citation** : Groovy DSL, auto-generated tests + stubs
- **Conflit d'interet** : non

### SOURCE 2
- **Nom** : Pact docs
- **URL** : https://docs.pact.io/
- **Niveau pyramide** : 3
- **Date** : 2025
- **Citation** : consumer-driven contracts, Pact Broker
- **Conflit d'interet** : non

### SOURCE 3
- **Nom** : Sam Newman — Building Microservices
- **URL** : voir editeur (O'Reilly)
- **Niveau pyramide** : 5
- **Date** : 2021 (2nd ed)
- **Citation** : contract tests between services
- **Conflit d'interet** : non

---

## e2e-tests.md

### SOURCE 1
- **Nom** : State of JS 2024
- **URL** : https://stateofjs.com/
- **Niveau pyramide** : 4
- **Date** : 2024
- **Citation** : Playwright #1 satisfaction
- **Conflit d'interet** : non

### SOURCE 2
- **Nom** : JetBrains Developer Survey 2024
- **URL** : https://www.jetbrains.com/lp/devecosystem-2024/
- **Niveau pyramide** : 4
- **Date** : 2024
- **Citation** : croissance la plus rapide (Playwright)
- **Conflit d'interet** : oui — JetBrains vend des IDE, mais survey considere comme objectif

### SOURCE 3
- **Nom** : npm trends
- **URL** : https://npmtrends.com/
- **Niveau pyramide** : 4
- **Date** : 2025
- **Citation** : Playwright depasse Cypress en telechargements
- **Conflit d'interet** : non

### SOURCE 4
- **Nom** : Playwright docs
- **URL** : https://playwright.dev/
- **Niveau pyramide** : 3
- **Date** : 2025
- **Citation** : multi-browser (Chromium + Firefox + WebKit), auto-waiting natif, parallelisation gratuite, API testing integre
- **Conflit d'interet** : oui — Microsoft (proprietaire de Playwright), mais outil open-source gratuit

---

## integration-tests.md

### SOURCE 1
- **Nom** : Spring Boot docs (@ServiceConnection)
- **URL** : https://docs.spring.io/spring-boot/reference/
- **Niveau pyramide** : 3
- **Date** : 2025
- **Citation** : @ServiceConnection depuis 3.1, integration Testcontainers
- **Conflit d'interet** : non

### SOURCE 2
- **Nom** : Testcontainers docs
- **URL** : https://testcontainers.com/
- **Niveau pyramide** : 3
- **Date** : 2025
- **Citation** : lance un vrai PostgreSQL dans Docker pendant les tests, evite les differences de dialecte H2
- **Conflit d'interet** : non

### SOURCE 3
- **Nom** : Fowler — "Integration Testing"
- **URL** : https://martinfowler.com/bliki/IntegrationTest.html
- **Niveau pyramide** : 5
- **Date** : non precise
- **Citation** : definition et pratiques de tests d'integration
- **Conflit d'interet** : non

### SOURCE 4
- **Nom** : SWEBOK v4 Ch.5
- **URL** : voir docs officielles
- **Niveau pyramide** : 1
- **Date** : 2024
- **Citation** : integration testing prescribed
- **Conflit d'interet** : non

---

## mocking.md

### SOURCE 1
- **Nom** : SWEBOK v4
- **URL** : voir docs officielles
- **Niveau pyramide** : 1
- **Date** : 2024
- **Citation** : test doubles, stubs and mocks
- **Conflit d'interet** : non

### SOURCE 2
- **Nom** : Fowler — "Mocks Aren't Stubs"
- **URL** : https://martinfowler.com/articles/mocksArentStubs.html
- **Niveau pyramide** : 5
- **Date** : 2007
- **Citation** : mocker aux frontieres (DB, HTTP, FS), ne pas mocker ce qu'on possede, preferer les fakes aux mocks si possible
- **Conflit d'interet** : non

### SOURCE 3
- **Nom** : Spring Boot docs (Mockito inclus)
- **URL** : https://docs.spring.io/spring-boot/reference/
- **Niveau pyramide** : 3
- **Date** : 2025
- **Citation** : Mockito inclus par defaut dans spring-boot-starter-test
- **Conflit d'interet** : non

### SOURCE 4
- **Nom** : MSW docs (Mock Service Worker)
- **URL** : https://mswjs.io/
- **Niveau pyramide** : 5
- **Date** : 2025
- **Citation** : network-level mocking, interception des appels reseau
- **Conflit d'interet** : oui — documentation du produit lui-meme

---

## mutation-testing.md

### SOURCE 1
- **Nom** : SWEBOK v4
- **URL** : voir docs officielles
- **Niveau pyramide** : 1
- **Date** : 2024
- **Citation** : mutation testing as test effectiveness measure
- **Conflit d'interet** : non

### SOURCE 2
- **Nom** : PIT (pitest) docs
- **URL** : https://pitest.org/
- **Niveau pyramide** : 3
- **Date** : 2025
- **Citation** : Java mutation testing, Maven integration
- **Conflit d'interet** : non

### SOURCE 3
- **Nom** : Stryker docs
- **URL** : https://stryker-mutator.io/
- **Niveau pyramide** : 3
- **Date** : 2025
- **Citation** : JS/TS mutation testing, framework integrations
- **Conflit d'interet** : non

---

## test-data.md

### SOURCE 1
- **Nom** : Kent Beck
- **URL** : voir editeur (Test Driven Development: By Example)
- **Niveau pyramide** : 5
- **Date** : 2002
- **Citation** : tests independants, etat isole. "isolated tests". Un test = ses propres donnees.
- **Conflit d'interet** : non

### SOURCE 2
- **Nom** : Fowler — Object Mother / Test Data Builder
- **URL** : https://martinfowler.com/bliki/ObjectMother.html
- **Niveau pyramide** : 5
- **Date** : non precise
- **Citation** : Object Mother / Test Data Builder patterns
- **Conflit d'interet** : non

### SOURCE 3
- **Nom** : faker-js docs
- **URL** : https://fakerjs.dev/
- **Niveau pyramide** : 4
- **Date** : 2025
- **Citation** : 47M/mois npm, donnees realistes pour detecter les bugs de format/encoding
- **Conflit d'interet** : oui — documentation du produit lui-meme

---

## unit-tests.md

### SOURCE 1
- **Nom** : SWEBOK v4 Section 5.3
- **URL** : voir docs officielles
- **Niveau pyramide** : 1
- **Date** : 2024
- **Citation** : unit testing prescribed, automated frameworks recommended
- **Conflit d'interet** : non

### SOURCE 2
- **Nom** : ISO 25010:2023
- **URL** : voir docs officielles
- **Niveau pyramide** : 1
- **Date** : 2023
- **Citation** : Testability sub-characteristic of Maintainability
- **Conflit d'interet** : non

### SOURCE 3
- **Nom** : ISTQB CTFL v4.0
- **URL** : https://www.istqb.org/
- **Niveau pyramide** : 2
- **Date** : 2023
- **Citation** : component testing definition
- **Conflit d'interet** : non

### SOURCE 4
- **Nom** : Spring Boot docs
- **URL** : https://docs.spring.io/spring-boot/reference/
- **Niveau pyramide** : 3
- **Date** : 2025
- **Citation** : JUnit 5 + AssertJ + Mockito bundled by default. Utilise AssertJ dans tous les exemples.
- **Conflit d'interet** : non

### SOURCE 5
- **Nom** : Vitest docs
- **URL** : https://vitest.dev/
- **Niveau pyramide** : 3
- **Date** : 2025
- **Citation** : Vite-native, Jest-compatible API, shared config
- **Conflit d'interet** : non

### SOURCE 6
- **Nom** : Vite blog
- **URL** : https://vite.dev/blog/
- **Niveau pyramide** : 3
- **Date** : 2025
- **Citation** : Vite itself migrated to Vitest
- **Conflit d'interet** : non

### SOURCE 7
- **Nom** : React Testing Library
- **URL** : https://testing-library.com/docs/react-testing-library/intro/
- **Niveau pyramide** : 3
- **Date** : 2025
- **Citation** : supports Vitest with dedicated docs
- **Conflit d'interet** : non

### SOURCE 8
- **Nom** : State of JS 2024/2025
- **URL** : https://stateofjs.com/
- **Niveau pyramide** : 4
- **Date** : 2024-2025
- **Citation** : Vitest #1 satisfaction, +14pp YoY growth, 90%+ satisfaction
- **Conflit d'interet** : non

### SOURCE 9
- **Nom** : JetBrains Developer Survey 2024
- **URL** : https://www.jetbrains.com/lp/devecosystem-2024/
- **Niveau pyramide** : 4
- **Date** : 2024
- **Citation** : Jest 63%, Vitest 29% (growing), JUnit 5 dominant Java
- **Conflit d'interet** : oui — JetBrains vend des IDE, mais survey considere comme objectif

### SOURCE 10
- **Nom** : npm trends
- **URL** : https://npmtrends.com/
- **Niveau pyramide** : 4
- **Date** : 2025
- **Citation** : Jest 172M/mo, Vitest 82M/mo (3.5x growth in 2 years). Maven Central ~80% market share JUnit 5.
- **Conflit d'interet** : non

### SOURCE 11
- **Nom** : Google Testing Blog
- **URL** : https://testing.googleblog.com/
- **Niveau pyramide** : 5
- **Date** : non precise
- **Citation** : 70/20/10 pyramid ratio. Coverage tiers : 60% acceptable, 75% recommande, 90% exemplaire. 90% minimum nouveau code. "We should not be obsessing on how to get from 90% to 95%. The gains of increasing code coverage beyond a certain point are logarithmic."
- **Conflit d'interet** : oui — Google a un interet a promouvoir ses pratiques, mais blog considere comme reference industrielle

### SOURCE 12
- **Nom** : Fowler
- **URL** : https://martinfowler.com/articles/practical-test-pyramid.html
- **Niveau pyramide** : 5
- **Date** : non precise
- **Citation** : test pyramid, test observable behaviour. "Write lots of small and fast unit tests." "Push tests as far down the pyramid as you can." "Before fixing a bug from a high-level test, replicate with a unit test." "Give test code the same level of care."
- **Conflit d'interet** : non

### SOURCE 13
- **Nom** : Kent Beck
- **URL** : voir editeur (Test Driven Development: By Example)
- **Niveau pyramide** : 5
- **Date** : 2002
- **Citation** : 8 properties of good tests, sub-second, reliable. "minimize programmer waiting." "run reliably."
- **Conflit d'interet** : non

### SOURCE 14
- **Nom** : Bullseye (avec citations empiriques)
- **URL** : https://www.bullseye.com/
- **Niveau pyramide** : 5
- **Date** : non precise
- **Citation** : "Even 100% coverage is estimated to only expose about half the faults in a system."
- **Conflit d'interet** : oui — Bullseye vend un outil de couverture, mais cite des etudes empiriques

### SOURCE 15
- **Nom** : Kent C. Dodds
- **URL** : https://kentcdodds.com/
- **Niveau pyramide** : 5
- **Date** : non precise
- **Citation** : ~70% coverage comme cible raisonnable
- **Conflit d'interet** : non

### SOURCE 16
- **Nom** : Etude academique (AssertJ lisibilite)
- **URL** : voir docs officielles
- **Niveau pyramide** : 5
- **Date** : non precise
- **Citation** : confirme meilleure lisibilite d'AssertJ
- **Conflit d'interet** : non
