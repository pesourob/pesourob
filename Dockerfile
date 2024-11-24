# Use the base image WebSphere Liberty
FROM websphere-liberty:latest

MAINTAINER robert.pesout@tietoevry.com

USER root

# Set the working directory
WORKDIR /opt/ibm/wlp/bin

# Install vim and create the server
RUN apt-get update && apt install -y vim && apt-get clean && rm -rf /var/lib/apt/lists/* && \
    ./server create controller && \
    #./collective create controller --keystorePassword=password123 --createConfigFile=/opt/ibm/wlp/usr/servers/controller/ --hostName=$HOSTNAME && \
    chmod -R g+rw /config && \
    chown -R 1001:0 /logs && \
    chmod -R g+rw /logs && \
    chown -R 1001:0 /opt/ibm/wlp/usr && \
    chmod -R g+rw /opt/ibm/wlp/usr && \
    chmod -R u+rw /opt/ibm/wlp/usr && \
    chown -R 1001:0 /opt/ibm/wlp/output && \
    chmod -R g+rw /opt/ibm/wlp/output && \
    chown -R 1001:0 /etc/wlp && \
    chmod -R g+rw /etc/wlp
    
COPY --chown=1001:0 server.xml /opt/ibm/wlp/usr/servers/controller/
COPY --chown=1001:0 collective-create-include.xml /opt/ibm/wlp/usr/servers/controller/

# Start the server
CMD /opt/ibm/wlp/bin/server start controller && tail -f /logs/messages.log && collective create controller --keystorePassword=password123 --hostName=$HOSTNAME 

# Expose necessary ports
EXPOSE 9080 9443

