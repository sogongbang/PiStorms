#!/bin/sh
### BEGIN INIT INFO
# Provides:          MSWeb
# Required-Start:    hostname $local_fs
# Required-Stop:
# Should-Start:
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Start/stop MSWeb
# Description:       This script starts/stops MSWeb.
### END INIT INFO

PATH=/sbin:/usr/sbin:/bin:/usr/bin
#. /lib/init/vars.sh

do_start () {
    sleep 1
    sudo python3 /var/www/web_api/MSWeb.py >/var/tmp/webapi.out 2>&1 &
    sleep 1
}

do_status() {
    ps -ef | grep MSWeb.py | grep -v grep
    return $?
}

case "$1" in
  start|"")
    do_start
    ;;
  restart|reload|force-reload)
    sudo kill -SIGKILL $(ps -aux | awk '/MSWeb.py/ && !/awk/ {print $2}' | tail -1) 2> /dev/null
    do_start
    exit 3
    ;;
  stop)
    sudo kill -SIGKILL $(ps -aux | awk '/MSWeb.py/ && !/awk/ {print $2}' | tail -1) 2> /dev/null
    ;;
  status)
    do_status
    ;;
  *)
    echo "Usage: MSWeb [start|stop|status|restart]" >&2
    exit 3
    ;;
esac

:
