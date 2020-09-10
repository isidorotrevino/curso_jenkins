#!/bin/bash
DB_HOST=$1
DB_PASSWORD=$2
DB_NAME=$3
DATE=$(date +%H-%M-%S)
AWS_SECRET=$4
BUCKET_NAME=$5

MYSQL_CONN="-uroot -p${DB_PASSWORD}"
SQL="SELECT schema_name FROM information_schema.schemata WHERE schema_name NOT IN"
SQL="${SQL} ('mysql','information_schema','performance_schema')"

DBLISTFILE=/tmp/DatabasesToDump.txt
mysql -h $DB_HOST ${MYSQL_CONN} -ANe"${SQL}" > ${DBLISTFILE}

DBLIST=""
for DB in `cat ${DBLISTFILE}` ; do DBLIST="${DBLIST} ${DB}" ; done

MYSQLDUMP_OPTIONS="--routines --triggers --single-transaction"
(mysqldump -u root -h $DB_HOST -p$DB_PASSWORD $DB_NAME ${MYSQLDUMP_OPTIONS} --databases ${DBLIST} > /tmp/db-$DATE.sql || true ) && \
export AWS_ACCESS_KEY_ID=AKIASK3WJI3S6RR635DL && \
export AWS_SECRET_ACCESS_KEY=$AWS_SECRET && \
aws s3 cp /tmp/db-$DATE.sql s3://$BUCKET_NAME
