#!/bin/sh
host = "127.0.0.1"
user = "admin"
PGPASSWORD = "admin@1234"
db = "coworking"

for f in *.sql;
do
    psql --host $host -U $user -d $db -p 5432 -f "$f"
done
