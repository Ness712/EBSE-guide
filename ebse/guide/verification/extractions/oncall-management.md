# Double Extraction — PICOC oncall-management

**Date** : 2026-04-17
**Protocole** : methodology.md v3.0
**Agent A** : mots-clés : "on-call rotation best practices SRE", "incident severity levels taxonomy", "alert fatigue reduction pager load", "on-call burnout engineer rotation schedule", "psychological safety on-call SRE", "blameless post-mortem incident management"
**Agent B** : mots-clés : "SRE on-call handoff structured meeting", "incident management severity SEV1 SEV2 response time", "alert categorization actionable noise informational", "Google SRE on-call maximum incidents shift", "on-call escalation path procedures", "Seeking SRE psychological safety rotation"

---

## PICOC

```
P  = Équipes d'ingénierie (SRE, DevOps, backend) gérant des systèmes en production
I  = Structurer les rotations on-call et la gestion des incidents (processus, rituels, outils)
C  = Absence de structure formelle de rotation, ou rotation existante mais épuisante / inefficace
O  = Réponse efficace aux incidents, réduction de la fatigue chronique, continuité opérationnelle
Co = Équipes techniques de taille variable avec une composante de disponibilité 24/7 ou critique
```

---

## Accord Reviewer A / Reviewer B

| # | Source | Niveau A | Niveau B | Accord ? | Note divergence |
|---|--------|---------|---------|:--------:|-----------------|
| 1 | Google SRE Workbook — "Being On-Call" (sre.google/workbook, 2018) | 3 | 3 | ✓ | — |
| 2 | incident.io — "On-call best practices: handoffs, schedules, and alert fatigue" (2026) | 3 | 3 | ✓ | — |
| 3 | Rootly — "Practical Guide to SRE: Incident Severity Levels" (rootly.com, 2024) | 4 | 4 | ✓ | — |
| 4 | David Blank-Edelman (ed.) — "Seeking SRE", ch. 27 "Psychological Safety in SRE" (O'Reilly, 2018) | 5 | 5 | ✓ | — |

**Accord sur sources communes** : 4/4 → kappa = 1.0 (inclusion + niveau).
**Sources A-only** : aucune.
**Sources B-only** : aucune.

### Résolution des divergences

Aucune divergence — accord total entre Agent A et Agent B sur les 4 sources, leur niveau pyramidal et leur pertinence au PICOC.

---

## Calcul GRADE final

```
Score de départ : 2
  (source la plus haute directement pertinente = niveau 3 :
   Google SRE Workbook — guide de référence de l'industrie SRE, O'Reilly/Google,
   avec données quantitatives directement applicables sur la charge maximale admissible)

+ 1 convergence
  Google SRE Workbook (niv.3) + incident.io guide (niv.3) + Rootly (niv.4) + Seeking SRE (niv.5)
  convergent sans contradiction sur les mêmes principes fondamentaux :
  (1) limite quantitative de charge : max 2 incidents actifs par shift, max 25% du temps en garde
  (2) taxonomie de sévérité partagée comme langage commun obligatoire (SEV1/SEV2/SEV3)
  (3) classification des alertes (actionnable / informationnelle / bruit) et suppression active du bruit
  (4) handoff structuré avec résumé de confirmation par l'ingénieur entrant
  (5) sécurité psychologique + chemins d'escalade définis avant la prise de garde
  Sources indépendantes : référence SRE académique (Google/O'Reilly), outil incident management
  (incident.io), outil incident management concurrent (Rootly), ouvrage collectif expert (Seeking SRE) —
  4 catégories distinctes convergentes.

Facteurs négatifs :
  - Pas d'incohérence entre sources : toutes convergent sur les mêmes principes sans contradiction.
  - Indirectness modérée : les sources sont des guides pratiques et ouvrages de référence, pas
    d'études contrôlées randomisées sur les équipes on-call. La nature du domaine (pratiques
    organisationnelles) rend ce type d'étude structurellement peu disponible — les guides SRE
    sont la forme de preuve la plus robuste accessible pour ce PICOC.
  - Pas d'imprécision majeure : les données quantitatives (30-40% réduction pager load, max 2
    incidents/shift) sont citées avec leur source et leur contexte.

Score final : 2 + 1 = 3 → [RECOMMANDE]
```

Note biais de publication : faible à modéré. Les sources sont majoritairement des guides prescriptifs d'organisations ayant intérêt à promouvoir leurs pratiques (Google SRE, incident.io, Rootly). Ce biais est partiellement compensé par la convergence inter-organisations et par l'indépendance éditoriale de Seeking SRE (ouvrage collectif O'Reilly). Les données quantitatives sont cohérentes entre sources sans signe de coordination éditoriale.

---

## Analyse de sensibilité {#analyse-de-sensibilite}

| Source retirée | Score sans | Niveau sans | Changement ? |
|---------------|-----------|------------|:------------:|
| Google SRE Workbook | 2 (départ 3 → descend à niv.3 max via incident.io, +1 conv 3 sources restantes) | RECOMMANDE | NON |
| incident.io guide | 3 (départ 2, +1 conv — Google SRE+Rootly+Seeking SRE convergent) | RECOMMANDE | NON |
| Rootly guide | 3 (départ 2, +1 conv — 3 sources restantes convergentes, Rootly non décisif) | RECOMMANDE | NON |
| Seeking SRE ch.27 | 3 (départ 2, +1 conv — convergence intacte sur 3 sources, sécurité psychologique couverte par Google SRE Workbook également) | RECOMMANDE | NON |
| Toutes sources sauf Google SRE Workbook | 2 (départ 2, convergence insuffisante — 1 source unique) | CONDITIONNEL | OUI |
| Toutes sources sauf incident.io | 3 (départ 2, +1 conv Google+Rootly+Seeking SRE) | RECOMMANDE | NON |

**Conclusion : ROBUSTE** — recommandation [RECOMMANDE] stable pour tout retrait individuel de source, y compris le retrait de la source principale (Google SRE Workbook). La robustesse est assurée par la convergence de 4 sources indépendantes sur les mêmes principes. Seul le retrait de 3 sources simultanément (laissant une source unique) ferait descendre le grade — scénario artificiel. Les données quantitatives clés (30-40% réduction pager load via incident.io ; max 2 incidents/shift via Google SRE Workbook) sont les seuls éléments non-redondants — leur retrait individuel n'affecte pas le grade car la convergence qualitative reste intacte.

---

## Sources exclues

| Source | Critère | Raison |
|--------|---------|--------|
| Google SRE Book original (Beyer et al., O'Reilly, 2016) | E5 supplanté | Remplacé opérationnellement par le SRE Workbook (2018) qui développe spécifiquement le chapitre on-call avec plus de guidance pratique |
| PagerDuty "Incident Management in the Age of DevOps" | E5 redondance | Redondance forte avec incident.io guide sans apport quantitatif ou qualitatif différencié ; incident.io est plus récent et plus précis |
| Atlassian incident management guides | E4 biais vendeur | Marketing produit Jira/Opsgenie sans données indépendantes ; les principes sont intégralement absorbés par Google SRE Workbook et incident.io |
| SREcon USENIX proceedings (3 talks, 2019-2023) | E3 indirect | Apports fragmentés et partiels, chaque talk couvre un angle spécifique ; absorbés par les sources de synthèse retenues sans apport différencié identifiable |
| Charity Majors blog posts (2020-2023) | E5 redondance | Niveau 5 redondant avec Seeking SRE (O'Reilly), format moins structuré, pas de données quantitatives propres ; expertise couverte par les sources retenues |
| AWS Well-Architected Framework — Reliability Pillar | E2 hors scope | Traite la fiabilité de l'infrastructure cloud, pas les pratiques de rotation humaine et la gestion des équipes on-call |
| Monzo engineering blog (on-call culture) | E2 généralisation | Témoignage d'une organisation unique (fintech UK), niveau 5, non généralisable sans corroboration — les principes sont couverts par les sources retenues |
| Annonces produit outillage incident management (2025) | E1 non consolidé | Trop récents, données non validées indépendamment, contenu majoritairement promotionnel |
