#!/bin/bash

set -euo pipefail  
IFS=$'\n\t'

# ----------- ПЕРЕВІРКА ЗМІННИХ СЕРЕДОВИЩА -----------
if [[ -z "${DB_USER:-}" || -z "${DB_PASSWORD:-}" ]]; then
  echo "❌ Помилка: змінні середовища DB_USER і DB_PASSWORD мають бути встановлені."
  echo "Використай команди: export DB_USER='ім'я_користувача' і export DB_PASSWORD='пароль'"
  exit 1
fi

# ----------- НАЛАШТУВАННЯ -----------
PROD_DB="ShopDB"
RESERVE_DB="ShopDBReserve"
DEV_DB="ShopDBDevelopment"

TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
FULL_BACKUP_FILE="/tmp/${PROD_DB}_full_${TIMESTAMP}.sql"
DATA_BACKUP_FILE="/tmp/${PROD_DB}_data_${TIMESTAMP}.sql"

# Використовуємо тимчасовий конфіг MySQL замість передачі пароля у відкритому вигляді
MYSQL_CNF="/tmp/.mysql_secure.cnf"
cat > "$MYSQL_CNF" <<EOF
[client]
user=${DB_USER}
password=${DB_PASSWORD}
EOF
chmod 600 "$MYSQL_CNF"

MYSQL_CMD="mysql --defaults-extra-file=$MYSQL_CNF"
MYSQLDUMP_CMD="mysqldump --defaults-extra-file=$MYSQL_CNF"

echo "=========================================="
echo " Початок нічного резервного копіювання..."
echo " Час: $(date)"
echo "=========================================="

# ----------- КРОК 1: Повне резервне копіювання та відновлення у ShopDBReserve -----------
echo "[1/3] Створення повної резервної копії ${PROD_DB} і відновлення у ${RESERVE_DB}..."

$MYSQLDUMP_CMD --routines --triggers --skip-events $PROD_DB > $FULL_BACKUP_FILE
$MYSQL_CMD $RESERVE_DB < $FULL_BACKUP_FILE

echo "✔ Повна резервна копія успішно відновлена у ${RESERVE_DB}"

# ----------- КРОК 2: Резервна копія лише даних -----------
echo "[2/3] Створення копії лише даних із ${PROD_DB}..."

$MYSQLDUMP_CMD --no-create-info $PROD_DB > $DATA_BACKUP_FILE
echo "✔ Копію даних створено успішно"

# ----------- КРОК 3: Очищення та відновлення у ShopDBDevelopment -----------
echo "[3/3] Відновлення даних у ${DEV_DB} (очищення старих даних перед імпортом)..."

# Вимикаємо зовнішні ключі, щоб уникнути конфліктів
$MYSQL_CMD $DEV_DB -e "SET FOREIGN_KEY_CHECKS=0;"

# Очищаємо всі таблиці в базі розробки
TABLES=$($MYSQL_CMD -N -e "SHOW TABLES IN ${DEV_DB};")
for T in $TABLES; do
  $MYSQL_CMD $DEV_DB -e "TRUNCATE TABLE \`${T}\`;"
done

$MYSQL_CMD $DEV_DB -e "SET FOREIGN_KEY_CHECKS=1;"

# Імпортуємо нові дані
$MYSQL_CMD $DEV_DB < $DATA_BACKUP_FILE
echo "✔ Дані успішно відновлені у ${DEV_DB}"

# ----------- ОЧИЩЕННЯ -----------
echo "Очищення тимчасових файлів..."
rm -f $FULL_BACKUP_FILE $DATA_BACKUP_FILE $MYSQL_CNF

echo "=========================================="
echo "✅ Резервне копіювання та відновлення виконано успішно!"
echo " Завершено о: $(date)"
echo "=========================================="

