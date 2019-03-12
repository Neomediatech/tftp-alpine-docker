FROM alpine:3.9

LABEL maintainer="docker-dario@neomediatech.it"

RUN apk update && apk upgrade && \ 
    apk add --no-cache tzdata tftp-hpa bash tini rsyslog && \
    cp /usr/share/zoneinfo/Europe/Rome /etc/localtime

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

VOLUME /tftpboot
EXPOSE 69/udp

ENTRYPOINT ["/entrypoint.sh"]

#CMD ["tini", "--", "in.tftpd", "-4", "-vvv", "--foreground", "--secure", "-p", "/tftpboot"]
CMD ["in.tftpd", "-4", "-vvv", "--foreground", "--secure", "-p", "/tftpboot"]
