#!/bin/bash

ip netns exec ns2 tcpdump -i veth2 -c 6 -w esp-tunnel-route__ping__veth2.pcap &
ip netns exec ns2 tcpdump -i vti2 -c 2 -w esp-tunnel-route__ping__vti2.pcap &

# Waiting for tcpdump to be ready...
sleep 1

ip netns exec ns1 ping -I 172.16.1.1 -c 1 172.16.2.1
