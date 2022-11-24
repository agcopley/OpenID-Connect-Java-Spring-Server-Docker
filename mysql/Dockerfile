FROM ubuntu:latest
MAINTAINER Roderick Rangel
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=America/Santiago
RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y mysql-server \
 && sed -i "s/127.0.0.1/0.0.0.0/g" /etc/mysql/mysql.conf.d/mysqld.cnf \
 && chown -R mysql:mysql /var/run/mysqld

VOLUME ["/var/lib/mysql"]

# setup our entry point
ADD init.sh /init.sh
RUN chmod 755 /*.sh
ENTRYPOINT ["/init.sh"]

EXPOSE 3306

CMD ["mysqld_safe"]
