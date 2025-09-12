#!/bin/bash
set -e

# Читаємо змінні середовища
USER="$DB_USER"
PASS="$DB_PASSWORD"

# Перевірка, що змінні встановлені
if [[ -z "$USER" || -z "$PASS" ]]; then
  echo "DB_USER або DB_PASSWORD не встановлені"
  exit 1
fi

# 1. Повний бекап ShopDB → відновлення в ShopDBReserve
mysqldump -u"$USER" -p"$PASS" ShopDB > /tmp/shopdb_full.sql
mysql -u"$USER" -p"$PASS" ShopDBReserve < /tmp/shopdb_full.sql

# 2. Бекап тільки даних ShopDB → відновлення в ShopDBDevelopment
mysqldump -u"$USER" -p"$PASS" --no-create-info ShopDB > /tmp/shopdb_data.sql
mysql -u"$USER" -p"$PASS" ShopDBDevelopment < /tmp/shopdb_data.sql

echo "Backup & Restore завершено успішно."
