FROM wordpress:latest
MAINTAINER LolHens <pierrekisters@gmail.com>


ADD ["https://raw.githubusercontent.com/LolHens/docker-tools/master/bin/cleanimage", "/usr/local/bin/"]
RUN chmod +x "/usr/local/bin/cleanimage"

RUN apt-get update \
 && apt-get install -y \
      msmtp \
      nano \
 && echo 'sendmail_path=msmtp -t' >> /usr/local/etc/php/conf.d/sendmail.ini \
 && cleanimage

COPY ["msmtprc", "/etc/"]
