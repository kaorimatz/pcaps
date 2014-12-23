#!/bin/bash

ip netns add ns1
ip netns add ns2
ip link add name veth10 type veth peer name veth20
ip link add name veth11 type veth peer name veth21
ip link set dev veth10 netns ns1
ip link set dev veth11 netns ns1
ip link set dev veth20 netns ns2
ip link set dev veth21 netns ns2
ip netns exec ns1 ip link add name bond1 type bond
ip netns exec ns2 ip link add name bond2 type bond
ip netns exec ns1 sh -c 'echo 802.3ad > /sys/class/net/bond1/bonding/mode'
ip netns exec ns2 sh -c 'echo 802.3ad > /sys/class/net/bond2/bonding/mode'
ip netns exec ns1 ip link set dev veth10 master bond1
ip netns exec ns1 ip link set dev veth11 master bond1
ip netns exec ns2 ip link set dev veth20 master bond2
ip netns exec ns2 ip link set dev veth21 master bond2
