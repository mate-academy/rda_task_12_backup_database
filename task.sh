#!/bin/bash
set -e

mysqldump --user=$DB_USER --password=$DB_PASSWORD ShopDB --no-create-db > backup-no-create-db.sql
mysqldump --user=$DB_USER --password=$DB_PASSWORD ShopDB --no-create-db  --no-create-info > backup-no-create-db-info.sql
mysql -u $DB_USER -p$DB_PASSWORD -e "DROP DATABASE IF EXISTS ShopDBReserve;"
mysql -u $DB_USER -p$DB_PASSWORD -e "CREATE DATABASE IF NOT EXISTS ShopDBReserve;"
mysql -u $DB_USER -p$DB_PASSWORD -e "CREATE DATABASE IF NOT EXISTS ShopDBDevelopment;"
mysql -u $DB_USER -p$DB_PASSWORD ShopDBReserve < backup-no-create-db.sql
mysql -u $DB_USER -p$DB_PASSWORD ShopDBDevelopment < backup-no-create-db-info.sql
rm ./backup-no-create-db-info.sql ./backup-no-create-db.sql
