#! /bin/bash

# Зчитуємо змінні оточення
USER=$DB_USER
PASSWORD=$DB_PASSWORD

chmod +x task.sh

# 1. Повний бекап ShopDB -> відновлення в ShopDBReserve
mysqldump -u "$USER" -p"$PASSWORD" ShopDB --result-file=backup.sql

mysql -u "$USER" -p"$PASSWORD" ShopDBReserve < backup.sql

# 2. Тільки ДАНІ (без схеми) ShopDB -> відновлення в ShopDBDevelopment
mysqldump -u "$USER" -p"$PASSWORD" ShopDB --no-create-info --result-file=backup_development.sql

mysql -u "$USER" -p"$PASSWORD" ShopDBDevelopment < backup_development.sql

