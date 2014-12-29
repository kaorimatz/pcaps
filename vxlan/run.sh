#!/bin/bash

ip netns exec ns2 tcpdump -i veth2 -c 14 -w vxlan__ping__veth2.pcap &

# Waiting for tcpdump to be ready...
sleep 1

ip netns exec ns1 ip link set dev vxlan1 up

sleep 1

ip netns exec ns2 ip link set dev vxlan2 up

sleep 1

ip netns exec ns2 tcpdump -i vxlan2 -c 6 -w vxlan__ping__vxlan2.pcap &

# Waiting for tcpdump to be ready...
sleep 1

ip netns exec ns1 ping -I veth11 -c 1 172.16.1.2
