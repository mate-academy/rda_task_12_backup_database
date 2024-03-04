#! /bin/bash

if [[ -z "$DB_USER" || -z "$DB_PASSWORD" ]]; then
    echo "Error: Required environment variables DB_USER and/or DB_PASSWORD are not set."
    exit 1
fi

mysqldump -u "$DB_USER" -p"$DB_PASSWORD" ShopDB --no-create-db --skip-add-drop-table --result-file=fullbackup.sql
mysql -u "$DB_USER" -p"$DB_PASSWORD" ShopDBReserve < fullbackup.sql
mysqldump -u "$DB_USER" -p"$DB_PASSWORD" ShopDB --no-create-info --result-file=full_databackup.sql
mysql -u "$DB_USER" -p"$DB_PASSWORD" ShopDBDevelopment < full_databackup.sql