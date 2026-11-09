#!/usr/bin/env bash
set -eu
export PATH="/usr/local/bin:/usr/bin:/bin:$PATH"
export KUBECONFIG="${KUBECONFIG:-$HOME/.kube/config}"

BACKUP_DIR="$HOME/backups"
mkdir -p -m 700 "$BACKUP_DIR"

TIMESTAMP="$(date +%Y%m%d-%H%M%S)"
DUMP_FILE="$BACKUP_DIR/db-$TIMESTAMP.dump"

if ! kubectl exec deploy/db -- pg_dump -U postgres -Fc testdb > "$DUMP_FILE"; then
    rm -f "$DUMP_FILE"
    echo "FAILED: pg_dump failed"
    exit 1
fi

if ! kubectl exec -i deploy/db -- pg_restore --list < "$DUMP_FILE" | grep -q ' TABLE DATA '; then
    rm -f "$DUMP_FILE"
    echo "SKIPPED: the database has no tables, so the existing backups are kept as they are."
    exit 0
fi

ls -1t "$BACKUP_DIR"/db-*.dump | tail -n +13 | xargs -r rm -f
echo "Backup successful: $DUMP_FILE"
