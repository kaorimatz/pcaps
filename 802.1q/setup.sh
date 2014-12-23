#!/bin/bash

ip netns add ns1
ip netns add ns2
ip link add name veth1 type veth peer name veth2
ip link set dev veth1 netns ns1
ip link set dev veth2 netns ns2
ip netns exec ns1 ip link add name veth1.100 link veth1 type vlan id 100
ip netns exec ns2 ip link add name veth2.100 link veth2 type vlan id 100
ip netns exec ns1 ip address add 192.168.100.1/30 dev veth1.100
ip netns exec ns2 ip address add 192.168.100.2/30 dev veth2.100
ip netns exec ns1 ip link set dev veth1 up
ip netns exec ns2 ip link set dev veth2 up
ip netns exec ns1 ip link set dev veth1.100 up
ip netns exec ns2 ip link set dev veth2.100 up
