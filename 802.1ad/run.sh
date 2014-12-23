#!/bin/bash

ip netns exec ns2 tcpdump -i veth2 -c 4 -w 802.1ad__ping__veth2.pcap &
ip netns exec ns2 tcpdump -i veth2.100 -c 4 -w 802.1ad__ping__veth2.100.pcap &
ip netns exec ns2 tcpdump -i veth2.100.200 -c 4 -w 802.1ad__ping__veth2.100.200.pcap &

# Waiting for tcpdump to be ready...
sleep 1

ip netns exec ns1 ping -I veth1.100.200 -c 1 192.168.200.2
