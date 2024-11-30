#!/bin/bash

echo "----------Starting server----------"
/config/ibm/wlp/bin/server start controller 

if [[ ! -e /config/ibm/wlp/usr/servers/controller/resources || ! -e /config/ibm/wlp/usr/servers/controller/collective-create-include.xml ]]; then
    echo "----------Running collective command----------"
    /config/ibm/wlp/bin/collective create controller --keystorePassword=password123 --createConfigFile=/config/ibm/wlp/usr/servers/controller/ --hostName=websphere-liberty-controller
else
    echo "----------Files exist, skipping collective create command----------"
fi

echo "----------Stopping server----------"
/config/ibm/wlp/bin/server stop controller 

mkdir -p /controller

#Symbolic link
echo "----------Creating symbolic link----------"
#ln -s /config/ibm/wlp/usr/servers/controller /controller

echo "----------Starting server----------"
/config/ibm/wlp/bin/server start controller && tail -f /logs/messages.log
