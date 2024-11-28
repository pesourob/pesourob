#!/bin/bash

# Upravit soubor pomocí sed
#sed -i "s/<variable name=\"defaultHostName\" value=\"[^\"]*\" \/>/<variable name=\"defaultHostName\" value=\"$HOSTNAME\" \/>/" /opt/ibm/wlp/usr/servers/controller/collective-create-include.xml

#./server create controller && \

# Spustit kolektivní příkaz
#collective create controller --keystorePassword=password123 --createConfigFile=/opt/ibm/wlp/usr/servers/controller/ --hostName=$HOSTNAME

/opt/ibm/wlp/bin/server create controller

/opt/ibm/wlp/bin/collective create controller --keystorePassword=password123 --createConfigFile=/opt/ibm/wlp/usr/servers/controller/ --hostName=websphere-liberty-controller

chown -R 1001:0 /opt/ibm/wlp/usr
chmod -R o+rwx /opt/ibm/wlp/usr/servers/controller/


#sed -i 's/<quickStartSecurity userName="" userPassword="" />/<quickStartSecurity userName="admin" userPassword="password123"/>/' /opt/ibm/wlp/usr/servers/controller/collective-create-include.xml

# Start the server
/opt/ibm/wlp/bin/server start controller

# Udržet kontejner běžící
tail -f /logs/messages.log
