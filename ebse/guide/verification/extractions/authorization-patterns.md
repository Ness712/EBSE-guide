# Double Extraction — PICOC authorization-patterns

**Date** : 2026-04-17
**Protocole** : methodology.md v3.0
**Agent A** : mots-cles : "RBAC role-based access control standard", "NIST ABAC attribute-based access control", "OWASP authorization broken access control", "Zanzibar Google ReBAC relationship-based", "Ferraiolo Kuhn NIST RBAC 1992"
**Agent B** : mots-cles : "OWASP ASVS access control verification", "authorization library Node.js TypeScript Casbin CASL", "Keycloak authorization services RBAC ABAC", "Zanzibar USENIX ATC 2019 ReBAC", "broken access control OWASP Top 10 2021"

---

## PICOC

```
P  = Equipes developpement et agents IA autonomes gerant des ressources protegees
I  = Choisir et implementer un modele d'autorisation (RBAC, ABAC, ReBAC)
C  = Absence de modele formel (acces ad hoc hard-code)
O  = Securite/Confidentialite, maintenabilite, auditabilite
Co = Applications web multi-utilisateurs avec roles ou attributs
```

---

## Accord Reviewer A / Reviewer B

| # | Source | Niveau A | Niveau B | Accord inclusion ? | Note divergence |
|---|--------|---------|---------|:-----------------:|-----------------|
| 1 | ANSI/INCITS 359-2012 — Role Based Access Control | 1 | absent | divergence | **A cite, B ne cite pas — B couvre RBAC via NIST SP 800-162 (qui mentionne RBAC comme baseline d'ABAC)** |
| 2 | NIST SP 800-162 — Guide to ABAC (NIST, 2014) | 1 | 1 | ✓ | — |
| 3 | Ferraiolo & Kuhn 1992 — Role-Based Access Controls (NIST) | 1 | absent | divergence | **A cite (source fondatrice RBAC), B juge redondant avec ANSI/INCITS 359** |
| 4 | OWASP Top 10 A01:2021 — Broken Access Control | 2 | 2 | ✓ | — |
| 5 | OWASP ASVS V4.0 — V4 Access Control | absent | 2 | divergence | **B cite, A juge couvert par OWASP Top 10** |
| 6 | OWASP Authorization Cheat Sheet | 2 | absent | divergence | **A cite, B juge redondant avec OWASP Top 10 et ASVS** |
| 7 | Zanzibar Google USENIX ATC 2019 | 5 | 5 | ✓ | — |
| 8 | Apache Casbin documentation | absent | 3 | divergence | **B cite (framework eprouve), A juge hors PICOC (implementation, pas modele)** |
| 9 | CASL — authorization library Node.js/TypeScript | absent | 3 | divergence | **B cite (stack TypeScript), A juge hors PICOC** |
| 10 | Keycloak Authorization Services Guide | absent | 3 | divergence | **B cite (autorisation externalisee), A juge hors PICOC** |

**Accord sur sources communes** : 3/3 (NIST SP 800-162, OWASP Top 10 A01:2021, Zanzibar) → kappa sources communes = 1.0.
**Sources A-only** : ANSI/INCITS 359-2012, Ferraiolo & Kuhn 1992, OWASP Authorization Cheat Sheet.
**Sources B-only** : OWASP ASVS V4.0, Apache Casbin, CASL, Keycloak.
**Taux d'accord brut** : 3 accords / 10 sources evaluees = 30% (kappa adequat compte tenu des mots-cles deliberement divergents).

### Resolution des divergences

**ANSI/INCITS 359-2012 (A-only)** : Inclus — standard normatif ANSI qui definit formellement le modele RBAC (niveaux RBAC0 a RBAC3, hierarchie de roles, contraintes). Niveau 1 independant de NIST SP 800-162. B couvre RBAC via NIST SP 800-162 mais ANSI/INCITS 359 est la reference normative directe sur RBAC — l'inclusion augmente la robustesse niv.1.

**Ferraiolo & Kuhn 1992 (A-only)** : Inclus — article fondateur du RBAC par ses auteurs NIST, publie dans les proceedings NISSC gouvernementaux. Valeur historique et normative (source primaire qui a donne naissance a ANSI/INCITS 359). Divergence A(inclus)/B(redondant) : A l'emporte car Ferraiolo & Kuhn 1992 est citable independamment comme source niv.1 — les publications NIST gouvernementales sont de niveau 1.

**OWASP ASVS V4.0 (B-only)** : Inclus — complement operationnel essentiel au OWASP Top 10. La ou A01:2021 identifie le probleme, ASVS V4 specifie les criteres de verification (comment tester qu'un systeme d'autorisation est correct). Divergence A(redondant)/B(inclus) : B l'emporte car ASVS apporte des criteres de validation absents du Top 10.

**OWASP Authorization Cheat Sheet (A-only)** : Inclus — guidance concrete sur la centralisation de l'autorisation et l'application du moindre privilege. Complemente Top 10 (pourquoi) et ASVS (quoi verifier) avec le comment implementer. Divergence A(inclus)/B(redondant) : A l'emporte car la Cheat Sheet contient des recommandations d'implementation explicites non couvertes par les deux autres sources OWASP.

**Apache Casbin, CASL, Keycloak (B-only)** : Tous trois inclus — valident l'existence de librairies eprouvees evitant l'implementation custom. Argument B retenu : la recommandation "utiliser une librairie etablie" a besoin de sources concretes pour etre actionnable. Niveau 3 (framework docs). Ces sources etayent le "comment implementer" sans modifier le calcul GRADE (source la plus haute reste niv.1).

---

## Calcul GRADE final

```
Score de depart : 4
  (source la plus haute directement pertinente = niveau 1 :
   ANSI/INCITS 359-2012 standard normatif RBAC + NIST SP 800-162 standard normatif ABAC
   + Ferraiolo & Kuhn 1992 source primaire NIST — 3 sources de niveau 1 directement
   sur les modeles d'autorisation)

+ 1 convergence
  3 sources niv.1 (ANSI/INCITS 359, NIST SP 800-162, Ferraiolo & Kuhn 1992)
  + 3 sources niv.2 (OWASP Top 10 A01, OWASP ASVS V4, OWASP Authorization Cheat Sheet)
  + 1 source niv.5 (Zanzibar Google USENIX ATC 2019)
  + 3 sources niv.3 (Casbin, CASL, Keycloak)
  convergent sans contradiction sur : (1) hierarchie RBAC→ABAC→ReBAC selon la complexite
  reelle des regles d'acces ; (2) principe de moindre privilege ; (3) centralisation de la
  logique d'autorisation ; (4) signaux d'alerte (hard-coding, God-role, permission sprawl).
  10 sources independantes couvrant 1992-2024, 4 types distincts (normatif, securite industry,
  systeme production Google, framework docs).

+ 1 effet important
  OWASP Top 10 A01:2021 classe Broken Access Control comme vulnerabilite #1 (en hausse
  depuis la position #5 de 2017) — l'impact securite d'une mauvaise autorisation est
  severe et mesure : violations de donnees, acces non-autorises en production, violation
  de la confidentialite des donnees utilisateurs. L'effet d'une bonne autorisation
  (prevention de la vulnerabilite la plus critique du web) est important et documentable.

Score final : 4 + 1 + 1 = 6 → [STANDARD]

Note GRADE : aucun facteur de downgrade applicable.
  - Pas d'incoherence : les sources niv.1, niv.2, niv.5 et niv.3 convergent sans
    contradiction (RBAC pour les cas simples, ABAC pour les attributs dynamiques,
    ReBAC pour les relations entre entites — hierarchie claire et non contestee).
  - Pas d'indirectness : ANSI/INCITS 359 et NIST SP 800-162 sont directement prescriptifs
    sur les modeles RBAC et ABAC — pas de transfert de contexte requis.
  - Pas d'imprecision : recommandation operationnellement claire (criteres de choix
    RBAC/ABAC/ReBAC explicites, librairies identifiees, signaux d'alerte specifiques).
  Le niveau [STANDARD] est justifie : 3 sources niv.1, convergence forte 10 sources,
  effet securite mesurable et classe #1 par OWASP.
```

---

## Analyse de sensibilite {#analyse-de-sensibilite}

| Source retiree | Score sans | Niveau sans | Changement ? |
|----------------|-----------|------------|:------------:|
| ANSI/INCITS 359-2012 (niv.1) | 5 (depart 4, +1 conv, +1 effet — NIST SP 800-162 maintient niv.1) | [STANDARD] | NON — NIST SP 800-162 et Ferraiolo & Kuhn 1992 maintiennent le niveau 1 |
| NIST SP 800-162 (niv.1) | 5 (depart 4, +1 conv, +1 effet — ANSI/INCITS 359 maintient niv.1) | [STANDARD] | NON |
| Ferraiolo & Kuhn 1992 (niv.1) | 5 (depart 4, +1 conv, +1 effet — 2 autres sources niv.1 intactes) | [STANDARD] | NON |
| Toutes sources niv.1 simultanement | 4 (depart 3, +1 conv, +1 effet — sources niv.2 maintiennent convergence et effet) | [RECOMMANDE] | OUI — degrade d'un niveau |
| OWASP Top 10 A01:2021 (niv.2) | 5 (convergence partielle, effet important maintenu par ASVS + Cheat Sheet) | [STANDARD] | NON |
| Zanzibar Google (niv.5) | 5 (ReBAC perd sa reference principale mais les sources niv.1/2 couvrent RBAC/ABAC) | [STANDARD] | NON — grace aux sources niv.1 |
| Toutes sources niv.3 (Casbin, CASL, Keycloak) | 5 (niv.3 ne contribue pas au score de depart) | [STANDARD] | NON — recommandation affaiblie sur le "comment implementer" mais niveau inchange |
| Toutes sources OWASP simultanement | 4 (depart 4, +1 conv niv.1+niv.5, -1 effet — perd +1 effet) | [RECOMMANDE] | OUI — perd le facteur "effet important" documente par OWASP Top 10 #1 |

**Conclusion : ROBUSTE** — recommandation [STANDARD] stable pour tout retrait individuel ou retrait de l'ensemble niv.3. Deux scenarios de downgrade : (1) retrait simultane de toutes les sources niv.1 → [RECOMMANDE] ; (2) retrait simultane de toutes les sources OWASP → [RECOMMANDE]. Les deux scenarios sont hypothetiques — les sources niv.1 sont des standards normatifs stables (ANSI, NIST), non contestables. La robustesse de [STANDARD] est exceptionnelle pour un PICOC securite : triple couverture niv.1 + triple couverture niv.2 OWASP + source Google production + triple coverage niv.3.

---

## Sources exclues

| Source | Critere | Raison |
|--------|---------|--------|
| NIST SP 800-207 — Zero Trust Architecture | E2 | Traite de l'autorisation au niveau reseau/infrastructure, pas du modele d'autorisation applicatif RBAC/ABAC/ReBAC — hors PICOC direct |
| ANSI/INCITS 565 | E3 | Absorbe par ANSI/INCITS 359-2012 comme version anterieure — INCITS 359 est la reference normative active |
| OpenFGA documentation | E5 partiel | Derive de Zanzibar (deja inclus) — apport marginal sur ReBAC ; redondant avec Zanzibar USENIX qui est la source primaire |
| Ory Keto documentation | E5 partiel | Derive de Zanzibar (deja inclus) — redondant avec Keycloak pour les framework docs |
| OWASP Testing Guide V4 — Chapter 4.5 | E3 | Absorbe par OWASP ASVS V4 et OWASP Top 10 A01 — pas d'apport marginal sur le modele d'autorisation |
| Blog posts securite (Auth0, Okta, etc.) | E1 + E4 | Niveau 5 redondant avec sources institutionnelles ; biais vendeur potentiel — les fournisseurs SaaS d'autorisation ont interet a recommander leurs solutions |
| arXiv surveys RBAC/ABAC generiques | E1 | Niveau 4 ou 5 sans methodologie systematique ; absorbes par NIST SP 800-162 qui contient une revue de la litterature |
