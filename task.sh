#! /bin/bash

echo "Creating backup ShopDB for Reserve"
mysqldump -u "$DB_USER" -p"$DB_PASSWORD" ShopDB --no-create-db --result-file=backup-no-create-db.sql

echo "Restoring database to ShopDBReserve"
mysql -u "$DB_USER" -p"$DB_PASSWORD" ShopDBReserve < backup-no-create-db.sql

echo "_____________________________________________________"

echo "Creating backup ShopDB for Development"
mysqldump -u "$DB_USER" -p"$DB_PASSWORD" ShopDB --no-create-db --no-create-info --result-file=backup-no-create-db-no-create-info.sql

echo "Restoring database to ShopDBDevelopment"
mysql -u "$DB_USER" -p"$DB_PASSWORD" ShopDBDevelopment < backup-no-create-db-no-create-info.sql

echo "Finished!"