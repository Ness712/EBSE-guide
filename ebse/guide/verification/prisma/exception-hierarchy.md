# PRISMA Flow — PICOC exception-hierarchy

**Date de recherche** : 2026-04-17
**Bases interrogées** : IETF RFCs, OWASP (Cheat Sheets, WSTG), NestJS documentation, TypeScript documentation officielle, Martin Fowler (martinfowler.com), enterprisecraftsmanship.com, npm/GitHub (neverthrow), WebSearch général
**Mots-clés Agent A** : "NestJS exception filters custom exceptions hierarchy", "HTTP error response format problem details", "OWASP error handling stack trace exposure CWE-209", "domain errors vs infrastructure errors DDD", "NestJS built-in HTTP exceptions BadRequest Conflict"
**Mots-clés Agent B** : "exceptions vs result object domain errors", "Fowler notification pattern validation errors", "neverthrow result type TypeScript type-safe errors", "TypeScript discriminated unions exhaustive switch never", "NestJS exception filter catch decorator"
**Protocole** : methodology.md v3.0 §2.1 — double extraction indépendante (Agents A + B, mots-clés différents) + synthèse Agent C

---

## Flux

```
IDENTIFICATION
  Sources identifiées par base (Agent A + Agent B combinés, avant déduplication) :
    - Standards normatifs (IETF RFCs) : 2 résultats candidats (RFC 9457, RFC 7807)
    - OWASP (Cheat Sheets, WSTG, ASVS) : ~5 résultats candidats
    - Documentation framework (NestJS) : ~8 résultats candidats
    - Documentation langage (TypeScript) : ~6 résultats candidats
    - Experts design / DDD (Fowler, Khorikov, Evans) : ~7 résultats candidats
    - Bibliothèques npm (neverthrow, fp-ts, zod) : ~5 résultats candidats
    - Snowballing backward (références citées par sources principales) : ~4 sources
  Total identifié (brut, combiné A+B) : ~37
  Doublons retirés (même source identifiée par A et B) : 5 (RFC 9457, OWASP Cheat Sheet, NestJS Exception Filters, NestJS built-in exceptions, Khorikov 2015)
  Total après déduplication : ~32

SCREENING (titre + résumé)
  Sources screenées : ~32
  Sources exclues au screening : ~20
    - E1 (blog opinion sans données ni référence normative) : ~9
    - E2 (hors scope PICOC — error handling général non HTTP, ou non NestJS) : ~5
    - E3 (redondance forte avec sources primaires déjà incluses) : ~4
    - E4 (vendeur / marketing sans substance technique) : ~2

ELIGIBILITÉ (lecture complète)
  Sources évaluées en détail : ~12
  Sources exclues après lecture complète : ~4
    - RFC 7807 (obsolété par RFC 9457 — exclusion E3) : 1
    - GoF Design Patterns (trop général, pas de traitement HTTP exceptions) : 1
    - fp-ts Either type (redondance avec neverthrow sur le principe, complexité plus élevée) : 1
    - NestJS Pipes documentation (absorbé par NestJS Exception Filters) : 1

INCLUSION
  Sources incluses dans la synthèse : 8
    - Niveau 1 : 1 (RFC 9457 — IETF 2023)
    - Niveau 2 : 1 (OWASP Error Handling Cheat Sheet 2024)
    - Niveau 3 : 3 (NestJS Exception Filters, NestJS built-in exceptions, TypeScript Exhaustiveness)
    - Niveau 4 : 1 (neverthrow)
    - Niveau 5 : 2 (Khorikov V. 2015, Fowler M. 2014)

  Sources exclues avec raison documentée : 4
    - RFC 7807 (IETF, 2016) : obsolété explicitement par RFC 9457 (2023)
    - Gamma et al. GoF (1994) : trop général — Chain of Responsibility absorbé par NestJS docs
    - fp-ts : redondant avec neverthrow sur le principe Result, plus complexe à apprendre
    - NestJS Pipes/Validation docs : absorbé par la mention ValidationPipe dans le principe
```

---

## Documentation recherche (Table 2 Kitchenham)

### Agent A — bases interrogées

| Élément | Valeur |
|---------|--------|
| Bases | IETF RFCs, OWASP, NestJS documentation, enterprisecraftsmanship.com, WebSearch général |
| Mots-clés | "NestJS exception filters custom exceptions hierarchy", "HTTP error response format problem details", "OWASP error handling stack trace exposure CWE-209", "domain errors vs infrastructure errors DDD", "NestJS built-in HTTP exceptions" |
| Période couverte | 2014-2024 |
| Sources identifiées | ~20 |
| Sources retenues | 5 (RFC 9457, OWASP, NestJS Exception Filters, NestJS built-in, Khorikov 2015) |
| Date d'extraction | 2026-04-17 |

### Agent B — bases interrogées

| Élément | Valeur |
|---------|--------|
| Bases | martinfowler.com, npm/GitHub (neverthrow, fp-ts), TypeScript documentation, NestJS documentation, WebSearch |
| Mots-clés | "exceptions vs result object domain errors", "Fowler notification pattern validation errors", "neverthrow result type TypeScript type-safe errors", "TypeScript discriminated unions exhaustive switch never", "NestJS exception filter catch decorator" |
| Période couverte | 2014-2024 |
| Sources identifiées | ~17 |
| Sources retenues | 8 (5 communes avec A + TypeScript Exhaustiveness, neverthrow, Fowler 2014) |
| Date d'extraction | 2026-04-17 |

---

## Sources exclues — raisons documentées

| Source | Raison exclusion |
|--------|-----------------|
| RFC 7807 — Problem Details for HTTP APIs (IETF, 2016) | Obsolété explicitement par RFC 9457 (2023) qui le remplace. Inclure les deux serait redondant — RFC 9457 est la version normative en vigueur. |
| Gamma et al. — Design Patterns (GoF, 1994) | Trop général. Le pattern Chain of Responsibility est absorbé par la documentation NestJS Exception Filters qui l'applique directement au contexte HTTP. |
| fp-ts — Functional Programming for TypeScript | Redondant avec neverthrow sur le principe Result/Either. fp-ts apporte une approche plus exhaustive (catégorie theory) mais avec une courbe d'apprentissage significativement plus élevée pour un bénéfice équivalent sur ce PICOC. |
| NestJS — Pipes and Validation documentation | Absorbé par la mention du ValidationPipe dans le principe et la référence à Fowler 2014 sur le Notification pattern. Pas d'apport différencié sur l'architecture de la hiérarchie d'exceptions. |
| Evans E. — Domain-Driven Design (2003) | Traite des erreurs de domaine implicitement mais sans prescrire d'architecture d'exceptions HTTP. Contenu conceptuel absorbé par Khorikov 2015 qui applique directement la distinction DDD au contexte exceptions vs résultats. |
| Blog posts NestJS error handling (≥6 sources) | Niveau 5 redondant ou sous-niveau 5. Souvent incomplets ou contradictoires sur la distinction domaine/technique. Les sources primaires (RFC 9457, OWASP, NestJS docs, Khorikov, Fowler) couvrent le même contenu avec plus de rigueur. |
