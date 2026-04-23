# Git hooks locaux (husky + lint-staged)

## Pourquoi c'est necessaire

Les quality gates CI/CD (GitHub Actions, SonarQube) constituent la source d'autorite finale, mais leur feedback arrive **apres le push** — trop tard pour un cycle de correction rapide. Les git hooks locaux interceptent les violations **avant** qu'elles entrent dans le repo, pour tout acteur (humain, agent IA, script).

```
"Build times under 10 minutes correlate with 4x higher deployment frequency."
 — DORA State of DevOps 2024
```

Feedback local < 10s vs CI < 10min vs review humaine > hours : les hooks locaux sont le niveau le plus rapide de la defense en profondeur.

**Distinction critique** : les git hooks s'executent pour **tout acteur** qui commite ou pousse (humain, agent IA, script CI local). Les hooks d'agent IA (ex. Claude Code `settings.json`) ne s'executent que pendant une session agent — ils ne remplacent pas les git hooks, ils s'ajoutent pour les interceptions specifiques a l'agent (audit log, contexte, variables de session).

---

## Node.js / TypeScript — Husky + lint-staged

**[RECOMMANDE]** **Husky** pour la gestion des git hooks | Score GRADE : 4/7

Husky est le standard de facto de l'ecosysteme Node.js pour installer et gerer les git hooks sans editer manuellement `.git/hooks/` (qui n'est pas commite). Utilise par React, Prettier, ESLint, NestJS et la majorite des projets open-source Node.js majeurs.

| Outil | Telechargements npm | Role |
|-------|--------------------|----|
| husky | ~5M/semaine | Installe et gere les git hooks |
| lint-staged | ~5M/semaine | Execute les linters uniquement sur les fichiers staged |

**lint-staged** est complementaire : plutot que de linter tout le repo a chaque commit, il cible uniquement les fichiers modifies — 10 a 100x plus rapide.

### Installation

```bash
pnpm add -D husky lint-staged
pnpm exec husky init
```

### Configuration `.husky/pre-commit`

```bash
#!/bin/sh
pnpm exec lint-staged
```

### Configuration `package.json`

```json
{
  "lint-staged": {
    "*.{ts,tsx}": [
      "eslint --fix --quiet",
      "prettier --write"
    ],
    "*.{json,md,css}": [
      "prettier --write"
    ]
  }
}
```

### Hook pre-push (tests + build)

```bash
# .husky/pre-push
#!/bin/sh
pnpm run type:check && pnpm test --run
```

> Regle : lint uniquement en pre-commit (< 5s) ; typecheck + tests en pre-push (accepte 30-60s avant push). Build complet en CI uniquement.

---

## Autres stacks

| Stack | Equivalent |
|-------|-----------|
| Java / Maven | Plugin `maven-enforcer` + Checkstyle dans `validate` phase |
| Go | `pre-commit` framework (Python) — `golangci-lint` hook |
| Python | `pre-commit` framework — pylint, black, mypy hooks |
| Universel | `pre-commit` framework (python) — supporte 100+ langages |

---

## Perimetre et limites

- Les hooks locaux peuvent etre **bypasses** par `git commit --no-verify` — le CI reste la gate authoritative
- Les hooks ne sont pas appliques aux commits faits directement sur GitHub.com
- Husky necessite que `pnpm install` (ou `npm install`) soit lance apres clonage pour s'installer — automatique si `prepare` est dans `package.json` :

```json
{
  "scripts": {
    "prepare": "husky"
  }
}
```

---

## Sources

- [niv. 3] git-scm.com — "Git Hooks" (documentation officielle, 2024)
- [niv. 3] Husky documentation — typicode.github.io/husky (2024)
- [niv. 3] lint-staged documentation — github.com/lint-staged/lint-staged (2024)
- [niv. 3] React (utilisateurs de husky) — github.com/facebook/react (2024)
- [niv. 3] Prettier (utilisateurs de husky) — github.com/prettier/prettier (2024)
- [niv. 4] DORA State of DevOps 2024 — fast feedback = 4x deployment frequency
- [niv. 4] npm trends — husky ~5M/sem, lint-staged ~5M/sem (2024)
