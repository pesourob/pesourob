#!/bin/bash

/opt/ibm/wlp/bin/server start controller && tail -f /logs/messages.log 

mkdir -p /hello

# Spustit kolektivní příkaz

/opt/ibm/wlp/bin/collective create controller --keystorePassword=password123 --createConfigFile=/opt/ibm/wlp/usr/servers/controller/ --hostName=websphere-liberty-controller

/opt/ibm/wlp/bin/server stop controller && tail -f /logs/messages.log 
