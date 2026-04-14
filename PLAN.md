# Plan de construction du guide EBSE

## Phase 1 — Structure du guide final
Definir le format que le lecteur verra :
- Partie 1 : Profils de stack (combinaisons completes par type de projet)
- Partie 2 : Recommandations par domaine (securite, design, testing, etc.)
- Partie 3 : Justifications detaillees (cases PICO/GRADE, pour verification)

Livrable : squelette du guide avec les sections vides.

## Phase 2 — Matrice de couverture
Croiser ISO 25010:2023 (~40 sous-caracteristiques) x SWEBOK v4 (18 knowledge areas).
Pour chaque case : active (= genere une decision technique) ou N/A (avec justification).
Double extraction : 2 reviewers independants determinent les cases actives.

Livrable : matrice avec ~100-150 cases actives identifiees.

## Phase 3 — Priorisation
Classer les cases actives par priorite :
- P1 : decisions que TOUT projet doit prendre (stack, securite, testing, CI/CD)
- P2 : decisions importantes (design, performance, monitoring)
- P3 : decisions avancees (scalabilite, accessibilite poussee, safety)

Livrable : liste ordonnee des cases a traiter.

## Phase 4 — Recherche systematique (par case)
Pour chaque case active, dans l'ordre de priorite :

1. Formuler la question PICO
2. Decouverte des alternatives (recherche dans les bases definies)
3. Collecte des preuves (formulaire d'extraction standardise)
4. **Double extraction** : 2 agents IA independants extraient les donnees
5. Comparaison des extractions, resolution des divergences
6. Evaluation GRADE (mecanique)
7. Recommandation avec niveau de confiance

Livrable : une case documentee par decision.

## Phase 5 — Compilation du guide
Transformer les cases en recommandations lisibles :
- Chaque case → 1 recommandation concise dans le guide (partie 2)
- Regrouper les recommandations interdependantes en profils de stack (partie 1)
- Lier chaque recommandation a sa case detaillee (partie 3)

Livrable : guide v1.0 complet.

## Phase 6 — Verification finale
- Relire le plan (PLAN.md) point par point, verifier que tout est fait
- Verifier que chaque recommandation a sa source verifiable
- Verifier que les profils de stack sont coherents (interdependances)
- Verifier la double extraction sur un echantillon de cases

Livrable : guide v1.0 verifie.

## Phase 7 — Maintenance
- Revue annuelle de toutes les recommandations
- Mise a jour quand une source majeure change (nouvelle enquete, nouveau standard)
- Versioning : ANNEE.MOIS (ex: 2026.04)
