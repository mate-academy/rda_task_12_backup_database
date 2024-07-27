#! /bin/bash

mysqldump -u $DB_USER -p$DB_PASSWORD ShopDB --no-create-db --result-file=full_backup.sql

mysqldump -u $DB_USER -p$DB_PASSWORD ShopDB --no-create-info --result-file=partial_backup.sql

mysql -u $DB_USER -p$DB_PASSWORD ShopDBReserve < full_backup.sql

mysql -u $DB_USER -p$DB_PASSWORD ShopDBDevelopment < partial_backup.sql
