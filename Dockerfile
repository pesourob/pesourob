# Použijte základní obraz WebSphere Liberty
FROM websphere-liberty:latest

# Nastavte pracovní adresář
WORKDIR /opt/ibm/wlp/bin

MAINTAINER robert.pesout@tietoevry.com

USER root

# Zkopírujte soubor server.xml do kontejneru (pokud máte vlastní konfiguraci)
#COPY server.xml /config/

# Nainstalujte požadované funkce
RUN apt-get install -y vim && apt-get clean && rm -rf /var/lib/apt/lists/* \
    ./installUtility install collectiveController-1.0 collectiveMember-1.0 clusterMember-1.0 websocket-1.1 restConnector-2.0 ssl-1.0 localConnector-1.0 adminCenter-1.0 --acceptLicense \
    ./server create controller \
    && chmod -R g+rw /config \
    && chown -R 1001:0 /logs \
    && chmod -R g+rw /logs \
    && chown -R 1001:0 /opt/ol/wlp/usr \
    && chmod -R g+rw /opt/ol/wlp/usr \
    && chown -R 1001:0 /opt/ol/wlp/output \
    && chmod -R g+rw /opt/ol/wlp/output \
    && chown -R 1001:0 /opt/ol/helpers \
    && chmod -R g+rw /opt/ol/helpers \
    && chown -R 1001:0 /opt/ol/fixes \
    && chmod -R g+rwx /opt/ol/fixes \
    && chown -R 1001:0 /etc/wlp \
    && chmod -R g+rw /etc/wlp 

#./collective create DMGR --keystorePassword=wasadmin --createConfigFile=/opt/ibm/wlp/usr/servers/DMGR/controller.xml 

# Spusťte server
CMD /opt/ibm/wlp/bin/server start controller && tail -f /logs/messages.log 

# Exponujte potřebné porty
EXPOSE 9080 9443
