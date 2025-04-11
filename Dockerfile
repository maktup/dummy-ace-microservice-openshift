#FROM ibmcom/ace-server:11.0.0.11-r2-20210303-133203-amd64
#FROM cp.icr.io/cp/appc/ace:13.0.2.1-r1
#USER root
#COPY compilado /home/aceuser/bars
#RUN  chmod -R ugo+rwx /home/aceuser
#USER 1000
#RUN ace_compile_bars.sh
#USER root
#RUN  chmod -R ugo+rwx /home/aceuser
#USER 1000
FROM cp.icr.io/cp/appc/ace:12.0.9.0-r1@sha256:0e03de28d175e15238896b1ae00b54ddda6a46b793173f9a7707187d6b58202e
USER root
COPY *.bar /tmp
RUN export LICENSE=accept \
    && . /opt/ibm/ace-12/server/bin/mqsiprofile && set -x && for FILE in /tmp/*.bar; do echo "$FILE" >> /tmp/deploys \
    && ibmint package --compile-maps-and-schemas --input-bar-file "$FILE" --output-bar-file /tmp/temp.bar  2>&1 | tee -a /tmp/deploys \
    && ibmint deploy --input-bar-file /tmp/temp.bar --output-work-directory /home/aceuser/ace-server/ 2>&1 | tee -a /tmp/deploys; done \
    && ibmint optimize server --work-dir /home/aceuser/ace-server \
    && chmod -R ugo+rwx /home/aceuser/
USER 1001
