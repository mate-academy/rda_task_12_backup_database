#!/bin/bash
set -euo pipefail

mysqldump -u "$DB_USER" -p"$DB_PASSWORD" --single-transaction --skip-triggers ShopDB > backup.sql
mysql -u "$DB_USER" -p"$DB_PASSWORD" ShopDBReserve < backup.sql

mysqldump -u "$DB_USER" -p"$DB_PASSWORD" --single-transaction --skip-triggers --no-create-info ShopDB > backup_data.sql
mysql -u "$DB_USER" -p"$DB_PASSWORD" ShopDBDevelopment < backup_data.sql