#!/bin/sh
host="a53905f6f517d4544aff42d70adb51ab-1411344514.us-east-1.elb.amazonaws.com"
user="postgres"
PGPASSWORD="admin123"
db="coworking"

for f in *.sql;
do
    psql --host $host -U $user -d $db -p 5433 -f "$f"
done
