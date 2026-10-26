#!/usr/bin/env bash
set -eu

export PATH="/usr/local/bin:/usr/bin:/bin:$PATH"
export GIT_TERMINAL_PROMPT=0

REPO="$(cd "$(dirname "$0")/.." && pwd)"
STATE="$HOME/.deployed-commit"
cd "$REPO"

echo "$(date '+%Y-%m-%d %H:%M:%S') Checking for deployments..."
git fetch --quiet origin main

NEW="$(git rev-parse origin/main)"
OLD="$(cat "$STATE" 2>/dev/null || true)"

if [ "$NEW" = "$OLD" ]; then
  echo "up to date at $NEW"
  exit 0
fi

echo "Deploying new commit $NEW..."
echo "$NEW" > "$STATE"
echo "Deployment successful."
