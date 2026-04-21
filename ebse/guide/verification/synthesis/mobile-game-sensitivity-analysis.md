# Sensitivity Analysis — SLR `mobile-game-2d`

**Protocole** : methodology.md §2.6 — variation systématique des hypothèses transverses pour tester la robustesse des recommandations.
**Scope** : 37 PICOCs du domaine `mobile-game-2d`.

## Variations testées

Chaque recommandation primaire est testée contre 7 variations du pilot P :

- **V1** : team_size solo → team 2-5 (VSE élargi)
- **V2** : Android+iOS → Android-only
- **V3** : offline-first → online-first
- **V4** : 2D pixel-art → 2D illustré (vector style)
- **V5** : F2P+IAP → Premium paid upfront
- **V6** : portrait → landscape-primary
- **V7** : budget open-source → budget saas-ok

## Robustesse par PICOC

| PICOC | Robustesse globale | Variations qui changent la reco |
|-------|:------------------:|---------------------------------|
| A1 Engine | HAUTE | V4 (pixel-art → illustré) déclasse Godot au profit de Flame ou Unity |
| A4' Determinism | TRÈS HAUTE | Aucune |
| A6 Input/a11y | TRÈS HAUTE | Aucune |
| A7 Persistence | MOYENNE | V3 (online-first) change : PocketBase #1 devient Supabase |
| A8 Asset pipeline | HAUTE | V4 change : vector assets → Rive ou Lottie |
| B7-B11 Asset tooling | HAUTE sur scope pixel-art | V4 rend B11 Aseprite non-applicable |
| C12-C15 Persistence | HAUTE | V3 (online-first) simplifie C15 (integrity platform-side) |
| D17-D21 Publishing | TRÈS HAUTE | Aucune (réglementaire) |
| E22 Ads | MOYENNE | V5 (premium) fait disparaître E22 entièrement |
| E23 IAP | MOYENNE | V5 simplifie IAP à one-shot non-consumable ; V7 ajoute RevenueCat au ranking |
| E24 Monetization model | Variable | C'est la variation elle-même |
| E25 Receipt validation | HAUTE | V3 simplifie (pas besoin de cache signed offline) |
| F26-F29 Social | HAUTE | V3 change F26 reco vers custom aggregator cross-platform |
| G30-G32 Localization | HAUTE | Aucune |
| H33-H37 DevOps | HAUTE | V7 fait monter cloud paid (Sentry Team, Supabase Pro) dans le ranking |
| I37 Test methodology | MOYENNE | V1 (équipe 2-5) ajoute playtesting protocols + code review gates |
| I39 Accessibility | HAUTE | Distribution EU → EAA 2025 rend Intermediate tier obligatoire |
| J43 AI asset gate | HAUTE | Variation "pas d'AI assets" désactive complètement le PICOC |

## Variations critiques pour `mobile-game-2d`

**Les 3 variations les plus déstabilisantes** pour le stack recommandé :

1. **V4 : pixel-art → illustré** — change l'engine (Godot → possiblement Flame/Unity) + les outils assets (Aseprite → Figma/Rive). Refactor significatif.
2. **V3 : offline-first → online-first** — change A7 (persistence), E25 (receipt validation), C15 (save integrity). Plusieurs PICOCs impactés.
3. **V5 : F2P → Premium** — disparition de E22, E22b, E25 simplifié, E24 bascule.

**Variations bénignes** :
- V1 team_size (impacte seulement I37 et processus)
- V2 Android-only (simplification mais stack mobile-cross reste fonctionnel)
- V6 orientation (impacte A8 asset pipeline resolutions + UX layout, pas le stack technique)

## Implications pour le stack recommandé

Le stack `godot-mobile-game-2d` est **robuste pour le pilot P défini** (solo indie + 2D pixel-art + offline-first + F2P+IAP + budget open-source + Android+iOS).

Les 3 points de fragilité (V3, V4, V5) correspondent à des **changements fondamentaux de produit**. Si l'un de ces paramètres change après l'adoption du stack, une re-exécution du guide est nécessaire plutôt qu'un ajustement marginal.

Les variations de transverses moins structurantes (V1, V2, V6, V7) n'invalident pas la stack — elles ajustent les choix sur quelques PICOCs sans refactor architectural.
