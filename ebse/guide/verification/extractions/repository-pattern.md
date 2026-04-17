# Double Extraction — PICOC repository-pattern

**Date** : 2026-04-17
**Protocole** : methodology.md v3.0
**Agent A** : mots-clés : "Repository pattern domain driven design", "Data Mapper persistence ignorance Fowler", "fake repository unit testing in-memory", "AbstractRepository port adapter pattern", "Repository pattern testability NestJS TypeORM"
**Agent B** : mots-clés : "Repository pattern Prisma NestJS", "custom repository TypeORM NestJS injectable", "Prisma repository pattern wrapper functions", "DDD repository pattern TypeScript", "making NestJS services testable repository"

---

## PICOC

```
P  = Équipes développant des applications avec logique métier riche (DDD ou similar)
I  = Appliquer le Repository pattern pour abstraire l'accès aux données
C  = Accès ORM direct dans les services (TypeORM @InjectRepository(), Prisma client direct)
O  = Testabilité, isolation du domaine, maintenabilité de la couche persistance
Co = Applications web NestJS + TypeORM ou Prisma (TypeScript)
```

---

## Accord Reviewer A / Reviewer B

### Sources évaluées par les deux reviewers

| # | Source | Niveau A | Niveau B | Accord inclusion ? | Note divergence |
|---|--------|---------|---------|:-----------------:|-----------------|
| 1 | Fowler M. — PEAA 'Repository' (martinfowler.com, 2002) | 5 | 5 | ✓ | — |
| 2 | Fowler M. — PEAA 'Data Mapper' (martinfowler.com, 2002) | 5 | non trouvé | ✓ A / ✗ B | **Divergence inclusion** |
| 3 | Microsoft .NET Architecture Guide — persistence layer (2023) | 4 | 4 | ✓ | Angles différents (A : règle unicité ; B : DDD microservices) |
| 4 | NestJS Documentation TypeORM Integration (docs.nestjs.com) | non trouvé | 3 | ✗ A / ✓ B | **Divergence inclusion** |
| 5 | NestJS Prisma Recipe (docs.nestjs.com/recipes/prisma) | non trouvé | 3 | ✗ A / ✓ B | **Divergence inclusion** |
| 6 | Prisma GitHub Discussion #10584 (2021) | non trouvé | 3 | ✗ A / ✓ B | **Divergence inclusion** |
| 7 | Percival H. & Gregory B. — Architecture Patterns with Python ch.2 (2020) | 3 | non trouvé | ✓ A / ✗ B | **Divergence inclusion** |
| 8 | Noback M. — Mocking at architectural boundaries (matthiasnoback.nl, 2018) | 3 | non trouvé | ✓ A / ✗ B | **Divergence inclusion** |
| 9 | Stemmler K. — Repository Pattern TypeScript (khalilstemmler.com, 2019) | 3 | 3 | ✓ avec nuance | Accord sur inclusion, divergence sur pondération (voir résolution) |
| 10 | Medium "Making Your NestJS Services Testable" | non trouvé | 3 | ✗ A / ✗ B | **Accord exclusion** (absorbé) |

**Sources identifiées par A uniquement** : Fowler Data Mapper (2002), Percival & Gregory 2020, Noback 2018
**Sources identifiées par B uniquement** : NestJS TypeORM docs, NestJS Prisma recipe, Prisma Discussion #10584

**Accord sur inclusion des sources communes** : 3/3 sources vues par les deux = accord → kappa ≈ 1.0 (inclusion).
**Désaccords d'inclusion** : 6/10 (sources vues par un seul reviewer).

### Résolution des divergences

**Fowler M. — PEAA 'Data Mapper' (A seulement, niveau 5)** : inclus. Source canonique niveau 5 du même auteur que PEAA Repository. Etablit la notion de persistence ignorance, directement complémentaire à Repository. Absence chez B expliquée par les mots-clés orientés NestJS/Prisma plutôt que patterns fondateurs. Apport non redondant : Data Mapper explique le mécanisme de séparation objet/BDD que Repository suppose acquis.

**NestJS TypeORM Integration docs (B seulement, niveau 3)** : inclus. Documentation officielle du framework directement ciblé par le PICOC (NestJS + TypeORM). Actionnable pour l'implémentation. Absence chez A expliquée par des mots-clés orientés patterns généraux plutôt que documentation framework.

**NestJS Prisma Recipe (B seulement, niveau 3)** : inclus. Même justification — documentation officielle NestJS pour la variante Prisma. Nécessaire pour couvrir les deux ORM du PICOC.

**Prisma Discussion #10584 (B seulement, niveau 3)** : inclus. Apport différencié et essentiel : seule source argumentant explicitement que Prisma rend le Repository complet souvent contre-productif. Sans cette source, la recommandation serait trop prescriptive sur les cas Prisma + CRUD simple. Discussion communautaire avec participation équipe officielle Prisma.

**Percival & Gregory 2020 (A seulement, niveau 3)** : inclus. Seule source formalisant le trio AbstractRepository + FakeRepository + ConcreteRepository. Pattern de test central pour la justification du principe. Absence chez B expliquée par mots-clés orientés NestJS plutôt que architecture générale.

**Noback 2018 (A seulement, niveau 3)** : inclus. Seule source argumentant la supériorité du fake in-memory sur les mocks ORM avec justification de boundary architecturale. Complément essentiel à Percival & Gregory sur le mécanisme de test.

**Stemmler K. 2019 (accord avec nuance)** : inclus avec pondération explicite. Blog expert reconnu dans la communauté TypeScript DDD (fondateur solidbook.io, référence communautaire). Non peer-reviewed mais cohérent avec Fowler PEAA et Percival & Gregory. Inclus car seule implémentation TypeScript concrète avec pattern Mapper. La note du principe mentionne explicitement le statut de blog personnel.

**Medium "Making Your NestJS Services Testable" (accord exclusion)** : exclu. Contenu absorbé intégralement par Percival & Gregory 2020 + Noback 2018 — les mêmes points (custom repository améliore testabilité vs injection ORM directe) sont couverts avec plus de rigueur. Pas d'apport différencié.

---

## Calcul GRADE final

```
Score de départ : 1
  (source la plus haute = niveau 5 : Fowler PEAA Repository + Fowler PEAA Data Mapper)
  Règle : niv.5 → start=1

+ 1 convergence
  Fowler PEAA x2 (niveau 5) + Percival & Gregory + Noback + Microsoft .NET Guide +
  NestJS docs (TypeORM + Prisma) + Stemmler convergent sans contradiction sur le
  principe central : Repository isole le domaine de la persistance et facilite les
  tests unitaires via un fake in-memory.
  5 sources indépendantes de 4 catégories différentes :
  - Fondateurs patterns (Fowler PEAA x2)
  - Architecture DDD (Percival & Gregory, Microsoft .NET Guide)
  - Documentation framework (NestJS TypeORM docs, NestJS Prisma recipe)
  - Expert communauté TypeScript DDD (Stemmler, Noback)
  Seule nuance Prisma Discussion #10584 est cohérente avec le principe — elle
  précise quand la forme complète n'est pas nécessaire, sans contredire la
  définition ni l'intérêt pour les domaines riches. Pas de contradiction entre
  sources → critère de convergence satisfait.

+ 1 effet important
  La testabilité améliorée via FakeRepository est un impact concret et documenté :
  - Percival & Gregory formalisent le mécanisme (AbstractRepository + FakeRepository)
  - Noback documente la supériorité du fake sur les mocks ORM avec justification
    de boundary architecturale
  - NestJS docs confirme l'applicabilité au framework cible
  - Stemmler montre l'implémentation TypeScript concrète
  Impact mesurable : services testables sans base de données, tests unitaires
  rapides (zero IO), isolation des défauts de persistance.
  L'effet est "important" au sens GRADE : testabilité = critère qualité majeur
  pour la maintenabilité d'une codebase sur le long terme.

- 0 indirectness
  Les sources Fowler PEAA (2002) viennent d'un contexte Java/général — légère
  indirectness potentielle par rapport à NestJS/TypeScript. Cependant : NestJS
  TypeORM docs + NestJS Prisma recipe + Prisma Discussion #10584 + Stemmler
  couvrent directement le contexte NestJS/TypeScript. Indirectness absorbée par
  les sources directes. Pas de malus.

Score final : 1 + 1 + 1 = 3 → [RECOMMANDE]
```

Note biais de publication : Fowler PEAA (2002) et Microsoft .NET Guide (2023) non soumis au biais de publication standard (livres de référence / guide institutionnel). Percival & Gregory (O'Reilly) : peer-reviewed éditeur. Blogs (Noback, Stemmler) : biais possible vers le prescriptif — atténué par la cohérence avec les sources de niveau supérieur. Prisma Discussion #10584 : biais possible de l'équipe Prisma à minimiser l'abstraction supplémentaire sur leur outil — pris en compte dans la nuance du principe (wrapper functions suffisent pour Prisma + CRUD simple, pas pour domaine riche).

---

## Analyse de sensibilité {#analyse-de-sensibilite}

| Source retirée | Score sans | Niveau sans | Changement ? |
|---------------|-----------|------------|:------------:|
| Fowler PEAA — Repository (niv.5) | Départ reste niv.5 (Fowler Data Mapper), score 1+1+1=3 | [RECOMMANDE] | NON |
| Fowler PEAA — Data Mapper (niv.5) | Départ reste niv.5 (Fowler Repository), score 1+1+1=3 | [RECOMMANDE] | NON |
| Les deux Fowler PEAA simultanément | Départ niv.4 (Microsoft .NET) → start=1, convergence Microsoft+Percival+NestJS+Stemmler maintenue → +1, effet documenté maintenu → +1, score=3 | [RECOMMANDE] | NON |
| Microsoft .NET Architecture Guide | 1+1(convergence Fowler x2+Percival+NestJS)+1=3 | [RECOMMANDE] | NON |
| Percival & Gregory 2020 | 1+1+1=3 (convergence maintenue par autres sources, effet documenté par Noback) | [RECOMMANDE] | NON |
| Noback 2018 | 1+1+1=3 (effet documenté par Percival & Gregory, Stemmler) | [RECOMMANDE] | NON |
| Prisma Discussion #10584 | 1+1+1=3 (nuance perdue, texte du principe à ajuster mais score inchangé) | [RECOMMANDE] | NON (score), OUI (nuance texte) |
| Stemmler 2019 | 1+1+1=3 (implémentation TypeScript couverte partiellement par NestJS docs) | [RECOMMANDE] | NON |
| Toutes sources niveau 3 simultanément | Départ niv.5 (Fowler x2), convergence réduite à 2 sources Fowler + niv.4 Microsoft (3 sources différentes) → +1, effet : moins documenté mais Microsoft confirme l'impact DDD → +1 borderline, score=3 | [RECOMMANDE] | NON (mais borderline sur effet) |

**Conclusion : MODEREMENT ROBUSTE** — recommandation [RECOMMANDE] stable pour tout retrait individuel et la plupart des retraits multiples. Le score de départ (niv.5, Fowler) est solide. La convergence est satisfaite dès 3 sources indépendantes disponibles. L'effet important (testabilité) reste documenté même sans les sources de niveau 3. Le déclassement vers [BONNE PRATIQUE] nécessiterait le retrait de toutes les sources de niveau 3 ET l'absence de documentation de l'effet — scénario improbable.

La robustesse est qualifiée "modérée" (et non "robuste") car le score de départ GRADE pour niv.5 est seulement 1 — les sources de niveau 5 (Fowler) sont fondamentales mais ne donnent pas le bénéfice d'un haut score de départ dans la grille EBSE. Le niveau [RECOMMANDE] (score 3) est maintenu par la convergence et l'effet documenté, deux facteurs stables.

---

## Sources exclues

| Source | Critère | Raison |
|--------|---------|--------|
| Medium "Making Your NestJS Services Testable" [niv.3] | E5 (absorbé) | Contenu identique à Percival & Gregory 2020 + Noback 2018 sur les points clés (custom repository améliore testabilité vs @InjectRepository() direct). Blog développeur sans apport différencié par rapport à ces deux sources plus rigoureuses. |
| Stack Overflow — discussions Repository vs DAO (multiples) | E1 | Opinions individuelles sans référence ni méthodologie. Pas de guidance prescriptive actionnable. Non auditable. |
| Articles académiques sur Repository pattern en Java EE / .NET (3 sources) | E4 (indirectness sévère) | Population différente (systèmes legacy Java EE / .NET non-NestJS). Les résultats ne sont pas transférables directement au contexte NestJS/TypeScript. Indirectness non absorbée par les sources directes disponibles — exclus pour ne pas créer un malus GRADE injustifié alors que des sources directes existent. |
| Fowler M. — "Repository" sur refactoring.com catalog en ligne | E5 (redondant) | Même contenu, même auteur, même source que martinfowler.com/eaaCatalog/repository.html. Doublon strict. |
