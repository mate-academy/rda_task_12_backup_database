#! /bin/bash
prod_database_name=ShopDB
reserve_database_name=ShopDBReserve
develop_database_name=ShopDBDevelopment

# Directory and file names used to store the generated SQL dumps
backup_path=backups
full_backup_name=ShopDB-full.sql
data_backup_name=ShopDB-data.sql

# Create the backup directory if it doesn't exist yet
if [ ! -d "$backup_path" ]; then
    mkdir "$backup_path"
fi

# Archive the previous full backup (if any) before creating a new one,
# so we always keep the last known-good copy as a fallback
if [ -f "$backup_path/$full_backup_name" ]; then
    mv "$backup_path/$full_backup_name" "$backup_path/$full_backup_name.old"
fi

echo "Creating a full backup (schema + data) of $prod_database_name"
mysqldump -u "$DB_USER" -p"$DB_PASSWORD" "$prod_database_name" \
--no-create-db --result-file="$backup_path/$full_backup_name" 2> /dev/null

if [ $? -ne 0 ]; then
    echo "Error: full backup of $prod_database_name failed"
    exit 1
fi
echo "Full backup created successfully"

# Archive the previous data-only backup (if any) before creating a new one
if [ -f "$backup_path/$data_backup_name" ]; then
    mv "$backup_path/$data_backup_name" "$backup_path/$data_backup_name.old"
fi

echo "Creating a data-only backup (no schema) of $prod_database_name"
mysqldump -u "$DB_USER" -p"$DB_PASSWORD" "$prod_database_name" \
--no-create-info --result-file="$backup_path/$data_backup_name" 2> /dev/null

if [ $? -ne 0 ]; then
    echo "Error: data-only backup of $prod_database_name failed"
    exit 1
fi
echo "Data-only backup created successfully"

echo "Restoring full backup into $reserve_database_name (disaster recovery copy)"
if [ -f "$backup_path/$full_backup_name" ]; then
    mysql -u "$DB_USER" -p"$DB_PASSWORD" "$reserve_database_name" < "$backup_path/$full_backup_name" 2> /dev/null
fi

echo "Restoring data-only backup into $develop_database_name (development database)"
if [ -f "$backup_path/$data_backup_name" ]; then
    mysql -u "$DB_USER" -p"$DB_PASSWORD" "$develop_database_name" < "$backup_path/$data_backup_name" 2> /dev/null
fi

exit 0