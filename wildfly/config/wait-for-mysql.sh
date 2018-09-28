#!/bin/bash

set -e

echo "Waiting for mysql"
until /usr/bin/mysql -h${MYSQL_DB}  -u ${MYSQL_USER} -p${MYSQL_PASSWORD} > /dev/null 2>&1
do
  echo "still waiting for mysql"
  sleep 1
done

echo -e "\nmysql ready"
export DISPLAY=:0.0
/opt/jboss/wildfly/bin/standalone.sh -b 0.0.0.0 -bmanagement 0.0.0.0 -c standalone-full.xml
