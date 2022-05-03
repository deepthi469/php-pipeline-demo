FROM quay.io/ksummersill2/ubuntu-wget:1.0.0
RUN mkdir -p /nmap/home/
RUN echo "Install nmap"
RUN apt-get install sudo
RUN apt-get install nmap -y
RUN whoami
# ENV inputs.params.targetIP 8.8.8.8
RUN nmap 8.8.8.8 && nmap 8.8.8.8 -O && nmap 8.8.8.8 -sT && nmap 8.8.8.8 -p http,https && nmap 8.8.8.8 -sL && nmap 8.8.8.8 -sV && nmap 8.8.8.8 -f -oX /nmap/home/dast-report.txt cat /nmap/home/dast-report.txt
RUN curl -v -u dm-vic:Password123 --upload-file /nmap/home/dast-report.txt http://nexus3-openshift-operators.apps.vapo-ppd.va.gov/repository/dm-vic/dast-report.txt
RUN echo "DAST report Upload Complete"
CMD ["tail", "-f", "/dev/null"]
