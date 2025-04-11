#FROM cp.icr.io/cp/appc/ace:13.0.1.0-r1
#USER root
#COPY compilado/*.bar /tmp
#RUN export LICENSE=accept \
#    && . /opt/ibm/ace-13/server/bin/mqsiprofile \
#    && set -x && for FILE in /tmp/*.bar; do \
#       echo "$FILE" >> /tmp/deploys && \
#       ibmint package --compile-maps-and-schemas --input-bar-file "$FILE" --output-bar-file /tmp/temp.bar  2>&1 | tee -a /tmp/deploys && \
#       ibmint deploy --input-bar-file /tmp/temp.bar --output-work-directory /home/aceuser/ace-server/ 2>&1 | tee -a /tmp/deploys; done \
#    && ibmint optimize server --work-dir /home/aceuser/ace-server \
#    && chmod -R ugo+rwx /home/aceuser/ \
#    && chmod -R ugo+rwx /var/mqsi/
#USER 1001

FROM cp.icr.io/cp/appc/ace:12.0.12.11-r1@sha256:80a66965a03eff6edf7d22f147470d84c75d97b65262aaf10ebacd7f7d4c20ea
USER root
COPY compilado/*.bar /tmp
RUN export LICENSE=accept \
    && . /opt/ibm/ace-12/server/bin/mqsiprofile && set -x && for FILE in /tmp/*.bar; do echo "$FILE" >> /tmp/deploys \
    && ibmint package --compile-maps-and-schemas --input-bar-file "$FILE" --output-bar-file /tmp/temp.bar  2>&1 | tee -a /tmp/deploys \
    && ibmint deploy --input-bar-file /tmp/temp.bar --output-work-directory /home/aceuser/ace-server/ 2>&1 | tee -a /tmp/deploys; done \
    && ibmint optimize server --work-dir /home/aceuser/ace-server \
    && chmod -R ugo+rwx /home/aceuser/
USER 1001
