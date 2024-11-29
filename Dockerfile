# Use the base image WebSphere Liberty
FROM websphere-liberty:latest

MAINTAINER robert.pesout@tietoevry.com

USER root

# Set working directory
WORKDIR /opt/ibm/wlp/bin

# Copy necessary files
COPY entrypoint.sh /tmp
COPY --chown=1001:0 server.xml /opt/ibm/wlp/usr/servers/member1/

# Install dependencies and configure server
RUN apt-get update && apt-get install -y vim && \
    mkdir -p /.ssh && touch /.ssh/authorized_keys && \
    chmod 700 /.ssh && chmod 770 /.ssh/authorized_keys && \
    ./server create member1 && \
    chmod +x /tmp/entrypoint.sh && \
    chown -R 1001:0 /tmp/entrypoint.sh /opt/ibm/wlp/usr /logs /opt/ibm/wlp/output /etc/wlp && \
    chmod -R g+rw /opt/ibm/wlp/usr /logs /opt/ibm/wlp/output /etc/wlp

COPY --chown=1001:0 server.xml /opt/ibm/wlp/usr/servers/member1/

# Switch to non-root user
USER 1001

# Expose necessary ports
EXPOSE 9080 9443

# Set entrypoint
ENTRYPOINT ["/tmp/entrypoint.sh"]

# Start the server
CMD ["/opt/ibm/wlp/bin/server", "start", "member1"]

