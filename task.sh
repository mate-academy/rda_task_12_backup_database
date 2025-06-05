#! /bin/bash

mysqldump -u "$DB_USER" -p"$DB_PASSWORD" --databases ShopDB --result-file=backup-full.sql

mysql -u mysqluser -pP@ssw0rd ShopDBReserve < backup-full.sql

mysqldump -u "$DB_USER" -p"$DB_PASSWORD" --databases ShopDB --no-data --result-file=backup-no-data.sql

mysql -u mysqluser -pP@ssw0rd ShopDBDevelopment < backup-no-data.sql
