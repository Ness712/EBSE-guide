# /sweep — Sweep projet

État du projet, découverte systématique 5 dimensions + exécution + vérification boucle.
Source : scaffold `[MANDATORY]` section "Protocole tâches sweep" (PICOC #25 + SWEBOK v4 ch.9).

---

## Configuration projet (à renseigner dans CLAUDE.md projet)

```
REPOS             : [CONFIGURER: liste des repos à couvrir]
BRANCHE_STAGING   : [CONFIGURER: ex. staging]

# Commandes par dimension
CMD_SOURCE_PRS    : [CONFIGURER: ex. gh pr list --state open --repo org/repo]
CMD_SOURCE_ISSUES : [CONFIGURER: ex. gh issue list --state open --repo org/repo]
CMD_SOURCE_GIT    : [CONFIGURER: ex. git branch -r && git worktree list]
CMD_CICD          : [CONFIGURER: ex. gh run list --limit 5]
CMD_INFRA         : [CONFIGURER: ex. df -h && docker system df]
CMD_QUALITE       : [CONFIGURER: ex. sonarqube qualitygates API]
CMD_MONITORING    : [CONFIGURER: ex. sentry/glitchtip issues API]
```

---

## Phase 1 — Découverte systématique (AVANT toute exécution)

Exécuter les commandes configurées pour les 5 dimensions :

| Dimension | Ce qu'on cherche |
|-----------|-----------------|
| **Source control** | PRs ouvertes, issues ouvertes, branches stale, worktrees orphelins |
| **CI/CD** | Pipelines échoués récents |
| **Infrastructure** | Ressources (disk, containers) |
| **Qualité** | Quality gates statiques (FAILED / WARNING) |
| **Monitoring** | Erreurs runtime non résolues, alertes actives |

→ Consolider en liste priorisée, puis enchaîner directement sur la Phase 2 sans attendre le PO.

---

## Phase 2 — Exécution

Traiter chaque item identifié en Phase 1.

**Branche cible** : `BRANCHE_STAGING` (jamais la branche de production — gate PO incompatible avec exécution autonome).

---

## Phase 3 — Vérification (boucle obligatoire)

Re-jouer Phase 1 en entier.

→ Si nouveaux items détectés : les traiter et re-vérifier (répéter Phase 2 → Phase 3).
→ **Déclarer "done" uniquement quand la découverte revient vide** — pas quand la liste initiale est épuisée.

**Critère de "done"** : état du système (0 item critique ouvert sur toutes les dimensions), pas l'exhaustion de la liste initiale. Des items peuvent apparaître pendant l'exécution (CI qui échoue, issue créée entre-temps, repo oublié).

`Source : MAST failure modes "Incomplete Verification" 9.1% (PICOC #25) + SWEBOK v4 ch.9 acceptance criteria`
