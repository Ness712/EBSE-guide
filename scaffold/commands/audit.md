# /audit — Audit complet de projet

Audit exhaustif ligne par ligne : chaque fichier du projet lu intégralement et vérifié contre toutes les sources applicables.
Méthodologie : `audit-sources.md` (GRADE 5/9) + `project-health-audit.md` (GRADE 3/7).

---

## Configuration projet (à renseigner avant exécution)

```
RECOMMENDATIONS : [CONFIGURER: chemin vers <project>-recommendations.json]
CATALOG         : [CONFIGURER: chemin vers ebse-scaffold/ebse/guide/data/sources-catalog.json]
MANIFEST        : [CONFIGURER: chemin vers audit-sources-manifest.md du projet]
REPOS           : [CONFIGURER: liste des repos à auditer]
```

---

## Étape 1 — Charger les sources (AVANT d'ouvrir le projet)

1. Lire `RECOMMENDATIONS → applicable_sources` → liste des IDs Tier 1 et Tier 2
2. Pour chaque ID Tier 1 : lire `CATALOG` → URL officielle + critères
3. Pour chaque ID Tier 2 : lire `CATALOG → what_to_check`
4. Lire chaque fichier Tier 3 (CONVENTIONS.md) listé dans `MANIFEST` → extraire toutes les règles
5. Lire chaque fichier Tier 4 (architecture docs) listé dans `MANIFEST` → extraire toutes les contraintes auditables
6. Documenter l'inventaire complet — c'est la grille de vérification pour toutes les étapes suivantes

```
INVENTAIRE SOURCES :
  Recos EBSE     : <project>-recommendations.json — N critères
  Tier 1 normes  : [IDs + critères clés]
  Tier 2 outils  : [IDs + what_to_check]
  Tier 3         : [règles extraites par CONVENTIONS.md]
  Tier 4         : [contraintes extraites par doc architecture]
```

---

## Étape 2 — Énumération exhaustive des fichiers

Pour chaque repo listé dans `REPOS`, récupérer la liste complète des fichiers trackés :

```bash
git -C <repo> ls-files | grep -v node_modules | grep -v .git | sort
```

Exclure uniquement : `node_modules/`, `.git/`, fichiers binaires (images, fonts, archives).
**Ne pas filtrer par extension ou pattern** — tous les fichiers sont inclus.

Lister tous les répertoires du projet (un niveau de profondeur significatif) :

```bash
git -C <repo> ls-files | grep -v node_modules | xargs -I{} dirname {} | sort -u
```

Un agent par répertoire. Les fichiers à la racine d'un repo (tsconfig.json, package.json, main.ts, etc.) forment un répertoire "racine" traité par un agent dédié.

```
RÉPERTOIRES ÉNUMÉRÉS :
  OLS-backend  : src/auth/, src/users/, src/messages/, prisma/, … → K agents
  OLS-frontend : src/features/auth/, src/features/lab/, src/components/, … → K agents
  OLS-infrastructure : / (racine), … → K agents
  Total : K agents
```

---

## Étape 3 — Lecture exhaustive par répertoire (agents en parallèle)

Spawner un agent par répertoire. Chaque agent :

1. **Lit chaque fichier de son répertoire en entier** (pas de grep, pas de résumé — lecture complète ligne par ligne)
2. **Vérifie chaque ligne** contre la grille complète de l'étape 1 :
   - Recommandations EBSE applicables au type de fichier
   - Critères Tier 1 (OWASP pour auth/API, WCAG pour composants UI, RGPD pour modèles de données…)
   - `what_to_check` Tier 2 pour les fichiers de config
   - Règles Tier 3 (CONVENTIONS.md) pour tous les fichiers de code
   - Contraintes Tier 4 pour les fichiers d'architecture
3. **Produit un finding par écart** au format standard

Prompt de chaque agent :
```
Audit exhaustif — répertoire [CHEMIN] — repo [NOM].
Tu n'as pas participé à la construction de ce code. Contexte frais, sois critique.

Grille de vérification (lire avant d'ouvrir les fichiers) :
- Recommandations EBSE : [recos pertinentes extraites de l'étape 1]
- Tier 1 : [critères normes applicables à ce type de répertoire]
- Tier 2 : [what_to_check pour les outils présents dans ce répertoire]
- Tier 3 : [règles CONVENTIONS.md]
- Tier 4 : [contraintes architecture]

Fichiers à auditer (lire chaque fichier en entier, ligne par ligne) :
[liste de tous les fichiers du répertoire]

Pour chaque fichier :
  - Lire intégralement
  - Identifier chaque écart avec la grille
  - Produire un finding par écart (format standard ci-dessous)
  - Citer la source explicite pour chaque finding

Format finding :
**[LABEL] Titre court**
- Sévérité : CRITIQUE | MAJEUR | MINEUR | INFO
- Fichier : chemin/vers/fichier.ts:42
- Source : reco#<id> | OWASP ASVS X.Y.Z | WCAG 2.2 SC X.X.X | CONVENTIONS.md §X | modules.md
- Problème : description précise
- Correction : action applicable immédiatement
```

---

## Étape 4 — Consolidation

1. Collecter tous les findings de tous les agents
2. Dédupliquer (même fichier:ligne signalé par plusieurs agents)
3. Classer par sévérité : CRITIQUE > MAJEUR > MINEUR > INFO

### Classement et issues

- **CRITIQUE** : issue GitHub individuelle, bloquant release
- **MAJEUR** : issue GitHub individuelle, à traiter dans le sprint
- **MINEUR** : groupés en une issue "Lot MINEUR [date]"
- **INFO** : rapport uniquement, pas d'issue

### Rapport final

```
REPOS AUDITÉS : [liste]
RÉPERTOIRES AUDITÉS : K (exhaustif — 0 répertoire ignoré, 0 fichier ignoré)
SOURCES VÉRIFIÉES :
  Recos EBSE : N critères
  Tier 1 : [normes appliquées]
  Tier 2 : [outils vérifiés]
  Tier 3 : [CONVENTIONS.md — N règles]
  Tier 4 : [docs architecture — N contraintes]
FINDINGS : N CRITIQUE, N MAJEUR, N MINEUR, N INFO
CORRECTIONS AUTONOMES : [fichier:ligne corrigé directement]
À TRAITER PAR PO : [findings nécessitant décision humaine]
STATUT GLOBAL : OK / KO
```

---

## Références

- Guide sources : `ebse-scaffold/ebse/guide/02-domains/project/audit-sources.md`
- Guide structure : `ebse-scaffold/ebse/guide/02-domains/project/project-health-audit.md`
- Catalogue sources : `ebse-scaffold/ebse/guide/data/sources-catalog.json`
