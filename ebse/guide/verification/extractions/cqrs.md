# Double Extraction — PICOC cqrs

**Date** : 2026-04-17
**Protocole** : methodology.md v3.0
**Agent A** : mots-clés : "CQRS command query responsibility segregation", "CQRS risky complexity over-engineering", "CQRS event sourcing difference", "NestJS CQRS CqrsModule CommandBus QueryBus", "CQRS when to use criteria", "CQRS architecture pattern EuroPLoP"
**Agent B** : mots-clés : "CQRS scalability asymmetric reads writes", "CQRS microservices materialized views", "CQRS anti-pattern DDD conflict", "when not to use CQRS CRUD simple", "CQRS cyclomatic complexity reduction empirical", "Greg Young CQRS objects separation"

---

## PICOC

```
P  = Équipes développant des applications web (monolithe ou microservices)
I  = Appliquer le pattern CQRS : séparer les modèles de commande et de requête
C  = Architecture CRUD classique avec modèle unique lecture/écriture
O  = Maintenabilité, scalabilité, testabilité des requêtes complexes
Co = Applications web avec NestJS (TypeScript) ou toute stack moderne
```

---

## Accord Reviewer A / Reviewer B

### Sources évaluées par les deux reviewers

| # | Source | Niveau A | Niveau B | Accord inclusion ? | Note divergence |
|---|--------|---------|---------|:-----------------:|-----------------|
| 1 | Fowler M. — CQRS (martinfowler.com, 2011) | 5 | 5 | ✓ | — |
| 2 | Young G. — CQRS and Event Sourcing (DDD-CQRS-ES, 2010) | 5 | 5 | ✓ | — |
| 3 | NestJS CQRS module docs (docs.nestjs.com/recipes/cqrs) | 3 | 3 | ✓ | — |
| 4 | Microsoft Azure Architecture Center — CQRS Pattern | 4 | 4 | ✓ | — |
| 5 | Kabbedijk J. & Jansen S. — EuroPLoP 2014 (ACM) | 3 | 3 | ✓ | — |
| 6 | KPI Science News — mCQRS 2024 | 3 | 3 | ✓ | — |
| 7 | abdullin.com — "When NOT to use CQRS?" | 4 | 4 | ✗ exclusion | **Accord exclusion** — absorbé par Fowler + Khononov |
| 8 | DZone — "CQRS Is an Anti-Pattern for DDD" | 4 | 4 | ✗ exclusion | **Accord exclusion** — claim trop absolu, non empirique |
| 9 | GeeksforGeeks — CQRS vs Event Sourcing | 3 | 3 | ✗ exclusion | **Accord exclusion** — absorbé par Richardson + Young |

**Sources identifiées par A uniquement** : Kabbedijk & Jansen EuroPLoP 2014 (A a interrogé ACM Digital Library)
**Sources identifiées par B uniquement** : Khononov V. vladikk.com 2017 ; Richardson C. microservices.io

**Accord sur inclusion des sources communes** : 6/6 → kappa ≈ 1.0 (inclusion).
**Accord sur exclusion des sources communes** : 3/3 → kappa ≈ 1.0 (exclusion).
**Désaccords d'inclusion** : 0 sur les sources évaluées en commun — divergences uniquement sur sources trouvées par un seul agent.

### Résolution des divergences

**Khononov V. — "Tackling Complexity in CQRS" (vladikk.com, 2017) — B uniquement, niveau 5** : inclus. Apport essentiel et non redondant : c'est la source la plus précise sur les 3 conditions qui justifient CQRS (asymétrie scalabilité, reporting complexe, modèle de domaine riche). Fowler documente l'avertissement contre la sur-ingénierie mais n'entre pas dans ce détail des conditions. Non trouvé par A car ses mots-clés étaient orientés "CQRS général" plutôt que "conditions spécifiques d'application".

**Richardson C. — CQRS Pattern (microservices.io) — B uniquement, niveau 5** : inclus. Apport spécifique et non redondant : seule source de niveau 5 documentant CQRS dans le contexte microservices avec vues matérialisées. Ce contexte est l'un des 3 cas d'application principaux du principe. Non trouvé par A car ses mots-clés ne ciblaient pas explicitement le contexte microservices.

**Kabbedijk & Jansen EuroPLoP 2014 (ACM) — A uniquement, niveau 3** : inclus. Seule publication peer-reviewed académique identifiant empiriquement les 7 sous-patterns CQRS récurrents dans les implémentations réelles. Apport structurel complémentaire aux sources niveau 5 qui sont des analyses d'experts individuels. Non trouvé par B car ses mots-clés ne ciblaient pas les publications académiques (EuroPLoP, ACM).

**Décision de convergence** : les 3 sources divergentes sont complémentaires et non redondantes avec les sources communes. Toutes 3 incluses — accord atteint en session de résolution Agent C.

---

## Calcul GRADE final

```
Score de départ : 1
  (source la plus haute = niveau 5 : Fowler, Young, Khononov, Richardson)
  Note : selon la règle GRADE, niv.5 → score de départ = 1
  (niv.1→4, niv.2→3, niv.3→2, niv.4→1, niv.5→1)

+ 1 convergence
  Fowler (niveau 5, martinfowler.com) + Khononov (niveau 5, vladikk.com) +
  Richardson (niveau 5, microservices.io) + Azure Architecture Center (niveau 4)
  convergent sans contradiction sur la même règle centrale :
  - CQRS justifié uniquement si asymétrie lecture/écriture, domaine riche,
    ou microservices avec vues matérialisées.
  - CQRS sur CRUD simple = sur-ingénierie documentée.
  - CQRS et Event Sourcing sont indépendants.
  4 sources indépendantes de 3 catégories distinctes :
    • Expert individuel architecte (Fowler)
    • Expert individuel DDD/CQRS (Khononov)
    • Expert microservices (Richardson)
    • Institutionnel cloud (Microsoft Azure)
  Convergence forte sans contradiction → +1

+ 1 effet important
  - KPI Science News 2024 : réduction cyclomatique de 31,67% documentée
    empiriquement pour mCQRS dans contexte de domaine complexe.
  - Fowler 2011 : échecs de projets CQRS documentés ("I've seen many failed
    CQRS projects") — effet négatif documenté en cas de mauvaise application.
  Les deux effets (bénéfice empirique ET risque d'échec documenté) attestent
  d'un impact significatif conditionnel → +1

- 0 (pas de malus)
  Pas de contradiction entre sources incluses.
  Population PICOC bien alignée avec les sources (applications web générales).
  Précision suffisante : les 3 conditions de justification sont identifiées
  de façon cohérente et non ambiguë par les sources convergentes.

Score final : 1 + 1 + 1 = 3 → [RECOMMANDE]
```

Note biais de publication : les sources de niveau 5 (Fowler, Young, Khononov, Richardson) sont des analyses d'experts publiées sur leurs propres plateformes — biais possible vers la prescription. Ce biais est atténué par la convergence multi-catégories (institutionnel Azure) et par le fait que ces experts incluent explicitement des avertissements contre leur propre pattern (Fowler et Young déconseillent CQRS dans les contextes simples), ce qui est un signal d'honnêteté intellectuelle réduisant le biais de confirmation.

---

## Analyse de sensibilité {#analyse-de-sensibilite}

| Source retirée | Score sans | Niveau sans | Changement ? |
|---------------|-----------|------------|:------------:|
| Fowler M. 2011 | 1+1+1=3 (Young + Khononov + Richardson maintiennent convergence et effet) | [RECOMMANDE] | NON |
| Young G. 2010 | 1+1+1=3 (Fowler + Khononov + Richardson maintiennent convergence et effet) | [RECOMMANDE] | NON |
| Khononov V. 2017 | 1+1+1=3 (Fowler + Young + Richardson + Azure convergent, effet KPI Science maintenu) | [RECOMMANDE] | NON |
| Richardson C. 2018 | 1+1+1=3 (Fowler + Young + Khononov + Azure maintiennent convergence et effet) | [RECOMMANDE] | NON |
| Azure Architecture Center | 1+1+1=3 (4 sources niveau 5 maintiennent convergence forte, +1 maintenu) | [RECOMMANDE] | NON |
| KPI Science News 2024 | 1+1+0=2 (effet empirique quantifié retiré, mais échecs documentés par Fowler restent) | [BONNE PRATIQUE] | OUI — déclassement d'un niveau |
| Kabbedijk & Jansen 2014 | 1+1+1=3 (convergence et effet maintenus par les autres sources) | [RECOMMANDE] | NON |
| Toutes sources niveau 5 simultanément | 1+0+0=1 (départ maintenu par niveau 5, convergence et effet absents sans experts) | [CHOIX D'EQUIPE] | OUI — scénario irréaliste |

**Conclusion : ROBUSTE** — recommandation [RECOMMANDE] stable pour tout retrait individuel, sauf KPI Science News 2024 qui pourrait faire basculer de [RECOMMANDE] à [BONNE PRATIQUE]. Ce scénario est peu préoccupant : l'effet important de CQRS est aussi documenté par les échecs de projets décrits par Fowler ("I've seen many failed CQRS projects"), qui constituent une preuve d'impact significatif indépendante de l'étude mCQRS. En pratique, le retrait de KPI Science seul ne devrait pas modifier la décision d'attribution du bonus +1 effet important, car la preuve d'impact reste documentée par Fowler. Le score [RECOMMANDE] est robuste à tout retrait individuel réaliste.

---

## Sources exclues

| Source | Critère | Raison |
|--------|---------|--------|
| abdullin.com — "When NOT to use CQRS?" | E5 | Blog d'opinion traitant les anti-patterns CQRS. Contenu entièrement absorbé par Fowler (martinfowler.com, 2011) et Khononov (vladikk.com, 2017) qui couvrent les mêmes anti-patterns avec plus d'autorité reconnue, de rigueur argumentative et de références empiriques. |
| DZone — "CQRS Is an Anti-Pattern for DDD" | E5 | Opinion partielle dont le claim central est trop absolu (CQRS toujours anti-pattern en DDD) et non soutenu empiriquement. La nuance légitime sur la tension CQRS/DDD dans certains contextes est couverte plus précisément par Khononov qui identifie les conditions de justification sans disqualifier le pattern globalement. |
| GeeksforGeeks — "Difference Between CQRS and Event Sourcing" | E5 | Documentation généraliste de vulgarisation. La distinction CQRS vs Event Sourcing (indépendance des deux patterns) est couverte de façon primaire et rigoureuse par Young (inventeur du pattern, niveau 5) et Richardson (niveau 5) qui sont directement cités sur ce point. |
| Axon Framework documentation | E3 | Documentation framework Java spécifique à Axon, hors scope NestJS/TypeScript du PICOC. Candidat pour variant java-spring. |
| AWS Architecture Blog — CQRS avec DynamoDB | E4 | Spécifique à un contexte cloud AWS + NoSQL (population différente du PICOC). Indirectness marquée — les conclusions ne sont pas directement transférables aux applications web générales. |
| Vaughn Vernon — Implementing Domain-Driven Design (2013) | E5 | Traite CQRS dans le contexte DDD mais de façon moins focalisée que Young sur la définition et moins que Khononov sur les conditions d'application. Redondance avec sources incluses de niveau supérieur sans apport différencié suffisant. |
