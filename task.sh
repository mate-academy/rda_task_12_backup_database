#!/bin/bash
mysqldump -u "$DB_USER" -p"$DB_PASSWORD" --no-create-db ShopDB > backup_full.sql
mysql -u "$DB_USER" -p"$DB_PASSWORD" ShopDBReserve < backup_full.sql
mysqldump -u "$DB_USER" -p"$DB_PASSWORD" --no-create-db --no-create-info ShopDB > data_only_backup.sql
mysql -u "$DB_USER" -p"$DB_PASSWORD" ShopDBDevelopment < data_only_backup.sql
