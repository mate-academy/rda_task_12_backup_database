#! /bin/bash
set -euo pipefail
if [[ -z "${DB_USER:-}" || -z "${DB_PASSWORD:-}" ]]; then
  echo "ERROR: DB_USER and DB_PASSWORD environment variables must be set." >&2
  exit 1
fi

DB_HOST="${DB_HOST:-localhost}"

MYSQL_OPTS="-h ${DB_HOST} -u ${DB_USER} -p${DB_PASSWORD}"
DUMP_OPTS="-h ${DB_HOST} -u ${DB_USER} -p${DB_PASSWORD}"

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Starting backup procedure..."
echo "[$(date '+%Y-%m-%d %H:%M:%S')] Step 1: Full backup of ShopDB → ShopDBReserve"

mysqldump ${DUMP_OPTS} \
  --single-transaction \
  --routines \
  --triggers \
  ShopDB \
| mysql ${MYSQL_OPTS} ShopDBReserve

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Step 1 complete: ShopDBReserve updated."
echo "[$(date '+%Y-%m-%d %H:%M:%S')] Step 2: Data-only backup of ShopDB → ShopDBDevelopment"

mysqldump ${DUMP_OPTS} \
  --single-transaction \
  --no-create-info \
  ShopDB \
| mysql ${MYSQL_OPTS} ShopDBDevelopment

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Step 2 complete: ShopDBDevelopment updated."
echo "[$(date '+%Y-%m-%d %H:%M:%S')] Backup procedure finished successfully."
