# Double Extraction — PICOC cache-invalidation

**Date** : 2026-04-17
**Protocole** : methodology.md v3.0
**Agent A** : mots-clés : "cache invalidation strategies TTL write-through write-behind", "cache-aside pattern lazy loading implementation", "Redis DEL UNLINK cache invalidation", "event-driven cache invalidation domain events", "cache stampede thundering herd mitigation"
**Agent B** : mots-clés : "write-through write-behind cache consistency tradeoffs", "Microsoft Azure cache-aside pattern", "NestJS cache-manager CACHE_MANAGER invalidation", "Redis eviction policies expiration", "Phil Karlton cache invalidation naming things"

---

## PICOC

```
P  = Équipes de développement utilisant Redis comme cache applicatif
I  = Choisir et implémenter une stratégie d'invalidation de cache
     (TTL, write-through, write-behind, cache-aside, event-driven)
C  = Pas de stratégie d'invalidation (TTL seul ou invalidation absente)
O  = Cohérence cache/source, performance, risque de données périmées
Co = Applications web backend (NestJS, Spring Boot) avec Redis
```

---

## Accord Reviewer A / Reviewer B

### Sources évaluées par les deux reviewers

| # | Source | Niveau A | Niveau B | Accord inclusion ? | Note divergence |
|---|--------|---------|---------|:-----------------:|-----------------|
| 1 | Redis Documentation — Eviction and Expiration Policies (2024) | 3 | 3 | ✓ | — |
| 2 | Microsoft Azure Architecture Center — Cache-Aside Pattern (2023) | 3 | 3 | ✓ | — |
| 3 | Microsoft Azure Architecture Center — Write-Through and Write-Behind (2023) | 3 | 3 | ✓ | — |
| 4 | NestJS Caching Documentation — @nestjs/cache-manager (2024) | 3 | 3 | ✓ | — |
| 5 | Karlton P. — citation "cache invalidation and naming things" (1996) | 5 | 5 | ✓ | — |
| 6 | Google Cloud Memorystore docs | 3 | 3 | ✗ | **Accord exclusion** — redondant avec Redis docs |
| 7 | Blog posts engineering (Hazard, DigiNinja, Medium) | 5 | 5 | ✗ | **Accord exclusion** — redondant avec Azure docs |

**Sources identifiées par A uniquement** : aucune (convergence complète sur les inclusions)
**Sources identifiées par B uniquement** : aucune (convergence complète)

**Accord sur inclusion des sources communes** : 5/5 → kappa ≈ 1.0 (inclusion)
**Désaccords d'inclusion** : 0/7 → accord complet A et B

### Résolution des divergences

Aucune divergence d'inclusion. Les deux agents A et B ont identifié les mêmes 5 sources à inclure et les mêmes sources à exclure pour redondance. Convergence parfaite.

---

## Calcul GRADE final

```
Score de départ : 2
  (source la plus haute = niveau 3 : Redis Documentation, Azure Architecture Center,
   NestJS Documentation — toutes niveau 3)

+ 1 convergence
  Redis Documentation (niveau 3) + Microsoft Azure Cache-Aside Pattern (niveau 3)
  + Microsoft Azure Write-Through/Write-Behind (niveau 3) + NestJS Caching docs (niveau 3)
  convergent sans contradiction sur :
  - Cache-aside : charger en cas de miss, invalider sur update source
  - Write-through : double write synchrone, cohérence forte, latence augmentée
  - Write-behind : write asynchrone, performance max, risque de perte
  - TTL comme filet de sécurité universel
  4 sources indépendantes de 3 organisations distinctes (Redis Labs, Microsoft, NestJS/Vercel)

- 0 nuance empirique (pas de malus supplémentaire)
  Les sources convergent sans contradiction. La tension cohérence/performance
  est documentée de façon cohérente dans toutes les sources.

Score final : 2 + 1 = 3 → [RECOMMANDE]
```

Note biais de publication : documentation technique officielle (Redis, Microsoft, NestJS) — biais possible vers la mise en valeur de leurs propres outils. Atténué par la convergence inter-organisations et l'absence de contradiction sur les tradeoffs documentés.

---

## Analyse de sensibilité {#analyse-de-sensibilite}

| Source retirée | Score sans | Niveau sans | Changement ? |
|---------------|-----------|------------|:------------:|
| Redis Documentation 2024 | 2+1=3 (Azure + NestJS convergent, convergence maintenue) | [RECOMMANDE] | NON |
| Azure Cache-Aside Pattern 2023 | 2+1=3 (Redis + Azure Write-Through + NestJS convergent) | [RECOMMANDE] | NON |
| Azure Write-Through/Write-Behind 2023 | 2+1=3 (Redis + Azure Cache-Aside + NestJS convergent) | [RECOMMANDE] | NON |
| NestJS Caching Documentation 2024 | 2+1=3 (Redis + Azure convergent, convergence ≥3 sources maintenue) | [RECOMMANDE] | NON |
| Karlton 1996 | 3 (source de contexte, pas de changement de score) | [RECOMMANDE] | NON |
| Toutes sources niveau 3 sauf Redis | 2+0=2 (une seule source, convergence absente) | [BONNE PRATIQUE] | OUI |

**Conclusion : ACCEPTABLE** — recommandation [RECOMMANDE] stable pour tout retrait individuel. Le seul scénario de déclassement est le retrait de 3 sources sur 4 simultanément, laissant une seule source niveau 3 sans convergence. Ce scénario est irréaliste. L'absence de source niveau 1 ou 2 (pas de standard RFC ou OWASP directement applicable à l'invalidation applicative) limite la robustesse à ACCEPTABLE — le [RECOMMANDE] est justifié mais ne peut atteindre [STANDARD] sans une référence normative de niveau 1.

---

## Sources exclues

| Source | Critère | Raison |
|--------|---------|--------|
| Google Cloud Memorystore documentation | E3 | Redondance totale avec Redis docs — même API, mêmes commandes DEL/UNLINK, mêmes politiques d'éviction |
| AWS ElastiCache documentation | E3 | Redondance avec Redis docs, scope AWS cloud spécifique hors principe universel |
| Fowler — PoEAA — cache pattern | E3 | Absorbé par Azure Architecture Center (2023, plus récent, plus opérationnel, patterns nommés explicitement) |
| Varnish Cache documentation | E2 | Hors scope PICOC — cache HTTP proxy côté infrastructure, pas invalidation applicative |
| Blog posts engineering (5+ sources) | E3 | Niveau 5 redondant — Azure Architecture Center couvre les mêmes patterns avec plus de rigueur éditoriale |
| Papers académiques consistency | E2 | Trop théoriques (CAP theorem, linearizability) — pas prescriptifs pour l'implémentation applicative |
| Spring Cache / @Cacheable documentation | E2 | Hors scope du principe universel — candidat pour variant java-spring-boot |
