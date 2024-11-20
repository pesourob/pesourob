# Použijte základní obraz WebSphere Liberty
FROM websphere-liberty:latest

# Nastavte pracovní adresář
WORKDIR /opt/ibm/wlp/bin

MAINTAINER robert.pesout@tietoevry.com

# Zkopírujte soubor server.xml do kontejneru (pokud máte vlastní konfiguraci)
#COPY server.xml /config/

# Nainstalujte požadované funkce
RUN ./installUtility install collectiveController-1.0 collectiveMember-1.0 clusterMember-1.0 websocket-1.1 restConnector-2.0 ssl-1.0 localConnector-1.0 adminCenter-1.0 --acceptLicense && \
./server create DMGR && \
./collective create DMGR --keystorePassword=wasadmin --createConfigFile=/opt/ibm/wlp/usr/servers/DMGR/controller.xml && \
cp /opt/server.xml /opt/ibm/wlp/usr/servers/DMGR/server.xml && \
sed -i 's/<variable name="defaultHostName" value="localhost" \/>/<variable name="defaultHostName" value="DMGR" \/>/' /opt/ibm/wlp/usr/servers/DMGR/controller.xml
#sed -i 's/<quickStartSecurity userName="" userPassword=""\s*\/>/<quickStartSecurity userName="wasadmin" userPassword="wasadmin" \/>/' /opt/ibm/wlp/usr/servers/DMGR/controller.xml

# Exponujte potřebné porty
EXPOSE 9080 9443

# Spusťte server
CMD /opt/wlp/bin/server start DMGR ; tail -f /opt/wlp/usr/servers/DMGR/logs/messages.log


