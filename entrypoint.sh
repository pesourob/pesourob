#!/bin/bash

# Start the server
/opt/ibm/wlp/bin/server start controller

# Spustit kolektivní příkaz
collective create controller --keystorePassword=password123 --hostName=$HOSTNAME

# Upravit soubor pomocí sed
sed -i "s/<variable name=\"defaultHostName\" value=\"[^\"]*\" \/>/<variable name=\"defaultHostName\" value=\"$HOSTNAME\" \/>/" /opt/ibm/wlp/usr/servers/controller/collective-create-include.xml

# Udržet kontejner běžící
tail -f /logs/messages.log
