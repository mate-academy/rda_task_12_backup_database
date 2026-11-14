#! /bin/bash
User="$DB_USER"
Pass="$DB_PASSWORD"

echo "Start backup and restoration"
mysqldump -u "$User" -p"$Pass" ShopDB --result-file=ShopDB_back.sql
mysql -u "$User" -p"$Pass" -e "CREATE DATABASE IF NOT EXISTS ShopDBReserve"
mysql -u "$User" -p"$Pass" ShopDBReserve < ShopDB_back.sql

mysqldump -u "$User" -p"$Pass" ShopDB --no-create-db --result-file=ShopDBDev_back.sql
mysql -u "$User" -p"$Pass" -e "CREATE DATABASE IF NOT EXISTS ShopDBDevelopment"
mysql -u "$User" -p"$Pass" ShopDBDevelopment < ShopDBDev_back.sql
echo "Backup and restoration completed"
