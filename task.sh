#! /bin/bash
mysqldump --user=$DB_USER --password=$DB_PASSWORD ShopDB --no-create-db --result-file=backup-no-create-db.sql
mysqldump --user=$DB_USER --password=$DB_PASSWORD ShopDB --no-create-db  --no-create-info --result-file=backup-no-create-db-info.sql
mysql -u $DB_USER -p$DB_PASSWORD -e "CREATE DATABASE IF NOT EXISTS ShopDBReserve;"
mysql -u $DB_USER -p$DB_PASSWORD -e "CREATE DATABASE IF NOT EXISTS ShopDBDevelopment;"
mysql -u $DB_USER -p$DB_PASSWORD ShopDBReserve < backup-no-create-db.sql
mysql -u $DB_USER -p$DB_PASSWORD ShopDBDevelopment < backup-no-create-db-info.sql
