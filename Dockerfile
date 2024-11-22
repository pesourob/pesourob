# Použijte základní obraz WebSphere Liberty
FROM websphere-liberty:latest

# Nastavte pracovní adresář
WORKDIR /opt/ibm/wlp/bin

MAINTAINER robert.pesout@tietoevry.com

USER root

# Zkopírujte soubor server.xml do kontejneru (pokud máte vlastní konfiguraci)
#COPY server.xml /config/

# Nainstalujte požadované funkce
RUN ./installUtility install collectiveController-1.0 collectiveMember-1.0 clusterMember-1.0 websocket-1.1 restConnector-2.0 ssl-1.0 localConnector-1.0 adminCenter-1.0 --acceptLicense && su - wasadmin 

#./collective create DMGR --keystorePassword=wasadmin --createConfigFile=/opt/ibm/wlp/usr/servers/DMGR/controller.xml 

# Spusťte server
CMD /opt/ibm/wlp/bin/server start defaultServer && tail -f /logs/messages.log && collective create controller --keystorePassword=adminpwd --createConfigFile --hostName=$HOSTNAME

# Exponujte potřebné porty
EXPOSE 9080 9443
