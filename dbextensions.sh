#!/bin/bash
set -e


echo "Creating extensions in $POSTGRES_DB as user $POSTGRES_USER"

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE EXTENSION IF NOT EXISTS postgis;
    CREATE EXTENSION IF NOT EXISTS hll;
    CREATE EXTENSION IF NOT EXISTS btree_gist;
    CREATE EXTENSION IF NOT EXISTS pgcrypto;

EOSQL

echo "$POSTGRES_DB database setup is complete have fun! :)"
