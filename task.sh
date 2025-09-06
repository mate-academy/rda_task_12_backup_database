#! /bin/bash

mysqldump -u"$DB_USER" -p"$DB_PASSWORD" --databases ShopDB --result-file=full_backup.sql
mysql -u"$DB_USER" -p"$DB_PASSWORD" ShopDBReserve < full_backup.sql

mysqldump -u"$DB_USER" -p"$DB_PASSWORD" --no-create-info ShopDB --result-file=data_backup.sql
mysql -u"$DB_USER" -p"$DB_PASSWORD" ShopDBDevelopment < full_backup.sql
