#!/bin/bash
# Перевірка наявності змінних середовища
if [[ -z "$DB_USER" || -z "$DB_PASSWORD" ]]; then
  echo "❌ Помилка: Змінні середовища DB_USER або DB_PASSWORD не задані."
  exit 1
fi

# Назви баз
SOURCE_DB="ShopDB"
FULL_BACKUP_DB="ShopDBReserve"
DATA_ONLY_DB="ShopDBDevelopment"

# Ім'я файлу для повної резервної копії
FULL_BACKUP_FILE="full_backup.sql"
# дані (без структури)
DATA_BACKUP_FILE="data_only_backup.sql"

echo "📦 Створення повної резервної копії бази $SOURCE_DB..."
mysqldump -u"$DB_USER" -p"$DB_PASSWORD" $SOURCE_DB > "$FULL_BACKUP_FILE"

echo "♻️ Відновлення повної резервної копії у $FULL_BACKUP_DB..."
mysql -u"$DB_USER" -p"$DB_PASSWORD" $FULL_BACKUP_DB < "$FULL_BACKUP_FILE"

echo "📦 Створення резервної копії лише даних з $SOURCE_DB..."
mysqldump -u"$DB_USER" -p"$DB_PASSWORD" --no-create-info $SOURCE_DB > "$DATA_BACKUP_FILE"

echo "♻️ Відновлення лише даних у $DATA_ONLY_DB..."
mysql -u"$DB_USER" -p"$DB_PASSWORD" $DATA_ONLY_DB < "$DATA_BACKUP_FILE"

echo "✅ Готово. Резервне копіювання та відновлення завершені успішно."
