# PRISMA Flow — PICOC runbooks

**Date de recherche** : 2026-04-17
**Bases interrogées** : Google SRE Book (sre.google / O'Reilly), Google SRE Workbook (sre.google / O'Reilly), Atlassian Incident Management, PagerDuty blog, VictorOps/Splunk blog, Google Cloud documentation, ITIL 4, WebSearch général
**Mots-clés Agent A** : "SRE runbook incident response on-call procedures", "SLO alerting on-call engineer response", "eliminating toil automation SRE", "postmortem culture blameless SRE", "incident management escalation procedures"
**Mots-clés Agent B** : "runbook structure operational procedures", "postmortem follow-up actions runbook", "toil pager alert repetitive manual work", "SRE on-call diagnosis mitigation escalation", "Atlassian runbook what is incident management"
**Protocole** : methodology.md v3.0 §2.1 — double extraction indépendante (Agents A + B, mots-clés différents) + synthèse Agent C

---

## Flux

```
IDENTIFICATION
  Sources identifiées par base (Agent A + Agent B combinés, avant déduplication) :
    - SRE Book / SRE Workbook (O'Reilly / Google) : ~8 chapitres candidats
    - Atlassian Incident Management (runbooks, postmortem, on-call) : ~5 résultats candidats
    - PagerDuty blog (runbooks, incident response) : ~6 résultats candidats
    - VictorOps/Splunk blog : ~4 résultats candidats
    - Google Cloud Operations documentation : ~5 résultats candidats
    - ITIL 4 (incident management practice) : ~3 résultats candidats
    - Articles académiques / empiriques (IEEE, ACM) sur runbooks ou incident response : ~4 résultats candidats
    - Snowballing backward (références citées par SRE Book) : ~6 sources
  Total identifié (brut, combiné A+B) : ~41
  Doublons retirés (même source identifiée par A et B) : 3 (SRE Book ch.11, SRE Workbook ch.8, SRE Book ch.5)
  Total après déduplication : ~38

SCREENING (titre + résumé)
  Sources screenées : ~38
  Sources exclues au screening : ~26
    - E1 (blog commercial sans données, biais produit) : ~12
    - E2 (hors scope PICOC — incident management organisationnel sans guidance runbook opérationnelle) : ~6
    - E3 (doublons partiels — couverts par sources primaires déjà incluses) : ~5
    - E4 (documentation produit avec biais commercial marqué) : ~3

ELIGIBILITÉ (lecture complète)
  Sources évaluées en détail : ~12
  Sources exclues après lecture complète : ~6
    - Hors scope PICOC strict (CI/CD ou monitoring sans lien runbook) : 2
    - Niveau de preuve insuffisant (blog opinion, pas de structure documentée) : 2
    - Redondance forte avec SRE Book sans apport supplémentaire : 2

INCLUSION
  Sources incluses dans la synthèse : 6
    - Niveau 3 : 5 (SRE Book ch.11, SRE Book ch.15, SRE Book ch.5, SRE Workbook ch.8, SRE Workbook ch.5)
    - Niveau 4 : 1 (Atlassian "What is a runbook?" 2024)

  Sources exclues avec raison documentée : 6
    - PagerDuty "Runbook Automation" blog 2023 : biais commercial, absorbé par SRE ch.5
    - VictorOps/Splunk blog 2022 : redondant avec Atlassian 2024, moins précis
    - Google Cloud "Incident Response" docs : absorbé par SRE Book/Workbook sans biais produit
    - ITIL 4 Incident Management : niveau d'abstraction ITSM hors scope technique SRE/DevOps
    - Humble et al. Continuous Delivery 2010 : pertinent CI/CD, hors scope runbooks incident
    - Articles académiques IEEE/ACM sur incident response : génériques, pas de guidance runbook structurée
```

---

## Documentation recherche (Table 2 Kitchenham)

### Agent A — bases interrogées

| Élément | Valeur |
|---------|--------|
| Bases | Google SRE Book (sre.google), Google SRE Workbook, PagerDuty blog, Google Cloud docs, WebSearch général |
| Mots-clés | "SRE runbook incident response on-call procedures", "SLO alerting on-call engineer response", "eliminating toil automation SRE", "postmortem culture blameless SRE", "incident management escalation procedures" |
| Période couverte | 2016-2024 |
| Sources identifiées | ~22 |
| Sources retenues | 4 (SRE Book ch.11, ch.5, SRE Workbook ch.8, ch.5) |
| Date d'extraction | 2026-04-17 |

### Agent B — bases interrogées

| Élément | Valeur |
|---------|--------|
| Bases | Google SRE Book (sre.google), Atlassian Incident Management, VictorOps/Splunk blog, PagerDuty blog, ITIL 4, WebSearch |
| Mots-clés | "runbook structure operational procedures", "postmortem follow-up actions runbook", "toil pager alert repetitive manual work", "SRE on-call diagnosis mitigation escalation", "Atlassian runbook what is incident management" |
| Période couverte | 2016-2024 |
| Sources identifiées | ~19 |
| Sources retenues | 4 (SRE Book ch.15, ch.5, SRE Workbook ch.8, Atlassian 2024) |
| Date d'extraction | 2026-04-17 |

---

## Sources exclues — raisons documentées

| Source | Raison exclusion |
|--------|-----------------|
| PagerDuty "Runbook Automation" blog (2023) | Biais commercial (vente PagerDuty). Contenu sur l'automatisation absorbé par SRE Book ch.5 "Eliminating Toil" avec plus de rigueur et sans biais produit |
| VictorOps/Splunk "What is a runbook" blog (2022) | Redondant avec Atlassian 2024 sur la structure, moins précis. Biais commercial concurrent |
| Google Cloud — "Incident Response" documentation | Documentation produit Google Cloud Operations. Absorbée par SRE Book/Workbook (même corpus Google, sans biais produit spécifique) |
| ITIL 4 — Incident Management practice | Niveau d'abstraction ITSM organisationnel — ne fournit pas de guidance opérationnelle sur la structure des runbooks techniques. Hors scope PICOC (équipes SRE/DevOps avec astreintes techniques) |
| Humble J. & Farley D. — Continuous Delivery (2010) | Référence CI/CD pertinente pour d'autres PICOCs. Ne traite pas des runbooks d'incident opérationnel. Hors scope |
| Articles académiques IEEE/ACM sur "incident response" (≥4 sources) | Génériques (cybersécurité, ITIL) ou trop empiriques sans guidance prescriptive sur la structure des runbooks. Aucun ne couvre le PICOC spécifique SRE runbooks opérationnels |
