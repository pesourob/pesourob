FROM websphere-liberty:latest

LABEL maintainer="robert.pesout@tietoevry.com"

USER root

WORKDIR /opt/ibm/wlp/bin

COPY entrypoint.sh /tmp/

RUN apt-get update && apt-get install -y vim && apt-get install -y openssh-server openssh-client && apt-get install -y iputils-ping telnet net-tools && \
    ./installUtility install collectivecontroller-1.0 --acceptLicense && \
    mkdir -p /.ssh && touch /.ssh/authorized_keys && mkdir -p /var/run/sshd && \
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    chmod 660 /.ssh/authorized_keys && \
    chown -R 1001:0 /.ssh && \
    ./server create controller && \
    chmod +x /tmp/entrypoint.sh && \
    chown -R 1001:0 /tmp/entrypoint.sh && \
    ln -s /opt/ibm/wlp/usr/servers/controller /config && \
    chmod -R g+rw /logs /opt/ibm/wlp/usr /opt/ibm/wlp/output /etc/wlp && \
    chown -R 1001:0 /logs /opt/ibm/wlp/usr /opt/ibm/wlp/output /etc/wlp && \
    apt-get clean && rm -rf /var/lib/apt/lists/* && usermod --shell /bin/bash default && usermod -aG sudo default

COPY --chown=1001:0 server.xml /opt/ibm/wlp/usr/servers/controller/

USER default

# Nastavení entrypoint skriptu
ENTRYPOINT ["/tmp/entrypoint.sh"]

# Otevření potřebných portů
EXPOSE 9080 9443 22 2222
