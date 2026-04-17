# PRISMA Flow — PICOC zero-trust

**Date de recherche** : 2026-04-17
**Bases interrogées** : NIST (csrc.nist.gov), CISA (cisa.gov), USENIX proceedings, CNCF / istio.io, SPIFFE/SPIRE documentation, WebSearch général, OWASP (contexte complémentaire)
**Mots-clés Agent A** : "Zero Trust Architecture NIST SP 800-207", "never trust always verify implementation", "BeyondCorp Google enterprise security", "Istio mTLS service mesh zero trust", "least privilege per-request authorization microservices"
**Mots-clés Agent B** : "CISA Zero Trust Maturity Model v2.0 pillars", "assume breach security architecture", "zero trust identity device network workload data", "SPIFFE SPIRE service identity mutual TLS", "zero trust shift location-centric data-centric"
**Protocole** : methodology.md v3.0 §2.1 — double extraction indépendante (Agents A + B, mots-clés différents) + synthèse Agent C

---

## Flux

```
IDENTIFICATION
  Sources identifiées par base (Agent A + Agent B combinés, avant déduplication) :
    - Standards normatifs gouvernementaux (NIST, CISA, White House EO) : 5 résultats candidats
    - Implémentations de référence CNCF (Istio, SPIFFE/SPIRE, Envoy) : ~8 résultats candidats
    - Publications académiques et techniques peer-reviewed (USENIX, IEEE, ACM) : ~6 résultats candidats
    - Rapports analytiques (Forrester, Gartner) : ~4 résultats candidats
    - Documentation vendeurs (Palo Alto, Zscaler, Microsoft ZT) : ~9 résultats candidats
    - Snowballing backward (références citées par NIST SP 800-207 annexe) : ~7 sources
  Total identifié (brut, combiné A+B) : ~39
  Doublons retirés (même source identifiée par A et B) : 4 (NIST SP 800-207, CISA ZTMM v2.0, Istio docs, EO 14028)
  Total après déduplication : ~35

SCREENING (titre + résumé)
  Sources screenées : ~35
  Sources exclues au screening : ~24
    - E1 (blog opinion, définitions marketing ZT sans contenu technique auditable) : ~9
    - E2 (hors scope PICOC — identité seule, MFA seule, sans lien ZT architectural) : ~6
    - E3 (rapport propriétaire non accessible — Forrester original Kindervag) : ~2
    - E4 (whitepapers vendeurs avec biais commercial explicite) : ~7

ELIGIBILITÉ (lecture complète)
  Sources évaluées en détail : ~11
  Sources exclues après lecture complète : ~7
    - Hors scope PICOC strict (identité numérique NIST 800-63B sans lien ZT architectural direct) : 1
    - Biais vendeur disqualifiant (définition ZT réduite aux fonctionnalités produit) : 3
    - Redondance forte sans apport différencié (SPIFFE/SPIRE absorbé par Istio docs) : 2
    - Concept concurrent sans peer review (Gartner CARTA) : 1

INCLUSION
  Sources incluses dans la synthèse : 4
    - Niveau 1 : 2 (NIST SP 800-207, CISA ZTMM v2.0)
    - Niveau 2 : 1 (Istio CNCF Graduated — documentation projet de référence)
    - Niveau 3 : 1 (Ward & Beyer — BeyondCorp, USENIX)

  Sources exclues avec raison documentée : 7
    - EO 14028 (White House, 2021) : contexte réglementaire, guidance technique absorbée par CISA ZTMM v2.0
    - SPIFFE/SPIRE CNCF documentation : absorbé par Istio qui couvre mTLS + SPIFFE de façon intégrée
    - NIST SP 800-63B (Digital Identity) : hors scope architectural ZT — candidat pour PICOC identity-management
    - Forrester Zero Trust (Kindervag, 2010) : rapport propriétaire inaccessible, contenu absorbé par NIST + CISA
    - Gartner CARTA : biais commercial, pas de peer review, usage interne Gartner uniquement
    - Vendor whitepapers ZT (Palo Alto, Zscaler, Microsoft) : biais commercial disqualifiant
    - Blogs/articles "ZT explained" (≥5) : non auditables, nombreuses confusions conceptuelles
```

---

## Documentation recherche (Table 2 Kitchenham)

### Agent A — bases interrogées

| Élément | Valeur |
|---------|--------|
| Bases | NIST CSRC, CISA, USENIX proceedings, CNCF/istio.io, WebSearch général |
| Mots-clés | "Zero Trust Architecture NIST SP 800-207", "never trust always verify implementation", "BeyondCorp Google enterprise security", "Istio mTLS service mesh zero trust", "least privilege per-request authorization microservices" |
| Période couverte | 2014-2024 |
| Sources identifiées | ~22 |
| Sources retenues | 4 (NIST SP 800-207, CISA ZTMM v2.0, BeyondCorp 2014, Istio 2024) |
| Date d'extraction | 2026-04-17 |

### Agent B — bases interrogées

| Élément | Valeur |
|---------|--------|
| Bases | CISA, NIST CSRC, CNCF, SPIFFE/SPIRE docs, White House (EO), WebSearch |
| Mots-clés | "CISA Zero Trust Maturity Model v2.0 pillars", "assume breach security architecture", "zero trust identity device network workload data", "SPIFFE SPIRE service identity mutual TLS", "zero trust shift location-centric data-centric" |
| Période couverte | 2020-2024 |
| Sources identifiées | ~17 |
| Sources retenues | 3 (NIST SP 800-207, CISA ZTMM v2.0, Istio 2024 — convergence élevée avec A ; BeyondCorp non trouvé) |
| Date d'extraction | 2026-04-17 |

---

## Sources exclues — raisons documentées

| Source | Raison exclusion |
|--------|-----------------|
| EO 14028 — Executive Order on Improving the Nation's Cybersecurity (White House, 2021) | Cité en contexte réglementaire pour facteur +effet GRADE. Guidance technique absorbée intégralement par CISA ZTMM v2.0 qui est la concrétisation opérationnelle directe de l'EO. Pas d'apport différencié en tant que source primaire de guidance architecturale. |
| SPIFFE / SPIRE — Secure Production Identity Framework (CNCF, 2024) | Documentation d'implémentation spécifique (émission SVID, bundle SPIFFE). Contenu absorbé par la documentation Istio qui intègre SPIFFE dans le contexte mTLS de façon plus directement actionnable pour le PICOC. Candidat pour un variant spécialisé (zero-trust-service-mesh). |
| NIST SP 800-63B — Digital Identity Guidelines (NIST, 2017, rev. 2024) | Hors scope PICOC strict — traite de l'assurance d'identité et des niveaux AAL (Authentication Assurance Level) sans lien direct avec l'architecture ZT. Pertinent pour le pilier Identity CISA mais ne répond pas à la question architecturale centrale. Candidat pour PICOC identity-management ou mfa-authentication. |
| Forrester Research — Zero Trust eXtended (Kindervag, 2010) | Rapport propriétaire Forrester inaccessible publiquement, non peer-reviewed. Le terme "Zero Trust" y est introduit mais le contenu opérationnel est intégralement absorbé et dépassé par NIST SP 800-207 et CISA ZTMM v2.0. Inclusion non possible sans accès au document primaire. |
| Gartner — CARTA (Continuous Adaptive Risk and Trust Assessment) | Concept propriétaire Gartner sans peer review. Biais commercial significatif vers les produits du Magic Quadrant Gartner. Convergence partielle avec ZT sur la surveillance continue, mais présentation orientée vers des solutions commerciales sans guidance architecturale neutre. |
| Palo Alto Networks — Zero Trust whitepaper | Biais vendeur disqualifiant — définit ZT principalement via les fonctionnalités Prisma Access. |
| Zscaler — Zero Trust Exchange documentation | Biais vendeur disqualifiant — définit ZT comme synonyme de SASE/SSE, réduction du périmètre du concept à l'offre produit. |
| Microsoft — Zero Trust Guidance Center | Partiellement utilisable (alignement NIST), mais biais vers Azure AD / Microsoft 365. Contenu NIST/CISA absorbé par les sources primaires directes sans biais plateforme. |
