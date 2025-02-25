#! /bin/bash

echo "Creating backup ShopDB"
mysqldump -u "$DB_USER" -p"$DB_PASSWORD" ShopDB --no-create-db --result-file=backup-no-create-db.sql

echo "Restoring database to ShopDBReserve"
mysql -u "$DB_USER" -p"$DB_PASSWORD" ShopDBReserve < backup-no-create-db.sql

echo "Restoring database to ShopDBDevelopment"
mysql -u "$DB_USER" -p"$DB_PASSWORD" ShopDBDevelopment < backup-no-create-db.sql

echo "Finished!"