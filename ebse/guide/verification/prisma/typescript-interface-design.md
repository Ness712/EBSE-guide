# PRISMA Flow — PICOC typescript-interface-design

**Date de recherche** : 2026-04-17
**Bases interrogees** : TypeScript official documentation (typescriptlang.org), TypeScript GitHub wiki (microsoft/TypeScript), Google TypeScript Style Guide, NestJS documentation, Total TypeScript (totaltypescript.com), khalilstemmler.com, O'Reilly (Effective TypeScript), WebSearch general
**Mots-cles Agent A** : "typescript interface vs type alias performance compiler", "TypeScript Performance wiki interface caching intersection", "Google TypeScript Style Guide interface type", "abstract class vs interface TypeScript coupling", "TypeScript structural typing interface type compatibility", "TypeScript declaration merging interface only"
**Mots-cles Agent B** : "typescript interface type alias when to use", "NestJS DTO class vs interface class-validator runtime metadata", "TypeScript Handbook everyday types interface default", "Effective TypeScript interface type public API declaration merging", "Total TypeScript Matt Pocock interface type union mapped type"
**Protocole** : methodology.md v3.0 §2.1 — double extraction independante (Agents A + B, mots-cles differents) + synthese Agent C

---

## Flux

```
IDENTIFICATION
  Sources identifiees par base (Agent A + Agent B combines, avant deduplication) :
    - Documentation officielle TypeScript (typescriptlang.org, handbook, wiki) : ~8 resultats candidats
    - Style guides organisationnels (Google, Airbnb, Microsoft) : ~5 resultats candidats
    - Documentation frameworks (NestJS, Angular) : ~6 resultats candidats
    - Livres de reference (Effective TypeScript, Programming TypeScript) : ~4 resultats candidats
    - Experts communaute (Total TypeScript, khalilstemmler.com, dev.to experts) : ~10 resultats candidats
    - Blog posts et articles techniques : ~15 resultats candidats
    - Snowballing backward (references citees par sources principales) : ~4 sources
  Total identifie (brut, combine A+B) : ~52
  Doublons retires (meme source identifiee par A et B) : 8 (TypeScript Handbook Everyday Types,
    TypeScript Performance wiki, TypeScript Declaration Merging docs, TypeScript Type Compatibility docs,
    NestJS validation docs, Effective TypeScript Vanderkam, Total TypeScript Pocock, Google Style Guide)
  Total apres deduplication : ~44

SCREENING (titre + resume)
  Sources screeniees : ~44
  Sources exclues au screening : ~29
    - E1 (blog opinion sans donnees ni methodologie, Dev.to posts generiques) : ~12
    - E2 (hors scope PICOC — TypeScript general, pas la decision interface/type/class) : ~8
    - E3 (doublons partiels — couverts par sources primaires deja incluses) : ~5
    - E4 (vendeur / marketing sans substance technique, tutoriels introductifs) : ~4

ELIGIBILITE (lecture complete)
  Sources evaluees en detail : ~15
  Sources exclues apres lecture complete : ~6
    - LogRocket Blog "Types vs interfaces in TypeScript" : niveau 3 acceptable, points de performance
      couverts avec plus d'autorite par TypeScript wiki officiel ; point declaration merging couvert
      par TypeScript Handbook Declaration Merging — redondance sans apport differencie
    - Airbnb TypeScript Style Guide : moins prescriptif sur interface vs type que Google Style Guide,
      pas de justification technique ajoutee
    - "Programming TypeScript" O'Reilly (Cherny 2019) : couvert par Effective TypeScript Vanderkam
      (plus recent, meme editeur, directement sur la question)
    - Angular Style Guide : couvre les classes pour les services/components mais pas la decision
      interface/type/class en general — hors scope PICOC strict
    - GitHub Copilot / OpenAI blogs sur TypeScript : opinion sans fondement empirique ou normatif
    - Stack Overflow threads (3 entrees) : opinion communaute, non auditable, non peer-reviewed

INCLUSION
  Sources incluses dans la synthese : 9
    - Niveau 2 : 2 (TypeScript Team Performance wiki, Google TypeScript Style Guide)
    - Niveau 3 : 6 (TypeScript Handbook Everyday Types, TypeScript Handbook Declaration Merging,
                    TypeScript Handbook Type Compatibility, NestJS documentation DTOs/Validation,
                    Total TypeScript Pocock, Stemmler khalilstemmler.com)
    - Niveau 5 : 1 (Vanderkam Effective TypeScript 2nd ed.)

  Sources exclues avec raison documentee : 6 (voir section Sources exclues ci-dessous)
```

---

## Documentation recherche (Table 2 Kitchenham)

### Agent A — bases interrogees

| Element | Valeur |
|---------|--------|
| Bases | TypeScript GitHub wiki, typescriptlang.org, google.github.io/styleguide, khalilstemmler.com, WebSearch general |
| Mots-cles | "typescript interface vs type alias performance compiler", "TypeScript Performance wiki interface caching intersection", "Google TypeScript Style Guide interface type", "abstract class vs interface TypeScript coupling", "TypeScript structural typing interface type compatibility", "TypeScript declaration merging interface only" |
| Periode couverte | 2019-2024 |
| Sources identifiees | ~25 |
| Sources retenues | 5 (TypeScript wiki Performance, Google Style Guide, TypeScript Handbook Type Compatibility, TypeScript Handbook Declaration Merging, Stemmler) |
| Date d'extraction | 2026-04-17 |

### Agent B — bases interrogees

| Element | Valeur |
|---------|--------|
| Bases | typescriptlang.org, docs.nestjs.com, totaltypescript.com, O'Reilly catalog, WebSearch |
| Mots-cles | "typescript interface type alias when to use", "NestJS DTO class vs interface class-validator runtime metadata", "TypeScript Handbook everyday types interface default", "Effective TypeScript interface type public API declaration merging", "Total TypeScript Matt Pocock interface type union mapped type" |
| Periode couverte | 2019-2024 |
| Sources identifiees | ~27 |
| Sources retenues | 6 (TypeScript Handbook Everyday Types, NestJS docs, Effective TypeScript Vanderkam, Total TypeScript Pocock, plus convergence sur TypeScript wiki Performance et Google Style Guide) |
| Date d'extraction | 2026-04-17 |

---

## Sources exclues — raisons documentees

| Source | Raison exclusion |
|--------|-----------------|
| LogRocket Blog "Types vs. interfaces in TypeScript" | Niveau 3 — points de performance couverts avec plus d'autorite par TypeScript wiki officiel (Microsoft, niveau 2) ; point declaration merging couvert par TypeScript Handbook Declaration Merging sans apport differencie. Redondance forte sans valeur ajoutee. |
| Airbnb TypeScript Style Guide | Moins prescriptif que Google Style Guide sur la decision interface/type ; ne fournit pas de justification technique sur la performance ou la declaration merging. Contenu absorbe par Google Style Guide. |
| Cherny B. — Programming TypeScript (O'Reilly, 2019) | Couvert par Effective TypeScript Vanderkam (plus recent : 2021/2023, meme editeur, traite directement la question interface/type/class). Redondant. |
| Angular Style Guide | Prescrit les classes pour les services et composants Angular — contexte trop specifique Angular, hors scope du principe universel TypeScript. Candidat pour un variant angular si pertinent. |
| Stack Overflow threads (interface vs type TypeScript) | Opinion communaute non auditable. Les votes eleves ne constituent pas un niveau de preuve acceptable selon la pyramide EBSE. Points couverts par les sources officielles incluses. |
| GitHub Copilot / AI blogs sur TypeScript best practices | Opinion generee ou editoriale sans fondement empirique ni normatif. Non inclus. |
