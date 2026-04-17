# Double Extraction — PICOC zero-trust

**Date** : 2026-04-17
**Protocole** : methodology.md v3.0
**Agent A** : mots-clés : "Zero Trust Architecture NIST SP 800-207", "never trust always verify implementation", "BeyondCorp Google enterprise security", "Istio mTLS service mesh zero trust", "least privilege per-request authorization microservices"
**Agent B** : mots-clés : "CISA Zero Trust Maturity Model v2.0 pillars", "assume breach security architecture", "zero trust identity device network workload data", "SPIFFE SPIRE service identity mutual TLS", "zero trust shift location-centric data-centric"

---

## PICOC

```
P  = Équipes architecture et sécurité concevant des systèmes distribués
I  = Implémenter une architecture Zero Trust : "never trust, always verify", least privilege, per-request auth
C  = Sécurité périmétrique (firewall/VPN), trust implicite basé sur localisation réseau
O  = Réduction de la surface d'attaque latérale, conformité EO 14028 / CISA ZTMM
Co = Applications microservices (NestJS / Spring Boot) déployées sur cloud/VPS
```

---

## Accord Reviewer A / Reviewer B

### Sources évaluées par les deux reviewers

| # | Source | Niveau A | Niveau B | Accord inclusion ? | Note divergence |
|---|--------|---------|---------|:-----------------:|-----------------|
| 1 | NIST SP 800-207 — Zero Trust Architecture (2020) | 1 | 1 | ✓ | — |
| 2 | CISA Zero Trust Maturity Model v2.0 (2023) | 1 | 1 | ✓ | — |
| 3 | Ward & Beyer — BeyondCorp: A New Approach to Enterprise Security (Google, USENIX, 2014) | 3 | non trouvé | ✓ A / ✗ B | **Divergence inclusion** |
| 4 | Istio — Security: Mutual TLS and Zero-Trust Network (CNCF Graduated, 2024) | 2 | 2 | ✓ | — |
| 5 | EO 14028 — Executive Order on Improving the Nation's Cybersecurity (White House, 2021) | 1 | 1 | ✗ (contexte, non inclus comme source primaire) | Accord exclusion — cité en contexte réglementaire, pas comme source de guidance technique |

**Sources identifiées par A uniquement** : Ward & Beyer — BeyondCorp 2014 (USENIX ;login: Vol.39 No.6)
**Sources identifiées par B uniquement** : aucune source supplémentaire retenue

**Accord sur inclusion des sources communes** : 3/3 → kappa ≈ 1.0 (inclusion).
**Désaccords d'inclusion** : 1/5 → BeyondCorp 2014 (A seulement).

### Résolution des divergences

**Ward & Beyer — BeyondCorp 2014 (A seulement, niveau 3)** : inclus. Source fondatrice unique documentant le premier déploiement Zero Trust à grande échelle en production réelle — précède le NIST SP 800-207 de six ans et est citée par celui-ci comme référence empirique. Non trouvé par B car ses mots-clés ciblaient le modèle de maturité CISA et les implémentations techniques (SPIFFE, mTLS) plutôt que l'histoire et les preuves de concept fondatrices. Apport différencié essentiel : preuve de faisabilité opérationnelle à grande échelle, non couverte par les sources normatives NIST/CISA.

**Décision de convergence** : BeyondCorp 2014 inclus. Les 3 autres sources sont en accord complet A/B. Total sources incluses : 4.

---

## Calcul GRADE final

```
Score de départ : 4
  (sources les plus hautes = niveau 1 : NIST SP 800-207 + CISA ZTMM v2.0,
   deux sources indépendantes de niveau 1 — score de départ 4 maintenu,
   la seconde source niveau 1 contribue à la convergence, pas au départ)

+ 1 convergence
  NIST SP 800-207 (niveau 1) + CISA ZTMM v2.0 (niveau 1) + Istio CNCF Graduated (niveau 2)
  + BeyondCorp Google (niveau 3) convergent sans contradiction sur :
  - Les 3 principes fondamentaux : never trust always verify, least privilege, assume breach.
  - La progression incrémentale : Identity et Networks avant service mesh.
  - L'identité de service forte comme condition du ZT inter-services (mTLS / SPIFFE).
  4 sources de 3 catégories distinctes : normatif gouvernemental (NIST + CISA),
  implémentation de référence CNCF (Istio), preuve empirique fondatrice (Google BeyondCorp).
  Aucune contradiction entre sources sur les principes ou la séquence de mise en œuvre.

+ 1 effet important
  EO 14028 (2021) mandate la migration ZT pour les systèmes fédéraux américains —
  maturité normative et réglementaire maximale.
  SolarWinds (2020) et attaques par mouvement latéral constituent la classe d'attaques
  exacte que ZT prévient structurellement — démonstration d'effet documentée en production.
  CISA ZTMM v2.0 est directement opposable aux organisations soumises à conformité fédérale.

Score final : 4 + 1 + 1 = 6 → [STANDARD]
```

Note biais de publication : NIST SP 800-207 et CISA ZTMM v2.0 sont des publications gouvernementales officielles, non soumises au biais de publication académique. BeyondCorp est une publication technique d'ingénieur Google dans USENIX — biais possible vers la promotion de l'approche Google, atténué par le fait que la publication date de 2014 (avant que ZT ne devienne un terme marketing) et que ses principes ont été indépendamment validés par NIST et CISA. Istio est documenté par le projet lui-même (CNCF Graduated) — biais vers la promotion du service mesh comme solution, atténué par le fait que la guidance CISA précise explicitement que le service mesh n'est pas obligatoire pour les niveaux Initial et Advanced.

---

## Analyse de sensibilité {#analyse-de-sensibilite}

| Source retirée | Score sans | Niveau sans | Changement ? |
|---------------|-----------|------------|:------------:|
| NIST SP 800-207 | 4+1+1=6 (CISA ZTMM v2.0 reste niveau 1, convergence + effet maintenus) | [STANDARD] | NON |
| CISA ZTMM v2.0 | 4+1+1=6 (NIST SP 800-207 reste niveau 1, convergence + effet maintenus) | [STANDARD] | NON |
| BeyondCorp Google 2014 | 4+1+1=6 (départ et convergence maintenus par NIST + CISA + Istio) | [STANDARD] | NON |
| Istio CNCF 2024 | 4+1+1=6 (NIST + CISA + BeyondCorp maintiennent convergence, effet réglementaire inchangé) | [STANDARD] | NON |
| NIST + CISA simultanément | 2+1+1=4 (départ chute niveau 3 si seulement BeyondCorp + Istio, convergence partielle, effet réduit) | [RECOMMANDE] | OUI |
| Toutes sources niveau 1 et 2 | 2+0=2 (départ niveau 3 BeyondCorp seulement, pas de convergence multi-catégorie) | [BONNE PRATIQUE] | OUI |

**Conclusion : ROBUSTE** — recommandation [STANDARD] stable pour tout retrait individuel de source, y compris le retrait de l'une des deux sources niveau 1. Le seul scénario de déclassement réaliste est le retrait simultané de NIST SP 800-207 et CISA ZTMM v2.0, ce qui est irréaliste : ces deux publications sont des standards gouvernementaux officiels américains en vigueur, non retirés. La convergence sur 4 sources indépendantes de 3 catégories distinctes conforte la robustesse maximale.

---

## Sources exclues

| Source | Critère | Raison |
|--------|---------|--------|
| EO 14028 — Executive Order on Improving the Nation's Cybersecurity (White House, 2021) | E3 | Cité en contexte réglementaire pour le facteur +effet, mais n'apporte pas de guidance technique ou architecturale directe. Contenu technique absorbé par CISA ZTMM v2.0 qui est la concrétisation opérationnelle de l'EO 14028. |
| SPIFFE / SPIRE — Secure Production Identity Framework (CNCF, 2024) | E3 | Documentation technique d'implémentation spécifique (émission d'identités SVID). Contenu absorbé par la documentation Istio qui couvre mTLS + identité de service avec les mêmes références SPIFFE. Candidat pour un variant spécialisé service-mesh. |
| NIST SP 800-63B — Digital Identity Guidelines (NIST, 2017) | E2 | Hors scope PICOC strict — traite de l'assurance d'identité numérique et MFA en général, pas de l'architecture Zero Trust spécifiquement. Pertinent pour le pilier Identity mais pas pour la question architecturale centrale. |
| Forrester Research — Zero Trust eXtended (John Kindervag, 2010) | E1 | Rapport propriétaire non accessible publiquement, non peer-reviewed. Le terme "Zero Trust" est attribué à Kindervag chez Forrester, mais le contenu opérationnel est intégralement absorbé et dépassé par NIST SP 800-207 et CISA ZTMM v2.0. |
| Gartner — CARTA (Continuous Adaptive Risk and Trust Assessment) | E4 | Concept concurrent/complémentaire produit par un cabinet d'analyse commercial. Biais fournisseur significatif. Convergence avec ZT sur la surveillance continue, mais présentation orientée vers des produits commerciaux Gartner Magic Quadrant. |
| Blogs "Zero Trust explained" (multiples sources) | E2 | Sources sans peer review ni validation normative. Nombreuses confusions entre "produit ZT" et "architecture ZT". Non auditables. |
| Vendor whitepapers ZT (Palo Alto, Zscaler, Microsoft) | E4 | Biais commercial explicite — promotion de produits propriétaires. La définition de ZT y est souvent réduite à ce que le vendeur propose. Non inclus. |
