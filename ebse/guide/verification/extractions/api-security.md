# Double Extraction — PICOC api-security

**Date** : 2026-04-17
**Protocole** : methodology.md v3.0
**Agent A** : mots-clés : "NestJS API-to-API authentication service-to-service JWT", "OAuth2 client credentials microservices security", "NIST microservices security strategies", "mTLS service mesh zero trust", "API authentication breach incidents 2024"
**Agent B** : mots-clés : "JWT RFC 9068 OAuth2 access token profile inter-service", "HMAC request signing vs JWT microservices", "Istio mTLS strict permissive NestJS", "OWASP API security broken authentication 2023", "NestJS guards passport JWT implementation"

---

## PICOC

```
P  = Applications NestJS avec multiples services ou modules communiquant via API
I  = Authentification et autorisation API-to-API : JWT service tokens
     (OAuth2 client_credentials), mTLS, API keys hashées, HMAC request signing
C  = Confiance implicite au réseau interne, pas d'authentification inter-services
O  = Security/Authenticity, zero-trust, auditabilité des appels inter-services,
     résistance aux breaches API
Co = Architecture NestJS modulaire ou microservices, Guards NestJS
```

---

## Accord Reviewer A / Reviewer B

### Sources évaluées par les deux reviewers

| # | Source | Niveau A | Niveau B | Accord inclusion ? | Note divergence |
|---|--------|---------|---------|:-----------------:|-----------------|
| 1 | NIST SP 800-204 (2019) | 1 | 1 | ✓ | — |
| 2 | RFC 6749 — OAuth2 Client Credentials Grant (2012) | 1 | 1 | ✓ | — |
| 3 | OWASP API Security Top 10 2023 | 2 | 2 | ✓ | — |
| 4 | NestJS Docs — Guards, Authentication, Microservices (2024) | 3 | 3 | ✓ | — |
| 5 | Salt Security — State of API Security 2024 | 4 | 4 | ✓ | — |
| 6 | NIST SP 800-204A — Service Mesh (2021) | 1 | non trouvé | ✓ A / ✗ B | **Divergence inclusion** |
| 7 | NIST SP 800-204B — ABAC Microservices (2021) | 1 | non trouvé | ✓ A / ✗ B | **Divergence inclusion** |
| 8 | RFC 8705 — OAuth2 mTLS (2020) | 1 | non trouvé | ✓ A / ✗ B | **Divergence inclusion** |
| 9 | Curity — Implementing Zero Trust APIs (2023) | 3 | non trouvé | ✓ A / ✗ B | **Divergence inclusion** |
| 10 | FireTail/Equixly — Top API Breaches 2024 | 4 | non trouvé | ✓ A / ✗ B | **Divergence inclusion** |
| 11 | RFC 7519 — JSON Web Token (2015) | non trouvé | 1 | ✗ A / ✓ B | **Divergence inclusion** |
| 12 | RFC 9068 — JWT Profile for OAuth2 Access Tokens (2021) | non trouvé | 1 | ✗ A / ✓ B | **Divergence inclusion** |
| 13 | Istio Documentation — Security/mTLS (2024) | non trouvé | 3 | ✗ A / ✓ B | **Divergence inclusion** |
| 14 | HMAC comparatifs — Authgear/SSOJet/GitGuardian (2025) | non trouvé | 3-5 | ✗ A / ✓ B | **Divergence inclusion** |
| 15 | OWASP Microservices Security Cheat Sheet (2024) | 2 | non trouvé | ✓ A / ✗ B | **Divergence inclusion** |
| 16 | Medium/DEV — NestJS gRPC + JWT (Saimouah, 2024) | 5 | non trouvé | exclu | **Divergence — exclu E2** |

**Sources identifiées par A uniquement** : NIST 800-204A/B, RFC 8705, OWASP Microservices Cheat Sheet, Curity Zero Trust, FireTail/Equixly
**Sources identifiées par B uniquement** : RFC 7519, RFC 9068, Istio Docs, HMAC comparatifs

**Accord sur inclusion des sources communes** : 5/5 → kappa ≈ 1.0 (inclusion).
**Désaccords d'inclusion** : 10/16 → résolutions ci-dessous.

### Résolution des divergences

**RFC 7519 (B seulement, niveau 1)** : inclus. Standard JWT fondateur sans lequel RFC 9068 ne peut être compris ni appliqué. Non trouvé par A car ses mots-clés ciblaient l'implémentation NestJS plutôt que les standards IETF de base.

**RFC 9068 (B seulement, niveau 1)** : inclus. Définit le profil JWT spécifique aux OAuth2 access tokens avec les claims obligatoires pour les appels inter-services, notamment jti (prévention replay). Source normative IETF directement actionnable. Non trouvé par A pour la même raison que RFC 7519.

**NIST SP 800-204A (A seulement, niveau 1)** : inclus. Extension opérationnelle de NIST 800-204 sur le service mesh et mTLS — complémentaire à la source commune NIST 800-204. Non trouvé par B car ses mots-clés étaient orientés implémentation applicative plutôt que standards infra.

**NIST SP 800-204B (A seulement, niveau 1)** : inclus. Troisième volet de la série NIST 800-204 sur l'autorisation fine-grained ABAC inter-services. Complète le triptyque identité → authentification → autorisation. Non trouvé par B pour la même raison.

**RFC 8705 (A seulement, niveau 1)** : inclus. Renforce OAuth2 avec des certificate-bound access tokens — empêche l'usage de tokens volés même si le réseau est compromis. Source normative IETF pertinente à la matrice de choix mTLS. Non trouvé par B car ses mots-clés ciblaient les comparatifs HMAC/JWT plutôt que les extensions OAuth2.

**Istio Documentation (B seulement, niveau 3)** : inclus. Contextualise mTLS comme alternative transparente (sans modification du code NestJS) via les politiques PeerAuthentication déclaratives. Source opérationnelle directe pour les 3 niveaux de politique (PERMISSIVE → STRICT). Non trouvé par A car ses mots-clés ciblaient les sources NIST plutôt que la documentation des service meshes.

**HMAC comparatifs Authgear/SSOJet/GitGuardian (B seulement, niveau 3-5)** : inclus comme note de positionnement. Délimite le domaine d'application de HMAC (webhooks uniquement, 10-100× plus rapide mais gestion de clés partagées ingérable à l'échelle). Essentiel pour compléter la matrice de choix. Non trouvé par A car ses mots-clés ne couvraient pas les comparatifs HMAC.

**Curity Zero Trust APIs (A seulement, niveau 3)** : inclus. Opérationnalise le zero-trust avec JWT et autorisation décentralisée via scopes/claims — implémentation concrète du principe NIST 800-204. Non trouvé par B car ses mots-clés ne couvraient pas les guides d'implémentation zero-trust.

**OWASP Microservices Security Cheat Sheet (A seulement, niveau 2)** : inclus. Documente les tradeoffs opérationnels mTLS vs JWT (révocation, TTL, latence) — complément essentiel à l'OWASP API Top 10. Non trouvé par B car ses mots-clés ciblaient l'OWASP API Top 10 général plutôt que le cheat sheet microservices.

**FireTail/Equixly (A seulement, niveau 4)** : inclus pour l'illustration des conséquences réelles (T-Mobile 37M, Dropbox, Dell 49M). Biais commercial atténué par la vérifiabilité des incidents cités. Non trouvé par B car ses mots-clés ne couvraient pas les rapports de sécurité d'autres vendors.

**Medium/DEV NestJS gRPC + JWT (A seulement, niveau 5)** : **exclu (E2)**. Blog individuel sans peer review. L'implémentation NestJS Guards est couverte par la documentation officielle NestJS (niveau 3, source commune).

**Décision de convergence** : toutes les divergences résolues en inclusion sauf Medium/DEV (exclu E2). L'ensemble des sources retenues couvre les 4 dimensions nécessaires : normatif (NIST, IETF), guideline communautaire (OWASP), opérationnel NestJS/Istio, et données de marché sur les incidents réels.

---

## Calcul GRADE final

```
Score de départ : 4
  (sources les plus hautes = niveau 1 : NIST SP 800-204/204A/204B,
   RFC 6749, RFC 8705, RFC 7519, RFC 9068 — 7 sources niveau 1)

+ 1 convergence
  7 sources niveau 1 + 2 sources niveau 2 OWASP + NestJS Docs + Curity
  convergent sans contradiction sur :
  1. Zero-trust : jamais de confiance implicite au réseau interne
     (NIST 800-204 + OWASP API2 + Curity + NestJS Docs)
  2. OAuth2 client_credentials + JWT = pattern standard inter-services
     (RFC 6749 + RFC 7519 + RFC 9068 + NestJS Docs)
  3. Claims jti obligatoires pour prévenir le replay
     (RFC 9068 + OWASP Microservices Cheat Sheet)
  4. mTLS = couche complémentaire ou alternative zero-trust
     (NIST 800-204 + RFC 8705 + NIST 800-204A + Istio Docs)
  5. API keys seules insuffisantes — consensus normatif NIST explicite
  Pas de contradiction entre les sources sur ces 5 points.

+ 1 effet important
  Salt Security : 95% APIs avec problèmes, 23% breachées.
  Incidents documentés : Dropbox via API keys, T-Mobile 37M records,
  Dell 49M records. NIST 800-204 prescrit explicitement l'identité
  de workload comme exigence de niveau 1. OWASP API2 maintenu #2
  depuis 4 ans sans amélioration observée.

- 1 indirectness
  Absence d'études empiriques RCT comparant JWT vs mTLS vs API keys
  dans NestJS spécifiquement. Les recommandations sont normatives
  (NIST, IETF) ou basées sur incidents documentés. Salt Security
  et FireTail/Equixly ont un biais commercial potentiel.
  Pas de mesure quantitative du coût de complexité PKI mTLS en
  contexte NestJS réel.

Score final : 4 + 1 + 1 - 1 = 5 → [STANDARD], ROBUSTE
```

Note biais de publication : sources primaires normatives (NIST, IETF RFC) non soumises au biais de publication. Sources OWASP : peer review communautaire. Rapports industrie (Salt Security, FireTail/Equixly) : biais commercial potentiel — atténué par la vérifiabilité des incidents cités et la convergence avec les sources normatives niveau 1 sur les vecteurs d'attaque identifiés.

---

## Analyse de sensibilité {#analyse-de-sensibilite}

| Source retirée | Score sans | Niveau sans | Changement ? |
|---------------|-----------|------------|:------------:|
| NIST SP 800-204 (2019) | 4+1+1-1=5 (6 sources niveau 1 restantes, convergence maintenue) | [STANDARD] | NON |
| Tous les RFC IETF (7519, 6749, 8705, 9068) | 1+1+1-1=2 (départ niveau 2 OWASP, convergence OWASP+NIST, effet important) | [BONNE PRATIQUE] | OUI — scénario irréaliste : RFC IETF sont des standards fondateurs |
| OWASP API Top 10 2023 | 4+1+1-1=5 (NIST+RFC maintiennent convergence) | [STANDARD] | NON |
| Salt Security 2024 + FireTail 2024 | 4+1+0-0=5 (convergence normative maintenue, effet important réduit mais NIST prescriptif reste) | [STANDARD] | NON |
| NestJS Docs + Istio Docs + Curity | 4+1+1-1=5 (convergence normative NIST+RFC+OWASP maintenue) | [STANDARD] | NON |
| RFC 9068 (claims jti) | 4+1+1-1=5 (OWASP Microservices Cheat Sheet couvre la limite JWT offline) | [STANDARD] | NON |
| NIST SP 800-204A + 204B | 4+1+1-1=5 (NIST 800-204 + RFC 8705 couvrent l'essentiel) | [STANDARD] | NON |
| Toutes sources niveau 1 simultanément | 2+0+1-0=3 (départ niveau 2 OWASP, pas de convergence multi-niveaux) | [RECOMMANDE] | OUI — scénario irréaliste : 7 RFC/NIST ne disparaissent pas |

**Conclusion : ROBUSTE** — recommandation [STANDARD] stable pour tout retrait individuel. Le seul scénario de déclassement réaliste serait le retrait simultané de tous les RFC IETF, ce qui est irréaliste (standards fondateurs). La convergence entre les 7 sources niveau 1 (NIST × 3 + RFC × 4) sans contradiction sur les 5 points clés constitue une base solide. L'unique source de fragilité est l'absence d'études empiriques RCT NestJS-spécifiques — déjà capturée dans le malus -1 indirectness.

---

## Sources exclues

| Source | Critère | Raison |
|--------|---------|--------|
| Medium/DEV — NestJS gRPC + JWT (Saimouah, 2024) | E2 | Blog individuel sans peer review. Implémentation NestJS Guards couverte par la documentation officielle NestJS (niveau 3, source commune). |
| Kong — API Security Best Practices (2024) | E3 | Documentation vendor avec biais commercial implicite (vente de Kong API Gateway). Contenu absorbé par OWASP + NIST. |
| Auth0 — Securing Service-to-Service APIs (2023) | E3 | Documentation vendor (Okta/Auth0). Contenu technique correct mais source commerciale. Contenu absorbé par RFC 6749 + RFC 9068 + NestJS Docs. |
| JWT.io documentation | E3 | Documentation outil Auth0. Contenu absorbé par RFC 7519. |
| Kubernetes documentation — Network Policies | E5 | Hors périmètre : traite des politiques réseau niveau 3 (TCP/IP), pas de l'authentification applicative API-to-API. |
| CVE Database — API Authentication vulnerabilities | E1 | Base de données CVE sans synthèse — trop fragmenté pour être utilisé directement. Les incidents pertinents sont capturés via Salt Security et FireTail/Equixly. |
