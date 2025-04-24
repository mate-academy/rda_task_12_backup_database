#! /bin/bash
DB_USER="${DB_USER}"
DB_PASSWORD="${DB_PASSWORD}"

# ShopDB backup
mysqldump -u"$DB_USER" -p"$DB_PASSWORD" --databases ShopDB > /tmp/shopdb_backup.sql

# Empty ShopDBReserve
mysql -u"$DB_USER" -p"$DB_PASSWORD" -e "DROP DATABASE IF EXISTS ShopDBReserve; CREATE DATABASE ShopDBReserve;"

# Restore ShopDBReserve
mysql -u"$DB_USER" -p"$DB_PASSWORD" ShopDBReserve < /tmp/shopdb_backup.sql

# Copy data to ShopDBDevelopment
# List ShopDB tables
tables=$(mysql -u"$DB_USER" -p"$DB_PASSWORD" -Nse 'SHOW TABLES;' ShopDB)

# Empty ShopDBDevelopment
for table in $tables; do
  mysql -u"$DB_USER" -p"$DB_PASSWORD" -e "DELETE FROM $table;" ShopDBDevelopment 2>/dev/null
done

# Copy data
for table in $tables; do
  mysqldump -u"$DB_USER" -p"$DB_PASSWORD" --no-create-info ShopDB "$table" | mysql -u"$DB_USER" -p"$DB_PASSWORD" ShopDBDevelopment
done