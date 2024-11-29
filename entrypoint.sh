#!/bin/bash

/opt/ibm/wlp/bin/server start controller && tail -f /logs/messages.log 

# Spustit kolektivní příkaz

#/opt/ibm/wlp/bin/collective create controller --keystorePassword=password123 --createConfigFile=/opt/ibm/wlp/usr/servers/controller/ --hostName=websphere-liberty-controller

#Pouzitelne v Docker
#sed -i 's/<quickStartSecurity userName="" userPassword="" />/<quickStartSecurity userName="admin" userPassword="password123"/>/' /opt/ibm/wlp/usr/servers/controller/collective-create-include.xml
