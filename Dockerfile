FROM amazonlinux:2

RUN yum update -y
# install pip and requirements
RUN yum install python3-3.7.1-9.amzn2.0.1 python3-pip-9.0.3-1.amzn2.0.1 python3-devel-3.7.1-9.amzn2.0.1 python3-setuptools rsync tar -y
RUN pip3.7 install virtualenv


# install requirements
RUN mkdir /build
WORKDIR /build
COPY pack-it.sh /pack-it.sh
RUN chmod +x /pack-it.sh
CMD /pack-it.sh