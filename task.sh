#!/bin/bash

if [[ -z "$DB_USER" || -z "$DB_PASSWORD" ]]; then
    echo "Помилка: Змінні оточення DB_USER або DB_PASSWORD не встановлені."
    exit 1
fi

USER=$DB_USER
PASS=$DB_PASSWORD
HOST="localhost"

echo "Розпочинаю процедуру обслуговування баз даних..."

echo "Копіювання ShopDB до ShopDBReserve (повний бекап)..."
mysqldump -u "$USER" -p"$PASS" ShopDB | mysql -u "$USER" -p"$PASS" ShopDBReserve

if [ $? -eq 0 ]; then
    echo "Успішно: ShopDBReserve оновлено."
else
    echo "Помилка при оновленні ShopDBReserve."
fi

echo "Копіювання даних ShopDB до ShopDBDevelopment (тільки дані)..."
mysqldump -u "$USER" -p"$PASS" --no-create-info ShopDB | mysql -u "$USER" -p"$PASS" ShopDBDevelopment

if [ $? -eq 0 ]; then
    echo "Успішно: Дані в ShopDBDevelopment оновлено."
else
    echo "Помилка при оновленні ShopDBDevelopment."
fi

echo "Завдання виконано."
