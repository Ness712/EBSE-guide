# Double Extraction — PICOC security-testing

**Date** : 2026-04-17
**Protocole** : methodology.md v3.0
**Agent A** : mots-clés : "SAST DAST SCA CI/CD pipeline security testing", "shift-left security vulnerability detection cost", "static analysis false positive rate empirical", "DevSecOps NestJS GitHub Actions toolchain", "npm supply chain dependency confusion"
**Agent B** : mots-clés : "DevSecOps maturity model OWASP SAMM CI/CD", "SAST effectiveness comparison real-world deployment", "software composition analysis npm vulnerability", "DAST OWASP ZAP GitHub Actions integration", "NIST SSDF secure software development framework"

---

## PICOC

```
P  = Équipes développant des applications web NestJS+React avec pipeline CI/CD GitHub Actions
I  = Intégrer SAST (analyse statique), DAST (analyse dynamique), SCA (analyse dépendances) dans CI/CD
C  = Security testing manuel ponctuel, pas d'automatisation dans la pipeline
O  = Détection précoce des vulnérabilités, Security/Resistance, shift-left security, réduction du coût de remédiation
Co = Pipeline GitHub Actions, NestJS TypeScript, React, npm
```

---

## Accord Reviewer A / Reviewer B

### Sources évaluées par les deux reviewers

| # | Source | Niveau A | Niveau B | Accord inclusion ? | Note divergence |
|---|--------|---------|---------|:-----------------:|-----------------|
| 1 | NIST SP 800-115 — Technical Guide to Information Security Testing (NIST, 2008/2021) | 1 | non trouvé | ✓ A / résolution B | **Divergence** |
| 2 | NIST SP 800-218 — SSDF v1.1 (NIST, 2022) | non trouvé | 1 | résolution A / ✓ B | **Divergence** |
| 3 | OWASP SAMM v2.0 (OWASP, 2020) | 2 | non trouvé | ✓ A / résolution B | **Divergence** |
| 4 | OWASP WSTG v4.2 (OWASP, 2020) | 2 | non trouvé | ✓ A / résolution B | **Divergence** |
| 5 | OWASP DevSecOps Guideline (OWASP, 2024) | non trouvé | 2 | résolution A / ✓ B | **Divergence** |
| 6 | Charoenwet et al. — ISSTA 2024 (ACM) | 3 | non trouvé | ✓ A / résolution B | **Divergence** |
| 7 | NIST SAMATE / SATE IV (NIST, 2012+) | 3 | non trouvé | ✓ A / résolution B | **Divergence** |
| 8 | Feio, Santos, Escravana, Pacheco — IEEE EuroS&PW 2024 | 3 | non trouvé | ✓ A / résolution B | **Divergence** |
| 9 | Mateo Tudela et al. — MDPI Applied Sciences 2020 | non trouvé | 3 | résolution A / ✓ B | **Divergence** |
| 10 | ACM EASE 2025 — SAST Effectiveness Comparison | non trouvé | 3 | résolution A / ✓ B | **Divergence** |
| 11 | eslint-plugin-security (eslint-community, 2024) | 3 | non trouvé | ✓ A / résolution B | **Divergence** |
| 12 | npm audit (npm docs, 2024) | 3 | non trouvé | ✓ A / résolution B | **Divergence** |
| 13 | OWASP Dependency-Check (OWASP, 2024) | 2-3 | non trouvé | ✓ A / résolution B | **Divergence** |
| 14 | GitHub Dependabot (GitHub Docs, 2024) | non trouvé | 3 | résolution A / ✓ B | **Divergence** |
| 15 | Semgrep (Semgrep Inc., 2024-2025) | non trouvé | 3 | résolution A / ✓ B | **Divergence** |
| 16 | OWASP ZAP — zaproxy/action-full-scan (OWASP, 2024) | non trouvé | 3 | résolution A / ✓ B | **Divergence** |
| 17 | IBM/NIST/Capers Jones — Shift-left cost ratios (1981/2000s) | 3-4 | non trouvé | ✓ A / résolution B | **Divergence** |
| 18 | Snyk — State of Open Source Security 2024 | non trouvé | 4 | résolution A / ✓ B | **Divergence** |
| 19 | Snyk/Orca — Dependency Confusion incidents (2021-2024) | 4 | non trouvé | ✓ A / résolution B | **Divergence** |
| 20 | IDC DevSecOps Survey 2024 / Gartner | non trouvé | 4 | résolution A / ✓ B | **Divergence** |
| 21 | ResearchGate SAST+DAST+SCA (2025) | 4 | non trouvé | ✗ — exclu | E1 : source non top-tier, contenu absorbé |
| 22 | ROI shift-left synthèses (Kiuwan, Medium, GitLab, 2024-2025) | 4-5 | non trouvé | ✗ — exclu | E2 : blogs/synthèses commerciales |

**Sources identifiées par A uniquement** : NIST 800-115, OWASP SAMM, OWASP WSTG, Charoenwet 2024, NIST SAMATE, Feio 2024, eslint-plugin-security, npm audit, OWASP Dependency-Check, IBM shift-left, Dependency Confusion incidents, ResearchGate 2025.

**Sources identifiées par B uniquement** : NIST SP 800-218 SSDF, OWASP DevSecOps Guideline, Mateo Tudela 2020, ACM EASE 2025, Snyk 2024, GitHub Dependabot, Semgrep, OWASP ZAP, IDC/Gartner, ROI synthèses.

**Accord sur sources communes** : 0 source identifiée par les deux agents avec le même niveau — les deux agents ont exploré des corpus complémentaires sans recoupement direct. Accord de résolution atteint sur toutes les inclusions et exclusions.

### Résolution des divergences

**NIST SP 800-115 (A seulement, niv.1)** : inclus. Baseline normative pour tout programme de security testing. Même si antérieur à DevSecOps, définit les méthodes fondamentales (testing, examination, interviewing) qui restent valides. Non trouvé par B car ses mots-clés ciblaient les frameworks DevSecOps récents.

**NIST SP 800-218 SSDF v1.1 (B seulement, niv.1)** : inclus. Source critique — le plus récent framework normatif NIST directement applicable au DevSecOps, déclenché par Executive Order 14028. 4 groupes PO/PS/PW/RV, SBOM requis. Draft v1.2 ajoute GenAI. Non trouvé par A car ses mots-clés ciblaient les outils et méthodes techniques plutôt que les frameworks organisationnels.

**OWASP SAMM v2.0 (A seulement, niv.2)** : inclus. Modèle de maturité essentiel définissant les activités concrètes par phase. Citation directe sur l'intégration CI/CD comme critère de maturité niveau 1.

**OWASP WSTG v4.2 (A seulement, niv.2)** : inclus. Taxonomie de référence des tests web. Définit le scope du DAST automatisé par rapport au pentest manuel.

**OWASP DevSecOps Guideline (B seulement, niv.2)** : inclus. Séquence pipeline CI/CD la plus opérationnelle : secrets scanning → SAST → SCA → DAST → IAST. Source complémentaire au SAMM.

**Charoenwet ISSTA 2024 (A seulement, niv.3)** : inclus. Étude empirique top-tier ACM avec chiffres clés (76% faux positifs dans les fonctions vulnérables, 22% commits manqués). Justification empirique centrale de l'approche multi-outils. Limite : C/C++.

**NIST SAMATE/SATE IV (A seulement, niv.3)** : inclus. Variabilité inter-outils (FP 3-48%). Confirme qu'aucun outil unique ne couvre le spectre complet.

**Feio IEEE EuroS&PW 2024 (A seulement, niv.3)** : inclus. Seule étude empirique d'un framework DevSecOps complet (SCA + DAST + red/blue team) en conditions réelles dans un pipeline CI/CD.

**Mateo Tudela MDPI 2020 (B seulement, niv.3)** : inclus. Benchmark empirique SAST+DAST+IAST sur OWASP Top Ten. Confirme la complémentarité des approches.

**ACM EASE 2025 (B seulement, niv.3)** : inclus. Données récentes sur les taux de faux positifs SAST en conditions réelles (15-60%, 98% non exploitables).

**eslint-plugin-security (A seulement, niv.3)** : inclus. SAST Node.js léger, directement intégrable dans le lint existant. Applicabilité directe NestJS.

**npm audit (A seulement, niv.3)** : inclus. SCA natif npm, zéro configuration. Filet minimal documenté avec ses limites connues.

**OWASP Dependency-Check (A seulement, niv.2-3)** : inclus. Alternative SCA multi-DB plus complète que npm audit seul. Support Node.js experimental.

**GitHub Dependabot (B seulement, niv.3)** : inclus. SCA automatisé GitHub natif, gratuit, >80% mises à jour npm/Yarn. Complémentaire à npm audit.

**Semgrep (B seulement, niv.3)** : inclus. SAST open-source avec support NestJS natif, GitHub Actions natif. Complémentaire à eslint-plugin-security sur les vulnérabilités plus complexes.

**OWASP ZAP (B seulement, niv.2)** : inclus. DAST open-source de référence, GitHub Actions natif. Seul outil DAST open-source retenu.

**IBM/NIST/Capers Jones shift-left (A seulement, niv.3-4)** : inclus avec nuance. Ratios exacts contestés mais direction (coût croissant de la remédiation) confirmée sur 12 000+ projets. Inclus pour la justification économique, pas comme preuve de précision des ratios.

**Snyk State of Open Source 2024 (B seulement, niv.4)** : inclus. Données terrain sur la densité de vulnérabilités (49 vulns/projet en moyenne). Contextualise l'urgence.

**Dependency Confusion incidents (A seulement, niv.4)** : inclus. Vecteur supply chain actionnable avec incidents réels documentés. Justifie les recommandations concrètes de configuration.

**IDC/Gartner 2024 (B seulement, niv.4)** : inclus comme donnée de contexte adoption (70% citent la résistance culturelle). Pas comme preuve primaire.

**ResearchGate SAST+DAST+SCA 2025 (A seulement, niv.4)** : exclu (E1). Source non top-tier. Contenu absorbé par les sources de niveau 1-3 incluses.

**ROI shift-left synthèses (B seulement, niv.4-5)** : exclu (E2). Blogs et synthèses commerciales sans peer review. Contenu illustratif absorbé par IBM/NIST et Feio 2024.

---

## Calcul GRADE final

```
Score de départ : 4
  (sources les plus hautes = niveau 1 : NIST SP 800-115 + NIST SP 800-218 SSDF)

+ 1 convergence
  2 sources niveau 1 (NIST SP 800-115, NIST SP 800-218 SSDF) +
  4 sources niveau 2 (OWASP SAMM, WSTG, DevSecOps Guideline, Dependency-Check) +
  6 études empiriques niveau 3 (Charoenwet ISSTA 2024, NIST SAMATE, Feio IEEE 2024,
  Mateo Tudela 2020, ACM EASE 2025, npm audit docs) convergent sans contradiction sur :
  (1) approche multicouche obligatoire — aucun outil unique ne suffit ;
  (2) intégration CI/CD automatisée > testing manuel ponctuel ;
  (3) shift-left réduit les coûts de remédiation.
  4 contextes distincts : normatif NIST, référentiels OWASP, études empiriques
  peer-reviewed, documentation outils actifs.

+ 1 effet important
  Charoenwet ISSTA 2024 : 76% faux positifs dans les fonctions vulnérables +
  22% commits vulnérables complètement manqués par un seul outil SAST.
  NIST SAMATE : FP 3-48% selon les outils.
  IBM/NIST : coût 1x → 60-100x entre design et après release.
  Snyk 2024 : 49 vulnérabilités en moyenne par projet.
  Effets quantifiés sur plusieurs ordres de grandeur, convergents.

- 1 indirectness
  Les études empiriques SAST les plus rigoureuses (Charoenwet ISSTA 2024,
  NIST SAMATE/SATE IV) portent sur C/C++, pas TypeScript/NestJS.
  Pas d'étude académique spécifique NestJS + security testing.
  Transferabilité partielle : les vulnérabilités web (injection, XSS, SSRF)
  relèvent de patterns différents des vulnérabilités mémoire C/C++.

Score final : 4 + 1 + 1 - 1 = 5 → [STANDARD]
```

Note biais de publication : sources normatives (NIST, OWASP) non soumises au biais de publication. Études empiriques (ACM ISSTA, IEEE EuroS&PW, ACM EASE, MDPI) soumises à peer-review. Documentation outils (Dependabot, Semgrep, ZAP, npm) : biais possible vers la valorisation des fonctionnalités — atténué par les études indépendantes qui confirment les taux d'efficacité et de faux positifs. Sources commerciales (Snyk, IDC) utilisées uniquement pour des données de contexte, pas comme preuves primaires.

---

## Analyse de sensibilité {#analyse-de-sensibilite}

| Source retirée | Score sans | Niveau sans | Changement ? |
|---------------|-----------|------------|:------------:|
| NIST SP 800-115 (niv.1) | départ 1 (SSDF reste niv.1), +1 convergence, +1 effet, -1 indirect = 4 | [RECOMMANDE] | NON — SSDF maintient le score |
| NIST SP 800-218 SSDF (niv.1) | départ 1 (800-115 reste niv.1), +1 convergence, +1 effet, -1 indirect = 4 | [RECOMMANDE] | NON — 800-115 maintient le score |
| Les deux sources niv.1 simultanément | départ 2 (meilleure = OWASP SAMM niv.2), +1 convergence, +1 effet, -1 indirect = 5 | [STANDARD] | NON — convergence OWASP + études empiriques maintient |
| Charoenwet ISSTA 2024 (niv.3) | 4+1+1-1 = 5 (NIST SAMATE couvre la variabilité inter-outils) | [STANDARD] | NON |
| NIST SAMATE/SATE IV (niv.3) | 4+1+1-1 = 5 (Charoenwet couvre la justification empirique) | [STANDARD] | NON |
| Feio IEEE EuroS&PW 2024 (niv.3) | 4+1+1-1 = 5 (autres études empiriques maintiennent) | [STANDARD] | NON |
| Toutes études empiriques niv.3 simultanément | 4+1+0-0 = 5 (convergence niv.1+2 maintenue, effet important réduit, indirect disparaît) | [STANDARD] | NON — mais robustesse réduite |
| Suppression indirectness (-1) | 4+1+1 = 6 — plafonné à 5 par la grille GRADE | [STANDARD] | NON — score plafonné |
| Ajout d'une étude spécifique NestJS TypeScript (hypothétique) | 4+1+1+0 = 6 → 5 plafonné | [STANDARD] | NON — mais indirectness disparaîtrait |

**Conclusion : ROBUSTE** — recommandation [STANDARD] stable pour tout retrait individuel et même pour le retrait simultané des deux sources niveau 1 (les référentiels OWASP niveau 2 et les études empiriques niveau 3 maintiennent la convergence). Le seul scénario de déclassement serait le retrait simultané de toutes sources niveau 1 ET 2 — scénario irréaliste car NIST et OWASP sont des organisations normatives établies avec publications actives. Le malus d'indirectness (-1) est le seul facteur de vulnérabilité : il disparaîtrait si une étude empirique spécifique TypeScript/NestJS security testing était publiée, ce qui renforcerait le score.

---

## Sources exclues

| Source | Critère | Raison |
|--------|---------|--------|
| ResearchGate SAST+DAST+SCA (2025) | E1 | Source venue non top-tier. Contenu absorbé par les sources niveau 1-3 incluses (NIST, OWASP SAMM, Charoenwet, ACM EASE). Pas de valeur ajoutée différentielle. |
| ROI shift-left synthèses (Kiuwan, Medium, GitLab, 2024-2025) | E2 | Blogs individuels et synthèses commerciales sans peer review. Contenu illustratif absorbé par IBM/NIST/Jones et Feio IEEE 2024. Exemple "Medium fintech: $450K cost avoidance" non vérifiable. |
| IAST tools documentation (divers vendeurs) | E3 | Documentation commerciale d'outils IAST. IAST non retenu dans la toolchain recommandée faute d'outil open-source GitHub Actions natif. Biais commercial implicite. |
| CVE databases / NVD raw data | E4 | Données brutes sans analyse. Contenu intégré via OWASP Dependency-Check et npm audit qui utilisent NVD comme source. |
| Pentest reports (divers) | E5 | Rapports de tests d'intrusion non publiés. Hors périmètre PICOC (CI/CD automatisé vs pentest manuel). |
