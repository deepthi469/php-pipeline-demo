FROM quay.io/ksummersill2/ubuntu-wget:1.0.0
RUN mkdir -p /nmap/home/
RUN echo "Install nmap"
RUN apt-get install sudo
RUN apt-get install nmap -y
RUN whoami
RUN sudo nmap $(inputs.params.targetIP) && \
RUN sudo nmap $(inputs.params.targetIP) -O && \
RUN sudo nmap $(inputs.params.targetIP) -sT && \
RUN sudo nmap $(inputs.params.targetIP) -p http,https && \
RUN sudo nmap $(inputs.params.targetIP) -sL && \
RUN sudo nmap $(inputs.params.targetIP) -sV && \
RUN sudo nmap $(inputs.params.targetIP) -f -oX /nmap/home/dast-report.xml
RUN cat /nmap/home/dast-report.xml
RUN curl -v -u dm-vic:Password123 --upload-file /nmap/home/dast-report.xml http://nexus3-openshift-operators.apps.vapo-ppd.va.gov/repository/dm-vic/dast-report.$localdate.xml
RUN echo "DAST report Upload Complete"
