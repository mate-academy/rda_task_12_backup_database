#! /bin/bash


# Вихід при першій помилці
set -e

# Зчитування змінних середовища
DB_USER="${DB_USER}"
DB_PASSWORD="${DB_PASSWORD}"

# Перевірка, чи змінні встановлені
if [[ -z "$DB_USER" || -z "$DB_PASSWORD" ]]; then
  echo "❌ Помилка: Змінні середовища DB_USER або DB_PASSWORD не встановлені."
  exit 1
fi

# Шляхи до файлів бекапів
FULL_BACKUP_FILE="shopdb_full_backup.sql"
DATA_ONLY_BACKUP_FILE="shopdb_data_only_backup.sql"

# Створення повного бекапу бази ShopDB
echo "📦 Створюємо повний бекап бази ShopDB..."
mysqldump -u "$DB_USER" -p"$DB_PASSWORD" ShopDB > "$FULL_BACKUP_FILE"

# Відновлення повного бекапу в базу ShopDBReserve
echo "♻️ Відновлюємо повний бекап у базу ShopDBReserve..."
mysql -u "$DB_USER" -p"$DB_PASSWORD" ShopDBReserve < "$FULL_BACKUP_FILE"

# Створення бекапу тільки даних (без CREATE TABLE)
echo "📦 Створюємо бекап тільки даних з бази ShopDB..."
mysqldump -u "$DB_USER" -p"$DB_PASSWORD" --no-create-info ShopDB > "$DATA_ONLY_BACKUP_FILE"

# Відновлення тільки даних у базу ShopDBDevelopment
echo "♻️ Відновлюємо тільки дані у базу ShopDBDevelopment..."
mysql -u "$DB_USER" -p"$DB_PASSWORD" ShopDBDevelopment < "$DATA_ONLY_BACKUP_FILE"

echo "✅ Резервне копіювання та відновлення успішно завершено!"
