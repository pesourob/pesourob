#!/bin/bash

# Upravit soubor pomocí sed
#sed -i "s/<variable name=\"defaultHostName\" value=\"[^\"]*\" \/>/<variable name=\"defaultHostName\" value=\"$HOSTNAME\" \/>/" /opt/ibm/wlp/usr/servers/controller/collective-create-include.xml

# Spustit kolektivní příkaz
collective create controller --keystorePassword=password123 --createConfigFile=/opt/ibm/wlp/usr/servers/controller/ --hostName=$HOSTNAME

# Start the server
/opt/ibm/wlp/bin/server start controller

# Udržet kontejner běžící
tail -f /logs/messages.log
