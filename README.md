# DHCPD6 server for containerlab

This repository provides a simple DHCPD6 server for use in containerlab. It was originally developed for a MAPT demo and is built from an Alpine image.

## Create image
To create the DHCPD6 server image, use the following command:
```shell
docker build -t ghcr.io/cloud-native-everything/dhcpd6:v2307 .
```

## Testing
You can test the DHCPD6 server by starting the lab using the provided topology file:

```bash
clab deploy -t topo.yml
```

## Customization
The DHCPD6 server can be customized by modifying the files in the dhcp folder:

### dhcpd6.conf
The dhcp/dhcpd6.conf file contains the configuration for the DHCPv6 server. By default, it includes two subnets and options for the MAPT use case:
```ruby
default-lease-time 600;
max-lease-time 7200; 
log-facility local7; 
option dhcp6.map-option code 95 = string;

subnet6 2001:db8:ffff:1::/64 {}

subnet6 2001:db8:ffff:2::/64 {
range6 2001:db8:ffff:2::1 2001:db8:ffff:2::1000;
prefix6 2001:db8:f1:: 2001:db8:f1:fff0:: /60;
option dhcp6.map-option 00:59:00:16:00:0c:18:c0:12:01:00:30:20:01:0d:b8:00:00:00:5d:00:04:06:00:00:00:00:5b:00:09:40:20:01:0d:b8:ff:ff:ff:00;
}
```
You can modify this file to suit your specific DHCPv6 configuration requirements.


### eth1-ipv6-conf.sh
The eth1-ipv6-conf.sh script is responsible for configuring the network settings. By default, it adds the IPv6 address 2001:db8:ffff:1::10/64 to the eth1 interface and sets up an IPv6 route for the 2001:db8::/32 network:
```shell
# Apply network configuration
ip addr add 2001:db8:ffff:1::10/64 dev eth1
ip -6 route add 2001:db8::/32 via 2001:db8:ffff:1::1
```
You can edit this script to customize the network settings as needed.

These files can be mounted into the DHCPD6 server container using the topo.yml file provided in this repository as an example.

Feel free to modify and adapt these files according to your specific requirements.
