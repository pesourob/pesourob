#!/bin/bash

#/opt/ibm/wlp/bin/server start controller && tail -f /logs/messages.log 
/opt/ibm/wlp/bin/server start controller && tail -f /logs/messages.log  

# Spustit kolektivní příkaz

./collective create controller --keystorePassword=password123 --createConfigFile=/opt/ibm/wlp/usr/servers/controller/ --hostName=websphere-liberty-controller

/opt/ibm/wlp/bin/server start controller && tail -f /logs/messages.log 

/opt/ibm/wlp/bin/server stop controller && tail -f /logs/messages.log  
/opt/ibm/wlp/bin/server start controller && tail -f /logs/messages.log

#Pouzitelne v Docker
#sed -i 's/<quickStartSecurity userName="" userPassword="" />/<quickStartSecurity userName="admin" userPassword="password123"/>/' /opt/ibm/wlp/usr/servers/controller/collective-create-include.xm
