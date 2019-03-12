FROM alpine:3.9

LABEL maintainer="docker-dario@neomediatech.it"

RUN apk update && apk upgrade && \ 
    apk add --no-cache tzdata tftp-hpa && \
    cp /usr/share/zoneinfo/Europe/Rome /etc/localtime

VOLUME /tftpboot
EXPOSE 69/udp

ENTRYPOINT ["in.tftpd"]
CMD ["--verbose", "--foreground", "--secure", "--create", "--user", "root", "/tftpboot"]
