#!/bin/bash

tcpdump -i veth21 -c 6 -w mpls__ping__veth21.pcap &

# Waiting for tcpdump to be ready...
sleep 1

ip netns exec ns1 ping -I host1 -c 1 192.168.1.2
