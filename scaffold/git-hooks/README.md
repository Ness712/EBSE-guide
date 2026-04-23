# Git hooks — templates

Scripts `pre-commit.sh` et `pre-push.sh` : quality gates universelles.
S'executent pour tout acteur (humain, agent IA, script CI local).

## Installation Node.js (husky)

```bash
pnpm add -D husky lint-staged
pnpm exec husky init
```

Ajouter dans `package.json` :
```json
{
  "scripts": { "prepare": "husky" },
  "lint-staged": {
    "*.{ts,tsx}": ["eslint --fix --quiet", "prettier --write"],
    "*.{json,md,css}": ["prettier --write"]
  }
}
```

Copier les scripts dans un dossier commite (ex. `scripts/git-hooks/`) :
```bash
mkdir -p scripts/git-hooks
cp path/to/scaffold/git-hooks/pre-commit.sh scripts/git-hooks/
cp path/to/scaffold/git-hooks/pre-push.sh scripts/git-hooks/
```

Creer les hooks husky :
```bash
echo 'sh scripts/git-hooks/pre-commit.sh' > .husky/pre-commit
echo 'sh scripts/git-hooks/pre-push.sh "$@"' > .husky/pre-push
```

Remplir les sections `[CONFIGURER]` dans les scripts.

## Installation autre stack (natif)

```bash
cp pre-commit.sh .git/hooks/pre-commit
cp pre-push.sh .git/hooks/pre-push
chmod +x .git/hooks/pre-commit .git/hooks/pre-push
```

## Bypass exceptionnel

```bash
git commit --no-verify   # uniquement si gate fausse-positive documentee
git push --no-verify
```

Le CI reste la gate authoritative — le bypass local n'affecte pas le CI.
