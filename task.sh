#! /bin/bash

mysqldump -u "$DB_USER" -p"$DB_PASSWORD" ShopDB --no-create-db --skip-add-drop-table --result-file=fullbackup.sql
mysql -u "$DB_USER" -p"$DB_PASSWORD" ShopDBReserve < fullbackup.sql
mysqldump -u "$DB_USER" -p"$DB_PASSWORD" ShopDB --no-create-info --result-file=databackup.sql
mysql -u "$DB_USER" -p"$DB_PASSWORD" ShopDBDevelopment < databackup.sql
