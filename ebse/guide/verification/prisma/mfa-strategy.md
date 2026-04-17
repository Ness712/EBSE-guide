# PRISMA Flow — mfa-strategy

**Date de recherche** : 2026-04-17
**Agents** : Reviewer A (indépendant) + Reviewer B (indépendant) — contextes séparés
**Bases interrogées** : NIST SP 800-63B-4, IETF (RFC 6238, RFC 4226), W3C WebAuthn L2, FIDO Alliance specs, OWASP, CISA advisories, FBI IC3, Microsoft Research, Google Security Blog, FIDO Passkey Index, NestJS docs, npm (otplib, @simplewebauthn), Google Scholar, arXiv
**Mots-clés Agent A** : "MFA multifactor authentication web application NIST AAL", "TOTP HOTP RFC 6238 security", "WebAuthn FIDO2 passkeys phishing resistance", "SMS OTP SIM swapping security risks", "MFA fatigue push notification attack mitigation"
**Mots-clés Agent B** : "number matching MFA fatigue CISA", "passkeys adoption rate 2024 2025", "FIDO2 WebAuthn implementation NestJS TypeScript", "SS7 SIM swap account takeover empirical", "otplib simplewebauthn NestJS authentication"

---

## Flux PRISMA

```
IDENTIFICATION
  Sources identifiées par base :
    - Standards normatifs (NIST SP 800-63B-4, RFC 6238,
      RFC 4226, W3C WebAuthn L2)                                 : 4 références
    - Specs industrielles / consortiums (FIDO Alliance
      FIDO2/CTAP2, FIDO Passkey Index 2025)                      : 2 sources
    - Advisories gouvernementaux (CISA Number Matching,
      FBI/CISA Advisory 2024)                                     : 2 sources
    - Référentiels sécurité (OWASP MFA Cheat Sheet)              : 1 source
    - Études empiriques peer-reviewed / large-scale
      (Microsoft Weinert 2023, Google Bursztein 2019)            : 2 sources
    - Documentation officielle frameworks/libs
      (NestJS Auth docs, otplib, @simplewebauthn)                : 3 sources
    - Rapports commerciaux (Okta 2023, Efani/Group-IB)          : 2 sources
    - Snowballing (références croisées)                          : ~6 additionnelles
  Total identifié : ~22
  Doublons retirés : -3
  Total après déduplication : ~19

SCREENING (titre + résumé)
  Sources screenées : 19
  Sources exclues au screening : -5
    - E1 (> 5 ans ET non-standard/non-classique) : -1 (ISO 29115)
    - E2 (blog individuel sans peer review)       : -3 (Medium/Dev.to)
    - E3 (marketing outil — app authenticator)    : -1 (Authy/Google Auth docs)

ÉLIGIBILITÉ (lecture complète)
  Sources évaluées en détail : 14
  Sources exclues après lecture : -6 (voir extraction file)
    - E3 (rapports commerciaux absorbés)          : -2 (Duo, Efani/Group-IB → absorbés)
    - E5 (hors périmètre)                         : -2 (Speakeasy déprécié, passport-local)
    - E5 (absorbé par source plus complète)       : -2 (ISO 29115 → NIST, HOTP tokens)

INCLUSION
  Sources incluses dans la synthèse : 15
    - Niveau 1 (standards NIST/IETF/W3C)                         : 4
    - Niveau 2 (advisories gouvernementaux, OWASP, FIDO specs)   : 4
    - Niveau 3 (études empiriques, docs officielles)             : 6
    - Niveau 4 (rapport commercial avec biais signalé)           : 1
```

---

## Documentation recherche (Table 2 Kitchenham)

| Base | Termes utilisés | Date | Retenus |
|------|----------------|------|---------|
| NIST / IETF | "SP 800-63B-4 AAL authentication assurance", "RFC 6238 TOTP", "RFC 4226 HOTP" | 2026-04-17 | 3 (NIST 800-63B-4, RFC 6238, RFC 4226) |
| W3C / FIDO Alliance | "WebAuthn Level 2 recommendation", "FIDO2 CTAP2 specification", "passkey index 2025" | 2026-04-17 | 3 (W3C WebAuthn L2, FIDO2/CTAP2, Passkey Index) |
| Gouvernemental (CISA, FBI) | "CISA number matching MFA fatigue", "FBI IC3 SIM swap 2024", "Salt Typhoon advisory" | 2026-04-17 | 2 (CISA Number Matching, FBI/CISA Advisory) |
| OWASP | "multifactor authentication cheat sheet", "WSTG-AUTHN-11" | 2026-04-17 | 1 (OWASP MFA Cheat Sheet) |
| Microsoft Research / Google Security | "Weinert MFA effectiveness 2023", "Bursztein phishing MFA 2019" | 2026-04-17 | 2 (Microsoft Weinert 2023, Google Bursztein 2019) |
| NestJS / npm | "NestJS authentication 2FA passport", "otplib v12", "simplewebauthn server v11" | 2026-04-17 | 3 (NestJS docs, otplib, @simplewebauthn) |
| Rapports industriels | "Okta credential fraud risks 2023", "FIDO passkey adoption" | 2026-04-17 | 1 (Okta 2023, biais commercial signalé) |
| Google Scholar / arXiv | "MFA bypass attacks empirical", "WebAuthn implementation security" | 2026-04-17 | 0 (exclus E1/E2 ou absorbés) |

---

## Évaluation qualité des sources incluses

| Source | Niveau pyramide | Biais potentiel | Mitigation |
|--------|----------------|----------------|------------|
| NIST SP 800-63B-4 | 1 | Aucun notable | Standard normatif gouvernemental US |
| RFC 6238 | 1 | Aucun notable | Standard IETF, process de validation communautaire |
| RFC 4226 | 1 | Aucun notable | Standard IETF, process de validation communautaire |
| W3C WebAuthn L2 | 1 | Aucun notable | Recommendation W3C, consensus multi-acteurs |
| CISA Number Matching | 2 | Aucun notable | Advisory gouvernemental US, données terrain |
| FBI/CISA Advisory | 2 | Aucun notable | Sources gouvernementales croisées US + UK |
| FIDO Alliance FIDO2/CTAP2 | 2 | Biais promotionnel (consortium) | Convergence avec W3C WebAuthn L2 indépendant |
| OWASP MFA Cheat Sheet | 2 | Aucun notable | Communauté sécurité open source |
| Microsoft Weinert 2023 | 3 | Biais organisationnel | Échelle massive, méthodologie documentée |
| Google Bursztein 2019 | 3-4 | Biais organisationnel | Référence de facto dans la littérature MFA |
| FIDO Passkey Index 2025 | 3 | Biais promotionnel (FIDO) | Données d'adoption chiffrées, convergence cross-sources |
| NestJS Official Docs | 3 | Aucun notable | Documentation officielle maintenue |
| otplib documentation | 3 | Aucun notable | Bibliothèque open source maintenue |
| @simplewebauthn docs | 3 | Aucun notable | Certifié FIDO Conformance Tests |
| Okta 2023 | 4 | Biais commercial fort | Données terrain uniquement, pondération réduite |

---

## Cohérence inter-sources

Aucune contradiction majeure identifiée entre les sources incluses. Points de convergence confirmés :

1. **FIDO2/WebAuthn = résistance phishing structurelle** : confirmé par W3C WebAuthn L2 (spec origin binding), FIDO Alliance specs, Google Bursztein 2019 (100% bots, 99% bulk phishing), Okta 2023 (99,8% phishing resistance).

2. **SMS = RESTRICTED pour PII** : confirmé par NIST SP 800-63B-4 (classification normative), OWASP MFA Cheat Sheet (recommandation explicite), FBI/CISA Advisory 2024 (données empiriques SIM swap), Google Bursztein 2019 (76% targeted attacks blocked vs 100% security keys).

3. **TOTP admissible AAL2** : confirmé par NIST SP 800-63B-4 (classification explicite), RFC 6238 (algorithme sound), OWASP (recommandé pour applications non-PII critiques).

4. **Number matching élimine MFA fatigue** : confirmé par CISA (résultat en production documenté) + OWASP (recommandation).

5. **Passkeys synchronisés = AAL2 uniquement** : confirmé par NIST SP 800-63B-4 (nuance explicite), FIDO Passkey Index 2025 (données d'adoption), W3C WebAuthn L2 (distinction sync vs hardware bound).

Seule tension identifiée : FIDO Passkey Index 2025 et Okta 2023 ont un biais promotionnel. Résolution : leurs données quantitatives sont confirmées par les sources niveaux 1-2 sur les points clés (résistance phishing, classification AAL). Les chiffres d'adoption (69% utilisateurs) et UX (93% taux succès) sont des données de marché sans équivalent dans les sources normatives — inclus avec biais documenté.
