#!/bin/bash

ip netns exec ns2 tcpdump -i veth2 -c 4 -w 802.1q__ping__veth2.pcap &
ip netns exec ns2 tcpdump -i veth2.100 -c 4 -w 802.1q__ping__veth2.100.pcap &

# Waiting for tcpdump to be ready...
sleep 1

ip netns exec ns1 ping -I veth1.100 -c 1 192.168.100.2
