#! /bin/bash

# Here I read database credentials
DB_USER="${DB_USER}"
DB_PASSWORD="${DB_PASSWORD}"

# Backup ShopDB 
mysqldump -u $DB_USER -p$DB_PASSWORD ShopDB | mysql -u $DB_USER -p$DB_PASSWORD ShopDBReserve

# Dump from ShopDB and restore ShopDBDevelopment
mysqldump -u $DB_USER -p$DB_PASSWORD --no-create-info ShopDB | mysql -u $DB_USER -p$DB_PASSWORD ShopDBDevelopment

echo "Backup done well ))."