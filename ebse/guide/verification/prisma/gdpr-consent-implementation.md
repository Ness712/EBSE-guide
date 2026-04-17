# PRISMA Flow — PICOC gdpr-consent-implementation

**Date de recherche** : 2026-04-17
**Bases interrogées** : EUR-Lex (RGPD), CNIL (recommandations officielles), OWASP, IAB Europe, WebSearch général
**Mots-clés Agent A** : "GDPR consent technical implementation CMP banner", "CNIL recommandation cookies consentement 2022", "GDPR Article 17 right to erasure implementation API", "consent management platform technical requirements", "GDPR data retention policy automated deletion"
**Mots-clés Agent B** : "RGPD droit effacement endpoint API cascade delete", "IAB TCF transparency consent framework v2.2", "OWASP privacy cheat sheet data retention consent", "CNIL dark patterns banniere consentement refus", "GDPR Article 15 data access export structured"
**Protocole** : methodology.md v3.0 §2.1 — double extraction indépendante (Agents A + B, mots-clés différents) + synthèse Agent C

---

## Flux

```
IDENTIFICATION
  Sources identifiées par base (Agent A + Agent B combinés, avant déduplication) :
    - Textes normatifs UE (EUR-Lex — RGPD) : ~5 résultats candidats
    - Autorités de régulation (CNIL, ICO, AEPD) : ~12 résultats candidats
    - OWASP (Privacy Cheat Sheet, Top 10 Privacy Risks) : ~5 résultats candidats
    - IAB Europe (TCF) : ~4 résultats candidats
    - CMP vendors documentation (Axeptio, Didomi, OneTrust, klaro) : ~10 résultats candidats
    - Articles légaux et techniques (IAPP, jurisprudence CNIL) : ~8 résultats candidats
    - Snowballing backward : ~4 sources
  Total identifié (brut, combiné A+B) : ~48
  Doublons retirés (même source identifiée par A et B) : 5 (RGPD, CNIL recommandation cookies, OWASP Privacy, IAB TCF, CNIL retention)
  Total après déduplication : ~43

SCREENING (titre + résumé)
  Sources screenées : ~43
  Sources exclues au screening : ~30
    - E1 (blog juridique sans référence normative) : ~10
    - E2 (hors scope PICOC — RGPD RH, RGPD B2B, hors consentement technique) : ~8
    - E3 (doublons partiels — couverts par CNIL/RGPD primaires) : ~7
    - E4 (CMP vendor marketing sans substance technique) : ~5

ELIGIBILITÉ (lecture complète)
  Sources évaluées en détail : ~13
  Sources exclues après lecture complète : ~8
    - Hors scope PICOC strict (RGPD organisationnel/contractuel, pas implémentation technique) : 4
    - Redondance forte avec CNIL recommandation sans apport différencié : 2
    - Autre régulation nationale sans portée UE directement applicable : 2

INCLUSION
  Sources incluses dans la synthèse : 5
    - Niveau 1 : 3 (RGPD Art.7+17, CNIL recommandation cookies 2022, CNIL recommandation retention 2020)
    - Niveau 2 : 1 (OWASP Privacy Cheat Sheet 2023)
    - Niveau 3 : 1 (IAB Europe TCF v2.2 2023)

  Sources exclues avec raison documentée : 8
    - ICO (UK) Guide to GDPR : hors scope post-Brexit pour applications UE
    - AEPD (Espagne) guidelines : couvert par RGPD + CNIL pour le contexte français
    - OneTrust documentation : niveau 3 vendor redondant avec IAB TCF
    - Axeptio / Didomi documentation : niveau 3 vendor redondant avec IAB TCF
    - CJUE — Planet49 (2019) : jurisprudence importante mais couvert par CNIL recommandation
    - CJUE — Orange Romania (2020) : jurisprudence couvert par Art.7 RGPD
    - IAPP articles consentement : niveau 5 redondant avec CNIL recommandations
    - DPA fines database (GDPR Enforcement Tracker) : données amendes, pas guidance implémentation
```

---

## Documentation recherche (Table 2 Kitchenham)

### Agent A — bases interrogées

| Élément | Valeur |
|---------|--------|
| Bases | EUR-Lex, CNIL, OWASP, WebSearch général |
| Mots-clés | "GDPR consent technical implementation CMP banner", "CNIL recommandation cookies consentement 2022", "GDPR Article 17 right to erasure implementation API", "GDPR data retention policy automated deletion" |
| Période couverte | 2016-2024 |
| Sources identifiées | ~25 |
| Sources retenues | 4 |
| Date d'extraction | 2026-04-17 |

### Agent B — bases interrogées

| Élément | Valeur |
|---------|--------|
| Bases | EUR-Lex, CNIL, OWASP, IAB Europe, CMP vendors |
| Mots-clés | "RGPD droit effacement endpoint API cascade delete", "IAB TCF transparency consent framework v2.2", "OWASP privacy cheat sheet data retention consent", "CNIL dark patterns banniere consentement refus" |
| Période couverte | 2016-2024 |
| Sources identifiées | ~23 |
| Sources retenues | 5 (convergence élevée avec A + IAB TCF en plus) |
| Date d'extraction | 2026-04-17 |

---

## Sources exclues — raisons documentées

| Source | Raison exclusion |
|--------|-----------------|
| ICO (UK) Guide to GDPR | Hors scope — autorité de régulation post-Brexit. Applicable au Royaume-Uni uniquement, pas à l'UE |
| AEPD guidelines (Espagne) | Couvert par RGPD + CNIL. Le principe cible les applications UE/France |
| OneTrust documentation | Niveau 3 vendor redondant avec IAB TCF v2.2 qui définit le standard inter-CMP |
| Axeptio / Didomi documentation | Même raison — vendor redondant avec IAB TCF, biais commercial |
| CJUE — Planet49 (2019) | Jurisprudence couvert par CNIL recommandation cookies 2022 (qui intègre Planet49) |
| CJUE — Orange Romania (2020) | Jurisprudence couvert par Art.7 RGPD (conditions du consentement) |
| IAPP articles consentement | Niveau 5 redondant avec CNIL recommandations officielles |
| GDPR Enforcement Tracker | Données d'amendes, pas guidance d'implémentation technique |
