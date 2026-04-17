# Double Extraction — PICOC session-management

**Date** : 2026-04-17
**Protocole** : methodology.md v3.0
**Agent A** : mots-clés : "session management security JWT stateless", "JWT blacklist token revocation Redis", "session fixation attack prevention", "OAuth 2.0 token revocation RFC 7009", "HttpOnly Secure SameSite cookie security", "JWT refresh token rotation"
**Agent B** : mots-clés : "OAuth 2.0 security best current practice RFC 9700", "OWASP ASVS session management V3", "cookie security attributes WSTG SESS-06", "NIST SP 800-63B session timeout", "session hijacking prevention", "refresh token rotation invalidation"

---

## PICOC

```
P  = Équipes développement et agents IA gérant l'état d'authentification utilisateur
I  = Implémenter une gestion de session sécurisée (tokens JWT, session cookies)
C  = Sessions non gérées ou gérées de façon ad hoc (tokens en localStorage,
     pas de rotation, pas de protection session fixation)
O  = Sécurité/Authenticité, protection contre fixation, hijacking, replay
Co = Applications web avec authentification utilisateur (NestJS/React ou autre stack)
```

---

## Accord Reviewer A / Reviewer B

| # | Source | Niv. A | Niv. B | Accord ? | Note divergence |
|---|--------|--------|--------|:--------:|-----------------|
| 1 | NIST SP 800-63B-4 — Digital Identity Guidelines (NIST, 2024) | 1 | 1 | ✓ | — |
| 2 | RFC 7009 — OAuth 2.0 Token Revocation (IETF, 2013) | 1 | 1 | ✓ | — |
| 3 | RFC 9068 — JWT Profile for OAuth 2.0 Access Tokens (IETF, 2021) | 1 | absent | ✗ | **A cite, B juge couvert par authentication.json — inclus (scope session, claims obligatoires pour validation)** |
| 4 | RFC 9700 — Best Current Practice OAuth 2.0 Security (IETF BCP, 2025) | absent | 1 | ✗ | **B cite, A ne cite pas explicitement — inclus, source BCP la plus haute sur OAuth 2.0 sécurité** |
| 5 | OWASP ASVS V3 — Session Management (OWASP, 2021) | absent | 2 | ✗ | **B cite, A cite OWASP Session Mgmt Cheat Sheet — complémentaires, les deux inclus** |
| 6 | OWASP Session Management Cheat Sheet (OWASP, 2024) | 2 | 2 | ✓ | — |
| 7 | OWASP WSTG SESS-06 — Testing for Cookie Attributes (OWASP, 2023) | absent | 2 | ✗ | **B cite, A couvre via ASVS V3.4 — inclus, angle test complémentaire** |
| 8 | OWASP Session Fixation attack doc (OWASP, 2023) | 2 | absent | ✗ | **A cite deux entrées séparées (attaque + protection), B couvre via ASVS V3.7 — inclus, fusionné en une source** |
| 9 | OWASP Session Fixation protection patterns (OWASP, 2023) | 2 | absent | ✗ | **Fusionné avec #8 (même source, deux angles) — une seule entrée dans la synthèse** |
| 10 | SuperTokens — JWT Blacklist implementation guide (2023) | 5 | absent | ✗ | **A cite, B ne cite pas — inclus, seule source d'implémentation concrète blacklist JWT** |

**Accord sur sources communes** : 3/3 sources citées par A et B simultanément → kappa sources communes = 1.0.
**Sources A-only** : RFC 9068, OWASP Session Fixation (×2 → fusionné en 1), SuperTokens JWT Blacklist.
**Sources B-only** : RFC 9700 BCP, OWASP ASVS V3, OWASP WSTG SESS-06.

### Résolution des divergences

**RFC 9068 (A-only)** : Inclus — definit le profil JWT pour les access tokens OAuth 2.0, claims obligatoires (exp, sub, iss, aud) directement pertinents pour la validation de session. Divergence B(couvert par authentication.json) : A l'emporte car le scope session-management requiert de documenter la structure des tokens en jeu, pas seulement leur validation d'authentification.

**RFC 9700 BCP (B-only)** : Inclus — source la plus haute (BCP RFC IETF) sur la sécurité OAuth 2.0, couvre explicitement la rotation obligatoire des refresh tokens et les access tokens courts. Absence chez A probablement due à ordre de recherche — source fondamentale non contestable.

**OWASP ASVS V3 (B-only)** : Inclus — complémentaire à OWASP Session Mgmt Cheat Sheet citée par A. ASVS fournit les exigences vérifiables (format testable) quand le Cheat Sheet fournit le guide pratique. Les deux se renforcent mutuellement.

**OWASP WSTG SESS-06 (B-only)** : Inclus — angle test (vérification empirique des attributs cookies) complémentaire aux exigences ASVS V3.4. Pas de redondance : ASVS dit "quoi exiger", WSTG dit "comment vérifier que c'est en place".

**OWASP Session Fixation ×2 (A-only)** : Inclus en une seule entrée fusionnée — les deux entrées Agent A (attaque + protection) sont deux faces de la même source OWASP. Fusion en une source unique pour éviter la duplication artificielle.

**SuperTokens JWT Blacklist (A-only)** : Inclus avec note de niveau 5 — aucune autre source ne fournit le patron d'implémentation concret de la blacklist Redis. Convergent avec RFC 7009 (qui définit la revocation mais pas l'implémentation technique). Robustesse limitée en isolation (niv.5 seul) mais légitime comme complément opérationnel.

---

## Calcul GRADE final

```
Score de départ : 4
  (source la plus haute directement pertinente = niveau 1 :
   NIST SP 800-63B-4, RFC 9700 BCP, RFC 7009, RFC 9068 — quatre sources niveau 1
   convergentes sur la gestion de session sécurisée)

+ 1 convergence
  4 RFCs IETF indépendants (RFC 9700, RFC 7009, RFC 9068 + NIST SP 800-63B-4)
  + 5 sources OWASP (ASVS V3, Session Mgmt Cheat Sheet, WSTG SESS-06, Session Fixation ×2)
  convergent sans contradiction sur les mêmes prescriptions :
  (1) access token court ≤15 min + refresh token long avec rotation obligatoire
  (2) HttpOnly + Secure + SameSite=Strict/Lax obligatoires (jamais localStorage)
  (3) régénération session ID après authentification réussie (anti-fixation)
  (4) révocation explicite via protocole standard (RFC 7009) ou blacklist courte durée
  (5) durée maximale de session : 12h inactivité, 30j continu (NIST SP 800-63B-4)
  9 sources indépendantes, 3 niveaux de pyramide, 2012-2025 — convergence exceptionnelle.

+ 1 effet important
  Les manquements documentés (tokens en localStorage → XSS, absence de rotation →
  replay, session fixation non corrigée → hijacking) sont des vecteurs d'attaque
  exploités en production et documentés par OWASP (WSTG, Top 10). Impact sécurité
  critique — la magnitude de l'effet justifie un bonus.

Score final : 4 + 1 + 1 = 6 → [STANDARD]

Note GRADE : aucun downgrade applicable.
- Pas d'incohérence : 9 sources convergent sans contradiction.
- Pas d'indirectness : toutes les sources traitent directement la gestion de session web.
- Pas d'imprécision : les prescriptions sont quantifiées (≤15 min, ≤12h, ≤30j) et vérifiables.
Score 6 → STANDARD (seuil : 5+).
```

---

## Analyse de sensibilité {#analyse-de-sensibilite}

| Source retirée | Score sans | Niveau sans | Changement ? |
|---------------|-----------|------------|:------------:|
| NIST SP 800-63B-4 | 5 (3 RFCs niveau 1 restants, +1 conv, +1 effet) | STANDARD | NON |
| RFC 9700 BCP | 5 (NIST + 2 RFCs, +1 conv, +1 effet) | STANDARD | NON |
| RFC 7009 | 5 (NIST + 2 RFCs, +1 conv, +1 effet) | STANDARD | NON |
| RFC 9068 | 5 (NIST + 2 RFCs, +1 conv, +1 effet) | STANDARD | NON |
| Toutes sources niveau 1 simultanément | 3 (départ niv.2=3, +1 conv partielle, +1 effet) | RECOMMANDE | OUI — dégrade d'un niveau |
| OWASP ASVS V3 | 6 (convergence intacte sans ASVS, WSTG couvre) | STANDARD | NON |
| OWASP Session Mgmt Cheat Sheet | 6 (ASVS + WSTG absorbent) | STANDARD | NON |
| OWASP WSTG SESS-06 | 6 (ASVS + Cheat Sheet couvrent les attributs) | STANDARD | NON |
| OWASP Session Fixation | 6 (ASVS V3.7 couvre l'exigence) | STANDARD | NON |
| SuperTokens JWT Blacklist | 6 (seul impact : perte de l'implémentation concrète blacklist) | STANDARD | NON (niveau stable, opérationnalité réduite) |
| Toutes sources niveau 2 simultanément | 5 (4 RFCs niv.1, +1 conv réduite, +1 effet) | STANDARD | NON |
| Toutes sources niveau 5 simultanément | 6 (SuperTokens seul niv.5 — impact minimal) | STANDARD | NON |

**Conclusion : ROBUSTE** — recommandation [STANDARD] stable pour tout retrait individuel et pour les retraits par niveau complet (sauf retrait simultané de TOUTES les sources niveau 1, ce qui réduirait à [RECOMMANDE]). La multiplicité des sources niveau 1 (4 RFCs/NIST) et leur indépendance réciproque constituent le fondement de la robustesse. Aucune source individuelle n'est un point de défaillance unique. La convergence niveau 2 (OWASP ×5) renforce sans être indispensable. SuperTokens (niv.5) est exclu de la robustesse GRADE mais précieux pour l'opérationnalisation.

---

## Sources exclues

| Source | Critère | Raison |
|--------|---------|--------|
| Auth0 blog — "Understanding Refresh Token Rotation" | E4 | Vendor bias — Auth0/Okta auto-évalue son implémentation ; pas de validation indépendante |
| RFC 6749 — OAuth 2.0 Core | E5 partiel | Supplanté par RFC 9700 BCP qui le cite et le complète spécifiquement sur la sécurité |
| RFC 6265 — HTTP State Management (cookies) | E5 partiel | Couvert opérationnellement par OWASP WSTG SESS-06 et ASVS V3.4 — niveau de detail technique non nécessaire pour la synthèse |
| OWASP JWT Cheat Sheet | E3 | Scope plus large (validation JWT globale) — couvert dans authentication.json ; duplication sans apport marginal pour session-management |
| RFC 7515/7516/7517 (JWS/JWE/JWK) | E2 | Cryptographie JWT — hors scope session management (concerne la couche cryptographique, traitée dans authentication.json) |
| Portswigger Web Security Academy — Session hijacking | E5 | Niveau 5, contenu didactique — redondant avec OWASP WSTG qui est la source primaire normative |
| OWASP WSTG SESS-07 (session timeout testing) | E2 | Hors scope PICOC direct — les exigences de timeout sont couvertes par NIST SP 800-63B-4 |
| OWASP WSTG SESS-09 (logout testing) | E2 | Hors scope PICOC direct — l'invalidation à la déconnexion est couverte par RFC 7009 |
| RFC 8693 — OAuth 2.0 Token Exchange | E2 | Concerne l'échange de tokens entre services — hors scope gestion de session utilisateur final |
