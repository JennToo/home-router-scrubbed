#!/bin/bash
IF_WAN=eth0
IF_ROUTER=eth1

CONFIG_OPTIONS=(
  --restart-dhcp
  --ignore-when-wan-up
  --ignore-logoff
  --ping-gateway
)

DAEMON_OPTIONS=(
  --daemon
  --pidfile /var/run/eap_proxy.pid
  --syslog
)

if test -f /var/run/eap_proxy.pid; then
  kill "$(head -1 /var/run/eap_proxy.pid)" 2>/dev/null
fi

/usr/bin/python /config/scripts/eap_proxy.py \
    "$IF_WAN" "$IF_ROUTER" "${CONFIG_OPTIONS[@]}" "${DAEMON_OPTIONS[@]}" &
