FROM wordpress:latest
MAINTAINER LolHens <pierrekisters@gmail.com>


ENV MSMTP_HOST smtp
ENV MSMTP_FROM example.com
ENV MSMTP_AUTH_ENABLED off
#ENV MSMTP_AUTH_USER
#ENV MSMTP_AUTH_PASSWORD


ADD ["https://raw.githubusercontent.com/LolHens/docker-tools/master/bin/cleanimage", "/usr/local/bin/"]
RUN chmod +x "/usr/local/bin/cleanimage"

COPY ["msmtprc_template", "/etc/"]

RUN apt-get update \
 && apt-get install -y \
      gettext \
      msmtp \
      nano \
 && echo 'sendmail_path=msmtp -t' >> /usr/local/etc/php/conf.d/sendmail.ini \
 && sed -i '/exec "$@"/ i\cat /etc/msmtprc_template | envsubst > /etc/msmtprc' /usr/local/bin/docker-entrypoint.sh \
 && sed -i '/exec "$@"/ i\\' /usr/local/bin/docker-entrypoint.sh \
 && cleanimage
