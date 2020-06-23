FROM centos:7
MAINTAINER "Peter Mumenthaler" <pmumenthaler@gmail.com>
RUN curl -Lsf -o /tmp/logitechmediaserver.noarch.rpm http://downloads.slimdevices.com/LogitechMediaServer_v7.9.0/logitechmediaserver-7.9.0-1.noarch.rpm
#housekeeping
RUN yum install -y /tmp/logitechmediaserver.noarch.rpm && rm -f /tmp/logitechmediaserver.noarch.rpm
RUN yum install -y perl-CGI.noarch perl-Digest-MD5.x86_64 && yum clean all -y
RUN ln -s /usr/lib/perl5/vendor_perl/Slim /usr/lib64/perl5/Slim
ENV LANG=en_US.UTF-8 \
#    SQUEEZEBOX_USER="squeezeboxserver" \ 
    SQUEEZEBOX_HOME="/usr/libexec" \ 
    SQUEEZEBOX_CFG_DIR="/var/lib/squeezeboxserver/prefs" \ 
    SQUEEZEBOX_LOG_DIR="/var/log/squeezeboxserver" \ 
    SQUEEZEBOX_CACHE_DIR="/var/lib/squeezeboxserver/cache" \ 
    SQUEEZEBOX_CHARSET="utf8" \ 
    SQUEEZEBOX_ARGS="--daemon --prefsdir=$SQUEEZEBOX_CFG_DIR --logdir=$SQUEEZEBOX_LOG_DIR --cachedir=$SQUEEZEBOX_CACHE_DIR --charset=$SQUEEZEBOX_CHARSET --user=$SQUEEZEBOX_USER"
# fix permissions after installation
RUN touch /var/log/squeezeboxserver/perfmon.log && \ 
touch /var/log/squeezeboxserver/server.log && \ 
touch /var/log/squeezeboxserver/spotifyd.log
RUN chgrp -R 0  /var/log/squeezeboxserver && \ 
chmod -R g=u  /var/lib/squeezeboxserver
EXPOSE 3483 3483/udp 9000 9090
USER 1001
ENTRYPOINT ["perl","/usr/libexec/squeezeboxserver" ,"$SQUEEZEBOX_ARGS"]


