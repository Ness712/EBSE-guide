# Double Extraction — PICOC gdpr-consent-implementation

**Date** : 2026-04-17
**Protocole** : methodology.md v3.0
**Agent A** : mots-clés : "GDPR consent technical implementation CMP banner", "CNIL recommandation cookies consentement 2022", "GDPR Article 17 right to erasure implementation API", "consent management platform technical requirements", "GDPR data retention policy automated deletion"
**Agent B** : mots-clés : "RGPD droit effacement endpoint API cascade delete", "IAB TCF transparency consent framework v2.2", "OWASP privacy cheat sheet data retention consent", "CNIL dark patterns banniere consentement refus", "GDPR Article 15 data access export structured"

---

## PICOC

```
P  = Équipes de développement d'applications web traitant des données personnelles UE
I  = Implémenter techniquement le consentement CNIL/GDPR :
     CMP conforme, bannière, right-to-erasure, droit d'accès, retention policy
C  = Absence d'implémentation ou implémentation non conforme (case pré-cochée,
     refus difficile, pas d'endpoint d'effacement)
O  = Conformité légale RGPD, confiance utilisateur, évitement des amendes CNIL
Co = Applications web (NestJS backend, React frontend) avec données utilisateurs UE
```

---

## Accord Reviewer A / Reviewer B

### Sources évaluées par les deux reviewers

| # | Source | Niveau A | Niveau B | Accord inclusion ? | Note divergence |
|---|--------|---------|---------|:-----------------:|-----------------|
| 1 | RGPD Art.7 (consentement) + Art.17 (effacement) + Art.15 (accès) — EUR-Lex 2016 | 1 | 1 | ✓ | — |
| 2 | CNIL — Recommandation relative aux cookies et autres traceurs (2022) | 1 | 1 | ✓ | — |
| 3 | OWASP Privacy Cheat Sheet (2023) | 2 | 2 | ✓ | — |
| 4 | IAB Europe — TCF v2.2 (2023) | 3 | 3 | ✓ | — |
| 5 | CNIL — Recommandation durées de conservation (2020) | 1 | 1 | ✓ | — |
| 6 | ICO (UK) Guide to GDPR | hors scope | hors scope | ✗ | **Accord exclusion** — post-Brexit, hors UE |
| 7 | OneTrust / Axeptio documentation | 3 | 3 | ✗ | **Accord exclusion** — vendor redondant avec IAB TCF |
| 8 | CJUE Planet49 (2019) | absorbé | absorbé | ✗ | **Accord exclusion** — couvert par CNIL recommandation |

**Sources identifiées par A uniquement** : aucune (convergence complète)
**Sources identifiées par B uniquement** : aucune (convergence complète)

**Accord sur inclusion des sources communes** : 5/5 → kappa ≈ 1.0 (inclusion)
**Désaccords d'inclusion** : 0/8 → accord complet A et B

### Résolution des divergences

Aucune divergence d'inclusion. Les deux agents A et B ont identifié les mêmes 5 sources à inclure avec le même niveau de preuve. Convergence parfaite sur l'ensemble du corpus.

---

## Calcul GRADE final

```
Score de départ : 4
  (source la plus haute = niveau 1 : RGPD Art.7+17+15 (EUR-Lex),
   CNIL Recommandation cookies 2022, CNIL Recommandation retention 2020 —
   trois sources normatives de niveau 1 indépendantes)

+ 1 convergence
  RGPD Art.7+17+15 (niveau 1) + CNIL cookies 2022 (niveau 1) + CNIL retention 2020 (niveau 1)
  + OWASP Privacy Cheat Sheet (niveau 2) + IAB TCF v2.2 (niveau 3)
  convergent sans contradiction sur :
  - Consentement libre, spécifique, éclairé, univoque — pas de case pré-cochée
  - Refus aussi simple que l'acceptation (dark patterns interdits)
  - Right-to-erasure : cascade sur toutes les tables, délai 30 jours
  - Retention définie par catégorie : logs 12 mois, comptes inactifs 36 mois
  5 sources indépendantes de 4 organisations (UE, CNIL, OWASP, IAB Europe)

- 0 nuance empirique (pas de malus)
  Les sources sont cohérentes. L'IAB TCF définit les specs techniques
  en accord avec les recommandations CNIL (pas de contradiction).

Score final : 4 + 1 = 5 → [STANDARD]
```

Note biais de publication : RGPD est un texte légal non soumis au biais de publication. CNIL recommandations : autorité de régulation officielle, non soumise au biais de publication. OWASP Privacy Cheat Sheet : revue communautaire. IAB TCF : standard d'industrie — biais possible vers les intérêts de l'industrie publicitaire, atténué par la conformité démontrée avec RGPD et CNIL recommandations.

---

## Analyse de sensibilité {#analyse-de-sensibilite}

| Source retirée | Score sans | Niveau sans | Changement ? |
|---------------|-----------|------------|:------------:|
| RGPD Art.7+17+15 (EUR-Lex) | 4+1=5 (deux sources CNIL niveau 1 restent, convergence OWASP+IAB) | [STANDARD] | NON |
| CNIL Recommandation cookies 2022 | 4+1=5 (RGPD niveau 1 + CNIL retention niveau 1, convergence OWASP+IAB) | [STANDARD] | NON |
| CNIL Recommandation retention 2020 | 4+1=5 (RGPD + CNIL cookies niveau 1, convergence OWASP+IAB) | [STANDARD] | NON |
| OWASP Privacy Cheat Sheet | 4+1=5 (trois sources niveau 1 restent, convergence IAB) | [STANDARD] | NON |
| IAB Europe TCF v2.2 | 4+1=5 (trois sources niveau 1 restent, convergence OWASP) | [STANDARD] | NON |
| Toutes sources niveau 1 simultanément | impossible (3 sources niveau 1 indépendantes, retrait simultané irréaliste) | — | N/A |

**Conclusion : ROBUSTE** — recommandation [STANDARD] stable pour tout retrait individuel. Aucun scénario de déclassement réaliste. Trois sources normatives de niveau 1 indépendantes (RGPD, CNIL cookies, CNIL retention) convergent sans contradiction, ce qui rend la recommandation particulièrement solide. La robustesse est renforcée par le caractère légalement contraignant des sources (RGPD = règlement UE d'application directe, CNIL = autorité de contrôle habilitée à sanctionner).

---

## Sources exclues

| Source | Critère | Raison |
|--------|---------|--------|
| ICO (UK) Guide to GDPR | E2 | Hors scope géographique — autorité post-Brexit. Les applications UE/France relèvent de la CNIL |
| AEPD guidelines (Espagne) | E2 | Redondant avec RGPD + CNIL pour le contexte français. Pas d'apport différencié |
| OneTrust documentation | E3/E4 | Niveau 3 vendor avec biais commercial. Couvert par IAB TCF v2.2 qui définit le standard inter-CMP |
| Axeptio / Didomi documentation | E3/E4 | Même raison — vendor documentation redondante avec IAB TCF |
| CJUE — Planet49 (2019) | E3 | Jurisprudence importante mais intégralement absorbée par CNIL Recommandation cookies 2022 |
| CJUE — Orange Romania (2020) | E3 | Couvert par Art.7 RGPD (conditions du consentement). Pas d'apport au-delà du texte normatif |
| IAPP articles consentement | E1/E3 | Niveau 5 redondant avec les recommandations officielles CNIL |
| GDPR Enforcement Tracker | E2 | Données d'amendes — hors scope PICOC. Utile pour la motivation mais pas la guidance technique |
