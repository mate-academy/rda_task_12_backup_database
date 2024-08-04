#! /bin/bash

# full backup of `ShopDB` database
mysqldump -u "$DB_USER" -p"$DB_PASSWORD" ShopDB --no-create-db --result-file=full_backup_ShopDB.sql
# restore to `ShopDBReserve` for fast disaster recovery.
mysql -u "$DB_USER" -p"$DB_PASSWORD" ShopDBReserve < full_backup_ShopDB.sql

# backup of `ShopDB` database w/o schema for development purposes
mysqldump -u "$DB_USER" -p"$DB_PASSWORD" ShopDB --no-create-info --result-file=development_backup_ShopDB.sql
# restore to `ShopDBDevelopment`.
mysql -u "$DB_USER" -p"$DB_PASSWORD" ShopDBDevelopment < development_backup_ShopDB.sql
