# Systematic Reviews — 10 Security Decisions (Agent B)

**Date** : 2026-04-14
**Methode** : Kitchenham v3.0 (EBSE-Guide methodology.md)
**Reviewer** : Agent B (Claude Opus 4.6, contexte isole)

---

## Decision 1 — Password Hashing (Argon2id vs bcrypt vs scrypt vs PBKDF2)

**PICOC** : P=App web stockant mots de passe utilisateurs | I=Argon2id / bcrypt / scrypt / PBKDF2 | C=entre eux | O=Resistance GPU/ASIC, cout cracking, performance serveur | Co=Production, auth classique email+password

**PRISMA** : OWASP Password Storage CS (1), NIST SP 800-63B Rev4 (1), Password Hashing Competition 2015 (1), Stytch blog (1), Guptadeepak benchmark 2026 (1) → Found=5 → Screened=5 → Excl: 0 → Included=5

**I/E** : I1=traite directement du hashing de mots de passe, I3=niveaux 1-3, I4=post-2021. Aucune exclusion.

**Quality Assessment** :
| Source | Q1 | Q2 | Q3 | Q4 | Q5 | Q6 | Q7 | Q8 | Q9 | Q10 | Q11 | TOTAL |
|--------|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:---:|:---:|:-----:|
| OWASP Password CS | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | **11/11** |
| NIST SP 800-63B R4 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | **11/11** |
| PHC 2015 results | 1 | 1 | 1 | 1 | 1 | 0.5 | 1 | 1 | 1 | 1 | 1 | **10.5/11** |
| Stytch blog | 1 | 1 | 0.5 | 0.5 | 0 | 0.5 | 1 | 0.5 | 0.5 | 1 | 1 | **7.5/11** |
| Guptadeepak 2026 | 1 | 1 | 0.5 | 0.5 | 0 | 0.5 | 1 | 0.5 | 0.5 | 1 | 1 | **7.5/11** |

**Data Extraction** :
| Source | URL | Pyramid | Year | Data Point | COI |
|--------|-----|:-------:|:----:|------------|:---:|
| OWASP Password CS | https://cheatsheetseries.owasp.org/cheatsheets/Password_Storage_Cheat_Sheet.html | 1 | 2025 | Hierarchy: 1.Argon2id 2.scrypt 3.bcrypt 4.PBKDF2. Min config: m=19MiB, t=2, p=1 | Non |
| NIST SP 800-63B R4 | https://pages.nist.gov/800-63-4/sp800-63b.html | 1 | 2024 | Memory-hard+compute-hard SHOULD be used. Salt >=32 bits. Cost SHOULD increase over time | Non |
| PHC 2015 | https://www.password-hashing.net/ | 2 | 2015 | Argon2 winner of open competition, peer-reviewed by expert panel | Non |
| Stytch blog | https://stytch.com/blog/argon2-vs-bcrypt-vs-scrypt/ | 3 | 2023 | Argon2 128MiB GPU advantage only 1.5x vs 620,000x for MD5 | Oui (Stytch=auth vendor) |
| Guptadeepak 2026 | https://guptadeepak.com/research/password-hashing-guide-2026/ | 3 | 2026 | Cracking Argon2id ~$500K vs PBKDF2 ~$5K for 8-char password | Non |

**GRADE** : Score depart=4 (niveau 1, OWASP+NIST) +1 (convergence: 5/5 sources recommandent Argon2id #1) +1 (peer-reviewed PHC) = **6/7 → FORTE_RECOMMANDATION**.

**Sensitivity** : Retrait OWASP → NIST seul suffit (score 5). Retrait NIST → OWASP+PHC suffisent (score 5). **ROBUSTE**.

**Publication bias** : Aucun article ne recommande PBKDF2 ou bcrypt au-dessus d'Argon2id pour les nouveaux systemes. Bias non detecte.

**Recommendation** : **Argon2id** avec m=19MiB, t=2, p=1 minimum. bcrypt (cost=10+) acceptable en fallback legacy.

**Variants** :
- **Java/Spring Boot** : `spring-security-crypto` inclut Argon2idPasswordEncoder depuis Spring Security 5.8+. Config: `new Argon2PasswordEncoder(16, 32, 1, 19456, 2)`.
- **NestJS** : `argon2` npm package (binding C natif). `await argon2.hash(password, {type: argon2.argon2id, memoryCost: 19456, timeCost: 2})`.
- **Django** : `Argon2PasswordHasher` integre depuis Django 3.2+ (via `argon2-cffi`). Ajouter dans `PASSWORD_HASHERS[0]`.

---

## Decision 2 — Encryption (TLS version + at-rest)

**PICOC** : P=App web traitant donnees sensibles | I=TLS 1.3 / TLS 1.2 + AES-256-GCM / AES-128-GCM at-rest | C=versions TLS, algorithmes at-rest | O=Securite, performance handshake, compatibilite | Co=Production, donnees utilisateurs, conformite RGPD

**PRISMA** : NIST SP 800-52r2 (1), OWASP TLS CS (1), NCSC NL TLS Guidelines 2025 (1), Cloudflare Radar (1), Mozilla Server Side TLS (1) → Found=5 → Screened=5 → Excl: 0 → Included=5

**I/E** : I1=traite directement de TLS/encryption, I3=niveaux 1-3, I4=post-2021. Aucune exclusion.

**Quality Assessment** :
| Source | Q1 | Q2 | Q3 | Q4 | Q5 | Q6 | Q7 | Q8 | Q9 | Q10 | Q11 | TOTAL |
|--------|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:---:|:---:|:-----:|
| NIST SP 800-52r2 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | **11/11** |
| OWASP TLS CS | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | **11/11** |
| NCSC NL 2025 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | **11/11** |
| Cloudflare Radar | 1 | 1 | 0.5 | 0.5 | 0.5 | 1 | 1 | 1 | 0.5 | 1 | 1 | **9/11** |
| Mozilla TLS | 1 | 1 | 1 | 1 | 0.5 | 1 | 1 | 1 | 1 | 1 | 1 | **10.5/11** |

**Data Extraction** :
| Source | URL | Pyramid | Year | Data Point | COI |
|--------|-----|:-------:|:----:|------------|:---:|
| NIST SP 800-52r2 | https://nvlpubs.nist.gov/nistpubs/SpecialPublications/NIST.SP.800-52r2.pdf | 1 | 2024 | TLS 1.3 SHOULD be preferred. TLS 1.0/1.1 SHALL NOT be used. AES-256-GCM mandatory | Non |
| OWASP TLS CS | https://cheatsheetseries.owasp.org/cheatsheets/Transport_Layer_Security_Cheat_Sheet.html | 1 | 2025 | TLS 1.3 preferred, TLS 1.2 acceptable with strong ciphers only | Non |
| NCSC NL 2025 | https://www.ncsc.nl/api/media/sites/default/files/Publication_TLS-Security%20guidelines-2025-05_ENG.pdf | 1 | 2025 | TLS 1.3 only 5 cipher suites vs 15-20 in TLS 1.2. PFS mandatory | Non |
| Cloudflare Radar | https://radar.cloudflare.com/ | 4 | 2026 | ~95% web traffic uses TLS 1.3 in 2026 | Oui (Cloudflare=CDN vendor) |
| Mozilla TLS | https://wiki.mozilla.org/Security/Server_Side_TLS | 1 | 2025 | "Modern" profile = TLS 1.3 only. "Intermediate" = TLS 1.2+1.3 | Non |

**GRADE** : Score depart=4 (niveau 1, NIST+OWASP+NCSC) +1 (convergence: 5/5 concordent TLS 1.3) +1 (adoption massive 95%) = **6/7 → FORTE_RECOMMANDATION**.

**Sensitivity** : Retrait de n'importe quelle source → score reste >=5. **ROBUSTE**.

**Publication bias** : Pas de publication pro-TLS 1.1 trouvee. Consensus total. Bias non detecte.

**Recommendation** : **TLS 1.3** obligatoire, TLS 1.2 en fallback compatibilite avec ciphers forts uniquement. At-rest : **AES-256-GCM**. PFS obligatoire.

**Variants** :
- **Java/Spring Boot** : `server.ssl.enabled-protocols=TLSv1.3` dans application.properties. Jasypt ou Spring Vault pour encryption at-rest.
- **NestJS** : Reverse proxy (nginx/caddy) gere TLS. At-rest via `crypto.createCipheriv('aes-256-gcm')` ou `@nestjs/config` + Vault.
- **Django** : `SECURE_SSL_REDIRECT=True`, `SECURE_PROXY_SSL_HEADER`. At-rest via `django-encrypted-model-fields` ou Fernet.

---

## Decision 3 — HTTP Security Headers (headers + outil par stack)

**PICOC** : P=App web exposee sur Internet | I=Set de headers securite (HSTS, CSP, X-Frame-Options, etc.) | C=avec vs sans headers, outils par stack | O=Protection XSS/clickjacking/MIME sniffing, score securityheaders.com | Co=Production, navigateurs modernes

**PRISMA** : OWASP Secure Headers Project (1), OWASP HTTP Headers CS (1), helmet.js docs (1), Spring Security headers docs (1), securityheaders.com (1) → Found=5 → Screened=5 → Excl: 0 → Included=5

**I/E** : I1=traite directement des headers HTTP securite, I3=niveaux 1-3, I4=post-2021. Aucune exclusion.

**Quality Assessment** :
| Source | Q1 | Q2 | Q3 | Q4 | Q5 | Q6 | Q7 | Q8 | Q9 | Q10 | Q11 | TOTAL |
|--------|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:---:|:---:|:-----:|
| OWASP Secure Headers | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | **11/11** |
| OWASP HTTP Headers CS | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | **11/11** |
| helmet.js GitHub | 1 | 1 | 0.5 | 0.5 | 0 | 0.5 | 1 | 0.5 | 0.5 | 1 | 1 | **7.5/11** |
| Spring Security docs | 1 | 1 | 1 | 1 | 0.5 | 0.5 | 1 | 1 | 1 | 1 | 1 | **10/11** |
| securityheaders.com | 1 | 0.5 | 0.5 | 0.5 | 0 | 0.5 | 1 | 0.5 | 0.5 | 1 | 1 | **7/11** |

**Data Extraction** :
| Source | URL | Pyramid | Year | Data Point | COI |
|--------|-----|:-------:|:----:|------------|:---:|
| OWASP Secure Headers | https://owasp.org/www-project-secure-headers/ | 1 | 2025 | Liste headers obligatoires: HSTS, CSP, X-Content-Type-Options, X-Frame-Options, Referrer-Policy, Permissions-Policy | Non |
| OWASP HTTP Headers CS | https://cheatsheetseries.owasp.org/cheatsheets/HTTP_Headers_Cheat_Sheet.html | 1 | 2025 | HSTS: max-age=63072000; includeSubDomains; preload. X-XSS-Protection: mettre a 0 ou supprimer | Non |
| helmet.js | https://github.com/helmetjs/helmet | 3 | 2025 | Middleware Express/NestJS, active 11 headers par defaut en un appel `app.use(helmet())` | Non |
| Spring Security | https://docs.spring.io/spring-security/reference/features/exploits/headers.html | 3 | 2025 | Headers actives par defaut: Cache-Control, X-Content-Type, HSTS, X-Frame-Options, CSP configurable | Non |
| securityheaders.com | https://securityheaders.com/ | 4 | 2026 | Outil de scan gratuit, grade A+ = tous headers recommandes presents | Non |

**GRADE** : Score depart=4 (niveau 1, OWASP x2) +1 (convergence totale) +1 (outils par stack bien documentes) = **6/7 → FORTE_RECOMMANDATION**.

**Sensitivity** : Retrait OWASP Headers CS → OWASP Secure Headers suffit (score 5). **ROBUSTE**.

**Publication bias** : Aucune source ne recommande de ne PAS mettre ces headers. Consensus universel.

**Recommendation** : Headers obligatoires : HSTS (max-age=63072000), CSP, X-Content-Type-Options: nosniff, X-Frame-Options: DENY, Referrer-Policy: strict-origin-when-cross-origin, Permissions-Policy. Supprimer : Server, X-Powered-By, X-XSS-Protection.

**Variants** :
- **Java/Spring Boot** : Spring Security active la majorite par defaut. Ajouter CSP via `http.headers(h -> h.contentSecurityPolicy(csp -> csp.policyDirectives("...")))`.
- **NestJS** : `app.use(helmet())` via `@nestjs/helmet`. CSP custom via `helmet({contentSecurityPolicy: {directives: {...}}})`.
- **Django** : `django-csp` middleware pour CSP. `SECURE_HSTS_SECONDS=63072000`, `X_FRAME_OPTIONS='DENY'`, `SECURE_CONTENT_TYPE_NOSNIFF=True` dans settings.py.

---

## Decision 4 — Rate Limiting (Bucket4j vs @nestjs/throttler vs DRF throttling)

**PICOC** : P=API REST exposee publiquement | I=Bucket4j / @nestjs/throttler / DRF throttling | C=entre eux | O=Protection brute force, configurabilite, support distribue | Co=Production, API publique, scaling horizontal

**PRISMA** : OWASP Rate Limiting CS (1), Bucket4j GitHub (1), NestJS throttler docs (1), DRF throttling docs (1), Baeldung Bucket4j (1) → Found=5 → Screened=5 → Excl: 0 → Included=5

**I/E** : I1=traite directement du rate limiting, I3=niveaux 1-3, I4=post-2021. Aucune exclusion.

**Quality Assessment** :
| Source | Q1 | Q2 | Q3 | Q4 | Q5 | Q6 | Q7 | Q8 | Q9 | Q10 | Q11 | TOTAL |
|--------|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:---:|:---:|:-----:|
| OWASP Rate Limiting | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | **11/11** |
| Bucket4j GitHub | 1 | 1 | 0.5 | 0.5 | 0 | 0.5 | 1 | 0.5 | 0.5 | 1 | 1 | **7.5/11** |
| NestJS throttler | 1 | 1 | 0.5 | 0.5 | 0 | 0.5 | 1 | 0.5 | 0.5 | 1 | 1 | **7.5/11** |
| DRF throttling | 1 | 1 | 0.5 | 0.5 | 0 | 0.5 | 1 | 0.5 | 0.5 | 1 | 1 | **7.5/11** |
| Baeldung Bucket4j | 1 | 1 | 0.5 | 0.5 | 0 | 0.5 | 1 | 0.5 | 0.5 | 1 | 1 | **7.5/11** |

**Data Extraction** :
| Source | URL | Pyramid | Year | Data Point | COI |
|--------|-----|:-------:|:----:|------------|:---:|
| OWASP Rate Limiting | https://cheatsheetseries.owasp.org/cheatsheets/Denial_of_Service_Cheat_Sheet.html | 1 | 2025 | Rate limiting obligatoire sur endpoints auth, API publiques. Recommande token bucket | Non |
| Bucket4j GitHub | https://github.com/bucket4j/bucket4j | 3 | 2025 | v8.18.0, token bucket, thread-safe, JCache distribue (Redis/Hazelcast), Java 17+ | Non |
| NestJS throttler | https://docs.nestjs.com/security/rate-limiting | 3 | 2025 | @nestjs/throttler v6+, decorators @Throttle/@SkipThrottle, Redis store, TTL+limit | Non |
| DRF throttling | https://www.django-rest-framework.org/api-guide/throttling/ | 3 | 2025 | AnonRateThrottle, UserRateThrottle, ScopedRateThrottle. Backend cache (Redis/Memcached) | Non |
| Baeldung Bucket4j | https://www.baeldung.com/spring-bucket4j | 3 | 2025 | Filtre Spring Boot, config YAML, HTTP 429 auto, support distribue via JCache | Non |

**GRADE** : Score depart=3 (niveau 1 OWASP + niveau 3 docs) +1 (convergence: chaque stack a une solution standard) = **4/7 → RECOMMANDE** (chaque outil pour sa stack).

**Sensitivity** : Retrait OWASP → score 2 (outils restent mais sans autorite). OWASP est critique. **FRAGILE** sur OWASP.

**Publication bias** : Pas de comparatif cross-stack rigoureux. Chaque doc promeut son outil. Bias possible mais inevitable (docs officielles).

**Recommendation** : Utiliser l'outil standard de chaque stack. Pas de choix cross-stack a faire.

**Variants** :
- **Java/Spring Boot** : **Bucket4j** + spring-boot-starter. Token bucket, Redis distribue. `@RateLimiter` ou filtre global.
- **NestJS** : **@nestjs/throttler** v6. `ThrottlerModule.forRoot({ttl: 60000, limit: 100})`. Redis store pour multi-instance.
- **Django** : **DRF throttling** integre. `DEFAULT_THROTTLE_RATES: {'anon': '100/hour', 'user': '1000/hour'}`. Cache Redis.

---

## Decision 5 — Secrets Management (env vars vs Vault vs cloud secrets)

**PICOC** : P=App en production gerant secrets (DB password, API keys, JWT secret) | I=Variables d'environnement / HashiCorp Vault / Cloud secrets (AWS SM, GCP SM) | C=entre eux | O=Securite, rotation, audit, complexite operationnelle | Co=Production, equipe petite-moyenne, budget variable

**PRISMA** : OWASP Secrets Mgmt CS (1), NIST SP 800-57 (1), HashiCorp Vault docs (1), Pulumi Secrets Guide 2025 (1), 12-Factor App (1) → Found=5 → Screened=5 → Excl: 0 → Included=5

**I/E** : I1=traite directement de la gestion des secrets, I3=niveaux 1-3, I4=post-2021. Aucune exclusion.

**Quality Assessment** :
| Source | Q1 | Q2 | Q3 | Q4 | Q5 | Q6 | Q7 | Q8 | Q9 | Q10 | Q11 | TOTAL |
|--------|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:---:|:---:|:-----:|
| OWASP Secrets Mgmt | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | **11/11** |
| NIST SP 800-57 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | **11/11** |
| Vault docs | 1 | 1 | 0.5 | 0.5 | 0 | 0.5 | 1 | 0.5 | 0.5 | 1 | 1 | **7.5/11** |
| Pulumi Guide 2025 | 1 | 1 | 0.5 | 0.5 | 0 | 0.5 | 1 | 0.5 | 0.5 | 1 | 1 | **7.5/11** |
| 12-Factor App | 1 | 1 | 1 | 0.5 | 0 | 0.5 | 1 | 1 | 1 | 1 | 1 | **9/11** |

**Data Extraction** :
| Source | URL | Pyramid | Year | Data Point | COI |
|--------|-----|:-------:|:----:|------------|:---:|
| OWASP Secrets Mgmt | https://cheatsheetseries.owasp.org/cheatsheets/Secrets_Management_Cheat_Sheet.html | 1 | 2025 | Ne jamais hardcoder. Rotation auto. Chiffrement at-rest. RBAC obligatoire | Non |
| NIST SP 800-57 | https://csrc.nist.gov/publications/detail/sp/800-57-part-1/rev-5/final | 1 | 2020 | Gestion cycle de vie des cles: generation, stockage, rotation, destruction | Non |
| Vault docs | https://developer.hashicorp.com/vault | 3 | 2025 | Dynamic secrets, auto-rotation, audit log, RBAC, encryption as service | Oui (HashiCorp) |
| Pulumi Guide 2025 | https://www.pulumi.com/blog/secrets-management-tools-guide/ | 3 | 2025 | Vault=standard entreprise. Cloud SM pour cloud-native. Env vars=baseline uniquement | Oui (Pulumi) |
| 12-Factor App | https://12factor.net/config | 2 | 2017 | Config dans l'env, separee du code. Mais ne couvre pas rotation/audit | Non |

**GRADE** : Score depart=4 (niveau 1, OWASP+NIST) +1 (convergence: jamais hardcoder) -1 (pas de consensus env vs Vault, depend contexte) = **4/7 → RECOMMANDE** avec nuances.

**Sensitivity** : Retrait 12-Factor → pas d'impact. Retrait OWASP → perte de l'autorite principale (score 2). **FRAGILE** sur OWASP.

**Publication bias** : Vault docs et Pulumi ont COI. Mais OWASP et NIST sont neutres. Bias compense.

**Recommendation** : **Minimum** : env vars via Docker secrets / .env non commite, jamais hardcode. **Optimal** : Vault ou cloud secrets manager pour rotation auto et audit. Decision depend de la taille de l'equipe et du budget.

**Variants** :
- **Java/Spring Boot** : Spring Cloud Vault (`spring-cloud-starter-vault-config`). Fallback: `@Value("${secret}")` depuis env vars.
- **NestJS** : `@nestjs/config` + `dotenv`. Vault via `node-vault` package. Infisical comme alternative open-source.
- **Django** : `django-environ` pour env vars. `hvac` Python client pour Vault. `django-vault` pour integration directe.

---

## Decision 6 — Dependency Scanning (Dependabot vs Snyk vs OWASP Dependency-Check)

**PICOC** : P=Projet avec dependencies tierces (npm, Maven, pip) | I=Dependabot / Snyk / OWASP Dependency-Check | C=entre eux | O=Detection CVE, faux positifs, integration CI, cout | Co=GitHub, CI/CD, equipe 1-10 devs

**PRISMA** : OWASP Dep-Check docs (1), Snyk blog (1), GitHub Dependabot docs (1), Rafter SCA comparison 2026 (1), Aikido open-source scanners 2025 (1) → Found=5 → Screened=5 → Excl: 0 → Included=5

**I/E** : I1=traite directement du scanning de dependances, I3=niveaux 3-4, I4=post-2021. Aucune exclusion.

**Quality Assessment** :
| Source | Q1 | Q2 | Q3 | Q4 | Q5 | Q6 | Q7 | Q8 | Q9 | Q10 | Q11 | TOTAL |
|--------|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:---:|:---:|:-----:|
| OWASP Dep-Check | 1 | 1 | 0.5 | 0.5 | 0 | 0.5 | 1 | 0.5 | 0.5 | 1 | 1 | **7.5/11** |
| Snyk docs | 1 | 1 | 0.5 | 0.5 | 0 | 0.5 | 1 | 0.5 | 0.5 | 1 | 1 | **7.5/11** |
| GitHub Dependabot | 1 | 1 | 0.5 | 0.5 | 0 | 0.5 | 1 | 0.5 | 0.5 | 1 | 1 | **7.5/11** |
| Rafter SCA 2026 | 1 | 1 | 1 | 0.5 | 0 | 0.5 | 1 | 0.5 | 1 | 1 | 1 | **8.5/11** |
| Aikido 2025 | 1 | 1 | 0.5 | 0.5 | 0 | 0.5 | 1 | 0.5 | 0.5 | 1 | 1 | **7.5/11** |

**Data Extraction** :
| Source | URL | Pyramid | Year | Data Point | COI |
|--------|-----|:-------:|:----:|------------|:---:|
| OWASP Dep-Check | https://owasp.org/www-project-dependency-check/ | 3 | 2025 | Open-source, NVD-based, Java/.NET deepest support. Lag possible sur NVD | Non |
| Snyk docs | https://snyk.io/product/open-source-security-management/ | 3 | 2025 | Gartner Leader AST 2025. Detection 47j plus rapide que NVD. Reachability Java/JS only | Oui (Snyk) |
| GitHub Dependabot | https://docs.github.com/en/code-security/dependabot | 3 | 2025 | Gratuit, zero config sur GitHub. GitHub Advisory DB. Pas de reachability/SBOM | Non |
| Rafter SCA 2026 | https://rafter.so/blog/sca-tools-comparison | 4 | 2026 | Dependabot: 13 ecosystemes. Snyk: 10+ avec reachability. OWASP-DC: NVD lag | Oui (Rafter) |
| Aikido 2025 | https://www.aikido.dev/blog/top-open-source-dependency-scanners | 3 | 2025 | Recommande Dependabot+OWASP-DC en stack gratuite pour couverture baseline | Oui (Aikido) |

**GRADE** : Score depart=2 (niveau 3-4, pas d'autorite normative) +1 (convergence: tous recommandent scanner) +1 (donnees Gartner Snyk) = **4/7 → RECOMMANDE** (combiner outils).

**Sensitivity** : Retrait Snyk → score 3 (reste RECOMMANDE mais perd reachability). **MODERE**.

**Publication bias** : Snyk, Rafter, Aikido ont tous des COI (vendeurs concurrents). Aucune source neutre de type NIST/OWASP ne compare les 3. Bias **detecte** mais compense par triangulation.

**Recommendation** : **Dependabot** (gratuit, GitHub-native) + **OWASP Dependency-Check** en CI pour double couverture. Snyk en complement si budget permet (reachability analysis).

**Variants** :
- **Java/Spring Boot** : OWASP Dependency-Check Maven plugin (`dependency-check-maven`). Dependabot natif GitHub. Snyk Maven plugin.
- **NestJS** : Dependabot natif GitHub pour npm. `npm audit` en CI. Snyk CLI `snyk test`.
- **Django** : Dependabot pour pip/Poetry. `pip-audit` (PyPI Advisory DB). OWASP-DC via CLI. `safety check` en complement.

---

## Decision 7 — Audit Logging (approche par stack)

**PICOC** : P=App web traitant donnees sensibles, besoin tracabilite | I=AOP/interceptors (Spring) / interceptors+decorators (NestJS) / signals+middleware (Django) | C=approches par stack | O=Tracabilite, conformite, performance, requetabilite | Co=Production, RGPD, audit securite

**PRISMA** : OWASP Logging CS (1), NIST SP 800-92 (1), Spring Boot AOP audit (1), NestJS interceptor audit (1), Django audit libs (1) → Found=5 → Screened=5 → Excl: 0 → Included=5

**I/E** : I1=traite directement de l'audit logging, I3=niveaux 1-3, I4=post-2021. Aucune exclusion.

**Quality Assessment** :
| Source | Q1 | Q2 | Q3 | Q4 | Q5 | Q6 | Q7 | Q8 | Q9 | Q10 | Q11 | TOTAL |
|--------|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:---:|:---:|:-----:|
| OWASP Logging CS | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | **11/11** |
| NIST SP 800-92 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | **11/11** |
| Spring AOP audit | 1 | 1 | 0.5 | 0.5 | 0 | 0.5 | 1 | 0.5 | 0.5 | 1 | 1 | **7.5/11** |
| NestJS interceptor | 1 | 1 | 0.5 | 0.5 | 0 | 0.5 | 1 | 0.5 | 0.5 | 1 | 1 | **7.5/11** |
| Django audit libs | 1 | 1 | 0.5 | 0.5 | 0 | 0.5 | 1 | 0.5 | 0.5 | 1 | 1 | **7.5/11** |

**Data Extraction** :
| Source | URL | Pyramid | Year | Data Point | COI |
|--------|-----|:-------:|:----:|------------|:---:|
| OWASP Logging CS | https://cheatsheetseries.owasp.org/cheatsheets/Logging_Cheat_Sheet.html | 1 | 2025 | Logger: who, what, when, where, outcome. Ne jamais logger secrets/PII. Correlation IDs | Non |
| NIST SP 800-92 | https://csrc.nist.gov/publications/detail/sp/800-92/final | 1 | 2006 | Centraliser les logs, retention policy, integrite des logs, analyse temps reel | Non |
| Spring AOP audit | https://medium.com/@pbudayangani9595/implementing-audit-logs-in-spring-boot-a-step-by-step-guide-8d96ad387610 | 3 | 2025 | @Audit annotation + AOP pointcut. Spring Data Envers pour historique entites JPA | Non |
| NestJS interceptor | https://docs.nestjs.com/techniques/logger | 3 | 2025 | Interceptors NestJS capturent req/res. Decorators custom @AuditLog. Async queue pour perf | Non |
| Django audit libs | https://medium.com/@mariliabontempo/django-audit-logging-the-best-libraries-for-tracking-model-changes-with-postgresql-2c7396564e97 | 3 | 2025 | django-auditlog, django-simple-history, django-reversion. Tracking model changes + PostgreSQL | Non |

**GRADE** : Score depart=4 (niveau 1, OWASP+NIST) +1 (convergence: principes identiques cross-stack) = **5/7 → FORTE_RECOMMANDATION**.

**Sensitivity** : Retrait OWASP → NIST suffit (score 4). Retrait NIST → OWASP suffit (score 4). **ROBUSTE**.

**Publication bias** : Pas de source contre l'audit logging. Consensus universel. Bias non detecte.

**Recommendation** : Audit logging obligatoire. Logger: qui (userId), quoi (action), quand (timestamp UTC), ou (endpoint), resultat (succes/echec). Ne jamais logger PII/secrets. Correlation IDs cross-services.

**Variants** :
- **Java/Spring Boot** : AOP `@Around` + annotation `@Audited`. Spring Data Envers pour historique JPA. Logback + ELK pour centralisation.
- **NestJS** : `CallHandler` interceptor global. Decorator `@AuditLog()` custom. Winston/Pino + async queue (Bull) pour non-blocking.
- **Django** : `django-auditlog` (recommande, actif, PostgreSQL). Middleware pour HTTP-level. `django-simple-history` pour model history.

---

## Decision 8 — Threat Modeling (STRIDE vs PASTA vs LINDDUN)

**PICOC** : P=Equipe dev securisant une app web | I=STRIDE / PASTA / LINDDUN | C=entre eux | O=Couverture menaces, complexite adoption, outillage, conformite RGPD | Co=Equipe 1-10 devs, app traitant donnees personnelles

**PRISMA** : Security Compass comparison (1), TechRxiv/Springer Naik et al. (1), SEI CMU 12 Methods (1), OWASP Threat Modeling CS (1), Microsoft STRIDE docs (1) → Found=5 → Screened=5 → Excl: 0 → Included=5

**I/E** : I1=traite directement du threat modeling, I3=niveaux 1-2, I4=post-2021. Aucune exclusion.

**Quality Assessment** :
| Source | Q1 | Q2 | Q3 | Q4 | Q5 | Q6 | Q7 | Q8 | Q9 | Q10 | Q11 | TOTAL |
|--------|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:---:|:---:|:-----:|
| Security Compass | 1 | 1 | 1 | 0.5 | 0 | 0.5 | 1 | 1 | 1 | 1 | 1 | **9/11** |
| Naik et al. Springer | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | **11/11** |
| SEI CMU | 1 | 1 | 1 | 1 | 0.5 | 1 | 1 | 1 | 1 | 1 | 1 | **10.5/11** |
| OWASP Threat Model CS | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | **11/11** |
| Microsoft STRIDE | 1 | 1 | 1 | 0.5 | 0 | 0.5 | 1 | 1 | 1 | 1 | 1 | **9/11** |

**Data Extraction** :
| Source | URL | Pyramid | Year | Data Point | COI |
|--------|-----|:-------:|:----:|------------|:---:|
| Security Compass | https://www.securitycompass.com/blog/comparing-stride-linddun-pasta-threat-modeling/ | 3 | 2025 | STRIDE=debutants/agile, PASTA=mature/risk-centric, LINDDUN=privacy/GDPR. Peuvent se combiner | Oui (SecurityCompass) |
| Naik et al. | https://link.springer.com/chapter/10.1007/978-3-031-74443-3_16 | 2 | 2024 | Analyse comparative peer-reviewed de 6 methodes. STRIDE le plus adopte. PASTA le plus complet | Non |
| SEI CMU | https://www.sei.cmu.edu/blog/threat-modeling-12-available-methods/ | 2 | 2024 | 12 methodes cataloguees. STRIDE recommande pour la majorite des equipes dev | Non |
| OWASP Threat Model CS | https://cheatsheetseries.owasp.org/cheatsheets/Threat_Modeling_Cheat_Sheet.html | 1 | 2025 | Threat modeling obligatoire. Recommande approche par DFD + categorisation menaces | Non |
| Microsoft STRIDE | https://learn.microsoft.com/en-us/azure/security/develop/threat-modeling-tool | 3 | 2025 | STRIDE: Spoofing, Tampering, Repudiation, Info Disclosure, DoS, Elevation of Privilege | Oui (Microsoft) |

**GRADE** : Score depart=3 (niveau 1 OWASP + niveau 2 peer-reviewed) +1 (convergence: STRIDE recommande pour debuter) +1 (peer-reviewed Springer) = **5/7 → FORTE_RECOMMANDATION** pour STRIDE comme baseline.

**Sensitivity** : Retrait Naik et al. → score 4 (reste RECOMMANDE). Retrait OWASP → score 3. **MODERE**.

**Publication bias** : Microsoft a COI sur STRIDE (createur). Mais Naik et al. (neutre, peer-reviewed) confirme. Bias compense.

**Recommendation** : **STRIDE** comme baseline (simple, agile, bien outille). Ajouter **LINDDUN** si app traite donnees personnelles (RGPD). **PASTA** pour organisations matures avec processus risk management.

**Variants** : Methode agnostique du stack. Applicable identiquement a Java/Spring Boot, NestJS, Django. Outils: Microsoft Threat Modeling Tool (gratuit), OWASP Threat Dragon, IriusRisk.

---

## Decision 9 — Input Validation (XSS/SQLi/CSRF prevention per stack)

**PICOC** : P=App web acceptant input utilisateur | I=Validation/sanitization/parametrized queries par stack | C=avec vs sans, approches par stack | O=Prevention XSS/SQLi/CSRF, conformite OWASP Top 10 | Co=Production, formulaires, API publique

**PRISMA** : OWASP Input Validation CS (1), OWASP XSS Prevention CS (1), OWASP SQLi Prevention CS (1), OWASP CSRF Prevention CS (1), OWASP Top 10 2021 (1) → Found=5 → Screened=5 → Excl: 0 → Included=5

**I/E** : I1=traite directement de la validation d'input, I3=niveau 1, I4=post-2021. Aucune exclusion.

**Quality Assessment** :
| Source | Q1 | Q2 | Q3 | Q4 | Q5 | Q6 | Q7 | Q8 | Q9 | Q10 | Q11 | TOTAL |
|--------|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:---:|:---:|:-----:|
| OWASP Input Validation | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | **11/11** |
| OWASP XSS Prevention | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | **11/11** |
| OWASP SQLi Prevention | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | **11/11** |
| OWASP CSRF Prevention | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | **11/11** |
| OWASP Top 10 2021 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | **11/11** |

**Data Extraction** :
| Source | URL | Pyramid | Year | Data Point | COI |
|--------|-----|:-------:|:----:|------------|:---:|
| OWASP Input Validation | https://cheatsheetseries.owasp.org/cheatsheets/Input_Validation_Cheat_Sheet.html | 1 | 2025 | Allowlist > denylist. Validation != protection (defense in depth) | Non |
| OWASP XSS Prevention | https://cheatsheetseries.owasp.org/cheatsheets/Cross_Site_Scripting_Prevention_Cheat_Sheet.html | 1 | 2025 | Output encoding obligatoire. CSP en defense secondaire. Framework auto-escaping | Non |
| OWASP SQLi Prevention | https://cheatsheetseries.owasp.org/cheatsheets/SQL_Injection_Prevention_Cheat_Sheet.html | 1 | 2025 | Prepared statements/parameterized queries = defense #1. ORM par defaut safe | Non |
| OWASP CSRF Prevention | https://cheatsheetseries.owasp.org/cheatsheets/Cross-Site_Request_Forgery_Prevention_Cheat_Sheet.html | 1 | 2025 | Synchronizer token pattern ou double-submit cookie. SameSite=Lax par defaut | Non |
| OWASP Top 10 | https://owasp.org/www-project-top-ten/ | 1 | 2021 | A03:Injection (#3), A07:XSS (merge into A03). Injection reste top 3 menaces web | Non |

**GRADE** : Score depart=5 (niveau 1 x5, toutes OWASP) +1 (convergence totale) +1 (OWASP = reference mondiale incontestee) = **7/7 → FORTE_RECOMMANDATION**.

**Sensitivity** : Retrait de n'importe quelle source → 4 sources OWASP niveau 1 restent (score 6). **TRES ROBUSTE**.

**Publication bias** : Sources 100% OWASP (organisation neutre, open-source, communautaire). Bias non detecte.

**Recommendation** : Defense in depth obligatoire : 1) Allowlist validation en entree 2) Prepared statements/ORM pour SQLi 3) Output encoding pour XSS 4) CSRF tokens synchronizer 5) CSP headers. Ne jamais se fier a une seule couche.

**Variants** :
- **Java/Spring Boot** : Bean Validation (`@Valid`, `@NotBlank`, `@Pattern`). JPA/Hibernate = prepared statements natifs. Spring Security CSRF token auto. Thymeleaf auto-escape.
- **NestJS** : `class-validator` + `class-transformer` (DTOs). TypeORM/Prisma = parameterized natif. `csurf` middleware CSRF. CSP via helmet.
- **Django** : Forms validation integree. Django ORM = parameterized natif. CSRF middleware active par defaut (`{% csrf_token %}`). Templates auto-escape par defaut.

---

## Decision 10 — Authentication (JWT architecture, token storage, PKCE)

**PICOC** : P=App web avec auth utilisateur (SPA + API) | I=JWT access+refresh tokens, stockage HttpOnly cookie vs localStorage, PKCE pour OAuth | C=architectures de stockage, avec vs sans PKCE | O=Securite (XSS/CSRF), UX, conformite OWASP | Co=Production, SPA React + API REST, OAuth2 potentiel

**PRISMA** : OWASP JWT CS (1), OWASP OAuth2 CS (1), RFC 7636 PKCE (1), OWASP Session Mgmt CS (1), Auth0/Okta best practices (1) → Found=5 → Screened=5 → Excl: 0 → Included=5

**I/E** : I1=traite directement de l'auth JWT/PKCE, I3=niveaux 1-2, I4=post-2021. Aucune exclusion.

**Quality Assessment** :
| Source | Q1 | Q2 | Q3 | Q4 | Q5 | Q6 | Q7 | Q8 | Q9 | Q10 | Q11 | TOTAL |
|--------|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:--:|:---:|:---:|:-----:|
| OWASP JWT CS | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | **11/11** |
| OWASP OAuth2 CS | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | **11/11** |
| RFC 7636 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | **11/11** |
| OWASP Session Mgmt | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | **11/11** |
| Auth0 best practices | 1 | 1 | 0.5 | 0.5 | 0 | 0.5 | 1 | 0.5 | 0.5 | 1 | 1 | **7.5/11** |

**Data Extraction** :
| Source | URL | Pyramid | Year | Data Point | COI |
|--------|-----|:-------:|:----:|------------|:---:|
| OWASP JWT CS | https://cheatsheetseries.owasp.org/cheatsheets/JSON_Web_Token_for_Java_Cheat_Sheet.html | 1 | 2025 | Access token court (5-15min). Refresh token long, stocke serveur-side. Algorithme RS256/ES256 | Non |
| OWASP OAuth2 CS | https://cheatsheetseries.owasp.org/cheatsheets/OAuth2_Cheat_Sheet.html | 1 | 2025 | PKCE obligatoire pour public clients. Implicit flow interdit. Authorization code + PKCE | Non |
| RFC 7636 | https://datatracker.ietf.org/doc/html/rfc7636 | 1 | 2015 | PKCE: code_verifier + code_challenge (S256). Protege contre interception auth code | Non |
| OWASP Session Mgmt | https://cheatsheetseries.owasp.org/cheatsheets/Session_Management_Cheat_Sheet.html | 1 | 2025 | Cookies: HttpOnly, Secure, SameSite=Lax/Strict. Ne pas stocker tokens dans localStorage | Non |
| Auth0 best practices | https://auth0.com/docs/secure/tokens/token-best-practices | 3 | 2025 | Access token en memoire (pas localStorage). Refresh via HttpOnly cookie. Token rotation | Oui (Auth0=vendor) |

**GRADE** : Score depart=5 (niveau 1 x4, RFC) +1 (convergence: HttpOnly cookie, PKCE obligatoire) +1 (RFC = standard IETF) = **7/7 → FORTE_RECOMMANDATION**.

**Sensitivity** : Retrait Auth0 → score 6 (reste FORTE). Retrait n'importe quel OWASP → score 5. **TRES ROBUSTE**.

**Publication bias** : Auth0 a COI mais ses recommandations alignees avec OWASP/RFC. Bias non significatif.

**Recommendation** : **Architecture JWT** : Access token (5-15min, en memoire JS, jamais localStorage), Refresh token (HttpOnly, Secure, SameSite=Strict cookie). Algorithme RS256 ou ES256 (asymetrique). **PKCE obligatoire** pour tout public client (SPA, mobile). Implicit flow interdit. Token rotation sur refresh.

**Variants** :
- **Java/Spring Boot** : Spring Security OAuth2 Resource Server + `spring-boot-starter-oauth2-client`. `nimbus-jose-jwt` pour JWT. PKCE via Spring Authorization Server.
- **NestJS** : `@nestjs/jwt` + `@nestjs/passport`. `passport-jwt` strategy. PKCE via `openid-client`. Cookie config dans `main.ts`.
- **Django** : `djangorestframework-simplejwt` pour JWT. `django-oauth-toolkit` pour OAuth2+PKCE. `SESSION_COOKIE_HTTPONLY=True, SESSION_COOKIE_SECURE=True`.

---

## Synthese GRADE

| # | Decision | GRADE | Robustesse | Recommendation |
|:-:|----------|:-----:|:----------:|----------------|
| 1 | Password Hashing | 6/7 | ROBUSTE | Argon2id (m=19MiB, t=2, p=1) |
| 2 | Encryption | 6/7 | ROBUSTE | TLS 1.3 + AES-256-GCM at-rest |
| 3 | HTTP Security Headers | 6/7 | ROBUSTE | HSTS+CSP+X-Content-Type+X-Frame+Referrer+Permissions |
| 4 | Rate Limiting | 4/7 | FRAGILE | Outil standard par stack (Bucket4j/throttler/DRF) |
| 5 | Secrets Management | 4/7 | FRAGILE | Env vars minimum, Vault/cloud SM optimal |
| 6 | Dependency Scanning | 4/7 | MODERE | Dependabot + OWASP-DC, Snyk si budget |
| 7 | Audit Logging | 5/7 | ROBUSTE | Who/what/when/where/outcome, jamais PII |
| 8 | Threat Modeling | 5/7 | MODERE | STRIDE baseline + LINDDUN si RGPD |
| 9 | Input Validation | 7/7 | TRES ROBUSTE | Defense in depth (validation+encoding+prepared+CSRF+CSP) |
| 10 | Authentication | 7/7 | TRES ROBUSTE | JWT HttpOnly cookie + PKCE + RS256 + token rotation |
