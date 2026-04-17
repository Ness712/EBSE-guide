# Double Extraction — PICOC java-concurrency

**Date** : 2026-04-17
**Protocole** : methodology.md v3.0
**Agent A** : mots-clés : "JEP 444 virtual threads Java 21", "virtual threads pinning synchronized carrier thread", "thread-per-request model Java Loom", "virtual threads pooling anti-pattern", "JFR jdk.VirtualThreadPinned diagnostic"
**Agent B** : mots-clés : "structured concurrency JEP 453 StructuredTaskScope", "Spring Boot virtual threads spring.threads.virtual.enabled", "ScopedValue ThreadLocal virtual threads JEP 446", "virtual threads CPU-bound limitations", "ReentrantLock synchronized virtual threads migration"

---

## PICOC

```
P  = Équipes développement Java 21+ écrivant des services I/O-bound (APIs REST, accès BDD, appels services)
I  = Utiliser virtual threads (JEP 444) + structured concurrency (JEP 453) dans les applications Spring Boot
C  = Platform threads classiques ou modèles réactifs (Reactor/RxJava) pour la concurrence I/O
O  = Throughput, lisibilité du code, fiabilité (absence de thread leaks), observabilité
Co = Applications Spring Boot 3.2+ sur Java 21 LTS, services I/O-bound
```

---

## Accord Reviewer A / Reviewer B

| # | Source | Niveau A | Niveau B | Accord ? | Note divergence |
|---|--------|---------|---------|:--------:|-----------------|
| 1 | JEP 444 — Virtual Threads (OpenJDK/JCP, Java 21 LTS, 2023) | 1 | 1 | ✓ | — |
| 2 | JEP 453 — Structured Concurrency (OpenJDK/JCP, 2023-2024) | 1 | 1 | ✓ | — |
| 3 | Spring Boot documentation — Virtual Threads (spring.io, 2024) | absent | 3 | ✗ | **A ne cite pas, B cite directement** |
| 4 | Brian Goetz — Java Concurrency in Practice (Addison-Wesley, 2006) | 5 | 5 | ✓ | — |
| 5 | InfoQ / Nicolai Parlog — Java 21: Virtual Threads (InfoQ, 2023) | 4 | 4 | ✓ | — |

**Accord sur sources communes** : 4/4 → kappa = 1.0 (inclusion + niveau).
**Sources A-only** : aucune.
**Sources B-only** : Spring Boot documentation Virtual Threads.

### Résolution des divergences

**Spring Boot docs (B-only)** : Inclus — directement actionnable pour l'activation (spring.threads.virtual.enabled=true) et la mise en garde critique sur synchronized/pinning. Pyramide 3 (documentation framework officielle). Scope PICOC : OLS utilise Spring Boot comme backend principal (voir ols.json), ce qui rend la source directement pertinente. La note sur synchronized = pinning est la règle la plus actionnable de ce PICOC pour les utilisateurs Spring Boot. Aucun risque de biais (documentation officielle framework).

---

## Calcul GRADE final

```
Score de départ : 4
  (source la plus haute directement pertinente = niveau 1 :
   JEP 444 — définit littéralement le comportement des virtual threads,
   la règle anti-pooling, et le modèle de suspension automatique lors des I/O
   JEP 453 — définit littéralement le modèle structured concurrency)

+ 1 convergence
  JEP 444 (niveau 1) + JEP 453 (niveau 1) + Spring Boot docs (niveau 3) +
  Goetz JCIP (niveau 5) + Parlog/InfoQ (niveau 4) convergent sans contradiction
  sur les mêmes règles :
  (1) virtual threads = thread-per-request, jamais pooler — contrainte JEP 444
  (2) synchronized = pinning carrier thread = annulation des bénéfices — documenté JEP 444, Spring Boot docs, Parlog
  (3) structured concurrency = élimination thread leaks par construction — JEP 453
  (4) CPU-bound = aucun bénéfice virtual threads — Parlog/InfoQ, cohérent avec JEP 444
  (5) ScopedValue > ThreadLocal pour contexte per-task avec millions de virtual threads — Parlog
  Sources indépendantes : 2 standards JCP (niveau 1), documentation framework officiel (niveau 3),
  livre de référence auteur Java (niveau 5), article expert Java advocate (niveau 4).
  4 catégories distinctes convergentes.

Facteurs négatifs :
  - Pas d'incohérence entre sources (aucune source contredit les règles énoncées).
  - Pas d'indirectness significative : les sources traitent directement virtual threads Java 21
    dans le contexte des applications I/O-bound (PICOC direct).
  - Pas d'imprécision : les règles sont précises et opérationnelles
    (Executors.newVirtualThreadPerTaskExecutor(), ReentrantLock, StructuredTaskScope.ShutdownOnFailure,
    jdk.VirtualThreadPinned, spring.threads.virtual.enabled=true).

Score final : 4 + 1 = 5 → [STANDARD]
```

Note biais de publication : faible — les sources normatives (JEPs OpenJDK) sont prescriptives par nature. Brian Goetz est Java Language Architect Oracle (auteur de la plateforme). Nicolai Parlog est Java developer advocate Oracle. Spring Boot docs proviennent de Broadcom/VMware. Les 3 organisations (Oracle/OpenJDK, Broadcom/VMware, InfoQ) sont indépendantes et convergentes. Aucun biais publication détecté.

---

## Analyse de sensibilité {#analyse-de-sensibilite}

| Source retirée | Score sans | Niveau sans | Changement ? |
|---------------|-----------|------------|:------------:|
| JEP 444 | 4 (départ 3 — niv.1 restant = JEP 453, +1 conv 4 sources) | STANDARD | NON |
| JEP 453 | 4 (départ 3, +1 conv 4 sources restantes) | STANDARD | NON |
| Spring Boot docs | 5 (départ 4, +1 conv — convergence intacte sur 4 sources) | STANDARD | NON |
| Goetz JCIP | 5 (départ 4, +1 conv — convergence intacte sur 4 sources) | STANDARD | NON |
| Parlog/InfoQ | 5 (départ 4, +1 conv partielle — mais nuances CPU-bound/ScopedValue perdues) | STANDARD | NON |
| Toutes sources niv.3-5 simultanément | 5 (départ 4 — 2 JEPs niv.1, +1 conv — 2 standards indépendants convergent) | STANDARD | NON |
| JEP 444 + JEP 453 simultanément | 3 (départ 2 niv.3, +1 conv Spring+Goetz+Parlog) | RECOMMANDE | OUI |

**Conclusion : ROBUSTE** — recommandation [STANDARD] stable pour tout retrait individuel et pour tout retrait par catégorie sauf retrait simultané des deux JEPs niveau 1 (scénario artificiel — les deux JEPs sont des standards OpenJDK publiés et non retirés). La robustesse est élevée car les deux sources de niveau 1 (JEP 444 + JEP 453) définissent les comportements normatifs de la JVM, non falsifiables par des sources de niveau inférieur. La convergence avec Spring Boot docs (framework le plus utilisé sur la stack Java enterprise) valide l'applicabilité opérationnelle immédiate.

---

## Sources exclues

| Source | Critère | Raison |
|--------|---------|--------|
| JEP 446 — ScopedValue (OpenJDK, preview Java 21) | E5 absorbé | Parlog/InfoQ documente ScopedValue vs ThreadLocal avec la nuance opérationnelle nécessaire ; JEP 446 encore en évolution (non finalisé Java 21 LTS) |
| JEP 425 — Virtual Threads preview Java 19 (2022) | E5 supplanté | Remplacé intégralement par JEP 444 (version finale stable Java 21 LTS — même contenu, version normative plus récente) |
| TechEmpower Framework Benchmarks virtual threads (2023) | E3 indirect | Benchmarks micro non représentatifs d'applications réelles ; JEP 444 fournit le modèle de performance théorique plus fiable |
| Quarkus virtual threads documentation (Red Hat, 2024) | E2 scope | Implémentation framework non-Spring — hors scope du principe universel couvert par les JEPs |
| Micronaut virtual threads documentation (Object Computing, 2024) | E2 scope | Même raison que Quarkus ; la règle universelle (JEPs) couvre l'essentiel indépendamment du framework |
