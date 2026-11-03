#! /bin/bash
username="$DB_USER"
password="$DB_PASSWORD"

mysqldump -u $username -p$password ShopDB  --result-file=backup.sql
mysql -u $username -p$password ShopDBReserve < backup.sql
mysqldump -u $username -p$password ShopDB --no-create-info  --result-file=backupDEV.sql
mysql -u $username -p$password ShopDBDevelopment < backupDEV.sql