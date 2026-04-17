# PRISMA Flow — PICOC hexagonal-architecture

**Date de recherche** : 2026-04-17
**Bases interrogees** : alistair.cockburn.us, Addison-Wesley/O'Reilly books, AWS Prescriptive Guidance, GitHub (Sairyss domain-driven-hexagon), Medium Engineering, ACM Digital Library, WebSearch general
**Mots-cles Agent A** : "hexagonal architecture ports adapters Cockburn", "clean architecture dependency rule Robert Martin", "domain-driven design domain isolation Evans", "Fowler presentation domain data layering", "AWS hexagonal architecture pattern", "hexagonal architecture dependency inversion principle"
**Mots-cles Agent B** : "implementing DDD Vernon hexagonal bounded context", "architecture patterns Python O'Reilly ports adapters", "NestJS hexagonal architecture TypeScript", "domain-driven hexagon NestJS Sairyss GitHub", "vertical slice architecture Bogard alternative hexagonal", "layered architecture vs hexagonal testability database"
**Protocole** : methodology.md v3.0 §2.1 — double extraction independante (Agents A + B, mots-cles differents)

---

## Flux

```
IDENTIFICATION
  Sources identifiees par base (Agent A + Agent B combines, avant deduplication) :
    - Sources primaires (Cockburn, livres Addison-Wesley/O'Reilly) : 6 sources candidates
      (Cockburn 2005, Cockburn+Garrido 2023, Martin 2017, Evans 2003, Vernon 2013, Percival+Gregory 2020)
    - Articles/blogs experts reconnus : 5 sources candidates
      (Martin article 2012, Fowler bliki 2015, Unite tech blog 2022, Slomka Medium 2023, Bogard 2019)
    - Documentation officielle / cloud providers : 2 sources candidates
      (AWS Prescriptive Guidance 2023, Spring docs)
    - Community references : 2 sources candidates
      (Sairyss GitHub 2022-2024, NestJS docs)
    - Empiriques / peer-reviewed : 3 sources candidates
      (ACM EASE 2024, IEEE studies on coupling/cohesion, arXiv architecture surveys)
    - Comparatifs : 2 sources candidates
      (Edana hexagonal vs layered 2026, Stackify SOLID DIP 2023)
  Total identifie (brut, combine A+B) : ~20
  Doublons retires (meme source identifiee par A et B) : 3 (Cockburn, Martin, Evans)
  Total apres deduplication : ~17

SCREENING (titre + resume)
  Sources screenees : ~17
  Sources exclues au screening : ~5
    - E1 (opinion sans donnees, blog posts non-attribuables) : 2
    - E2 (hors scope PICOC — concerne uniquement DDD sans lien explicite hexagonale) : 1
    - E3 (doublons — Martin article 2012 absorbe par Clean Architecture 2017) : 1
    - E5 (redondant — Fowler PresentationDomainDataLayering absorbe par Vernon + Percival) : 1

ELIGIBILITE (lecture complete)
  Sources evaluees en detail : ~12
  Sources exclues apres lecture complete : 2
    - Stackify SOLID DIP 2023 : traite DIP en general sans lien explicite avec l'hexagonale —
      le principe est couvert par Martin 2017 et Cockburn 2023 (E3 — absorbe)
    - Spring docs IoC container : couvert par la relation DIP/hexagonale via Martin et Cockburn —
      specifique Spring, absent pour NestJS (E2 partiel — absorbe par Slomka 2023)

INCLUSION
  Sources incluses dans la synthese : 11
    - Niveau 1 : 1 (ACM EASE 2024)
    - Niveau 3 : 1 (AWS Prescriptive Guidance 2023)
    - Niveau 5 : 9 (Cockburn 2005, Cockburn+Garrido 2023, Martin 2017, Evans 2003,
                    Vernon 2013, Percival+Gregory 2020, Slomka 2023, Sairyss 2023, Bogard 2019)

  Sources exclues avec raison documentee : 2
    - Stackify SOLID DIP : E3 — absorbe par Martin 2017 et Cockburn 2023
    - Martin article 2012 : E3 — absorbe par Clean Architecture 2017 (version etendue)
```

---

## Documentation recherche (Table 2 Kitchenham)

### Agent A — bases interrogees

| Element | Valeur |
|---------|--------|
| Bases | alistair.cockburn.us, Addison-Wesley catalog, AWS Prescriptive Guidance, Unite tech blog, WebSearch general |
| Mots-cles | "hexagonal architecture ports adapters Cockburn", "clean architecture dependency rule Robert Martin", "domain-driven design domain isolation Evans", "Fowler presentation domain data layering", "AWS hexagonal architecture pattern", "hexagonal architecture dependency inversion principle" |
| Periode couverte | 2003-2023 |
| Sources identifiees | ~12 |
| Sources retenues | 6 |
| Date d'extraction | 2026-04-17 |

### Agent B — bases interrogees

| Element | Valeur |
|---------|--------|
| Bases | Addison-Wesley/O'Reilly books, Medium Engineering, GitHub (community references), ACM Digital Library, WebSearch general |
| Mots-cles | "implementing DDD Vernon hexagonal bounded context", "architecture patterns Python O'Reilly ports adapters", "NestJS hexagonal architecture TypeScript", "domain-driven hexagon NestJS Sairyss GitHub", "vertical slice architecture Bogard alternative hexagonal", "layered architecture vs hexagonal testability database" |
| Periode couverte | 2003-2026 |
| Sources identifiees | ~11 |
| Sources retenues | 8 |
| Date d'extraction | 2026-04-17 |

---

## Sources exclues — raisons documentees

| Source | Raison exclusion |
|--------|-----------------|
| Martin R.C. — article 2012 "The Clean Architecture" (blog) | E3 — absorbe par Clean Architecture livre 2017 (version etendue et formalisee de l'article) |
| Fowler M. — PresentationDomainDataLayering bliki 2015 | E5 partiel — evolution vers l'isolation du domaine couverte par Vernon 2013 et Percival 2020 qui l'appliquent concretement ; apport marginal |
| Stackify — SOLID Dependency Inversion Principle 2023 | E3 — DIP comme base de l'hexagonale couvert par Martin 2017 et Cockburn 2023 avec plus de profondeur |
| Spring Framework docs — IoC container | E2 partiel — specifique Spring, l'equivalent NestJS est couvert par Slomka 2023 ; la relation DIP/hexagonale est couverte par les sources principales |
| Unite tech blog — DIP/hexagonale 2022 | E5 partiel — absorbe par Cockburn 2023 et Slomka 2023 qui traitent la meme relation avec plus d'autorite |
| Edana — hexagonal vs layered 2026 | E5 partiel — la comparaison layered vs hexagonale est couverte par Percival 2020 et Slomka 2023 avec des exemples de code concrets ; source marketing non peer-reviewed |
| arXiv architecture surveys generiques | E1 — niveau 4 ou 5 sans methodologie systematique ; absorbes par les sources niv.5 expertales et la seule source empirique directe (ACM EASE 2024) |
