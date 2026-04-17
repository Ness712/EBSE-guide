# Double Extraction — PICOC mfa-strategy

**Date** : 2026-04-17
**Protocole** : methodology.md v3.0
**Agent A** : mots-clés : "MFA multifactor authentication web application NIST AAL", "TOTP HOTP RFC 6238 security", "WebAuthn FIDO2 passkeys phishing resistance", "SMS OTP SIM swapping security risks", "MFA fatigue push notification attack mitigation"
**Agent B** : mots-clés : "number matching MFA fatigue CISA", "passkeys adoption rate 2024 2025", "FIDO2 WebAuthn implementation NestJS TypeScript", "SS7 SIM swap account takeover empirical", "otplib simplewebauthn NestJS authentication"

---

## PICOC

```
P  = Applications web avec authentification utilisateur (données sensibles ou personnelles)
I  = Implémenter une stratégie MFA : TOTP (RFC 6238), WebAuthn/passkeys (W3C),
     SMS OTP (déconseillé), push notifications avec number matching
C  = Authentification par mot de passe seul
O  = Sécurité/Authenticité, résistance au phishing, UX acceptable
Co = NestJS TypeScript + React (otplib pour TOTP, @simplewebauthn/server pour WebAuthn)
```

---

## Accord Reviewer A / Reviewer B

### Sources évaluées par les deux reviewers

| # | Source | Niveau A | Niveau B | Accord inclusion ? | Note divergence |
|---|--------|---------|---------|:-----------------:|-----------------|
| 1 | NIST SP 800-63B-4 (2024) | 1 | 1 | ✓ | — |
| 2 | RFC 6238 — TOTP (IETF, 2011) | 1 | 1 | ✓ | — |
| 3 | OWASP MFA Cheat Sheet (2024) | 2 | 2 | ✓ | — |
| 4 | FIDO Alliance Passkey Index 2025 | 3 | 3-4 | ✓ | Niveau légèrement divergent — inclus |
| 5 | @simplewebauthn/server + browser (2024-2025) | 3 | 3 | ✓ | — |
| 6 | RFC 4226 — HOTP (IETF, 2005) | 1 | non trouvé | ✓ A / ✗ B | **Divergence inclusion** |
| 7 | W3C Web Authentication L2 (W3C, 2021) | 1 | non trouvé | ✓ A / ✗ B | **Divergence inclusion** |
| 8 | FIDO Alliance FIDO2/CTAP2 specs (2018-2024) | 2 | non trouvé | ✓ A / ✗ B | **Divergence inclusion** |
| 9 | Microsoft Research Weinert et al. 2023 | 3 | non trouvé | ✓ A / ✗ B | **Divergence inclusion** |
| 10 | Okta — Navigating Credential and Fraud Risks (2023) | 4 | non trouvé | ✓ A / ✗ B | **Divergence inclusion, biais commercial** |
| 11 | FBI/CISA Advisory Salt Typhoon + UK SIM swap (2024) | 2 | non trouvé | ✓ A / ✗ B | **Divergence inclusion** |
| 12 | NestJS Official Docs — Auth + 2FA patterns (2024) | 3 | non trouvé | ✓ A / ✗ B | **Divergence inclusion** |
| 13 | Google Bursztein et al. 2019 | non trouvé | 3-4 | ✗ A / ✓ B | **Divergence inclusion** |
| 14 | CISA — Number Matching in MFA (2022-2023) | non trouvé | 2 | ✗ A / ✓ B | **Divergence inclusion** |
| 15 | Efani/Group-IB/P1Security SS7 + SIM swap (2024) | non trouvé | 3-4 | ✗ A / ✓ B | **Divergence inclusion** |
| 16 | otplib npm documentation (v12.x, 2024) | non trouvé | 3 | ✗ A / ✓ B | **Divergence inclusion** |

**Sources identifiées par A uniquement** : RFC 4226, W3C WebAuthn L2, FIDO Alliance FIDO2/CTAP2 specs, Microsoft Research Weinert 2023, Okta 2023, FBI/CISA Advisory 2024, NestJS Official Docs
**Sources identifiées par B uniquement** : Google Bursztein 2019, CISA Number Matching 2022-2023, Efani/Group-IB/P1Security SS7 rapports, otplib documentation

**Accord sur inclusion des sources communes** : 5/5 → kappa ≈ 1.0 (inclusion).
**Désaccords d'inclusion** : 11/16 → toutes identifiées par un seul agent.

### Résolution des divergences

**RFC 4226 (A seulement, niveau 1)** : inclus. Base algorithmique fondatrice de TOTP — pertinent pour comprendre les limites du modèle à secret partagé (côté serveur = surface d'attaque). Standard IETF niveau 1 non contestable.

**W3C Web Authentication L2 (A seulement, niveau 1)** : inclus. Spécification fondatrice de WebAuthn définissant l'origin binding — mécanisme central de résistance au phishing. Source niveau 1 indispensable.

**FIDO Alliance FIDO2/CTAP2 specs (A seulement, niveau 2)** : inclus. Complémentaire à W3C WebAuthn L2 pour la couche CTAP2 (communication authenticator). Converge sans contradiction.

**Microsoft Research Weinert 2023 (A seulement, niveau 3)** : inclus. Étude empirique large échelle (millions de comptes Microsoft) sur l'efficacité comparative des facteurs. Données quantitatives de référence incontournables dans la littérature MFA. Biais organisationnel documenté dans la note.

**Okta 2023 (A seulement, niveau 4)** : inclus avec note biais commercial explicite. Apporte des données terrain sur la résistance au phishing comparée SMS/FIDO2. À pondérer avec les sources niveaux 1-3.

**FBI/CISA Advisory 2024 (A seulement, niveau 2)** : inclus. Autorité gouvernementale US, données récentes sur SIM swapping — justifie empiriquement le classement RESTRICTED du SMS dans NIST SP 800-63B-4.

**NestJS Official Docs 2024 (A seulement, niveau 3)** : inclus. Référence directe pour le pattern d'implémentation TOTP dans NestJS — actionnable et contextualisé à la stack cible.

**Google Bursztein 2019 (B seulement, niveau 3-4)** : inclus. Référence empirique de facto dans la littérature MFA (large-scale, Google infrastructure). Données comparatives SMS vs security keys sur 3 vecteurs d'attaque. Non trouvé par A car ses mots-clés ciblaient NIST/RFC plutôt que les études d'efficacité.

**CISA Number Matching (B seulement, niveau 2)** : inclus. Spécifique à la mitigation des attaques MFA fatigue — très actionnable. Seule source documentant l'élimination des attaques fatigue en production. Non trouvé par A.

**Efani/Group-IB/P1Security SS7 (B seulement, niveau 3-4)** : inclus via la synthèse dans FBI/CISA Advisory (données UK 2024 et FBI IC3). Les rapports commerciaux individuels (Efani, Group-IB) sont absorbés par la source gouvernementale plus fiable.

**otplib (B seulement, niveau 3)** : inclus. Recommandation concrète stack NestJS — remplace Speakeasy déprécié. Non trouvé par A dont les mots-clés ciblaient les standards plutôt les bibliothèques.

**Décision de convergence** : toutes les divergences résolues — les sources A-only et B-only sont complémentaires (standards + empirique d'un côté, implémentation + contre-mesures spécifiques de l'autre). Accord atteint en session de résolution.

---

## Calcul GRADE final

```
Score de départ : 4
  (sources les plus hautes = niveau 1 : NIST SP 800-63B-4, RFC 6238,
   RFC 4226, W3C WebAuthn L2)

+ 1 convergence
  4 sources niveau 1 (NIST, RFC 6238, RFC 4226, W3C WebAuthn L2)
  + 3 sources niveau 2 (CISA Number Matching, FBI/CISA Advisory, OWASP)
  + FIDO Alliance FIDO2/CTAP2 specs (niveau 2)
  + Microsoft Research Weinert 2023 + Google Bursztein 2019 + FIDO Passkey Index 2025
  convergent sans contradiction sur :
    (1) FIDO2/WebAuthn = gold standard anti-phishing par origin binding
    (2) TOTP admissible AAL2 malgré limites du secret partagé côté serveur
    (3) SMS = RESTRICTED/déprécié pour données PII
  5 contextes distincts : normatif (NIST, RFC, W3C), gouvernemental (CISA, FBI),
  communauté sécurité (OWASP), empirique (Microsoft, Google), industriel (FIDO Alliance)

+ 1 effet important
  Microsoft 99,22% réduction risque ; Google 100% phishing bloqué security keys
  vs 76% SMS (targeted attacks) ; FIDO 93% taux succès passkeys vs 63% traditionnel ;
  CISA : élimination MFA fatigue avec number matching — magnitude non ambiguë

- 1 indirectness
  Études empiriques (Microsoft, Google, Okta) = observational studies depuis leurs
  propres infrastructures, pas des RCT indépendants — biais organisationnel possible.
  Pas d'étude académique peer-reviewed spécifique NestJS+MFA.
  Chiffres Okta (niveau 4) issus d'un rapport commercial.

Score final : 4 + 1 + 1 - 1 = 5 → [STANDARD], ROBUSTE
```

Note biais de publication : sources primaires normatives (NIST, RFC, W3C, OWASP) non soumises au biais de publication. Sources gouvernementales (CISA, FBI) : autorité élevée, méthodologie documentée. Études empiriques (Microsoft, Google) : soumises au biais organisationnel — atténué par la convergence inter-sources et la magnitude des effets. Rapports industriels (FIDO Alliance, Okta) : biais promotionnel possible — signalé dans les notes des sources concernées.

---

## Analyse de sensibilité {#analyse-de-sensibilite}

| Source retirée | Score sans | Niveau sans | Changement ? |
|---------------|-----------|------------|:------------:|
| NIST SP 800-63B-4 | 4+1+1-1=5 (RFC 6238+RFC 4226+W3C restent niveau 1, convergence maintenue) | [STANDARD] | NON |
| RFC 6238 | 4+1+1-1=5 (NIST+RFC 4226+W3C restent niveau 1) | [STANDARD] | NON |
| W3C WebAuthn L2 | 4+1+1-1=5 (3 sources niveau 1 restent, FIDO Alliance spec couvre partiellement) | [STANDARD] | NON |
| Toutes sources niveau 1 simultanément | 2+1+1-1=3 (départ niveau 2, CISA/OWASP/FBI restent) | [RECOMMANDE] | OUI |
| Microsoft Research Weinert 2023 | 4+1+1-1=5 (Google Bursztein couvre l'effet empirique) | [STANDARD] | NON |
| Google Bursztein 2019 | 4+1+1-1=5 (Microsoft Weinert couvre l'effet empirique) | [STANDARD] | NON |
| CISA Number Matching | 4+1+1-1=5 (OWASP couvre partiellement la mitigation MFA fatigue) | [STANDARD] | NON |
| FBI/CISA Advisory 2024 | 4+1+1-1=5 (NIST RESTRICTED classification reste, données SIM swap réduites) | [STANDARD] | NON |
| otplib + NestJS docs (implémentation) | 4+1+1-1=5 (principe reste valide, implémentation moins précise) | [STANDARD] | NON |
| @simplewebauthn documentation | 4+1+1-1=5 (W3C WebAuthn L2 + FIDO specs couvrent la spec fondatrice) | [STANDARD] | NON |
| Okta 2023 (niveau 4) | 4+1+1-1=5 (données terrain couvertes par Microsoft + Google) | [STANDARD] | NON |
| Toutes sources empiriques simultanément | 4+0+0-0=4 (convergence et effet non prouvés sans empirique) | [RECOMMANDE] | OUI |

**Conclusion : ROBUSTE** — recommandation [STANDARD] stable pour tout retrait individuel. Deux scénarios de déclassement à [RECOMMANDE] : (1) retrait simultané de toutes les sources niveau 1 — scénario irréaliste (NIST, RFC, W3C sont des références établies et pérennes) ; (2) retrait de toutes les sources empiriques simultanément — scénario improbable et qui laisserait tout de même 4 sources normatives niveau 1-2 parfaitement convergentes. La convergence sur 5 contextes distincts et la magnitude des effets documentés confèrent une robustesse élevée au [STANDARD].

---

## Sources exclues

| Source | Critère | Raison |
|--------|---------|--------|
| Speakeasy — npm package | E1 + E5 | Bibliothèque dépréciée — remplacée par otplib. Documentation non maintenue. |
| HOTP-based counter tokens (hardware OTP non-FIDO) | E5 | Hors périmètre — technologie pré-WebAuthn sans résistance phishing. Absorbée par RFC 4226 pour la base algorithmique. |
| Authy, Google Authenticator — documentation apps | E3 | Documentation propriétaire d'applications TOTP tierces, biais commercial. Les recommandations d'implémentation côté serveur (otplib, @simplewebauthn) sont indépendantes de l'app authenticator choisie côté utilisateur. |
| Duo Security — MFA whitepaper (2023) | E3 | Rapport commercial Duo/Cisco. Contenu absorbé par OWASP MFA Cheat Sheet et Microsoft Research pour les données quantitatives. |
| passport-local + passport-jwt documentation | E5 | Hors périmètre MFA — concerne l'authentification primaire, pas le second facteur. |
| Blogs Medium/Dev.to "NestJS 2FA tutorial" | E2 | Blogs individuels sans peer review, qualité variable, non auditables. |
| ISO/IEC 29115 — Entity Authentication Assurance Framework | E5 | Standard ISO sur les niveaux d'assurance — absorbé par NIST SP 800-63B-4 qui est plus récent, plus détaillé et référence de facto pour le marché cible (applications web US/international). |
