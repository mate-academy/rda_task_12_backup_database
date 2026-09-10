mysqldump -u "DB_USER" -p"DB_PASSWORD" ShopDB > backup.sql
mysqldump -u "DB_USER" -p"DB_PASSWORD" ShopDBReverse < backup.sql
mysqldump -u "DB_USER" -p"DB_PASSWORD" --no-create-info ShopDB > data_backup.sql
mysql -u "DB_USER" -p"DB_PASSWORD" ShopDBReverse < data_backup.sql
