# Use the base image WebSphere Liberty
FROM websphere-liberty:latest

MAINTAINER robert.pesout@tietoevry.com

USER root

# Set the working directory
WORKDIR /opt/ibm/wlp/bin

COPY collective-create-include.xml /tmp
COPY entrypoint.sh /tmp

# Install vim and create the server
RUN apt-get update && apt install -y vim && \
    ./server create controller && \
    cp -r /tmp/collective-create-include.xml /opt/ibm/wlp/usr/servers/controller/ && \
    chmod +x /tmp/entrypoint.sh && \
    chown -R 1001:0 /tmp/entrypoint.sh && \
    chmod -R u+rwx /tmp/entrypoint.sh && \
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
    useradd -m -d /home/user1000840000 -s /bin/bash -u 1000840000 user1000840000 
    
COPY --chown=1001:0 server.xml /opt/ibm/wlp/usr/servers/controller/

# Start the server
CMD /opt/ibm/wlp/bin/server start controller && tail -f /logs/messages.log 

# Start the server
ENTRYPOINT ["/tmp/entrypoint.sh"]

# Expose necessary ports
EXPOSE 9080 9443


# Expose necessary ports
EXPOSE 9080 9443

