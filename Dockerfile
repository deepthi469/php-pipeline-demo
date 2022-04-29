FROM quay.io/ksummersill2/ubuntu-wget:1.0.0
RUN mkdir -p /nmap/home/
RUN echo "Install nmap"
RUN apt-get install sudo
RUN apt-get install nmap -y
RUN whoami
RUN sudo nmap $(inputs.params.targetIP) && \
sudo nmap $(inputs.params.targetIP) -O && \
sudo nmap $(inputs.params.targetIP) -sT && \
sudo nmap $(inputs.params.targetIP) -p http,https && \
sudo nmap $(inputs.params.targetIP) -sL && \
sudo nmap $(inputs.params.targetIP) -sV && \
sudo nmap $(inputs.params.targetIP) -f -oX /nmap/home/dast-report.xml
RUN cat /nmap/home/dast-report.xml
RUN curl -v -u dm-vic:Password123 --upload-file /nmap/home/dast-report.xml http://nexus3-openshift-operators.apps.vapo-ppd.va.gov/repository/dm-vic/dast-report.$localdate.xml
RUN echo "DAST report Upload Complete"
CMD ["tail", "-f", "/dev/null"]
