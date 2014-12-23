#!/bin/bash

ip netns exec ns1 ip link delete dev veth10
ip netns exec ns1 ip link delete dev veth11
ip netns exec ns1 ip link delete dev bond1
ip netns exec ns2 ip link delete dev bond2
ip netns delete ns1
ip netns delete ns2

modprobe -r bonding
