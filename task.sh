#! /bin/bash
mysqldump -u "${DB_USER}" -p"${DB_PASSWORD}" --single-transaction ShopDB > ShopDB_back.sql
mysqldump -u "${DB_USER}" -p"${DB_PASSWORD}" --single-transaction --no-create-info ShopDB > ShopDB_dev_back.sql
mysql -u "${DB_USER}" -p"${DB_PASSWORD}" -e 'create database IF NOT EXISTS ShopDBReserve'
mysql -u "${DB_USER}" -p"${DB_PASSWORD}" -e 'create database IF NOT EXISTS ShopDBDevelopment'
mysql -u "${DB_USER}" -p"${DB_PASSWORD}" ShopDBReserve < ShopDB_back.sql
mysql -u "${DB_USER}" -p"${DB_PASSWORD}" ShopDBDevelopment < ShopDB_dev_back.sql