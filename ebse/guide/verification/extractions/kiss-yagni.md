# Double Extraction — PICOC kiss-yagni

**Date** : 2026-04-17
**Protocole** : methodology.md v3.0
**Agent A** : mots-clés : "YAGNI you aren't gonna need it XP", "KISS principle software design", "over-engineering technical debt", "premature abstraction cost", "speculative generality code smell"
**Agent B** : mots-clés : "accidental complexity Brooks", "simple design XP Kent Beck", "speculative generality code smell Fowler", "big design up front vs evolutionary design", "make it work make it right make it fast"

---

## PICOC

```
P  = Développeurs et agents IA autonomes prenant des décisions d'architecture
     et d'implémentation (niveau code local ET niveau architectural)
I  = Appliquer KISS (Keep It Simple) + YAGNI (You Aren't Gonna Need It) :
     implémenter le strict nécessaire pour le besoin actuel avéré,
     rejeter les abstractions non justifiées par un besoin réel présent
C  = Conception anticipée (BDUF — Big Design Up Front), abstraction spéculative
     basée sur des besoins futurs supposés non confirmés
O  = Réduction de la complexité accidentelle, vélocité de développement,
     maintenabilité, dette technique évitée
Co = Projets logiciels évolutifs avec besoins changeants, en particulier
     projets agiles où le feedback utilisateur guide les priorités
```

---

## Accord Reviewer A / Reviewer B

| # | Source | Niveau A | Niveau B | Accord ? | Note divergence |
|---|--------|---------|---------|:--------:|-----------------|
| 1 | SWEBOK v4 ch.2 — Software Design (IEEE, 2024) | 1 | 1 | ✓ | — |
| 2 | Beck K. — XP Explained 2nd ed. (2004) | 5 | 5 | ✓ | — |
| 3 | Fowler M. — Refactoring 2nd ed. (2018) | 5 | 5 | ✓ | — |
| 4 | Brooks F.P. — No Silver Bullet (IEEE Computer, 1987) | 5 | 5 | ✓ | — |
| 5 | McConnell S. — Code Complete 2nd ed. (2004) | 5 | 5 | ✓ | — |
| 6 | Fowler M. — Is Design Dead? (martinfowler.com, 2004) | 5 | 5 | ✓ | — |
| 7 | Hunt A., Thomas D. — Pragmatic Programmer 20th anniv. (2019) | 5 | absent | ✗ | **A cite, B ne cite pas — absorbé par Beck/Fowler selon B** |
| 8 | Robert Martin — Clean Code (2008) | absent | 5 | ✗ | **B cite, A juge redondant avec McConnell** |
| 9 | Kerievsky J. — Refactoring to Patterns (2004) | absent | 5 | ✗ | **B cite, A juge hors PICOC direct** |
| 10 | Gamma et al. — Design Patterns GoF (1994) | absent | 5 | ✗ | **B cite (context patterns), A juge hors PICOC** |

**Accord sur sources communes** : 6/6 → kappa = 1.0 (inclusion + niveau).
**Sources A-only** : Hunt & Thomas 2019 (Pragmatic Programmer — ETC principle).
**Sources B-only** : Robert Martin Clean Code 2008, Kerievsky 2004, GoF 1994.

### Résolution des divergences

**Hunt & Thomas 2019 (A-only)** : Inclus — apporte le principe ETC (Easier To Change) comme critère opérationnel indépendant de YAGNI. Complémentaire à Beck (qui pose le principe) et Fowler (qui l'illustre). Pyramide 5 — expert reconnu (~20k citations, référence SE universelle). Divergence A(inclus)/B(redondant) : A l'emporte car ETC est une formulation distincte non absorbée par les autres sources.

**Robert Martin — Clean Code (B-only)** : Exclu — fortement redondant avec McConnell 2004 sur la gestion de la complexité et les principes de clarté. Pas de formulation originale de KISS/YAGNI. Risque de duplication sans apport marginal.

**Kerievsky — Refactoring to Patterns (B-only)** : Exclu — traite de l'application des design patterns, ce qui peut contredire YAGNI si pris hors contexte. Hors périmètre direct du PICOC (la question est le rejet de l'abstraction prématurée, pas les patterns en eux-mêmes).

**GoF — Design Patterns (B-only)** : Exclu — source canonique sur les patterns mais ne traite pas de KISS/YAGNI. L'inclusion créerait une confusion entre "patterns connus vs abstractions spéculatives custom" qui dépasse le PICOC.

---

## Calcul GRADE final

```
Score de départ : 4
  (source la plus haute directement pertinente = niveau 1 :
   SWEBOK v4 ch.2 Software Design — affirme la primauté de la simplicité,
   la distinction complexité essentielle/accidentelle, le rejet des abstractions
   spéculatives comme source de défauts et coûts de maintenance)

+ 1 convergence
  SWEBOK v4 (niveau 1) + Beck 2004 + Fowler Refactoring 2018 + Brooks 1987
  + McConnell 2004 + Fowler Is Design Dead? 2004 + Hunt & Thomas 2019
  convergent sans contradiction sur trois points :
  (1) implémenter uniquement ce qui est nécessaire maintenant
  (2) la complexité accidentelle est la principale source de dette technique évitable
  (3) YAGNI ne s'applique pas aux décisions architecturales irréversibles
  7 sources indépendantes couvrant 1987-2024, 4 contextes distincts
  (standard normatif IEEE, fondateur XP, expert refactoring, expert pragmatique)

- 1 absence d'études empiriques quantifiées
  Absence d'études randomisées ou quasi-expérimentales comparant des projets
  appliquant KISS/YAGNI strict vs projets BDUF sur des métriques mesurables
  (vélocité, taux de défauts, coût de maintenance). La convergence est
  normative/expertale — robuste mais pas empiriquement quantifiée à large
  échelle avec groupes de contrôle. Biais de confirmation possible dans la
  littérature XP (auteurs engagés dans la méthodologie qu'ils évaluent).

Score final : 4 + 1 - 1 = 4 → [RECOMMANDE]

Note GRADE : score 4 sans downgrade "indirectness" car SWEBOK v4 est directement
prescriptif sur le sujet (simplicité comme attribut qualité, complexité accidentelle
à éviter). Le seul downgrade applicable est l'absence d'empirique large-échelle.
Le niveau [RECOMMANDE] est conservateur et honnête : le principe est robuste,
la convergence est forte, mais l'absence de mesure d'effet quantifiée empêche [STANDARD].
```

---

## Analyse de sensibilité {#analyse-de-sensibilite}

| Source retirée | Score sans | Niveau sans | Changement ? |
|---------------|-----------|------------|:------------:|
| SWEBOK v4 ch.2 | 2 (départ 1 niveau 5, +1 conv, -1 empirique) | [BONNE PRATIQUE] | OUI — dégrade d'un niveau |
| Beck 2004 XP | 4 (départ 4, +1 conv partielle, -1 empirique) | [RECOMMANDE] | NON |
| Fowler Refactoring 2018 | 4 (convergence intacte sans Speculative Generality) | [RECOMMANDE] | NON |
| Brooks 1987 | 4 (convergence toujours présente, SWEBOK absorbe) | [RECOMMANDE] | NON |
| Fowler Is Design Dead? 2004 | 3 (nuance architecturale affaiblie, -1 robustesse) | [RECOMMANDE] | NON (niveau stable, robustesse réduite) |
| Hunt & Thomas 2019 | 4 (convergence légèrement réduite mais intacte) | [RECOMMANDE] | NON |
| Toutes sources niveau 5 simultanément | 3 (SWEBOK seul, -1 empirique) | [RECOMMANDE] | NON |

**Conclusion : MODERE-ROBUSTE** — recommandation [RECOMMANDE] stable pour tout retrait individuel sauf SWEBOK v4 (retrait de la seule source niveau 1 ferait passer à [BONNE PRATIQUE]). La dépendance à SWEBOK v4 est le point de fragilité principal. En pratique, SWEBOK v4 est une source directe et non contestée sur ce sujet — le risque de remise en cause est très faible. La convergence des experts (Beck, Fowler, Brooks, McConnell, Hunt & Thomas) est exceptionnellement forte et couvre 4 décennies sans contradiction, ce qui ancre le principe indépendamment de SWEBOK.

---

## Sources exclues

| Source | Critère | Raison |
|--------|---------|--------|
| Robert Martin — Clean Code (2008) | E5 partiel | Fortement redondant avec McConnell 2004 ; pas de formulation originale de KISS/YAGNI ; absorbé par les sources incluses |
| Kerievsky J. — Refactoring to Patterns (2004) | E5 | Traite de l'application des design patterns — risque de confusion avec YAGNI si hors contexte ; hors PICOC direct |
| Gamma et al. — Design Patterns GoF (1994) | E5 | Source canonique patterns mais ne traite pas de KISS/YAGNI ; inclusion créerait une confusion hors PICOC |
| Johnson K. — KISS principle origin (DARPA/Lockheed, 1960s) | E1 + E2 | Source primaire non-documentée académiquement ; attribution historique incertaine ; le principe est mieux documenté via ses applications SE (SWEBOK, McConnell, Beck) |
| Martin J. — Agile Software Development (2002) | E5 | Chevauche fortement Beck 2004 XP ; pas de formulation additionnelle sur KISS/YAGNI |
| Jeffries R. — XP Installed (2000) | E1 partiel + E5 | Redondant avec Beck 2004 ; pas d'apport marginal sur KISS/YAGNI |
| Poppendieck M. — Lean Software Development (2003) | E5 | Convergent avec YAGNI via "eliminate waste" mais formulation indirecte ; absorbé par Beck 2004 |
| State of DevOps Report (DORA, 2019-2023) | E5 | Mesure la performance DevOps (deployment frequency, lead time) — corrélation indirecte avec la simplicité ; pas de mesure directe de KISS/YAGNI application |
| Humble & Farley — Continuous Delivery (2010) | E5 | Traite principalement le pipeline de livraison ; overlap avec YAGNI indirect via "evolutionary design" |
