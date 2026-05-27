#!/bin/bash

mysqldump -u"$DB_USER" -p"$DB_PASSWORD" ShopDB > ShopDB.backup.sql

mysql -u"$DB_USER" -p"$DB_PASSWORD" ShopDBReserve < ShopDB.backup.sql


mysqldump -u"$DB_USER" -p"$DB_PASSWORD" --no-create-info ShopDB > ShopDBNoInfo.backup.sql

mysql -u"$DB_USER" -p"$DB_PASSWORD" ShopDBDevelopment < ShopDBNoInfo.backup.sql