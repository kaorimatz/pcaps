#!/bin/bash

ip netns exec ns2 tcpdump -i veth2 -c 7 -w esp-tunnel-policy__ping__veth2.pcap &

# Waiting for tcpdump to be ready...
sleep 1

ip netns exec ns1 ping -I 172.16.1.1 -c 1 172.16.2.1
