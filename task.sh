#! /bin/bash

mysqldump -u "$DB_USER" -p"$DB_PASSWORD" ShopDB --no-create-db --result-file=full-backup.sql
mysql -u "$DB_USER" -p"$DB_PASSWORD" ShopDBReserve < full-backup.sql
mysqldump -u "$DB_USER" -p"$DB_PASSWORD" ShopDB --no-create-info --result-file=data-backup.sql
mysql -u "$DB_USER" -p"$DB_PASSWORD" ShopDBDevelopment < data-backup.sql
