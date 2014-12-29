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
ip netns exec ns1 ip link add name vxlan1 type vxlan id 1 dev veth1 dstport 4789 group 239.1.1.1
ip netns exec ns2 ip link add name vxlan2 type vxlan id 1 dev veth2 dstport 4789 group 239.1.1.1
ip netns exec ns1 ip link add name veth10 type veth peer name veth11
ip netns exec ns2 ip link add name veth20 type veth peer name veth21
ip netns exec ns1 ip link set dev veth10 up
ip netns exec ns1 ip link set dev veth11 up
ip netns exec ns2 ip link set dev veth20 up
ip netns exec ns2 ip link set dev veth21 up
ip netns exec ns1 ip link add name bridge1 type bridge
ip netns exec ns2 ip link add name bridge2 type bridge
ip netns exec ns1 ip link set dev bridge1 up
ip netns exec ns2 ip link set dev bridge2 up
ip netns exec ns1 ip link set vxlan1 master bridge1
ip netns exec ns2 ip link set vxlan2 master bridge2
ip netns exec ns1 ip link set veth10 master bridge1
ip netns exec ns2 ip link set veth20 master bridge2
ip netns exec ns1 ip address add 172.16.1.1/24 dev veth11
ip netns exec ns2 ip address add 172.16.1.2/24 dev veth21
