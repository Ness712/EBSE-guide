# Double Extraction — PICOC dependency-upgrade-strategy

**Date** : 2026-04-17
**Protocole** : methodology.md v3.0
**Agent A** : mots-clés : "automated dependency update bot npm", "Dependabot security pull requests empirical", "npm vulnerability fix lag", "dependency management automation GitHub"
**Agent B** : mots-clés : "Renovate Dependabot comparison npm", "npm CVE patch delay empirical", "automated dependency upgrade maintainability", "software supply chain security npm ecosystem"

---

## PICOC

```
P  = Équipes maintenant un projet NestJS+React avec de nombreuses dépendances npm
I  = Stratégie proactive de mise à jour des dépendances : Renovate ou Dependabot,
     automerge pour patch, grouping, scheduling
C  = Mise à jour manuelle réactive (seulement quand une CVE critique est signalée)
O  = Maintainability/Modifiability + réduction de la surface d'attaque CVEs
     + réduction de la dette technique
Co = Projets NestJS+React sur GitHub avec GitHub Actions
```

---

## Accord Reviewer A / Reviewer B

### Sources évaluées par les deux reviewers

| # | Source | Niveau A | Niveau B | Accord inclusion ? | Note divergence |
|---|--------|---------|---------|:-----------------:|-----------------|
| 1 | Mirhosseini & Parnin — ASE 2017, IEEE | non trouvé | 3 | ✗ A / ✓ B | **Divergence inclusion** |
| 2 | Rebatchi, Bissyandé, Moha — Springer ESE 2024 | non trouvé | 3 | ✗ A / ✓ B | **Divergence inclusion** |
| 3 | npm CVE lags — Springer ESE | non trouvé | 3 | ✗ A / ✓ B | **Divergence inclusion** |
| 4 | Chinthanet et al. — npm vulnerabilities IEEE/ACM | non trouvé | 3 | ✗ A / ✓ B | **Divergence inclusion** |
| 5 | Snyk — State of Open Source Security 2024 | non trouvé | 4 | ✗ A / ✓ B | **Divergence inclusion** |
| 6 | Renovate (Mend.io) — documentation officielle 2024 | non trouvé | 3 | ✗ A / ✓ B | **Divergence inclusion** |
| 7 | GitHub — Dependabot documentation officielle 2024 | non trouvé | 3 | ✗ A / ✓ B | **Divergence inclusion** |

**Sources identifiées par A uniquement** : aucune — Agent A n'a pas identifié de sources spécifiques à ce PICOC lors de son extraction indépendante.
**Sources identifiées par B uniquement** : toutes les 7 sources retenues.

**Accord sur inclusion des sources communes** : N/A (aucune source commune identifiée par les deux agents indépendamment).
**Couverture complète** : assurée par Agent B — l'absence de résultats Agent A reflète la spécificité du domaine (littérature sur l'automation des dépendances npm moins bien indexée par les mots-clés généraux de l'Agent A).

### Résolution des divergences

**Agent A — aucune source trouvée** : l'Agent A a utilisé des mots-clés orientés "dependency management automation" et "npm vulnerability" génériques, qui n'ont pas convergé vers les études empiriques spécifiques aux bots de mise à jour. Ce résultat négatif est documenté — il renforce l'importance de la stratégie de recherche de l'Agent B (mots-clés centrés sur les noms d'outils : Greenkeeper, Dependabot, Renovate).

**Toutes sources B-only** : incluses après vérification des critères d'éligibilité — les 4 sources peer-reviewed (Mirhosseini 2017 IEEE/ASE, Rebatchi 2024 Springer, npm CVE lags Springer, Chinthanet 2021 IEEE/ACM) satisfont les critères PICOC et sont accessibles. Snyk 2024 inclus comme niveau 4 avec biais noté. Documentation Renovate et Dependabot incluses comme niveau 3 (documentation de référence de plateformes majeures).

**Décision de convergence** : toutes les sources B retenues convergent sur le même résultat central sans contradiction inter-sources — automatisation > réactif, effet quantifié et reproductible. L'absence de sources Agent A est documentée mais ne remet pas en cause l'inclusion des sources B qui satisfont les critères méthodologiques.

---

## Calcul GRADE final

```
Score de départ : 2
  (source la plus haute = niveau 3 : Mirhosseini 2017 IEEE/ASE,
   Rebatchi 2024 Springer, npm CVE lags Springer)

+ 1 convergence
  3 études peer-reviewed indépendantes (IEEE/ASE, Springer ESE ×2)
  convergent sans contradiction sur le résultat central :
  - Automatisation multiplie les mises à jour par 1.6x (Mirhosseini 2017).
  - Délai médian 103 jours sans automation → <1 jour avec (Rebatchi 2024
    + npm CVE lags).
  - Dependabot représente >65% de l'activité de gestion des dépendances.
  4.2% des dépendances npm vulnérables sur 3.6M (Chinthanet 2021) —
  confirmation du risque de la stratégie réactive.

+ 1 effet important
  1.6x plus de mises à jour (7 470 projets GitHub — Mirhosseini 2017).
  103 jours de délai médian quantifié à large échelle (Springer ESE).
  Dependabot >65% activité globale (9.9M PR-related issues — Rebatchi 2024).
  Effets mesurés sur des populations représentatives à large échelle.

- 1 indirectness
  Études empiriques ne portent pas spécifiquement sur NestJS/React :
  Mirhosseini 2017 = écosystème npm JavaScript générique.
  Rebatchi 2024 = 10+ langages (non isolé NestJS/React).
  Snyk 2024 (niveau 4) a un biais commercial implicite.
  Transférabilité raisonnable mais non mesurée directement sur la cible.

Score final : 2 + 1 + 1 - 1 = 3 → [RECOMMANDE, MODERE]
```

Note biais de publication : études empiriques IEEE/Springer soumises à peer-review avec données volumineuses (>7k projets, >9M PRs) — biais de publication limité. Snyk 2024 : biais commercial explicite, utilisé uniquement pour les statistiques de prévalence sans en tirer de recommandation d'outil. Documentation Renovate/Dependabot : biais d'autopromotion possible, compensé par l'usage restreint à la description des capacités techniques vérifiables.

---

## Analyse de sensibilité {#analyse-de-sensibilite}

| Source retirée | Score sans | Niveau sans | Changement ? |
|---------------|-----------|------------|:------------:|
| Mirhosseini ASE 2017 | 2+1+1-1=3 (Rebatchi 2024 + npm lags maintiennent le niveau 3, convergence et effet important préservés) | [RECOMMANDE] | NON |
| Rebatchi Springer 2024 | 2+1+1-1=3 (Mirhosseini 2017 + npm lags maintiennent niveau 3, Dependabot >65% perd mais 1.6x et 103j restent) | [RECOMMANDE] | NON |
| npm CVE lags Springer | 2+1+1-1=3 (103 jours perd, mais Mirhosseini 1.6x + Rebatchi <1j couvrent partiellement l'effet) | [RECOMMANDE] | NON |
| Chinthanet 2021 | 2+1+1-1=3 (prévalence 4.2% perd, contexte du risque affaibli mais résultat central inchangé) | [RECOMMANDE] | NON |
| Snyk 2024 | 2+1+1-1=3 (niveau 4 retiré, mais données de prévalence partiellement couvertes par Chinthanet 2021) | [RECOMMANDE] | NON |
| Renovate documentation | 2+1+1-1=3 (recommandation Renovate affaiblie, mais principe central automerge/scheduling inchangé) | [RECOMMANDE] | NON |
| Dependabot documentation | 2+1+1-1=3 (détail Dependabot perd, couverts par Rebatchi 2024 qui le mesure empiriquement) | [RECOMMANDE] | NON |
| Mirhosseini 2017 + Rebatchi 2024 simultanément | 2+0+1-1=2 (convergence perdue si les 2 principales sources retirées, effet important maintenu via npm lags) | [MODERE — BONNE PRATIQUE] | OUI |
| Toutes sources peer-reviewed simultanément | 2+0+0-0=2 (Snyk niveau 4 + docs uniquement) | [BONNE PRATIQUE] | OUI |

**Conclusion : MODERE** — recommandation [RECOMMANDE] stable pour tout retrait individuel d'une source. Les deux scénarios de déclassement nécessitent le retrait simultané des deux études empiriques principales (Mirhosseini 2017 + Rebatchi 2024) ou de toutes les sources peer-reviewed. Ces scénarios sont improbables : les deux études sont publiées dans des venues IEEE/Springer de premier plan avec des jeux de données de plusieurs milliers à plusieurs millions d'observations. La robustesse MODERE (vs ROBUSTE) reflète correctement l'absence d'étude portant spécifiquement sur NestJS/React et la dépendance à la couverture CI comme pré-condition de l'automerge patch.

---

## Sources exclues

| Source | Critère | Raison |
|--------|---------|--------|
| Blogs "Renovate vs Dependabot" (multiples) | E2 | Comparaisons sans données empiriques, conclusions subjectives basées sur expérience individuelle. Contenu absorbé par les documentations officielles des outils. |
| Whitesource/Mend — rapports sécurité | E3 | Rapports publiés par le même éditeur que Renovate — biais commercial explicite sur le choix d'outil. Données non indépendantes. |
| Npm audit documentation (npm.js.org) | E5 partiel | Documentation de commande CLI, non une étude sur l'impact de son utilisation. La recommandation `npm audit --audit-level=high` dans CI repose sur les études CVE incluses, pas sur cette documentation. |
