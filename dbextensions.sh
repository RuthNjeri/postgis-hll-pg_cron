#!/bin/bash
set -e

# Set up pg_cron
echo "Setting up pg_cron..."
cat <<EOT >> ${PGDATA}/postgresql.conf
shared_preload_libraries='pg_cron'
cron.database_name='${POSTGRES_DB:-postgres}'
EOT

# Restart postgres after pg_cron setup
echo "Restarting Postgres..."
pg_ctl restart

# Create Extensions
echo "Creating extensions in $POSTGRES_DB as user $POSTGRES_USER"

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE EXTENSION IF NOT EXISTS postgis;
    CREATE EXTENSION IF NOT EXISTS hll;
    CREATE EXTENSION IF NOT EXISTS btree_gist;
    CREATE EXTENSION IF NOT EXISTS pgcrypto;
    CREATE EXTENSION IF NOT EXISTS pg_cron;

EOSQL

echo "$POSTGRES_DB database setup is complete have fun! :)"
