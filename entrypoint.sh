#!/bin/bash

echo "----------Starting server----------"
/opt/ibm/wlp/bin/server start controller 

if [[ ! -e /opt/ibm/wlp/usr/servers/controller/resources || ! -e /opt/ibm/wlp/usr/servers/controller/collective-create-include.xml ]]; then
    echo "----------Running collective command----------"
#    /opt/ibm/wlp/bin/collective create controller --keystorePassword=password123 --createConfigFile=/opt/ibm/wlp/usr/servers/controller/ --hostName=websphere-liberty-controller
else
    echo "----------Files exist, skipping collective create command----------"
fi

echo "----------Stopping server----------"
/opt/ibm/wlp/bin/server stop controller 

mkdir -p /controller

#Symbolic link
echo "----------Creating symbolic link----------"
ln -s /opt/ibm/wlp/usr/servers/controller /controller

echo "----------Starting server----------"
/opt/ibm/wlp/bin/server start controller && tail -f /logs/messages.log
