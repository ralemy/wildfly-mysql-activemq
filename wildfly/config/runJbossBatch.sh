#!/bin/bash

echo "================================================"
echo "============  Starting WildFly Server =========="
echo "================================================"

$WILDFLY/bin/standalone.sh -c standalone-full.xml > /dev/null &

echo  -ne "Waiting for server ..."
until `$JBOSS -c ":read-attribute(name=server-state)" 2> /dev/null | grep -q running`; do
  echo -ne .
  sleep 1
done

echo ""
echo "Sever Started, executing $1"
$JBOSS -c --file=/opt/$1

$JBOSS -c ":shutdown"
rm -rf $STANDALONE/configuration/standalone_xml_history
