#!/bin/bash
echo "watch gps: cgps -s, watch ntp server: chronyc sources -v"
echo "starting gpsd..."
gpsd -n /dev/ttyACM0 -F /var/run/gpsd.sock
echo "starting chronyd..."
pkill chronyd || chronyd -d -s
echo "service running..."
chronyc sources -v
tail -f /dev/null
