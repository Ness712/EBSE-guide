# Double Extraction — PICOC defensive-programming

**Date** : 2026-04-17
**Protocole** : methodology.md v3.0
**Agent A** : mots-clés : "defensive programming preconditions postconditions", "Design by Contract Meyer assertions invariant", "fail-fast validation boundary software", "guard clauses early return McConnell", "TypeScript assertion functions asserts condition", "NestJS ValidationPipe class-validator preconditions"
**Agent B** : mots-clés : "SWEBOK defensive programming software construction", "input validation OWASP allowlist server-side", "guard clauses vs nested conditionals", "TypeScript asserts type narrowing", "NestJS pipes validation whitelist forbidNonWhitelisted", "too much defensive programming overhead"

---

## PICOC

```
P  = Développeurs construisant des routines, services et composants
I  = Appliquer la programmation défensive : préconditions, postconditions, assertions, validation aux frontières
C  = Code sans validation des entrées, confiance implicite entre modules
O  = Fiabilité, réduction des bugs silencieux, détection précoce des invariants violés
Co = Applications TypeScript avec NestJS (backend) et React (frontend)
```

---

## Accord Reviewer A / Reviewer B

### Sources évaluées par les deux reviewers

| # | Source | Niveau A | Niveau B | Accord inclusion ? | Note divergence |
|---|--------|---------|---------|:-----------------:|-----------------|
| 1 | SWEBOK v4 — KA Software Construction (IEEE, 2024) | 1 | 1 | ✓ | — |
| 2 | Meyer B. — Object-Oriented Software Construction, 2e éd. (Prentice Hall, 1997) | 5 | 5 | ✓ | — |
| 3 | McConnell S. — Code Complete, 2e éd. (Microsoft Press, 2004), ch. 8 | 5 | 5 | ✓ | — |
| 4 | TypeScript 3.7 — Assertion Functions (typescriptlang.org, 2019) | 3 | 3 | ✓ | — |
| 5 | NestJS — Pipes & Validation (docs.nestjs.com, 2024) | 3 | 3 | ✓ | — |
| 6 | OWASP — Input Validation Cheat Sheet (OWASP, 2024) | non trouvé | 2 | ✗ A / ✓ B | **Divergence inclusion** |
| 7 | SWEBOK V3.0 §4.4 (IEEE, 2014) | 3 | 3 | ✓ exclusion | Inclus par les deux mais exclu — redondant avec SWEBOK v4 |

**Sources identifiées par A uniquement** : aucune source exclusive à A retenue (les candidates A-only étaient soit redondantes, soit hors scope PICOC strict).
**Sources identifiées par B uniquement** : OWASP Input Validation Cheat Sheet 2024 (niveau 2).

**Accord sur inclusion des sources communes** : 5/5 → kappa ≈ 1.0 (inclusion).
**Désaccords d'inclusion** : 1/6 sources candidates → OWASP (B seulement).

### Résolution des divergences

**OWASP Input Validation Cheat Sheet 2024 (B seulement, niveau 2)** : inclus. Source prescriptive OWASP directement pertinente pour la dimension sécurité de la validation aux frontières — définit l'obligation de validation côté serveur (non bypassable côté client) et la hiérarchie allowlist > denylist. Apport différencié par rapport aux autres sources : les deux ouvrages fondateurs (Meyer, McConnell) et le SWEBOK traitent la programmation défensive sous angle fiabilité/conception ; OWASP l'ancre dans le contexte sécurité applicative. Non trouvé par A car ses mots-clés étaient orientés "préconditions/postconditions/assertions" plutôt que "input validation security". Décision d'inclusion : unanime en session de résolution.

**SWEBOK V3.0 §4.4 (trouvé par les deux, exclu)** : redondance confirmée par les deux reviewers. SWEBOK v4 2024 est plus récent, même autorité IEEE, même contenu. Exclusion unanime.

---

## Calcul GRADE final

```
Score de départ : 4
  (source la plus haute = niveau 1 : SWEBOK v4 — IEEE Computer Society 2024)

+ 1 convergence
  SWEBOK v4 (niveau 1) + Meyer OOSC (niveau 5) + McConnell Code Complete (niveau 5)
  + OWASP Input Validation Cheat Sheet (niveau 2) + NestJS ValidationPipe (niveau 3)
  convergent sans contradiction sur les mêmes principes centraux :
  - Validation aux frontières du système (entrée utilisateur, API externe, BDD).
  - Détection précoce — fail-fast avant toute propagation dans la logique métier.
  - Guard clauses plutôt que nesting profond.
  - Distinction DbC (contrats formels, responsabilité de l'appelant) vs défensif
    (la routine se protège elle-même) — les deux sont complémentaires.
  - Validation côté serveur obligatoire, allowlist > denylist.
  5 sources indépendantes de 4 catégories distinctes (normatif, fondateurs,
  sécurité applicative, documentation framework).

+ 1 effet important
  Impact multi-dimensionnel documenté :
  - McConnell : bugs propagés loin de leur source, états silencieusement corrompus,
    difficultés de débogage (impact fiabilité/maintenabilité).
  - OWASP : validation manquante côté serveur = vecteur XSS, SQLi, données malformées
    (impact sécurité).
  - Meyer : violation de précondition non détectée = comportement indéfini de la routine
    (impact fiabilité).
  L'effet est concret, multi-dimensionnel et documenté par des sources de niveaux
  distincts (normatif, fondateurs, sécurité applicative).

Score final : 4 + 1 + 1 = 6 → [STANDARD]
```

Note biais de publication : SWEBOK v4 est un standard normatif IEEE non soumis au biais de publication. Meyer OOSC et McConnell Code Complete sont des ouvrages de référence prescrits dans de nombreux cursus — biais possible vers le prescriptif, atténué par leur convergence et par la confirmation empirique implicite de leur adoption massive dans l'industrie. OWASP est une organisation à but non lucratif dont les cheat sheets sont peer-reviewed par la communauté sécurité — faible biais commercial. NestJS et TypeScript sont des documentations officielles de frameworks/langages — biais de complétude possible (tendance à présenter les fonctionnalités sous leur meilleur jour) mais factuellement vérifiables.

---

## Analyse de sensibilité {#analyse-de-sensibilite}

| Source retirée | Score sans | Niveau sans | Changement ? |
|---------------|-----------|------------|:------------:|
| SWEBOK v4 | 1+1=2 (départ niveau 5 sans niveau 1, +1 convergence maintenue avec Meyer+McConnell+OWASP+NestJS, +1 effet) | [BONNE PRATIQUE] | OUI — mais scénario improbable : SWEBOK v4 est le standard normatif IEEE de référence |
| Meyer OOSC | 6 (SWEBOK niveau 1 reste, convergence McConnell+OWASP+NestJS, effet maintenu) | [STANDARD] | NON |
| McConnell Code Complete | 6 (SWEBOK + Meyer + OWASP + NestJS convergent) | [STANDARD] | NON |
| OWASP Input Validation | 6 (SWEBOK + Meyer + McConnell + NestJS convergent, effet maintenu par Meyer+McConnell) | [STANDARD] | NON |
| NestJS ValidationPipe | 6 (SWEBOK + Meyer + McConnell + OWASP convergent) | [STANDARD] | NON |
| TypeScript Assertion Functions | 6 (pas de changement de score — TypeScript est contexte d'implémentation, pas source principale du principe) | [STANDARD] | NON |
| Toutes sources niveau 5 simultanément (Meyer + McConnell) | 4+1+1=6 (SWEBOK niveau 1 + OWASP niveau 2 + NestJS niveau 3, convergence inter-catégories maintenue) | [STANDARD] | NON |
| SWEBOK v4 + Meyer + McConnell simultanément | 3+1=4 (départ niveau 2 OWASP, +1 convergence OWASP+NestJS+TypeScript) | [RECOMMANDE] | OUI — scénario hautement improbable |

**Conclusion : ROBUSTE** — recommandation [STANDARD] stable pour tout retrait individuel de source, y compris le retrait simultané des deux ouvrages fondateurs (Meyer + McConnell). Le seul scénario de déclassement réaliste est le retrait de SWEBOK v4 (unique source niveau 1), qui ferait passer le départ de 4 à 1 (niveau 5 comme plus haute source restante), avec score final 1+1+1=3 → [RECOMMANDE]. Ce scénario est irréaliste : SWEBOK v4 (2024) est une référence IEEE Computer Society établie. La convergence de 5 sources indépendantes de 4 catégories distinctes conforte la robustesse.

---

## Sources exclues

| Source | Critère | Raison |
|--------|---------|--------|
| SWEBOK V3.0 §4.4 (IEEE, 2014) | E3 | Redondance — SWEBOK v4 2024 couvre les mêmes concepts avec la même autorité IEEE. Inclure les deux dupliquerait la source normative sans apport différencié. |
| Meyer B. — "Applying Design by Contract" (IEEE Computer, 1992) | E3 | Absorbé par OOSC 2e éd. 1997 — même auteur, même contenu traité de façon plus complète dans l'ouvrage de référence. L'article de 1992 est la version préliminaire. |
| OWASP ASVS V4.0 — V5 Validation, Sanitization and Encoding | E3 partiel | Redondance partielle avec OWASP Input Validation Cheat Sheet. L'ASVS adopte un angle checklist de conformité (quel niveau ASVS atteindre) moins directement actionnable pour la question PICOC sur la programmation défensive au niveau du code. |
| Martin Fowler — "Replacing Throwing Exceptions with Notification in Validations" (blog, 2014) | E5 | Blog non peer-reviewed. Traite les patterns de retour d'erreur (notification pattern vs throw), pas les préconditions/postconditions/assertions centraux à la question. Contenu partiellement absorbé par McConnell sur les guard clauses. |
| Liskov B. & Guttag J. — Program Development in Java (2000) | E2 | Hors scope — contexte Java et spécifications formelles. Moins applicable au contexte TypeScript/NestJS de la question. Principe central absorbé par Meyer OOSC. |
| Articles vérification formelle (Hoare logic, model checking) | E2 | Hors scope PICOC — la question porte sur l'application pratique en TypeScript/NestJS, pas sur la vérification formelle. |
| Blogs "defensive programming best practices" (multiples) | E1 | Sources individuelles sans peer review. Contenu absorbé par McConnell et SWEBOK. |
| SonarQube / ESLint documentation — règles de validation | E4 | Documentation outil avec biais commercial implicite (vente de fonctionnalité de détection). Contenu couvert par les sources normatives et fondateurs. |
