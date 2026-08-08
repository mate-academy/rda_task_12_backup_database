#! /bin/bash

# Create full backup ShopDB without create DB. Restore data for existing DB.
sudo mysqldump -u "$DB_USER" -p"$DB_PASSWORD" ShopDB --no-create-db --result-file=backup-no-create-db.sql

# Recover full DB without database create.
sudo mysql -u "$DB_USER" -p"$DB_PASSWORD" ShopDBReserve < backup-no-create-db.sql

# Create data backup ShopDB.
sudo mysqldump -u "$DB_USER" -p"$DB_PASSWORD" ShopDB --no-create-info --result-file=backup-no-info.sql

# Recover data in existing database.
sudo mysql -u "$DB_USER" -p"$DB_PASSWORD" ShopDBDevelopment < backup-no-info.sql

