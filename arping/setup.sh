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
