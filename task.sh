#! /bin/bash
# Зчитати ім'я користувача та пароль бази даних зі змінних середовища
USER="$DB_USER"
PASS="$DB_PASSWORD"

# 1. Повний бекап ShopDB -> ShopDBReserve
mysqldump -u "$USER" -p"$PASS" ShopDB | mysql -u "$USER" -p"$PASS" ShopDBReserve
# 2. Створіть резервну копію даних з бази даних ShopDBта відновіть їх у базі даних -> ShopDBDevelopment
mysqldump --no-create-info -u "$USER" -p"$PASS" ShopDB | mysql -u "$USER" -p"$PASS" ShopDBDevelopment