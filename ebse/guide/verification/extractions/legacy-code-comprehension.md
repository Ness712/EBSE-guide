# Double Extraction — PICOC legacy-code-comprehension

**Date** : 2026-04-17
**Protocole** : methodology.md v3.0
**Agent A** : mots-clés : "legacy code without tests safely", "characterization tests legacy code Feathers", "strangler fig pattern incremental migration", "seams legacy code testability", "working effectively with legacy code key concepts"
**Agent B** : mots-clés : "how to modify legacy code safely", "strangler fig application Fowler", "thin slices legacy migration blast radius", "legacy code refactoring seams injection points", "characterization tests document actual behavior"

---

## PICOC

```
P  = Équipes développement confrontées à du code legacy sans couverture de tests
I  = Approche incrémentale : characterization tests + seams + Strangler Fig + thin slices
C  = Modification directe du code legacy sans tests préalables, ou rewrite total
O  = Sécurité comportementale (zéro régression silencieuse), maintenabilité, livraison continue
Co = Bases de code legacy actives en production, nécessitant évolution ou migration
```

---

## Accord Reviewer A / Reviewer B

| # | Source | Niveau A | Niveau B | Accord ? | Note divergence |
|---|--------|---------|---------|:--------:|-----------------|
| 1 | Martin Fowler — StranglerFigApplication (martinfowler.com, 2004) | 5 | 5 | ✓ | — |
| 2 | Michael Feathers — Working Effectively with Legacy Code (Prentice Hall, 2004) | 5 | 5 | ✓ | — |
| 3 | Microsoft Azure Architecture Center — Strangler Fig pattern (2024) | 3 | 3 | ✓ | — |
| 4 | understandlegacycode.com — The key points of Working Effectively with Legacy Code (2020) | 4 | 4 | ✓ | — |

**Accord sur sources communes** : 4/4 → kappa = 1.0 (inclusion + niveau).
**Sources A-only** : aucune.
**Sources B-only** : aucune.

### Résolution des divergences

Aucune divergence — accord total entre Agent A et Agent B sur les 4 sources identifiées (inclusion et niveau de pyramide). La convergence est particulièrement forte car les deux agents partaient de mots-clés distincts (approche Feathers pour A, approche Fowler pour B) et ont abouti aux mêmes sources fondatrices.

---

## Calcul GRADE final

```
Score de départ : 2
  (source la plus haute directement pertinente = niveau 3 :
   Microsoft Azure Architecture Center — Strangler Fig pattern
   Les sources Feathers et Fowler sont niveau 5, donc départ = 2 pour chacune.
   Azure Architecture Center (niveau 3) est la meilleure source par la pyramide → départ = 2)

+ 1 convergence
  Fowler (martinfowler.com, niv.5) + Feathers (Prentice Hall, niv.5) + Azure Architecture
  Center (Microsoft, niv.3) + understandlegacycode (niv.4) convergent sans contradiction
  sur la même approche incrémentale :
  (1) tests préalables obligatoires avant tout refactoring — règle Feathers
  (2) characterization tests = documenter le comportement actuel, pas le comportement attendu
  (3) seams = points d'injection pour isoler le comportement en test sans modifier la source
  (4) Strangler Fig = facade/proxy pour migration feature-by-feature sans big-bang rewrite
  (5) thin slices = tranches indépendantes livrables avec valeur métier — évite le grand rewrite
  Sources indépendantes : praticien reconnu, éditeur académique, documentation architecture
  cloud, synthèse communautaire — 4 catégories distinctes convergentes.

Facteurs négatifs :
  - Pas d'incohérence entre sources : Fowler et Feathers (même année 2004) ont développé
    leurs approches indépendamment (Fowler : migration de système, Feathers : modification
    locale sécurisée) et sont complémentaires, pas contradictoires.
  - Indirectness modérée : les sources de niveau 5 (Fowler, Feathers) datent de 2004.
    Azure 2024 confirme la pertinence contemporaine du pattern mais ne constitue pas une
    validation empirique quantitative indépendante.
  - Pas d'effet important documenté par exploitation réelle à grande échelle comparable
    à ce que Kettle 2016 apporte pour CORS — les sources documentent des principes et
    des patterns, pas des métriques d'impact mesurées.

Score final : 2 + 1 = 3 → [RECOMMANDE]
```

Note biais de publication : faible — Feathers (Prentice Hall) et Fowler (martinfowler.com) sont des sources de référence de l'industrie reconnues universellement. Azure Architecture Center est une source de documentation prescriptive. understandlegacycode.com est une synthèse fidèle, traçable et sans agenda commercial. Aucun biais publication détecté : les principes sont indépendants de toute stack ou vendeur particulier.

---

## Analyse de sensibilité {#analyse-de-sensibilite}

| Source retirée | Score sans | Niveau sans | Changement ? |
|---------------|-----------|------------|:------------:|
| Microsoft Azure Architecture Center | 2 (départ recalculé niv.5 → départ=1, mais convergence Fowler+Feathers+understandlegacycode maintenue → +1) = 2 → RECOMMANDE | RECOMMANDE | NON |
| Martin Fowler — StranglerFigApplication | 3 (départ 2, +1 conv — Feathers + Azure + understandlegacycode convergent, thin slices et blast radius couverts par Azure) | RECOMMANDE | NON |
| Michael Feathers — Working Effectively with Legacy Code | 3 (départ 2, +1 conv — Fowler + Azure + understandlegacycode convergent ; characterization tests et seams documentés par understandlegacycode comme synthèse WELC) | RECOMMANDE | NON |
| understandlegacycode.com | 3 (départ 2, +1 conv — Fowler + Feathers + Azure maintiennent la convergence) | RECOMMANDE | NON |
| Fowler + Azure simultanément | 2 (départ 1 — seul Feathers niveau 5 ; understandlegacycode synthèse WELC maintient characterization tests + seams ; convergence partielle → +1) = 2 | RECOMMANDE | NON |
| Toutes sauf Feathers | 2 (départ 2 Azure niv.3, convergence Fowler + understandlegacycode partielle → +0 car understandlegacycode dépend de Feathers) = 2 | RECOMMANDE | NON |
| Toutes sauf Azure | 2 (départ 1 — meilleures sources niv.5 ; convergence Fowler + Feathers + understandlegacycode → +1) = 2 | RECOMMANDE | NON |

**Conclusion : ROBUSTE** — recommandation [RECOMMANDE] stable pour tout retrait individuel ou par paires. La robustesse est élevée car deux sources fondatrices indépendantes de niveau 5 (Fowler et Feathers, 2004) traitent des aspects complémentaires du même problème et sont confirmées par une source récente de niveau 3 (Azure 2024). La recommandation ne peut descendre en dessous de [RECOMMANDE] que dans le scénario artificiel du retrait de toutes les sources — la convergence entre praticiens reconnus indépendants est l'élément stabilisateur principal.

---

## Sources exclues

| Source | Critère | Raison |
|--------|---------|--------|
| Sam Newman — Monolith to Microservices (O'Reilly, 2019) | E5 redondance | Couvre Strangler Fig et migration incrémentale sans apport différencié sur characterization tests/seams — Fowler + Azure couvrent le principe plus directement et sont les sources primaires |
| Martin Fowler — Refactoring (2018) | E2 scope | Couvre le refactoring de code déjà testé — hors scope PICOC strict qui cible le code sans tests existants |
| AWS Well-Architected — Legacy Migration | E5 redondance | Même concept thin slices et migration incrémentale que Azure Architecture Center, moins détaillé, pas d'apport différencié |
| GCP — Modernizing Legacy Applications | E5 redondance | Redondant avec Azure Architecture Center — pas d'apport différencié sur le principe universel |
| Surveys académiques legacy modernization (≥3 papiers) | E3 indirect | Mesurent les pratiques industrielles mais n'apportent pas de guidance prescriptive supplémentaire aux principes Feathers/Fowler |
| Blog posts communautaires characterization tests (≥3 sources) | E1 redondance | Niveau 5 redondant — understandlegacycode.com synthétise Feathers avec plus de rigueur et de traçabilité |
| AWS Strangler Fig pattern documentation | E5 redondance | Même pattern que Azure Architecture Center, Azure présente le concept thin slices et blast radius plus explicitement |
