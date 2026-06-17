#!/bin/bash

mysqldump -u $DB_USER -p$DB_PASSWORD ShopDB > ShopDB_full_backup.sql
mysql -u $DB_USER -p$DB_PASSWORD ShopDBReserve < ShopDB_full_backup.sql

mysqldump -u $DB_USER -p$DB_PASSWORD --no-create-info ShopDB > ShopDB_data_backup.sql
mysql -u $DB_USER -p$DB_PASSWORD ShopDBDevelopment < ShopDB_data_backup.sql