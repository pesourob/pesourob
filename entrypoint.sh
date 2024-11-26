#!/bin/bash

USERNAME=$USER
USER_UID=$UID
HOME_DIR=/home/$USER

mkdir -p $HOME/.ssh
chown -R $USER_UID:1001 $HOME_DIR/.ssh
chmod -R 777 /home/$USERNAME

# Spustit kolektivní příkaz
collective create controller --keystorePassword=password123 --hostName=$HOSTNAME

# Start the server
/opt/ibm/wlp/bin/server start controller

# Upravit soubor pomocí sed
sed -i "s/<variable name=\"defaultHostName\" value=\"[^\"]*\" \/>/<variable name=\"defaultHostName\" value=\"$HOSTNAME\" \/>/" /opt/ibm/wlp/usr/servers/controller/collective-create-include.xml

# Udržet kontejner běžící
tail -f /logs/messages.log
