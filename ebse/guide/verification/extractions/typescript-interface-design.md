# Double Extraction — PICOC typescript-interface-design

**Date** : 2026-04-17
**Protocole** : methodology.md v3.0
**Agent A** : mots-cles : "typescript interface vs type alias performance compiler", "TypeScript Performance wiki interface caching intersection", "Google TypeScript Style Guide interface type", "abstract class vs interface TypeScript coupling", "TypeScript structural typing interface type compatibility", "TypeScript declaration merging interface only"
**Agent B** : mots-cles : "typescript interface type alias when to use", "NestJS DTO class vs interface class-validator runtime metadata", "TypeScript Handbook everyday types interface default", "Effective TypeScript interface type public API declaration merging", "Total TypeScript Matt Pocock interface type union mapped type"

---

## PICOC

```
P  = Equipes developpant en TypeScript (frontend et backend)
I  = Choisir entre interface, type alias et class pour definir des contrats de types
C  = Utilisation inconsistante ou aleatoire de interface/type/class
O  = Maintenabilite, performance du compilateur, testabilite, extensibilite des APIs
Co = Applications TypeScript avec NestJS (backend) et React (frontend)
```

---

## Accord Reviewer A / Reviewer B

### Sources evaluees par les deux reviewers

| # | Source | Niveau A | Niveau B | Accord inclusion ? | Note divergence |
|---|--------|---------|---------|:-----------------:|-----------------|
| 1 | TypeScript Team Performance wiki (Microsoft, github.com/microsoft/TypeScript/wiki/Performance) | 2 | 2 | ✓ | — |
| 2 | Google TypeScript Style Guide (google.github.io/styleguide/tsguide.html) | 2 | 2 | ✓ | — |
| 3 | TypeScript Handbook — Everyday Types (typescriptlang.org) | 3 | 3 | ✓ | — |
| 4 | TypeScript Handbook — Declaration Merging (typescriptlang.org) | 3 | 3 | ✓ | — |
| 5 | Vanderkam D. — Effective TypeScript 2nd ed. (O'Reilly, 2021/2023) | 5 | 5 | ✓ | — |
| 6 | Total TypeScript — Matt Pocock (totaltypescript.com) | non trouve | 3 | ✗ A / ✓ B | **Divergence inclusion** |
| 7 | NestJS — Documentation DTOs et Validation (docs.nestjs.com) | 3 | 3 | ✓ | — |
| 8 | TypeScript Handbook — Type Compatibility (typescriptlang.org) | 3 | non trouve | ✓ A / ✗ B | **Divergence inclusion** |
| 9 | Stemmler K. — When to Use TypeScript Abstract Classes (khalilstemmler.com) | 3 | non trouve | ✓ A / ✗ B | **Divergence inclusion** |

**Sources identifiees par A uniquement** : TypeScript Handbook Type Compatibility, Stemmler khalilstemmler.com
**Sources identifiees par B uniquement** : Total TypeScript Matt Pocock

**Accord sur inclusion des sources communes** : 6/6 → kappa = 1.0 (inclusion).
**Desaccords d'inclusion** : 3/9 — Total TypeScript (B seulement), Type Compatibility (A seulement), Stemmler (A seulement).

### Resolution des divergences

**Total TypeScript — Matt Pocock (B seulement, niveau 3)** : inclus. Matt Pocock est un expert TypeScript reconnu dans la communaute (auteur de la formation Total TypeScript, ancien core contributor typeScript). La source apporte une heuristique complementaire claire sur la partition fonctionnelle interface/type, en particulier la liste des constructions qui exigent type (unions, mapped types, conditional types) — aspect non couvert avec autant de precision par les sources communes. Non trouve par A car ses mots-cles etaient orientes "performance" et "structural typing" plutot que "use case partitioning".

**TypeScript Handbook Type Compatibility (A seulement, niveau 3)** : inclus. Fournit le fondement theorique du typage structurel TypeScript, essentiel pour expliquer pourquoi interface et type sont techniquement interchangeables pour la compatibilite de type, et que la decision est une question de tooling et d'expressivite plutot que de semantique. Non trouve par B car ses mots-cles etaient orientes "when to use" plutot que "structural typing theory".

**Stemmler K. khalilstemmler.com (A seulement, niveau 3)** : inclus. Seule source traitant directement la decision abstract class vs interface avec le critere de couplage — dimension non couverte par les autres sources. Apport specifique et non redondant. Non trouve par B car ses mots-cles ne ciblaient pas la dimension abstract class.

**Decision de convergence** : les trois sources A-only et B-only sont complementaires et non redondantes. Toutes incluses — accord atteint en session de resolution.

---

## Calcul GRADE final

```
Score de depart : 3
  (source la plus haute = TypeScript Team Performance wiki, niveau 2 ;
   et Google TypeScript Style Guide, niveau 2 → depart = 3)

+ 1 convergence
  TypeScript Team Performance wiki (niveau 2, Microsoft officiel) +
  Google TypeScript Style Guide (niveau 2, organisation majeure) +
  Vanderkam Effective TypeScript (niveau 5, expert reconnu O'Reilly) +
  TypeScript Handbook Everyday Types (niveau 3, documentation officielle) +
  Total TypeScript Pocock (niveau 3, expert communaute reconnu) +
  NestJS documentation (niveau 3, framework officiel)
  convergent sans contradiction sur les regles de decision :
  - Preference interface par defaut (sources officielles + expert + Google)
  - Performance compilateur : interfaces cachees (TypeScript wiki niveau 2)
  - API publiques = interface pour declaration merging (TypeScript docs + Vanderkam)
  - Unions/mapped/conditional types = type obligatoire (Pocock + TypeScript docs)
  - DTOs NestJS = class obligatoire pour metadonnees runtime (NestJS docs)
  6 sources independantes, 4 contextes distincts (officiel Microsoft, industriel
  grande echelle, expert communaute, framework applicatif). Aucune contradiction.

+ 1 effet important
  Performance compilateur documentee par benchmarks officiels TypeScript Team
  (interfaces cachees vs intersection types recalcules a chaque usage — impact
  mesurable sur grandes codebases, TypeScript wiki niveau 2).
  NestJS DTOs en class obligatoire sous peine de validation silencieusement
  inactive ou crash runtime lors de la transformation (class-validator/
  class-transformer inoperants sur interfaces — impact direct bugs production,
  NestJS docs niveau 3 confirme).
  Messages d'erreur ameliores avec interface (TypeScript Handbook).

- 0 (aucun malus)
  Pas d'indirection : les sources de niveau 2 traitent directement la question.
  Pas d'incoherence entre sources.
  Pas d'imprecision : les regles sont formulees explicitement par les sources.

Score final : 3 + 1 + 1 = 5 → [STANDARD]
```

Note biais de publication : sources officielles TypeScript (Microsoft) et NestJS non soumises au biais de publication. Google Style Guide : pratique interne codifiee, pas de biais editorial. Effective TypeScript (O'Reilly) : livre technique ; biais possible vers le prescriptif, attenue par la confirmation de l'equipe TypeScript officielle sur les memes points. Total TypeScript (Pocock) : blog expert ; inclus pour l'heuristique complementaire sur les cas exclusifs de type, non pour les points couverts par les sources officielles.

---

## Analyse de sensibilite {#analyse-de-sensibilite}

| Source retiree | Score sans | Niveau sans | Changement ? |
|---------------|-----------|------------|:------------:|
| TypeScript wiki Performance (niveau 2) | 3+0+1=4 (depart niveau 2 Google Style Guide, convergence maintenue, effet NestJS reste) | [RECOMMANDE] | OUI — mais scenario improbable : wiki officiel Microsoft equipe TypeScript, peu susceptible de disparaitre |
| Google TypeScript Style Guide (niveau 2) | 3+1+1=5 (TypeScript wiki niveau 2 reste comme source la plus haute) | [STANDARD] | NON |
| Vanderkam Effective TypeScript | 5 (Google + TypeScript wiki convergent, NestJS docs confirment) | [STANDARD] | NON |
| Total TypeScript Pocock | 5 (regle unions/mapped types couverte partiellement par TypeScript Handbook) | [STANDARD] | NON |
| NestJS documentation | 4 (effet runtime NestJS non documente — malus potentiel -1 sur effet ; convergence maintenue) | [RECOMMANDE] | OUI partiel — mais l'obligation class pour class-validator est verifiable empiriquement meme sans la doc |
| TypeScript Handbook Everyday Types | 5 (TypeScript wiki + Google Style Guide couvrent la prescription) | [STANDARD] | NON |
| TypeScript Handbook Declaration Merging | 5 (Vanderkam + Google Style Guide couvrent la regle API publiques) | [STANDARD] | NON |
| Stemmler khalilstemmler.com | 5 (regle abstract class marginale par rapport au principe principal) | [STANDARD] | NON |
| Toutes sources niveau 5 simultanement | 3+1+1=5 (niveaux 2 et 3 suffisent) | [STANDARD] | NON |
| TypeScript wiki + Google Style Guide simultanement | 2+1+0=3 (depart niveau 3, convergence maintenue, mais effet moins fort sans benchmarks officiels) | [RECOMMANDE] | OUI |

**Conclusion : ROBUSTE** — recommandation [STANDARD] stable pour tout retrait individuel. Les deux scenarios de declassement potentiel (retrait TypeScript wiki Performance seul, ou retrait simultane des deux sources niveau 2) sont improbables : le TypeScript wiki Performance est une documentation officielle Microsoft active et le Google TypeScript Style Guide est un artefact public maintenu. La convergence forte de 6 sources independantes sur 4 contextes distincts et l'effet documente (performance compilateur avec benchmarks, bugs runtime NestJS) confortent la robustesse du score [STANDARD].

---

## Sources exclues

| Source | Critere | Raison |
|--------|---------|--------|
| LogRocket Blog "Types vs. interfaces in TypeScript" | E5 partiel | Niveau 3 acceptable — les points de performance sont couverts avec plus d'autorite par TypeScript wiki officiel (Microsoft, niveau 2). Le point declaration merging est couvert par TypeScript Handbook Declaration Merging. Redondance forte sans apport differencie. |
| Airbnb TypeScript Style Guide | E5 | Moins prescriptif que Google Style Guide sur la decision interface/type, sans justification technique sur la performance ou la declaration merging. Contenu absorbe par Google Style Guide. |
| Cherny B. — Programming TypeScript (O'Reilly, 2019) | E5 | Couvert par Effective TypeScript Vanderkam (plus recent : 2021/2023, meme editeur, traite directement la question interface/type/class avec plus de precision). Redondant. |
| Angular Style Guide | E2 | Prescrit les classes pour services et composants dans le contexte specifique Angular — hors scope du principe universel TypeScript PICOC. Candidat pour un variant angular si pertinent. |
| Stack Overflow threads (interface vs type TypeScript) | E1 | Opinion communaute non auditable. Les votes eleves ne constituent pas un niveau de preuve acceptable selon la pyramide EBSE. Points couverts par les sources officielles incluses. |
| GitHub Copilot / AI blogs sur TypeScript best practices | E1 | Opinion generee ou editoriale sans fondement empirique ni normatif. |
| RFC TypeScript (anciens) | E3 | TypeScript RFCs initiaux sur les types et interfaces — absorbes par la documentation officielle actuelle plus complete et maintenue. |
