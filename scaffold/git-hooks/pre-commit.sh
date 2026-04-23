#!/bin/sh
# Git hook pre-commit — quality gates universelles
# S'execute pour TOUT acteur (humain, agent, script CI local)
# Installation : .husky/pre-commit (Node.js) ou .git/hooks/pre-commit
#
# Usage husky :
#   pnpm add -D husky lint-staged
#   pnpm exec husky init
#   echo 'sh scripts/git-hooks/pre-commit.sh' > .husky/pre-commit

REPO_ROOT=$(git rev-parse --show-toplevel 2>/dev/null || pwd)
STAGED=$(git diff --cached --name-only 2>/dev/null)
[ -z "$STAGED" ] && exit 0

PM="npm"
[ -f "$REPO_ROOT/pnpm-lock.yaml" ] && PM="pnpm"
[ -f "$REPO_ROOT/yarn.lock" ] && PM="yarn"

# ============================================================
# Gate : fichiers .env stagés (secrets potentiels)
# ============================================================
ENV_STAGED=$(echo "$STAGED" | grep -E '(^|/)\.env($|\.)' | grep -v '\.env\.example$' || true)
if [ -n "$ENV_STAGED" ]; then
  echo "ERREUR: Fichier .env stage — risque de commit de secrets :" >&2
  echo "$ENV_STAGED" | sed 's/^/  /' >&2
  exit 1
fi

# ============================================================
# Gate : CLAUDE.local.md (ne doit jamais etre commite)
# ============================================================
if echo "$STAGED" | grep -q 'CLAUDE.local.md'; then
  echo "ERREUR: CLAUDE.local.md ne doit jamais etre commite" >&2
  exit 1
fi

# ============================================================
# Gate : secrets en clair dans le diff
# ============================================================
SECRETS=$(git diff --cached -U0 2>/dev/null \
  | grep '^+' | grep -v '^\+\+\+' \
  | grep -iE "(password|api_key|apikey|secret_key|secret|access_token|auth_token|private_key|client_secret)\s*[=:]\s*['\"][^'\"]{8,}" \
  || true)
if [ -n "$SECRETS" ]; then
  echo "ERREUR: Secret potentiel detecte dans le diff :" >&2
  echo "$SECRETS" | head -5 | sed 's/^/  /' >&2
  echo "Utiliser des variables d'environnement." >&2
  exit 1
fi

# ============================================================
# Conventions code (binaires, verifiables automatiquement)
# ============================================================
while IFS= read -r f; do
  [ -z "$f" ] && continue
  # eslint-disable sans justification " -- " interdit
  if git show ":$f" 2>/dev/null | grep -E "eslint-disable" | grep -qvE ' -- '; then
    echo "ERREUR: eslint-disable sans justification dans $f" >&2
    echo "Format : // eslint-disable-next-line <rule> -- <raison>" >&2
    exit 1
  fi
  # @SuppressWarnings / noqa / noinspection interdits
  if git show ":$f" 2>/dev/null | grep -qE "@SuppressWarnings|# noqa|// noinspection"; then
    echo "ERREUR: suppression de warning dans $f — corriger a la source" >&2
    exit 1
  fi
  # Marqueurs @deprecated / TODO laisses interdits
  if git show ":$f" 2>/dev/null | grep -qE "@deprecated|// TODO: remove|TODO.*FIXME"; then
    echo "ERREUR: marqueur deprecated/TODO laisse dans $f" >&2
    exit 1
  fi
done <<EOF
$STAGED
EOF

# ============================================================
# [CONFIGURER: lint + typecheck par stack]
# Node.js backend  : (cd "$REPO_ROOT" && $PM run lint --quiet && $PM run type:check) || exit 1
# Node.js frontend : (cd "$REPO_ROOT" && $PM run lint --quiet && $PM run format:check && $PM run type:check) || exit 1
# Maven/Java       : (cd "$REPO_ROOT" && mvn checkstyle:check -q) || exit 1
# Go               : gofmt -l . | grep . && exit 1; go vet ./...
# ============================================================

exit 0
