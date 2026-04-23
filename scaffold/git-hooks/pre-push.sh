#!/bin/sh
# Git hook pre-push — quality gates avant push
# S'execute pour TOUT acteur (humain, agent, script CI local)
# Installation : .husky/pre-push (Node.js) ou .git/hooks/pre-push
#
# Recoit en argument : $1=remote, $2=url
# Stdin : "<local-ref> <local-sha1> <remote-ref> <remote-sha1>"

REMOTE="$1"
REPO_ROOT=$(git rev-parse --show-toplevel 2>/dev/null || pwd)

PM="npm"
[ -f "$REPO_ROOT/pnpm-lock.yaml" ] && PM="pnpm"
[ -f "$REPO_ROOT/yarn.lock" ] && PM="yarn"

# Branche courante
BRANCH=$(git rev-parse --abbrev-ref HEAD 2>/dev/null || echo "")
IS_PROTECTED=false
echo "$BRANCH" | grep -qE '^(main|staging|master)$' && IS_PROTECTED=true

# ============================================================
# Ne pas bloquer sur suppression de branche distante
# ============================================================
while read local_ref local_sha remote_ref remote_sha; do
  [ "$local_sha" = "0000000000000000000000000000000000000000" ] && exit 0
done

# ============================================================
# [CONFIGURER: tests unitaires]
# Node.js : (cd "$REPO_ROOT" && $PM test --run 2>&1 | tail -10) || { echo "Tests FAILED" >&2; exit 1; }
# Maven   : (cd "$REPO_ROOT" && mvn test -q) || exit 1
# Go      : go test ./... || exit 1
# ============================================================

# ============================================================
# Dependency audit
# ============================================================
if [ -f "$REPO_ROOT/package.json" ]; then
  echo "[pre-push] Audit dependances..."
  (cd "$REPO_ROOT" && $PM audit --audit-level=high 2>&1 | tail -5) || {
    echo "ERREUR: vulnerabilites critiques detectees — corriger avant push" >&2
    exit 1
  }
fi

# ============================================================
# Docker build --check si Dockerfile ou docker-compose modifie
# ============================================================
BASE=$(git rev-parse "origin/$BRANCH" 2>/dev/null || git rev-parse "HEAD~1" 2>/dev/null || echo "HEAD~1")
CHANGED=$(git diff --name-only "$BASE" HEAD 2>/dev/null || true)
if echo "$CHANGED" | grep -qE '(Dockerfile|docker-compose.*\.yml)'; then
  DOCKERFILE=$(find "$REPO_ROOT" -name "Dockerfile" -maxdepth 3 | head -1)
  if [ -n "$DOCKERFILE" ] && command -v docker >/dev/null 2>&1; then
    echo "[pre-push] Docker build --check..."
    docker build --check -f "$DOCKERFILE" "$(dirname "$DOCKERFILE")" 2>&1 | tail -5 || {
      echo "ERREUR: docker build --check FAILED" >&2
      exit 1
    }
  fi
fi

# ============================================================
# [CONFIGURER: checks supplementaires par projet]
# License check  : (cd "$REPO_ROOT" && npx --yes license-checker --failOn "GPL;AGPL" --summary 2>&1 | tail -5) || exit 1
# CI status      : gh run list --limit 1 --json conclusion -q '.[0].conclusion' == "failure" → exit 1 si $IS_PROTECTED
# SonarQube gate : curl quality gate API → exit 1 si ERROR et $IS_PROTECTED
# .env validation: comparer .env vs .env.example (cles manquantes → exit 1)
# ============================================================

echo "[pre-push] OK"
exit 0
