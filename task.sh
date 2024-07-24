#! /bin/bash

USER=$DB_USER
PASSWORD=$DB_PASSWORD

DATABASE="ShopDB"
DB_RSERVE="ShopDBReserve"
DB_DEVELOPMENT="ShopDBDevelopment"

mysqldump -u"$USER" -p"$PASSWORD" "$DATABASE" --no-create-db --result-file=full-backup-db.sql
mysql -u"$USER" -p"$PASSWORD" "$DB_RSERVE" < full-backup-db.sql

mysqldump -u"$USER" -p"$PASSWORD" "$DATABASE" --no-create-info --result-file=data-backup-db.sql
mysql -u"$USER" -p"$PASSWORD" "$DB_DEVELOPMENT" < data-backup-db.sql
