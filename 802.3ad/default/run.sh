#!/bin/bash

ip netns exec ns1 tcpdump -i veth10 -c 10 -w 802.3ad__veth10.pcap &
ip netns exec ns1 tcpdump -i veth11 -c 8 -w 802.3ad__veth11.pcap &

# Waiting for tcpdump to be ready...
sleep 1

ip netns exec ns1 ip link set dev bond1 up

sleep 5

ip netns exec ns2 ip link set dev bond2 up

sleep 5

sudo ip netns exec ns2 ip link set dev veth21 down

sleep 30

sudo ip netns exec ns2 ip link set dev veth21 up
