#
# Dockerfile - Facebook HHVM FastCGI
#
# - Build
# git clone https://github.com/ruo91/docker-facebook-hhvm /opt/docker-facebook-hhvm
# docker build --rm -t hhvm:source /opt/docker-facebook-hhvm/hhvm-source
#
# - Run
# docker run -d --name="hhvm" -p 9000:9000 -v /tmp:/tmp -v /home:/home hhvm:source
#

FROM     ubuntu:14.04
MAINTAINER Yongbok Kim <ruo91@yongbok.net>

# Last Package Update & Install
RUN apt-get update && apt-get install -y git supervisor \
 autoconf automake binutils-dev build-essential cmake g++ git \
 libboost-dev libboost-filesystem-dev libboost-program-options-dev libboost-regex-dev \
 libboost-system-dev libboost-thread-dev libbz2-dev libc-client-dev libldap2-dev \
 libc-client2007e-dev libcap-dev libcurl4-openssl-dev libdwarf-dev libelf-dev \
 libexpat-dev libgd2-xpm-dev libgoogle-glog-dev libgoogle-perftools-dev libicu-dev \
 libjemalloc-dev libmcrypt-dev libmemcached-dev libmysqlclient-dev libncurses-dev \
 libonig-dev libpcre3-dev libreadline-dev libtbb-dev libtool libxml2-dev zlib1g-dev \
 libevent-dev libmagickwand-dev libinotifytools0-dev libiconv-hook-dev libedit-dev \
 libiberty-dev libxslt1-dev ocaml-native-compilers php5-imagick libyaml-dev libgmp10

# HHVM
ENV SRC_DIR /opt
RUN cd $SRC_DIR && git clone git://github.com/facebook/hhvm.git \
 && cd hhvm && git submodule update --init --recursive && cmake . && make && make install \
 && mkdir /etc/hhvm && rm -rf $SRC_DIR/hhvm

# ADD in the "/etc/hhvm" directory
ADD conf/php.ini	/etc/hhvm/php.ini
ADD conf/server.ini	/etc/hhvm/server.ini

# https://github.com/facebook/hhvm/issues/3112
RUN echo 'export LANG=C' >> /etc/profile \
 && echo 'export LC_ALL=C' >> /etc/profile
 
# Supervisor
RUN mkdir -p /var/log/supervisor
ADD conf/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Port
EXPOSE 9000

# Daemon
CMD ["/usr/bin/supervisord"]
