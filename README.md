# Overview

Builds a docker container that allows the upgrade of an existing Postgres 9.6 database to Postgres 12.

Disclaimer: We take no responsibility if this script corrupts your database. Pls do appropriate DB backups before running this script.

# Setup

1. Clone this repo onto your machine (assuming installation into `/opt`).

```
cd /opt
git clone https://github.com/geraldyong17/pgupg96to12.git pgupg96to12
```

2. Create the following directories to store the Postgres data:

```
mkdir -p /opt/pgupg96to12/volumes/data96
mkdir -p /opt/pgupg96to12/volumes/data12
```

3. Move the Postgres 9.6 data from your existing database into `/opt/pgupg96to12/volumes/data96`.

# Postgres 9.6

This assumes you have an existing Postgres 9.6 database. If this is not available, you can do the following to create one:

```
docker-compose up -d postgres96
docker-compose down
```

# Performing the Upgrade

1. Start up the Postgres 12 instance to create the database.

```
docker-compose up -d postgres12
docker-compose down 
```

2. Start the database upgrade.

```
docker-compose build pgupg96to12
docker-compose up postgres_upg
docker-compose down
```

3. Start the new Postgres 12 database.

```
docker-compose up -d postgres12
docker-compose logs -f
```

4. Verify the tables.

```
docker exec -it pgupg96to12_postgres12_1 psql -U postgres
select * from xxxx
```
