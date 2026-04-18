# Plan d'application BSAF + SDMF

**Objectif global :** Rendre le scaffold OLS exhaustif et auditable en appliquant les trois méthodologies EBSE validées.

**Fondement :** PICOC `ai-agent-scaffold-methodology` — GRADE 5 CONFIRME (SLR 2026-04-17, 3 phases, 40 sources)

---

## Rappel des rôles

| Méthodologie | Rôle |
|---|---|
| EBSE | Dit QUOI mettre dans les règles (décisions sourcées) |
| SDMF | Dit COMMENT trouver TOUTES les règles nécessaires (exhaustivité) |
| BSAF | Dit COMMENT structurer, valider et auditer ces règles (fiabilité) |

---

## Plan 1 — BSAF : Classifier le scaffold existant

**Objectif :** Structurer `scaffold-claude.md` selon Mandatory/Required/Advisory. Identifier les règles Mandatory sans hook (gaps d'implémentation).

**Étapes :**
1. Lire `scaffold-claude.md` intégralement
2. Pour chaque règle : attribuer un niveau BSAF
   - **Mandatory** : règle absolue — doit être implémentée par un hook déterministe (pas de dérogation possible)
   - **Required** : règle importante — CLAUDE.md, dérogation via Deviation Record signé PO
   - **Advisory** : recommandation — CLAUDE.md, dérogation sans formalité
3. Vérifier la correspondance implémentation → niveau (hook existant pour chaque Mandatory ?)
4. Identifier les Mandatory sans hook → liste de gaps d'implémentation
5. Produire une Compliance Matrix

**Output :**
- `scaffold-claude.md` avec annotations de niveau par règle
- `ebse-scaffold/scaffold/compliance-matrix.md` : tableau règle | niveau | implémentation | source PICOC | statut (OK / GAP)

**Mode d'exécution :** Direct dans le chat (lecture + édition scaffold)
**Durée estimée :** 1-2h

---

## Plan 2 — SDMF : Trouver les règles manquantes dans le scaffold

**Objectif :** Appliquer les 6 phases SDMF sur le scaffold actuel pour détecter les angles morts — règles absentes, dimensions non couvertes.

### Phase 1 — ODD (Operational Design Domain)
**Question :** Dans quels contextes l'agent OLS opère-t-il ?
**Méthode :** Construire une taxonomie hiérarchique fermée de tous les contextes (type de tâche, état du repo, présence PO, permissions disponibles, phase projet, criticité du chemin modifié...)
**Critère d'inclusion :** une dimension est incluse si sa variation peut créer un risque
**Output :** Liste exhaustive des contextes d'opération

### Phase 2 — FMEA (Failure Mode and Effects Analysis)
**Question :** Pour chaque capacité de l'agent, quels sont tous les modes de défaillance possibles ?
**Méthode :** Boundary Diagram (périmètre de l'agent) + P-Diagram (entrées/sorties/bruits) + décomposition par capacité
- Capacités à couvrir : écriture fichiers, exécution bash, appels API, création PR/commit/push, communication PO, déploiement, lecture codebase, modification infra...
- Pour chaque capacité : lister tous les modes de défaillance (comportements erronés possibles)
- Prioritiser par RPN (Severity × Occurrence × Detection)
**Output :** Tableau capacité | mode de défaillance | effet | règle scaffold existante | gap (oui/non)

### Phase 3 — KAOS (Obstacle Analysis)
**Question :** Pour chaque objectif Mandatory du scaffold, quelles conditions pourraient le violer ?
**Méthode :** Pour chaque objectif G : identifier formellement tous les obstacles O tels que Dom ∪ {O} ⊨ ¬G. Vérifier la domain-completeness.
**Output :** Liste d'obstacles non couverts par les règles actuelles → nouveaux candidats règles

### Phase 4 — STRIDE + Misuse Cases
**Question :** Quels comportements interdits manquent dans le scaffold ?
**Méthode :**
- STRIDE : appliquer les 6 catégories (Spoofing, Tampering, Repudiation, Information Disclosure, DoS, Elevation of Privilege) à chaque composant du flux agent OLS
- Misuse Cases : pour chaque use case de l'agent, dériver le misuse case correspondant
**Output :** Matrice STRIDE + liste de misuse cases non couverts

### Phase 5 — Kassab RE Completeness
**Question :** Le scaffold est-il complet selon les 4 dimensions RE ?
**Méthode :** Vérifier :
- Syntaxique : tous les templates/sections obligatoires sont remplis ?
- Sémantique : toutes les entités du domaine (PO, staging, main, hooks, secrets...) sont référencées ?
- Comportementale : toutes les transitions d'état de l'agent sont spécifiées ?
- Couverture : tous les scénarios critiques sont tracés vers une règle ?
**Output :** Liste de lacunes par dimension

### Phase 6 — Meta-synthèse AI Risk Repository
**Question :** Quels sous-domaines de risque du MIT AI Risk Repository ne sont pas couverts par le scaffold ?
**Méthode :** Comparer le scaffold contre les 23 sous-domaines (7 domaines : Discrimination, Vie privée, Désinformation, Acteurs malveillants, IHM, Socio-économique, Sécurité système IA)
**Référence :** Slattery et al. arXiv:2408.12622 — couverture moyenne frameworks ad hoc = 34%
**Output :** Taux de couverture + sous-domaines non couverts

**Mode d'exécution :** 6 sous-agents en parallèle (un par phase) + synthèse Agent C
**Durée estimée :** 3-4h

---

## Plan 3 — SDMF appliqué à EBSE : Trouver les domaines de décision manquants

**Objectif :** Les 231 décisions EBSE couvrent-elles exhaustivement tous les domaines techniques d'OLS ? Identifier les domaines sans PICOC.

**Étapes :**
1. FMEA sur les capacités techniques du projet OLS (pas de l'agent — de l'application) : auth, messaging temps-réel, storage, infra Docker, tests, observabilité, CI/CD, sécurité...
2. Pour chaque capacité : y a-t-il une décision EBSE dans `decisions/` ?
3. STRIDE sur l'architecture OLS → domaines de sécurité sans décision sourcée ?
4. Comparer contre `ols-recommendations.json` → choix faits sans décision EBSE de fond ?
5. Identifier les gaps → nouveaux SLRs à lancer

**Output :** Liste de domaines sans PICOC → priorisés par impact sur OLS
**Mode d'exécution :** 1 sous-agent (lecture `decisions/` + `ols-recommendations.json`) + synthèse ici
**Durée estimée :** 1-2h

---

## Statut d'avancement

| Étape | Statut | Output produit |
|-------|--------|----------------|
| Plan 1 — BSAF classification | ✅ FAIT | `scaffold/compliance-matrix.md` |
| Plan 1 — Annoter scaffold-claude.md avec niveaux BSAF | ⏳ À FAIRE | Ajouter tag `[MANDATORY]`/`[REQUIRED]`/`[ADVISORY]` sur chaque règle dans scaffold-claude.md (référence : compliance-matrix.md) |
| Plan 1 — Implémenter 6 hooks Mandatory manquants hookables | ✅ FAIT | `pre-commit-quality.sh` : gate migrations DB (schema.prisma + migrations/*.sql), gate secrets (.env*), gate CLAUDE.local.md repos production, warning chemins critiques. `pre-push-quality.sh` : Docker build --check (Dockerfile/docker-compose modifiés), license check (GPL/AGPL interdit). Compliance matrix mise à jour : 17/24 Mandatory hookés. |
| Plan 1 — Étudier hook gate architecture (signal faible) | ⏳ À FAIRE | Gate "changements d'architecture" — détection dans pre-pr : scanner mots-clés (nouveau service, changement stack, restructuration) dans body PR + fichiers modifiés (docker-compose, infra/**). Signal faible → évaluer faux positifs avant d'activer |
| Plan 1 — Traiter les 4 Mandatory non-hookables | ⏳ À FAIRE | Pour chaque règle non-hookable (non-invention, non-masquage échec, sous-agent CLAUDE.md en premier, ne pas bypasser gates) : (a) tester le wording actuel sur 5+ reformulations sémantiquement équivalentes (PICOC ai-agent-instruction-compliance — risque -61.8% sur reformulations) ; (b) si compliance < 100% → reformuler et re-tester ; (c) documenter le Deviation Risk résiduel dans compliance-matrix.md ; (d) vérifier que les mécanismes compensatoires sont en place (reviewer indépendant, audit pre-release, audit-tool-use.sh) |
| Plan 2 — SDMF sur scaffold (6 phases) | ⏳ À FAIRE | gaps → nouveaux PICOCs ou règles |
| Plan 3 — SDMF sur EBSE (domaines manquants) | ⏳ À FAIRE | domaines sans PICOC → nouveaux SLRs |
| Mettre à jour scaffold-claude.md ligne 724 (GRADE 3 → GRADE 5) | ⏳ À FAIRE | scaffold-claude.md |

---

## Ordre d'exécution recommandé

```
Plan 1 (BSAF)     → base structurée, rapide
     ↓
Plan 2 (SDMF scaffold)  → gaps dans les règles
     ↓
Plan 3 (SDMF EBSE)      → gaps dans les décisions techniques
```

Les gaps trouvés en Plan 2 et 3 alimentent soit un nouveau PICOC EBSE (si solution à sourcer), soit une règle directe dans le scaffold (si évidence déjà dans les sources existantes).

---

**Mécanisme de feedback continu (gap identifié, non encore résolu) :**
L'agent ne loggue pas actuellement quelle règle il a appliquée ni quand aucune règle ne s'applique. Ce gap sera capturé formellement en Phase 3 KAOS (Plan 2) et nécessitera probablement un nouveau PICOC EBSE.
