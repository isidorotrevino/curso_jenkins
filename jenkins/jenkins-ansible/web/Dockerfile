FROM serverbee/nginx-php-fpm-72-centos7

COPY ./conf/nginx.repo /etc/yum.repos.d/nginx.repo

#RUN                                                                          \
#  dnf clean all && rm -r /var/cache/dnf  && dnf upgrade -y && dnf update -y  \
#  dnf -y install nginx openssl --enablerepo=nginx                         && \
#  yum -y install --skip-broken https://repo.ius.io/ius-release-el7.rpm    && \
#  dnf install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm && \
#  dnf -y install                                                             \
#    php71u-fpm                                                               \
#    php71u-cli                                                               \
#    php71u-mysqlnd                                                           \
#    php71u-soap                                                              \
#    php71u-xml                                                               \
#    php71u-zip                                                               \
#    php71u-json                                                              \
#    php71u-mcrypt                                                            \
#    php71u-mbstring                                                          \
#    php71u-zip                                                               \
#    php71u-gd                                                                \
#      && yum clean all

USER root
# Update packages
RUN yum -y update

# Install EPEL
RUN yum install -y epel-release

# Install, configure and start Nginx
RUN echo "[nginx]" > /etc/yum.repos.d/nginx.repo
RUN echo "name=nginx repo" >> /etc/yum.repos.d/nginx.repo
RUN echo "baseurl=http://nginx.org/packages/centos/7/\$basearch" >> /etc/yum.repos.d/nginx.repo
RUN echo "gpgcheck=0" >> /etc/yum.repos.d/nginx.repo
RUN echo "enabled=1" >> /etc/yum.repos.d/nginx.repo
RUN yum install -y nginx-1.12.1

# Install, configure and start PHP-FPM and XDebug
RUN yum install -y http://rpms.remirepo.net/enterprise/remi-release-7.rpm
RUN yum install -y --enablerepo=remi --enablerepo=remi-php71 php-fpm php-mysql php-mbstring php-devel php-pear
RUN yum install -y gcc gcc-c++ autoconf automake
RUN pecl install Xdebug
RUN sed -i '/^;cgi.fix_pathinfo=1$/c\cgi.fix_pathinfo=0' /etc/php.ini
RUN sed -i '/^user\s=\sapache$/c\user = nginx' /etc/php-fpm.d/www.conf
RUN sed -i '/^group\s=\sapache$/c\group = nginx' /etc/php-fpm.d/www.conf
RUN mkdir /run/php-fpm

EXPOSE 80 443 3306


EXPOSE 80 443

VOLUME /var/www/html /var/log/nginx /var/log/php-fpm /var/lib/php-fpm

COPY ./conf/nginx.conf /etc/nginx/conf.d/default.conf

COPY ./bin/start.sh /start.sh

RUN chmod +x /start.sh

CMD /start.sh

