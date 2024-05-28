#! /bin/bash

mysqldump -u $DB_USER -p"$DB_PASSWORD" ShopDB --no-create-db --result-file=back_up_for_dbreserve.sql
mysql -u $DB_USER -p"$DB_PASSWORD" ShopDBReserve < back_up_for_dbreserve.sql

mysqldump -u $DB_USER -p"$DB_PASSWORD" ShopDB --no-create-db --no-create-info --result-file=back_up_for_dbdevelopment.sql
mysql -u $DB_USER -p"$DB_PASSWORD" ShopDBDevelopment < back_up_for_dbdevelopment.sql
