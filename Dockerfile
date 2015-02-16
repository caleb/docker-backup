FROM ruby:2.2

MAINTAINER Caleb Land <caleb@land.fm>

ENV DCRON_VERSION=4.5

ADD https://github.com/caleb/docker-helpers/archive/master.tar.gz /tmp/helpers.tar.gz
ADD https://raw.githubusercontent.com/caleb/mo/master/mo /usr/local/bin/mo
ADD http://www.jimpryor.net/linux/releases/dcron-${DCRON_VERSION}.tar.gz /dcron.tar.gz

RUN mkdir -p /helpers \
&& tar xzf /tmp/helpers.tar.gz --strip-components=1 -C / docker-helpers-master/helpers \
&& rm /tmp/helpers.tar.gz \
&& chmod +x /usr/local/bin/mo

RUN gem install backup
RUN groupadd --system crond

RUN tar xzf dcron.tar.gz -C / \
&& cd /dcron-${DCRON_VERSION} \
&& make PREFIX=/usr CRONTAB_GROUP=crond \
&& make install \
&& cd / \
&& rm -rf /dcron-${DCRON_VERSION}

RUN apt-get update
RUN apt-get install -y msmtp
RUN rm -rf /var/lib/apt/lists/*

ADD msmtprc.mo           /etc/msmtprc.mo
ADD docker-entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]

CMD [ "/usr/sbin/crond", "-f" ]
