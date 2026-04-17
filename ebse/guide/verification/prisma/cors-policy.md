# PRISMA Flow — PICOC cors-policy

**Date de recherche** : 2026-04-17
**Bases interrogées** : WHATWG/W3C standards, OWASP (WSTG, Cheat Sheets), MDN Web Docs, PortSwigger Web Security Academy, AppSecUSA proceedings, NestJS documentation, WebSearch général
**Mots-clés Agent A** : "CORS misconfiguration security", "Access-Control-Allow-Origin wildcard authenticated API", "CORS policy whitelist server-side", "CORS credentials wildcard incompatible", "CORS attack cross-origin data theft", "OWASP CORS testing CLNT-07"
**Mots-clés Agent B** : "CORS secure configuration backend", "cross-origin resource sharing vulnerabilities", "CORS null origin exploit", "NestJS CORS CorsOptions whitelist", "WHATWG Fetch standard CORS section", "Kettle CORS misconfigurations exploiting"
**Protocole** : methodology.md v3.0 §2.1 — double extraction indépendante (Agents A + B, mots-clés différents) + synthèse Agent C

---

## Flux

```
IDENTIFICATION
  Sources identifiées par base (Agent A + Agent B combinés, avant déduplication) :
    - Standards normatifs (WHATWG Fetch, W3C) : 2 résultats candidats
    - OWASP (WSTG, Cheat Sheets, ASVS) : ~6 résultats candidats
    - Documentation développeur (MDN, NestJS, Spring Security) : ~8 résultats candidats
    - Recherche sécurité offensive (PortSwigger, AppSecUSA, blog posts experts) : ~12 résultats candidats
    - Articles académiques / surveys : ~4 résultats candidats
    - Snowballing backward (références citées par sources principales) : ~5 sources
  Total identifié (brut, combiné A+B) : ~37
  Doublons retirés (même source identifiée par A et B) : 5 (WHATWG Fetch, OWASP WSTG CLNT-07, OWASP HTML5 Cheat Sheet, MDN CORS, Kettle 2016, PortSwigger WSA)
  Total après déduplication : ~32

SCREENING (titre + résumé)
  Sources screenées : ~32
  Sources exclues au screening : ~21
    - E1 (blog opinion sans données ou méthodologie) : ~8
    - E2 (hors scope PICOC — CORS général, pas configuration sécurisée serveur) : ~5
    - E3 (doublons partiels — couverts par sources primaires déjà incluses) : ~4
    - E4 (vendeur / marketing sans substance technique) : ~4

ELIGIBILITÉ (lecture complète)
  Sources évaluées en détail : ~11
  Sources exclues après lecture complète : ~4
    - Hors scope PICOC strict (CORS côté navigateur uniquement, pas configuration serveur) : 2
    - Niveau de preuve insuffisant (pure opinion, pas de données ni de référence à la spec) : 1
    - Redondance forte avec OWASP WSTG CLNT-07 sans apport supplémentaire : 1

INCLUSION
  Sources incluses dans la synthèse : 7
    - Niveau 1 : 1 (WHATWG Fetch Living Standard)
    - Niveau 2 : 2 (OWASP WSTG CLNT-07, OWASP HTML5 Security Cheat Sheet)
    - Niveau 3 : 2 (MDN Web Docs CORS, NestJS CORS documentation)
    - Niveau 5 : 2 (PortSwigger Web Security Academy, Kettle J. 2016)

  Sources exclues avec raison documentée : 4
    - OWASP ASVS V14 (CORS section) : couvert par WSTG CLNT-07 + Cheat Sheet, pas d'apport différencié
    - Spring Security CORS docs : hors scope du principe universel (variant stack)
    - RFC 6454 — The Web Origin Concept : absorbé par WHATWG Fetch Standard (plus récent et complet)
    - Surveys académiques CORS (3 articles arXiv) : indirects — mesurent prévalence des misconfigs mais n'apportent pas de guidance prescriptive supplémentaire
```

---

## Documentation recherche (Table 2 Kitchenham)

### Agent A — bases interrogées

| Élément | Valeur |
|---------|--------|
| Bases | WHATWG/W3C, OWASP, MDN, PortSwigger Web Security Academy, WebSearch général |
| Mots-clés | "CORS misconfiguration security", "Access-Control-Allow-Origin wildcard authenticated API", "CORS policy whitelist server-side", "CORS credentials wildcard incompatible", "OWASP CORS testing CLNT-07" |
| Période couverte | 2016-2024 |
| Sources identifiées | ~20 |
| Sources retenues | 6 |
| Date d'extraction | 2026-04-17 |

### Agent B — bases interrogées

| Élément | Valeur |
|---------|--------|
| Bases | WHATWG/W3C, OWASP, MDN, NestJS docs, AppSecUSA proceedings, WebSearch |
| Mots-clés | "CORS secure configuration backend", "cross-origin resource sharing vulnerabilities", "CORS null origin exploit", "NestJS CORS CorsOptions whitelist", "Kettle CORS misconfigurations exploiting" |
| Période couverte | 2016-2024 |
| Sources identifiées | ~17 |
| Sources retenues | 7 (convergence élevée avec A + NestJS docs en plus) |
| Date d'extraction | 2026-04-17 |

---

## Sources exclues — raisons documentées

| Source | Raison exclusion |
|--------|-----------------|
| OWASP ASVS V14 — CORS section | Redondance — couvert intégralement par WSTG CLNT-07 + HTML5 Cheat Sheet sans apport différencié |
| RFC 6454 — The Web Origin Concept (IETF, 2011) | Absorbé par WHATWG Fetch Living Standard (plus récent, plus complet, standard vivant) |
| Spring Security CORS documentation | Hors scope du principe universel — candidat pour variant java-spring-boot |
| arXiv surveys CORS misconfiguration prevalence | Mesurent la prévalence mais n'apportent pas de guidance prescriptive supplémentaire aux règles OWASP/WHATWG |
| Blog posts experts sécurité (≥4 sources) | Niveau 5 redondant — PortSwigger WSA + Kettle 2016 couvrent la même expertise offensive avec plus de rigueur |
