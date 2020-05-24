#!/bin/bash

set -e

# Perform the database upgrade.
BIN94=/usr/lib/postgresql/9.4/bin
BIN12=/usr/lib/postgresql/12/bin
DATA94=/var/lib/postgresql/9.4/main
DATA12=/var/lib/postgresql/12/main

echo "Current User changing data owner to postgres user"
whoami
chown -R postgres:postgres /var/lib/postgresql/
sudo -i -u postgres bash << EOF
echo "Current User to update datasebase"
whoami
cd /tmp
${BIN12}/pg_upgrade --old-bindir ${BIN94} --new-bindir ${BIN12} --old-datadir ${DATA94} --new-datadir ${DATA12} \
-o '-c config_file=${DATA94}/postgresql.conf' -O '-c config_file=${DATA12}/postgresql.conf'
cp -p ${DATA94}/pg_hba.conf ${DATA12}/pg_hba.conf
echo "Database upgrade completed."
EOF
