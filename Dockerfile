FROM alpine

LABEL MAINTAINER "mgd <suporte@mgdtecnologia.com.br>"

ENV FRP_VERSION=v0.41.0

ADD entrypoint.sh /entrypoint.sh

RUN addgroup -S frp \
 && adduser -D -S -h /var/frp -s /sbin/nologin -G frp frp \
 && apk add --no-cache curl \
 && curl -fSL https://github.com/magadan/docker-frp/raw/master/frp_railway.tar.gz -o frp_railway.tar.gz \
 && tar -zxv -f frp_railway.tar.gz \
 && rm -rf frp_railway.tar.gz \
 && mv frp_railway /frp \
 && chown -R frp:frp /frp \
 && mv /entrypoint.sh /frp/

USER frp

WORKDIR /frp

EXPOSE 6000 7000 7500

CMD ["/frp/entrypoint.sh"]
