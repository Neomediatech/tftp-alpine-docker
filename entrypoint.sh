#!/bin/bash

LOGFILE="/var/log/messages"

if [ ! -f $LOGFILE ]; then
    touch $LOGFILE
fi

syslogd 2>/dev/null
exec tail -f $LOGFILE &
exec "$@"
