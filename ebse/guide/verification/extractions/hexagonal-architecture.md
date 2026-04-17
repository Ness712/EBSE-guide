# Double Extraction — PICOC hexagonal-architecture

**Date** : 2026-04-17
**Protocole** : methodology.md v3.0
**Agent A** : mots-cles : "hexagonal architecture ports adapters Cockburn", "clean architecture dependency rule Robert Martin", "domain-driven design domain isolation Evans", "Fowler presentation domain data layering", "AWS hexagonal architecture pattern", "hexagonal architecture dependency inversion principle"
**Agent B** : mots-cles : "implementing DDD Vernon hexagonal bounded context", "architecture patterns Python O'Reilly ports adapters", "NestJS hexagonal architecture TypeScript", "domain-driven hexagon NestJS Sairyss GitHub", "vertical slice architecture Bogard alternative hexagonal", "layered architecture vs hexagonal testability database"

---

## PICOC

```
P  = Equipes developpement concevant des applications avec dependances externes (BDD, APIs, UI)
I  = Structurer l'application selon l'architecture hexagonale (Ports & Adapters) pour isoler le domaine
C  = Couplage direct entre logique metier et infrastructure (BDD, frameworks, APIs externes)
O  = Maintenabilite/Modularite, testabilite unitaire, independance technologique
Co = Applications web (toutes stacks) — universel
```

---

## Accord Reviewer A / Reviewer B

| # | Source | Niveau A | Niveau B | Accord inclusion ? | Note divergence |
|---|--------|---------|---------|:-----------------:|-----------------|
| 1 | Cockburn — Hexagonal Architecture 2005 (alistair.cockburn.us) | 5 | absent | divergence | **A cite (source primaire du pattern), B couvre via Vernon 2013 et Percival 2020 qui citent Cockburn** |
| 2 | Cockburn & Garrido de Paz — Hexagonal Architecture Explained 2023 | 5 | absent | divergence | **A cite (formalisation definitive), B absent** |
| 3 | Martin R.C. — Clean Architecture 2017 | 5 | 5 | ✓ | — |
| 4 | Evans E. — Domain-Driven Design 2003 | 5 | absent | divergence | **A cite (fondement theorique), B couvre via Vernon 2013 (extension DDD)** |
| 5 | Fowler M. — PresentationDomainDataLayering bliki 2015 | 5 | absent | divergence | **A cite, B juge absorbe par Vernon et Percival — resolution : exclu (E5 partiel)** |
| 6 | Unite tech blog — DIP/hexagonale 2022 | 5 | absent | divergence | **A cite, B absent — resolution : exclu (E5 partiel, absorbe par Cockburn 2023)** |
| 7 | AWS Prescriptive Guidance — Hexagonal Architecture Pattern 2023 | 3 | absent | divergence | **A cite (reconnaissance cloud provider), B absent** |
| 8 | Vernon V. — Implementing DDD 2013 | absent | 5 | divergence | **B cite (Bounded Context + hexagonale), A couvre via Evans 2003** |
| 9 | Percival H. & Gregory B. — Architecture Patterns with Python 2020 | absent | 5 | divergence | **B cite (application production), A absent** |
| 10 | Slomka K. — Hexagonal NestJS TypeScript Medium 2023 | absent | 5 | divergence | **B cite (specifique NestJS), A absent** |
| 11 | Sairyss — Domain-Driven Hexagon GitHub 2022-2024 | absent | 5 | divergence | **B cite (reference communaute TypeScript/NestJS), A absent** |
| 12 | Bogard J. — Vertical Slice Architecture 2019 | absent | 5 | divergence | **B cite (alternative contextuelle), A absent** |
| 13 | Stackify — SOLID DIP 2023 | absent | 5 | divergence | **B cite, A juge absorbe — resolution : exclu (E3, absorbe par Martin 2017)** |
| 14 | ACM EASE 2024 — comparative SAST | absent | 1 | divergence | **B cite (seule source empirique), A absent** |

**Accord sur sources communes** : 1/1 (Martin 2017) → kappa sources communes = 1.0.
**Sources A-only retenues** : Cockburn 2005, Cockburn+Garrido 2023, Evans 2003, AWS Prescriptive Guidance 2023.
**Sources B-only retenues** : Vernon 2013, Percival+Gregory 2020, Slomka 2023, Sairyss 2023, Bogard 2019, ACM EASE 2024.
**Taux d'accord brut** : 1 accord / 14 sources evaluees = 7% (adequat compte tenu des mots-cles deliberement divergents — Agent A cible les fondateurs, Agent B cible les applications modernes).

### Resolution des divergences

**Cockburn 2005 et Cockburn+Garrido 2023 (A-only)** : Inclus — Cockburn est l'inventeur du pattern ; toute etude sur l'hexagonale decoule de ces sources. L'absence chez B est une consequence des mots-cles (B cible les applications modernes) — non un desaccord de valeur. L'inclusion est obligatoire : source primaire fondatrice, pyramide 5.

**Evans 2003 (A-only)** : Inclus — Evans fournit le 'pourquoi' theorique de l'isolation du domaine que l'hexagonale implements architecturalement. Vernon 2013 (B) est une extension de Evans — la source primaire est superieure. A l'emporte.

**Fowler 2015 et Unite tech blog 2022 (A-only)** : Exclus — absorbes par des sources plus recentes et plus completes (Vernon 2013, Cockburn 2023, Slomka 2023). E5 partiel — pas d'apport marginal suffisant.

**AWS Prescriptive Guidance 2023 (A-only)** : Inclus — signal d'adoption industrie valide (cloud provider majeur) meme si pyramide 3. Argument A retenu : valide la pertinence contemporaine du pattern pour les applications cloud.

**Vernon 2013 (B-only)** : Inclus — articule explicitement la relation Bounded Context / hexagone, absent chez A. Apport distinct de Evans 2003 (Evans : pourquoi isoler ; Vernon : comment organiser les hexagones par Bounded Context). B l'emporte.

**Percival & Gregory 2020 (B-only)** : Inclus — seule source avec exemples concrets de tests unitaires du domaine sans BDD (implementation in-memory des ports). Valide operationnellement le benefice principal de l'hexagonale. B l'emporte.

**Slomka 2023 et Sairyss 2023 (B-only)** : Inclus — seules sources specifiques au stack NestJS/TypeScript. Applicabilite concrete pour les equipes TypeScript — apport indispensable pour les recommandations pratiques. B l'emporte.

**Bogard 2019 (B-only)** : Inclus — nuance critique : l'hexagonale n'est pas systematiquement superieure. Vertical Slice Architecture est une alternative valide pour les domaines legers. B l'emporte — la nuance contextuelle est essentielle pour eviter la sur-ingenierie.

**Stackify SOLID DIP 2023 (B-only)** : Exclu — DIP est couvert par Martin 2017 avec plus de profondeur et d'autorite. E3 — absorbe.

**ACM EASE 2024 (B-only)** : Inclus malgre l'indirectness — seule source empirique peer-reviewed de niveau 1. L'isolation de composants (son sujet) est la base mesurable du benefice de testabilite de l'hexagonale. Inclus avec note d'indirectness explicite dans le calcul GRADE.

---

## Calcul GRADE final

```
Score de depart : 1
  (source la plus haute directement pertinente = niveau 5 :
   Cockburn 2005/2023, Martin 2017, Evans 2003, Vernon 2013, Percival 2020,
   Slomka 2023, Sairyss 2023, Bogard 2019 — tous pyramide 5.
   La seule source niv.1 (ACM EASE 2024) est indirecte — elle ne porte pas
   directement sur l'architecture hexagonale mais sur l'isolation de composants.
   Score de depart = 1 (niv.5 → 1 point selon grille GRADE).)

+ 1 convergence forte
  9 sources niv.5 + 1 source niv.3 (AWS) + 1 source niv.1 indirecte (ACM EASE 2024)
  convergent sans contradiction sur :
  (1) l'isolation du domaine comme principe fondamental — Cockburn, Martin, Evans, Vernon ;
  (2) la testabilite unitaire par isolation (tests sans BDD) — Percival, Slomka, Sairyss ;
  (3) l'independance technologique (swap d'infrastructure) — Cockburn, Martin, AWS ;
  (4) la nuance YAGNI (domaine riche vs leger) — Bogard.
  11 sources independantes couvrant 2003-2024, de l'inventeur aux praticiens modernes,
  incluant un cloud provider majeur et une source empirique.

+ 1 effet important (marginal — documente par praticiens, pas par etudes controlees)
  Percival & Gregory 2020 et Slomka 2023 documentent concretement la testabilite unitaire
  totale du domaine sans BDD — le benefice est operationnellement demonstrable (tests plus
  rapides, independants de l'infrastructure). ACM EASE 2024 valide empiriquement que
  l'isolation de composants reduit la propagation de defauts. L'effet est important pour
  les applications avec logique metier riche, et la reconnaissance AWS valide l'echelle.

- 1 indirectness
  Presque toutes les sources sont prescriptives/expertales (niv.5) — literature d'experts
  reconnus, pas d'etudes RCT controlees comparant 'projet hexagonal vs projet layered'
  avec metriques quantifiees (defects, cout de maintenance, duree de regression tests).
  La seule source niv.1 (ACM EASE 2024) est indirecte : concerne l'isolation de composants
  et SAST en general, pas l'architecture hexagonale specificitement. Pas de meta-analyse
  empirique directe sur 'hexagonal vs layered'. La robustesse empirique reste moderee.

Score final : 1 + 1 + 1 - 1 = 2 → [BONNE PRATIQUE]

Note GRADE : le score [BONNE PRATIQUE] est honnete pour un pattern architectural.
  Les patterns architecturaux en SE sont quasi-universellement documentes par litterature
  prescriptive d'experts (niv.5) car les etudes RCT controlees sont methodologiquement
  difficiles (on ne peut pas randomiser des projets entiers sur 5 ans pour comparer
  l'architecture hexagonale vs layered). [BONNE PRATIQUE] ne signifie pas 'eviter' —
  il signifie que la recommandation repose sur un consensus d'experts forts (Cockburn,
  Martin, Evans, Vernon) sans validation empirique directe a grande echelle.
  La convergence de 9 sources niv.5 sur les memes benefices justifie l'application
  dans les contextes identifies (domaine metier riche, need testabilite, stack DI).

  Variante RECOMMANDE possible si l'on considere que :
  - la convergence de 9 experts fondateurs sans aucune contradiction est exceptionnnelle
    pour un pattern architectural en SE ;
  - ACM EASE 2024 valide empiriquement le principe sous-jacent (isolation de composants) ;
  - AWS Prescriptive Guidance valide l'adoption a l'echelle cloud.
  Decision finale retenue : [BONNE PRATIQUE] — par rigueur methodologique sur l'absence
  d'etudes empiriques directes sur l'hexagonale specificitement.
```

---

## Analyse de sensibilite {#analyse-de-sensibilite}

| Source retiree | Score sans | Niveau sans | Changement ? |
|----------------|-----------|------------|:------------:|
| Cockburn 2005 (niv.5) | 2 (depart 1, +1 conv, +1 effet, -1 indirect — Cockburn 2023 maintient la source primaire) | [BONNE PRATIQUE] | NON |
| Cockburn 2005 + Cockburn 2023 simultanement (niv.5) | 2 (depart 1, +1 conv Martin+Evans+Vernon+Percival, +1 effet, -1 indirect) | [BONNE PRATIQUE] | NON — Martin 2017 et Evans 2003 couvrent les principes fondamentaux |
| Martin 2017 — Clean Architecture (niv.5) | 2 (depart 1, +1 conv Cockburn+Evans+Vernon+Percival, +1 effet, -1 indirect) | [BONNE PRATIQUE] | NON |
| Evans 2003 — DDD (niv.5) | 2 (depart 1, +1 conv Cockburn+Martin+Vernon+Percival, +1 effet, -1 indirect) | [BONNE PRATIQUE] | NON — Vernon 2013 couvre le lien DDD/hexagonale |
| ACM EASE 2024 (niv.1 — seule source empirique) | 2 (depart 1, +1 conv, +1 effet praticiens, -1 indirect — indirectness augmente sans source niv.1) | [BONNE PRATIQUE] | NON — score maintenu mais robustesse empirique affaiblie |
| Toutes sources niv.5 simultanement | 0 (depart 1, convergence inexistante, -1 indirect — ne reste que AWS niv.3 et ACM niv.1 indirect) | [CHOIX D'EQUIPE] | OUI — scenario hypothetique (retrait de 9 experts fondateurs) |
| Bogard 2019 — Vertical Slice Architecture (niv.5) | 2 (score inchange) | [BONNE PRATIQUE] | NON — score inchange mais nuance YAGNI affaiblie : risque de sur-ingenierie moins bien documente |
| AWS Prescriptive Guidance (niv.3) | 2 (niv.3 ne contribue pas au score de depart) | [BONNE PRATIQUE] | NON — signal d'adoption industrie affaibli mais score inchange |
| Percival & Gregory 2020 (niv.5) | 2 (depart 1, +1 conv, +1 effet reduit, -1 indirect — Slomka et Sairyss maintiennent les exemples concrets) | [BONNE PRATIQUE] | NON |
| Slomka 2023 + Sairyss 2023 simultanement (niv.5) | 2 (score inchange sur principes, applicabilite NestJS affaiblie) | [BONNE PRATIQUE] | NON — recommandation NestJS moins directe, principe inchange |

**Conclusion : MODERE** — la recommandation [BONNE PRATIQUE] est stable pour tout retrait individuel ou retrait de groupes de sources. Un seul scenario de downgrade identifie : retrait simultane de toutes les sources niv.5 → [CHOIX D'EQUIPE] — scenario hypothetique qui requiert d'ignorer simultanement Cockburn (inventeur), Martin, Evans, Vernon, Percival, Slomka, Sairyss et Bogard, soit l'ensemble de la litterature fondatrice et applicative du pattern.

La robustesse MODEREE (vs ROBUSTE) tient a l'absence de sources niv.1 ou niv.2 directement portant sur l'architecture hexagonale. Comparer avec authorization-patterns (ROBUSTE) qui beneficie de 3 sources niv.1 (ANSI/INCITS, NIST) et 3 sources niv.2 (OWASP) directement sur le sujet. Les patterns architecturaux en SE ne disposent structurellement pas de telles sources normatives — c'est caracteristique du domaine, pas une faiblesse specifique a ce PICOC.

---

## Sources exclues

| Source | Critere | Raison |
|--------|---------|--------|
| Martin R.C. — article 2012 "The Clean Architecture" | E3 | Absorbe par Clean Architecture 2017 — version etendue et formalisee de l'article original |
| Fowler M. — PresentationDomainDataLayering bliki 2015 | E5 partiel | Evolution vers l'isolation du domaine couverte par Vernon 2013 et Percival 2020 avec plus de concretude ; apport marginal insuffisant |
| Unite tech blog — Hexagonal Architecture is based on DIP 2022 | E5 partiel | Relation DIP/hexagonale couverte par Martin 2017 et Cockburn 2023 avec plus d'autorite ; source de blog sans peer-review |
| Stackify — SOLID Dependency Inversion Principle 2023 | E3 | DIP couvert par Martin 2017 (Dependency Rule) et Cockburn 2023 (principe des ports sortants) — absorbe |
| Spring Framework docs — IoC container | E2 partiel | Specifique Spring ; la relation DIP/DI/hexagonale est couverte pour le stack NestJS par Slomka 2023 et pour Spring par Martin 2017 |
| Edana — Hexagonal vs Layered Architecture 2026 | E5 partiel | Comparaison couverte par Percival 2020 (exemples concrets sans BDD) et Slomka 2023 ; source marketing sans methodologie transparente |
| arXiv architecture surveys generiques | E1 | Niveau 4 ou 5 sans methodologie systematique ; pas d'apport marginal par rapport aux sources niv.5 expertales retenues |
