#!/bin/bash

ip netns exec ns2 tcpdump -i gretap2 -c 6 -w gre-ethernet__ping__gretap2.pcap &
ip netns exec ns2 tcpdump -i veth2 -c 10 -w gre-ethernet__ping__veth2.pcap &

# Waiting for tcpdump to be ready...
sleep 1

ip netns exec ns1 ping -I veth11 -c 1 172.16.1.2
