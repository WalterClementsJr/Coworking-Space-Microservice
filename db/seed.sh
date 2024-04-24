#!/bin/sh
host="a823d10293ef448eba9fa5ceb21a00df-596495898.us-east-1.elb.amazonaws.com"
port=5432
user="postgres"
db="coworking"

echo "seeding db $host $user$PGPASSWORD $db"

for f in *.sql;
do
    echo "$f"
    PGPASSWORD="admin123" psql --host $host -p $port -U $user -d $db -f "$f"
done
