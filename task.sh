#! /bin/bash
user=$DB_USER
password=$DB_PASSWORD

chmod +x task.sh

mysqldump -u $user -p$password ShopDB --no-create-db --result-file=backup-no-create-db.sql

mysql -u $user -p$password ShopDBReserve < backup-no-create-db.sql

mysqldump -u $user -p$password ShopDB  --no-create-info --no-create-db --result-file=backup-no-create-info.sql 

mysql -u $user -p$password ShopDBDevelopment < backup-no-create-info.sql




