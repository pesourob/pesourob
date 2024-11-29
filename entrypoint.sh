#!/bin/bash

echo "Starting server"
/opt/ibm/wlp/bin/server start controller && tail -f /logs/messages.log 

echo "Creating directory /hello"
mkdir -p /hello

echo "Running collective command"
/opt/ibm/wlp/bin/collective create controller --keystorePassword=password123 --createConfigFile=/opt/ibm/wlp/usr/servers/controller/collective-create-include.xml --hostName=websphere-liberty-controller

echo "Stopping server"
/opt/ibm/wlp/bin/server stop controller && tail -f /logs/messages.log
/opt/ibm/wlp/bin/server start controller && tail -f /logs/messages.log 
