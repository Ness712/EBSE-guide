# Double Extraction — PICOC runbooks

**Date** : 2026-04-17
**Protocole** : methodology.md v3.0
**Agent A** : mots-clés : "SRE runbook incident response on-call procedures", "SLO alerting on-call engineer response", "eliminating toil automation SRE", "postmortem culture blameless SRE", "incident management escalation procedures"
**Agent B** : mots-clés : "runbook structure operational procedures", "postmortem follow-up actions runbook", "toil pager alert repetitive manual work", "SRE on-call diagnosis mitigation escalation", "Atlassian runbook what is incident management"

---

## PICOC

```
P  = Équipes SRE/DevOps gérant des services en production avec astreintes
I  = Créer des runbooks opérationnels structurés pour la résolution des incidents
C  = Procédures informelles (oral, Slack), connaissance tribale, héroïsme individuel
O  = MTTR réduit, toil réduit, onboarding on-call facilité
Co = Applications web déployées avec Docker/GitHub Actions (toute stack)
```

---

## Accord Reviewer A / Reviewer B

### Sources évaluées par les deux reviewers

| # | Source | Niveau A | Niveau B | Accord inclusion ? | Note divergence |
|---|--------|---------|---------|:-----------------:|-----------------|
| 1 | SRE Book ch.11 "Being On-Call" (Beyer et al., 2016) | 3 | 3 | ✓ | — |
| 2 | SRE Workbook ch.8 "On-Call" (Cook et al., 2018) | 3 | 3 | ✓ | — |
| 3 | SRE Book ch.5 "Eliminating Toil" (Rau, 2016) | 3 | 3 | ✓ | — |
| 4 | SRE Book ch.15 "Postmortem Culture" (Lunney & Lueder, 2016) | non trouvé | 3 | ✗ A / ✓ B | **Divergence inclusion** |
| 5 | SRE Workbook ch.5 "Alerting on SLOs" (2018) | 3 | non trouvé | ✓ A / ✗ B | **Divergence inclusion** |
| 6 | Atlassian "What is a runbook?" (2024) | non trouvé | 4 | ✗ A / ✓ B | **Divergence inclusion** |

**Sources identifiées par A uniquement** : SRE Workbook ch.5 "Alerting on SLOs" (lien SLO → déclencheur runbook)
**Sources identifiées par B uniquement** : SRE Book ch.15 "Postmortem Culture" (lien postmortem → runbook) + Atlassian "What is a runbook?" (structure minimale)

**Accord sur inclusion des sources communes** : 3/3 → kappa = 1.0 (inclusion).
**Désaccords d'inclusion** : 3/6 → SRE Workbook ch.5 (A seulement), SRE Book ch.15 (B seulement), Atlassian (B seulement).

### Résolution des divergences

**SRE Workbook ch.5 "Alerting on SLOs" (A seulement, niveau 3)** : inclus. Seule source établissant explicitement le couplage SLO → déclencheur de procédure d'incident. La règle "un runbook par symptôme SLO observable" repose directement sur ce chapitre. Non trouvé par B car ses mots-clés ciblaient la structure des runbooks plutôt que le lien avec les SLOs.

**SRE Book ch.15 "Postmortem Culture" (B seulement, niveau 3)** : inclus. Documente le mécanisme postmortem → follow-up actions → runbook qui constitue la boucle d'amélioration continue. Complémentaire au ch.11 (procédures pendant l'incident) en couvrant l'après-incident. Non trouvé par A car ses mots-clés ciblaient "on-call" et "incident management" sans couvrir explicitement "postmortem".

**Atlassian "What is a runbook?" (B seulement, niveau 4)** : inclus. Seule source apportant la structure minimale prescriptive de façon explicite et opérationnelle. Convergente avec le SRE Book sur les critères de qualité, mais plus directement actionnable sur le format. Niveau 4 acceptable car Atlassian est l'éditeur d'outils ITSM de référence (Jira, Opsgenie) avec une expertise pratique reconnue. Non trouvé par A car ses mots-clés étaient orientés SRE académique plutôt que praticien.

**Décision de convergence** : les 3 sources A-only et B-only sont complémentaires et non redondantes. Toutes incluses — accord atteint en session de résolution.

---

## Calcul GRADE final

```
Score de départ : 2
  (source la plus haute = niveau 3 : SRE Book / SRE Workbook — livres d'experts)

+ 1 convergence
  SRE Book (ch.11, ch.15, ch.5) + SRE Workbook (ch.8, ch.5) convergent
  sans contradiction sur les mêmes principes :
  - Runbooks actionnables, testés, versionnés, propriétarisés.
  - Couplage alerte SLO → procédure d'incident.
  - Postmortem blameless comme moteur d'amélioration des runbooks.
  - Automatisation progressive du toil (docs → script → automation).
  Atlassian (niveau 4) converge sur la structure minimale et les critères
  de qualité, depuis un corpus praticien indépendant du corpus Google SRE.
  2 corpus distincts (Google SRE + Atlassian ITSM) sans contradiction.

+ 1 effet documenté
  SRE Book ch.11 : réduction MTTR par procédures claires et escalade définie.
  SRE Book ch.5 : réduction du toil par automatisation progressive des
  procédures répétitives (handling pager alerts = toil par définition).
  SRE Book ch.15 : amélioration continue mesurable (follow-up actions
  postmortem → réduction récurrence incidents).
  Atlassian : réduction du temps de résolution par standardisation.
  Effets multiples et distincts documentés : MTTR, toil, onboarding,
  récurrence incidents.

Score final : 2 + 1 + 1 = 4 → [RECOMMANDE]
```

Note biais de publication : sources Google SRE (niveaux 3) — livres d'experts avec fort biais prescriptif vers les pratiques Google. Atténué par la convergence avec Atlassian (praticien indépendant) et par le fait que les principes décrits (documentation, test, versioning, couplage alerte) sont universellement applicables indépendamment de l'échelle Google. Atlassian (niveau 4) — biais commercial possible (vente d'Opsgenie/JSM), mais le contenu sur la structure des runbooks est prescriptif et non lié à un produit spécifique.

---

## Analyse de sensibilité {#analyse-de-sensibilite}

| Source retirée | Score sans | Niveau sans | Changement ? |
|---------------|-----------|------------|:------------:|
| SRE Book ch.11 (Beyer 2016) | 4 (SRE Workbook ch.8 couvre le même sujet, convergence maintenue) | [RECOMMANDE] | NON |
| SRE Workbook ch.8 (Cook 2018) | 4 (SRE Book ch.11 couvre le même sujet, convergence maintenue) | [RECOMMANDE] | NON |
| SRE Book ch.5 Eliminating Toil | 3 (principe d'automatisation progressive sans fondement fort — score départ 2 + convergence partielle) | [BONNE PRATIQUE] | OUI — l'automatisation progressive perd son ancrage normatif |
| SRE Book ch.15 Postmortem Culture | 4 (lien postmortem→runbook moins documenté mais reste dans convergence SRE générale) | [RECOMMANDE] | NON |
| SRE Workbook ch.5 Alerting on SLOs | 4 (lien SLO→déclencheur moins documenté mais reste dans convergence) | [RECOMMANDE] | NON |
| Atlassian 2024 | 4 (structure minimale moins prescriptive mais SRE Book ch.11 la couvre partiellement) | [RECOMMANDE] | NON |
| Toutes sources SRE Workbook simultanément | 3 (SRE Book seul, convergence réduite à un seul corpus) | [BONNE PRATIQUE] | OUI |

**Conclusion : MODEREMENT ROBUSTE** — recommandation [RECOMMANDE] stable pour tout retrait individuel sauf SRE Book ch.5 "Eliminating Toil" (fondement du niveau 3 d'automatisation). Le retrait simultané des deux chapitres SRE Workbook ramènerait à [BONNE PRATIQUE]. Ces scénarios sont peu probables : le SRE Book (O'Reilly/Google, 2016) est une référence établie et largement citée dans la communauté SRE. La robustesse est inférieure à [STANDARD] car les sources sont toutes de niveau 3 ou 4 (absence de revues systématiques ou études empiriques contrôlées sur les runbooks spécifiquement).

---

## Sources exclues

| Source | Critère | Raison |
|--------|---------|--------|
| PagerDuty "Runbook Automation" (blog, 2023) | E1 | Blog commercial avec biais produit (vente de PagerDuty). Contenu absorbé par SRE Book ch.5 sur l'automatisation et Atlassian sur la structure. |
| VictorOps/Splunk "What is a runbook" (blog, 2022) | E1 | Blog commercial concurrent d'Atlassian. Redondant avec Atlassian 2024, moins précis sur la structure. |
| Google Cloud — "Incident Response" documentation | E3 | Documentation produit Google Cloud Operations. Absorbée par SRE Book/Workbook qui couvrent les mêmes principes sans biais produit. |
| ITIL 4 — Incident Management practice | E2 | ITIL 4 couvre la gestion des incidents mais à un niveau d'abstraction organisationnel (ITSM) sans guidance opérationnelle sur la structure des runbooks. Hors scope PICOC qui cible les équipes SRE/DevOps avec astreintes techniques. |
| Humble et al. — Continuous Delivery (2010) | E2 | Couvre les pipelines de déploiement mais pas spécifiquement les runbooks d'incident. Référence pertinente pour d'autres PICOCs (CI/CD) mais hors scope ici. |
| Blogs "how to write a runbook" (multiples) | E1 | Sources sans peer review ni référence documentée. Contenu absorbé par Atlassian 2024 et SRE Book. |
