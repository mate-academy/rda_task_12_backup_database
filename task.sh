#! /bin/bash

read DBUser
read  DBPassword

mysqldump -u $DBUser -p$DBPassword --databases ShopDB --result-file=backup-shopdb.sql
mysql -u $DBUser -p$DBPassword ShopDBReserve < backup-shopdb.sql

mysqldump -u $DBUser -p$DBPassword --databases ShopDB --no-create-info --result-file=backup-dev.sql
mysql -u $DBUser -p$DBPassword ShopDBDevelopment < backup-dev.sql