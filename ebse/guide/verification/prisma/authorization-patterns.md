# PRISMA Flow — PICOC authorization-patterns

**Date de recherche** : 2026-04-17
**Bases interrogées** : NIST CSRC (SP 800-xxx), ANSI/INCITS standards, OWASP (owasp.org), USENIX proceedings, framework docs (Apache Casbin, CASL, Keycloak), WebSearch général
**Mots-clés Agent A** : "RBAC role-based access control standard", "NIST ABAC attribute-based access control", "OWASP authorization broken access control", "authorization patterns web application", "Zanzibar Google ReBAC relationship-based", "Ferraiolo Kuhn NIST RBAC 1992"
**Mots-clés Agent B** : "OWASP ASVS access control verification", "NIST SP 800-162 ABAC guide", "authorization library Node.js TypeScript Casbin CASL", "Keycloak authorization services RBAC ABAC", "Zanzibar USENIX ATC 2019 ReBAC", "broken access control OWASP Top 10 2021"
**Protocole** : methodology.md v3.0 §2.1 — double extraction independante (Agents A + B, mots-cles differents)

---

## Flux

```
IDENTIFICATION
  Sources identifiees par base (Agent A + Agent B combines, avant deduplication) :
    - NIST CSRC (standards normatifs) : 3 sources candidates (SP 800-162, SP 800-207, Ferraiolo 1992)
    - ANSI/INCITS (standards normatifs) : 2 sources candidates (INCITS 359-2012, INCITS 565)
    - OWASP (owasp.org) : 4 sources candidates (Top 10, ASVS, Authorization Cheat Sheet, Testing Guide)
    - USENIX proceedings : 2 sources candidates (Zanzibar ATC 2019, OSDI papers)
    - Framework documentation : 5 sources candidates (Casbin, CASL, Keycloak, OpenFGA, Ory Keto)
    - WebSearch general / peer-reviewed : 4 sources candidates (surveys RBAC/ABAC, arXiv)
    - Snowballing backward (references citees par NIST SP 800-162) : 3 sources
  Total identifie (brut, combine A+B) : ~23
  Doublons retires (meme source identifiee par A et B) : 3 (NIST SP 800-162, OWASP Top 10, Zanzibar)
  Total apres deduplication : ~20

SCREENING (titre + resume)
  Sources screenees : ~20
  Sources exclues au screening : ~9
    - E1 (opinion sans donnees, blog posts securite) : 3
    - E2 (hors scope PICOC — gestion identite, authentication, OAuth2/OIDC) : 3
    - E3 (doublons partiels — INCITS 565 absorbe par INCITS 359-2012) : 1
    - E4 (vendeur sans methodologie transparente — produits SaaS authorization) : 2

ELIGIBILITE (lecture complete)
  Sources evaluees en detail : ~11
  Sources exclues apres lecture complete : 1
    - NIST SP 800-207 (Zero Trust Architecture) : traite de l'autorisation reseau/perimetre,
      pas du modele d'autorisation applicatif — hors PICOC direct (E2)

INCLUSION
  Sources incluses dans la synthese : 10
    - Niveau 1 : 3 (ANSI/INCITS 359-2012, NIST SP 800-162, Ferraiolo & Kuhn 1992)
    - Niveau 2 : 3 (OWASP Top 10 A01:2021, OWASP ASVS V4, OWASP Authorization Cheat Sheet)
    - Niveau 3 : 3 (Apache Casbin docs, CASL docs, Keycloak Authorization Services Guide)
    - Niveau 5 : 1 (Zanzibar Google USENIX ATC 2019)

  Sources exclues avec raison documentee : 1
    - NIST SP 800-207 Zero Trust Architecture : hors PICOC (autorisation reseau, pas applicative)
```

---

## Documentation recherche (Table 2 Kitchenham)

### Agent A — bases interrogees

| Element | Valeur |
|---------|--------|
| Bases | NIST CSRC, ANSI/INCITS catalog, owasp.org, USENIX proceedings, WebSearch general |
| Mots-cles | "RBAC role-based access control standard", "NIST ABAC attribute-based access control", "OWASP authorization broken access control", "Zanzibar Google ReBAC", "Ferraiolo Kuhn NIST RBAC 1992" |
| Periode couverte | 1992-2024 |
| Sources identifiees | ~14 |
| Sources retenues | 6 |
| Date d'extraction | 2026-04-17 |

### Agent B — bases interrogees

| Element | Valeur |
|---------|--------|
| Bases | owasp.org (ASVS + Top 10), framework docs (Casbin, CASL, Keycloak, OpenFGA), NIST CSRC, USENIX |
| Mots-cles | "OWASP ASVS access control verification", "authorization library Node.js TypeScript", "Keycloak authorization services", "Zanzibar USENIX ATC 2019 ReBAC", "broken access control OWASP Top 10 2021" |
| Periode couverte | 2014-2024 |
| Sources identifiees | ~12 |
| Sources retenues | 7 |
| Date d'extraction | 2026-04-17 |

---

## Sources exclues — raisons documentees

| Source | Raison exclusion |
|--------|-----------------|
| NIST SP 800-207 — Zero Trust Architecture | E2 — traite de l'autorisation au niveau reseau/perimetre infrastructure, pas du modele d'autorisation applicatif RBAC/ABAC/ReBAC |
| ANSI/INCITS 565 — Next Generation RBAC | E3 — absorbe par ANSI/INCITS 359-2012 comme version anterieure ; INCITS 359 est la reference normative active |
| OpenFGA documentation | E5 partiel — derive de Zanzibar (deja inclus) ; apport marginal — ReBAC couvert par Zanzibar USENIX |
| Ory Keto documentation | E5 partiel — derive de Zanzibar (deja inclus) ; redundant avec Keycloak pour les framework docs |
| OWASP Testing Guide V4 — Chapter 4.5 Access Control | E3 — absorbe par OWASP ASVS V4 et OWASP Top 10 A01 ; pas d'apport marginal sur le modele d'autorisation |
| Blog posts securite (Auth0, Okta, etc.) | E1 + E4 — niveau 5 redondant avec sources institutionnelles ; biais vendeur potentiel |
| arXiv surveys RBAC/ABAC (papers generiques) | E1 — niveau 4 ou 5 sans methodologie systematique ; absorbes par NIST SP 800-162 qui inclut une revue de la litterature |
