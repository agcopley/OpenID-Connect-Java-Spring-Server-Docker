FROM maven:3.6.3-jdk-11
MAINTAINER Andrew Copley

ENV HOME /opt/mitreidc


# default to the master (development) branch. Override from docker build --build-arg if you want.
ARG BRANCH=master

## Prerequisites: Add user, BouncyCastle
RUN echo "#!/bin/sh\nexit 0" > /usr/sbin/policy-rc.d
RUN apt-get update && apt-get upgrade -y && apt-get install -y git wget sudo && apt-get clean && \	
	mkdir -p $HOME && \
	groupadd -r mitreidc && \
	useradd -r -s /bin/bash -g mitreidc -d $HOME -c "MitreIDC User" mitreidc && \
	echo "mitreidc ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
	chown -R mitreidc:mitreidc $HOME && \
	cd $JAVA_HOME/lib/ && \
	wget http://downloads.bouncycastle.org/java/bcprov-jdk15on-168.jar -nv && \
	cd $JAVA_HOME/conf/security && \
	echo 'security.provider.10=org.bouncycastle.jce.provider.BouncyCastleProvider' >> $JAVA_HOME/conf/security/java.security

# Install
USER mitreidc
WORKDIR $HOME
## get and build the latest production branch
RUN git clone --branch $BRANCH https://github.com/agcopley/OpenID-Connect-Java-Spring-Server.git . 



WORKDIR $HOME
RUN mvn -Dmaven.javadoc.skip=true -DskipTests clean install

# Preload Jetty dependencies
WORKDIR $HOME/openid-connect-server-webapp
RUN mvn -X -Djetty.skip=true jetty:run-war

EXPOSE 8080

CMD ["mvn", "jetty:run-war"]
