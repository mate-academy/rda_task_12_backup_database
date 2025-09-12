#!/bin/bash
set -euo pipefail

# Автоматичне видалення тимчасових файлів при виході
trap 'rm -f "$FULL_DUMP" "$DATA_DUMP"' EXIT
trap 'echo "[ERROR] Script failed at $(date)" >&2' ERR

# Перевірка змінних середовища
if [[ -z "${DB_USER:-}" ]]; then
  echo "Environment variable DB_USER is not set"
  exit 1
fi

if [[ -z "${DB_PASSWORD:-}" ]]; then
  echo "Environment variable DB_PASSWORD is not set"
  exit 1
fi

# Створення тимчасових файлів
FULL_DUMP=$(mktemp)
DATA_DUMP=$(mktemp)

echo "$(date) - Starting full backup from ShopDB..."
MYSQL_PWD="$DB_PASSWORD" mysqldump -u"$DB_USER" ShopDB \
  | sed '/^USE /d' > "$FULL_DUMP"

echo "$(date) - Restoring full backup to ShopDBReserve..."
MYSQL_PWD="$DB_PASSWORD" mysql -u"$DB_USER" ShopDBReserve < "$FULL_DUMP"

echo "$(date) - Starting data-only backup from ShopDB..."
MYSQL_PWD="$DB_PASSWORD" mysqldump -u"$DB_USER" --no-create-info --replace ShopDB \
  | sed '/^USE /d' > "$DATA_DUMP"

echo "$(date) - Restoring data-only backup to ShopDBDevelopment..."
MYSQL_PWD="$DB_PASSWORD" mysql -u"$DB_USER" ShopDBDevelopment < "$DATA_DUMP"

echo "$(date) - Backup & Restore completed successfully."
