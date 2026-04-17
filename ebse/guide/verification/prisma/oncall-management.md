# PRISMA Flow — PICOC oncall-management

**Date de recherche** : 2026-04-17
**Bases interrogées** : Google SRE site (sre.google), O'Reilly SRE literature, incident.io blog/guides, Rootly guides, PagerDuty resources, WebSearch général SRE practices
**Mots-clés Agent A** : "on-call rotation best practices SRE", "incident severity levels taxonomy", "alert fatigue reduction pager load", "on-call burnout engineer rotation schedule", "psychological safety on-call SRE", "blameless post-mortem incident management"
**Mots-clés Agent B** : "SRE on-call handoff structured meeting", "incident management severity SEV1 SEV2 response time", "alert categorization actionable noise informational", "Google SRE on-call maximum incidents shift", "on-call escalation path procedures", "Seeking SRE psychological safety rotation"
**Protocole** : methodology.md v3.0 §2.1 — double extraction indépendante (Agents A + B, mots-clés différents) + synthèse Agent C

---

## Flux

```
IDENTIFICATION
  Sources identifiées par base (Agent A + Agent B combinés, avant déduplication) :
    - Littérature SRE de référence (Google SRE Book/Workbook, Seeking SRE, Site Reliability Engineering) : ~6 résultats candidats
    - Guides pratiques outillage incident management (incident.io, Rootly, PagerDuty, OpsGenie) : ~14 résultats candidats
    - Articles académiques / conférences (USENIX SREcon, ACM) : ~7 résultats candidats
    - Blog posts experts SRE (Charity Majors, Liz Fong-Jones, etc.) : ~10 résultats candidats
    - Snowballing backward (références citées par sources principales) : ~5 sources
  Total identifié (brut, combiné A+B) : ~42
  Doublons retirés (même source identifiée par A et B) : 4 (Google SRE Workbook, incident.io guide, Rootly guide, Seeking SRE ch.27)
  Total après déduplication : ~38

SCREENING (titre + résumé)
  Sources screenées : ~38
  Sources exclues au screening : ~26
    - E1 (blog opinion sans données ou méthodologie) : ~10
    - E2 (hors scope PICOC — incident post-mortem uniquement, pas rotation on-call) : ~6
    - E3 (doublons partiels — couverts par sources primaires déjà incluses) : ~5
    - E4 (vendeur / marketing sans substance technique) : ~5

ELIGIBILITÉ (lecture complète)
  Sources évaluées en détail : ~12
  Sources exclues après lecture complète : ~8
    - Hors scope PICOC strict (alerting sans traitement de la rotation ni de la charge) : 3
    - Niveau de preuve insuffisant (témoignage individuel sans données, pas de généralisation) : 2
    - Redondance forte avec Google SRE Workbook sans apport supplémentaire : 2
    - Trop récent et non consolidé (annonce produit 2025 sans données validées) : 1

INCLUSION
  Sources incluses dans la synthèse : 4
    - Niveau 3 : 2 (Google SRE Workbook, incident.io guide)
    - Niveau 4 : 1 (Rootly practical guide)
    - Niveau 5 : 1 (Seeking SRE ch.27 — David Blank-Edelman ed., O'Reilly)

  Sources exclues avec raison documentée : 8
    - Google SRE Book (original, 2016) : couvert et mis à jour par le SRE Workbook (2018), plus opérationnel
    - PagerDuty "Incident Management in the Age of DevOps" : redondance forte avec incident.io sans données supplémentaires
    - Atlassian incident management guides : marketing produit Jira/Opsgenie, pas de données indépendantes
    - SREcon proceedings (3 talks) : apports fragmentés absorbés par les sources retenues
    - Charity Majors blog posts (2020-2023) : niv.5 redondant avec Seeking SRE, moins structuré
    - "The Site Reliability Workbook" chapitre alerting (Beyer et al.) : couvert par Google SRE Workbook
    - AWS Well-Architected reliability pillar : hors scope (infrastructure, pas rotation humaine)
    - Monzo engineering blog (on-call culture) : niv.5 témoignage unique, pas généralisable
```

---

## Documentation recherche (Table 2 Kitchenham)

### Agent A — bases interrogées

| Élément | Valeur |
|---------|--------|
| Bases | sre.google, O'Reilly SRE literature, incident.io, PagerDuty resources, WebSearch général |
| Mots-clés | "on-call rotation best practices SRE", "incident severity levels taxonomy", "alert fatigue reduction pager load", "on-call burnout engineer rotation schedule", "psychological safety on-call SRE", "blameless post-mortem incident management" |
| Période couverte | 2016-2026 |
| Sources identifiées | ~22 |
| Sources retenues | 4 |
| Date d'extraction | 2026-04-17 |

### Agent B — bases interrogées

| Élément | Valeur |
|---------|--------|
| Bases | sre.google, O'Reilly SRE literature, Rootly guides, incident.io, WebSearch SRE practices |
| Mots-clés | "SRE on-call handoff structured meeting", "incident management severity SEV1 SEV2 response time", "alert categorization actionable noise informational", "Google SRE on-call maximum incidents shift", "on-call escalation path procedures", "Seeking SRE psychological safety rotation" |
| Période couverte | 2016-2026 |
| Sources identifiées | ~20 |
| Sources retenues | 4 (convergence complète avec A) |
| Date d'extraction | 2026-04-17 |

---

## Sources exclues — raisons documentées

| Source | Raison exclusion |
|--------|-----------------|
| Google SRE Book original (Beyer et al., 2016) | Supplanté par le SRE Workbook (2018), plus opérationnel sur le on-call, couvre les mêmes principes en version mise à jour |
| PagerDuty "Incident Management in the Age of DevOps" | Redondance forte avec incident.io guide sans apport quantitatif ou qualitatif supplémentaire identifiable |
| Atlassian incident management guides | Marketing produit (Jira/Opsgenie) sans données indépendantes ; les principes sont absorbés par Google SRE Workbook et incident.io |
| SREcon USENIX proceedings (3 talks) | Apports fragmentés et partiels, absorbés par les sources de synthèse retenues (Google SRE Workbook, Seeking SRE) |
| Charity Majors blog posts (2020-2023) | Niveau 5 redondant avec Seeking SRE, format moins structuré, pas de données quantitatives propres |
| AWS Well-Architected Framework — Reliability Pillar | Hors scope PICOC : traite la fiabilité infrastructure, pas la rotation humaine et la gestion des équipes on-call |
| Monzo engineering blog (on-call culture) | Témoignage unique d'une organisation, niveau 5, non généralisable sans données corroborantes supplémentaires |
| Annonces produit outillage incident management (2025) | Trop récents, non consolidés, pas de données validées indépendamment |
