#! /bin/bash
user=$DB_USER
pass=$DB_PASSWORD
mysqldump -u $user -p"$pass" ShopDB  --result-file=ShopDBBackup
#mysql -u $user -p"$pass" -e "CREATE DATABASE ShopDBReserve;"
mysql -u $user -p"$pass" ShopDBReserve < ShopDBBackup
mysqldump -u $user -p"$pass" ShopDB --no-create-db --no-create-info --result-file=ShopDBDataBackup
#mysql -u $user -p"$pass" -e "CREATE DATABASE ShopDBDevelopment;"
mysql -u $user -p"$pass" ShopDBDevelopment  < ShopDBDataBackup
