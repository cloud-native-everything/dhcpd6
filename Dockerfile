FROM alpine:latest

LABEL org.opencontainers.image.source https://github.com/cloud-native-everything/dhcpd6
RUN set -xe \
    && apk add --no-cache --purge -uU tzdata dhcp openrc \
    && touch /var/lib/dhcp/dhcpd6.leases \
    && rm -rf /var/cache/apk/* /tmp/*

RUN echo 'net.ipv6.conf.all.disable_ipv6=0' >> /etc/sysctl.conf \
    && echo 'net.ipv6.conf.default.disable_ipv6=0' >> /etc/sysctl.confa

VOLUME /etc/dhcp/
EXPOSE 67/udp 67/tcp
COPY dhcpd6-init.sh /dhcpd6-init.sh
ENTRYPOINT ["/sbin/init"]
