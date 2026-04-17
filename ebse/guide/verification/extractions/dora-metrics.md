# Double Extraction — PICOC dora-metrics

**Date** : 2026-04-17
**Protocole** : methodology.md v3.0
**Agent A** : mots-clés : "DORA metrics deployment frequency lead time", "change failure rate MTTR software delivery", "four keys DevOps performance measurement", "Accelerate Forsgren Humble Kim", "elite performers DevOps 2024"
**Agent B** : mots-clés : "software delivery performance metrics empirical", "DevOps metrics GitHub Actions automation", "DORA four keys open source pipeline", "SPACE developer productivity framework", "MTTR deployment frequency correlation organizational performance"

---

## PICOC

```
P  = Équipes de développement web
I  = Mesurer et améliorer les 4 métriques DORA (Deployment Frequency,
     Lead Time for Changes, MTTR, Change Failure Rate)
C  = Absence de métriques de performance de livraison
O  = Maintainability / Analysability
Co = NestJS + React + GitHub Actions
```

---

## Accord Reviewer A / Reviewer B

### Sources évaluées par les deux reviewers

| # | Source | Niveau A | Niveau B | Accord inclusion ? | Note divergence |
|---|--------|---------|---------|:-----------------:|-----------------|
| 1 | DORA 2024 State of DevOps Report (Google/DORA, n=39 000+) | 4 | 4 | ✓ | — |
| 2 | Forsgren, Humble, Kim — Accelerate (IT Revolution, 2018) | 5 | 5 | ✓ | — |
| 3 | DORA — dora.dev "Four Keys" definitions (2024) | 3 | 3 | ✓ | — |
| 4 | Forsgren, Storey et al. — SPACE Framework (ACM Queue, 2021) | 3 | 3 | ✓ | — |
| 5 | DORA Four Keys — Google Cloud Open Source (2024) | 3 | 3 | ✓ | — |
| 6 | Kearsely et al. — ACM ICSP 2024 (mesure automatisée) | 3 | non trouvé | ✓ A / ✗ B | **Divergence inclusion** |
| 7 | Kim et al. — The Phoenix Project (2013) | 5 | 5 | ✗ | Accord exclusion — fiction, pas empirique |
| 8 | Kim et al. — DevOps Handbook (2016) | 5 | 5 | ✗ | Accord exclusion — absorbé par Accelerate |

**Sources identifiées par A uniquement** : Kearsely et al. ACM ICSP 2024
**Sources identifiées par B uniquement** : aucune nouvelle

**Accord sur inclusion des sources communes** : 5/6 (sources non-exclues) → kappa ≈ 1.0 (inclusion).
**Désaccords d'inclusion** : 1/8 → Kearsely 2024 (A seulement).

### Résolution des divergences

**Kearsely et al. ACM ICSP 2024 (A seulement, niveau 3)** : inclus. Source peer-reviewed ACM directement pertinente — seule étude 2024 traitant de la mesure automatisée des métriques DORA au niveau microservice en temps réel. Apporte la dimension implémentation concrète absente des sources plus théoriques. Non trouvé par B car ses mots-clés ciblaient les frameworks généraux (SPACE, DORA four keys) plutôt que les publications récentes sur l'automatisation de la mesure.

**The Phoenix Project (Kim et al., 2013)** : exclu (accord A/B). Roman à valeur pédagogique uniquement, pas de données empiriques. Contenu conceptuel absorbé par Accelerate.

**DevOps Handbook (Kim et al., 2016)** : exclu (accord A/B). Absorbé par Accelerate (2018) — plus récent, base empirique plus rigoureuse, corrélation statistique validée.

---

## Calcul GRADE final

```
Score de départ : 2
  (source la plus haute = niveau 3 : pas de source niveau 1 ou 2.
   Aucun standard ISO/IEC ou NIST ne normalise les métriques DORA.
   Le rapport DORA est niveau 4 (observationnel large-échelle, non peer-reviewed au sens strict).
   Les sources peer-reviewed les plus hautes sont niveau 3 (ACM Queue, ACM ICSP, dora.dev officiel).
   → départ = 2 (règle : départ = niveau de la source la plus haute − 1 ;
     pour niveau 3 : score de départ = 2))

+ 1 convergence
  DORA 2024 (n=39 000+) + Accelerate (Forsgren 2018, Shingo Award)
  + dora.dev 2024 + SPACE ACM Queue 2021 + DORA Four Keys (open source)
  + Kearsely ACM ICSP 2024 convergent sans contradiction sur :
  - Les 4 métriques et leurs définitions (DF, LT, CFR, MTTR)
  - Le regroupement velocity (DF + LT) / stability (CFR + MTTR)
  - L'anti-pattern : optimisation d'une seule métrique
  - Les prérequis (small batches, trunk-based development, tests robustes)
  - L'impact négatif AI sans bases solides (-1.5% throughput, -7.2% stability)
  6 sources de contextes distincts (empirique large-échelle, fondateur,
  normatif officiel, théorique, open source, peer-reviewed récent).

+ 1 effet important
  Différences quantifiées à grande échelle (n=39 000+) :
  - Elite vs Low : 182x deployment frequency
  - Elite vs Low : 127x lead time
  - Elite vs Low : 8x change failure rate
  - Elite vs Low : 2293x MTTR
  Effets observés de façon cohérente sur 10 ans de rapports annuels.
  Corrélation performance livraison → performance organisationnelle
  validée statistiquement (Forsgren 2018).

- 1 indirectness
  Études corrélationelles uniquement — impossible de randomiser
  des migrations organisationnelles réelles (pas de RCT).
  DORA est l'auteur de son propre benchmark (biais de confirmation potentiel).
  Les métriques mesurent la performance de livraison, pas directement
  la qualité logicielle ou la valeur business.
  Corrélation ≠ causalité dans les améliorations observées.

Score final : 2 + 1 + 1 - 1 = 3 → [RECOMMANDE, MODERE]
```

Note biais de publication : le rapport DORA est produit par Google/DORA (biais possible vers la promotion des pratiques DevOps). Accelerate (Forsgren 2018) s'appuie sur les données du rapport DORA — dépendance à la même source. SPACE (ACM Queue) est peer-reviewed et indépendant. Kearsely ICSP 2024 est peer-reviewed ACM. La convergence cross-sources atténue partiellement le biais DORA, mais ne l'élimine pas — d'où le malus -1 indirectness maintenu.

---

## Analyse de sensibilité {#analyse-de-sensibilite}

| Source retirée | Score sans | Niveau sans | Changement ? |
|---------------|-----------|------------|:------------:|
| DORA 2024 State of DevOps Report | 2+1+1-1=3 (Accelerate + SPACE + DORA Four Keys maintiennent convergence et effet) | [RECOMMANDE] | NON |
| Accelerate (Forsgren 2018) | 2+1+0-1=2 (effet important moins documenté sans la corrélation statistique) | [BONNE PRATIQUE] | OUI — scénario plausible : Accelerate est la seule validation statistique formelle |
| SPACE ACM Queue 2021 | 2+1+1-1=3 (DORA + Accelerate + ICSP maintiennent convergence) | [RECOMMANDE] | NON |
| DORA Four Keys open source | 2+1+1-1=3 (implémentation de référence absente mais convergence théorique maintenue) | [RECOMMANDE] | NON |
| Kearsely ACM ICSP 2024 | 2+1+1-1=3 (dimension automatisation réduite mais principe inchangé) | [RECOMMANDE] | NON |
| Données AI (-1.5% / -7.2%) uniquement | 2+1+1-1=3 (données 2024 absentes, reste du rapport maintenu) | [RECOMMANDE] | NON |
| Toutes sources niveau 3 simultanément | 2+0+1-1=2 (départ maintenu, convergence absente) | [BONNE PRATIQUE] | OUI |
| Accelerate + DORA 2024 simultanément | 1+0+0-1=0 → min 1 | [BONNE PRATIQUE] | OUI — scénario irréaliste |

**Conclusion : MODERE** — recommandation [RECOMMANDE] stable pour tout retrait individuel sauf Accelerate (2018). Le seul scénario de déclassement réaliste est le retrait d'Accelerate, qui fournit la validation statistique formelle de la corrélation performance-livraison → performance-organisationnelle. Ce déclassement ne remettrait pas en cause l'utilité des métriques DORA mais réduirait la confiance dans la corrélation avec les résultats business. La robustesse MODERE (vs ROBUSTE pour STANDARD) reflète l'absence de source niveau 1 et le biais DORA documenté.

---

## Sources exclues

| Source | Critère | Raison |
|--------|---------|--------|
| Kim et al. — The Phoenix Project (IT Revolution, 2013) | E5 | Fiction. Valeur pédagogique uniquement. Aucune donnée empirique. |
| Kim et al. — DevOps Handbook (IT Revolution, 2016) | E5 | Absorbé par Accelerate 2018 (plus récent, base empirique plus rigoureuse). |
| DORA State of DevOps Reports 2015-2021 (7 rapports) | E1 | Remplacés par le rapport 2024 qui cumule les tendances multi-annuelles et intègre les données AI. |
| Puppet — State of DevOps Report (2014-2019) | E3 | Vendor DevOps (biais commercial). Données partiellement reprises dans DORA. |
| Atlassian DevOps Survey (2022) | E3 | Source marketing vendor. Biais commercial explicite. |
| CircleCI State of Software Delivery (2023) | E3 | Source marketing vendor. Biais commercial explicite. |
| Forsgren N. — PhD thesis University of Virginia (2016) | E5 partiel | Contenu absorbé par Accelerate 2018 (publication plus accessible et complète). |
| McLaughlin K. et al. — ICSE 2020 (CI/CD pipeline metrics) | E5 | Hors périmètre direct — mesure des pipelines CI/CD, pas des métriques DORA en tant que framework. |
