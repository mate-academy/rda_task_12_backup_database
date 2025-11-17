#!/bin/bash

DB_USER=$DB_USER
DB_PASSWORD=$DB_PASSWORD

mysqldump -u $DB_USER -p$DB_PASSWORD --databases ShopDB --result-file=backup.sql
mysql -u $DB_USER -p$DB_PASSWORD ShopDBReserve < backup.sql

mysqldump -u $DB_USER -p$DB_PASSWORD --databases ShopDB --no-create-info --result-file=back_no_info.sql
mysql -u $DB_USER -p$DB_PASSWORD ShopDBDevelopment < back_no_info.sql
