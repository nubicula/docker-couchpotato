FROM nubicula/base
MAINTAINER nubicula

ENV LANG='en_US.UTF-8' \
    LANGUAGE='en_US.UTF-8' \
    TERM='xterm'

RUN apk -U upgrade && \
    apk -U add \
        ca-certificates git \
        py-pip ca-certificates git python py-libxml2 py-lxml py-pip  \
        make gcc g++ python-dev openssl-dev libffi-dev \
    && \
    pip --no-cache-dir install pyopenssl && \
    git clone https://github.com/RuudBurger/CouchPotatoServer.git /CouchPotatoServer && \
    apk del make gcc g++ python-dev && \
    rm -rf /tmp/src && \
    rm -rf /var/cache/apk/*

VOLUME ["/config", "/media"]

ADD ./start.sh /start.sh
RUN chmod u+x  /start.sh

EXPOSE 8072

CMD ["/start.sh"]
