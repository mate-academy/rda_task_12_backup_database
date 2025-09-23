#!/bin/bash

COMMON_ARGS="-u$DB_USER -p$DB_PASSWORD ShopDB --no-create-db"

mysqldump $COMMON_ARGS --result-file=ShopDBReserve.sql
mysqldump $COMMON_ARGS --no-create-info --result-file=ShopDBDevelopment.sql

mysql -u "$DB_USER" -p"$DB_PASSWORD" -e "DROP DATABASE IF EXISTS ShopDBReserve;"
mysql -u "$DB_USER" -p"$DB_PASSWORD" -e "DROP DATABASE IF EXISTS ShopDBDevelopment;"
mysql -u "$DB_USER" -p"$DB_PASSWORD" -e "CREATE DATABASE ShopDBReserve;"
mysql -u "$DB_USER" -p"$DB_PASSWORD" -e "CREATE DATABASE ShopDBDevelopment;"
mysql -u "$DB_USER" -p"$DB_PASSWORD" ShopDBDevelopment -e "
CREATE TABLE IF NOT EXISTS Products (
    ID INT AUTO_INCREMENT,
    Name VARCHAR(50),
    PRIMARY KEY (ID)
);
"

mysql -u "$DB_USER" -p"$DB_PASSWORD" ShopDBReserve < ShopDBReserve.sql
mysql -u "$DB_USER" -p"$DB_PASSWORD" ShopDBDevelopment < ShopDBDevelopment.sql
