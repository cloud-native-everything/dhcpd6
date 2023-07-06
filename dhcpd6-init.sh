#!/bin/sh

# Start DHCPv6 server
/usr/sbin/dhcpd -6 -f -d --no-pid -cf /etc/dhcp/dhcpd6.conf &

