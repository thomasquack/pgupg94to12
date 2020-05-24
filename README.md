# Overview

Builds a docker container that allows the upgrade of an existing Postgres 9.4 database to Postgres 12.

This repo is built based on code from https://github.com/nwt-gt/auto-postgres.git

Disclaimer: We take no responsibility if this script corrupts your database. Pls do appropriate DB backups before running this script.

# Setup

1. Clone this repo onto your machine (assuming installation into `/opt`).

```
cd /opt
git clone https://github.com/geraldyong17/pgupg94to12.git pgupg94to12
```

2. Create the following directories to store the Postgres data:

```
mkdir -p /opt/pgupg94to12/volumes/data94
mkdir -p /opt/pgupg94to12/volumes/data12
```

3. Move the Postgres 9.4 data from your existing database into `/opt/pgupg94to12/volumes/data94`.

`cp -pr /var/lib/postgres/data/* /opt/pgupg94to12/volumes/data94`

This assumes you have an existing Postgres 9.4 database. If this is not available, you can do the following to create one:

```
docker-compose up -d postgres94
docker-compose down
```

# Performing the Upgrade

4. Start up the Postgres 12 instance to create the database.

```
docker-compose up -d postgres12
docker-compose down 
```

5. Start the database upgrade.

```
docker-compose build pgupg94to12
docker-compose up postgres_upg
docker-compose down
```

6. Start the new Postgres 12 database.

```
docker-compose up -d postgres12
docker-compose logs -f
```

7. Verify the tables.

```
docker exec -it pgupg94to12_postgres12_1 psql -U postgres
select * from xxxx
```
