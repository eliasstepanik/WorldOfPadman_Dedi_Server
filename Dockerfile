# https://worldofpadman.net/en/tutorials/create-a-dedicated-wop-server/ 


FROM ubuntu:22.04

EXPOSE 27960/udp


RUN echo 'APT::Install-Suggests "0";' >> /etc/apt/apt.conf.d/00-docker
RUN echo 'APT::Install-Recommends "0";' >> /etc/apt/apt.conf.d/00-docker
RUN DEBIAN_FRONTEND=noninteractive \
  apt-get update \
  && apt-get install -y python3 \
  && apt-get install -y unzip  \
  && apt-get install -y wget

RUN mkdir /wop
RUN mkdir /wop/server
RUN mkdir /wop/server/data
RUN mkdir /wop/server/data/wop

WORKDIR /tmp
RUN wget --no-check-certificate https://res.sailehd.de/wop-1.6.2-full-unified.zip
RUN unzip /tmp/wop-1.6.2-full-unified.zip -d /tmp/
RUN mv /tmp/worldofpadman-1-6-2/* /wop/server/data/

WORKDIR /wop/server
    
ADD start-* /wop/server/
ADD config/ /wop/server/data/wop/

RUN ["chmod", "+x", "start-wop.sh"]
CMD /wop/server/start-wop.sh
