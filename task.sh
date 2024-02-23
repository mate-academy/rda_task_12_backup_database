#! /bin/bash

DB_USER=$DB_USER
DB_PASSWORD=$DB_PASSWORD

DATABASE="ShopDB"
BACKUP_DB="ShopDBReserve"
DEVELOPMENT_DB="ShopDBDevelopment"

mysqldump -u"$DB_USER" -p"$DB_PASSWORD" "$DATABASE" --no-create-db --result-file=full-backup-db.sql
mysql -u"$DB_USER" -p"$DB_PASSWORD" "$BACKUP_DB" < full-backup-db.sql
mysqldump -u"$DB_USER" -p"$DB_PASSWORD" "$DATABASE" --no-create-info --result-file=data-backup-db.sql
mysql -u"$DB_USER" -p"$DB_PASSWORD" "$DEVELOPMENT_DB" < data-backup-db.sql