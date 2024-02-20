#! /bin/bash
mysqldump -u "$DB_USER" -p"$DB_PASSWORD" --databases ShopDB --skip-add-drop-table --no-create-db --result-file=backup-no-create-db.sql

mysql -u "$DB_USER" -p"$DB_PASSWORD" ShopDBReserve < backup-no-create-db.sql

mysqldump -u "$DB_USER" -p"$DB_PASSWORD" --databases ShopDB --no-create-info --result-file=backup-no-create-db_info.sql

mysql -u "$DB_USER" -p"$DB_PASSWORD" ShopDBDevelopment < backup-no-create-db_info.sql

