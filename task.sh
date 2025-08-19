#!/bin/bash

# Backup повної бази
mysqldump -u "$DB_USER" -p"$DB_PASSWORD" ShopDB > ShopDBReserve.sql

# Відновлення повної копії
mysql -u "$DB_USER" -p"$DB_PASSWORD" ShopDBReserve < ShopDBReserve.sql

# Резервна копія лише даних
mysqldump -u "$DB_USER" -p"$DB_PASSWORD" --no-create-info ShopDB > ShopDBDevelopment.sql

# Відновлення даних
mysql -u "$DB_USER" -p"$DB_PASSWORD" ShopDBDevelopment < ShopDBDevelopment.sql
