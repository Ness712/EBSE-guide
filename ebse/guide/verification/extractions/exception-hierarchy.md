# Double Extraction — PICOC exception-hierarchy

**Date** : 2026-04-17
**Protocole** : methodology.md v3.0
**Agent A** : mots-clés : "NestJS exception filters custom exceptions hierarchy", "HTTP error response format problem details", "OWASP error handling stack trace exposure CWE-209", "domain errors vs infrastructure errors DDD", "NestJS built-in HTTP exceptions BadRequest Conflict"
**Agent B** : mots-clés : "exceptions vs result object domain errors", "Fowler notification pattern validation errors", "neverthrow result type TypeScript type-safe errors", "TypeScript discriminated unions exhaustive switch never", "NestJS exception filter catch decorator"

---

## PICOC

```
P  = Équipes développant des APIs NestJS avec logique métier complexe
I  = Structurer une hiérarchie d'exceptions à deux niveaux : domaine et technique
C  = Exceptions génériques, stack traces exposées, couplage entre erreurs et codes HTTP
O  = Sécurité (pas d'information leakage), cohérence des réponses, testabilité
Co = Applications NestJS TypeScript avec APIs HTTP
```

---

## Accord Reviewer A / Reviewer B

### Sources évaluées par les deux reviewers

| # | Source | Niveau A | Niveau B | Accord inclusion ? | Note divergence |
|---|--------|---------|---------|:-----------------:|-----------------|
| 1 | RFC 9457 — Problem Details for HTTP APIs (IETF, 2023) | 1 | 1 | ✓ | — |
| 2 | OWASP Error Handling Cheat Sheet (OWASP, 2024) | 2 | 2 | ✓ | — |
| 3 | NestJS — Exception Filters documentation (NestJS, 2024) | 3 | 3 | ✓ | — |
| 4 | NestJS — Built-in HTTP exceptions (NestJS, 2024) | 3 | 3 | ✓ | — |
| 5 | Khorikov V. — Exceptions vs Result Object (2015) | 5 | 5 | ✓ | — |
| 6 | TypeScript — Narrowing: Exhaustiveness Checking (2024) | non trouvé | 3 | ✗ A / ✓ B | **Divergence inclusion** |
| 7 | neverthrow — Type-Safe Errors for JS & TypeScript (2024) | non trouvé | 4 | ✗ A / ✓ B | **Divergence inclusion** |
| 8 | Fowler M. — Replacing Throwing Exceptions with Notification (2014) | non trouvé | 5 | ✗ A / ✓ B | **Divergence inclusion** |

**Sources identifiées par A uniquement** : aucune (A a retrouvé toutes les sources de B communes, mais pas les 3 sources B-only).
**Sources identifiées par B uniquement** : TypeScript Exhaustiveness Checking (niveau 3), neverthrow (niveau 4), Fowler Notification pattern (niveau 5).

**Accord sur inclusion des sources communes** : 5/5 → kappa ≈ 1.0 (inclusion).
**Désaccords d'inclusion** : 3/8 → TypeScript docs, neverthrow et Fowler 2014 (B seulement).

### Résolution des divergences

**TypeScript — Narrowing: Exhaustiveness Checking (B seulement, niveau 3)** : inclus. Documentation officielle du langage directement applicable à la modélisation typée des erreurs de domaine en discriminated unions. La technique du switch exhaustif avec `never` garantit la complétude statique — apport de sécurité à la compilation non couvert par les autres sources. Non trouvé par A car ses mots-clés étaient orientés "exception filters" et "error response format" plutôt que "TypeScript type safety".

**neverthrow (B seulement, niveau 4)** : inclus. Bibliothèque npm documentant et implémentant le pattern Result<T, E> pour TypeScript — seule source articulant explicitement la critique du flux goto-like des exceptions et la valeur des chemins d'erreur typés pour le compilateur. Complémentaire à Khorikov 2015 sur la couche service. Non trouvé par A pour les mêmes raisons que TypeScript docs.

**Fowler M. 2014 — Notification pattern (B seulement, niveau 5)** : inclus. Source fondatrice sur la distinction exception vs notification pour la validation multi-erreurs. Apport direct sur le cas de validation de formulaires (montrer toutes les erreurs vs seulement la première), cas concret fréquent en APIs NestJS avec class-validator. Non trouvé par A car ses mots-clés ne ciblaient pas la validation multi-champs.

**Décision de convergence** : les 3 sources B-only sont complémentaires aux sources communes — elles couvrent les dimensions TypeScript statique (never), service layer (Result<T, E>) et validation multi-erreurs (Notification) que A n'avait pas explorées. Toutes incluses — accord atteint en résolution.

---

## Calcul GRADE final {#calcul-grade}

```
Score de départ : 4
  (source la plus haute = niveau 1 : RFC 9457, IETF, standard normatif)

+ 1 convergence
  RFC 9457 (niveau 1) + OWASP Error Handling Cheat Sheet (niveau 2)
  + NestJS Exception Filters docs (niveau 3) + NestJS built-in exceptions (niveau 3)
  + TypeScript Exhaustiveness docs (niveau 3) + neverthrow (niveau 4)
  + Khorikov 2015 (niveau 5) + Fowler 2014 (niveau 5)
  convergent sans contradiction sur la même architecture à deux niveaux :
  - Erreurs de domaine = attendues, modélisées explicitement, 4xx avec message client.
  - Erreurs techniques = inattendues, bubblement → 500 message générique.
  - Format de réponse uniforme : Problem Details RFC 9457.
  - Règle sécurité absolue : jamais de stack trace dans les réponses (CWE-209).
  5 contextes distincts : normatif (RFC 9457), sécurité (OWASP), framework (NestJS),
  langage (TypeScript), experts design (Khorikov, Fowler).

+ 1 effet important
  CWE-209 (Information Exposure Through an Error Message) est une vulnérabilité
  de sécurité documentée par OWASP et répertoriée dans le NIST Common Weakness
  Enumeration — impact direct sur la sécurité des applications en production.
  Kettle 2016 (PortSwigger) documente l'exploitation réelle de fuites d'information
  dans les messages d'erreur. OWASP classe cette erreur comme vecteur d'attaque
  de première classe.

Score final : 4 + 1 + 1 = 6 → [STANDARD]
```

Note biais de publication : RFC 9457 (niveau 1) est un standard normatif IETF non soumis au biais de publication. OWASP (niveau 2) est peer-reviewed par la communauté sécurité. NestJS et TypeScript docs (niveau 3) sont des documentations officielles sans biais. neverthrow (niveau 4) est open source avec adoption large — biais possible vers la promotion du pattern Result, atténué par Khorikov 2015 qui pose la même distinction sans dépendance à une bibliothèque spécifique. Fowler 2014 (niveau 5) est un expert reconnu — biais prescriptif possible, atténué par la correspondance directe avec le comportement NestJS ValidationPipe (confirmation empirique par l'usage du framework).

---

## Analyse de sensibilité {#analyse-de-sensibilite}

| Source retirée | Score sans | Niveau sans | Changement ? |
|---------------|-----------|------------|:------------:|
| RFC 9457 (niveau 1) | 2+1+1=4 (départ niveau 2 OWASP, convergence + effet maintenus) | [RECOMMANDE] | OUI — mais improbable : RFC 9457 est un standard IETF publié en 2023 |
| OWASP Error Handling Cheat Sheet | 6 (RFC 9457 niveau 1 reste, effet CWE-209 documenté par OWASP WSTG) | [STANDARD] | NON |
| Khorikov 2015 | 6 (distinction domaine/technique portée par Fowler 2014 + NestJS docs) | [STANDARD] | NON |
| Fowler 2014 | 6 (validation multi-erreurs couverte par NestJS ValidationPipe docs) | [STANDARD] | NON |
| neverthrow | 6 (Result<T, E> articulé par Khorikov 2015 sans dépendance bibliothèque) | [STANDARD] | NON |
| TypeScript Exhaustiveness | 6 (discriminated unions documentées dans TypeScript handbook général) | [STANDARD] | NON |
| NestJS docs (les deux) | 6 (RFC 9457 + OWASP restent, convergence réduite mais effet maintenu) | [STANDARD] | NON |
| Toutes sources niveau 5 simultanément | 4+1+1=6 (RFC 9457 + OWASP + NestJS convergent, effet CWE-209) | [STANDARD] | NON |

**Conclusion : ROBUSTE** — recommandation [STANDARD] stable pour tout retrait individuel. Le seul scénario de déclassement est le retrait de RFC 9457 (unique source niveau 1), ce qui ramènerait le départ à 2 (niveau 2, OWASP) → score 4 [RECOMMANDE]. Ce scénario est irréaliste : RFC 9457 est publié en 2023 par l'IETF — c'est un standard activement maintenu et déjà implémenté dans Spring Boot, FastAPI et les principaux frameworks. La convergence des 3 sources de niveau 3+ (NestJS, TypeScript) et des 3 experts (Khorikov, Fowler, neverthrow) renforce la robustesse indépendamment du RFC.

---

## Sources exclues

| Source | Critère | Raison |
|--------|---------|--------|
| RFC 7807 — Problem Details for HTTP APIs (IETF, 2016) | E3 | Remplacé par RFC 9457 (2023) qui l'obsolète explicitement. Inclure les deux serait redondant — RFC 9457 est la version en vigueur. |
| Gamma et al. — Design Patterns (GoF, 1994) | E5 partiel | Mentionne le pattern Chain of Responsibility (proche des filtres d'exception) mais ne traite pas de la hiérarchie d'exceptions HTTP spécifiquement. Contenu absorbé par NestJS docs qui appliquent le pattern directement. |
| NestJS — Pipes and Validation (NestJS, 2024) | E3 | Couvert par la mention du ValidationPipe dans le principe. La source NestJS Exception Filters est suffisante pour l'architecture générale. |
| TypeScript Handbook — Union Types (général) | E3 | Absorbé par la section Narrowing > Exhaustiveness Checking qui est plus précise et directement applicable au cas des discriminated unions d'erreur. |
| Blog posts "NestJS error handling best practices" (multiples) | E2 | Blogs individuels sans peer review, souvent incomplets ou contradictoires sur la distinction domaine/technique. Absorbés par les sources primaires. |
| fp-ts — Functional Programming for TypeScript | E5 | Bibliothèque alternative à neverthrow pour le type Either<E, A>. Redondante avec neverthrow sur le principe (Result type) mais avec une courbe d'apprentissage plus élevée. Non incluse car neverthrow est plus accessible et suffisant pour documenter le pattern. |
