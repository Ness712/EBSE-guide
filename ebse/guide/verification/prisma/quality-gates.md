# PRISMA Flow — PICOC quality-gates

**Date de recherche** : 2026-04-17
**Bases interrogées** : ISO/IEC standards, IEEE Xplore, ACM Digital Library, OWASP (DevSecOps, SDL, Code Review), SonarQube documentation, NIH/PubMed Central, Martin Fowler bliki, WebSearch général
**Mots-clés Agent A** : "quality gates CI/CD pipeline", "SonarQube quality gate configuration", "SAST static analysis security testing CI", "code coverage threshold automated gate", "technical debt measurement metrics", "Clean as You Code SonarQube"
**Mots-clés Agent B** : "software maintainability metrics quality gate", "cyclomatic complexity maintenance correlation", "ISO 25010 maintainability analysability", "technical debt operationalization CI", "PMD rulesets defect correlation", "OWASP secure code review automated"
**Protocole** : methodology.md v3.0 §2.1 — double extraction indépendante (Agents A + B, mots-clés différents) + synthèse Agent C

---

## Flux

```
IDENTIFICATION
  Sources identifiées par base (Agent A + Agent B combinés, avant déduplication) :
    - Standards normatifs (ISO/IEC 25010, IEEE standards) : 4 résultats candidats
    - Études empiriques IEEE/ACM (ESEM, ISSTA, TSE, JSS) : ~14 résultats candidats
    - OWASP (DevSecOps, SDL, Code Review Guide, Cheat Sheets) : ~8 résultats candidats
    - Documentation outil (SonarQube, Checkstyle, PMD) : ~6 résultats candidats
    - Expert / littérature grise (Cunningham, Fowler, blogs) : ~10 résultats candidats
    - Snowballing backward (références citées par sources principales) : ~8 sources
  Total identifié (brut, combiné A+B) : ~50
  Doublons retirés (même source identifiée par A et B) : 8 (ISO 25010, Gill & Kemerer 1991,
    ESEM 2022, ISSTA 2024, JSS 2019, OWASP DevSecOps, SonarQube docs, Cunningham 1992)
  Total après déduplication : ~42

SCREENING (titre + résumé)
  Sources screenées : ~42
  Sources exclues au screening : ~26
    - E1 (blog opinion sans données ou méthodologie) : ~10
    - E2 (hors scope PICOC — outils CI/CD généraux sans quality gates spécifiques) : ~7
    - E3 (doublons partiels — couverts par sources primaires déjà incluses) : ~5
    - E4 (vendeur / marketing sans substance technique) : ~4

ELIGIBILITÉ (lecture complète)
  Sources évaluées en détail : ~16
  Sources exclues après lecture complète : ~1
    - Hors scope PICOC strict (outil CI/CD sans lien quality gate / maintenabilité) : 1

INCLUSION
  Sources incluses dans la synthèse : 15
    - Niveau 1 : 8 (ISO 25010:2023, Gill & Kemerer IEEE TSE 1991, PMC 2020,
        Di Penta ESEM 2022, IEEE Software 2023, ISSTA 2024, JSS Elsevier 2019, IEEE 2009)
    - Niveau 2 : 4 (OWASP DevSecOps 2023, OWASP SDL 2023,
        OWASP Code Review Guide 2017, OWASP Secure Code Review Cheat Sheet 2023)
    - Niveau 3 : 1 (SonarQube documentation 2024)
    - Niveau 5 : 2 (Cunningham OOPSLA 1992, Fowler TechnicalDebt bliki 2019)

  Sources exclues avec raison documentée : voir section ci-dessous
```

---

## Documentation recherche (Table 2 Kitchenham)

### Agent A — bases interrogées

| Élément | Valeur |
|---------|--------|
| Bases | ACM Digital Library, IEEE Xplore, OWASP, SonarQube docs, WebSearch général |
| Mots-clés | "quality gates CI/CD pipeline", "SonarQube quality gate configuration", "SAST static analysis security testing CI", "code coverage threshold automated gate", "technical debt measurement metrics", "Clean as You Code SonarQube" |
| Période couverte | 1991-2024 |
| Sources identifiées | ~24 |
| Sources retenues | 8 |
| Date d'extraction | 2026-04-17 |

### Agent B — bases interrogées

| Élément | Valeur |
|---------|--------|
| Bases | ISO/IEC, IEEE Xplore, NIH/PubMed Central, OWASP, Martin Fowler bliki, WebSearch |
| Mots-clés | "software maintainability metrics quality gate", "cyclomatic complexity maintenance correlation", "ISO 25010 maintainability analysability", "technical debt operationalization CI", "PMD rulesets defect correlation", "OWASP secure code review automated" |
| Période couverte | 1991-2024 |
| Sources identifiées | ~26 |
| Sources retenues | 9 (convergence élevée avec A + PMC 2020, IEEE 2009, Fowler, OWASP Cheat Sheet en plus) |
| Date d'extraction | 2026-04-17 |

---

## Sources exclues — raisons documentées

| Source | Raison exclusion |
|--------|-----------------|
| McCabe T.J. — A Complexity Measure (IEEE TSE, 1976) | Supplanté — absorbé par Gill & Kemerer 1991 qui applique la complexité cyclomatique à la maintenance avec données empiriques plus récentes et directement pertinentes |
| SonarQube SQALE method documentation | Redondance — modèle SQALE de dette technique couvert par IEEE Software 2023 + SonarQube docs déjà incluses |
| GitHub Actions documentation (quality gate steps) | Hors scope — implémentation CI/CD générique, pas de guidance sur les seuils ou métriques quality gate |
| Veracode/Checkmarx vendor reports | E4 — rapports vendeurs sans méthodologie indépendante ; SAST couvert par ISSTA 2024 et JSS 2019 |
| Blog posts SonarQube (Sonar blog) | Redondance niveau 5 — couverts par la documentation officielle SonarQube (niveau 3) déjà incluse |
| Surveys académiques "CI/CD adoption" (≥5 articles) | Indirects — mesurent l'adoption CI/CD en général sans focus quality gates ; absorbés par ESEM 2022 et IEEE Software 2023 |
| OWASP ASVS v4 — Testing metrics | Redondance — couvert par OWASP DevSecOps 2023 + OWASP SDL 2023 sans apport différencié pour les quality gates |