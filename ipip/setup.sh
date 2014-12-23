#!/bin/bash

ip netns add ns1
ip netns add ns2
ip link add name veth1 type veth peer name veth2
ip link set dev veth1 netns ns1
ip link set dev veth2 netns ns2
ip netns exec ns1 ip link set dev veth1 up
ip netns exec ns2 ip link set dev veth2 up
ip netns exec ns1 ip address add 192.168.1.1/30 dev veth1
ip netns exec ns2 ip address add 192.168.1.2/30 dev veth2
ip netns exec ns1 ip link add tunl1 type ipip local 192.168.1.1 remote 192.168.1.2
ip netns exec ns2 ip link add tunl2 type ipip local 192.168.1.2 remote 192.168.1.1
ip netns exec ns1 ip link set dev tunl1 up
ip netns exec ns2 ip link set dev tunl2 up
ip netns exec ns1 ip address add 172.16.1.1/24 dev lo
ip netns exec ns2 ip address add 172.16.2.1/24 dev lo
ip netns exec ns1 ip route add 172.16.2.0/24 dev tunl1
ip netns exec ns2 ip route add 172.16.1.0/24 dev tunl2
