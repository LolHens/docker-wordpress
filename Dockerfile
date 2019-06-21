FROM wordpress:latest
MAINTAINER LolHens <pierrekisters@gmail.com>


ADD ["https://raw.githubusercontent.com/LolHens/docker-tools/master/bin/cleanimage", "/usr/local/bin/"]
RUN chmod +x "/usr/local/bin/cleanimage"

RUN echo 'postfix postfix/main_mailer_type select Internet Site' | debconf-set-selections \
 && echo 'postfix postfix/mailname string gitlab.example.com' | debconf-set-selections \
 && apt-get update \
 && apt-get install -y \
      rsyslog \
      postfix \
      mailutils \
      dnsutils \
 && sed -i '/exec "$@"/ i\# Start postfix service.' /usr/local/bin/docker-entrypoint.sh \
 && sed -i '/exec "$@"/ i\service rsyslog start' /usr/local/bin/docker-entrypoint.sh \
 && sed -i '/exec "$@"/ i\service postfix start' /usr/local/bin/docker-entrypoint.sh \
 && sed -i '/exec "$@"/ i\\' /usr/local/bin/docker-entrypoint.sh \
 && cleanimage
