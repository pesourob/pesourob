# Použití základního obrazu WebSphere Liberty
FROM websphere-liberty:latest

# Informace o správci
LABEL maintainer="robert.pesout@tietoevry.com"

# Použití uživatele root pro konfiguraci
USER root

# Nastavení pracovního adresáře
WORKDIR /opt/ibm/wlp/bin

# Kopírování potřebných souborů
COPY entrypoint.sh /tmp/

# Instalace balíčků a příprava prostředí
RUN apt-get update && apt-get install -y vim && \
    ./installUtility install collectivecontroller-1.0 --acceptLicense && \
    mkdir -p /.ssh && touch /.ssh/authorized_keys && \
    chmod 660 /.ssh/authorized_keys && \
    chown -R 1001:0 /.ssh && \
    ./server create controller && \
    chmod +x /tmp/entrypoint.sh && \
    chown -R 1001:0 /tmp/entrypoint.sh && \
    ln -s /opt/ibm/wlp/usr/servers/controller /config && \
    chmod -R g+rw /logs /opt/ibm/wlp/usr /opt/ibm/wlp/output /etc/wlp && \
    chown -R 1001:0 /logs /opt/ibm/wlp/usr /opt/ibm/wlp/output /etc/wlp && \
    apt-get clean && rm -rf /var/lib/apt/lists/* 

COPY --chown=1001:0 server.xml /opt/ibm/wlp/usr/servers/controller/

# Nastavení entrypoint skriptu
ENTRYPOINT ["/tmp/entrypoint.sh"]

# Otevření potřebných portů
EXPOSE 9080 9443
