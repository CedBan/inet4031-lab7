#!/usr/bin/env bash
set -eu
export PATH="/usr/local/bin:/usr/bin:/bin:$PATH"
export KUBECONFIG="${KUBECONFIG:-$HOME/.kube/config}"

BACKUP_DIR="$HOME/backups"
LATEST_BACKUP="$(ls -1t "$BACKUP_DIR"/db-*.dump 2>/dev/null | head -n 1)"

if [ -z "$LATEST_BACKUP" ]; then
    echo "ERROR: No backup files found in $BACKUP_DIR"
    exit 1
fi

echo "Restoring from $LATEST_BACKUP..."
kubectl exec -i deploy/db -- pg_restore -U postgres -d testdb --clean --if-exists < "$LATEST_BACKUP"
echo "Restore completed successfully."
