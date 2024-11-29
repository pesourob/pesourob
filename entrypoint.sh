#!/bin/bash

echo "Starting server"
/opt/ibm/wlp/bin/server start controller 

echo "Running collective command"
/opt/ibm/wlp/bin/collective create controller --keystorePassword=password123 --createConfigFile=/opt/ibm/wlp/usr/servers/controller/ --hostName=websphere-liberty-controller

echo "Stopping server"
/opt/ibm/wlp/bin/server stop controller 
