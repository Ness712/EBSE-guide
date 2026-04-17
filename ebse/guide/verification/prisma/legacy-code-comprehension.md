# PRISMA Flow — PICOC legacy-code-comprehension

**Date de recherche** : 2026-04-17
**Bases interrogées** : martinfowler.com, Prentice Hall / O'Reilly (livres techniques), Microsoft Azure Architecture Center, understandlegacycode.com, WebSearch général
**Mots-clés Agent A** : "legacy code without tests safely", "characterization tests legacy code Feathers", "strangler fig pattern incremental migration", "seams legacy code testability", "working effectively with legacy code key concepts"
**Mots-clés Agent B** : "how to modify legacy code safely", "strangler fig application Fowler", "thin slices legacy migration blast radius", "legacy code refactoring seams injection points", "characterization tests document actual behavior"
**Protocole** : methodology.md v3.0 §2.1 — double extraction indépendante (Agents A + B, mots-clés différents) + synthèse Agent C

---

## Flux

```
IDENTIFICATION
  Sources identifiées par base (Agent A + Agent B combinés, avant déduplication) :
    - Livres techniques (Prentice Hall, O'Reilly, Addison-Wesley) : ~5 résultats candidats
    - Blogs praticiens reconnus (martinfowler.com, understandlegacycode.com) : ~8 résultats candidats
    - Documentation architecture cloud (Azure, AWS, GCP Architecture Centers) : ~6 résultats candidats
    - Articles académiques sur modernisation legacy : ~7 résultats candidats
    - Tutoriels / articles blog communautaires : ~14 résultats candidats
    - Snowballing backward (références citées par sources principales) : ~5 sources
  Total identifié (brut, combiné A+B) : ~45
  Doublons retirés (même source identifiée par A et B) : 4 (Feathers WELC, Fowler StranglerFig, Azure Architecture Center, understandlegacycode)
  Total après déduplication : ~41

SCREENING (titre + résumé)
  Sources screenées : ~41
  Sources exclues au screening : ~29
    - E1 (blog opinion sans données ou méthodologie) : ~11
    - E2 (hors scope PICOC — refactoring général, pas legacy sans tests) : ~7
    - E3 (doublons partiels — couverts par sources primaires déjà incluses) : ~6
    - E4 (vendeur / marketing sans substance technique) : ~5

ELIGIBILITÉ (lecture complète)
  Sources évaluées en détail : ~12
  Sources exclues après lecture complète : ~8
    - Redondance forte avec Feathers WELC sans apport supplémentaire : 3
    - Hors scope PICOC strict (modernisation legacy architecturale, pas tests/seams) : 2
    - Niveau de preuve insuffisant (expériences isolées sans reproductibilité) : 2
    - Doublon partiel avec Azure Architecture Center (autres Architecture Centers) : 1

INCLUSION
  Sources incluses dans la synthèse : 4
    - Niveau 3 : 1 (Microsoft Azure Architecture Center — Strangler Fig pattern)
    - Niveau 4 : 1 (understandlegacycode.com — synthèse WELC)
    - Niveau 5 : 2 (Fowler StranglerFigApplication, Feathers WELC)

  Sources exclues avec raison documentée : 8
    - Sam Newman — Monolith to Microservices (O'Reilly, 2019) : couvert par Fowler StranglerFig + Azure, pas d'apport sur characterization tests/seams
    - AWS Well-Architected — Legacy Migration : redondant avec Azure Architecture Center (même concept, moins détaillé)
    - GCP — Modernizing Legacy Applications : redondant avec Azure Architecture Center
    - Martin Fowler — Refactoring (2018) : hors scope PICOC strict — couvre le refactoring de code testé, pas le code legacy sans tests
    - Surveys académiques legacy modernization : indirects — mesurent les pratiques mais n'apportent pas de guidance prescriptive supplémentaire
    - Articles communautaires sur characterization tests (≥3 sources) : niveau 5 redondant — understandlegacycode.com couvre la même expertise avec plus de rigueur
```

---

## Documentation recherche (Table 2 Kitchenham)

### Agent A — bases interrogées

| Élément | Valeur |
|---------|--------|
| Bases | martinfowler.com, Prentice Hall (Google Books), Microsoft Azure Architecture Center, WebSearch général |
| Mots-clés | "legacy code without tests safely", "characterization tests legacy code Feathers", "strangler fig pattern incremental migration", "seams legacy code testability", "working effectively with legacy code key concepts" |
| Période couverte | 2004-2024 |
| Sources identifiées | ~23 |
| Sources retenues | 4 |
| Date d'extraction | 2026-04-17 |

### Agent B — bases interrogées

| Élément | Valeur |
|---------|--------|
| Bases | martinfowler.com, understandlegacycode.com, Microsoft Azure Architecture Center, O'Reilly catalog, WebSearch |
| Mots-clés | "how to modify legacy code safely", "strangler fig application Fowler", "thin slices legacy migration blast radius", "legacy code refactoring seams injection points", "characterization tests document actual behavior" |
| Période couverte | 2004-2024 |
| Sources identifiées | ~22 |
| Sources retenues | 4 (convergence totale avec A) |
| Date d'extraction | 2026-04-17 |

---

## Sources exclues — raisons documentées

| Source | Raison exclusion |
|--------|-----------------|
| Sam Newman — Monolith to Microservices (O'Reilly, 2019) | Redondance — couvre Strangler Fig et migration incrémentale mais sans apport sur characterization tests/seams ; Fowler + Azure couvrent le principe plus directement |
| AWS Well-Architected — Legacy Migration guidance | Redondance — même concept thin slices et migration incrémentale que Azure Architecture Center, moins détaillé sur l'aspect tests |
| GCP — Modernizing Legacy Applications documentation | Redondance avec Azure Architecture Center — pas d'apport différencié |
| Martin Fowler — Refactoring: Improving the Design of Existing Code (2018) | Hors scope PICOC strict — couvre le refactoring de code déjà testé ; PICOC cible spécifiquement le code sans tests existants |
| Surveys académiques legacy modernization (≥3 papiers) | Indirects — mesurent les pratiques industrielles mais n'apportent pas de guidance prescriptive supplémentaire aux principes Feathers/Fowler |
| Blog posts communautaires characterization tests (≥3 sources) | Niveau 5 redondant — understandlegacycode.com synthétise Feathers avec plus de rigueur et de traçabilité que les articles isolés |
| AWS Strangler Fig pattern | Redondance avec Azure Architecture Center — même pattern, même niveau, Azure présente le concept thin slices plus explicitement |
