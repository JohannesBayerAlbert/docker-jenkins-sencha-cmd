FROM jenkins

USER root

# Based on https://github.com/elmasse/docker-jenkins-sencha-cmd
MAINTAINER Johannes Bayer-Albert <info@johannesbayer.de>

RUN apt-get update && \
    apt-get install -y openjdk-8-jre ruby unzip libstdc++ tzdata bash ttf-dejavu fontconfig wget curl

RUN wget http://cdn.sencha.com/cmd/6.2.2/no-jre/SenchaCmd-6.2.2-linux-amd64.sh.zip -O senchacmd.zip && unzip senchacmd.zip && rm senchacmd.zip && chmod +x SenchaCmd-6.2.2.36-linux-amd64.sh
RUN ./SenchaCmd-6.2.2.36-linux-amd64.sh -q -dir /opt/sencha/cmd/6.2.2 -Dall=true
RUN rm SenchaCmd-6.2.2.36-linux-amd64.sh && chmod +x /opt/sencha/cmd/6.2.2/sencha

RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN chown -R jenkins:jenkins /opt/sencha/cmd/6.2.2/

ENV PATH /opt/sencha/cmd/6.2.2/bin:$PATH

USER jenkins

COPY plugins.txt /usr/share/jenkins/plugins.txt
RUN /usr/local/bin/install-plugins.sh /usr/share/jenkins/plugins.txt

WORKDIR /code

