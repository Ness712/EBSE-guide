# PRISMA Flow — PICOC defensive-programming

**Date de recherche** : 2026-04-17
**Bases interrogées** : IEEE SWEBOK, ACM Digital Library, OWASP (Cheat Sheets, ASVS), TypeScript documentation officielle, NestJS documentation officielle, Microsoft Press (Code Complete), Prentice Hall (OOSC), WebSearch général
**Mots-clés Agent A** : "defensive programming preconditions postconditions", "Design by Contract Meyer assertions invariant", "fail-fast validation boundary software", "guard clauses early return McConnell", "TypeScript assertion functions asserts condition", "NestJS ValidationPipe class-validator preconditions"
**Mots-clés Agent B** : "SWEBOK defensive programming software construction", "input validation OWASP allowlist server-side", "guard clauses vs nested conditionals", "TypeScript asserts type narrowing", "NestJS pipes validation whitelist forbidNonWhitelisted", "too much defensive programming overhead"
**Protocole** : methodology.md v3.0 §2.1 — double extraction indépendante (Agents A + B, mots-clés différents) + synthèse Agent C

---

## Flux

```
IDENTIFICATION
  Sources identifiées par base (Agent A + Agent B combinés, avant déduplication) :
    - Standards normatifs (IEEE SWEBOK v3, v4) : 3 résultats candidats
    - Ouvrages fondateurs (Meyer OOSC, McConnell Code Complete) : 4 résultats candidats
    - OWASP (Cheat Sheets, ASVS, Testing Guide) : ~7 résultats candidats
    - Documentation officielle (TypeScript, NestJS) : ~6 résultats candidats
    - Articles académiques / conférences : ~8 résultats candidats
    - Blogs / articles pratiques (Martin Fowler blog, etc.) : ~10 résultats candidats
    - Snowballing backward (références citées par sources principales) : ~6 sources
  Total identifié (brut, combiné A+B) : ~44
  Doublons retirés (même source identifiée par A et B) : 8
    (SWEBOK v4, McConnell ch.8, Meyer OOSC, TypeScript 3.7 assertions, NestJS ValidationPipe)
  Total après déduplication : ~36

SCREENING (titre + résumé)
  Sources screenées : ~36
  Sources exclues au screening : ~23
    - E1 (blog opinion sans données ou méthodologie) : ~9
    - E2 (hors scope PICOC — validation UI uniquement, pas protection de routines) : ~6
    - E3 (doublons partiels — couverts par sources primaires déjà incluses) : ~5
    - E4 (vendeur / marketing sans substance technique) : ~3

ELIGIBILITÉ (lecture complète)
  Sources évaluées en détail : ~13
  Sources exclues après lecture complète : ~7
    - Hors scope PICOC strict (traite DbC formellement sans lien programmation défensive) : 2
    - Niveau de preuve insuffisant (anecdotique, pas de référence normative) : 2
    - Redondance forte avec sources déjà incluses sans apport différencié : 3

INCLUSION
  Sources incluses dans la synthèse : 6
    - Niveau 1 : 1 (SWEBOK v4 — IEEE Computer Society 2024)
    - Niveau 2 : 1 (OWASP Input Validation Cheat Sheet 2024)
    - Niveau 3 : 2 (TypeScript 3.7 Assertion Functions, NestJS Pipes & Validation)
    - Niveau 5 : 2 (Meyer OOSC 2e éd. 1997, McConnell Code Complete 2e éd. 2004)

  Sources exclues avec raison documentée : voir section dédiée ci-dessous
```

---

## Documentation recherche (Table 2 Kitchenham)

### Agent A — bases interrogées

| Élément | Valeur |
|---------|--------|
| Bases | IEEE SWEBOK, ACM Digital Library, Microsoft Press, Prentice Hall, TypeScript docs, NestJS docs, WebSearch général |
| Mots-clés | "defensive programming preconditions postconditions", "Design by Contract Meyer assertions invariant", "fail-fast validation boundary software", "guard clauses early return McConnell", "TypeScript assertion functions asserts condition", "NestJS ValidationPipe class-validator preconditions" |
| Période couverte | 1997-2024 |
| Sources identifiées | ~22 |
| Sources retenues | 5 |
| Date d'extraction | 2026-04-17 |

### Agent B — bases interrogées

| Élément | Valeur |
|---------|--------|
| Bases | IEEE SWEBOK, OWASP, TypeScript docs, NestJS docs, Martin Fowler blog, WebSearch |
| Mots-clés | "SWEBOK defensive programming software construction", "input validation OWASP allowlist server-side", "guard clauses vs nested conditionals", "TypeScript asserts type narrowing", "NestJS pipes validation whitelist forbidNonWhitelisted", "too much defensive programming overhead" |
| Période couverte | 1997-2024 |
| Sources identifiées | ~22 |
| Sources retenues | 6 (convergence élevée avec A + OWASP Input Validation Cheat Sheet en plus) |
| Date d'extraction | 2026-04-17 |

---

## Sources exclues — raisons documentées

| Source | Raison exclusion |
|--------|-----------------|
| SWEBOK V3.0 §4.4 (IEEE, 2014) | Redondance — SWEBOK v4 2024 est plus récent et couvre les mêmes concepts avec la même autorité. Inclure les deux serait dupliquer la même source normative. |
| Meyer B. — "Applying Design by Contract" (IEEE Computer, 1992) | Absorbé par OOSC 2e éd. 1997 — même auteur, même contenu traité de façon plus complète et plus accessible dans l'ouvrage de référence. |
| OWASP ASVS V4.0 — V5 Validation, Sanitization and Encoding | Redondance partielle avec OWASP Input Validation Cheat Sheet. L'ASVS traite le sujet sous angle checklist de conformité (quel niveau atteindre) plutôt que prescriptif (comment faire). Moins directement actionnable pour la question PICOC. |
| Martin Fowler — "Replacing Throwing Exceptions with Notification in Validations" (blog, 2014) | Blog niveau 5, non peer-reviewed. Traite des patterns de retour d'erreur de validation (notification pattern) — pertinent mais pas central à la question PICOC sur les préconditions/postconditions/assertions. Contenu partiellement absorbé par McConnell sur les guard clauses. |
| Liskov B. & Guttag J. — Program Development in Java (2000) | Traite DbC dans un contexte Java fortement typé avec spécifications formelles. Hors scope du contexte TypeScript/NestJS et moins accessible que Meyer OOSC pour le principe central. |
| Bertrand Meyer — "Design by Contract, by Example" (2002) | Redondance avec OOSC 2e éd. — même auteur, même principe, ouvrage secondaire moins canonique. |
| Articles académiques sur la vérification formelle (Hoare logic, etc.) | Hors scope PICOC — la question porte sur l'application pratique en TypeScript/NestJS, pas sur la vérification formelle de programmes. |
