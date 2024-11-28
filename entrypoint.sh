#!/bin/bash

# Upravit soubor pomocí sed
#sed -i "s/<variable name=\"defaultHostName\" value=\"[^\"]*\" \/>/<variable name=\"defaultHostName\" value=\"$HOSTNAME\" \/>/" /opt/ibm/wlp/usr/servers/controller/collective-create-include.xml

#./server create controller && \

# Spustit kolektivní příkaz
#collective create controller --keystorePassword=password123 --createConfigFile=/opt/ibm/wlp/usr/servers/controller/ --hostName=$HOSTNAME

collective create controller --keystorePassword=password123 --createConfigFile=/opt/ibm/wlp/usr/servers/controller/ --hostName=websphere-liberty-controller-0.websphere-liberty-controller.pesourob-was-liberty.svc.cluster.local

#sed -i 's/<quickStartSecurity userName="" userPassword="" />/<quickStartSecurity userName="admin" userPassword="password123"/>/' /opt/ibm/wlp/usr/servers/controller/collective-create-include.xml

# Start the server
/opt/ibm/wlp/bin/server start controller

# Udržet kontejner běžící
tail -f /logs/messages.log
