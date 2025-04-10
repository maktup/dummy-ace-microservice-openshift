FROM ibmcom/ace-server:11.0.0.11-r2-20210303-133203-amd64
#FROM cp.icr.io/cp/appc/ace:13.0.2.1-r1
USER root
COPY compilado /home/aceuser/bars
RUN  chmod -R ugo+rwx /home/aceuser
USER 1000
RUN ace_compile_bars.sh
USER root
RUN  chmod -R ugo+rwx /home/aceuser
USER 1000
 
