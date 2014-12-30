#!/bin/bash

ip netns exec ns2 tcpdump -i veth2 -c 6 -w ah-transport__ping__veth2.pcap &

# Waiting for tcpdump to be ready...
sleep 1

ip netns exec ns1 ping -I veth1 -c 1 192.168.1.2
