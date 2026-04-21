# Global Amendments — methodology.md

**Protocole de base** : `methodology.md` v3.0 (Kitchenham & Charters 2007, EBSE-2007-01)
**Portee** : amendements applicables au protocole global (tous domaines), par opposition aux amendements domaine-specifiques (voir `ai-collaboration-amendments.md`, `mobile-game-amendments.md`, etc.)

---

## Amendement G-1 — Correction du biais d'ancrage dans la table "Scope et plateformes" (§1.2)

**Date** : 2026-04-21
**Declencheur** : revue de scope pour la SLR `mobile-game` — le Product Owner (Gabriel) a identifie un biais d'ancrage dans la table §1.2 listant les plateformes non couvertes.

### Protocole original (§1.2 avant amendement G-1)

La table "Scope et plateformes" contenait, pour chaque plateforme "Pas couvert", une colonne "Prochaine etape" **pre-identifiant** des technologies candidates. Exemple :

```
| Mobile cross-platform | Pas couvert | Necessite EBSE : Flutter vs React Native vs KMP |
| Mobile natif Android  | Pas couvert | Necessite EBSE : Kotlin, Jetpack Compose, etc.  |
| Mobile natif iOS      | Pas couvert | Necessite EBSE : Swift, SwiftUI, etc.           |
| Desktop               | Pas couvert | Necessite EBSE : Electron vs Tauri              |
```

### Observation — biais detecte

Cette pre-identification viole directement la sous-procedure §1.3 "Decouverte des alternatives" du protocole :

> *"Avant de formuler le PICOC, identifier exhaustivement tous les outils/pratiques existants. Le C (comparaison) doit inclure TOUTES les alternatives trouvees par decouverte systematique."*

Lister "Flutter vs React Native vs KMP" **avant** la phase de decouverte systematique :

1. **Ancre le reviewer** sur 3 candidats — il peut omettre de chercher Ionic, NativeScript, Kotlin Multiplatform, .NET MAUI, Quasar, Expo, Capacitor, Tauri Mobile, Uno Platform, Avalonia Mobile, etc.
2. **Ancre le reviewer** sur une taxonomie ("cross-platform" vs "natif") qui presuppose la reponse (si les natifs gagnent sur certains P, la taxonomie pre-imposee du tableau devient invalide).
3. **Produit un selection bias** documente comme type de biais a eviter en §2.3 (Table 4 Kitchenham) : *"Systematic differences between baseline characteristics of the groups that are compared"*.
4. **Couvre le cas "app"** mais omet le cas "jeu" — qui a un P radicalement different (game loop, asset pipeline, frame budget, monetisation) et doit faire l'objet d'une SLR separee avec son propre scope.

### Amendement applique

1. **Reecriture de la colonne "Prochaine etape"** pour toutes les plateformes non couvertes :

   ```
   A couvrir par SLR dediee (scope + PICOC + alternatives a decouvrir systematiquement par §1.3)
   ```

2. **Ajout de lignes distinctes** pour les sous-domaines qui justifient un P distinct :
   - `Mobile game (2D/3D)` — P distinct de `Mobile natif Android`/`iOS`/`cross-platform` (game loop, assets, frame budget, monetisation specifiques aux jeux)
   - `Desktop game (2D/3D)` — P distinct de `Desktop app`

3. **Ajout d'une "Regle anti-biais"** explicite sous la table (§1.2) qui renvoie au present amendement.

### Application a toutes les SLRs futures

Pour toute nouvelle SLR de plateforme/domaine, la procedure est :

1. **Creer le fichier de scope** (`verification/commissioning/<domain>-scope.md`) **sans pre-identifier les alternatives** — seulement le P, les anchors (standards, SWEBOK KAs), les outcomes attendus, le contexte.
2. **Executer §1.3 Decouverte des alternatives** : recherche systematique dans toutes les bases applicables (npm, Maven Central, Cargo, GitHub topics, SO Survey, State of X, itch.io, App Store analytics, etc.).
3. **Documenter PRISMA** de la decouverte (identification → screening → eligibilite → inclusion).
4. **Formulation PICOC** avec `C = les alternatives qui survivent au screening` — pas un sous-ensemble arbitraire.

### Impact sur les SLRs existantes

- **Domaine `ai-collaboration`** : pas de revision requise. Son fichier de scope (`ai-collaboration-scope.md`) ne pre-identifiait pas d'alternatives — il listait 13 decisions candidates (processus/gouvernance), pas des outils pre-selectionnes. Le biais G-1 ne s'y applique pas.
- **Pages guide existantes `guide/01-stack-profiles/` et `guide/02-domains/`** : pas de revision requise. Leurs PICOCs avaient tous des C decouverts en §1.3, pas copies de la table §1.2.

### Approbation

**Status** : applique.
**Approuve par** : superviseur humain (Gabriel), 2026-04-21, conversation de commissioning mobile-game SLR.
**Reference** : methodology.md §1.2 modifie + regle anti-biais ajoutee en bas de table.

---

## Journal des amendements globaux

| # | Date | Titre | Type | Etat |
|---|------|-------|:----:|------|
| G-1 | 2026-04-21 | Correction du biais d'ancrage dans la table "Scope et plateformes" (§1.2) | Correction | Applique |
