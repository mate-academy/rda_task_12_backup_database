#!/bin/bash

# 1. Проверяем переменные (добавили пробелы перед закрывающими скобками)
if [ -z "$DB_USER" ] || [ -z "$DB_PASSWORD" ]; then
  echo "Ошибка: Переменные окружения не заданы!"
  exit 1
fi

echo "$DB_USER"
echo "$DB_PASSWORD"

# 2. Первый бэкап (полный)
mysqldump -u "$DB_USER" -p"$DB_PASSWORD" ShopDB | \
mysql -u "$DB_USER" -p"$DB_PASSWORD" ShopDBReserve

# Проверяем: если код НЕ равен 0 (произошла ошибка), то выходим
if [ $? -ne 0 ]; then
  echo "Ошибка при копировании в ShopDBReserve!"
  exit 1
fi

# 3. Второй бэкап (только данные)
mysqldump -u "$DB_USER" -p"$DB_PASSWORD" --no-create-info --insert-ignore ShopDB | \
mysql -u "$DB_USER" -p"$DB_PASSWORD" ShopDBDevelopment

# Снова проверяем на ошибку
if [ $? -ne 0 ]; then
  echo "Ошибка при копировании данных в ShopDBDevelopment!"
  exit 1
fi

echo "Все базы данных успешно синхронизированы!"