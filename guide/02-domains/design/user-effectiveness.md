# Mesure de l'efficacite utilisateur

*Derive de ISO 25019:2023 — Effectiveness, Efficiency, Satisfaction*

**[BONNE PRATIQUE]** Mesurer si les utilisateurs atteignent leurs objectifs | Score GRADE : 3/7

## Pourquoi

Le guide couvre la qualite du PRODUIT (ISO 25010). Cette page couvre la qualite d'USAGE (ISO 25019) : est-ce que l'utilisateur reussit reellement ?

```
"Effectiveness: degree to which users achieve specified goals
 with accuracy and completeness."
 — ISO/IEC 25019:2023
```

## Metriques a suivre

| Metrique | Ce qu'elle mesure | Cible |
|----------|------------------|-------|
| Task success rate | % d'utilisateurs qui completent un flow critique | > 95% |
| Task completion time | Temps moyen pour accomplir un objectif | < budget defini |
| Error rate (user) | Nombre d'erreurs utilisateur par tache | En baisse |
| Satisfaction (SUS/CSAT) | Perception subjective de qualite | SUS > 68 |

## Outillage

```typescript
// Analytics — tracker les flows critiques
analytics.track('flow_completed', {
  flow: 'exercice_submission',
  duration_ms: Date.now() - startTime,
  success: true,
  steps_count: stepCount,
});

// Funnel analysis — identifier ou les utilisateurs abandonnent
// PostHog, Mixpanel, ou Plausible pour les funnels
```

## Usability testing

| Methode | Frequence | Source |
|---------|-----------|--------|
| Test utilisateur (5 users) | Par feature majeure | Nielsen & Landauer 1993 — approximation (p=0.31), conteste par Spool 2001. Utile comme heuristique, pas comme loi universelle. |
| Session recording (Hotjar, PostHog) | Continu | Analyse qualitative des frictions |
| SUS score | Trimestriel | System Usability Scale (Brooke 1996) |

## Decisions contextuelles (ISO 25019)

| Decision | Statut | Commentaire |
|----------|--------|-------------|
| Browser support | [CHOIX D'EQUIPE] | Definir une matrice (ex: 2 dernieres versions Chrome/Firefox/Safari) |
| Dark mode | [CHOIX D'EQUIPE] | `prefers-color-scheme` media query + theme toggle |
| Offline strategy | [CHOIX D'EQUIPE] | Web app educative : offline non critique |
| User preferences (theme, layout) | [CHOIX D'EQUIPE] | Stocker dans user profile (serveur) ou localStorage |

Sources : ISO 25019:2023 (niv. 1), Nielsen Norman Group — 5 users/85% issues (niv. 5), SUS (Brooke 1996, standard industriel) (niv. 5), PostHog/Mixpanel docs (niv. 3)
