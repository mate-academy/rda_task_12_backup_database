#!/bin/bash

mysqldump -u ${1:-$DB_USER} -p${2:-$DB_PASSWORD} ShopDB --routines --events > full_backup.sql
mysqldump -u ${1:-$DB_USER} -p${2:-$DB_PASSWORD} --no-create-db --no-create-info ShopDB > data_backup.sql

mysql -u ${1:-$DB_USER} -p${2:-$DB_PASSWORD} ShopDBReserve < full_backup.sql
mysql -u ${1:-$DB_USER} -p${2:-$DB_PASSWORD} ShopDBDevelopment < data_backup.sql