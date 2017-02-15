FROM ubuntu:latest
MAINTAINER Scott Enderle <enderlej@upenn.edu>

RUN apt-get update \
    && apt-get install default-jdk supervisor unzip \
    && mkdir /var/www/voyant \
    && cd /var/www/voyant \
    && wget https://github.com/sgsinclair/VoyantServer/releases/download/2.2.0-M2/VoyantServer2_2-M2.zip \
    && unzip VoyantServer2_2-M2.zip \


