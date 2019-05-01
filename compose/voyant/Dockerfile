FROM openjdk:13-alpine

RUN mkdir -p /var/www/voyant

WORKDIR /var/www/voyant
RUN wget https://github.com/sgsinclair/VoyantServer/releases/download/2.4.0-M17/VoyantServer2_4-M17.zip
RUN unzip VoyantServer2_4-M17.zip && rm VoyantServer2_4-M17.zip
RUN mv VoyantServer2_4-M17/* . && rmdir VoyantServer2_4-M17

# Workaround from https://github.com/sgsinclair/VoyantServer/issues/17#issuecomment-433812114
COPY pre_app_patched.jsp _app/resources/jsp/pre_app.jsp




