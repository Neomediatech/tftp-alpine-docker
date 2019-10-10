FROM alpine:3.10

LABEL maintainer="docker-dario@neomediatech.it"

RUN apk update && apk upgrade && \ 
    apk add --no-cache tzdata tftp-hpa bash tini rsyslog && \
    cp /usr/share/zoneinfo/Europe/Rome /etc/localtime && \
    rm -rf /usr/local/share/doc /usr/local/share/man

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

VOLUME /var/tftpboot
EXPOSE 69/udp
EXPOSE 6969:6999/udp

ENTRYPOINT ["/entrypoint.sh"]

CMD ["in.tftpd", "-4", "-vvv", "--foreground", "--secure", "-p", "/var/tftpboot", "-R", "6969:6999"]
