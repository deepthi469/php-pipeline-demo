FROM quay.io/ksummersill2/ubuntu-wget:1.0.0
RUN mkdir -p /nmap/home/
RUN echo "Install nmap"
RUN apt-get install sudo
RUN apt-get install nmap -y
RUN whoami
# ENV inputs.params.targetIP 127.0.0.1
RUN nmap 127.0.0.1
RUN nmap 127.0.0.1
RUN nmap 127.0.0.1 -O 
RUN nmap 127.0.0.1 -sT
RUN nmap 127.0.0.1 -p http,https
RUN nmap 127.0.0.1 -sL
RUN nmap 127.0.0.1 -sV
RUN nmap 127.0.0.1 -f -oX /nmap/home/dast-report.xml
RUN cat /nmap/home/dast-report.xml
RUN curl -v -u dm-vic:Password123 --upload-file /nmap/home/dast-report.xml http://nexus3-openshift-operators.apps.vapo-ppd.va.gov/repository/dm-vic/dast-report.$localdate.xml
RUN echo "DAST report Upload Complete"
CMD ["tail", "-f", "/dev/null"]
