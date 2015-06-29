#!/bin/bash
#
# /etc/init.d/<container name>
#
# description: System V script for Docker Containers.
# Name this file with the container name and enable it with chkconfig.
# Make sure this runs after Docker service is up.
#
# chkconfig: 2345 96 94

# Source function library.
. /etc/rc.d/init.d/functions

FILE=`basename "$0"`

case "$1" in
        start)
                echo -n "Starting $FILE service: "
                /usr/bin/docker start $FILE
                touch /var/lock/subsys/$FILE
        ;;
        stop)
                echo -n "Shutting down $FILE service: "
                /usr/bin/docker stop $FILE
                rm -f /var/lock/subsys/$FILE
        ;;
        status)
                /usr/bin/docker inspect $FILE
        ;;
        restart)
                /usr/bin/docker restart $FILE
        ;;
        *)
                echo "Usage: $FILE {start|stop|status|restart}"
                exit 1
        ;;
esac
