#!/bin/bash

# Spustit kolektivní příkaz

/opt/ibm/wlp/bin/collective create controller --keystorePassword=password123 --createConfigFile=/opt/ibm/wlp/usr/servers/controller/ --hostName=websphere-liberty-controller

chown -R 1001:0 /opt/ibm/wlp/usr
chmod -R o+rwx /opt/ibm/wlp/usr/servers/controller/

#sed -i 's/<quickStartSecurity userName="" userPassword="" />/<quickStartSecurity userName="admin" userPassword="password123"/>/' /opt/ibm/wlp/usr/servers/controller/collective-create-include.xml
