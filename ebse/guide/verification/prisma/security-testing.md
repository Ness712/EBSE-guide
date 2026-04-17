# PRISMA Flow — security-testing

**Date de recherche** : 2026-04-17
**Agents** : Reviewer A (indépendant) + Reviewer B (indépendant) — contextes séparés
**Bases interrogées** : NIST SP (800-115, 800-218), OWASP (SAMM, WSTG, DevSecOps Guideline, Dependency-Check, ZAP), ACM DL (ISSTA 2024, EASE 2025), IEEE Xplore (EuroS&PW 2024), MDPI Applied Sciences, documentation outils (GitHub, npm, Semgrep, eslint-community), Snyk reports, IDC/Gartner
**Mots-clés Agent A** : "SAST DAST SCA CI/CD pipeline security testing", "shift-left security vulnerability detection cost", "static analysis false positive rate empirical", "DevSecOps NestJS GitHub Actions toolchain", "npm supply chain dependency confusion"
**Mots-clés Agent B** : "DevSecOps maturity model OWASP SAMM CI/CD", "SAST effectiveness comparison real-world deployment", "software composition analysis npm vulnerability", "DAST OWASP ZAP GitHub Actions integration", "NIST SSDF secure software development framework"

---

## Flux PRISMA

```
IDENTIFICATION
  Sources identifiées par base :
    - Standards NIST (SP 800-115, SP 800-218 SSDF)              :  2 références
    - Référentiels OWASP (SAMM, WSTG, DevSecOps Guideline,
      Dependency-Check, ZAP)                                    :  5 références
    - Peer-reviewed empirique ACM/IEEE
      (Charoenwet ISSTA 2024, Feio IEEE EuroS&PW 2024,
       Mateo Tudela MDPI 2020, ACM EASE 2025)                   :  4 références
    - Documentation NIST SAMATE/SATE IV                         :  1 référence
    - Documentation outils (GitHub Dependabot, Semgrep,
      eslint-plugin-security, npm audit)                        :  4 références
    - Rapports sectoriels (Snyk 2024, IDC/Gartner 2024)         :  2 références
    - Sources grises (IBM/NIST shift-left, Dependency
      Confusion incidents, ResearchGate 2025,
      ROI synthèses)                                            :  4 références
    - Snowballing (références croisées)                         : ~3 additionnelles
  Total identifié : ~25
  Doublons retirés : -3
  Total après déduplication : ~22

SCREENING (titre + résumé)
  Sources screenées : 22
  Sources exclues au screening : -7
    - E1 (source non top-tier, contenu absorbé)          : -1 (ResearchGate 2025)
    - E2 (blog/synthèse commerciale sans peer review)    : -3 (ROI synthèses, etc.)
    - E3 (documentation outil à biais commercial)        : -1 (IAST vendors)
    - E4 (données brutes sans analyse)                   : -1 (CVE/NVD raw)
    - E5 (hors périmètre — pentest manuel vs CI/CD)     : -1 (pentest reports)

ÉLIGIBILITÉ (lecture complète)
  Sources évaluées en détail : 15
  Sources exclues après lecture complète : -2
    - Dependency Confusion (A seulement) : conservée après résolution
    - IBM/NIST shift-left (A seulement) : conservée avec nuance après résolution

INCLUSION
  Sources incluses dans la synthèse : 20
    - Niveau 1 (standards normatifs NIST)                        :  2
    - Niveau 2 (référentiels OWASP, référence de premier plan)   :  5
    - Niveau 3 (peer-reviewed empirique ACM/IEEE, docs outils)   : 10
    - Niveau 4 (rapports sectoriels, sources grises avec nuance) :  3
```

---

## Documentation recherche (Table 2 Kitchenham)

| Base | Termes utilisés | Date | Retenus |
|------|----------------|------|---------|
| NIST Publications | "information security testing", "secure software development framework", "static analysis tool exposition" | 2026-04-17 | 3 (800-115, 800-218 SSDF, SAMATE/SATE IV) |
| OWASP | "SAMM maturity model", "web security testing guide", "DevSecOps guideline", "dependency-check", "ZAP full scan" | 2026-04-17 | 5 |
| ACM DL | "SAST vulnerability contributing commits", "SAST effectiveness comparison" | 2026-04-17 | 2 (Charoenwet 2024, EASE 2025) |
| IEEE Xplore | "DevSecOps empirical study CI/CD pipeline" | 2026-04-17 | 1 (Feio EuroS&PW 2024) |
| MDPI Applied Sciences | "SAST DAST IAST benchmark OWASP Top Ten" | 2026-04-17 | 1 (Mateo Tudela 2020) |
| GitHub Docs / npm Docs / Semgrep Docs | "dependabot security updates", "npm audit vulnerabilities", "semgrep typescript ruleset", "eslint-plugin-security" | 2026-04-17 | 4 |
| Snyk / IDC | "state of open source security 2024", "DevSecOps adoption survey" | 2026-04-17 | 2 |
| Sources grises | "IBM shift-left cost", "dependency confusion npm incidents" | 2026-04-17 | 2 (avec nuance) |
| Google Scholar / ResearchGate | "SAST DAST SCA combined CI/CD" | 2026-04-17 | 0 (exclu E1) |
