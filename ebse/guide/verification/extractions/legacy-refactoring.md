# Double Extraction — PICOC legacy-refactoring

**Date** : 2026-04-17
**Protocole** : methodology.md v3.0
**Agent A** : mots-clés : "strangler fig pattern legacy migration", "branch by abstraction refactoring incremental", "big bang rewrite risk software", "legacy code characterization tests", "technical debt refactoring empirical"
**Agent B** : mots-clés : "incremental refactoring vs big bang rewrite comparison", "strangler application pattern Martin Fowler", "working effectively legacy code Feathers", "ISO 14764 software maintenance types", "NestJS Express migration incremental"

---

## PICOC

```
P  = Équipes maintenant un système legacy
I  = Refactoriser de façon incrémentale
     (Strangler Fig, Branch by Abstraction)
C  = Big-bang rewrite
O  = Maintainability / Modifiability
Co = Migration NestJS (ex : Express → NestJS)
```

---

## Accord Reviewer A / Reviewer B

### Sources évaluées par les deux reviewers

| # | Source | Niveau A | Niveau B | Accord inclusion ? | Note divergence |
|---|--------|---------|---------|:-----------------:|-----------------|
| 1 | SWEBOK v4 — KA Software Maintenance (IEEE, 2024) | 1 | 1 | ✓ | — |
| 2 | ISO/IEC/IEEE 14764:2022 — Software Maintenance | 1 | 1 | ✓ | — |
| 3 | Fowler M. — StranglerFigApplication (martinfowler.com, 2004) | 5 | 5 | ✓ | — |
| 4 | Feathers M. — Working Effectively with Legacy Code (2004) | 5 | 5 | ✓ | — |
| 5 | Hammant P. / Fowler M. — Branch by Abstraction (2007/2011) | 5 | 5 | ✓ | — |
| 6 | Spolsky J. — Things You Should Never Do (2000) | 5 | 5 | ✓ | — |
| 7 | Richardson C. — Strangler Fig Microservices (microservices.io, 2023) | 3 | 3 | ✓ | — |
| 8 | Evans E. — Domain-Driven Design (2003) | 5 | 5 | ✗ | Accord exclusion — hors périmètre direct |
| 9 | Martin R. — Clean Architecture (2017) | 5 | 5 | ✗ | Accord exclusion — absorbé par Fowler + Feathers |
| 10 | paulhammant.com — articles CI/CD additionnels | 5 | non trouvé | ✓ A / ✗ B | **Divergence** — résolu : absorbé |

**Sources identifiées par A uniquement** : paulhammant.com articles CI/CD additionnels (exclus après résolution)
**Sources identifiées par B uniquement** : aucune nouvelle

**Accord sur inclusion des sources communes** : 7/8 (hors exclusions d'accord) → kappa ≈ 1.0 (inclusion).
**Désaccords d'inclusion** : 1/10 → paulhammant.com articles CI/CD additionnels.

### Résolution des divergences

**paulhammant.com articles CI/CD additionnels (A seulement, niveau 5)** : exclus. Le contenu pertinent sur Branch by Abstraction est couvert par la source primaire (paulhammant.com 2007 + Fowler martinfowler.com 2011). Les articles CI/CD additionnels de Hammant sur trunk-based development et feature flags sont hors périmètre de ce PICOC (stratégie de migration incrémentale, pas pratiques CI/CD générales).

**Evans E. — Domain-Driven Design (2003)** : exclu (accord A/B). Pertinent pour les bounded contexts dans le contexte Strangler Fig, mais le PICOC porte sur les patterns de migration, pas sur la modélisation du domaine. Hors périmètre direct.

**Martin R. — Clean Architecture (2017)** : exclu (accord A/B). Principes architecturaux généraux sans traitement direct du Strangler Fig ni du code legacy. Absorbé par Fowler (StranglerFig) et Feathers (LegacyCode) qui sont plus spécifiques.

---

## Calcul GRADE final

```
Score de départ : 4
  (source la plus haute = niveau 1 :
   SWEBOK v4 — KA Software Maintenance (IEEE Computer Society, 2024)
   ISO/IEC/IEEE 14764:2022 — Software Life Cycle Processes — Maintenance
   Deux sources niveau 1 → départ = 4)

+ 1 convergence
  SWEBOK v4 (niveau 1) + ISO 14764:2022 (niveau 1)
  + Fowler StranglerFig + Feathers LegacyCode
  + Hammant/Fowler BranchByAbstraction + Spolsky + Richardson
  convergent sans contradiction sur :
  - Incrémental > big-bang (accord universel)
  - Prérequis characterization tests avant tout refactoring (Feathers)
  - Pattern Transform/Coexist/Eliminate (Fowler → Richardson)
  - Abstraction layer pour couches internes (Hammant/Fowler)
  - Anti-pattern big-bang documenté empiriquement (Spolsky/Netscape)
  7 sources de 4 décennies (2000-2024) et contextes distincts :
  normatif IEEE (SWEBOK), international ISO (14764), expert patterns
  (Fowler), expert pratique (Feathers), practitioner (Richardson).

+ 1 effet important
  Spolsky 2000 — Netscape Navigator 4→6 :
  3 ans de développement perdus, perte de part de marché face à IE,
  quasi-faillite de Netscape (rachat par AOL).
  Knight Capital Group (2012) : flags de code legacy non nettoyés →
  440M$ de pertes en 45 minutes (cas documenté dette technique).
  Ces cas illustrent le coût asymétrique et catastrophique du big-bang
  et du code legacy non géré — effets importants documentés.

- 1 indirectness
  Pas de RCT Strangler Fig vs Big Bang — impossible à randomiser
  sur des migrations organisationnelles réelles.
  Les études empiriques sur la dette technique (ICSE, ScienceDirect)
  sont indirectes : elles mesurent l'impact de la dette en général,
  pas spécifiquement l'efficacité comparée du Strangler Fig vs
  autres stratégies de migration.
  Les cas Spolsky/Netscape et Knight Capital sont des études de cas
  uniques — non généralisables statistiquement.

Score final : 4 + 1 + 1 - 1 = 5 → [STANDARD, ROBUSTE]
```

Note biais de publication : les sources primaires normatives (SWEBOK, ISO 14764) ne sont pas soumises au biais de publication. Les livres de référence (Fowler, Feathers) peuvent présenter un biais vers le prescriptif — atténué par la convergence avec les standards normatifs et les données empiriques indirectes. Spolsky (2000) est un article d'opinion d'expert, non peer-reviewed — mais son cas Netscape est factuellement documenté et universellement reconnu dans la littérature SE. Richardson (microservices.io) : source practitioner reconnue dans la communauté microservices.

---

## Analyse de sensibilité {#analyse-de-sensibilite}

| Source retirée | Score sans | Niveau sans | Changement ? |
|---------------|-----------|------------|:------------:|
| SWEBOK v4 KA Maintenance | 4+1+1-1=5 (ISO 14764:2022 maintient le niveau 1, convergence inchangée) | [STANDARD] | NON |
| ISO/IEC/IEEE 14764:2022 | 4+1+1-1=5 (SWEBOK v4 maintient le niveau 1, convergence inchangée) | [STANDARD] | NON |
| Fowler — StranglerFigApplication 2004 | 4+1+1-1=5 (Richardson 2023 couvre partiellement le même pattern) | [STANDARD] | NON |
| Feathers — Working Effectively (2004) | 4+1+1-1=5 (prérequis tests moins documenté, mais convergence maintenue) | [STANDARD] | NON |
| Hammant/Fowler — Branch by Abstraction | 4+1+1-1=5 (Strangler Fig reste, Branch by Abstraction moins documenté) | [STANDARD] | NON |
| Spolsky — Things You Should Never Do (2000) | 4+1+0-1=4 (effet important Netscape absent, mais ISO+SWEBOK maintiennent le niveau) | [RECOMMANDE] | OUI — scénario réaliste : Spolsky est opinion d'expert non peer-reviewed |
| Richardson — Strangler Fig Microservices (2023) | 4+1+1-1=5 (application NestJS moins documentée, principe inchangé) | [STANDARD] | NON |
| SWEBOK v4 + ISO 14764:2022 simultanément | 1+1+1-1=2 (départ = niveau 5, convergence forte, effet important) | [BONNE PRATIQUE] | OUI — scénario irréaliste (deux standards IEEE/ISO établis) |
| Toutes sources niveau 5 simultanément | 4+0+0-0=4 (départ SWEBOK+ISO niveau 1, convergence absente, effet absent) | [RECOMMANDE] | OUI |

**Conclusion : ROBUSTE** — recommandation [STANDARD] stable pour tout retrait individuel sauf Spolsky (2000). Le retrait de Spolsky réduirait le score de 5 à 4 [RECOMMANDE] en supprimant le +1 effet important. Ce déclassement est le seul scénario réaliste car Spolsky est un article d'opinion (non peer-reviewed) — mais son cas Netscape est factuellement vérifiable et universellement référencé. Les deux sources niveau 1 (SWEBOK v4 + ISO 14764:2022) assurent une base normative solide qui maintient la recommandation [STANDARD] même en l'absence des sources niveau 5. La robustesse ROBUSTE reflète cette double couverture normative.

---

## Sources exclues

| Source | Critère | Raison |
|--------|---------|--------|
| Evans E. — Domain-Driven Design (Addison-Wesley, 2003) | E5 | Pertinent pour bounded contexts dans le Strangler Fig, mais hors périmètre direct du PICOC (stratégies de migration, pas modélisation de domaine). |
| Martin R. — Clean Architecture (2017) | E5 | Principes architecturaux généraux. Contenu pertinent absorbé par Fowler StranglerFig et Feathers pour les aspects maintenance. |
| Tornhill A. — Your Code as a Crime Scene (O'Reilly, 2015) | E5 | Outils d'analyse forensique du code legacy. Hors périmètre — le PICOC porte sur les stratégies de migration, pas l'analyse. |
| Newman S. — Building Microservices 2nd ed. (O'Reilly, 2021) | E5 | Traite du Strangler Fig moins en profondeur que Richardson 2023. Absorbé. |
| Kim et al. — DevOps Handbook (IT Revolution, 2016) | E5 | Mentionne la migration incrémentale sans traiter les patterns spécifiques (Strangler Fig, Branch by Abstraction). Hors périmètre précis. |
| Suryanarayana G. et al. — Refactoring for SW Design Smells (2014) | E1 | > 5 ans, non normatif. Couverture partielle des smells de design, sans traitement des stratégies de migration legacy. |
| Blogs "Express to NestJS migration guide" (multiples, 2021-2024) | E2 | Articles individuels sans peer review. Cités comme contexte practitioner dans le texte du principe sans être sources formelles. |
| Microsoft — "Strangler Fig pattern" (docs.microsoft.com, 2024) | E3 | Documentation vendor (Microsoft Azure). Biais vers solutions cloud Microsoft. Contenu conceptuel absorbé par Fowler 2004. |
| paulhammant.com — articles CI/CD additionnels (trunk-based dev) | E5 | Hors périmètre — trunk-based development ≠ stratégie de migration legacy. Contenu Branch by Abstraction absorbé par source primaire (paulhammant.com 2007). |
