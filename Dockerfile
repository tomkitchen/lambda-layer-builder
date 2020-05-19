FROM tkitchen00/lambda:latest

RUN yum install gcc openssl-devel bzip2-devel libffi-devel -y ; yum clean all
WORKDIR /usr/src
RUN wget https://www.python.org/ftp/python/3.7.2/Python-3.7.2.tgz
RUN tar xzf Python-3.7.2.tgz
WORKDIR Python-3.7.2
RUN ./configure --enable-optimizations
RUN make altinstall
RUN rm -rf /usr/src/Python-3.7.2
RUN yum install yum-utils rpmdevtools -y A; yum clean all
WORKDIR /home/ec2-user
RUN mkdir -p build
CMD ["/bin/bash", "mount/run.sh"]
