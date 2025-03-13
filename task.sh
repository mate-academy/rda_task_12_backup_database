#! /bin/bash

DB_USER=${DB_USER}
DB_PASSWORD=${DB_PASSWORD}

mysqldump -u ${DB_USER} -p${DB_PASSWORD} --databases ShopDB  --result-file=backup-new.sql --no-create-db;
mysql -u ${DB_USER} -p${DB_PASSWORD} ShopDBReserve < backup-new.sql;

mysqldump -u ${DB_USER} -p${DB_PASSWORD} --databases ShopDB  --result-file=backup-new.sql --no-create-info;
mysql -u ${DB_USER} -p${DB_PASSWORD} ShopDBDevelopment < backup-new.sql;
