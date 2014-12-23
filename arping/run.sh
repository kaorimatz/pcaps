#!/bin/bash

ip netns exec ns2 tcpdump -i veth2 -c 2 -w arping__veth2.pcap &

# Waiting for tcpdump to be ready...
sleep 1

ip netns exec ns1 arping -I veth1 -c 1 192.168.1.2


ip netns exec ns2 tcpdump -i veth2 -c 1 -w arping-U__veth2.pcap &

# Waiting for tcpdump to be ready...
sleep 1

ip netns exec ns1 arping -U -I veth1 -c 1 192.168.1.1


ip netns exec ns2 tcpdump -i veth2 -c 1 -w arping-A__veth2.pcap &

# Waiting for tcpdump to be ready...
sleep 1

ip netns exec ns1 arping -A -I veth1 -c 1 192.168.1.1
