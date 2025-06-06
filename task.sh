#!/bin/bash

# Перевірка змінних середовища
if [[ -z "$DB_USER" || -z "$DB_PASSWORD" ]]; then
  echo "❌ Environment variables DB_USER and/or DB_PASSWORD are not set."
  exit 1
fi

# Налаштування
HOST="localhost"
FULL_BACKUP_FILE="shopdb_full_backup.sql"
DATA_ONLY_BACKUP_FILE="shopdb_data_only_backup.sql"

# 1. Повний бекап бази ShopDB
echo "📦 Creating full backup of ShopDB..."
mysqldump -u "$DB_USER" -p"$DB_PASSWORD" -h "$HOST" ShopDB > "$FULL_BACKUP_FILE"

# 2. Відновлення повного бекапу в ShopDBReserve
echo "♻️ Restoring full backup to ShopDBReserve..."
mysql -u "$DB_USER" -p"$DB_PASSWORD" -h "$HOST" ShopDBReserve < "$FULL_BACKUP_FILE"

# 3. Бекап тільки даних з ShopDB
echo "📄 Creating data-only backup of ShopDB..."
mysqldump -u "$DB_USER" -p"$DB_PASSWORD" -h "$HOST" ShopDB --no-create-info > "$DATA_ONLY_BACKUP_FILE"

# 4. Відновлення тільки даних у ShopDBDevelopment
echo "📥 Restoring data-only backup to ShopDBDevelopment..."
mysql -u "$DB_USER" -p"$DB_PASSWORD" -h "$HOST" ShopDBDevelopment < "$DATA_ONLY_BACKUP_FILE"

echo "✅ All operations completed."
