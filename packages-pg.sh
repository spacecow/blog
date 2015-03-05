#!/usr/bin/env bash

apt-get install -y postgresql postgresql-contrib postgresql-client libpq-dev
sudo mkdir -p /usr/local/pgsql/data
sudo chown postgres:postgres /usr/local/pgsql/data
sudo su postgres
/usr/lib/postgresql/9.3/bin/initdb -D /usr/local/pgsql/data
createuser vagrant
psql
alter user vagrant with superuser;
exit
psql postgres

sudo su postgres 
psql
postgres=# CREATE DATABASE <yourappname>_development 
postgres=# CREATE DATABASE <yourappname>_test 

sudo -u postgres psql
postgres=# ALTER ROLE vagrant CREATEUSER CREATEDB;
