#!/bin/bash
echo "Creating user"
# createuser $DB_USER 
# createdb $PGDB_JIRA
# createdb $PGDB_CONF

psql -U $POSTGRES_USER <<-EOSQL
  CREATE ROLE $DB_USER WITH LOGIN ENCRYPTED PASSWORD '${DB_PASS}' SUPERUSER;
EOSQL
  #alter user $DB_USER with encrypted password '$DB_PASS';
 
echo "Creating database"
psql -U $POSTGRES_USER <<-EOSQL
  CREATE DATABASE $DB_JIRA WITH OWNER $DB_USER ENCODING 'UNICODE' LC_COLLATE 'C' LC_CTYPE 'C' TEMPLATE template0;
  CREATE DATABASE $DB_CONF WITH OWNER $DB_USER ENCODING 'UNICODE' LC_COLLATE 'C' LC_CTYPE 'C' TEMPLATE template0;
  GRANT ALL PRIVILEGES ON DATABASE $DB_JIRA TO $DB_USER;
  GRANT ALL PRIVILEGES ON DATABASE $DB_CONF TO $DB_USER;
EOSQL
 
echo "******DOCKER DATABASE CONFIGURED******"