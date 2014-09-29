#
# Dockerfile - Facebook HHVM FastCGI
#
# - Build
# git clone https://github.com/ruo91/docker-facebook-hhvm /opt/docker-facebook-hhvm
# docker build --rm -t hhvm:packages /opt/docker-facebook-hhvm/hhvm-packages
#
# - Run
# docker run -d --name="hhvm" -p 9000:9000 -v /tmp:/tmp -v /home:/home hhvm:packages
#

FROM     ubuntu:14.04
MAINTAINER Yongbok Kim <ruo91@yongbok.net>

# Last Package Update & Install
RUN apt-get update && apt-get install -y wget supervisor add-apt-key

# HHVM
RUN wget -O - http://dl.hhvm.com/conf/hhvm.gpg.key | apt-key add - \
 && echo "deb http://dl.hhvm.com/ubuntu trusty main" > /etc/apt/sources.list.d/hhvm.list \
 && apt-get update && apt-get install -y hhvm libgmp10

# ADD in the "/etc/hhvm" directory
ADD conf/php.ini	/etc/hhvm/php.ini
ADD conf/server.ini	/etc/hhvm/server.ini
RUN sed -i "/^PIDFILE=/ s:.*:PIDFILE=/var/run/\$NAME.pid:" /etc/init.d/hhvm

# https://github.com/facebook/hhvm/issues/3112
RUN echo 'export LANG=C' >> /etc/profile \
 && echo 'export LC_ALL=C' >> /etc/profile \
 && echo '' >> /etc/profile

# Supervisor
RUN mkdir -p /var/log/supervisor
ADD conf/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Port
EXPOSE 9000

# Daemon
CMD ["/usr/bin/supervisord"]
