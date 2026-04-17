# Double Extraction — PICOC sla-management

**Date** : 2026-04-17
**Protocole** : methodology.md v3.0
**Agent A** : mots-clés : "SLI SLO SLA error budget definition", "burn rate alerting SRE multiwindow", "service level objectives implementation Prometheus", "NestJS health check terminus SLO", "ITIL service level management"
**Agent B** : mots-clés : "error budget policy feature freeze", "SLO based alerting false positive reduction", "Sloth Pyrra SLO Prometheus generator", "availability SLO calibration empirical", "service level agreement SMART definition"

---

## PICOC

```
P  = Équipes exploitant un service web en production
I  = Définir des SLI/SLO/SLA et les mesurer (error budget, burn rate alerting)
C  = Pas de SLO formels, monitoring réactif sans alertes seuillées
O  = Reliability/Availability
Co = NestJS+React avec Prometheus+Grafana+@nestjs/terminus
```

---

## Accord Reviewer A / Reviewer B

### Sources évaluées par les deux reviewers

| # | Source | Niveau A | Niveau B | Accord inclusion ? | Note divergence |
|---|--------|---------|---------|:-----------------:|-----------------|
| 1 | Google SRE Book — ch. 4 "Service Level Objectives" (2016) | 5 | 5 | ✓ | — |
| 2 | Google SRE Workbook — ch. 2 + ch. 5 (2018) | 5 | 5 | ✓ | — |
| 3 | ITIL 4 — Service Level Management Practice (2019) | 3 | 3 | ✓ | — |
| 4 | Sloth (github.com/slok/sloth, 2021) | 3 | 3 | ✓ | — |
| 5 | NestJS Terminus (@nestjs/terminus, docs.nestjs.com) | 3 | 3 | ✓ | — |
| 6 | Pyrra (github.com/pyrra-dev/pyrra) | non trouvé | 3 | ✗ A / exclus après lecture | **Exclu après lecture** |
| 7 | Kleppmann M. — Designing Data-Intensive Applications (2017) | 5 | non trouvé | ✓ A / exclus après lecture | **Exclu après lecture** |

**Sources identifiées par A uniquement** : Kleppmann 2017 (traitement trop indirect de la question PICOC).
**Sources identifiées par B uniquement** : Pyrra (fonctionnellement redondant avec Sloth).

**Accord sur inclusion des sources communes** : 5/5 → kappa ≈ 1.0 (inclusion).
**Désaccords d'inclusion** : 0/5 sur les sources retenues.

### Résolution des divergences

**Pyrra (B uniquement, niveau 3)** : exclu après lecture. Fonctionnellement équivalent à Sloth pour la génération de règles Prometheus SLO. Retenu comme mention dans le JSON (alternative Sloth) mais non inclus comme source primaire car redondant — Sloth est mieux documenté dans la littérature CNCF. Décision unanime A/B.

**Kleppmann 2017 (A uniquement, niveau 5)** : exclu après lecture. Traite des SLAs au ch. 1 de façon trop brève et indirecte (contexte systèmes distribués) par rapport à la question PICOC (implémentation SLI/SLO avec Prometheus dans NestJS). Contenu entièrement absorbé par SRE Book ch. 4. Décision unanime A/B.

---

## Calcul GRADE final

```
Score de départ : 2
  (source la plus haute = niveau 3 : ITIL 4, Sloth, NestJS Terminus)
  Note : Google SRE Book et SRE Workbook sont niveau 5 (livres d'experts
  reconnus, pas des standards normatifs IEEE/ISO ni des organismes de
  standardisation). ITIL 4 est un framework international reconnu
  (niveau 3 — framework/standard organisationnel). Départ à 2.

+ 1 convergence
  Google SRE Book (niveau 5) + Google SRE Workbook (niveau 5) +
  ITIL 4 (niveau 3) + Sloth (niveau 3) + NestJS Terminus (niveau 3)
  convergent sans contradiction sur :
  - Hiérarchie SLI→SLO→SLA avec définitions cohérentes.
  - Error budget = 1 - SLO, liant fiabilité aux décisions produit.
  - Multiwindow multi-burn-rate alerting pour réduire les faux positifs.
  - Implémentation concrète : health checks + métriques Prometheus
    + règles SLO générées + dashboards Grafana.
  5 sources de 3 contextes distincts (expertise Google SRE, standard
  ITSM international, outillage open-source communautaire, framework
  NestJS officiel) sur 8 ans (2016–2024).

+ 1 effet important
  Multiwindow multi-burn-rate alerting : réduction documentée des faux
  positifs vs fenêtre unique (SRE Workbook ch. 5, exemples chiffrés).
  Error budget policy : mécanisme de gouvernance liant directement la
  fiabilité aux décisions features — fort impact organisationnel.
  Tableaux de disponibilité : 99 % = 3,65 j/an vs 99,99 % = 52,6 min
  — impact concret et mesurable sur les choix de SLO.

- 1 indirectness
  Google SRE Book et SRE Workbook décrivent les pratiques internes de
  Google, pas une étude empirique peer-reviewed contrôlée.
  Absence d'études RCT comparant des équipes avec SLO formels vs sans
  SLO sur des métriques de disponibilité mesurées hors GAFAM.
  Preuves principalement normatives et expertales — solides mais non
  quantifiées empiriquement sur des populations larges.

Score final : 2 + 1 + 1 - 1 = 3 → [RECOMMANDE], MODERE
```

Note biais de publication : Google SRE Book et SRE Workbook sont des publications de Google décrivant leurs propres pratiques — biais possible de confirmation et de survivorship (Google est un environnement atypique à très grande échelle). Atténué par l'adoption massive des pratiques SRE dans l'industrie (ITIL 4 incluant des concepts SLO/SLA alignés, outillage open-source Sloth/Pyrra implémentant exactement ces recommandations). ITIL 4 : framework commercial (Axelos/PeopleCert), possible biais vers la complexité — atténué par la convergence avec SRE Book sur les définitions fondamentales.

---

## Analyse de sensibilité {#analyse-de-sensibilite}

| Source retirée | Score sans | Niveau sans | Changement ? |
|---------------|-----------|------------|:------------:|
| Google SRE Book 2016 (niveau 5) | Départ niveau 3 (ITIL/Sloth/Terminus) → 2+1+1-1=3 | [RECOMMANDE] | NON — départ inchangé, convergence et effet important maintenus par SRE Workbook |
| Google SRE Workbook 2018 (niveau 5) | 2+1+1-1=3 (SRE Book maintient la convergence et l'effet important) | [RECOMMANDE] | NON |
| Toutes sources Google SRE simultanément (Book + Workbook) | Départ niveau 3 → 2+0+0-0=2 (perte convergence forte et effet important ; indirectness disparaît) | [BONNE PRATIQUE] | OUI — retrait des deux sources Google SRE fait tomber à [BONNE PRATIQUE] |
| ITIL 4 (niveau 3) | 2+1+1-1=3 (Sloth + Terminus + SRE convergent toujours) | [RECOMMANDE] | NON |
| Sloth (niveau 3) | 2+1+1-1=3 (ITIL + Terminus + SRE convergent ; Pyrra mentionné en alternative) | [RECOMMANDE] | NON |
| NestJS Terminus (niveau 3) | 2+1+1-1=3 (ITIL + Sloth + SRE convergent ; Terminus remplaçable par prom-client seul) | [RECOMMANDE] | NON |
| ITIL 4 + Sloth + NestJS Terminus simultanément | Départ niveau 5 (SRE Book) → 1+1+1-1=2 | [BONNE PRATIQUE] | OUI — perte du départ niveau 3 ; toutes les sources niveau 3 retirées |
| Toutes sources sauf SRE Book | 2+0+1-0=3 (Workbook retiré, effet important maintenu par Book seul, convergence absente) | [RECOMMANDE] | NON |

**Conclusion : MODERE** — recommandation [RECOMMANDE] stable pour tout retrait individuel. Deux scénarios de déclassement à [BONNE PRATIQUE] : (1) retrait simultané des deux sources Google SRE (Book + Workbook), seule constellation qui détruirait à la fois la convergence et l'effet important ; (2) retrait simultané de toutes les sources niveau 3 (ITIL 4 + Sloth + Terminus), qui ferait remonter le départ à niveau 5 mais perdrait la convergence multi-contexte. Ces scénarios sont improbables : le SRE Book (2016) et le SRE Workbook (2018) sont des références de facto universellement adoptées dans le domaine SRE/DevOps. La classification MODERE (et non ROBUSTE) reflète l'absence d'études empiriques peer-reviewed hors Google confirmant l'efficacité quantifiée des SLOs.

---

## Sources exclues

| Source | Critère | Raison |
|--------|---------|--------|
| Pyrra (github.com/pyrra-dev/pyrra) | E5 partiel | Fonctionnellement redondant avec Sloth. Alternative valide (mentionnée dans le JSON) mais non retenue comme source distincte car les deux outils implémentent les mêmes recommandations du SRE Workbook. |
| Kleppmann M. — DDIA (2017) | E5 partiel | Traitement trop indirect du sujet (ch. 1 uniquement, contexte systèmes distribués). Absorbé par SRE Book ch. 4 qui couvre le même périmètre avec plus de profondeur et de précision. |
| Datadog — "SLO Best Practices Guide" | E3 | Whitepaper commercial. Biais commercial implicite. Définitions absorbées par SRE Book + ITIL 4. |
| Circonus — "SLA vs SLO vs SLI Guide" | E2/E3 | Blog fournisseur monitoring. Définitions redondantes, source non indépendante. |
